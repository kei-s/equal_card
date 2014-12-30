require 'spec_helper'

describe Equal do
  let(:equal) { Equal.new(c) }

  describe 'new' do
    subject { equal }
    context '0123456789+-*/' do
      let(:c) { '0123456789+-*/' }
      it { expect{ subject }.not_to raise_error }
    end

    context '?' do
      let(:c) { '?' }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#answers' do
    subject { equal.solved? }
    context '11' do
      let(:c) { '11' }
      it { expect(subject).to eq [] }
    end
    context '111' do
      let(:c) { '111' }
      it { expect(subject).to eq ['1=1'] }
    end
  end
end
