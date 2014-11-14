require "rails_helper"

describe GuestbookEntry do
  describe "associations" do
    it "destroys associated likes when an entry is destroyed" do
      entry = GuestbookEntry.create!(body: "hi")
      entry.likes.create!
      expect { entry.destroy }.to change(Like, :count).from(1).to(0)
    end
  end

  describe "validations" do
    it "is invalid when the body contains 'silly'" do
      entry = GuestbookEntry.new(body: "This site is silly!")

      expect(entry).not_to be_valid
      expect(entry.errors[:body].size).to eq(1)
      expect(entry.errors[:body]).to include("contains a bad word")
    end

    it "is invalid when the body is blank" do
      entry = GuestbookEntry.new(body: "")

      expect(entry).not_to be_valid
      expect(entry.errors[:body].size).to eq(1)
      expect(entry.errors[:body]).to include("can't be blank")
    end

    it "is invalid when the body contains more than 255 characters" do
      entry = GuestbookEntry.new(body: "x" * 256)

      expect(entry).not_to be_valid
      expect(entry.errors[:body].size).to eq(1)
      expect(entry.errors[:body]).
        to include("is too long (maximum is 255 characters)")
    end
  end

  describe ".limited" do
    it "returns five entries maximum" do
      (1..6).each { |n| GuestbookEntry.create!(body: "Entry #{n}") }

      expect(GuestbookEntry.limited.count).to eq(5)
    end
  end

  describe ".most_recent_first" do
    it "orders the entries by created_at, descending" do
      GuestbookEntry.create!(body: "middle", created_at: 3.days.ago)
      GuestbookEntry.create!(body: "newest", created_at: 2.days.ago)
      GuestbookEntry.create!(body: "oldest", created_at: 5.days.ago)

      ordered_entries = GuestbookEntry.most_recent_first.pluck(:body)
      expect(ordered_entries).to eq(%w(newest middle oldest))
    end
  end

  describe ".recent" do
    it "includes entries created within the last 30 days" do
      entry = GuestbookEntry.create!(body: "Hi", created_at: 14.days.ago)
      expect(GuestbookEntry.recent).to include(entry)
    end

    it "excludes entries created more than 30 days ago" do
      entry = GuestbookEntry.create!(body: "Hi", created_at: 31.days.ago)
      expect(GuestbookEntry.recent).not_to include(entry)
    end
  end
end
