require 'spec_helper'

describe Post do
  it "has a valid factory" do
    post = build(:post)
    expect(post).to be_valid
  end

  it "is invalid without Title" do
    post = build(:post, title: nil)
    expect(post).not_to be_valid
  end

  it "is invalid without Digest" do
    post = build(:post, digest: nil)
    expect(post).not_to be_valid
  end

  it "is invalid without Body" do
    post = build(:post, body: nil)
    expect(post).not_to be_valid
  end

  it "is invalid without an owner" do
    post = build(:post, admin: nil)
    expect(post).not_to be_valid
  end

  it "is invalid with duplicate titles" do
    create(:post, title: "aTitle")
    post = build(:post, title: "aTitle")
    expect(post).not_to be_valid
  end

  describe "Tags" do
    it "is valid without tags" do
      post = build(:post, tags: nil)
      expect(post).to be_valid
    end

    it "is valid with 5 tags" do
      post = build(:post, 
                   tags: ["Ruby", "Rails", "Web", "Rspec", "testing"])
      expect(post).to be_valid
    end

    it "is invalid with more than 5 tags" do
      post = build(:post, 
                   tags: ["Ruby", "Rails", "Web", "Rspec", "testing", "extra"])
      expect(post).not_to be_valid
    end
  end

  describe "#subscribtion_needed?" do
    it "returns value of pro" do
      post = build(:post)
      expect(post.subscribtion_needed?).to eq post.pro
    end
  end

  describe "pro" do
    it "is set to false by default" do
      post = build(:post)
      expect(post.pro).to be_false
    end
  end

  describe "published" do
    it "is set to false by default" do
      post = build(:post)
      expect(post.published).to be_false
    end
  end

  describe "has_tag" do
    it "returns posts containtin a given tag" do
      post = create(:post, tags: ["ruby", "rails"])
      expect(Post.has_tag("ruby")).to eq [post]
    end
  end
end
