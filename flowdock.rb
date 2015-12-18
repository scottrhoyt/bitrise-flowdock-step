require 'flowdock'

flow_token = ENV['flowdock_source_token']

if !(flow_token)
  exit(1)
end

# Create a client that uses a source's flow_token to authenticate. Can only use post_to_thread
flow_token_client = Flowdock::Client.new(flow_token: flow_token)

flow_token_client.post_to_thread(
    event: "activity",
    author: {
        name: "Bitrise1"
    },
    title: "A Bitrise build completed1",
    external_thread_id: "7777",
    thread: {
        title: "Bitrise2",
        body: "<p>A Bitrise build completed2</p>",
        external_url: "https://example.com/issue/123",
        status: {
            color: "red",
            value: "boom"
        }
    }
)
