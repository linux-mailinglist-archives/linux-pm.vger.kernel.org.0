Return-Path: <linux-pm+bounces-12575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21641958C57
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BB51F2628D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A61BF31F;
	Tue, 20 Aug 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="fjzVqkVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DE1B3F33
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171811; cv=none; b=CtKz4ThvyGM/QTnqU9qqw1Hos1Ef+othJXZuZm+pITF+GZohVU/2l8rW8x38NlYdu2+ePp1qA2sCchNJzC9eGSvS/C0svKdgJUglx3fpCKqxoVjukK2jZUJPaCaQtMj92qkZ9Gy8tyoF+839i0zvYlquAroJaQ9tHSzMr76tokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171811; c=relaxed/simple;
	bh=6C3oq3HrJLkJWrLpo+1dSeHCEUbPFUKzQa1BwujeAi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pj33fFRxwuR/zm+Ev2i+rJE/Hxpl2Ljq2rLc0iiKAYiTyE2GLHU1p5aF6nbaNdit6S2KTOEk9UVfZMtJ5YLglPHDewplME7+mFXKLg7MgY8x38R+60bVkG/59E3h8vjNxHhmtTTEExABT5SCE3RAwFbUFXkIOKPXluonSL1ha3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=fjzVqkVB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8657900fc1so80328866b.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171808; x=1724776608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/d/uli9PIV9KsPRWvcOGLBXbZ0uKNuetYque1eIsGo=;
        b=fjzVqkVBxMlFXs/sf5pfn83HKxZQ5kmtbDyuCPqCWoT989vqp5FYBgRHckO175VAK6
         afp5xA1Kt3xPIl/EhBbsiMUTi+KZe3lMFTUMw+wF/gfH0N2Zh3ZBp76G84juM/GieE1P
         ATcMhYlRgSR49mkGkASHqiIi+kzig0aJhlL0J45kH3IWYiQvLA/z6824GVWUeBy/jwTF
         OO8c65IReOgiNzWEsfrQUUHkZpYEopWYA3pATdKuwtFZSAj/Hv1olpkpvTw5AUJgVZID
         hDC8O3YuV0TvVW+0Y/aHZC5FzOTc4xELh9NvIMwBPR0MtX1auZ+ymrHXTFERLFwTi9sp
         YFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171808; x=1724776608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/d/uli9PIV9KsPRWvcOGLBXbZ0uKNuetYque1eIsGo=;
        b=DgDsVecCpM66CSqmJRVnFEnH5r7NZFH1AT3h8NVX7yysoUBGcjS0BpFywTWLjhwY3x
         inA3giMJrH14a1+Z1cp9RMRyAkWO6qxOuzxxFYgyYGQc5xpFMFLctRtisVW1z8vlplM3
         EQOr+96q5xblDgWj1y4T6uvrf1cA3BV4IOmX+yLRMgSIL3x8A8nuR1E1q7BH2pg9EQp5
         jZNLqnzwZQvishRPV42vfVJjy9hjnStU7l52nO4A7VmM8WMfR+erAu2lFmbo07ls8Fgg
         fL/4Zk5m1UMS3fUI2Smcl682caWxhtu+bkzocmAHZshan97IgUvPC8rtLNSMsYXLEOlE
         vuUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2gD7+ik22bdn9lcQAnLccuRXSiVn+WDb157Vq5Nb5AoJm+0AWLPEhhTRAeFBkbqOKLiYlAFLzqbMZHMBjNTIRr20adcIGEbU=
X-Gm-Message-State: AOJu0YwHnthTg5oWxSn9VBiPWz6EXRgaR2eP31kstRw4kgyywnvqfKkL
	Sy19rEE3hFzJSSn8GkRZtUqRWmlvRDmc+H7PaDojTIXUcfm1kY6wNFtHgogwpq4=
X-Google-Smtp-Source: AGHT+IEZPw2L8xpcAT+hcydRU41CPHFT8ONkE8EI/GuWh2TzpVwCtCSqfce21OS/S3Nt2vjzA7lj8A==
X-Received: by 2002:a17:907:f193:b0:a80:f893:51bb with SMTP id a640c23a62f3a-a8392a4c515mr1029504866b.68.1724171807827;
        Tue, 20 Aug 2024 09:36:47 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:47 -0700 (PDT)
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
Subject: [RFC PATCH 11/16] sched/qos: Add rampup multiplier QoS
Date: Tue, 20 Aug 2024 17:35:07 +0100
Message-Id: <20240820163512.1096301-12-qyousef@layalina.io>
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

Bursty tasks are hard to predict. To use resources efficiently, the
system would like to be exact as much as possible. But this poses
a challenge for these bursty tasks that need to get access to more
resources quickly.

The new SCHED_QOS_RAMPUP_MULTIPLIER allows userspace to do that. As the
name implies, it only helps them to transition to a higher performance
state when they get _busier_. That is perfectly periodic tasks by
definition are not going through a transition and will run at a constant
performance level. It is the tasks that need to transition from one
periodic state to another periodic state that is at a higher level that
this rampup_multiplier will help with. It also slows down the ewma decay
of util_est which should help those bursty tasks to keep their faster
rampup.

This should work complimentary with uclamp. uclamp tells the system
about min and max perf requirements which can be applied immediately.

rampup_multiplier is about reactiveness of the task to change.
Specifically to a change for a higher performance level. The task might
necessary need to have a min perf requirements, but it can have sudden
burst of changes that require higher perf level and it needs the system
to provide this faster.

TODO: update the sched_qos docs

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h      |  7 ++++
 include/uapi/linux/sched.h |  2 ++
 kernel/sched/core.c        | 66 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c        |  6 ++--
 kernel/sched/syscalls.c    | 38 ++++++++++++++++++++--
 5 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2e8c5a9ffa76..a30ee43a25fb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -404,6 +404,11 @@ struct sched_info {
 #endif /* CONFIG_SCHED_INFO */
 };
 
+struct sched_qos {
+	DECLARE_BITMAP(user_defined, SCHED_QOS_MAX);
+	unsigned int rampup_multiplier;
+};
+
 /*
  * Integer metrics need fixed point arithmetic, e.g., sched/fair
  * has a few: load, load_avg, util_avg, freq, and capacity.
@@ -882,6 +887,8 @@ struct task_struct {
 
 	struct sched_info		sched_info;
 
+	struct sched_qos		sched_qos;
+
 	struct list_head		tasks;
 #ifdef CONFIG_SMP
 	struct plist_node		pushable_tasks;
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 67ef99f64ddc..0baba91ba5b8 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -104,6 +104,8 @@ struct clone_args {
 };
 
 enum sched_qos_type {
+	SCHED_QOS_RAMPUP_MULTIPLIER,
+	SCHED_QOS_MAX,
 };
 #endif
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c91e6a62c7ab..54faa845cb29 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -152,6 +152,8 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  */
 const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
+unsigned int sysctl_sched_qos_default_rampup_multiplier	= 1;
+
 __read_mostly int scheduler_running;
 
 #ifdef CONFIG_SCHED_CORE
@@ -4488,6 +4490,47 @@ static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_SYSCTL
+static void sched_qos_sync_sysctl(void)
+{
+	struct task_struct *g, *p;
+
+	guard(rcu)();
+	for_each_process_thread(g, p) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		if (!test_bit(SCHED_QOS_RAMPUP_MULTIPLIER, p->sched_qos.user_defined))
+			p->sched_qos.rampup_multiplier = sysctl_sched_qos_default_rampup_multiplier;
+		task_rq_unlock(rq, p, &rf);
+	}
+}
+
+static int sysctl_sched_qos_handler(struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned int old_rampup_mult;
+	int result;
+
+	old_rampup_mult = sysctl_sched_qos_default_rampup_multiplier;
+
+	result = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (result)
+		goto undo;
+	if (!write)
+		return 0;
+
+	if (old_rampup_mult != sysctl_sched_qos_default_rampup_multiplier) {
+		sched_qos_sync_sysctl();
+	}
+
+	return 0;
+
+undo:
+	sysctl_sched_qos_default_rampup_multiplier = old_rampup_mult;
+	return result;
+}
+
 static struct ctl_table sched_core_sysctls[] = {
 #ifdef CONFIG_SCHEDSTATS
 	{
@@ -4534,6 +4577,13 @@ static struct ctl_table sched_core_sysctls[] = {
 		.extra2		= SYSCTL_FOUR,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+	{
+		.procname	= "sched_qos_default_rampup_multiplier",
+		.data           = &sysctl_sched_qos_default_rampup_multiplier,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_sched_qos_handler,
+	},
 };
 static int __init sched_core_sysctl_init(void)
 {
@@ -4543,6 +4593,21 @@ static int __init sched_core_sysctl_init(void)
 late_initcall(sched_core_sysctl_init);
 #endif /* CONFIG_SYSCTL */
 
+static void sched_qos_fork(struct task_struct *p)
+{
+	/*
+	 * We always force reset sched_qos on fork. These sched_qos are treated
+	 * as finite resources to help improve quality of life. Inheriting them
+	 * by default can easily lead to a situation where the QoS hint become
+	 * meaningless because all tasks in the system have it.
+	 *
+	 * Every task must request the QoS explicitly if it needs it. No
+	 * accidental inheritance is allowed to keep the default behavior sane.
+	 */
+	bitmap_zero(p->sched_qos.user_defined, SCHED_QOS_MAX);
+	p->sched_qos.rampup_multiplier = sysctl_sched_qos_default_rampup_multiplier;
+}
+
 /*
  * fork()/clone()-time setup:
  */
@@ -4562,6 +4627,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->prio = current->normal_prio;
 
 	uclamp_fork(p);
+	sched_qos_fork(p);
 
 	/*
 	 * Revert to default priority/policy on fork if requested.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0c10e2afb52d..3d9794db58e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4906,7 +4906,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (!task_sleep) {
 		if (task_util(p) > task_util_dequeued(p)) {
 			ewma &= ~UTIL_AVG_UNCHANGED;
-			ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
+			ewma = approximate_util_avg(ewma, (p->se.delta_exec/1000) * p->sched_qos.rampup_multiplier);
 			goto done;
 		}
 		return;
@@ -4974,6 +4974,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
 	 */
 	ewma <<= UTIL_EST_WEIGHT_SHIFT;
+	if (p->sched_qos.rampup_multiplier)
+		last_ewma_diff /= p->sched_qos.rampup_multiplier;
 	ewma  -= last_ewma_diff;
 	ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
@@ -9643,7 +9645,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	 * on TICK doesn't end up hurting it as it can happen after we would
 	 * have crossed this threshold.
 	 *
-	 * To ensure that invaraince is taken into account, we don't scale time
+	 * To ensure that invariance is taken into account, we don't scale time
 	 * and use it as-is, approximate_util_avg() will then let us know the
 	 * our threshold.
 	 */
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index a7d4dfdfed43..dc7d7bcaae7b 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -543,6 +543,35 @@ static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
 #endif
 
+static inline int sched_qos_validate(struct task_struct *p,
+				     const struct sched_attr *attr)
+{
+	switch (attr->sched_qos_type) {
+	case SCHED_QOS_RAMPUP_MULTIPLIER:
+		if (attr->sched_qos_cookie)
+			return -EINVAL;
+		if (attr->sched_qos_value < 0)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __setscheduler_sched_qos(struct task_struct *p,
+				     const struct sched_attr *attr)
+{
+	switch (attr->sched_qos_type) {
+	case SCHED_QOS_RAMPUP_MULTIPLIER:
+		set_bit(SCHED_QOS_RAMPUP_MULTIPLIER, p->sched_qos.user_defined);
+		p->sched_qos.rampup_multiplier = attr->sched_qos_value;
+	default:
+		break;
+	}
+}
+
 /*
  * Allow unprivileged RT tasks to decrease priority.
  * Only issue a capable test if needed and only once to avoid an audit
@@ -668,8 +697,11 @@ int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
-	if (attr->sched_flags & SCHED_FLAG_QOS)
-		return -EOPNOTSUPP;
+	if (attr->sched_flags & SCHED_FLAG_QOS) {
+		retval = sched_qos_validate(p, attr);
+		if (retval)
+			return retval;
+	}
 
 	/*
 	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
@@ -799,7 +831,9 @@ int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_params(p, attr);
 		__setscheduler_prio(p, newprio);
 	}
+
 	__setscheduler_uclamp(p, attr);
+	__setscheduler_sched_qos(p, attr);
 
 	if (queued) {
 		/*
-- 
2.34.1


