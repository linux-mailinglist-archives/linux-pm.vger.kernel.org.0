Return-Path: <linux-pm+bounces-42223-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KldETH7hWmzIwQAu9opvQ
	(envelope-from <linux-pm+bounces-42223-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:31:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFF8FEFAD
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E1630CA67A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E73F075B;
	Fri,  6 Feb 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnGDPW3W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0F3EF0A3;
	Fri,  6 Feb 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387896; cv=none; b=aGH+jJKADAl89IEyQTGeazgUs0DP8aKOFyXQM2y6LWbg5icKUeDQG+VwRqDiPBSSh89Bts4WAyhIaaeZqHdcmqE/t8GFAhEdcdjk0OttOysE8MkQ4YYwNtsNZ/7TFkilnGLxxGlXBXZj3R/b/OMKVmo+gIcKddTWANRLRvzMFM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387896; c=relaxed/simple;
	bh=axD30NXxtXM5SUHtedxFjg90A77tUvhavW17z9RBWt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkfLzW+GA/kWg+7lUVYrLH83pbn9ncwl5NVrql2WQ+v3jVODoh9z++9P0IGfPzP+nyJWRwHNUY8m24tuc7sZhhlVrp1AkRTR+ZUWOObNr3mU6o3NM4fY0sI2rHrKY7U7eiG71+9XvLpuIzi7HxKPtsJz6Gc9v1dvHl+SPiHvcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnGDPW3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684F4C116C6;
	Fri,  6 Feb 2026 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387896;
	bh=axD30NXxtXM5SUHtedxFjg90A77tUvhavW17z9RBWt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JnGDPW3WKQhZalgvDsfBR/ftmpCbHIg1kQ0jgLm0KnWWKT+zYa23crSRw7f5YRXCM
	 btDzqBLYR0Y0L4Cokn+/iY4Hvkk1LkJUyVU9RhKCw56WiwHT/UxGr31MDM0RACUhrV
	 YlzTAPXCA4NQtRJKJWqG1kMqJAvuoV7QdX7PlPuOIxgYZxAAilXOiHkCS39U7SyzkR
	 6gVTqKVllraCVZZi/Pl0sOAUW9n76CxeszJ1hzlDS8iF/uHHjHHoHKmekWABTOsAVz
	 eX8l3T5Ax5VY6BHzJDpKsCH3geoZS801SZSmFMGC/Ebc1IKNLQCaeHmaINBKfiIT72
	 /v4G2qyFhFU9A==
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
Subject: [PATCH 15/15] sched/cputime: Handle dyntick-idle steal time correctly
Date: Fri,  6 Feb 2026 15:22:45 +0100
Message-ID: <20260206142245.58987-16-frederic@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-42223-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 9DFF8FEFAD
X-Rspamd-Action: no action

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
 include/linux/kernel_stat.h |  1 +
 kernel/sched/cputime.c      | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 512104b0ff49..24a54a6151ba 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -39,6 +39,7 @@ struct kernel_cpustat {
 	bool		idle_elapse;
 	seqcount_t	idle_sleeptime_seq;
 	u64		idle_entrytime;
+	u64		idle_stealtime;
 #endif
 	u64		cpustat[NR_STATS];
 };
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 92fa2f037b6e..7e79288eb327 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -424,19 +424,25 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
 	u64 *cpustat = kc->cpustat;
-	u64 delta;
+	u64 delta, steal, steal_delta;
 
 	if (!kc->idle_elapse)
 		return;
 
 	delta = now - kc->idle_entrytime;
+	steal = steal_account_process_time(delta);
 
 	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	steal_delta = min_t(u64, kc->idle_stealtime, delta);
+	delta -= steal_delta;
+	kc->idle_stealtime -= steal_delta;
+
 	if (nr_iowait_cpu(smp_processor_id()) > 0)
 		cpustat[CPUTIME_IOWAIT] += delta;
 	else
 		cpustat[CPUTIME_IDLE] += delta;
 
+	kc->idle_stealtime += steal;
 	kc->idle_entrytime = now;
 	kc->idle_elapse = false;
 	write_seqcount_end(&kc->idle_sleeptime_seq);
@@ -460,7 +466,6 @@ void kcpustat_dyntick_stop(u64 now)
 		kc->idle_dyntick = false;
 		irqtime_dyntick_stop();
 		vtime_dyntick_stop();
-		steal_account_process_time(ULONG_MAX);
 	}
 }
 
@@ -505,10 +510,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 	do {
 		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
 
-		if (kc->idle_elapse && compute_delta)
-			idle = cpustat[idx] + (now - kc->idle_entrytime);
-		else
-			idle = cpustat[idx];
+		idle = cpustat[idx];
+
+		if (kc->idle_elapse && compute_delta) {
+			u64 delta = now - kc->idle_entrytime;
+
+			delta -= min_t(u64, kc->idle_stealtime, delta);
+			idle += delta;
+		}
 	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
 
 	return idle;
-- 
2.51.1


