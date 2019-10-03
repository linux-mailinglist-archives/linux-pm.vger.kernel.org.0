Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC77C9A24
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2019 10:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfJCInH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Oct 2019 04:43:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35145 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfJCInB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2019 04:43:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id v8so2030414wrt.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2019 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=odawl8FFS06ZpSGBB5Pezvvx3lJRWzOpGgq0TcvgjOg=;
        b=v7y4rzaK0MQgPuMbb5NWETwWGPueVDGszHCqSbJJjVsZxpxHu7xhb1LPnPejnbbkTc
         iR6Q4ZXi25WJIVuZRzzuw8QwvO3ihKaaBoiBhmv6HsczC0bmN8/W56KKK4iGGINj1ICG
         Am9nxP435ym+y+DPS8tkpmF8jdZ8SCangB5ymHZ9GEkscZCMBrmdr7782hFXI8blcfg1
         Dg61klwuoahEFTVByjwtOV//mlPARlGxJSMiSIKS0WRZE2Rl35hh3bEFCuhxbqKFufhm
         TwEbya5lvVOVym3xYPqNflXhm0X2DpUa5ri7tq/sqiL3aDnxM0YWIzL9zY73sA7ezrLq
         vyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=odawl8FFS06ZpSGBB5Pezvvx3lJRWzOpGgq0TcvgjOg=;
        b=iObs89jEr5CxPIQgSIU8NT8dSI9cO/8DOAzKMrnk+rIbAnxPnUXp2cEJ/hLQHxjQJz
         1yojsigjhhGGDeQ/JJF832ShdkUhVsAkQtkNVehjjSy6FaBMcW1VeFyqYLhJNnM4HVPw
         9Z5L0tG2+mhqs/TsgfEoV7OXT0H4S/wtxiuzfH9UfxqLdtslL4WkJDTwDAnUjleCjCmm
         YGCHDVBO7gxTzF7W5SWWdUS69FaLOvQE+OpHP8wqwSlQsoArldBLe8uXs2YZ6yctBAmD
         YLsV7wDAU8YdjwHf6UwIbRCpPaymvBo990f2uFoZYo1t/DBkfsYgXo34O4ilT1LxhH63
         Df7g==
X-Gm-Message-State: APjAAAU8kotXIzbTaEWXF+VFqB05bRrqd+na+cqEESwENctKkWnPCCrl
        LqMpx8iVJTovqPvK+qjMolvfwg==
X-Google-Smtp-Source: APXvYqyS6h77LQAZ5Ic9uRAYKuZ5vXMTKi/BH/kjF+1yzQ7erewqJoV5uVd24xnUUXJz+Ec1i45W2A==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr5813676wre.245.1570092178160;
        Thu, 03 Oct 2019 01:42:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:7990:8bfa:5771:282b])
        by smtp.gmail.com with ESMTPSA id z3sm1519702wmi.30.2019.10.03.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 01:42:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/3] cpuidle: play_idle: Make play_idle more flexible
Date:   Thu,  3 Oct 2019 10:42:39 +0200
Message-Id: <20191003084242.8655-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The play_idle function has two users, the intel powerclamp and the
idle_injection.

The idle injection cooling device uses the function via the
idle_injection powercap's APIs. Unfortunately, play_idle is currently
limited by the idle state depth: by default the deepest idle state is
selected. On the ARM[64] platforms, most of the time it is the cluster
idle state, the exit latency and the residency can be very high. That
reduces the scope of the idle injection usage because the impact on
the performances can be very significant.

If the idle injection cycles can be done with a shallow state like a
retention state, the cooling effect would eventually give similar
results than the cpufreq cooling device.

In order to prepare the function to receive an idle state parameter,
let's replace the 'use_deepest_state' boolean field with 'use_state'
and use this value to enter the specific idle state.

The current code keeps the default behavior which is go to the deepest
idle state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
 include/linux/cpuidle.h   | 13 ++++++-------
 kernel/sched/idle.c       | 10 +++++-----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0895b988fa92..f8b54f277589 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -99,31 +99,31 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 }
 
 /**
- * cpuidle_use_deepest_state - Set/clear governor override flag.
- * @enable: New value of the flag.
+ * cpuidle_use_state - Force the cpuidle framework to enter an idle state.
+ * @state: An integer for an idle state
  *
- * Set/unset the current CPU to use the deepest idle state (override governors
- * going forward if set).
+ * Specify an idle state the cpuidle framework must step in and bypass
+ * the idle state selection process.
  */
-void cpuidle_use_deepest_state(bool enable)
+void cpuidle_use_state(int state)
 {
 	struct cpuidle_device *dev;
 
 	preempt_disable();
 	dev = cpuidle_get_device();
 	if (dev)
-		dev->use_deepest_state = enable;
+		dev->use_state = state;
 	preempt_enable();
 }
 
 /**
  * cpuidle_find_deepest_state - Find the deepest available idle state.
- * @drv: cpuidle driver for the given CPU.
- * @dev: cpuidle device for the given CPU.
  */
-int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev)
+int cpuidle_find_deepest_state(void)
 {
+	struct cpuidle_device *dev = cpuidle_get_device();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
 	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
 }
 
@@ -554,6 +554,7 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 static void __cpuidle_device_init(struct cpuidle_device *dev)
 {
 	memset(dev->states_usage, 0, sizeof(dev->states_usage));
+	dev->use_state = CPUIDLE_STATE_NOUSE;
 	dev->last_residency = 0;
 	dev->next_hrtimer = 0;
 }
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 2dc4c6b19c25..ba0751b26e37 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/hrtimer.h>
 
+#define CPUIDLE_STATE_NOUSE	-1
 #define CPUIDLE_STATE_MAX	10
 #define CPUIDLE_NAME_LEN	16
 #define CPUIDLE_DESC_LEN	32
@@ -80,11 +81,11 @@ struct cpuidle_driver_kobj;
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
-	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
 	ktime_t			next_hrtimer;
 
+	int			use_state;
 	int			last_state_idx;
 	int			last_residency;
 	u64			poll_limit_ns;
@@ -203,19 +204,17 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 #endif
 
 #ifdef CONFIG_CPU_IDLE
-extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev);
+extern int cpuidle_find_deepest_state(void);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
-extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_use_state(int state);
 #else
-static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-					     struct cpuidle_device *dev)
+static inline int cpuidle_find_deepest_state(void)
 {return -ENODEV; }
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable)
+static inline void cpuidle_use_state(int state)
 {
 }
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index b98283fc6914..17da9cb309e1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -165,7 +165,8 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 
-	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
+	if (idle_should_enter_s2idle() ||
+	    dev->use_state != CPUIDLE_STATE_NOUSE) {
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -181,8 +182,7 @@ static void cpuidle_idle_call(void)
 		tick_nohz_idle_stop_tick();
 		rcu_idle_enter();
 
-		next_state = cpuidle_find_deepest_state(drv, dev);
-		call_cpuidle(drv, dev, next_state);
+		call_cpuidle(drv, dev, dev->use_state);
 	} else {
 		bool stop_tick = true;
 
@@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(true);
+	cpuidle_use_state(cpuidle_find_deepest_state());
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
 	while (!READ_ONCE(it.done))
 		do_idle();
 
-	cpuidle_use_deepest_state(false);
+	cpuidle_use_state(CPUIDLE_STATE_NOUSE);
 	current->flags &= ~PF_IDLE;
 
 	preempt_fold_need_resched();
-- 
2.17.1

