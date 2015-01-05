require 'spec_helper'

describe Equal::Solver do
  let(:solver) { Equal::Solver.new(p) }
  let(:p) { |example| example.example_group.description }

  describe '#solve' do
    subject { solver.solve }
    context '11' do
      it { expect(subject).to match_array [] }
    end
    context '111' do
      it { expect(subject).to match_array ['1=1'] }
    end
    context '112' do
      it { expect(subject).to match_array [] }
    end
    context '1+12' do
      it { expect(subject).to match_array [] }
    end
    context '1+112' do
      it { expect(subject).to match_array ['1+1=2'] }
    end
    context '1*111' do
      it { expect(subject).to match_array ['1*1=1', '1=1=1'] }
    end
    context '1/1*1' do
      it { expect(subject).to match_array ['1/1=1', '1=1*1', '1=1=1'] }
    end
  end

  describe '#equal_patterns' do
    subject { solver.equal_patterns }
    context '11' do
      it { expect(subject).to match_array [] }
    end
    context '111' do
      it { expect(subject).to match_array ['1=1'] }
    end
    context '112' do
      it { expect(subject).to match_array ['1=2'] }
    end
    context '1+12' do
      it { expect(subject).to match_array ['1=12'] }
    end
    context '1+112' do
      it { expect(subject).to match_array ['1=112', '1+1=2', '1=1=2'] }
    end
    context '1111111' do
      it do
        expect(subject).to match_array [
          '11111=1', '1111=11', '111=111', '11=1111', '1=11111',
          '111=1=1', '11=11=1', '1=111=1', '11=1=11', '1=11=11', '1=1=111',
          '1=1=1=1'
        ]
      end
    end
    context '1234567' do
      it do
        expect(subject).to match_array [
          '12345=7', '1234=67', '123=567', '12=4567', '1=34567',
          '123=5=7', '12=45=7', '1=345=7', '12=4=67', '1=34=67', '1=3=567',
          '1=3=5=7'
        ]
      end
    end
    context '12345+6' do
      it do
        expect(subject).to match_array [
          '12345=6', '123=5+6', '12=45+6', '1=345+6',
          '123=5=6', '12=45=6', '1=345=6', '1=3=5+6',
          '1=3=5=6'
        ]
      end
    end
  end

  describe '#equalable_positions' do
    subject { solver.equalable_positions }
    context '11' do
      it { expect(subject).to match_array [] }
    end
    context '111' do
      it { expect(subject).to match_array [1] }
    end
    context '112' do
      it { expect(subject).to match_array [1] }
    end
    context '1+12' do
      it { expect(subject).to match_array [1] }
    end
    context '1+112' do
      it { expect(subject).to match_array [1, 3] }
    end
    context '1111111' do
      it { expect(subject).to match_array [1, 2, 3, 4, 5] }
    end
    context '1234567' do
      it { expect(subject).to match_array [1, 2, 3, 4, 5] }
    end
    context '12345+6' do
      it { expect(subject).to match_array [1, 2, 3, 5] }
    end
  end
end
