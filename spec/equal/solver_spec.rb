require 'spec_helper'

describe Equal::Solver do
  let(:solver) { Equal::Solver.new(p) }

  describe '#solve' do
    subject { solver.solve }
    context '11' do
      let(:p) { '11'.split('') }
      it { expect(subject).to eq [] }
    end
    context '111' do
      let(:p) { '111'.split('') }
      it { expect(subject).to eq ['1','=','1'] }
    end
  end
end
