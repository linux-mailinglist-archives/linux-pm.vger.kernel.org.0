Return-Path: <linux-pm+bounces-41017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FCDD3302A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08F20319B064
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A4274FC1;
	Fri, 16 Jan 2026 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2N15wgk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979A13B293;
	Fri, 16 Jan 2026 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575198; cv=none; b=VYUixGEVpEe6oZY6tXABb/tvgditnXHgTDy/iz3vp2gCnhebCPieLr7KguTAj1dVJpG58/lcveCa1fTIZ2VaZGVQh//veN/SGJpdFULV70/5N2evMMXABmHDiNYWIjyRwOp42158sdRYPoiV8HfeSg9Od2EdygEDoyo2joRIcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575198; c=relaxed/simple;
	bh=6uFyuO5klJgHNENFOSF+x68f4iBYCkwgEv1Ti9TKsLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGvl0oF7FZq3bHCBXo6npfP0vGrJfqEDLmISoHCKeGF+kx5jLD7xHgCrNh2dDOkBu02R/jubkg7qPYQ+7m+nnUTevL21wAFPM2SgdYucvnw1OxBUzMeoxyEjd307BCOC8CT/PkLJepTURC+ajYAREbv6ClTHSxY9m8mC81DjfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2N15wgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD2FC19423;
	Fri, 16 Jan 2026 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575198;
	bh=6uFyuO5klJgHNENFOSF+x68f4iBYCkwgEv1Ti9TKsLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2N15wgkSJJg2WEIufXp2BjLHdQAxntSADU/uVCO6plXZBWOEQrHvHSfskOiYtVdZ
	 UxQJQfexh2UyBLWfmd6knC/gADTgf/uNDot/hM9UNySIWksjgfM8Uon6dTZXfAxUqk
	 o2SsSUTNxj4vS2+MN7ybX1APmYSWrVvDtZhtVpi7Zk7KqoeFq6GjRtCdwXHMRfj7CN
	 gfJHbzwyqtlWn/fJkjFXq/VXs5H1iHdh8FveDF8UnXBwY5lXC11DN7cAGvK+kVEuoo
	 Nm9knjTpgNpfzWUnTRfgWhubz6NT+6JMku2ChA1QU7igMB2u3mgddBsFNKKrO/GCOi
	 dbvxfaysBrppg==
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
Subject: [PATCH 08/15] tick/sched: Remove nohz disabled special case in cputime fetch
Date: Fri, 16 Jan 2026 15:52:01 +0100
Message-ID: <20260116145208.87445-9-frederic@kernel.org>
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

Even when nohz is not runtime enabled, the dynticks idle cputime
accounting can run and the common idle cputime accessors are still
relevant.

Remove the nohz disabled special case accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 74c97ad75856..f0b79e876997 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -786,7 +786,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 	ktime_t now, idle;
 	unsigned int seq;
 
-	if (!tick_nohz_active || vtime_generic_enabled_cpu(cpu))
+	if (vtime_generic_enabled_cpu(cpu))
 		return -1;
 
 	now = ktime_get();
@@ -824,7 +824,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if NOHZ is not enabled, else total idle time of the @cpu
+ * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
@@ -848,7 +848,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if NOHZ is not enabled, else total iowait time of @cpu
+ * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
-- 
2.51.1


