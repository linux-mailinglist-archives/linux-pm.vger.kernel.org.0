Return-Path: <linux-pm+bounces-41020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A9DD330CF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40DE3146D16
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778639901F;
	Fri, 16 Jan 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="majYxb9z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354E3933FD;
	Fri, 16 Jan 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575221; cv=none; b=ry4z+0nAaItYBkQm4bpkk81gnoLO1P7QJhFFk6y6BVV39biKDXPg94b0S9Tvqxmyo5tLvA97fucfhFuy1DBAE3AMB9Hgb4GMIxTt06XPmyoutvXxruBexCvv3qrUqP3yla7HszrW7ce9GQG4KkMXuFY5Z6S0Xd/YYtM2TZUb4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575221; c=relaxed/simple;
	bh=cektvtI2SQiWO5ottxWjn0y5YqwpxHFc7QfJqdyaGjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvNm9nXMOtEm4w610cQzwCsxnTJ1Dd+/1Mh5/cuNEQt/MYOBTsYFMkdio5IZJaZlgeTDIzapef1jRMyaAw9JYtFQPuym16p+4TmTfghG+F71W+X+AcXnHjEa67jk/f3o0Xw/V7EnOaREe+Ge5C9qtMkqB4Mi5po3S4ueIy4CSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=majYxb9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3A9C116C6;
	Fri, 16 Jan 2026 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575220;
	bh=cektvtI2SQiWO5ottxWjn0y5YqwpxHFc7QfJqdyaGjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=majYxb9zCy1nbQRA1636ysfFV2EK0/qpH4WyUbSc4F11FOMivnoCU9dWsqRzdXQgO
	 0MLmU7Iotug0Svmin6qEo2i1OFpka0D0pxed3kZHXuclBjeyOb9jqgwcmlGfY4sDbp
	 gTbntQVtC6lzNf/gQvADwtKPpq2oBLDumuiuXSG3Kg2h0ar+0eIT8+KEN/d045w8+6
	 82dvl0WaoB4Ywhlw/3Uf6eUdwdbcpYIAG4ZCujx8X6rcyhTTcP/60iw490KEUqeb80
	 dw8qTk9m3iTx/4o116/7uPT8R2t7A6lLVjoZoB8HZ9lBMYbZRP+h+TxnFcGco+/gcK
	 ynzL8m/vHtxdg==
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
Subject: [PATCH 11/15] tick/sched: Account tickless idle cputime only when tick is stopped
Date: Fri, 16 Jan 2026 15:52:04 +0100
Message-ID: <20260116145208.87445-12-frederic@kernel.org>
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

There is no real point in switching to dyntick-idle cputime accounting
mode if the tick is not actually stopped. This just adds overhead,
notably fetching the GTOD, on each idle exit and each idle IRQ entry for
no reason during short idle trips.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 44 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbd645fb8df6..05da130d257a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1135,8 +1135,10 @@ void tick_nohz_idle_stop_tick(void)
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;
 
-		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED))
+		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+			kcpustat_dyntick_start(ts->idle_entrytime);
 			nohz_balance_enter_idle(cpu);
+		}
 	} else {
 		tick_nohz_retain_tick(ts);
 	}
@@ -1177,7 +1179,6 @@ void tick_nohz_idle_enter(void)
 	ts = this_cpu_ptr(&tick_cpu_sched);
 	WARN_ON_ONCE(ts->timer_expires_base);
 	ts->idle_entrytime = ktime_get();
-	kcpustat_dyntick_start(ts->idle_entrytime);
 	tick_nohz_clock_sleep(ts);
 
 	local_irq_enable();
@@ -1207,9 +1208,10 @@ void tick_nohz_irq_exit(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE)) {
-		ts->idle_entrytime = ktime_get();
-		kcpustat_irq_exit(ts->idle_entrytime);
 		tick_nohz_clock_sleep(ts);
+		ts->idle_entrytime = ktime_get();
+		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
+			kcpustat_irq_exit(ts->idle_entrytime);
 	} else {
 		tick_nohz_full_update_tick(ts);
 	}
@@ -1310,8 +1312,11 @@ void tick_nohz_idle_restart_tick(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+		ktime_t now = ktime_get();
+		kcpustat_dyntick_stop(now);
+		tick_nohz_restart_sched_tick(ts, now);
+	}
 }
 
 static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
@@ -1341,7 +1346,6 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 void tick_nohz_idle_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	bool idle_active, tick_stopped;
 	ktime_t now;
 
 	local_irq_disable();
@@ -1350,18 +1354,13 @@ void tick_nohz_idle_exit(void)
 	WARN_ON_ONCE(ts->timer_expires_base);
 
 	tick_sched_flag_clear(ts, TS_FLAG_INIDLE);
-	idle_active = tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE);
-	tick_stopped = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
+	tick_nohz_clock_wakeup(ts);
 
-	if (idle_active || tick_stopped)
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		now = ktime_get();
-
-	if (idle_active)
-		tick_nohz_clock_wakeup(ts);
-
-	if (tick_stopped)
+		kcpustat_dyntick_stop(now);
 		tick_nohz_idle_update_tick(ts, now);
-	kcpustat_dyntick_stop(now);
+	}
 
 	local_irq_enable();
 }
@@ -1415,15 +1414,13 @@ static inline void tick_nohz_irq_enter(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now;
 
-	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
+	tick_nohz_clock_wakeup(ts);
+
+	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED))
 		return;
 
 	now = ktime_get();
-
-	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
-		tick_nohz_clock_wakeup(ts);
-		kcpustat_irq_enter(now);
-	}
+	kcpustat_irq_enter(now);
 
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
@@ -1432,8 +1429,7 @@ static inline void tick_nohz_irq_enter(void)
 	 * rare case (typically stop machine). So we must make sure we have a
 	 * last resort.
 	 */
-	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
-		tick_nohz_update_jiffies(now);
+	tick_nohz_update_jiffies(now);
 }
 
 #else
-- 
2.51.1


