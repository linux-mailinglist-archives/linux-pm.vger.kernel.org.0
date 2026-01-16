Return-Path: <linux-pm+bounces-41011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE33D33051
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97FFD316020D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73F3358D4;
	Fri, 16 Jan 2026 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwuikQdv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA8145348;
	Fri, 16 Jan 2026 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575155; cv=none; b=TSC0OarB+edWR/jUSXFV0944uQoBqDK4mPHZIiG6zf/l3BfpDAlkWiA5qiwioMVYgZZDRgfwrKXnC39HeQ6ozF+MvkGULZ/eSiWebwry5UYAuPuphnYiGqjHIOVLYpoVSMGidzU+pB6lj9RBA8dhYdV6te2OS65eyfe2xScF2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575155; c=relaxed/simple;
	bh=LzZmy6jqMt6NobQKkguWtqCpma0/ISXupISgS1lOgXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIqwGw8XvzRj5kXb/9GtEkrwAUnbPD+dEdoH+kWbntyLR2oKT3Kvqy+M2Eo6D8fKuveidpywHXXf4I/HRFwNMiBY6d7zT/NXPvJtmLk829dKX+5bQpvwA0YfouIBD2gytiu1UkP/Spv3G6n+EK+1s1jq7zZnmEbols2W00+p1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwuikQdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110B8C19423;
	Fri, 16 Jan 2026 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575154;
	bh=LzZmy6jqMt6NobQKkguWtqCpma0/ISXupISgS1lOgXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwuikQdv1p9BjGjXhU91yRg8Gw3GvSgQ0M5hzOyEUvqaUD15zFuY83kFOAlgDqtiL
	 aq3Av8T2Mi2oEMJQB77oNtUUPugoJ7geLsaS0nsgJemsTZhW0YU6Gy+zpaXbizbI++
	 nJ4mgh32RcayhFdkr1DMDQB7/MzFNvmkoyAX8/lgU6JDEKdEh7sGOC/70hoxE4oSyF
	 7vtveo+2W7bYT1M/MT0l5IGEafZcX6e5/LLy3p/jPoWkP6CxNqQEYegvs8P+oSPr4J
	 UAjET/LVrlea6oibw+ZGIMM81HmVRAborc7oWyiJm0nAXPvHp8IOheB0uD7EXGGxq4
	 i7oDCgTaceOrw==
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
Subject: [PATCH 02/15] sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
Date: Fri, 16 Jan 2026 15:51:55 +0100
Message-ID: <20260116145208.87445-3-frederic@kernel.org>
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

The first parameter to kcpustat_field() is a pointer to the cpu kcpustat
to be fetched from. This parameter is error prone because a copy to a
kcpustat could be passed by accident instead of the original one. Also
the kcpustat structure can already be retrieved with the help of the
mandatory CPU argument.

Remove the needless paramater.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 drivers/macintosh/rack-meter.c     | 2 +-
 include/linux/kernel_stat.h        | 8 +++-----
 kernel/rcu/tree.c                  | 9 +++------
 kernel/rcu/tree_stall.h            | 7 +++----
 kernel/sched/cputime.c             | 5 ++---
 6 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 1a7fcaf39cc9..b6683628091d 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -105,7 +105,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
 			if (dbs_data->ignore_nice_load)
-				j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+				j_cdbs->prev_cpu_nice = kcpustat_field(CPUTIME_NICE, j);
 		}
 	}
 }
@@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
-			u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+			u64 cur_nice = kcpustat_field(CPUTIME_NICE, j);
 
 			idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
 			j_cdbs->prev_cpu_nice = cur_nice;
@@ -539,7 +539,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		j_cdbs->prev_load = 0;
 
 		if (ignore_nice)
-			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+			j_cdbs->prev_cpu_nice = kcpustat_field(CPUTIME_NICE, j);
 	}
 
 	gov->start(policy);
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 896a43bd819f..20b2ecd32340 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -87,7 +87,7 @@ static inline u64 get_cpu_idle_time(unsigned int cpu)
 		 kcpustat->cpustat[CPUTIME_IOWAIT];
 
 	if (rackmeter_ignore_nice)
-		retval += kcpustat_field(kcpustat, CPUTIME_NICE, cpu);
+		retval += kcpustat_field(CPUTIME_NICE, cpu);
 
 	return retval;
 }
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index b97ce2df376f..dd020ecaf67b 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -100,14 +100,12 @@ static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 }
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-			  enum cpu_usage_stat usage, int cpu);
+extern u64 kcpustat_field(enum cpu_usage_stat usage, int cpu);
 extern void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu);
 #else
-static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-				 enum cpu_usage_stat usage, int cpu)
+static inline u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 {
-	return kcpustat->cpustat[usage];
+	return kcpustat_cpu(cpu).cpustat[usage];
 }
 
 static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..ceea4b2f755b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -968,14 +968,11 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
 			int cpu = rdp->cpu;
 			struct rcu_snap_record *rsrp;
-			struct kernel_cpustat *kcsp;
-
-			kcsp = &kcpustat_cpu(cpu);
 
 			rsrp = &rdp->snap_record;
-			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
-			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
-			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+			rsrp->cputime_irq     = kcpustat_field(CPUTIME_IRQ, cpu);
+			rsrp->cputime_softirq = kcpustat_field(CPUTIME_SOFTIRQ, cpu);
+			rsrp->cputime_system  = kcpustat_field(CPUTIME_SYSTEM, cpu);
 			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
 			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
 			rsrp->nr_csw = nr_context_switches_cpu(cpu);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..cf7ae51cba40 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -479,7 +479,6 @@ static void print_cpu_stat_info(int cpu)
 {
 	struct rcu_snap_record rsr, *rsrp;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct kernel_cpustat *kcsp = &kcpustat_cpu(cpu);
 
 	if (!rcu_cpu_stall_cputime)
 		return;
@@ -488,9 +487,9 @@ static void print_cpu_stat_info(int cpu)
 	if (rsrp->gp_seq != rdp->gp_seq)
 		return;
 
-	rsr.cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
-	rsr.cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
-	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+	rsr.cputime_irq     = kcpustat_field(CPUTIME_IRQ, cpu);
+	rsr.cputime_softirq = kcpustat_field(CPUTIME_SOFTIRQ, cpu);
+	rsr.cputime_system  = kcpustat_field(CPUTIME_SYSTEM, cpu);
 
 	pr_err("\t         hardirqs   softirqs   csw/system\n");
 	pr_err("\t number: %8lld %10d %12lld\n",
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 4f97896887ec..5dcb0f2e01bc 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -961,10 +961,9 @@ static int kcpustat_field_vtime(u64 *cpustat,
 	return 0;
 }
 
-u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-		   enum cpu_usage_stat usage, int cpu)
+u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 {
-	u64 *cpustat = kcpustat->cpustat;
+	u64 *cpustat = kcpustat_cpu(cpu).cpustat;
 	u64 val = cpustat[usage];
 	struct rq *rq;
 	int err;
-- 
2.51.1


