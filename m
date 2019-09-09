Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65B8ADB82
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2019 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfIIOul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Sep 2019 10:50:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35791 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfIIOuk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2019 10:50:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id n10so15070975wmj.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2019 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6wI7i6Gbnav5uwhJVfDbJMtuedUVCsGJCuf8wyB5XU=;
        b=RPYUZPTibr9AanKGPNcwdNX17NsYLWATLuxjMEKtRtT1pWQURXW6f2mgF1TFpItixz
         M5UWchWOk0NRM/RHgImjKHOJZUK4JLysiH0eFawJBDcI230yHnY1ETiv3v+CCQSl3vvI
         /6j8U20TpRGiBML/ADdwdphRVFpe+HgLtVBIQ1BjxahIPCqBiPSryOiOTheLxs28aZD2
         I68HOko7jM0yTHpCtIreoDuvjioH7CisIifSjkuuOWH64No2MrIhntQh8Bx5pYADiK3x
         EPAS6P/Tk7500SB1z/pmpa3iwRIAYj4aUyWeTfAW67cTEB178VYyf+jDOpT3v598pYVP
         1xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s6wI7i6Gbnav5uwhJVfDbJMtuedUVCsGJCuf8wyB5XU=;
        b=Z/3pfY9lNvErO7HJINJ4ZLwNJUdkDZCR8+0FhpP5dB7W0wUsIitxs/flgiHhqb6XMx
         zdqfptAoTxRNhWqcRo64u4KRKOqmtXJycXsVddBN51RTEmwQUNu1cGcOCxsu+V11LiXL
         uGCmeabTOBqT96wCo/AgsdSiJQl5vMJgUjyOWsPVzFv25TqgA1GcSkmB6KJZvi9HxpjO
         v4ORPfN5ekO7Gw9bzeHXGDl2tQDVRB6ZPrxPJl0Q1TNAxBSabOaRk7lnFCbQAlgg4K16
         v8uR0AkFUCI4pCRwJYyTABfrhtoFmJoTYi7yil+iId4V0P2UQ8wiZW5IdYUwizZfltx6
         JJUA==
X-Gm-Message-State: APjAAAXqyF9Y+e+mXnQ6NUafZO/XzcoHwn1u032S+qgY+Y65SC6dGmld
        2e8DyrvWBXJLQz/gUVJm4e0+5g==
X-Google-Smtp-Source: APXvYqw8s9A4r482jBoWdsTqv3e7ZlIw6KR1ves4iX7uEf32rst4qyckS1lwsm5su/rqLbwNv1uiTA==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr18921446wme.41.1568040638602;
        Mon, 09 Sep 2019 07:50:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:a060:80d2:1467:e511])
        by smtp.gmail.com with ESMTPSA id v2sm31921147wmf.18.2019.09.09.07.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:50:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Mon,  9 Sep 2019 16:50:14 +0200
Message-Id: <20190909145015.26317-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190909145015.26317-1-daniel.lezcano@linaro.org>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, the play_idle function does not allow to tell which idle
state we want to go. Improve this by passing the idle state as
parameter to the function.

There is no functional changes, the cpuidle state is the deepest one.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c           | 3 ++-
 drivers/thermal/intel/intel_powerclamp.c | 4 +++-
 include/linux/cpu.h                      | 2 +-
 kernel/sched/idle.c                      | 4 ++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..9b18667b9f26 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -138,7 +138,8 @@ static void idle_inject_fn(unsigned int cpu)
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

