# Yank all versions of a gem to release the valuable namespace for others

In my understanding...

* Basically, once released, gem versions should not be yanked except for unavoidable reasons.
  * Security issues
  * License issues
  * Secrets accidentally included in the gem file

But I believe, OSS licenses accept to retire from projects.
So if you really want to retire, which behaviors are preferable?

* Find successors as maintainers and give them power
* Keep the source code, but archive it with the reason and point to a new repository URL

This is right!

But experimental gems, old gems, no longer maintained gems. If they are almost never used, releasing the namespace might be a good choice?

Below links say that if all versions of a gem are yanked, the namespace will be released.

* [Deprecated site, but looks still active some of the information](https://help.rubygems.org/kb/gemcutter/removing-a-published-rubygem)
* [Showing message when yanked all versions](https://github.com/rubygems/rubygems.org/blob/60fed00a6769ee5aee89150669034e51d12de865/config/locales/en.yml#L429-L433)

Here is an excerpt

```plaintext
I just renamed my gem. Can you delete the old one?
Once you've yanked all versions of a gem, anyone can push onto that same gem namespace and effectively take it over.       This way, we kind of automate the process of taking over old gem namespaces.

I don't want to be using up the namespace
Once you've yanked all versions of a gem the namespace is free for others to use. If you accidentally pushed the wrong name once yank it and it'll be free for others to use.
```

```plaintext
This gem previously existed, but has been removed by its owner. The RubyGems.org team has reserved this gem name for %{count} more days. After that time is up, anyone will be able to claim this gem name using gem push.
```

Sounds good! But...

The `gem yank` command requires the specified `version`. I can understand that, it should be safe to handle valuable gems. Reasonable. Should not be changed.

But it makes operations annoying when you actually want to free the namespace.

This is a solution.

## Tasks before using this

Confirm that the library is not used by other OSS at least hosted on GitHub and/or published on rubygems.

```plaintext
https://github.com/#{your_name}/#{the_library}/network/dependents
https://rubygems.org/gems/#{the_library}/reverse_dependencies
```

## Usage

```console
$ git clone git@github.com:kachick/yank-all-versions-of-a-gem-to-release-the-valuable-namespace-for-others.git
$ cd yank-all-versions-of-a-gem-to-release-the-valuable-namespace-for-others
$ rake 'yank_all_i_swear_i_know_exactly_what_i_am_going_to_do[the_retired_gem_name,otp_code]'
gem yank the_retired_gem_name --version 0.0.1 --otp 123456
Yanking gem from https://rubygems.org...
Successfully deleted gem: the_retired_gem_name (0.0.1)
gem yank the_retired_gem_name --version 0.0.2.1 --otp 123456
Yanking gem from https://rubygems.org...
Successfully deleted gem: the_retired_gem_name (0.0.2.1)
gem yank the_retired_gem_name --version 0.0.3 --otp 123456
Yanking gem from https://rubygems.org...
Successfully deleted gem: the_retired_gem_name (0.0.3)

...I got peace
```

![All worldly things are transitory](https://user-images.githubusercontent.com/1180335/119101820-6174dd00-ba54-11eb-9b38-872c33f6f5ea.png)

This is dangerous. Whether it works correctly or not is not guaranteed, the function of the `gem` command changes the behavior.
I don't recommend using this way for others.

## Motivation

* [ja](https://github.com/kachick/times_kachick/issues/72)
