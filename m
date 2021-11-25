Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D288345D694
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 09:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353757AbhKYJAm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 04:00:42 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:45906 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353137AbhKYI6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 03:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637830531; x=1669366531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=C1SMImgKRYYI+V5asR9+c50EUAXTpvbf8imgtE5v1XQ=;
  b=VwkQKi0e9BEOvwe6aZAOmCEDpH1EucFbjJR3ByoC3pX5JGBixhZTHhVX
   tyYzmG+xln4+HotdEwXHVwKSy7kArv6xpXjE493XfXoVkhcXee8Nv1k8C
   hczER3MNraoTykYboo8XMwdA3Bae7GTJbWPaIiGndGzwh2Qr28c7KcFGV
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Nov 2021 00:55:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 00:55:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:29 -0800
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 00:55:26 -0800
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <quic_lsrao@quicinc.com>, <rnayak@codeaurora.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Subject: [PATCH 4/4] cpuidle: governors: Allow the governors to be compiled as modules
Date:   Thu, 25 Nov 2021 14:24:41 +0530
Message-ID: <1637830481-21709-5-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allow the menu, ladder and teo governors to be compiled as modules
when building allmodconfig.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/cpuidle/Kconfig            | 6 +++---
 drivers/cpuidle/governors/ladder.c | 4 ++++
 drivers/cpuidle/governors/menu.c   | 4 ++++
 drivers/cpuidle/governors/teo.c    | 4 ++++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd..d71e3e4 100644
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
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 8e9058c..4de5b3d 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
 #include <linux/jiffies.h>
+#include <linux/module.h>
 #include <linux/tick.h>
 
 #include <asm/io.h>
@@ -195,3 +196,6 @@ static int __init init_ladder(void)
 }
 
 postcore_initcall(init_ladder);
+
+MODULE_DESCRIPTION("CPUidle Ladder governor (for periodic timer tick)");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 2e56704..2ef7cfc 100644
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
@@ -577,3 +578,6 @@ static int __init init_menu(void)
 }
 
 postcore_initcall(init_menu);
+
+MODULE_DESCRIPTION("CPUidle Menu governor (for tickless system)");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index d9262db..1a1d9ef 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -104,6 +104,7 @@
 #include <linux/cpuidle.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sched/clock.h>
 #include <linux/tick.h>
 
@@ -532,3 +533,6 @@ static int __init teo_governor_init(void)
 }
 
 postcore_initcall(teo_governor_init);
+
+MODULE_DESCRIPTION("CPUidle Timer events oriented (TEO) governor (for tickless systems)");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

