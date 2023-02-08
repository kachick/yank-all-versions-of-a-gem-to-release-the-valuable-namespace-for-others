# frozen_string_literal: true

class BugOrOutdatedError < ScriptError; end
class UsedError < ScriptError; end

# refs for implementation
#  * https://github.com/rubygems/rubygems/blob/96e5cff3df491c4d943186804c6d03b57fcb459b/lib/rubygems/version.rb#L172-L178
#  * https://github.com/rubygems/rubygems/blob/96e5cff3df491c4d943186804c6d03b57fcb459b/lib/rubygems/version.rb#L157-L158
#  * https://github.com/rubygems/rubygems/blob/96e5cff3df491c4d943186804c6d03b57fcb459b/lib/rubygems/specification_policy.rb#L271-L283
#  * https://github.com/rubygems/rubygems/blob/96e5cff3df491c4d943186804c6d03b57fcb459b/lib/rubygems/specification.rb#L112
#  * https://github.com/rubygems/rubygems/blob/96e5cff3df491c4d943186804c6d03b57fcb459b/lib/rubygems/installer.rb#L718-L721

task :yank_all_i_swear_i_know_exactly_what_i_am_going_to_do, %w[the_retired_gem_name otp_code] do |_task, args|
  the_retired_gem_name = args.the_retired_gem_name.freeze
  raise ArgumentError, 'should pass correct gem name!' unless Gem::Specification::VALID_NAME_PATTERN.match?(the_retired_gem_name)
  otp_code = args.otp_code.freeze
  raise ArgumentError, 'should pass correct OTP code!' unless /\A\d{6}\z/.match?(otp_code)
  gem_info = `gem info #{the_retired_gem_name} --remote --all`
  name_and_versions_possibilities = gem_info.lines.grep(/\A#{Regexp.escape(the_retired_gem_name)} *\(/)
  raise BugOrOutdatedError unless name_and_versions_possibilities.size == 1
  name_and_versions = name_and_versions_possibilities.first.strip
  raise BugOrOutdatedError unless name_and_versions.delete_prefix!("#{the_retired_gem_name} (")
  raise BugOrOutdatedError unless name_and_versions.delete_suffix!(')')
  versions = name_and_versions.split(/,\s+/)
  raise BugOrOutdatedError unless versions.all? { |version| Gem::Version.correct?(version) }

  reverse_dependencies = Integer(`curl https://rubygems.org/api/v1/gems/#{the_retired_gem_name}/reverse_dependencies.json | jq '. | length'`)
  raise UsedError, 'this gem used by other public gems!' unless reverse_dependencies == 0

  versions.reverse_each do |version|
    sh "gem yank #{the_retired_gem_name} --version #{version} --otp #{otp_code}"
  end
end
