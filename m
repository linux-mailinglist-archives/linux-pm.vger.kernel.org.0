Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584D0195785
	for <lists+linux-pm@lfdr.de>; Fri, 27 Mar 2020 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgC0MwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Mar 2020 08:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgC0MwE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Mar 2020 08:52:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3817C206F2;
        Fri, 27 Mar 2020 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585313521;
        bh=1R/OBWOdSNz5r7LGZd/cYLoW69xw9FJJUFw/4OkIJUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbANr3YmQIhbFQq2kfIo/Zq6ustYafLqYhyd7/WPrBJsJMfnDA/uhw4xyduRmOyAq
         JxVTwa44Vw8b7RtDYTRVroueSPdl+gKkLNc9HLezS0Xe8r9Ek17YiajS3iJ+fd891W
         ois9aCNGfe7LPw7Awg+ALpd1liztW5iJ3pXDiFWs=
Date:   Fri, 27 Mar 2020 13:51:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grant Likely <grant.likely@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>, a.hajda@samsung.com,
        artem.bityutskiy@linux.intel.com, balbi@kernel.org,
        broonie@kernel.org, fntoth@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, peter.ujfalusi@ti.com, rafael@kernel.org,
        kernel-team@android.com, nd <nd@arm.com>
Subject: Re: [PATCH v3] driver core: Break infinite loop when deferred probe
 can't be satisfied
Message-ID: <20200327125158.GA1921196@kroah.com>
References: <20200324175719.62496-1-andriy.shevchenko@linux.intel.com>
 <20200325032901.29551-1-saravanak@google.com>
 <20200325125120.GX1922688@smile.fi.intel.com>
 <295d25de-f01e-26de-02d6-1ac0c149d828@arm.com>
 <20200326163110.GD1922688@smile.fi.intel.com>
 <20200326163953.GA1551380@kroah.com>
 <9350ec52-345f-5c3c-f175-4e256699b9cf@arm.com>
 <20200327080323.GA1627562@kroah.com>
 <291a6afb-75b1-0717-d8d0-577f8f3d77da@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <291a6afb-75b1-0717-d8d0-577f8f3d77da@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 27, 2020 at 12:37:54PM +0000, Grant Likely wrote:
> 
> 
> On 27/03/2020 08:03, Greg KH wrote:
> > On Thu, Mar 26, 2020 at 06:06:37PM +0000, Grant Likely wrote:
> > > 
> > > 
> > > On 26/03/2020 16:39, Greg KH wrote:
> > > > On Thu, Mar 26, 2020 at 06:31:10PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Mar 26, 2020 at 03:01:22PM +0000, Grant Likely wrote:
> > > > > > On 25/03/2020 12:51, Andy Shevchenko wrote:
> > > > > > > On Tue, Mar 24, 2020 at 08:29:01PM -0700, Saravana Kannan wrote:
> > > > > > > > On Tue, Mar 24, 2020 at 5:38 AM Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > Consider the following scenario.
> > > > > > > > > 
> > > > > > > > > The main driver of USB OTG controller (dwc3-pci), which has the following
> > > > > > > > > functional dependencies on certain platform:
> > > > > > > > > - ULPI (tusb1210)
> > > > > > > > > - extcon (tested with extcon-intel-mrfld)
> > > > > > > > > 
> > > > > > > > > Note, that first driver, tusb1210, is available at the moment of
> > > > > > > > > dwc3-pci probing, while extcon-intel-mrfld is built as a module and
> > > > > > > > > won't appear till user space does something about it.
> > > > > > > > > 
> > > > > > > > > This is depicted by kernel configuration excerpt:
> > > > > > > > > 
> > > > > > > > > 	CONFIG_PHY_TUSB1210=y
> > > > > > > > > 	CONFIG_USB_DWC3=y
> > > > > > > > > 	CONFIG_USB_DWC3_ULPI=y
> > > > > > > > > 	CONFIG_USB_DWC3_DUAL_ROLE=y
> > > > > > > > > 	CONFIG_USB_DWC3_PCI=y
> > > > > > > > > 	CONFIG_EXTCON_INTEL_MRFLD=m
> > > > > > > > > 
> > > > > > > > > In the Buildroot environment the modules are probed by alphabetical ordering
> > > > > > > > > of their modaliases. The latter comes to the case when USB OTG driver will be
> > > > > > > > > probed first followed by extcon one.
> > > > > > > > > 
> > > > > > > > > So, if the platform anticipates extcon device to be appeared, in the above case
> > > > > > > > > we will get deferred probe of USB OTG, because of ordering.
> > > > > > > > > 
> > > > > > > > > Since current implementation, done by the commit 58b116bce136 ("drivercore:
> > > > > > > > > deferral race condition fix") counts the amount of triggered deferred probe,
> > > > > > > > > we never advance the situation -- the change makes it to be an infinite loop.
> > > > > > > > 
> > > > > > > > Hi Andy,
> > > > > > > > 
> > > > > > > > I'm trying to understand this sequence of steps. Sorry if the questions
> > > > > > > > are stupid -- I'm not very familiar with USB/PCI stuff.
> > > > > > > 
> > > > > > > Thank you for looking into this. My answer below.
> > > > > > > 
> > > > > > > As a first thing I would like to tell that there is another example of bad
> > > > > > > behaviour of deferred probe with no relation to USB. The proposed change also
> > > > > > > fixes that one (however, less possible to find in real life).
> > > > > > > 
> > > > > > > > > ---8<---8<---
> > > > > > > > > 
> > > > > > > > > [   22.187127] driver_deferred_probe_trigger <<< 1
> > > > > > > > > 
> > > > > > > > > ...here is the late initcall triggers deferred probe...
> > > > > > > > > 
> > > > > > > > > [   22.191725] platform dwc3.0.auto: deferred_probe_work_func in deferred list
> > > > > > > > > 
> > > > > > > > > ...dwc3.0.auto is the only device in the deferred list...
> > > > > > > > 
> > > > > > > > Ok, dwc3.0.auto is the only unprobed device at this point?
> > > > > > > 
> > > > > > > Correct.
> > > > > > > 
> > > > > > > > > [   22.198727] platform dwc3.0.auto: deferred_probe_work_func 1 <<< counter 1
> > > > > > > > > 
> > > > > > > > > ...the counter before mutex is unlocked is kept the same...
> > > > > > > > > 
> > > > > > > > > [   22.205663] platform dwc3.0.auto: Retrying from deferred list
> > > > > > > > > 
> > > > > > > > > ...mutes has been unlocked, we try to re-probe the driver...
> > > > > > > > > 
> > > > > > > > > [   22.211487] bus: 'platform': driver_probe_device: matched device dwc3.0.auto with driver dwc3
> > > > > > > > > [   22.220060] bus: 'platform': really_probe: probing driver dwc3 with device dwc3.0.auto
> > > > > > > > > [   22.238735] bus: 'ulpi': driver_probe_device: matched device dwc3.0.auto.ulpi with driver tusb1210
> > > > > > > > > [   22.247743] bus: 'ulpi': really_probe: probing driver tusb1210 with device dwc3.0.auto.ulpi
> > > > > > > > > [   22.256292] driver: 'tusb1210': driver_bound: bound to device 'dwc3.0.auto.ulpi'
> > > > > > > > > [   22.263723] driver_deferred_probe_trigger <<< 2
> > > > > > > > > 
> > > > > > > > > ...the dwc3.0.auto probes ULPI, we got successful bound and bumped counter...
> > > > > > > > > 
> > > > > > > > > [   22.268304] bus: 'ulpi': really_probe: bound device dwc3.0.auto.ulpi to driver tusb1210
> > > > > > > > 
> > > > > > > > So where did this dwc3.0.auto.ulpi come from?
> > > > > > > 
> > > > > > > > Looks like the device is created by dwc3_probe() through this call flow:
> > > > > > > > dwc3_probe() -> dwc3_core_init() -> dwc3_core_ulpi_init() ->
> > > > > > > > dwc3_ulpi_init() -> ulpi_register_interface() -> ulpi_register()
> > > > > > > 
> > > > > > > Correct.
> > > > > > > 
> > > > > > > > > [   22.276697] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > > > > > > > 
> > > > > > > > Can you please point me to which code patch actually caused the probe
> > > > > > > > deferral?
> > > > > > > 
> > > > > > > Sure, it's in drd.c.
> > > > > > > 
> > > > > > > if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > > > > > >      edev = extcon_get_extcon_dev(name);
> > > > > > >      if (!edev)
> > > > > > >        return ERR_PTR(-EPROBE_DEFER);
> > > > > > >      return edev;
> > > > > > > }
> > > > > > > 
> > > > > > > > > ...but extcon driver is still missing...
> > > > > > > > > 
> > > > > > > > > [   22.283174] platform dwc3.0.auto: Added to deferred list
> > > > > > > > > [   22.288513] platform dwc3.0.auto: driver_deferred_probe_add_trigger local counter: 1 new counter 2
> > > > > > > > 
> > > > > > > > I'm not fully aware of all the USB implications, but if extcon is
> > > > > > > > needed, why can't that check be done before we add and probe the ulpi
> > > > > > > > device? That'll avoid this whole "fake" probing and avoid the counter
> > > > > > > > increase. And avoid the need for this patch that's touching the code
> > > > > > > > code that's already a bit delicate.
> > > > > > > 
> > > > > > > > Also, with my limited experience with all the possible drivers in the
> > > > > > > > kernel, it's weird that the ulpi device is added and probed before we
> > > > > > > > make sure the parent device (dwc3.0.auto) can actually probe
> > > > > > > > successfully.
> > > > > > > 
> > > > > > > As I said above the deferred probe trigger has flaw on its own.
> > > > > > > Even if we fix for USB case, there is (and probably will be) others.
> > > > > > 
> > > > > > Right here is the driver design bug. A driver's probe() hook should *not*
> > > > > > return -EPROBE_DEFER after already creating child devices which may have
> > > > > > already been probed.
> > > > > 
> > > > > Any documentation statement for this requirement?
> > > > 
> > > > There shouldn't be.  If you return ANY error from a probe function, your
> > > > driver is essencially "dead" when it comes to that device, and it had
> > > > better have cleaned up after itself. >
> > > > That includes defering probe, that's not "special" here at all.
> > > 
> > > What is special in this case is that if a .probe() hook had registered a
> > > child device, then removed that child device (so it did clean up after
> > > itself) and then return -EPROBE_DEFER, then we end up in an endless probe
> > > loop.
> > 
> > If all child devices really are cleaned up completly, why would this be
> > a problem?  What is set internally in the driver core that would get
> > tripped up by this?
> > 
> > > But this is unusual behaviour. Normally a .probe() hook checks all required
> > > resources are available before registering any child devices. This driver
> > > doesn't do that. Arguably this is indeed an additional requirement beyond
> > > "clean up after yourself". I cannot find anyplace where it is documented. In
> > > fact, I cannot find any documentation on EPROBE_DEFER in the Documentation/
> > > tree. How about the below?
> > > 
> > > > > By the way, I may imagine other mechanisms that probe the driver on other CPU
> > > > > at the same time (let's consider parallel modprobes). The current code has a
> > > > > flaw with that.
> > > > 
> > > > That can't happen, the driver core prevents that.
> > > 
> > > Greg's right, that can't happen. At worst a driver will get an additional
> > > defer event; but it all still works.
> > > 
> > > g.
> > > 
> > > ---
> > > diff --git a/Documentation/driver-api/driver-model/driver.rst
> > > b/Documentation/driver-api/driver-model/driver.rst
> > > index baa6a85c8287..46adede13aba 100644
> > > --- a/Documentation/driver-api/driver-model/driver.rst
> > > +++ b/Documentation/driver-api/driver-model/driver.rst
> > > @@ -167,7 +167,17 @@ the driver to that device.
> > > 
> > >   A driver's probe() may return a negative errno value to indicate that
> > >   the driver did not bind to this device, in which case it should have
> > > -released all resources it allocated::
> > > +released all resources it allocated. Optionally, probe() may return
> > > +-EPROBE_DEFER if the driver depends on resources that are not yet
> > > +available (e.g., supplied by a driver that hasn't initialized yet).
> > > +The driver core will put the device onto the deferred probe list and
> > > +will try to call it again later. Important: -EPROBE_DEFER must not be
> > > +returned if probe() has already created child devices, even if those
> > > +child devices have were removed again in a cleanup path. If -EPROBE_DEFER
> > > +is returned after a child device has been registered, it may result in an
> > > +infinite loop of .probe() calls to the same driver.
> > 
> > Ok, this is a bug, if that is the case, in the driver core as it should
> > not matter how many devices were added/removed/whatever while a driver
> > is in it's probe function.
> Fair enough, call it a bug. However, the solution proposed so far is broken,
> and I've not seen or been able to come up with an approach without adding
> significant complexity to driver core.
> 
> Alternately, highlighting the limitation that EPROBE_DEFER can only be used
> before the device gets to the point of registering child devices is simple,
> only affects a few drivers, and matches the best practice of if a driver
> needs to defer, it should do so *as soon as possible* to avoid work needing
> to be unwound multiple times, which reduces boot time delays.

Agreed.

> > But, I don't see how this patch solves that problem, another probe call
> > should never be made for the same bus while in this probe function.  If
> > we do:
> > 	device1->probe()
> > 		device1 creates device2 and registers it
> > 			device2->probe is called
> > 			device2->probe returns 0
> > 		device1 has problems, unregisters device2
> > 			device2->remove is called
> > 		device1 deletes device2
> > 		device1 returns -EPROBE_DEFER
> > 
> > So then where's the problem?  Did device2 somehow not really get
> > properly cleaned up?
> 
> Using the above sequence with a couple of annotations
> 
>  	device1->probe()
>  		device1 creates device2 and registers it
>  			device2->probe is called
>  			device2->probe returns 0
>                        *Driver Core increments probe_count
> 				(drivers/base/dd.c:516)
>  		device1 has problems, unregisters device2
>  			device2->remove is called
>  		device1 deletes device2
>  		device1 returns -EPROBE_DEFER
>       *Driver core notices that probe_count got incremented since
> device1->probe() call started; therefore it is possible that the required
> resource is now available, so try calling device1->probe() again.

Ah, that makes more sense now, thanks.

And yes, this specific patch doesn't seem to solve that problem, so I'll
be glad to take the documentation upate that says "do not do this" :)

thanks,

greg k-h
