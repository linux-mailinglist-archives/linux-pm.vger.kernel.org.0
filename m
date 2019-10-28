Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065EDE73B9
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 15:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390132AbfJ1Oea (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 10:34:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35830 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390127AbfJ1Oea (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 10:34:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id x5so2143808wmi.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BEYu7m/BP15PKxS3B/UgDB/KRkLT0CCRGNyhfdY7cDM=;
        b=Wys/SgWUXZA1zYzmzVS6ULJQ+rZkhvNARj/2aQx3Um+V5En3UGIAUu5lPaAq6NlAoC
         oXnZzYO1AIRzADf997O87rUnvIOU5cxuJ8WhHTPVAZUpKxpsafFeXDIFDeRYePVcuJMd
         ncbSTz05rd692UnYqEoD9+YWYIW5LMsdew9vFFhtU18msfjeYJfonuLa5m259cgEKyje
         SEWRJhnlKeZ56uomr6cJby2wzWmLizFDMdnB5/ox+FzMWfZqoBeU3hkRhrSA2e1MA/MB
         YjVW2DiYtI5UlBW8CrK7NHf+LKIiOmyJwPdfD2UazoqsmUwiVCWkjqtdrvgzWXx79lL3
         GaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BEYu7m/BP15PKxS3B/UgDB/KRkLT0CCRGNyhfdY7cDM=;
        b=LIayvr2HHVEk4aJiryIEmsx3drjvEqfUfR98xvfQDd6TycOBeYjnnDFjr8nDZJhx8E
         ziznuRy3iqux4zT/kA3d0SLhW9TL8YmkuUR1k8QRKqe9fp+iZ0et64hVVEeZau6q15NS
         RQmtDdIXX9MUBWjh34iQEE8pqQWV//8w1uzVZilbguqz0vsO/15bIs3teLNT7Hyz7AFE
         UgtXoKYH2DRRM2B1U1LxaosL45ar4ineGhAdmEsrHVKhVtckAMDRLym1MvseDhkXtTzi
         hCnNdM+KlVBgBY24sYtSDfkR16QPaRAAQRp1C2Oa0xhJGP1+NYUUHtS1ZjHehUM7sosc
         SqoQ==
X-Gm-Message-State: APjAAAWIzmmCE78Hpk3OLo5drd2iBIW7j0umzDtulAwVa/7UdTBssODy
        UCu4b8DV35F8YMbHYfQ0Mi1HFg==
X-Google-Smtp-Source: APXvYqw/Rz1E14kfnWirGGYn7JTX/0QpzRHnvSQKGEFhux5jdWCMpKgGmfoZRG/bs0HLPhi4vTirdA==
X-Received: by 2002:a1c:48c4:: with SMTP id v187mr267338wma.27.1572273267709;
        Mon, 28 Oct 2019 07:34:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d48d:c917:1f3e:4a87])
        by smtp.gmail.com with ESMTPSA id g5sm14166144wmg.12.2019.10.28.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 07:34:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V5 1/3] cpuidle: play_idle: Make play_idle more flexible
Date:   Mon, 28 Oct 2019 15:34:17 +0100
Message-Id: <20191028143419.16236-1-daniel.lezcano@linaro.org>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>
---
  V5:
   - Fix s2idle default idle state value:
     https://lkml.org/lkml/2019/10/15/522
---
 drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
 include/linux/cpuidle.h   | 13 ++++++-------
 kernel/sched/idle.c       | 11 +++++++----
 3 files changed, 24 insertions(+), 21 deletions(-)

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
index 4b6b5bea8f79..b5602ab28601 100644
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
index 8dad5aa600ea..fc7f5216b579 100644
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
 
@@ -176,12 +177,14 @@ static void cpuidle_idle_call(void)
 			}
 
 			rcu_idle_exit();
+			next_state = cpuidle_find_deepest_state();
+		} else {
+			next_state = dev->use_state;
 		}
 
 		tick_nohz_idle_stop_tick();
 		rcu_idle_enter();
 
-		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
 		bool stop_tick = true;
@@ -328,7 +331,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(true);
+	cpuidle_use_state(cpuidle_find_deepest_state());
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -339,7 +342,7 @@ void play_idle(unsigned long duration_us)
 	while (!READ_ONCE(it.done))
 		do_idle();
 
-	cpuidle_use_deepest_state(false);
+	cpuidle_use_state(CPUIDLE_STATE_NOUSE);
 	current->flags &= ~PF_IDLE;
 
 	preempt_fold_need_resched();
-- 
2.17.1

