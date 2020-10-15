Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1B28F508
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388837AbgJOOos (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 10:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388882AbgJOOos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 10:44:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCAEC0613D2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q5so3996587wmq.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MntIS5hG5qKkJHF3dkjVLX64GnAHUT4P3HeNpPTIdo0=;
        b=Gr9Mau/Xqu2Exr9oRxron8l1EirbsMrJtvhPHJxxDWRryiywuM/kvWWjRQ95PAtkkB
         wmxbrBqyLWqMVgLQKWiEWfiy8ojRfHOXSfaOxLarzRwLE4Wsu5KHKNuUJm3vF7WZAVOc
         Yav6uBclxqyBdl65J0iaDn4SJFrOD/OZkCnXh3F8thhugKVL21q6UV15GdEulgDsdOOb
         et/xVCy5gUbtz9oX60ikqcEb7TNMWIDm0YuLG+sx8/X2P7pZwWv5x2YKtRDnX+jtLJOT
         pIkJOKVd5NlgbJ5iqv5LTJSFGw4PkhzzVQbBbFn1SGpLqp/dHMfS+ib/Z2drZsf0IAmv
         9EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MntIS5hG5qKkJHF3dkjVLX64GnAHUT4P3HeNpPTIdo0=;
        b=YG0YctqdBT4lKgFUhgdzWXn3Vr0GXQBFPx7QVdQeGM1YagvjZJ6lVafkRt28LEYyLI
         ishTxgLlPGKWObHEYsRRNGv2WMJ8DcU+lKhDoDmbz2Y3DEId+K8yyF9g7IYTdwUvPpGi
         +yBbUr2X8E+07dfYdh88WifGMXm1/CN0jSc6JLZHOSIWepDwaIciyReiSZoMQk1IhV6r
         oLiN2gN4mF8cDANtulGE7PMiS9nO8mhsKa7B9rrha2UWV1sHcEJ3pr56/zc5pHZxMQva
         xZ1tM3J9r5FxZqr4TkcnWHQu/Y9NnM5JlsecHndmwZXUDIuSCJcA2IptwjHGdf6CJ4Do
         WnfA==
X-Gm-Message-State: AOAM5319ZGZFlGo8u6u0ktMyoBIh4k3Mn6hFEhH3xUbzgqAQLAAi/rZL
        FMcA8LhvZyrV7j9XmuN1Ze7KCA==
X-Google-Smtp-Source: ABdhPJyCyD9y+3z7qx4BminOn3dgTANolTABtkUhDhQSFQf/2wyCDC/+bP77BUDkHaJ7HpScB0EXzQ==
X-Received: by 2002:a1c:9d87:: with SMTP id g129mr4443850wme.30.1602773086172;
        Thu, 15 Oct 2020 07:44:46 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-134-136.adsl.proxad.net. [82.252.134.136])
        by smtp.gmail.com with ESMTPSA id 40sm5053800wrc.46.2020.10.15.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:44:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ilina@codeaurora.org
Subject: [PATCH 5/5] cpuidle: governor: Convert governors to modules
Date:   Thu, 15 Oct 2020 16:44:31 +0200
Message-Id: <20201015144431.9979-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015144431.9979-1-daniel.lezcano@linaro.org>
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch converts the cpuidle governors into modules. Even if it is
not the utmost importance, that will be consistent with the devfreq,
the watchdog and the cpufreq governors.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig              |  8 ++++----
 drivers/cpuidle/governors/haltpoll.c |  9 ++++++++-
 drivers/cpuidle/governors/ladder.c   | 12 ++++++++++--
 drivers/cpuidle/governors/menu.c     | 10 +++++++++-
 drivers/cpuidle/governors/teo.c      | 10 +++++++++-
 5 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd66f02..ff83042edd50 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -19,13 +19,13 @@ config CPU_IDLE_MULTIPLE_DRIVERS
 	bool
 
 config CPU_IDLE_GOV_LADDER
-	bool "Ladder governor (for periodic timer tick)"
+	tristate "Ladder governor (for periodic timer tick)"
 
 config CPU_IDLE_GOV_MENU
-	bool "Menu governor (for tickless system)"
+	tristate "Menu governor (for tickless system)"
 
 config CPU_IDLE_GOV_TEO
-	bool "Timer events oriented (TEO) governor (for tickless systems)"
+	tristate "Timer events oriented (TEO) governor (for tickless systems)"
 	help
 	  This governor implements a simplified idle state selection method
 	  focused on timer events and does not do any interactivity boosting.
@@ -34,7 +34,7 @@ config CPU_IDLE_GOV_TEO
 	  to use.  Say Y here if you are not happy with the alternatives.
 
 config CPU_IDLE_GOV_HALTPOLL
-	bool "Haltpoll governor (for virtualized systems)"
+	tristate "Haltpoll governor (for virtualized systems)"
 	depends on KVM_GUEST
 	help
 	  This governor implements haltpoll idle state selection, to be
diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index cb2a96eafc02..4756b758c324 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -146,4 +146,11 @@ static int __init init_haltpoll(void)
 	return 0;
 }
 
-postcore_initcall(init_haltpoll);
+static void __exit exit_haltpoll(void)
+{
+	cpuidle_unregister_governor(&haltpoll_governor);
+}
+
+module_init(init_haltpoll);
+module_exit(exit_haltpoll);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 8e9058c4ea63..78b622b75ce7 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
+#include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/tick.h>
 
@@ -188,10 +189,17 @@ static int __init init_ladder(void)
 	 * governor is better so give it a higher rating than the menu
 	 * governor.
 	 */
-	if (!tick_nohz_enabled)
+	if (!tick_nohz_is_enabled())
 		ladder_governor.rating = 25;
 
 	return cpuidle_register_governor(&ladder_governor);
 }
 
-postcore_initcall(init_ladder);
+static void __exit exit_ladder(void)
+{
+	cpuidle_unregister_governor(&ladder_governor);
+}
+
+module_init(init_ladder);
+module_exit(exit_ladder);
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b0a7ad566081..fc92a5b18a7b 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -13,6 +13,7 @@
 #include <linux/time.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
+#include <linux/module.h>
 #include <linux/tick.h>
 #include <linux/sched.h>
 #include <linux/sched/loadavg.h>
@@ -571,4 +572,11 @@ static int __init init_menu(void)
 	return cpuidle_register_governor(&menu_governor);
 }
 
-postcore_initcall(init_menu);
+static void __exit exit_menu(void)
+{
+	cpuidle_unregister_governor(&menu_governor);
+}
+
+module_init(init_menu);
+module_exit(exit_menu);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 6deaaf5f05b5..d11dab61113c 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -48,6 +48,7 @@
 #include <linux/cpuidle.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sched/clock.h>
 #include <linux/tick.h>
 
@@ -491,4 +492,11 @@ static int __init teo_governor_init(void)
 	return cpuidle_register_governor(&teo_governor);
 }
 
-postcore_initcall(teo_governor_init);
+static void __exit teo_governor_exit(void)
+{
+	cpuidle_unregister_governor(&teo_governor);
+}
+
+module_init(teo_governor_init);
+module_exit(teo_governor_exit);
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

