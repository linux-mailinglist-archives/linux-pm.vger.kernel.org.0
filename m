Return-Path: <linux-pm+bounces-42213-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCjiLJn5hWlEIwQAu9opvQ
	(envelope-from <linux-pm+bounces-42213-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:24:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE33FED5B
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FC0A301751D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A73EFD32;
	Fri,  6 Feb 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU84qQiq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CE3EF0A4;
	Fri,  6 Feb 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387816; cv=none; b=f7eX+vgGLKxuVjIQ7odAgmnHXp0hhDUjERzl2p15kJN+Az1WBDtYRnGZO9paHsDGLafzIjYzQCNTAO5PDrMpve4F4jlg+F24Ji0iCEUZHWJSSjAwV8wx48PiGzFFNrGGUh9WoCDSJGbwYi7EIgtTbeCssOm24f/J4HkxzV9S+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387816; c=relaxed/simple;
	bh=DaRfqtPxemmkp+aTTTQoiIZqc3SEzpEw+S8gq3cyoPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbuDHij1Sn1FA8lQ8FQNcyHxe1abnePMkhueH8jn3RWTMpuEuo/eYaLLj5O8bTmAtBn/E8+GLAnePZyKUEpCAUnqCUAX4X8WGSTJ4UbmOBp/7YHplnN4jH+QQyU5kl2K6SmfYzXaFguDjuAsrlz6VnYH8ZPMiyosmr9iTUeigFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU84qQiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223F1C19421;
	Fri,  6 Feb 2026 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387816;
	bh=DaRfqtPxemmkp+aTTTQoiIZqc3SEzpEw+S8gq3cyoPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BU84qQiqPenzVeN7b6iVXZU3Aq98TI8RnVWp5ThVnZaQ61YRQiT8g8RJ4n31aWvM+
	 Bc8FPIVGx6kobB/Pk0WfSAe1Q7nrqN3RQ2LAeyq3lQJyFcTZVmJaB8Dkd4LJpIa0cb
	 F6F5ZKuxGoI8CQ7TisaeuHWEm46TNDEGIRT6xlIGKC63IuNB282k3riJV1x8sy8HsH
	 dNuPM3JGMwVOfV3JK8DMe7cYWVli/dyd2Fdo5kUBNs3VoO/CrsP/Y2zKlpbxEq11o1
	 r2W+zflG36srXMqKgrj9zAMyOgMwEEFX0e0e/CiLQdsskyHwQsb2+jC82mVhAVo5pF
	 dfIwwG2nb3dNw==
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
Subject: [PATCH 05/15] s390/time: Prepare to stop elapsing in dynticks-idle
Date: Fri,  6 Feb 2026 15:22:35 +0100
Message-ID: <20260206142245.58987-6-frederic@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_FROM(0.00)[bounces-42213-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CE33FED5B
X-Rspamd-Action: no action

Currently the tick subsystem stores the idle cputime accounting in
private fields, allowing cohabitation with architecture idle vtime
accounting. The former is fetched on online CPUs, the latter on offline
CPUs.

For consolidation purpose, architecture vtime accounting will continue
to account the cputime but will make a break when the idle tick is
stopped. The dyntick cputime accounting will then be relayed by the tick
subsystem so that the idle cputime is still seen advancing coherently
even when the tick isn't there to flush the idle vtime.

Prepare for that and introduce three new APIs which will be used in
subsequent patches:

_ vtime_dynticks_start() is deemed to be called when idle enters in
  dyntick mode. The idle cputime that elapsed so far is accumulated
  and accounted. Also idle time accounting is ignored.

- vtime_dynticks_stop() is deemed to be called when idle exits from
  dyntick mode. The vtime entry clocks are fast-forward to current time
  so that idle accounting restarts elapsing from now. Also idle time
  accounting is resumed.

- vtime_reset() is deemed to be called from dynticks idle IRQ entry to
  fast-forward the clock to current time so that the IRQ time is still
  accounted by vtime while nohz cputime is paused.

Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
accounting twice the idle cputime, along with nohz accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/s390/include/asm/idle.h | 14 +++++---
 arch/s390/kernel/idle.c      | 19 +++++++----
 arch/s390/kernel/vtime.c     | 65 ++++++++++++++++++++++++++++++------
 3 files changed, 77 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 09f763b9eb40..285b3da318d6 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -8,17 +8,21 @@
 #ifndef _S390_IDLE_H
 #define _S390_IDLE_H
 
+#include <linux/percpu-defs.h>
 #include <linux/types.h>
 #include <linux/device.h>
 
 struct s390_idle_data {
-	unsigned long idle_count;
-	unsigned long idle_time;
-	unsigned long clock_idle_enter;
-	unsigned long timer_idle_enter;
-	unsigned long mt_cycles_enter[8];
+	bool		idle_dyntick;
+	unsigned long	idle_count;
+	unsigned long	idle_time;
+	unsigned long	clock_idle_enter;
+	unsigned long	timer_idle_enter;
+	unsigned long	mt_cycles_enter[8];
 };
 
+DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
+
 extern struct device_attribute dev_attr_idle_count;
 extern struct device_attribute dev_attr_idle_time_us;
 
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 39cb8d0ae348..614db5ea6ea3 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -19,7 +19,7 @@
 #include <asm/smp.h>
 #include "entry.h"
 
-static DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
+DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 
 void account_idle_time_irq(void)
 {
@@ -35,7 +35,15 @@ void account_idle_time_irq(void)
 			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
 	}
 
+	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
+
+	/* Account time spent with enabled wait psw loaded as idle time. */
 	idle_time = lc->int_clock - idle->clock_idle_enter;
+	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
+
+	/* Dyntick idle time accounted by nohz/scheduler */
+	if (idle->idle_dyntick)
+		return;
 
 	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
 	lc->last_update_clock = lc->int_clock;
@@ -43,9 +51,6 @@ void account_idle_time_irq(void)
 	lc->system_timer += lc->last_update_timer - idle->timer_idle_enter;
 	lc->last_update_timer = lc->sys_enter_timer;
 
-	/* Account time spent with enabled wait psw loaded as idle time. */
-	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
-	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
 	account_idle_time(cputime_to_nsecs(idle_time));
 }
 
@@ -61,8 +66,10 @@ void noinstr arch_cpu_idle(void)
 	set_cpu_flag(CIF_ENABLED_WAIT);
 	if (smp_cpu_mtid)
 		stcctm(MT_DIAG, smp_cpu_mtid, (u64 *)&idle->mt_cycles_enter);
-	idle->clock_idle_enter = get_tod_clock_fast();
-	idle->timer_idle_enter = get_cpu_timer();
+	if (!idle->idle_dyntick) {
+		idle->clock_idle_enter = get_tod_clock_fast();
+		idle->timer_idle_enter = get_cpu_timer();
+	}
 	bpon();
 	__load_psw_mask(psw_mask);
 }
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 234a0ba30510..c19528eb4ee3 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -17,6 +17,7 @@
 #include <asm/vtimer.h>
 #include <asm/vtime.h>
 #include <asm/cpu_mf.h>
+#include <asm/idle.h>
 #include <asm/smp.h>
 
 #include "entry.h"
@@ -111,23 +112,30 @@ static void account_system_index_scaled(struct task_struct *p, u64 cputime,
 	account_system_index_time(p, cputime_to_nsecs(cputime), index);
 }
 
-/*
- * Update process times based on virtual cpu times stored by entry.S
- * to the lowcore fields user_timer, system_timer & steal_clock.
- */
-static int do_account_vtime(struct task_struct *tsk)
+static inline void vtime_reset_last_update(struct lowcore *lc)
 {
-	u64 timer, clock, user, guest, system, hardirq, softirq;
-	struct lowcore *lc = get_lowcore();
-
-	timer = lc->last_update_timer;
-	clock = lc->last_update_clock;
 	asm volatile(
 		"	stpt	%0\n"	/* Store current cpu timer value */
 		"	stckf	%1"	/* Store current tod clock value */
 		: "=Q" (lc->last_update_timer),
 		  "=Q" (lc->last_update_clock)
 		: : "cc");
+}
+
+/*
+ * Update process times based on virtual cpu times stored by entry.S
+ * to the lowcore fields user_timer, system_timer & steal_clock.
+ */
+static int do_account_vtime(struct task_struct *tsk)
+{
+	u64 timer, clock, user, guest, system, hardirq, softirq;
+	struct lowcore *lc = get_lowcore();
+
+	timer = lc->last_update_timer;
+	clock = lc->last_update_clock;
+
+	vtime_reset_last_update(lc);
+
 	clock = lc->last_update_clock - clock;
 	timer -= lc->last_update_timer;
 
@@ -261,6 +269,43 @@ void vtime_account_hardirq(struct task_struct *tsk)
 	virt_timer_forward(delta);
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+/**
+ * vtime_reset - Fast forward vtime entry clocks
+ *
+ * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
+ * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
+ */
+void vtime_reset(void)
+{
+	vtime_reset_last_update(get_lowcore());
+}
+
+/**
+ * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
+ *
+ * Called when idle enters in dyntick mode. The idle cputime that elapsed so far
+ * is flushed and the tick subsystem takes over the idle cputime accounting.
+ */
+void vtime_dyntick_start(void)
+{
+	__this_cpu_write(s390_idle.idle_dyntick, true);
+	vtime_flush(current);
+}
+
+/**
+ * vtime_dyntick_stop - Inform vtime about exit from idle-dynticks
+ *
+ * Called when idle exits from dyntick mode. The vtime entry clocks are
+ * fast-forward to current time and idle accounting resumes.
+ */
+void vtime_dyntick_stop(void)
+{
+	vtime_reset_last_update(get_lowcore());
+	__this_cpu_write(s390_idle.idle_dyntick, false);
+}
+#endif /* CONFIG_NO_HZ_COMMON */
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
-- 
2.51.1


