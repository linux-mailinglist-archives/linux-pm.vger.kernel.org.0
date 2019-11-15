Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1346AFE0F2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 16:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfKOPNB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 10:13:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOPNA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 10:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OQdTLuR4MwzJvC3l2K9WiOBsfhChWetXzjSMuUMUuxA=; b=Lz5ZvFoc56/6mRaBw91xDfNB/
        CmlEBZP5nqpX6wKCTXRhgE5vSEBZCqqFIPZ4AwqnWXX57UpifP7lQy2xDjnpTpfAU0cowXh0bGagZ
        rEt9gGXBqdWShK9pmYTMdk1kxDjVrttwv0gBUGyIO0zfhKqBg7LXgKPRqYaj+pIftpcZtmdFIzHRV
        QMj+tmg8JgRh07j8ho30bQcth84zOvAGhWSDUmBZjq92EgcfWvxbSjPw0Dqgdw+iYD+5ulPSBD9c/
        gXOZRz1aqW+hSXOgbBH7B3agMwvkCi9L5LihNef3Z+vjsdpAs/wuNlCqoQFivk2E1hvjZNwTjaC91
        ZwxpaE/UQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVdGq-0000YK-3Q; Fri, 15 Nov 2019 15:12:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5CB9303DDD;
        Fri, 15 Nov 2019 16:11:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8E352B12EE0A; Fri, 15 Nov 2019 16:12:20 +0100 (CET)
Date:   Fri, 15 Nov 2019 16:12:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115151220.GO4131@hirez.programming.kicks-ass.net>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115132520.GJ4131@hirez.programming.kicks-ass.net>
 <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 02:37:27PM +0100, Vincent Guittot wrote:
> On Fri, 15 Nov 2019 at 14:25, Peter Zijlstra <peterz@infradead.org> wrote:

> > Should not all 3 have their windows aligned and thus alway return the
> > exact same value?
> 
> rt and dl yes but not irq
> 
> But having aligned window doesn't mean that they will all decay.
> One can have been updated just before (during a dequeue as an example)
> or at least less than 1ms before

Now, the thing is, if that update happened in sched/rt, then it wouldn't
have called cpufreq anyway. And once we're idle longer than a period,
they'll all decay at once.

Except indeed that IRQ stuff, which runs out of sync.

That is, I'm just not convinced it matters much if we keep rq->cfs
on the list forever (like UP). Because we'll only stop calling when
update_blocked_averages() when everything hit 0, and up until that
point, we'll get one update per period from rq->cfs.

For good measure we can force an update when @done, at that point we
know all 0s.

How is something like this?

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 545bcb90b4de..a99ac2aa4a23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }
 
@@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -7453,7 +7454,7 @@ static void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq, *pos;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
-	bool done = true;
+	bool done = true, decayed = false;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7476,10 +7477,14 @@ static void update_blocked_averages(int cpu)
 	 * list_add_leaf_cfs_rq() for details.
 	 */
 	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+		bool last = cfs_rq == &rq->cfs;
 		struct sched_entity *se;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq, 0);
+			if (last)
+				decayed = true;
+		}
 
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
@@ -7490,7 +7495,7 @@ static void update_blocked_averages(int cpu)
 		 * There can be a lot of idle CPU cgroups.  Don't let fully
 		 * decayed cfs_rqs linger on the list.
 		 */
-		if (cfs_rq_is_decayed(cfs_rq))
+		if (!last && cfs_rq_is_decayed(cfs_rq))
 			list_del_leaf_cfs_rq(cfs_rq);
 
 		/* Don't need periodic decay once load/util_avg are null */
@@ -7498,6 +7503,9 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 
+	if (decayed || done)
+		cpufreq_update_util(rq, 0);
+
 	update_blocked_load_status(rq, !done);
 	rq_unlock_irqrestore(rq, &rf);
 }
@@ -7555,6 +7563,7 @@ static inline void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
+	bool done, decayed;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7568,9 +7577,13 @@ static inline void update_blocked_averages(int cpu)
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 
-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	decayed = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	done = !(cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
 
-	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
+	if (decayed || done)
+		cpufreq_update_util(rq, 0);
+
+	update_blocked_load_status(rq, !done);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
