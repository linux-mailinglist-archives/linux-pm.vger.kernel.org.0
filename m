Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE671EC45
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEOKq7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:46:59 -0400
Received: from foss.arm.com ([217.140.101.70]:40524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfEOKq7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 06:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 141AF80D;
        Wed, 15 May 2019 03:46:58 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87C383F703;
        Wed, 15 May 2019 03:46:55 -0700 (PDT)
Date:   Wed, 15 May 2019 11:46:54 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Message-ID: <20190515104651.tv5odug7ce4zlupc@queper01-lin>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
 <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
 <20190515104043.vogspxgkapp6qsny@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515104043.vogspxgkapp6qsny@queper01-lin>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 15 May 2019 at 11:40:44 (+0100), Quentin Perret wrote:
> On Wednesday 15 May 2019 at 15:52:00 (+0530), Viresh Kumar wrote:
> > On 15-05-19, 12:16, Daniel Lezcano wrote:
> > > Viresh what do you think ?
> > 
> > I agree with your last suggestions. They do make sense.
> 
> Good :-)
> 
> So, FWIW, the below compiles w/ or w/o THERMAL_GOV_POWER_ALLOCATOR. I'll
> test it and clean it up some more and put it as patch 1 in the series if
> that's OK.
> 
> Thanks,
> Quentin
> 
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..ee431848ef71 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -58,7 +58,9 @@
>   */
>  struct freq_table {
>         u32 frequency;
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>         u32 power;
> +#endif
>  };
>  
>  /**
> @@ -109,28 +111,6 @@ static DEFINE_IDA(cpufreq_ida);
>  static DEFINE_MUTEX(cooling_list_lock);
>  static LIST_HEAD(cpufreq_cdev_list);
>  
> -/* Below code defines functions to be used for cpufreq as cooling device */
> -
> -/**
> - * get_level: Find the level for a particular frequency
> - * @cpufreq_cdev: cpufreq_cdev for which the property is required
> - * @freq: Frequency
> - *
> - * Return: level corresponding to the frequency.
> - */
> -static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
> -                              unsigned int freq)
> -{
> -       struct freq_table *freq_table = cpufreq_cdev->freq_table;
> -       unsigned long level;
> -
> -       for (level = 1; level <= cpufreq_cdev->max_level; level++)
> -               if (freq > freq_table[level].frequency)
> -                       break;
> -
> -       return level - 1;
> -}
> -
>  /**
>   * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
>   * @nb:        struct notifier_block * with callback info.
> @@ -184,6 +164,27 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>         return NOTIFY_OK;
>  }
>  
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> +/**
> + * get_level: Find the level for a particular frequency
> + * @cpufreq_cdev: cpufreq_cdev for which the property is required
> + * @freq: Frequency
> + *
> + * Return: level corresponding to the frequency.
> + */
> +static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
> +                              unsigned int freq)
> +{
> +       struct freq_table *freq_table = cpufreq_cdev->freq_table;
> +       unsigned long level;
> +
> +       for (level = 1; level <= cpufreq_cdev->max_level; level++)
> +               if (freq > freq_table[level].frequency)
> +                       break;
> +
> +       return level - 1;
> +}
> +
>  /**
>   * update_freq_table() - Update the freq table with power numbers
>   * @cpufreq_cdev:      the cpufreq cooling device in which to update the table
> @@ -333,80 +334,6 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
>         return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
>  }
>  
> -/* cpufreq cooling device callback functions are defined below */
> -
> -/**
> - * cpufreq_get_max_state - callback function to get the max cooling state.
> - * @cdev: thermal cooling device pointer.
> - * @state: fill this variable with the max cooling state.
> - *
> - * Callback for the thermal cooling device to return the cpufreq
> - * max cooling state.
> - *
> - * Return: 0 on success, an error code otherwise.
> - */
> -static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
> -                                unsigned long *state)
> -{
> -       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> -
> -       *state = cpufreq_cdev->max_level;
> -       return 0;
> -}
> -
> -/**
> - * cpufreq_get_cur_state - callback function to get the current cooling state.
> - * @cdev: thermal cooling device pointer.
> - * @state: fill this variable with the current cooling state.
> - *
> - * Callback for the thermal cooling device to return the cpufreq
> - * current cooling state.
> - *
> - * Return: 0 on success, an error code otherwise.
> - */
> -static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> -                                unsigned long *state)
> -{
> -       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> -
> -       *state = cpufreq_cdev->cpufreq_state;
> -
> -       return 0;
> -}
> -
> -/**
> - * cpufreq_set_cur_state - callback function to set the current cooling state.
> - * @cdev: thermal cooling device pointer.
> - * @state: set this variable to the current cooling state.
> - *
> - * Callback for the thermal cooling device to change the cpufreq
> - * current cooling state.
> - *
> - * Return: 0 on success, an error code otherwise.
> - */
> -static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> -                                unsigned long state)
> -{
> -       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> -       unsigned int clip_freq;
> -
> -       /* Request state should be less than max_level */
> -       if (WARN_ON(state > cpufreq_cdev->max_level))
> -               return -EINVAL;
> -
> -       /* Check if the old cooling action is same as new cooling action */
> -       if (cpufreq_cdev->cpufreq_state == state)
> -               return 0;
> -
> -       clip_freq = cpufreq_cdev->freq_table[state].frequency;
> -       cpufreq_cdev->cpufreq_state = state;
> -       cpufreq_cdev->clipped_freq = clip_freq;
> -
> -       cpufreq_update_policy(cpufreq_cdev->policy->cpu);
> -
> -       return 0;
> -}
> -
>  /**
>   * cpufreq_get_requested_power() - get the current power
>   * @cdev:      &thermal_cooling_device pointer
> @@ -551,22 +478,93 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
>                                       power);
>         return 0;
>  }
> +#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
> +
> +/* cpufreq cooling device callback functions are defined below */
> +
> +/**
> + * cpufreq_get_max_state - callback function to get the max cooling state.
> + * @cdev: thermal cooling device pointer.
> + * @state: fill this variable with the max cooling state.
> + *
> + * Callback for the thermal cooling device to return the cpufreq
> + * max cooling state.
> + *
> + * Return: 0 on success, an error code otherwise.
> + */
> +static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +
> +       *state = cpufreq_cdev->max_level;
> +       return 0;
> +}
> +
> +/**
> + * cpufreq_get_cur_state - callback function to get the current cooling state.
> + * @cdev: thermal cooling device pointer.
> + * @state: fill this variable with the current cooling state.
> + *
> + * Callback for the thermal cooling device to return the cpufreq
> + * current cooling state.
> + *
> + * Return: 0 on success, an error code otherwise.
> + */
> +static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long *state)
> +{
> +       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +
> +       *state = cpufreq_cdev->cpufreq_state;
> +
> +       return 0;
> +}
> +
> +/**
> + * cpufreq_set_cur_state - callback function to set the current cooling state.
> + * @cdev: thermal cooling device pointer.
> + * @state: set this variable to the current cooling state.
> + *
> + * Callback for the thermal cooling device to change the cpufreq
> + * current cooling state.
> + *
> + * Return: 0 on success, an error code otherwise.
> + */
> +static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> +                                unsigned long state)
> +{
> +       struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +       unsigned int clip_freq;
> +
> +       /* Request state should be less than max_level */
> +       if (WARN_ON(state > cpufreq_cdev->max_level))
> +               return -EINVAL;
> +
> +       /* Check if the old cooling action is same as new cooling action */
> +       if (cpufreq_cdev->cpufreq_state == state)
> +               return 0;
> +
> +       clip_freq = cpufreq_cdev->freq_table[state].frequency;
> +       cpufreq_cdev->cpufreq_state = state;
> +       cpufreq_cdev->clipped_freq = clip_freq;
> +
> +       cpufreq_update_policy(cpufreq_cdev->policy->cpu);
> +
> +       return 0;
> +}
>  
>  /* Bind cpufreq callbacks to thermal cooling device ops */
>  
>  static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
> -       .get_max_state = cpufreq_get_max_state,
> -       .get_cur_state = cpufreq_get_cur_state,
> -       .set_cur_state = cpufreq_set_cur_state,
> -};
> -
> -static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
>         .get_max_state          = cpufreq_get_max_state,
>         .get_cur_state          = cpufreq_get_cur_state,
>         .set_cur_state          = cpufreq_set_cur_state,
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>         .get_requested_power    = cpufreq_get_requested_power,
>         .state2power            = cpufreq_state2power,
>         .power2state            = cpufreq_power2state,
> +#endif
>  };
>  
>  /* Notifier for cpufreq policy change */
> @@ -674,17 +672,16 @@ __cpufreq_cooling_register(struct device_node *np,
>                         pr_debug("%s: freq:%u KHz\n", __func__, freq);
>         }
>  
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>         if (capacitance) {
>                 ret = update_freq_table(cpufreq_cdev, capacitance);
>                 if (ret) {
>                         cdev = ERR_PTR(ret);
>                         goto remove_ida;
>                 }
> -
> -               cooling_ops = &cpufreq_power_cooling_ops;
> -       } else {
> -               cooling_ops = &cpufreq_cooling_ops;
>         }
> +#endif
> +       cooling_ops = &cpufreq_cooling_ops;

Argh, that is actually broken with !capacitance and
THERMAL_GOV_POWER_ALLOCATOR=y ... Perhaps it's best to keep the two
thermal_cooling_device_ops struct separated in the end.

>  
>         cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
>                                                   cooling_ops);
