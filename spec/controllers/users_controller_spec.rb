require 'spec_helper'

describe UsersController do
  describe "GET #show" do
    it "renders sign in template if not signed in"
    it "renders :show template if signed in"
  end

  describe "GET #new" do
    it "assigns a new user to @user"
    it "renders :new template"
  end

  describe "POST #create" do
    context "valid attributes" do
      it "adds a new user"
      it "signes in the new user"
      it "renders :show template"
    end

    context "invalid attributes" do
      it "does not add a new user"
      it "renders :new template"
    end
  end
end