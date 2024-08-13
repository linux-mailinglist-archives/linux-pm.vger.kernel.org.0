Return-Path: <linux-pm+bounces-12154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C46950693
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D04288535
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675EE19DF59;
	Tue, 13 Aug 2024 13:34:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945219DF51;
	Tue, 13 Aug 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556050; cv=none; b=VcVqTDXIyh1e3DOcW4jLzfFhA9YrzDv6EdGtgnJxPsaS/FpBOEtSJKCg6W7wOO+yYmKkIQwOhiAOaoGwpRjzRKByFPw8kwx0xbonSycY7lLriRwtpakQFF5iGjTaVShYp0AghVx4zlfxYqKCzlObBxaS8CLnn2sN1VD+1NH0OgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556050; c=relaxed/simple;
	bh=lU2SQ94URlj66gon0D6KadISJnb6ovZPlwcfEoHfkFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdasFPZXoyzRGfIE5FA5CVOz/j32LfWCxZevM4lkg1bmqfZmjXn/97RaqzoCjbVEDUVtU3SIZd3TOwuJ+1kgkmr1LJt+OcHZrY7brbQ8R5DuxQKP0eDvQInUUF6ehik2JRn9dTGt8fyfVQcKox1AiWakHMJ0wylRzfPdj5oJTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D515E12FC;
	Tue, 13 Aug 2024 06:34:33 -0700 (PDT)
Received: from [10.57.84.20] (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2029B3F6A8;
	Tue, 13 Aug 2024 06:34:05 -0700 (PDT)
Message-ID: <459ae1ee-d114-4fdc-b728-33bde5d08e24@arm.com>
Date: Tue, 13 Aug 2024 14:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
 <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
 <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
 <25da50cb-776f-42db-9821-e86a441259c0@arm.com>
 <ZrtdYXW2VullBiop@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ZrtdYXW2VullBiop@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 14:19, Juri Lelli wrote:
> On 13/08/24 11:17, Christian Loehle wrote:
>> On 8/13/24 08:54, Vincent Guittot wrote:
>>> On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
>>>>
>>>> On 09/08/24 02:24, Qais Yousef wrote:
>>>>> Adding more sched folks to CC
>>>>>
>>>>> On 08/06/24 14:41, Christian Loehle wrote:
>>>>>> Convert the sugov deadline task attributes to use the available
>>>>>> definitions to make them more readable.
>>>>>> No functional change.
>>>>>>
>>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>>>> ---
>>>>>>  kernel/sched/cpufreq_schedutil.c | 6 +++---
>>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>>>>>> index eece6244f9d2..012b38a04894 100644
>>>>>> --- a/kernel/sched/cpufreq_schedutil.c
>>>>>> +++ b/kernel/sched/cpufreq_schedutil.c
>>>>>> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>>>>>>              * Fake (unused) bandwidth; workaround to "fix"
>>>>>>              * priority inheritance.
>>>>>>              */
>>>>>> -           .sched_runtime  =  1000000,
>>>>>> -           .sched_deadline = 10000000,
>>>>>> -           .sched_period   = 10000000,
>>>>>> +           .sched_runtime  = USEC_PER_SEC,
>>>>>> +           .sched_deadline = 10 * USEC_PER_SEC,
>>>>>> +           .sched_period   = 10 * USEC_PER_SEC,
>>>>>
>>>>> I think NSEC_PER_MSEC is the correct one. The units in
>>>>> include/uapi/linux/sched/types.h is not specified. Had to look at
>>>>> sched-deadline.rst to figure it out.
>>
>> Huh, that's what I used, see below.
>>
>>>>
>>>> In practice it's the same number :). But, you are correct, we want
>>>> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.
>>>
>>> Yes NSEC_PER_MSEC is the correct unit
>>
>> Thank you Qais, Juri and Vincent, but if I'm not missing something we
>> have a contradiction.
>> This patch should indeed be NSEC_PER_MSEC and I'll send a v2 but:
>> - Documentation/scheduler/sched-deadline.rst talks about microseconds:
>> SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
>>  "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
>>  "runtime" microseconds of execution time every "period" microseconds, and
>>  these "runtime" microseconds are available within "deadline" microseconds
>>  from the beginning of the period.
>>
>> - sched_setattr / sched_getattr manpages talks about nanoseconds:
>>        sched_deadline
>>               This field specifies the "Deadline" parameter for deadline
>>               scheduling.  The value is expressed in nanoseconds.
>>
>> - include/uapi/linux/sched/types.h doesn't mention any unit.
>> I will add that to the v2 series.
>>
>> - kernel/sched/deadline.c works with nanoseconds internally (although
>> with the precision limitation in microseconds).
>>
>> No conversion so
>> attr->sched_deadline (uapi) == dl_se->dl_deadline (kernel) etc.
>> So Documentation/scheduler/sched-deadline.rst is false or what is it that
>> I'm missing?
>>
> 
> As you say above, internal resolution is essentially down to 1us
> (microsecond) and we also check that parameters are at least 1us or
> bigger [1].
> 
> syscalls and internal mechanics work with nanoseconds, but I don't think
> this is a contradiction.
> 
> 1 - https://elixir.bootlin.com/linux/v6.10.4/source/kernel/sched/deadline.c#L3065
> 

All good then you reckon?
Still the part about schedtool is wrong:

-->8--

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9fe4846079bb..f7475d101e7a 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -759,7 +759,7 @@ Appendix A. Test suite
   # schedtool -E -t 10000000:100000000 -e ./my_cpuhog_app
 
  With this, my_cpuhog_app is put to run inside a SCHED_DEADLINE reservation
- of 10ms every 100ms (note that parameters are expressed in microseconds).
+ of 10ms every 100ms (note that parameters are expressed in nanoseconds).
  You can also use schedtool to create a reservation for an already running
  application, given that you know its pid::
 

