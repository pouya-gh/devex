require 'spec_helper'

describe UsersController do
  describe "GET #show" do
    context "not signed in" do
      it "renders sign in template"
    end
    
    context "signed in" do
      it "renders :show template if signed in"
      it "assigns user to @user"
    end
  end

  describe "GET #new" do
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders :new template" do
      get :new
      expect(response).to render_template :new
    end
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