Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C2B7D1A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfISOmk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:42:40 -0400
Received: from cmta20.telus.net ([209.171.16.93]:38882 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732606AbfISOmk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Sep 2019 10:42:40 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id AxdeijQG0N5I9AxdfiCpdK; Thu, 19 Sep 2019 08:42:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1568904157; bh=qsEsOn4V0sECDsIsTqqpcyZaf3W8tl4yw4sCR0WiVTk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=U5DwomJrh3bRYkhcLiR/2vupWKfKc85b06kE3tTiXuarJBCZ/529Zba2rCcr9KX74
         diyUsc+4Z+qmtp5TvLa8isjhPLfysrBszid0wmE6WRVKUu/ILEw5U8Yy2hMQmTIoAy
         63xpovk0IsqUslEwufgghgoHPCPZkmJfg4hWCH1GYwDa7jrUGhAwpUyRGeTxcpvAg+
         xJ7sZ9cit+9NAsBlj3TX0ukxXz6B7Zbqtu4OEx+M2J2Fi76oEc8HNAar29i/uUnIaY
         UntclzIKmPAzts6mxBurTh9NBOfm5vGbH0MqWW8j5luLCTWgLWqUL1iOVtsLimC4ad
         4iU2KXtJzZ3AA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=K/Fc4BeI c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8 a=3yQbRBO75ofR69lJigcA:9
 a=Hy-bYUk0Tl6sZ_2g:21 a=H4s1P0xrksXhmr0C:21 a=QEXdDO2ut3YA:10
 a=svzTaB3SJmTkU8mK-ULk:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>
Cc:     <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mgorman@techsingularity.net>,
        <matt@codeblueprint.co.uk>, <viresh.kumar@linaro.org>,
        <juri.lelli@redhat.com>, <pjt@google.com>,
        <vincent.guittot@linaro.org>, <qperret@qperret.net>,
        <dietmar.eggemann@arm.com>, <srinivas.pandruvada@linux.intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <bp@suse.de>, <lenb@kernel.org>, <rjw@rjwysocki.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>         <20190909024216.5942-2-ggherdovich@suse.cz>         <000e01d568b5$87de9be0$979bd3a0$@net> <000301d56a76$0022e630$0068b290$@net> <1568730313.3329.1.camel@suse.cz>
In-Reply-To: <1568730313.3329.1.camel@suse.cz>
Subject: RE: [PATCH 1/2] x86,sched: Add support for frequency invariance
Date:   Thu, 19 Sep 2019 07:42:29 -0700
Message-ID: <001a01d56ef8$7abb07c0$70311740$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdVtYwA14mVTiFQ5RZGnWAIKW2qj0gBjRDQA
X-CMAE-Envelope: MS4wfGGRscLOybzzEQVsuwc2K7T+I2qYlMg0Yx7F0a/GExLEpT67nJ0viAdCunam85Px1X/zoNw893WHez3CBiivEb0VCJnptiLQe5h7sXCHNTe5y8Qc30MI
 CZRqd5Zjt7J3a1gXpZCmIvqS+yHP9KmQ+szxWkz0VZBwRJTLxr8I6Nmlw/544Nkep2RK3c1cCpL9NSdBIbfAQvs+UUv6fiCFnwoiQXugeysnOR1fcuuRCQPl
 oN2RZqhY8YRQGplzm8o6rtfWFgp5XmOnpHEFx2ZI1dAB3fZqISkqlWbEvGjO9265YuOBC8B1nPbBPTOEsIbTS9UuIfxC+cwJU7mj0X1ml5Huuo3JVGjE7Q4Y
 hLgbjVtZq+thd9QWRHq1cH5XuStbtYpbhJiShJtX97Yzhfn4niKAQFUeeX37vNT6f/vjfmqX/yXXWFeAkOpC513R4qwoO1TLI6JyaruMkcM1Nz+8yOx+LUoz
 +Z59WniWjlWjb+6Rb9/OPK0R+FrOhLa/vUoeFekTHVIIwbgiOIqKOnzdaePYISnglYC58P6zF+syllhzXbZtxqqncNrR7uIIs9EKS3YIPi4Y9g2VpSF+ACkd
 n0CD+5CgNPux3aVzw8WzXJZtJtRbXwAe9kEjk1neZcFN/JMV049sowkKVDeYrVwaYfZxacVqQudJ+Yfhr/XXyORHyF+hemAhxdHAES76L9Cwx4w4ZiAsktxK
 0pGmTpCK7Jw9/1tKtIfJREx1mZnhnrJ5JtmTFEuYrHgVD/LwH55pIA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Giovanni,

Thank you for your detailed reply.

On 2019.09.17 07:25 Giovanni Gherdovich wrote:
>On Wed, 2019-09-11 at 08:28 -0700, Doug Smythies wrote:
> [...]

>> The problem with the test is its run to run variability, which was from
>> all the disk I/O, as far as I could determine. At the time,
>> I studied this to death [2], and made a more repeatable test, without
>> any disk I/O.
>> 
>> While the challenges with this work flow have tended to be focused
>> on the CPU frequency scaling driver, I have always considered
>> the root issue here to be a scheduling issue. Excerpt from my notes
>> [2]:
>> 
>>> The issue is that performance is much much better if the system is
>>> forced to use only 1 CPU rather than relying on the defaults where
>>> the CPU scheduler decides what to do.
>>> The scheduler seems to not realize that the current CPU has just
>>> become free, and assigns the new task to a new CPU. Thus the load
>>> on any one CPU is so low that it doesn't ramp up the CPU frequency.
>>> It would be better if somehow the scheduler knew that the current
>>> active CPU was now able to take on the new task, overall resulting
>>> on one fully loaded CPU at the highest CPU frequency.
>> 
>> I do not know if such is practical, and I didn't re-visit the issue.
>>
>
> You're absolutely right, pinning a serialized, fork-intensive workload such as
> gitsource gives you as good of a performance as you can get, because it removes
> the scheduler out of the picture.
>
> So one might be tempted to flag this test as non-representative of a
> real-world scenario;

Disagree. I consider this test to be very representative of real-world
scenarios. However, and I do not know for certain, the relatively high
average fork rate of the gitsource "make test" is less common.

> the reasons we keep looking at it are:
> 1. pinning may not always practical, as you mention
> 2. it's an adversary, worst-case sort of test for some scheduler code paths

Agree.

>> For reference against which all other results are compared
>> is the forced CPU affinity test run. i.e.:
>> 
>> taskset -c 3 test_script.
>> 
>> Mode          Governor                degradation     Power           Bzy_MHz
>> Reference     perf 1 CPU              1.00            reference       3798
>> -             performance             1.2             6% worse        3618
>> passive       ondemand                2.3
>> active        powersave               2.6
>> passive       schedutil               2.7                             1600
>> passive       schedutil-4C            1.68                            2515
>> 
>> Where degradation ratio is the time to execute / the reference time for
>> the same conditions. The test runs over a wide range of processes per
>> second, and the worst ratio has been selected for the above table.
>> I have yet to write up this experiment, but the graphs that will
>> eventually be used are at [4] and [5] (same data presented two
>> different ways).
>
> Your table is interesting; I'd say that the one to beat there (from the
> schedutil point of view) is intel_pstate(active)/performance. I'm slightly
> surprised that intel_pstate(passive)/ondemand is worse than
> intel_pstate(active)/powersave, I'd have guessed the other way around but it's
> also true that the latter lost some grip on iowait_boost in of the recent
> dev cycles.

??
intel_pstate(passive)/ondemand is better than intel_pstate(active)/powersave,
not worse, over the entire range of PIDs (forks) per second and by quite a lot.

>> I did the "make test" method and, presenting the numbers your way,
>> got that 4C took 0.69 times as long as the unpatched schedutil.
>> Your numbers were same or better (copied below, lower is better):
>> 80x-BROADWELL-NUMA:   0.49
>> 8x-SKYLAKE-UMA:               0.55
>> 48x-HASWELL-NUMA:             0.69

> I think your 0.69 and my three values tell the same story: schedutil really
> needs to use the frequency invariant formula otherwise it's out of the
> race. Enabling scale-invariance gives multple tens of percent point in
> advantage.

Agreed. This frequency invariant addition is great. However, if
schedutil is "out of the race" without it, as you say, then isn't
intel_pstate(passive)/ondemand out of the race also? It performs
just as poorly for this test, until very low PIDs per second.

> Now, is it 0.69 or 0.49? There are many factors to it; that's why I'm happy I
> can test on multiple machines and get a somehow more varied picture.
>
> Also, didn't you mention you made several runs and selected the worst one for
> the final score? I was less adventurous and took the average of 5 runs for my
> gitsource executions :) that might contribute to a slightly higher final mark.

No, I did the exact same as you for the gitsource "make test" method, except
that I do 6 runs and throw out the first one and average the next 5.

Yes, I said I picked the worse ratio, but that was for my version of this test,
with the disk I/O and its related non-repeatability eliminated, only to provide
something for readers that did not want to go to my web site to look at the
related graph [1]. I'll send you the graph in a separate e-mail, in case you didn't
go to the web site.

>>>> 
>>>> Compare it to the update formula of intel_pstate/powersave:
>>> 
>>>    freq_next = 1.25 * freq_max * Busy%
>>> 
>>> where again freq_max is 1C turbo and Busy% is the percentage of time not spent
>>> idling (calculated with delta_MPERF / delta_TSC);
>> 
>> Note that the delta_MPERF / delta_TSC method includes idle state 0 and the old
>> method of utilization does not (at least not last time I investigated, which was
>> awhile ago (and I can not find my notes)).
>
> I think that depends on whether or not TSC stops at idle. As understand from
> the Intel Software Developer manual (SDM) a TSC that stops at idle is called
> "invariant TSC", and makes delta_MPERF / delta_TSC interesting. Otherwise the
> two counters behaves exactly the same and the ratio is always 1, modulo the
> delays in actually reading the two values. But all I know comes from
> turbostat's man page and the SDM, so don't quote me on that :)

I was only talking about idle state 0 (polling), where TSC does not stop.

By the way, I have now done some tests with this patch set and multi-threaded
stuff. Nothing to report, it all looks great.

[1] http://www.smythies.com/~doug/linux/single-threaded/gg-pidps2.png

... Doug


