Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FFE31AB61
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 13:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBMMja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 07:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhBMMjZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Feb 2021 07:39:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50FBC64E43;
        Sat, 13 Feb 2021 12:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613219924;
        bh=o/zZqrT6O6iNIwheMyFEI2jvfg6vVZr9nbqaV+htoIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txF6bHj3jHmk4gL5sOVuT0ldolnX3VYX3sFEh4LrwrU1+F4hJWITuI3BK6TLmPX4i
         1l77sxrHhIUjd/uYPUUUWc16kNVseZQ/lNRnOLQYpbu90g/0ihX87LUQw25ma5kLM/
         KcuInp3QIDAlSQH6EI154VQQ99pQxZZUv/gCtNO0=
Date:   Sat, 13 Feb 2021 13:38:42 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saravanak@google.com" <saravanak@google.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Message-ID: <YCfIUliPU1No7SuN@kroah.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <YCfDAly9b0zHMpJT@kroah.com>
 <0bf56f1c5eb8262bd734ceb81fc832655253adc0.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf56f1c5eb8262bd734ceb81fc832655253adc0.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 13, 2021 at 12:26:59PM +0000, Vaittinen, Matti wrote:
> 
> On Sat, 2021-02-13 at 13:16 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Feb 13, 2021 at 01:58:44PM +0200, Matti Vaittinen wrote:
> > > A few drivers which need a delayed work-queue must cancel work at
> > > exit.
> > > Some of those implement remove solely for this purpose. Help
> > > drivers
> > > to avoid unnecessary remove and error-branch implementation by
> > > adding
> > > managed verision of delayed work initialization
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > 
> > That's not a good idea.  As this would kick in when the device is
> > removed from the system, not when it is unbound from the driver,
> > right?
> > 
> > > ---
> > >  drivers/base/devres.c  | 33 +++++++++++++++++++++++++++++++++
> > >  include/linux/device.h |  5 +++++
> > >  2 files changed, 38 insertions(+)
> > > 
> > > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > > index fb9d5289a620..2879595bb5a4 100644
> > > --- a/drivers/base/devres.c
> > > +++ b/drivers/base/devres.c
> > > @@ -1231,3 +1231,36 @@ void devm_free_percpu(struct device *dev,
> > > void __percpu *pdata)
> > >  			       (void *)pdata));
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_free_percpu);
> > > +
> > > +static void dev_delayed_work_drop(struct device *dev, void *res)
> > > +{
> > > +	cancel_delayed_work_sync(*(struct delayed_work **)res);
> > > +}
> > > +
> > > +/**
> > > + * devm_delayed_work_autocancel - Resource-managed work allocation
> > > + * @dev: Device which lifetime work is bound to
> > > + * @pdata: work to be cancelled when device exits
> > > + *
> > > + * Initialize work which is automatically cancelled when device
> > > exits.
> > 
> > There is no such thing in the driver model as "when device exits".
> > Please use the proper terminology as I do not understand what you
> > think
> > this is doing here...
> > 
> > > + * A few drivers need delayed work which must be cancelled before
> > > driver
> > > + * is unload to avoid accessing removed resources.
> > > + * devm_delayed_work_autocancel() can be used to omit the explicit
> > > + * cancelleation when driver is unload.
> > > + */
> > > +int devm_delayed_work_autocancel(struct device *dev, struct
> > > delayed_work *w,
> > > +				 void (*worker)(struct work_struct
> > > *work))
> > > +{
> > > +	struct delayed_work **ptr;
> > > +
> > > +	ptr = devres_alloc(dev_delayed_work_drop, sizeof(*ptr),
> > > GFP_KERNEL);
> > > +	if (!ptr)
> > > +		return -ENOMEM;
> > > +
> > > +	INIT_DELAYED_WORK(w, worker);
> > > +	*ptr = w;
> > > +	devres_add(dev, ptr);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_delayed_work_autocancel);
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 1779f90eeb4c..192456198de7 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/uidgid.h>
> > >  #include <linux/gfp.h>
> > >  #include <linux/overflow.h>
> > > +#include <linux/workqueue.h>
> > >  #include <linux/device/bus.h>
> > >  #include <linux/device/class.h>
> > >  #include <linux/device/driver.h>
> > > @@ -249,6 +250,10 @@ void __iomem *devm_of_iomap(struct device
> > > *dev,
> > >  			    struct device_node *node, int index,
> > >  			    resource_size_t *size);
> > >  
> > > +/* delayed work which is cancelled when driver exits */
> > 
> > Not when the "driver exits".
> > 
> > There is two different lifespans here (well 3).  Code and
> > data*2.  Don't
> > confuse them as that will just cause lots of problems.
> > 
> > The move toward more and more "devm" functions is not the way to go
> > as
> > they just more and more make things easier to get wrong.
> > 
> > APIs should be impossible to get wrong, this one is going to be
> > almost
> > impossible to get right.
> 
> Thanks for prompt reply. I guess I must've misunderstood some of this
> concept. Frankly to say, I don't understand how the devm based irq
> management works and this does not. Maybe I'd better study this further
> then.

The devm based irq management works horribly and should not be used at
all.  That is the main offender in the "an api that is impossible to use
correctly" category.

Honestly, I think it should just be removed as there is almost no real
need for it that I can determine, other than to cause bugs.

thanks,

greg k-h
