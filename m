Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13141C712
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbhI2Oqj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbhI2Oqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 10:46:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB101C06161C
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 07:44:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y26so11733764lfa.11
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObMXohmKHbaPjr7B/fFVbkQWXBDEuU80sho6l7t/8yw=;
        b=Qt3SQkMkn9oR3E5nvk0LB4VlD/Iv+gDzeJ+mcn7bxpNqxdbSXJDEMFPiHamef5fq0L
         +897ot5UjYtarWL6Gmg6xEek1k2FYnC8jORoBkeZK5gW8jtAr6DUDVZTwphtYq+mIJUi
         VPgZyHmLs2EOX+QzqEIbQq1vX3oWOqO9Ql1b8dXpH5tFwwDzXM8lzLLlwDPFKgcq458N
         Guo+kNsNOetyHqsq8lUoxr7bnE1JsCDym3W6LrSseQHg1wIlSU62y0IOPIKHEb4reAqm
         awgPOphMhCT5uQeTxfN3eyPo63VGBSEnD3VOuLG/v6nLzdtAzkr4vQQzN69Ivyo9OhCE
         Qf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObMXohmKHbaPjr7B/fFVbkQWXBDEuU80sho6l7t/8yw=;
        b=f9NURuEabDjVBzHTZBi3rNSgYSUQJnJmPA0kGGt2q+f/hqLdXoSid+MN/2MJ5z+Wql
         u7dO6chb9qXmfVfP0xE4HC/FYzwZDT6E17FlUq6RdCnLLshv9Cs7JPD/aeeqK2KHUb3S
         e0sbwHLFyCaWxjmQV7CbpMt1qEMAECgRgBAk2z3mykI62KAsBOI2l+WPS87s3wsGl8j3
         uiRmPT4sBPPOcRBdp6VcSaMK3fdWkODYQ4Cib90N2DrBrngRYe+7+ekrXvNHJZFW96XZ
         G+tVO4h3DQvMYv32QE7DoMHlFjmeGK2HnPCg+9s1sEjXoTPrIHr+OrE/TKJfrmdS1pH7
         iQFg==
X-Gm-Message-State: AOAM533Pny+ciMXfaQRkU98vdqxXsCygJlUxer91H4TJFqo2Fn97cxmB
        q3U4Gp75EPvcePV62aCcL60tkQ==
X-Google-Smtp-Source: ABdhPJx14+UcR6O9ITJ5yjchMiAj7JKKZa40xBYE/WhHNCOiaiXO64w5lrJo/O5nbYoJcgAWu6tIQQ==
X-Received: by 2002:a05:651c:50c:: with SMTP id o12mr352826ljp.86.1632926695013;
        Wed, 29 Sep 2021 07:44:55 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id g4sm9863ljk.64.2021.09.29.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:44:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpuidle: Avoid calls to cpuidle_resume|pause() for s2idle
Date:   Wed, 29 Sep 2021 16:44:50 +0200
Message-Id: <20210929144451.113334-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929144451.113334-1-ulf.hansson@linaro.org>
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In s2idle_enter(), cpuidle_resume|pause() are invoked to re-allow calls to
the cpuidle callbacks during s2idle operations. This is needed because
cpuidle is paused in-between in dpm_suspend_noirq() and dpm_resume_noirq().

However, calling cpuidle_resume|pause() from s2idle_enter() looks a bit
superfluous, as it also causes all CPUs to be waken up when the first CPU
wakes up from s2idle.

Therefore, let's drop the calls to cpuidle_resume|pause() from
s2idle_enter(). To make this work, let's also adopt the path in the
cpuidle_idle_call() to allow cpuidle callbacks to be invoked for s2idle,
even if cpuidle has been paused.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle.c |  7 ++++++-
 include/linux/cpuidle.h   |  2 ++
 kernel/power/suspend.c    |  2 --
 kernel/sched/idle.c       | 40 ++++++++++++++++++++++-----------------
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd8..c76747e497e7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -49,7 +49,12 @@ void disable_cpuidle(void)
 bool cpuidle_not_available(struct cpuidle_driver *drv,
 			   struct cpuidle_device *dev)
 {
-	return off || !initialized || !drv || !dev || !dev->enabled;
+	return off || !drv || !dev || !dev->enabled;
+}
+
+bool cpuidle_paused(void)
+{
+	return !initialized;
 }
 
 /**
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index fce476275e16..51698b385ab5 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -165,6 +165,7 @@ extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern void cpuidle_pause(void);
 extern void cpuidle_resume(void);
+extern bool cpuidle_paused(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
@@ -204,6 +205,7 @@ static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline void cpuidle_pause(void) { }
 static inline void cpuidle_resume(void) { }
+static inline bool cpuidle_paused(void) {return true; }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index eb75f394a059..388a5de4836e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -97,7 +97,6 @@ static void s2idle_enter(void)
 	raw_spin_unlock_irq(&s2idle_lock);
 
 	cpus_read_lock();
-	cpuidle_resume();
 
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
@@ -105,7 +104,6 @@ static void s2idle_enter(void)
 	swait_event_exclusive(s2idle_wait_head,
 		    s2idle_state == S2IDLE_STATE_WAKE);
 
-	cpuidle_pause();
 	cpus_read_unlock();
 
 	raw_spin_lock_irq(&s2idle_lock);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d17b0a5ce6ac..3bc3a2c46731 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -158,6 +158,17 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	return cpuidle_enter(drv, dev, next_state);
 }
 
+static void cpuidle_deepest_state(struct cpuidle_driver *drv,
+				  struct cpuidle_device *dev,
+				  u64 max_latency_ns)
+{
+	int next_state;
+
+	tick_nohz_idle_stop_tick();
+	next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
+	call_cpuidle(drv, dev, next_state);
+}
+
 /**
  * cpuidle_idle_call - the main idle function
  *
@@ -189,6 +200,7 @@ static void cpuidle_idle_call(void)
 	 */
 
 	if (cpuidle_not_available(drv, dev)) {
+default_idle:
 		tick_nohz_idle_stop_tick();
 
 		default_idle_call();
@@ -204,25 +216,19 @@ static void cpuidle_idle_call(void)
 	 * timekeeping to prevent timer interrupts from kicking us out of idle
 	 * until a proper wakeup interrupt happens.
 	 */
+	if (idle_should_enter_s2idle()) {
+		entered_state = call_cpuidle_s2idle(drv, dev);
+                if (entered_state <= 0)
+			cpuidle_deepest_state(drv, dev, U64_MAX);
+		goto exit_idle;
+	}
 
-	if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
-		u64 max_latency_ns;
-
-		if (idle_should_enter_s2idle()) {
-
-			entered_state = call_cpuidle_s2idle(drv, dev);
-			if (entered_state > 0)
-				goto exit_idle;
-
-			max_latency_ns = U64_MAX;
-		} else {
-			max_latency_ns = dev->forced_idle_latency_limit_ns;
-		}
-
-		tick_nohz_idle_stop_tick();
+	if (cpuidle_paused())
+		goto default_idle;
 
-		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
-		call_cpuidle(drv, dev, next_state);
+	if (dev->forced_idle_latency_limit_ns) {
+		cpuidle_deepest_state(drv, dev,
+				      dev->forced_idle_latency_limit_ns);
 	} else {
 		bool stop_tick = true;
 
-- 
2.25.1

