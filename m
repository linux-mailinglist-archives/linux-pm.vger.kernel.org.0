Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859BDF42F4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 10:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfKHJSk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 04:18:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbfKHJSk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 04:18:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id t1so6174250wrv.4
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2019 01:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hWc4CNXdaezoVevHvca5ylONXVnjuwVtoa5alIlTaOI=;
        b=CITHKKNnD1jyOabFg4uHN2NqdwJ9z7jttLoYa3k857zRiXz+ZYYL3I8UTCtGnOFBJ2
         R8tE44/BL3K9kB5mKZ+0pP6yOPrEbQ4WZILruWRqUjA8WBi5gZbR/am2GkMiBMEejxlI
         wmETL00/BWmCabbXpD8bZcJ1gHJ0GSpjMcw8ORo+lcldLpidjBTr/3XOigZ1cpr13+Ry
         bfRbPBBocASbTT5FQ4WEbEWKxQzIL0plWunV3aNNRNlP4qxIwtAUGTImHRvIQEN+d60Q
         PNQ7AHTmdXILhg6VKM9ptoKmLIZ8vI9WN/oYrYZadhtpf1J/d5I654ybYilAmWJGu3b+
         0XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hWc4CNXdaezoVevHvca5ylONXVnjuwVtoa5alIlTaOI=;
        b=shR/f0IiHCktzAt/4HLuHsUjq/NCsW5E65GowxfKqYEpHZ/U3ZH2FS9AZ/u4YNdEEc
         1grrJoqsbKU/m07kPGH8sqJfoAeCyii7iG4Wq45wDPPp+yy0YAHGIH9GgXPbJUmSKv9+
         DQDWdoYaet9N+FR8nUaMA6E/DrixnigwEwpsMk7v3yvc+dQHG8hSrYmzn1HdN2o6aJm/
         XU+6a0vAZyUIWb1IE3pRBb6e2BuNILL8/ffup62sca6a4/6f0dzPyPRvggshQqQOY8nf
         OX0EmkCythdN+AeVUsOfGQjkVxhSyizG+kxQkoJJkM7+EnX+nW5cxa7vg/hAX+bBuGBO
         xNmA==
X-Gm-Message-State: APjAAAU/WQOq9vBW8kd79G+PLqeiUKArwzt+NUhIhQDwVBu+M/C3wEGf
        OJSebqF8avksRfB1okDO25/DqQ==
X-Google-Smtp-Source: APXvYqwmw1eDv9QSLslHbEI7+TrX3IZgya8Ue0j07LVUMNimWrzETmFAIxC/PNLwXRofI6nyaCmymQ==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr6593925wrm.299.1573204717050;
        Fri, 08 Nov 2019 01:18:37 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:2c7f:4532:a254:2b46])
        by smtp.gmail.com with ESMTPSA id j67sm6108140wmb.43.2019.11.08.01.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:18:35 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:18:34 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH] Revert "sched/fair: Fix O(nr_cgroups) in the load
 balancing path"
Message-ID: <20191108091834.GA24402@linaro.org>
References: <1572018904-5234-1-git-send-email-dsmythies@telus.net>
 <CAKfTPtDFAS3TiNaaPoEXFZbqdMt_-tfGm9ffVcQAN=Mu_KbRdQ@mail.gmail.com>
 <000c01d58bca$f5709b30$e051d190$@net>
 <CAKfTPtDx6nu7YtYN=JLRAseZS3Q6Nt-QdMQuG_XoUtmtR_101A@mail.gmail.com>
 <001201d58e68$eaa39630$bfeac290$@net>
 <20191029160210.GA8343@linaro.org>
 <000001d58f2a$fc593200$f50b9600$@net>
 <CAKfTPtCjhYKttEuWs9cqicUdJMiJVy5he+=xWofof_4xAWgKAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCjhYKttEuWs9cqicUdJMiJVy5he+=xWofof_4xAWgKAw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Doug,

Le Wednesday 30 Oct 2019 à 16:27:08 (+0100), Vincent Guittot a écrit :
> On Wed, 30 Oct 2019 at 15:04, Doug Smythies <dsmythies@telus.net> wrote:
> >
> > On 2019.10.29 09:02 Vincent Guittot wrote:
> >
> > > Could you try the patch below ? It ensures that at least the root cfs rq stays
> > > in the list so each time update_blocked_averages is called, we will call update_cfs_rq_load_avg()
> > > for the root cfs_rq at least and even if everything already reach zero.
> > > This will ensure that cfs_rq_util_change is called even if nothing has
> > > changed.
> > >
> > > ---
> > >  kernel/sched/fair.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 151c0b7..ac0a549 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7552,6 +7552,8 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
> > >
> > >  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > >  {
> > > +     struct rq *rq = rq_of(cfs_rq);
> > > +
> > >       if (cfs_rq->load.weight)
> > >               return false;
> > >
> > > @@ -7564,6 +7566,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
> > >       if (cfs_rq->avg.runnable_load_sum)
> > >               return false;
> > >
> > > +     if (cfs_rq == &rq->cfs)
> > > +             return false;
> > > +
> > >       return true;
> > > }
> > >
> > > --
> > > 2.7.4
> >
> > Yes, this patch works and solves the long time
> > between calls of the intel_pstate CPU frequency scaling
> > driver issue.
> > I see you sent a formal patch a few hours ago.
> > I'll try it and report back.
> 
> The patch that I sent a few hours ago, doesn't solve your problem. It
> solves item 1 of my previous email.
> 
> The fact that this hack fix your problem means that Intel pstate needs
> to be called periodically even if the cfs pelt signals are null and
> this is probably linked to the internal state machine of the driver.
> The current behavior for CFS makes perfectly sense because cfs signal
> is already null so we don't need to update freq because of cfs' signal
> Then it remains the rt, dl and irq signals which might not be null yet
> and which doesn't trigger a call to cpufreq_update_util whereas it
> could worth calling it.
> 
> I have to prepare a patch for this part which is item 2

I have finally been able to prepared the patch for item 2. Could you check
that it also fixes your problem ?

Subject: [PATCH] sched/freq: move call to cpufreq_update_util

update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
which might be inefficient when cpufreq driver has rate limitation.

When a task is attached on a CPU, we have call path:

update_blocked_averages()
  update_cfs_rq_load_avg()
    cfs_rq_util_change -- > trig frequency update
  attach_entity_load_avg()
    cfs_rq_util_change -- > trig frequency update

The 1st frequency update will not take into account the utilization of the
newly attached task and the 2nd one might be discard because of rate
limitation of the cpufreq driver.

update_cfs_rq_load_avg() is only called by update_blocked_averages()
and update_load_avg() so we can move the call to
{cfs_rq,cpufreq}_util_change() into these 2 functions. It's also
interesting to notice that update_load_avg() already calls directly
cfs_rq_util_change() for !SMP case.

This changes will also ensure that cpufreq_update_util() is called even
when there is no more CFS rq in the leaf_cfs_rq_list to update but only
irq, rt or dl pelt signals.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

We can still have some spurious call to cpufreq_util_change in 
update_blocked_average() with this patch but at least the value will be
up to date in both calls, which was not the case before. If this fix
Doug's problem, I can prepare an additional one to fix the spurious call
but I wanted to make sure that this fix the problem first.


 kernel/sched/fair.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index adc923f..4fd324e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3509,9 +3509,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }
 
@@ -3621,8 +3618,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
 		update_tg_load_avg(cfs_rq, 0);
 
-	} else if (decayed && (flags & UPDATE_TG))
-		update_tg_load_avg(cfs_rq, 0);
+	} else if (decayed) {
+		cfs_rq_util_change(cfs_rq, 0);
+
+		if (flags & UPDATE_TG)
+			update_tg_load_avg(cfs_rq, 0);
+	}
 }
 
 #ifndef CONFIG_64BIT
@@ -7441,6 +7442,7 @@ static void update_blocked_averages(int cpu)
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
+	int decayed = 0;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7450,9 +7452,9 @@ static void update_blocked_averages(int cpu)
 	 * that RT, DL and IRQ signals have been updated before updating CFS.
 	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	decayed |= update_irq_load_avg(rq, 0);
 
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7486,6 +7488,9 @@ static void update_blocked_averages(int cpu)
 	}
 
 	update_blocked_load_status(rq, !done);
+
+	if (decayed)
+		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7542,6 +7547,7 @@ static inline void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
+	int decayed = 0;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7551,13 +7557,16 @@ static inline void update_blocked_averages(int cpu)
 	 * that RT, DL and IRQ signals have been updated before updating CFS.
 	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	decayed |= update_irq_load_avg(rq, 0);
 
-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
 
 	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
+
+	if (decayed)
+		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-- 
2.7.4


> 
> Regards,
> Vincent
> 
> 
> >
> > ... Doug
> >
> >
