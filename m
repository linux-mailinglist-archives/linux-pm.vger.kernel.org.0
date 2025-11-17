Return-Path: <linux-pm+bounces-38113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09775C63250
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 10:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA46E34B6B1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AC324B2A;
	Mon, 17 Nov 2025 09:18:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC131A07B;
	Mon, 17 Nov 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371125; cv=none; b=rguSwjItFqGlD4q8oQCcrWCt/djmnLpOMnBV/NsFI3Qcnv5SdtAQ2BTufXxPUNU7HbCgOqopuO91GWr9e+NoseBohjcIrjvIX863N/tPK5wRmmx2yrf4QBp9VSEr70Z9zqjVa/jSyVF8/7Rz+3t/7KOiI2Urfz+AUduQ5QcMr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371125; c=relaxed/simple;
	bh=tOhBaqusApoCmBoq4Ahas/AFuv/QNj4TQZOaZxpcIgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuoW1ah4cY0n2+gz7WUF2l6yd11+rOaFiyX8KhwlOsTSGpEi+mtMpDHbeW9eYDbmg2vb9DYBfeXLazTUkMNauvzWMmU9IR8i1NjBaOv+xF9w5o++SCKvVbbePbpDStQhMo/JsHg57zV2qnv4aswRQETB+a/6P2PNyo9omG+R+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 715FCFEC;
	Mon, 17 Nov 2025 01:18:35 -0800 (PST)
Received: from [10.57.74.7] (unknown [10.57.74.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B68453F66E;
	Mon, 17 Nov 2025 01:18:38 -0800 (PST)
Message-ID: <28868c0e-2a46-47ed-9bd7-439056cf94c0@arm.com>
Date: Mon, 17 Nov 2025 09:18:35 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: Add policy_frequency trace event
To: Viresh Kumar <viresh.kumar@linaro.org>, Samuel Wu <wusamuel@google.com>,
 peterz@infradead.org, vincent.guittot@linaro.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kernel-team@android.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Qais Yousef <qyousef@layalina.io>, John Stultz <jstultz@google.com>
References: <20251112235154.2974902-1-wusamuel@google.com>
 <hslbhy6btkbpsgriafvdq4ligq7vorwcpffaakinqoieroopur@beyq5ouauscf>
 <CAG2KctqdJzhaC4pRG9rAgteVKHtKsA8Y7=_MHEUCCeBBhoejWQ@mail.gmail.com>
 <5pv5tqf24p6ttpydpdegyhyod3m2hmpwbfrzl6otsq3q2gvb2s@gsgcgbcvin3u>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5pv5tqf24p6ttpydpdegyhyod3m2hmpwbfrzl6otsq3q2gvb2s@gsgcgbcvin3u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/25 05:11, Viresh Kumar wrote:
> On 13-11-25, 19:41, Samuel Wu wrote:
>> On Wed, Nov 12, 2025 at 10:45 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>
>>> On 12-11-25, 15:51, Samuel Wu wrote:
>>>> The existing cpu_frequency trace_event can be verbose, emitting an event
>>>> for every CPU in the policy even when their frequencies are identical.
>>>>
>>>> This patch adds a new policy_frequency trace event, which provides a
>>>> more efficient alternative to cpu_frequency trace event. This option
>>>> allows users who only need frequency at a policy level more concise logs
>>>> with simpler analysis.
>>>>
>>>> Signed-off-by: Samuel Wu <wusamuel@google.com>
>>>> ---
>>>>  drivers/cpufreq/cpufreq.c    |  2 ++
>>>>  include/trace/events/power.h | 21 +++++++++++++++++++++
>>>>  2 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>> index 4472bb1ec83c..b65534a4fd9a 100644
>>>> --- a/drivers/cpufreq/cpufreq.c
>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>> @@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
>>>>               pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
>>>>                        cpumask_pr_args(policy->cpus));
>>>>
>>>> +             trace_policy_frequency(freqs->new, policy->cpu);
>>>>               for_each_cpu(cpu, policy->cpus)
>>>>                       trace_cpu_frequency(freqs->new, cpu);
>>>
>>> I don't see much value in almost duplicate trace events. If we feel that a
>>> per-policy event is a better fit (which makes sens), then we can just drop the
>>> trace_cpu_frequency() events and print policy->cpus (or related_cpus)
>>> information along with the per-policy events.
>>
>> Thank you for the feedback Viresh. Fair enough, I've done some testing
>> and a single trace event should work and would be cleaner. Please let
>> me know what you think of this proposal for v2.
>>
>> We can append a bitmask of policy->cpus field to
>> trace_cpu_frequency(). This way we maintain backwards compatibility:
>> trace_cpu_frequency() is not removed, and its pre-existing fields are
>> not disturbed.
>>
>> Call flow wise, we can delete all the for_each_cpu() loops, and we
>> still retain the benefits of the trace emitting once per policy
>> instead of once per cpu.
> 
> Fine by me. I have added Scheduler maintainers in the loop to see if they have a
> different view.
>

And IIUC your proposal is to fold policy_frequency into cpu_frequency but then
only have one cpu_frequency event per policy emitted?
I think from a tooling perspective it would be easier to remove cpu_frequency
entirely, then tools can probe on the presence of policy_frequency / cpu_frequency.

