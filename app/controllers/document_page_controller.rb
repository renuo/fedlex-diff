# frozen_string_literal: true

class DocumentPageController < ApplicationController
  def index
    @law = Law.find_by(sr_number: params[:sr_number], language: params[:language_tag])
    @revisions = Revision.where(law_id: @law.id).order('date_applicability')

    if params[:revision].present?
      selected_revisions = grab_selected_revisions
      @selected_revision1 = grab_revision(selected_revisions[0]) if selected_revisions[0].present?
      @selected_revision2 = grab_revision(selected_revisions[1]) if selected_revisions[1].present?
    end
  end

  private

  def grab_selected_revisions
    selected_revisions = []
    params[:revision].each do |rev|
      selected_revisions.append(rev) if rev != '0'
    end
    selected_revisions
  end

  def grab_revision(date_applicability)
    @revisions.find_by(date_applicability: date_applicability)
  end

end
