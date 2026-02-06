Return-Path: <linux-pm+bounces-42217-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H8sNtL6hWmjIwQAu9opvQ
	(envelope-from <linux-pm+bounces-42217-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:29:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C85FEEF7
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487FE304AAD4
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE93F0744;
	Fri,  6 Feb 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ3eKQ+3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02813EF0A4;
	Fri,  6 Feb 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387849; cv=none; b=uqcXKNoAfjdWBs3ulDOYzZ7iRzleTBL5beJFr+7wJ9+CMpMAra/IBUdtmVctGcAnxnNvzQbRQfULGUn3OH/P9ojzJmuU7yqk/2IJ/Eh7JfIhg6ObNEI0IqqaOa4nNBRZXkhlIOduxW+4oSJM4/QX3bqIB5JXeeLlj9LMM7PQbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387849; c=relaxed/simple;
	bh=Zut58oWwnAdSAa/LElaysKfGWrc+d2Pi1wvax1K4ey4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBuNYTaePDQRt/S7ks3AymILzFxvtxoUuxLHd2S1ruMFLCjjGgZkAenXnvHKvZvZvSZWHpUv4MpIL7BGRuOBs2JnqmvOjtjXVBWByCihHrP9hRXpJpEIueluS/MEzvKBv/o64L7zKVHZpDDhZRjOMeWPEneG0AVdIZQr0o0QAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ3eKQ+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9207C116C6;
	Fri,  6 Feb 2026 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387849;
	bh=Zut58oWwnAdSAa/LElaysKfGWrc+d2Pi1wvax1K4ey4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZ3eKQ+3XefXB2htQQ0iVuhOST4+54PDYJpfCvGoyyq5B3LlcDa4KaugtG96dNXSP
	 wHL2s6yqK44c5buBck5RKPK7ziHGVaoMSn/KD0Blxo9osLaexiinxGjQJq6G+yniZd
	 H1CRhuDQ3XoGM/kST+ZqrKsEDagIcL9+7qE6TUa+krwM0oHhekBA6S5EPL0M3TDwZg
	 5016h3t6IhYDY4weyAyBkF1NeYUVkGN1+Dnm8QfGI+dVQN2qQkL77JwjJeHWtC6xWH
	 XyTQTPhLN4nhg+2IEjIKdv7f5lKW3x7D7qI1vmWsB9tgwYzvaXyjfcGa12kt5xoDd4
	 HZb2e58GATc5w==
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
	linuxppc-dev@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH 09/15] tick/sched: Move dyntick-idle cputime accounting to cputime code
Date: Fri,  6 Feb 2026 15:22:39 +0100
Message-ID: <20260206142245.58987-10-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260206142245.58987-1-frederic@kernel.org>
References: <20260206142245.58987-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_FROM(0.00)[bounces-42217-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72C85FEEF7
X-Rspamd-Action: no action

Although the dynticks-idle cputime accounting is necessarily tied to
the tick subsystem, the actual related accounting code has no business
residing there and should be part of the scheduler cputime code.

Move away the relevant pieces and state machine to where they belong.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kernel_stat.h |  14 +++-
 kernel/sched/cputime.c      | 149 +++++++++++++++++++++++++++++++--
 kernel/time/tick-sched.c    | 162 +++++++-----------------------------
 3 files changed, 184 insertions(+), 141 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index ba65aad308a1..9343353ac7a3 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -35,9 +35,12 @@ enum cpu_usage_stat {
 
 struct kernel_cpustat {
 #ifdef CONFIG_NO_HZ_COMMON
-	int idle_dyntick;
+	bool		idle_dyntick;
+	bool		idle_elapse;
+	seqcount_t	idle_sleeptime_seq;
+	u64		idle_entrytime;
 #endif
-	u64 cpustat[NR_STATS];
+	u64		cpustat[NR_STATS];
 };
 
 struct kernel_stat {
@@ -103,8 +106,11 @@ static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
-extern void kcpustat_dyntick_start(void);
-extern void kcpustat_dyntick_stop(void);
+extern void kcpustat_dyntick_start(u64 now);
+extern void kcpustat_dyntick_stop(u64 now);
+extern void kcpustat_irq_enter(u64 now);
+extern void kcpustat_irq_exit(u64 now);
+
 static inline bool kcpustat_idle_dyntick(void)
 {
 	return __this_cpu_read(kernel_cpustat.idle_dyntick);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d67f93e845a7..d2cad4d8dc10 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,6 +2,7 @@
 /*
  * Simple CPU accounting cgroup controller
  */
+#include <linux/sched/clock.h>
 #include <linux/sched/cputime.h>
 #include <linux/tsacct_kern.h>
 #include "sched.h"
@@ -406,22 +407,156 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 #endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_NO_HZ_COMMON
-void kcpustat_dyntick_start(void)
+static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
-	if (!vtime_generic_enabled_this_cpu()) {
-		vtime_dyntick_start();
-		__this_cpu_write(kernel_cpustat.idle_dyntick, 1);
-	}
+	u64 *cpustat = kc->cpustat;
+	u64 delta;
+
+	if (!kc->idle_elapse)
+		return;
+
+	delta = now - kc->idle_entrytime;
+
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	if (nr_iowait_cpu(smp_processor_id()) > 0)
+		cpustat[CPUTIME_IOWAIT] += delta;
+	else
+		cpustat[CPUTIME_IDLE] += delta;
+
+	kc->idle_entrytime = now;
+	kc->idle_elapse = false;
+	write_seqcount_end(&kc->idle_sleeptime_seq);
 }
 
-void kcpustat_dyntick_stop(void)
+static void kcpustat_idle_start(struct kernel_cpustat *kc, u64 now)
 {
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	kc->idle_entrytime = now;
+	kc->idle_elapse = true;
+	write_seqcount_end(&kc->idle_sleeptime_seq);
+}
+
+void kcpustat_dyntick_stop(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
 	if (!vtime_generic_enabled_this_cpu()) {
-		__this_cpu_write(kernel_cpustat.idle_dyntick, 0);
+		WARN_ON_ONCE(!kc->idle_dyntick);
+		kcpustat_idle_stop(kc, now);
+		kc->idle_dyntick = false;
 		vtime_dyntick_stop();
 		steal_account_process_time(ULONG_MAX);
 	}
 }
+
+void kcpustat_dyntick_start(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu()) {
+		vtime_dyntick_start();
+		kc->idle_dyntick = true;
+		kcpustat_idle_start(kc, now);
+	}
+}
+
+void kcpustat_irq_enter(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu())
+		kcpustat_idle_stop(kc, now);
+}
+
+void kcpustat_irq_exit(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu())
+		kcpustat_idle_start(kc, now);
+}
+
+static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
+				 bool compute_delta, u64 *last_update_time)
+{
+	struct kernel_cpustat *kc = &kcpustat_cpu(cpu);
+	u64 *cpustat = kc->cpustat;
+	unsigned int seq;
+	ktime_t now;
+	u64 idle;
+
+	now = ktime_get();
+	if (last_update_time)
+		*last_update_time = ktime_to_us(now);
+
+	if (vtime_generic_enabled_cpu(cpu)) {
+		idle = kcpustat_field(idx, cpu);
+		goto to_us;
+	}
+
+	do {
+		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
+
+		if (kc->idle_elapse && compute_delta)
+			idle = cpustat[idx] + (now - kc->idle_entrytime);
+		else
+			idle = cpustat[idx];
+	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
+
+to_us:
+	do_div(idle, NSEC_PER_USEC);
+
+	return idle;
+}
+
+/**
+ * get_cpu_idle_time_us - get the total idle time of a CPU
+ * @cpu: CPU number to query
+ * @last_update_time: variable to store update time in. Do not update
+ * counters if NULL.
+ *
+ * Return the cumulative idle time (since boot) for a given
+ * CPU, in microseconds. Note that this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
+ */
+u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
+{
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
+				     !nr_iowait_cpu(cpu), last_update_time);
+}
+EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
+
+/**
+ * get_cpu_iowait_time_us - get the total iowait time of a CPU
+ * @cpu: CPU number to query
+ * @last_update_time: variable to store update time in. Do not update
+ * counters if NULL.
+ *
+ * Return the cumulative iowait time (since boot) for a given
+ * CPU, in microseconds. Note this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
+ */
+u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
+{
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
+				     nr_iowait_cpu(cpu), last_update_time);
+}
+EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
+
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2b58cdc326c3..aa36c8d218e2 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -746,125 +746,6 @@ static void tick_nohz_update_jiffies(ktime_t now)
 	touch_softlockup_watchdog_sched();
 }
 
-static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
-{
-	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	ktime_t delta;
-
-	if (vtime_generic_enabled_this_cpu())
-		return;
-
-	if (WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)))
-		return;
-
-	delta = ktime_sub(now, ts->idle_entrytime);
-
-	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	if (nr_iowait_cpu(smp_processor_id()) > 0)
-		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
-	else
-		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
-
-	ts->idle_entrytime = now;
-	tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
-	write_seqcount_end(&ts->idle_sleeptime_seq);
-
-	sched_clock_idle_wakeup_event();
-}
-
-static void tick_nohz_start_idle(struct tick_sched *ts)
-{
-	if (vtime_generic_enabled_this_cpu())
-		return;
-
-	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	ts->idle_entrytime = ktime_get();
-	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
-	write_seqcount_end(&ts->idle_sleeptime_seq);
-	sched_clock_idle_sleep_event();
-}
-
-static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
-				 bool compute_delta, u64 *last_update_time)
-{
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
-	u64 *cpustat = kcpustat_cpu(cpu).cpustat;
-	ktime_t now, idle;
-	unsigned int seq;
-
-	now = ktime_get();
-	if (last_update_time)
-		*last_update_time = ktime_to_us(now);
-
-	if (vtime_generic_enabled_cpu(cpu)) {
-		idle = kcpustat_field(idx, cpu);
-		return ktime_to_us(idle);
-	}
-
-	do {
-		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
-
-		if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE) && compute_delta) {
-			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
-
-			idle = ktime_add(cpustat[idx], delta);
-		} else {
-			idle = cpustat[idx];
-		}
-	} while (read_seqcount_retry(&ts->idle_sleeptime_seq, seq));
-
-	return ktime_to_us(idle);
-
-}
-
-/**
- * get_cpu_idle_time_us - get the total idle time of a CPU
- * @cpu: CPU number to query
- * @last_update_time: variable to store update time in. Do not update
- * counters if NULL.
- *
- * Return the cumulative idle time (since boot) for a given
- * CPU, in microseconds. Note that this is partially broken due to
- * the counter of iowait tasks that can be remotely updated without
- * any synchronization. Therefore it is possible to observe backward
- * values within two consecutive reads.
- *
- * This time is measured via accounting rather than sampling,
- * and is as accurate as ktime_get() is.
- *
- * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
- */
-u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
-{
-	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
-				     !nr_iowait_cpu(cpu), last_update_time);
-}
-EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
-
-/**
- * get_cpu_iowait_time_us - get the total iowait time of a CPU
- * @cpu: CPU number to query
- * @last_update_time: variable to store update time in. Do not update
- * counters if NULL.
- *
- * Return the cumulative iowait time (since boot) for a given
- * CPU, in microseconds. Note this is partially broken due to
- * the counter of iowait tasks that can be remotely updated without
- * any synchronization. Therefore it is possible to observe backward
- * values within two consecutive reads.
- *
- * This time is measured via accounting rather than sampling,
- * and is as accurate as ktime_get() is.
- *
- * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
- */
-u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
-{
-	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
-				     nr_iowait_cpu(cpu), last_update_time);
-}
-EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
-
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
 	hrtimer_cancel(&ts->sched_timer);
@@ -1272,6 +1153,20 @@ void tick_nohz_idle_retain_tick(void)
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
 }
 
+static void tick_nohz_clock_sleep(struct tick_sched *ts)
+{
+	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
+	sched_clock_idle_sleep_event();
+}
+
+static void tick_nohz_clock_wakeup(struct tick_sched *ts)
+{
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
+		tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
+		sched_clock_idle_wakeup_event();
+	}
+}
+
 /**
  * tick_nohz_idle_enter - prepare for entering idle on the current CPU
  *
@@ -1286,12 +1181,11 @@ void tick_nohz_idle_enter(void)
 	local_irq_disable();
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
-
 	WARN_ON_ONCE(ts->timer_expires_base);
-
 	tick_sched_flag_set(ts, TS_FLAG_INIDLE);
-	kcpustat_dyntick_start();
-	tick_nohz_start_idle(ts);
+	ts->idle_entrytime = ktime_get();
+	kcpustat_dyntick_start(ts->idle_entrytime);
+	tick_nohz_clock_sleep(ts);
 
 	local_irq_enable();
 }
@@ -1319,10 +1213,13 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
-		tick_nohz_start_idle(ts);
-	else
+	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE)) {
+		ts->idle_entrytime = ktime_get();
+		kcpustat_irq_exit(ts->idle_entrytime);
+		tick_nohz_clock_sleep(ts);
+	} else {
 		tick_nohz_full_update_tick(ts);
+	}
 }
 
 /**
@@ -1467,11 +1364,11 @@ void tick_nohz_idle_exit(void)
 		now = ktime_get();
 
 	if (idle_active)
-		tick_nohz_stop_idle(ts, now);
+		tick_nohz_clock_wakeup(ts);
 
 	if (tick_stopped)
 		tick_nohz_idle_update_tick(ts, now);
-	kcpustat_dyntick_stop();
+	kcpustat_dyntick_stop(now);
 
 	local_irq_enable();
 }
@@ -1527,9 +1424,14 @@ static inline void tick_nohz_irq_enter(void)
 
 	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
 		return;
+
 	now = ktime_get();
-	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE))
-		tick_nohz_stop_idle(ts, now);
+
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
+		tick_nohz_clock_wakeup(ts);
+		kcpustat_irq_enter(now);
+	}
+
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
 	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
-- 
2.51.1


