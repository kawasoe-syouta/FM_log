require 'rails_helper'

describe Item do
  describe '#create' do
    #valid
    context 'can save' do
      let(:item_valid) {build(:item)}

      let(:items_phase1) {build(:item, phase_id: 1)}
      let(:items_phase2) {build(:item, phase_id: 2)}
      let(:items_phase3) {build(:item, phase_id: 3)}
      let(:items_phase4) {build(:item, phase_id: 4)}

      let(:items_status1) {build(:item, status_id: 1)}
      let(:items_status2) {build(:item, status_id: 2)}
      let(:items_status3) {build(:item, status_id: 3)}
      let(:items_status4) {build(:item, status_id: 4)}
      let(:items_status5) {build(:item, status_id: 5)}
      let(:items_status6) {build(:item, status_id: 6)}

      let(:items_delivery_to_pay1) {build(:item, delivery_to_pay_id: 1)}
      let(:items_delivery_to_pay2) {build(:item, delivery_to_pay_id: 2)}

      it "is valid" do
        # item1 = build(:item)
        item_valid.valid?
        expect(item_valid).to be_valid
      end

      it "is valid to phase reference" do
        expect(items_phase1.phase.phase).to eq '出品中'
        expect(items_phase2.phase.phase).to eq '支払い待ち'
        expect(items_phase3.phase.phase).to eq '発送待ち'
        expect(items_phase4.phase.phase).to eq '取引完了'
      end

      it "is valid to status reference" do
        expect(items_status1.status.status).to eq '新品、未使用'
        expect(items_status2.status.status).to eq '未使用に近い'
        expect(items_status3.status.status).to eq '目立った傷や汚れなし'
        expect(items_status4.status.status).to eq 'やや傷や汚れあり'
        expect(items_status5.status.status).to eq '傷や汚れあり'
        expect(items_status6.status.status).to eq '全体的に状態が悪い'
      end

      it "is valid to status reference" do
        expect(items_delivery_to_pay1.delivery_to_pay.to_pay).to eq '送料込み(出品者負担)'
        expect(items_delivery_to_pay2.delivery_to_pay.to_pay).to eq '着払い(購入者負担)'
      end

    end

    #invalid
    context 'can not save' do
      let(:item_name_blank) {build(:item, name: nil)}
      let(:item_name_space) {build(:item, name: "")}
      let(:item_price_blank) {build(:item, price: nil)}
      let(:item_price_space) {build(:item, price: "")}
      let(:item_delivery_days_blank) {build(:item, delivery_days: nil)}
      let(:item_delivery_days_space) {build(:item, delivery_days: "")}

      it "is invalid with null check to name" do
        item_name_blank.valid?
        expect(item_name_blank.errors[:name]).to include('can\'t be blank')
      end

      it "is invalid with space check to name" do
        item_name_space.valid?
        expect(item_name_space.errors[:name]).to include('can\'t be blank')
      end

      it "is invalid with null check to price" do
        item_price_blank.valid?
        expect(item_price_blank.errors[:price]).to include('can\'t be blank')
      end

      it "is invalid with space check to price" do
        item_price_space.valid?
        expect(item_price_space.errors[:price]).to include('can\'t be blank')
      end

      it "is invalid with null check to delivery_days" do
        item_delivery_days_blank.valid?
        expect(item_delivery_days_blank.errors[:delivery_days]).to include('can\'t be blank')
      end

      it "is invalid with space check to delivery_days" do
        item_delivery_days_space.valid?
        expect(item_delivery_days_space.errors[:delivery_days]).to include('can\'t be blank')
      end

    end
  end
end