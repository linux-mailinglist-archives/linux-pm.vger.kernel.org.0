Return-Path: <linux-pm+bounces-41023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D1D330DE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A84430B588F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE6739449B;
	Fri, 16 Jan 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcKqW+8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51D394493;
	Fri, 16 Jan 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575243; cv=none; b=e2RorPuM4sCBOAc9KIlw8rMmoe6lieWgX640wm0w6kv0pj9ulnUsY6uQVpnWY3rjy7YYhnFIScbGz7MCpZST9CIQCByoN0OBcDnVVcHJF+P7T+niybFnTRX1cuRkyHt73UKtkAPa/sQiPYirXBeLnjKKe15Ijf8FPqfBZdT4PiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575243; c=relaxed/simple;
	bh=mk05EtvK6jmV7aIMR9OssU/GyByeNnVfxkVqMJUomLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdIBfTPNhyavZfVtjBw+z7R0MkELpApEiN2JdGxuJgzI/U8+79RaiqaDOoNm4uftAfjCsfGUoABojmyvcWZ+X8n0hsDpbkpApnbuxg8mVkMhDmPhDPsd95JxrhwZ+xDWi2AOiwg20wqXbC18DLeTDNGmsAm47LIsz+7Jd2bn38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcKqW+8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67EAC16AAE;
	Fri, 16 Jan 2026 14:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575242;
	bh=mk05EtvK6jmV7aIMR9OssU/GyByeNnVfxkVqMJUomLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcKqW+8YV5y1IBAUOSldpi6lBEuvnxsszdxaFzWfPn7SddeH5Def9WFC2Py2Rf3s1
	 kqIvancp1XfneOrmmW7MKk5yddG/PHjbkzUFSorJymu0aooz5hahZ1Lh0+T6opdkOE
	 fJfDF5W5QOx+FeE7+vrYNsd3pwntG6OxOiuiLUZ5aXcRrjlaLw3h0n9HQaRPsIFyAy
	 ZStxpfLCZ61SMsXAucgtCaUGybpk84IKlSdjQeYajSIeOCaD6y1U0Bt/xDBqdj687t
	 DS12t/MQtuMmnyzcmHSN6oYAiLgwKh3WvZLzWugRIROVvRXaE3Cs/JV4cuHcNtZK/R
	 uvWyiDRhINhcg==
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
Subject: [PATCH 14/15] sched/cputime: Handle idle irqtime gracefully
Date: Fri, 16 Jan 2026 15:52:07 +0100
Message-ID: <20260116145208.87445-15-frederic@kernel.org>
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

The dyntick-idle cputime accounting always assumes that IRQ time
accounting is enabled and consequently stops elapsing the idle time
during dyntick-idle IRQs.

This doesn't mix up well with disabled IRQ time accounting because then
idle IRQs become a cputime blind-spot. Also this feature is disabled
on most configurations and the overhead of pausing dyntick-idle
accounting while in idle IRQs could then be avoided.

Fix the situation with conditionally pausing dyntick-idle accounting
during idle IRQs only if neither native vtime (which does IRQ time
accounting) nor generic IRQ time accounting are enabled.

Also make sure that the accumulated IRQ time is not accidentally
substracted from later accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/cputime.c | 24 +++++++++++++++++++++---
 kernel/sched/sched.h   |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index f0620b429698..3dadfaa92b27 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -45,7 +45,8 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	u64_stats_update_begin(&irqtime->sync);
 	cpustat[idx] += delta;
 	irqtime->total += delta;
-	irqtime->tick_delta += delta;
+	if (!irqtime->idle_dyntick)
+		irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
 }
 
@@ -80,6 +81,16 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
+static inline void irqtime_dyntick_start(void)
+{
+	__this_cpu_write(cpu_irqtime.idle_dyntick, true);
+}
+
+static inline void irqtime_dyntick_stop(void)
+{
+	__this_cpu_write(cpu_irqtime.idle_dyntick, false);
+}
+
 static u64 irqtime_tick_accounted(u64 maxtime)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
@@ -93,6 +104,9 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 
 #else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
 
+static inline void irqtime_dyntick_start(void) { }
+static inline void irqtime_dyntick_stop(void) { }
+
 static u64 irqtime_tick_accounted(u64 dummy)
 {
 	return 0;
@@ -443,6 +457,7 @@ void kcpustat_dyntick_stop(ktime_t now)
 		WARN_ON_ONCE(!kc->idle_dyntick);
 		kcpustat_idle_stop(kc, now);
 		kc->idle_dyntick = false;
+		irqtime_dyntick_stop();
 		vtime_dyntick_stop();
 		steal_account_process_time(ULONG_MAX);
 	}
@@ -454,6 +469,7 @@ void kcpustat_dyntick_start(ktime_t now)
 
 	if (!vtime_generic_enabled_this_cpu()) {
 		vtime_dyntick_start();
+		irqtime_dyntick_start();
 		kc->idle_dyntick = true;
 		kcpustat_idle_start(kc, now);
 	}
@@ -463,7 +479,8 @@ void kcpustat_irq_enter(ktime_t now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_stop(kc, now);
 }
 
@@ -471,7 +488,8 @@ void kcpustat_irq_exit(ktime_t now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_start(kc, now);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6870f5..cf677ff12b10 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3307,6 +3307,7 @@ static inline void sched_core_tick(struct rq *rq) { }
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 struct irqtime {
+	bool			idle_dyntick;
 	u64			total;
 	u64			tick_delta;
 	u64			irq_start_time;
-- 
2.51.1


