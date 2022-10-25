Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05BE60CE23
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 15:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiJYN7m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiJYN7d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 09:59:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B53A38BD;
        Tue, 25 Oct 2022 06:59:27 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjZFfNcyum+PDjbc3AHd6/uCS3i8MsMOcfFwmxfp/G8=;
        b=UGETlyUbeKc76z87+EiwJTtOgXzZt9nBjRIlvPB+43LPxVq66Dbt+jPjjOj7/ZFpYuqsIW
        I0e4W3BYeNd8LbwVjg6tY/8gQLKK+FLTtjQchvMJdeyx+M4RUT39dIAXup7j8xP776BazL
        Uw5eK5TV1VTIZbqp0sCaOEQZAW7jXxWEcssNm3q9ioeDkiHPzwNC7Ews0VZAkB8SK2Yf2z
        vLUMsX7pSxW0NUPXDSaHjsGWkm2M6uwS/NGh9wTwDljUDzg45uBXoYZyiGbUIq1NW+gPuE
        UJ/SQOZZ4kZxHd90FKE1vQhlYAkP5JNqg7pE2XzS6Ny3qmCv3SYahFDPeJn8Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjZFfNcyum+PDjbc3AHd6/uCS3i8MsMOcfFwmxfp/G8=;
        b=oMJlLtkx5PBtCsSDRXrQdvne6oh7AExalkKbxyvC+Y9LxFQv/AhZgza0IWSZwZbkC+1+De
        Lox22y4x9bbXKdCw==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v3 10/17] timer: Add get next timer interrupt functionality for remote CPUs
Date:   Tue, 25 Oct 2022 15:58:43 +0200
Message-Id: <20221025135850.51044-11-anna-maria@linutronix.de>
In-Reply-To: <20221025135850.51044-1-anna-maria@linutronix.de>
References: <20221025135850.51044-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have functionality available getting the
next timer interrupt on a remote CPU.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-internal.h |  3 +++
 kernel/time/timer.c         | 41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 6f5f164506d5..7b65abc9d803 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -170,6 +170,9 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern void forward_and_idle_timer_bases(unsigned long basej, u64 basem,
 					 struct timer_events *tevt);
+extern void get_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+					    struct timer_events *tevt,
+					    unsigned int cpu);
 void timer_clear_idle(void);
 
 #define CLOCK_SET_WALL							\
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 167ae89f0f46..54631e86763f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1744,6 +1744,47 @@ static unsigned long get_next_timer_interrupt(struct timer_base *base_local,
 	return local_first ? nextevt_local : nextevt_global;
 }
 
+/**
+ * get_next_timer_interrupt_remote
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @tevt:	Pointer to the storage for the expiry values
+ * @cpu:	Remote CPU
+ *
+ * Stores the next pending local and global timer expiry values in the
+ * struct pointed to by @tevt. If a queue is empty the corresponding
+ * field is set to KTIME_MAX. If local event expires before global
+ * event, global event is set to KTIME_MAX as well.
+ */
+void get_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+				     struct timer_events *tevt,
+				     unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+	unsigned long flags;
+
+	/* Preset local / global events */
+	tevt->local = tevt->global = KTIME_MAX;
+
+	/*
+	 * Pretend that there is no timer pending if the cpu is offline.
+	 * Possible pending timers will be migrated later to an active cpu.
+	 */
+	if (cpu_is_offline(cpu))
+		return;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	raw_spin_lock_irqsave(&base_local->lock, flags);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	get_next_timer_interrupt(base_local, base_global, basej, basem, tevt);
+
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock_irqrestore(&base_local->lock, flags);
+}
+
 /**
  * forward_and_idle_timer_bases
  * @basej:	base time jiffies
-- 
2.30.2

