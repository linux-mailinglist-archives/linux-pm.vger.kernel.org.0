Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090A5FAF46
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 12:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfKMLF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 06:05:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47543 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMLF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 06:05:56 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 6c433e02a7a76a3d; Wed, 13 Nov 2019 12:05:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Convert to dev_to_genpd_safe() in genpd_syscore_switch()
Date:   Wed, 13 Nov 2019 12:05:53 +0100
Message-ID: <2599983.gEBnMgVu9Q@kreacher>
In-Reply-To: <20191016141649.18690-1-ulf.hansson@linaro.org>
References: <20191016141649.18690-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 16, 2019 4:16:49 PM CET Ulf Hansson wrote:
> The intent with walking the gpd_list via calling genpd_present() from
> genpd_syscore_switch(), is to make sure the dev->pm_domain pointer belongs
> to a registered genpd. However, as a genpd can't be removed if there is a
> device attached to it, let's convert to use the quicker dev_to_genpd_safe()
> instead.
> 
> Due to the above change, this allows us to cleanup genpd_present() and move
> it inside CONFIG_PM_GENERIC_DOMAINS_OF, so let's do that as well.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index cc85e87eaf05..600ea78d6b71 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -922,24 +922,6 @@ static int __init genpd_power_off_unused(void)
>  }
>  late_initcall(genpd_power_off_unused);
>  
> -#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
> -
> -static bool genpd_present(const struct generic_pm_domain *genpd)
> -{
> -	const struct generic_pm_domain *gpd;
> -
> -	if (IS_ERR_OR_NULL(genpd))
> -		return false;
> -
> -	list_for_each_entry(gpd, &gpd_list, gpd_list_node)
> -		if (gpd == genpd)
> -			return true;
> -
> -	return false;
> -}
> -
> -#endif
> -
>  #ifdef CONFIG_PM_SLEEP
>  
>  /**
> @@ -1354,8 +1336,8 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
>  {
>  	struct generic_pm_domain *genpd;
>  
> -	genpd = dev_to_genpd(dev);
> -	if (!genpd_present(genpd))
> +	genpd = dev_to_genpd_safe(dev);
> +	if (!genpd)
>  		return;
>  
>  	if (suspend) {
> @@ -2020,6 +2002,16 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>  	return 0;
>  }
>  
> +static bool genpd_present(const struct generic_pm_domain *genpd)
> +{
> +	const struct generic_pm_domain *gpd;
> +
> +	list_for_each_entry(gpd, &gpd_list, gpd_list_node)
> +		if (gpd == genpd)
> +			return true;
> +	return false;
> +}
> +
>  /**
>   * of_genpd_add_provider_simple() - Register a simple PM domain provider
>   * @np: Device node pointer associated with the PM domain provider.
> 

Applying as 5.5 material, thanks!



