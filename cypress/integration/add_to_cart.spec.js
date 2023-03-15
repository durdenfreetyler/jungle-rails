/// <reference types="cypress" />

describe("jungle", () => {
  beforeEach(() => {
    cy.visit("/");
  });
  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
  it(".click() - click on a DOM element", () => {
    // https://on.cypress.io/click
    cy.contains("My Cart (0)");
    cy.get("article .btn").first().click({ force: true });
    cy.contains("My Cart (1)");
  });
});
