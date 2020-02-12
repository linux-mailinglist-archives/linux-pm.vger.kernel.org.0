Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7B15B545
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 00:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgBLXwS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 18:52:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40031 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgBLXwR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 18:52:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so2875446lfi.7;
        Wed, 12 Feb 2020 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJyovvzwjvX/zSdfNpouKUwfmXEwONgtFiRjueLQOdM=;
        b=g1c7rdEMZP+mkhMzKdMdpPH5fiRVIckF0MUzqLj0bh4g3gNZAPuHbBb+6sJw4DvJxz
         v5iX90Aa9ZF2RquuChYpRaLHcVTnQRjgsrQSz8jYTUzfxs9zsRwE5cOlO754uq0XWOY9
         XQ84RB/akX+ZGniemaFBAHMHsmFa0xAJpyCRWV81IItG2V31y9NqsaFeSeKxjsk5+qhF
         nh8oSD1qdWUpMnxMeIpkFSNTG+VXYiXm1nSHcU4l7akqMn1BbjlqHxO+GecaTc7o6lNB
         IZDEuuPxeFWPdZisgiYEhOqx0YfWm0oos+n90tUZfHQnWYVgwRrbxqIDlf2AF/Xh3kRy
         qqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJyovvzwjvX/zSdfNpouKUwfmXEwONgtFiRjueLQOdM=;
        b=LUpP6crOcLLfXUYYauRF06TkVKrixVhb6b8evHv3koJ6M1SEfIq+WDNYOl5vcSrBQm
         /kQAW82PcwM83yvhLJlyZg6nE0Sy+SHktBv1bjykmsLoAG4NMtSlCl0sTA/7iZ36MjaK
         4ANgoLz4+l5JDt2P44Ozfj5NtRg5JNi9QOmY9mQtrmUk9rN9UtBHO9r/lumCvKGLLknc
         iX8DnnMSwGn4CI/4sSF233Vl9pgQjGFVr3gBtH0FbHkonfG1awP+JWYI2xoaMgmHDL2F
         e4qW3bpTcaDKzoT3gfkZ+PfFrjuUYs51D/0YifRU/WUWnnjTMolK1Gb2a5+wBB9GJpQF
         QQqg==
X-Gm-Message-State: APjAAAWUv2sIifPzUEljY8M55LcGuAl3T2WxB61iFfRECoS9eIbhQjCF
        UHIBCU14oWdBe2QbQ8wzfk8=
X-Google-Smtp-Source: APXvYqxY3KKsnSS1gOTt+qeVOlAzRLIvKZUsDxuwF1MTMavuvQwBlt73PwDPs8J/czxSQKnAbjg9FQ==
X-Received: by 2002:ac2:5509:: with SMTP id j9mr7679263lfk.135.1581551535527;
        Wed, 12 Feb 2020 15:52:15 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d5sm251686lfb.20.2020.02.12.15.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:52:15 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 06/17] ARM: tegra: Expose PM functions required for new cpuidle driver
Date:   Thu, 13 Feb 2020 02:51:23 +0300
Message-Id: <20200212235134.12638-7-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200212235134.12638-1-digetx@gmail.com>
References: <20200212235134.12638-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The upcoming unified CPUIDLE driver will be added to the drivers/cpuidle/
directory and it will require all these exposed Tegra PM-core functions.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Tested-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c        |  3 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c         |  2 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c         |  3 +-
 arch/arm/mach-tegra/irq.c                     |  3 +-
 arch/arm/mach-tegra/pm.h                      |  8 -----
 arch/arm/mach-tegra/sleep.h                   |  1 -
 arch/arm/mach-tegra/tegra.c                   |  1 -
 .../mach-tegra => include/soc/tegra}/irq.h    |  8 +++--
 include/soc/tegra/pm.h                        | 31 +++++++++++++++++++
 9 files changed, 43 insertions(+), 17 deletions(-)
 rename {arch/arm/mach-tegra => include/soc/tegra}/irq.h (59%)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 5118f777fd66..2d8527837aeb 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -12,13 +12,14 @@
 
 #include <linux/firmware/trusted_foundations.h>
 
+#include <soc/tegra/pm.h>
+
 #include <asm/cpuidle.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/psci.h>
 
 #include "cpuidle.h"
-#include "pm.h"
 #include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 9789541adb7d..fdfe92068e38 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 
 #include <soc/tegra/flowctrl.h>
+#include <soc/tegra/pm.h>
 
 #include <asm/cpuidle.h>
 #include <asm/smp_plat.h>
@@ -27,7 +28,6 @@
 #include "cpuidle.h"
 #include "iomap.h"
 #include "irq.h"
-#include "pm.h"
 #include "reset.h"
 #include "sleep.h"
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 17cbd118abee..3e91c29891f7 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -17,12 +17,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#include <soc/tegra/pm.h>
+
 #include <asm/cpuidle.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
 #include "cpuidle.h"
-#include "pm.h"
 #include "sleep.h"
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index ace7a390b5fe..4e1ee70b2a3f 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -18,9 +18,10 @@
 #include <linux/of.h>
 #include <linux/syscore_ops.h>
 
+#include <soc/tegra/irq.h>
+
 #include "board.h"
 #include "iomap.h"
-#include "irq.h"
 
 #define SGI_MASK 0xFFFF
 
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index 7d72f31dee77..81525f5f4a44 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -23,20 +23,12 @@ void tegra20_sleep_core_init(void);
 void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
-void tegra_clear_cpu_in_lp2(void);
-void tegra_set_cpu_in_lp2(void);
-int tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
 void tegra_init_suspend(void);
-int tegra_pm_park_secondary_cpu(unsigned long cpu);
 #else
 static inline void tegra_init_suspend(void) {}
-static inline int tegra_pm_park_secondary_cpu(unsigned long cpu)
-{
-	return -ENOTSUPP;
-}
 #endif
 
 #endif /* _MACH_TEGRA_PM_H_ */
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 4978def9db46..4718a3cb45a1 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -122,7 +122,6 @@ void tegra20_hotplug_shutdown(void);
 void tegra30_hotplug_shutdown(void);
 
 void tegra20_tear_down_cpu(void);
-int tegra30_sleep_cpu_secondary_finish(unsigned long);
 void tegra30_tear_down_cpu(void);
 
 #endif
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 1e3b85923ca3..79184a077c84 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -42,7 +42,6 @@
 #include "common.h"
 #include "cpuidle.h"
 #include "iomap.h"
-#include "irq.h"
 #include "pm.h"
 #include "reset.h"
 #include "sleep.h"
diff --git a/arch/arm/mach-tegra/irq.h b/include/soc/tegra/irq.h
similarity index 59%
rename from arch/arm/mach-tegra/irq.h
rename to include/soc/tegra/irq.h
index 7a94cf121448..8eb11a7109e4 100644
--- a/arch/arm/mach-tegra/irq.h
+++ b/include/soc/tegra/irq.h
@@ -3,9 +3,11 @@
  * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
  */
 
-#ifndef __TEGRA_IRQ_H
-#define __TEGRA_IRQ_H
+#ifndef __SOC_TEGRA_IRQ_H
+#define __SOC_TEGRA_IRQ_H
 
+#if defined(CONFIG_ARM)
 bool tegra_pending_sgi(void);
-
 #endif
+
+#endif /* __SOC_TEGRA_IRQ_H */
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 951fcd738d55..1974e8405098 100644
--- a/include/soc/tegra/pm.h
+++ b/include/soc/tegra/pm.h
@@ -6,6 +6,8 @@
 #ifndef __SOC_TEGRA_PM_H__
 #define __SOC_TEGRA_PM_H__
 
+#include <linux/errno.h>
+
 enum tegra_suspend_mode {
 	TEGRA_SUSPEND_NONE = 0,
 	TEGRA_SUSPEND_LP2, /* CPU voltage off */
@@ -20,6 +22,12 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 
 /* low-level resume entry point */
 void tegra_resume(void);
+
+int tegra30_sleep_cpu_secondary_finish(unsigned long arg);
+void tegra_clear_cpu_in_lp2(void);
+void tegra_set_cpu_in_lp2(void);
+int tegra_idle_lp2_last(void);
+int tegra_pm_park_secondary_cpu(unsigned long cpu);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -30,6 +38,29 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
 static inline void tegra_resume(void)
 {
 }
+
+static inline int tegra30_sleep_cpu_secondary_finish(unsigned long arg)
+{
+	return -ENOTSUPP;
+}
+
+static inline void tegra_clear_cpu_in_lp2(void)
+{
+}
+
+static inline void tegra_set_cpu_in_lp2(void)
+{
+}
+
+static inline int tegra_idle_lp2_last(void)
+{
+	return -ENOTSUPP;
+}
+
+static inline int tegra_pm_park_secondary_cpu(unsigned long cpu)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_PM_SLEEP */
 
 #endif /* __SOC_TEGRA_PM_H__ */
-- 
2.24.0

