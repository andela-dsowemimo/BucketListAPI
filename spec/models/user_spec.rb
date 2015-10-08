require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid" do
    expect(build :user).to be_valid
  end

  it "is invalid without an email" do
    expect(build :invalid_user).to have(2).errors_on(:email)
  end

  it "is invalid if password and password confirmation do not match" do
    expect(build :invalid_user).to have(1).errors_on(:password_confirmation)
  end

  it "is given authorization key before creation" do
    expect(create :new_user).to be_valid
  end

  context "set_auth" do
    before :each do
      @daisi = build(:user)
    end

    it "does not set auth token for user if present" do
      @daisi.set_auth_token
      expect(@daisi.auth_token).to eq("My212aut1wer2hdvs")
    end

    it "sets auth token for user if not present" do
      @daisi.auth_token = nil
      @daisi.set_auth_token
      expect(@daisi.auth_token).not_to eq(nil)
    end

  end
end
