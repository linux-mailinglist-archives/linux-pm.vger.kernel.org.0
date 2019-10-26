Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB7E58E7
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2019 08:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfJZG7w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Oct 2019 02:59:52 -0400
Received: from cmta17.telus.net ([209.171.16.90]:45331 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfJZG7w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Oct 2019 02:59:52 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id OG34iQ0jPbg38OG36inJfv; Sat, 26 Oct 2019 00:59:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572073190; bh=aNeAgRVxJMvpFDpvPSlcVC9IWfr9DUAcU3M0fLFw4nw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=PS+GP1qBYbSm6ObNbnSsmFSBVXqKR7MqeC3+f2nMl1O1ycvz+XXlGGxNJxv3anHU1
         F/8JXYAIWO0lcieu2rzbGwbCgOuIRAMjvCEU6l6biRqldHMPKjmzyHO6TgX4Q4JRyJ
         RRA7MlFchxeI/gFW+e1rmPr4fY4bXpcYWoqOQiZwLgyR67OKzNLmfTjZ7EYebZIaas
         VVtJpAWjcfHvcELqaGd+h4eMkEx90fsSAXTEPpCImPBbVQnXjIMzA7cmfVOpE8Tv7+
         xKTbJQgMV0tc2k0X5zjdO+jzVFw6RmaWGwxrUd3ve3N8GCJg+X77Jwo4NY0hHjstMM
         Xa27KusS+b3/g==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=O/1HQy1W c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=fwyzoN0nAAAA:8
 a=aatUQebYAAAA:8 a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=dseLGN2P6mxj_P1ppjoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=Sc3RvPAMVtkGz6dGeUiH:22 a=7715FyvI7WU-l6oqrZBK:22
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
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net> <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
Subject: RE: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load balancing path"
Date:   Fri, 25 Oct 2019 23:59:41 -0700
Message-ID: <000c01d58bca$f5709b30$e051d190$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdWLVGs9CusObHsRSmCblhUnwqZNXwAKKLKg
X-CMAE-Envelope: MS4wfN0lhk1RruJcql3NN6/TjzFHMeI4Z2aBD6dN1Tf+hjDFIT+IfUIMS2KCKeY0uJ1H00enT18NXMrxN04vxJRKJVYcFW3XQj5k4zI2Fiqb3PJzR5Cjtqky
 pPXuFgqEGqZBXn1H83wu4RkxXwNUXBTAq8jbcP6l3iFwyoaMU7IOh4AvMqKYtuQOoWSW/BiN8mVR5Y/RPcEQXoOHHEz3sLSjMicIsfj9Prgd80RO5Y7jph6E
 suXsDIjmqA0/LdhwJm/cCwHJBs+CYhFbO/F0TOo3i/7Lgsowh86wALC4QaPO0EbdUA1iys1ndU0cBAPYCDn0GSl9dqSEqZnwZ5ptWMM8vJKIUmyNBflTYM0p
 KLjLP07xGQ5dGBUlERuv46FMHopKv23tO6qfPImPiHc2SKM882NgIBmUY7tr9iqL7K4z+3nJ7w2WLMA7hOctO0ZDK1oE+KVqFG7dU5eMvDph0SxbJtVzTMYC
 +w+uznk4bQBDpzZt0rFMlPTZrDuDBPH7hGp1IVbZhG0BruCkprxS44a+naom8AnI0P5WcgSt/imeJsEiWavn9ztu5Oj51yr1t4hafA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

Thank you for your quick reply.

On 2010.10.25 09:51 Vincent Guittot wrote:
> On Fri, 25 Oct 2019 at 17:55, Doug Smythies <doug.smythies@gmail.com> wrote:
>>
>> This reverts commit 039ae8bcf7a5f4476f4487e6bf816885fb3fb617,
>> which, in turn, was a re-apply of
>> commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
>> after it was reverted via
>> commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")
>>
>> For an idle system, the cfs_rq_is_decayed function components can underflow to 0 and
>> incorrectly return TRUE, when the item should not be deleted from the list.
>
> The patch from Rik solves the problem of cfs_rq_is_decayed wrongly returns true
> https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/

Not for my use case.

I applied Rik's patch to kernel 5.4-rc2 (since all my other reference
test data had been acquired against a base of 5.4-rc2). Tests results
are similar to the non-reverted kernel (results added in-line
below).

>>
>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: sargun@sargun.me
>> Cc: tj@kernel.org
>> Cc: xiexiuqi@huawei.com
>> Cc: xiezhipeng1@huawei.com
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>> ---
>> Note 1: Both this reversion and just deleting the cfs_rq_is_decayed function
>> and it's call and leaving the other changes have been tested. I do not know
>> which solution is better. (ie for the "list_for_each_entry_rcu" part of it.)
>>
>> Note 2: Previous controversy over this patch was based on heavy workloads,
>> but this is based on minimal or no workload, or "idle".
>> Where "idle" on my test server, with no gui and many services disabled,
>> tends to mean more "idle" than most systems.
>>
>> Note 3: While this supporting data only involves the intel_pstate CPU
>> frequency scaling driver as a casualty, it is beyond my capabilities
>> to determine what other tasks that should be running might be omitted.
>>
>> Use case example 1:
>> System Idle: The intel pstate CPU frequency scaling driver:
>> Mode: Active, non-hwp, powersave governor.
>> Expected behaviour: There is never ever a duration (time between calls to
>> the driver / per CPU) longer than 4 seconds (the watchdog time, I think).
>> Actual behaviour: There are long long gaps between calls to the driver:
>>
>> Kernel: 5.4-rc2 CPU:7
>> duration: 327.17 Seconds. (this is one of many hundreds of examples.)
>> mpref: 44023326
>> apref: 20716861
>> tsc: 1.11604E+12
>> load: 0
>> CPU frequency: 1.6053 GHz (average over this 327 second sample period).
>> old pstate: 16 (the lowest for my processor)
>> new pstate: 16
>>
>> Kernel: 5.4-rc2 + reversion (either method)
>> After several hours of testing, maximum durations were never more
>> than 4 seconds (well plus some jitter).
>> reversion method: max=4.07908 seconds
>> CPU:7
>> mperf: 492578
>> apref: 231813 (56,829 per second average is consistent with other tests)
>> tsc: 13914264074
>> load: 0
>> CPU frequency: 1.6052 GHz
>> old pstate: 16 (the lowest for my precessor)
>> new pstate: 16
>>
>> On average, the non-reverted kernel executes the driver 25% less
>> than the reverted kernel during idle.

On (shorter)average, the Rik patched kernel executes the driver
14% less than the reverted kernel during idle.

Longer and repeated testing would be required to determine if
this is a trend or simply non-repeatable noise.

>> O.K. so who cares, the requested pstate doesn't change?
>> First, one wonders if the math could overflow.
>> (although 7180ddd suggests maybe it won't)
>> Second, the sample is largely dominated by obsolete information.
>> Third, this can be problematic, and potentially wastes energy,
>> for the busy to idle transition.
>>
>> Use case example 2:
>> The busy to idle transition:
>>
>> Typically, the pstate request response to a busy to idle transition
>> is very slow because the duration suddenly goes from, typically,
>> 10 milliseconds to much much longer, up to 4 seconds. Transition
>> times to the system being fully idle, with all requested pstates
>> being at minimum, takes around 8 seconds with this reversion,
>> and, potentially, a very very long time (over 100 seconds has been
>> measured) without.
>>
>> Again, so who cares, if the processor is in a deep idle state anyway,
>> not consuming much energy? O.K. but what if it is in an idle state
>> where energy consumption is a function of the requested pstate?
>> For example, for my processor (i7-2600K), idle state 1, then processor
>> package energy can be over double what it should be for many 10s of
>> seconds.
>>
>> Experiment method:
>>
>> enable only idle state 1
>> Dountil stopped
>>   apply a 100% load (all CPUs)
>>   after awhile (about 50 seconds) remove the load.
>>   allow a short transient delay (1 second).
>>   measure the processor package joules used over the next 149 seconds.
>> Enduntil
>>
>> Kernel k5.4-rc2 + reversion (this method)
>> Average processor package power: 9.148 watts (128 samples, > 7 hours)
>> Minimum: 9.02 watts
>> Maximum: 9.29 watts
>> Note: outlyer data point group removed, as it was assumed the computer
>> had something to do and wasn't actually "idle".
>>
>> Kernel 5.4-rc2:
>> Average processor package power: 9.969 watts (150 samples, > 8 hours)
>> Or 9% more energy for the idle phases of the work load.
>> Minimum: 9.15 watts
>> Maximum: 13.79 watts (51% more power)

Kernel 5.4-rc2 + Rik-patch:
Average processor package power: 9.85 watts (53 samples, < 3 hours)
Or 7.7% more energy for the idle phases of the work load.
Minimum: 9.23 watts
Maximum: 12.79 watts (40% more power)



