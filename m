Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6831C115
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 05:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfENDlE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 23:41:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35021 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfENDlE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 23:41:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so8341298pfa.2;
        Mon, 13 May 2019 20:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TLbBxcNH0WeD0BKtSA/Uc69uT8WQkGkN+bEzuyZ7KLs=;
        b=rPBKX41T4S7cCCn9jIzU3s2TuMa/olhowD3zDRrAt10AJWHrZt3s8bIqA2DMASazxj
         ZkIvr58xWmUmotaX2PxqwnHNt+APLHpaReUt8FH4m6xE7qM9Bf29urB7CzUf5blGGd3e
         r+9yufFIuRVnkpzIG0pD/0SSkwu4qWy4mSjjmS0HN0E6gnjxjHYM6xZzNIwjut4W+d1A
         NFgJI2jnjPzssHARpMX7zH9s+j5sjOcrMGT1yx/SsaRfD1AV/w0QRNLC/gwqg8oO92dX
         cil6teXTB3Srlrse2QYhUcPSx99ALFPRWYlO8oB3WGx5WKAfWEE5M5QnZm/KaPoGqVtV
         N/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TLbBxcNH0WeD0BKtSA/Uc69uT8WQkGkN+bEzuyZ7KLs=;
        b=gYufl1ZmJJWclHcO/V0nXwSUrAh6PN9blH5b+5vG4tXXSNvYZC1q4llklBuC5NZTu3
         n33xCEaWATw80/kkiHs3Z+EeVdmtmq8cEwiE8B82hRcC+PBf0ZS5ZtLsEYel6kpVulTL
         QcKTTwwMA0HKwroZygE9C83Jz2MDX+2rwLaM2JmrzJ4vmz/kcQ1MN18zhC8I3ScVVEJ6
         aYXgzb85aRz4dfv8xLBN6JGvvRl78JJapKNn/JAhrwZh+YpGPRdTJbp8h3LkFk7Ad3YL
         vq7VAUBAke19S5BigaA/H868+TidvOrjLutNYKtDQLIikn5ZZa1SW6Hj1I2UsvdKJR2L
         GKUA==
X-Gm-Message-State: APjAAAVST867x0aa3tI3ZE6O8xsm8Y3o0NVc7frxv3rYpf+R1fTmERwm
        vthdTvi4oETBA8UziLVR6DM=
X-Google-Smtp-Source: APXvYqwYZkyubLaMqtveOQIiJFkxmdLxbVCdxF56uUWta2ysReW5y4m0Lu+35i4noEKCMWJYf6MgZQ==
X-Received: by 2002:a63:fd0c:: with SMTP id d12mr36025157pgh.391.1557805262437;
        Mon, 13 May 2019 20:41:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id e29sm17205008pgb.37.2019.05.13.20.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 20:41:01 -0700 (PDT)
Date:   Mon, 13 May 2019 20:40:59 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190514034056.GA5621@localhost.localdomain>
References: <20190503094409.3499-1-quentin.perret@arm.com>
 <20190503094409.3499-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190503094409.3499-4-quentin.perret@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 03, 2019 at 10:44:09AM +0100, Quentin Perret wrote:
> The newly introduced Energy Model framework manages power cost tables in
> a generic way. Moreover, it supports a several types of models since the
> tables can come from DT or firmware (through SCMI) for example. On the
> other hand, the cpu_cooling subsystem manages its own power cost tables
> using only DT data.
>=20
> In order to avoid the duplication of data in the kernel, and in order to
> enable IPA with EMs coming from more than just DT, remove the private
> tables from cpu_cooling.c and migrate it to using the centralized EM
> framework.
>=20
> The case where the thermal subsystem is used without an Energy Model
> (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> frequency table which is already a dependency for cpu_cooling.c anyway.
> Since the thermal framework expects the cooling states in a particular
> order, bail out whenever the CPUFreq table is unsorted, since that is
> fairly uncommon in general, and there are currently no users of
> cpu_cooling for this use-case.

Will this break DT in any way? After this change, are the existing DTs
still compatible with this cpu cooling?

>=20
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/thermal/Kconfig       |   1 +
>  drivers/thermal/cpu_cooling.c | 238 ++++++++++++----------------------
>  2 files changed, 82 insertions(+), 157 deletions(-)
>=20
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 653aa27a25a4..d695bd33c440 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -144,6 +144,7 @@ config THERMAL_GOV_USER_SPACE
> =20
>  config THERMAL_GOV_POWER_ALLOCATOR
>  	bool "Power allocator thermal governor"
> +	depends on ENERGY_MODEL
>  	help
>  	  Enable this to manage platform thermals by dynamically
>  	  allocating and limiting power to devices.
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..322ea89dd078 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/energy_model.h>
> =20
>  #include <trace/events/thermal.h>
> =20
> @@ -48,19 +49,6 @@
>   *	...
>   */
> =20
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
> -	u32 power;
> -};
> -
>  /**
>   * struct time_in_idle - Idle time stats
>   * @time: previous reading of the absolute time that this cpu was idle
> @@ -82,7 +70,7 @@ struct time_in_idle {
>   *	frequency.
>   * @max_level: maximum cooling level. One less than total number of valid
>   *	cpufreq frequencies.
> - * @freq_table: Freq table in descending order of frequencies
> + * @em: Reference on the Energy Model of the device
>   * @cdev: thermal_cooling_device pointer to keep track of the
>   *	registered cooling device.
>   * @policy: cpufreq policy.
> @@ -98,7 +86,7 @@ struct cpufreq_cooling_device {
>  	unsigned int cpufreq_state;
>  	unsigned int clipped_freq;
>  	unsigned int max_level;
> -	struct freq_table *freq_table;	/* In descending order */
> +	struct em_perf_domain *em;
>  	struct thermal_cooling_device *cdev;
>  	struct cpufreq_policy *policy;
>  	struct list_head node;
> @@ -121,14 +109,14 @@ static LIST_HEAD(cpufreq_cdev_list);
>  static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cd=
ev,
>  			       unsigned int freq)
>  {
> -	struct freq_table *freq_table =3D cpufreq_cdev->freq_table;
> -	unsigned long level;
> +	int i;
> =20
> -	for (level =3D 1; level <=3D cpufreq_cdev->max_level; level++)
> -		if (freq > freq_table[level].frequency)
> +	for (i =3D cpufreq_cdev->max_level - 1; i >=3D 0; i--) {
> +		if (freq > cpufreq_cdev->em->table[i].frequency)
>  			break;
> +	}
> =20
> -	return level - 1;
> +	return cpufreq_cdev->max_level - i - 1;
>  }
> =20
>  /**
> @@ -184,105 +172,30 @@ static int cpufreq_thermal_notifier(struct notifie=
r_block *nb,
>  	return NOTIFY_OK;
>  }
> =20
> -/**
> - * update_freq_table() - Update the freq table with power numbers
> - * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
> - * @capacitance: dynamic power coefficient for these cpus
> - *
> - * Update the freq table with power numbers.  This table will be used in
> - * cpu_power_to_freq() and cpu_freq_to_power() to convert between power =
and
> - * frequency efficiently.  Power is stored in mW, frequency in KHz.  The
> - * resulting table is in descending order.
> - *
> - * Return: 0 on success, -EINVAL if there are no OPPs for any CPUs,
> - * or -ENOMEM if we run out of memory.
> - */
> -static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
> -			     u32 capacitance)
> -{
> -	struct freq_table *freq_table =3D cpufreq_cdev->freq_table;
> -	struct dev_pm_opp *opp;
> -	struct device *dev =3D NULL;
> -	int num_opps =3D 0, cpu =3D cpufreq_cdev->policy->cpu, i;
> -
> -	dev =3D get_cpu_device(cpu);
> -	if (unlikely(!dev)) {
> -		dev_warn(&cpufreq_cdev->cdev->device,
> -			 "No cpu device for cpu %d\n", cpu);
> -		return -ENODEV;
> -	}
> -
> -	num_opps =3D dev_pm_opp_get_opp_count(dev);
> -	if (num_opps < 0)
> -		return num_opps;
> -
> -	/*
> -	 * The cpufreq table is also built from the OPP table and so the count
> -	 * should match.
> -	 */
> -	if (num_opps !=3D cpufreq_cdev->max_level + 1) {
> -		dev_warn(dev, "Number of OPPs not matching with max_levels\n");
> -		return -EINVAL;
> -	}
> -
> -	for (i =3D 0; i <=3D cpufreq_cdev->max_level; i++) {
> -		unsigned long freq =3D freq_table[i].frequency * 1000;
> -		u32 freq_mhz =3D freq_table[i].frequency / 1000;
> -		u64 power;
> -		u32 voltage_mv;
> -
> -		/*
> -		 * Find ceil frequency as 'freq' may be slightly lower than OPP
> -		 * freq due to truncation while converting to kHz.
> -		 */
> -		opp =3D dev_pm_opp_find_freq_ceil(dev, &freq);
> -		if (IS_ERR(opp)) {
> -			dev_err(dev, "failed to get opp for %lu frequency\n",
> -				freq);
> -			return -EINVAL;
> -		}
> -
> -		voltage_mv =3D dev_pm_opp_get_voltage(opp) / 1000;
> -		dev_pm_opp_put(opp);
> -
> -		/*
> -		 * Do the multiplication with MHz and millivolt so as
> -		 * to not overflow.
> -		 */
> -		power =3D (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> -		do_div(power, 1000000000);
> -
> -		/* power is stored in mW */
> -		freq_table[i].power =3D power;
> -	}
> -
> -	return 0;
> -}
> -
>  static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
>  			     u32 freq)
>  {
>  	int i;
> -	struct freq_table *freq_table =3D cpufreq_cdev->freq_table;
> =20
> -	for (i =3D 1; i <=3D cpufreq_cdev->max_level; i++)
> -		if (freq > freq_table[i].frequency)
> +	for (i =3D cpufreq_cdev->max_level - 1; i >=3D 0; i--) {
> +		if (freq > cpufreq_cdev->em->table[i].frequency)
>  			break;
> +	}
> =20
> -	return freq_table[i - 1].power;
> +	return cpufreq_cdev->em->table[i + 1].power;
>  }
> =20
>  static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  			     u32 power)
>  {
>  	int i;
> -	struct freq_table *freq_table =3D cpufreq_cdev->freq_table;
> =20
> -	for (i =3D 1; i <=3D cpufreq_cdev->max_level; i++)
> -		if (power > freq_table[i].power)
> +	for (i =3D cpufreq_cdev->max_level - 1; i >=3D 0; i--) {
> +		if (power > cpufreq_cdev->em->table[i].power)
>  			break;
> +	}
> =20
> -	return freq_table[i - 1].frequency;
> +	return cpufreq_cdev->em->table[i + 1].frequency;
>  }
> =20
>  /**
> @@ -374,6 +287,28 @@ static int cpufreq_get_cur_state(struct thermal_cool=
ing_device *cdev,
>  	return 0;
>  }
> =20
> +static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufre=
q_cdev,
> +			      unsigned long state)
> +{
> +	struct cpufreq_policy *policy;
> +	unsigned long idx;
> +
> +	/* Use the Energy Model table if available */
> +	if (cpufreq_cdev->em) {
> +		idx =3D cpufreq_cdev->max_level - state;
> +		return cpufreq_cdev->em->table[idx].frequency;
> +	}
> +
> +	/* Otherwise, fallback on the CPUFreq table */
> +	policy =3D cpufreq_cdev->policy;
> +	if (policy->freq_table_sorted =3D=3D CPUFREQ_TABLE_SORTED_ASCENDING)
> +		idx =3D cpufreq_cdev->max_level - state;
> +	else
> +		idx =3D state;
> +
> +	return policy->freq_table[idx].frequency;
> +}
> +
>  /**
>   * cpufreq_set_cur_state - callback function to set the current cooling =
state.
>   * @cdev: thermal cooling device pointer.
> @@ -398,7 +333,7 @@ static int cpufreq_set_cur_state(struct thermal_cooli=
ng_device *cdev,
>  	if (cpufreq_cdev->cpufreq_state =3D=3D state)
>  		return 0;
> =20
> -	clip_freq =3D cpufreq_cdev->freq_table[state].frequency;
> +	clip_freq =3D get_state_freq(cpufreq_cdev, state);
>  	cpufreq_cdev->cpufreq_state =3D state;
>  	cpufreq_cdev->clipped_freq =3D clip_freq;
> =20
> @@ -497,7 +432,7 @@ static int cpufreq_state2power(struct thermal_cooling=
_device *cdev,
>  			       struct thermal_zone_device *tz,
>  			       unsigned long state, u32 *power)
>  {
> -	unsigned int freq, num_cpus;
> +	unsigned int freq, num_cpus, idx;
>  	struct cpufreq_cooling_device *cpufreq_cdev =3D cdev->devdata;
> =20
>  	/* Request state should be less than max_level */
> @@ -506,7 +441,8 @@ static int cpufreq_state2power(struct thermal_cooling=
_device *cdev,
> =20
>  	num_cpus =3D cpumask_weight(cpufreq_cdev->policy->cpus);
> =20
> -	freq =3D cpufreq_cdev->freq_table[state].frequency;
> +	idx =3D cpufreq_cdev->max_level - state;
> +	freq =3D cpufreq_cdev->em->table[idx].frequency;
>  	*power =3D cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
> =20
>  	return 0;
> @@ -559,7 +495,6 @@ static struct thermal_cooling_device_ops cpufreq_cool=
ing_ops =3D {
>  	.get_cur_state =3D cpufreq_get_cur_state,
>  	.set_cur_state =3D cpufreq_set_cur_state,
>  };
> -
>  static struct thermal_cooling_device_ops cpufreq_power_cooling_ops =3D {
>  	.get_max_state		=3D cpufreq_get_max_state,
>  	.get_cur_state		=3D cpufreq_get_cur_state,
> @@ -574,18 +509,31 @@ static struct notifier_block thermal_cpufreq_notifi=
er_block =3D {
>  	.notifier_call =3D cpufreq_thermal_notifier,
>  };
> =20
> -static unsigned int find_next_max(struct cpufreq_frequency_table *table,
> -				  unsigned int prev_max)
> -{
> -	struct cpufreq_frequency_table *pos;
> -	unsigned int max =3D 0;
> +static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cde=
v,
> +			      struct em_perf_domain *em) {
> +	struct cpufreq_policy *policy;
> +	unsigned int nr_levels;
> =20
> -	cpufreq_for_each_valid_entry(pos, table) {
> -		if (pos->frequency > max && pos->frequency < prev_max)
> -			max =3D pos->frequency;
> +	if (!em)
> +		return false;
> +
> +	policy =3D cpufreq_cdev->policy;
> +	if (!cpumask_equal(policy->related_cpus, to_cpumask(em->cpus))) {
> +		pr_err("The span of pd %*pbl is misaligned with cpufreq policy %*pbl\n=
",
> +			cpumask_pr_args(to_cpumask(em->cpus)),
> +			cpumask_pr_args(policy->related_cpus));
> +		return false;
>  	}
> =20
> -	return max;
> +	nr_levels =3D cpufreq_cdev->max_level + 1;
> +	if (em->nr_cap_states !=3D nr_levels) {
> +		pr_err("The number of cap states in pd %*pbl (%u) doesn't match the nu=
mber of cooling levels (%u)\n",
> +			cpumask_pr_args(to_cpumask(em->cpus)),
> +			em->nr_cap_states, nr_levels);
> +		return false;
> +	}
> +
> +	return true;
>  }
> =20
>  /**
> @@ -593,7 +541,7 @@ static unsigned int find_next_max(struct cpufreq_freq=
uency_table *table,
>   * @np: a valid struct device_node to the cooling device device tree node
>   * @policy: cpufreq policy
>   * Normally this should be same as cpufreq policy->related_cpus.
> - * @capacitance: dynamic power coefficient for these cpus
> + * @em: Energy Model of the cpufreq policy
>   *
>   * This interface function registers the cpufreq cooling device with the=
 name
>   * "thermal-cpufreq-%x". This api can support multiple instances of cpuf=
req
> @@ -605,12 +553,13 @@ static unsigned int find_next_max(struct cpufreq_fr=
equency_table *table,
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
> @@ -644,46 +593,26 @@ __cpufreq_cooling_register(struct device_node *np,
>  	/* max_level is an index, not a counter */
>  	cpufreq_cdev->max_level =3D i - 1;
> =20
> -	cpufreq_cdev->freq_table =3D kmalloc_array(i,
> -					sizeof(*cpufreq_cdev->freq_table),
> -					GFP_KERNEL);
> -	if (!cpufreq_cdev->freq_table) {
> -		cdev =3D ERR_PTR(-ENOMEM);
> -		goto free_idle_time;
> -	}
> -
>  	ret =3D ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
>  		cdev =3D ERR_PTR(ret);
> -		goto free_table;
> +		goto free_idle_time;
>  	}
>  	cpufreq_cdev->id =3D ret;
> =20
>  	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
>  		 cpufreq_cdev->id);
> =20
> -	/* Fill freq-table in descending order of frequencies */
> -	for (i =3D 0, freq =3D -1; i <=3D cpufreq_cdev->max_level; i++) {
> -		freq =3D find_next_max(policy->freq_table, freq);
> -		cpufreq_cdev->freq_table[i].frequency =3D freq;
> -
> -		/* Warn for duplicate entries */
> -		if (!freq)
> -			pr_warn("%s: table has duplicate entries\n", __func__);
> -		else
> -			pr_debug("%s: freq:%u KHz\n", __func__, freq);
> -	}
> -
> -	if (capacitance) {
> -		ret =3D update_freq_table(cpufreq_cdev, capacitance);
> -		if (ret) {
> -			cdev =3D ERR_PTR(ret);
> -			goto remove_ida;
> -		}
> -
> +	if (em_is_sane(cpufreq_cdev, em)) {
> +		cpufreq_cdev->em =3D em;
>  		cooling_ops =3D &cpufreq_power_cooling_ops;
> -	} else {
> +	} else if (policy->freq_table_sorted !=3D CPUFREQ_TABLE_UNSORTED) {
>  		cooling_ops =3D &cpufreq_cooling_ops;
> +	} else {
> +		pr_err("%s: unsorted frequency tables are not supported\n",
> +				__func__);
> +		cdev =3D ERR_PTR(-EINVAL);
> +		goto remove_ida;
>  	}
> =20
>  	cdev =3D thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
> @@ -691,7 +620,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  	if (IS_ERR(cdev))
>  		goto remove_ida;
> =20
> -	cpufreq_cdev->clipped_freq =3D cpufreq_cdev->freq_table[0].frequency;
> +	cpufreq_cdev->clipped_freq =3D get_state_freq(cpufreq_cdev, 0);
>  	cpufreq_cdev->cdev =3D cdev;
> =20
>  	mutex_lock(&cooling_list_lock);
> @@ -708,8 +637,6 @@ __cpufreq_cooling_register(struct device_node *np,
> =20
>  remove_ida:
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> -free_table:
> -	kfree(cpufreq_cdev->freq_table);
>  free_idle_time:
>  	kfree(cpufreq_cdev->idle_time);
>  free_cdev:
> @@ -731,7 +658,7 @@ __cpufreq_cooling_register(struct device_node *np,
>  struct thermal_cooling_device *
>  cpufreq_cooling_register(struct cpufreq_policy *policy)
>  {
> -	return __cpufreq_cooling_register(NULL, policy, 0);
> +	return __cpufreq_cooling_register(NULL, policy, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
> =20
> @@ -759,7 +686,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *po=
licy)
>  {
>  	struct device_node *np =3D of_get_cpu_node(policy->cpu, NULL);
>  	struct thermal_cooling_device *cdev =3D NULL;
> -	u32 capacitance =3D 0;
> =20
>  	if (!np) {
>  		pr_err("cpu_cooling: OF node not available for cpu%d\n",
> @@ -768,10 +694,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *p=
olicy)
>  	}
> =20
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		of_property_read_u32(np, "dynamic-power-coefficient",
> -				     &capacitance);
> +		struct em_perf_domain *em =3D em_cpu_get(policy->cpu);
> =20
> -		cdev =3D __cpufreq_cooling_register(np, policy, capacitance);
> +		cdev =3D __cpufreq_cooling_register(np, policy, em);
>  		if (IS_ERR(cdev)) {
>  			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\=
n",
>  			       policy->cpu, PTR_ERR(cdev));
> @@ -813,7 +738,6 @@ void cpufreq_cooling_unregister(struct thermal_coolin=
g_device *cdev)
>  	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
>  	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>  	kfree(cpufreq_cdev->idle_time);
> -	kfree(cpufreq_cdev->freq_table);
>  	kfree(cpufreq_cdev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
