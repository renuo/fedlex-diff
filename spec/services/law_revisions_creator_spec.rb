# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LawRevisionsCreator do
  describe 'create law revision pair' do
    let(:rdf_query_solution) do
      RDF::Query::Solution.new({
                                 title: RDF::Literal.new('Bundesgesetz über Corona-Epidemie'),
                                 titleAlternative: RDF::Literal.new('Covid-19'),
                                 dateDocument: RDF::Literal.new('2020-01-01'),
                                 languageTag: RDF::Literal.new('de'),
                                 dateApplicability: RDF::Literal.new('2020-02-02'),
                                 fileUri: RDF::URI.new('https://fedlex.data.admin.ch/filestore/fedlex.data.admin.ch/eli/cc/2020/711/20211019/de/html/fedlex-data-admin-ch-eli-cc-2020-711-20211019-de-html-1.html')
                               })
    end
    let(:law_revision_creator) { described_class.new(rdf_query_solution) }

    before do
      laws = Law.all
      laws.each(&:destroy)
    end

    it 'creates a law' do
      expect { law_revision_creator.find_or_create_law }.to change(Law, :count).by(1)
    end

    it 'creates a revision' do
      VCR.use_cassette('create_covid_revisions/one_revision') do
        law_revision_creator.find_or_create_law
        expect { law_revision_creator.create_revision }.to change(Revision, :count).by(1)
      end
    end

    it 'does not create the same law twice' do
      law_revision_creator.find_or_create_law
      expect { law_revision_creator.find_or_create_law }.to change(Law, :count).by(0)
    end

    it 'does not create the same revision twice' do
      VCR.use_cassette('create_covid_revisions/no_multiple_revisions') do
        law_revision_creator.find_or_create_law
        law_revision_creator.create_revision
        expect { law_revision_creator.create_revision }.to change(Revision, :count).by(0)
      end
    end
  end
end
