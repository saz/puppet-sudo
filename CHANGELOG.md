# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v10.0.0](https://github.com/saz/puppet-sudo/tree/v10.0.0) (2026-09-29)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v9.0.2...v10.0.0)

**Breaking changes:**

- Drop Debian 11 support [\#342](https://github.com/saz/puppet-sudo/pull/342) ([saz](https://github.com/saz))
- Add structured sudo fact [\#341](https://github.com/saz/puppet-sudo/pull/341) ([saz](https://github.com/saz))

**Implemented enhancements:**

- Add support for Ubuntu 26.04 [\#343](https://github.com/saz/puppet-sudo/pull/343) ([saz](https://github.com/saz))
- \[facter\]\[sudoversion\] Replace deprecated Facter::Util::Resolution [\#340](https://github.com/saz/puppet-sudo/pull/340) ([toggetit](https://github.com/toggetit))

**Fixed bugs:**

- Fix sudo::defaults function to correctly place list [\#338](https://github.com/saz/puppet-sudo/pull/338) ([gettalong](https://github.com/gettalong))

**Closed issues:**

- Support sudo-rs [\#337](https://github.com/saz/puppet-sudo/issues/337)
- Error while resolving custom fact fact='sudoversion', resolution='<anonymous>': undefined method `\[\]' for nil [\#335](https://github.com/saz/puppet-sudo/issues/335)
- Arch linux distributions other than Manjaro and default Arch fail with "Unsupported platform" [\#332](https://github.com/saz/puppet-sudo/issues/332)
- Fact sudoversion fails on latest Ubuntu version [\#331](https://github.com/saz/puppet-sudo/issues/331)

**Merged pull requests:**

- Update facter regex to work for Rust sudo variant \(sudo-rs\) [\#334](https://github.com/saz/puppet-sudo/pull/334) ([ky3mr2](https://github.com/ky3mr2))
- Fix os.family references for Arch and Gentoo-based distributions [\#333](https://github.com/saz/puppet-sudo/pull/333) ([zbentley](https://github.com/zbentley))
- replace puppet requirement by openvox [\#329](https://github.com/saz/puppet-sudo/pull/329) ([saz](https://github.com/saz))

## [v9.0.2](https://github.com/saz/puppet-sudo/tree/v9.0.2) (2025-02-28)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v9.0.1...v9.0.2)

**Closed issues:**

- After updating to 9.0.1 priority requires an integer instead of accepting a string [\#322](https://github.com/saz/puppet-sudo/issues/322)

**Merged pull requests:**

- prepare release: v9.0.2 [\#323](https://github.com/saz/puppet-sudo/pull/323) ([saz](https://github.com/saz))

## [v9.0.1](https://github.com/saz/puppet-sudo/tree/v9.0.1) (2025-02-20)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v9.0.0...v9.0.1)

**Closed issues:**

- Regression in v9.0.0? Config lines moved "for no reason" [\#318](https://github.com/saz/puppet-sudo/issues/318)
- Version 8 on the forge does include the RHEL9 template [\#310](https://github.com/saz/puppet-sudo/issues/310)
- I can't get sudo:defaults to work with hiera  [\#308](https://github.com/saz/puppet-sudo/issues/308)
- Publish new version to forge [\#287](https://github.com/saz/puppet-sudo/issues/287)

**Merged pull requests:**

- prepare release: v9.0.1 [\#321](https://github.com/saz/puppet-sudo/pull/321) ([saz](https://github.com/saz))
- Update to module template files [\#320](https://github.com/saz/puppet-sudo/pull/320) ([saz](https://github.com/saz))
- Revert "Include defaults as last line on all platforms" [\#319](https://github.com/saz/puppet-sudo/pull/319) ([saz](https://github.com/saz))
- Fix defaults functions for key-only configs [\#317](https://github.com/saz/puppet-sudo/pull/317) ([pikrzysztof](https://github.com/pikrzysztof))
- Cleanup old OSes leftovers [\#314](https://github.com/saz/puppet-sudo/pull/314) ([jay7x](https://github.com/jay7x))

## [v9.0.0](https://github.com/saz/puppet-sudo/tree/v9.0.0) (2024-10-18)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v8.0.0...v9.0.0)

**Closed issues:**

- secure\_path in params.pp set to incorrect defaults for recent Redhat releases [\#298](https://github.com/saz/puppet-sudo/issues/298)
- sudo::purge\_ignore: '\*\[!\_puppet\]' erase more then \*\_puppet [\#289](https://github.com/saz/puppet-sudo/issues/289)
- Add ability to set passprompt or not mange main config file/package [\#280](https://github.com/saz/puppet-sudo/issues/280)
- 'versioncmp' parameter 'a' expects a String value, got Undef [\#279](https://github.com/saz/puppet-sudo/issues/279)
- Group names with space [\#262](https://github.com/saz/puppet-sudo/issues/262)
- What happened to includedirsudoers? [\#197](https://github.com/saz/puppet-sudo/issues/197)

**Merged pull requests:**

- Update to module template files [\#311](https://github.com/saz/puppet-sudo/pull/311) ([saz](https://github.com/saz))
- Modulesync [\#307](https://github.com/saz/puppet-sudo/pull/307) ([saz](https://github.com/saz))
- add types in sudo::conf [\#306](https://github.com/saz/puppet-sudo/pull/306) ([saz](https://github.com/saz))
- Remove parameters from README.md, mention REFERENCE.md, fixes \#197 [\#305](https://github.com/saz/puppet-sudo/pull/305) ([saz](https://github.com/saz))
- use sudo::defaults in rhel9 template [\#304](https://github.com/saz/puppet-sudo/pull/304) ([saz](https://github.com/saz))
- drop purge\_ignore example, as it is not working as documented [\#303](https://github.com/saz/puppet-sudo/pull/303) ([saz](https://github.com/saz))
- Add support for RedHat 9 [\#301](https://github.com/saz/puppet-sudo/pull/301) ([patemery](https://github.com/patemery))
- add package\_manage parameter [\#299](https://github.com/saz/puppet-sudo/pull/299) ([cedriclaudrel](https://github.com/cedriclaudrel))
- Support modifying sudoers Defaults [\#282](https://github.com/saz/puppet-sudo/pull/282) ([deric](https://github.com/deric))

## [v8.0.0](https://github.com/saz/puppet-sudo/tree/v8.0.0) (2023-06-26)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v7.0.2...v8.0.0)

**Closed issues:**

- stdlib 9.x.x compat [\#291](https://github.com/saz/puppet-sudo/issues/291)
- Not All Files in /etc/sudoers.d Getting Purged [\#286](https://github.com/saz/puppet-sudo/issues/286)
- wheel\_config defaulting to 'absent' is undesirable, change to 'password' [\#276](https://github.com/saz/puppet-sudo/issues/276)
- sudo::content parameter is poorly  named [\#272](https://github.com/saz/puppet-sudo/issues/272)
- README is outdated [\#237](https://github.com/saz/puppet-sudo/issues/237)

**Merged pull requests:**

- prepare release: v8.0.0 [\#296](https://github.com/saz/puppet-sudo/pull/296) ([saz](https://github.com/saz))
- Update from modulesync\_config [\#295](https://github.com/saz/puppet-sudo/pull/295) ([saz](https://github.com/saz))
- Drop EoL Debian 9 [\#294](https://github.com/saz/puppet-sudo/pull/294) ([bastelfreak](https://github.com/bastelfreak))
- puppetlabs/stdlib: Allow 9.x [\#293](https://github.com/saz/puppet-sudo/pull/293) ([bastelfreak](https://github.com/bastelfreak))
- Add puppet 8 support [\#292](https://github.com/saz/puppet-sudo/pull/292) ([bastelfreak](https://github.com/bastelfreak))
- Improvements [\#285](https://github.com/saz/puppet-sudo/pull/285) ([saz](https://github.com/saz))
- Update from modulesync\_config [\#284](https://github.com/saz/puppet-sudo/pull/284) ([saz](https://github.com/saz))
- Restore format and behavior prior to adding wheel\_config parameter [\#278](https://github.com/saz/puppet-sudo/pull/278) ([msalway](https://github.com/msalway))
- Add prefix parameter to prefix all sudoers.d entries [\#261](https://github.com/saz/puppet-sudo/pull/261) ([traylenator](https://github.com/traylenator))

## [v7.0.2](https://github.com/saz/puppet-sudo/tree/v7.0.2) (2021-08-25)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v7.0.1...v7.0.2)

**Closed issues:**

- Puppetlabs stdlib 8.x.x support [\#275](https://github.com/saz/puppet-sudo/issues/275)

## [v7.0.1](https://github.com/saz/puppet-sudo/tree/v7.0.1) (2021-08-24)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v7.0.0...v7.0.1)

**Closed issues:**

- Release 6.0.1? [\#266](https://github.com/saz/puppet-sudo/issues/266)
- Dependency pinning resolves version 4.1.0 with new stdlib version 7.0.0 [\#263](https://github.com/saz/puppet-sudo/issues/263)
- Template for rhel8 is mising [\#255](https://github.com/saz/puppet-sudo/issues/255)

**Merged pull requests:**

- fix duplicate variable declaration [\#274](https://github.com/saz/puppet-sudo/pull/274) ([bastelfreak](https://github.com/bastelfreak))
- Update from saz modulesync\_config [\#273](https://github.com/saz/puppet-sudo/pull/273) ([saz](https://github.com/saz))

## [v7.0.0](https://github.com/saz/puppet-sudo/tree/v7.0.0) (2021-08-05)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v6.0.0...v7.0.0)

**Closed issues:**

- Bump required stdlib version to \<8.0.0 [\#267](https://github.com/saz/puppet-sudo/issues/267)
- update ::sudoversion to facts hash [\#264](https://github.com/saz/puppet-sudo/issues/264)
- Module fails with resolving custom fact "sudoversion" [\#260](https://github.com/saz/puppet-sudo/issues/260)
- Facter error on Windows [\#258](https://github.com/saz/puppet-sudo/issues/258)
- is this still maintained [\#257](https://github.com/saz/puppet-sudo/issues/257)
- unable to use hiera.yaml with module profile [\#256](https://github.com/saz/puppet-sudo/issues/256)
- rhel 8 support is missing, PRs have been submitted [\#250](https://github.com/saz/puppet-sudo/issues/250)
- AIX default package source invalid [\#240](https://github.com/saz/puppet-sudo/issues/240)
- Feature Request: Allow default settings from hiera [\#239](https://github.com/saz/puppet-sudo/issues/239)
- multiple content lines [\#238](https://github.com/saz/puppet-sudo/issues/238)
- do not fail without sudoversion fact on modern os's [\#226](https://github.com/saz/puppet-sudo/issues/226)
- Feature Request: Ability to add additional paths to secure\_path [\#220](https://github.com/saz/puppet-sudo/issues/220)
- Template users\_groups.erb is broken [\#212](https://github.com/saz/puppet-sudo/issues/212)

**Merged pull requests:**

- Make wheel param [\#271](https://github.com/saz/puppet-sudo/pull/271) ([stuartrobert](https://github.com/stuartrobert))
- Add secure path param [\#270](https://github.com/saz/puppet-sudo/pull/270) ([stuartrobert](https://github.com/stuartrobert))
- Migrate to Github Actions [\#269](https://github.com/saz/puppet-sudo/pull/269) ([saz](https://github.com/saz))
- bump stdlib requirement up to \<8.0.0 [\#268](https://github.com/saz/puppet-sudo/pull/268) ([zilchms](https://github.com/zilchms))
- Rename some rubocop rules [\#249](https://github.com/saz/puppet-sudo/pull/249) ([traylenator](https://github.com/traylenator))
- New parameter suffix to main class [\#248](https://github.com/saz/puppet-sudo/pull/248) ([traylenator](https://github.com/traylenator))
- EL8 support - changed default sudoers file for redhat enterprise linux to most current one [\#247](https://github.com/saz/puppet-sudo/pull/247) ([thalunil](https://github.com/thalunil))
- support manjaro linux [\#244](https://github.com/saz/puppet-sudo/pull/244) ([qs5779](https://github.com/qs5779))
- Remove extra % in sudo::allow template [\#242](https://github.com/saz/puppet-sudo/pull/242) ([jstraw](https://github.com/jstraw))
- parameterize AIX package provider so the default can be overridden [\#241](https://github.com/saz/puppet-sudo/pull/241) ([keeckle](https://github.com/keeckle))

## [v6.0.0](https://github.com/saz/puppet-sudo/tree/v6.0.0) (2019-02-12)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v5.0.0...v6.0.0)

**Breaking changes:**

- Move hiera lookups to init.pp [\#228](https://github.com/saz/puppet-sudo/pull/228) ([baurmatt](https://github.com/baurmatt))

**Closed issues:**

- Switch absoluete class linter to "reverse" [\#235](https://github.com/saz/puppet-sudo/issues/235)
- Rspec testing Failure/Error:   Evaluation Error: Unknown function: 'ensure\_packages'. package.pp:77:9  [\#233](https://github.com/saz/puppet-sudo/issues/233)
- Updating requirements [\#232](https://github.com/saz/puppet-sudo/issues/232)
- Move Hiera lookup to init.pp [\#227](https://github.com/saz/puppet-sudo/issues/227)
- Do not remove systemctl alias for EL 7 [\#224](https://github.com/saz/puppet-sudo/issues/224)
- Small inconsistency in the documentation  [\#222](https://github.com/saz/puppet-sudo/issues/222)
- Class\[Sudo\]: parameter 'purge\_ignore' expects a value of type Undef or String, got Tuple [\#221](https://github.com/saz/puppet-sudo/issues/221)
- How can I add Cmnd\_Alias [\#219](https://github.com/saz/puppet-sudo/issues/219)
- RHEL 5.11 broken [\#216](https://github.com/saz/puppet-sudo/issues/216)
- Add Changelog [\#210](https://github.com/saz/puppet-sudo/issues/210)

**Merged pull requests:**

- Reverse absolute classname linter [\#236](https://github.com/saz/puppet-sudo/pull/236) ([baurmatt](https://github.com/baurmatt))
- Support puppetlabs-stdlib 6.x [\#234](https://github.com/saz/puppet-sudo/pull/234) ([jehane](https://github.com/jehane))
- Allow the use of sudoreplay [\#231](https://github.com/saz/puppet-sudo/pull/231) ([rmdir](https://github.com/rmdir))
- Support puppetlabs-stdlib 5.x [\#230](https://github.com/saz/puppet-sudo/pull/230) ([hfm](https://github.com/hfm))
- Fix \#224 Update sudoers.rhel7.erb [\#225](https://github.com/saz/puppet-sudo/pull/225) ([ttres](https://github.com/ttres))
- Fix for Rubocop test failing. [\#218](https://github.com/saz/puppet-sudo/pull/218) ([spidersddd](https://github.com/spidersddd))
- anchors rhel 5 regex in params.pp [\#217](https://github.com/saz/puppet-sudo/pull/217) ([gitkodak](https://github.com/gitkodak))
- Currently we set package to undef for a couple of OSs [\#214](https://github.com/saz/puppet-sudo/pull/214) ([davidgibbons](https://github.com/davidgibbons))
- Let $purge\_ignore accept an array of strings [\#211](https://github.com/saz/puppet-sudo/pull/211) ([bitcrush](https://github.com/bitcrush))

## [v5.0.0](https://github.com/saz/puppet-sudo/tree/v5.0.0) (2018-01-11)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v4.2.0...v5.0.0)

**Closed issues:**

- Module generates deprecation warnings with puppet 4.8 \(debian stretch\) [\#208](https://github.com/saz/puppet-sudo/issues/208)
- incorrect use of 'define' in conf.pp [\#206](https://github.com/saz/puppet-sudo/issues/206)
- Module generates a deprecation warning on the hiera\_array\(\) function in allow.pp [\#205](https://github.com/saz/puppet-sudo/issues/205)
- Puppetlabs/apache and sudo  [\#202](https://github.com/saz/puppet-sudo/issues/202)
- migrate deprecated hiera\_\* to lookup\(\) [\#200](https://github.com/saz/puppet-sudo/issues/200)
- ensure\_packages\(\): Wrong number of arguments given \(2 for 1\) at /etc/puppet/modules/sudo/manifests/package.pp:77 [\#199](https://github.com/saz/puppet-sudo/issues/199)
- includedir but commented out, what's the point? [\#198](https://github.com/saz/puppet-sudo/issues/198)
- Do not change permissions for /usr/local/etc/sudoers.d/ and don't delete /usr/local/etc/sudoers.d/.keep-me [\#196](https://github.com/saz/puppet-sudo/issues/196)
- Error on sudoers.d/file delete the original file too [\#184](https://github.com/saz/puppet-sudo/issues/184)
- config\_dir not overwritten [\#162](https://github.com/saz/puppet-sudo/issues/162)
- visudo check may give false sense of syntax correctness [\#125](https://github.com/saz/puppet-sudo/issues/125)
- race condition during puppet runs [\#124](https://github.com/saz/puppet-sudo/issues/124)

**Merged pull requests:**

- Fix deprecation notices, use internal variable typing [\#209](https://github.com/saz/puppet-sudo/pull/209) ([Yyuzu](https://github.com/Yyuzu))
- Update sudoers.rhel7.erb [\#204](https://github.com/saz/puppet-sudo/pull/204) ([jeremythuon](https://github.com/jeremythuon))
- replace anchor with contain [\#203](https://github.com/saz/puppet-sudo/pull/203) ([sudodevnull](https://github.com/sudodevnull))
- allow setting the mode of $config\_dir and $config\_file [\#201](https://github.com/saz/puppet-sudo/pull/201) ([aeber](https://github.com/aeber))
- Add comment to beginning of sudo::conf content when content is an array [\#194](https://github.com/saz/puppet-sudo/pull/194) ([treydock](https://github.com/treydock))
- Document change from `$sudo::source` to `$sudo::content` [\#193](https://github.com/saz/puppet-sudo/pull/193) ([rnelson0](https://github.com/rnelson0))
- BREAKING: Support multiple `#includedir` sudoers stanzas [\#191](https://github.com/saz/puppet-sudo/pull/191) ([rnelson0](https://github.com/rnelson0))
- \#160 close use hiera lookup parameter for puppet 4 [\#188](https://github.com/saz/puppet-sudo/pull/188) ([jg-development](https://github.com/jg-development))
- Changed the file resource in conf.pp to use validate\_cmd by default [\#185](https://github.com/saz/puppet-sudo/pull/185) ([fduranti](https://github.com/fduranti))
- Fix three rubocop offences [\#183](https://github.com/saz/puppet-sudo/pull/183) ([stblassitude](https://github.com/stblassitude))
- revert change of package parameter name [\#181](https://github.com/saz/puppet-sudo/pull/181) ([tosmi](https://github.com/tosmi))
- Added 7.0 to Red Hat supported OSs [\#176](https://github.com/saz/puppet-sudo/pull/176) ([ubellavance](https://github.com/ubellavance))

## [v4.2.0](https://github.com/saz/puppet-sudo/tree/v4.2.0) (2017-06-23)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v4.1.0...v4.2.0)

**Closed issues:**

- Release 4.2.0 [\#195](https://github.com/saz/puppet-sudo/issues/195)
- source for init parameter is a breaking change [\#192](https://github.com/saz/puppet-sudo/issues/192)
- rpm installed override sudoversion package [\#182](https://github.com/saz/puppet-sudo/issues/182)
- package parameter in init.pp changed to package\_default [\#180](https://github.com/saz/puppet-sudo/issues/180)
- Gentoo not supported but code references non-existent Resource type [\#179](https://github.com/saz/puppet-sudo/issues/179)
- secure\_path doesn't have puppet binary [\#177](https://github.com/saz/puppet-sudo/issues/177)
- check-syntax statement not working on FreeBSD. [\#175](https://github.com/saz/puppet-sudo/issues/175)
- RHEL support in compatibility [\#174](https://github.com/saz/puppet-sudo/issues/174)
- undefined method `optional\_repeated\_param' [\#168](https://github.com/saz/puppet-sudo/issues/168)
- Puppet 4 - Ubuntu 16.04 - /etc/sudoers does not get overwritten. [\#160](https://github.com/saz/puppet-sudo/issues/160)

## [v4.1.0](https://github.com/saz/puppet-sudo/tree/v4.1.0) (2017-01-08)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v4.0.0...v4.1.0)

**Closed issues:**

- 4.0.0 broken on ArchLinux - params::package\_ldap undefined [\#173](https://github.com/saz/puppet-sudo/issues/173)
- Can add\_users or similar way, using hiera sudo::configs, but for different templates than sudo ALL? [\#150](https://github.com/saz/puppet-sudo/issues/150)

**Merged pull requests:**

- Ruby travis fixed, template through hiera fixed and README improved [\#170](https://github.com/saz/puppet-sudo/pull/170) ([Rocco83](https://github.com/Rocco83))
- I want to set if we include dir sudoers with augeas [\#148](https://github.com/saz/puppet-sudo/pull/148) ([edestecd](https://github.com/edestecd))
- escape % in users\_groups for erb syntax check [\#136](https://github.com/saz/puppet-sudo/pull/136) ([sknolin](https://github.com/sknolin))
- remove the empty case for OpenBSD in package.pp installation, [\#131](https://github.com/saz/puppet-sudo/pull/131) ([buzzdeee](https://github.com/buzzdeee))

## [v4.0.0](https://github.com/saz/puppet-sudo/tree/v4.0.0) (2017-01-08)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.1.0...v4.0.0)

**Closed issues:**

- Puppet 4 support [\#172](https://github.com/saz/puppet-sudo/issues/172)
- How do I  configure sudo rules in /etc/sudoers instead of sudoers.d  [\#169](https://github.com/saz/puppet-sudo/issues/169)
- New release [\#166](https://github.com/saz/puppet-sudo/issues/166)
- Puppet 4 and hiera problem [\#161](https://github.com/saz/puppet-sudo/issues/161)
- Project URL in Puppet Forge wrong [\#159](https://github.com/saz/puppet-sudo/issues/159)
- white spaces in name result in visudo to fail. [\#158](https://github.com/saz/puppet-sudo/issues/158)
- Need new module updated on forge. [\#157](https://github.com/saz/puppet-sudo/issues/157)
- Unknown function hiera\_hash [\#145](https://github.com/saz/puppet-sudo/issues/145)
- Sudo configs take a wrong default config\_dir variable [\#143](https://github.com/saz/puppet-sudo/issues/143)
- right operand of + is not a number at sudo/manifests/params.pp:13 [\#137](https://github.com/saz/puppet-sudo/issues/137)
- The project URL on the Puppet Forge is not set [\#134](https://github.com/saz/puppet-sudo/issues/134)
- sudo config objects with spaces in their name fail visudo file checks [\#132](https://github.com/saz/puppet-sudo/issues/132)
- Error: /Stage\[main\]/Sudo/Augeas\[includedirsudoers\]: Could not evaluate: Saving failed, see debug [\#128](https://github.com/saz/puppet-sudo/issues/128)
- https://forge.puppetlabs.com/saz/sudo broken link [\#127](https://github.com/saz/puppet-sudo/issues/127)
- fixedsudoers.aug breaks Augeas on Debian [\#84](https://github.com/saz/puppet-sudo/issues/84)

**Merged pull requests:**

- fix for CVE-2016-7091 by removing INPUTRC [\#171](https://github.com/saz/puppet-sudo/pull/171) ([mariusv](https://github.com/mariusv))
- freebsd has a new default sudoers file [\#167](https://github.com/saz/puppet-sudo/pull/167) ([sethlyons](https://github.com/sethlyons))
- Add file managed by Puppet comments to all sudoers files [\#163](https://github.com/saz/puppet-sudo/pull/163) ([esalberg](https://github.com/esalberg))
- Update acceptance tests [\#156](https://github.com/saz/puppet-sudo/pull/156) ([petems](https://github.com/petems))
- Fix missing param package\_ldap for Solaris and AIX OS. [\#155](https://github.com/saz/puppet-sudo/pull/155) ([mandos](https://github.com/mandos))
- Use versioncmp function to compare Debian vers in param class. [\#154](https://github.com/saz/puppet-sudo/pull/154) ([mandos](https://github.com/mandos))
- sudoversion is less os-specific, add tests [\#153](https://github.com/saz/puppet-sudo/pull/153) ([jyaworski](https://github.com/jyaworski))
- Package resource gets conflict [\#152](https://github.com/saz/puppet-sudo/pull/152) ([ashish1099](https://github.com/ashish1099))
- Add Puppet AIO binary path to secure\_path [\#149](https://github.com/saz/puppet-sudo/pull/149) ([rnelson0](https://github.com/rnelson0))
- SmartOS support [\#147](https://github.com/saz/puppet-sudo/pull/147) ([ksaio](https://github.com/ksaio))
- Add LDAP support to the package [\#146](https://github.com/saz/puppet-sudo/pull/146) ([Rocco83](https://github.com/Rocco83))
- Use class default not OS default for config\_dir [\#144](https://github.com/saz/puppet-sudo/pull/144) ([endzone](https://github.com/endzone))
- use standard sudoers lense for adding includedir on rhel 5 [\#135](https://github.com/saz/puppet-sudo/pull/135) ([tosmi](https://github.com/tosmi))
- Check for Kali Linux [\#133](https://github.com/saz/puppet-sudo/pull/133) ([prateepb](https://github.com/prateepb))
- Fix URL to project\_page [\#130](https://github.com/saz/puppet-sudo/pull/130) ([sgnl05](https://github.com/sgnl05))
- Add support for OSX [\#126](https://github.com/saz/puppet-sudo/pull/126) ([OEP](https://github.com/OEP))

## [v3.1.0](https://github.com/saz/puppet-sudo/tree/v3.1.0) (2015-06-06)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.9...v3.1.0)

**Closed issues:**

- Namespacing Issue in config.pp [\#118](https://github.com/saz/puppet-sudo/issues/118)
- sudoers + ldap [\#115](https://github.com/saz/puppet-sudo/issues/115)
- Setting 'sudo' class parameters using yaml [\#114](https://github.com/saz/puppet-sudo/issues/114)
- Invalid metadata.json [\#112](https://github.com/saz/puppet-sudo/issues/112)
- Trailing commas in metadata.json [\#110](https://github.com/saz/puppet-sudo/issues/110)
- Priority should be zero-padded [\#109](https://github.com/saz/puppet-sudo/issues/109)
- "Defaults    requiretty" didn't work with Vagrant [\#101](https://github.com/saz/puppet-sudo/issues/101)
- no support for openBSD [\#100](https://github.com/saz/puppet-sudo/issues/100)
- configs.pp breaks with future parser and without Hiera [\#98](https://github.com/saz/puppet-sudo/issues/98)
- module does not work with --parser future [\#86](https://github.com/saz/puppet-sudo/issues/86)

**Merged pull requests:**

- Gentoo support broken [\#123](https://github.com/saz/puppet-sudo/pull/123) ([blackcobra1973](https://github.com/blackcobra1973))
- Bring RHEL secure\_path settings in line with other OSes, supports PE binary location [\#122](https://github.com/saz/puppet-sudo/pull/122) ([rnelson0](https://github.com/rnelson0))
- Update in sudoers.suse, in sync with SLE12 / openSUSE 13.2 distros [\#119](https://github.com/saz/puppet-sudo/pull/119) ([tampakrap](https://github.com/tampakrap))
- Feature/invalid tags [\#117](https://github.com/saz/puppet-sudo/pull/117) ([vindir](https://github.com/vindir))
- Support Debian Jessie [\#113](https://github.com/saz/puppet-sudo/pull/113) ([CyBeRoni](https://github.com/CyBeRoni))
- Update metadata.json to remove extra commas [\#107](https://github.com/saz/puppet-sudo/pull/107) ([pbyrne413](https://github.com/pbyrne413))
- Adjust stdlib fixture url [\#105](https://github.com/saz/puppet-sudo/pull/105) ([arioch](https://github.com/arioch))
- Update sudoers.rhel7 [\#104](https://github.com/saz/puppet-sudo/pull/104) ([ozbillwang](https://github.com/ozbillwang))
- Use hardwareisa in download URL [\#103](https://github.com/saz/puppet-sudo/pull/103) ([Reamer](https://github.com/Reamer))
- bug fix - Defaults    requiretty [\#102](https://github.com/saz/puppet-sudo/pull/102) ([ozbillwang](https://github.com/ozbillwang))
- conf: Fix the scope of the visudo -c check [\#99](https://github.com/saz/puppet-sudo/pull/99) ([Spredzy](https://github.com/Spredzy))
- Replace module file with metadata.json [\#97](https://github.com/saz/puppet-sudo/pull/97) ([petems](https://github.com/petems))
- Adds acceptance tests [\#96](https://github.com/saz/puppet-sudo/pull/96) ([petems](https://github.com/petems))
- added source [\#95](https://github.com/saz/puppet-sudo/pull/95) ([soniah](https://github.com/soniah))
- Remove --nosignature and --nodigest [\#94](https://github.com/saz/puppet-sudo/pull/94) ([croddy](https://github.com/croddy))
- Added configs\_hash variable [\#92](https://github.com/saz/puppet-sudo/pull/92) ([fabiorauber](https://github.com/fabiorauber))
- OpenBSD compatibility. [\#91](https://github.com/saz/puppet-sudo/pull/91) ([buzzdeee](https://github.com/buzzdeee))
- set an empty default hash for $configs and check for it using empty\(\) [\#89](https://github.com/saz/puppet-sudo/pull/89) ([brunoleon](https://github.com/brunoleon))
- Add case in RedHat section for EL7 [\#85](https://github.com/saz/puppet-sudo/pull/85) ([dgoldsmith](https://github.com/dgoldsmith))

## [v3.0.9](https://github.com/saz/puppet-sudo/tree/v3.0.9) (2014-09-24)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.8...v3.0.9)

**Closed issues:**

- Error 'You cannot specify more than one of content, source, target' using \>=v3.0.7 [\#82](https://github.com/saz/puppet-sudo/issues/82)

## [v3.0.8](https://github.com/saz/puppet-sudo/tree/v3.0.8) (2014-09-23)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.7...v3.0.8)

**Merged pull requests:**

- Fix/strict variables [\#81](https://github.com/saz/puppet-sudo/pull/81) ([mcanevet](https://github.com/mcanevet))

## [v3.0.7](https://github.com/saz/puppet-sudo/tree/v3.0.7) (2014-09-23)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.6...v3.0.7)

**Closed issues:**

- requiretty [\#76](https://github.com/saz/puppet-sudo/issues/76)
- Puppet Module Install fails with v3.0.0 [\#71](https://github.com/saz/puppet-sudo/issues/71)
- default template for SUSE [\#69](https://github.com/saz/puppet-sudo/issues/69)
- Important Line missing in Debian 7 [\#63](https://github.com/saz/puppet-sudo/issues/63)
- sudo breaks on RHEL5 with old version of sudo \(\#includedir not working\) [\#58](https://github.com/saz/puppet-sudo/issues/58)

**Merged pull requests:**

- cosmetic changes to fix styleguide violation [\#78](https://github.com/saz/puppet-sudo/pull/78) ([simonoded](https://github.com/simonoded))
- Add Array Handling Logic [\#77](https://github.com/saz/puppet-sudo/pull/77) ([jwcarman](https://github.com/jwcarman))
- Allow some files in sudoers.d to be ignored. [\#74](https://github.com/saz/puppet-sudo/pull/74) ([nanliu](https://github.com/nanliu))
- Added option to set filename manually [\#73](https://github.com/saz/puppet-sudo/pull/73) ([netson](https://github.com/netson))
- Update sudoers.suse [\#70](https://github.com/saz/puppet-sudo/pull/70) ([schoekek](https://github.com/schoekek))
- Add template for /etc/sudoers file [\#66](https://github.com/saz/puppet-sudo/pull/66) ([mremy](https://github.com/mremy))
- Changing sudoers to reflect the actual default [\#65](https://github.com/saz/puppet-sudo/pull/65) ([ggeldenhuis](https://github.com/ggeldenhuis))
- Update README.md [\#64](https://github.com/saz/puppet-sudo/pull/64) ([tosmi](https://github.com/tosmi))
- better support for redhat 5 systems [\#62](https://github.com/saz/puppet-sudo/pull/62) ([tosmi](https://github.com/tosmi))
- removed explicit resource deps in conf.pp, rspec tests [\#61](https://github.com/saz/puppet-sudo/pull/61) ([tosmi](https://github.com/tosmi))

## [v3.0.6](https://github.com/saz/puppet-sudo/tree/v3.0.6) (2014-04-19)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.5...v3.0.6)

**Closed issues:**

- sudo-syntax-check error in puppet-sudo version 3.0.5 [\#60](https://github.com/saz/puppet-sudo/issues/60)

**Merged pull requests:**

- Hiera support for configuration snippets [\#55](https://github.com/saz/puppet-sudo/pull/55) ([level99](https://github.com/level99))

## [v3.0.5](https://github.com/saz/puppet-sudo/tree/v3.0.5) (2014-04-17)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.4...v3.0.5)

## [v3.0.4](https://github.com/saz/puppet-sudo/tree/v3.0.4) (2014-04-17)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.3...v3.0.4)

**Closed issues:**

- "Purge sudoers.d directory, but leave sudoers file as it is" [\#56](https://github.com/saz/puppet-sudo/issues/56)

**Merged pull requests:**

- Validate all sudoers files on each update into sudoers.d [\#59](https://github.com/saz/puppet-sudo/pull/59) ([mafredri](https://github.com/mafredri))
- fix documentation for $config\_file\_replace [\#57](https://github.com/saz/puppet-sudo/pull/57) ([tosmi](https://github.com/tosmi))
- remove puppet 3.0.0 from .travis.yml because of puppet bug 15529 [\#54](https://github.com/saz/puppet-sudo/pull/54) ([tosmi](https://github.com/tosmi))
- fixed solaris 10/11 rspec tests [\#53](https://github.com/saz/puppet-sudo/pull/53) ([tosmi](https://github.com/tosmi))

## [v3.0.3](https://github.com/saz/puppet-sudo/tree/v3.0.3) (2014-03-08)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.2...v3.0.3)

**Merged pull requests:**

- if config\_replace is false use augeas to add \#include\_dir on redhat 5 [\#52](https://github.com/saz/puppet-sudo/pull/52) ([tosmi](https://github.com/tosmi))
- improve solaris 10 support [\#51](https://github.com/saz/puppet-sudo/pull/51) ([tosmi](https://github.com/tosmi))
- use upstream \(sudo.ws\) sudo, remove ldap dependency [\#50](https://github.com/saz/puppet-sudo/pull/50) ([tosmi](https://github.com/tosmi))
- refactor rspec tests [\#49](https://github.com/saz/puppet-sudo/pull/49) ([tosmi](https://github.com/tosmi))

## [v3.0.2](https://github.com/saz/puppet-sudo/tree/v3.0.2) (2014-02-23)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.1...v3.0.2)

**Merged pull requests:**

- rspec tests for AIX [\#48](https://github.com/saz/puppet-sudo/pull/48) ([tosmi](https://github.com/tosmi))
- fixed documentation for $purge \(default is true\) [\#47](https://github.com/saz/puppet-sudo/pull/47) ([tosmi](https://github.com/tosmi))
- Minor syntax fixes to reduce puppet lint warnings [\#46](https://github.com/saz/puppet-sudo/pull/46) ([danieldreier](https://github.com/danieldreier))

## [v3.0.1](https://github.com/saz/puppet-sudo/tree/v3.0.1) (2014-02-05)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v3.0.0...v3.0.1)

**Closed issues:**

- No new line @ EOF on template [\#44](https://github.com/saz/puppet-sudo/issues/44)

**Merged pull requests:**

- Added new line to EOF [\#45](https://github.com/saz/puppet-sudo/pull/45) ([kingcody](https://github.com/kingcody))

## [v3.0.0](https://github.com/saz/puppet-sudo/tree/v3.0.0) (2014-01-22)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.4.3...v3.0.0)

**Closed issues:**

- Change config\_file\_replace and purge back to true  [\#43](https://github.com/saz/puppet-sudo/issues/43)

**Merged pull requests:**

- Update params.pp [\#42](https://github.com/saz/puppet-sudo/pull/42) ([mattboston](https://github.com/mattboston))
- Added new package\_ensure parameter, and changed "ensure" parameter to "enable" parameter. [\#41](https://github.com/saz/puppet-sudo/pull/41) ([solarkennedy](https://github.com/solarkennedy))

## [v2.4.3](https://github.com/saz/puppet-sudo/tree/v2.4.3) (2013-12-09)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.4.2...v2.4.3)

**Merged pull requests:**

- Change dot in file name [\#39](https://github.com/saz/puppet-sudo/pull/39) ([mremy](https://github.com/mremy))

## [v2.4.2](https://github.com/saz/puppet-sudo/tree/v2.4.2) (2013-12-04)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.4.1...v2.4.2)

**Merged pull requests:**

- Fix syntax check, add spec test [\#38](https://github.com/saz/puppet-sudo/pull/38) ([smarlow](https://github.com/smarlow))

## [v2.4.1](https://github.com/saz/puppet-sudo/tree/v2.4.1) (2013-12-03)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.4.0...v2.4.1)

**Merged pull requests:**

- Check configuration file and notify sudo [\#37](https://github.com/saz/puppet-sudo/pull/37) ([mremy](https://github.com/mremy))
- added missing sudoers default config file [\#36](https://github.com/saz/puppet-sudo/pull/36) ([tosmi](https://github.com/tosmi))

## [v2.4.0](https://github.com/saz/puppet-sudo/tree/v2.4.0) (2013-12-02)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.3.0...v2.4.0)

**Merged pull requests:**

- added aix support [\#32](https://github.com/saz/puppet-sudo/pull/32) ([tosmi](https://github.com/tosmi))

## [v2.3.0](https://github.com/saz/puppet-sudo/tree/v2.3.0) (2013-12-01)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.2.0...v2.3.0)

**Closed issues:**

- hiera hierarchy doesn't "merge" [\#34](https://github.com/saz/puppet-sudo/issues/34)
- "File paths must be fully qualified" error [\#33](https://github.com/saz/puppet-sudo/issues/33)
- RHEL Sudo config file breaks sudo if package \< 1.7.0 [\#30](https://github.com/saz/puppet-sudo/issues/30)
- Add parameter for timestamp\_timeout [\#25](https://github.com/saz/puppet-sudo/issues/25)
- New parameter for array of users to get sudo access [\#23](https://github.com/saz/puppet-sudo/issues/23)
- Docs for config\_file\_replace don't match actual default value [\#22](https://github.com/saz/puppet-sudo/issues/22)
- still need to 'include sudo' outside of sudo::conf for conf to work [\#18](https://github.com/saz/puppet-sudo/issues/18)
- What does priority mean? [\#17](https://github.com/saz/puppet-sudo/issues/17)

**Merged pull requests:**

- added support for solaris 11 in params.pp [\#35](https://github.com/saz/puppet-sudo/pull/35) ([tosmi](https://github.com/tosmi))
- \(\#30\) Switch source of RHEL sudoers config file based on release ver. [\#31](https://github.com/saz/puppet-sudo/pull/31) ([fatmcgav](https://github.com/fatmcgav))
- manifests/init.pp: updated default values in comments. [\#28](https://github.com/saz/puppet-sudo/pull/28) ([php-coder](https://github.com/php-coder))
- manifests/init.pp: corrected module description inside comment. [\#27](https://github.com/saz/puppet-sudo/pull/27) ([php-coder](https://github.com/php-coder))
- manifests/conf.pp: fixed a typo in comment. [\#26](https://github.com/saz/puppet-sudo/pull/26) ([php-coder](https://github.com/php-coder))
- New class sudo::allow to support Hiera better [\#24](https://github.com/saz/puppet-sudo/pull/24) ([nicwaller](https://github.com/nicwaller))
- Solution for $sudo::conf not loading in $sudo::params prior to parameter... [\#21](https://github.com/saz/puppet-sudo/pull/21) ([thomasbiddle](https://github.com/thomasbiddle))
- Setting both purge and config\_replace to false. [\#20](https://github.com/saz/puppet-sudo/pull/20) ([thomasbiddle](https://github.com/thomasbiddle))
- Fix wheezy detection [\#19](https://github.com/saz/puppet-sudo/pull/19) ([rpeltola](https://github.com/rpeltola))
- Add Ubuntu support [\#16](https://github.com/saz/puppet-sudo/pull/16) ([djs](https://github.com/djs))

## [v2.2.0](https://github.com/saz/puppet-sudo/tree/v2.2.0) (2013-02-01)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.1.0...v2.2.0)

**Closed issues:**

- Typo in params.pp [\#14](https://github.com/saz/puppet-sudo/issues/14)
- sudo::conf does not include sudo [\#13](https://github.com/saz/puppet-sudo/issues/13)

**Merged pull requests:**

- some fixes [\#15](https://github.com/saz/puppet-sudo/pull/15) ([DavidS](https://github.com/DavidS))

## [v2.1.0](https://github.com/saz/puppet-sudo/tree/v2.1.0) (2012-11-19)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.0.9...v2.1.0)

**Merged pull requests:**

- Initial Archlinux support added, to replace debian sudoers file. [\#12](https://github.com/saz/puppet-sudo/pull/12) ([aboe76](https://github.com/aboe76))

## [v2.0.9](https://github.com/saz/puppet-sudo/tree/v2.0.9) (2012-11-02)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.0.8...v2.0.9)

**Merged pull requests:**

- make purge a class parameter [\#11](https://github.com/saz/puppet-sudo/pull/11) ([jon-proulx](https://github.com/jon-proulx))

## [v2.0.8](https://github.com/saz/puppet-sudo/tree/v2.0.8) (2012-10-13)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.0.7...v2.0.8)

**Closed issues:**

- No explicit licence [\#10](https://github.com/saz/puppet-sudo/issues/10)

## [v2.0.7](https://github.com/saz/puppet-sudo/tree/v2.0.7) (2012-09-25)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.0.6...v2.0.7)

## [v2.0.6](https://github.com/saz/puppet-sudo/tree/v2.0.6) (2012-08-14)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.0.5...v2.0.6)

**Merged pull requests:**

- archlinux compatibility [\#9](https://github.com/saz/puppet-sudo/pull/9) ([simonsd](https://github.com/simonsd))

## [v2.0.5](https://github.com/saz/puppet-sudo/tree/v2.0.5) (2012-08-08)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/v2.0.0...v2.0.5)

**Closed issues:**

- module deletes my snippets which are not managed by puppet [\#2](https://github.com/saz/puppet-sudo/issues/2)

**Merged pull requests:**

- Add newline in the end of sudo::conf content [\#8](https://github.com/saz/puppet-sudo/pull/8) ([antonlindstrom](https://github.com/antonlindstrom))
- Add support for Solaris [\#7](https://github.com/saz/puppet-sudo/pull/7) ([beezly](https://github.com/beezly))
- puppet-sudo pull request [\#5](https://github.com/saz/puppet-sudo/pull/5) ([deadpoint](https://github.com/deadpoint))
- Add support for Fedora [\#4](https://github.com/saz/puppet-sudo/pull/4) ([stahnma](https://github.com/stahnma))
- adding gentoo [\#3](https://github.com/saz/puppet-sudo/pull/3) ([hairmare](https://github.com/hairmare))
- Added the bits needed for RedHat and CentOS [\#1](https://github.com/saz/puppet-sudo/pull/1) ([MattMencel](https://github.com/MattMencel))

## [v2.0.0](https://github.com/saz/puppet-sudo/tree/v2.0.0) (2012-01-20)

[Full Changelog](https://github.com/saz/puppet-sudo/compare/60c44ee6e964ba824ec7990b50941a2df4ee9a30...v2.0.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
