Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E35315F0
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEaUOD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 16:14:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfEaUOD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 16:14:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so7296442wrv.2
        for <linux-pm@vger.kernel.org>; Fri, 31 May 2019 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1veSzmme9xy9EDCdaXF+fOGjs1JaVIDVHse9u2t5kHE=;
        b=O35kPx5r6zUN5pUBRFbzTq/dtlhn75KVRNgPXWArXjSD34YvThVRP0uYM0/vep8/35
         9FuvwrJaHehlrkKn3Tn2fw188nhb6N5u+Zh8r+ZTz1LTe/8k0+JhRMTLqPs6sA+SVKjY
         ivvf2oGkpRJL5Oo7tH72JhEVwpX8TQ7M3PXoIaMksVVko6MvoP3pD0NCSstFZ/EREaq1
         jzTQ7qd9u3oQEiqj8MMtvdAarpdEetYEIDbEwkxuA7c/Nif7InjwDIEiL6oMBlJdxtIQ
         CiirPxzWjuzVHkootO5kD/oMGVcDbRCPsG5dePAhW59AFRq4ZZuseimCM9h4nbiCcVs0
         bbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1veSzmme9xy9EDCdaXF+fOGjs1JaVIDVHse9u2t5kHE=;
        b=ks/uEssh1QJJfTxITBswL3x46QRVsVzCNlgekiHhfJS6GhuoDMDhjwdrjaEzEMJgnU
         8oGNmtIBecvj3UyEtx1g5ta20PE0lsvQQeWfZkJGncE2hEgbcvWpvfwmSrcUjIJHlapM
         jPu7NRm6X4AofUW1xysanPHMZe/UBtPsE7nn7mmQ+DyRmP0FHZVCOWtXGKodTF3yGl5P
         pHH7c2LMmzg7Ts8UaDkLe62qqMK0wxCozyvQOx53/6R8Wy+LZxRr6vFegaDWSIT3m3iX
         ExDD5ehMVx1dJWFSMSS1J3Cn0xQnKpKi40kQRfRQNMFpV14ErOaiZYtnTXTp9HhsaMsO
         TVIQ==
X-Gm-Message-State: APjAAAWeZ1WnWOHNCvFbyJaDYyR4wjTqKmMNPw1jpPf4R5jZ8v1gxvak
        YlS70H0WcHkO+NDLvRNOYoqYdA==
X-Google-Smtp-Source: APXvYqyo/wcntUU4TyrfMaNmdty93gvojoM5MPib/xTT60WDBlXHYcpR8O12fXaOdaF+8JPLQYUJHA==
X-Received: by 2002:adf:dc04:: with SMTP id t4mr8215909wri.126.1559333640803;
        Fri, 31 May 2019 13:14:00 -0700 (PDT)
Received: from [192.168.43.165] ([37.168.13.193])
        by smtp.googlemail.com with ESMTPSA id s7sm5819335wmc.2.2019.05.31.13.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:14:00 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] thermal: cpu_cooling: Make the power-related code
 depend on IPA
To:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-3-quentin.perret@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1980a46c-3aaf-2b39-1154-fa2abcfdab50@linaro.org>
Date:   Fri, 31 May 2019 22:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530092038.12020-3-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2019 11:20, Quentin Perret wrote:
> The core CPU cooling infrastructure has power-related functions
> that have only one client: IPA. Since there can be no user of those
> functions if IPA is not compiled in, make sure to guard them with
> checks on CONFIG_THERMAL_GOV_POWER_ALLOCATOR to not waste space
> unnecessarily.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks!

  -- Daniel

> ---
>  drivers/thermal/cpu_cooling.c | 214 +++++++++++++++++-----------------
>  1 file changed, 104 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 4c5db59a619b..498f59ab64b2 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -46,7 +46,9 @@
>   */
>  struct freq_table {
>  	u32 frequency;
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>  	u32 power;
> +#endif
>  };
>  
>  /**
> @@ -96,28 +98,6 @@ static DEFINE_IDA(cpufreq_ida);
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
> -			       unsigned int freq)
> -{
> -	struct freq_table *freq_table = cpufreq_cdev->freq_table;
> -	unsigned long level;
> -
> -	for (level = 1; level <= cpufreq_cdev->max_level; level++)
> -		if (freq > freq_table[level].frequency)
> -			break;
> -
> -	return level - 1;
> -}
> -
>  /**
>   * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
>   * @nb:	struct notifier_block * with callback info.
> @@ -171,6 +151,27 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
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
> +			       unsigned int freq)
> +{
> +	struct freq_table *freq_table = cpufreq_cdev->freq_table;
> +	unsigned long level;
> +
> +	for (level = 1; level <= cpufreq_cdev->max_level; level++)
> +		if (freq > freq_table[level].frequency)
> +			break;
> +
> +	return level - 1;
> +}
> +
>  /**
>   * update_freq_table() - Update the freq table with power numbers
>   * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
> @@ -319,80 +320,6 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
>  	return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
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
> -				 unsigned long *state)
> -{
> -	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> -
> -	*state = cpufreq_cdev->max_level;
> -	return 0;
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
> -				 unsigned long *state)
> -{
> -	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> -
> -	*state = cpufreq_cdev->cpufreq_state;
> -
> -	return 0;
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
> -				 unsigned long state)
> -{
> -	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> -	unsigned int clip_freq;
> -
> -	/* Request state should be less than max_level */
> -	if (WARN_ON(state > cpufreq_cdev->max_level))
> -		return -EINVAL;
> -
> -	/* Check if the old cooling action is same as new cooling action */
> -	if (cpufreq_cdev->cpufreq_state == state)
> -		return 0;
> -
> -	clip_freq = cpufreq_cdev->freq_table[state].frequency;
> -	cpufreq_cdev->cpufreq_state = state;
> -	cpufreq_cdev->clipped_freq = clip_freq;
> -
> -	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
> -
> -	return 0;
> -}
> -
>  /**
>   * cpufreq_get_requested_power() - get the current power
>   * @cdev:	&thermal_cooling_device pointer
> @@ -536,22 +463,88 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
>  				      power);
>  	return 0;
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
> +				 unsigned long *state)
> +{
> +	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +
> +	*state = cpufreq_cdev->max_level;
> +	return 0;
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
> +				 unsigned long *state)
> +{
> +	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +
> +	*state = cpufreq_cdev->cpufreq_state;
> +
> +	return 0;
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
> +				 unsigned long state)
> +{
> +	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +	unsigned int clip_freq;
> +
> +	/* Request state should be less than max_level */
> +	if (WARN_ON(state > cpufreq_cdev->max_level))
> +		return -EINVAL;
> +
> +	/* Check if the old cooling action is same as new cooling action */
> +	if (cpufreq_cdev->cpufreq_state == state)
> +		return 0;
> +
> +	clip_freq = cpufreq_cdev->freq_table[state].frequency;
> +	cpufreq_cdev->cpufreq_state = state;
> +	cpufreq_cdev->clipped_freq = clip_freq;
> +
> +	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
> +
> +	return 0;
> +}
>  
>  /* Bind cpufreq callbacks to thermal cooling device ops */
>  
>  static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
> -	.get_max_state = cpufreq_get_max_state,
> -	.get_cur_state = cpufreq_get_cur_state,
> -	.set_cur_state = cpufreq_set_cur_state,
> -};
> -
> -static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
>  	.get_max_state		= cpufreq_get_max_state,
>  	.get_cur_state		= cpufreq_get_cur_state,
>  	.set_cur_state		= cpufreq_set_cur_state,
> -	.get_requested_power	= cpufreq_get_requested_power,
> -	.state2power		= cpufreq_state2power,
> -	.power2state		= cpufreq_power2state,
>  };
>  
>  /* Notifier for cpufreq policy change */
> @@ -659,18 +652,19 @@ __cpufreq_cooling_register(struct device_node *np,
>  			pr_debug("%s: freq:%u KHz\n", __func__, freq);
>  	}
>  
> +	cooling_ops = &cpufreq_cooling_ops;
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>  	if (capacitance) {
>  		ret = update_freq_table(cpufreq_cdev, capacitance);
>  		if (ret) {
>  			cdev = ERR_PTR(ret);
>  			goto remove_ida;
>  		}
> -
> -		cooling_ops = &cpufreq_power_cooling_ops;
> -	} else {
> -		cooling_ops = &cpufreq_cooling_ops;
> +		cooling_ops->get_requested_power = cpufreq_get_requested_power;
> +		cooling_ops->state2power = cpufreq_state2power;
> +		cooling_ops->power2state = cpufreq_power2state;
>  	}
> -
> +#endif
>  	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
>  						  cooling_ops);
>  	if (IS_ERR(cdev))
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

