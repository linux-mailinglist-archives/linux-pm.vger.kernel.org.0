Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 393AFFCB7D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 18:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKNRHj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 12:07:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34584 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKNRHi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 12:07:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so7369393wrw.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1ttFX6mWZtj3YRIFFgJ6Wwp3zHGzs5AKoNMo4yJ71bI=;
        b=WHZK123eBZHkZP/Y8D8MlnOe/2Nmnk2EbmjV7pOYxzOF9bglYHQM0CpE466xwJDzf2
         QvmrWlPfr91t6/5XVDBgljgZAcUAfQ+8pdBV4Rx/QS5M149hHSGdvgIMEqVFhxPUaHqp
         yFyA+EQDWwXaszXyanRYc0Sw9uWoX6A+lKIK+C2fJvaArIv5PMiWTgRh9VFwzorrv3JR
         mAnoCLpiELtGgwpUzV1zRUREx++WEjZea5oXN8PnwnG1f3nCHbX/nloFHWfL2bS7upie
         RUZ153xCXEB8LgmG7Ie0RchcaEFi1ZIKZPN3zRnUyH5LISFUX98YBQ/VULbiqGcYaDIz
         NaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ttFX6mWZtj3YRIFFgJ6Wwp3zHGzs5AKoNMo4yJ71bI=;
        b=g49MSzJTUqdgnlNJz7Dn91Fz0wDJxlYuEkF4REWy/qec6Or8UqplCPuJW/qwjWS/fZ
         0rvoD6QNjTMtCrELQ2SWYYWqIvL0jULdZQGQp8lHUfRGzxsmr8ZPyNnYDqSK1RLBWtHc
         jVc8jj7jQKDAlCc6IcpSs4Z/lYoLTp5AtC8zVu4qWSC3TjJYYhKQuK/KLZfO7wh45ZiE
         261vD5DUzvYB9s2uWRWLpBl/fDh1jB+yjMAuTDeNhjrglx3Wm8hQUhbNSt1OCxG5tBaV
         Xo5Xe8TJOr+DRcBnoZ/yHRXEsdVGTEaRQz1JXOZqzojo2mWOlgNqe0kXspYAI9T+ER5n
         IAkA==
X-Gm-Message-State: APjAAAVxq/zxQ2mI3CReYg51aPUQQLLLVUuIWcvaRhqQ2uH2PdHH+O+P
        9xLk2v9E5RPz2dtiZSd3P8o8ig==
X-Google-Smtp-Source: APXvYqw/DbqT30oaTSSQCsMzIEM6CXlElniAe550T4zmltle7nwi+XIYxEvJuCHQhA1ntJ7bpz/9lA==
X-Received: by 2002:adf:82c6:: with SMTP id 64mr8827756wrc.151.1573751255472;
        Thu, 14 Nov 2019 09:07:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:b163:2e66:cb71:e145])
        by smtp.gmail.com with ESMTPSA id m3sm7552619wrw.20.2019.11.14.09.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Nov 2019 09:07:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4] sched/freq: move call to cpufreq_update_util
Date:   Thu, 14 Nov 2019 18:07:31 +0100
Message-Id: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
which might be inefficient when cpufreq driver has rate limitation.

When a task is attached on a CPU, we have call path:

update_load_avg()
  update_cfs_rq_load_avg()
    cfs_rq_util_change -- > trig frequency update
  attach_entity_load_avg()
    cfs_rq_util_change -- > trig frequency update

The 1st frequency update will not take into account the utilization of the
newly attached task and the 2nd one might be discard because of rate
limitation of the cpufreq driver.

update_cfs_rq_load_avg() is only called by update_blocked_averages()
and update_load_avg() so we can move the call to
cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
interesting to notice that update_load_avg() already calls directly
cfs_rq_util_change() for !SMP case.

This changes will also ensure that cpufreq_update_util() is called even
when there is no more CFS rq in the leaf_cfs_rq_list to update but only
irq, rt or dl pelt signals.

Reported-by: Doug Smythies <dsmythies@telus.net>
Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

this patch applies on tip/sched/urgent as there is a dependency with
commit b90f7c9d2198 ("sched/pelt: Fix update of blocked PELT ordering")

Changes for v4:
- updated comments
- added Reviewed-by and Acked-by 

 kernel/sched/fair.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5..3be44e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3504,9 +3504,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }
 
@@ -3616,8 +3613,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -7543,18 +7544,19 @@ static void update_blocked_averages(int cpu)
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
+	int decayed;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
 	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
+	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
+	 * DL and IRQ signals have been updated before updating CFS.
 	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	decayed |= update_irq_load_avg(rq, 0);
 
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7567,9 +7569,13 @@ static void update_blocked_averages(int cpu)
 	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
 		struct sched_entity *se;
 
-		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
+		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq, 0);
 
+			if (cfs_rq == &rq->cfs)
+				decayed = 1;
+		}
+
 		/* Propagate pending load changes to the parent, if any: */
 		se = cfs_rq->tg->se[cpu];
 		if (se && !skip_blocked_update(se))
@@ -7588,6 +7594,9 @@ static void update_blocked_averages(int cpu)
 	}
 
 	update_blocked_load_status(rq, !done);
+
+	if (decayed)
+		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7644,22 +7653,22 @@ static inline void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
+	int decayed;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	/*
-	 * update_cfs_rq_load_avg() can call cpufreq_update_util(). Make sure
-	 * that RT, DL and IRQ signals have been updated before updating CFS.
-	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
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

