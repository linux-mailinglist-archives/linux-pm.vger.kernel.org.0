Return-Path: <linux-pm+bounces-21990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00EA331FA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 23:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293313A5D92
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 22:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E0204089;
	Wed, 12 Feb 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJVT8kjj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990B204087;
	Wed, 12 Feb 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397924; cv=none; b=QOG7i1pW+76y5EgNwDV/zuMJj/f7zHjiRb84OVw0vGitTO27sIh+WXw6MkyuHBT9JbgKs5YraBVAa/KIe4vlmlsToXN/GCjGzQniQHR7gwTV7FuV11q6C8bYMOjZwwD1yK0gPCAbER4uLnduXaTu9UiJiS95gnlABgzdlqFlUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397924; c=relaxed/simple;
	bh=MQI+PKcaHTqtA7qNC5oF+u39hyT4lvLQUfBwteyUk0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMLGgMb5JAfmrWNj722w04ZbAK+YbZbKOO/VQmGBfyv+ygtKOicF9MLXG112T3u8fFfdUO/jFqnuicEZGhHSzoQcGs+Hleageht78oGsYkXhNzrzCdTv98xmxI6rHRLrzoqsMucwiGNLSkg5xsyXFfj70EXtxYWD3R3PEmEguY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJVT8kjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04081C4CEDF;
	Wed, 12 Feb 2025 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739397923;
	bh=MQI+PKcaHTqtA7qNC5oF+u39hyT4lvLQUfBwteyUk0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TJVT8kjjGRUmJI2QMR+AWjvdphUmVun9lACRjgqqYlTUaB3TeMTlvyUdVCkMoDQhJ
	 eb82v5bQasBPqg28MeL4NhfYu4IrF8NkGplwoo5B4QA1XGFq4QzWv3q9hygHguJMn0
	 TPMnPe27DrBkZK52k0pof/aItQWioFkq0eh98Z0HzWPJ+mGQ597d1YNW7rk+RgulGq
	 R5gJlfRpDGYM4yhW1Dp9LiG8qcWjke/ARLgRN37YuRWwwVUnnWKrkKfLMjYS+CpurT
	 vb0K9S17HEjE//byKpo4+WRA80zuxOFntZbP6qtRKUDxbTf3ZMq8UHTKC4Gp8VFGwb
	 Q8ELHsr9ZFtXQ==
Message-ID: <04f036bf-e863-45c1-87de-7b61f8bc510d@kernel.org>
Date: Wed, 12 Feb 2025 16:05:22 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] cpufreq/amd-pstate: Overhaul locking
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250206215659.3350066-1-superm1@kernel.org>
 <20250206215659.3350066-5-superm1@kernel.org>
 <adccc912-bf93-4320-8011-21c0220c839a@amd.com>
 <bfcafbaf-c407-412b-a5e4-d152e2a565d7@kernel.org>
 <82f27cde-4725-4f4e-b4ae-c23885b31d14@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <82f27cde-4725-4f4e-b4ae-c23885b31d14@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/2025 23:15, Dhananjay Ugwekar wrote:
> On 2/12/2025 3:24 AM, Mario Limonciello wrote:
>> On 2/10/2025 23:02, Dhananjay Ugwekar wrote:
>>> On 2/7/2025 3:26 AM, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> amd_pstate_cpu_boost_update() and refresh_frequency_limits() both
>>>> update the policy state and have nothing to do with the amd-pstate
>>>> driver itself.
>>>>
>>>> A global "limits" lock doesn't make sense because each CPU can have
>>>> policies changed independently.  Instead introduce locks into to the
>>>> cpudata structure and lock each CPU independently.
>>>>
>>>> The remaining "global" driver lock is used to ensure that only one
>>>> entity can change driver modes at a given time.
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/cpufreq/amd-pstate.c | 27 +++++++++++++++++----------
>>>>    drivers/cpufreq/amd-pstate.h |  2 ++
>>>>    2 files changed, 19 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>> index 77bc6418731ee..dd230ed3b9579 100644
>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>> @@ -196,7 +196,6 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
>>>>        return -EINVAL;
>>>>    }
>>>>    -static DEFINE_MUTEX(amd_pstate_limits_lock);
>>>>    static DEFINE_MUTEX(amd_pstate_driver_lock);
>>>>      static u8 msr_get_epp(struct amd_cpudata *cpudata)
>>>> @@ -283,6 +282,8 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
>>>>        u64 value, prev;
>>>>        int ret;
>>>>    +    lockdep_assert_held(&cpudata->lock);
>>>
>>> After making the perf_cached variable writes atomic, do we still need a cpudata->lock ?
>>
>> My concern was specifically that userspace could interact with multiple sysfs files that influence the atomic perf variable (and the HW) at the same time.  So you would not have a deterministic behavior if they raced.  But if you take the mutex on all the paths that this could happen it will be a FIFO.
> 
> I guess, the lock still wont guarantee the ordering right? It will just ensure that one thread executes
> that code path for a specific CPU at a time. And do we even care about the ordering ? I'm having a hard
> time thinking of a scenario where we'll need the lock. Can you or Gautham think of any such scenario?
> 

You're right; I can't really think of one either.  Let me take out the 
private lock for the per-cpu device and I'll just overhaul the global 
lock locations.

>>
>>>
>>> Regards,
>>> Dhananjay
>>>
>>>> +
>>>>        value = prev = READ_ONCE(cpudata->cppc_req_cached);
>>>>        value &= ~AMD_CPPC_EPP_PERF_MASK;
>>>>        value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, epp);
>>>> @@ -315,6 +316,8 @@ static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
>>>>        int ret;
>>>>        struct cppc_perf_ctrls perf_ctrls;
>>>>    +    lockdep_assert_held(&cpudata->lock);
>>>> +
>>>>        if (epp == cpudata->epp_cached)
>>>>            return 0;
>>>>    @@ -335,6 +338,8 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>>        u8 epp;
>>>>    +    guard(mutex)(&cpudata->lock);
>>>> +
>>>>        if (!pref_index)
>>>>            epp = cpudata->epp_default;
>>>>        else
>>>> @@ -750,7 +755,6 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>>>>            pr_err("Boost mode is not supported by this processor or SBIOS\n");
>>>>            return -EOPNOTSUPP;
>>>>        }
>>>> -    guard(mutex)(&amd_pstate_driver_lock);
>>>>          ret = amd_pstate_cpu_boost_update(policy, state);
>>>>        refresh_frequency_limits(policy);
>>>> @@ -973,6 +977,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>>>>          cpudata->cpu = policy->cpu;
>>>>    +    mutex_init(&cpudata->lock);
>>>> +    guard(mutex)(&cpudata->lock);
>>>> +
>>>>        ret = amd_pstate_init_perf(cpudata);
>>>>        if (ret)
>>>>            goto free_cpudata1;
>>>> @@ -1179,8 +1186,6 @@ static ssize_t store_energy_performance_preference(
>>>>        if (ret < 0)
>>>>            return -EINVAL;
>>>>    -    guard(mutex)(&amd_pstate_limits_lock);
>>>> -
>>>>        ret = amd_pstate_set_energy_pref_index(policy, ret);
>>>>          return ret ? ret : count;
>>>> @@ -1353,8 +1358,10 @@ int amd_pstate_update_status(const char *buf, size_t size)
>>>>        if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
>>>>            return -EINVAL;
>>>>    -    if (mode_state_machine[cppc_state][mode_idx])
>>>> +    if (mode_state_machine[cppc_state][mode_idx]) {
>>>> +        guard(mutex)(&amd_pstate_driver_lock);
>>>>            return mode_state_machine[cppc_state][mode_idx](mode_idx);
>>>> +    }
>>>>          return 0;
>>>>    }
>>>> @@ -1375,7 +1382,6 @@ static ssize_t status_store(struct device *a, struct device_attribute *b,
>>>>        char *p = memchr(buf, '\n', count);
>>>>        int ret;
>>>>    -    guard(mutex)(&amd_pstate_driver_lock);
>>>>        ret = amd_pstate_update_status(buf, p ? p - buf : count);
>>>>          return ret < 0 ? ret : count;
>>>> @@ -1472,6 +1478,9 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>>>>          cpudata->cpu = policy->cpu;
>>>>    +    mutex_init(&cpudata->lock);
>>>> +    guard(mutex)(&cpudata->lock);
>>>> +
>>>>        ret = amd_pstate_init_perf(cpudata);
>>>>        if (ret)
>>>>            goto free_cpudata1;
>>>> @@ -1558,6 +1567,8 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>>>        union perf_cached perf;
>>>>        u8 epp;
>>>>    +    guard(mutex)(&cpudata->lock);
>>>> +
>>>>        amd_pstate_update_min_max_limit(policy);
>>>>          if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>>>> @@ -1646,8 +1657,6 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>>>>        if (cpudata->suspended)
>>>>            return 0;
>>>>    -    guard(mutex)(&amd_pstate_limits_lock);
>>>> -
>>>>        if (trace_amd_pstate_epp_perf_enabled()) {
>>>>            trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>>>>                          AMD_CPPC_EPP_BALANCE_POWERSAVE,
>>>> @@ -1684,8 +1693,6 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>>>>        struct amd_cpudata *cpudata = policy->driver_data;
>>>>          if (cpudata->suspended) {
>>>> -        guard(mutex)(&amd_pstate_limits_lock);
>>>> -
>>>>            /* enable amd pstate from suspend state*/
>>>>            amd_pstate_epp_reenable(policy);
>>>>    diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
>>>> index a140704b97430..6d776c3e5712a 100644
>>>> --- a/drivers/cpufreq/amd-pstate.h
>>>> +++ b/drivers/cpufreq/amd-pstate.h
>>>> @@ -96,6 +96,8 @@ struct amd_cpudata {
>>>>        bool    boost_supported;
>>>>        bool    hw_prefcore;
>>>>    +    struct mutex    lock;
>>>> +
>>>>        /* EPP feature related attributes*/
>>>>        u8    epp_cached;
>>>>        u32    policy;
>>>
>>
> 


