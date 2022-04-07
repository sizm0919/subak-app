require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "creating a Company" do
    visit companies_url
    click_on "New Company"

    fill_in "Account", with: @company.account_id
    fill_in "Address", with: @company.address
    fill_in "Co number", with: @company.co_number
    fill_in "Co registration date", with: @company.co_registration_date
    fill_in "Farmer", with: @company.farmer
    fill_in "Homemeal", with: @company.homemeal
    fill_in "Name", with: @company.name
    fill_in "Postal code", with: @company.postal_code
    fill_in "Representative name", with: @company.representative_name
    fill_in "Restaurant", with: @company.restaurant
    fill_in "Retail", with: @company.retail
    fill_in "Wholesale", with: @company.wholesale
    click_on "Create Company"

    assert_text "Company was successfully created"
    click_on "Back"
  end

  test "updating a Company" do
    visit companies_url
    click_on "Edit", match: :first

    fill_in "Account", with: @company.account_id
    fill_in "Address", with: @company.address
    fill_in "Co number", with: @company.co_number
    fill_in "Co registration date", with: @company.co_registration_date
    fill_in "Farmer", with: @company.farmer
    fill_in "Homemeal", with: @company.homemeal
    fill_in "Name", with: @company.name
    fill_in "Postal code", with: @company.postal_code
    fill_in "Representative name", with: @company.representative_name
    fill_in "Restaurant", with: @company.restaurant
    fill_in "Retail", with: @company.retail
    fill_in "Wholesale", with: @company.wholesale
    click_on "Update Company"

    assert_text "Company was successfully updated"
    click_on "Back"
  end

  test "destroying a Company" do
    visit companies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Company was successfully destroyed"
  end
end
