Return-Path: <linux-pm+bounces-39722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB188CD2D57
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99455300A21A
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFFD2DAFCA;
	Sat, 20 Dec 2025 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="u5FSOmbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D67273D84;
	Sat, 20 Dec 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766226557; cv=none; b=d6ml63dtQ2t56Z+V/wnUEhwa8aNNe0ZzTM9ENDkYxBVAKyUzk+hJx0ykHlDiE+xKli/byKUvCMJHMtttmWPo/e7T/Uc78xZ12vzI54PPZo3CH5aOyyPzHCheS2JWPVf1vbCJcPqdGzdHIt75ZzuWalCxaIRf/uZ3/G1ixaNSzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766226557; c=relaxed/simple;
	bh=tkASWnxDAnPkSgYklHe/Hs7vfqfR5l4Y2k3+inLhx5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R4dkrJX4S5Zo1gYjG89RAYlD1krwPwG6RM8aFpnls7XCIIwgUnzFAriIRGWtDy77qyD3eXN98SV9wOaI7aINa51fYfjzpOOj3dzOU0cgmWR10LMtRoJ2kFVPGyzB22JtBZuKuCWHQEv2s29BcpVQ+xp391vpXuqKW3+bsMqWx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=u5FSOmbt; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rQWfpVR0ETstCxv+UIVuxd4KCChPSiLYUvsCabSYxDc=;
	b=u5FSOmbtABHD8Bjb22xd1V+0/78YUbbRd16O9Bi/kG+PNqrUEO6Aj/pmEsiFv6u1neCtJuYp0
	ihS8mihEEpqC6WcsOqyQm0k3hknnRjarSq20tJGgvBFGCQ8nYYTQOR4JbwYHk8xxVPJA2pmSJrH
	LL9KZ7+e/j/a4jZ7kfDP7/c=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dYLDQ0jDKz1T4G3;
	Sat, 20 Dec 2025 18:26:46 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 8161640562;
	Sat, 20 Dec 2025 18:29:02 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 20 Dec
 2025 18:29:01 +0800
Message-ID: <1a2059cf-b12c-4e47-b52e-e5c797a0506c@huawei.com>
Date: Sat, 20 Dec 2025 18:29:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: Update set_boost callbacks to rely on
 boost_freq_req
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-kernel@vger.kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Jie
 Zhan <zhanjie9@hisilicon.com>, Huang Rui <ray.huang@amd.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>
References: <20251208105933.1369125-1-pierre.gondois@arm.com>
 <20251208105933.1369125-4-pierre.gondois@arm.com>
 <14ad55ce-413f-46e0-9ce0-f35fc421056c@huawei.com>
 <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <73da1186-5edd-4465-bd49-e18d9064a501@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/18 0:22, Pierre Gondois wrote:
> Hello Lifeng,
> 
> Thanks for the review.
> I wrote a bit of text, but IIUC you already agree with what I describe.
> This might be more to be sure of what I want to do.
> 
> If you disagree with something, please let me know.
> 
> On 12/10/25 10:26, zhenglifeng (A) wrote:
>> On 2025/12/8 18:59, Pierre Gondois wrote:
>>> In the existing set_boost() callbacks:
>>> - Don't update policy->max as this is done through the qos notifier
>>>    cpufreq_notifier_max() which calls cpufreq_set_policy().
>>> - Remove freq_qos_update_request() calls as the qos request is now
>>>    done in policy_set_boost() and updates the new boost_freq_req
>>>
>>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>>> ---
>>>   drivers/cpufreq/amd-pstate.c   |  2 --
>>>   drivers/cpufreq/cppc_cpufreq.c | 21 ++++-----------------
>>>   drivers/cpufreq/cpufreq.c      | 14 ++------------
>>>   3 files changed, 6 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index b44f0f7a5ba1c..50416358a96ac 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -754,8 +754,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>>>       else if (policy->cpuinfo.max_freq > nominal_freq)
>>>           policy->cpuinfo.max_freq = nominal_freq;
>>>   -    policy->max = policy->cpuinfo.max_freq;
>>> -
>>>       if (cppc_state == AMD_PSTATE_PASSIVE) {
>>>           ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
>>>           if (ret < 0)
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index e23d9abea1359..3baf7baaec371 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -597,21 +597,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>       caps = &cpu_data->perf_caps;
>>>       policy->driver_data = cpu_data;
>>>   -    /*
>>> -     * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>>> -     * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>>> -     */
>>> -    policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>>> -    policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>>> -                        caps->highest_perf : caps->nominal_perf);
>> Why remove this?
> 
> This is partly a mistake.
> As you suggested below (I think), policy->max should not be set directly.
> It might be better to set the boost_freq_req for all cpufreq drivers, which should
> result in setting policy->max.
> 
>>
>>> -
>>>       /*
>>>        * Set cpuinfo.min_freq to Lowest to make the full range of performance
>>>        * available if userspace wants to use any perf between lowest & lowest
>>>        * nonlinear perf
>>>        */
>>>       policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
>>> -    policy->cpuinfo.max_freq = policy->max;
>>> +    policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, policy->boost_enabled ?
>>> +                        caps->highest_perf : caps->nominal_perf);
>>>         policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>>>       policy->shared_type = cpu_data->shared_type;
>>> @@ -776,17 +769,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
>>>   {
>>>       struct cppc_cpudata *cpu_data = policy->driver_data;
>>>       struct cppc_perf_caps *caps = &cpu_data->perf_caps;
>>> -    int ret;
>>>         if (state)
>>> -        policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
>>> +        policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
>>>       else
>>> -        policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
>>> -    policy->cpuinfo.max_freq = policy->max;
>>> -
>>> -    ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +        policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
>>>         return 0;
>>>   }
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 65ef0fa70c388..ab2def9e4d188 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -1514,10 +1514,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>             blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>>                   CPUFREQ_CREATE_POLICY, policy);
>>> -    } else {
>>> -        ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>> -        if (ret < 0)
>>> -            goto out_destroy_policy;
>> I think boost_freq_req should be updated here, to solve the problem that
>> this code originally intended to solve.
> 
> Yes right indeed.
> 
>>>       }
>>>         if (cpufreq_driver->get && has_target()) {
>>> @@ -2819,16 +2815,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
>>>           return -ENXIO;
>>>         ret = cpufreq_frequency_table_cpuinfo(policy);
>> cpufreq_frequency_table_cpuinfo() may change policy->max. I believe this
>> isn't what you want.
> 
> 
> cpufreq_frequency_table_cpuinfo() can effectively update
> policy->cpuinfo.max_freq, but directly setting policy->max should be wrong
> as it bypasses the other QoS constraints on the maximal frequency.
> 
> Updates to policy->max should go through the following call chain
> to be sure all constraints/notifiers are respected/called.
> freq_qos_update_request()
> \-freq_qos_apply()
>   \-pm_qos_update_target()
>     \-blocking_notifier_call_chain()
>       \-cpufreq_notifier_max()
>         \-handle_update()
>           \-refresh_frequency_limits()
>             \-cpufreq_set_policy()
> 
> FYIU, we should have:
> - max_freq_req: the maximal frequency constraint as set by the user.
>   It is updated whenever the user write to scaling_max_freq.
> - boost_freq_req: the maximal frequency constraint as set by the
>   driver. It is updated whenever boost is enabled/disabled.
> - policy->cpuinfo.max_freq: the maximal frequency reachable by the driver.
>   This value is used in cpufreq at various places to check frequencies
>   are within valid boundaries.
> - policy->max: the maximal frequency cpufreq can use. It is a resultant
>   of all the QoS constraints received (from the user, boost, thermal).
>   It should be updated whenever one of the QoS constraint is updated.
>   It should never be set directly to avoid bypassing the QoS constraints.
> 
> Whenever a cpufreq driver is initialized, policy->max is set, but the
> value is overridden whenever the user writes to scaling_max_freq.
> Thus we might think it should be replaced with a max_freq_req constraint.
> 
> However if boost is enabled, the maximal frequency will be limited by
> max_freq_req. So at init, cpufreq drivers should set boost_freq_req
> instead (to policy->cpuinfo.max_freql).
> That way, if boost is enabled, the maximal frequency available is the
> boost frequency.
> 
> ------
> 
> Summary:
> -
> policy->max should never be set directly. It should only be set through
> cpufreq_set_policy(). cpufreq_set_policy() might be called indirectly
> after updating a QoS constraint using freq_qos_update_request().
> 
> -
> boost_freq_req should be set for all cpufreq drivers, with a default value
> of policy->cpuinfo.max_freq. This represents the maximal frequency available
> with/without boost.
> Note: the name "boost_freq_req" might not be well chosen.
> 
> -
> Any update to policy->cpuinfo.max_freq should be followed by a call to
> freq_qos_update_request(policy->boost_freq_req).
> This will allow to update "policy->max" with the new boost frequency.

Yes. I agree. So the source of the problem is that max_freq_req includes
both user-defined limits and driver-defined limits. And now you try to
separate them. That's nice. Looking forward to the next version!

At the same time, I'm curious whether a similar problem would occur with
min_freq_req if a driver existed that could change cpuinfo.min_freq in
runtime (not quite certain whether such a driver exists).

> 
> 
>>> -    if (ret) {
>>> +    if (ret)
>>>           pr_err("%s: Policy frequency update failed\n", __func__);
>>> -        return ret;
>>> -    }
>>>   -    ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>>> -    if (ret < 0)
>>> -        return ret;
>>> -
>>> -    return 0;
>>> +    return ret;
>>>   }
>>>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>>>   
> 


