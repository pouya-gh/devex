require 'spec_helper'

describe Admin do
  it "has a valid factory" do
    expect(build(:admin)).to be_valid
  end

  it "is invalid without a first_name" do
    expect(build(:admin, 
                 first_name: nil)).
                 not_to be_valid
  end

  it "is invalid without a last_name" do
    expect(build(:admin, 
                 last_name: nil)).
                 not_to be_valid 
  end

  it "is invalid without an email" do
    expect(build(:admin, 
                 email: nil)).
                 not_to be_valid 
  end

  it "is invalid without a password" do
    expect(build(:admin, 
                 password: nil)).
                 not_to be_valid
  end

  it "is invalid with a duplicate email" do
    create(:admin, email: "pouya@test.com")
    pouya2 = build(:admin, email: "pouya@test.com")
    expect(pouya2).not_to be_valid 
  end

  it "is invalid with an email with a wrong format" do
    expect(build(:admin, 
                 email: "kdkfs@skd")).
                 not_to be_valid
  end

  describe "name validity" do 
    context "first_name lenght" do
      it "is valid at a size of 3" do
        expect(build(:admin, 
                     first_name: "pou")).to be_valid
      end

      it "is valid at a size of 30" do
        admin =build(:admin, 
                     first_name: "pouyapouyapouyapouyapouyapouya") 
        expect(admin).to be_valid
      end

      it "is invalid shorter than 3" do
        expect(build(:admin,
                     first_name: "po")).
                     not_to be_valid
      end

      it "is invalid longer than 30" do
        admin = build(:admin, first_name: "pouyapouyapouyapouyapouyapouyap") 
        expect(admin).not_to be_valid
      end
    end

    context "last_name lenght" do
      it "is valid at a size of 3" do
        expect(build(:admin,
                     last_name: "tes")).
                     to be_valid
      end

      it "is valid at a size of 30" do
        admin = build(:admin,
                last_name: "testtesttesttesttesttesttestte")
        expect(admin).to be_valid
      end

      it "is invalid shorter than 3" do
        admin = build(:admin,
                      last_name: "te")
        expect(admin).not_to be_valid
      end

      it "is invalid longer than 30" do
        admin = build(:admin,
                      last_name: "testtesttesttesttesttesttesttes")
        expect(admin).not_to be_valid
      end
    end
  end

  it "returns last 5 posts" do
    admin = create(:admin)
    post1 = create(:post, admin: admin)
    post2 = create(:post, admin: admin)
    post3 = create(:post, admin: admin)
    post4 = create(:post, admin: admin)
    post5 = create(:post, admin: admin)
    post6 = create(:post, admin: admin)
    expect(admin.last_posts()).to eq [post6, post5, post4, post3, post2]
  end

  it "returns true for #admin? method" do
    person = create(:admin)
    expect(person.admin?).to be_true
  end
end
