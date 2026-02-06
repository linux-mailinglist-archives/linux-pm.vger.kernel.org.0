Return-Path: <linux-pm+bounces-42211-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OlADef5hWmKIwQAu9opvQ
	(envelope-from <linux-pm+bounces-42211-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:25:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF163FEDEC
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7EE30238FC
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F6E3EFD04;
	Fri,  6 Feb 2026 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqKfkvWI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E412212542;
	Fri,  6 Feb 2026 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387801; cv=none; b=nouReTpBo2z779ZBZomihMEC/mqNHWWAx95wFmuW9P8XIpflJ8DKTp3eCUyx0a7zKSMriACkRrON/Jpnupr/ez0Ux/NqdG25YPoW5xoSPVu/kGoXdl4H9MnQ0u0PyQnOEo9uzBq0xJBKfJF1FYMkwJ3ai8JDF3zyjbXIYoad2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387801; c=relaxed/simple;
	bh=qfdvJvQBGQZlUpvIquFdfzN94e1PNCF4663MJivSVPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo39hRiRHTrmjlmvFSzVmh92dEnA9xLLBtim8C8QSpK8lELlyHsrY1dmO/f0TbGxOWfd894ptzF1lJo6UCeELuWRKKdsg+zIxyfLq/SxmKiZAKgCDgevGiLkPj8jK9Roh4bx2x2SVfEncwENNR4CtaMuG5Ot+CJQsfDTbn/841w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqKfkvWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591C7C19421;
	Fri,  6 Feb 2026 14:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387800;
	bh=qfdvJvQBGQZlUpvIquFdfzN94e1PNCF4663MJivSVPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqKfkvWIMKXMf0cmdOvt2Y10zm2nPU6tJSh5T6lbhjlSIW+OOuxr7rUhCcemxU0X8
	 V6fhXfiKi4KkXNj6wWqqOttvsoIh3wfATrAYXH2IJmXf8fuNQYHqUgGDrUGzx3/83Z
	 3Z48d8HPnEykVqhoj8FWVRuKEMqRnEIqzJ7bQQqzfd2yVDKWGUV2utENJq1VKVphxm
	 pNfksmCGAEhEBqZPnlOhgu66iHn+zFTuP1wVNuCdb0X15WfEO30qGMC9VmiMxs3Kly
	 wjtB/M13j+cX7HCX5MWqiT9ynyCP7VU+0MKdGBpSu65QwaPFBV/gs7hkFpMa6dehle
	 7idBsyhkmkOJg==
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
Subject: [PATCH 03/15] sched/cputime: Correctly support generic vtime idle time
Date: Fri,  6 Feb 2026 15:22:33 +0100
Message-ID: <20260206142245.58987-4-frederic@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-42211-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: AF163FEDEC
X-Rspamd-Action: no action

Currently whether generic vtime is running or not, the idle cputime is
fetched from the nohz accounting.

However generic vtime already does its own idle cputime accounting. Only
the kernel stat accessors are not plugged to support it.

Read the idle generic vtime cputime when it's running, this will allow
to later more clearly split nohz and vtime cputime accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/vtime.h    |  9 +++++++--
 kernel/sched/cputime.c   | 38 +++++++++++++++++++++++++++++---------
 kernel/time/tick-sched.c | 12 +++++++++---
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 29dd5b91dd7d..336875bea767 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -10,7 +10,6 @@
  */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 extern void vtime_account_kernel(struct task_struct *tsk);
-extern void vtime_account_idle(struct task_struct *tsk);
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
@@ -27,7 +26,13 @@ static inline void vtime_guest_exit(struct task_struct *tsk) { }
 static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
+static inline bool vtime_generic_enabled_cpu(int cpu)
+{
+	return context_tracking_enabled_cpu(cpu);
+}
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+extern void vtime_account_idle(struct task_struct *tsk);
 extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
@@ -74,7 +79,7 @@ static inline bool vtime_accounting_enabled(void)
 
 static inline bool vtime_accounting_enabled_cpu(int cpu)
 {
-	return context_tracking_enabled_cpu(cpu);
+	return vtime_generic_enabled_cpu(cpu);
 }
 
 static inline bool vtime_accounting_enabled_this_cpu(void)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5dcb0f2e01bc..5613838d0307 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -759,9 +759,9 @@ void vtime_guest_exit(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(vtime_guest_exit);
 
-void vtime_account_idle(struct task_struct *tsk)
+static void __vtime_account_idle(struct vtime *vtime)
 {
-	account_idle_time(get_vtime_delta(&tsk->vtime));
+	account_idle_time(get_vtime_delta(vtime));
 }
 
 void vtime_task_switch_generic(struct task_struct *prev)
@@ -770,7 +770,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 
 	write_seqcount_begin(&vtime->seqcount);
 	if (vtime->state == VTIME_IDLE)
-		vtime_account_idle(prev);
+		__vtime_account_idle(vtime);
 	else
 		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
@@ -912,6 +912,7 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				int cpu, u64 *val)
 {
 	struct vtime *vtime = &tsk->vtime;
+	struct rq *rq = cpu_rq(cpu);
 	unsigned int seq;
 
 	do {
@@ -953,6 +954,14 @@ static int kcpustat_field_vtime(u64 *cpustat,
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
@@ -1015,8 +1024,8 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		*dst = *src;
 		cpustat = dst->cpustat;
 
-		/* Task is sleeping, dead or idle, nothing to add */
-		if (state < VTIME_SYS)
+		/* Task is sleeping or dead, nothing to add */
+		if (state < VTIME_IDLE)
 			continue;
 
 		delta = vtime_delta(vtime);
@@ -1025,15 +1034,17 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
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
@@ -1041,6 +1052,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
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
index 8ddf74e705d3..9632066aea4d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -774,9 +774,10 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 	sched_clock_idle_sleep_event();
 }
 
-static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
+static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx, ktime_t *sleeptime,
 				 bool compute_delta, u64 *last_update_time)
 {
+	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t now, idle;
 	unsigned int seq;
 
@@ -787,6 +788,11 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
 	if (last_update_time)
 		*last_update_time = ktime_to_us(now);
 
+	if (vtime_generic_enabled_cpu(cpu)) {
+		idle = kcpustat_field(idx, cpu);
+		return ktime_to_us(idle);
+	}
+
 	do {
 		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
 
@@ -824,7 +830,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
-	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE, &ts->idle_sleeptime,
 				     !nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
@@ -850,7 +856,7 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
-	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT, &ts->iowait_sleeptime,
 				     nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
-- 
2.51.1


