Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2488BC9D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfHMPJc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 11:09:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54812 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfHMPIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 11:08:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190813150853euoutp0299dc8dfd8a3c506da1018afa09e4c287~6g-rcO0z41875518755euoutp02b
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 15:08:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190813150853euoutp0299dc8dfd8a3c506da1018afa09e4c287~6g-rcO0z41875518755euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565708933;
        bh=CHwrcQgxdxi20bpPDuVxUcb9c8px2mVrekv0Siy9/y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VI8ZoyuqVMR1Vsv/VduYc0zoTFHzb8iK/4dFNmqb+2lTbPwRuRstDNMn8U4TdiVnc
         IfmeMZyBru/bZfbRR34fBuisooFakKZ6l68KMUTxZaL5R5IqXVz7iB1vMi8Cl/FVmf
         shkKrXq8anwpDe4p228nfwJDur32dfJ9hLYnwDRs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190813150853eucas1p2b3e8dc6697564147a45468b05606426b~6g-qnYUpZ1046510465eucas1p2E;
        Tue, 13 Aug 2019 15:08:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.FA.04374.482D25D5; Tue, 13
        Aug 2019 16:08:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c~6g-p3o1FT2658526585eucas1p2_;
        Tue, 13 Aug 2019 15:08:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190813150851eusmtrp241579caea272c8ee6a5850e906e31577~6g-pn97Og2922129221eusmtrp2l;
        Tue, 13 Aug 2019 15:08:51 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-ff-5d52d2843f99
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.23.04117.382D25D5; Tue, 13
        Aug 2019 16:08:51 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190813150851eusmtip260ca00771b69f26e8db2c41c03c96151~6g-pDjpEg1086510865eusmtip2B;
        Tue, 13 Aug 2019 15:08:51 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
Date:   Tue, 13 Aug 2019 17:08:20 +0200
Message-Id: <20190813150827.31972-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813150827.31972-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87otl4JiDS5M1bPYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxsLrexgLfqhUPH6/
        kb2BcZV8FyMnh4SAicTt/x+Yuxi5OIQEVjBKXJrcwwThfGGUuDhnHyOE85lRYl7nIVaYljMT
        d0AlljNKPOnbyg7X8vByMzNIFZuAoUTv0T5GEFtEQFji3tLlYEXMAveYJE4/PcsEkhAWiJLY
        v6cJrIhFQFXi28JT7CA2r4C1xME/h5gg1slLrN5wAGwop4CNxM7p71lBBkkITGaX2D15OtRN
        LhLvts5mgbCFJV4d38IOYctI/N85nwmioZlRomf3bXYIZwKjxP3jCxghqqwlDh+/CDSJA+g+
        TYn1u/RBTAkBR4krB40hTD6JG28FQYqZgcxJ26YzQ4R5JTrahCBmqEj8XjUd6mQpie4n/6Gu
        8ZDY9acLGsD9jBIt07YwTmCUn4WwawEj4ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA
        xHL63/GvOxj3/Uk6xCjAwajEwxuwJShWiDWxrLgy9xCjBAezkgjvhItAId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYwrHxs/Yzwhe2LxrARxgZB1+338
        nsVz3T0SuMTvimmjrfHHtu3zFr5M+SrR/vjhfOfLXNGbNNYaVfu7th83nOyota7P736RzPzH
        X2uEZJjYnpzaYS8sEsVyfumsgzf47de7WbHU+mf7BfZGn2yvK3OpnvlVyn7ZhfsanYGcJ6ak
        FIrYOIfIMSixFGckGmoxFxUnAgAnkxGaKAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xe7rNl4JiDZ4ss7TYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsLrexgLfqhUPH6/kb2BcZV8FyMnh4SAicSZiTsY
        uxi5OIQEljJKXL/UCeRwACWkJOa3KEHUCEv8udbFBlHziVHi5LIGJpAEm4ChRO/RPkYQWwSo
        6N7S5ewgRcwCr5gkbs/7D1YkLBAh8X3PJLAiFgFViW8LT7GD2LwC1hIH/xxigtggL7F6wwFm
        EJtTwEZi5/T3rCC2EFDN03frmScw8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGOTb
        jv3cAvTFu+BDjAIcjEo8vAFbgmKFWBPLiitzDzFKcDArifBOuAgU4k1JrKxKLcqPLyrNSS0+
        xGgKdNREZinR5HxgBOaVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCU
        amBMFhefEuyhsk+8WlNf2ffAZlm1Q0cnCLa+03zpEvcusvvvzA3JVUJXelhz9fsafxYeLdeQ
        aOeNWTYzfs/F72sm7uBV1tfcWCa+g0fYhts19R5Hx3Pfn9weR+Z4FC/3Mynpmmd6VGrajz9i
        m7g2ma7TSXzeUNr/SOXDLyuPmJXRO7ru13sHHFdiKc5INNRiLipOBADXCbbMiAIAAA==
X-CMS-MailID: 20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c
References: <20190813150827.31972-1-s.nawrocki@samsung.com>
        <CGME20190813150852eucas1p2be4c0ab5ec2c079e3daf1af24283b27c@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the driver to use regmap API in order to allow other
drivers, like ASV, to access the CHIPID registers.

This patch adds definition of selected CHIPID register offsets
and register bit fields for Exynos5422 SoC.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - s/_EXYNOS_ASV_H/__LINU_SOC_EXYNOS_ASV_H,
 - removed __func__ from error log,
 - removed unneeded <linux/of_address.h> header inclusion.

Changes since v1 (RFC):
 - new patch
---
 drivers/soc/samsung/exynos-chipid.c       | 34 ++++++---------
 include/linux/soc/samsung/exynos-chipid.h | 52 +++++++++++++++++++++++
 2 files changed, 65 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/soc/samsung/exynos-chipid.h

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index bcf691f2b650..006a95feb618 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -9,16 +9,13 @@
  */
 
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/soc/samsung/exynos-chipid.h>
 #include <linux/sys_soc.h>
 
-#define EXYNOS_SUBREV_MASK	(0xF << 4)
-#define EXYNOS_MAINREV_MASK	(0xF << 0)
-#define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
-#define EXYNOS_MASK		0xFFFFF000
-
 static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
@@ -51,29 +48,24 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
 int __init exynos_chipid_early_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
-	void __iomem *exynos_chipid_base;
 	struct soc_device *soc_dev;
 	struct device_node *root;
-	struct device_node *np;
+	struct regmap *regmap;
 	u32 product_id;
 	u32 revision;
+	int ret;
 
-	/* look up for chipid node */
-	np = of_find_compatible_node(NULL, NULL, "samsung,exynos4210-chipid");
-	if (!np)
-		return -ENODEV;
-
-	exynos_chipid_base = of_iomap(np, 0);
-	of_node_put(np);
-
-	if (!exynos_chipid_base) {
-		pr_err("Failed to map SoC chipid\n");
-		return -ENXIO;
+	regmap = syscon_regmap_lookup_by_compatible("samsung,exynos4210-chipid");
+	if (IS_ERR(regmap)) {
+		pr_err("Failed to get CHIPID regmap\n");
+		return PTR_ERR(regmap);
 	}
 
-	product_id = readl_relaxed(exynos_chipid_base);
+	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &product_id);
+	if (ret < 0)
+		return ret;
+
 	revision = product_id & EXYNOS_REV_MASK;
-	iounmap(exynos_chipid_base);
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
diff --git a/include/linux/soc/samsung/exynos-chipid.h b/include/linux/soc/samsung/exynos-chipid.h
new file mode 100644
index 000000000000..8bca6763f99c
--- /dev/null
+++ b/include/linux/soc/samsung/exynos-chipid.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * Exynos - CHIPID support
+ */
+#ifndef __LINUX_SOC_EXYNOS_CHIPID_H
+#define __LINUX_SOC_EXYNOS_CHIPID_H
+
+#define EXYNOS_CHIPID_REG_PRO_ID	0x00
+#define EXYNOS_SUBREV_MASK		(0xf << 4)
+#define EXYNOS_MAINREV_MASK		(0xf << 0)
+#define EXYNOS_REV_MASK			(EXYNOS_SUBREV_MASK | \
+					 EXYNOS_MAINREV_MASK)
+#define EXYNOS_MASK			0xfffff000
+
+#define EXYNOS_CHIPID_REG_PKG_ID	0x04
+/* Bit field definitions for EXYNOS_CHIPID_REG_PKG_ID register */
+#define EXYNOS5422_IDS_OFFSET		24
+#define EXYNOS5422_IDS_MASK		0xff
+#define EXYNOS5422_USESG_OFFSET	3
+#define EXYNOS5422_USESG_MASK		0x01
+#define EXYNOS5422_SG_OFFSET		0
+#define EXYNOS5422_SG_MASK		0x07
+#define EXYNOS5422_TABLE_OFFSET	8
+#define EXYNOS5422_TABLE_MASK		0x03
+#define EXYNOS5422_SG_A_OFFSET		17
+#define EXYNOS5422_SG_A_MASK		0x0f
+#define EXYNOS5422_SG_B_OFFSET		21
+#define EXYNOS5422_SG_B_MASK		0x03
+#define EXYNOS5422_SG_BSIGN_OFFSET	23
+#define EXYNOS5422_SG_BSIGN_MASK	0x01
+#define EXYNOS5422_BIN2_OFFSET		12
+#define EXYNOS5422_BIN2_MASK		0x01
+
+#define EXYNOS_CHIPID_REG_LOT_ID	0x14
+
+#define EXYNOS_CHIPID_REG_AUX_INFO	0x1c
+/* Bit field definitions for EXYNOS_CHIPID_REG_AUX_INFO register */
+#define EXYNOS5422_TMCB_OFFSET		0
+#define EXYNOS5422_TMCB_MASK		0x7f
+#define EXYNOS5422_ARM_UP_OFFSET	8
+#define EXYNOS5422_ARM_UP_MASK		0x03
+#define EXYNOS5422_ARM_DN_OFFSET	10
+#define EXYNOS5422_ARM_DN_MASK		0x03
+#define EXYNOS5422_KFC_UP_OFFSET	12
+#define EXYNOS5422_KFC_UP_MASK		0x03
+#define EXYNOS5422_KFC_DN_OFFSET	14
+#define EXYNOS5422_KFC_DN_MASK		0x03
+
+#endif /*__LINUX_SOC_EXYNOS_CHIPID_H */
-- 
2.17.1

