Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0485B14FBA
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEFPN3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 11:13:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35554 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEFPMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 11:12:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190506151216euoutp014524328de593fb1d987fe89ba5cbf0f7~cILXjUTX61989919899euoutp01I
        for <linux-pm@vger.kernel.org>; Mon,  6 May 2019 15:12:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190506151216euoutp014524328de593fb1d987fe89ba5cbf0f7~cILXjUTX61989919899euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557155536;
        bh=86iqIqfIak+6kGfU9Jy/gt4WpLVnXi1qlgsvGp5pltU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmiVwZvGIej+lcoua1GL2TO1nDpoeM5vPGX9EClkg/4Jplp00OZxzYGpSpoM0LyJ6
         ZkqG2koVKMP3qJSn/5SMVJZK7q9+D8vTfL30Eg0UYvclxSmTr6ZgkOsdbQNCa2TzUA
         mF8mPNlSnvnlERRbGEyuifczx73s0jBVZj8b8VbM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190506151215eucas1p1dd8793a10fd8303226a760cd7dd225b4~cILWs71rp2011820118eucas1p1d;
        Mon,  6 May 2019 15:12:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 55.02.04298.FCE40DC5; Mon,  6
        May 2019 16:12:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190506151214eucas1p2e87194b1ce66f7184d6770818d02814d~cILV54_FD1041710417eucas1p24;
        Mon,  6 May 2019 15:12:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190506151214eusmtrp24389a4c3951bf803d602e0d00ada4744~cILVr3Isd0409004090eusmtrp2W;
        Mon,  6 May 2019 15:12:14 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-38-5cd04ecfe336
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.5D.04146.ECE40DC5; Mon,  6
        May 2019 16:12:14 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190506151213eusmtip1e8d433fc18b6b2aaab34e62835216866~cILU804710052300523eusmtip1g;
        Mon,  6 May 2019 15:12:13 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v7 06/13] drivers: memory: extend of_memory by LPDDR3
 support
Date:   Mon,  6 May 2019 17:11:54 +0200
Message-Id: <1557155521-30949-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHPbu723U0uW6SJwurQVhRmjLiQCGGEZeJJhQEKdjM2xTdtF1n
        mREr05ylCwsTzSzD11ZZc/kiFac403Lay172sjRyWfkYtjJz3kX/fX7fx+8Hh0Ngok7cj0hS
        pdNqlTxFwhNwG3t+2jbbogZjt9S+XYvulNTjaHhmHEcV3QM4Mv4YBehCXzkHPTirRPrRCQzZ
        bLf56OEpOx+91K5Cj1sv89B0QTdAJbZ2DrrZPcJHr07W8lCX/QyOOp7I0KtfXsjR+wGEiSnH
        bBGXKtMOcamW0hE+ZTLoeFRB9iSP6py8x6EKzQZANfRnUdMm/2jP/YLtCXRKUgatDgo9IEgc
        K23gpQ3Ljjb9ngJacDI0H3gSkJTCT1YHyAcCQkTWAnir7jnODjMA5kx0u4dpAF98z8H/VZy6
        Xj5r1ABo7JnHXMZSpapelA8IgkcGwmbDYZfsQ2bB18MdmCuPkXYOfOic47oMMbkbTuofLDGX
        XAfvOz9irq6QlEH7/Ar2lj98MaBbWu9JRsD5PAtg9Td8WNq1j+WdME/fxGFZDL9YzXyWV8GF
        lgq3zkBtwTV39zgc1Ze7M9tgl3UId53FyA2wvjXIhZDcAcuMMha94POv3q4wtohFjZcwVhbC
        vFwRu2M9NJ8bdN9ZDmtuFPPZCAUNlkj2ma4A+DM7m3cerC79f+oqAAbgS2sYpYJmglX0kUBG
        rmQ0KkXgwVSlCSx+rP4/1qlmMPso3gJIAkiWCT/vHIwV4fIMJlNpAZDAJD5C+dhArEiYIM88
        RqtT49SaFJqxgJUEV+IrzPJ4FyMiFfJ0Opmm02j1P5dDePppgWrcWyoICw2vDIkrLj4Ukzue
        G7EJ2/W+Tbq12XvCmuEQYw6pYmY6YC9HE/7mbvncN9/oDudIctQcskV35RSeDlwgh7Hr+rpw
        U9WaEyFtjX3Pcp2qkADF76cCc2p1e+bLxPgK8UXKuWtPS+svGzBWm0oiE7/r1soq+6Y8zP0e
        Ei6TKA/eiKkZ+V/sPm8jVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7rn/C7EGDydo22xccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrNZm9kKrntVbP/zibGBsdGui5GTQ0LAROJX5wn2
        LkYuDiGBpYwSl5/8YIVIiElM2redHcIWlvhzrYsNougTo8TO58eBijg42AT0JHasKgSpERGo
        l+h/cwmshlmggVlizfarYIOEBXwl+pa3sYHYLAKqEid/PWEG6eUV8JJ481cSYr6cxM1zncwg
        NqeAt8TfjkOMILYQUMm+j79ZJjDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYSduO
        /dy8g/HSxuBDjAIcjEo8vA9sL8QIsSaWFVfmHmKU4GBWEuFNfHYuRog3JbGyKrUoP76oNCe1
        +BCjKdBNE5mlRJPzgVGeVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mD
        U6qB0UejLeJDcebz3DCH7CNV03b8mJJZ2DV7/bzubRvrjh/yz1oVG/0g/nfXqtsBB2x/xztz
        aS1sm2OYKLrzSqiU9bb7tu4PxNbPfrb3ToxVzOKczyG7Jx2ZxKPKPl1Qdbv9w9Mqzy3O77d3
        K/Xs4eQ3s2Vdwse43/ulMXNCjfbObPX1KreKF+y7o8RSnJFoqMVcVJwIAG+8QNm6AgAA
X-CMS-MailID: 20190506151214eucas1p2e87194b1ce66f7184d6770818d02814d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151214eucas1p2e87194b1ce66f7184d6770818d02814d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151214eucas1p2e87194b1ce66f7184d6770818d02814d
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151214eucas1p2e87194b1ce66f7184d6770818d02814d@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch adds AC timings information needed to support LPDDR3 and memory
controllers. The structure is used in of_memory and currently in Exynos
5422 DMC. Add parsing data needed for LPDDR3 support.
It is currently used in Exynos5422 Dynamic Memory Controller.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/memory/of_memory.c | 148 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/memory/of_memory.h |  20 +++++-
 include/memory/jedec_ddr.h |  62 +++++++++++++++++++
 3 files changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 2f5ed73..19fbbcd 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -2,6 +2,7 @@
  * OpenFirmware helpers for memory drivers
  *
  * Copyright (C) 2012 Texas Instruments, Inc.
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -152,3 +153,150 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
 	return lpddr2_jedec_timings;
 }
 EXPORT_SYMBOL(of_get_ddr_timings);
+
+/**
+ * of_lpddr3_get_min_tck() - extract min timing values for lpddr3
+ * @np: pointer to ddr device tree node
+ * @device: device requesting for min timing values
+ *
+ * Populates the lpddr3_min_tck structure by extracting data
+ * from device tree node. Returns a pointer to the populated
+ * structure. If any error in populating the structure, returns NULL.
+ */
+const struct lpddr3_min_tck *of_lpddr3_get_min_tck(struct device_node *np,
+						   struct device *dev)
+{
+	int			ret = 0;
+	struct lpddr3_min_tck	*min;
+
+	min = devm_kzalloc(dev, sizeof(*min), GFP_KERNEL);
+	if (!min)
+		goto default_min_tck;
+
+	ret |= of_property_read_u32(np, "tRFC-min-tck", &min->tRFC);
+	ret |= of_property_read_u32(np, "tRRD-min-tck", &min->tRRD);
+	ret |= of_property_read_u32(np, "tRPab-min-tck", &min->tRPab);
+	ret |= of_property_read_u32(np, "tRPpb-min-tck", &min->tRPpb);
+	ret |= of_property_read_u32(np, "tRCD-min-tck", &min->tRCD);
+	ret |= of_property_read_u32(np, "tRC-min-tck", &min->tRC);
+	ret |= of_property_read_u32(np, "tRAS-min-tck", &min->tRAS);
+	ret |= of_property_read_u32(np, "tWTR-min-tck", &min->tWTR);
+	ret |= of_property_read_u32(np, "tWR-min-tck", &min->tWR);
+	ret |= of_property_read_u32(np, "tRTP-min-tck", &min->tRTP);
+	ret |= of_property_read_u32(np, "tW2W-C2C-min-tck", &min->tW2W_C2C);
+	ret |= of_property_read_u32(np, "tR2R-C2C-min-tck", &min->tR2R_C2C);
+	ret |= of_property_read_u32(np, "tWL-min-tck", &min->tWL);
+	ret |= of_property_read_u32(np, "tDQSCK-min-tck", &min->tDQSCK);
+	ret |= of_property_read_u32(np, "tRL-min-tck", &min->tRL);
+	ret |= of_property_read_u32(np, "tFAW-min-tck", &min->tFAW);
+	ret |= of_property_read_u32(np, "tXSR-min-tck", &min->tXSR);
+	ret |= of_property_read_u32(np, "tXP-min-tck", &min->tXP);
+	ret |= of_property_read_u32(np, "tCKE-min-tck", &min->tCKE);
+	ret |= of_property_read_u32(np, "tCKESR-min-tck", &min->tCKESR);
+	ret |= of_property_read_u32(np, "tMRD-min-tck", &min->tMRD);
+
+	if (ret) {
+		dev_warn(dev, "%s: errors while parsing min-tck values\n",
+			 __func__);
+		devm_kfree(dev, min);
+		goto default_min_tck;
+	}
+
+	return min;
+
+default_min_tck:
+	dev_warn(dev, "%s: using default min-tck values\n", __func__);
+	return NULL;
+}
+EXPORT_SYMBOL(of_lpddr3_get_min_tck);
+
+static int of_lpddr3_do_get_timings(struct device_node *np,
+				    struct lpddr3_timings *tim)
+{
+	int ret;
+
+	/* The 'reg' param required since DT has changed, used as 'max-freq' */
+	ret = of_property_read_u32(np, "reg", &tim->max_freq);
+	ret |= of_property_read_u32(np, "min-freq", &tim->min_freq);
+	ret |= of_property_read_u32(np, "tRFC", &tim->tRFC);
+	ret |= of_property_read_u32(np, "tRRD", &tim->tRRD);
+	ret |= of_property_read_u32(np, "tRPab", &tim->tRPab);
+	ret |= of_property_read_u32(np, "tRPpb", &tim->tRPpb);
+	ret |= of_property_read_u32(np, "tRCD", &tim->tRCD);
+	ret |= of_property_read_u32(np, "tRC", &tim->tRC);
+	ret |= of_property_read_u32(np, "tRAS", &tim->tRAS);
+	ret |= of_property_read_u32(np, "tWTR", &tim->tWTR);
+	ret |= of_property_read_u32(np, "tWR", &tim->tWR);
+	ret |= of_property_read_u32(np, "tRTP", &tim->tRTP);
+	ret |= of_property_read_u32(np, "tW2W-C2C", &tim->tW2W_C2C);
+	ret |= of_property_read_u32(np, "tR2R-C2C", &tim->tR2R_C2C);
+	ret |= of_property_read_u32(np, "tFAW", &tim->tFAW);
+	ret |= of_property_read_u32(np, "tXSR", &tim->tXSR);
+	ret |= of_property_read_u32(np, "tXP", &tim->tXP);
+	ret |= of_property_read_u32(np, "tCKE", &tim->tCKE);
+	ret |= of_property_read_u32(np, "tCKESR", &tim->tCKESR);
+	ret |= of_property_read_u32(np, "tMRD", &tim->tMRD);
+
+	return ret;
+}
+
+/**
+ * of_lpddr3_get_ddr_timings() - extracts the lpddr3 timings and updates no of
+ * frequencies available.
+ * @np_ddr: Pointer to ddr device tree node
+ * @dev: Device requesting for ddr timings
+ * @device_type: Type of ddr
+ * @nr_frequencies: No of frequencies available for ddr
+ * (updated by this function)
+ *
+ * Populates lpddr3_timings structure by extracting data from device
+ * tree node. Returns pointer to populated structure. If any error
+ * while populating, returns NULL.
+ */
+const struct lpddr3_timings *of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
+		struct device *dev, u32 device_type, u32 *nr_frequencies)
+{
+	struct lpddr3_timings	*timings = NULL;
+	u32			arr_sz = 0, i = 0;
+	struct device_node	*np_tim;
+	char			*tim_compat = NULL;
+
+	switch (device_type) {
+	case DDR_TYPE_LPDDR3:
+		tim_compat = "jedec,lpddr3-timings";
+		break;
+	default:
+		dev_warn(dev, "%s: un-supported memory type\n", __func__);
+	}
+
+	for_each_child_of_node(np_ddr, np_tim)
+		if (of_device_is_compatible(np_tim, tim_compat))
+			arr_sz++;
+
+	if (arr_sz)
+		timings = devm_kcalloc(dev, arr_sz, sizeof(*timings),
+				       GFP_KERNEL);
+
+	if (!timings)
+		goto default_timings;
+
+	for_each_child_of_node(np_ddr, np_tim) {
+		if (of_device_is_compatible(np_tim, tim_compat)) {
+			if (of_lpddr3_do_get_timings(np_tim, &timings[i])) {
+				devm_kfree(dev, timings);
+				goto default_timings;
+			}
+			i++;
+		}
+	}
+
+	*nr_frequencies = arr_sz;
+
+	return timings;
+
+default_timings:
+	dev_warn(dev, "%s: using default timings\n", __func__);
+	*nr_frequencies = 0;
+	return NULL;
+}
+EXPORT_SYMBOL(of_lpddr3_get_ddr_timings);
diff --git a/drivers/memory/of_memory.h b/drivers/memory/of_memory.h
index ef2514f..8cf2ce6 100644
--- a/drivers/memory/of_memory.h
+++ b/drivers/memory/of_memory.h
@@ -18,6 +18,11 @@ extern const struct lpddr2_min_tck *of_get_min_tck(struct device_node *np,
 extern const struct lpddr2_timings
 	*of_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
 	u32 device_type, u32 *nr_frequencies);
+extern const struct lpddr3_min_tck
+	*of_lpddr3_get_min_tck(struct device_node *np, struct device *dev);
+extern const struct lpddr3_timings
+	*of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
+	struct device *dev, u32 device_type, u32 *nr_frequencies);
 #else
 static inline const struct lpddr2_min_tck
 	*of_get_min_tck(struct device_node *np, struct device *dev)
@@ -31,6 +36,19 @@ static inline const struct lpddr2_timings
 {
 	return NULL;
 }
-#endif /* CONFIG_OF && CONFIG_DDR */
+
+static inline const struct lpddr3_min_tck
+	*of_lpddr3_get_min_tck(struct device_node *np, struct device *dev)
+{
+	return NULL;
+}
+
+static inline const struct lpddr3_timings
+	*of_lpddr3_get_ddr_timings(struct device_node *np_ddr,
+	struct device *dev, u32 device_type, u32 *nr_frequencies)
+{
+	return NULL;
+}
+#endif
 
 #endif /* __LINUX_MEMORY_OF_REG_ */
diff --git a/include/memory/jedec_ddr.h b/include/memory/jedec_ddr.h
index ddad0f8..3601825 100644
--- a/include/memory/jedec_ddr.h
+++ b/include/memory/jedec_ddr.h
@@ -32,6 +32,7 @@
 #define DDR_TYPE_LPDDR2_S4	3
 #define DDR_TYPE_LPDDR2_S2	4
 #define DDR_TYPE_LPDDR2_NVM	5
+#define DDR_TYPE_LPDDR3		6
 
 /* DDR IO width */
 #define DDR_IO_WIDTH_4		1
@@ -172,4 +173,65 @@ extern const struct lpddr2_timings
 	lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
 extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
 
+
+/*
+ * Structure for timings for LPDDR3 based on LPDDR2 plus additional fields.
+ * All parameters are in pico seconds(ps) unless explicitly indicated
+ * with a suffix like tRAS_max_ns below
+ */
+struct lpddr3_timings {
+	u32 max_freq;
+	u32 min_freq;
+	u32 tRFC;
+	u32 tRRD;
+	u32 tRPab;
+	u32 tRPpb;
+	u32 tRCD;
+	u32 tRC;
+	u32 tRAS;
+	u32 tWTR;
+	u32 tWR;
+	u32 tRTP;
+	u32 tW2W_C2C;
+	u32 tR2R_C2C;
+	u32 tWL;
+	u32 tDQSCK;
+	u32 tRL;
+	u32 tFAW;
+	u32 tXSR;
+	u32 tXP;
+	u32 tCKE;
+	u32 tCKESR;
+	u32 tMRD;
+};
+
+/*
+ * Min value for some parameters in terms of number of tCK cycles(nCK)
+ * Please set to zero parameters that are not valid for a given memory
+ * type
+ */
+struct lpddr3_min_tck {
+	u32 tRFC;
+	u32 tRRD;
+	u32 tRPab;
+	u32 tRPpb;
+	u32 tRCD;
+	u32 tRC;
+	u32 tRAS;
+	u32 tWTR;
+	u32 tWR;
+	u32 tRTP;
+	u32 tW2W_C2C;
+	u32 tR2R_C2C;
+	u32 tWL;
+	u32 tDQSCK;
+	u32 tRL;
+	u32 tFAW;
+	u32 tXSR;
+	u32 tXP;
+	u32 tCKE;
+	u32 tCKESR;
+	u32 tMRD;
+};
+
 #endif /* __LINUX_JEDEC_DDR_H */
-- 
2.7.4

