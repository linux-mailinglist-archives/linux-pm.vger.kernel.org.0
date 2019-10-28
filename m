Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48607E6DF8
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 09:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbfJ1IWK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 04:22:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37613 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbfJ1IWJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 04:22:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id b20so7099232lfp.4
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIXlgbuERO/r+OjB+yKUqeYDRiwYPjVnkieIgWyt76w=;
        b=B38VAYDz7qc5eZ8v5Iut7ThwwndNb99Ya5qXU0gbehUWiTYDZMTxGBEaCnMWoZoPsh
         ajRnJG99o6njVwv897rCPyDYuHmsbqcOHtZqXWOB/LlogIMJzbJeKn3ZwBL/HQ0lcdBm
         0+FCMDnwHdGcVN1XympRw//aUoeIT+T2HJRv+isUqnMGMTcS7Q5Z36qZz+2UhedKIPlT
         XJcC2dH7zTgQf0YxajYl8HCAoEd1U1k02bDlpn6X9GO34T85epiOLZsCXJFJQOd/P9iP
         forqXjz5VBEi/G76JrQ9Gwb4d2exLLq8u52qb+U0GOQgGkFb/8MqakYjBpiNSJ/n4huK
         OrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIXlgbuERO/r+OjB+yKUqeYDRiwYPjVnkieIgWyt76w=;
        b=c4BrSDKq2MCBDWbYZQ836+kN67XME1lRNogizGmwQDinvjs/T7vE0vzzcn4omu+rPy
         dN5eJePWru3WTAca8d2PXhwI0tGk9qQQ8Ip+7gSnyFvsJcMufRV9mBPsma2o0c+R1yv8
         HnC/NPgNBwp+Mp46tQvJnHJbA4E+jVdXLDyj2BmJWt0+pXdszLkKKavvaa7RiR354WES
         lKCYuaDLqeKr4On/INe1sO3gD0+ICyqjNqiNzZ9b2221KLWnj7ZkT9UAYfsxmzv2BnLk
         B6ixxXxoIBThsTL9SHqH12XFLCvYRjjMVKXAzJqYEf9rR7XZS9bDuQi34vmv6vjbwa5p
         K7uw==
X-Gm-Message-State: APjAAAUnOIdQwdK/cex6DMk7XJY6xRomGenJSmjekKV+LcurJx/0SgxO
        IOfRbSjv40rQ3kxu4sHjDZZ8A8++VHT4BHHIJ6h5Cg==
X-Google-Smtp-Source: APXvYqza5pTaS++YI4hlLxfxykVGNaV2Fn1clU+Uo5Dt9cYfwofGwz5UP5QFaU5rW1I/qlKWV/BS+j95kSnH2jGyXSU=
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr3255017lfq.177.1572250926616;
 Mon, 28 Oct 2019 01:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com> <000c01d58bca$f5709b30$e051d190$@net>
In-Reply-To: <000c01d58bca$f5709b30$e051d190$@net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 28 Oct 2019 09:21:55 +0100
Message-ID: <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 26 Oct 2019 at 08:59, Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Vincent,
>
> Thank you for your quick reply.
>
> On 2010.10.25 09:51 Vincent Guittot wrote:
> > On Fri, 25 Oct 2019 at 17:55, Doug Smythies <doug.smythies@gmail.com> wrote:
> >>
> >> This reverts commit 039ae8bcf7a5f4476f4487e6bf816885fb3fb617,
> >> which, in turn, was a re-apply of
> >> commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
> >> after it was reverted via
> >> commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")
> >>
> >> For an idle system, the cfs_rq_is_decayed function components can underflow to 0 and
> >> incorrectly return TRUE, when the item should not be deleted from the list.
> >
> > The patch from Rik solves the problem of cfs_rq_is_decayed wrongly returns true
> > https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
>
> Not for my use case.
>
> I applied Rik's patch to kernel 5.4-rc2 (since all my other reference
> test data had been acquired against a base of 5.4-rc2). Tests results
> are similar to the non-reverted kernel (results added in-line
> below).

Ok.

I have studied a bit more your results below and IIUC your problem,
some periodic wakes up (every 4sec) are missing with kernel 5.4-rc2
that helps cpuidle to enters deeper idle state after each new wake up
until reaching the deepest state, isn't it ?
My 1st point is that this code doesn't use timer or hrtimer to wake up
the system but only take advantage of the wake up of something else to
update the blocked load. So I don't see how this patch could remove
the 4sec periodic wakeup of the watchdog timer that you are
mentioning.
Then, when a system is idle and not used, the load should obviously be
null most of the time and the update of decayed load should not happen
anyway. It looks like you take advantage of some spurious and
un-necessary wake up to help cpuidle to reach deeper idle state. Is
this understanding correct ?

Then, without or without removing the cfs_rq from the list, we should
end up with rq->has_blocked_load == 0 and nohz.has_blocked == 0 too.
The only main impact will be the duration of the loop that can be
significantly shorter when you have a lot of rqs and cgroups.

>
> >>
> >> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> >> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@kernel.org>
> >> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: sargun@sargun.me
> >> Cc: tj@kernel.org
> >> Cc: xiexiuqi@huawei.com
> >> Cc: xiezhipeng1@huawei.com
> >> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >>
> >> ---
> >> Note 1: Both this reversion and just deleting the cfs_rq_is_decayed function
> >> and it's call and leaving the other changes have been tested. I do not know
> >> which solution is better. (ie for the "list_for_each_entry_rcu" part of it.)
> >>
> >> Note 2: Previous controversy over this patch was based on heavy workloads,
> >> but this is based on minimal or no workload, or "idle".
> >> Where "idle" on my test server, with no gui and many services disabled,
> >> tends to mean more "idle" than most systems.
> >>
> >> Note 3: While this supporting data only involves the intel_pstate CPU
> >> frequency scaling driver as a casualty, it is beyond my capabilities
> >> to determine what other tasks that should be running might be omitted.
> >>
> >> Use case example 1:
> >> System Idle: The intel pstate CPU frequency scaling driver:
> >> Mode: Active, non-hwp, powersave governor.
> >> Expected behaviour: There is never ever a duration (time between calls to
> >> the driver / per CPU) longer than 4 seconds (the watchdog time, I think).
> >> Actual behaviour: There are long long gaps between calls to the driver:
> >>
> >> Kernel: 5.4-rc2 CPU:7
> >> duration: 327.17 Seconds. (this is one of many hundreds of examples.)
> >> mpref: 44023326
> >> apref: 20716861
> >> tsc: 1.11604E+12
> >> load: 0
> >> CPU frequency: 1.6053 GHz (average over this 327 second sample period).
> >> old pstate: 16 (the lowest for my processor)
> >> new pstate: 16
> >>
> >> Kernel: 5.4-rc2 + reversion (either method)
> >> After several hours of testing, maximum durations were never more
> >> than 4 seconds (well plus some jitter).
> >> reversion method: max=4.07908 seconds
> >> CPU:7
> >> mperf: 492578
> >> apref: 231813 (56,829 per second average is consistent with other tests)
> >> tsc: 13914264074
> >> load: 0
> >> CPU frequency: 1.6052 GHz
> >> old pstate: 16 (the lowest for my precessor)
> >> new pstate: 16
> >>
> >> On average, the non-reverted kernel executes the driver 25% less
> >> than the reverted kernel during idle.
>
> On (shorter)average, the Rik patched kernel executes the driver
> 14% less than the reverted kernel during idle.
>
> Longer and repeated testing would be required to determine if
> this is a trend or simply non-repeatable noise.
>
> >> O.K. so who cares, the requested pstate doesn't change?
> >> First, one wonders if the math could overflow.
> >> (although 7180ddd suggests maybe it won't)
> >> Second, the sample is largely dominated by obsolete information.
> >> Third, this can be problematic, and potentially wastes energy,
> >> for the busy to idle transition.
> >>
> >> Use case example 2:
> >> The busy to idle transition:
> >>
> >> Typically, the pstate request response to a busy to idle transition
> >> is very slow because the duration suddenly goes from, typically,
> >> 10 milliseconds to much much longer, up to 4 seconds. Transition
> >> times to the system being fully idle, with all requested pstates
> >> being at minimum, takes around 8 seconds with this reversion,
> >> and, potentially, a very very long time (over 100 seconds has been
> >> measured) without.
> >>
> >> Again, so who cares, if the processor is in a deep idle state anyway,
> >> not consuming much energy? O.K. but what if it is in an idle state
> >> where energy consumption is a function of the requested pstate?
> >> For example, for my processor (i7-2600K), idle state 1, then processor
> >> package energy can be over double what it should be for many 10s of
> >> seconds.
> >>
> >> Experiment method:
> >>
> >> enable only idle state 1
> >> Dountil stopped
> >>   apply a 100% load (all CPUs)
> >>   after awhile (about 50 seconds) remove the load.
> >>   allow a short transient delay (1 second).
> >>   measure the processor package joules used over the next 149 seconds.
> >> Enduntil
> >>
> >> Kernel k5.4-rc2 + reversion (this method)
> >> Average processor package power: 9.148 watts (128 samples, > 7 hours)
> >> Minimum: 9.02 watts
> >> Maximum: 9.29 watts
> >> Note: outlyer data point group removed, as it was assumed the computer
> >> had something to do and wasn't actually "idle".
> >>
> >> Kernel 5.4-rc2:
> >> Average processor package power: 9.969 watts (150 samples, > 8 hours)
> >> Or 9% more energy for the idle phases of the work load.
> >> Minimum: 9.15 watts
> >> Maximum: 13.79 watts (51% more power)
>
> Kernel 5.4-rc2 + Rik-patch:
> Average processor package power: 9.85 watts (53 samples, < 3 hours)
> Or 7.7% more energy for the idle phases of the work load.
> Minimum: 9.23 watts
> Maximum: 12.79 watts (40% more power)
>
>
>
