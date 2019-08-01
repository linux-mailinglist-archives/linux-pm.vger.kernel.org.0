Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456CC7E360
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbfHATg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 15:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388609AbfHATg7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Aug 2019 15:36:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2139520838;
        Thu,  1 Aug 2019 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564688218;
        bh=lypMJbkrxUynjgnSEFuwofVmlVKCWiCa3c8E0G4VfEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hqnd451LmueSlcqobyaOj3Px3+5vctxxTbMIf2bZbHq6v8Cv8r4odS8S+vPi3lOtu
         bON5FfervHBjLsYYb+LSR3gwalIPBmPD2hwq9XZI1PVyx4pvgWMBb88KXBaDYJD1To
         whsURxIydlhyNIENR6hf6JH7TGu6ZUDx6DEbE96A=
Date:   Thu, 1 Aug 2019 21:36:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
Message-ID: <20190801193656.GB24916@kroah.com>
References: <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher>
 <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com>
 <5d423637.1c69fb81.62114.ca6f@mx.google.com>
 <CAJZ5v0jkLXwqmXwyYtdZ9X2=W2KNKS4Ok_NrDew2yvvt1=4pgQ@mail.gmail.com>
 <5d4305df.1c69fb81.c4013.1950@mx.google.com>
 <CAJZ5v0hDE908XcreUyzZ8JGjFJbgVX1N1ELeMwf+n_ENxPA_DA@mail.gmail.com>
 <5d433c91.1c69fb81.93f13.febc@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d433c91.1c69fb81.93f13.febc@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 01, 2019 at 12:25:04PM -0700, Stephen Boyd wrote:
> Quoting Rafael J. Wysocki (2019-08-01 10:21:44)
> > On Thu, Aug 1, 2019 at 5:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > BTW, paths in /sys/devices aren't supposed to matter too much. In this
> > > case, I'd expect to see userspace looking at the /sys/class/wakeup path
> > > to follow the symlink to figure out what device triggered a wakeup. It
> > > can look at the 'device' symlink inside the directory for the wakeup
> > > device to figure out which one it is.
> > 
> > But if you go from the device, it would be good to be able to figure
> > out which wakeup sources are associated with it and in the alarmtimer
> > example you don't even see that it is a wakeup source without
> > following the link.
> 
> Userspace shouldn't go from the device path (/sys/devices/.../rtc0 in
> this example). That's incorrect. Instead, userspace should go from the
> /sys/class/wakeup/... path. It should iterate over all the devices in
> the class path and look at the device pointers instead.
> 
> # ls /sys/class/wakeup/*/device -l
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/alarmtimer/device -> ../../rtc0
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup0/device -> ../../../a6f8800.usb
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup1/device -> ../../../a8f8800.usb
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup2/device -> ../../../cros-ec-rtc.1.auto
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup3/device -> ../../sbs-16-000b
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup4/device -> ../../../a88000.spi:ec@0:keyboard-controller
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup5/device -> ../../../spi10.0
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup6/device -> ../../../gpio-keys
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup7/device -> ../../../1-1.1
> lrwxrwxrwx. 1 root root 0 Aug  1 12:13 /sys/class/wakeup/wakeup8/device -> ../../../1-1.2.4.1
> 
> > 
> > So the "wakeupN" virtual dev names for all wakeup source objects are
> > less confusing IMO.
> > 
> > It would be good to avoid the glue dir creation in all cases somehow too.
> 
> I recall some differences between a bus_type and a class. Are you
> suggesting to use a bus_type for the wakeup sources? I like the class
> approach taken here to use different device names because it avoids the
> name collisions, avoids making another attribute to express the name of
> the wakeup source, and doesn't make a more heavyweight driver
> abstraction on top of wakeup sources.

This should be a class, as-is, not a bus type as these are all the same
type of "interface" for many different individual devices.

The difference between bus type and class is:
	- class is almost always how userspace sees the device, and cuts
	  across types of devices.  For example, a keyboard is a type of
	  an input device, and it can be a serial, PS/2, bluetooth, or
	  USB type of device.
	- a bus is a common type of devices usually at the hardware
	  level, where a driver is needed to send class-specific
	  commands down to a specific hardware device.  Busses have
	  drivers that bind a specific class to a specific device.
	  For example, there is a USB bus, and it has USB drivers for
	  things like a keyboard.  That USB keyboard driver knows how to
	  talk to the specific USB commands for the hardware and
	  translate them into specific input calls for the input class.

Hope this helps explain things better.

thanks,

greg k-h
