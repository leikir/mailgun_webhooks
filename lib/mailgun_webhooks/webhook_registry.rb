module MailgunWebhooks
  class WebhookRegistry

    def initialize
      @hooks = Hash.new { |h, k| h[k] = [] }
    end

    # Public: Store a block by name for later execution.
    #
    # Returns nothing.
    def on(webhook, &block)
      @hooks[webhook.to_sym] << block
    end

    # Public: Execute all of the blocks associated with the webhook.
    #
    # Returns status returned by block execution
    def trigger(webhook, data)
      @hooks[webhook.to_sym].each { |hook| return hook.call(data) }
    end

  end
end
