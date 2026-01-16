Return-Path: <linux-pm+bounces-41010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525FD32EAC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 118B5302DCAA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA43933F3;
	Fri, 16 Jan 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlqCwn2Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309B145348;
	Fri, 16 Jan 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575148; cv=none; b=gBbltEhxNUnh/QXIUcyv5iSl5+5stoYKdLWmXx0l/FYtQTNwLZ2YfsZsEzRXzQM2xecDeSummsadxWFmcaVVt8d1Ao4qGxrusMAMK5igP2QjdVEsivHO91vjJbsFEqfVzt9uFT08QQdfCyskKKvOYyE5sLYwWdbzsi9jGAawsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575148; c=relaxed/simple;
	bh=AunS2qc13yjAkPCRwR4BY8llDOuJfk4lXWa5mN6Z7vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VziwdvbvvLHOOxA7aEwl1ICsdLwwFt1aJNHMTsvjE/0x7jB1Gje6YFHqcybNk30sgCZwQRb1Bb/ojbJiV0qxVddDt4G24KieTomm9Juez6rVEKEERqWZja1e2SSkzdk6KsZHDhOSaU/E3KnTDLf95lGERm7PFMgqn1uA6COxqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlqCwn2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FDAC19421;
	Fri, 16 Jan 2026 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575147;
	bh=AunS2qc13yjAkPCRwR4BY8llDOuJfk4lXWa5mN6Z7vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlqCwn2YqqsP+baZapFQ2Pk8CvxIq+ZishCZjE6uTpwv+ovsptwhqtsPhBh7V+OIG
	 1urHhwFrOFkMLDXB62n/42kPaa8XEk9xkVQ3StO1dvAoIq7IOsSUJ7Z9gmTmn+A7Oq
	 wOadWfFRYVWv3iyp8oPlNZYOMuOTa1J7Lg7efbMLvA1U1OOlJ2X9jlJF4Tnc6hCio2
	 BL593vlwI8MvVly+7Fx7wUKPtRWsClhbLa5u4jQy6KrBBMM91+cWXJ21NDC/Oq0LH7
	 7Fg/Gdw9RjA7uHoS/moX9agnj3h5E4Lys7jb3GLWmMqLdqnpfkgAbh37OZpnXG4SD7
	 j4qOYkZUJbLPA==
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
Subject: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
Date: Fri, 16 Jan 2026 15:51:54 +0100
Message-ID: <20260116145208.87445-2-frederic@kernel.org>
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

Offline handling happens from within the inner idle loop,
after the beginning of dyntick cputime accounting, nohz idle
load balancing and TIF_NEED_RESCHED polling.

This is not necessary and even buggy because:

* There is no dyntick handling to do. And calling tick_nohz_idle_enter()
  messes up with the struct tick_sched reset that was performed on
  tick_sched_timer_dying().

* There is no nohz idle balancing to do.

* Polling on TIF_RESCHED is irrelevant at this stage, there are no more
  tasks allowed to run.

* No need to check if need_resched() before offline handling since
  stop_machine is done and all per-cpu kthread should be done with
  their job.

Therefore move the offline handling at the beginning of the idle loop.
This will also ease the idle cputime unification later by not elapsing
idle time while offline through the call to:

	tick_nohz_idle_enter() -> tick_nohz_start_idle()

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/idle.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c174afe1dd17..35d79af3286d 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -260,6 +260,12 @@ static void do_idle(void)
 {
 	int cpu = smp_processor_id();
 
+	if (cpu_is_offline(cpu)) {
+		local_irq_disable();
+		cpuhp_report_idle_dead();
+		arch_cpu_idle_dead();
+	}
+
 	/*
 	 * Check if we need to update blocked load
 	 */
@@ -311,11 +317,6 @@ static void do_idle(void)
 		 */
 		local_irq_disable();
 
-		if (cpu_is_offline(cpu)) {
-			cpuhp_report_idle_dead();
-			arch_cpu_idle_dead();
-		}
-
 		arch_cpu_idle_enter();
 		rcu_nocb_flush_deferred_wakeup();
 
-- 
2.51.1


