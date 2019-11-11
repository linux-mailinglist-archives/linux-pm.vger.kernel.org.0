Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C228FF8219
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 22:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfKKVRY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 16:17:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44793 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKVQd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 16:16:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id z188so3793357lfa.11;
        Mon, 11 Nov 2019 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HSBQmUHjV911oFfX562hus/HMz13o7s1uTrxyVrhXI=;
        b=BSoguuqrt3sJRT8WA7rIHcMwEOAhrohM2QJCqxg0j2lNG/jeOJ5soLG6amjIYyRjb4
         9J2MWw3or77ouCl8m8iA/vvbPw4bB0b9yUoOnCRWV11MM4NUkirBpozyX2YXBR4VDIPp
         p+ndejlXJx4KDGV6gvGwZU+JCvHoBMnUfpQiF9PMM1UqBjINdnIVek5NQMDataEz9nZL
         LGBHt6k2b7Y619y3Lzr9M0qFrLE69bHGftNBifSx9FPe5Xh+goG7DOG9/5dJII/HWjIf
         hw2+TcebPoYvmZyF+CS+Dkj+7h68quAsEeakdE+cgPV2Nt2zcIifcGfnJW44RZLxm5P1
         kATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HSBQmUHjV911oFfX562hus/HMz13o7s1uTrxyVrhXI=;
        b=Qu7mHTwMWZNnzlVRsjYnWf2mMCOXMujOPaMUbWT3UGXFVNscId7RgUXfO0iFQpHTyR
         SwH62SADVmU/7rEEHZ/xS550i11mFhku6dWLS2ertPCNq+Y1/SCIycYwFDKSrP4OTn32
         zeI9suHIIq91MPtuECtCjLrhjOiWkCSgfqW3HobdFRBtOjojz3EdVeRhoFMZ1wGfKLOr
         GXidRSmDtYY0Qs5iX0RPaB9+xwf9a4Jjggd+jaSRy7FvJxZel+PCOWyGiuqumjrHDynm
         t2j+WqWvnPYTydrcB04Ul3qP63uoVvAI3fKEcKPzOhJZdZ8I3rrF33ZcqYjiE/Kdv3dr
         rlkQ==
X-Gm-Message-State: APjAAAXX+ubC6HLccF2RSMXD3awoCZZ8wqqlJ4RY7qncXQEdW0/a5oCN
        HPHget+ayLI3faqd1uDKfig=
X-Google-Smtp-Source: APXvYqwQVazmb2hXsH+uu8RYs9EgW7t1i/OEl9YMTVWwSx+HUL7iFzPfbANlORuDEfmTo2OO6pGTPA==
X-Received: by 2002:ac2:5999:: with SMTP id w25mr7820515lfn.42.1573506990657;
        Mon, 11 Nov 2019 13:16:30 -0800 (PST)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id n19sm7913150lfl.85.2019.11.11.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 13:16:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 06/17] ARM: tegra: Expose PM functions required for new cpuidle driver
Date:   Tue, 12 Nov 2019 00:15:45 +0300
Message-Id: <20191111211556.20723-7-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191111211556.20723-1-digetx@gmail.com>
References: <20191111211556.20723-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The upcoming unified CPUIDLE driver will be added to the drivers/cpuidle/
directory and it will require all these exposed Tegra PM-core functions.

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
index 74ba37992259..7de2151a2e0c 100644
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
2.23.0

