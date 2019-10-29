Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5784CE8B41
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbfJ2Ozi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 10:55:38 -0400
Received: from cmta18.telus.net ([209.171.16.91]:60729 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389640AbfJ2Ozi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 10:55:38 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id PSu8iYL7wgu2QPSu9iBTYP; Tue, 29 Oct 2019 08:55:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572360936; bh=AOJLWPSLYgaT+Ehe7RkC1T4tGEF13LSGV+XxBMtZ+2c=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=IJ5XD5tCN8ujqjxpNDEOMJcDya0aD/FoYRqfDEQnOQS28UDRAw3okzkW5aC5s7Fyz
         hEgNB7TbAGvbSPZtWcSVm8rVTGFau7qG7is94f03dDAMIBRVEd4gnCrWJ3HwxKg9EH
         p9CLG8GTlj3Kw+5+h9e9Aw747WFYKKA7QjIlRfvryL9vuhmKfZc/MrGWSDKQnQUNjH
         XDzubcc1Pu4Dv/56BAC8CI9ME2dQ1HXdBAph4YvXsdjVECoSMlcgcI5OdMDWh+Mx+h
         fLXRgq+dQWOqXOtU00E0OTBuDEyxstFoxMfY46gB5EiI5vtbtLdfBnVbYxjsOqWAiN
         e78A4ABAtCOsQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=QIcWuTDL c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aatUQebYAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=fwyzoN0nAAAA:8 a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=g89Xgr21wEJfR344xdQA:9
 a=y4eRWvFj_7CgjE1O:21 a=tcg5UhvJsACvx3I_:21 a=QEXdDO2ut3YA:10
 a=7715FyvI7WU-l6oqrZBK:22 a=AjGcO6oz07-iQ99wixmX:22 a=Sc3RvPAMVtkGz6dGeUiH:22
 a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Vincent Guittot'" <vincent.guittot@linaro.org>
Cc:     "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Ingo Molnar'" <mingo@kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Sargun Dhillon'" <sargun@sargun.me>,
        "'Tejun Heo'" <tj@kernel.org>, "'Xie XiuQi'" <xiexiuqi@huawei.com>,
        <xiezhipeng1@huawei.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Rik van Riel'" <riel@surriel.com>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net> <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com> <000c01d58bca$f5709b30$e051d190$@net> <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
In-Reply-To: <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
Subject: RE: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load balancing path"
Date:   Tue, 29 Oct 2019 07:55:26 -0700
Message-ID: <001201d58e68$eaa39630$bfeac290$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWNaMsMJ/vPri4wSOCa/R5R5HdKJwAPeH4Q
X-CMAE-Envelope: MS4wfDvYKlZtNiTE/l/nEj6dUPSZjWE3AQOEuXhKUvAAu5+Fp3PXCNzgVqVcDAKbZsZIwtQIF46U1e7EYoQKfq5r2Xah+AF1guFIar0TOYVwuqfrqv/aYylD
 VKci+iQJB2/qCkDVVekqRsp0wgpmcgOeXZHICOyghI7ecd5qeqJZkOV2ebFnhujqT+vTrQES9fsNni0cwzuxCywZf92jp2nkJWlag9VPkfUZGJHRsc7+bR2p
 kQZYwjUqfmFEkkHnLdnc4FATJtzq/IRNgItwP0B8aZLnFueriQ+CxDAWgS/U00/219qZgpTHjnBWam5Myu2XnVvJDfTcXaFqGy8tGXKiK4e6dsSaw7dgfaGh
 ZUrYAOu8X1gS1PgdjXhjylJnFlQu3fUeabTOIu9AmkHuL7vSGT2irIIDFkYl96VBjZUUSL9coduuiwO5iSFWVrQpcKtAOmukmo1UIeP6iUaE2NQyNHlOH+1L
 9qmjjRB4Z5xyODwm233++jy0epipxs3/UgDha38BsvhEXuiJ2baMDBnVl8KgWPUyqRTtKZXKRuRCExG+vu51ui8mTYyRZ89kPlUb2Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.28 01:22 Vincent Guittot wrote:
> On Sat, 26 Oct 2019 at 08:59, Doug Smythies <dsmythies@telus.net> wrote:
>> On 2010.10.25 09:51 Vincent Guittot wrote:
>>> On Fri, 25 Oct 2019 at 17:55, Doug Smythies <doug.smythies@gmail.com> wrote:
>>>>
>>>> This reverts commit 039ae8bcf7a5f4476f4487e6bf816885fb3fb617,
>>>> which, in turn, was a re-apply of
>>>> commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
>>>> after it was reverted via
>>>> commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")
>>>>
>>>> For an idle system, the cfs_rq_is_decayed function components can underflow to 0 and
>>>> incorrectly return TRUE, when the item should not be deleted from the list.
>>>
>>> The patch from Rik solves the problem of cfs_rq_is_decayed wrongly returns true
>>> https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
>>
>> Not for my use case.
>>
>> I applied Rik's patch to kernel 5.4-rc2 (since all my other reference
>> test data had been acquired against a base of 5.4-rc2). Tests results
>> are similar to the non-reverted kernel (results added in-line
>> below).
>
> Ok.
>
> I have studied a bit more your results below and IIUC your problem,
> some periodic wakes up (every 4sec) are missing with kernel 5.4-rc2

Actually, I don't know that the periodic wake ups are missing, I only
know that the intel_pstate CPU scaling driver is not being called.
This has been since kernel 5.1-rc1.
I bisected the kernel and found the patch that is this subject.
Then I used kernel 5.4-rc2 as my baseline for the data submitted.

Looking at the number of clocks cycles that have being used since the last
call to the driver suggests that the CPU has been doing something between
the long time between calls:
For the example given, there were 20,716,861 active clocks in 327.175
seconds. At 4 seconds per doing something that's 253,286 clocks each,
which is consistent (o.k. the variability is high) with actual data
(and, for example, see the aperf number of 231,813 clocks for the
4 second example given below).

> that helps cpuidle to enters deeper idle state after each new wake up
> until reaching the deepest state, isn't it ?

Well, it is the delay in the intel_pstate driver calls that is the
root issue. Dragging idle into it was just the use case example that
started this investigation.

> My 1st point is that this code doesn't use timer or hrtimer to wake up
> the system but only take advantage of the wake up of something else to
> update the blocked load. So I don't see how this patch could remove
> the 4sec periodic wakeup of the watchdog timer that you are
> mentioning.

I don't know that it is, as mentioned above.

> Then, when a system is idle and not used, the load should obviously be
> null most of the time and the update of decayed load should not happen
> anyway. It looks like you take advantage of some spurious and
> un-necessary wake up to help cpuidle to reach deeper idle state. Is
> this understanding correct ?

I don't know.

I only know that the call to the intel_pstate driver doesn't
happen, and that it is because cfs_rq_is_decayed returns TRUE.
So, I am asserting that the request is not actually decayed, and
should not have been deleted. Furthermore, I am wondering if other
tasks that should be run are suffering the same fate.

Now, if we also look back at the comments for the original commit:

	"In an edge case where temporary cgroups were leaking, this
	caused the kernel to consume good several tens of percents of
	CPU cycles running update_blocked_averages(), each run taking
	multiple millisecs."

To my way of thinking: Fix the leak, don't program around it; The
commit breaks something else, so revert it.

>
> Then, without or without removing the cfs_rq from the list, we should
> end up with rq->has_blocked_load == 0 and nohz.has_blocked == 0 too.
> The only main impact will be the duration of the loop that can be
> significantly shorter when you have a lot of rqs and cgroups.

I'm not following.

>
>>>>
>>>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@kernel.org>
>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: sargun@sargun.me
>>>> Cc: tj@kernel.org
>>>> Cc: xiexiuqi@huawei.com
>>>> Cc: xiezhipeng1@huawei.com
>>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>>>
>>>> ---
>>>> Note 1: Both this reversion and just deleting the cfs_rq_is_decayed function
>>>> and it's call and leaving the other changes have been tested. I do not know
>>>> which solution is better. (ie for the "list_for_each_entry_rcu" part of it.)
>>>>
>>>> Note 2: Previous controversy over this patch was based on heavy workloads,
>>>> but this is based on minimal or no workload, or "idle".
>>>> Where "idle" on my test server, with no gui and many services disabled,
>>>> tends to mean more "idle" than most systems.
>>>>
>>>> Note 3: While this supporting data only involves the intel_pstate CPU
>>>> frequency scaling driver as a casualty, it is beyond my capabilities
>>>> to determine what other tasks that should be running might be omitted.
>>>>
>>>> Use case example 1:
>>>> System Idle: The intel pstate CPU frequency scaling driver:
>>>> Mode: Active, non-hwp, powersave governor.
>>>> Expected behaviour: There is never ever a duration (time between calls to
>>>> the driver / per CPU) longer than 4 seconds (the watchdog time, I think).
>>>> Actual behaviour: There are long long gaps between calls to the driver:
>>>>
>>>> Kernel: 5.4-rc2 CPU:7
>>>> duration: 327.17 Seconds. (this is one of many hundreds of examples.)
>>>> mpref: 44023326
>>>> apref: 20716861
>>>> tsc: 1.11604E+12
>>>> load: 0
>>>> CPU frequency: 1.6053 GHz (average over this 327 second sample period).
>>>> old pstate: 16 (the lowest for my processor)
>>>> new pstate: 16
>>>>
>>>> Kernel: 5.4-rc2 + reversion (either method)
>>>> After several hours of testing, maximum durations were never more
>>>> than 4 seconds (well plus some jitter).
>>>> reversion method: max=4.07908 seconds
>>>> CPU:7
>>>> mperf: 492578
>>>> apref: 231813 (56,829 per second average is consistent with other tests)
>>>> tsc: 13914264074
>>>> load: 0
>>>> CPU frequency: 1.6052 GHz
>>>> old pstate: 16 (the lowest for my precessor)
>>>> new pstate: 16
>>>>
>>>> On average, the non-reverted kernel executes the driver 25% less
>>>> than the reverted kernel during idle.
>>
>> On (shorter)average, the Rik patched kernel executes the driver
>> 14% less than the reverted kernel during idle.
>>
>> Longer and repeated testing would be required to determine if
>> this is a trend or simply non-repeatable noise.

The difference in probabilities of the issue occurring does appear to be
somewhat consistent. Not sure what it means, if anything.

>>>> O.K. so who cares, the requested pstate doesn't change?
>>>> First, one wonders if the math could overflow.
>>>> (although 7180ddd suggests maybe it won't)
>>>> Second, the sample is largely dominated by obsolete information.
>>>> Third, this can be problematic, and potentially wastes energy,
>>>> for the busy to idle transition.
>>>>
>>>> Use case example 2:
>>>> The busy to idle transition:
>>>>
>>>> Typically, the pstate request response to a busy to idle transition
>>>> is very slow because the duration suddenly goes from, typically,
>>>> 10 milliseconds to much much longer, up to 4 seconds. Transition
>>>> times to the system being fully idle, with all requested pstates
>>>> being at minimum, takes around 8 seconds with this reversion,
>>>> and, potentially, a very very long time (over 100 seconds has been
>>>> measured) without.
>>>>
>>>> Again, so who cares, if the processor is in a deep idle state anyway,
>>>> not consuming much energy? O.K. but what if it is in an idle state
>>>> where energy consumption is a function of the requested pstate?
>>>> For example, for my processor (i7-2600K), idle state 1, then processor
>>>> package energy can be over double what it should be for many 10s of
>>>> seconds.
>>>>
>>>> Experiment method:
>>>>
>>>> enable only idle state 1
>>>> Dountil stopped
>>>>   apply a 100% load (all CPUs)
>>>>   after awhile (about 50 seconds) remove the load.
>>>>   allow a short transient delay (1 second).
>>>>   measure the processor package joules used over the next 149 seconds.
>>>> Enduntil
>>>>
>>>> Kernel k5.4-rc2 + reversion (this method)
>>>> Average processor package power: 9.148 watts (128 samples, > 7 hours)
>>>> Minimum: 9.02 watts
>>>> Maximum: 9.29 watts
>>>> Note: outlyer data point group removed, as it was assumed the computer
>>>> had something to do and wasn't actually "idle".
>>>>
>>>> Kernel 5.4-rc2:
>>>> Average processor package power: 9.969 watts (150 samples, > 8 hours)
>>>> Or 9% more energy for the idle phases of the work load.
>>>> Minimum: 9.15 watts
>>>> Maximum: 13.79 watts (51% more power)
>>
>> Kernel 5.4-rc2 + Rik-patch:
>> Average processor package power: 9.85 watts (53 samples, < 3 hours)
>> Or 7.7% more energy for the idle phases of the work load.
>> Minimum: 9.23 watts
>> Maximum: 12.79 watts (40% more power)


