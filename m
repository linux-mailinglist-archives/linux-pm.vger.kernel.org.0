Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BC27FFB3
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 19:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405145AbfHBRem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Aug 2019 13:34:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41595 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404979AbfHBRem (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2019 13:34:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so74761114wrm.8
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2019 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bDEOJwb4xqHHfpIDNDHbU9t5ke6F3VYkxQP5lELIP1Y=;
        b=KS5V/XMTVAFkHwFkazN3mS/2TYlFzz8uQwHHuGQd6e/Zr0MJSRa3mbEEl1jIQmElfO
         qRq8JtHiMjTYIJL6E8q2aQInj8YJ6nDwsSRmII09tM976pdVDsZq8jzZ+D/PEPrNCkD4
         b11BNSxIDB2dO78KfCJMVXp6Iw6A2n78MwBWc+reC0heHhoo4rEQjCRt3DWYvSX5YA95
         HHzF3OOWi0GI7WO/NQnJFLvOcEFom5FFjIptwlM82Pn9fn2Tpx1pheq29VYVdvfhDLfd
         dsLnMtSbwJs+HdDYKRXgHcq30PSvXF+ao79CAXp1AOk8PrEnQOzpZpYpWP9F42QkVY3k
         lhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bDEOJwb4xqHHfpIDNDHbU9t5ke6F3VYkxQP5lELIP1Y=;
        b=dXn3tR9IuUCcAgDirPyc80ufVugalYi53Z/Xg1d5mBCIKtGRbchamPr+BQszZeLpJb
         b8q1iSrMLRN0HoWcgsa0ptSoViObgrR6GYaQQVRShDZL1EUq3Da/BmQ5DSW+PNwtYjoX
         nRikBPMOmD5Q7FGPUaLkZGN2bxkwDrQncttN0zI46kV9pDeYNyjwzbubZFMMRrFLdMzm
         93PFqIBIJBMR1Cox+iCbWCxXRHnZMiP7YstOOjmX51hqrVcOqso7pFS4366Ya9Harx6O
         RFA1PTokJtESkcXAFWcibWbd4TplAGRwxqeOjaX+08BXSD4BJFeeyNohG36nem1NDKZV
         WBmg==
X-Gm-Message-State: APjAAAUrEyTop5S6v37JMmhAZdmhJqTZ5fO5aOA4zZ7wscsL/tGyIIaB
        9G/bN+kqMn1zoHpDGLrFNCDpdg==
X-Google-Smtp-Source: APXvYqz4Gh7LpR01MQf4zEjFUcmLL5WBfty/eWNYEKR7CCDJoh64kQU+/HcMx44mqJUe18+6mZrG0w==
X-Received: by 2002:adf:cd84:: with SMTP id q4mr70061248wrj.232.1564767279893;
        Fri, 02 Aug 2019 10:34:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:7d60:82f1:6b3e:4a0])
        by smtp.gmail.com with ESMTPSA id s188sm70856194wmf.40.2019.08.02.10.34.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 10:34:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 1/2] cpuidle: play_idle: Increase the resolution to usec
Date:   Fri,  2 Aug 2019 19:34:23 +0200
Message-Id: <20190802173424.5844-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The play_idle resolution is 1ms. The intel_powerclamp bases the idle
duration on jiffies. The idle injection API is also using msec based
duration but has no user yet.

Unfortunately, msec based time does not fit well when we want to
inject idle cycle precisely with shallow idle state.

In order to set the scene for the incoming idle injection user, move
the precision up to usec when calling play_idle.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c           | 2 +-
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 include/linux/cpu.h                      | 2 +-
 kernel/sched/idle.c                      | 7 ++++---
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 24ff2a068978..10601f4bdf72 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -138,7 +138,7 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_ms));
+	play_idle(READ_ONCE(ii_dev->idle_duration_ms) * USEC_PER_MSEC);
 }
 
 /**
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 5149a817456b..53216dcbe173 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -430,7 +430,7 @@ static void clamp_idle_injection_func(struct kthread_work *work)
 	if (should_skip)
 		goto balance;
 
-	play_idle(jiffies_to_msecs(w_data->duration_jiffies));
+	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
 
 balance:
 	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fcb1386bb0d4..88dc0c653925 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_ms);
+void play_idle(unsigned long duration_us);
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 80940939b733..b98283fc6914 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_ms)
+void play_idle(unsigned long duration_us)
 {
 	struct idle_timer it;
 
@@ -323,7 +323,7 @@ void play_idle(unsigned long duration_ms)
 	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
 	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
-	WARN_ON_ONCE(!duration_ms);
+	WARN_ON_ONCE(!duration_us);
 
 	rcu_sleep_check();
 	preempt_disable();
@@ -333,7 +333,8 @@ void play_idle(unsigned long duration_ms)
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	it.timer.function = idle_inject_timer_fn;
-	hrtimer_start(&it.timer, ms_to_ktime(duration_ms), HRTIMER_MODE_REL_PINNED);
+	hrtimer_start(&it.timer, ns_to_ktime(duration_us * NSEC_PER_USEC),
+		      HRTIMER_MODE_REL_PINNED);
 
 	while (!READ_ONCE(it.done))
 		do_idle();
-- 
2.17.1

