Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13792D2358
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 06:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgLHFvh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 00:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgLHFvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 00:51:37 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF050C0613D6
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 21:50:56 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2so8957700pfq.5
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 21:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6m3opYu0ZIz6W26OLN1G8zHJToF9eLQnKkxue86QI9o=;
        b=U7KAdv79dkrW5Nexusu4yT7KBKAmQuwyloiJHvF7xZacZMhK4K2ebv4dVabhWUKaH/
         yaq5PQNf+CBrcTX4WpaINFOfBeh+QmR5DJToPqKG4S3RKtC08koGS1yqWjQh9pUR1fgI
         QlF2QUOnJPiLEW1L/BnC1tgnSmIFxLDR7AbNg5OiWIB8QmTb7FZbU9ud0EDKD9Ww2MGs
         BJH7MyoqpWPeZPx4rIyYnKXls1yKvd08mE0NTPticvB7TER4vA8QJycXAXjkZ4CWlrzi
         OTDbmL1ZdTa1ZKjZHV2MiHVdE0McWPqYE3hjbk4EfeAEZ2o2eCxvWmMuzz2OFlI3A4O+
         P4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6m3opYu0ZIz6W26OLN1G8zHJToF9eLQnKkxue86QI9o=;
        b=aM1oEwFAx/z82Y5IgF91OrivJa46BzPUTnaXpHwJJ3baKM9X0TueZI2CDJSMVEZq+2
         VfgFRibzYXXALD6LK6w7JX9m8rGg/Tn2naGavUSVQtE7bgCdQkJqfjJzoqyvBDFl+lB9
         ndraWKHL80FeczXnptoPOjvJt48xyICJfzctnNqiWcQqhgvfIeBbSw+/I7iJFJ9QrgJw
         oSGkCtyrVRNwfVPlMtlKgjtJe3kBJNiy70EOjuJ9A/7eDQpxxqMNe+XK4ITxwPFuyivz
         zokvk2SOwSlIi8m/ghKJuxG4V1BetR+0Ng/foSKSg9QlRo6zQAlP3GhC5SKylvnaJbS3
         e/uQ==
X-Gm-Message-State: AOAM533nJOjXEBj5axZHL5+dndUGpDlyy6P/1O1zLNYnzfW0Hd0Rk/f2
        u/lV4xhdobtzLXv+7ORfm+qUAg==
X-Google-Smtp-Source: ABdhPJzPPrMpdq9bQ7ACUwUsZAr0/UZBTss4ApskHzyJzFHFQHOSukNjkGBBMoXrxoL6+YdGeLMoFg==
X-Received: by 2002:a17:90a:f194:: with SMTP id bv20mr2612367pjb.11.1607406656352;
        Mon, 07 Dec 2020 21:50:56 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id kb12sm1431328pjb.2.2020.12.07.21.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 21:50:55 -0800 (PST)
Date:   Tue, 8 Dec 2020 11:20:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
Message-ID: <20201208055053.kggxw26kxtnpneua@vireshk-i7>
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202172356.10508-4-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-20, 17:23, Nicola Mazzucato wrote:
> By design, SCMI performance domains define the granularity of
> performance controls, they do not describe any underlying hardware
> dependencies (although they may match in many cases).
> 
> It is therefore possible to have some platforms where hardware may have
> the ability to control CPU performance at different granularity and choose
> to describe fine-grained performance control through SCMI.
> 
> In such situations, the energy model would be provided with inaccurate
> information based on controls, while it still needs to know the
> performance boundaries.
> 
> To restore correct functionality, retrieve information of CPUs under the
> same v/f domain from operating-points-v2 in DT, and pass it on to EM.
> 
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 51 +++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 491a0a24fb1e..f505efcc62b1 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -127,6 +127,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  	struct cpufreq_frequency_table *freq_table;
>  	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>  	bool power_scale_mw;
> +	cpumask_var_t opp_shared_cpus;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -134,30 +135,45 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  		return -ENODEV;
>  	}
>  
> -	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
> -	if (ret) {
> -		dev_warn(cpu_dev, "failed to add opps to the device\n");
> -		return ret;
> -	}
> +	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
> +		return -ENOMEM;
>  
>  	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
>  	if (ret) {
>  		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
> -		return ret;
> +		goto out_free_cpumask;
>  	}
>  
> -	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> -	if (ret) {
> -		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> -			__func__, ret);
> -		return ret;
> +	/*
> +	 * The OPP 'sharing cpus' info may come from dt through an empty opp
> +	 * table and opp-shared. If found, it takes precedence over the SCMI
> +	 * domain IDs info.
> +	 */
> +	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, opp_shared_cpus);
> +	if (ret || !cpumask_weight(opp_shared_cpus)) {
> +		/*
> +		 * Either opp-table is not set or no opp-shared was found,
> +		 * use the information from SCMI domain IDs.
> +		 */
> +		cpumask_copy(opp_shared_cpus, policy->cpus);
>  	}
>  
>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>  	if (nr_opp <= 0) {
> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> -		ret = -EPROBE_DEFER;
> -		goto out_free_opp;
> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
> +		if (ret) {
> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
> +			goto out_free_cpumask;
> +		}
> +
> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
> +		if (ret) {
> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> +				__func__, ret);
> +			goto out_free_cpumask;
> +		}
> +

Why do we need to call above two after calling
dev_pm_opp_get_opp_count() ? And we don't check the return value of
the below call anymore, moreover we have to call it twice now.

> +		nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>  	}
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> @@ -191,15 +207,18 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>  		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
>  
>  	power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
> -	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus,
> +	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus,
>  				    power_scale_mw);
>  
> -	return 0;
> +	ret = 0;

ret is already 0 here.

> +	goto out_free_cpumask;
>  
>  out_free_priv:
>  	kfree(priv);
>  out_free_opp:
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
> +out_free_cpumask:
> +	free_cpumask_var(opp_shared_cpus);
>  
>  	return ret;
>  }
> -- 
> 2.27.0

-- 
viresh
