Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BDE73BC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 15:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390145AbfJ1Oec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 10:34:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44064 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390130AbfJ1Oec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 10:34:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so10107332wro.11
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4oykr6hhSS8d3p5gLtPenEIbZRgipyeUhU1SI+xjRiw=;
        b=aJ3p1z6EQWyhd80OLGf1tsrUeqZWBC6HyUHS8fwhqb2EzHX+omuOe/u7GDDGpsIrZj
         veqnLHFwjh/YE7AKfRmDF2cOLw2UeINHKYuJaqEBdd0Jl23DaUy5fFiPwntEoPwpeDym
         FeeE7nlcO627qs3lyV4TSGsVaOy/P4LcyH0kkRVJUqum/w7IPpbcit16DZUhqo2mFLI+
         V9a10F6BN8yhtzpA5p9a2eUqnfTOzRUZxT1f5hWmY9tnZ6IZkTVBJDCY8ZAuQFIUd5aK
         NqBB+Z5Q/ero5VMfMe0Q5bO5zVk+GAgMFUGlOUI+66qamQcsLyHu/EWJeOpelKUfeazJ
         OEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4oykr6hhSS8d3p5gLtPenEIbZRgipyeUhU1SI+xjRiw=;
        b=WUWtxzwHTKn2uD5nGEUfrfsA2IUSOfxq+0HwFGkNcP07BZVrKOYq5c6kfUGSU+z99t
         GSToJqEZDllPTAsbNk1/WHKT9ejhYroowcKQp9KfMudfmoKvVIAyAPZt9lZU82nKfm2y
         jp5P/XWMTVdd7SwrFHeyS/vd0XXNjmvOTN2LfOqS+8nJ429L3PT8D1puATrUJpfbTV2N
         86j6UVG1m6cQ+n5KAtf2NXHhkFUCZr9tv8oqxNV12B9AuFTdJNW163p7rkccCgFapaWW
         kAV5Ncb/gpTG58azU46UvjszkDcj/1bpc0i/dzZz5EzX4kQKQmfQU7cn1DG0oP9UcfX4
         NDSA==
X-Gm-Message-State: APjAAAXb7bYXOt3dQlRu+V4m9J01rijJhtmlPh3V/QJrBGq1VuKabcWE
        n1n7wWx+wLcPxod6PbDlc6M7FMNrYI4=
X-Google-Smtp-Source: APXvYqzs5w6Gq4JpiGUgyx01gDWrkBD+EdjVlWYZdkkpEY2vZQrqvohKZMKo+mI/jpPUCQ7yREhuBA==
X-Received: by 2002:adf:f810:: with SMTP id s16mr12632216wrp.127.1572273268819;
        Mon, 28 Oct 2019 07:34:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d48d:c917:1f3e:4a87])
        by smtp.gmail.com with ESMTPSA id g5sm14166144wmg.12.2019.10.28.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 07:34:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V5 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Mon, 28 Oct 2019 15:34:18 +0100
Message-Id: <20191028143419.16236-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028143419.16236-1-daniel.lezcano@linaro.org>
References: <20191028143419.16236-1-daniel.lezcano@linaro.org>
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
---
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
index f8b54f277589..94804e532b9a 100644
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
index d0633ebdaa9c..23478208fc55 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_us);
+void play_idle(unsigned long duration_us, int state);
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index fc7f5216b579..af90abe0c1b3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -314,7 +314,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle(unsigned long duration_us, int state)
 {
 	struct idle_timer it;
 
@@ -331,7 +331,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_state(cpuidle_find_deepest_state());
+	cpuidle_use_state(state);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.17.1

