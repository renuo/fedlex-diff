# frozen_string_literal: true

class DocumentPageController < ApplicationController
  def index
    @law = Law.find_by(sr_number: params[:sr_number], language: params[:language_tag])
    @revisions = Revision.where(law_id: @law.id).order('date_applicability')

    return if params[:revision].blank? || !selected_two_revisions?

    @selected_revisions = grab_selected_revisions
  end

  private

  def selected_two_revisions?
    revisions = pick_out_dates
    revisions.length >= 2
  end

  def grab_selected_revisions
    revision_dates = pick_out_dates
    revisions = []
    revision_dates.each { |rev_date| revisions.append(fetch_revision_text(rev_date)) }

    revisions
  end

  def pick_out_dates
    dates = []
    params[:revision].each do |rev|
      dates.append(rev) if rev != '0'
    end
    dates
  end

  def fetch_revision_text(date_applicability)
    revision = @revisions.find_by(date_applicability: date_applicability)
    revision.legislative_text
  end
end
