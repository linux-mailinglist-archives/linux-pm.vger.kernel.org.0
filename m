Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEAFE9766
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJ3Hvv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 03:51:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39848 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3Hvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 03:51:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so1116183wra.6
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BZNIcki3Cc1NFt4MdJedERahJMNfTWN5VN23v6fFhks=;
        b=MVvgsmb0yiuED+rnzOJkbrXwPIK5RV1j41jBfmNjk9r+UnsVn4cUFv3msOgZBAFX61
         ZYcI3CwAijFxSnDT7kFJ9MMhdOOTgqth/I3X11+y9kjSR7+nzqN0rvewE+ue7+LOtbFo
         Zanf2lRAuBqY4BWx7kgLaesAR0fhaIY3QaLdwDNafzrKnS5IDCDEnKx+AjcJubjocWTv
         vf7g6RvNnV3ecQRtraFgica2HgGaig87ScG89cn/k/ybCN94n/YLxMpK4Jkk4s0Z5RFh
         /wtBt7HxSPsd31G2AXhYyoJz0x+IxQRtJfv8TgprpDNGNWOEpj1Q8PAclZ3rNezVzAhU
         UVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BZNIcki3Cc1NFt4MdJedERahJMNfTWN5VN23v6fFhks=;
        b=cGOAjhLo+8jXA7dQSybmYL74GzaKT3IkVmhmMnfG/OhCy0n8alPDcFzpy4GjcALVXx
         AYylHANqyvf0AiFfUFbQ+d9NDeLrdjBlN+Gu347VBOla19UBxbBX0qOk7xTmRzE1EEj3
         poFjzg+9ChlW4xBO5+Nv5YGefnhpjT8286psPCoKB7ML2g6z7i67Nt8xEhUEuEFSu9ZT
         siSFhHp817BYYKpUVNaOxTSl+M4/5Tg0AJUhE/SeqDIidMFa011bKteIeZnrNGVbFJXV
         Qt6+1IG3CkzIYw2uznMU1ioWdQxUXXmzugqlz+DTGHIcPWyusqEpjoYlQ0DBeWrZBqzB
         atcg==
X-Gm-Message-State: APjAAAV8K2qVbSn8V+n7k62svUFaENFOBDfv6UuwN3xHOhWCbPP/tKkT
        LLm15PyShmUASt05bj+e5osuyUvJ3qU=
X-Google-Smtp-Source: APXvYqyjg//d7J+YDBLJIAIjQRZoBGCYKZq3U2W012p7z9HX6FrarhqQgwXpDpTgxjxjPRgPTSDBmw==
X-Received: by 2002:adf:e651:: with SMTP id b17mr22037702wrn.191.1572421907822;
        Wed, 30 Oct 2019 00:51:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2c7f:2fc:5551:ee55])
        by smtp.gmail.com with ESMTPSA id q11sm1114387wmq.21.2019.10.30.00.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:51:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V6 1/3] cpuidle: play_idle: Make play_idle more flexible
Date:   Wed, 30 Oct 2019 08:51:39 +0100
Message-Id: <20191030075141.1039-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
  V6:
   - Change use_state variable name by use_state_idx:
     https://lkml.org/lkml/2019/10/28/874
  V5:
   - Fix s2idle default idle state value:
     https://lkml.org/lkml/2019/10/15/522
---
 drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
 include/linux/cpuidle.h   | 13 ++++++-------
 kernel/sched/idle.c       | 11 +++++++----
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0895b988fa92..18523ea6b11b 100644
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
+void cpuidle_use_state(int index)
 {
 	struct cpuidle_device *dev;
 
 	preempt_disable();
 	dev = cpuidle_get_device();
 	if (dev)
-		dev->use_deepest_state = enable;
+		dev->use_state_idx = index;
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
+	dev->use_state_idx = CPUIDLE_STATE_NOUSE;
 	dev->last_residency = 0;
 	dev->next_hrtimer = 0;
 }
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4b6b5bea8f79..d53ad36cb2de 100644
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
 
+	int			use_state_idx;
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
+extern void cpuidle_use_state(int index);
 #else
-static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-					     struct cpuidle_device *dev)
+static inline int cpuidle_find_deepest_state(void)
 {return -ENODEV; }
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable)
+static inline void cpuidle_use_state(int index)
 {
 }
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa600ea..fb9fc93f1497 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -165,7 +165,8 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 
-	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
+	if (idle_should_enter_s2idle() ||
+	    dev->use_state_idx != CPUIDLE_STATE_NOUSE) {
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -176,12 +177,14 @@ static void cpuidle_idle_call(void)
 			}
 
 			rcu_idle_exit();
+			next_state = cpuidle_find_deepest_state();
+		} else {
+			next_state = dev->use_state_idx;
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

