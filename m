Return-Path: <linux-pm+bounces-13346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53096879A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 14:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805221C21CC5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C4185B6B;
	Mon,  2 Sep 2024 12:35:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3177EDF71;
	Mon,  2 Sep 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280541; cv=none; b=T4XLAEr+m8VesHy5XMtEyvCHtlK876k/MR4A/Y9yWyFbzNaK1UB6gKl77fg+s1zCH0t9gLse4ADwPIlvrtTKnY2GFmGMzEp9DKE1QW3dNFaj+gO9wQddQFhJqOppNqBDJYLR2HDEz3g1pl/IljSwXMbw6PSlGTwhiv/n0w1EC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280541; c=relaxed/simple;
	bh=SUcK1Z2OBNs2Wp+VAUaS0CbMWYJfqEWfxRsvGitxAeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWf9A94BIYlNFwfq0jc9xWwUvKVUcEQDj3hlpibX6SeMn5W+IFROCVEvVDnwXrSn/kVe6g7eCrMsmRifPzDBUy5s7edy6pZIxGKljT8bbUjAtsktkWSyKaboL4KEiBHjrAXnbw3W49WOeClJuhsGG01cLZWiBwqovVoKB9N6Ra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83DB1FEC;
	Mon,  2 Sep 2024 05:36:04 -0700 (PDT)
Received: from [10.57.50.212] (unknown [10.57.50.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E799E3F66E;
	Mon,  2 Sep 2024 05:35:35 -0700 (PDT)
Message-ID: <24a4a74f-0d46-420a-894c-9aa01ea4abcc@arm.com>
Date: Mon, 2 Sep 2024 13:35:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 13:30, Vincent Guittot wrote:
> On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 08/13/24 10:27, Vincent Guittot wrote:
>>> On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
>>> <vincent.guittot@linaro.org> wrote:
>>>>
>>>> On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>> Hi Qais,
>>>>> the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
>>>>> freq updates still bothered me so let me share my thoughts even though
>>>>> it might be niche enough for us not to care.
>>>>>
>>>>> 1. On fast_switch systems, assuming they are fine with handling the
>>>>> actual updates, we have a bit more work on each context_switch() and
>>>>> some synchronisation, too. That should be fine, if anything there's
>>>>> some performance regression in a couple of niche cases.
>>>>>
>>>>> 2. On !fast_switch systems this gets more interesting IMO. So we have
>>>>> a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
>>>>> update request. This task will preempt whatever and currently will
>>>>> pretty much always be running on the CPU it ran last on (so first CPU
>>>>> of the PD).
>>>>
>>>> The !fast_switch is a bit of concern for me too but not for the same
>>>> reason and maybe the opposite of yours IIUC your proposal below:
>>>>
>>>> With fast_switch we have the following sequence:
>>>>
>>>> sched_switch() to task A
>>>> cpufreq_driver_fast_switch -> write new freq target
>>>> run task A
>>>>
>>>> This is pretty straight forward but we have the following sequence
>>>> with !fast_switch
>>>>
>>>> sched_switch() to task A
>>>> queue_irq_work -> raise an IPI on local CPU
>>>> Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
>>>> with 1 CPU per PD)
>>>> sched_switch() to sugov dl task
>>>> __cpufreq_driver_target() which can possibly block on a lock
>>>> sched_switch() to task A
>>>> run task A
>>>>
>>>
>>> sent a bit too early
>>>
>>>> We can possibly have 2 context switch and one IPi for each "normal"
>>>> context switch which is not really optimal
>>>
>>> It would be good to find a way to skip the spurious back and forth
>>> between the normal task and sugov
>>
>> Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
>> Relaxing this will make it less of a problem, but won't eliminate it.
> 
> yes, but it's not a problem of relaxing affinity here
> 
> The problem is that the 1st switch to task A will be preempted by
> sugov so the 1st switch is useless. You should call cpufreq_update
> before switching to A so that we skip the useless switch to task A and
> directly switch to sugov 1st then task A

Not necessarily, if you relax them to all CPUs the sugov tasks for all PDs
can run on CPU0, no matter which CPU task A is on.

There is some benefit on having all sugov threads on the littles for many
platforms (i.e. restricting them), making a good mainline policy out of
it isn't quite so obvious to me.


