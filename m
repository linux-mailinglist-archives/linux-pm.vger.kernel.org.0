Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA26CFC0
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbfGROba (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:31:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34973 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGROba (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:31:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718143128euoutp01a9d4a2ad596e5260ebe170a9815f072e~yhtlSn62L1313513135euoutp01u
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 14:31:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718143128euoutp01a9d4a2ad596e5260ebe170a9815f072e~yhtlSn62L1313513135euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563460288;
        bh=GxexQaGZG+sAY0gsqq2BuusRgkw0PyTNpfiAreTG6ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DF9PyU82NLpzwO1o89xqZRaKSDiG0A+YvlxdmNkaQp+h1A7aBDzFcwpCtEp3WRzbg
         40a1PrdOpuzH/aI3G9xDMNwhV6sigIRShGuQes8M36YB5wT686fgdbIQpFGOnqbNqX
         zynKlfGp3OxnzWsjQkiahAVCCa4hHHggDZjrrVgo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190718143127eucas1p27977cbbd1e1640c1a7053e374b61b5e0~yhtkj8Fue3233132331eucas1p2a;
        Thu, 18 Jul 2019 14:31:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C3.20.04325.FB2803D5; Thu, 18
        Jul 2019 15:31:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3~yhtj2aAk60448804488eucas1p1b;
        Thu, 18 Jul 2019 14:31:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718143126eusmtrp2cff0ec36d197b30db8f17c8f20ab35d9~yhtjoPfZj0339203392eusmtrp2A;
        Thu, 18 Jul 2019 14:31:26 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-c4-5d3082bfb430
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.A6.04140.EB2803D5; Thu, 18
        Jul 2019 15:31:26 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143126eusmtip18386d7ede1d45f20d7b77f0c1e339fef~yhtjBeXj11716617166eusmtip1u;
        Thu, 18 Jul 2019 14:31:26 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 1/9] soc: samsung: Add exynos chipid driver support
Date:   Thu, 18 Jul 2019 16:30:36 +0200
Message-Id: <20190718143044.25066-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718143044.25066-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87r7mwxiDVauU7LYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxvl/75gLZuhUbH/9
        gKmBsUe1i5GTQ0LAROLE6VOMXYxcHEICKxgl1n36wgThfGGU6P7zkQ3C+cwosXzmP0aYlo1P
        V7JCJJYzSpxdfR+hpfXrBhaQKjYBQ4neo31gHSICwhL3li5nByliFrjHJHH66VkmkISwgJvE
        viVd7CA2i4CqxNzuE2BxXgFriat/VjJDrJOXWL3hAJjNKWAjcfjuU7BrJQSms0tMfXMMqshF
        YtHfW1D3CUu8Or6FHcKWkfi/cz4TREMzo0TP7tvsEM4ERon7xxdAdVhLHD5+EegjDqD7NCXW
        79KHCDtK3DjxBCwsIcAnceOtIEiYGcictG06M0SYV6KjTQiiWkXi96rpTBC2lET3k/8sELaH
        RNOyJmg49jNKfF8whW0Co/wshGULGBlXMYqnlhbnpqcWG+ellusVJ+YWl+al6yXn525iBKaW
        0/+Of93BuO9P0iFGAQ5GJR7egFyDWCHWxLLiytxDjBIczEoivLdf6scK8aYkVlalFuXHF5Xm
        pBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYDx1VsMi99e5/LzCZke5a59X6oU1
        nDi/3JH7yuXflt2rr/PemSwjtDVPxO3Q0QM9/hVf06do1bBP25pctE5OtOhHQMSCNJ1P/Q5/
        2C62qoTWBxWyr5txcAdb4Y7LDzbssbC82W0cXFeownjw5NZ1S34pMzz//6L56dvF94xWFk1K
        9vibvPf49hQlluKMREMt5qLiRACA0JtXKQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7r7mgxiDZae1LHYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexvl/75gLZuhUbH/9gKmBsUe1i5GTQ0LARGLj05Ws
        XYxcHEICSxkltk86zdLFyAGUkJKY36IEUSMs8edaFxtEzSdGie/zO1lAEmwChhK9R/sYQWwR
        oKJ7S5ezgxQxC7xikrg97z8TSEJYwE1i35IudhCbRUBVYm73CbA4r4C1xNU/K5khNshLrN5w
        AMzmFLCROHz3KdhQIaCa2S+vMU5g5FvAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMMi3
        Hfu5ZQdj17vgQ4wCHIxKPLwBuQaxQqyJZcWVuYcYJTiYlUR4b7/UjxXiTUmsrEotyo8vKs1J
        LT7EaAp01ERmKdHkfGAE5pXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi
        4JRqYGS9zVMh3vbkk47LtbmW8w3dpabNl5976t3d4HWHAzlt+U7Hs1bkze9bNl99f6u005db
        rT7rr7skVK+PuPkn1Nlgu9o+tYh3upcemnemMs5cmrftgLSIyrwFD1Y+23XtSuPtVMP0f0sW
        2O9ksntxR6532pPHfxquc7CFJcgcXBLZl/Bz6vOGqd+UWIozEg21mIuKEwEE5n3GiAIAAA==
X-CMS-MailID: 20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3
References: <20190718143044.25066-1-s.nawrocki@samsung.com>
        <CGME20190718143127eucas1p13b1e2c98d270140a87f09562ef46c9a3@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

Exynos SoCs have Chipid, for identification of product IDs and SoC
revisions. This patch intends to provide initialization code for all
these functionalities, at the same time it provides some sysfs entries
for accessing these information to user-space.

This driver uses existing binding for exynos-chipid.

Changes by Bartlomiej:
- fixed return values on errors
- removed bogus kfree_const()
- added missing Exynos4210 EVT0 id
- converted code to use EXYNOS_MASK define
- fixed np use after of_node_put()
- fixed too early use of dev_info()
- made driver fail for unknown SoC-s
- added SPDX tag
- updated Copyrights

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
[m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[s.nawrocki: updated copyright date]
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/soc/samsung/Kconfig         |   5 ++
 drivers/soc/samsung/Makefile        |   2 +
 drivers/soc/samsung/exynos-chipid.c | 111 ++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-chipid.c

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 2186285fda92..2905f5262197 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -7,6 +7,11 @@ menuconfig SOC_SAMSUNG
 
 if SOC_SAMSUNG
 
+config EXYNOS_CHIPID
+	bool "Exynos Chipid controller driver" if COMPILE_TEST
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	select SOC_BUS
+
 config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
 	depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 29f294baac6e..3b6a8797416c 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
new file mode 100644
index 000000000000..78b123ee60c0
--- /dev/null
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * EXYNOS - CHIP ID support
+ * Author: Pankaj Dubey <pankaj.dubey@samsung.com>
+ * Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define EXYNOS_SUBREV_MASK	(0xF << 4)
+#define EXYNOS_MAINREV_MASK	(0xF << 0)
+#define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
+#define EXYNOS_MASK		0xFFFFF000
+
+static const struct exynos_soc_id {
+	const char *name;
+	unsigned int id;
+} soc_ids[] = {
+	{ "EXYNOS3250", 0xE3472000 },
+	{ "EXYNOS4210", 0x43200000 },	/* EVT0 revision */
+	{ "EXYNOS4210", 0x43210000 },
+	{ "EXYNOS4212", 0x43220000 },
+	{ "EXYNOS4412", 0xE4412000 },
+	{ "EXYNOS5250", 0x43520000 },
+	{ "EXYNOS5260", 0xE5260000 },
+	{ "EXYNOS5410", 0xE5410000 },
+	{ "EXYNOS5420", 0xE5420000 },
+	{ "EXYNOS5440", 0xE5440000 },
+	{ "EXYNOS5800", 0xE5422000 },
+	{ "EXYNOS7420", 0xE7420000 },
+	{ "EXYNOS5433", 0xE5433000 },
+};
+
+static const char * __init product_id_to_soc_id(unsigned int product_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
+		if ((product_id & EXYNOS_MASK) == soc_ids[i].id)
+			return soc_ids[i].name;
+	return NULL;
+}
+
+int __init exynos_chipid_early_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	void __iomem *exynos_chipid_base;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	struct device_node *np;
+	u32 product_id;
+	u32 revision;
+
+	/* look up for chipid node */
+	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
+	if (!np)
+		return -ENODEV;
+
+	exynos_chipid_base = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!exynos_chipid_base) {
+		pr_err("Failed to map SoC chipid\n");
+		return -ENXIO;
+	}
+
+	product_id = readl_relaxed(exynos_chipid_base);
+	revision = product_id & EXYNOS_REV_MASK;
+	iounmap(exynos_chipid_base);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = "Samsung Exynos";
+
+	root = of_find_node_by_path("/");
+	of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
+	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
+	if (!soc_dev_attr->soc_id) {
+		pr_err("Unknown SoC\n");
+		return -ENODEV;
+	}
+
+	/* please note that the actual registration will be deferred */
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	/* it is too early to use dev_info() here (soc_dev is NULL) */
+	pr_info("soc soc0: Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
+		soc_dev_attr->soc_id, product_id, revision);
+
+	return 0;
+}
+early_initcall(exynos_chipid_early_init);
-- 
2.17.1

