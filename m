Return-Path: <linux-pm+bounces-38112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B57C63168
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 10:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4306E3A97B0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF4313264;
	Mon, 17 Nov 2025 09:14:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E8227E060;
	Mon, 17 Nov 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370875; cv=none; b=JXAgF3oxBYUgam9EJJahpKktaPa+awa657u7HN3ZNXqiSRtYvcHuTs8/LtyJtHv1dEp6APH4Wg4fq77/p7iFMjgdzDhXUOwuZLtFfxVn5Ot3QtsP8Rj5NP5l2tgkGBYDwd26GgGTuF0OlB8rkTfZ/86EhI0E8u8EVwBXInqydns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370875; c=relaxed/simple;
	bh=GPqvZg+qkTe/2G6tOziGFBWa9p+NefU3MgtEuEV+JHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIXPZDN1DufRktSmzTt+yB+hfg9/o20fJABFnbNJWd65tG0pA0VxrOg7ehZ3iJ2tRJBFPXLyJDkYGWCBEFTObKaI5m21va7+e/M1aHRmoQoAvGc5k6mphgo30N0JYdZPHsdLDLvWSwwnfwHbYh27SJbLw/YKq37OWNPe0lIyKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70C44FEC;
	Mon, 17 Nov 2025 01:14:25 -0800 (PST)
Received: from [10.57.74.7] (unknown [10.57.74.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A1A33F66E;
	Mon, 17 Nov 2025 01:14:27 -0800 (PST)
Message-ID: <341938b2-c8f0-4014-9e51-02521e7c497a@arm.com>
Date: Mon, 17 Nov 2025 09:14:25 +0000
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

That's gonna break a lot of tooling but AFAICS that in and of itself isn't
a good enough reason not to do it.
(Added some CCs)

