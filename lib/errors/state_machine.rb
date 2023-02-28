module Error
    module StateMachine
        class InvalidState < StandardError; end
        class IneligibleState < StandardError; end
        class MissingInitialState < StandardError; end
        class IneligibleTransition < StandardError; end
    end
end