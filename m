Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80264FEC68
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2019 14:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKPNQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Nov 2019 08:16:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39948 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfKPNQX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Nov 2019 08:16:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id q15so1121144wrw.7
        for <linux-pm@vger.kernel.org>; Sat, 16 Nov 2019 05:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tg11cTivSk8CuEqGhmHmDNWvHOysA3jwYAGlqgKbG4c=;
        b=GirAD+vKxjyd5OFXVVcD73825caTPpQT3zyFYDhPJmQP2+wOrhtIH3Doi0c7zREGmj
         p1x6DfxjpOLX2Ec/MslH8bQpMTPbvFPrhqstclENzGsx0jJYmeY5UEyKA6dHgIiY//JO
         qaPC2I+05TfMDm+138SK6j7be0b1aPpocydbxi9HCLMjnzIn4mMkLZM9ZnCFo5suca69
         ACNkNHfQ9WqlB2ALMDyfuZxiVeCeo59RziqRDnhbm2dRmRDJz0+puD1RaeHpMVQqaa7I
         8jXOn8UpiFOcHYJF2dF+w3bE/PCL00vm7vWt1xjNkRbUrosteggtbrGXWf3hxv8RpxPS
         cI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tg11cTivSk8CuEqGhmHmDNWvHOysA3jwYAGlqgKbG4c=;
        b=R1K6SXDb5GZXlGwB9RsGDEKrrD+UPIRW+zNsqtQ9R5z4bKtaaf0bRSt5TKhbiNuo75
         NKATATIvo7JdOfSnmXJy7aNHVb9juFcfDc5/EzQOcUicMJSM6jgq6s3Yoi7nwduFVKoJ
         kRCxvXIni+MR/9QaFHrNr2gx1liMxwa4frXKiJausEV4+cOnAGvDkLAz+ePUqytFrrcL
         r3HiHv9q/WyYL7JAuO06/7SfZ0h05QQroU64BuJBgY8XJ/DGk8YS7/qVlEvX0VgfHnuu
         JheVXvPPN5vLpNecVQRrV3cDh2tVH/Gx3/DvBFH1Jn6aTpBWDzWXsee585r3XUOZWlsr
         B5cw==
X-Gm-Message-State: APjAAAU7bgeJvbr8br0k2+eyKrZRW8jCpmWIoqo83hANBBAFmOwtSCvk
        R74sRfb+WuehmYRpZ9hSB2Avyg==
X-Google-Smtp-Source: APXvYqyHW5ijIPfL2Ep4+ox47SbxoujUX+av53dHNyM6NeuTcEWIcEELLwtuNXkWHbejHNtn0zWz/Q==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr19691490wrw.291.1573910180022;
        Sat, 16 Nov 2019 05:16:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:b462:d85e:9aab:bc1d])
        by smtp.gmail.com with ESMTPSA id r2sm11128914wma.44.2019.11.16.05.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 05:16:19 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V2 1/2] cpuidle: Replace use_deepest_state flag by forced_idle_latency_limit_ns
Date:   Sat, 16 Nov 2019 14:16:12 +0100
Message-Id: <20191116131613.15733-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We want to specify a latency constraint when choosing an idle state at
play_idle time. Instead of duplicating the information in the
structure or propagate the latency in the call stack, change the
use_deepest_state by forced_latency_limit_ns to introduce this
constraint. The idea being that when it is set, idle is forced
(i.e. no governors), but there is a latency limit for the state to
use.

A zero latency constraint means "do not use the deepest idle state
path" as the 'use_deepest_state' boolean was used in the
cpuidle_idle_call.

In addition add the play_idle_precise() function getting a nanosec
base latency constraint as parameter. The play_idle() function becomes
a wrapper passing an U64_MAX to play_idle_precise().

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 10 +++++-----
 include/linux/cpu.h       |  6 +++++-
 include/linux/cpuidle.h   |  6 +++---
 kernel/sched/idle.c       | 14 +++++++-------
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 44ae39f2b47a..62226fadc02d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -100,19 +100,19 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 
 /**
  * cpuidle_use_deepest_state - Set/clear governor override flag.
- * @enable: New value of the flag.
+ * @latency_limit_ns: A latency limit constraint
  *
- * Set/unset the current CPU to use the deepest idle state (override governors
- * going forward if set).
+ * Set/unset the current CPU to use the deepest idle state with the exit
+ * latency within @latency_limit_ns
  */
-void cpuidle_use_deepest_state(bool enable)
+void cpuidle_use_deepest_state(u64 latency_limit_ns)
 {
 	struct cpuidle_device *dev;
 
 	preempt_disable();
 	dev = cpuidle_get_device();
 	if (dev)
-		dev->use_deepest_state = enable;
+		dev->forced_idle_latency_limit_ns = latency_limit_ns;
 	preempt_enable();
 }
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d0633ebdaa9c..4c9694e209a5 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,11 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_us);
+void play_idle_precise(u64 duration_ns, u64 latency_ns);
+static inline void play_idle(unsigned long duration_us)
+{
+	play_idle_precise(duration_us * NSEC_PER_USEC, U64_MAX);
+}
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index d23a3b1ddcf6..1f3f4dd01e48 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,7 +83,6 @@ struct cpuidle_driver_kobj;
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
-	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
 	ktime_t			next_hrtimer;
@@ -91,6 +90,7 @@ struct cpuidle_device {
 	int			last_state_idx;
 	int			last_residency;
 	u64			poll_limit_ns;
+	u64			forced_idle_latency_limit_ns;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
@@ -210,7 +210,7 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
-extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
@@ -218,7 +218,7 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable)
+static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
 {
 }
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa600ea..0a817e907192 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -165,7 +165,7 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 
-	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
+	if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle_precise(u64 duration_ns, u64 latency_ns)
 {
 	struct idle_timer it;
 
@@ -323,29 +323,29 @@ void play_idle(unsigned long duration_us)
 	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
 	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
-	WARN_ON_ONCE(!duration_us);
+	WARN_ON_ONCE(!duration_ns);
 
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(true);
+	cpuidle_use_deepest_state(latency_ns);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	it.timer.function = idle_inject_timer_fn;
-	hrtimer_start(&it.timer, ns_to_ktime(duration_us * NSEC_PER_USEC),
+	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
 		      HRTIMER_MODE_REL_PINNED);
 
 	while (!READ_ONCE(it.done))
 		do_idle();
 
-	cpuidle_use_deepest_state(false);
+	cpuidle_use_deepest_state(0);
 	current->flags &= ~PF_IDLE;
 
 	preempt_fold_need_resched();
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(play_idle);
+EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-- 
2.17.1

