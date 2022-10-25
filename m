Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5360CE28
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 15:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiJYN7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiJYN7h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 09:59:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5417AAB;
        Tue, 25 Oct 2022 06:59:31 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666706370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oP0fWluRaqq+tZG2dJILM23sro1m5U/XHwLQFeRCl3o=;
        b=0Eg6ZbxmuMXbfIgn0sAXp3ULCCXFyqQQtHzl2xH5jlgUOd8RjrvMvZPngiSqQ/uBF1PlvC
        9C0tbJW+sVdS+DAjMs9HDPuEHChU1u8mwIhVatnjiFurN8cB6b1ONTjDgf6PYEJ11KhDWm
        0cPWMzqqFpUPBjMGMZW7dh5kVzEHrBNTua/xN61Djdnunb72Q5WJlBah36fwTd6QL5OrTZ
        uJlJWIj5makdOkBQ9ydWs+dfO5xprJa7l2oNflXamBNY66R8DL+fC5gAcKXpnjwgTiSLA+
        jsfaS9bMQsglAe/04br6zM+/zkNYHqSoF7gKXy9x0hB1rgx+baiz5OH82C1jMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666706370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oP0fWluRaqq+tZG2dJILM23sro1m5U/XHwLQFeRCl3o=;
        b=8lpLCKUTS76ShpC/dXVU5vgSp553OSmhz+hNadGKfYlzIIqj55OD6ImpPLdzbexTWiCEpO
        7i4ia9DdR8hIqNDQ==
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
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v3 17/17] timer: Always queue timers on the local CPU
Date:   Tue, 25 Oct 2022 15:58:50 +0200
Message-Id: <20221025135850.51044-18-anna-maria@linutronix.de>
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

The timer pull model is in place so we can remove the heuristics which try
to guess the best target CPU at enqueue/modification time.

All non pinned timers are queued on the local CPU in the seperate storage
and eventually pulled at expiry time to a remote CPU.

When a timer is added via add_timer_on(), TIMER_PINNED flag is required to
ensure it expires on the specified CPU. Otherwise it will be enqueued in
the global timer base which could be expired by a remote CPU. WARN_ONCE()
is added to prevent misuse.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 67f9cc077ff7..f05e547e0c6c 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -947,17 +947,6 @@ static inline struct timer_base *get_timer_base(u32 tflags)
 	return get_timer_cpu_base(tflags, tflags & TIMER_CPUMASK);
 }
 
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	if (static_branch_likely(&timers_migration_enabled) &&
-	    !(tflags & TIMER_PINNED))
-		return get_timer_cpu_base(tflags, get_nohz_timer_target());
-#endif
-	return get_timer_this_cpu_base(tflags);
-}
-
 static inline void forward_timer_base(struct timer_base *base)
 {
 	unsigned long jnow = READ_ONCE(jiffies);
@@ -1093,7 +1082,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
 		goto out_unlock;
 
-	new_base = get_target_base(base, timer->flags);
+	new_base = get_timer_this_cpu_base(timer->flags);
 
 	if (base != new_base) {
 		/*
@@ -1228,6 +1217,10 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	BUG_ON(timer_pending(timer) || !timer->function);
 
+	WARN_ONCE(!(timer->flags & TIMER_PINNED), "TIMER_PINNED flag for "
+		  "add_timer_on() is missing: timer=%p function=%ps",
+		  timer, timer->function);
+
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
 	/*
-- 
2.30.2

