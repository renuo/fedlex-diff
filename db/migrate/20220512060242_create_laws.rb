# frozen_string_literal: true

class CreateLaws < ActiveRecord::Migration[7.0]
  def change
    create_table :laws do |t|
      t.string :sr_number, null: false
      t.string :title, null: false
      t.string :title_alternative
      t.string :language, null: false

      t.timestamps
    end
  end
end
