require 'spec_helper'

describe UsersController do
  describe "GET #show" do
    context "not signed in" do
      it "renders sign in template" do
        expected_url = sign_in_url(redirect_url: request.original_url)
        get :show, id: 1
        expect(response).to redirect_to(expected_url)
      end
    end
    
    context "signed in" do
      before :each do
        @user = create(:user)
        cookies[:auth_token] = @user.auth_token
        get :show, id: @user
      end

      it "renders :show template if signed in" do
        expect(response).to render_template :show
      end

      it "assigns user to @user" do
        expect(assigns(:user)).to eq @user  
      end
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
      it "adds a new user" do
        expect {
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by 1
      end

      it "signs in the new user" do
        post :create, user: attributes_for(:user)
        user = assigns(:user)
        expect(cookies[:auth_token]).to eq(user.auth_token)
      end

      it "redirects to show" do
        post :create, user: attributes_for(:user)
        user = assigns(:user)
        expect(response).to redirect_to(user_url(user))
      end
    end

    context "invalid attributes" do
      it "does not add a new user" do
        expect {
          post :create, user: attributes_for(:user, email: nil)
        }.not_to change(User, :count)
      end

      it "renders new template" do
        post :create, user: attributes_for(:user, email: nil)
        expect(response).to render_template(:new)
      end
    end
  end
end