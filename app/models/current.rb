class Current < ActiveSupport::CurrentAttributes
    # allows us to keep all per-request attributes easily available 
    # to the whole system. Essentially this enables us to set and 
    # have access to a current user during each request to the server
    attribute :user
end