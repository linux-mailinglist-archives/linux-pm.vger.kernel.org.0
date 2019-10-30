Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB861E9767
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJ3Hvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 03:51:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46329 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfJ3Hvw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 03:51:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so1079047wrw.13
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dHBCLxQkG9LNvtfSsjY+Tj1w31CstLD8dsr/LClK51s=;
        b=h5sMJ2JGuiWmie339WTaqqWjq3k4RHL0GD9MgGQLxWp6AvDjeDynXtCvr5A0ZV0bVY
         rM0dLkZ6YDga9XevieLAclSdsMv1sGeLatVPiuRfpFIXoI2cHR461v142oABCwHgBqye
         kMgZF+i8u5zW/2cRjPbg0EmFQu1adD+Ilo8+5spSINVvgdnGrDaGoz+xWbUYuVhpWJRD
         LGbkeyfuSGaD/CkJ4bK76D+gy6rLEQxG7VErElE4oKAi5TXFDOjKLcpmkkSEPly6BFJW
         JGWhVnJgnErfa3mFM39PlWCiWmO+jLy6TptkkYTHh2Qecyf5ueszmLyU/KEu9o0/zEUB
         L+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dHBCLxQkG9LNvtfSsjY+Tj1w31CstLD8dsr/LClK51s=;
        b=ti1oa1aPooF9Sef0s52CBFMgNeIe9hsvldzmJMZthPqOepd/sJdhd0sGGLi04TbjpI
         gLPMAvG/LEgTeEaTZ+EMo5Xf4PoVkor4e2tXSelo7kuaq4SdsLdcz8aICqLu0cNBZbQQ
         n/25vI2zgO+VEB5Bvdwt0HRFPDls1CZVtjlnB4TJSsQ9KCwRBkw830GmHQ4Y2yihUeAt
         C9djE0S/cslpIPFOd4ARS4T6tkBe3p6JO/AqPE5CHk3ENOKG/F+UomWtZF7XEr/8YV7o
         3EagQZ1ZZJZ3Gxp+Vo8AW5c0k++OA0mDBp8BfxGCqTLHSJorpO9xme11U1vLQ5skwSk1
         Flyg==
X-Gm-Message-State: APjAAAU00eERZkK/9o7IgUK5VQyqC9a5/H5sEF6Z8UsAQHIshSoM2hq3
        ypT+Fn6RFestIBdK2lNfGvtzkA==
X-Google-Smtp-Source: APXvYqylTMVL5RLP/JMrf42pdZ+IB2tLiHX2DrlSnTXln1rapuXDxWtqZBcF2Dw1nYl0xNsoVe82Ig==
X-Received: by 2002:a5d:544d:: with SMTP id w13mr23937797wrv.19.1572421909082;
        Wed, 30 Oct 2019 00:51:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2c7f:2fc:5551:ee55])
        by smtp.gmail.com with ESMTPSA id q11sm1114387wmq.21.2019.10.30.00.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:51:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V6 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Wed, 30 Oct 2019 08:51:40 +0100
Message-Id: <20191030075141.1039-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030075141.1039-1-daniel.lezcano@linaro.org>
References: <20191030075141.1039-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the play_idle function does not allow to tell which idle
state we want to go. Improve this by passing the idle state as
parameter to the function.

Export cpuidle_find_deepest_state() symbol as it is used from the
intel_powerclamp driver as a module.

There is no functional changes, the cpuidle state is the deepest one.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
  V6:
   - Change variable name 'state' -> 'index':
     https://lkml.org/lkml/2019/10/28/874
  V4:
   - Add EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state) for the
     intel_powerclamp driver when this one is compiled as a module
  V3:
   - Add missing cpuidle.h header
---
 drivers/cpuidle/cpuidle.c                | 1 +
 drivers/powercap/idle_inject.c           | 4 +++-
 drivers/thermal/intel/intel_powerclamp.c | 4 +++-
 include/linux/cpu.h                      | 2 +-
 kernel/sched/idle.c                      | 4 ++--
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 18523ea6b11b..b871fc2e8e67 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -126,6 +126,7 @@ int cpuidle_find_deepest_state(void)
 
 	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
 }
+EXPORT_SYMBOL_GPL(cpuidle_find_deepest_state);
 
 #ifdef CONFIG_SUSPEND
 static void enter_s2idle_proper(struct cpuidle_driver *drv,
diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..233c878cbf46 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -38,6 +38,7 @@
 #define pr_fmt(fmt) "ii_dev: " fmt
 
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/hrtimer.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
@@ -138,7 +139,8 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_us));
+	play_idle(READ_ONCE(ii_dev->idle_duration_us),
+		  cpuidle_find_deepest_state());
 }
 
 /**
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 53216dcbe173..b55786c169ae 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/thermal.h>
 #include <linux/slab.h>
 #include <linux/tick.h>
@@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
 	if (should_skip)
 		goto balance;
 
-	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
+	play_idle(jiffies_to_usecs(w_data->duration_jiffies),
+		  cpuidle_find_deepest_state());
 
 balance:
 	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d0633ebdaa9c..6f5df0b3641a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_us);
+void play_idle(unsigned long duration_us, int index);
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index fb9fc93f1497..eb9e93b37a97 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -314,7 +314,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle(unsigned long duration_us, int index)
 {
 	struct idle_timer it;
 
@@ -331,7 +331,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_state(cpuidle_find_deepest_state());
+	cpuidle_use_state(index);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.17.1

