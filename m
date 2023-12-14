Return-Path: <linux-pm+bounces-1151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB7812D36
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F185B20D0A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB9B3C463;
	Thu, 14 Dec 2023 10:40:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FBAC11B;
	Thu, 14 Dec 2023 02:40:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5180C15;
	Thu, 14 Dec 2023 02:40:52 -0800 (PST)
Received: from [10.57.85.242] (unknown [10.57.85.242])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B810C3F738;
	Thu, 14 Dec 2023 02:40:02 -0800 (PST)
Message-ID: <fe8f8d00-1720-4a47-83ae-1aa4c005c4f5@arm.com>
Date: Thu, 14 Dec 2023 10:41:05 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, rui.zhang@intel.com,
 mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org>
 <20231214054307.axl33gagxacidjbn@vireshk-i7>
 <CAKfTPtDam5eQO1DHxALsCaU53Rtawbfrvswy+z2unnV_eXeVLA@mail.gmail.com>
 <54f3b98c-1f7d-4205-9e3c-a4a19ad3d941@arm.com>
 <CAJZ5v0gD-utGhM3vN7JmPia1CVcSQa6RPnk2xMBXXc6asRTn=g@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gD-utGhM3vN7JmPia1CVcSQa6RPnk2xMBXXc6asRTn=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/14/23 09:40, Rafael J. Wysocki wrote:
> On Thu, Dec 14, 2023 at 10:07 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> On 12/14/23 07:57, Vincent Guittot wrote:
>>> On Thu, 14 Dec 2023 at 06:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>
>>>> On 12-12-23, 15:27, Vincent Guittot wrote:
>>>>> @@ -2618,6 +2663,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>>>>>         policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
>>>>>         trace_cpu_frequency_limits(policy);
>>>>>
>>>>> +     cpus = policy->related_cpus;
>>>>> +     cpufreq_update_pressure(cpus, policy->max);
>>>>> +
>>>>>         policy->cached_target_freq = UINT_MAX;
>>>>
>>>> One more question, why are you doing this from cpufreq_set_policy ? If
>>>> due to cpufreq cooling or from userspace, we end up limiting the
>>>> maximum possible frequency, will this routine always get called ?
>>>
>>> Yes, any update of a FREQ_QOS_MAX ends up calling cpufreq_set_policy()
>>> to update the policy->max
>>>
>>
>> Agree, cpufreq sysfs scaling_max_freq is also important to handle
>> in this new design. Currently we don't reflect that as reduced CPU
>> capacity in the scheduler. There was discussion when I proposed to feed
>> that CPU frequency reduction into thermal_pressure [1].
>>
>> The same applies for the DTPM which is missing currently the proper
>> impact to the CPU reduced capacity in the scheduler.
>>
>> IMHO any limit set into FREQ_QOS_MAX should be visible in this
>> new design of capacity reduction signaling.
>>
>> [1] https://lore.kernel.org/lkml/20220930094821.31665-2-lukasz.luba@arm.com/
> 
> Actually, freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX) will
> return the requisite limit.

Yes, but we need to translate that information from freq domain
into capacity domain and plumb ii into scheduler as stolen CPU capacity.
Ideally, w/o any 'smoothing' but just instant value.
That's the hope of this patch set re-design.

