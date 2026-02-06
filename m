Return-Path: <linux-pm+bounces-42222-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGiGFUP6hWmKIwQAu9opvQ
	(envelope-from <linux-pm+bounces-42222-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:27:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64139FEE45
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 842653022ED2
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791403F0751;
	Fri,  6 Feb 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyvvjMdH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF73EF0A3;
	Fri,  6 Feb 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387888; cv=none; b=QWv98v+xHpa+4p14bos4FjELmtMzOq9sOEVKRhAOpj5BJf8Vxvegokib7xDwyWe441pwN6K14T0NjLCdpfMZwp00nB7OhiFnfoLTLRLURAMlHtuWS5IRFbr1kla2rqsaoM6BFIpvS99ksnDlfqsAoQCAwS9opZ5XqemAlXexJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387888; c=relaxed/simple;
	bh=1a8G23aJDuAPjK+U9mKc7z3SxXZk+XIfUuQdAEaa5yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGN1wJ1tuqSdCl5DAwQWh4QRnygM1u/D//aSrYijRdpP8B7YE+3A9qAj/6JjtYazoMflUvxzov5G5G9j/2AWjp3hYNJxzKr0eQP1NWHurH8m70t6vz0I2+jRAkhJMc3JKAaLwXzQQ/cbCSBX4WSKlImQ7OqhMR+j5bZY5iaDUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyvvjMdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E3AC19424;
	Fri,  6 Feb 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387888;
	bh=1a8G23aJDuAPjK+U9mKc7z3SxXZk+XIfUuQdAEaa5yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pyvvjMdH3hIzpy6aY54/LbDRrNWblh4tmt5l6YkK+fTkvt2lfzilz/SMkfwmrBCTa
	 SdLlYowtBljkJ90q0VuzNj72diFgimT3w+ipxS9PtB8dSXBlzs4yP8OfTHShrVnSgr
	 gIf5I4KVPgt8ITyocNbbNovtS1ms8WfLW13HT+LGC2E4XC8HPszlhfOeclfv2fM5jt
	 dXpbutriVMuVXNcdLINPem/tHoz9daDrciUC3ojdNmBJ73HAVeG1sT48y3yzyYxiIE
	 55GK83AOK2oYqnpMm+ZYmC8nbn9afCH/50djVJ6jux706lusveFloWpWJaZDjViUcl
	 ImbJ0ASRdg5Qw==
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
Subject: [PATCH 14/15] sched/cputime: Handle idle irqtime gracefully
Date: Fri,  6 Feb 2026 15:22:44 +0100
Message-ID: <20260206142245.58987-15-frederic@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_FROM(0.00)[bounces-42222-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64139FEE45
X-Rspamd-Action: no action

The dyntick-idle cputime accounting always assumes that IRQ time
accounting is enabled and consequently stops elapsing the idle time
during dyntick-idle IRQs.

This doesn't mix up well with disabled IRQ time accounting because then
idle IRQs become a cputime blind-spot. Also this feature is disabled
on most configurations and the overhead of pausing dyntick-idle
accounting while in idle IRQs could then be avoided.

Fix the situation with conditionally pausing dyntick-idle accounting
during idle IRQs only if neither native vtime (which does IRQ time
accounting) nor generic IRQ time accounting are enabled.

Also make sure that the accumulated IRQ time is not accidentally
substracted from later accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/cputime.c | 24 +++++++++++++++++++++---
 kernel/sched/sched.h   |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d588a4a50e57..92fa2f037b6e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -46,7 +46,8 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	u64_stats_update_begin(&irqtime->sync);
 	cpustat[idx] += delta;
 	irqtime->total += delta;
-	irqtime->tick_delta += delta;
+	if (!irqtime->idle_dyntick)
+		irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
 }
 
@@ -81,6 +82,16 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
+static inline void irqtime_dyntick_start(void)
+{
+	__this_cpu_write(cpu_irqtime.idle_dyntick, true);
+}
+
+static inline void irqtime_dyntick_stop(void)
+{
+	__this_cpu_write(cpu_irqtime.idle_dyntick, false);
+}
+
 static u64 irqtime_tick_accounted(u64 maxtime)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
@@ -94,6 +105,9 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 
 #else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
 
+static inline void irqtime_dyntick_start(void) { }
+static inline void irqtime_dyntick_stop(void) { }
+
 static u64 irqtime_tick_accounted(u64 dummy)
 {
 	return 0;
@@ -444,6 +458,7 @@ void kcpustat_dyntick_stop(u64 now)
 		WARN_ON_ONCE(!kc->idle_dyntick);
 		kcpustat_idle_stop(kc, now);
 		kc->idle_dyntick = false;
+		irqtime_dyntick_stop();
 		vtime_dyntick_stop();
 		steal_account_process_time(ULONG_MAX);
 	}
@@ -455,6 +470,7 @@ void kcpustat_dyntick_start(u64 now)
 
 	if (!vtime_generic_enabled_this_cpu()) {
 		vtime_dyntick_start();
+		irqtime_dyntick_start();
 		kc->idle_dyntick = true;
 		kcpustat_idle_start(kc, now);
 	}
@@ -464,7 +480,8 @@ void kcpustat_irq_enter(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_stop(kc, now);
 }
 
@@ -472,7 +489,8 @@ void kcpustat_irq_exit(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_start(kc, now);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d30cca6870f5..cf677ff12b10 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3307,6 +3307,7 @@ static inline void sched_core_tick(struct rq *rq) { }
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 struct irqtime {
+	bool			idle_dyntick;
 	u64			total;
 	u64			tick_delta;
 	u64			irq_start_time;
-- 
2.51.1


