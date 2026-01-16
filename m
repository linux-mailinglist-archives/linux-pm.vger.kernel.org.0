Return-Path: <linux-pm+bounces-41024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD297D3309F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EB5D3246DF3
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E945394483;
	Fri, 16 Jan 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P58I4pON"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1833939B9;
	Fri, 16 Jan 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575250; cv=none; b=MdrcWGyUOLcDdu6d4KdglETnztOseyJfDN3gP5sYw+mcZKO0Q9llPno40e9h0ZxR73JEx45BPvRXAJLUkanUxPAUoHY3WxiblIE7gCDSJ8QSyVr3j4B2di1ZzkLqeRx1qfpwdnw5t1tk8qkkD3Q7HK9nwQkW9Qgjmpuy8nSSpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575250; c=relaxed/simple;
	bh=NiFNP1dNEv/R0O+iuBotsMn8keb9Y+JzQXP3O6DHJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVlpf1DtfKJ3mqV7Z1DQI47GgGOEwqjnpmv4j67EE9vVjWRJWmwd+EhteHnjtvrAowkCUuJPExnzQQMVTUC71Wmuvms08KBdI9GHa5HhsmQv8LthF2M59nzjsQDzaBa6Y8JYr2w9F8KNlSHXb1TaMTJbpFXPWswTVyxrQeA4650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P58I4pON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4568DC19423;
	Fri, 16 Jan 2026 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575250;
	bh=NiFNP1dNEv/R0O+iuBotsMn8keb9Y+JzQXP3O6DHJSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P58I4pONEqgRKgQ76ZkWUDt5XWzZMMI1w+pz+lcYFsRcbcsZHQupqMSvLSprbGueN
	 b+pk/yo1pIdVpFUg3JXsmxcb/PGfRQU9pNdfd8Jr9hk0A1q6noGtXzxgWyURE9ouC3
	 1APMRpVzRm8n/zG3SHUGHD64MLVTPwa7TIMgoVeMS6BoBYJPpxS8Mw6kww+qUJDUgN
	 uiIDVVVHWgH05pom4hl7O6l7IccpprH56k6WxOcl/M06cBnf3pySTKttXVjeZktmJd
	 jPd5Cm2EqpHdhEMCmACSzFve7xNaBHvoUtLunX2kvWz82JJJyBOVA8xHbLW4Ftq6Hh
	 ouLpAwlTIoQ0g==
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
Subject: [PATCH 15/15] sched/cputime: Handle dyntick-idle steal time correctly
Date: Fri, 16 Jan 2026 15:52:08 +0100
Message-ID: <20260116145208.87445-16-frederic@kernel.org>
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

The dyntick-idle steal time is currently accounted when the tick
restarts but the stolen idle time is not substracted from the idle time
that was already accounted. This is to avoid observing the idle time
going backward as the dyntick-idle cputime accessors can't reliably know
in advance the stolen idle time.

In order to maintain a forward progressing idle cputime while
substracting idle steal time from it, keep track of the previously
accounted idle stolen time and substract it from _later_ idle cputime
accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kernel_stat.h | 1 +
 kernel/sched/cputime.c      | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index e59916477075..a5b5a25c3cc1 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -39,6 +39,7 @@ struct kernel_cpustat {
 	bool		idle_elapse;
 	seqcount_t	idle_sleeptime_seq;
 	ktime_t		idle_entrytime;
+	u64		idle_steal;
 #endif
 	u64		cpustat[NR_STATS];
 };
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 3dadfaa92b27..749a6ed4d2fa 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -424,18 +424,25 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, ktime_t now)
 {
 	u64 *cpustat = kc->cpustat;
 	ktime_t delta;
+	u64 steal, steal_delta;
 
 	if (!kc->idle_elapse)
 		return;
 
 	delta = ktime_sub(now, kc->idle_entrytime);
+	steal = steal_account_process_time(delta);
 
 	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	steal_delta = min_t(u64, kc->idle_steal, delta);
+	delta -= steal_delta;
+	kc->idle_steal -= steal_delta;
+
 	if (nr_iowait_cpu(smp_processor_id()) > 0)
 		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
 	else
 		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
 
+	kc->idle_steal += steal;
 	kc->idle_entrytime = now;
 	kc->idle_elapse = false;
 	write_seqcount_end(&kc->idle_sleeptime_seq);
@@ -459,7 +466,6 @@ void kcpustat_dyntick_stop(ktime_t now)
 		kc->idle_dyntick = false;
 		irqtime_dyntick_stop();
 		vtime_dyntick_stop();
-		steal_account_process_time(ULONG_MAX);
 	}
 }
 
@@ -507,6 +513,7 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 		if (kc->idle_elapse && compute_delta) {
 			ktime_t delta = ktime_sub(now, kc->idle_entrytime);
 
+			delta -= min_t(u64, kc->idle_steal, (u64)delta);
 			idle = ktime_add(cpustat[idx], delta);
 		} else {
 			idle = cpustat[idx];
-- 
2.51.1


