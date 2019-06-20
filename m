Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0AA4CD4D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2019 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFTL6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 07:58:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45561 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfFTL6s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 07:58:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so2699614wre.12
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yfDIYkJBCGgiuHC89rCxe++p9rIEb8l8SlYDjqLM+j8=;
        b=At5uPzZl0xMy2dBRFM0cR7AjvTOhAy8c4HD5xHZ5VXHJ7agf+p+P4TvgGqzHGQD37R
         t2+A57Vyu61vpCZK5ZzVuUnXPi7ruMILgteZoh5iiTylqQKFsoOnIMFifdmpnfexACqD
         CvOowLPr2LVoKdaCWo7tyFz0PEadScdP4V4rieu9nXPcSmERS/BcFoSZyZgsZ04TZSZo
         eCxKQmMu8A6WRdNaflEctQPanbpQUtH5658Sv4UcIRhNA9CE2/YdEDR4Gr4c3Qyy6BCq
         +uwCsmcQmZRjppnYLGOTtTj5HkQqj0GfRfjWl73XsGO8iky8aRwrTygBYLZ+Lnp5uSkc
         kV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yfDIYkJBCGgiuHC89rCxe++p9rIEb8l8SlYDjqLM+j8=;
        b=KxtBY+HSS3k0PGEq13BrTLky21CAVNdFRmyVZbDk9YsNNozj/CB9OBmIw9OJwJLWLX
         ub6qRgNMfxiWWCCIXcaAum3dmNKlEQKp1RxT0tpBNVD+DMcpr5DYi+GyxNb6V+OUCSjX
         Jd/5n7awITu9JeU/C1H0idLnUvaZCfCMrq/AauGrNsh8C8bA7OuMxDmkRAHQTmXqSDKP
         MbMXBFRvRG6PTsK1bmEBkS+f5a0MaqRH+BiyHzTyInQKe7G0TLWlGZx/JqJmLeZJ+FWO
         4jgzZX2IReCNReFvDBw6cr15qirO+tUQsP5FDzj9nR1B/3hQxKhd+rzIxHv6CtEX8s+A
         X0Kg==
X-Gm-Message-State: APjAAAXsltEXCC+HGchC5iPWBSRr1iBv/8ptLUw+/MDwgazMsWH6OY2F
        ApCkUJooUSjdcYkAf5zcIMD9nA==
X-Google-Smtp-Source: APXvYqze1cywhBggLbeZBfPiDVQbn+WH3AFmR+RCtNEe6XBMFX/W6bKoZsoTaZ7dwVS3nchorD9FwA==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr13513620wrn.316.1561031924778;
        Thu, 20 Jun 2019 04:58:44 -0700 (PDT)
Received: from clegane.local (177.208.130.77.rev.sfr.net. [77.130.208.177])
        by smtp.gmail.com with ESMTPSA id d18sm36370417wrb.90.2019.06.20.04.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:58:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:CPU IDLE TIME MANAGEMENT FRAMEWORK)
Subject: [PATCH] cpuidle/drivers/mobile: Add new governor for mobile/embedded systems
Date:   Thu, 20 Jun 2019 13:58:08 +0200
Message-Id: <20190620115826.4897-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The objective is the same for all the governors: save energy, but at
the end the governors menu, ladder and teo aim to improve the
performances with an acceptable energy drop for some workloads which
are identified for servers and desktops (with the help of a firmware).

The ladder governor is designed for server with a periodic tick
configuration.

The menu governor does not behave nicely with the mobile platform and
the energy saving for the multimedia workloads is worst than picking
up randomly an idle state.

The teo governor acts efficiently, it promotes shallower state for
performances which is perfect for the servers / desktop but inadequate
for mobile because the energy consumed is too high.

It is very difficult to do changes in these governors for embedded
systems without impacting performances on servers/desktops or ruin the
optimizations for the workloads on these platforms.

The mobile governor is a new governor targeting embedded systems
running on battery where the energy saving has a higher priority than
servers or desktops. This governor aims to save energy as much as
possible but with a performance degradation tolerance.

In this way, we can optimize the governor for specific mobile workload
and more generally embedded systems without impacting other platforms.

The mobile governor is built on top of the paradigm 'separate the wake
up sources signals and analyze them'. Three categories of wake up
signals are identified:
 - deterministic : timers
 - predictable : most of the devices interrupt
 - unpredictable : IPI rescheduling, random signals

The latter needs an iterative approach and the help of the scheduler
to give more input to the governor.

The governor uses the irq timings where we predict the next interrupt
occurrences on the current CPU and the next timer. It is well suited
for mobile and more generally embedded systems where the interrupts
are usually pinned on one CPU and where the power is more important
than the performances.

The multimedia applications on the embedded system spawn multiple
threads which are migrated across the different CPUs and waking
between them up. In order to catch this situation we have also to
track the idle task rescheduling duration with a relative degree of
confidence as the scheduler is involved in the task migrations. The
resched information is in the scope of the governor via the reflect
callback.

The governor begins with a clean foundation basing the prediction on
the irq behavior returned by the irq timings, the timers and the idle
task rescheduling. The advantage of the approach is we have a full
view of the wakeup sources as we identify them separately and then we
can control the situation without relying on biased heuristics.

This first iteration provides a basic prediction but improves on some
mobile platforms better energy for better performance for multimedia
workloads.

The scheduling aspect will be optimized iteratively with non
regression testing for previous identified workloads on an Android
reference platform.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig            |  11 ++-
 drivers/cpuidle/governors/Makefile |   1 +
 drivers/cpuidle/governors/mobile.c | 151 +++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cpuidle/governors/mobile.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index a4ac31e4a58c..e2376d85e288 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -5,7 +5,7 @@ config CPU_IDLE
 	bool "CPU idle PM support"
 	default y if ACPI || PPC_PSERIES
 	select CPU_IDLE_GOV_LADDER if (!NO_HZ && !NO_HZ_IDLE)
-	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO
+	select CPU_IDLE_GOV_MENU if (NO_HZ || NO_HZ_IDLE) && !CPU_IDLE_GOV_TEO && !CPU_IDLE_GOV_MOBILE
 	help
 	  CPU idle is a generic framework for supporting software-controlled
 	  idle processor power management.  It includes modular cross-platform
@@ -33,6 +33,15 @@ config CPU_IDLE_GOV_TEO
 	  Some workloads benefit from using it and it generally should be safe
 	  to use.  Say Y here if you are not happy with the alternatives.
 
+config CPU_IDLE_GOV_MOBILE
+	bool "Mobile governor"
+	select IRQ_TIMINGS
+	help
+	  The mobile governor is based on irq timings measurements and
+	  pattern research combined with the next timer. This governor
+	  suits very well on embedded systems where the interrupts are
+	  grouped on a single core and the power is the priority.
+
 config DT_IDLE_STATES
 	bool
 
diff --git a/drivers/cpuidle/governors/Makefile b/drivers/cpuidle/governors/Makefile
index 42f44cc610dd..f09da7178670 100644
--- a/drivers/cpuidle/governors/Makefile
+++ b/drivers/cpuidle/governors/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_CPU_IDLE_GOV_LADDER) += ladder.o
 obj-$(CONFIG_CPU_IDLE_GOV_MENU) += menu.o
 obj-$(CONFIG_CPU_IDLE_GOV_TEO) += teo.o
+obj-$(CONFIG_CPU_IDLE_GOV_MOBILE) += mobile.o
diff --git a/drivers/cpuidle/governors/mobile.c b/drivers/cpuidle/governors/mobile.c
new file mode 100644
index 000000000000..8fda0f9b960b
--- /dev/null
+++ b/drivers/cpuidle/governors/mobile.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019, Linaro Ltd
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+#include <linux/cpuidle.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/tick.h>
+#include <linux/interrupt.h>
+#include <linux/sched/clock.h>
+
+struct mobile_device {
+	u64 idle_ema_avg;
+	u64 idle_total;
+	unsigned long last_jiffies;
+};
+
+#define EMA_ALPHA_VAL		64
+#define EMA_ALPHA_SHIFT		7
+#define MAX_RESCHED_INTERVAL_MS	100
+
+static DEFINE_PER_CPU(struct mobile_device, mobile_devices);
+
+static int mobile_ema_new(s64 value, s64 ema_old)
+{
+	if (likely(ema_old))
+		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
+				  EMA_ALPHA_SHIFT);
+	return value;
+}
+
+static void mobile_reflect(struct cpuidle_device *dev, int index)
+{
+        struct mobile_device *mobile_dev = this_cpu_ptr(&mobile_devices);
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	struct cpuidle_state *s = &drv->states[index];
+	int residency;
+
+	/*
+	 * The idle task was not rescheduled since
+	 * MAX_RESCHED_INTERVAL_MS, let's consider the duration is
+	 * long enough to clear our stats.
+	 */
+	if (time_after(jiffies, mobile_dev->last_jiffies +
+		       msecs_to_jiffies(MAX_RESCHED_INTERVAL_MS)))
+		mobile_dev->idle_ema_avg = 0;
+
+	/*
+	 * Sum all the residencies in order to compute the total
+	 * duration of the idle task.
+	 */
+	residency = dev->last_residency - s->exit_latency;
+	if (residency > 0)
+		mobile_dev->idle_total += residency;
+
+	/*
+	 * We exited the idle state with the need_resched() flag, the
+	 * idle task will be rescheduled, so store the duration the
+	 * idle task was scheduled in an exponential moving average and
+	 * reset the total of the idle duration.
+	 */
+	if (need_resched()) {
+		mobile_dev->idle_ema_avg = mobile_ema_new(mobile_dev->idle_total,
+						      mobile_dev->idle_ema_avg);
+		mobile_dev->idle_total = 0;
+		mobile_dev->last_jiffies = jiffies;
+	}
+}
+
+static int mobile_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       bool *stop_tick)
+{
+	struct mobile_device *mobile_dev = this_cpu_ptr(&mobile_devices);
+	int latency_req = cpuidle_governor_latency_req(dev->cpu);
+	int i, index = 0;
+	ktime_t delta_next;
+	u64 now, irq_length, timer_length;
+	u64 idle_duration_us;
+
+	/*
+	 * Get the present time as reference for the next steps
+	 */
+	now = local_clock();
+
+	/*
+	 * Get the next interrupt event giving the 'now' as a
+	 * reference, if the next event appears to have already
+	 * expired then we get the 'now' returned which ends up with a
+	 * zero duration.
+	 */
+	irq_length = irq_timings_next_event(now) - now;
+
+	/*
+	 * Get the timer duration before expiration.
+	 */
+	timer_length = ktime_to_ns(tick_nohz_get_sleep_length(&delta_next));
+
+	/*
+	 * Get the smallest duration between the timer and the irq next event.
+	 */
+	idle_duration_us = min_t(u64, irq_length, timer_length) / NSEC_PER_USEC;
+
+	/*
+	 * Get the idle task duration average if the information is
+	 * available.
+	 */
+	if (mobile_dev->idle_ema_avg)
+		idle_duration_us = min_t(u64, idle_duration_us,
+					 mobile_dev->idle_ema_avg);
+
+	for (i = 0; i < drv->state_count; i++) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		if (s->disabled || su->disable)
+			continue;
+
+		if (s->exit_latency > latency_req)
+			break;
+
+		if (idle_duration_us > s->exit_latency)
+			idle_duration_us = idle_duration_us - s->exit_latency;
+
+		if (s->target_residency > idle_duration_us)
+			break;
+
+		index = i;
+	}
+
+	if (!index)
+		*stop_tick = false;
+
+	return index;
+}
+
+static struct cpuidle_governor mobile_governor = {
+	.name =		"mobile",
+	.rating =	20,
+	.select =	mobile_select,
+	.reflect =	mobile_reflect,
+};
+
+static int __init init_governor(void)
+{
+	irq_timings_enable();
+	return cpuidle_register_governor(&mobile_governor);
+}
+
+postcore_initcall(init_governor);
-- 
2.17.1

