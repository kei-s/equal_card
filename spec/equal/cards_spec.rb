require 'spec_helper'

describe Equal::Cards do
  let(:equal) { Equal::Cards.new(c) }

  describe 'new' do
    subject { equal }
    let(:c) {|example| example.example_group.description }
    context '0123456789+-*/' do
      it { expect{ subject }.not_to raise_error }
    end
    context '?' do
      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#answers' do
    subject { equal.answers.to_a }
    let(:c) {|example| example.example_group.description }
    context '11' do
      it { expect(subject).to eq [] }
    end
    context '111' do
      it { expect(subject).to eq ['1=1'] }
    end
  end
end
