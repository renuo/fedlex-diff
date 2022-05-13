# frozen_string_literal: true

require 'open-uri'

class LawRevisionsCreator
  include ActionView::Helpers::SanitizeHelper

  SR_NUMBER = '818.102'

  def initialize(rdf_query_solution)
    @rdf_query_solution = rdf_query_solution
  end

  def find_or_create_law
    title = strip_tags(sanitize(@rdf_query_solution[:title].to_s))
    @law = if Law.exists?(title: title)
             Law.find_by(title: title)
           else
             Law.create(sr_number: SR_NUMBER, title: title,
                        title_alternative: @rdf_query_solution[:titleAlternative].to_s,
                        language: @rdf_query_solution[:languageTag].to_s)
           end
  end

  def create_revision
    return if Revision.exists?(file_uri: @rdf_query_solution[:fileUri].to_s)

    legislative_text = extract_legislative_text(@rdf_query_solution[:fileUri].to_s)
    Revision.create(date_document: @rdf_query_solution[:dateDocument].to_s,
                    date_applicability: @rdf_query_solution[:dateApplicability].to_s,
                    file_uri: @rdf_query_solution[:fileUri].to_s,
                    language_tag: @rdf_query_solution[:languageTag].to_s,
                    legislative_text: legislative_text,
                    law_id: @law.id)
  end

  private

  def extract_legislative_text(uri)
    opened_uri = URI.open(uri)
    html = opened_uri.read
    strip_tags(sanitize(html))
  end
end
