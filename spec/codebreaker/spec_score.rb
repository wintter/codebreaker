require '../spec_helper'

module Codebreaker

  describe Score do
    subject { Score }

    context "initial conditions for Score" do

      it "should file" do
        expect(subject::SCORE_INFO).not_to be_empty
      end

      it "should respond_to get_info" do
        expect(subject).to respond_to(:get_info)
      end

      it "should respond_to load" do
        expect(subject).to respond_to(:load)
      end

      it "should respond_to set" do
        expect(subject).to respond_to(:set)
      end

      it "should respond_to save_result" do
        expect(subject).to respond_to(:save_result)
      end

    end

    context "#get_info" do

      it "should return string with Players and attempts" do
        expect(subject.get_info).to include('Player', 'attempts')
      end

      it "should generate correct string" do
        expect(subject.get_info name: 'Bob', user_attempts: '4').to eq("Player: Bob , attempts: 4")
      end

    end

    context "#load" do

      before do
        allow(File).to receive_message_chain(:readlines, :each)
      end

      it "should read the file before add a new player" do
        expect(File).to receive(:readlines)
        subject.load
      end

    end

    context "#set" do

      before do
        allow(File).to receive_message_chain(:readlines, :each)
        allow(File).to receive(:open)
      end

      it "should return false if file is not exist" do
        subject::SCORE_INFO = ''
        expect(subject.set double('data')).to eq(false)
      end

     it "should call load" do
       allow(File).to receive(:exist?).and_return(true)
       allow(subject).to receive(:load).once
       subject.set double('data')
     end

    end

    context "#save_result" do

      it "should have string with new player" do
        expect(subject).to receive(:set).with(instance_of(String))
        subject.save_result double
      end

      it "should have some message when save the score" do
        expect(subject).to receive(:puts).and_return('some message')
        subject.save_result double
      end

    end

  end
end



