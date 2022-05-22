# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Law.create(sr_number: '101', title: 'Bundesverfassung der Schweizerischen Eidgenossenschaft', title_alternative: '',
           language: 'de')
Law.create(sr_number: '101', title: 'Constitution fédérale de la Confédération suisse', title_alternative: '',
           language: 'fr')
Law.create(sr_number: '101', title: 'Costituzione federale della Confederazione Svizzera', title_alternative: '',
           language: 'it')

Law.create(sr_number: '120', title: 'Bundesgesetz über Massnahmen zur Wahrung der inneren Sicherheit',
           title_alternative: '', language: 'de')
Law.create(sr_number: '120', title: 'Loi fédérale instituant des mesures visant au maintien de la sûreté intérieure',
           title_alternative: '', language: 'fr')
Law.create(sr_number: '120', title: 'Legge federale sulle misure per la salvaguardia della sicurezza interna',
           title_alternative: '', language: 'it')
