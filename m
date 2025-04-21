Return-Path: <linux-pm+bounces-25803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48134A951BB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33427A453A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC081262D29;
	Mon, 21 Apr 2025 13:36:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E026461D;
	Mon, 21 Apr 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242568; cv=none; b=MC4nJiGlC0G0YhsWDtcm/Q/AXBabrbx3mIKDkEAHxzfYzkwUkTJZnsMnyjMeUc+qhuyEH0hHcxiYPROlM8BvNNQwmh75m8XcBtTPC4pZqaf/JFJhUL5VJ8kifEp2djdjyffodhwcxBtj1DM2901X5Su0U2cgNiSoPNgWkjWwYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242568; c=relaxed/simple;
	bh=6STubb6yu4UpbdE2z9HBVtYn6wKDkzygjGD/KfyvTpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CWh1k8e8FAFMLvlHlT6U84bDY97EVQdCTrXOCRj+bb1RJGcWOv7+sr/NxgsLyyhVh43gtB1rtNEtVNdFNERuj6Leh4ia2gGc8TGm6LLw+x8dVWSJOnyo2Npu5+2EA8Jzxfl4stoaRRqCk1k5sWgvMUi34Ou1lE5SOzx2QciIl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zh5rW1BRzz69bn;
	Mon, 21 Apr 2025 21:32:11 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A982918046A;
	Mon, 21 Apr 2025 21:36:01 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 21 Apr
 2025 21:36:01 +0800
Message-ID: <794278e8-633d-4fd7-affa-9e89ba9719bd@huawei.com>
Date: Mon, 21 Apr 2025 21:36:00 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Nicholas Chin
	<nic.c3.14@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
	<vincent.guittot@linaro.org>
References: <20250417015424.36487-1-nic.c3.14@gmail.com>
 <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
 <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
 <CAJZ5v0iwAsVnvYKjKskLXuu5bDV_SMpgnTTy0zD=7fgnGzHQnA@mail.gmail.com>
 <CAKohponCr6pwgmK+J0WnvY_VZdDhA738JF18L518A2MKJVQLmw@mail.gmail.com>
 <c704850d-1fdd-4f25-8251-5bab03f055bb@huawei.com>
 <20250421113753.lwukxhi45bnmqbpq@vireshk-i7>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250421113753.lwukxhi45bnmqbpq@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/4/21 19:37, Viresh Kumar wrote:

> Coming back to this response again:
> 
> On 19-04-25, 17:35, zhenglifeng (A) wrote:
>> Yes, the policy boost will be forcibly set to mirror the global boost. This
>> indicates that the global boost value is the default value of policy boost
>> each time the CPU goes online. Otherwise, we'll meet things like:
>>
>> 1. The global boost is set to disabled after a CPU going offline but the
>> policy boost is still be enabled after the CPU going online again.
> 
> This is surely a valid case, we must not enable policy boost when
> global boost is disabled.
> 
>> 2. The global boost is set to enabled after a CPU going offline and the
>> rest of the online CPUs are all boost enabled. However, the offline CPU
>> remains in the boost disabled state after it going online again. Users
>> have to set its boost state separately.
> 
> I now this this is the right behavior. The policy wasn't present when
> the global boost was enabled and so the action doesn't necessarily
> apply to it.

OK. I just think that in this case the users would generally want it to be
true. But if you think this is the right behavior, I'll accept it.

> 
> This is how I think this should be fixed, we may still need to fix
> acpi driver's bug separately though:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 3841c9da6cac..7ac8b4c28658 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -620,6 +620,20 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
>         return sysfs_emit(buf, "%d\n", policy->boost_enabled);
>  }
> 
> +static int policy_set_boost(struct cpufreq_policy *policy, bool enable, bool forced)
> +{
> +       if (!forced && (policy->boost_enabled == enable))
> +               return 0;
> +
> +       policy->boost_enabled = enable;
> +
> +       ret = cpufreq_driver->set_boost(policy, enable);
> +       if (ret)
> +               policy->boost_enabled = !policy->boost_enabled;

This may cause boost_enabled becomes false but actually boosted when forced
is true and trying to set boost_enabled from true to true.

> +
> +       return ret;
> +}
> +
>  static ssize_t store_local_boost(struct cpufreq_policy *policy,
>                                  const char *buf, size_t count)
>  {
> @@ -635,21 +649,14 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
>         if (!policy->boost_supported)
>                 return -EINVAL;
> 
> -       if (policy->boost_enabled == enable)
> -               return count;
> -
> -       policy->boost_enabled = enable;
> -
>         cpus_read_lock();
> -       ret = cpufreq_driver->set_boost(policy, enable);
> +       ret = policy_set_boost(policy, enable, false);
>         cpus_read_unlock();
> 
> -       if (ret) {
> -               policy->boost_enabled = !policy->boost_enabled;
> -               return ret;
> -       }
> +       if (!ret)
> +               return count;
> 
> -       return count;
> +       return ret;
>  }
> 
>  static struct freq_attr local_boost = __ATTR(boost, 0644, show_local_boost, store_local_boost);
> @@ -1617,16 +1624,17 @@ static int cpufreq_online(unsigned int cpu)
>         if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
>                 policy->cdev = of_cpufreq_cooling_register(policy);
> 
> -       /* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +       /*
> +        * Let the per-policy boost flag mirror the cpufreq_driver boost during
> +        * initialization for a new policy. For an existing policy, maintain the
> +        * previous boost value unless global boost is disabled now.
> +        */
>         if (cpufreq_driver->set_boost && policy->boost_supported &&
> -           policy->boost_enabled != cpufreq_boost_enabled()) {
> -               policy->boost_enabled = cpufreq_boost_enabled();
> -               ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
> +           (new_policy || !cpufreq_boost_enabled())) {
> +               ret = policy_set_boost(policy, cpufreq_boost_enabled(), false);

I think forced here should be true. If new_policy and
!cpufreq_boost_enabled() but the cpu is actually boosted by some other
reason (like what we met in acpi-cpufreq), set_boost() should be forcibly
executed to make the cpu unboost.

>                 if (ret) {
> -                       /* If the set_boost fails, the online operation is not affected */
> -                       pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
> -                               str_enable_disable(policy->boost_enabled));
> -                       policy->boost_enabled = !policy->boost_enabled;
> +                       pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__,
> +                               policy->cpu, str_enable_disable(cpufreq_boost_enabled()));
>                 }
>         }
> 
> @@ -2864,12 +2872,9 @@ static int cpufreq_boost_trigger_state(int state)
>                 if (!policy->boost_supported)
>                         continue;
> 
> -               policy->boost_enabled = state;
> -               ret = cpufreq_driver->set_boost(policy, state);
> -               if (ret) {
> -                       policy->boost_enabled = !policy->boost_enabled;
> +               ret = policy_set_boost(policy, state, true);

Sorry, I can't see why forced need to be true here but false in other
places. Actually, the optimization I mentioned earlier is like:

@@ -2870,16 +2870,13 @@ static int cpufreq_boost_trigger_state(int state)
        unsigned long flags;
        int ret = 0;

-       if (cpufreq_driver->boost_enabled == state)
-               return 0;
-
        write_lock_irqsave(&cpufreq_driver_lock, flags);
        cpufreq_driver->boost_enabled = state;
        write_unlock_irqrestore(&cpufreq_driver_lock, flags);

        cpus_read_lock();
        for_each_active_policy(policy) {
-               if (!policy->boost_supported)
+               if (!policy->boost_supported || (policy->boost_enabled == state))
                        continue;

                policy->boost_enabled = state;

> +               if (ret)
>                         goto err_reset_state;
> -               }
>         }
>         cpus_read_unlock();
> 


