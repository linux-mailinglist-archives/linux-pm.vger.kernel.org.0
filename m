Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A85F2C7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 08:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfGDGZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 02:25:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfGDGZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jul 2019 02:25:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D913F60388; Thu,  4 Jul 2019 06:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562221530;
        bh=xkAUg2OUHV+GwWXOlO7P+klLeg44/63IPVz6IQV2vxc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X1M1C9iK4LEittuCZfRIY7XqMpo9bvyua4Iu21+zxoxNQXY5k6hk8G0obMuRcbWuE
         GIZkSZeejHBbKGUa81lYZLXS9qF0pwQu67pL4swF96F6qKHMj67l0KqMVB9LOlOrPb
         S9rZ+zvSCugJOkzcQRQzIgzJKqwtIUQ2UDe7RGek=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.141] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E6F4B602EE;
        Thu,  4 Jul 2019 06:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562221529;
        bh=xkAUg2OUHV+GwWXOlO7P+klLeg44/63IPVz6IQV2vxc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G1OKQrTeKjebKqnrs2/KkC1KkIpWeitaKP2GSiQhBiGQzqPIysFaIcM1YE0d3wDPC
         srC+82/jcqIFtmUVBgL8CpSodcTCOVJ6fNSr+PFN+IMV62L6FlI548hzuCdSXpCYS6
         zdkeFWBzZdk54UR1OM0ZhYcVsz70PPg5O1BOhy70=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6F4B602EE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] opp: Attach genpds to devices from within OPP core
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
References: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <aee8dc78-e292-a671-3dc5-ca962c0eec6b@codeaurora.org>
Date:   Thu, 4 Jul 2019 11:55:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/13/2019 3:54 PM, Viresh Kumar wrote:
> The OPP core requires the virtual device pointers to set performance
> state on behalf of the device, for the multiple power domain case. The
> genpd API (dev_pm_domain_attach_by_name()) has evolved now to support
> even the single power domain case and that lets us add common code for
> handling both the cases more efficiently.
> 
> The virtual device structure returned by dev_pm_domain_attach_by_name()
> isn't normally used by the cpufreq drivers as they don't manage power
> on/off of the domains and so is only useful for the OPP core.

This might be true for CPUs but not necessarily so for IO devices which might
want to set up device links so the devices runtime pm calls can trigger the
on/off of the power domain. Is there a way to handle that case now?

> 
> This patch moves all the complexity into the OPP core to make the end
> drivers simple. The earlier APIs dev_pm_opp_{set|put}_genpd_virt_dev()
> are reworked into dev_pm_opp_{attach|detach}_genpd(). The new helper
> dev_pm_opp_attach_genpd() accepts a NULL terminated array of strings
> which contains names of all the genpd's to attach. It then attaches all
> the domains and saves the pointers to the virtual devices. The other
> helper undo the work done by this helper.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Niklas: Can you please try these patches and confirm they solve the
> issues you were facing ?
> 
>   drivers/opp/core.c     | 128 ++++++++++++++++++++++++++---------------
>   include/linux/pm_opp.h |   8 +--
>   2 files changed, 86 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..67d6b0caeab1 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1744,91 +1744,127 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
>   }
>   EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
>   
> +static void _opp_detach_genpd(struct opp_table *opp_table)
> +{
> +	int index;
> +
> +	for (index = 0; index < opp_table->required_opp_count; index++) {
> +		if (!opp_table->genpd_virt_devs[index])
> +			continue;
> +
> +		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
> +		opp_table->genpd_virt_devs[index] = NULL;
> +	}
> +}
> +
>   /**
> - * dev_pm_opp_set_genpd_virt_dev - Set virtual genpd device for an index
> - * @dev: Consumer device for which the genpd device is getting set.
> - * @virt_dev: virtual genpd device.
> - * @index: index.
> + * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
> + * @dev: Consumer device for which the genpd is getting attached.
> + * @names: Null terminated array of pointers containing names of genpd to attach.
>    *
>    * Multiple generic power domains for a device are supported with the help of
>    * virtual genpd devices, which are created for each consumer device - genpd
>    * pair. These are the device structures which are attached to the power domain
>    * and are required by the OPP core to set the performance state of the genpd.
> + * The same API also works for the case where single genpd is available and so
> + * we don't need to support that separately.
>    *
>    * This helper will normally be called by the consumer driver of the device
> - * "dev", as only that has details of the genpd devices.
> + * "dev", as only that has details of the genpd names.
>    *
> - * This helper needs to be called once for each of those virtual devices, but
> - * only if multiple domains are available for a device. Otherwise the original
> - * device structure will be used instead by the OPP core.
> + * This helper needs to be called once with a list of all genpd to attach.
> + * Otherwise the original device structure will be used instead by the OPP core.
>    */
> -struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev,
> -						struct device *virt_dev,
> -						int index)
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
>   {
>   	struct opp_table *opp_table;
> +	struct device *virt_dev;
> +	int index, ret = -EINVAL;
> +	const char **name = names;
>   
>   	opp_table = dev_pm_opp_get_opp_table(dev);
>   	if (!opp_table)
>   		return ERR_PTR(-ENOMEM);
>   
> +	/*
> +	 * If the genpd's OPP table isn't already initialized, parsing of the
> +	 * required-opps fail for dev. We should retry this after genpd's OPP
> +	 * table is added.
> +	 */
> +	if (!opp_table->required_opp_count) {
> +		ret = -EPROBE_DEFER;
> +		goto put_table;
> +	}
> +
>   	mutex_lock(&opp_table->genpd_virt_dev_lock);
>   
> -	if (unlikely(!opp_table->genpd_virt_devs ||
> -		     index >= opp_table->required_opp_count ||
> -		     opp_table->genpd_virt_devs[index])) {
> +	while (*name) {
> +		index = of_property_match_string(dev->of_node,
> +						 "power-domain-names", *name);
> +		if (index < 0) {
> +			dev_err(dev, "Failed to find power domain: %s (%d)\n",
> +				*name, index);
> +			goto err;
> +		}
>   
> -		dev_err(dev, "Invalid request to set required device\n");
> -		dev_pm_opp_put_opp_table(opp_table);
> -		mutex_unlock(&opp_table->genpd_virt_dev_lock);
> +		if (index >= opp_table->required_opp_count) {
> +			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
> +				*name, opp_table->required_opp_count, index);
> +			goto err;
> +		}
>   
> -		return ERR_PTR(-EINVAL);
> +		if (opp_table->genpd_virt_devs[index]) {
> +			dev_err(dev, "Genpd virtual device already set %s\n",
> +				*name);
> +			goto err;
> +		}
> +
> +		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
> +		if (IS_ERR(virt_dev)) {
> +			ret = PTR_ERR(virt_dev);
> +			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
> +			goto err;
> +		}
> +
> +		opp_table->genpd_virt_devs[index] = virt_dev;
> +		name++;
>   	}
>   
> -	opp_table->genpd_virt_devs[index] = virt_dev;
>   	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>   
>   	return opp_table;
> +
> +err:
> +	_opp_detach_genpd(opp_table);
> +	mutex_unlock(&opp_table->genpd_virt_dev_lock);
> +
> +put_table:
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return ERR_PTR(ret);
>   }
> +EXPORT_SYMBOL_GPL(dev_pm_opp_attach_genpd);
>   
>   /**
> - * dev_pm_opp_put_genpd_virt_dev() - Releases resources blocked for genpd device.
> - * @opp_table: OPP table returned by dev_pm_opp_set_genpd_virt_dev().
> - * @virt_dev: virtual genpd device.
> - *
> - * This releases the resource previously acquired with a call to
> - * dev_pm_opp_set_genpd_virt_dev(). The consumer driver shall call this helper
> - * if it doesn't want OPP core to update performance state of a power domain
> - * anymore.
> + * dev_pm_opp_detach_genpd() - Detach genpd(s) from the device.
> + * @opp_table: OPP table returned by dev_pm_opp_attach_genpd().
> + *
> + * This detaches the genpd(s), resets the virtual device pointers, and puts the
> + * OPP table.
>    */
> -void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
> -				   struct device *virt_dev)
> +void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
>   {
> -	int i;
> -
>   	/*
>   	 * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
>   	 * used in parallel.
>   	 */
>   	mutex_lock(&opp_table->genpd_virt_dev_lock);
> -
> -	for (i = 0; i < opp_table->required_opp_count; i++) {
> -		if (opp_table->genpd_virt_devs[i] != virt_dev)
> -			continue;
> -
> -		opp_table->genpd_virt_devs[i] = NULL;
> -		dev_pm_opp_put_opp_table(opp_table);
> -
> -		/* Drop the vote */
> -		dev_pm_genpd_set_performance_state(virt_dev, 0);
> -		break;
> -	}
> -
> +	_opp_detach_genpd(opp_table);
>   	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>   
> -	if (unlikely(i == opp_table->required_opp_count))
> -		dev_err(virt_dev, "Failed to find required device entry\n");
> +	dev_pm_opp_put_opp_table(opp_table);
>   }
> +EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
>   
>   /**
>    * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index b150fe97ce5a..be570761b77a 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -131,8 +131,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>   void dev_pm_opp_put_clkname(struct opp_table *opp_table);
>   struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>   void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> -struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
> -void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
> +void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
>   int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>   int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>   int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
> @@ -295,12 +295,12 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
>   
>   static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
>   
> -static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index)
> +static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
>   {
>   	return ERR_PTR(-ENOTSUPP);
>   }
>   
> -static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
> +static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
>   
>   static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
>   {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
