Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4376A3D521
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406939AbfFKSI2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 14:08:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60258 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406828AbfFKSIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 14:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1560276487; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMGlnOY/mkdY5Ii1FMy4DJ7e5EuTwF3Oqoqtl6a7HkI=;
        b=QkXQ7FzsBHcBdngAoE9Il9Z8h0/GwAfHYs6tP9oEGvVEb46S+H7VXS4oouIM+CFBiuMdPG
        R+NntOWPNecdi7vo1+zPB/kpEMcIHUKnVanufwGM9kkG+ifmwqqBjRMBHG9AvjKM2zrQiu
        kfVTNt2OBv1xyrZQ83/oaymcVBLZGf8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/5] clk: ingenic: Handle setting the Low-Power Mode bit
Date:   Tue, 11 Jun 2019 20:07:54 +0200
Message-Id: <20190611180757.32299-2-paul@crapouillou.net>
In-Reply-To: <20190611180757.32299-1-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Low-Power Mode, when enabled, will make the "wait" MIPS instruction
suspend the system.

This is not really clock-related, but this bit happens to be in the
register set of the CGU.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc4

 drivers/clk/ingenic/Makefile      |  2 +-
 drivers/clk/ingenic/jz4725b-cgu.c |  3 +++
 drivers/clk/ingenic/jz4740-cgu.c  |  3 +++
 drivers/clk/ingenic/jz4770-cgu.c  | 33 ++---------------------
 drivers/clk/ingenic/jz4780-cgu.c  |  3 +++
 drivers/clk/ingenic/pm.c          | 45 +++++++++++++++++++++++++++++++
 drivers/clk/ingenic/pm.h          | 12 +++++++++
 7 files changed, 69 insertions(+), 32 deletions(-)
 create mode 100644 drivers/clk/ingenic/pm.c
 create mode 100644 drivers/clk/ingenic/pm.h

diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
index ab58a6a862a5..250570a809d3 100644
--- a/drivers/clk/ingenic/Makefile
+++ b/drivers/clk/ingenic/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_INGENIC_CGU_COMMON)	+= cgu.o
+obj-$(CONFIG_INGENIC_CGU_COMMON)	+= cgu.o pm.o
 obj-$(CONFIG_INGENIC_CGU_JZ4740)	+= jz4740-cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4725B)	+= jz4725b-cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4770)	+= jz4770-cgu.o
diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 6e8bbf620c76..15055b118a44 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <dt-bindings/clock/jz4725b-cgu.h>
 #include "cgu.h"
+#include "pm.h"
 
 /* CGU register offsets */
 #define CGU_REG_CPCCR		0x00
@@ -226,5 +227,7 @@ static void __init jz4725b_cgu_init(struct device_node *np)
 	retval = ingenic_cgu_register_clocks(cgu);
 	if (retval)
 		pr_err("%s: failed to register CGU Clocks\n", __func__);
+
+	ingenic_cgu_register_syscore_ops(cgu);
 }
 CLK_OF_DECLARE(jz4725b_cgu, "ingenic,jz4725b-cgu", jz4725b_cgu_init);
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 2deac19a8d04..efa893ee1de9 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/jz4740-cgu.h>
 #include <asm/mach-jz4740/clock.h>
 #include "cgu.h"
+#include "pm.h"
 
 /* CGU register offsets */
 #define CGU_REG_CPCCR		0x00
@@ -218,6 +219,8 @@ static void __init jz4740_cgu_init(struct device_node *np)
 	retval = ingenic_cgu_register_clocks(cgu);
 	if (retval)
 		pr_err("%s: failed to register CGU Clocks\n", __func__);
+
+	ingenic_cgu_register_syscore_ops(cgu);
 }
 CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
 
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 42b2ee121642..12b1f57defb9 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -8,9 +8,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/syscore_ops.h>
 #include <dt-bindings/clock/jz4770-cgu.h>
 #include "cgu.h"
+#include "pm.h"
 
 /*
  * CPM registers offset address definition
@@ -37,9 +37,6 @@
 #define CGU_REG_MSC2CDR		0xA8
 #define CGU_REG_BCHCDR		0xAC
 
-/* bits within the LCR register */
-#define LCR_LPM			BIT(0)		/* Low Power Mode */
-
 /* bits within the OPCR register */
 #define OPCR_SPENDH		BIT(5)		/* UHC PHY suspend */
 
@@ -406,30 +403,6 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 	},
 };
 
-#if IS_ENABLED(CONFIG_PM_SLEEP)
-static int jz4770_cgu_pm_suspend(void)
-{
-	u32 val;
-
-	val = readl(cgu->base + CGU_REG_LCR);
-	writel(val | LCR_LPM, cgu->base + CGU_REG_LCR);
-	return 0;
-}
-
-static void jz4770_cgu_pm_resume(void)
-{
-	u32 val;
-
-	val = readl(cgu->base + CGU_REG_LCR);
-	writel(val & ~LCR_LPM, cgu->base + CGU_REG_LCR);
-}
-
-static struct syscore_ops jz4770_cgu_pm_ops = {
-	.suspend = jz4770_cgu_pm_suspend,
-	.resume = jz4770_cgu_pm_resume,
-};
-#endif /* CONFIG_PM_SLEEP */
-
 static void __init jz4770_cgu_init(struct device_node *np)
 {
 	int retval;
@@ -443,9 +416,7 @@ static void __init jz4770_cgu_init(struct device_node *np)
 	if (retval)
 		pr_err("%s: failed to register CGU Clocks\n", __func__);
 
-#if IS_ENABLED(CONFIG_PM_SLEEP)
-	register_syscore_ops(&jz4770_cgu_pm_ops);
-#endif
+	ingenic_cgu_register_syscore_ops(cgu);
 }
 
 /* We only probe via devicetree, no need for a platform driver */
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 6d524e760180..afd7e9bd4fc4 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <dt-bindings/clock/jz4780-cgu.h>
 #include "cgu.h"
+#include "pm.h"
 
 /* CGU register offsets */
 #define CGU_REG_CLOCKCONTROL	0x00
@@ -720,5 +721,7 @@ static void __init jz4780_cgu_init(struct device_node *np)
 		pr_err("%s: failed to register CGU Clocks\n", __func__);
 		return;
 	}
+
+	ingenic_cgu_register_syscore_ops(cgu);
 }
 CLK_OF_DECLARE(jz4780_cgu, "ingenic,jz4780-cgu", jz4780_cgu_init);
diff --git a/drivers/clk/ingenic/pm.c b/drivers/clk/ingenic/pm.c
new file mode 100644
index 000000000000..341752b640d2
--- /dev/null
+++ b/drivers/clk/ingenic/pm.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include "cgu.h"
+#include "pm.h"
+
+#include <linux/io.h>
+#include <linux/syscore_ops.h>
+
+#define CGU_REG_LCR		0x04
+
+#define LCR_LOW_POWER_MODE	BIT(0)
+
+static void __iomem * __maybe_unused ingenic_cgu_base;
+
+static int __maybe_unused ingenic_cgu_pm_suspend(void)
+{
+	u32 val = readl(ingenic_cgu_base + CGU_REG_LCR);
+
+	writel(val | LCR_LOW_POWER_MODE, ingenic_cgu_base + CGU_REG_LCR);
+
+	return 0;
+}
+
+static void __maybe_unused ingenic_cgu_pm_resume(void)
+{
+	u32 val = readl(ingenic_cgu_base + CGU_REG_LCR);
+
+	writel(val & ~LCR_LOW_POWER_MODE, ingenic_cgu_base + CGU_REG_LCR);
+}
+
+static struct syscore_ops __maybe_unused ingenic_cgu_pm_ops = {
+	.suspend = ingenic_cgu_pm_suspend,
+	.resume = ingenic_cgu_pm_resume,
+};
+
+void ingenic_cgu_register_syscore_ops(struct ingenic_cgu *cgu)
+{
+	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+		ingenic_cgu_base = cgu->base;
+		register_syscore_ops(&ingenic_cgu_pm_ops);
+	}
+}
diff --git a/drivers/clk/ingenic/pm.h b/drivers/clk/ingenic/pm.h
new file mode 100644
index 000000000000..fa7540407b6b
--- /dev/null
+++ b/drivers/clk/ingenic/pm.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Paul Cercueil <paul@crapouillou.net>
+ */
+#ifndef DRIVERS_CLK_INGENIC_PM_H
+#define DRIVERS_CLK_INGENIC_PM_H
+
+struct ingenic_cgu;
+
+void ingenic_cgu_register_syscore_ops(struct ingenic_cgu *cgu);
+
+#endif /* DRIVERS_CLK_INGENIC_PM_H */
-- 
2.21.0.593.g511ec345e18

