Return-Path: <linux-pm+bounces-822-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618418098CE
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 02:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D391F21351
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 01:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066021849;
	Fri,  8 Dec 2023 01:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="uG2SzpEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED771171E
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 17:52:57 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso16634335e9.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 17:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702000376; x=1702605176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+u72VL4qIOeq+J2csfvDxNp1PRAIPkthflP9kFSqak=;
        b=uG2SzpEF7sXScVPAx4NaSLF9+iYt/NDfaBx0ZDwmfJ9fBOFgSdvQLYvv/bff7eQbMs
         ty+ZDxcyFQWUCwi3rOEtGaQreTWieecb2UF5e4AQd0eN+IWXEwWNROtZQlrSp5rH3KAx
         XIVgctniTlfJU2p6WJlOFonJITB/PcaDws+HPQpJPvJI6xjgh5vPWeClgQqzlVanuwW5
         82Ct1LeAoyGF5WUFWXF5uInSrm6hNOqsFn8oJUZO9xvTJrlzgbHbGBEERMIAnHiGtEUF
         hXRnDjeScVdvLcbwfZ5i3Z1/7seWcGBvjZXednIIXd1xSE8UfmSPJ0U9VYlRICy89E+N
         LyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702000376; x=1702605176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+u72VL4qIOeq+J2csfvDxNp1PRAIPkthflP9kFSqak=;
        b=mCtN/ecLklxTzqQbKHn6vzG0QoMRJ+sQSy3EIC8uP3mjgCRcUd7M9ce0ufl5ClSSNl
         M91c0hiVdor7VikrDZRGUuE2sieJnxtaZHa5rK+ldvrXCyfkhUj2L2cfOYOUPRZgh8nY
         HezyXYUfCb0DtLPIlnyOo94XJfr1FtOh94C5Pn9QURfwM30PSWRVOc51ZrJdCIFDBTgt
         rgjgcuax7wX+LfywZrln/QX/At5oIvPXW0WFU7CFd5jRitIPhzqPsEWUdRNjbstYwpvT
         PhVxZHrivVHnRhG/56bLifahHWOZ/dFbhcmyGb5tgVLt4gKNZKcUr9rBVx7w0BERI2uI
         cyjw==
X-Gm-Message-State: AOJu0Yy4lU/IV80Kqdjjhe07hMD1zhfBfBK17kAuh54VFe2WfpjZMe9s
	/MRBw/OSX60QmK8kjCKTs+1/Lw==
X-Google-Smtp-Source: AGHT+IF8WsWFoTjiDKV5h3luTOtxLISQDCjwxSEj9rcDbZNRT8PPzOtqlLl5GkjGbkuH2w841PI+CA==
X-Received: by 2002:a05:600c:4c94:b0:40b:5e21:cc33 with SMTP id g20-20020a05600c4c9400b0040b5e21cc33mr1786201wmp.94.1702000376453;
        Thu, 07 Dec 2023 17:52:56 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id s12-20020adf978c000000b003333a0da243sm902521wrb.81.2023.12.07.17.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:52:56 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 1/4] sched/fair: Be less aggressive in calling cpufreq_update_util()
Date: Fri,  8 Dec 2023 01:52:39 +0000
Message-Id: <20231208015242.385103-2-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208015242.385103-1-qyousef@layalina.io>
References: <20231208015242.385103-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the way code is structured, it makes a lot of sense to trigger
cpufreq_update_util() from update_load_avg(). But this is too aggressive
as in most cases we are iterating through entities in a loop to
update_load_avg() in the hierarchy. So we end up sending too many
request in an loop as we're updating the hierarchy.

Combine this with the rate limit in schedutil, we could end up
prematurely send up a wrong frequency update before we have actually
updated all entities appropriately.

Be smarter about it by limiting the trigger to perform frequency updates
after all accounting logic has done. This ended up being in the
following points:

1. enqueue/dequeue_task_fair()
2. throttle/unthrottle_cfs_rq()
3. attach/detach_task_cfs_rq()
4. task_tick_fair()
5. __sched_group_set_shares()

This is not 100% ideal still due to other limitations that might be
a bit harder to handle. Namely we can end up with premature update
request in the following situations:

a. Simultaneous task enqueue on the CPU where 2nd task is bigger and
   requires higher freq. The trigger to cpufreq_update_util() by the
   first task will lead to dropping the 2nd request until tick. Or
   another CPU in the same policy trigger a freq update.

b. CPUs sharing a policy can end up with the same race in a but the
   simultaneous enqueue happens on different CPUs in the same policy.

The above though are limitations in the governor/hardware, and from
scheduler point of view at least that's the best we can do. The
governor might consider smarter logic to aggregate near simultaneous
request and honour the higher one.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 55 ++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b83448be3f79..f99910fc6705 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3997,29 +3997,6 @@ static inline void update_cfs_group(struct sched_entity *se)
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
-{
-	struct rq *rq = rq_of(cfs_rq);
-
-	if (&rq->cfs == cfs_rq) {
-		/*
-		 * There are a few boundary cases this might miss but it should
-		 * get called often enough that that should (hopefully) not be
-		 * a real problem.
-		 *
-		 * It will not get called when we go idle, because the idle
-		 * thread is a different class (!fair), nor will the utilization
-		 * number include things like RT tasks.
-		 *
-		 * As is, the util number is not freq-invariant (we'd have to
-		 * implement arch_scale_freq_capacity() for that).
-		 *
-		 * See cpu_util_cfs().
-		 */
-		cpufreq_update_util(rq, flags);
-	}
-}
-
 #ifdef CONFIG_SMP
 static inline bool load_avg_is_decayed(struct sched_avg *sa)
 {
@@ -4648,8 +4625,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
-
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
@@ -4678,8 +4653,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
-
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
@@ -4726,11 +4699,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 */
 		detach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
-	} else if (decayed) {
-		cfs_rq_util_change(cfs_rq, 0);
-
-		if (flags & UPDATE_TG)
-			update_tg_load_avg(cfs_rq);
+	} else if (decayed && (flags & UPDATE_TG)) {
+		update_tg_load_avg(cfs_rq);
 	}
 }
 
@@ -5114,7 +5084,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
-	cfs_rq_util_change(cfs_rq, 0);
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
@@ -5807,6 +5776,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	sub_nr_running(rq, task_delta);
 
 done:
+	cpufreq_update_util(rq, 0);
+
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5899,6 +5870,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
+	cpufreq_update_util(rq, 0);
+
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
 		resched_curr(rq);
@@ -6704,14 +6677,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	/*
-	 * If in_iowait is set, the code below may not trigger any cpufreq
-	 * utilization updates, so do it here explicitly with the IOWAIT flag
-	 * passed.
-	 */
-	if (p->in_iowait)
-		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
-
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			break;
@@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
+	cpufreq_update_util(rq, p->in_iowait ? SCHED_CPUFREQ_IOWAIT : 0);
+
 	hrtick_update(rq);
 }
 
@@ -6849,6 +6816,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+	cpufreq_update_util(rq, 0);
 	hrtick_update(rq);
 }
 
@@ -8482,6 +8450,7 @@ done: __maybe_unused;
 
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
+	cpufreq_update_util(rq, 0);
 
 	return p;
 
@@ -12615,6 +12584,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+	cpufreq_update_util(rq, 0);
 
 	task_tick_core(rq, curr);
 }
@@ -12739,6 +12709,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
 	struct sched_entity *se = &p->se;
 
 	detach_entity_cfs_rq(se);
+	cpufreq_update_util(task_rq(p), 0);
 }
 
 static void attach_task_cfs_rq(struct task_struct *p)
@@ -12746,6 +12717,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 	struct sched_entity *se = &p->se;
 
 	attach_entity_cfs_rq(se);
+	cpufreq_update_util(task_rq(p), 0);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
@@ -12991,6 +12963,7 @@ static int __sched_group_set_shares(struct task_group *tg, unsigned long shares)
 			update_load_avg(cfs_rq_of(se), se, UPDATE_TG);
 			update_cfs_group(se);
 		}
+		cpufreq_update_util(rq, 0);
 		rq_unlock_irqrestore(rq, &rf);
 	}
 
-- 
2.34.1


