Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4940731B41
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFAKhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 06:37:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38703 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfFAKhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 06:37:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so8101298wrs.5
        for <linux-pm@vger.kernel.org>; Sat, 01 Jun 2019 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ozhKHGFa1kDQjdWhfzHYL4YQh2UKeVQWwQDbP74zblc=;
        b=PdUo0UndCQGJDCNGD9JCINP6LyOGOl8k2keiiS88uBmWOEFP1RgENQx6PKf7p6uBbS
         mgoB+UkvqhlGoppvceDS356WpKpoCafQbpWErY8tMZCZ6h2mpBmpHKdNi3DxUE7DMXGB
         Id46AFrZMIoP6Pxzm34ZFRxWx686K0OAba+v5uCc5sOfzQKxhrDnHyw3fPd+p8ZjsFsH
         9SXhay6q6eKf26FnM7y/N/dM10gWlDQIQjpzxfDXqPch5puKDCyLg/ES3XEBHazC1tr6
         7ohlEaC6pqH2SIbNAqDv/BW2NSwpudyY+jTOLBlnf+sES1uxfErXQSU4eppSA4oQjBQ2
         BNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ozhKHGFa1kDQjdWhfzHYL4YQh2UKeVQWwQDbP74zblc=;
        b=fygo2yyllv1FBJo79jYlSyJNs2JeTddMQJhkNrCqesTjwmPrGICd3LP9sCvW91jwSW
         cHVpLHDPOvlFPjEP2ccphOMx41uHQeP86E4zZ7No2TjwCf4z/9pvfn6+gSkKIvhAK/bJ
         drd+FzeIpgnZqqqXJRXrmMueULaogDn3yioD7Mb+vLMZ6YF8E0o6XwF9A5dW2PfTRq3H
         ZBUFq0gn9O4heQvCzR59+k44FWE72bCCh+JCi87FqG+3BuOJ1KepqBORb21iigTxyY++
         LGu8I6I7QcePFupWdOzvykW/c5Uwfn4Q/PnEUhPQggR8rqYMZGkxLVBFb2Pk59K4g4du
         hy0Q==
X-Gm-Message-State: APjAAAUn2fZfMY8JFuLFM8C8QxXQVFM7ns2LO+oFCEQcQM+NWXg4h6bs
        T6pxCzJJbC9F3Rrl2iEPh4Cv3A==
X-Google-Smtp-Source: APXvYqzOy3f9Jvo3sm7xCt6HY+DA0q9Jyd4x91v4bn30fqbf/kqMfESfMKQWZkEa0b4W9d8EwgI8Dg==
X-Received: by 2002:adf:e841:: with SMTP id d1mr9791047wrn.204.1559385428991;
        Sat, 01 Jun 2019 03:37:08 -0700 (PDT)
Received: from [192.168.43.165] ([37.165.40.122])
        by smtp.googlemail.com with ESMTPSA id 32sm25760059wra.35.2019.06.01.03.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 03:37:08 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
To:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-4-quentin.perret@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2d1d5cda-63c3-07a9-ae5f-abbc300ed1fc@linaro.org>
Date:   Sat, 1 Jun 2019 12:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530092038.12020-4-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2019 11:20, Quentin Perret wrote:
> The newly introduced Energy Model framework manages power cost tables in
> a generic way. Moreover, it supports several types of models since the
> tables can come from DT or firmware (through SCMI) for example. On the
> other hand, the cpu_cooling subsystem manages its own power cost tables
> using only DT data.
> 
> In order to avoid the duplication of data in the kernel, and in order to
> enable IPA with EMs coming from more than just DT, remove the private
> tables from cpu_cooling.c and migrate it to using the centralized EM
> framework. Doing so should have no visible functional impact for
> existing users of IPA since:
> 
>  - recent extenstions to the the PM_OPP infrastructure enable the
>    registration of EMs in PM_EM using the DT property used by IPA;
> 
>  - the existing upstream cpufreq drivers marked with the
>    'CPUFREQ_IS_COOLING_DEV' flag all use the aforementioned PM_OPP
>    infrastructure, which means they all support PM_EM. The only two
>    exceptions are qoriq-cpufreq which doesn't in fact use an EM and
>    scmi-cpufreq which doesn't use DT for power costs.
> 
> For existing users of cpu_cooling, PM_EM tables will contain the exact
> same power values that IPA used to compute on its own until now. The
> only new dependency for them is to compile in CONFIG_ENERGY_MODEL.
> 
> The case where the thermal subsystem is used without an Energy Model
> (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> frequency table which is already a dependency for cpu_cooling.c anyway.
> Since the thermal framework expects the cooling states in a particular
> order, bail out whenever the CPUFreq table is unsorted, since that is
> fairly uncommon in general, and there are currently no users of
> cpu_cooling for this use-case.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  drivers/thermal/Kconfig       |   1 +
>  drivers/thermal/cpu_cooling.c | 250 ++++++++++++----------------------
>  2 files changed, 91 insertions(+), 160 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 9966364a6deb..340853a3ca48 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -144,6 +144,7 @@ config THERMAL_GOV_USER_SPACE
>  
>  config THERMAL_GOV_POWER_ALLOCATOR
>  	bool "Power allocator thermal governor"
> +	depends on ENERGY_MODEL
>  	help
>  	  Enable this to manage platform thermals by dynamically
>  	  allocating and limiting power to devices.
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 498f59ab64b2..83486775e593 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/energy_model.h>
>  
>  #include <trace/events/thermal.h>
>  
> @@ -36,21 +37,6 @@
>   *	...
>   */
>  
> -/**
> - * struct freq_table - frequency table along with power entries
> - * @frequency:	frequency in KHz
> - * @power:	power in mW
> - *
> - * This structure is built when the cooling device registers and helps
> - * in translating frequency to power and vice versa.
> - */
> -struct freq_table {
> -	u32 frequency;
> -#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> -	u32 power;
> -#endif
> -};
> -
>  /**
>   * struct time_in_idle - Idle time stats
>   * @time: previous reading of the absolute time that this cpu was idle
> @@ -72,7 +58,7 @@ struct time_in_idle {
>   *	frequency.
>   * @max_level: maximum cooling level. One less than total number of valid
>   *	cpufreq frequencies.
> - * @freq_table: Freq table in descending order of frequencies
> + * @em: Reference on the Energy Model of the device
>   * @cdev: thermal_cooling_device pointer to keep track of the
>   *	registered cooling device.
>   * @policy: cpufreq policy.
> @@ -88,7 +74,7 @@ struct cpufreq_cooling_device {
>  	unsigned int cpufreq_state;
>  	unsigned int clipped_freq;
>  	unsigned int max_level;
> -	struct freq_table *freq_table;	/* In descending order */
> +	struct em_perf_domain *em;
>  	struct cpufreq_policy *policy;
>  	struct list_head node;
>  	struct time_in_idle *idle_time;
> @@ -162,114 +148,40 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>  static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
>  			       unsigned int freq)
>  {
> -	struct freq_table *freq_table = cpufreq_cdev->freq_table;
> -	unsigned long level;
> +	int i;
>  
> -	for (level = 1; level <= cpufreq_cdev->max_level; level++)
> -		if (freq > freq_table[level].frequency)
> +	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> +		if (freq > cpufreq_cdev->em->table[i].frequency)
>  			break;
> -
> -	return level - 1;
> -}
> -
> -/**
> - * update_freq_table() - Update the freq table with power numbers
> - * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
> - * @capacitance: dynamic power coefficient for these cpus
> - *
> - * Update the freq table with power numbers.  This table will be used in
> - * cpu_power_to_freq() and cpu_freq_to_power() to convert between power and
> - * frequency efficiently.  Power is stored in mW, frequency in KHz.  The
> - * resulting table is in descending order.
> - *
> - * Return: 0 on success, -EINVAL if there are no OPPs for any CPUs,
> - * or -ENOMEM if we run out of memory.
> - */
> -static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
> -			     u32 capacitance)
> -{
> -	struct freq_table *freq_table = cpufreq_cdev->freq_table;
> -	struct dev_pm_opp *opp;
> -	struct device *dev = NULL;
> -	int num_opps = 0, cpu = cpufreq_cdev->policy->cpu, i;
> -
> -	dev = get_cpu_device(cpu);
> -	if (unlikely(!dev)) {
> -		pr_warn("No cpu device for cpu %d\n", cpu);
> -		return -ENODEV;
> -	}
> -
> -	num_opps = dev_pm_opp_get_opp_count(dev);
> -	if (num_opps < 0)
> -		return num_opps;
> -
> -	/*
> -	 * The cpufreq table is also built from the OPP table and so the count
> -	 * should match.
> -	 */
> -	if (num_opps != cpufreq_cdev->max_level + 1) {
> -		dev_warn(dev, "Number of OPPs not matching with max_levels\n");
> -		return -EINVAL;
> -	}
> -
> -	for (i = 0; i <= cpufreq_cdev->max_level; i++) {
> -		unsigned long freq = freq_table[i].frequency * 1000;
> -		u32 freq_mhz = freq_table[i].frequency / 1000;
> -		u64 power;
> -		u32 voltage_mv;
> -
> -		/*
> -		 * Find ceil frequency as 'freq' may be slightly lower than OPP
> -		 * freq due to truncation while converting to kHz.
> -		 */
> -		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> -		if (IS_ERR(opp)) {
> -			dev_err(dev, "failed to get opp for %lu frequency\n",
> -				freq);
> -			return -EINVAL;
> -		}
> -
> -		voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
> -		dev_pm_opp_put(opp);
> -
> -		/*
> -		 * Do the multiplication with MHz and millivolt so as
> -		 * to not overflow.
> -		 */
> -		power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> -		do_div(power, 1000000000);
> -
> -		/* power is stored in mW */
> -		freq_table[i].power = power;
>  	}
>  
> -	return 0;
> +	return cpufreq_cdev->max_level - i - 1;
>  }
>  
>  static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
>  			     u32 freq)
>  {
>  	int i;
> -	struct freq_table *freq_table = cpufreq_cdev->freq_table;
>  
> -	for (i = 1; i <= cpufreq_cdev->max_level; i++)
> -		if (freq > freq_table[i].frequency)
> +	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> +		if (freq > cpufreq_cdev->em->table[i].frequency)
>  			break;
> +	}
>  
> -	return freq_table[i - 1].power;
> +	return cpufreq_cdev->em->table[i + 1].power;
>  }
>  
>  static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  			     u32 power)
>  {
>  	int i;
> -	struct freq_table *freq_table = cpufreq_cdev->freq_table;
>  
> -	for (i = 1; i <= cpufreq_cdev->max_level; i++)
> -		if (power > freq_table[i].power)
> +	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> +		if (power > cpufreq_cdev->em->table[i].power)
>  			break;
> +	}
>  
> -	return freq_table[i - 1].frequency;
> +	return cpufreq_cdev->em->table[i + 1].frequency;
>  }
>  
>  /**
> @@ -410,7 +322,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
>  			       struct thermal_zone_device *tz,
>  			       unsigned long state, u32 *power)
>  {
> -	unsigned int freq, num_cpus;
> +	unsigned int freq, num_cpus, idx;
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
>  
>  	/* Request state should be less than max_level */
> @@ -419,7 +331,8 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
>  
>  	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
>  
> -	freq = cpufreq_cdev->freq_table[state].frequency;
> +	idx = cpufreq_cdev->max_level - state;
> +	freq = cpufreq_cdev->em->table[idx].frequency;
>  	*power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
>  
>  	return 0;
> @@ -463,8 +376,60 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
>  				      power);
>  	return 0;
>  }
> +
> +static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
> +			      struct em_perf_domain *em) {
> +	struct cpufreq_policy *policy;
> +	unsigned int nr_levels;
> +
> +	if (!em)
> +		return false;
> +
> +	policy = cpufreq_cdev->policy;
> +	if (!cpumask_equal(policy->related_cpus, to_cpumask(em->cpus))) {
> +		pr_err("The span of pd %*pbl is misaligned with cpufreq policy %*pbl\n",
> +			cpumask_pr_args(to_cpumask(em->cpus)),
> +			cpumask_pr_args(policy->related_cpus));
> +		return false;
> +	}
> +
> +	nr_levels = cpufreq_cdev->max_level + 1;
> +	if (em->nr_cap_states != nr_levels) {
> +		pr_err("The number of cap states in pd %*pbl (%u) doesn't match the number of cooling levels (%u)\n",
> +			cpumask_pr_args(to_cpumask(em->cpus)),
> +			em->nr_cap_states, nr_levels);
> +		return false;
> +	}
> +
> +	return true;
> +}
>  #endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
>  
> +static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> +                             unsigned long state)
> +{
> +       struct cpufreq_policy *policy;
> +       unsigned long idx;
> +
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> +       /* Use the Energy Model table if available */
> +       if (cpufreq_cdev->em) {
> +               idx = cpufreq_cdev->max_level - state;
> +               return cpufreq_cdev->em->table[idx].frequency;
> +       }
> +#endif
> +
> +       /* Otherwise, fallback on the CPUFreq table */
> +       policy = cpufreq_cdev->policy;
> +       if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> +               idx = cpufreq_cdev->max_level - state;
> +       else
> +               idx = state;
> +
> +       return policy->freq_table[idx].frequency;
> +}
> +
> +
>  /* cpufreq cooling device callback functions are defined below */
>  
>  /**
> @@ -530,7 +495,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  	if (cpufreq_cdev->cpufreq_state == state)
>  		return 0;
>  
> -	clip_freq = cpufreq_cdev->freq_table[state].frequency;
> +	clip_freq = get_state_freq(cpufreq_cdev, state);
>  	cpufreq_cdev->cpufreq_state = state;
>  	cpufreq_cdev->clipped_freq = clip_freq;
>  
> @@ -552,26 +517,12 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
>  	.notifier_call = cpufreq_thermal_notifier,
>  };
>  
> -static unsigned int find_next_max(struct cpufreq_frequency_table *table,
> -				  unsigned int prev_max)
> -{
> -	struct cpufreq_frequency_table *pos;
> -	unsigned int max = 0;
> -
> -	cpufreq_for_each_valid_entry(pos, table) {
> -		if (pos->frequency > max && pos->frequency < prev_max)
> -			max = pos->frequency;
> -	}
> -
> -	return max;
> -}
> -
>  /**
>   * __cpufreq_cooling_register - helper function to create cpufreq cooling device
>   * @np: a valid struct device_node to the cooling device device tree node
>   * @policy: cpufreq policy
>   * Normally this should be same as cpufreq policy->related_cpus.
> - * @capacitance: dynamic power coefficient for these cpus
> + * @em: Energy Model of the cpufreq policy
>   *
>   * This interface function registers the cpufreq cooling device with the name
>   * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
> @@ -583,12 +534,13 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
>   */
>  static struct thermal_cooling_device *
>  __cpufreq_cooling_register(struct device_node *np,
> -			struct cpufreq_policy *policy, u32 capacitance)
> +			struct cpufreq_policy *policy,
> +			struct em_perf_domain *em)
>  {
>  	struct thermal_cooling_device *cdev;
>  	struct cpufreq_cooling_device *cpufreq_cdev;
>  	char dev_name[THERMAL_NAME_LENGTH];
> -	unsigned int freq, i, num_cpus;
> +	unsigned int i, num_cpus;
>  	int ret;
>  	struct thermal_cooling_device_ops *cooling_ops;
>  	bool first;
> @@ -622,55 +574,38 @@ __cpufreq_cooling_register(struct device_node *np,
>  	/* max_level is an index, not a counter */
>  	cpufreq_cdev->max_level = i - 1;
>  
> -	cpufreq_cdev->freq_table = kmalloc_array(i,
> -					sizeof(*cpufreq_cdev->freq_table),
> -					GFP_KERNEL);
> -	if (!cpufreq_cdev->freq_table) {
> -		cdev = ERR_PTR(-ENOMEM);
> -		goto free_idle_time;
> -	}
> -
>  	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
>  		cdev = ERR_PTR(ret);
> -		goto free_table;
> +		goto free_idle_time;
>  	}
>  	cpufreq_cdev->id = ret;
>  
>  	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
>  		 cpufreq_cdev->id);
>  
> -	/* Fill freq-table in descending order of frequencies */
> -	for (i = 0, freq = -1; i <= cpufreq_cdev->max_level; i++) {
> -		freq = find_next_max(policy->freq_table, freq);
> -		cpufreq_cdev->freq_table[i].frequency = freq;
> -
> -		/* Warn for duplicate entries */
> -		if (!freq)
> -			pr_warn("%s: table has duplicate entries\n", __func__);
> -		else
> -			pr_debug("%s: freq:%u KHz\n", __func__, freq);
> -	}
> -
>  	cooling_ops = &cpufreq_cooling_ops;
>  #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> -	if (capacitance) {
> -		ret = update_freq_table(cpufreq_cdev, capacitance);
> -		if (ret) {
> -			cdev = ERR_PTR(ret);
> -			goto remove_ida;
> -		}
> +	if (em_is_sane(cpufreq_cdev, em)) {
> +		cpufreq_cdev->em = em;
>  		cooling_ops->get_requested_power = cpufreq_get_requested_power;
>  		cooling_ops->state2power = cpufreq_state2power;
>  		cooling_ops->power2state = cpufreq_power2state;
> -	}
> +	} else
>  #endif
> +	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {
> +		pr_err("%s: unsorted frequency tables are not supported\n",
> +				__func__);
> +		cdev = ERR_PTR(-EINVAL);
> +		goto remove_ida;
> +	}
> +
>  	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
>  						  cooling_ops);
>  	if (IS_ERR(cdev))
>  		goto remove_ida;
>  
> -	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
> +	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
>  
>  	mutex_lock(&cooling_list_lock);
>  	/* Register the notifier for first cpufreq cooling device */
> @@ -686,8 +621,6 @@ __cpufreq_cooling_register(struct device_node *np,
>  
>  remove_ida:
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> -free_table:
> -	kfree(cpufreq_cdev->freq_table);
>  free_idle_time:
>  	kfree(cpufreq_cdev->idle_time);
>  free_cdev:
> @@ -709,7 +642,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  struct thermal_cooling_device *
>  cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> -	return __cpufreq_cooling_register(NULL, policy, 0);
> +	return __cpufreq_cooling_register(NULL, policy, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
>  
> @@ -737,7 +670,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
>  	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
>  	struct thermal_cooling_device *cdev = NULL;
> -	u32 capacitance = 0;
>  
>  	if (!np) {
>  		pr_err("cpu_cooling: OF node not available for cpu%d\n",
> @@ -746,10 +678,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
>  	}
>  
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		of_property_read_u32(np, "dynamic-power-coefficient",
> -				     &capacitance);
> +		struct em_perf_domain *em = em_cpu_get(policy->cpu);
>  
> -		cdev = __cpufreq_cooling_register(np, policy, capacitance);
> +		cdev = __cpufreq_cooling_register(np, policy, em);
>  		if (IS_ERR(cdev)) {
>  			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
>  			       policy->cpu, PTR_ERR(cdev));
> @@ -791,7 +722,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  	thermal_cooling_device_unregister(cdev);
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>  	kfree(cpufreq_cdev->idle_time);
> -	kfree(cpufreq_cdev->freq_table);
>  	kfree(cpufreq_cdev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

