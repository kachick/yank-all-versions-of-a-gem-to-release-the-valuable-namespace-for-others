# Yank all versions of a gem to release the valuable namespace for others

In my understanding, when yanked all versions of a gem, the namespace will be released.

[deprecated site, but looks still active some of the information](https://help.rubygems.org/kb/gemcutter/removing-a-published-rubygem)

Here is an excerpt

```plaintext
I just renamed my gem. Can you delete the old one?
Once you've yanked all versions of a gem, anyone can push onto that same gem namespace and effectively take it over.       This way, we kind of automate the process of taking over old gem namespaces.

I don't want to be using up the namespace
Once you've yanked all versions of a gem the namespace is free for others to use. If you accidentally pushed the wrong name once yank it and it'll be free for others to use.
```

Sounds good! But...

`gem yank` command requires the `version` specified. I can understand, it should be safe for handling valuable gems. Reasonable. Should not be changed.

But it makes annoy operations when actually want to release the namespace.

This is the one.

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

This is dangerous. Correctly works or not is not ensured the feature of `gem` command behavior changes. I don't recommend to use this tool by others.

## License?

WTFPL

* https://choosealicense.com/licenses/wtfpl/
* https://en.wikipedia.org/wiki/WTFPL

## Motivation

* [ja](https://github.com/kachick/times_kachick/issues/72)
