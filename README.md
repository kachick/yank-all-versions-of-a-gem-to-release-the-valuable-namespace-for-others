# Yank all versions of a gem to release the valuable namespace for others

In my understanding...

* Basically once released gem versions should not be yanked except unavoidable reasons.
  * Security issue
  * License issue
  * Accidentally contained secrets in the gem file

But I believe, OSS licenses accept to retire from projects.
So when want to actually retire from it, which behaviors will be preferable?

* Find successors as maintainers and give the power to them
* Keep the source code, but archived with the reason and refer new repository URL

It is right!

But experimental gems, ancient gems, no longer maintained gems. When they are almost not used, Releasing the namespace might be a good choice?

Below links say, when yanked all versions of a gem, the namespace will be released.

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

`gem yank` command requires the `version` specified. I can understand, it should be safe for handling valuable gems. Reasonable. Should not be changed.

But it makes annoy operations when actually want to release the namespace.

This is a solution.

## Tasks before using this

Confirm the library is not used by other OSS at least hosted on GitHub and/or published on rubygems

```plaintext
https://github.com/#{your_name}/#{the_library}/network/dependents
https://rubygems.org/gems/#{the_library}/reverse_dependencies
```

## Usage

```console
$ git clone git@github.com:kachick/yank-all-versions-of-a-gem-to-release-the-valuable-namespace-for-others.git
$ cd yank-all-versions-of-a-gem-to-release-the-valuable-namespace-for-others
$ rake yank_all_i_swear_i_know_exactly_what_i_am_going_to_do[the_retired_gem_name,otp_code]
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

This is dangerous. Correctly works or not is not ensured the feature of `gem` command behavior changes.

My environment when used this tool.

```console
$ ruby -v
ruby 3.0.1p64 (2021-04-05 revision 0fb782ee38) [x86_64-darwin20]

$ gem -v
3.2.15

$ bundle -v
Bundler version 2.2.17

$ rake --version
rake, version 13.0.3
```

I don't recommend to use this way, for others.

## Motivation

* [ja](https://github.com/kachick/times_kachick/issues/72)
