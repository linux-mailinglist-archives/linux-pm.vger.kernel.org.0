Return-Path: <linux-pm+bounces-42215-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIDODd/5hWl7IwQAu9opvQ
	(envelope-from <linux-pm+bounces-42215-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:25:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFABFEDDC
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E7B1305B580
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449B3F23A2;
	Fri,  6 Feb 2026 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFmGLTxE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E33F0763;
	Fri,  6 Feb 2026 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387833; cv=none; b=QxagZzRDte+WT3A2AX+Jmi4e9pvGemoCnGOzQOCWuCQEEKOSg4lvPOZA2VRISzeDXXyZU/zxdcItO4rJOGNPmi5qMPOudoSaZ811yr1PGc124c4+8xGz0Q4UypB89uvHV7hjL3iaq82tzn0LEQg8YtbU6PwoMWEhHNr6HJRsmfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387833; c=relaxed/simple;
	bh=E9zTeO5x+KjyNgewXK9Mi3ZXHv+NiD0HDMZoN+zshlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFV+moBnlBrwy60AFYGuyuNJ7irhfnjYso1cPH9GWQCibsxTEqJbQDKERgljWikPA9nGq0ru/mqOG6DrV1BY0OgqCjTtIvac9RJoBaH1tLdoj0B15TCkLUriu37X9WxKPnhxMXkf84MtCtm1KzEyZ72eizcvxI2Kbw8R7bb45QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFmGLTxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AE5C116C6;
	Fri,  6 Feb 2026 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387833;
	bh=E9zTeO5x+KjyNgewXK9Mi3ZXHv+NiD0HDMZoN+zshlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFmGLTxEaIrIJJzRiPyrmfO9obNPSzQIgdiRScbMZu6qmx1Q6FtQ3R9Aw+6E8sRP1
	 3HtC8F8wo9w5y4hyRZiXDWe6Yoq2bgTp2n8jPUF3eJ6HQBvK+/pJ9k1rbP08KaVmzm
	 ZlV4GHCqJz3b4bCL4bpJyQm/uQ7FP1PYUfH4bOW6rvOZ1dWtTlSgNXYl+BX1RnSr67
	 yzI4+xZbT6c/vJnJYNf9zWE2vAXmLgUjA2AWtc/XVqEC4McNjBgteT+FxFDp9kUWts
	 KcmTfBVhmkCrD0QQgxfkHNsLefiRvPn55fMJFTNwmnJgP5m43MOuO0Hw8OxB1AGwKO
	 cytjZ4krynFmA==
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
Subject: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime granularity test
Date: Fri,  6 Feb 2026 15:22:37 +0100
Message-ID: <20260206142245.58987-8-frederic@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_FROM(0.00)[bounces-42215-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AAFABFEDDC
X-Rspamd-Action: no action

cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
accounting has a nanoseconds granularity.

Use the appropriate indicator instead to make that deduction.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 7 +------
 include/linux/tick.h               | 2 ++
 kernel/time/hrtimer.c              | 2 +-
 kernel/time/tick-internal.h        | 2 --
 kernel/time/tick-sched.c           | 8 +++++++-
 kernel/time/timer.c                | 2 +-
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a6ecc203f7b7..bb7db82930e4 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -334,17 +334,12 @@ static void od_free(struct policy_dbs_info *policy_dbs)
 static int od_init(struct dbs_data *dbs_data)
 {
 	struct od_dbs_tuners *tuners;
-	u64 idle_time;
-	int cpu;
 
 	tuners = kzalloc(sizeof(*tuners), GFP_KERNEL);
 	if (!tuners)
 		return -ENOMEM;
 
-	cpu = get_cpu();
-	idle_time = get_cpu_idle_time_us(cpu, NULL);
-	put_cpu();
-	if (idle_time != -1ULL) {
+	if (tick_nohz_is_active()) {
 		/* Idle micro accounting is supported. Use finer thresholds */
 		dbs_data->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
 	} else {
diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa36d..738007d6f577 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -126,6 +126,7 @@ enum tick_dep_bits {
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
+extern bool tick_nohz_is_active(void);
 extern bool tick_nohz_tick_stopped(void);
 extern bool tick_nohz_tick_stopped_cpu(int cpu);
 extern void tick_nohz_idle_stop_tick(void);
@@ -142,6 +143,7 @@ extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
+static inline bool tick_nohz_is_active(void) { return false; }
 static inline int tick_nohz_tick_stopped(void) { return 0; }
 static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
 static inline void tick_nohz_idle_stop_tick(void) { }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index f8ea8c8fc895..e1bbf883dfa8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -943,7 +943,7 @@ void clock_was_set(unsigned int bases)
 	cpumask_var_t mask;
 	int cpu;
 
-	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_active)
+	if (!hrtimer_hres_active(cpu_base) && !tick_nohz_is_active())
 		goto out_timerfd;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 4e4f7bbe2a64..597d816d22e8 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -156,7 +156,6 @@ static inline void tick_nohz_init(void) { }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
-extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
 extern u64 get_jiffies_update(unsigned long *basej);
 # ifdef CONFIG_SMP
@@ -171,7 +170,6 @@ extern void timer_expire_remote(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
-#define tick_nohz_active (0)
 #endif
 
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 21ac561a8545..81c619bf662c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -691,7 +691,7 @@ void __init tick_nohz_init(void)
  * NO HZ enabled ?
  */
 bool tick_nohz_enabled __read_mostly  = true;
-unsigned long tick_nohz_active  __read_mostly;
+static unsigned long tick_nohz_active  __read_mostly;
 /*
  * Enable / Disable tickless mode
  */
@@ -702,6 +702,12 @@ static int __init setup_tick_nohz(char *str)
 
 __setup("nohz=", setup_tick_nohz);
 
+bool tick_nohz_is_active(void)
+{
+	return tick_nohz_active;
+}
+EXPORT_SYMBOL_GPL(tick_nohz_is_active);
+
 bool tick_nohz_tick_stopped(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1f2364126894..7e1e3bde6b8b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -281,7 +281,7 @@ DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
 
 static void timers_update_migration(void)
 {
-	if (sysctl_timer_migration && tick_nohz_active)
+	if (sysctl_timer_migration && tick_nohz_is_active())
 		static_branch_enable(&timers_migration_enabled);
 	else
 		static_branch_disable(&timers_migration_enabled);
-- 
2.51.1


