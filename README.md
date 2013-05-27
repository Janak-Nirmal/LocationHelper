LocationHelper
==============

## Overview
** LocationHelper** is a simple class that will allow you to get user's current location with a single instance across the application.

## How to use
It can be initialised as easy as:

    [[LocationHelper sharedInstance] requestNewLocation];

Before requesting you will have to set notification listener methods as

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationAuthorizationStatus:) name:kAuthorizationUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated:) name:kLocationUpdateNotification object:nil];


Whenever new location is available or authorisation status is changed you will be notified with the help of notification,

    -(void)locationAuthorizationStatus:(NSNotification*)authorizationStatus{
        
    }

    -(void)locationUpdated:(NSNotification*)locationUpdateNotification{
        
    }

##License

LocationHelper is under the MIT Licence:

Copyright (c) 2013 Jennis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
