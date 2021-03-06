# frozen_string_literal: true

require 'config'
require 'github_tools'
require 'parallel'

THREADS = 6

Config.validate!
client = Config.make_client
org = Config.fetch :github_org

repo_names = STDIN.readlines chomp: true

if repo_names.empty?
  warn 'No repos, nothing to do.'
  exit 0
end

progress_label = "Unsubscribing from #{repo_names.length} repos"

Parallel.each(repo_names, in_threads: THREADS, progress: progress_label) do |repo_name|
  GitHubTools.handle_errs(client) { client.delete_subscription "#{org}/#{repo_name}" }
end
