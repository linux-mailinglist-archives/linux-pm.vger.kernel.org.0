Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABC3C32E8
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 06:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGJE74 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhGJE7w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jul 2021 00:59:52 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D9C0613E9
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 21:57:06 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id o23-20020a4a2c170000b029025469ad0e4aso2823938ooo.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 21:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UDGTF4bnijwcKjYKNVG9NXGEhqZ5ES+EVweJisBftjo=;
        b=rb//oRKhjIIg8WRDqovlx6mFGLBpj+DC7Hu8AT+FB+MK92XuIgtBA4qqJ11Oo+K5Ab
         FmwNtZPVEDfz3+dSBucQuFVqvvhF5Xdcgp5+XNu5plRC428resz87Mf9mMfAf+Jzj6lG
         5dzuJE35SpsXpWhoOfi5Ko+ENGFNRvzMiZQsEjLDoUcjkyJlcossnmVqE92unXm/ap7I
         Npi6Pfn18AJqgwbSXaezIzoGDHiM/NOUmxTBWUXtqNfiUyE4Ouex/zTeN57FuKgzjCf6
         Yck+fXyxuA4FPgGrjohgUTcUcZjD+eKaZ8bzZaaupimz+te9M1eJnpB/DDNWW5MuAHdz
         aoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDGTF4bnijwcKjYKNVG9NXGEhqZ5ES+EVweJisBftjo=;
        b=EMVZ/oKwghbKi/M4kF6C2mzpmlZFuVUjzHkkUkak1h7rJtxFTBisx9rpj3TsRe0HNM
         3Cyh0hQmUD9DAvjw0/ZID6WtkHcqx4MnH2LNbOEINRmOCmdYWkIL/nBbLqWw0NwFeNNX
         ydEbIM2e8Ji7ts2YpmHmyX1w3WlCTMIlb9dQMyBj8GqLng2XMv/m8L6/uyymlfOjltwX
         zCiY4xFlIDIoKXRBB+ESt8kd7zMnQtLJjg/GYzI3OSZoqUKCM3lMH/Xzp2yHRRjs1HvE
         YtX3QVhDCJJuAsgh52n7MMrmmqKgtq30vEAMwnzguvQZ7H+1cSigz+D46rCTgTUhlh9W
         D0YA==
X-Gm-Message-State: AOAM533TrIyhULyESI+R1oqBY/2vD3IEXOzYEJxXQdOXiQTs655CDJtq
        Hk8WC/wZxs+S6cJdn4quzry0fA==
X-Google-Smtp-Source: ABdhPJwi8B3nEaX1k9oQq1OTRwAMZTmvLYql2ghMjn78ZCJrWqd7ytG1skgLtqbKBG7LaL/31O5Qqg==
X-Received: by 2002:a4a:8749:: with SMTP id a9mr29155288ooi.71.1625893025163;
        Fri, 09 Jul 2021 21:57:05 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t15sm1718639oiw.16.2021.07.09.21.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 21:57:04 -0700 (PDT)
Date:   Fri, 9 Jul 2021 23:57:01 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 3/6] cpufreq: qcom-cpufreq-hw: Add dcvs interrupt
 support
Message-ID: <YOkonX2F+xP5fcuT@yoga>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120656.663851-4-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:

> Add interrupt support to notify the kernel of h/w initiated frequency
> throttling by LMh. Convey this to scheduler via thermal presssure
> interface.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v2->v3:
> 	- Cosmetic fixes from review comments on the list.
> 	- Moved all LMh initializations to qcom_cpufreq_hw_lmh_init.
> 	- Added freeing of LMh interrupt and cancelling the polling worker to
> 	  qcom_cpufreq_hw_cpu_exit as per Viresh's suggestion.
> 	- LMh interrupts are now tied to cpu dev and not cpufreq dev. This will be
> 	  useful for further generation of SoCs where the same interrupt signals
> 	  multiple cpu clusters.
> 
> v1->v2:
> 	- Introduced qcom_cpufreq_hw_lmh_init to consolidate LMh related initializations
> 	  as per Viresh's review comment.
> 	- Moved the piece of code restarting polling/re-enabling LMh interrupt to
> 	  qcom_lmh_dcvs_notify therby simplifying isr and timer callback as per Viresh's
> 	  suggestion.
> 	- Droped cpus from qcom_cpufreq_data and instead using cpus from cpufreq_policy in
> 	  qcom_lmh_dcvs_notify as per Viresh's review comment.
> 	- Dropped dt property qcom,support-lmh as per Bjorn's suggestion.
> 	- Other minor/cosmetic fixes
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 118 ++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index f86859bf76f1..bb5fc700d913 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/init.h>
>  #include <linux/interconnect.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -22,10 +23,13 @@
>  #define CLK_HW_DIV			2
>  #define LUT_TURBO_IND			1
>  
> +#define HZ_PER_KHZ			1000
> +
>  struct qcom_cpufreq_soc_data {
>  	u32 reg_enable;
>  	u32 reg_freq_lut;
>  	u32 reg_volt_lut;
> +	u32 reg_current_vote;
>  	u32 reg_perf_state;
>  	u8 lut_row_size;
>  };
> @@ -33,7 +37,10 @@ struct qcom_cpufreq_soc_data {
>  struct qcom_cpufreq_data {
>  	void __iomem *base;
>  	struct resource *res;
> +	struct delayed_work lmh_dcvs_poll_work;

How about dropping "lmh" from this variable name?

Perhaps "throttle_work" or something like that?

>  	const struct qcom_cpufreq_soc_data *soc_data;
> +	struct cpufreq_policy *policy;
> +	int lmh_dcvs_irq;

throttle_irq ?

>  };
>  
>  static unsigned long cpu_hw_rate, xo_rate;
> @@ -251,10 +258,84 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  	}
>  }
>  
> +static inline unsigned long qcom_lmh_vote_to_freq(u32 val)
> +{
> +	return (val & 0x3FF) * 19200;
> +}
> +
> +static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
> +{
> +	struct cpufreq_policy *policy = data->policy;
> +	struct dev_pm_opp *opp;
> +	struct device *dev;
> +	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
> +	unsigned int val, freq;
> +
> +	/*
> +	 * Get the h/w throttled frequency, normalize it using the
> +	 * registered opp table and use it to calculate thermal pressure.
> +	 */
> +	val = readl_relaxed(data->base + data->soc_data->reg_current_vote);

I would find it cleaner to move the readl() into the helper function, as
you don't care about the register value, only the resulting frequency.

> +	freq = qcom_lmh_vote_to_freq(val);
> +	freq_hz = freq * HZ_PER_KHZ;
> +
> +	dev = get_cpu_device(cpumask_first(policy->cpus));
> +	opp = dev_pm_opp_find_freq_floor(dev, &freq_hz);
> +	if (IS_ERR(opp) && PTR_ERR(opp) == -ERANGE)
> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq_hz);
> +
> +	throttled_freq = freq_hz / HZ_PER_KHZ;
> +
> +	/* Update thermal pressure */
> +
> +	max_capacity = arch_scale_cpu_capacity(cpumask_first(policy->cpus));
> +	capacity = throttled_freq * max_capacity;
> +	capacity /= policy->cpuinfo.max_freq;

Perhaps, to avoid overflows if this is ever used on a 32-bit platform
use:

	mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq)

> +
> +	/* Don't pass boost capacity to scheduler */
> +	if (capacity > max_capacity)
> +		capacity = max_capacity;
> +
> +	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
> +
> +	/*
> +	 * If h/w throttled frequency is higher than what cpufreq has requested for, stop
> +	 * polling and switch back to interrupt mechanism
> +	 */
> +
> +	if (throttled_freq >= qcom_cpufreq_hw_get(cpumask_first(policy->cpus)))
> +		/* Clear the existing interrupts and enable it back */
> +		enable_irq(data->lmh_dcvs_irq);
> +	else
> +		mod_delayed_work(system_highpri_wq, &data->lmh_dcvs_poll_work,
> +				 msecs_to_jiffies(10));
> +}
> +
> +static void qcom_lmh_dcvs_poll(struct work_struct *work)
> +{
> +	struct qcom_cpufreq_data *data;
> +
> +	data = container_of(work, struct qcom_cpufreq_data, lmh_dcvs_poll_work.work);
> +
> +	qcom_lmh_dcvs_notify(data);
> +}
> +
> +static irqreturn_t qcom_lmh_dcvs_handle_irq(int irq, void *data)
> +{
> +	struct qcom_cpufreq_data *c_data = data;
> +
> +	/* Disable interrupt and enable polling */
> +	disable_irq_nosync(c_data->lmh_dcvs_irq);
> +	qcom_lmh_dcvs_notify(c_data);
> +
> +	return 0;
> +}
> +
>  static const struct qcom_cpufreq_soc_data qcom_soc_data = {
>  	.reg_enable = 0x0,
>  	.reg_freq_lut = 0x110,
>  	.reg_volt_lut = 0x114,
> +	.reg_current_vote = 0x704,
>  	.reg_perf_state = 0x920,
>  	.lut_row_size = 32,
>  };
> @@ -274,6 +355,35 @@ static const struct of_device_id qcom_cpufreq_hw_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>  
> +static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
> +{
> +	struct qcom_cpufreq_data *data = policy->driver_data;
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	char irq_name[15];
> +	int ret;
> +
> +	/*
> +	 * Look for LMh interrupt. If no interrupt line is specified /
> +	 * if there is an error, allow cpufreq to be enabled as usual.
> +	 */
> +	data->lmh_dcvs_irq = platform_get_irq(pdev, index);
> +	if (data->lmh_dcvs_irq <= 0)
> +		return data->lmh_dcvs_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
> +
> +	snprintf(irq_name, sizeof(irq_name), "dcvsh-irq-%u", policy->cpu);
> +	ret = devm_request_irq(cpu_dev, data->lmh_dcvs_irq, qcom_lmh_dcvs_handle_irq,
> +			       0, irq_name, data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering irq %x\n", ret, data->lmh_dcvs_irq);

The irq number here won't have any meaning, and %x wouldn't be suitable.

How about ..."Error registering %s: %d\n", irq_name, ret); ?

> +		return 0;

This sounds like a problem, wouldn't it be suitable to treat it as a
problem?

> +	}
> +	data->policy = policy;

Afaict, no one is going to access data->policy unless devm_request_irq()
succeeds and if it does and the interrupt fires immediately it would be
too late to set it here. So better move it earlier.

> +	INIT_DEFERRABLE_WORK(&data->lmh_dcvs_poll_work, qcom_lmh_dcvs_poll);

What if the interrupt fires before you initialize the work? Better move
this higher up.

> +
> +	return 0;
> +}
> +
>  static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  {
>  	struct platform_device *pdev = cpufreq_get_driver_data();
> @@ -370,6 +480,10 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
>  	}
>  
> +	ret = qcom_cpufreq_hw_lmh_init(policy, index);
> +	if (ret)
> +		goto error;
> +
>  	return 0;
>  error:
>  	kfree(data);
> @@ -389,6 +503,10 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
>  
>  	dev_pm_opp_remove_all_dynamic(cpu_dev);
>  	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> +	if (data->lmh_dcvs_irq > 0) {
> +		devm_free_irq(cpu_dev, data->lmh_dcvs_irq, data);

As init/exit are called multiple times you should avoid the devm
variants.

Regards,
Bjorn

> +		cancel_delayed_work_sync(&data->lmh_dcvs_poll_work);
> +	}
>  	kfree(policy->freq_table);
>  	kfree(data);
>  	iounmap(base);
> -- 
> 2.25.1
> 
