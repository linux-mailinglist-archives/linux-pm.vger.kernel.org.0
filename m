Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5319B6CFC1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 16:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390672AbfGRObb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 10:31:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34991 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390649AbfGRObb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 10:31:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190718143130euoutp01e51da4b217903a11942ff5746c2b6a84~yhtm6q_WG1278312783euoutp01O
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 14:31:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190718143130euoutp01e51da4b217903a11942ff5746c2b6a84~yhtm6q_WG1278312783euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563460290;
        bh=6Mongs3rKoQIIy+5lxAFgXp5DxRMdW7uILP3705yXZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcdEkwAsxYSYuAyLhufmMV/f0Q7FCp9pTrBh9N6s9xWBUP8etKu7DPzVoJFAhGzJ/
         /hGXOL8oFVg4OjzHxRoN5fb3HXFysMVYl546tSIvmL6fMwFRPHmrpWvoLKDdlR47JI
         ViEAK9rKteWm8mf5RVcxGummEnWfNVOspzco6gtY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190718143129eucas1p12dfdee2ffbb3aec78a47a77054674860~yhtmNABe60701407014eucas1p1Z;
        Thu, 18 Jul 2019 14:31:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 93.55.04377.1C2803D5; Thu, 18
        Jul 2019 15:31:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190718143128eucas1p2677ae16d229dddcd9a0db8084f0da5cf~yhtlihN-71435014350eucas1p2S;
        Thu, 18 Jul 2019 14:31:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190718143128eusmtrp160704d7710faea506b30aed717b8d37b~yhtlUc-Io1897918979eusmtrp1S;
        Thu, 18 Jul 2019 14:31:28 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-1b-5d3082c1280c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.3E.04146.0C2803D5; Thu, 18
        Jul 2019 15:31:28 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718143127eusmtip1657223273b812ceda58a30f9f07bbfa2~yhtktREIm1716617166eusmtip1v;
        Thu, 18 Jul 2019 14:31:27 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 2/9] soc: samsung: Convert exynos-chipid driver to use
 the regmap API
Date:   Thu, 18 Jul 2019 16:30:37 +0200
Message-Id: <20190718143044.25066-3-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718143044.25066-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7oHmwxiDZ5PErbYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxsu1H1kLjitX/D++
        g72B8YdsFyMnh4SAicS0UweYuhi5OIQEVjBKrN97kBXC+cIo8fblfijnM1Bm0kZGmJYTLS2M
        EInljBIHVtxlg2u58WAOE0gVm4ChRO/RPrAOEQFhiXtLl7ODFDEL3GOSOP30LFiRsECUxMH+
        RjCbRUBVoq/nO5jNK2AtcWDZFRaIdfISqzccYAaxOQVsJA7ffQq2WkJgOrvEji27mCGKXCT+
        NfSwQ9jCEq+Ob4GyZSROT+5hgWhoZpTo2X2bHcKZwChx//gCqI+sJQ4fvwj0KgfQfZoS63fp
        Q4QdJTZ1dLCDhCUE+CRuvBUECTMDmZO2TWeGCPNKdLQJQVSrSPxeNZ0JwpaS6H7ynwWixEPi
        4GZuSAD1M0osO9vNMoFRfhbCrgWMjKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECE8vp
        f8e/7GDc9SfpEKMAB6MSD29ArkGsEGtiWXFl7iFGCQ5mJRHe2y/1Y4V4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzVjM8iBYSSE8sSc1OTS1ILYLJMnFwSjUwlhqe/vvpzbwWcZXE9C0e06xWPkxU
        W7Av/ydXdddM80CXBd77ZvWtv7W1+OWM9DvVb98brRFkv9d0rtHg5q2f13OvCx6ym3nQs/1I
        smVi/J8dZ6fbvm2Ryrp6wDXti4vjhzNxjzwOm4eKRX3U7P2SEq9YfP/C0mPxC6qK/txp7zBv
        69p6bIL6diWW4oxEQy3mouJEAMNJijEoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7oHmgxiDaZMU7TYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZvG59wijxYzz+5gs1h65y26xaOsXdovWvUfYLQ6/aWe1
        2PzgGJsDr8emVZ1sHpuX1Hv0bVnF6PF5k1wAS5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsu1H1kLjitX/D++g72B8YdsFyMnh4SAicSJlhbG
        LkYuDiGBpYwSn15vY+pi5ABKSEnMb1GCqBGW+HOtiw3EFhL4xChxdaoriM0mYCjRe7SPEcQW
        Aaq5t3Q5O8gcZoFXTBK35/1nAkkIC0RIPJs/A6yZRUBVoq/nO1icV8Ba4sCyKywQC+QlVm84
        wAxicwrYSBy++5QRYpm1xOyX1xgnMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERji
        24793LyD8dLG4EOMAhyMSjy8AbkGsUKsiWXFlbmHGCU4mJVEeG+/1I8V4k1JrKxKLcqPLyrN
        SS0+xGgKdNREZinR5Hxg/OWVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj
        4uCUamC00GUTUcpdv1zjm03Zeb2Ty98bF6zTlDkpEO5yWPLrLaXDLfHmv8xPKC4zmrJpeaJh
        x5OJWorle/aJm+RXJUpmX/VeUtlg/uPvEcE7W6OCFEqEPk5v1rMorn2QJfdEYAv/NZvLMdyX
        tldVN2x5p/3BbKbrq86D0i/31TXPMk7IqzJRrnHpv6bEUpyRaKjFXFScCAB9ejDLhwIAAA==
X-CMS-MailID: 20190718143128eucas1p2677ae16d229dddcd9a0db8084f0da5cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190718143128eucas1p2677ae16d229dddcd9a0db8084f0da5cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190718143128eucas1p2677ae16d229dddcd9a0db8084f0da5cf
References: <20190718143044.25066-1-s.nawrocki@samsung.com>
        <CGME20190718143128eucas1p2677ae16d229dddcd9a0db8084f0da5cf@eucas1p2.samsung.com>
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
Changes since v1 (RFC):
 - new patch
---
 drivers/soc/samsung/exynos-chipid.c       | 33 ++++++----------
 include/linux/soc/samsung/exynos-chipid.h | 48 +++++++++++++++++++++++
 2 files changed, 61 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/soc/samsung/exynos-chipid.h

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 78b123ee60c0..594b00488013 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -9,18 +9,16 @@
  */
 
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
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
@@ -53,29 +51,24 @@ static const char * __init product_id_to_soc_id(unsigned int product_id)
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
+		pr_err("%s: failed to get regmap\n", __func__);
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
index 000000000000..25359d70d617
--- /dev/null
+++ b/include/linux/soc/samsung/exynos-chipid.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 Samsung Electronics Co., Ltd.
+ *	      http://www.samsung.com/
+ *
+ * Exynos - CHIPID support
+ */
+
+#define EXYNOS_CHIPID_REG_PRO_ID	0x00
+ #define EXYNOS_SUBREV_MASK		(0xf << 4)
+ #define EXYNOS_MAINREV_MASK		(0xf << 0)
+ #define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | \
+					 EXYNOS_MAINREV_MASK)
+ #define EXYNOS_MASK			0xfffff000
+
+#define EXYNOS_CHIPID_REG_PKG_ID	0x04
+/* Bit field definitions for EXYNOS_CHIPID_REG_PKG_ID register */
+ #define EXYNOS5422_IDS_OFFSET		24
+ #define EXYNOS5422_IDS_MASK		0xff
+ #define EXYNOS5422_USESG_OFFSET	3
+ #define EXYNOS5422_USESG_MASK		0x01
+ #define EXYNOS5422_SG_OFFSET		0
+ #define EXYNOS5422_SG_MASK		0x07
+ #define EXYNOS5422_TABLE_OFFSET	8
+ #define EXYNOS5422_TABLE_MASK		0x03
+ #define EXYNOS5422_SG_A_OFFSET		17
+ #define EXYNOS5422_SG_A_MASK		0x0f
+ #define EXYNOS5422_SG_B_OFFSET		21
+ #define EXYNOS5422_SG_B_MASK		0x03
+ #define EXYNOS5422_SG_BSIGN_OFFSET	23
+ #define EXYNOS5422_SG_BSIGN_MASK	0x01
+ #define EXYNOS5422_BIN2_OFFSET		12
+ #define EXYNOS5422_BIN2_MASK		0x01
+
+#define EXYNOS_CHIPID_REG_LOT_ID	0x14
+
+#define EXYNOS_CHIPID_REG_AUX_INFO	0x1c
+/* Bit field definitions for EXYNOS_CHIPID_REG_AUX_INFO register */
+ #define EXYNOS5422_TMCB_OFFSET		0
+ #define EXYNOS5422_TMCB_MASK		0x7f
+ #define EXYNOS5422_ARM_UP_OFFSET	8
+ #define EXYNOS5422_ARM_UP_MASK		0x03
+ #define EXYNOS5422_ARM_DN_OFFSET	10
+ #define EXYNOS5422_ARM_DN_MASK		0x03
+ #define EXYNOS5422_KFC_UP_OFFSET	12
+ #define EXYNOS5422_KFC_UP_MASK		0x03
+ #define EXYNOS5422_KFC_DN_OFFSET	14
+ #define EXYNOS5422_KFC_DN_MASK		0x03
-- 
2.17.1

