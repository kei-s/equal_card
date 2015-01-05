require 'spec_helper'
require 'equal_card/cards'

describe EqualCard::Cards do
  let(:equal) { EqualCard::Cards.new(c) }

  describe 'new' do
    subject { equal }
    let(:c) { |example| example.example_group.description }
    context '0123456789+-*/' do
      it { expect { subject }.not_to raise_error }
    end
    context '?' do
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#answers' do
    subject { equal.answers.to_a.uniq }
    let(:c) { |example| example.example_group.description }
    context '11' do
      it { expect(subject).to eq [] }
    end
    context '111' do
      it { expect(subject).to eq ['1=1'] }
    end
    context '01019' do
      it { expect(subject).to eq ['10=10'] }
    end
    context '/1111' do
      it do
        expect(subject).to match_array ['11=11', '1=1=1', '1/1=1', '1=1/1']
      end
    end
    context '21111' do
      it do
        expect(subject).to match_array ['11=11', '1=1=1']
      end
    end
    context '21111' do
      it do
        expect(subject).to match_array ['11=11', '1=1=1']
      end
    end
    context '11129+*' do
      it do
        expect(subject).to match_array [
          '1+1*1=2', '1+1=1*2', '1+1=2*1',
          '1*1+1=2', '1*2=1+1',
          '2*1=1+1', '2=1+1*1', '2=1*1+1'
        ]
      end
    end
  end
end
