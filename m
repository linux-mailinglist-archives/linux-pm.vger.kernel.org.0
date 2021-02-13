Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58E31AB3F
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 13:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBMMQt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 07:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhBMMQs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Feb 2021 07:16:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAE7864DD6;
        Sat, 13 Feb 2021 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613218567;
        bh=4xFxyQXalGrldKkL8r7xY5JedLCnGKpV3hkcAB/m1wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P1CMoTjyFG+N6rtSr9mS6CNFYhgNtCzBL8hhnGR+JH2R7vCweELe4lRrbbVp6RPiN
         en8N4dDDqTgnZnQzGSQYwxOSm6ZS746+QT/AOxTto/0mhC5yLC163HMYpnUPGWDmdT
         +Rd5L3vt5ecVTsaxeRi5phB99KKthyXaLvTdZ5ig=
Date:   Sat, 13 Feb 2021 13:16:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <YCfDAly9b0zHMpJT@kroah.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 13, 2021 at 01:58:44PM +0200, Matti Vaittinen wrote:
> A few drivers which need a delayed work-queue must cancel work at exit.
> Some of those implement remove solely for this purpose. Help drivers
> to avoid unnecessary remove and error-branch implementation by adding
> managed verision of delayed work initialization
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

That's not a good idea.  As this would kick in when the device is
removed from the system, not when it is unbound from the driver, right?

> ---
>  drivers/base/devres.c  | 33 +++++++++++++++++++++++++++++++++
>  include/linux/device.h |  5 +++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index fb9d5289a620..2879595bb5a4 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -1231,3 +1231,36 @@ void devm_free_percpu(struct device *dev, void __percpu *pdata)
>  			       (void *)pdata));
>  }
>  EXPORT_SYMBOL_GPL(devm_free_percpu);
> +
> +static void dev_delayed_work_drop(struct device *dev, void *res)
> +{
> +	cancel_delayed_work_sync(*(struct delayed_work **)res);
> +}
> +
> +/**
> + * devm_delayed_work_autocancel - Resource-managed work allocation
> + * @dev: Device which lifetime work is bound to
> + * @pdata: work to be cancelled when device exits
> + *
> + * Initialize work which is automatically cancelled when device exits.

There is no such thing in the driver model as "when device exits".
Please use the proper terminology as I do not understand what you think
this is doing here...

> + * A few drivers need delayed work which must be cancelled before driver
> + * is unload to avoid accessing removed resources.
> + * devm_delayed_work_autocancel() can be used to omit the explicit
> + * cancelleation when driver is unload.
> + */
> +int devm_delayed_work_autocancel(struct device *dev, struct delayed_work *w,
> +				 void (*worker)(struct work_struct *work))
> +{
> +	struct delayed_work **ptr;
> +
> +	ptr = devres_alloc(dev_delayed_work_drop, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(w, worker);
> +	*ptr = w;
> +	devres_add(dev, ptr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_delayed_work_autocancel);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1779f90eeb4c..192456198de7 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -27,6 +27,7 @@
>  #include <linux/uidgid.h>
>  #include <linux/gfp.h>
>  #include <linux/overflow.h>
> +#include <linux/workqueue.h>
>  #include <linux/device/bus.h>
>  #include <linux/device/class.h>
>  #include <linux/device/driver.h>
> @@ -249,6 +250,10 @@ void __iomem *devm_of_iomap(struct device *dev,
>  			    struct device_node *node, int index,
>  			    resource_size_t *size);
>  
> +/* delayed work which is cancelled when driver exits */

Not when the "driver exits".

There is two different lifespans here (well 3).  Code and data*2.  Don't
confuse them as that will just cause lots of problems.

The move toward more and more "devm" functions is not the way to go as
they just more and more make things easier to get wrong.

APIs should be impossible to get wrong, this one is going to be almost
impossible to get right.

thanks,

greg k-h
