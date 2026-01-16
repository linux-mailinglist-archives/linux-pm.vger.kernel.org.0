Return-Path: <linux-pm+bounces-41014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7692ED330AE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2C9930499FC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65B3939AE;
	Fri, 16 Jan 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXLhbUJp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE453358D4;
	Fri, 16 Jan 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575177; cv=none; b=Jr0p1disjRWgNW+ex9X6ba0NIDnP2Z/DnIoCaRy8Iwkfqb0z00tTTVx2kY3PicVhFlt3U/0sDoCA8iVxWF1ue3s2bb/Lzocjim94qawa7FvdjFiW2EJbj00L4F2OK1KkntvBJfc2nAzl6hygdIE1Vde3d8ctj0z0RYbMvxJU3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575177; c=relaxed/simple;
	bh=vvbridxIQso7KWjeK226R2O4tHRCA31JE5Z2K7DDlx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fte0X0qm54Th/gY5cv+hD81PexSlUsVgYTKnq/YI5slntG20UdWob/CLff0AMXA0FrXQWD22yfRKxOKoigAe+H0kqEDD+1qchptGyWUuwJKCUxvS6a1FkBSoUDl8KCOvqhu74olcVfMAAL4YjaxvlUu7ODgljfz/FKFVSlFfifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXLhbUJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6E9C19421;
	Fri, 16 Jan 2026 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575177;
	bh=vvbridxIQso7KWjeK226R2O4tHRCA31JE5Z2K7DDlx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXLhbUJpSe2jZoljJhKsDC27GLZ/Nje4Dfdzt+9e5A8Qe8HbJQL7AtTSlBBvtQxYD
	 JEoEUArdN7c3biSjO8pjEpKLgy7I+x7b5EXJ363hnEJgvBoZ7tBYEZi9O1iG8ihbmx
	 OiKewfemzThz7ZiIqZtX1yp/OwINnAHXAkawnJCl5Uv7QUVyhWRkLIvuoXNMyOqUtp
	 Wacczq3p1j2eXAzBRjlloY9pra1JLen6QZ8H5kz+I+b/GguE0H5BY85+SBDFweFt9k
	 IrF8ut5IrXm87oPBfxgY3ztrHxHfFSNiUltGY0wE56dwU1pbhAy5XE2ybMtWzgE/yJ
	 7QQq0bJS/Kv5g==
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
Subject: [PATCH 05/15] s390/time: Prepare to stop elapsing in dynticks-idle
Date: Fri, 16 Jan 2026 15:51:58 +0100
Message-ID: <20260116145208.87445-6-frederic@kernel.org>
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
 arch/s390/include/asm/idle.h | 11 +++---
 arch/s390/kernel/idle.c      | 13 ++++++--
 arch/s390/kernel/vtime.c     | 65 ++++++++++++++++++++++++++++++------
 3 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 09f763b9eb40..2770c4f761e1 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -12,11 +12,12 @@
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
 
 extern struct device_attribute dev_attr_idle_count;
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 39cb8d0ae348..54bb932184dd 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -35,6 +35,12 @@ void account_idle_time_irq(void)
 			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
 	}
 
+	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
+
+	/* Dyntick idle time accounted by nohz/scheduler */
+	if (idle->idle_dyntick)
+		return;
+
 	idle_time = lc->int_clock - idle->clock_idle_enter;
 
 	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
@@ -45,7 +51,6 @@ void account_idle_time_irq(void)
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
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


