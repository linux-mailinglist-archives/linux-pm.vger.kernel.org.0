Return-Path: <linux-pm+bounces-10595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041BB9273B5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8081F2157A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8B1AB53B;
	Thu,  4 Jul 2024 10:13:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB71A0730;
	Thu,  4 Jul 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087984; cv=none; b=ROt5vGD2Lskaij7L85GHrLlxWQAsDQ2x489POaBe6wrGQ6MelC1IsNANT6y2D6WtntjOFxkwIUAmFt82o7L4tDacIW2Nye3up9Ha31aOGdGvzRmZaocte4VIKD5xp5ZTYfJ2bQAY3TnZNqA4gp4WABGL1ok8PB2otL7tPqt5whk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087984; c=relaxed/simple;
	bh=UMT+3o1id/iUYRmU6CkrDgoAaUAyPXeN3HPV2v2JMmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gK1kgwxivfF8O4T8GfUUQNfkr1T6FNii0buTBVwPVSGml6NiVFpeksbDEwSy6puf3a61x8ZGF0ct1TmCBgnsD2f/NUo7wgVYegHOArt2vlsOapDD/XqwvlOJotBr8gjMmHFWSoR+a/eakeTZXFouCMQjPI6OSkV9fi51b5kMiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AFB9367;
	Thu,  4 Jul 2024 03:13:26 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 001213F762;
	Thu,  4 Jul 2024 03:12:58 -0700 (PDT)
Message-ID: <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>
Date: Thu, 4 Jul 2024 12:12:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240619201409.2071728-1-qyousef@layalina.io>
 <f281ba07-d54a-460a-8f78-f7eb6bd8ed88@arm.com>
 <20240628015200.vw75huo53redgkzf@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240628015200.vw75huo53redgkzf@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 03:52, Qais Yousef wrote:
> On 06/25/24 14:58, Dietmar Eggemann wrote:
> 
>>> @@ -4917,6 +4927,84 @@ static inline void __balance_callbacks(struct rq *rq)
>>>  
>>>  #endif
>>>  
>>> +static __always_inline void
>>> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
>>> +{
>>> +#ifdef CONFIG_CPU_FREQ
>>> +	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
>>> +		/* Sugov just did an update, don't be too aggressive */
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * RT and DL should always send a freq update. But we can do some
>>> +	 * simple checks to avoid it when we know it's not necessary.
>>> +	 *
>>> +	 * iowait_boost will always trigger a freq update too.
>>> +	 *
>>> +	 * Fair tasks will only trigger an update if the root cfs_rq has
>>> +	 * decayed.
>>> +	 *
>>> +	 * Everything else should do nothing.
>>> +	 */
>>> +	switch (current->policy) {
>>> +	case SCHED_NORMAL:
>>> +	case SCHED_BATCH:
>>
>> What about SCHED_IDLE tasks?
> 
> I didn't think they matter from cpufreq perspective. These tasks will just run
> at whatever the idle system is happen to be at and have no specific perf
> requirement since they should only run when the system is idle which a recipe
> for starvation anyway?

Not sure we talk about the same thing here? idle_sched_class vs.
SCHED_IDLE policy (FAIR task with a tiny weight of WEIGHT_IDLEPRIO).

>>> +		if (unlikely(current->in_iowait)) {
>>> +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
>>> +			return;
>>> +		}
>>> +
>>> +#ifdef CONFIG_SMP
>>> +		if (unlikely(rq->cfs.decayed)) {
>>> +			rq->cfs.decayed = false;
>>> +			cpufreq_update_util(rq, 0);
>>> +			return;
>>> +		}
>>> +#else
>>> +		cpufreq_update_util(rq, 0);
>>> +#endif
>>
>> We can have !CONFIG_SMP and CONFIG_FAIR_GROUP_SCHED systems. Does this
>> mean on those systems we call cpufreq_update_util() for each cfs_rq of
>> the hierarchy where on CONFIG_SMP we only do this for the root cfs_rq?
> 
> No. This is called on context switch only and hierarchy doesn't matter here. We
> just do it unconditionally for UP since we only track the decayed at cfs_rq
> level and I didn't think it's worth trying to make it at rq level.

OK, I see. The call in __update_cpufreq_ctx_switch() plus
(task_tick_fair() and check_preempt_wakeup_fair()) are not related to a
cfs_rq, but rather to the rq and/or task directly.

Currently we have the thing in update_load_avg() for !CONFIG_SMP and
there we use cfs_rq_util_change() which only calls cpufreq_update_util()
for root cfs_rq but this clearly has a cfs_rq context.

>> [...]
>>
>>> @@ -4744,8 +4716,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>>  	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
>>>  		__update_load_avg_se(now, cfs_rq, se);
>>>  
>>> -	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
>>> -	decayed |= propagate_entity_load_avg(se);
>>> +	cfs_rq->decayed |= update_cfs_rq_load_avg(now, cfs_rq);
>>> +	cfs_rq->decayed |= propagate_entity_load_avg(se);
>>>  
>>>  	if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>>>  
>>> @@ -4766,11 +4738,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>>  		 */
>>>  		detach_entity_load_avg(cfs_rq, se);
>>>  		update_tg_load_avg(cfs_rq);
>>> -	} else if (decayed) {
>>> -		cfs_rq_util_change(cfs_rq, 0);
>>> -
>>> -		if (flags & UPDATE_TG)
>>> -			update_tg_load_avg(cfs_rq);
>>> +	} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
>>> +		update_tg_load_avg(cfs_rq);
>>>  	}
>>>  }
>>
>> You set cfs_rq->decayed for each taskgroup level but you only reset it
>> for the root cfs_rq in __update_cpufreq_ctx_switch() and task_tick_fair()?
> 
> Yes. We only care about using it for root level. Tracking the information at
> cfs_rq level is the most natural way to do it as this is what update_load_avg()
> is acting on.

But IMHO this creates an issue with those non-root cfs_rq's within
update_load_avg() itself. They will stay decayed after cfs_rq->decayed
has been set to 1 once and will never be reset to 0. So with UPDATE_TG
update_tg_load_avg() will then always be called on those non-root
cfs_rq's all the time.

[...]

