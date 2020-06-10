Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660AB1F5706
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFJOwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 10:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgFJOwg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jun 2020 10:52:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EDDE2072F;
        Wed, 10 Jun 2020 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591800756;
        bh=oS+UZVB/AkABps8121WWQrCyjlNmIIcN5+h0Ejd3dRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1IuhvU/rIncjUJFKPZ6Al50zu71QYKuAQ/4thw02tx+wCYKe8g/lRBDY+o1L6e9Jc
         9iLqSMc+IDLmPvx80klg7Xs5WG/gT9ClewSBw6M4l9MXLpTk4HZehf8RBMgVyEvKLK
         aLfD1xrCpN/NkIMW7WE8q0vCQo5XazyfzC/scJd8=
Date:   Wed, 10 Jun 2020 16:52:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gustav Wiklander <gustav.wiklander@axis.com>
Cc:     linux-pm@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        kernel@axis.com, Gustav Wiklander <gustavwi@axis.com>
Subject: Re: [PATCH] PM / Domains: Add module ref count for each consumer
Message-ID: <20200610145229.GA2101163@kroah.com>
References: <20200610143943.12548-1-gustav.wiklander@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610143943.12548-1-gustav.wiklander@axis.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 10, 2020 at 04:39:43PM +0200, Gustav Wiklander wrote:
> From: Gustav Wiklander <gustavwi@axis.com>
> 
> Currently a pm_domain can be unloaded without regard for consumers.
> This patch adds a module dependecy for every registered consumer.
> Now a power domain driver can only be unloaded if no consumers are
> registered.

What is the problem with doing this?  Shouldn't when a power domain is
unregistered, the consumers are properly torn down?  Some subsystems
allow you to unload a module at any point in time, and properly clean
things up.  What is the problem today that you are trying to solve with
this (remember, removing modules only happens by developers, no
real-world system ever automatically onloads a module.)


> 
> Signed-off-by: Gustav Wiklander <gustavwi@axis.com>
> ---
>  drivers/base/power/domain.c | 11 ++++++++++-
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0a01df608849..80723f6d5e6b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1499,11 +1499,18 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  	if (IS_ERR(gpd_data))
>  		return PTR_ERR(gpd_data);
>  
> +	if (!try_module_get(genpd->owner)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
>  	gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
>  
>  	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
> -	if (ret)
> +	if (ret) {
> +		module_put(genpd->owner);
>  		goto out;
> +	}
>  
>  	genpd_lock(genpd);
>  
> @@ -1579,6 +1586,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
>  
>  	genpd_free_dev_data(dev, gpd_data);
>  
> +	module_put(genpd->owner);
> +
>  	return 0;
>  
>   out:
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ec78ee53652..777c1b30e5af 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -9,6 +9,7 @@
>  #define _LINUX_PM_DOMAIN_H
>  
>  #include <linux/device.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/err.h>
> @@ -93,6 +94,7 @@ struct opp_table;
>  
>  struct generic_pm_domain {
>  	struct device dev;
> +	struct module *owner;		/* Module owner of the PM domain */

But you did not actually set the owner field anywhere :(

Make this an automatic thing, look how functions like
usb_register_driver() and friends to it so that you do not have to go
around and try to add it by hand to every driver.  And then go back in a
year and fix up the remaining ones you missed.  And then in another
year...

thanks,

greg k-h
