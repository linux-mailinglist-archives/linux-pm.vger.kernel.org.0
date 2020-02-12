Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C301415AD2A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 17:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBLQVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 11:21:00 -0500
Received: from foss.arm.com ([217.140.110.172]:34824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBLQVA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 11:21:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD813328;
        Wed, 12 Feb 2020 08:20:59 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE1A63F68F;
        Wed, 12 Feb 2020 08:20:57 -0800 (PST)
Subject: Re: [PATCH v3 1/7] arm64: add support for the AMU extension v1
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <133890f7-59bb-63b9-0ca8-2294e3596058@arm.com>
Date:   Wed, 12 Feb 2020 16:20:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200212161045.GA7475@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

On 12/02/2020 16:10, Ionela Voinescu wrote:
> Hi Suzuki,
> 
> On Wednesday 12 Feb 2020 at 11:30:44 (+0000), Suzuki Kuruppassery Poulose wrote:
>>> +static int __init set_disable_amu(char *str)
>>> +{
>>> +	int value = 0;
>>> +
>>> +	disable_amu = get_option(&str, &value) ? !!value : true;
>>
>> minor nit: You could simply use strtobool(str) here, which accepts:
>>
>> disable_amu= [0/1/on/off/y/n]
>>
> 
> Yes, this was intentional as I wanted "disable_amu" to be a valid option
> as well, not only "disable_amu=<option>".
> 
> If you don't mind I'd like to keep it like this. Currently the use of

Sure, thats fine.

>>> +
>>> +	return 0;
>>> +}
>>> +early_param("disable_amu", set_disable_amu);
>>> +
>>> +static bool has_amu(const struct arm64_cpu_capabilities *cap,
>>> +		       int __unused)
>>> +{
>>> +	/*
>>> +	 * The AMU extension is a non-conflicting feature: the kernel can
>>> +	 * safely run a mix of CPUs with and without support for the
>>> +	 * activity monitors extension. Therefore, if not disabled through
>>> +	 * the kernel command line early parameter, enable the capability
>>> +	 * to allow any late CPU to use the feature.
>>> +	 *
>>> +	 * With this feature enabled, the cpu_enable function will be called
>>> +	 * for all CPUs that match the criteria, including secondary and
>>> +	 * hotplugged, marking this feature as present on that respective CPU.
>>> +	 * The enable function will also print a detection message.
>>> +	 */
>>> +
>>> +	if (!disable_amu && !zalloc_cpumask_var(&amu_cpus, GFP_KERNEL)) {
>>
>> This looks problematic. Don't we end up in allocating the memory during
>> "each CPU" check and thus leaking memory ? Do we really need to allocate
>> this dynamically ?
>>
> 
> Yes, it does make some assumptions. Given that the AMU capability is
> a WEAK_LOCAL_CPU_FEATURE I relied on the match function being called
> only once, when the return value is true. If the return value is false,

That is not correct. A WEAK_LOCAL_CPU_FEATURE is still SCOPE_LOCAL_CPU,
implies it is run on all the booting CPUs (including the hotplugged
ones). The WEAK is there to imply that its "permitted" or "optional"
for a hotplugged CPU. So, eventually you will re-allocate this variable
every single time a CPU turns up, where you could also loose the current
state.

> which will result in it being called multiple times, it's either because
> disable_amu == false, or it has become false due to a previous failed
> allocation, in which case a new allocation will not be attempted.
> 
> For better handling I could have a cpumask_available check before the
> allocation just in case the capability type changes in the future, or to
> at least not rely on assumptions based on the type of the capability.
> 
> The reason this is dynamic is that I wanted to avoid the memory being
> allocated when disable_amu is true - as Valentin mentioned in a comment
> in the meantime "the static allocation is done against NR_CPUS whereas
> the dynamic one is done against nr_cpu_ids".
> 
> Would this be alright?
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 182e05ca3410..4cee6b147ddd 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1222,7 +1222,11 @@ static bool has_amu(const struct arm64_cpu_capabilities *cap,
>           * The enable function will also print a detection message.
>           */
>   
> -       if (!disable_amu && !zalloc_cpumask_var(&amu_cpus, GFP_KERNEL)) {
> +       if (disable_amu)
> +               return false;
> +
> +       if (!cpumask_available(amu_cpus) &&
> +           !zalloc_cpumask_var(&amu_cpus, GFP_KERNEL)) {
>                  pr_err("Activity Monitors Unit (AMU): fail to allocate memory");
>                  disable_amu = true;
>          }

This looks fine.

Cheers
Suzuki
