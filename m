Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9157AF23
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfG3RKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:10:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51504 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbfG3RKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:10:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so57893332wma.1;
        Tue, 30 Jul 2019 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWP8nyImS39zSZSpsquwa+7h83m45I0RXPq4864glDw=;
        b=Iu9EjQjZxmPl+Q4bfHcmGwyQDVVaNNpvg/OpDyGt+7lGZ0E4arbO7crE19E05b7srI
         xFSOFbugrx7lNFmE/6mIc2U3JHmGayehFJHvqNoXKBR7PabDGkK5rX5AiSkcYjgyGpdM
         kYxzm9UK+SxRH+DmKD+l6Dh39NlADk8GQ/cBd1kZkHQrg/t25wjz4m5RlvZI+5ev5L8/
         PaQ3redmmEfRjn7LM6cpZuHqlakUGT8RqZWrN2BvlCJlYIwM5n1pXFoz2Ve20I9l1ird
         FwMusc3kwdlBHsOuUEgODl8VH72duETUdSHEpuGeHReKGrEOtBKk3a7CPqm7rn8sHo1v
         RUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWP8nyImS39zSZSpsquwa+7h83m45I0RXPq4864glDw=;
        b=byVtd8OH82SDbUrCnaeH4qJIzi8IwLtj14A90KG7w4RjOmSt767EGjXePacOoX8IZn
         tJ56xCgcM9QvFYG16Ancz8zW8mmicQjRtJ/fUOxShE6XgWps5xKB68jAD5Uwm+4YMfXD
         ZnywtcwPhQKx1/WniB2VgDj7DBheZf4NeRxYMBH3Gm0tRCtlut3Kalad3qMKTD9Lj6ia
         lZ9NiNrEtc/bBlqPrMgsQUMgh86SBKSmu4u8UFUGBhcgdYWbIar+zQb/zAMRhvcz+/NL
         7211+rLtO7oBDtyd39Jz6dYnyZUi9x/Hda+khxeFOZ34+3Dxagm6ZHTDf9DsMRPEeoWm
         eUVA==
X-Gm-Message-State: APjAAAUY/bjIkVoPAsGqEyDL3cf9ri9PDOEyaz4RHGuELa3a8XT8YTBp
        TPCzB2VqP7W7K6g8PbEFCdM=
X-Google-Smtp-Source: APXvYqw3fVyWAWZ7kBBQv6+IKJ3g2QmXyBtQvX8SEi5ctVNZO7fbPMe02SHu5bD++PN7kt5z0SRACA==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr91081455wmh.136.1564506612681;
        Tue, 30 Jul 2019 10:10:12 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id i13sm58897736wrr.73.2019.07.30.10.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:10:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/13] ARM: tegra: Expose PM functions required for new cpuidle driver
Date:   Tue, 30 Jul 2019 20:09:47 +0300
Message-Id: <20190730170955.11987-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730170955.11987-1-digetx@gmail.com>
References: <20190730170955.11987-1-digetx@gmail.com>
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
 arch/arm/mach-tegra/irq.c   |  2 ++
 arch/arm/mach-tegra/pm.h    |  3 ---
 arch/arm/mach-tegra/sleep.h |  1 -
 include/soc/tegra/irq.h     | 13 +++++++++++++
 include/soc/tegra/pm.h      | 25 +++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 4 deletions(-)
 create mode 100644 include/soc/tegra/irq.h

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 4c065b54cbe7..4e1ee70b2a3f 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -18,6 +18,8 @@
 #include <linux/of.h>
 #include <linux/syscore_ops.h>
 
+#include <soc/tegra/irq.h>
+
 #include "board.h"
 #include "iomap.h"
 
diff --git a/arch/arm/mach-tegra/pm.h b/arch/arm/mach-tegra/pm.h
index ae68fc7db576..81525f5f4a44 100644
--- a/arch/arm/mach-tegra/pm.h
+++ b/arch/arm/mach-tegra/pm.h
@@ -23,9 +23,6 @@ void tegra20_sleep_core_init(void);
 void tegra30_lp1_iram_hook(void);
 void tegra30_sleep_core_init(void);
 
-void tegra_clear_cpu_in_lp2(void);
-void tegra_set_cpu_in_lp2(void);
-int tegra_idle_lp2_last(void);
 extern void (*tegra_tear_down_cpu)(void);
 
 #ifdef CONFIG_PM_SLEEP
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
diff --git a/include/soc/tegra/irq.h b/include/soc/tegra/irq.h
new file mode 100644
index 000000000000..8eb11a7109e4
--- /dev/null
+++ b/include/soc/tegra/irq.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2012, NVIDIA Corporation. All rights reserved.
+ */
+
+#ifndef __SOC_TEGRA_IRQ_H
+#define __SOC_TEGRA_IRQ_H
+
+#if defined(CONFIG_ARM)
+bool tegra_pending_sgi(void);
+#endif
+
+#endif /* __SOC_TEGRA_IRQ_H */
diff --git a/include/soc/tegra/pm.h b/include/soc/tegra/pm.h
index 951fcd738d55..bc1abdf41d61 100644
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
@@ -20,6 +22,11 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode);
 
 /* low-level resume entry point */
 void tegra_resume(void);
+
+int tegra30_sleep_cpu_secondary_finish(unsigned long arg);
+void tegra_clear_cpu_in_lp2(void);
+void tegra_set_cpu_in_lp2(void);
+int tegra_idle_lp2_last(void);
 #else
 static inline enum tegra_suspend_mode
 tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
@@ -30,6 +37,24 @@ tegra_pm_validate_suspend_mode(enum tegra_suspend_mode mode)
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
 #endif /* CONFIG_PM_SLEEP */
 
 #endif /* __SOC_TEGRA_PM_H__ */
-- 
2.22.0

