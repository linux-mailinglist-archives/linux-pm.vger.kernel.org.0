Return-Path: <linux-pm+bounces-12140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E78695023B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF571F228CF
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D54189BB1;
	Tue, 13 Aug 2024 10:17:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4217418991F;
	Tue, 13 Aug 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544231; cv=none; b=PRMcXv4nZC+FWqoaRVrHnFIONm9NZGAHJYVYvR6byEuV1sUfmBOg6u0x74J5p02W27gh6KKMfpdBhSHykJk/JLMDJmZhlSU3csNEmupMOIAgW8JY4pNimLdM4zuVusAJPxrZGzo26kQ4inX5TUDab2srtlLr6IWNyONiKXmiD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544231; c=relaxed/simple;
	bh=Xu+iiuReFcW0fn/P8EhrttA79VQ1ERlMzOso3uy9zto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW5f57zrys5wcrNaJuF9IntNBsmbGnlUIgS1ok9OimAkyHwKrueHFtIrr7h9XL6Hs1G1FsWr2MFVyY1ADkTpkG9pgF2qR+yfuOvPhzqpjPwMDYPM1Xu4A0ZJ0qUkfjJ5Qdbh4wT8q8oi0OAPN4QBebMcOMmC2wAQFg1kqpkKQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4173012FC;
	Tue, 13 Aug 2024 03:17:34 -0700 (PDT)
Received: from [10.57.84.20] (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 213D13F40C;
	Tue, 13 Aug 2024 03:17:07 -0700 (PDT)
Message-ID: <25da50cb-776f-42db-9821-e86a441259c0@arm.com>
Date: Tue, 13 Aug 2024 11:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki"
 <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
 <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
 <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 08:54, Vincent Guittot wrote:
> On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
>>
>> On 09/08/24 02:24, Qais Yousef wrote:
>>> Adding more sched folks to CC
>>>
>>> On 08/06/24 14:41, Christian Loehle wrote:
>>>> Convert the sugov deadline task attributes to use the available
>>>> definitions to make them more readable.
>>>> No functional change.
>>>>
>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>> ---
>>>>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>>> index eece6244f9d2..012b38a04894 100644
>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>>>>              * Fake (unused) bandwidth; workaround to "fix"
>>>>              * priority inheritance.
>>>>              */
>>>> -           .sched_runtime  =  1000000,
>>>> -           .sched_deadline = 10000000,
>>>> -           .sched_period   = 10000000,
>>>> +           .sched_runtime  = USEC_PER_SEC,
>>>> +           .sched_deadline = 10 * USEC_PER_SEC,
>>>> +           .sched_period   = 10 * USEC_PER_SEC,
>>>
>>> I think NSEC_PER_MSEC is the correct one. The units in
>>> include/uapi/linux/sched/types.h is not specified. Had to look at
>>> sched-deadline.rst to figure it out.

Huh, that's what I used, see below.

>>
>> In practice it's the same number :). But, you are correct, we want
>> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.
> 
> Yes NSEC_PER_MSEC is the correct unit

Thank you Qais, Juri and Vincent, but if I'm not missing something we
have a contradiction.
This patch should indeed be NSEC_PER_MSEC and I'll send a v2 but:
- Documentation/scheduler/sched-deadline.rst talks about microseconds:
SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
 "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
 "runtime" microseconds of execution time every "period" microseconds, and
 these "runtime" microseconds are available within "deadline" microseconds
 from the beginning of the period.

- sched_setattr / sched_getattr manpages talks about nanoseconds:
       sched_deadline
              This field specifies the "Deadline" parameter for deadline
              scheduling.  The value is expressed in nanoseconds.

- include/uapi/linux/sched/types.h doesn't mention any unit.
I will add that to the v2 series.

- kernel/sched/deadline.c works with nanoseconds internally (although
with the precision limitation in microseconds).

No conversion so
attr->sched_deadline (uapi) == dl_se->dl_deadline (kernel) etc.
So Documentation/scheduler/sched-deadline.rst is false or what is it that
I'm missing?

