Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F120E8C57
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 17:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbfJ2QCQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 12:02:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35711 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390070AbfJ2QCQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 12:02:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id x5so3010232wmi.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wjq3qMo8FvirVrLZpXvZeqaZgtvs3ai3e6aI3M0oDmE=;
        b=xOivT3hhLEHME5RyF/hELFM/3OrICx3ncx4VgZKgqcBTQBy5UIlsW7gwjt7Sd/gazb
         ehTutRziipVSFrrsVWBj+4js6+S/H711nmJGDi11kh32EgvyPphfH8uf6ZrUl94QWaqj
         nw3kAWACD+WA2OehHlo0zQYHTikWMAFTEQDt5RffHgAagF2KKt18R+zDt4n9O192wpI0
         yM5SzpOe9GRN335PlMY2JXnMBYxvAOdFAJIGM1nZ7pvW85B7/VpRUMPW6MwewYUg8mHb
         lz3C/STmHaTmDT1XjDdco4vMQIQWsZYHsOdHEuQVqrtwrnPS+dNx5oAFO8qQIgJqbWET
         nopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wjq3qMo8FvirVrLZpXvZeqaZgtvs3ai3e6aI3M0oDmE=;
        b=kTALimQ/feVl+SDJ0Vq4SXVFONVqT5Gzv60FH0BnZr1pDc4cpZdR9Mv22jaAS0wSEm
         vm8XdbT6SmE1+YFsv9dh1ltcaxrOiE3/s3kmrB7JV3TvOc9yYgibgZgX4e4yGIlLHxgu
         jk/qvRr07hUZfdu7KsTy3NQ2fuBOUoeBMCt+f/DKzJiTq7IYTLrIC4FZyO3xb9fZht5h
         pvKzbNrd/yG1EHjmflcVI0Y9RMqegCCpddAdVZQ9KcC9J7GaGvcxpw5DQD9coIL9tQGT
         +KygBDVNgKSp9O3EKMrZ/sBGDkB/SVYzgQJMqdL2Q5SMV03cQ3uUAygAQKNs1VRV8rlY
         cmlQ==
X-Gm-Message-State: APjAAAXMgEqEh/0LehXOePMIu3gfNoEpXQn45oJIEgw1flO1kYm7qNgx
        Nf7Pcmku5Lsf+8DH3Cy0gE9jSg==
X-Google-Smtp-Source: APXvYqy1goi1LGSm/CocFeTvMezQJkdIX1dzc2tcscAAS5UvEdmaJ3PpBLCD25UJcds4KhlWA1cAGQ==
X-Received: by 2002:a7b:cd91:: with SMTP id y17mr5183496wmj.113.1572364932786;
        Tue, 29 Oct 2019 09:02:12 -0700 (PDT)
Received: from linaro.org ([2a01:e0a:f:6020:c11f:f443:8c4a:ee25])
        by smtp.gmail.com with ESMTPSA id e12sm16602872wrs.49.2019.10.29.09.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 09:02:11 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:02:10 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'linux-kernel' <linux-kernel@vger.kernel.org>,
        "'open list:THERMAL'" <linux-pm@vger.kernel.org>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Ingo Molnar' <mingo@kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Sargun Dhillon' <sargun@sargun.me>,
        'Tejun Heo' <tj@kernel.org>, 'Xie XiuQi' <xiexiuqi@huawei.com>,
        xiezhipeng1@huawei.com,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Rik van Riel' <riel@surriel.com>
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
Message-ID: <20191029160210.GA8343@linaro.org>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net>
 <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001201d58e68$eaa39630$bfeac290$@net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le Tuesday 29 Oct 2019 à 07:55:26 (-0700), Doug Smythies a écrit :
> On 2019.10.28 01:22 Vincent Guittot wrote:
> > On Sat, 26 Oct 2019 at 08:59, Doug Smythies <dsmythies@telus.net> wrote:
> >> On 2010.10.25 09:51 Vincent Guittot wrote:
> >>> On Fri, 25 Oct 2019 at 17:55, Doug Smythies <doug.smythies@gmail.com> wrote:
> >>>>
> >>>> This reverts commit 039ae8bcf7a5f4476f4487e6bf816885fb3fb617,
> >>>> which, in turn, was a re-apply of
> >>>> commit a9e7f6544b9c ("sched/fair: Fix O(nr_cgroups) in load balance path")
> >>>> after it was reverted via
> >>>> commit c40f7d74c741 ("sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c")
> >>>>
> >>>> For an idle system, the cfs_rq_is_decayed function components can underflow to 0 and
> >>>> incorrectly return TRUE, when the item should not be deleted from the list.
> >>>
> >>> The patch from Rik solves the problem of cfs_rq_is_decayed wrongly returns true
> >>> https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
> >>
> >> Not for my use case.
> >>
> >> I applied Rik's patch to kernel 5.4-rc2 (since all my other reference
> >> test data had been acquired against a base of 5.4-rc2). Tests results
> >> are similar to the non-reverted kernel (results added in-line
> >> below).
> >
> > Ok.
> >
> > I have studied a bit more your results below and IIUC your problem,
> > some periodic wakes up (every 4sec) are missing with kernel 5.4-rc2
> 
> Actually, I don't know that the periodic wake ups are missing, I only
> know that the intel_pstate CPU scaling driver is not being called.
> This has been since kernel 5.1-rc1.
> I bisected the kernel and found the patch that is this subject.
> Then I used kernel 5.4-rc2 as my baseline for the data submitted.
> 
> Looking at the number of clocks cycles that have being used since the last
> call to the driver suggests that the CPU has been doing something between
> the long time between calls:
> For the example given, there were 20,716,861 active clocks in 327.175
> seconds. At 4 seconds per doing something that's 253,286 clocks each,
> which is consistent (o.k. the variability is high) with actual data
> (and, for example, see the aperf number of 231,813 clocks for the
> 4 second example given below).
> 
> > that helps cpuidle to enters deeper idle state after each new wake up
> > until reaching the deepest state, isn't it ?
> 
> Well, it is the delay in the intel_pstate driver calls that is the
> root issue. Dragging idle into it was just the use case example that
> started this investigation.

Ok, I misuderstood your explanation.
Your point is that cfs_rq_util_change is not called anymore and as a result intel pstate driver.

Could you try the patch below ? It ensures that at least the root cfs rq stays
in the list so each time update_blocked_averages is called, we will call update_cfs_rq_load_avg()
for the root cfs_rq at least and even if everything already reach zero.
This will ensure that cfs_rq_util_change is called even if nothing has
changed.


---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 151c0b7..ac0a549 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7552,6 +7552,8 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
+	struct rq *rq = rq_of(cfs_rq);
+
 	if (cfs_rq->load.weight)
 		return false;
 
@@ -7564,6 +7566,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_load_sum)
 		return false;
 
+	if (cfs_rq == &rq->cfs)
+		return false;
+
 	return true;
 }
 
-- 
2.7.4



> 
> > My 1st point is that this code doesn't use timer or hrtimer to wake up
> > the system but only take advantage of the wake up of something else to
> > update the blocked load. So I don't see how this patch could remove
> > the 4sec periodic wakeup of the watchdog timer that you are
> > mentioning.
> 
> I don't know that it is, as mentioned above.
> 
> > Then, when a system is idle and not used, the load should obviously be
> > null most of the time and the update of decayed load should not happen
> > anyway. It looks like you take advantage of some spurious and
> > un-necessary wake up to help cpuidle to reach deeper idle state. Is
> > this understanding correct ?
> 
> I don't know.
> 
> I only know that the call to the intel_pstate driver doesn't
> happen, and that it is because cfs_rq_is_decayed returns TRUE.
> So, I am asserting that the request is not actually decayed, and
> should not have been deleted. Furthermore, I am wondering if other
> tasks that should be run are suffering the same fate.
> 
> Now, if we also look back at the comments for the original commit:
> 
> 	"In an edge case where temporary cgroups were leaking, this
> 	caused the kernel to consume good several tens of percents of
> 	CPU cycles running update_blocked_averages(), each run taking
> 	multiple millisecs."
> 
> To my way of thinking: Fix the leak, don't program around it; The
> commit breaks something else, so revert it.
> 
> >
> > Then, without or without removing the cfs_rq from the list, we should
> > end up with rq->has_blocked_load == 0 and nohz.has_blocked == 0 too.
> > The only main impact will be the duration of the loop that can be
> > significantly shorter when you have a lot of rqs and cgroups.
> 
> I'm not following.
> 
> >
> >>>>
> >>>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> >>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>>> Cc: Ingo Molnar <mingo@kernel.org>
> >>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: sargun@sargun.me
> >>>> Cc: tj@kernel.org
> >>>> Cc: xiexiuqi@huawei.com
> >>>> Cc: xiezhipeng1@huawei.com
> >>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> >>>>
> >>>> ---
> >>>> Note 1: Both this reversion and just deleting the cfs_rq_is_decayed function
> >>>> and it's call and leaving the other changes have been tested. I do not know
> >>>> which solution is better. (ie for the "list_for_each_entry_rcu" part of it.)
> >>>>
> >>>> Note 2: Previous controversy over this patch was based on heavy workloads,
> >>>> but this is based on minimal or no workload, or "idle".
> >>>> Where "idle" on my test server, with no gui and many services disabled,
> >>>> tends to mean more "idle" than most systems.
> >>>>
> >>>> Note 3: While this supporting data only involves the intel_pstate CPU
> >>>> frequency scaling driver as a casualty, it is beyond my capabilities
> >>>> to determine what other tasks that should be running might be omitted.
> >>>>
> >>>> Use case example 1:
> >>>> System Idle: The intel pstate CPU frequency scaling driver:
> >>>> Mode: Active, non-hwp, powersave governor.
> >>>> Expected behaviour: There is never ever a duration (time between calls to
> >>>> the driver / per CPU) longer than 4 seconds (the watchdog time, I think).
> >>>> Actual behaviour: There are long long gaps between calls to the driver:
> >>>>
> >>>> Kernel: 5.4-rc2 CPU:7
> >>>> duration: 327.17 Seconds. (this is one of many hundreds of examples.)
> >>>> mpref: 44023326
> >>>> apref: 20716861
> >>>> tsc: 1.11604E+12
> >>>> load: 0
> >>>> CPU frequency: 1.6053 GHz (average over this 327 second sample period).
> >>>> old pstate: 16 (the lowest for my processor)
> >>>> new pstate: 16
> >>>>
> >>>> Kernel: 5.4-rc2 + reversion (either method)
> >>>> After several hours of testing, maximum durations were never more
> >>>> than 4 seconds (well plus some jitter).
> >>>> reversion method: max=4.07908 seconds
> >>>> CPU:7
> >>>> mperf: 492578
> >>>> apref: 231813 (56,829 per second average is consistent with other tests)
> >>>> tsc: 13914264074
> >>>> load: 0
> >>>> CPU frequency: 1.6052 GHz
> >>>> old pstate: 16 (the lowest for my precessor)
> >>>> new pstate: 16
> >>>>
> >>>> On average, the non-reverted kernel executes the driver 25% less
> >>>> than the reverted kernel during idle.
> >>
> >> On (shorter)average, the Rik patched kernel executes the driver
> >> 14% less than the reverted kernel during idle.
> >>
> >> Longer and repeated testing would be required to determine if
> >> this is a trend or simply non-repeatable noise.
> 
> The difference in probabilities of the issue occurring does appear to be
> somewhat consistent. Not sure what it means, if anything.
> 
> >>>> O.K. so who cares, the requested pstate doesn't change?
> >>>> First, one wonders if the math could overflow.
> >>>> (although 7180ddd suggests maybe it won't)
> >>>> Second, the sample is largely dominated by obsolete information.
> >>>> Third, this can be problematic, and potentially wastes energy,
> >>>> for the busy to idle transition.
> >>>>
> >>>> Use case example 2:
> >>>> The busy to idle transition:
> >>>>
> >>>> Typically, the pstate request response to a busy to idle transition
> >>>> is very slow because the duration suddenly goes from, typically,
> >>>> 10 milliseconds to much much longer, up to 4 seconds. Transition
> >>>> times to the system being fully idle, with all requested pstates
> >>>> being at minimum, takes around 8 seconds with this reversion,
> >>>> and, potentially, a very very long time (over 100 seconds has been
> >>>> measured) without.
> >>>>
> >>>> Again, so who cares, if the processor is in a deep idle state anyway,
> >>>> not consuming much energy? O.K. but what if it is in an idle state
> >>>> where energy consumption is a function of the requested pstate?
> >>>> For example, for my processor (i7-2600K), idle state 1, then processor
> >>>> package energy can be over double what it should be for many 10s of
> >>>> seconds.
> >>>>
> >>>> Experiment method:
> >>>>
> >>>> enable only idle state 1
> >>>> Dountil stopped
> >>>>   apply a 100% load (all CPUs)
> >>>>   after awhile (about 50 seconds) remove the load.
> >>>>   allow a short transient delay (1 second).
> >>>>   measure the processor package joules used over the next 149 seconds.
> >>>> Enduntil
> >>>>
> >>>> Kernel k5.4-rc2 + reversion (this method)
> >>>> Average processor package power: 9.148 watts (128 samples, > 7 hours)
> >>>> Minimum: 9.02 watts
> >>>> Maximum: 9.29 watts
> >>>> Note: outlyer data point group removed, as it was assumed the computer
> >>>> had something to do and wasn't actually "idle".
> >>>>
> >>>> Kernel 5.4-rc2:
> >>>> Average processor package power: 9.969 watts (150 samples, > 8 hours)
> >>>> Or 9% more energy for the idle phases of the work load.
> >>>> Minimum: 9.15 watts
> >>>> Maximum: 13.79 watts (51% more power)
> >>
> >> Kernel 5.4-rc2 + Rik-patch:
> >> Average processor package power: 9.85 watts (53 samples, < 3 hours)
> >> Or 7.7% more energy for the idle phases of the work load.
> >> Minimum: 9.23 watts
> >> Maximum: 12.79 watts (40% more power)
> 
> 
