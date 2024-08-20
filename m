Return-Path: <linux-pm+bounces-12576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B2958C5A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357911F2643D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565A1C378B;
	Tue, 20 Aug 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="RTMnOQ6Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB91BD507
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171812; cv=none; b=io8r6qX0KnyQjU9O+HT5aggswtTUuVD3SJ3DNgX+CByd+z1qAI3XQBx6vd9Ek7bA/mUNL0SxG4JngeYQ3uBpDPEWSqdW5U6R9qwxeqtOSbxS+4cfh3cySHMqzBa5is8aQ1pvjmaFU2+644AwnTJJk+rJor872Wcv/KVwv3AlUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171812; c=relaxed/simple;
	bh=OqsaIQh4uctp/oFXsRzpZsyZxGxfrG6iSiwYiGo8PH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fx5gjF024Uv1nbC2QlVmLBveZXDPqlOGv7RWg3gmo+w+G867QL8bWYotNP9HDG1bWLzwfsG+vi53VT4Zj87nVy5hIAsPw51QTGrwlHSWoSLGWSwTI/xKxjtbkUgMokkAD56V/O6aHHHpw7O8yJG+QgTfoKmnA2ccrduwfG/dAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=RTMnOQ6Y; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so729862966b.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171809; x=1724776609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njOkbGyQ961EBslTvE6EDoi/18VK+01g5BSPEHY0GfY=;
        b=RTMnOQ6YK46DwBqw1h2uMXzX+6ia50MIzmrFzdRyi606L4gpe9mgVOQLjyiHT0/inH
         qQy/5Ws94ElnG0lNwn3558zunrUbtYXHvreSFkFHs58r9TmMlqvmJib1bSe1TbExfO+g
         ZQnypvquHj8Yk5Jzuvr3A5FM8ynUFKwQjOzQmyk7Rdgg5UBUILfsCKCNBdN3DCoH6ndF
         D87/NM4OjWar68x+o8aX5UnG/wHwTMmtviaVvc7Btr0Wl/zNsghZoWY0EaZZiUD+bRfl
         AW9MtTMT1ZM4vXJwMSsBI0Eu+rXIXkS62s9DLOEJ/43Gd2E5XFVkNIGxWYwtTC4JbwiP
         Cxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171809; x=1724776609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njOkbGyQ961EBslTvE6EDoi/18VK+01g5BSPEHY0GfY=;
        b=jAzOzDMY+rrm4mAQM+yyF8ro/T9M2SxnemTqn1ArsDY3DiKbie1tgEs1fBNfzdc2Tc
         BOTgp2fvZ6B9TQ6wiPlqNrQdqPdJ3crq1Dh4rG6tTrHvJNWmUegTbURw4/guxeV+CO5f
         wsb6/xb2HyXH1k2ciRHWQeoJK2ZB/vl/Pv4iRgs3Sn7rnJAwx8K+3TK4Jr6HvMnN205I
         v3xP2dh+K3Cu6474I9QLL3FfyAM3E5bTtPy7N7dA90o6FoY53/3NlXyRiy7rRAE2HGzY
         cKYDUK6cv00Ym6PVfHX3KEhbCVmdRLXb3OM8qKrRO7EmpqcBNxEk/K3Aj2cxQ7xyxEb7
         mfbw==
X-Forwarded-Encrypted: i=1; AJvYcCWGrNLZ6u7RzJdlEqzU6LrwfPoruEDG1JWwUYgvshPE5BHdUsySJ6NQ0ousUWGE/kwvWnK6uYCJNAlL9gEvrQUD2nnQJZR271Q=
X-Gm-Message-State: AOJu0YxQs9VgkAT5SVItPSq2NB3VmqAJhIHFUoJWef/sp9SifYgxg0SR
	1XF/j9mW4v6SAn1Sl1LhSJEFbegCWoWkETUMIZQfkcQ8AxKkCPJPty8Jn8qhrGY=
X-Google-Smtp-Source: AGHT+IGAOpAp1NhyW1kkfvm5+3bpeVK+LP152tiTM71qKtdLXPrb3x+lQlXhi6Bkd3u5CZOa4S8bpQ==
X-Received: by 2002:a17:906:f591:b0:a7a:c106:3659 with SMTP id a640c23a62f3a-a8647b6c7a6mr242678966b.60.1724171808835;
        Tue, 20 Aug 2024 09:36:48 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:48 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 12/16] sched/pelt: Add new waiting_avg to record when runnable && !running
Date: Tue, 20 Aug 2024 17:35:08 +0100
Message-Id: <20240820163512.1096301-13-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This info will be useful to understand how long tasks end up waiting
behind other tasks. This info is recorded for tasks only, and
added/subtracted from root cfs_rq on __update_load_avg_se().

It also helps to decouple util_avg which indicates tasks computational
demand from the fact that the CPU might need to run faster to reduce the
waiting time. It has been a point of confusion in the past while
discussing uclamp and util_avg and the fact that not keeping freq high
means tasks will take longer to run and cause delays. Isolating the
source of delay into its own signal would be a better way to take this
source of delay into account when making decisions independently of
task's/CPU's computational demands.

It is not used now. But will be used later to help drive DVFS headroom.
It could become a helpful metric to help us manage waiting latencies in
general, for example in load balance.

TODO: waiting_avg should use rq_clock_task() as it doesn't care about
invariance. Waiting time should reflect actual wait in realtime as this
is the measure of latency that users care about.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  2 ++
 kernel/sched/debug.c  |  5 +++++
 kernel/sched/fair.c   | 32 +++++++++++++++++++++++++++++-
 kernel/sched/pelt.c   | 45 ++++++++++++++++++++++++++++++-------------
 4 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a30ee43a25fb..f332ce5e226f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -477,10 +477,12 @@ struct sched_avg {
 	u64				last_update_time;
 	u64				load_sum;
 	u64				runnable_sum;
+	u64				waiting_sum;
 	u32				util_sum;
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			runnable_avg;
+	unsigned long			waiting_avg;
 	unsigned long			util_avg;
 	unsigned int			util_est;
 } ____cacheline_aligned;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1afd13..5fa2662a4a50 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -528,6 +528,7 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	P(se->avg.load_avg);
 	P(se->avg.util_avg);
 	P(se->avg.runnable_avg);
+	P(se->avg.waiting_avg);
 #endif
 
 #undef PN_SCHEDSTAT
@@ -683,6 +684,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
 			cfs_rq->avg.runnable_avg);
+	SEQ_printf(m, "  .%-30s: %lu\n", "waiting_avg",
+			cfs_rq->avg.waiting_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
@@ -1071,9 +1074,11 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #ifdef CONFIG_SMP
 	P(se.avg.load_sum);
 	P(se.avg.runnable_sum);
+	P(se.avg.waiting_sum);
 	P(se.avg.util_sum);
 	P(se.avg.load_avg);
 	P(se.avg.runnable_avg);
+	P(se.avg.waiting_avg);
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d9794db58e1..a8dbba0b755e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4726,6 +4726,22 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
+static inline void add_waiting_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long waiting_avg;
+	waiting_avg = READ_ONCE(cfs_rq->avg.waiting_avg);
+	waiting_avg += READ_ONCE(se->avg.waiting_avg);
+	WRITE_ONCE(cfs_rq->avg.waiting_avg, waiting_avg);
+}
+
+static inline void sub_waiting_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long waiting_avg;
+	waiting_avg = READ_ONCE(cfs_rq->avg.waiting_avg);
+	waiting_avg -= min(waiting_avg, READ_ONCE(se->avg.waiting_avg));
+	WRITE_ONCE(cfs_rq->avg.waiting_avg, waiting_avg);
+}
+
 /*
  * Optional action to be done while updating the load average
  */
@@ -4744,8 +4760,15 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * Track task load average for carrying it to new CPU after migrated, and
 	 * track group sched_entity load average for task_h_load calculation in migration
 	 */
-	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
+	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD)) {
+		bool update_rq_waiting_avg = entity_is_task(se) && se_runnable(se);
+
+		if (update_rq_waiting_avg)
+			sub_waiting_avg(&rq_of(cfs_rq)->cfs, se);
 		__update_load_avg_se(now, cfs_rq, se);
+		if (update_rq_waiting_avg)
+			add_waiting_avg(&rq_of(cfs_rq)->cfs, se);
+	}
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
 	decayed |= propagate_entity_load_avg(se);
@@ -5182,6 +5205,11 @@ attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
+static inline void
+add_waiting_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
+static inline void
+sub_waiting_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
+
 static inline int sched_balance_newidle(struct rq *rq, struct rq_flags *rf)
 {
 	return 0;
@@ -6786,6 +6814,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * estimated utilization, before we update schedutil.
 	 */
 	util_est_enqueue(&rq->cfs, p);
+	add_waiting_avg(&rq->cfs, se);
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -6874,6 +6903,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	bool was_sched_idle = sched_idle_rq(rq);
 
 	util_est_dequeue(&rq->cfs, p);
+	sub_waiting_avg(&rq->cfs, se);
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 536575757420..f0974abf8566 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -103,7 +103,8 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  */
 static __always_inline u32
 accumulate_sum(u64 delta, struct sched_avg *sa,
-	       unsigned long load, unsigned long runnable, int running)
+	       unsigned long load, unsigned long runnable, int running,
+	       bool is_task)
 {
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
 	u64 periods;
@@ -118,6 +119,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 		sa->load_sum = decay_load(sa->load_sum, periods);
 		sa->runnable_sum =
 			decay_load(sa->runnable_sum, periods);
+		sa->waiting_sum = decay_load((u64)(sa->waiting_sum), periods);
 		sa->util_sum = decay_load((u64)(sa->util_sum), periods);
 
 		/*
@@ -147,6 +149,8 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 		sa->runnable_sum += runnable * contrib << SCHED_CAPACITY_SHIFT;
 	if (running)
 		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
+	if (is_task && runnable && !running)
+		sa->waiting_sum += contrib << SCHED_CAPACITY_SHIFT;
 
 	return periods;
 }
@@ -181,7 +185,8 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
  */
 static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
-		  unsigned long load, unsigned long runnable, int running)
+		  unsigned long load, unsigned long runnable, int running,
+		  bool is_task)
 {
 	int time_shift;
 	u64 delta;
@@ -232,7 +237,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, runnable, running))
+	if (!accumulate_sum(delta, sa, load, runnable, running, is_task))
 		return 0;
 
 	return 1;
@@ -272,6 +277,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
 	sa->runnable_avg = div_u64(sa->runnable_sum, divider);
+	sa->waiting_avg = div_u64(sa->waiting_sum, divider);
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
@@ -303,7 +309,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 
 int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
-	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
+	if (___update_load_sum(now, &se->avg, 0, 0, 0, false)) {
 		___update_load_avg(&se->avg, se_weight(se));
 		trace_pelt_se_tp(se);
 		return 1;
@@ -314,10 +320,17 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	bool is_task = entity_is_task(se);
+
+	if (is_task)
+		rq_of(cfs_rq)->cfs.avg.waiting_avg -= se->avg.waiting_avg;
+
 	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
-				cfs_rq->curr == se)) {
+				cfs_rq->curr == se, is_task)) {
 
 		___update_load_avg(&se->avg, se_weight(se));
+		if (is_task)
+			rq_of(cfs_rq)->cfs.avg.waiting_avg += se->avg.waiting_avg;
 		cfs_se_util_change(&se->avg);
 		trace_pelt_se_tp(se);
 		return 1;
@@ -331,7 +344,8 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
 				cfs_rq->h_nr_running,
-				cfs_rq->curr != NULL)) {
+				cfs_rq->curr != NULL,
+				false)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
 		trace_pelt_cfs_tp(cfs_rq);
@@ -357,7 +371,8 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 	if (___update_load_sum(now, &rq->avg_rt,
 				running,
 				running,
-				running)) {
+				running,
+				false)) {
 
 		___update_load_avg(&rq->avg_rt, 1);
 		trace_pelt_rt_tp(rq);
@@ -383,7 +398,8 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	if (___update_load_sum(now, &rq->avg_dl,
 				running,
 				running,
-				running)) {
+				running,
+				false)) {
 
 		___update_load_avg(&rq->avg_dl, 1);
 		trace_pelt_dl_tp(rq);
@@ -414,7 +430,8 @@ int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
 	if (___update_load_sum(now, &rq->avg_hw,
 			       capacity,
 			       capacity,
-			       capacity)) {
+			       capacity,
+			       false)) {
 		___update_load_avg(&rq->avg_hw, 1);
 		trace_pelt_hw_tp(rq);
 		return 1;
@@ -462,11 +479,13 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	ret = ___update_load_sum(rq->clock - running, &rq->avg_irq,
 				0,
 				0,
-				0);
+				0,
+				false);
 	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
 				1,
 				1,
-				1);
+				1,
+				false);
 
 	if (ret) {
 		___update_load_avg(&rq->avg_irq, 1);
@@ -536,7 +555,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 	if (unlikely(!delta))
 		return util;
 
-	accumulate_sum(delta << sched_pelt_lshift, &sa, 1, 0, 1);
+	accumulate_sum(delta << sched_pelt_lshift, &sa, 1, 0, 1, false);
 	___update_load_avg(&sa, 0);
 
 	return sa.util_avg;
@@ -555,7 +574,7 @@ u64 approximate_runtime(unsigned long util)
 		return runtime;
 
 	while (sa.util_avg < util) {
-		accumulate_sum(delta, &sa, 1, 0, 1);
+		accumulate_sum(delta, &sa, 1, 0, 1, false);
 		___update_load_avg(&sa, 0);
 		runtime++;
 	}
-- 
2.34.1


