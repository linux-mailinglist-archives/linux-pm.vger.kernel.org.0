Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B01E74BB
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 16:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390613AbfJ1PPv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 11:15:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56432 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfJ1PPv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 11:15:51 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191028151547euoutp0288c625143dcbe1d0361a2768c24ba1e3~R2HZNcdjV1959419594euoutp022
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 15:15:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191028151547euoutp0288c625143dcbe1d0361a2768c24ba1e3~R2HZNcdjV1959419594euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572275747;
        bh=q4XNlQpYQhGsk+dCpGyDLD3VkD/n8749uNeVjUPIGZk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sOP/G4PrgJ6GLhfQDXNq1l/+U6583E5yIEvTzbMnf3oPgOvDDh7nDfkA5JWtIfBIG
         GyFTG5fXUGtLm62QDBW0q1NKl1ucaetnPKdjFX1aAh2Vmu/vEXbLt/BZVAfWhGMeMC
         Nj7tVN4mnoh2wYk6QXLvk0fRViYAvR8WjlCl2QNo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191028151547eucas1p1efb50e88a0d4f9679bc6fe70f72803f9~R2HY75iuO0606506065eucas1p11;
        Mon, 28 Oct 2019 15:15:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CF.D5.04469.32607BD5; Mon, 28
        Oct 2019 15:15:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191028151546eucas1p120f516f70114027d99724a40ea163af0~R2HYnWJpn1547515475eucas1p16;
        Mon, 28 Oct 2019 15:15:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191028151546eusmtrp23ab57cdfac4412bc398ec69421e4808c~R2HYmo-4b2864428644eusmtrp2L;
        Mon, 28 Oct 2019 15:15:46 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-99-5db706235aa1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.17.04117.22607BD5; Mon, 28
        Oct 2019 15:15:46 +0000 (GMT)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191028151546eusmtip17b9d89f13b98196e2c980ececc7d9099~R2HYF2Q1d2147221472eusmtip1v;
        Mon, 28 Oct 2019 15:15:46 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     vireshk@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v6 1/2] soc: samsung: Add Exynos Adaptive Supply Voltage
 driver
Date:   Mon, 28 Oct 2019 16:15:33 +0100
Message-Id: <20191028151534.9920-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUgTYRzv2d1t53RyTcEnC6VVRlHawA9HRRYFjSjRr8qYMw+13Jx38y2J
        FlHLl+kyZJLJRiTaLJ2nTk0SnS/7YDRnIqJmgi2jFF/m6JVs21l9+73y/z9/HhwRr6PReK5a
        S9FqZZ6EL0TtY99dxw/we+Qn2PEwsqO+HSNdLpuAZJemMdJrGAFkvWuAR74YeScgh1f0GNm5
        OMY/i8tYazlf1vn0lqy6ywpkXjYmBU0Tns6i8nKLKDrhTIYwp7ymFtHYLLySxk9DmA6Ue0AF
        wHFIJML1JUUFEOJiogXAtt45lCNbAOr0DQhHvAA2eO/6GyHBxubteYwzmgFcM20J/lWGVquw
        QIpPSKFhtDrYiCQi4EJTczCEEIsAzvQN8QJGBJEK6yZswRBKHILmB92CABYRJ+EPw3OUGxcL
        W22DwT0gMceHNRsTO8YFyLZ9xTgcAT87uwQc3ge3+8w8rnAHwKr+OQFHjAC+d1p2XnEKDjvd
        WOAGCHEEtr9M4ORz0No6JeBOEw5nVncHZMQPa+0mhJNF8P49MZc+CH9aTTwOR8PKD9soF5FB
        hw8PyGJCDhsnXqFGEPPo/ygLAFYQRRUyqmyKkaqp4nhGqWIK1dnxV/NVLPD/g/Hfzs1e4JvM
        dAACB5IwkfGtXS7GlEVMqcoBII5IIkXu135JlKUsvUHR+Qq6MI9iHGAvjkqiRGW7FtPFRLZS
        S12nKA1F/3V5eEi0DlQPV+4PTVnpuHLzSfHkcobZ8Ws+XPWQSJMdi0n39Osq8mctGtNC/bVL
        JRtx9EfPzOx5tT3N7dNMZrYUfHmWQmsfXxx84z7cm5g0yE53OLrX91yuM4d8Cx0xjiY3eQ0D
        nilWrvVJRWUtVLgiuVmoX16I0/fAgtjttbEkJCpVgjI5SulRhGaUfwBx2D+xAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xu7pKbNtjDY73mlpsnLGe1eL8+Q3s
        FpseX2O1+Nx7hNFixvl9TBZrj9xltzj8pp3VYvODY2wOHB6bVnWyeWxeUu/Rt2UVo8fnTXIB
        LFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GZ39
        k5gLNixgqpj74iBrA2PnU8YuRk4OCQETiU+Nd1hBbCGBpYwSV9fldDFyAMWlJOa3KEGUCEv8
        udbF1sXIBVTyiVHi2MvHbCAJNgFDid6jfWBzRICK7i1dzg5SxCzwjFHi99pvjCCDhAX8JU5t
        lQWpYRFQlZg/cSs7iM0rYCXxq3cNC8QCeYnVGw4wT2DkWcDIsIpRJLW0ODc9t9hIrzgxt7g0
        L10vOT93EyMwBLcd+7llB2PXu+BDjAIcjEo8vC+ubosVYk0sK67MPcQowcGsJMJ78QxQiDcl
        sbIqtSg/vqg0J7X4EKMp0PKJzFKiyfnA+MgriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliS
        mp2aWpBaBNPHxMEp1cCoxseqd/j6hs2LeLUKY1rvfdjWkvr0v8/Vo5u8lvy18l/vtqHvZv6z
        mSyfl/TOYWqw2cjwdFLHldsH+MRTRe99tuwxWJSnmv3m8VnZwoipjxj3zq34Zc57gK8356aa
        39vcwq3pzqe2Xz2hNlc4uFnq55fDR5V+nWf8XMp6fKre1a/fP7eGrv3+XYmlOCPRUIu5qDgR
        AJZ4uUpXAgAA
X-CMS-MailID: 20191028151546eucas1p120f516f70114027d99724a40ea163af0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191028151546eucas1p120f516f70114027d99724a40ea163af0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191028151546eucas1p120f516f70114027d99724a40ea163af0
References: <CGME20191028151546eucas1p120f516f70114027d99724a40ea163af0@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Adaptive Supply Voltage (ASV) driver adjusts CPU cluster operating
points depending on exact revision of an SoC retrieved from the CHIPID
block or the OTP memory.  This allows for some power saving as for some
CPU clock frequencies we can lower CPU cluster's supply voltage comparing
to safe values common to all the SoC revisions.

This patch adds support for Exynos5422/5800 SoC, it is partially based
on code from https://github.com/hardkernel/linux repository,
branch odroidxu4-4.14.y, files: arch/arm/mach-exynos/exynos5422-asv.[ch].

Tested on Odroid XU3, XU4, XU3 Lite.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v5:
 - "syscon" compatible in the chipid node is not required any more,
   use device_node_to_regmap() instead of syscon_node_to_regmap(),
 - dropped "Unsupported product ID" log,
 - EXYNOS_ASV_SYSBSYS* enumeration simplified and moved to exynos5422
   specific header,
 - dropped unnecessary headers inclusion,
 - dropped unused argument from exynos5422_asv_parse* helpers,
 - added const qualifier to some function arguments.

Changes since v4:
 - Fixed include guard in drivers/soc/samsung/exynos5422-asv.h

Changes since v3:
 - instead of removing/adding OPP use dedicated API to adjust OPP's
   voltage, only exynos_asv_update_cpu_opps() function has changed,
 - added a comment describing ASV tables at beginning of
   exynos5422-asv.c file.

Changes since v2:
 - use devm_kzalloc() in probe() to avoid memory leak,
 - removed leading spaces in exynos-chipid.h,
 - removed unneeded <linux/init.h> header inclusion,
 - dropped parentheses from exynos542_asv_parse_sg(),
 - updated Kconfig entry,
 - added const attribute to struct exynos_asv_susbsys::cpu_dt_compat.

Changes since v1 (RFC):
 - removed code for parsing the ASV OPP tables from DT, the ASV OPP tables
   moved to the driver,
 - converted to use the regmap API,
 - converted to normal platform driver.

---
 drivers/soc/samsung/Kconfig          |  10 +
 drivers/soc/samsung/Makefile         |   3 +
 drivers/soc/samsung/exynos-asv.c     | 177 ++++++++++
 drivers/soc/samsung/exynos-asv.h     |  71 ++++
 drivers/soc/samsung/exynos5422-asv.c | 505 +++++++++++++++++++++++++++
 drivers/soc/samsung/exynos5422-asv.h |  31 ++
 6 files changed, 797 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-asv.c
 create mode 100644 drivers/soc/samsung/exynos-asv.h
 create mode 100644 drivers/soc/samsung/exynos5422-asv.c
 create mode 100644 drivers/soc/samsung/exynos5422-asv.h

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 33ad0de2de3c..27fc59bbb520 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -7,6 +7,16 @@ menuconfig SOC_SAMSUNG

 if SOC_SAMSUNG

+config EXYNOS_ASV
+	bool "Exynos Adaptive Supply Voltage support" if COMPILE_TEST
+	depends on (ARCH_EXYNOS && EXYNOS_CHIPID) || COMPILE_TEST
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
index 000000000000..8abf4dfaa5c5
--- /dev/null
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -0,0 +1,177 @@
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
+		unsigned int new_volt, volt;
+		int ret;
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
+		volt = dev_pm_opp_get_voltage(opp);
+		new_volt = asv->opp_get_voltage(subsys, i, volt);
+		dev_pm_opp_put(opp);
+
+		if (new_volt == volt)
+			continue;
+
+		ret = dev_pm_opp_adjust_voltage(cpu, opp_freq * MHZ,
+						new_volt, new_volt, new_volt);
+		if (ret < 0)
+			dev_err(asv->dev,
+				"Failed to adjust OPP %u Hz/%u uV for cpu%d\n",
+				opp_freq, new_volt, cpu->id);
+		else
+			dev_dbg(asv->dev,
+				"Adjusted OPP %u Hz/%u -> %u uV, cpu%d\n",
+				opp_freq, volt, new_volt, cpu->id);
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
+	asv = devm_kzalloc(&pdev->dev, sizeof(*asv), GFP_KERNEL);
+	if (!asv)
+		return -ENOMEM;
+
+	asv->chipid_regmap = device_node_to_regmap(pdev->dev.of_node);
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
index 000000000000..3fd1f2acd999
--- /dev/null
+++ b/drivers/soc/samsung/exynos-asv.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ * Author: Sylwester Nawrocki <s.nawrocki@samsung.com>
+ *
+ * Samsung Exynos SoC Adaptive Supply Voltage support
+ */
+#ifndef __LINUX_SOC_EXYNOS_ASV_H
+#define __LINUX_SOC_EXYNOS_ASV_H
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
+	const char *cpu_dt_compat;
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
+	int (*opp_get_voltage)(const struct exynos_asv_subsys *subs,
+			       int level, unsigned int voltage);
+	unsigned int group;
+	unsigned int table;
+
+	/* True if SG fields from PKG_ID register should be used */
+	bool use_sg;
+	/* ASV bin read from DT */
+	int of_bin;
+};
+
+static inline u32 __asv_get_table_entry(const struct exynos_asv_table *table,
+					unsigned int row, unsigned int col)
+{
+	return table->buf[row * (table->num_cols) + col];
+}
+
+static inline u32 exynos_asv_opp_get_voltage(const struct exynos_asv_subsys *subsys,
+					unsigned int level, unsigned int group)
+{
+	return __asv_get_table_entry(&subsys->table, level, group + 1);
+}
+
+static inline u32 exynos_asv_opp_get_frequency(const struct exynos_asv_subsys *subsys,
+					unsigned int level)
+{
+	return __asv_get_table_entry(&subsys->table, level, 0);
+}
+
+#endif /* __LINUX_SOC_EXYNOS_ASV_H */
diff --git a/drivers/soc/samsung/exynos5422-asv.c b/drivers/soc/samsung/exynos5422-asv.c
new file mode 100644
index 000000000000..01bb3050d678
--- /dev/null
+++ b/drivers/soc/samsung/exynos5422-asv.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * Samsung Exynos 5422 SoC Adaptive Supply Voltage support
+ */
+
+#include <linux/bitrev.h>
+#include <linux/errno.h>
+#include <linux/regmap.h>
+#include <linux/soc/samsung/exynos-chipid.h>
+#include <linux/slab.h>
+
+#include "exynos-asv.h"
+#include "exynos5422-asv.h"
+
+#define ASV_GROUPS_NUM		14
+#define ASV_ARM_DVFS_NUM	20
+#define ASV_ARM_BIN2_DVFS_NUM	17
+#define ASV_KFC_DVFS_NUM	14
+#define ASV_KFC_BIN2_DVFS_NUM	12
+
+/*
+ * This array is a set of 4 ASV data tables, first column of each ASV table
+ * contains frequency value in MHz and subsequent columns contain the CPU
+ * cluster's supply voltage values in uV.
+ * In order to create a set of OPPs for specific SoC revision one of the voltage
+ * columns (1...14) from one of the tables (0...3) is selected during
+ * initialization. There are separate ASV tables for the big (ARM) and little
+ * (KFC) CPU cluster. Only OPPs which are already defined in devicetree
+ * will be updated.
+ */
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
+static int exynos5422_asv_opp_get_voltage(const struct exynos_asv_subsys *subsys,
+					  int level, unsigned int volt)
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
+static unsigned int exynos5422_asv_parse_table(unsigned int pkg_id)
+{
+	return (pkg_id >> EXYNOS5422_TABLE_OFFSET) & EXYNOS5422_TABLE_MASK;
+}
+
+static bool exynos5422_asv_parse_bin2(unsigned int pkg_id)
+{
+	return (pkg_id >> EXYNOS5422_BIN2_OFFSET) & EXYNOS5422_BIN2_MASK;
+}
+
+static bool exynos5422_asv_parse_sg(unsigned int pkg_id)
+{
+	return (pkg_id >> EXYNOS5422_USESG_OFFSET) & EXYNOS5422_USESG_MASK;
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
+		asv->use_sg = exynos5422_asv_parse_sg(pkg_id);
+		bin2 = exynos5422_asv_parse_bin2(pkg_id);
+	}
+
+	asv->group = exynos5422_asv_get_group(asv);
+	asv->table = exynos5422_asv_parse_table(pkg_id);
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
index 000000000000..95a5fb1a7508
--- /dev/null
+++ b/drivers/soc/samsung/exynos5422-asv.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * Samsung Exynos 5422 SoC Adaptive Supply Voltage support
+ */
+
+#ifndef __LINUX_SOC_EXYNOS5422_ASV_H
+#define __LINUX_SOC_EXYNOS5422_ASV_H
+
+#include <linux/errno.h>
+
+enum {
+	EXYNOS_ASV_SUBSYS_ID_ARM,
+	EXYNOS_ASV_SUBSYS_ID_KFC,
+	EXYNOS_ASV_SUBSYS_ID_MAX
+};
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
+#endif /* __LINUX_SOC_EXYNOS5422_ASV_H */
--
2.17.1

