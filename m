Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D76CFE0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390452AbfGROcH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:32:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35006 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390696AbfGRObf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:31:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718143132euoutp011ac46f26a90965742e76e269dfdcad0d~yhtodj8BQ1313513135euoutp01y
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 14:31:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718143132euoutp011ac46f26a90965742e76e269dfdcad0d~yhtodj8BQ1313513135euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563460292;
        bh=YNh32Lggk6Y48QJHpDfQwvVZmSvq1dYXR80Hoe3h1bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jykeZZV2ydqEwcSrawliSndZTwSuWLCwecHKPjMIPwh4Q2+uiTN6nCU5u9IbzLmtN
         eAlX6UHM5A9K8rMtpKv6Kh/K5KE2m7JQKHQTk/gcyGHQAfhCfKfvpeD2t+5gK3fLMy
         5p/mdDr5AaViLIX8vUhhhdwRCe9RCnhezCoG+l78=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718143131eucas1p128904f794ee62eea53832573e1d735d5~yhtntZkhE0452404524eucas1p1k;
        Thu, 18 Jul 2019 14:31:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B8.95.04298.2C2803D5; Thu, 18
        Jul 2019 15:31:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8~yhtm2VSDK2850928509eucas1p2i;
        Thu, 18 Jul 2019 14:31:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718143130eusmtrp14005a265569878d9668a41c3609f153a~yhtmoDkGp1897918979eusmtrp1X;
        Thu, 18 Jul 2019 14:31:30 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-bf-5d3082c2ce47
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F6.3E.04146.1C2803D5; Thu, 18
        Jul 2019 15:31:30 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143129eusmtip111f6ba236c939ab00c499be1281bebda~yhtmCGSde1716617166eusmtip1w;
        Thu, 18 Jul 2019 14:31:29 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 3/9] soc: samsung: Add Exynos Adaptive Supply Voltage
 driver
Date:   Thu, 18 Jul 2019 16:30:38 +0200
Message-Id: <20190718143044.25066-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718143044.25066-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87qHmgxiDW78NrbYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxuuHc1kLXk9jqvjR
        38jawLjsLmMXIyeHhICJxMMjp9m6GLk4hARWMEq0PnnODuF8YZSYdH4JE4TzmVFi7a05zF2M
        HGAtf7dXQ8SXM0r09s9iRuiYM50FZC6bgKFE79E+sB0iAsIS95YuBxvLLHCPSeL007NMIAlh
        gUCJNxeOsIHYLAKqEqsmnQWzeQWsJT5vaGOGOFBeYvWGA2A2p4CNxOG7TxlBBkkITGeXWHyt
        mxWiyEVi2r+nUB8JS7w6voUdwpaROD25hwWioZlRomf3bXYIZwKjxP3jC6A6rCUOH7/ICvIc
        s4CmxPpd+hBhR4lj7f+YIH7mk7jxVhAkzAxkTto2HRoUvBIdbUIQ1SoSv1dNZ4KwpSS6n/xn
        gbA9JCZMOMsKCaF+RomTE08yTWCUn4WwbAEj4ypG8dTS4tz01GLDvNRyveLE3OLSvHS95Pzc
        TYzA5HL63/FPOxi/Xko6xCjAwajEwxuQaxArxJpYVlyZe4hRgoNZSYT39kv9WCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MG2aHXk+4kc/o+PXoxB/b
        dZVbbs1nL6u4/Pj0Oa62E6JvBW8tshJqzLx/797Hi3neBZ61tpI+b/rmFC3X4zw6aYp0YtoC
        xr6julx95do6gWuW3HijlOqgeeEUD1d+y4/PBbZnbyStZIypahTZ08q9qbHtzu39Ux5GRG+t
        rJulPPO2TU78w0uflViKMxINtZiLihMBfHa1KSoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7qHmgxiDQ5HW2ycsZ7VYv6Rc6wW
        /Y9fM1ucP7+B3WLT42usFpd3zWGz+Nx7hNFixvl9TBZrj9xlt1i09Qu7ReveI+wWh9+0s1ps
        fnCMzYHXY9OqTjaPzUvqPfq2rGL0+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
        z9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j9cO5rAWvpzFV/OhvZG1gXHaXsYuRg0NCwETi7/bq
        LkYuDiGBpYwSB9ccY4WIS0nMb1HqYuQEMoUl/lzrYgOxhQQ+MUqsOiQKYrMJGEr0Hu1jBLFF
        gGruLV3ODjKHWeAVk8Ttef+ZQBLCAv4Sbc/egNksAqoSqyadBRvEK2At8XlDGzPEAnmJ1RsO
        gNmcAjYSh+8+ZYRYZi0x++U1xgmMfAsYGVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEhvi2
        Yz8372C8tDH4EKMAB6MSD29ArkGsEGtiWXFl7iFGCQ5mJRHe2y/1Y4V4UxIrq1KL8uOLSnNS
        iw8xmgIdNZFZSjQ5Hxh/eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4
        OKUaGGOfa4uwbwhpKNDsDF/y89qHKQy5DpUch4S69my5MHeL9tzNIv+rijmnbcxQ37DbJ7Lw
        n/+Jsq+dDoFb1/07/+mp7qLeteqaM0O+Pd+x6HhMgWbt8+RPBYu6TxRWeq5jOOR79tdfuRvv
        3fJXdbn66qXHblh+85eE2iWlS8szDkRyPvZ/4Si6/owSS3FGoqEWc1FxIgCH2Fv8hwIAAA==
X-CMS-MailID: 20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8
References: <20190718143044.25066-1-s.nawrocki@samsung.com>
        <CGME20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Adaptive Supply Voltage (ASV) driver adjusts CPU cluster operating
points depending on exact revision of an SoC retrieved from the CHIPID
block or the OTP memory.  This allows for some power saving as for some
CPU clock frequencies we can lower CPU cluster supply voltage comparing
to safe values common to the all chip revisions.

This patch adds support for Exynos5422/5800 SoC, it is partially based
on code from https://github.com/hardkernel/linux repository,
branch odroidxu4-4.14.y, files: arch/arm/mach-exynos/exynos5422-asv.[ch].

Tested on Odroid XU3, XU4, XU3 Lite.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1 (RFC):
 - removed code for parsing the ASV OPP tables from DT, the ASV OPP tables
   moved to the driver;
 - converted to use the regmap API;
 - converted to normal platform driver.
---
 drivers/soc/samsung/Kconfig          |  11 +
 drivers/soc/samsung/Makefile         |   3 +
 drivers/soc/samsung/exynos-asv.c     | 185 ++++++++++
 drivers/soc/samsung/exynos-asv.h     |  82 +++++
 drivers/soc/samsung/exynos5422-asv.c | 499 +++++++++++++++++++++++++++
 drivers/soc/samsung/exynos5422-asv.h |  25 ++
 6 files changed, 805 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2905f5262197..539cd95dd176 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -7,6 +7,17 @@ menuconfig SOC_SAMSUNG
 
 if SOC_SAMSUNG
 
+config EXYNOS_ASV
+	bool "Exynos Adaptive Supply Voltage support" if COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on EXYNOS_CHIPID
+	select EXYNOS_ASV_ARM if ARM && ARCH_EXYNOS
+
+# There is no need to enable these drivers for ARMv8
+config EXYNOS_ASV_ARM
+	bool "Exynos ASV ARMv7-specific driver extensions" if COMPILE_TEST
+	depends on EXYNOS_ASV
+
 config EXYNOS_CHIPID
 	bool "Exynos Chipid controller driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 3b6a8797416c..edd1d6ea064d 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_EXYNOS_ASV)	+= exynos-asv.o
+obj-$(CONFIG_EXYNOS_ASV_ARM)	+= exynos5422-asv.o
+
 obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
new file mode 100644
index 000000000000..b1a7e0ba8870
--- /dev/null
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
+ *
+ * Samsung Exynos SoC Adaptive Supply Voltage support
+ */
+
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/soc/samsung/exynos-chipid.h>
+
+#include "exynos-asv.h"
+#include "exynos5422-asv.h"
+
+#define MHZ 1000000U
+
+static int exynos_asv_update_cpu_opps(struct exynos_asv *asv,
+				      struct device *cpu)
+{
+	struct exynos_asv_subsys *subsys = NULL;
+	struct dev_pm_opp *opp;
+	unsigned int opp_freq;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(asv->subsys); i++) {
+		if (of_device_is_compatible(cpu->of_node,
+					    asv->subsys[i].cpu_dt_compat)) {
+			subsys = &asv->subsys[i];
+			break;
+		}
+	}
+	if (!subsys)
+		return -EINVAL;
+
+	for (i = 0; i < subsys->table.num_rows; i++) {
+		unsigned int new_voltage;
+		unsigned int voltage;
+		int timeout = 1000;
+		int err;
+
+		opp_freq = exynos_asv_opp_get_frequency(subsys, i);
+
+		opp = dev_pm_opp_find_freq_exact(cpu, opp_freq * MHZ, true);
+		if (IS_ERR(opp)) {
+			dev_info(asv->dev, "cpu%d opp%d, freq: %u missing\n",
+				 cpu->id, i, opp_freq);
+
+			continue;
+		}
+
+		voltage = dev_pm_opp_get_voltage(opp);
+		new_voltage = asv->opp_get_voltage(subsys, i, voltage);
+		dev_pm_opp_put(opp);
+
+		opp_freq *= MHZ;
+		dev_pm_opp_remove(cpu, opp_freq);
+
+		while (--timeout) {
+			opp = dev_pm_opp_find_freq_exact(cpu, opp_freq, true);
+			if (IS_ERR(opp))
+				break;
+			dev_pm_opp_put(opp);
+			msleep(1);
+		}
+
+		err = dev_pm_opp_add(cpu, opp_freq, new_voltage);
+		if (err < 0)
+			dev_err(asv->dev,
+				"Failed to add OPP %u Hz/%u uV for cpu%d\n",
+				opp_freq, new_voltage, cpu->id);
+	}
+
+	return 0;
+}
+
+static int exynos_asv_update_opps(struct exynos_asv *asv)
+{
+	struct opp_table *last_opp_table = NULL;
+	struct device *cpu;
+	int ret, cpuid;
+
+	for_each_possible_cpu(cpuid) {
+		struct opp_table *opp_table;
+
+		cpu = get_cpu_device(cpuid);
+		if (!cpu)
+			continue;
+
+		opp_table = dev_pm_opp_get_opp_table(cpu);
+		if (IS_ERR(opp_table))
+			continue;
+
+		if (!last_opp_table || opp_table != last_opp_table) {
+			last_opp_table = opp_table;
+
+			ret = exynos_asv_update_cpu_opps(asv, cpu);
+			if (ret < 0)
+				dev_err(asv->dev, "Couldn't udate OPPs for cpu%d\n",
+					cpuid);
+		}
+
+		dev_pm_opp_put_opp_table(opp_table);
+	}
+
+	return	0;
+}
+
+static int exynos_asv_probe(struct platform_device *pdev)
+{
+	int (*probe_func)(struct exynos_asv *asv);
+	struct exynos_asv *asv;
+	struct device *cpu_dev;
+	u32 product_id = 0;
+	int ret, i;
+
+	cpu_dev = get_cpu_device(0);
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret < 0)
+		return -EPROBE_DEFER;
+
+	asv = kcalloc(1, sizeof(*asv), GFP_KERNEL);
+	if (!asv)
+		return -ENOMEM;
+
+	asv->chipid_regmap = syscon_node_to_regmap(pdev->dev.of_node);
+	if (IS_ERR(asv->chipid_regmap)) {
+		dev_err(&pdev->dev, "Could not find syscon regmap\n");
+		return PTR_ERR(asv->chipid_regmap);
+	}
+
+	regmap_read(asv->chipid_regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
+
+	switch (product_id & EXYNOS_MASK) {
+	case 0xE5422000:
+		probe_func = exynos5422_asv_init;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported product ID: %#x", product_id);
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "samsung,asv-bin",
+				   &asv->of_bin);
+	if (ret < 0)
+		asv->of_bin = -EINVAL;
+
+	asv->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, asv);
+
+	for (i = 0; i < ARRAY_SIZE(asv->subsys); i++)
+		asv->subsys[i].asv = asv;
+
+	ret = probe_func(asv);
+	if (ret < 0)
+		return ret;
+
+	return exynos_asv_update_opps(asv);
+}
+
+static const struct of_device_id exynos_asv_of_device_ids[] = {
+	{ .compatible = "samsung,exynos4210-chipid" },
+	{}
+};
+
+static struct platform_driver exynos_asv_driver = {
+	.driver = {
+		.name = "exynos-asv",
+		.of_match_table = exynos_asv_of_device_ids,
+	},
+	.probe	= exynos_asv_probe,
+};
+module_platform_driver(exynos_asv_driver);
diff --git a/drivers/soc/samsung/exynos-asv.h b/drivers/soc/samsung/exynos-asv.h
new file mode 100644
index 000000000000..d0a5d603093d
--- /dev/null
+++ b/drivers/soc/samsung/exynos-asv.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
+ *
+ * Samsung Exynos SoC Adaptive Supply Voltage support
+ */
+#ifndef _EXYNOS_ASV_H
+#define _EXYNOS_ASV_H
+
+enum {
+	EXYNOS_ASV_SUBSYS_ID_ARM,
+	EXYNOS_ASV_SUBSYS_ID_EGL = EXYNOS_ASV_SUBSYS_ID_ARM,
+	EXYNOS_ASV_SUBSYS_ID_KFC,
+	EXYNOS_ASV_SUBSYS_ID_INT,
+	EXYNOS_ASV_SUBSYS_ID_MIF,
+	EXYNOS_ASV_SUBSYS_ID_G3D,
+	EXYNOS_ASV_SUBSYS_ID_CAM,
+	EXYNOS_ASV_SUBSYS_ID_MAX
+};
+
+struct regmap;
+
+/* HPM, IDS values to select target group */
+struct asv_limit_entry {
+	unsigned int hpm;
+	unsigned int ids;
+};
+
+struct exynos_asv_table {
+	unsigned int num_rows;
+	unsigned int num_cols;
+	u32 *buf;
+};
+
+struct exynos_asv_subsys {
+	struct exynos_asv *asv;
+	char *cpu_dt_compat;
+	int id;
+	struct exynos_asv_table table;
+
+	unsigned int base_volt;
+	unsigned int offset_volt_h;
+	unsigned int offset_volt_l;
+};
+
+struct exynos_asv {
+	struct device *dev;
+	struct regmap *chipid_regmap;
+	struct exynos_asv_subsys subsys[2];
+
+	int (*opp_get_voltage)(struct exynos_asv_subsys *subs, int level,
+			       unsigned int voltage);
+	unsigned int group;
+	unsigned int table;
+
+	/* True if SG fields from PKG_ID register should be used */
+	bool use_sg;
+	/* ASV bin read from DT */
+	int of_bin;
+};
+
+static inline u32 __asv_get_table_entry(struct exynos_asv_table *table,
+					unsigned int row, unsigned int col)
+{
+	return table->buf[row * (table->num_cols) + col];
+}
+
+static inline u32 exynos_asv_opp_get_voltage(struct exynos_asv_subsys *subsys,
+					unsigned int level, unsigned int group)
+{
+	return __asv_get_table_entry(&subsys->table, level, group + 1);
+}
+
+static inline u32 exynos_asv_opp_get_frequency(struct exynos_asv_subsys *subsys,
+					unsigned int level)
+{
+	return __asv_get_table_entry(&subsys->table, level, 0);
+}
+
+#endif /* _EXYNOS_ASV_H */
diff --git a/drivers/soc/samsung/exynos5422-asv.c b/drivers/soc/samsung/exynos5422-asv.c
new file mode 100644
index 000000000000..5fd673a6a733
--- /dev/null
+++ b/drivers/soc/samsung/exynos5422-asv.c
@@ -0,0 +1,499 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * Samsung Exynos 5422 SoC Adaptive Supply Voltage support
+ */
+
+#include <linux/bitrev.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/soc/samsung/exynos-chipid.h>
+#include <linux/slab.h>
+
+#include "exynos-asv.h"
+
+#define ASV_GROUPS_NUM		14
+#define ASV_ARM_DVFS_NUM	20
+#define ASV_ARM_BIN2_DVFS_NUM	17
+#define ASV_KFC_DVFS_NUM	14
+#define ASV_KFC_BIN2_DVFS_NUM	12
+
+static const u32 asv_arm_table[][ASV_ARM_DVFS_NUM][ASV_GROUPS_NUM + 1] = {
+{
+	/* ARM 0, 1 */
+	{ 2100,    1362500, 1362500, 1350000, 1337500, 1325000, 1312500, 1300000,
+	  1275000, 1262500, 1250000, 1237500, 1225000, 1212500, 1200000 },
+	{ 2000,    1312500, 1312500, 1300000, 1287500, 1275000, 1262500, 1250000,
+	  1237500, 1225000, 1237500, 1225000, 1212500, 1200000, 1187500 },
+	{ 1900,    1250000, 1237500, 1225000, 1212500, 1200000, 1187500, 1175000,
+	  1162500, 1150000, 1162500, 1150000, 1137500, 1125000, 1112500 },
+	{ 1800,    1200000, 1187500, 1175000, 1162500, 1150000, 1137500, 1125000,
+	  1112500, 1100000, 1112500, 1100000, 1087500, 1075000, 1062500 },
+	{ 1700,    1162500, 1150000, 1137500, 1125000, 1112500, 1100000, 1087500,
+	  1075000, 1062500, 1075000, 1062500, 1050000, 1037500, 1025000 },
+	{ 1600,    1125000, 1112500, 1100000, 1087500, 1075000, 1062500, 1050000,
+	  1037500, 1025000, 1037500, 1025000, 1012500, 1000000, 987500 },
+	{ 1500,    1087500, 1075000, 1062500, 1050000, 1037500, 1025000, 1012500,
+	  1000000, 987500,  1000000, 987500,  975000,  962500,  950000 },
+	{ 1400,    1062500, 1050000, 1037500, 1025000, 1012500, 1000000, 987500,
+	  975000,  962500,  975000,  962500,  950000,  937500,  925000 },
+	{ 1300,    1050000, 1037500, 1025000, 1012500, 1000000, 987500,  975000,
+	  962500,  950000,  962500,  950000,  937500,  925000,  912500 },
+	{ 1200,    1025000, 1012500, 1000000, 987500,  975000,  962500,  950000,
+	  937500,  925000,  937500,  925000,  912500,  900000,  900000 },
+	{ 1100,    1000000, 987500,  975000,  962500,  950000,  937500,  925000,
+	  912500,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 1000,    975000,  962500,  950000,  937500,  925000,  912500,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 900,     950000,  937500,  925000,  912500,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 800,     925000,  912500,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 700,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 600,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}, {
+	/* ARM 2 */
+	{ 2100,    1362500, 1362500, 1350000, 1337500, 1325000, 1312500, 1300000,
+	  1275000, 1262500, 1250000, 1237500, 1225000, 1212500, 1200000 },
+	{ 2000,    1312500, 1312500, 1312500, 1300000, 1275000, 1262500, 1250000,
+	  1237500, 1225000, 1237500, 1225000, 1212500, 1200000, 1187500 },
+	{ 1900,    1262500, 1250000, 1250000, 1237500, 1212500, 1200000, 1187500,
+	  1175000, 1162500, 1175000, 1162500, 1150000, 1137500, 1125000 },
+	{ 1800,    1212500, 1200000, 1187500, 1175000, 1162500, 1150000, 1137500,
+	  1125000, 1112500, 1125000, 1112500, 1100000, 1087500, 1075000 },
+	{ 1700,    1175000, 1162500, 1150000, 1137500, 1125000, 1112500, 1100000,
+	  1087500, 1075000, 1087500, 1075000, 1062500, 1050000, 1037500 },
+	{ 1600,    1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500,
+	  1050000, 1037500, 1050000, 1037500, 1025000, 1012500, 1000000 },
+	{ 1500,    1100000, 1087500, 1075000, 1062500, 1050000, 1037500, 1025000,
+	  1012500, 1000000, 1012500, 1000000, 987500,  975000,  962500 },
+	{ 1400,    1075000, 1062500, 1050000, 1037500, 1025000, 1012500, 1000000,
+	  987500,  975000,  987500,  975000,  962500,  950000,  937500 },
+	{ 1300,    1050000, 1037500, 1025000, 1012500, 1000000, 987500,  975000,
+	  962500,  950000,  962500,  950000,  937500,  925000,  912500 },
+	{ 1200,    1025000, 1012500, 1000000, 987500,  975000,  962500,  950000,
+	  937500,  925000,  937500,  925000,  912500,  900000,  900000 },
+	{ 1100,    1000000, 987500,  975000,  962500,  950000,  937500,  925000,
+	  912500,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 1000,    975000,  962500,  950000,  937500,  925000,  912500,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 900,     950000,  937500,  925000,  912500,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 800,     925000,  912500,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 700,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 600,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}, {
+	/* ARM 3 */
+	{ 2100,    1362500, 1362500, 1350000, 1337500, 1325000, 1312500, 1300000,
+	  1275000, 1262500, 1250000, 1237500, 1225000, 1212500, 1200000 },
+	{ 2000,    1312500, 1312500, 1300000, 1287500, 1275000, 1262500, 1250000,
+	  1237500, 1225000, 1237500, 1225000, 1212500, 1200000, 1187500 },
+	{ 1900,    1262500, 1250000, 1237500, 1225000, 1212500, 1200000, 1187500,
+	  1175000, 1162500, 1175000, 1162500, 1150000, 1137500, 1125000 },
+	{ 1800,    1212500, 1200000, 1187500, 1175000, 1162500, 1150000, 1137500,
+	  1125000, 1112500, 1125000, 1112500, 1100000, 1087500, 1075000 },
+	{ 1700,    1175000, 1162500, 1150000, 1137500, 1125000, 1112500, 1100000,
+	  1087500, 1075000, 1087500, 1075000, 1062500, 1050000, 1037500 },
+	{ 1600,    1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500,
+	  1050000, 1037500, 1050000, 1037500, 1025000, 1012500, 1000000 },
+	{ 1500,    1100000, 1087500, 1075000, 1062500, 1050000, 1037500, 1025000,
+	  1012500, 1000000, 1012500, 1000000, 987500,  975000,  962500 },
+	{ 1400,    1075000, 1062500, 1050000, 1037500, 1025000, 1012500, 1000000,
+	  987500,  975000,  987500,  975000,  962500,  950000,  937500 },
+	{ 1300,    1050000, 1037500, 1025000, 1012500, 1000000, 987500,  975000,
+	  962500,  950000,  962500,  950000,  937500,  925000,  912500 },
+	{ 1200,    1025000, 1012500, 1000000, 987500,  975000,  962500,  950000,
+	  937500,  925000,  937500,  925000,  912500,  900000,  900000 },
+	{ 1100,    1000000, 987500,  975000,  962500,  950000,  937500,  925000,
+	  912500,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 1000,    975000,  962500,  950000,  937500,  925000,  912500,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 900,     950000,  937500,  925000,  912500,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 800,     925000,  912500,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 700,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 600,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}, {
+	/* ARM bin 2 */
+	{ 1800,    1237500, 1225000, 1212500, 1200000, 1187500, 1175000, 1162500,
+	  1150000, 1137500, 1150000, 1137500, 1125000, 1112500, 1100000 },
+	{ 1700,    1200000, 1187500, 1175000, 1162500, 1150000, 1137500, 1125000,
+	  1112500, 1100000, 1112500, 1100000, 1087500, 1075000, 1062500 },
+	{ 1600,    1162500, 1150000, 1137500, 1125000, 1112500, 1100000, 1087500,
+	  1075000, 1062500, 1075000, 1062500, 1050000, 1037500, 1025000 },
+	{ 1500,    1125000, 1112500, 1100000, 1087500, 1075000, 1062500, 1050000,
+	  1037500, 1025000, 1037500, 1025000, 1012500, 1000000, 987500 },
+	{ 1400,    1100000, 1087500, 1075000, 1062500, 1050000, 1037500, 1025000,
+	  1012500, 1000000, 1012500, 1000000, 987500,  975000,  962500 },
+	{ 1300,    1087500, 1075000, 1062500, 1050000, 1037500, 1025000, 1012500,
+	  1000000, 987500,  1000000, 987500,  975000,  962500,  950000 },
+	{ 1200,    1062500, 1050000, 1037500, 1025000, 1012500, 1000000, 987500,
+	  975000,  962500,  975000,  962500,  950000,  937500,  925000 },
+	{ 1100,    1037500, 1025000, 1012500, 1000000, 987500,  975000,  962500,
+	  950000,  937500,  950000,  937500,  925000,  912500,  900000 },
+	{ 1000,    1012500, 1000000, 987500,  975000,  962500,  950000,  937500,
+	  925000,  912500,  925000,  912500,  900000,  900000,  900000 },
+	{ 900,     987500,  975000,  962500,  950000,  937500,  925000,  912500,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 800,     962500,  950000,  937500,  925000,  912500,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 700,     937500,  925000,  912500,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 600,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}
+};
+
+static const u32 asv_kfc_table[][ASV_KFC_DVFS_NUM][ASV_GROUPS_NUM + 1] = {
+{
+	/* KFC 0, 1 */
+	{ 1500000, 1300000, 1300000, 1300000, 1287500, 1287500, 1287500, 1275000,
+	  1262500, 1250000, 1237500, 1225000, 1212500, 1200000, 1187500 },
+	{ 1400000, 1275000, 1262500, 1250000, 1237500, 1225000, 1212500, 1200000,
+	  1187500, 1175000, 1162500, 1150000, 1137500, 1125000, 1112500 },
+	{ 1300000, 1225000, 1212500, 1200000, 1187500, 1175000, 1162500, 1150000,
+	  1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500 },
+	{ 1200000, 1175000, 1162500, 1150000, 1137500, 1125000, 1112500, 1100000,
+	  1087500, 1075000, 1062500, 1050000, 1037500, 1025000, 1012500 },
+	{ 1100000, 1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500,
+	  1050000, 1037500, 1025000, 1012500, 1000000, 987500,  975000 },
+	{ 1000000, 1100000, 1087500, 1075000, 1062500, 1050000, 1037500, 1025000,
+	  1012500, 1000000, 987500,  975000,  962500,  950000,  937500 },
+	{ 900000,  1062500, 1050000, 1037500, 1025000, 1012500, 1000000, 987500,
+	  975000,  962500,  950000,  937500,  925000,  912500,  900000 },
+	{ 800000,  1025000, 1012500, 1000000, 987500,  975000,  962500,  950000,
+	  937500,  925000,  912500,  900000,  900000,  900000,  900000 },
+	{ 700000,  987500,  975000,  962500,  950000,  937500,  925000,  912500,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 600000,  950000,  937500,  925000,  912500,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500000,  912500,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400000,  900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300000,  900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200000,  900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}, {
+	/* KFC 2 */
+	{ 1500,    1300000, 1300000, 1300000, 1287500, 1287500, 1287500, 1275000,
+	  1262500, 1250000, 1237500, 1225000, 1212500, 1200000, 1187500 },
+	{ 1400,    1275000, 1262500, 1250000, 1237500, 1225000, 1212500, 1200000,
+	  1187500, 1175000, 1162500, 1150000, 1137500, 1125000, 1112500 },
+	{ 1300,    1225000, 1212500, 1200000, 1187500, 1175000, 1162500, 1150000,
+	  1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500 },
+	{ 1200,    1175000, 1162500, 1150000, 1137500, 1125000, 1112500, 1100000,
+	  1087500, 1075000, 1062500, 1050000, 1037500, 1025000, 1012500 },
+	{ 1100,    1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500,
+	  1050000, 1037500, 1025000, 1012500, 1000000, 987500,  975000 },
+	{ 1000,    1100000, 1087500, 1075000, 1062500, 1050000, 1037500, 1025000,
+	  1012500, 1000000, 987500,  975000,  962500,  950000,  937500 },
+	{ 900,     1062500, 1050000, 1037500, 1025000, 1012500, 1000000, 987500,
+	  975000,  962500,  950000,  937500,  925000,  912500,  900000 },
+	{ 800,     1025000, 1012500, 1000000, 987500,  975000,  962500,  950000,
+	  937500,  925000,  912500,  900000,  900000,  900000,  900000 },
+	{ 700,     987500,  975000,  962500,  950000,  937500,  925000,  912500,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 600,     950000,  937500,  925000,  912500,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500,     912500,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}, {
+	/* KFC 3 */
+	{ 1500,    1300000, 1300000, 1300000, 1287500, 1287500, 1287500, 1275000,
+	  1262500, 1250000, 1237500, 1225000, 1212500, 1200000, 1187500 },
+	{ 1400,    1275000, 1262500, 1250000, 1237500, 1225000, 1212500, 1200000,
+	  1187500, 1175000, 1162500, 1150000, 1137500, 1125000, 1112500 },
+	{ 1300,    1225000, 1212500, 1200000, 1187500, 1175000, 1162500, 1150000,
+	  1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500 },
+	{ 1200,    1175000, 1162500, 1150000, 1137500, 1125000, 1112500, 1100000,
+	  1087500, 1075000, 1062500, 1050000, 1037500, 1025000, 1012500 },
+	{ 1100,    1137500, 1125000, 1112500, 1100000, 1087500, 1075000, 1062500,
+	  1050000, 1037500, 1025000, 1012500, 1000000, 987500,  975000 },
+	{ 1000,    1100000, 1087500, 1075000, 1062500, 1050000, 1037500, 1025000,
+	  1012500, 1000000, 987500,  975000,  962500,  950000,  937500 },
+	{ 900,     1062500, 1050000, 1037500, 1025000, 1012500, 1000000, 987500,
+	  975000,  962500,  950000,  937500,  925000,  912500,  900000 },
+	{ 800,     1025000, 1012500, 1000000, 987500,  975000,  962500,  950000,
+	  937500,  925000,  912500,  900000,  900000,  900000,  900000 },
+	{ 700,     987500,  975000,  962500,  950000,  937500,  925000,  912500,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 600,     950000,  937500,  925000,  912500,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500,     912500,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}, {
+	/* KFC bin 2 */
+	{ 1300,    1250000, 1237500, 1225000, 1212500, 1200000, 1187500, 1175000,
+	  1162500, 1150000, 1137500, 1125000, 1112500, 1100000, 1087500 },
+	{ 1200,    1200000, 1187500, 1175000, 1162500, 1150000, 1137500, 1125000,
+	  1112500, 1100000, 1087500, 1075000, 1062500, 1050000, 1037500 },
+	{ 1100,    1162500, 1150000, 1137500, 1125000, 1112500, 1100000, 1087500,
+	  1075000, 1062500, 1050000, 1037500, 1025000, 1012500, 1000000 },
+	{ 1000,    1125000, 1112500, 1100000, 1087500, 1075000, 1062500, 1050000,
+	  1037500, 1025000, 1012500, 1000000, 987500,  975000,  962500 },
+	{ 900,     1087500, 1075000, 1062500, 1050000, 1037500, 1025000, 1012500,
+	  1000000, 987500,  975000,  962500,  950000,  937500,  925000 },
+	{ 800,     1050000, 1037500, 1025000, 1012500, 1000000, 987500,  975000,
+	  962500,  950000,  937500,  925000,  912500,  900000,  900000 },
+	{ 700,     1012500, 1000000, 987500,  975000,  962500,  950000,  937500,
+	  925000,  912500,  900000,  900000,  900000,  900000,  900000 },
+	{ 600,     975000,  962500,  950000,  937500,  925000,  912500,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 500,     937500,  925000,  912500,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 400,     925000,  912500,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 300,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+	{ 200,     900000,  900000,  900000,  900000,  900000,  900000,  900000,
+	  900000,  900000,  900000,  900000,  900000,  900000,  900000 },
+}
+};
+
+static const struct asv_limit_entry __asv_limits[ASV_GROUPS_NUM] = {
+	{ 13, 55 },
+	{ 21, 65 },
+	{ 25, 69 },
+	{ 30, 72 },
+	{ 36, 74 },
+	{ 43, 76 },
+	{ 51, 78 },
+	{ 65, 80 },
+	{ 81, 82 },
+	{ 98, 84 },
+	{ 119, 87 },
+	{ 135, 89 },
+	{ 150, 92 },
+	{ 999, 999 },
+};
+
+static int exynos5422_asv_get_group(struct exynos_asv *asv)
+{
+	unsigned int pkgid_reg, auxi_reg;
+	int hpm, ids, i;
+
+	regmap_read(asv->chipid_regmap, EXYNOS_CHIPID_REG_PKG_ID, &pkgid_reg);
+	regmap_read(asv->chipid_regmap, EXYNOS_CHIPID_REG_AUX_INFO, &auxi_reg);
+
+	if (asv->use_sg) {
+		u32 sga = (pkgid_reg >> EXYNOS5422_SG_A_OFFSET) &
+			   EXYNOS5422_SG_A_MASK;
+
+		u32 sgb = (pkgid_reg >> EXYNOS5422_SG_B_OFFSET) &
+			   EXYNOS5422_SG_B_MASK;
+
+		if ((pkgid_reg >> EXYNOS5422_SG_BSIGN_OFFSET) &
+		     EXYNOS5422_SG_BSIGN_MASK)
+			return sga + sgb;
+		else
+			return sga - sgb;
+	}
+
+	hpm = (auxi_reg >> EXYNOS5422_TMCB_OFFSET) & EXYNOS5422_TMCB_MASK;
+	ids = (pkgid_reg >> EXYNOS5422_IDS_OFFSET) & EXYNOS5422_IDS_MASK;
+
+	for (i = 0; i < ASV_GROUPS_NUM; i++) {
+		if (ids <= __asv_limits[i].ids)
+			break;
+		if (hpm <= __asv_limits[i].hpm)
+			break;
+	}
+	if (i < ASV_GROUPS_NUM)
+		return i;
+
+	return 0;
+}
+
+static int __asv_offset_voltage(unsigned int index)
+{
+	switch (index) {
+	case 1:
+		return 12500;
+	case 2:
+		return 50000;
+	case 3:
+		return 25000;
+	default:
+		return 0;
+	};
+}
+
+static void exynos5422_asv_offset_voltage_setup(struct exynos_asv *asv)
+{
+	struct exynos_asv_subsys *subsys;
+	unsigned int reg, value;
+
+	regmap_read(asv->chipid_regmap, EXYNOS_CHIPID_REG_AUX_INFO, &reg);
+
+	/* ARM offset voltage setup */
+	subsys = &asv->subsys[EXYNOS_ASV_SUBSYS_ID_ARM];
+
+	subsys->base_volt = 1000000;
+
+	value = (reg >> EXYNOS5422_ARM_UP_OFFSET) & EXYNOS5422_ARM_UP_MASK;
+	subsys->offset_volt_h = __asv_offset_voltage(value);
+
+	value = (reg >> EXYNOS5422_ARM_DN_OFFSET) & EXYNOS5422_ARM_DN_MASK;
+	subsys->offset_volt_l = __asv_offset_voltage(value);
+
+	/* KFC offset voltage setup */
+	subsys = &asv->subsys[EXYNOS_ASV_SUBSYS_ID_KFC];
+
+	subsys->base_volt = 1000000;
+
+	value = (reg >> EXYNOS5422_KFC_UP_OFFSET) & EXYNOS5422_KFC_UP_MASK;
+	subsys->offset_volt_h = __asv_offset_voltage(value);
+
+	value = (reg >> EXYNOS5422_KFC_DN_OFFSET) & EXYNOS5422_KFC_DN_MASK;
+	subsys->offset_volt_l = __asv_offset_voltage(value);
+}
+
+static int exynos5422_asv_opp_get_voltage(struct exynos_asv_subsys *subsys,
+				int level, unsigned int volt)
+{
+	unsigned int asv_volt;
+
+	if (level >= subsys->table.num_rows)
+		return volt;
+
+	asv_volt = exynos_asv_opp_get_voltage(subsys, level,
+					      subsys->asv->group);
+
+	if (volt > subsys->base_volt)
+		asv_volt += subsys->offset_volt_h;
+	else
+		asv_volt += subsys->offset_volt_l;
+
+	return asv_volt;
+}
+
+static unsigned int exynos5422_asv_parse_table(struct exynos_asv *asv,
+				      unsigned int pkg_id)
+{
+	return (pkg_id >> EXYNOS5422_TABLE_OFFSET) & EXYNOS5422_TABLE_MASK;
+}
+
+static bool exynos5422_asv_parse_bin2(struct exynos_asv *asv,
+				     unsigned int pkg_id)
+{
+	return (pkg_id >> EXYNOS5422_BIN2_OFFSET) & EXYNOS5422_BIN2_MASK;
+}
+
+static bool exynos5422_asv_parse_sg(struct exynos_asv *asv,
+					unsigned int pkg_id)
+{
+	return ((pkg_id >> EXYNOS5422_USESG_OFFSET) & EXYNOS5422_USESG_MASK);
+}
+
+int exynos5422_asv_init(struct exynos_asv *asv)
+{
+	struct exynos_asv_subsys *subsys;
+	unsigned int table_index;
+	unsigned int pkg_id;
+	bool bin2;
+
+	regmap_read(asv->chipid_regmap, EXYNOS_CHIPID_REG_PKG_ID, &pkg_id);
+
+	if (asv->of_bin == 2) {
+		bin2 = true;
+		asv->use_sg = false;
+	} else {
+		asv->use_sg = exynos5422_asv_parse_sg(asv, pkg_id);
+		bin2 = exynos5422_asv_parse_bin2(asv, pkg_id);
+	}
+
+	asv->group = exynos5422_asv_get_group(asv);
+	asv->table = exynos5422_asv_parse_table(asv, pkg_id);
+
+	exynos5422_asv_offset_voltage_setup(asv);
+
+	if (bin2) {
+		table_index = 3;
+	} else {
+		if (asv->table == 2 || asv->table == 3)
+			table_index = asv->table - 1;
+		else
+			table_index = 0;
+	}
+
+	subsys = &asv->subsys[EXYNOS_ASV_SUBSYS_ID_ARM];
+	subsys->cpu_dt_compat = "arm,cortex-a15";
+	if (bin2)
+		subsys->table.num_rows = ASV_ARM_BIN2_DVFS_NUM;
+	else
+		subsys->table.num_rows = ASV_ARM_DVFS_NUM;
+	subsys->table.num_cols = ASV_GROUPS_NUM + 1;
+	subsys->table.buf = (u32 *)asv_arm_table[table_index];
+
+	subsys = &asv->subsys[EXYNOS_ASV_SUBSYS_ID_KFC];
+	subsys->cpu_dt_compat = "arm,cortex-a7";
+	if (bin2)
+		subsys->table.num_rows = ASV_KFC_BIN2_DVFS_NUM;
+	else
+		subsys->table.num_rows = ASV_KFC_DVFS_NUM;
+	subsys->table.num_cols = ASV_GROUPS_NUM + 1;
+	subsys->table.buf = (u32 *)asv_kfc_table[table_index];
+
+	asv->opp_get_voltage = exynos5422_asv_opp_get_voltage;
+
+	return 0;
+}
diff --git a/drivers/soc/samsung/exynos5422-asv.h b/drivers/soc/samsung/exynos5422-asv.h
new file mode 100644
index 000000000000..d8f108fcc39b
--- /dev/null
+++ b/drivers/soc/samsung/exynos5422-asv.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * Samsung Exynos 5422 SoC Adaptive Supply Voltage support
+ */
+
+#ifndef __EXYNOS5422_ASV_H
+#define __EXYNOS5422_ASV_H
+
+#include <linux/errno.h>
+
+struct exynos_asv;
+
+#ifdef CONFIG_EXYNOS_ASV_ARM
+int exynos5422_asv_init(struct exynos_asv *asv);
+#else
+static inline int exynos5422_asv_init(struct exynos_asv *asv)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+#endif /* __EXYNOS5422_ASV_H */
-- 
2.17.1

