Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE54A3B0B9E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhFVRpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhFVRoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 13:44:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06431C061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 10:42:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so2173106pjn.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d9gPYvqn2uuuVi2bAu98NXCYWXs4V/KcdSXWRP7wuLo=;
        b=ZVCAYu9nTL4ij3dTly/ui+mYySyStoxrKsypoS3zrq8rVVqzUSuj484n1aBA/uiz8g
         qUhkdZz/ccdvEMoCvR0f+SMHLF/u/dxZY+LQIxbLVj0vTdFz4j65aUbD2k3AL+2cbOdo
         QPcHJBMvrm9IZEP+BV5kyebYIv9dpMp8ZT5hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9gPYvqn2uuuVi2bAu98NXCYWXs4V/KcdSXWRP7wuLo=;
        b=AuWB8/PMWJjraZqDbRVbq1VjsErrYfNzZ6LS6nZL89icjy7jIwyqboZA2ZptCFgjo+
         7Hn3DHG1JPsUHdnEbj/bdFXQUKSuXrK/X6FhMEcN6vNiI3OuKALy4CRkmRPEMq45vff0
         cTupmhYRCQTZSIUC0NTjkJBxOw3sppDghHzN+dQsjeW+qq87ZQ4blPvZMonYesJLl0fR
         hQBY3KjVeQrI2hPdV6+Cbwd4V85GO0JOshLy3ogMN1mgactLIKqQkQtMh5ny0jQoqoUq
         8kLg6+REwyUIECKKyOLTO/3Bsmkp/bCNydkGEhCM9rlYpGYjSSit0Wll+NmmNGapzWkB
         jNKw==
X-Gm-Message-State: AOAM532DMsLMlVG/kCFlFKIAue6P4O3AlmbLCqPbpAuf1yQTTMEEyOUH
        nc1FSaF3Z3Bief+FjKFkB7hciw==
X-Google-Smtp-Source: ABdhPJzjlS0OixVEdhP/vLJwdUiIBbw0/CI1Efidm0Mb2n/FTxNBaVBeUHeZc5++YD/DDDGwFHvLkA==
X-Received: by 2002:a17:90a:708a:: with SMTP id g10mr5205184pjk.108.1624383757557;
        Tue, 22 Jun 2021 10:42:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dc21:8b6f:f8cd:9070])
        by smtp.gmail.com with UTF8SMTPSA id v15sm21530163pgf.26.2021.06.22.10.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 10:42:36 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:42:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        chanwoo@kernel.org, cwchoi00@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 3/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Message-ID: <YNIhCxw0bnweb9SB@google.com>
References: <20210617060546.26933-1-cw00.choi@samsung.com>
 <CGME20210617054647epcas1p431edaffea5bf7f3792b55dc3d91289ae@epcas1p4.samsung.com>
 <20210617060546.26933-4-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617060546.26933-4-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 17, 2021 at 03:05:45PM +0900, Chanwoo Choi wrote:
> From: Saravana Kannan <skannan@codeaurora.org>
> 
> Many CPU architectures have caches that can scale independent of the
> CPUs. Frequency scaling of the caches is necessary to make sure that the
> cache is not a performance bottleneck that leads to poor performance and
> power. The same idea applies for RAM/DDR.
> 
> To achieve this, this patch adds support for cpu based scaling to the
> passive governor. This is accomplished by taking the current frequency
> of each CPU frequency domain and then adjust the frequency of the cache
> (or any devfreq device) based on the frequency of the CPUs. It listens
> to CPU frequency transition notifiers to keep itself up to date on the
> current CPU frequency.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> * Derives the optimal devfreq device opp from required-opps property of
>   the parent cpu opp_table.
> 
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its
>   max frequency. If the CPUs are running at their min frequency, the
>   device runs at its min frequency. It is interpolated for frequencies
>   in between.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> [Sibi: Integrated cpu-freqmap governor into passive_governor]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> [Chanwoo: Fix conflict with latest code and clean code up]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/governor.h         |  22 +++
>  drivers/devfreq/governor_passive.c | 264 ++++++++++++++++++++++++++++-
>  include/linux/devfreq.h            |  16 +-
>  3 files changed, 293 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 9a9495f94ac6..3c36c92c89a9 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -47,6 +47,28 @@
>  #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
>  #define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
>  
> +/**
> + * struct devfreq_cpu_data - Hold the per-cpu data
> + * @dev:	reference to cpu device.
> + * @first_cpu:	the cpumask of the first cpu of a policy.
> + * @opp_table:	reference to cpu opp table.
> + * @cur_freq:	the current frequency of the cpu.
> + * @min_freq:	the min frequency of the cpu.
> + * @max_freq:	the max frequency of the cpu.
> + *
> + * This structure stores the required cpu_data of a cpu.
> + * This is auto-populated by the governor.
> + */
> +struct devfreq_cpu_data {
> +	struct device *dev;
> +	unsigned int first_cpu;
> +
> +	struct opp_table *opp_table;
> +	unsigned int cur_freq;
> +	unsigned int min_freq;
> +	unsigned int max_freq;
> +};
> +
>  /**
>   * struct devfreq_governor - Devfreq policy governor
>   * @node:		list node - contains registered devfreq governors
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index fc09324a03e0..07e864509b7e 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
>
> ...
>
> +static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
> +{
> +	struct devfreq_passive_data *p_data
> +			= (struct devfreq_passive_data *)devfreq->data;
> +	struct device *dev = devfreq->dev.parent;
> +	struct opp_table *opp_table = NULL;
> +	struct devfreq_cpu_data *cpu_data;
> +	struct cpufreq_policy *policy;
> +	struct device *cpu_dev;
> +	unsigned int cpu;
> +	int ret;
> +
> +	get_online_cpus();
> +
> +	p_data->nb.notifier_call = cpufreq_passive_notifier_call;
> +	ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
> +	if (ret) {
> +		dev_err(dev, "failed to register cpufreq notifier\n");
> +		p_data->nb.notifier_call = NULL;
> +		goto out;
> +	}
> +
> +	for_each_online_cpu(cpu) {


Is this really needed for each CPU? Wouldn't it be enough to create
a 'cpu_data' for each 'policy CPU'?

In any case should this be for_each_possible_cpu() as in _unregister_notifier()
to also support CPUs that may be offline when the notifier is registered?

> +		if (p_data->cpu_data[cpu])
> +			continue;
> +
> +		policy = cpufreq_cpu_get(cpu);
> +		if (policy) {
> +			cpu_data = kzalloc(sizeof(*cpu_data), GFP_KERNEL);
> +			if (!cpu_data) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			cpu_dev = get_cpu_device(cpu);
> +			if (!cpu_dev) {
> +				dev_err(dev, "failed to get cpu device\n");
> +				ret = -ENODEV;
> +				goto out;

Memory for 'cpu_data' is not freed in this path.

Also applies to CPUs from possible prior iterations.

> +			}
> +
> +			opp_table = dev_pm_opp_get_opp_table(cpu_dev);
> +			if (IS_ERR(opp_table)) {
> +				ret = PTR_ERR(opp_table);
> +				goto out;

Ditto and cpufreq_cpu_put() is missing too.

> +			}
> +
> +			cpu_data->dev = cpu_dev;
> +			cpu_data->opp_table = opp_table;
> +			cpu_data->first_cpu = cpumask_first(policy->related_cpus);
> +			cpu_data->cur_freq = policy->cur;
> +			cpu_data->min_freq = policy->cpuinfo.min_freq;
> +			cpu_data->max_freq = policy->cpuinfo.max_freq;
> +
> +			p_data->cpu_data[cpu] = cpu_data;
> +			cpufreq_cpu_put(policy);
> +		} else {
> +			ret = -EPROBE_DEFER;
> +			goto out;

Resources from possible prior iterations aren't freed.

> +		}
> +	}
> +out:
> +	put_online_cpus();
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&devfreq->lock);
> +	ret = devfreq_update_target(devfreq, 0L);
> +	mutex_unlock(&devfreq->lock);
> +	if (ret)
> +		dev_err(dev, "failed to update the frequency\n");
> +
> +	return ret;
> +}
> +
> +static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
> +{
> +	struct devfreq_passive_data *p_data
> +			= (struct devfreq_passive_data *)devfreq->data;
> +	struct devfreq_cpu_data *cpu_data;
> +	int cpu;
> +
> +	if (p_data->nb.notifier_call)
> +		cpufreq_unregister_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_data = p_data->cpu_data[cpu];
> +		if (cpu_data) {
> +			if (cpu_data->opp_table)
> +				dev_pm_opp_put_opp_table(cpu_data->opp_table);
> +			kfree(cpu_data);
> +			cpu_data = NULL;

Assignment to NULL is not needed.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int devfreq_passive_notifier_call(struct notifier_block *nb,
>  				unsigned long event, void *ptr)
>  {
> @@ -140,7 +379,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  	struct notifier_block *nb = &p_data->nb;
>  	int ret = 0;
>  
> -	if (!parent)
> +	if (p_data->parent_type == DEVFREQ_PARENT_DEV && !parent)
>  		return -EPROBE_DEFER;
>  
>  	switch (event) {
> @@ -148,13 +387,24 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  		if (!p_data->this)
>  			p_data->this = devfreq;
>  
> -		nb->notifier_call = devfreq_passive_notifier_call;
> -		ret = devfreq_register_notifier(parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER);
> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV) {
> +			nb->notifier_call = devfreq_passive_notifier_call;
> +			ret = devfreq_register_notifier(parent, nb,
> +						DEVFREQ_TRANSITION_NOTIFIER);
> +		} else if (p_data->parent_type == CPUFREQ_PARENT_DEV) {
> +			ret = cpufreq_passive_register_notifier(devfreq);
> +		} else {
> +			ret = -EINVAL;
> +		}
>  		break;
>  	case DEVFREQ_GOV_STOP:
> -		WARN_ON(devfreq_unregister_notifier(parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER));
> +		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
> +			WARN_ON(devfreq_unregister_notifier(parent, nb,
> +						DEVFREQ_TRANSITION_NOTIFIER));
> +		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
> +			WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
> +		else
> +			ret = -EINVAL;
>  		break;
>  	default:
>  		break;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 142474b4af96..cfa0ef54841e 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -38,6 +38,7 @@ enum devfreq_timer {
>  
>  struct devfreq;
>  struct devfreq_governor;
> +struct devfreq_cpu_data;
>  struct thermal_cooling_device;
>  
>  /**
> @@ -288,6 +289,11 @@ struct devfreq_simple_ondemand_data {
>  #endif
>  
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> +enum devfreq_parent_dev_type {
> +	DEVFREQ_PARENT_DEV,
> +	CPUFREQ_PARENT_DEV,
> +};
> +
>  /**
>   * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>   *	and devfreq_add_device
> @@ -299,8 +305,10 @@ struct devfreq_simple_ondemand_data {
>   *			using governors except for passive governor.
>   *			If the devfreq device has the specific method to decide
>   *			the next frequency, should use this callback.
> - * @this:	the devfreq instance of own device.
> - * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> + + * @parent_type	parent type of the device
> + + * @this:		the devfreq instance of own device.
> + + * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> + + * @cpu_data:		the state min/max/current frequency of all online cpu's
>   *
>   * The devfreq_passive_data have to set the devfreq instance of parent
>   * device with governors except for the passive governor. But, don't need to
> @@ -314,9 +322,13 @@ struct devfreq_passive_data {
>  	/* Optional callback to decide the next frequency of passvice device */
>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>  
> +	/* Should set the type of parent device */
> +	enum devfreq_parent_dev_type parent_type;
> +
>  	/* For passive governor's internal use. Don't need to set them */
>  	struct devfreq *this;
>  	struct notifier_block nb;
> +	struct devfreq_cpu_data *cpu_data[NR_CPUS];

Could memory usage be a concern on systems with a really high number of CPUs
(e.g. 8k for x86 with MAXSMP)? One could argue that such systems likely have
significant amount of RAM too and a chunk of memory in the order of 100k
wouldn't make a big impact. I'm assuming that 'cpu_data' is only needed for
'policy CPUs'.
