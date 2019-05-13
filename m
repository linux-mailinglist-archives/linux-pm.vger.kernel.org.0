Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9491B47F
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfEMLFB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 07:05:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44299 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfEMLFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 07:05:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so8690903lfn.11
        for <linux-pm@vger.kernel.org>; Mon, 13 May 2019 04:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w2aTyEsXXgINm2iYMe46jgXNAvwErCJxVhYOHAxTxdo=;
        b=yBGfuqfbMQCgliD3wrwLr0hRmquM17EiaCWALz55OZq2LazOK4J8mGJHgA9BHpG37o
         C9Cz/2srCGZavEySCc9oN1Tse8QXYoY1ZroK7Q10fM1vMlQ2ujkmBKbzFwHa1KfQAIAT
         dz6PAVz5H69b3CIdLazCnxdMAOkvyHPYMxYMUR8aVPPFsN2Yva/MizMQpXoY1vrxpfUz
         /72AscVlBx+6VR8t+ErrWdF0PpwwNQGOFYsClg+SRCmlg3qMbGrKVsZclI/jAfmOnsEe
         NqvimiurAy0g72vO+wS30gyCeFbC5XQNoBa4cVQ64r2LnEZIdgqHeAZgfPz4givjqE7D
         I4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w2aTyEsXXgINm2iYMe46jgXNAvwErCJxVhYOHAxTxdo=;
        b=nuBAg2PKpPqBpWg3vUh+khHee1iwtqwIInrO56cDDEahJPIveb4gaIXTuM8FlSvPbM
         4VYxYUDbbI5CRUuJePTf+WqOd83wU2/NszpbD9pN4Z92wgZ1cEJJJtS1WnD+tY48qwvM
         zoi7MEIU9x2KjmAep+steNssRTUlxeaZ2A4/cd4xniaPGWNjeVVmmsoP3Ia+zgUc3xjf
         H5BI+P5icZWtjd5TGx9nnh8FM0nFrTBZz7XS/j/dPVgErXUjmckRChEP4UHyRjYbzn/W
         /B3mSAZhf4+gEpgHXT2Iz6P2bQ1qs5edqJlwV53JLYsBjdBSyTcY277/Aayqi+hvyb6I
         8v8Q==
X-Gm-Message-State: APjAAAVTwwBaF0/3N9YUYnooJV75QAZQ6JYpzxoJt28FaUC7aRmCGovV
        vJzW5XYSDWrjIRJK396BL8vzadVDwIg=
X-Google-Smtp-Source: APXvYqzKHIY0n6oJU69DxP9sS/vxMtid7YQ/TJkM4OxmIj2byuy3/l0p2e9OHHD6mBNrsU9Q6F/8Lw==
X-Received: by 2002:ac2:4217:: with SMTP id y23mr13153081lfh.134.1557745498257;
        Mon, 13 May 2019 04:04:58 -0700 (PDT)
Received: from centauri (h-158-174-22-72.NA.cust.bahnhof.se. [158.174.22.72])
        by smtp.gmail.com with ESMTPSA id s26sm2954901ljj.52.2019.05.13.04.04.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 04:04:57 -0700 (PDT)
Date:   Mon, 13 May 2019 13:04:55 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: Attach genpds to devices from within OPP core
Message-ID: <20190513110455.GA30513@centauri>
References: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bc9053f5c41a10832b58a2a81decbad7f1aded9.1557742920.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 03:54:10PM +0530, Viresh Kumar wrote:
> The OPP core requires the virtual device pointers to set performance
> state on behalf of the device, for the multiple power domain case. The
> genpd API (dev_pm_domain_attach_by_name()) has evolved now to support
> even the single power domain case and that lets us add common code for
> handling both the cases more efficiently.
> 
> The virtual device structure returned by dev_pm_domain_attach_by_name()
> isn't normally used by the cpufreq drivers as they don't manage power
> on/off of the domains and so is only useful for the OPP core.
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
>  drivers/opp/core.c     | 128 ++++++++++++++++++++++++++---------------
>  include/linux/pm_opp.h |   8 +--
>  2 files changed, 86 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..67d6b0caeab1 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1744,91 +1744,127 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
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
>  /**
> - * dev_pm_opp_set_genpd_virt_dev - Set virtual genpd device for an index
> - * @dev: Consumer device for which the genpd device is getting set.
> - * @virt_dev: virtual genpd device.
> - * @index: index.
> + * dev_pm_opp_attach_genpd - Attach genpd(s) for the device and save virtual device pointer
> + * @dev: Consumer device for which the genpd is getting attached.
> + * @names: Null terminated array of pointers containing names of genpd to attach.
>   *
>   * Multiple generic power domains for a device are supported with the help of
>   * virtual genpd devices, which are created for each consumer device - genpd
>   * pair. These are the device structures which are attached to the power domain
>   * and are required by the OPP core to set the performance state of the genpd.
> + * The same API also works for the case where single genpd is available and so
> + * we don't need to support that separately.
>   *
>   * This helper will normally be called by the consumer driver of the device
> - * "dev", as only that has details of the genpd devices.
> + * "dev", as only that has details of the genpd names.
>   *
> - * This helper needs to be called once for each of those virtual devices, but
> - * only if multiple domains are available for a device. Otherwise the original
> - * device structure will be used instead by the OPP core.
> + * This helper needs to be called once with a list of all genpd to attach.
> + * Otherwise the original device structure will be used instead by the OPP core.
>   */
> -struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev,
> -						struct device *virt_dev,
> -						int index)
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
>  {
>  	struct opp_table *opp_table;
> +	struct device *virt_dev;
> +	int index, ret = -EINVAL;
> +	const char **name = names;
>  
>  	opp_table = dev_pm_opp_get_opp_table(dev);
>  	if (!opp_table)
>  		return ERR_PTR(-ENOMEM);
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
>  	mutex_lock(&opp_table->genpd_virt_dev_lock);
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
>  	}
>  
> -	opp_table->genpd_virt_devs[index] = virt_dev;
>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>  
>  	return opp_table;
> +
> +err:
> +	_opp_detach_genpd(opp_table);
> +	mutex_unlock(&opp_table->genpd_virt_dev_lock);
> +
> +put_table:
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(dev_pm_opp_attach_genpd);
>  
>  /**
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
>   */
> -void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
> -				   struct device *virt_dev)
> +void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
>  {
> -	int i;
> -
>  	/*
>  	 * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
>  	 * used in parallel.
>  	 */
>  	mutex_lock(&opp_table->genpd_virt_dev_lock);
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
>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>  
> -	if (unlikely(i == opp_table->required_opp_count))
> -		dev_err(virt_dev, "Failed to find required device entry\n");
> +	dev_pm_opp_put_opp_table(opp_table);
>  }
> +EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
>  
>  /**
>   * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index b150fe97ce5a..be570761b77a 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -131,8 +131,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>  void dev_pm_opp_put_clkname(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> -struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
> -void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
> +struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
> +void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
>  int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
> @@ -295,12 +295,12 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
>  
>  static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
>  
> -static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index)
> +static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names)
>  {
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> -static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
> +static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
>  
>  static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
>  {
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
