Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39D15B0DD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 20:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBLTT6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 14:19:58 -0500
Received: from foss.arm.com ([217.140.110.172]:36782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgBLTT5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 14:19:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5ADE30E;
        Wed, 12 Feb 2020 11:19:56 -0800 (PST)
Received: from [192.168.0.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597093F68E;
        Wed, 12 Feb 2020 11:19:53 -0800 (PST)
Subject: Re: [PATCH v3 1/7] arm64: add support for the AMU extension v1
To:     Ionela.Voinescu@arm.com
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, rjw@rjwysocki.net,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-2-ionela.voinescu@arm.com>
 <93472f17-6465-641d-ea82-3230b5697ffd@arm.com>
 <20200212161045.GA7475@arm.com>
 <133890f7-59bb-63b9-0ca8-2294e3596058@arm.com>
 <20200212182008.GA25421@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f35dc0e3-c85e-30da-6119-fcf398b4b428@arm.com>
Date:   Wed, 12 Feb 2020 19:24:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200212182008.GA25421@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On 02/12/2020 06:20 PM, Ionela Voinescu wrote:
> Hi Suzuki,
> 
> On Wednesday 12 Feb 2020 at 16:20:56 (+0000), Suzuki Kuruppassery Poulose wrote:
>>>>> +static bool has_amu(const struct arm64_cpu_capabilities *cap,
>>>>> +		       int __unused)
>>>>> +{
>>>>> +	/*
>>>>> +	 * The AMU extension is a non-conflicting feature: the kernel can
>>>>> +	 * safely run a mix of CPUs with and without support for the
>>>>> +	 * activity monitors extension. Therefore, if not disabled through
>>>>> +	 * the kernel command line early parameter, enable the capability
>>>>> +	 * to allow any late CPU to use the feature.
>>>>> +	 *
>>>>> +	 * With this feature enabled, the cpu_enable function will be called
>>>>> +	 * for all CPUs that match the criteria, including secondary and
>>>>> +	 * hotplugged, marking this feature as present on that respective CPU.
>>>>> +	 * The enable function will also print a detection message.
>>>>> +	 */
>>>>> +
>>>>> +	if (!disable_amu && !zalloc_cpumask_var(&amu_cpus, GFP_KERNEL)) {
>>>>
>>>> This looks problematic. Don't we end up in allocating the memory during
>>>> "each CPU" check and thus leaking memory ? Do we really need to allocate
>>>> this dynamically ?
>>>>
>>>
>>> Yes, it does make some assumptions. Given that the AMU capability is
>>> a WEAK_LOCAL_CPU_FEATURE I relied on the match function being called
>>> only once, when the return value is true. If the return value is false,
>>
>> That is not correct. A WEAK_LOCAL_CPU_FEATURE is still SCOPE_LOCAL_CPU,
>> implies it is run on all the booting CPUs (including the hotplugged
>> ones). The WEAK is there to imply that its "permitted" or "optional"
>> for a hotplugged CPU. So, eventually you will re-allocate this variable
>> every single time a CPU turns up, where you could also loose the current
>> state.
>>
> 
>>> which will result in it being called multiple times, it's either because
>>> disable_amu == false, or it has become false due to a previous failed
>>> allocation, in which case a new allocation will not be attempted.
> 
> First of all, I agree with you that this should be corrected.
> 
> But for completion (and my education) I retraced my steps in regards
> to my assumption above. While cpu_enable is called for all CPUs - boot,
> secondary, hotplugged, the matches function (in this case has_amu) is
> not always called for all CPUs, and that's where the confusion came
> from.
> 
> Looking over the update_cpu_capabilities function, that's called from
> both setup_boot_cpu_capabilities and check_local_cpu_capabilities
> (secondary CPUs) for SCOPE_LOCAL_CPU:
> 
> -----
> static void update_cpu_capabilities(u16 scope_mask)
> {
>          int i;
>          const struct arm64_cpu_capabilities *caps;
> 
>          scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
>          for (i = 0; i < ARM64_NCAPS; i++) {
>                  caps = cpu_hwcaps_ptrs[i];
>                  if (!caps || !(caps->type & scope_mask) ||
>                      cpus_have_cap(caps->capability) ||
>                      !caps->matches(caps, cpucap_default_scope(caps)))
>                          continue;
> 
> --> The matches function is only called if !cpus_have_cap

Agreed. Your analysis is correct. This was done as a micro
optimization(!) as it is pointless to check if something should be set, 
when it is already set.

> 
> 
>                  if (caps->desc)
>                          pr_info("detected: %s\n", caps->desc);
>                  cpus_set_cap(caps->capability);
> 
> --> If matches returns true we mark it as present in cpu_hwcaps.
> 
>                  if ((scope_mask & SCOPE_BOOT_CPU) && (caps->type & SCOPE_BOOT_CPU))
>                          set_bit(caps->capability, boot_capabilities);
>          }
> }
> ---
> 
> Therefore caps->matches (in this case has_amu) will only be called as
> long as it returns false. This is where my assumption above came from.
> Also, this is the reason it was working nicely in my testing, as I did
> not test hotplug this time.
> 
> Where the has_amu code breaks is when we end up calling
> verify_local_cpu_capabilities instead of update_cpu_capabilities after
> sys_caps_initialised, which will happen for hotplugged CPUs.
> In that case we call caps->matches for all CPUs. Also, if anyone in the
> future ends up calling this_cpu_has_cap for the AMU capability.

True.

> 
> I will fix this.

Cheers
Suzuki
