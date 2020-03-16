Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC12187480
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbgCPVLA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 17:11:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36176 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPVLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 17:11:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so19710252wme.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Sv8KUD8zPF4Ir+GRQ+QKJjcC2L7cu/aF4wlwHEeIJbo=;
        b=IXEpOUTNHS7sZ6cutzPW+cVhG0NmA8wCbuEQntuI51hOagKIcgBHVb1EcSQDRq+WDJ
         FezIotv1tQ8WGa+/JgCCGZhb1EXKMn+4PWQOjj0rPEQ2hMhZ8J+64FHw5NP+B/ptV3rw
         FCskGY/RBo3sfYwH1tkSO7PdHL6sb4oDLOr7j1PV24LN9tCrJuKe2GRLY0zrBOMmBPsw
         3dRXA5oIOahoNB3JKDiLTae0qxmhnRSi9FHlpVhMqcNZxaBsi4LRT80S5m0VrZXeNIL5
         h8wn7uVHjmY0drDQIrmxQuLisJcI82Ju8EHhW2SGywECyk9sQQOhRHLmrOf2KTiZ3EOA
         Ipsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sv8KUD8zPF4Ir+GRQ+QKJjcC2L7cu/aF4wlwHEeIJbo=;
        b=URtVJ+aOXjXPL+KHkimnohHZAm9/ZSgThlhQ4rsfkJPGCztvXKyk/HOvAOAXFu8y7E
         2IfFAzDH6sOi/54KmoF5txC71abGpUm860EwBcEcrhw3AWBmjutpSNRLpHFtjoGFaEqG
         1AiZ1lxbuZgkx5KsnHMXprfe0uF8a9f3KBj7UlD1v5O0z5/NY0Jh8lv0lhpSFxS5DHFx
         dwVgdnMuh6w5Ub0SVUzAXkufHYz6IIvWsRUGAv4JPBeP3KwmRTKUOLxgR36uUeL4fAny
         ySHKhFgx/SaD0ojszsDMXG8eoksAGck8P/OVgZ9hcZqsqZu5vlYZq2cFD9cAmrGWpUfW
         oTiQ==
X-Gm-Message-State: ANhLgQ1+JBrj6U6Z3mcrMHkGg1H1UeOUzklMsovsq/s9zeJAiaZijVwd
        fQtBiqoiGb6HywVEMy5AccYeqQ==
X-Google-Smtp-Source: ADFU+vvKMiYLVnpoVxVZzZk6U/ujuWCjK9IDJxDZEprSfFethkUU22Vk4uu56DNfOsGKvD1EVUA9Nw==
X-Received: by 2002:a1c:a714:: with SMTP id q20mr1022374wme.148.1584393058478;
        Mon, 16 Mar 2020 14:10:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:5511:ddba:ffbc:a3c4])
        by smtp.gmail.com with ESMTPSA id q10sm884045wrx.12.2020.03.16.14.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 14:10:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ulf.hansson@linaro.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@kernel.org
Subject: [PATCH RFC] cpuidle: consolidate calls to time capture
Date:   Mon, 16 Mar 2020 22:08:43 +0100
Message-Id: <20200316210843.11678-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few years ago, we changed the code in cpuidle to replace ktime_get()
by a local_clock() to get rid of potential seq lock in the path and an
extra latency.

Meanwhile, the code evolved and we are getting the time in some other
places like the power domain governor and in the future break even
deadline proposal.

Unfortunately, as the time must be compared across the CPU, we have no
other option than using the ktime_get() again. Hopefully, we can
factor out all the calls to local_clock() and ktime_get() into a
single one when the CPU is entering idle as the value will be reuse in
different places.

We can assume the time to go through the code path distance is small
enough between ktime_get() call in the cpuidle_enter() function and
the other users inspecting the value.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/power/domain_governor.c | 4 +++-
 drivers/cpuidle/cpuidle.c            | 6 +++---
 include/linux/cpuidle.h              | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index daa8c7689f7e..bee97f7b7b8d 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -279,8 +279,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 		}
 	}
 
+	dev = per_cpu(cpuidle_devices, smp_processor_id());
+
 	/* The minimum idle duration is from now - until the next wakeup. */
-	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
+	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, dev->idle_start));
 	if (idle_duration_ns <= 0)
 		return false;
 
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c149d9e20dfd..9db14581759b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -206,7 +206,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
-	ktime_t time_start, time_end;
+	ktime_t time_end;
 
 	/*
 	 * Tell the time framework to switch to a broadcast timer because our
@@ -228,14 +228,14 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	sched_idle_set_state(target_state);
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
-	time_start = ns_to_ktime(local_clock());
+	dev->idle_start = ktime_get();
 
 	stop_critical_timings();
 	entered_state = target_state->enter(dev, drv, index);
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
-	time_end = ns_to_ktime(local_clock());
+	time_end = ktime_get();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index ec2ef63771f0..112494658e01 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -89,6 +89,7 @@ struct cpuidle_device {
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
 	ktime_t			next_hrtimer;
+	ktime_t			idle_start;
 
 	int			last_state_idx;
 	u64			last_residency_ns;
-- 
2.17.1

