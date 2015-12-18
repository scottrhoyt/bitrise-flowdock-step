require 'flowdock'

flow_token = ENV['flowdock_source_token']

if !(flow_token)
  exit(1)
end

# Create a client that uses a source's flow_token to authenticate. Can only use post_to_thread
flow_token_client = Flowdock::Client.new(flow_token: flow_token)

# Get Bitrise info
is_build_failed_mode = ENV['STEPLIB_BUILD_STATUS'] != '0'
app_name = ENV['BITRISE_APP_TITLE'] || 'UNKNOWN APP'
branch = ENV['BITRISE_GIT_BRANCH'] || 'UNKNOWN BRANCH'
build_number = ENV['BITRISE_BUILD_NUMBER'] || 'UNKNOWN'
build_url = ENV['BITRISE_BUILD_URL']

# Create status
status = {}
if (is_build_failed_mode)
  status[:color] = 'red'
  status[:value] = 'fail'
else
  status[:color] = 'green'
  status[:value] = 'success'
end

# Create author
author = {}
author[:name] = 'Bitrise Bot'
author[:avatar] = 'https://avatars1.githubusercontent.com/u/7174390?v=3&s=200'

# Create thread
thread = {}
thread[:title] = app_name + ' on ' + branch
thread[:external_url] = build_url
thread[:status] = status

# Create payload
payload = {}
payload[:event] = 'activity'
payload[:author] = author
payload[:title] = 'A Bitrise build completed.'
payload[:external_thread_id] = build_number
payload[:thread] = thread

flow_token_client.post_to_thread(payload)
