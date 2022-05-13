# frozen_string_literal: true

require 'open-uri'

class FetchCovidRevisionsJob < ApplicationJob
  queue_as :default

  COVID_QUERY = '
  PREFIX jolux: <http://data.legilux.public.lu/resource/ontology/jolux#>
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
  order by ?languageTag ?dateDocument
'

  FEDLEX_ENDPOINT = 'https://fedlex.data.admin.ch/sparqlendpoint'

  def perform
    data = retrieve_covid_data

    data.each do |solution|
      law_revision_creator = LawRevisionsCreator.new(solution)
      law_revision_creator.find_or_create_law
      law_revision_creator.create_revision
    end
  end

  def retrieve_covid_data
    sparql_client = SPARQL::Client.new(FEDLEX_ENDPOINT)
    sparql_client.query(COVID_QUERY)
  end
end
