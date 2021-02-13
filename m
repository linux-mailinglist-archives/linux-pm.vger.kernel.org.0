Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35431ABDA
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhBMNee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 08:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhBMNeS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Feb 2021 08:34:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A1C264DDF;
        Sat, 13 Feb 2021 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613223213;
        bh=/0LJXrTVSCEWr3pkVyARQm3xVqOgM4H/owa2RIc6tJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uerP3uaunwq+zG20W7aTypbXj5gr7zF/rVnG7Dgri4obhymVxcNs+XmW7wQuVJva4
         5lrOteyz7Peh1MCyYHLUBBQGVyPlGPilqePtAfiqtG3+gshVd+4sMUpEvqLPNtWHY4
         SRBh7g73Yr/CckuvDKcltHQ9rSdCuyHdIloNe9aM=
Date:   Sat, 13 Feb 2021 14:33:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
Message-ID: <YCfVKyXbeJXNbMsd@kroah.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <YCfDAly9b0zHMpJT@kroah.com>
 <284d4a13-5cc8-e23c-7e99-c03db5415bf1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284d4a13-5cc8-e23c-7e99-c03db5415bf1@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 13, 2021 at 02:18:06PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/13/21 1:16 PM, Greg Kroah-Hartman wrote:
> > On Sat, Feb 13, 2021 at 01:58:44PM +0200, Matti Vaittinen wrote:
> >> A few drivers which need a delayed work-queue must cancel work at exit.
> >> Some of those implement remove solely for this purpose. Help drivers
> >> to avoid unnecessary remove and error-branch implementation by adding
> >> managed verision of delayed work initialization
> >>
> >> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > 
> > That's not a good idea.  As this would kick in when the device is
> > removed from the system, not when it is unbound from the driver, right?
> 
> Erm, no devm managed resources get released when the driver is detached:
> drivers/base/dd.c: __device_release_driver() calls devres_release_all(dev);

Then why do you have to manually call devm_free_irq() in release
callbacks?  I thought that was the primary problem with those things.

I can understand devm_ calls handling resources, but callbacks and
workqueues feels like a big stretch.

> > There is two different lifespans here (well 3).  Code and data*2.  Don't
> > confuse them as that will just cause lots of problems.
> > 
> > The move toward more and more "devm" functions is not the way to go as
> > they just more and more make things easier to get wrong.
> > 
> > APIs should be impossible to get wrong, this one is going to be almost
> > impossible to get right.
> 
> I have to disagree here devm generally makes it easier to get things right,
> it is when some devm functions are missing and devm and non devm resources
> are mixed that things get tricky.
> 
> Lets look for example at the drivers/extcon/extcon-intel-int3496.c code
> from patch 2/7 from this set. The removed driver-remove function looks like
> this:
> 
> -static int int3496_remove(struct platform_device *pdev)
> -{
> -	struct int3496_data *data = platform_get_drvdata(pdev);
> -
> -	devm_free_irq(&pdev->dev, data->usb_id_irq, data);
> -	cancel_delayed_work_sync(&data->work);
> -
> -	return 0;
> -}
> -
> 
> This is a good example where the mix of devm and non devm (the workqueue)
> resources makes things tricky. The IRQ must be freed first to avoid the
> work potentially getting re-queued after the sync cancel.
> 
> In this case using devm for the IRQ may cause the driver author to forget
> about this, leaving a race.
> 
> Bit with the new proposed devm_delayed_work_autocancel() function things
> will just work.
> 
> This work gets queued by the IRQ handler, so the work must be initialized (1)
> *before* devm_request_irq() gets called. Any different order would be a
> bug in the probe function since then the IRQ might run before the work
> is initialized.

How are we now going to audit the order of these calls to ensure that
this is done correctly?  That still feels like it is ripe for bugs in a
much easier way than without these functions.

> Since devm unrolls / releases resources in reverse order, this means that
> it will automatically free the IRQ (which was requested later) before
> cancelling the work.
> 
> So by switching to the new devm_delayed_work_autocancel() function we avoid
> a case where a driver author can cause a race on driver detach because it is
> relying on devm to free the IRQ, which may cause it to requeue a just
> cancelled work.
> 
> IOW introducing this function (and using it where appropriate) actually
> removes a possible class of bugs.
> 
> patch 2/7 actually has a nice example of this, drivers/extcon/extcon-gpio.c
> also uses a delayed work queued by an interrupt, together with devm managing
> the interrupt, yet the removed driver_remove callback:
> 
> -static int gpio_extcon_remove(struct platform_device *pdev)
> -{
> -	struct gpio_extcon_data *data = platform_get_drvdata(pdev);
> -
> -	cancel_delayed_work_sync(&data->work);
> -
> -	return 0;
> -}
> -
> 
> Is missing the explicit free on the IRQ which is necessary to avoid
> the race. One the one hand this illustrates your (Greg's) argument that
> devm managed IRQs may be a bad idea.

I still think it is :)

> OTOH it shows that if we have devm managed IRQs anyways that then also
> having devm managed autocancel works is a good idea, since this RFC patch-set
> not only results in some cleanup, but is actually fixing at least 1 driver
> detach race condition.

Fixing bugs is good, but the abstraction away from resource management
that the devm_ calls cause is worrying as the "magic" behind them can be
wrong, as seen here.

thanks,

greg k-h
