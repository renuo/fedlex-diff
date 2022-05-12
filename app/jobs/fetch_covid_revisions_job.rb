# frozen_string_literal: true

require 'open-uri'

class FetchCovidRevisionsJob < ApplicationJob
  include ActionView::Helpers::SanitizeHelper

  queue_as :default

  COVID_QUERY = ' PREFIX jolux: <http://data.legilux.public.lu/resource/ontology/jolux#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
select distinct ?title ?titleShort ?titleAlternative (str(?dateDocumentNode) as ?dateDocument)
(str(?languageNotation) as ?languageTag) (str(?dateApplicabilityNode) as ?dateApplicability) ?fileUri {
  values (?srString) {("818.102")}

  ?consoAbstract a jolux:ConsolidationAbstract .
  ?consoAbstract jolux:classifiedByTaxonomyEntry/skos:notation ?rsNotation .
  filter(str(?rsNotation) = ?srString)
  ?consoAbstract jolux:dateDocument ?dateDocumentNode .
  ?consoAbstract jolux:isRealizedBy ?consoAbstractExpression .
  ?consoAbstractExpression jolux:language ?languageConcept .
  ?consoAbstractExpression jolux:title ?title .
  optional {?consoAbstractExpression jolux:titleShort ?titleShort . }
  optional {?consoAbstractExpression jolux:titleAlternative ?titleAlternative . }

      ?conso a jolux:Consolidation .
  ?conso jolux:isMemberOf ?consoAbstract .
  ?conso jolux:dateApplicability ?dateApplicabilityNode .

  ?conso jolux:isRealizedBy ?consoExpression .
  ?consoExpression jolux:isEmbodiedBy ?manifestation .
  ?consoExpression jolux:language ?languageConcept .

  ?manifestation jolux:isExemplifiedBy ?fileUri .
  ?manifestation jolux:userFormat <https://fedlex.data.admin.ch/vocabulary/user-format/html> .

  ?languageConcept skos:notation ?languageNotation .
  filter(datatype(?languageNotation) = <http://publications.europa.eu/ontology/euvoc#XML_LNG>)

}
order by ?languageTag ?dateDocument'

  FEDLEX_ENDPOINT = 'https://fedlex.data.admin.ch/sparqlendpoint'

  SR_NUMBER = '818.102'

  def perform(_args)
    data = retrieve_covid_data

    data.each_solution do |solution|
      title = strip_tags(sanitize(solution[:title].to_s))
      law = if Law.exists?(title: title)
              Law.find_by(title: title)
            else
              Law.create(sr_number: SR_NUMBER, title: title,
                         title_alternative: solution[:titleAlternative].to_s,
                         language: solution[:languageTag].to_s)
            end

      next if Revision.exists?(file_uri: solution[:fileUri].to_s)

      text = extract_covid_legislative_text(solution[:fileUri].to_s)
      Revision.create(date_document: solution[:dateDocument].to_s,
                      date_applicability: solution[:dateApplicability].to_s,
                      file_uri: solution[:fileUri].to_s,
                      language_tag: solution[:languageTag].to_s,
                      legislative_text: text,
                      law_id: law.id)
    end
  end

  def retrieve_covid_data
    sparql_client = SPARQL::Client.new(FEDLEX_ENDPOINT)
    sparql_client.query(COVID_QUERY)
  end

  def extract_covid_legislative_text(uri)
    opened_uri = URI.open(uri)
    html = opened_uri.read
    strip_tags(sanitize(html))
  end
end
