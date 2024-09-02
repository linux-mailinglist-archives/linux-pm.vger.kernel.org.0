Return-Path: <linux-pm+bounces-13358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34811968911
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E070D282FF6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA918592D;
	Mon,  2 Sep 2024 13:40:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F819E967;
	Mon,  2 Sep 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284435; cv=none; b=CEXqk3sJrsh8Oox3CP556teQssqAMmoetmtpk4p7usGJnBmyHM268OJN+/C15NlZgWu0e6q8nJfk+LdNH4FauBKUHMxe8efM4K3ZVuyd8MNFyIRX8/AwUJK49xv9sIRjE9WVLwE1ata+nbKbDxCPrjpNLXyCY+zbPDVLSd0zJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284435; c=relaxed/simple;
	bh=p1dAONb+67n9SnBpsFI9G8mepoo+er+WI2qnkJHUgUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAegA4zdh6KRJA6EJ0eDlltLpzXmAjVdomoSwu7NpX2LB2fqtvlCHzRinrR2QeV7bv1SdE+YRwihIhD2HABKoJgG4HvLF/Jrom9y/ebx7XLWC6IAyD/OUCeRjQIG0op/bOHoprWPDRLfsVsqpFLh69Yo5MDpYAIKY4W1WDLUzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB87CFEC;
	Mon,  2 Sep 2024 06:40:57 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BD743F66E;
	Mon,  2 Sep 2024 06:40:28 -0700 (PDT)
Message-ID: <da3100cf-0fb4-4ef8-9e72-da07da381dc8@arm.com>
Date: Mon, 2 Sep 2024 14:40:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hongyan Xia
 <hongyan.xia2@arm.com>, John Stultz <jstultz@google.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu>
 <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <20240902125815.vu3s25ciib34eu3a@airbuntu>
 <20240902133402.dhyhnktol6pqj6jg@airbuntu>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240902133402.dhyhnktol6pqj6jg@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 14:34, Qais Yousef wrote:
> On 09/02/24 13:58, Qais Yousef wrote:
>> On 09/02/24 14:30, Vincent Guittot wrote:
>>> On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
>>>>
>>>> On 08/13/24 10:27, Vincent Guittot wrote:
>>>>> On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
>>>>> <vincent.guittot@linaro.org> wrote:
>>>>>>
>>>>>> On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>>>> Hi Qais,
>>>>>>> the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
>>>>>>> freq updates still bothered me so let me share my thoughts even though
>>>>>>> it might be niche enough for us not to care.
>>>>>>>
>>>>>>> 1. On fast_switch systems, assuming they are fine with handling the
>>>>>>> actual updates, we have a bit more work on each context_switch() and
>>>>>>> some synchronisation, too. That should be fine, if anything there's
>>>>>>> some performance regression in a couple of niche cases.
>>>>>>>
>>>>>>> 2. On !fast_switch systems this gets more interesting IMO. So we have
>>>>>>> a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
>>>>>>> update request. This task will preempt whatever and currently will
>>>>>>> pretty much always be running on the CPU it ran last on (so first CPU
>>>>>>> of the PD).
>>>>>>
>>>>>> The !fast_switch is a bit of concern for me too but not for the same
>>>>>> reason and maybe the opposite of yours IIUC your proposal below:
>>>>>>
>>>>>> With fast_switch we have the following sequence:
>>>>>>
>>>>>> sched_switch() to task A
>>>>>> cpufreq_driver_fast_switch -> write new freq target
>>>>>> run task A
>>>>>>
>>>>>> This is pretty straight forward but we have the following sequence
>>>>>> with !fast_switch
>>>>>>
>>>>>> sched_switch() to task A
>>>>>> queue_irq_work -> raise an IPI on local CPU
>>>>>> Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
>>>>>> with 1 CPU per PD)
>>>>>> sched_switch() to sugov dl task
>>>>>> __cpufreq_driver_target() which can possibly block on a lock
>>>>>> sched_switch() to task A
>>>>>> run task A
>>>>>>
>>>>>
>>>>> sent a bit too early
>>>>>
>>>>>> We can possibly have 2 context switch and one IPi for each "normal"
>>>>>> context switch which is not really optimal
>>>>>
>>>>> It would be good to find a way to skip the spurious back and forth
>>>>> between the normal task and sugov
>>>>
>>>> Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
>>>> Relaxing this will make it less of a problem, but won't eliminate it.
>>>
>>> yes, but it's not a problem of relaxing affinity here
>>
>> If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
>> I am just this will be safe on all platforms of course.
>>
>> But yeah, I don't think this is a solution anyway but the simplest thing to
>> make it harder to hit.
>>
>>> The problem is that the 1st switch to task A will be preempted by
>>> sugov so the 1st switch is useless. You should call cpufreq_update
>>> before switching to A so that we skip the useless switch to task A and
>>> directly switch to sugov 1st then task A
>>
>> Can we do this safely after we pick task A, but before we do the actual context
>> switch? One of the reasons I put this too late is because there's a late call
>> to balance_calbacks() that can impact the state of the rq and important to take
>> into account based on my previous testing and analysis.
>>
>> Any reason we need to run the sugov worker as DL instead for example being
>> a softirq?
> 
> I assume it performs non interrupt context safe operations. But I don't think
> I've ever seen it sleep during an activation.

That is the distinction of fast_switch and slow_switch though, isn't it?
See documentation of cpufreq_driver_fast_switch()
* Carry out a fast frequency switch without sleeping.                          

