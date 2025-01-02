Return-Path: <linux-pm+bounces-19908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28B9FFAB8
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 16:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B4B3A34F4
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6C1B4F1A;
	Thu,  2 Jan 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii1zFYfY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9771B4F0F;
	Thu,  2 Jan 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830141; cv=none; b=ljajt9GXtK5yperxXnCw8inn0oI66zuo0HCV8T/XFoAgBTnMKcxK+nX1+Jd7+4NygD6TZJ3suajC2CGeC7VVQ6Fm96LV4Nqcom1jqTUfzLHkwjZvaOnAy9wqMf1Z8fWdRGE77gw6wmS/VaCACYJ3PLC0b8TnaY+7hy+4AMkLSvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830141; c=relaxed/simple;
	bh=NavR6UqlfYLDkNot5pquuMbNapnDO70AeqgbD4rubNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfcWwXR63RFULIXaIGq2YPN+X8ZfjzIzHdHP1wmmCy7+pkMY4dJiqyMewbp6pLlYJ+aKJ2SEF8M+WMKWAyJER8B6HbuND5FYVFXs85o6Kba7LMtnkQZz47FxMdSCajbtWtJg6srSdov5V3BcGY97PjFjNVIIRZZO6UzRYPYbWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii1zFYfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50B0C4CEDC;
	Thu,  2 Jan 2025 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735830141;
	bh=NavR6UqlfYLDkNot5pquuMbNapnDO70AeqgbD4rubNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ii1zFYfY+IdRCDIfGXBqRZ9EQrbkQuQHJbyiNYcm1DLQdsiqh33r9b8VYJ4MoCs4e
	 0Yrd74ltYRuBi3yv90JL8VcjEtHH2oLdd/b1g5x1fndmmqhfvTN3SJb67pIn6eE3Hr
	 i4bHnUDVclbQnH3TKuwHHX76hydFQdnbJ/JCIN3VPP7cRM7VFrShaHKXFB5SmBe/yS
	 VQ2WFrmVZdoNfZ2z/53Hb8649SVMesCTwoFuTv0jPFhBAksToL771Lnn4b4k9I/4CZ
	 tAkG6DQx8RBpplNVlcGjkHjgJc9swYpLG2r5wjcf11f35Qoag8n+CiNjQCdQJhi+vl
	 DmK5aLVyecDIg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 4/6] cpuidle: Handle TIF_NR_POLLING on behalf of CPUIDLE_FLAG_MWAIT states
Date: Thu,  2 Jan 2025 16:01:58 +0100
Message-ID: <20250102150201.21639-5-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250102150201.21639-1-frederic@kernel.org>
References: <20250102150201.21639-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

The current handling of TIF_NR_POLLING is a bit of a maze:

1) TIF_NR_POLLING is set on idle entry (one atomic set)

2) Once cpuidle has selected an appropriate state and the tick is
   evaluated and then possibly stopped, TIF_NR_POLLING is cleared
   (one RmW operation)

2) The cpuidle state is then called with TIF_NR_POLLING cleared but if
   the state polls on (or monitors) need_resched() it sets again
   TIF_NR_POLLING before sleeping and clears it on wake-up. Summary:
   another pair of set/clear

3) Set back TIF_NR_POLLING (one atomic set)

4) goto 2) if need_resched() is not set

All those costly atomic operations, fully ordered RmW for some of
them, could be avoided if the cpuidle core knew in advance if the target
state polls on (or monitors) need_resched(). If so, TIF_NR_POLLING could
simply be set once upon entering the idle loop and cleared once after
idle loop exit.

Start dealing with that with handling TIF_NR_POLLING on behalf of
mwait based states.

[fweisbec: _ Handle broadcast properly
           _ Ignore mwait_idle() as it can be used by default_idle_call()]

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/mwait.h | 27 +++++++++++-------------
 drivers/cpuidle/cpuidle.c    | 22 +++++++++++++++++++-
 include/linux/sched/idle.h   |  7 ++++++-
 kernel/sched/idle.c          | 40 +++++++++++++-----------------------
 4 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 920426d691ce..3e06a7f3bf5a 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -116,25 +116,22 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
  */
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
-	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
-		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
-			mb();
-			clflush((void *)&current_thread_info()->flags);
-			mb();
-		}
+	if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
+		mb();
+		clflush((void *)&current_thread_info()->flags);
+		mb();
+	}
 
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
+	__monitor((void *)&current_thread_info()->flags, 0, 0);
 
-		if (!need_resched()) {
-			if (ecx & 1) {
-				__mwait(eax, ecx);
-			} else {
-				__sti_mwait(eax, ecx);
-				raw_local_irq_disable();
-			}
+	if (!need_resched()) {
+		if (ecx & 1) {
+			__mwait(eax, ecx);
+		} else {
+			__sti_mwait(eax, ecx);
+			raw_local_irq_disable();
 		}
 	}
-	current_clr_polling();
 }
 
 /*
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..46c0a2726f67 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -217,10 +217,10 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 				 int index)
 {
 	int entered_state;
-
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
 	ktime_t time_start, time_end;
+	bool polling;
 
 	instrumentation_begin();
 
@@ -237,6 +237,23 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		broadcast = false;
 	}
 
+	polling = target_state->flags & CPUIDLE_FLAG_MWAIT;
+
+	/*
+	 * If the target state doesn't poll on need_resched(), this is
+	 * the last check after which further TIF_NEED_RESCHED remote setting
+	 * will involve an IPI.
+	 */
+	if (!polling && current_clr_polling_and_test()) {
+		if (broadcast)
+			tick_broadcast_exit();
+		dev->last_residency_ns = 0;
+		local_irq_enable();
+		instrumentation_end();
+		return -EBUSY;
+	}
+
+
 	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
 		leave_mm();
 
@@ -336,6 +353,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		dev->states_usage[index].rejected++;
 	}
 
+	if (!polling)
+		__current_set_polling();
+
 	instrumentation_end();
 
 	return entered_state;
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index e670ac282333..3e3482bfb028 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -68,6 +68,8 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
 {
+	bool ret;
+
 	__current_clr_polling();
 
 	/*
@@ -76,7 +78,10 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	ret = unlikely(tif_need_resched());
+	if (ret)
+		__current_set_polling();
+	return ret;
 }
 
 #else
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 621696269584..9eece3df1080 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -114,12 +114,13 @@ void __cpuidle default_idle_call(void)
 		stop_critical_timings();
 
 		ct_cpuidle_enter();
-		arch_cpu_idle();
+		arch_cpu_idle(); // XXX assumes !polling
 		ct_cpuidle_exit();
 
 		start_critical_timings();
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 		cond_tick_broadcast_exit();
+		__current_set_polling();
 	}
 	local_irq_enable();
 	instrumentation_end();
@@ -128,31 +129,14 @@ void __cpuidle default_idle_call(void)
 static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev)
 {
+	int ret;
+
 	if (current_clr_polling_and_test())
 		return -EBUSY;
 
-	return cpuidle_enter_s2idle(drv, dev);
-}
-
-static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
-		      int next_state)
-{
-	/*
-	 * The idle task must be scheduled, it is pointless to go to idle, just
-	 * update no idle residency and return.
-	 */
-	if (current_clr_polling_and_test()) {
-		dev->last_residency_ns = 0;
-		local_irq_enable();
-		return -EBUSY;
-	}
-
-	/*
-	 * Enter the idle state previously returned by the governor decision.
-	 * This function will block until an interrupt occurs and will take
-	 * care of re-enabling the local interrupts
-	 */
-	return cpuidle_enter(drv, dev, next_state);
+	ret = cpuidle_enter_s2idle(drv, dev);
+	__current_set_polling();
+	return ret;
 }
 
 /**
@@ -213,7 +197,7 @@ static void cpuidle_idle_call(void)
 		tick_nohz_idle_stop_tick();
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
-		call_cpuidle(drv, dev, next_state);
+		cpuidle_enter(drv, dev, next_state);
 	} else {
 		bool stop_tick = true;
 
@@ -227,7 +211,12 @@ static void cpuidle_idle_call(void)
 		else
 			tick_nohz_idle_retain_tick();
 
-		entered_state = call_cpuidle(drv, dev, next_state);
+		/*
+		 * Enter the idle state previously returned by the governor decision.
+		 * This function will block until an interrupt occurs and will take
+		 * care of re-enabling the local interrupts.
+		 */
+		entered_state = cpuidle_enter(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
 		 */
@@ -235,7 +224,6 @@ static void cpuidle_idle_call(void)
 	}
 
 exit_idle:
-	__current_set_polling();
 
 	/*
 	 * It is up to the idle functions to re-enable local interrupts
-- 
2.46.0


