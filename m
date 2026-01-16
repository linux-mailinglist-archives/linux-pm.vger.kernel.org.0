Return-Path: <linux-pm+bounces-41012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF9FD33096
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 912BE3110556
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32C2E22BA;
	Fri, 16 Jan 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Adomgxsk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB5221DAD;
	Fri, 16 Jan 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575162; cv=none; b=pAdYmHHOv4SzK6edFGNoygFcq2fO/neDNMC9F31FTUUoLyHDYUscQvx7lZgBtGRZXe7DlF7wSmZWVoUz8DCk27/xZb0nhMsv+d1wTO175NU9RPCBIF8Max+bj4LNiK3qNV+P2rW8Hh6xTRiqyf6VOT3YmWxQmoJ1+/ntk4j6ad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575162; c=relaxed/simple;
	bh=KdTiRwNqvvTUCK29uJFVf97xOZdvdCR4xQadD5dd7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1C75L3p++jD9hUxULtRWXVVqadq/6d8BSE9IZuvGE8Qmo1D3M9+6vAp9GU/3uGMyt+83CPf8RdVQ819QayvqDOtuQ/hw9J27n/vkRENyQpXoYlsZkwepZCBdgD4PL49aMo3An5+S80D6KqKPxclD8CTOJSTkC2CCLPcRfDo+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Adomgxsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D42C116C6;
	Fri, 16 Jan 2026 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575162;
	bh=KdTiRwNqvvTUCK29uJFVf97xOZdvdCR4xQadD5dd7Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdomgxskzkU+sLSsmMYNhuPB6+HiDEHNe3Wx7a5u+FWDJg+MoxaTG491VnRfG9PM4
	 VwbMgd8WvqQBs+1XvJXxvoeBnrlgLJX4ddHNATB2nvc3bzW1P5fZH7TMd9PD7Zs0Ob
	 iw9aQxCHGZMljcG1K9g1yIum4xwa4jXkLhrpGfUlviKobG9w5c/9QaA/VOuC7caFVD
	 RiZ6VtCj1xk7+4MUVfNWd+NZJjGWbi5mjVOvnMERLr0gpI+C/ckt1g0ZJba6j9ssLh
	 tpFq4s92Hngh5oZAKD5TmBIvJs71ct71mj7+/GNtJhxxEn6446EjsuepigZH1TKZnW
	 07Ocp25nPF4Mw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/15] sched/cputime: Correctly support generic vtime idle time
Date: Fri, 16 Jan 2026 15:51:56 +0100
Message-ID: <20260116145208.87445-4-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260116145208.87445-1-frederic@kernel.org>
References: <20260116145208.87445-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently whether generic vtime is running or not, the idle cputime is
fetched from the nohz accounting.

However generic vtime already does its own idle cputime accounting. Only
the kernel stat accessors are not plugged to support it.

Read the idle generic vtime cputime when it's running, this will allow
to later more clearly split nohz and vtime cputime accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 fs/proc/stat.c           |  8 ++++----
 include/linux/vtime.h    |  7 ++++++-
 kernel/sched/cputime.c   | 38 +++++++++++++++++++++++++++++++-------
 kernel/time/tick-sched.c |  2 +-
 4 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 8b444e862319..6ac2a13b8be5 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -30,8 +30,8 @@ u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
 
 	if (idle_usecs == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
-		idle = kcs->cpustat[CPUTIME_IDLE];
+		/* !NO_HZ or cpu offline or vtime so we can rely on cpustat.idle */
+		idle = kcpustat_field(CPUTIME_IDLE, cpu);
 	else
 		idle = idle_usecs * NSEC_PER_USEC;
 
@@ -46,8 +46,8 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
 
 	if (iowait_usecs == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
-		iowait = kcs->cpustat[CPUTIME_IOWAIT];
+		/* !NO_HZ or cpu offline or vtime so we can rely on cpustat.iowait */
+		iowait = kcpustat_field(CPUTIME_IOWAIT, cpu);
 	else
 		iowait = iowait_usecs * NSEC_PER_USEC;
 
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 29dd5b91dd7d..737930f66c3e 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -27,6 +27,11 @@ static inline void vtime_guest_exit(struct task_struct *tsk) { }
 static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
+static inline bool vtime_generic_enabled_cpu(int cpu)
+{
+	return context_tracking_enabled_cpu(cpu);
+}
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
@@ -74,7 +79,7 @@ static inline bool vtime_accounting_enabled(void)
 
 static inline bool vtime_accounting_enabled_cpu(int cpu)
 {
-	return context_tracking_enabled_cpu(cpu);
+	return vtime_generic_enabled_cpu(cpu);
 }
 
 static inline bool vtime_accounting_enabled_this_cpu(void)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5dcb0f2e01bc..f32c169da11a 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -761,7 +761,11 @@ EXPORT_SYMBOL_GPL(vtime_guest_exit);
 
 void vtime_account_idle(struct task_struct *tsk)
 {
-	account_idle_time(get_vtime_delta(&tsk->vtime));
+	struct vtime *vtime = &tsk->vtime;
+
+	write_seqcount_begin(&vtime->seqcount);
+	account_idle_time(get_vtime_delta(vtime));
+	write_seqcount_end(&vtime->seqcount);
 }
 
 void vtime_task_switch_generic(struct task_struct *prev)
@@ -912,6 +916,7 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				int cpu, u64 *val)
 {
 	struct vtime *vtime = &tsk->vtime;
+	struct rq *rq = cpu_rq(cpu);
 	unsigned int seq;
 
 	do {
@@ -953,6 +958,14 @@ static int kcpustat_field_vtime(u64 *cpustat,
 			if (state == VTIME_GUEST && task_nice(tsk) > 0)
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
+		case CPUTIME_IDLE:
+			if (state == VTIME_IDLE && !atomic_read(&rq->nr_iowait))
+				*val += vtime_delta(vtime);
+			break;
+		case CPUTIME_IOWAIT:
+			if (state == VTIME_IDLE && atomic_read(&rq->nr_iowait) > 0)
+				*val += vtime_delta(vtime);
+			break;
 		default:
 			break;
 		}
@@ -1015,8 +1028,8 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		*dst = *src;
 		cpustat = dst->cpustat;
 
-		/* Task is sleeping, dead or idle, nothing to add */
-		if (state < VTIME_SYS)
+		/* Task is sleeping or dead, nothing to add */
+		if (state < VTIME_IDLE)
 			continue;
 
 		delta = vtime_delta(vtime);
@@ -1025,15 +1038,17 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		 * Task runs either in user (including guest) or kernel space,
 		 * add pending nohz time to the right place.
 		 */
-		if (state == VTIME_SYS) {
+		switch (vtime->state) {
+		case VTIME_SYS:
 			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
-		} else if (state == VTIME_USER) {
+			break;
+		case VTIME_USER:
 			if (task_nice(tsk) > 0)
 				cpustat[CPUTIME_NICE] += vtime->utime + delta;
 			else
 				cpustat[CPUTIME_USER] += vtime->utime + delta;
-		} else {
-			WARN_ON_ONCE(state != VTIME_GUEST);
+			break;
+		case VTIME_GUEST:
 			if (task_nice(tsk) > 0) {
 				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
 				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
@@ -1041,6 +1056,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 				cpustat[CPUTIME_GUEST] += vtime->gtime + delta;
 				cpustat[CPUTIME_USER] += vtime->gtime + delta;
 			}
+			break;
+		case VTIME_IDLE:
+			if (atomic_read(&cpu_rq(cpu)->nr_iowait) > 0)
+				cpustat[CPUTIME_IOWAIT] += delta;
+			else
+				cpustat[CPUTIME_IDLE] += delta;
+			break;
+		default:
+			WARN_ON_ONCE(1);
 		}
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8ddf74e705d3..f1d07a0276a5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -780,7 +780,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 	ktime_t now, idle;
 	unsigned int seq;
 
-	if (!tick_nohz_active)
+	if (!tick_nohz_active || vtime_generic_enabled_cpu(cpu))
 		return -1;
 
 	now = ktime_get();
-- 
2.51.1


