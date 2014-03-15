# encoding: utf-8

require 'spec_helper'

shared_context 'name' do
  context 'when nil' do
    it "is invalid" do
      expect(build(:user, arg.to_sym => nil)).to be_invalid
    end
  end

  context 'when too short' do
    it "is invalid" do
      expect(build(:user, arg.to_sym => 'aa')).to be_invalid
    end
  end

  context 'when too long' do
    it "is invalid" do
      expect(build(:user, arg.to_sym => 'a' * 31)).to be_invalid
    end
  end

  it "contains only permitted characters" do
    invalid_names = ['@ref', 'na$im', '*علی*']
    invalid_names.each do |invalud_name|
      expect(build(:user, first_name: invalud_name)).to be_invalid
    end
  end
end

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  describe "first_name" do
    include_context 'name' do 
      let(:arg) { :first_name }
    end
  end

  describe "last_name" do
    include_context 'name' do
      let(:arg) { :last_name }
    end
  end

  describe "email" do
    it "contains only permitted characters" do
      invalid_emails = ['arefaslani.com', '@arefaslani', 'arefaslani@gmail',
                        'عارف@gmail.com', 'aref\naslani@gmail.com']
      invalid_emails.each do |invalid_email|
        expect(build(:user, email: invalid_email)).to be_invalid
      end
    end
  end

  describe "password" do
    context 'when nil' do
      it "is invalid" do
        expect(build(:user, password: nil)).to be_invalid
      end
    end

    context "when doesn't match confirmation" do
      it "is invalid" do
        expect(build(:user, password: '12345678', password_confirmation: '12345679')).to be_invalid
      end
    end
  end
end