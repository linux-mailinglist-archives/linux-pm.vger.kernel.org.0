Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F0FB822
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 19:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfKMSyd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 13:54:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37236 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfKMSyd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 13:54:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id b17so3231482wmj.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mxbZ8+c1HWx+jX/DqmbvHgrD0xG3oGCm5/inpyhujDI=;
        b=xbkhJUOltkSzyozuDE5IeFiFnWsqRe6WSN7P/KyRswAlSB68Fg/2wMePtaC9laKO1e
         IoIZz2XW52u0SMEoMZB2VKfw1YBjCg02luv7h7LyPrk3j5tI3HN4mF6FSiuM5i6EWkHY
         c3eTZ/wwRXUJUZfGmTtKagrS0hFTVJKxZZ1lpyFsQuo6XXkPYciymEmbGddnKyUIhJvL
         O09YHa9HxnyyLC82+rzfRheSkU9tPA3+QfyZnPzqq3UBUXJDgmtvphqOvWZ/RgFngQxR
         4MrjLIaCBaXQnBNBTtIj9TYFuy+Fy1laVtDE1yRzUvRbrMUffwT8ZBOpNBPVi+uLLtT6
         Y2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mxbZ8+c1HWx+jX/DqmbvHgrD0xG3oGCm5/inpyhujDI=;
        b=ZLEy4B78dvORwNix3+/RUpsApSSi+HQQ5EjZk6jryR9IBlftjzwmCUL8VfuaEtHp0v
         CM0gFSYwTF9gQz1Zh0QOHdhD9n76h5ZTr9rXNl2BOnPwv769u5HZJhjK9FnNsjPu8Av0
         q+DU5Csh/MFMc8mC2eKsVYwn3Mlec+FAo7l48UcX3WIlU/8GPcIG7CvVlTkKUIDc+ag+
         Msp4w9dmSDrEPxFIa3QJ9JH9AhCLihhbqxUxQjnahEXjXB+4NHgRxCLoWKkB8Rry2DRh
         bSvR0Vmnq/4d2nXAaTOWn4BTY40Twq2jkzhqGR+GfezH/dOYiHPGm8SnYMzJEGH+rOh1
         4FZQ==
X-Gm-Message-State: APjAAAXwHMbaJvvMFceSFOi4x67YZIx/IDak7TU5a59v7Tgy1QM1LurA
        D8KwZKQFs0Io5HZGF8NCKIGzWg==
X-Google-Smtp-Source: APXvYqy13Me73uZ2M/FZW7maBTWK2qakrUvJ2/7ThhIIodfkNB48jSY/JJEUXFIcuuTE9MjTNMFMBA==
X-Received: by 2002:a1c:1f03:: with SMTP id f3mr4127745wmf.131.1573671271226;
        Wed, 13 Nov 2019 10:54:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ec92:781d:6592:837])
        by smtp.gmail.com with ESMTPSA id 17sm2652848wmg.19.2019.11.13.10.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:54:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH RFC 1/3] cpuidle: Replace use_deepest_state flag by use_latency
Date:   Wed, 13 Nov 2019 19:54:17 +0100
Message-Id: <20191113185419.13305-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We want to specify a latency constraint when choosing an idle state at
play_idle time. Instead of duplicating the information in the
structure or propagate the latency in the call stack, change the
use_deepest_state by use_latency to introduce this constraint.

A zero latency constraint means "do not use the deepest idle state
path" as the 'use_deepest_state' boolean was used in the
cpuidle_idle_call.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 6 +++---
 include/linux/cpuidle.h   | 6 +++---
 kernel/sched/idle.c       | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 44ae39f2b47a..f68a6c9e8482 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -100,19 +100,19 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 
 /**
  * cpuidle_use_deepest_state - Set/clear governor override flag.
- * @enable: New value of the flag.
+ * @latency: A latency constraint
  *
  * Set/unset the current CPU to use the deepest idle state (override governors
  * going forward if set).
  */
-void cpuidle_use_deepest_state(bool enable)
+void cpuidle_use_latency(unsigned int latency)
 {
 	struct cpuidle_device *dev;
 
 	preempt_disable();
 	dev = cpuidle_get_device();
 	if (dev)
-		dev->use_deepest_state = enable;
+		dev->use_latency = latency;
 	preempt_enable();
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index d23a3b1ddcf6..32018704f4ea 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,8 +83,8 @@ struct cpuidle_driver_kobj;
 struct cpuidle_device {
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
-	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
+	unsigned int		use_latency;
 	unsigned int		cpu;
 	ktime_t			next_hrtimer;
 
@@ -210,7 +210,7 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
-extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_use_latency(unsigned int latency);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
@@ -218,7 +218,7 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
 {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable)
+static inline void cpuidle_use_latency(unsigned int latency)
 {
 }
 #endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8dad5aa600ea..00e064d3dfe1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -165,7 +165,7 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 
-	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
+	if (idle_should_enter_s2idle() || dev->use_latency) {
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(true);
+	cpuidle_use_latency(1);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
 	while (!READ_ONCE(it.done))
 		do_idle();
 
-	cpuidle_use_deepest_state(false);
+	cpuidle_use_latency(0);
 	current->flags &= ~PF_IDLE;
 
 	preempt_fold_need_resched();
-- 
2.17.1

