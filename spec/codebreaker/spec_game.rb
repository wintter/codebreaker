require '../spec_helper'

module Codebreaker

  describe Game do

    context "#initialize" do

      it "should respond_to @code" do
        expect(subject).to respond_to(:code)
      end

      it "code should be valid" do
        expect(subject.code).to match /^[1-6]{4}/
      end

      it "should respond_to @attempt" do
        expect(subject).to respond_to(:attempt)
      end

      it "should respond_to @hint" do
        expect(subject).to respond_to(:hint)
      end

      it "attempt set to 5" do
        expect(subject.attempt).to eq(5)
      end

    end

    context "#get_hint" do

      before do
        subject.instance_variable_set(:@code, '1234')
      end

      it "should return a hint" do
        expect(subject.get_hint).to include('*')
      end

      it "hint has 4 items" do
        expect(subject.get_hint.size).to eq(4)
      end

      it "hint should be true" do
        expect(subject.hint).to eq(true)
      end

      it "should set instance to false" do
        expect { subject.get_hint }.to change{ subject.hint }.to(false)
      end

      it "should return ***4" do
        allow(subject).to receive(:rand).and_return(1)
        expect(subject.get_hint).to eq('*2**')
      end

      it "should return 1***" do
        allow(subject).to receive(:rand).and_return(0)
        expect(subject.get_hint).to eq('1***')
      end

    end

    context "#compasiron" do

      before do
        subject.instance_variable_set(:@code, '1234')
      end

      it "should return if incorrect code" do
        expect(subject.comparison 'ffff').to eq('Incorrect_code')
      end

      it "should return ++++" do
        expect(subject.comparison '1234').to eq('++++')
      end

      it "should return +++" do
        expect(subject.comparison '1236').to eq('+++')
      end

      it "should return +-" do
        expect(subject.comparison '6246').to eq('+-')
      end

      it "should return ++--" do
        expect(subject.comparison '2134').to eq('++--')
      end

      it "should return -" do
        expect(subject.comparison '6646').to eq('-')
      end

      it "should return ----" do
        expect(subject.comparison '4321').to eq('----')
      end

      it "should return +" do
        expect(subject.comparison '1666').to eq('+')
      end

      it "should return empty string" do
        expect(subject.comparison '6666').to eq('')
      end

    end

  end
end



