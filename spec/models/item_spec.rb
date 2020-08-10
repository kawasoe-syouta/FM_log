require 'rails_helper'

describe Item do
  describe '#create' do
    #valid
    context 'can save' do
      it "is valid" do
        item1 = build(:item)
        item1.valid?
        expect(item1).to be_valid
      end

      it "is valid to phase reference" do
        4.times do |count|
          items[count] = build(:item, phase_id: (count + 1))
          items[count].valid?
          expect(items[count]).to be_valid
        end
      end
    end

    #invalid
    context 'can not save' do
      it "is invalid with null check to name" do
        item1 = build(:item, name: nil)
        item1.valid?
        expect(item1.errors[:name]).to include('can\'t be blank')
      end
    end
  end
end