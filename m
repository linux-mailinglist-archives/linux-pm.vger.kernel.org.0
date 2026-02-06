Return-Path: <linux-pm+bounces-42212-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHKxDQj6hWl7IwQAu9opvQ
	(envelope-from <linux-pm+bounces-42212-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:26:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D18CFFEE21
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 15:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8DA3034564
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4153A3EF0A4;
	Fri,  6 Feb 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biDG7Lt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E155212542;
	Fri,  6 Feb 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387809; cv=none; b=sgpHrnoM9wkq3DZTVqhcxPRRGRPBAOLusjkhXkI7RiLZDyYBsMtUWSNHBQctYDK0NokbmccoxgPF5AlgyaJ6vOS5tVvVZciRNslHGcPcATS2vubh7SuzgLNmIRTMVJ62KuTVfbGf5+Skf4UsI4ves7UaWwcjqsxS5FAc6gQipkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387809; c=relaxed/simple;
	bh=g8tVOSmKODdWDGu0H8GcuoZ/GglJDm/0ZHioXuiWVfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6c2OhrdPiD+IUM/FZsdeVI60f4hJZHjfIc+NL72x8IoqqZSSgAnqAG7fooKZ5WDPdzVNWtMsPog5D/5fudyUJfga7fMQuoKBliCi+Q97vq+5ohyZP+7vkknL9eab/6uiMZb/oSjIyJD7UM4QwKnEKssOy0KGpvqIuHbApgMIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biDG7Lt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56251C116C6;
	Fri,  6 Feb 2026 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770387808;
	bh=g8tVOSmKODdWDGu0H8GcuoZ/GglJDm/0ZHioXuiWVfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biDG7Lt0Ev43G9yPf/tgbfgfwOIveTEAb5DEh8dtk+U1XX8gz0Q/dtBZNfgOtMJEl
	 kNfCLFIfPB6t6uP61zZj+shuMOeqZpOC31b4NHcrsKWospmBqyGW9A6Qq3TQJ4oPWp
	 70x4mH4gbM+55OkCaL8A7oEHXbswaRXY+tnV/SzSPKOeUNh4EUFhAowwgCz9W2ycM3
	 qgFsurW+hcFm187yRedu7bgw/O83UsalM4x9AAr3yvdOKALeJ/Det5+MMsFD6sxceg
	 aGycEmOIKs+IR8sy/n14LeKQpTkOc2iVjLeUzbFPrBqK/lSA0Anv/bcODsH4+wsvyN
	 oR5GpdjQzF1XQ==
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
Subject: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in dynticks-idle
Date: Fri,  6 Feb 2026 15:22:34 +0100
Message-ID: <20260206142245.58987-5-frederic@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-42212-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: D18CFFEE21
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
  dyntick mode. The idle cputime that elapsed so far is accumulated.

- vtime_dynticks_stop() is deemed to be called when idle exits from
  dyntick mode. The vtime entry clocks are fast-forward to current time
  so that idle accounting restarts elapsing from now.

- vtime_reset() is deemed to be called from dynticks idle IRQ entry to
  fast-forward the clock to current time so that the IRQ time is still
  accounted by vtime while nohz cputime is paused.

Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
accounting twice the idle cputime, along with nohz accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/powerpc/kernel/time.c | 41 ++++++++++++++++++++++++++++++++++++++
 include/linux/vtime.h      |  6 ++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4bbeb8644d3d..18506740f4a4 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -376,6 +376,47 @@ void vtime_task_switch(struct task_struct *prev)
 		acct->starttime = acct0->starttime;
 	}
 }
+
+#ifdef CONFIG_NO_HZ_COMMON
+/**
+ * vtime_reset - Fast forward vtime entry clocks
+ *
+ * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
+ * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
+ */
+void vtime_reset(void)
+{
+	struct cpu_accounting_data *acct = get_accounting(current);
+
+	acct->starttime = mftb();
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	acct->startspurr = read_spurr(acct->starttime);
+#endif
+}
+
+/**
+ * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
+ *
+ * Called when idle enters in dyntick mode. The idle cputime that elapsed so far
+ * is accumulated and the tick subsystem takes over the idle cputime accounting.
+ */
+void vtime_dyntick_start(void)
+{
+	vtime_account_idle(current);
+}
+
+/**
+ * vtime_dyntick_stop - Inform vtime about exit from idle-dynticks
+ *
+ * Called when idle exits from dyntick mode. The vtime entry clocks are
+ * fast-forward to current time so that idle accounting restarts elapsing from
+ * now.
+ */
+void vtime_dyntick_stop(void)
+{
+	vtime_reset();
+}
+#endif /* CONFIG_NO_HZ_COMMON */
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 void __no_kcsan __delay(unsigned long loops)
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 336875bea767..61b94c12d7dd 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -37,11 +37,17 @@ extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
+extern void vtime_reset(void);
+extern void vtime_dyntick_start(void);
+extern void vtime_dyntick_stop(void);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
 static inline void vtime_account_softirq(struct task_struct *tsk) { }
 static inline void vtime_account_hardirq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
+static inline void vtime_reset(void) { }
+static inline void vtime_dyntick_start(void) { }
+extern inline void vtime_dyntick_stop(void) { }
 #endif
 
 /*
-- 
2.51.1


