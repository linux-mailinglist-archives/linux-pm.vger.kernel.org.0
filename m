Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D7FAF43
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKMLE1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 06:04:27 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49749 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMLE1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 06:04:27 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 67b0217a63f9d45e; Wed, 13 Nov 2019 12:04:23 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/3] PM / Domains: Introduce dev_pm_domain_start()
Date:   Wed, 13 Nov 2019 12:04:23 +0100
Message-ID: <1794590.UXdaJiHv2O@kreacher>
In-Reply-To: <20191016131603.15784-1-ulf.hansson@linaro.org>
References: <20191016131603.15784-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 16, 2019 3:16:03 PM CET Ulf Hansson wrote:
> For a subsystem/driver that either doesn't support runtime PM or makes use
> of pm_runtime_set_active() during ->probe(), may try to access its device
> when probing, even if it may not be fully powered on from the PM domain's
> point of view. This may be the case when the used PM domain is a genpd
> provider, that implements genpd's ->start|stop() device callbacks.
> 
> There are cases where the subsystem/driver managed to avoid the above
> problem, simply by calling pm_runtime_enable() and pm_runtime_get_sync()
> during ->probe(). However, this approach comes with a drawback, especially
> if the subsystem/driver implements a ->runtime_resume() callback.
> 
> More precisely, the subsystem/driver then needs to use a device flag, which
> is checked in its ->runtime_resume() callback, as to avoid powering on its
> resources the first time the callback is invoked. This is needed because
> the subsystem/driver has already powered on the resources for the device,
> during ->probe() and before it called pm_runtime_get_sync().
> 
> In a way to avoid this boilerplate code and the inefficient check for "if
> (first_time_suspend)" in the ->runtime_resume() callback for these
> subsystems/drivers, let's introduce and export a dev_pm_domain_start()
> function, that may be called during ->probe() instead.
> 
> Moreover, let the dev_pm_domain_start() invoke an optional ->start()
> callback, added to the struct dev_pm_domain, as to allow a PM domain
> specific implementation.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/common.c | 20 ++++++++++++++++++++
>  include/linux/pm.h          |  2 ++
>  include/linux/pm_domain.h   |  5 +++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 8db98a1f83dc..bbddb267c2e6 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -187,6 +187,26 @@ void dev_pm_domain_detach(struct device *dev, bool power_off)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
>  
> +/**
> + * dev_pm_domain_start - Start the device through its PM domain.
> + * @dev: Device to start.
> + *
> + * This function should typically be called during probe by a subsystem/driver,
> + * when it needs to start its device from the PM domain's perspective. Note
> + * that, it's assumed that the PM domain is already powered on when this
> + * function is called.
> + *
> + * Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_domain_start(struct device *dev)
> +{
> +	if (dev->pm_domain && dev->pm_domain->start)
> +		return dev->pm_domain->start(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_domain_start);
> +
>  /**
>   * dev_pm_domain_set - Set PM domain of a device.
>   * @dev: Device whose PM domain is to be set.
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 4c441be03079..e057d1fa2469 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -637,6 +637,7 @@ extern void dev_pm_put_subsys_data(struct device *dev);
>   * struct dev_pm_domain - power management domain representation.
>   *
>   * @ops: Power management operations associated with this domain.
> + * @start: Called when a user needs to start the device via the domain.
>   * @detach: Called when removing a device from the domain.
>   * @activate: Called before executing probe routines for bus types and drivers.
>   * @sync: Called after successful driver probe.
> @@ -648,6 +649,7 @@ extern void dev_pm_put_subsys_data(struct device *dev);
>   */
>  struct dev_pm_domain {
>  	struct dev_pm_ops	ops;
> +	int (*start)(struct device *dev);
>  	void (*detach)(struct device *dev, bool power_off);
>  	int (*activate)(struct device *dev);
>  	void (*sync)(struct device *dev);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index baf02ff91a31..5a31c711b896 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -366,6 +366,7 @@ struct device *dev_pm_domain_attach_by_id(struct device *dev,
>  struct device *dev_pm_domain_attach_by_name(struct device *dev,
>  					    const char *name);
>  void dev_pm_domain_detach(struct device *dev, bool power_off);
> +int dev_pm_domain_start(struct device *dev);
>  void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
>  #else
>  static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
> @@ -383,6 +384,10 @@ static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
>  	return NULL;
>  }
>  static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
> +static inline int dev_pm_domain_start(struct device *dev)
> +{
> +	return 0;
> +}
>  static inline void dev_pm_domain_set(struct device *dev,
>  				     struct dev_pm_domain *pd) {}
>  #endif
> 

Applying this patch and the rest of the series for 5.5 (sorry for the delay).

Thanks!




