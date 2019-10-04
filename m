Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95461CB634
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbfJDIcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 04:32:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50973 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfJDIcq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 04:32:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so4866358wmg.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 01:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uHtN2KXg7csKh0URhIaVh4s7+YGI4rv+4/HJKnQimAk=;
        b=efZ/l09IxEYYv4a/hJ1ShKs5ROhMTgZVYiI2UmVudReioN0INj79IdyA1YLTqaKjdU
         R85CI/nMyCs0pj2FYsyDGYgtbbS0ZzUdlkTaaw3shGGWavs/dJhOHpwSXNFQVl8QRNGz
         3hE3o5PBHB4/mDthrTC9fMwBeMyo5/CJplg1nTwjIjWLIEDiiHGrD2GnmwvIzS3lUWOH
         11dEBnrsnE6OcUesIY9VdGArID7bbpIT+gVsl4lB9DGhbtf8jebAwnBapV3aGwEFj5Je
         SicEA40oONMKb9WayHKe0YkOgYK470O0O2ZMKNJBrFTxYisie7jwoCkdJlfwe384b3Lc
         UgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uHtN2KXg7csKh0URhIaVh4s7+YGI4rv+4/HJKnQimAk=;
        b=d9sc+xGnY1cilYHqS1fJxp4Y+yqueAGZFvgGZh0E3tWyZTV+u3r+oaXjpWRHYbE5Ie
         YDsKfplD9bDeIy+gCvoZmJBwBPWbTf/PLl71ZjX6pmcp/GXAMnCBSOLHf3tvriqmCpfT
         Gb4BeGxcVjkyuuubTqNtRndEum59gXhvl3hQ9N6FwOhbZEJ2o4HpMFHL5aqJk1pHL2ar
         U6K+sgWwbbUE+UpwHp+ywTIo8MAzZoLFp8CTdPhTlCUaV/txo4AghrlBXhm0rdSnG+CD
         Ws5/oRcUIizM9JkHM9aOJbx3EyiDz9VSSdSP00I1JCMgtiyDFRh2/R2zsC+1TrAZRT7J
         h+Ig==
X-Gm-Message-State: APjAAAX1pR7VbkRcon/XMrswrrVSMrmnxv+6maV4NlPkFMX7n6GYkWfY
        hajQWHBPMDbH0/zmFbcLZacAQw==
X-Google-Smtp-Source: APXvYqwJnjCRZKWVHF3uoTgFE2tUYZlg5wj1aIUzlB4L/JOqO6EYeEcXVIxdXW6rUSJ2LpdDyQZYnw==
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr10198941wmg.138.1570177961872;
        Fri, 04 Oct 2019 01:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:15f7:68ed:c037:86e6])
        by smtp.gmail.com with ESMTPSA id 59sm6488304wrc.23.2019.10.04.01.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 01:32:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V4 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Fri,  4 Oct 2019 10:32:04 +0200
Message-Id: <20191004083205.29302-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004083205.29302-1-daniel.lezcano@linaro.org>
References: <20191004083205.29302-1-daniel.lezcano@linaro.org>
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
index 88dc0c653925..76e3038b63ce 100644
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
index 17da9cb309e1..ead439dab2b5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle(unsigned long duration_us, int state)
 {
 	struct idle_timer it;
 
@@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_state(cpuidle_find_deepest_state());
+	cpuidle_use_state(state);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.17.1

