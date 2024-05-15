Return-Path: <linux-pm+bounces-7865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7948C6465
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 12:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C6A1F2253F
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C65A0E0;
	Wed, 15 May 2024 10:00:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A469E54645;
	Wed, 15 May 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767247; cv=none; b=GTJKhnKvfpaQ/GnH2LPX4PS/WuJi/fPDQVDb/GTBum0Dhp2B3YqEn44b8BJ1yQSrpDJbOeSFYBS2R8EkpSltYiPTcTe2j3jUw3XT1BVtgceuQGVbTtdrLzOvKIgv0Ok24B2gtUDFN5Xh5LaIHihJiVuBCG9J7ZmO791+Ml1riq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767247; c=relaxed/simple;
	bh=UP6ARF9IZdzS2kDPVK4Ew0G7gxoE0lxuEJNvLxI+258=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ikqv8lUb4tdXnS9TIFL0V87jnW2ocqhqaSZXP9y9v0G/WMYGAhuuAEV/A/2YnUJhBNbUWEojLSWKbu1UeGd6fqs/qfZEEXXvegEE+IkpZjQ7E+xI6pmwSs1HcO5b5x6mKzSIu/62bfO5P85NrkqphQVb5Y4o9ZZMY8MQ95XEo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BB0E1007;
	Wed, 15 May 2024 03:01:09 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6EF3F762;
	Wed, 15 May 2024 03:00:42 -0700 (PDT)
Message-ID: <09717ad7-2a4b-486c-a4f5-e3f09a212add@arm.com>
Date: Wed, 15 May 2024 12:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240512190018.531820-1-qyousef@layalina.io>
 <9e845146-8a31-407c-a5ee-e2e32f1655e5@arm.com>
 <20240513220903.no2j6zl4tk7lr6um@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240513220903.no2j6zl4tk7lr6um@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/05/2024 00:09, Qais Yousef wrote:
> On 05/13/24 14:43, Dietmar Eggemann wrote:
>> On 12/05/2024 21:00, Qais Yousef wrote:
>>
>> [...]
>>
>>> @@ -4682,7 +4659,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>>  
>>>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>>>  
>>> -	cfs_rq_util_change(cfs_rq, 0);
>>> +	cpufreq_update_util(rq_of(cfs_rq), 0);
>>
>> Isn't this slighlty different now?
>>
>> before:
>>
>>    if (&rq->cfs == cfs_rq) {
>>        cpufreq_update_util(rq, ....)
>>    }
>>
>> now:
>>
>>    cpufreq_update_util(rq_of(cfs_rq), ...)
>>
>> You should get way more updates from attach/detach now.
> 
> Yes, well spotted!
> 
> Looking at the path more closely, I can see this is called from
> enqueue_task_fair() path when a task migrates to new CPU. And when
> attach_task_cfs_rq() which is called when we switch_to_fair(), which I already
> cover in the policy change for the RUNNING task, or when
> task_change_group_fair() which what I originally understood Vincent was
> referring to. I moved the update to this function after the detach/attach
> operations with better guards to avoid unnecessary update.

Yeah, all !root cfs_rq attach or detach wouldn't change anything since
the util_avg wouldn't have propagated to the root cfs_rq yet. So
sugov_get_util() wouldn't see a difference.

Yes, enqueue_entity() sets DO_ATTACH unconditionally.

And dequeue_entity() sets DO_DETACH for a migrating (!wakeup migrating)
task.

For a wakeup migrating task we have remove_entity_load_avg() but this
can't remove util_avg from the cfs_rq. This is deferred to
update_cfs_rq_load_avg() in update_load_avg() or __update_blocked_fair().

And switched_{to,from}_fair() (check_class_changed()) and
task_change_group_fair() are the other 2 users of
{attach,detach}_entity_load_avg(). (plus online_fair_sched_group() for
attach).

> I understood this will lead to big change and better apply immediately vs
> wait for the next context switch. But I'll ask the question again, can we drop
> this and defer to context switch?

Hard to say really, probably we can. All benchmarks with score numbers
will create plenty of context switches so you wont see a diff. And for
more lighter testcases you would have to study the differences in trace
files and reason about the implications of potentially kick CPUfreq a
little bit later.

[...]

