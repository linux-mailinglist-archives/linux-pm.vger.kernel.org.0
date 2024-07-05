Return-Path: <linux-pm+bounces-10696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A035928835
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D862870F5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F07149C42;
	Fri,  5 Jul 2024 11:51:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6137146D45;
	Fri,  5 Jul 2024 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180264; cv=none; b=Xa/d93TpgAKR+t6qSQZQ5tYT44XVSip8SUwXdNwLXY+v272YZ/5MZWF/f0M0Ip+GlaKfiIbu67ffzuRqAQRpWV8llSqpWZoYBRqMGb19YlChZWYNDwn2kSkMuCJRayw4P91hav5c8eyAp0vcarGxMTDkOB57XuWRc9GYZup7ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180264; c=relaxed/simple;
	bh=H+ikbaT9Dvuckpcq1nSfgBg+YOJ4iSoDWTx/I4R7Bo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hybxv6AqIDTIQUhtEw3VsXntAJDPW5Cg02sKdcZZkQ0zmEF/deR5+8G9DHug9etc6r3vNZxRbbFIF/T5iJBQ9CzohLQglEvhuI0QwVdWcU0AVb7Bqz4Bl2raqelqORFwaw0wILBlrwwwJbtMHB5sZcz0/sJNk9si6k/gA9AQEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FA1A367;
	Fri,  5 Jul 2024 04:51:20 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73EB3F762;
	Fri,  5 Jul 2024 04:50:52 -0700 (PDT)
Message-ID: <2e988929-142c-4e69-8e2e-2f3e64c9f08c@arm.com>
Date: Fri, 5 Jul 2024 13:50:51 +0200
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
 <d510f41a-1225-46d9-a2d7-ff9e6ff599d2@arm.com>
 <20240705002205.nnrgq7savzvsoqgl@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240705002205.nnrgq7savzvsoqgl@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 02:22, Qais Yousef wrote:
> On 07/04/24 12:12, Dietmar Eggemann wrote:
>> On 28/06/2024 03:52, Qais Yousef wrote:
>>> On 06/25/24 14:58, Dietmar Eggemann wrote:
>>>
>>>>> @@ -4917,6 +4927,84 @@ static inline void __balance_callbacks(struct rq *rq)
>>>>>  
>>>>>  #endif
>>>>>  
>>>>> +static __always_inline void
>>>>> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
>>>>> +{
>>>>> +#ifdef CONFIG_CPU_FREQ
>>>>> +	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
>>>>> +		/* Sugov just did an update, don't be too aggressive */
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	/*
>>>>> +	 * RT and DL should always send a freq update. But we can do some
>>>>> +	 * simple checks to avoid it when we know it's not necessary.
>>>>> +	 *
>>>>> +	 * iowait_boost will always trigger a freq update too.
>>>>> +	 *
>>>>> +	 * Fair tasks will only trigger an update if the root cfs_rq has
>>>>> +	 * decayed.
>>>>> +	 *
>>>>> +	 * Everything else should do nothing.
>>>>> +	 */
>>>>> +	switch (current->policy) {
>>>>> +	case SCHED_NORMAL:
>>>>> +	case SCHED_BATCH:
>>>>
>>>> What about SCHED_IDLE tasks?
>>>
>>> I didn't think they matter from cpufreq perspective. These tasks will just run
>>> at whatever the idle system is happen to be at and have no specific perf
>>> requirement since they should only run when the system is idle which a recipe
>>> for starvation anyway?
>>
>> Not sure we talk about the same thing here? idle_sched_class vs.
>> SCHED_IDLE policy (FAIR task with a tiny weight of WEIGHT_IDLEPRIO).
> 
> Yes I am referring to SCHED_IDLE policy too. What is your expectation? AFAIK
> the goal of this policy to run when there's nothing else needs running.

IMHO, SCHED_IDLE tasks fight with all the other FAIR task over the
resource rq. I would include SCHED_IDLE into this switch statement next
to SCHED_NORMAL and SCHED_BATCH.
What do you do if only SCHED_IDLE FAIR tasks are runnable? They probably
also want to have their CPU frequency needs adjusted.

[...]

>>>>> @@ -4766,11 +4738,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>>>>  		 */
>>>>>  		detach_entity_load_avg(cfs_rq, se);
>>>>>  		update_tg_load_avg(cfs_rq);
>>>>> -	} else if (decayed) {
>>>>> -		cfs_rq_util_change(cfs_rq, 0);
>>>>> -
>>>>> -		if (flags & UPDATE_TG)
>>>>> -			update_tg_load_avg(cfs_rq);
>>>>> +	} else if (cfs_rq->decayed && (flags & UPDATE_TG)) {
>>>>> +		update_tg_load_avg(cfs_rq);
>>>>>  	}
>>>>>  }
>>>>
>>>> You set cfs_rq->decayed for each taskgroup level but you only reset it
>>>> for the root cfs_rq in __update_cpufreq_ctx_switch() and task_tick_fair()?
>>>
>>> Yes. We only care about using it for root level. Tracking the information at
>>> cfs_rq level is the most natural way to do it as this is what update_load_avg()
>>> is acting on.
>>
>> But IMHO this creates an issue with those non-root cfs_rq's within
> 
> I am not seeing the issue, could you expand on what is it?

I tried to explained it in the 4 lines below. With a local 'decayed'
update_cfs_rq_load_avg() and propagate_entity_load_avg() set it every
time update_load_avg() gets called. And this then determines whether
update_tg_load_avg() is called on this cfs_rq later in update_load_avg().

The new code:

  cfs_rq->decayed |= update_cfs_rq_load_avg() (*)
  cfs_rq->decayed |= propagate_entity_load_avg()

will not reset 'cfs_rq->decayed' for non-root cfs_rq's.

(*) You changed this in v3 from:

  cfs_rq->decayed  = update_cfs_rq_load_avg()


>> update_load_avg() itself. They will stay decayed after cfs_rq->decayed
>> has been set to 1 once and will never be reset to 0. So with UPDATE_TG
>> update_tg_load_avg() will then always be called on those non-root
>> cfs_rq's all the time.
> 
> We could add a check to update only the root cfs_rq. But what do we gain? Or
> IOW, what is the harm of unconditionally updating cfs_rq->decayed given that we
> only care about the root cfs_rq? I see more if conditions and branches which
> I am trying to avoid.

Yes, keep 'decayed' local and add a:

    if (cfs_rq == &rq_of(cfs_rq)->cfs)
        cfs_rq->decayed = decayed






