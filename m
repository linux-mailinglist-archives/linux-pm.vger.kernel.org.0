Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734011E7D9D
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 14:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgE2Mt7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 08:49:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54610 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgE2Mty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 08:49:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529124952euoutp027df7dc4deb49c52fe51be5a0f68c2206~TgLFktjHV0940009400euoutp02a
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 12:49:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529124952euoutp027df7dc4deb49c52fe51be5a0f68c2206~TgLFktjHV0940009400euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590756592;
        bh=GrxDA5iIgAOI8Alt9JYWIyF3cW/T6tYVEoUzcSu9Wto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tev7GWgHS3EGdhrO9ydDAZJJS9P8Gzbx5y1Kxy8SW/8LmyyMxIKYAYEzxRHLHbqpO
         06EjMPbPMubuzVV8EK1sKFWUvqKxS9Rbh6i2S6KxXcAvXvHR4UgahTmQJVbq8YnwSF
         HUA/+CNRziSsuKSeblM+4SsG+ks0Q88IGSEcBx0c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200529124952eucas1p2e2ae4295379ed6c62ddb39ebaf7d139b~TgLFOpYvt1904919049eucas1p29;
        Fri, 29 May 2020 12:49:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 54.74.60698.0F401DE5; Fri, 29
        May 2020 13:49:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8~TgLE21sBi1701917019eucas1p2J;
        Fri, 29 May 2020 12:49:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529124951eusmtrp146027ea796376930b651005eb6fd9990~TgLE2I6V61722217222eusmtrp1I;
        Fri, 29 May 2020 12:49:51 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-f4-5ed104f03e4f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.CA.07950.FE401DE5; Fri, 29
        May 2020 13:49:51 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529124951eusmtip1002b54cd56840951beab382476cbf0bb~TgLEBYA4R1283312833eusmtip1v;
        Fri, 29 May 2020 12:49:51 +0000 (GMT)
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
Subject: [PATCH 2/2] soc: samsung: Add simple voltage coupler for Exynos5800
Date:   Fri, 29 May 2020 14:49:40 +0200
Message-Id: <20200529124940.10675-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529124940.10675-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUhUURjlznvz5jk1+hyFuWlkDRQkuGXBbVGyBR6l0L9ESnvpQ821eWoq
        BGpRNlouYbmjIqRj7kvu5ahNYjouNSopppmaSxoumKbV+Mz+nfOdc+75+LgkJq0TmpG+gSGs
        IpDxlxNivObtT63VIt7rbtt+X4bKU0uFKGVsgkADy1NCVPTjC0BabZkIfc4aEqDVD7EC1F+f
        SaClx20ApWqbBai4bUSE5ta6BOhTdj+O3nf2CdGWrhxHsW2rGCpfoc8a03XpIyK6QvWIoId1
        jQSdsGlLV318iNNPqlSA1gy+EtBLFQeukG7iM16sv28Yq7BxvCH2iZkdEgWPHwzf2mzBo4Da
        XAlIElLHYUaJsRKISSlVAKCuIwrjyTKAGSotzpMlAFM0ZQIlMNhOjFdqRXospV4AuBB9dzeR
        1TAj1AsEZQeV80pCL5hS0QBW5/RspzFqA4NNvYf02IRyhoW5i4R+D5w6DNcHcP1YQjnA6aYK
        wJdZwKKyN5geG1COUNenBvo3IdUtgnE1aoI3XYCDzWNCHpvAGU2ViMf7YefTeJwP3ANwrLtY
        xJN4APtjUncqTsPh7vXtLTDqKCytt+HHTnB2uQvjj2QIB+eN+f0NYXLN852xBMY+kPLuIzBd
        U7Jb29LTt2Oh4USBmL9PEoB1KZOCRGCR/r8rBwAVkLGhXIA3y9kHsnesOSaACw30tvYMCqgA
        fz9U55ZmpRY0/7qpBhQJ5HslZWlad6mQCeMiAtQAkpjcVHKuq9NdKvFiIiJZRZCHItSf5dTA
        nMTlMol93rfrUsqbCWH9WDaYVfxTBaSBWRS4bTU86ddy0oWZbZL5vT5WHF2dpwvdsFSlcy/d
        XDamPBKNXDNGXBPyI8/bOL+7Gu0wmuaUHa+djEvbSlp5diu5dfqEYceer/ssHC6FR9Rubl4b
        X+vOdDqVP+fXKlsgzRSNFz080+h8o7GJwu/rbb8lMS7Ifm2UXsz1b69kSrGGy3Kc82HsLDEF
        x/wBdAECwUwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7rvWS7GGczqsrDYOGM9q8XUh0/Y
        LK5/ec5qsfrjY0aL8+c3sFs8mHuTyeLblQ4mi8u75rBZfO49wmgx4/w+Jou1R+6yW7z5cZbJ
        4va8yywWZ05fYrX4d20ji0XHkW/MFhu/ejgIeuycdZfdY9OqTjaPO9f2sHn0/zXw2HK1ncWj
        b8sqRo/jN7YzeXzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
        k5Kak1mWWqRvl6CX0fT6JnvBI4WKf38PsjQwHpLuYuTkkBAwkXi0+Tx7FyMXh5DAUkaJJR+a
        GSESMhInpzWwQtjCEn+udbFBFH1ilJi3+TczSIJNwFCi6y1EQkSglVHi/OtVTCAOs0Ari8SC
        O6vAqoQFfCRWLvwAVMXBwSKgKvHrOgtImFfAVuLF3k1Q2+QlVm84AFbOKWAnce3SIbC4EFDN
        gR1NTBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjJptx35u2cHY9S74EKMAB6MS
        D++GmefjhFgTy4orcw8xSnAwK4nwOp09HSfEm5JYWZValB9fVJqTWnyI0RToponMUqLJ+cCI
        ziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwKi+ffmPvh0B32Lt
        lQReWy1Su7iA7ca+Dt6Vzjo753hnab98PtNE3GiXzJlz3dLlCYZcW+vMflsHh8lMmvn/p+/1
        a1+NJPIDX8yIPvZY9snZHxvK/16MPuO9i3U/Z+iprW8EWoxFn3z6LbTXJTHE/sUCjctyP/qv
        6Md0TF78/LDkpTW/tG7K7mxRYinOSDTUYi4qTgQAn1kQdrACAAA=
X-CMS-MailID: 20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8
References: <20200529124940.10675-1-m.szyprowski@samsung.com>
        <CGME20200529124952eucas1p2565c598c3c0164b5dec6ed83e19148b8@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add custom voltage regulator coupler for Exynos5800 SoCs, which require
coupling between "vdd_arm" and "vdd_int" regulators. This coupler ensures
that coupled regulators voltage balancing is done only when clients for
each regulator (cpufreq for "vdd_arm" and devfreq for "vdd_int") apply
their constraints, so the voltage values don't go beyond the
bootloader-selected operation point during the boot process. This also
ensures proper voltage balancing if any of those drivers is missing.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                  |  1 +
 drivers/soc/samsung/Kconfig                   |  3 +
 drivers/soc/samsung/Makefile                  |  1 +
 .../soc/samsung/exynos-regulator-coupler.c    | 59 +++++++++++++++++++
 4 files changed, 64 insertions(+)
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
index 000000000000..54445918bd75
--- /dev/null
+++ b/drivers/soc/samsung/exynos-regulator-coupler.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * Samsung Exynos SoC voltage coupler
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
+	if (strcmp(rdev_get_name(rdev), "vdd_arm") == 0 ||
+	    strcmp(rdev_get_name(rdev), "vdd_int") == 0)
+		return 0;
+
+	return -EINVAL;
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

