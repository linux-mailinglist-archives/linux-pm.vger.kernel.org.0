Return-Path: <linux-pm+bounces-41021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC212D330D8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3FDE314B3D0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685E3933FD;
	Fri, 16 Jan 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNHyGy9x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334B274FC1;
	Fri, 16 Jan 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575228; cv=none; b=DiUGYfEkE7m+tiLC+iBrLNm97BmpCpY1rR/23xw3VzUZ/8+sDcWZ8tG5+FOUh0ILJIrLxd7ajeT+DQtH7RohnhM9lWRavl/AaI0WC9oFvrh3ChvuaV5bpqTWqSD0QopLLBMp0Lv82G0w9ML99LSTua8FI7AaFyqXLVBDO6tzU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575228; c=relaxed/simple;
	bh=6rMuEpbQZXvwjKA1HjWhJVfT/gG1/xfSb0ElvkTOWjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofVqpmgH1ExCiWdNm1j/WveUa9b6NdqfjKpFZDnDKvf3a7aF4b5AYCVRCLaz3et7NAxtg6pB01NjV7w2RbsQIwrea0zlw8Kz09WusTazw8qTO4ujOgv4RkmFy9wNTvX3WJG3/SD/Vpnn4nFxeRHjg43aWHVDi69GgUdAnibmi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNHyGy9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE2AC16AAE;
	Fri, 16 Jan 2026 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575228;
	bh=6rMuEpbQZXvwjKA1HjWhJVfT/gG1/xfSb0ElvkTOWjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNHyGy9x0ZCCX3hcPWuzKQoZdn2unDE3tiZ3OHWATurUeRfzrcyer0Bizt3PhEHNs
	 VeXOLM91VS3T7jU6c+Oomdzra6apJuw5lvulqLk2RNJM8W2atJwfXU3bmOQrRhcMGK
	 dhLpJHmLnLCrzmHDvtyJNh5lG2FqU6eGSaVbvu6dpyoc99Q46h6YEkbnB8NxttweMt
	 4+T3RxEeQPIACQs50+Rr0IclsAjLeekt5UsMdBaVhxEwjWRULX/BeE9qy/w1yrQ3ET
	 3arl4YDBDpRDM6J9kZ5pl1ddZb/l311wmJrjTSkyvPPaYoij16nZ7tekNqE3TrLhNP
	 zte6143jEN7qg==
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
Subject: [PATCH 12/15] tick/sched: Consolidate idle time fetching APIs
Date: Fri, 16 Jan 2026 15:52:05 +0100
Message-ID: <20260116145208.87445-13-frederic@kernel.org>
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

Fetching the idle cputime is available through a variety of accessors
all over the place depending on the different accounting flavours and
needs:

- idle vtime generic accounting can be accessed by kcpustat_field(),
  kcpustat_cpu_fetch(), or get_idle/iowait_time() but not by
  get_cpu_idle/iowait_time_us()

- dynticks-idle accounting can only be accessed by get_idle/iowait_time()
  or get_cpu_idle/iowait_time_us()

- CONFIG_NO_HZ_COMMON=n idle accounting can be accessed by kcpustat_field()
  kcpustat_cpu_fetch(), or get_idle/iowait_time() but not by
  get_cpu_idle/iowait_time_us()

Moreover get_idle/iowait_time() relies on get_cpu_idle/iowait_time_us()
with a non-sensical conversion to microseconds and back to nanoseconds
on the way.

Start consolidating the APIs with removing get_idle/iowait_time() and
make kcpustat_field() and kcpustat_cpu_fetch() work for all cases.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 fs/proc/stat.c              | 40 +++-----------------------
 fs/proc/uptime.c            |  8 ++----
 include/linux/kernel_stat.h | 34 +++++++++++++++++++---
 kernel/sched/cputime.c      | 57 ++++++++++++++++++++++++++-----------
 4 files changed, 76 insertions(+), 63 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6ac2a13b8be5..c00468a83f64 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -22,38 +22,6 @@
 #define arch_irq_stat() 0
 #endif
 
-u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
-{
-	u64 idle, idle_usecs = -1ULL;
-
-	if (cpu_online(cpu))
-		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
-
-	if (idle_usecs == -1ULL)
-		/* !NO_HZ or cpu offline or vtime so we can rely on cpustat.idle */
-		idle = kcpustat_field(CPUTIME_IDLE, cpu);
-	else
-		idle = idle_usecs * NSEC_PER_USEC;
-
-	return idle;
-}
-
-static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
-{
-	u64 iowait, iowait_usecs = -1ULL;
-
-	if (cpu_online(cpu))
-		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
-
-	if (iowait_usecs == -1ULL)
-		/* !NO_HZ or cpu offline or vtime so we can rely on cpustat.iowait */
-		iowait = kcpustat_field(CPUTIME_IOWAIT, cpu);
-	else
-		iowait = iowait_usecs * NSEC_PER_USEC;
-
-	return iowait;
-}
-
 static void show_irq_gap(struct seq_file *p, unsigned int gap)
 {
 	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
@@ -105,8 +73,8 @@ static int show_stat(struct seq_file *p, void *v)
 		user		+= cpustat[CPUTIME_USER];
 		nice		+= cpustat[CPUTIME_NICE];
 		system		+= cpustat[CPUTIME_SYSTEM];
-		idle		+= get_idle_time(&kcpustat, i);
-		iowait		+= get_iowait_time(&kcpustat, i);
+		idle		+= cpustat[CPUTIME_IDLE];
+		iowait		+= cpustat[CPUTIME_IOWAIT];
 		irq		+= cpustat[CPUTIME_IRQ];
 		softirq		+= cpustat[CPUTIME_SOFTIRQ];
 		steal		+= cpustat[CPUTIME_STEAL];
@@ -146,8 +114,8 @@ static int show_stat(struct seq_file *p, void *v)
 		user		= cpustat[CPUTIME_USER];
 		nice		= cpustat[CPUTIME_NICE];
 		system		= cpustat[CPUTIME_SYSTEM];
-		idle		= get_idle_time(&kcpustat, i);
-		iowait		= get_iowait_time(&kcpustat, i);
+		idle		= cpustat[CPUTIME_IDLE];
+		iowait		= cpustat[CPUTIME_IOWAIT];
 		irq		= cpustat[CPUTIME_IRQ];
 		softirq		= cpustat[CPUTIME_SOFTIRQ];
 		steal		= cpustat[CPUTIME_STEAL];
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index b5343d209381..433aa947cd57 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -18,12 +18,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 	int i;
 
 	idle_nsec = 0;
-	for_each_possible_cpu(i) {
-		struct kernel_cpustat kcs;
-
-		kcpustat_cpu_fetch(&kcs, i);
-		idle_nsec += get_idle_time(&kcs, i);
-	}
+	for_each_possible_cpu(i)
+		idle_nsec += kcpustat_field(CPUTIME_IDLE, i);
 
 	ktime_get_boottime_ts64(&uptime);
 	timens_add_boottime(&uptime);
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index a906492eb680..e1efd26e56f0 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -110,32 +110,59 @@ extern void kcpustat_dyntick_start(ktime_t now);
 extern void kcpustat_dyntick_stop(ktime_t now);
 extern void kcpustat_irq_enter(ktime_t now);
 extern void kcpustat_irq_exit(ktime_t now);
+extern u64 kcpustat_field_idle(int cpu);
+extern u64 kcpustat_field_iowait(int cpu);
 
 static inline bool kcpustat_idle_dyntick(void)
 {
 	return __this_cpu_read(kernel_cpustat.idle_dyntick);
 }
 #else
+static inline u64 kcpustat_field_idle(int cpu)
+{
+	return kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
+}
+static inline u64 kcpustat_field_iowait(int cpu)
+{
+	return kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
+}
+
 static inline bool kcpustat_idle_dyntick(void)
 {
 	return false;
 }
 #endif /* CONFIG_NO_HZ_COMMON */
 
+/* Fetch cputime values when vtime is disabled on a CPU */
+static inline u64 kcpustat_field_default(enum cpu_usage_stat usage, int cpu)
+{
+	if (usage == CPUTIME_IDLE)
+		return kcpustat_field_idle(cpu);
+	if (usage == CPUTIME_IOWAIT)
+		return kcpustat_field_iowait(cpu);
+	return kcpustat_cpu(cpu).cpustat[usage];
+}
+
+static inline void kcpustat_cpu_fetch_default(struct kernel_cpustat *dst, int cpu)
+{
+	*dst = kcpustat_cpu(cpu);
+	dst->cpustat[CPUTIME_IDLE] = kcpustat_field_idle(cpu);
+	dst->cpustat[CPUTIME_IOWAIT] = kcpustat_field_iowait(cpu);
+}
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 extern u64 kcpustat_field(enum cpu_usage_stat usage, int cpu);
 extern void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu);
 #else
 static inline u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 {
-	return kcpustat_cpu(cpu).cpustat[usage];
+	return kcpustat_field_default(usage, cpu);
 }
 
 static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 {
-	*dst = kcpustat_cpu(cpu);
+	kcpustat_cpu_fetch_default(dst, cpu);
 }
-
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 
 extern void account_user_time(struct task_struct *, u64);
@@ -145,7 +172,6 @@ extern void account_system_index_time(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
 extern void account_idle_time(u64);
-extern u64 get_idle_time(struct kernel_cpustat *kcs, int cpu);
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 static inline void account_process_tick(struct task_struct *tsk, int user)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 16d6730efe6d..9906abe5d7bc 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -475,21 +475,14 @@ void kcpustat_irq_exit(ktime_t now)
 		kcpustat_idle_start(kc, now);
 }
 
-static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
-				 bool compute_delta, u64 *last_update_time)
+static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
+				  bool compute_delta, ktime_t now)
 {
 	struct kernel_cpustat *kc = &kcpustat_cpu(cpu);
 	u64 *cpustat = kc->cpustat;
-	ktime_t now, idle;
+	ktime_t idle;
 	unsigned int seq;
 
-	if (vtime_generic_enabled_cpu(cpu))
-		return -1;
-
-	now = ktime_get();
-	if (last_update_time)
-		*last_update_time = ktime_to_us(now);
-
 	do {
 		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
 
@@ -502,7 +495,38 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 		}
 	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
 
-	return ktime_to_us(idle);
+	return idle;
+}
+
+u64 kcpustat_field_idle(int cpu)
+{
+	return kcpustat_field_dyntick(cpu, CPUTIME_IDLE,
+				      !nr_iowait_cpu(cpu), ktime_get());
+}
+EXPORT_SYMBOL_GPL(kcpustat_field_idle);
+
+u64 kcpustat_field_iowait(int cpu)
+{
+	return kcpustat_field_dyntick(cpu, CPUTIME_IOWAIT,
+				      nr_iowait_cpu(cpu), ktime_get());
+}
+EXPORT_SYMBOL_GPL(kcpustat_field_iowait);
+
+static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
+				 bool compute_delta, u64 *last_update_time)
+{
+	ktime_t now = ktime_get();
+	u64 res;
+
+	if (vtime_generic_enabled_cpu(cpu))
+		return -1;
+	else
+		res = kcpustat_field_dyntick(cpu, idx, compute_delta, now);
+
+	if (last_update_time)
+		*last_update_time = ktime_to_us(now);
+
+	return ktime_to_us(res);
 }
 
 /**
@@ -552,7 +576,6 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 				     nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
-
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
@@ -1110,8 +1133,8 @@ u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 	struct rq *rq;
 	int err;
 
-	if (!vtime_accounting_enabled_cpu(cpu))
-		return val;
+	if (!vtime_generic_enabled_cpu(cpu))
+		return kcpustat_field_default(usage, cpu);
 
 	rq = cpu_rq(cpu);
 
@@ -1206,8 +1229,8 @@ void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 	struct rq *rq;
 	int err;
 
-	if (!vtime_accounting_enabled_cpu(cpu)) {
-		*dst = *src;
+	if (!vtime_generic_enabled_cpu(cpu)) {
+		kcpustat_cpu_fetch_default(dst, cpu);
 		return;
 	}
 
@@ -1220,7 +1243,7 @@ void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 		curr = rcu_dereference(rq->curr);
 		if (WARN_ON_ONCE(!curr)) {
 			rcu_read_unlock();
-			*dst = *src;
+			kcpustat_cpu_fetch_default(dst, cpu);
 			return;
 		}
 
-- 
2.51.1


