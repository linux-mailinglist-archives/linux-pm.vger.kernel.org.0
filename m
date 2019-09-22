Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5FDBAB8D
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2019 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfIVUMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Sep 2019 16:12:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35829 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbfIVUMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Sep 2019 16:12:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so11667155lji.2;
        Sun, 22 Sep 2019 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KjABDSCC60PZzpx+ys1KaadWQd+C/lrMuTfmGfkb0l8=;
        b=WhPOeU8rhP6/0GqB5FDgC6Av0XM8F8ShHLlL4pkuw0h2+OJWcHwzj3Op9o1B69fujk
         DRNrNlQPSHn4MZ4uuESSMrevEBOMXCa+vMgmn/7dK4ycG4HbH1MZdvHJgN5sk9iMbozA
         oFVSJ02wbfhmrGwBzuJcINUYkhEwzKzVYxESSBBDoMMVuRiuFvdZEnPPzbBoKpLDKqiB
         XUYnZJQ0yPsssx+tPiaQeHvjtHmCiZjyGmbn6r5aNkV9tkdpLXLFxzw/aTO40jPS0l9k
         iPtJ25jkgdV4n7ISKkBGsyOxsxXyZFfR7rYbP14ly027TnmyjfFREBwuvWbf28Yq3Q/j
         JrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KjABDSCC60PZzpx+ys1KaadWQd+C/lrMuTfmGfkb0l8=;
        b=maVgT/jAxiQxfUuYsjtbmPwhf18sq4d9EVH7sCdsY3JZmH3C3QfGDHzTh8hOy1QrpE
         MVFagLcxKcs92bZ09anMcgtS/EimaVz7WSDrll8Mufx7l86ddhHGmMAlcqiqRatgb7aU
         2RGaK6rcwzHF0PP80FUHhd1HRukcZUEm/aSgzpSUwLe+byhelODTtUVPhhqyJSHJlJ4z
         XkdfgkmkKk6PkoYQ6HOf+YtKmWWEN8LKlkqCypW9Rp7ZbppMcE6R5MbG2vTo5zyQSx0n
         Zz8GGFTl7u0xgxDqflggkpBe/NcT43LeZvVz/E2UOqKBdTUIRalWdLfNWbRu1RBpSDlz
         QVZw==
X-Gm-Message-State: APjAAAUgCa9EFL3ZvjjPXv8zvGnoJ9Y+TrVPi1ojaHdSguIvL6e3F5wR
        18JaDS0FHdolrrEZYOeNTKueAUka
X-Google-Smtp-Source: APXvYqwAZbp55Foew1PIgd8h98fTLrHZi7EOztOzv8orKZkA/fHEy/1T/KrzG45/LHeGXG+jpjkt+g==
X-Received: by 2002:a2e:8789:: with SMTP id n9mr15570738lji.52.1569183154311;
        Sun, 22 Sep 2019 13:12:34 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-32-67.pppoe.spdop.ru. [94.29.32.67])
        by smtp.googlemail.com with ESMTPSA id g10sm1759003lfb.76.2019.09.22.13.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 13:12:33 -0700 (PDT)
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS
 framework
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        ulf.hansson@linaro.org, sfr@canb.auug.org.au, pavel@ucw.cz,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
Date:   Sun, 22 Sep 2019 23:12:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.07.2019 13:57, Viresh Kumar пишет:
> This registers the notifiers for min/max frequency constraints with the
> PM QoS framework. The constraints are also taken into consideration in
> cpufreq_set_policy().
> 
> This also relocates cpufreq_policy_put_kobj() as it is required to be
> called from cpufreq_policy_alloc() now.
> 
> refresh_frequency_limits() is updated to avoid calling
> cpufreq_set_policy() for inactive policies and handle_update() is
> updated to have proper locking in place.
> 
> No constraints are added until now though.
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> V6->V7:
> - All callers of refresh_frequency_limits(), except handle_update(),
>   take the policy->rwsem and result in deadlock as
>   refresh_frequency_limits() also takes the same lock again. Fix that
>   by taking the rwsem from handle_update() instead.
> 
> @Rafael: Sending it before Pavel has verified it as I would be offline
> later, in case you want to apply this today itself.
> 
>  drivers/cpufreq/cpufreq.c | 135 +++++++++++++++++++++++++++++---------
>  include/linux/cpufreq.h   |   3 +
>  2 files changed, 108 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index ceb57af15ca0..b96ef6db1bfe 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
> @@ -999,7 +1000,7 @@ static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
>  {
>  	struct device *dev = get_cpu_device(cpu);
>  
> -	if (!dev)
> +	if (unlikely(!dev))
>  		return;
>  
>  	if (cpumask_test_and_set_cpu(cpu, policy->real_cpus))
> @@ -1117,14 +1118,16 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
>  
>  static void refresh_frequency_limits(struct cpufreq_policy *policy)
>  {
> -	struct cpufreq_policy new_policy = *policy;
> -
> -	pr_debug("updating policy for CPU %u\n", policy->cpu);
> +	struct cpufreq_policy new_policy;
>  
> -	new_policy.min = policy->user_policy.min;
> -	new_policy.max = policy->user_policy.max;
> +	if (!policy_is_inactive(policy)) {
> +		new_policy = *policy;
> +		pr_debug("updating policy for CPU %u\n", policy->cpu);
>  
> -	cpufreq_set_policy(policy, &new_policy);
> +		new_policy.min = policy->user_policy.min;
> +		new_policy.max = policy->user_policy.max;
> +		cpufreq_set_policy(policy, &new_policy);
> +	}
>  }
>  
>  static void handle_update(struct work_struct *work)
> @@ -1133,14 +1136,60 @@ static void handle_update(struct work_struct *work)
>  		container_of(work, struct cpufreq_policy, update);
>  
>  	pr_debug("handle_update for cpu %u called\n", policy->cpu);
> +	down_write(&policy->rwsem);
>  	refresh_frequency_limits(policy);
> +	up_write(&policy->rwsem);
> +}
> +
> +static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
> +				void *data)
> +{
> +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
> +
> +	schedule_work(&policy->update);
> +	return 0;
> +}
> +
> +static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
> +				void *data)
> +{
> +	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
> +
> +	schedule_work(&policy->update);
> +	return 0;
> +}
> +
> +static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
> +{
> +	struct kobject *kobj;
> +	struct completion *cmp;
> +
> +	down_write(&policy->rwsem);
> +	cpufreq_stats_free_table(policy);
> +	kobj = &policy->kobj;
> +	cmp = &policy->kobj_unregister;
> +	up_write(&policy->rwsem);
> +	kobject_put(kobj);
> +
> +	/*
> +	 * We need to make sure that the underlying kobj is
> +	 * actually not referenced anymore by anybody before we
> +	 * proceed with unloading.
> +	 */
> +	pr_debug("waiting for dropping of refcount\n");
> +	wait_for_completion(cmp);
> +	pr_debug("wait complete\n");
>  }
>  
>  static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy;
> +	struct device *dev = get_cpu_device(cpu);
>  	int ret;
>  
> +	if (!dev)
> +		return NULL;
> +
>  	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
>  	if (!policy)
>  		return NULL;
> @@ -1157,7 +1206,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
>  				   cpufreq_global_kobject, "policy%u", cpu);
>  	if (ret) {
> -		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
> +		dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
>  		/*
>  		 * The entire policy object will be freed below, but the extra
>  		 * memory allocated for the kobject name needs to be freed by
> @@ -1167,6 +1216,25 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  		goto err_free_real_cpus;
>  	}
>  
> +	policy->nb_min.notifier_call = cpufreq_notifier_min;
> +	policy->nb_max.notifier_call = cpufreq_notifier_max;
> +
> +	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
> +				      DEV_PM_QOS_MIN_FREQUENCY);
> +	if (ret) {
> +		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
> +			ret, cpumask_pr_args(policy->cpus));
> +		goto err_kobj_remove;
> +	}
> +
> +	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
> +				      DEV_PM_QOS_MAX_FREQUENCY);
> +	if (ret) {
> +		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
> +			ret, cpumask_pr_args(policy->cpus));
> +		goto err_min_qos_notifier;
> +	}
> +
>  	INIT_LIST_HEAD(&policy->policy_list);
>  	init_rwsem(&policy->rwsem);
>  	spin_lock_init(&policy->transition_lock);
> @@ -1177,6 +1245,11 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	policy->cpu = cpu;
>  	return policy;
>  
> +err_min_qos_notifier:
> +	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
> +				   DEV_PM_QOS_MIN_FREQUENCY);
> +err_kobj_remove:
> +	cpufreq_policy_put_kobj(policy);
>  err_free_real_cpus:
>  	free_cpumask_var(policy->real_cpus);
>  err_free_rcpumask:
> @@ -1189,30 +1262,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  	return NULL;
>  }
>  
> -static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
> -{
> -	struct kobject *kobj;
> -	struct completion *cmp;
> -
> -	down_write(&policy->rwsem);
> -	cpufreq_stats_free_table(policy);
> -	kobj = &policy->kobj;
> -	cmp = &policy->kobj_unregister;
> -	up_write(&policy->rwsem);
> -	kobject_put(kobj);
> -
> -	/*
> -	 * We need to make sure that the underlying kobj is
> -	 * actually not referenced anymore by anybody before we
> -	 * proceed with unloading.
> -	 */
> -	pr_debug("waiting for dropping of refcount\n");
> -	wait_for_completion(cmp);
> -	pr_debug("wait complete\n");
> -}
> -
>  static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  {
> +	struct device *dev = get_cpu_device(policy->cpu);
>  	unsigned long flags;
>  	int cpu;
>  
> @@ -1224,6 +1276,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  		per_cpu(cpufreq_cpu_data, cpu) = NULL;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
> +	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
> +				   DEV_PM_QOS_MAX_FREQUENCY);
> +	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
> +				   DEV_PM_QOS_MIN_FREQUENCY);
> +
>  	cpufreq_policy_put_kobj(policy);
>  	free_cpumask_var(policy->real_cpus);
>  	free_cpumask_var(policy->related_cpus);
> @@ -2283,6 +2340,8 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
>  		       struct cpufreq_policy *new_policy)
>  {
>  	struct cpufreq_governor *old_gov;
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	unsigned long min, max;
>  	int ret;
>  
>  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> @@ -2297,11 +2356,27 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	if (new_policy->min > new_policy->max)
>  		return -EINVAL;
>  
> +	/*
> +	 * PM QoS framework collects all the requests from users and provide us
> +	 * the final aggregated value here.
> +	 */
> +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> +
> +	if (min > new_policy->min)
> +		new_policy->min = min;
> +	if (max < new_policy->max)
> +		new_policy->max = max;
> +
>  	/* verify the cpu speed can be set within this limit */
>  	ret = cpufreq_driver->verify(new_policy);
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * The notifier-chain shall be removed once all the users of
> +	 * CPUFREQ_ADJUST are moved to use the QoS framework.
> +	 */
>  	/* adjust if necessary - all reasons */
>  	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  			CPUFREQ_ADJUST, new_policy);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index a1467aa7f58b..95425941f46d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -147,6 +147,9 @@ struct cpufreq_policy {
>  
>  	/* Pointer to the cooling device if used for thermal mitigation */
>  	struct thermal_cooling_device *cdev;
> +
> +	struct notifier_block nb_min;
> +	struct notifier_block nb_max;
>  };
>  
>  struct cpufreq_freqs {
> 

Hello Viresh,

This patch causes use-after-free on a cpufreq driver module reload. Please take a look, thanks in advance.


[   87.952369] ==================================================================
[   87.953259] BUG: KASAN: use-after-free in notifier_chain_register+0x4f/0x9c
[   87.954031] Read of size 4 at addr e6abbd0c by task modprobe/243

[   87.954901] CPU: 1 PID: 243 Comm: modprobe Tainted: G        W
5.3.0-next-20190920-00185-gf61698eab956-dirty #2408
[   87.956077] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   87.956807] [<c0110aad>] (unwind_backtrace) from [<c010bb71>] (show_stack+0x11/0x14)
[   87.957709] [<c010bb71>] (show_stack) from [<c0d37b25>] (dump_stack+0x89/0x98)
[   87.958616] [<c0d37b25>] (dump_stack) from [<c02937e1>]
(print_address_description.constprop.0+0x3d/0x340)
[   87.959785] [<c02937e1>] (print_address_description.constprop.0) from [<c0293c6b>]
(__kasan_report+0xe3/0x12c)
[   87.960907] [<c0293c6b>] (__kasan_report) from [<c014988f>] (notifier_chain_register+0x4f/0x9c)
[   87.962001] [<c014988f>] (notifier_chain_register) from [<c01499b5>]
(blocking_notifier_chain_register+0x29/0x3c)
[   87.963180] [<c01499b5>] (blocking_notifier_chain_register) from [<c06f7ee9>]
(dev_pm_qos_add_notifier+0x79/0xf8)
[   87.964339] [<c06f7ee9>] (dev_pm_qos_add_notifier) from [<c092927d>] (cpufreq_online+0x5e1/0x8a4)
[   87.965351] [<c092927d>] (cpufreq_online) from [<c09295c9>] (cpufreq_add_dev+0x79/0x80)
[   87.966247] [<c09295c9>] (cpufreq_add_dev) from [<c06eb9d3>] (subsys_interface_register+0xc3/0x100)
[   87.967297] [<c06eb9d3>] (subsys_interface_register) from [<c0926e53>]
(cpufreq_register_driver+0x13b/0x1ec)
[   87.968476] [<c0926e53>] (cpufreq_register_driver) from [<bf800435>]
(tegra20_cpufreq_probe+0x165/0x1a8 [tegra20_cpufreq])
[   87.969711] [<bf800435>] (tegra20_cpufreq_probe [tegra20_cpufreq]) from [<c06ef7a5>]
(platform_drv_probe+0x49/0x88)
[   87.970854] [<c06ef7a5>] (platform_drv_probe) from [<c06ed299>] (really_probe+0x109/0x374)
[   87.971771] [<c06ed299>] (really_probe) from [<c06ed64f>] (driver_probe_device+0x57/0x158)
[   87.972685] [<c06ed64f>] (driver_probe_device) from [<c06ed8fd>] (device_driver_attach+0x61/0x64)
[   87.973658] [<c06ed8fd>] (device_driver_attach) from [<c06ed949>] (__driver_attach+0x49/0xa0)
[   87.974599] [<c06ed949>] (__driver_attach) from [<c06eb62d>] (bus_for_each_dev+0x69/0x94)
[   87.975510] [<c06eb62d>] (bus_for_each_dev) from [<c06ec731>] (bus_add_driver+0x179/0x1e8)
[   87.976427] [<c06ec731>] (bus_add_driver) from [<c06ee4ab>] (driver_register+0x8f/0x130)
[   87.977345] [<c06ee4ab>] (driver_register) from [<bf805017>]
(tegra20_cpufreq_driver_init+0x17/0x1000 [tegra20_cpufreq])
[   87.978553] [<bf805017>] (tegra20_cpufreq_driver_init [tegra20_cpufreq]) from [<c0102f35>]
(do_one_initcall+0x4d/0x280)
[   87.979729] [<c0102f35>] (do_one_initcall) from [<c01c8675>] (do_init_module+0xb9/0x288)
[   87.980618] [<c01c8675>] (do_init_module) from [<c01cb105>] (load_module+0x2829/0x2b90)
[   87.981496] [<c01cb105>] (load_module) from [<c01cb62b>] (sys_finit_module+0x7b/0x8c)
[   87.982358] [<c01cb62b>] (sys_finit_module) from [<c0101001>] (ret_fast_syscall+0x1/0x26)
[   87.983240] Exception stack(0xe4babfa8 to 0xe4babff0)
[   87.983809] bfa0:                   0003f210 00000001 00000003 0002b744 00000000 b6611e64
[   87.984703] bfc0: 0003f210 00000001 29a92d00 0000017b 0003f2a8 00000000 0003f210 00040008
[   87.985588] bfe0: b6611de8 b6611dd8 00022534 aec402e0

[   87.986340] Allocated by task 182:
[   87.986756]  cpufreq_online+0x55f/0x8a4
[   87.987204]  cpufreq_add_dev+0x79/0x80
[   87.987641]  subsys_interface_register+0xc3/0x100
[   87.988178]  cpufreq_register_driver+0x13b/0x1ec
[   87.988719]  tegra20_cpufreq_probe+0x165/0x1a8 [tegra20_cpufreq]
[   87.989389]  platform_drv_probe+0x49/0x88
[   87.989849]  really_probe+0x109/0x374
[   88.021245]  driver_probe_device+0x57/0x158
[   88.052890]  device_driver_attach+0x61/0x64
[   88.084012]  __driver_attach+0x49/0xa0
[   88.114533]  bus_for_each_dev+0x69/0x94
[   88.144898]  bus_add_driver+0x179/0x1e8
[   88.174840]  driver_register+0x8f/0x130
[   88.204398]  tegra20_cpufreq_driver_init+0x17/0x1000 [tegra20_cpufreq]
[   88.234165]  do_one_initcall+0x4d/0x280
[   88.263754]  do_init_module+0xb9/0x288
[   88.292773]  load_module+0x2829/0x2b90
[   88.321106]  sys_finit_module+0x7b/0x8c
[   88.349098]  ret_fast_syscall+0x1/0x26
[   88.376732]  0xb6802c60

[   88.430292] Freed by task 239:
[   88.456279]  __kasan_slab_free+0x9f/0xc4
[   88.481802]  kfree+0x71/0x1f4
[   88.506805]  subsys_interface_unregister+0xad/0xf0
[   88.531524]  cpufreq_unregister_driver+0x2f/0x7c
[   88.555909]  tegra20_cpufreq_remove+0x19/0x48 [tegra20_cpufreq]
[   88.580273]  platform_drv_remove+0x27/0x34
[   88.604156]  device_release_driver_internal+0xdf/0x1a4
[   88.627659]  driver_detach+0x85/0xf8
[   88.650458]  bus_remove_driver+0x53/0xb0
[   88.672706]  tegra20_cpufreq_driver_exit+0x9/0xb88 [tegra20_cpufreq]
[   88.695100]  sys_delete_module+0x14d/0x1a0
[   88.717147]  ret_fast_syscall+0x1/0x26
[   88.738799]  0xb6d35ff4

[   88.780543] The buggy address belongs to the object at e6abbc00
                which belongs to the cache kmalloc-512 of size 512
[   88.821845] The buggy address is located 268 bytes inside of
                512-byte region [e6abbc00, e6abbe00)
[   88.861188] The buggy address belongs to the page:
[   88.880380] page:edcbc700 refcount:1 mapcount:0 mapping:e7001a00 index:0x0 compound_mapcount: 0
[   88.900167] flags: 0x10200(slab|head)
[   88.919599] raw: 00010200 edcafb00 00030003 e7001a00 00000000 00100010 ffffffff 00000001
[   88.939423] page dumped because: kasan: bad access detected

[   88.978080] Memory state around the buggy address:
[   88.997237]  e6abbc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   89.016710]  e6abbc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   89.036051] >e6abbd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   89.055192]               ^
[   89.074260]  e6abbd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   89.093832]  e6abbe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   89.113300] ==================================================================
