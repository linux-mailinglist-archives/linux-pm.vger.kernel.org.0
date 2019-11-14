Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0557FCFE3
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 21:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKNUtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 15:49:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36741 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNUt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 15:49:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id c22so7740615wmd.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 12:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fBRrOeFjzqnzfONE7OUt/W61tGgjVczN6HnwGIweIMY=;
        b=UyAH0ik3h3xmZNBuHt5kE41PVk00D0xHfOmVezEgZri2dDGhwR/WyRVVGBCdd0x6dv
         Xxv+5awZJ/xz+ELjzjwK8QBT+X5QFDj8HNbKxLYVTPi/LECGs4mGFrQwf1hsw7tlV98+
         uIN4rgFBWDQOkpsqp4nJj+PB4GS9xQUVZhBmmlwbOX6ghrzy/DCT9lTDO9GyuL1hzdKE
         zt4FcyNBYMPKH9Zp7P/80gxHB7e2vxljNfmIizAvdbln7bCaAeOSPa092ecmyLz5MrHC
         BsA24QnBw/Uh/TmGv/ON91JnOiV/6DIm35mFY37NZm70wtl+/EAa/pFy+sWJNd6fmBHd
         kGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fBRrOeFjzqnzfONE7OUt/W61tGgjVczN6HnwGIweIMY=;
        b=bvaAsl4tWwBUAg9X++Kwv6na8TvRO6m5CMyhfskcP7MxYHi2Jq1rc7a2UJAdS+ZpTL
         Gvod8tl2gv80dyYMdDFsjNgxqIZgGN9nEORohKX1iH52zPhFqwv6prYmr62bBHYQqm3I
         OUDNAp9pfV1bK+RXO5iyrZCi4BV7j/1dpSZ5suK33U4Q03GOjOQQfAZ5cNa+H8Af/KLC
         acD3V5oOXm6aeU+9ckD/9pD7C5V+mo0ZqgmCUACw/uCeXjjgLzWYGMVGtyEAAvsTb8uL
         pzOQdOYhYhNS3Q4h3K4dsUZIYTAjDf7sXrpnHM7Zi36JWsPNBxmS/Jiw/WswOMkdRqIs
         9/ww==
X-Gm-Message-State: APjAAAWx25+PPcmBiMrjR1+k+WWavCSi7FHWsrICyni9SDmkAe5hR+/m
        qNCPkUFlKDTYkFFEahV4/XeMxPwuD14=
X-Google-Smtp-Source: APXvYqy/MM8gJSOT7UjZZGzCVxqEgDIwva5S/LnBEECN3mQLb588uLJNvchk04xOShDE3Ddb0U/RBQ==
X-Received: by 2002:a05:600c:294e:: with SMTP id n14mr9964213wmd.18.1573764566284;
        Thu, 14 Nov 2019 12:49:26 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3115:aefb:2495:829a])
        by smtp.gmail.com with ESMTPSA id a206sm7954485wmf.15.2019.11.14.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:49:25 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V1 3/3] cpuidle: Use the latency to call find_deepest_idle_state
Date:   Thu, 14 Nov 2019 21:49:14 +0100
Message-Id: <20191114204914.21206-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114204914.21206-1-daniel.lezcano@linaro.org>
References: <20191114204914.21206-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the dev->forced_idle_latency_limit_ns is filled with the latency
value when this function is called, use it as a parameter to the
find_deepest_idle_state() function.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 7 +++++--
 include/linux/cpuidle.h   | 6 ++++--
 kernel/sched/idle.c       | 8 +++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 62226fadc02d..a02b701fc289 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -122,9 +122,12 @@ void cpuidle_use_deepest_state(u64 latency_limit_ns)
  * @dev: cpuidle device for the given CPU.
  */
 int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev)
+			       struct cpuidle_device *dev,
+			       u64 latency_limit_ns)
 {
-	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
+	return find_deepest_state(drv, dev,
+				  div_u64(latency_limit_ns, NSEC_PER_USEC),
+				  0, false);
 }
 
 #ifdef CONFIG_SUSPEND
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1f3f4dd01e48..b60f35b7d53e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -207,13 +207,15 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 
 #ifdef CONFIG_CPU_IDLE
 extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev);
+				      struct cpuidle_device *dev,
+				      u64 latency_limit_ns);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
 extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-					     struct cpuidle_device *dev)
+					     struct cpuidle_device *dev,
+					     u64 latency_limit_ns)
 {return -ENODEV; }
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
 				       struct cpuidle_device *dev)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 0a817e907192..fd4a8747e602 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -166,6 +166,9 @@ static void cpuidle_idle_call(void)
 	 */
 
 	if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
+
+		u64 latency_limit_ns = dev->forced_idle_latency_limit_ns;
+
 		if (idle_should_enter_s2idle()) {
 			rcu_idle_enter();
 
@@ -176,12 +179,15 @@ static void cpuidle_idle_call(void)
 			}
 
 			rcu_idle_exit();
+
+			latency_limit_ns = U64_MAX;
 		}
 
 		tick_nohz_idle_stop_tick();
 		rcu_idle_enter();
 
-		next_state = cpuidle_find_deepest_state(drv, dev);
+		next_state = cpuidle_find_deepest_state(drv, dev,
+							latency_limit_ns);
 		call_cpuidle(drv, dev, next_state);
 	} else {
 		bool stop_tick = true;
-- 
2.17.1

