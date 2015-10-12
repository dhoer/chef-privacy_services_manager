# Privacy Services Manager Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/privacy_services_manager.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-privacy_services_manager.svg?style=flat-square)][travis]

[cookbook]: https://supermarket.chef.io/cookbooks/privacy_services_manager
[travis]: https://travis-ci.org/dhoer/chef-privacy_services_manager


Configures Mac OS X Accessibility, Calendar, Contacts, iCloud, Location Services and Reminders using 
University of Utah, Marriott Library, Apple Support's 
[privacy_services_manager](https://github.com/univ-of-utah-marriott-library-apple/privacy_services_manager).

## Requirements

- Chef 11+

### Platforms

- Mac OS X 10.8+

## Usage

This cookbook wraps University of Utah, Marriott Library, Apple Support's 
[privacy_services_manager](https://github.com/univ-of-utah-marriott-library-apple/privacy_services_manager).  
Please read their documentation thoroughly before using this cookbook.

### Actions

There are four actions available:

- `add`  Creates an entry for the specified application and enable the application for the service.
- `enable` Effectively just calls `add`, ensuring that the application has been added and enabled.
- `remove` Deletes the application's entry within the service. There will no longer be a record of that 
application therein.
- `disable` Leaves the application's record intact, but will disallow the application from utilizing the 
given service.

### Attributes

- `services` There are six services that can be modified:
  - `accessibility` deals with behind-the-scenes systems that Apple believes require extra privileges to enable. 
Applications that interface with your computer experience, such as BetterSnapTool or the Steam in-game overlay, 
require access through this service. These privileges must be granted by a privileged user via sudo.
  - `calendar` is the service responsible for allowing applications to inject events into your calendar. This can be 
used to schedule recurring events, among other things.
  - `contacts` handles requests to access a user's address book. Many web browsers use this to store login information 
for various websites. This service is handled on a per-user basis, so any user has the ability to modify this service 
for themselves.
  - `icloud` manages access to a user's iCloud storage and settings. Examples would be any text editing application 
that is able to save to your iCloud, such as TextEdit or iA Writer. Because of the nature of this request (access to 
a user's personal files and settings).
  - `location` manages any application that desires to report on your physical location. Apple's own Maps application 
will request access to this, as well as web browsers once you visit a website that asks for your location (such as 
Google Maps). 
  - `reminders` gives an application the ability to access your Reminders (which are usually handled manually via the 
Reminders application).
- `template`	Modify privacy services for Apple's User Template. Only applies to certain services.
- `forceroot`	Force the script to allow the creation/modification of the root user's own TCC database file.
- `no_check_bin`	Enable administrative override for binaries.
- `log_dest` Redirect logging to the specified file.
- `user` Modify privacy services for a specific user named "user". 
- `language` 	When changing privacy services for the Apple's User Template, modify the lang template. 
(Apple provides many User Template folder for different languages.)

Note the `user`, `template`, and `language` flags only affect those services which use the TCC system, i.e. `contacts`, 
`icloud`, and `accessibility`. Providing these options for Location Services will have no effect.

### Examples

#### Add an application to your own contacts service permissions

Most web browsers will ask you for permission to look at your contacts. 

Let's add Safari as a trusted application for vagrant user:

```ruby
privacy_services_manager 'grant safari access to contacts' do
  service 'contacts'
  user 'vagrant'
  applications ['com.apple.Safari']
  action :add
end
```

#### Add an application to the global location service permissions

For this part of the walkthrough we will be adding Apple's Maps application to 
Location Services, but know that the process is the same for Accessibility.

First, because Location Services is handled a bit differently under-the-hood, we have to enable the system globally. 

```ruby
privacy_services_manager 'enable location services globally' do
  service 'location'
  action :enable
end
```

Now we will add Maps to the database. To do this, simply do:

```ruby
privacy_services_manager 'add location services for maps' do
  service 'location'
  applications ['maps']
  action :add
end
```

## ChefSpec Matchers

This cookbook includes a custom [ChefSpec](https://github.com/sethvargo/chefspec) matcher you can use to test your
own cookbooks.

Example Matcher Usage

```ruby
expect(chef_run).to add_privacy_services_manager('grant safari access to contacts').with(
  service: 'contacts',
  user: 'vagrant',
  applications: ['com.apple.Safari'])
```

Cookbook Matchers

- add_privacy_services_manager(resource_name)
- enable_privacy_services_manager(resource_name)
- remove_privacy_services_manager(resource_name)
- disable_privacy_services_manager(resource_name)

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-privacy_services_manager).
- Report bugs and discuss potential features in
[Github issues](https://github.com/dhoer/chef-privacy_services_manager/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-privacy_services_manager/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-privacy_services_manager/blob/master/LICENSE.md) 
file for details.
