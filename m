Return-Path: <linux-pm+bounces-9530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADCE90E1DD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41835B22F30
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E158AD0;
	Wed, 19 Jun 2024 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0rguxlu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7379957888;
	Wed, 19 Jun 2024 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766784; cv=none; b=MmYIREqGM9KQfe0KKNtVXHPr1e7FayBmbhp6gp/KHPTY8UDZCv8WsSSaNBQYcSJ3DmW/zCFKfTuQQMo6pzg6z6esQ0bHeRC3iQLHEJaP7iqhJshNTDoQoteKYybQoy/DyZZlUqO0zQz1C5WAtWBO68zkZWEeGtcl4Pkff/5pnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766784; c=relaxed/simple;
	bh=zdpIlzi339zZqxVM8XSqxk2uRzY5cOZCkIi5zKk66oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSm4a9C454/WrTFwkF3Cms56m3cgG6bEOfHWoVj3UwReY/ER4jdwu2t7ipiHvJqkVDQwqcwSvJhwiZLvBjVkozm9kenWUiXYUgcydTVobAgeK76rRoKXD2GY3nqWRgQb5d8H5sksZRcwqhxJm1gnSPCH/pKs2Mm3T9kr65A+ZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0rguxlu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f717608231so46313485ad.2;
        Tue, 18 Jun 2024 20:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766782; x=1719371582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaseU+jv+YgCNZROoCKmeSNg7KaimNLQHFVcupqA3nk=;
        b=F0rguxluxrET0TLxN5mCte1B4NQ6rj8H3EC2RroN0OjgdVRigxwASN/boGg9vkaFY8
         VE1TCtvszbbF/2Uc8t9mYNvB7IODPeS2HvJdH1cZzC8bJ4rjJ4qwWzoUL6M5Zqs+aXNS
         Yhwam3rA+TW9tBh0ecOH1bHi440ICfuvCfbhUr8JUkwn5H5NAmosZCw7oxdYmtaY7yde
         LF58z5vDnWnSKjXynphwlUNjxgwdhhjJ9E/OrpFQZPJr5vjeMmSg14twZgF3oXSfwhfJ
         w/q+etVaCnGU64M4wOz+5d8oUXWswT6dlK9tHdMncCjzgo+lyAbTmmN0csuNzxoTd3f2
         rZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766782; x=1719371582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oaseU+jv+YgCNZROoCKmeSNg7KaimNLQHFVcupqA3nk=;
        b=D9b/OHdEmRCFa9cDMlENzU+0HajgAAkP/pRP/NYgxyXBJpxXEisYZ7wgdlAUlzcGIf
         rnI2G9/g4JjL6YMw86cS4ngAxgYryEmHS/dzTgP9FW1+Y4RhATlJA0K7Z108XWL8TGRx
         enyH8hykRpUjvianKAF1WMOpWL2CaKCYIX6S1EFt/NBpGH7iR6ozgZJXTuFp8F4brZ5g
         yvTJU8kdUe67mNrlWKGNxYtlFBUs46CDpET0DH55S6bplc7K57568A4g1rP2R4hMKvTW
         TYHls+VH51iJYP06uhp881fDOI4O26YYWBQHR98BasxUwzQNGLeFzwQCZPiWf4LP4U9V
         aZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZMDd/pryP4+m/3OcVtBcES/0RX5nRZFEkvP2ewjkQ0uO7TUzCa6sgYOO/GPdq+AonfJPKUtYri1vPwTfe9N4wxi128chLcmQCUL8
X-Gm-Message-State: AOJu0YyInwq/EtQkcrVESRcXEAersB/wYkQM8cMSR7sd/le8muAZHXPg
	wcIGpT+2s7nhu1Ds7bGfL9t7Jmyi1yLZOyl/jSs9LcByIN2n/OD8
X-Google-Smtp-Source: AGHT+IGV6hN650lzD1BQPi/nvAbifQ58g062gkFDvo59YUONPg9xiwUss3cLTnM3ErVM8spYcnCd1g==
X-Received: by 2002:a17:903:1cf:b0:1f9:a4bf:de10 with SMTP id d9443c01a7336-1f9aa3a5cd8mr17657725ad.2.1718766781585;
        Tue, 18 Jun 2024 20:13:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6dfb7sm104871845ad.64.2024.06.18.20.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:13:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	void@manifault.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 2/2] sched_ext: Add cpuperf support
Date: Tue, 18 Jun 2024 17:12:03 -1000
Message-ID: <20240619031250.2936087-3-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619031250.2936087-1-tj@kernel.org>
References: <20240619031250.2936087-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext currently does not integrate with schedutil. When schedutil is the
governor, frequencies are left unregulated and usually get stuck close to
the highest performance level from running RT tasks.

Add CPU performance monitoring and scaling support by integrating into
schedutil. The following kfuncs are added:

- scx_bpf_cpuperf_cap(): Query the relative performance capacity of
  different CPUs in the system.

- scx_bpf_cpuperf_cur(): Query the current performance level of a CPU
  relative to its max performance.

- scx_bpf_cpuperf_set(): Set the current target performance level of a CPU.

This gives direct control over CPU performance setting to the BPF scheduler.
The only changes on the schedutil side are accounting for the utilization
factor from sched_ext and disabling frequency holding heuristics as it may
not apply well to sched_ext schedulers which may have a lot weaker
connection between tasks and their current / last CPU.

With cpuperf support added, there is no reason to block uclamp. Enable while
at it.

A toy implementation of cpuperf is added to scx_qmap as a demonstration of
the feature.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c         |  12 +-
 kernel/sched/ext.c                       |  83 ++++++++++++-
 kernel/sched/ext.h                       |   9 ++
 kernel/sched/sched.h                     |   1 +
 tools/sched_ext/include/scx/common.bpf.h |   3 +
 tools/sched_ext/scx_qmap.bpf.c           | 142 ++++++++++++++++++++++-
 tools/sched_ext/scx_qmap.c               |   8 ++
 7 files changed, 252 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 972b7dd65af2..12174c0137a5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -197,7 +197,9 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 
 static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
-	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
+	unsigned long min, max;
+	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu) +
+		scx_cpuperf_target(sg_cpu->cpu);
 
 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
 	util = max(util, boost);
@@ -330,6 +332,14 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 	unsigned long idle_calls;
 	bool ret;
 
+	/*
+	 * The heuristics in this function is for the fair class. For SCX, the
+	 * performance target comes directly from the BPF scheduler. Let's just
+	 * follow it.
+	 */
+	if (scx_switched_all())
+		return false;
+
 	/* if capped by uclamp_max, always update to be in compliance */
 	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
 		return false;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f814e84ceeb3..04fb0eeee5ec 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -16,6 +16,8 @@ enum scx_consts {
 	SCX_EXIT_BT_LEN			= 64,
 	SCX_EXIT_MSG_LEN		= 1024,
 	SCX_EXIT_DUMP_DFL_LEN		= 32768,
+
+	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
 };
 
 enum scx_exit_kind {
@@ -3520,7 +3522,7 @@ DEFINE_SCHED_CLASS(ext) = {
 	.update_curr		= update_curr_scx,
 
 #ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 0,
+	.uclamp_enabled		= 1,
 #endif
 };
 
@@ -4393,7 +4395,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	unsigned long timeout;
-	int i, ret;
+	int i, cpu, ret;
 
 	mutex_lock(&scx_ops_enable_mutex);
 
@@ -4442,6 +4444,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	atomic_long_set(&scx_nr_rejected, 0);
 
+	for_each_possible_cpu(cpu)
+		cpu_rq(cpu)->scx.cpuperf_target = SCX_CPUPERF_ONE;
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
@@ -5835,6 +5840,77 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 		ops_dump_flush();
 }
 
+/**
+ * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
+ * @cpu: CPU of interest
+ *
+ * Return the maximum relative capacity of @cpu in relation to the most
+ * performant CPU in the system. The return value is in the range [1,
+ * %SCX_CPUPERF_ONE]. See scx_bpf_cpuperf_cur().
+ */
+__bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
+{
+	if (ops_cpu_valid(cpu, NULL))
+		return arch_scale_cpu_capacity(cpu);
+	else
+		return SCX_CPUPERF_ONE;
+}
+
+/**
+ * scx_bpf_cpuperf_cur - Query the current relative performance of a CPU
+ * @cpu: CPU of interest
+ *
+ * Return the current relative performance of @cpu in relation to its maximum.
+ * The return value is in the range [1, %SCX_CPUPERF_ONE].
+ *
+ * The current performance level of a CPU in relation to the maximum performance
+ * available in the system can be calculated as follows:
+ *
+ *   scx_bpf_cpuperf_cap() * scx_bpf_cpuperf_cur() / %SCX_CPUPERF_ONE
+ *
+ * The result is in the range [1, %SCX_CPUPERF_ONE].
+ */
+__bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
+{
+	if (ops_cpu_valid(cpu, NULL))
+		return arch_scale_freq_capacity(cpu);
+	else
+		return SCX_CPUPERF_ONE;
+}
+
+/**
+ * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
+ * @cpu: CPU of interest
+ * @perf: target performance level [0, %SCX_CPUPERF_ONE]
+ * @flags: %SCX_CPUPERF_* flags
+ *
+ * Set the target performance level of @cpu to @perf. @perf is in linear
+ * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
+ * schedutil cpufreq governor chooses the target frequency.
+ *
+ * The actual performance level chosen, CPU grouping, and the overhead and
+ * latency of the operations are dependent on the hardware and cpufreq driver in
+ * use. Consult hardware and cpufreq documentation for more information. The
+ * current performance level can be monitored using scx_bpf_cpuperf_cur().
+ */
+__bpf_kfunc void scx_bpf_cpuperf_set(u32 cpu, u32 perf)
+{
+	if (unlikely(perf > SCX_CPUPERF_ONE)) {
+		scx_ops_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
+		return;
+	}
+
+	if (ops_cpu_valid(cpu, NULL)) {
+		struct rq *rq = cpu_rq(cpu);
+
+		rq->scx.cpuperf_target = perf;
+
+		rcu_read_lock_sched_notrace();
+		cpufreq_update_util(cpu_rq(cpu), 0);
+		rcu_read_unlock_sched_notrace();
+	}
+}
+
 /**
  * scx_bpf_nr_cpu_ids - Return the number of possible CPU IDs
  *
@@ -6045,6 +6121,9 @@ BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index c41d742b5d62..c7ac33c47b68 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -48,6 +48,14 @@ int scx_check_setscheduler(struct task_struct *p, int policy);
 bool task_should_scx(struct task_struct *p);
 void init_sched_ext_class(void);
 
+static inline u32 scx_cpuperf_target(s32 cpu)
+{
+	if (scx_enabled())
+		return cpu_rq(cpu)->scx.cpuperf_target;
+	else
+		return 0;
+}
+
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
@@ -89,6 +97,7 @@ static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
 static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void scx_rq_activate(struct rq *rq) {}
 static inline void scx_rq_deactivate(struct rq *rq) {}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c0d6e42c99cc..d3912cf3c3b7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -743,6 +743,7 @@ struct scx_rq {
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			flags;
+	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			cpu_released;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 3fa87084cf17..dbbda0e35c5d 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -42,6 +42,9 @@ void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
 void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
+u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
+u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
+void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index c75c70d6a8eb..b1d0b09c966e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -68,6 +68,18 @@ struct {
 	},
 };
 
+/*
+ * If enabled, CPU performance target is set according to the queue index
+ * according to the following table.
+ */
+static const u32 qidx_to_cpuperf_target[] = {
+	[0] = SCX_CPUPERF_ONE * 0 / 4,
+	[1] = SCX_CPUPERF_ONE * 1 / 4,
+	[2] = SCX_CPUPERF_ONE * 2 / 4,
+	[3] = SCX_CPUPERF_ONE * 3 / 4,
+	[4] = SCX_CPUPERF_ONE * 4 / 4,
+};
+
 /*
  * Per-queue sequence numbers to implement core-sched ordering.
  *
@@ -95,6 +107,8 @@ struct {
 struct cpu_ctx {
 	u64	dsp_idx;	/* dispatch index */
 	u64	dsp_cnt;	/* remaining count */
+	u32	avg_weight;
+	u32	cpuperf_target;
 };
 
 struct {
@@ -107,6 +121,8 @@ struct {
 /* Statistics */
 u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
 u64 nr_core_sched_execed;
+u32 cpuperf_min, cpuperf_avg, cpuperf_max;
+u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -313,6 +329,29 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
+{
+	struct cpu_ctx *cpuc;
+	u32 zero = 0;
+	int idx;
+
+	if (!(cpuc = bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
+		scx_bpf_error("failed to look up cpu_ctx");
+		return;
+	}
+
+	/*
+	 * Use the running avg of weights to select the target cpuperf level.
+	 * This is a demonstration of the cpuperf feature rather than a
+	 * practical strategy to regulate CPU frequency.
+	 */
+	cpuc->avg_weight = cpuc->avg_weight * 3 / 4 + p->scx.weight / 4;
+	idx = weight_to_idx(cpuc->avg_weight);
+	cpuc->cpuperf_target = qidx_to_cpuperf_target[idx];
+
+	scx_bpf_cpuperf_set(scx_bpf_task_cpu(p), cpuc->cpuperf_target);
+}
+
 /*
  * The distance from the head of the queue scaled by the weight of the queue.
  * The lower the number, the older the task and the higher the priority.
@@ -422,8 +461,9 @@ void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_ctx *dctx, s32 cpu, bool idle
 	if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, cpu)))
 		return;
 
-	scx_bpf_dump("QMAP: dsp_idx=%llu dsp_cnt=%llu",
-		     cpuc->dsp_idx, cpuc->dsp_cnt);
+	scx_bpf_dump("QMAP: dsp_idx=%llu dsp_cnt=%llu avg_weight=%u cpuperf_target=%u",
+		     cpuc->dsp_idx, cpuc->dsp_cnt, cpuc->avg_weight,
+		     cpuc->cpuperf_target);
 }
 
 void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struct *p)
@@ -492,11 +532,106 @@ void BPF_STRUCT_OPS(qmap_cpu_offline, s32 cpu)
 	print_cpus();
 }
 
+struct monitor_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct monitor_timer);
+} monitor_timer SEC(".maps");
+
+/*
+ * Print out the min, avg and max performance levels of CPUs every second to
+ * demonstrate the cpuperf interface.
+ */
+static void monitor_cpuperf(void)
+{
+	u32 zero = 0, nr_cpu_ids;
+	u64 cap_sum = 0, cur_sum = 0, cur_min = SCX_CPUPERF_ONE, cur_max = 0;
+	u64 target_sum = 0, target_min = SCX_CPUPERF_ONE, target_max = 0;
+	const struct cpumask *online;
+	int i, nr_online_cpus = 0;
+
+	nr_cpu_ids = scx_bpf_nr_cpu_ids();
+	online = scx_bpf_get_online_cpumask();
+
+	bpf_for(i, 0, nr_cpu_ids) {
+		struct cpu_ctx *cpuc;
+		u32 cap, cur;
+
+		if (!bpf_cpumask_test_cpu(i, online))
+			continue;
+		nr_online_cpus++;
+
+		/* collect the capacity and current cpuperf */
+		cap = scx_bpf_cpuperf_cap(i);
+		cur = scx_bpf_cpuperf_cur(i);
+
+		cur_min = cur < cur_min ? cur : cur_min;
+		cur_max = cur > cur_max ? cur : cur_max;
+
+		/*
+		 * $cur is relative to $cap. Scale it down accordingly so that
+		 * it's in the same scale as other CPUs and $cur_sum/$cap_sum
+		 * makes sense.
+		 */
+		cur_sum += cur * cap / SCX_CPUPERF_ONE;
+		cap_sum += cap;
+
+		if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, i))) {
+			scx_bpf_error("failed to look up cpu_ctx");
+			goto out;
+		}
+
+		/* collect target */
+		cur = cpuc->cpuperf_target;
+		target_sum += cur;
+		target_min = cur < target_min ? cur : target_min;
+		target_max = cur > target_max ? cur : target_max;
+	}
+
+	cpuperf_min = cur_min;
+	cpuperf_avg = cur_sum * SCX_CPUPERF_ONE / cap_sum;
+	cpuperf_max = cur_max;
+
+	cpuperf_target_min = target_min;
+	cpuperf_target_avg = target_sum / nr_online_cpus;
+	cpuperf_target_max = target_max;
+out:
+	scx_bpf_put_cpumask(online);
+}
+
+static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	monitor_cpuperf();
+
+	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
+	return 0;
+}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
+	u32 key = 0;
+	struct bpf_timer *timer;
+	s32 ret;
+
 	print_cpus();
 
-	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
+	if (ret)
+		return ret;
+
+	timer = bpf_map_lookup_elem(&monitor_timer, &key);
+	if (!timer)
+		return -ESRCH;
+
+	bpf_timer_init(timer, &monitor_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, monitor_timerfn);
+
+	return bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
 }
 
 void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
@@ -509,6 +644,7 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .enqueue			= (void *)qmap_enqueue,
 	       .dequeue			= (void *)qmap_dequeue,
 	       .dispatch		= (void *)qmap_dispatch,
+	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
 	       .cpu_release		= (void *)qmap_cpu_release,
 	       .init_task		= (void *)qmap_init_task,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index bc36ec4f88a7..4d41c0cb1dab 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -116,6 +116,14 @@ int main(int argc, char **argv)
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
 		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
 		       skel->bss->nr_core_sched_execed);
+		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
+			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
+			       skel->bss->cpuperf_min,
+			       skel->bss->cpuperf_avg,
+			       skel->bss->cpuperf_max,
+			       skel->bss->cpuperf_target_min,
+			       skel->bss->cpuperf_target_avg,
+			       skel->bss->cpuperf_target_max);
 		fflush(stdout);
 		sleep(1);
 	}
-- 
2.45.2


