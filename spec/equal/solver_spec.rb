require 'spec_helper'

describe Equal::Solver do
  let(:solver) { Equal::Solver.new(p) }
  let(:p) {|example| example.example_group.description.split('') }

  describe '#solve' do
    subject { solver.solve }
    context '11' do
      it { expect(subject).to eq [] }
    end
    context '111' do
      it { expect(subject).to eq ['1','=','1'] }
    end
    context '112' do
      it { expect(subject).to eq [] }
    end
    context '1+11' do
      it { expect(subject).to eq [] }
    end
  end
end
