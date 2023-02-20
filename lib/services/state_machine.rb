require_relative '../errors/state_machine'

# StateMachine class
module Services
    module StateMachine
        attr_reader :states, :events
    
        # A single state in the state machine
        class State
            attr_reader :name, :initial
        
            def initialize(name, initial: false)
                @name = name
                @initial = initial
            end
        end
      
        # An event that can be triggered in the state machine
        class Event
            attr_accessor :name, :transition
        
            def initialize(name)
                @name = name
            end
        end
    
        # A transition between two states in the state machine
        class Transition
            attr_reader :from, :to
        
            def initialize(from:, to:)
                @from = Array(from)
                @to = to
            end
        end
    
        # Set up states, events, and call block argument
        def state_machine(&block)
            @states = []
            @events = []
            instance_eval(&block)

            # Apply initial state / add instance functions
            initial_state = @states.find(&:initial)
            if initial_state
                self.before_create -> { self.state = initial_state.name }
            else
                raise Error::StateMachine::MissingInitialState, "Initial state is not declared"
            end

            # Ensure direct state updates still conform to transition constraints
            define_method('state=') do |value|
                if self.state 
                    if value != self.state
                        self.validate_transition(value)
                        super(value)
                    end
                else # Model creation
                    if value == initial_state.name
                        super(value)
                    end
                end
            end

            define_method(:get_transitions) do
                # Get all events containing current state in their transition "from"
                self.class.events.select { |e| e.transition.from.include?(self.state.to_sym) }.map { |e| e.name }
            end

            define_method(:validate_transition) do |to_state|
                # Find an event with a transition to the to_state
                transition = self.class.events.find { |e| e.transition.to == to_state.to_sym }&.transition

                if !transition
                    raise Error::StateMachine::IneligibleState, "'#{to_state}' is not an eligible state"
                end

                is_eligible_transition = transition.from.include?(self.state.to_sym)

                # Verify transition eligibility
                if !is_eligible_transition
                    raise Error::StateMachine::IneligibleTransition, "Can only transition to '#{transition.to}' from #{transition.from}, not '#{self.state}'"
                end

                is_eligible_transition
            end
        end
    
        # Add new state to the state machine
        def state(name, initial: false)
            @states << State.new(name, initial: initial)
        end
    
        # Add new event to the state machine
        def event(name, &block)
            @events << Event.new(name)
            instance_eval(&block)
    
            # Define instance method with same name as the event, triggerable on invocation
            define_method(name) do
                to_state = self.class.events.find { |e| e.name == name }.transition.to
                self.update(state: to_state)
            end
        end
    
        # Add transition to the event
        def transitions(from:, to:)
            # Ensure all passed from-to states are eligible
            transitions = Array(from) + Array(to)
            transitions.each do |transition|
                is_valid_state = @states.map(&:name).include?(transition)

                if !is_valid_state
                    raise Error::StateMachine::InvalidState "Transition state, '#{transition}', is not declared as a state."
                end
            end

            # Add the transition to event
            @events.last.transition = Transition.new(from: from, to: to)
        end
    end
end