# frozen_string_literal: true

class CreateRevisions < ActiveRecord::Migration[7.0]
  def change
    create_table :revisions do |t|
      t.string :date_document
      t.string :date_applicability, null: false
      t.string :language_tag, null: false
      t.string :file_uri, unique: true, null: false
      t.text :legislative_text, null: false
      t.belongs_to :law

      t.timestamps
    end
  end
end
