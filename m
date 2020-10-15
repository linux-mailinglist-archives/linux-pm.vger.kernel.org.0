Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A419C28F50E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 16:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbgJOOor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388847AbgJOOor (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 10:44:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F20C0613D6
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so3772258wrm.13
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ns1m02lPSeh1tASLMlG6AU/degRmJ6UjKHjGB53b4n0=;
        b=ImcZK/ARIbT0i2dvRMtgGG1LbPKKa0EY0UfHjZ0tLJaYMylqk+PF13oLbny4hJBQDd
         CX5wqqnjlLEGNbFT5L/JIAHUxak4XiyoUwWz+13okIJQvXpW8p1doR1a3Iq2KFEuxH0f
         jIYYsEG4jzLCFd1jwlntJiW5Nro0SFcb61gx5pHpDvVyXvBJKAI9r+9L/On/zOw+z/GS
         yU67f4q9DwVgUFzifjU4kFFM39y7QjsNiGTW5JnjlUOasAvxTP99J3xJq6ylyruzOnqu
         G21fReacEZCUbgSr8XM4NDXWv65zXsTMSiLNnk1B1tleuDoWtYqGrKKD/8PTSiy5NODe
         rgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ns1m02lPSeh1tASLMlG6AU/degRmJ6UjKHjGB53b4n0=;
        b=A3Jsz8HNX77Bz7jTqh31+7JfaLfhZsKDMfO6iAUamB4Pxqb5ajxR/7OHgE5kBtXFQW
         pE/xJ5y1Wz+c5mk5KZyCr3M2Y+YLfND7ldCggBK3NZ9XI20RL8yICIcn3tMzayLxAKGc
         Jdm7UV9Vb05boqlpMQiIBpkvKEFTUoOynWT3wNQBj0S+jT3R7PUy8ppex355iOm63KoC
         zl/3+Uoek+ROrk1wi8VhrDy6hGF8AqNJVuyac3O85y0AN6wtk2WY8BwzNEg9TB6QDh4G
         ttvPd8IpD09o9eUsIlq5R+N2KZ1sWM9nJeDtnfMRpxLAAc7zotc/YAr4sS6hWUNQRr/E
         ixXg==
X-Gm-Message-State: AOAM532OKatU81Y09M9XNgBA8AJPTSYp43QGRfW5rD3jnTXARfxtdL5d
        HGVs4L0tkvhpTOvvYd/TudxqSg==
X-Google-Smtp-Source: ABdhPJwB1QuSwWGogwylyajeyd69XloX/G8jxuUJoAwxApFMv3mghUJjPBmy4MPv54zYfFZ5OVKm8A==
X-Received: by 2002:adf:c3cd:: with SMTP id d13mr4694475wrg.15.1602773084737;
        Thu, 15 Oct 2020 07:44:44 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-134-136.adsl.proxad.net. [82.252.134.136])
        by smtp.gmail.com with ESMTPSA id 40sm5053800wrc.46.2020.10.15.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:44:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org
Subject: [PATCH 4/5] cpuidle: governor: Export the needed symbols
Date:   Thu, 15 Oct 2020 16:44:30 +0200
Message-Id: <20201015144431.9979-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144431.9979-1-daniel.lezcano@linaro.org>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the next patch, the governors will be converted to modules. Export
the symbols of the different functions used by the governors.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governor.c | 3 +++
 include/linux/tick.h       | 2 ++
 kernel/sched/core.c        | 1 +
 kernel/time/tick-sched.c   | 9 +++++++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 6ec27ef096f5..2791fe352f51 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -120,6 +120,7 @@ void cpuidle_unregister_governor(struct cpuidle_governor *gov)
 
 	mutex_unlock(&cpuidle_lock);
 }
+EXPORT_SYMBOL(cpuidle_unregister_governor);
 
 /**
  * cpuidle_register_governor - registers a governor
@@ -150,6 +151,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
 
 	return ret;
 }
+EXPORT_SYMBOL(cpuidle_register_governor);
 
 /**
  * cpuidle_governor_latency_req - Compute a latency constraint for CPU
@@ -166,3 +168,4 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 
 	return (s64)device_req * NSEC_PER_USEC;
 }
+EXPORT_SYMBOL(cpuidle_governor_latency_req);
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613c7eff..8349ba050b9c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -124,6 +124,7 @@ enum tick_dep_bits {
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
+extern bool tick_nohz_is_enabled(void);
 extern bool tick_nohz_tick_stopped(void);
 extern bool tick_nohz_tick_stopped_cpu(int cpu);
 extern void tick_nohz_idle_stop_tick(void);
@@ -149,6 +150,7 @@ static inline void tick_nohz_idle_stop_tick_protected(void)
 
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
+static inline int tick_nohz_is_enabled(void) { return 0 };
 static inline int tick_nohz_tick_stopped(void) { return 0; }
 static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
 static inline void tick_nohz_idle_stop_tick(void) { }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3f4644..ceba61bb364d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3838,6 +3838,7 @@ unsigned long nr_iowait_cpu(int cpu)
 {
 	return atomic_read(&cpu_rq(cpu)->nr_iowait);
 }
+EXPORT_SYMBOL_GPL(nr_iowait_cpu);
 
 /*
  * IO-wait accounting, and how its mostly bollocks (on SMP).
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4ba1ad..537716124d46 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -500,12 +500,19 @@ static int __init setup_tick_nohz(char *str)
 
 __setup("nohz=", setup_tick_nohz);
 
+bool tick_nohz_is_enabled(void)
+{
+	return tick_nohz_enabled;
+}
+EXPORT_SYMBOL_GPL(tick_nohz_is_enabled);
+
 bool tick_nohz_tick_stopped(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	return ts->tick_stopped;
 }
+EXPORT_SYMBOL_GPL(tick_nohz_tick_stopped);
 
 bool tick_nohz_tick_stopped_cpu(int cpu)
 {
@@ -1066,6 +1073,7 @@ bool tick_nohz_idle_got_tick(void)
 	}
 	return false;
 }
+EXPORT_SYMBOL_GPL(tick_nohz_idle_got_tick);
 
 /**
  * tick_nohz_get_next_hrtimer - return the next expiration time for the hrtimer
@@ -1117,6 +1125,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 
 	return ktime_sub(next_event, now);
 }
+EXPORT_SYMBOL_GPL(tick_nohz_get_sleep_length);
 
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
-- 
2.17.1

