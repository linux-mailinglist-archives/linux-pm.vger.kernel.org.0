Return-Path: <linux-pm+bounces-41019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C798D33039
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E187D31A7381
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E69394487;
	Fri, 16 Jan 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7f1kh7r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D323D2B2;
	Fri, 16 Jan 2026 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575213; cv=none; b=Wu1x5ol+glsgsv5QE3YjoaB1fjxQZM05D4JiCkVuBs2bhlknTsfm2P2oQj40OeVyOYeISyeeTk2zGQXv/OePM1iPd3o596bY5SP1zALKLrzChXhkIbM+na75yc6XZYfB9p/nn9mE1PgM4DwR9gjc358v0dLp4OtI40rIj3BTTQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575213; c=relaxed/simple;
	bh=+EcaS9wpjAI5nYExsBELcaZu8W8ohxG84dL93BxRlIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFW7q0ke2g4PJfABMXC+3oxbGTZDPCbb2b+gapTPLMz/INX9vpu/OWH6gKPegEixZS2Lby3vvIqneTkmhPruXCJlOJpbhJfoiW8X1d3RLAWRxFDL8h4e/0TVCSItpIxidMSMMlZ/r+PdOj33VITumvI1wkoTXoXB/ba8tnVpT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7f1kh7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4247FC19425;
	Fri, 16 Jan 2026 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575213;
	bh=+EcaS9wpjAI5nYExsBELcaZu8W8ohxG84dL93BxRlIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7f1kh7rJjODodXqRraFZwOOQ0AX4fWSIf9o/E9fD1XYzZBx+5fe236YW0A3Ve8O1
	 Rz04lUtX6W0Gw6C314tLM0ft3an+9Nd8rmqrWtM0Vhg6x0+EvQe2+e6aDyUNfLVhon
	 0A/oWIFSINFiw5FCD1JK/pclfTftfMl9sh3tJos2b6nVCiOf19VU4C3AZuhhFqDtjQ
	 QwaQZu0Nnu2URB700+D7zJp6yNwtJJ9uRVarOFgNrqtd0i5eO4zzPyC1Hmdi8COYRc
	 vyQapnbNGGxOsmIOJu1LHgQBI29sqN/KUWMmFR8J2STLF9hH/rT/6h1EPP7gcz39KZ
	 0Pk5QK2wl08WQ==
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
Subject: [PATCH 10/15] tick/sched: Remove unused fields
Date: Fri, 16 Jan 2026 15:52:03 +0100
Message-ID: <20260116145208.87445-11-frederic@kernel.org>
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

Remove fields after the dyntick-idle cputime migration to scheduler
code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.h       | 12 ------------
 kernel/time/timer_list.c       |  6 +-----
 scripts/gdb/linux/timerlist.py |  4 ----
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index b4a7822f495d..79b9252047b1 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -44,9 +44,7 @@ struct tick_device {
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
  * @next_tick:		Next tick to be fired when in dynticks mode.
- * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_waketime:	Time when the idle was interrupted
- * @idle_sleeptime_seq:	sequence counter for data consistency
  * @idle_entrytime:	Time when the idle call was entered
  * @last_jiffies:	Base jiffies snapshot when next event was last computed
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
@@ -55,9 +53,6 @@ struct tick_device {
  * @idle_expires:	Next tick in idle, for debugging purpose only
  * @idle_calls:		Total number of idle calls
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
- * @idle_exittime:	Time when the idle state was left
- * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
- * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
  * @check_clocks:	Notification mechanism about clocksource changes
  */
@@ -73,12 +68,10 @@ struct tick_sched {
 	struct hrtimer			sched_timer;
 	ktime_t				last_tick;
 	ktime_t				next_tick;
-	unsigned long			idle_jiffies;
 	ktime_t				idle_waketime;
 	unsigned int			got_idle_tick;
 
 	/* Idle entry */
-	seqcount_t			idle_sleeptime_seq;
 	ktime_t				idle_entrytime;
 
 	/* Tick stop */
@@ -90,11 +83,6 @@ struct tick_sched {
 	unsigned long			idle_calls;
 	unsigned long			idle_sleeps;
 
-	/* Idle exit */
-	ktime_t				idle_exittime;
-	ktime_t				idle_sleeptime;
-	ktime_t				iowait_sleeptime;
-
 	/* Full dynticks handling */
 	atomic_t			tick_dep_mask;
 
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 488e47e96e93..e77b512e8597 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -154,14 +154,10 @@ static void print_cpu(struct seq_file *m, int cpu, u64 now)
 		P_flag(highres, TS_FLAG_HIGHRES);
 		P_ns(last_tick);
 		P_flag(tick_stopped, TS_FLAG_STOPPED);
-		P(idle_jiffies);
 		P(idle_calls);
 		P(idle_sleeps);
 		P_ns(idle_entrytime);
 		P_ns(idle_waketime);
-		P_ns(idle_exittime);
-		P_ns(idle_sleeptime);
-		P_ns(iowait_sleeptime);
 		P(last_jiffies);
 		P(next_timer);
 		P_ns(idle_expires);
@@ -258,7 +254,7 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
 
 static inline void timer_list_header(struct seq_file *m, u64 now)
 {
-	SEQ_printf(m, "Timer List Version: v0.10\n");
+	SEQ_printf(m, "Timer List Version: v0.11\n");
 	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
 	SEQ_printf(m, "now at %Ld nsecs\n", (unsigned long long)now);
 	SEQ_printf(m, "\n");
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index ccc24d30de80..c14ce55674c9 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -90,14 +90,10 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
             text += f"  .{'nohz':15s}: {int(bool(ts['flags'] & TS_FLAG_NOHZ))}\n"
             text += f"  .{'last_tick':15s}: {ts['last_tick']}\n"
             text += f"  .{'tick_stopped':15s}: {int(bool(ts['flags'] & TS_FLAG_STOPPED))}\n"
-            text += f"  .{'idle_jiffies':15s}: {ts['idle_jiffies']}\n"
             text += f"  .{'idle_calls':15s}: {ts['idle_calls']}\n"
             text += f"  .{'idle_sleeps':15s}: {ts['idle_sleeps']}\n"
             text += f"  .{'idle_entrytime':15s}: {ts['idle_entrytime']} nsecs\n"
             text += f"  .{'idle_waketime':15s}: {ts['idle_waketime']} nsecs\n"
-            text += f"  .{'idle_exittime':15s}: {ts['idle_exittime']} nsecs\n"
-            text += f"  .{'idle_sleeptime':15s}: {ts['idle_sleeptime']} nsecs\n"
-            text += f"  .{'iowait_sleeptime':15s}: {ts['iowait_sleeptime']} nsecs\n"
             text += f"  .{'last_jiffies':15s}: {ts['last_jiffies']}\n"
             text += f"  .{'next_timer':15s}: {ts['next_timer']}\n"
             text += f"  .{'idle_expires':15s}: {ts['idle_expires']} nsecs\n"
-- 
2.51.1


