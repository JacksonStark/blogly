require 'rails_helper'

RSpec.describe "StateMachine", type: :service do
    before(:all) do
        # using Article model for now, ideally we have an AR model double
        Article.state_machine do
            state :pending, initial: true
            state :approved
            state :rejected

            event :approve do
                transitions from: :pending, to: :approved
            end

            event :reject do
                transitions from: [:pending, :approved], to: :rejected
            end
        end

        @model = Article
    end

    before(:each) {
        @model = Article
        @instance = @model.create(title: 'test')
    }

    describe "#states" do
        it "returns an array of states" do
            expect(@model.states).to be_an(Array)
            expect(@model.states.map(&:name)).to match_array([:pending, :approved, :rejected])
        end
    end

    describe "#events" do
        it "returns an array of events" do
            # binding.pry
            expect(@model.events).to be_an(Array)
            expect(@model.events.map(&:name)).to match_array([:approve, :reject])
        end
    end

    describe "#state" do
        it "defines a new state" do
            @model.state(:archived)
            expect(@model.states.map(&:name)).to include(:archived)
        end
    end

    describe "#event" do
        it "defines a new event" do
            @model.state(:archived)
            expect(@model.states.map(&:name)).to include(:archived)

            @model.event(:archive) do
                transitions from: :pending, to: :archived
            end
            expect(@model.events.map(&:name)).to include(:archive)
        end
    end

    describe "#transitions" do
        it "defines transitions for an event" do
            event = @model.events.find { |e| e.name == :approve }
            expect(event.transition.from).to eq([:pending])
            expect(event.transition.to).to eq(:approved)
        end
    end

    describe "#before_create" do
        it "sets the initial state on creation" do
            expect(@instance.state).to eq("pending")
        end
    end

    describe "#approve" do
        it "transitions from pending to approved" do
            expect { @instance.approve }.to change { @instance.state }.from("pending").to("approved")
        end

        it "raises an error when transitioning from ineligible state" do
            @instance.approve
            expect { @instance.approve }.to raise_error(Error::StateMachine::IneligibleTransition, "Can only transition to 'approved' from [:pending], not 'approved'")
        end
    end
    
    describe "#reject" do
        it "transitions from pending to rejected" do
            expect { @instance.reject }.to change { @instance.state }.from("pending").to("rejected")
        end
    
        it "transitions from approved to rejected" do
            @instance.approve
            expect { @instance.reject }.to change { @instance.state }.from("approved").to("rejected")
        end
    
        it "raises an error when transitioning from ineligible state" do
            @instance.reject
            expect { @instance.reject }.to raise_error(Error::StateMachine::IneligibleTransition, "Can only transition to 'rejected' from [:pending, :approved], not 'rejected'")
        end
    end
end