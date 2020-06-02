Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8791EBCAE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBNJj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 09:09:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41829 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgFBNJg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 09:09:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200602130932euoutp020104bf24bb3f28efdc24adca31ec42f6~UvBZsimwQ2434324343euoutp02M
        for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2020 13:09:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200602130932euoutp020104bf24bb3f28efdc24adca31ec42f6~UvBZsimwQ2434324343euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591103372;
        bh=mqXQUJYme8sb1kqyyvm+dIEEXicHI1pNmMuhexl44FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvH6xRRKpNIE6J6Or813n+/x5J6SdAlVvNHoRWI5RMMBzWwoVWNuPT0TkluDE/rmI
         e6BEh5ULO8rq082LoJv4lvmnDlD0He3ulRHg8jhtHuEZmmDs/yGmqviqFpFzF1iLjO
         VJ1/gTj07mM2j/aexBkvBv0kaZAWZg/1cHLDD5oQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602130932eucas1p2fd3291361188944610cbfe39dacb9167~UvBY89fm52884128841eucas1p24;
        Tue,  2 Jun 2020 13:09:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7E.29.60698.B8F46DE5; Tue,  2
        Jun 2020 14:09:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200602130931eucas1p1cd784c8f692fa91dc566504543a927de~UvBYTXxxs1673516735eucas1p1S;
        Tue,  2 Jun 2020 13:09:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602130931eusmtrp1a44b6adeb42cbadf5c1397223ff4fca6~UvBYSlpQe0850308503eusmtrp1i;
        Tue,  2 Jun 2020 13:09:31 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-47-5ed64f8ba37e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.80.07950.B8F46DE5; Tue,  2
        Jun 2020 14:09:31 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200602130930eusmtip2d4d6e6598c097b354cc224f2f84170fb~UvBXd9TTM2230822308eusmtip2v;
        Tue,  2 Jun 2020 13:09:30 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, peron.clem@gmail.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2] soc: samsung: Add simple voltage coupler for Exynos5800
Date:   Tue,  2 Jun 2020 15:02:11 +0200
Message-Id: <20200602130211.2727-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjmO+fs7Dicnabki5nioKCbF+zHB4l28cepKPvjj4KWqw4qOpUt
        S4XIDLxslqaYYiZiSl5Th7csw3Q0aupMa5nO0BJtlkHp7KJJbkfz3/O9z/PwPO/Lx5CyLpEX
        E5twmVcnKOPltIRqf/F7cL8uwqII/JgXgltKmkS4aGqaxu8WZ0W4/vsnhM3mZjGevP+ewEtv
        sgk80lVG44VbBoRLzM8I3GiYEOOvvwYIPF4+QuF+07AIr1paKJxtWCJxi507tJV7XDoh5vR1
        OTRntTyluby/gVzr2yyKu91ahzjjaAfBLeh9TjNnJSGX+PjYK7w6IDRKErMy6plULU95mV1F
        pyOrtxa5MMAegNwKO6FFEkbG1iB4p2+kHYSMXUTwYeKEQCwgeNKxTG44Rle7SIF4iGC2eGLT
        kdEf6cA0GwTaeS3tEHmwNxC0VQwRDoJkl0nofu3nwO7sCZg1NYsdmGJ3wvsZnRNL2RDozB9H
        Qpov1Df3OJNd2DC4Z9Q6uwL7SgxjfZ8pQRQOtm/zYgG7w5yxdR17g6kwlxIMNxFMDTaKhUcu
        gpGMkvWIg2Ad/LPWlVmrtxuaugKE8WEoqS1zjoF1g9H5rcICblDQXkwKYylkZ8oE9S4oNT76
        H/t8aHj9WhzUagvXr1WAoMlqQvnIt3QzrAKhOuTJJ2tU0bwmOIG/6q9RqjTJCdH+FxNVerT2
        o0yrRnsnerZyoRexDJK7SgODLAqZSHlFk6rqRcCQcg/pkQGTQia9pExN49WJ59XJ8bymF21n
        KLmnNLjSdk7GRisv83E8n8SrN1iCcfFKR6KMnPKMM67HHlQrJ4sX9pZf734TY/gZpoCatp4f
        xDRtNERuqYro7sjKvGvv648NH9+m/1JkMy/uU8247bhDj7mXj1TdzR0MjRX3Re071bBkTrEd
        9fMJHXjScNLe98GH15mHV3f7TqXDcVY31zzvV2StjGsNvRhcGh6vGEu79lhOaWKUQXtItUb5
        D7BvGOhNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7rd/tfiDPruC1psnLGe1WLqwyds
        Fte/PGe1WP3xMaPF+fMb2C0ezL3JZPHtSgeTxeVdc9gsPvceYbSYcX4fk8XaI3fZLd78OMtk
        cXveZRaLM6cvsVr8u7aRxaLjyDdmi41fPRwEPXbOusvusWlVJ5vHnWt72Dz6/xp4bLnazuLR
        t2UVo8fxG9uZPD5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
        SUnNySxLLdK3S9DL+HNDvGCpUsXJjiVsDYx3ZLoYOTkkBEwkbvzbxdzFyMUhJLCUUWLajE+M
        EAkZiZPTGlghbGGJP9e62CCKPjFKnPkyAayITcBQoustREJEoJVR4vzrVUwgDrNAK4vEgjur
        mEGqhAW8JZ6f3sAOYrMIqErcfNYNZvMK2EjsmHAbap28xOoNB8DqOQXsJWYf7wIaxAG0zk7i
        9weuCYx8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTGzLZjP7fsYOx6F3yIUYCDUYmH
        18DwWpwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAt00kVlKNDkfGM95
        JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY9y088S6fp+f15bqQ
        xqOclyQ4p6n7ulqLT3hg0/uhRPHMjTdvp7OeM5q55WyUH3/+EesD34Rvvn1oee/Zd/Z32zZx
        hc/NSjGpO/7R/cQPb6VH+SKavBVan7qZOTqYGt8GLP666Mi6uMOZGatCzolbncy7ukxDfYuT
        6P3lPBkvt6z9+CV58bQjc5RYijMSDbWYi4oTAdTZRnevAgAA
X-CMS-MailID: 20200602130931eucas1p1cd784c8f692fa91dc566504543a927de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200602130931eucas1p1cd784c8f692fa91dc566504543a927de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602130931eucas1p1cd784c8f692fa91dc566504543a927de
References: <57cf3a15-5d9b-7636-4c69-60742e8cfae6@samsung.com>
        <CGME20200602130931eucas1p1cd784c8f692fa91dc566504543a927de@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a simple custom voltage regulator coupler for Exynos5800 SoCs, which
require coupling between "vdd_arm" and "vdd_int" regulators. This coupler
ensures that the voltage balancing for the coupled regulators is done
only when clients for the each regulator apply their constraints, so the
voltage values don't go beyond the bootloader-selected operation point
during the boot process. This also ensures proper voltage balancing if
any of the client driver is missing.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- removed dependency on the regulator names as pointed by krzk, now it
  works with all coupled regulators. So far the coupling between the
  regulators on Exynos5800 based boards is defined only between
  "vdd_arm" and "vdd_int" supplies.
---
 arch/arm/mach-exynos/Kconfig                  |  1 +
 drivers/soc/samsung/Kconfig                   |  3 +
 drivers/soc/samsung/Makefile                  |  1 +
 .../soc/samsung/exynos-regulator-coupler.c    | 56 +++++++++++++++++++
 4 files changed, 61 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-regulator-coupler.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 76838255b5fa..f185cd3d4c62 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -118,6 +118,7 @@ config SOC_EXYNOS5800
 	bool "Samsung EXYNOS5800"
 	default y
 	depends on SOC_EXYNOS5420
+	select EXYNOS_REGULATOR_COUPLER
 
 config EXYNOS_MCPM
 	bool
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index c7a2003687c7..264185664594 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -37,4 +37,7 @@ config EXYNOS_PM_DOMAINS
 	bool "Exynos PM domains" if COMPILE_TEST
 	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
 
+config EXYNOS_REGULATOR_COUPLER
+	bool "Exynos SoC Regulator Coupler" if COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
 endif
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index edd1d6ea064d..ecc3a32f6406 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
 obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
+obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
diff --git a/drivers/soc/samsung/exynos-regulator-coupler.c b/drivers/soc/samsung/exynos-regulator-coupler.c
new file mode 100644
index 000000000000..370a0ce4de3a
--- /dev/null
+++ b/drivers/soc/samsung/exynos-regulator-coupler.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * Simple Samsung Exynos SoC voltage coupler. Ensures that all
+ * clients set their constraints before balancing the voltages.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/regulator/coupler.h>
+#include <linux/regulator/driver.h>
+
+static int exynos_coupler_balance_voltage(struct regulator_coupler *coupler,
+					  struct regulator_dev *rdev,
+					  suspend_state_t state)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int ret, cons_uV = 0, cons_max_uV = INT_MAX;
+	bool skip_coupled = false;
+
+	/* get coupled regulator constraints */
+	ret = regulator_check_consumers(c_desc->coupled_rdevs[1], &cons_uV,
+					&cons_max_uV, state);
+	if (ret < 0)
+		return ret;
+
+	/* skip adjusting coupled regulator if it has no constraints set yet */
+	if (cons_uV == 0)
+		skip_coupled = true;
+
+	return regulator_do_balance_voltage(rdev, state, skip_coupled);
+}
+
+static int exynos_coupler_attach(struct regulator_coupler *coupler,
+				 struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static struct regulator_coupler exynos_coupler = {
+	.attach_regulator = exynos_coupler_attach,
+	.balance_voltage  = exynos_coupler_balance_voltage,
+};
+
+static int __init exynos_coupler_init(void)
+{
+	if (!of_machine_is_compatible("samsung,exynos5800"))
+		return 0;
+
+	return regulator_coupler_register(&exynos_coupler);
+}
+arch_initcall(exynos_coupler_init);
-- 
2.17.1

