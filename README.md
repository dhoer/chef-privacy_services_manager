# Mac OS X Privacy Services Manager Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/privacy_services_manager.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-privacy_services_manager.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-privacy_services_manager.svg?style=flat-square)][github]

[cookbook]: https://supermarket.chef.io/cookbooks/privacy_services_manager
[travis]: https://travis-ci.org/dhoer/chef-privacy_services_manager
[github]: https://github.com/dhoer/chef-privacy_services_manager/issues


Configures Mac OS X Accessibility, Contacts, iCloud, and Location services using 
University of Utah, Marriott Library, Apple Support's 
[privacy_services_manager](https://github.com/univ-of-utah-marriott-library-apple/privacy_services_manager).

## Requirements

- Chef 11 or higher

### Platforms

- Mac OS X - Mavericks (10.8) or higher

## Usage

This cookbook wraps University of Utah, Marriott Library, Apple Support's 
[privacy_services_manager](https://github.com/univ-of-utah-marriott-library-apple/privacy_services_manager).  
Please read their documentation thoroughly before using this.

### Actions

There are four actions available:

- `add` will create an entry for the specified application and enable the application for the service.
- `enable` effectively just calls add, ensuring that the application has been added and enabled.
- `remove` will delete the application's entry within the service. There will no longer be a record of that application therein.
- `disable` will leave the application's record intact, but will disallow the application from utilizing the given service.

### Attributes

- `services` There are six services that can be modified:
  - `contacts` handles requests to access a user's address book. Many web browsers use this to store login information 
for various websites. This service is handled on a per-user basis, so any user has the ability to modify this service 
for themselves.
  - `accessibility` deals with behind-the-scenes systems that Apple believes require extra privileges to enable. 
Applications that interface with your computer experience, such as BetterSnapTool or the Steam in-game overlay, 
require access through this service. These privileges must be granted by a privileged user via sudo.
  - `calendar` is the service responsible for allowing applications to inject events into your calendar. This can be 
used to schedule recurring events, among other things.
  - `reminders` gives an application the ability to access your Reminders (which are usually handled manually via the 
Reminders application).
  - `location` manages any application that desires to report on your physical location. Apple's own Maps application 
will request access to this, as well as web browsers once you visit a website that asks for your location (such as 
Google Maps). 
  - `icloud` manages access to a user's iCloud storage and settings. Examples would be any text editing application 
that is able to save to your iCloud, such as TextEdit or iA Writer. Because of the nature of this request (access to 
a user's personal files and settings).
- `template`	Modify privacy services for Apple's User Template. Only applies to certain services.
- `forceroot`	Force the script to allow the creation/modification of the root user's own TCC database file.
- `admin`	Enable administrative override to modify services for non-bundled applications. 
- `log_dest` Redirect logging to the specified file.
- `user` Modify privacy services for a specific user named "user". 
- `language` 	When changing privacy services for the Apple's User Template, modify the lang template. 
(Apple provides many User Template folder for different languages.)

Note the `user`, `template`, and `language` flags only affect those services which use the TCC system, i.e. `contacts`, 
`icloud`, and `accessibility`. Providing these options for Location Services will have no effect.


#### Add an application to your own contacts service permissions

Most web browsers will ask you for permission to look at your contacts. They can store things like your usernames 
and passwords here, among other things. 

Let's add Safari as a trusted application for your own account:

```ruby
privacy_services_manager 'grant safari access to contacts' do
  service 'contacts'
  applications ['com.apple.Safari']
  action :add
end
```

#### Add an application to the global location service permissions

Two of the services supported by Privacy Services Manager require administrative privileges to modify: 
Accessibility and Location Services. For this part of the walkthrough we will be adding Apple's Maps application to 
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

#### Add an application to another user's contacts service permissions

You've just installed some great program on the computer for your grandma, and you know it's going to ask for 
permission to leaf through her address book the first time she launches it.  You preemptively add permission for 
this application to her contacts service.

Let's say the application is called "MyApp":

```ruby
privacy_services_manager 'add MyApp to grandma's contacts permissions' do
  user 'grandma'
  service 'location'
  applications ['maps']
  action :add
end
```

This should add MyApp to your grandmother's contacts permissions, preventing any issues with her launching MyApp 
for the first time.


## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-privacy_services_manager).
- Report bugs and discuss potential features in
[Github issues](https://github.com/dhoer/chef-privacy_services_manager/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-privacy_services_manager/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-privacy_services_manager/blob/master/LICENSE.md) file
for details.
