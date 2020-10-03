require 'spec_helper'

RSpec.describe AlgebraDB::SyntaxBuilder do
  its(:syntax) { should be_empty }
  its(:params) { should be_empty & be_a(Array) }

  describe '#param' do
    subject { described_class.new.tap { |t| t.param(10) } }
    its(:syntax) { should eq '$1 ' }
    its(:params) { should eq([10]) }
  end

  describe '#separate' do
    subject do
      described_class.new.tap do |s|
        s.separate([1, 2, 3]) do |e, b|
          b.param(e)
        end
      end
    end

    its(:syntax) { should eq '$1, $2, $3 ' }
    its(:params) { should eq([1, 2, 3]) }
  end

  describe '#parenthesize' do
    subject do
      described_class.new.tap do |s|
        s.parenthesize do |b|
          b.text('foo')
        end
      end
    end

    its(:syntax) { should eq '(foo) ' }
  end
end
