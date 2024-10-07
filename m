Return-Path: <linux-pm+bounces-15291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C719993518
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 19:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4A81F23CBC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5A1D6DA9;
	Mon,  7 Oct 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0OKeE20"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BBB18D642
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322421; cv=none; b=l1r0JmR7jhUbtqBvcsRsavmA9KYScgIw82kBECyCkfAKwjlHBSB5KZFK2MUPMiVkdIobNzs5vcHVd9XOYwW3FN5LxFGNiA5SMKFWSwpvOa5zh9nBbPwNED8Asr5pz+NBHAJaT9CXNHVbm5Umv7wr1eekdG3GljqIApjxh5eGN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322421; c=relaxed/simple;
	bh=tUxpw6u7cL5nSjzpXGTsgJ2xlS7vW49I+aZBTX9BAcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j69oGdDqNFkzJuoCxf/uPUg/hpLWLhNILgPFMHcxU369H1IJUHwkWpDFIPaSr8RV5VkuRdo5rve9NxBnyxrKNorFg5YKYJWXNX3ALI1nmSotTwSyc+/R3heQPJGf5QDB199DFMpubORjQb7Gyjbop1NwGl2xgYiVBQFHt9AErHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A0OKeE20; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53995380bb3so5667036e87.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2024 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728322417; x=1728927217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnPjDrmeCMaKCaAWC5pFtxw0raHxBwjN+mo+qEzYwho=;
        b=A0OKeE20hSV/qcMDRJ20cdWkmabe2SacwA/vHQT1/MpKtS7SOqJ1qpGJV8d018Y2Qi
         08s2+zzNQUkwnWJe2Rr7M/HyF9lx4C+WM7fWxiLnRAl9wDac+W+S1O4BuyqdpNNODDHJ
         GQtsXaqYqrhFidIWmwCADbC6/AJhZ9PQXNCkeRNH0afaqkfrt4MMACPYtCeL7a20imKj
         QPYkuZ1lrdC/RWgNMpFXpUR9KTIMgKC4GtEUQXIMJOkCw2ntrP0Fqaoe3l5AbaURZdWu
         Qj+rYKV3g13y49F45xXU7GN1JbpF2/cy75o6AGI/sVMUEjWCErfLQO7YTBimG9tmshYu
         xU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728322417; x=1728927217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnPjDrmeCMaKCaAWC5pFtxw0raHxBwjN+mo+qEzYwho=;
        b=JcC3z8gltROsJ6ZJ+t1dRoqw2c5+1xarWSCDFGu7tki7CQVJpI723ttHUNLx4Ncm30
         LtAlLvGc5g3vGDkf1W+9104G0AI4//W0jQB12DQ4hUgHKZidcmQQek8Ui1zldzpth/fj
         jJA+hIgbTAZwmkNajHLGm+9BPgqFL4qotAoAJjutFkO4P+tKgAq4q0q1P4G0xCQfjvhA
         LLxk/4pKugRX+tL1LCbKmyeVqraPP+v4ko39gFnMwgFSqgh8I7QTIwM4TJ7ExGYDIN1l
         mI2KeMZUKSVTh6+JMkSSq0xAnNGiyFBBRWEJ/zyNfzx93ZbFv1pwWtpbKkYUhpEcvyj7
         mgcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZQoYrHOgPwz+23hnxzN9rmQHC8elktoDMV73FOo9qBTxl1X2n/iGjGspe6tGp1sp1xqijpzHi1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCkb+mver+mqE6jezIpaeoavjYVQRZRCQZ13KdpBix6kVAYs9
	6ZqEaRgpDQDD7bsSvUoMbiAJveNMRnUyjlZBNx10pSZLtdWwsVi2J/89bz3Sjj0=
X-Google-Smtp-Source: AGHT+IFfLhE1ASoAnxmgdVnlkdwYTU5SKFtJPZAxmsaoWd5KH+3F7EHebkIfK0aqR3vrEWcYB1k9sA==
X-Received: by 2002:a05:6512:b8a:b0:539:94cf:e32c with SMTP id 2adb3069b0e04-539ab88d223mr6336694e87.34.1728322417290;
        Mon, 07 Oct 2024 10:33:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec8147sm901762e87.84.2024.10.07.10.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:33:36 -0700 (PDT)
Date: Mon, 7 Oct 2024 20:33:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org, 
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, johan@kernel.org, 
	konradybcio@kernel.org, linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH V3 3/4] pmdomain: core: Fix debugfs node creation failure
Message-ID: <nlmz5adfxtnhgutblddlf2nlasmd5q3jpcsziaegmfvzsbkk7d@cb6e5qslk7vl>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <20241007060642.1978049-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007060642.1978049-4-quic_sibis@quicinc.com>

On Mon, Oct 07, 2024 at 11:36:41AM GMT, Sibi Sankar wrote:
> The domain attributes returned by the perf protocol can end up
> reporting identical names across domains, resulting in debugfs
> node creation failure. Fix this failure by ensuring that pm domains
> get a unique name using ida in pm_genpd_init.

Can we make this opt-in or opt-out? Seeing numeric suffixes next to
well-known power domain names (e.g. those comin from RPMh or the CPU
domains) is a bit strange. Or maybe you can limit the IDA suffix just to
the SCMI / perf domains?

> 
> Logs: [X1E reports 'NCC' for all its scmi perf domains]
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Fix-suggested-by: Ulf Hansson <ulf.hansson@linaro.org>

Just "Suggested-by: ..."

> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> genpd names with ida appended:
> power-domain-cpu0_0
> power-domain-cpu1_1
> ....
> ebi_18
> gfx_19
> ...
> NCC_56
> NCC_57
> NCC_58
> 
> genpd summary with ida appended:
> domain                          status          children        performance
>     /device                         runtime status                  managed by
>     ------------------------------------------------------------------------------
>     NCC_58                          on                                                 0
>     NCC_57                          on                                                 0
>     NCC_56                          on                                                 0
>     ...
>     gfx_19                          off-0                                              0
>     ebi_18                          off-0                                              0
>     ...
>     power-domain-cpu1_1             off-0                                              0
> 	genpd:0:cpu1                    suspended                   0           SW
>     power-domain-cpu0_0             off-0                                              0
> 	genpd:0:cpu0                    suspended                   0           SW
> 
>  drivers/pmdomain/core.c   | 40 ++++++++++++++++++++++++---------------
>  include/linux/pm_domain.h |  1 +
>  2 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 5ede0f7eda09..631cb732bb39 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt) "PM: " fmt
>  
>  #include <linux/delay.h>
> +#include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> @@ -23,6 +24,9 @@
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  
> +/* Provides a unique ID for each genpd device */
> +static DEFINE_IDA(genpd_ida);
> +
>  #define GENPD_RETRY_MAX_MS	250		/* Approximate */
>  
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
> @@ -189,7 +193,7 @@ static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
>  
>  	if (ret)
>  		dev_warn_once(dev, "PM domain %s will not be powered off\n",
> -				genpd->name);
> +			      dev_name(&genpd->dev));
>  
>  	return ret;
>  }
> @@ -274,7 +278,7 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
>  	if (!genpd_debugfs_dir)
>  		return;
>  
> -	debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
> +	debugfs_lookup_and_remove(dev_name(&genpd->dev), genpd_debugfs_dir);
>  }
>  
>  static void genpd_update_accounting(struct generic_pm_domain *genpd)
> @@ -731,7 +735,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
>  	genpd->gd->max_off_time_changed = true;
>  	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> -		 genpd->name, "on", elapsed_ns);
> +		 dev_name(&genpd->dev), "on", elapsed_ns);
>  
>  out:
>  	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
> @@ -782,7 +786,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>  	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
>  	genpd->gd->max_off_time_changed = true;
>  	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> -		 genpd->name, "off", elapsed_ns);
> +		 dev_name(&genpd->dev), "off", elapsed_ns);
>  
>  out:
>  	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
> @@ -1940,7 +1944,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
>  
>  	if (ret) {
>  		dev_warn(dev, "failed to add notifier for PM domain %s\n",
> -			 genpd->name);
> +			 dev_name(&genpd->dev));
>  		return ret;
>  	}
>  
> @@ -1987,7 +1991,7 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
>  
>  	if (ret) {
>  		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
> -			 genpd->name);
> +			 dev_name(&genpd->dev));
>  		return ret;
>  	}
>  
> @@ -2013,7 +2017,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>  	 */
>  	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
>  		WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
> -				genpd->name, subdomain->name);
> +		     dev_name(&genpd->dev), subdomain->name);
>  		return -EINVAL;
>  	}
>  
> @@ -2088,7 +2092,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>  
>  	if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
>  		pr_warn("%s: unable to remove subdomain %s\n",
> -			genpd->name, subdomain->name);
> +			dev_name(&genpd->dev), subdomain->name);
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -2264,8 +2268,13 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  	if (ret)
>  		return ret;
>  
> +	ret = ida_alloc(&genpd_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;
> +	genpd->device_id = ret;
> +
>  	device_initialize(&genpd->dev);
> -	dev_set_name(&genpd->dev, "%s", genpd->name);
> +	dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
>  
>  	mutex_lock(&gpd_list_lock);
>  	list_add(&genpd->gpd_list_node, &gpd_list);
> @@ -2287,13 +2296,13 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  
>  	if (genpd->has_provider) {
>  		genpd_unlock(genpd);
> -		pr_err("Provider present, unable to remove %s\n", genpd->name);
> +		pr_err("Provider present, unable to remove %s\n", dev_name(&genpd->dev));
>  		return -EBUSY;
>  	}
>  
>  	if (!list_empty(&genpd->parent_links) || genpd->device_count) {
>  		genpd_unlock(genpd);
> -		pr_err("%s: unable to remove %s\n", __func__, genpd->name);
> +		pr_err("%s: unable to remove %s\n", __func__, dev_name(&genpd->dev));
>  		return -EBUSY;
>  	}
>  
> @@ -2307,9 +2316,10 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  	genpd_unlock(genpd);
>  	genpd_debug_remove(genpd);
>  	cancel_work_sync(&genpd->power_off_work);
> +	ida_free(&genpd_ida, genpd->device_id);
>  	genpd_free_data(genpd);
>  
> -	pr_debug("%s: removed %s\n", __func__, genpd->name);
> +	pr_debug("%s: removed %s\n", __func__, dev_name(&genpd->dev));
>  
>  	return 0;
>  }
> @@ -3272,12 +3282,12 @@ static int genpd_summary_one(struct seq_file *s,
>  	else
>  		snprintf(state, sizeof(state), "%s",
>  			 status_lookup[genpd->status]);
> -	seq_printf(s, "%-30s  %-30s  %u", genpd->name, state, genpd->performance_state);
> +	seq_printf(s, "%-30s  %-30s  %u", dev_name(&genpd->dev), state, genpd->performance_state);
>  
>  	/*
>  	 * Modifications on the list require holding locks on both
>  	 * parent and child, so we are safe.
> -	 * Also genpd->name is immutable.
> +	 * Also the device name is immutable.
>  	 */
>  	list_for_each_entry(link, &genpd->parent_links, parent_node) {
>  		if (list_is_first(&link->parent_node, &genpd->parent_links))
> @@ -3502,7 +3512,7 @@ static void genpd_debug_add(struct generic_pm_domain *genpd)
>  	if (!genpd_debugfs_dir)
>  		return;
>  
> -	d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
> +	d = debugfs_create_dir(dev_name(&genpd->dev), genpd_debugfs_dir);
>  
>  	debugfs_create_file("current_state", 0444,
>  			    d, genpd, &status_fops);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b637ec14025f..738df5296ec7 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -163,6 +163,7 @@ struct generic_pm_domain {
>  	atomic_t sd_count;	/* Number of subdomains with power "on" */
>  	enum gpd_status status;	/* Current state of the domain */
>  	unsigned int device_count;	/* Number of devices */
> +	unsigned int device_id;		/* unique device id */
>  	unsigned int suspended_count;	/* System suspend device counter */
>  	unsigned int prepared_count;	/* Suspend counter of prepared devices */
>  	unsigned int performance_state;	/* Aggregated max performance state */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

