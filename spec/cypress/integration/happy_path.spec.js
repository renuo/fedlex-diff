describe('happy path', () => {
    before(() => {
        cy.appFactories([['create', 'law', { sr_number: '123', title: 'example'}]]).then((records) => {
            cy.appFactories([['create', 'revision', { legislative_text: 'Hello World!', law_id: records[0].id }]])
            cy.appFactories([['create', 'revision', { legislative_text: 'hello World!!', law_id: records[0].id }]])
        })
    })

    it('visit root', () => {
        cy.visit('/')
    })

    it('can enter a sr number', function () {
        cy.visit('/')
        cy.get('#search-field').type('123')
    });

    it('can select two checkboxes and compare them',  () => {
        cy.visit('/document_page?sr_number=123&language_tag=de')
        cy.get('.revisionCheckbox').first().click()
        cy.get('.revisionCheckbox').eq(1).click()
        cy.get('input').contains('Compare').click()
        cy.get('.scroll').children('#unifield').children('.diff').children('ul').children('.del')
        cy.get('.scroll').children('#unifield').children('.diff').children('ul').children('.ins')
    });

})
