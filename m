Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D19E38D3E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfFGOgU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 10:36:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40486 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfFGOfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 10:35:33 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607143531euoutp028c63938334cc393d25fad050fc1e66a1~l8UaEaVtq0257302573euoutp02M
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 14:35:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607143531euoutp028c63938334cc393d25fad050fc1e66a1~l8UaEaVtq0257302573euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559918131;
        bh=joPvOI2ssb0uSnbficTKFzJtwPdkaUxITkJsrrdAdmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMbXgwJUaL4GNbh2P0JEGT9kaBs/9dVNCT9HNj/l3Llm/sk2pwto/rzCPr5zu1pUu
         eQr5XTE4ihAQZgKqypBMAgfte32mIxsUfsKwHvhsCOmxvg9DkJKW4LQfeXENo0pXxU
         C09J9/yFCA2fdVLGeCMmKG4sdq1TYzCr+70PCCZY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607143530eucas1p1f10b816e5c87eda9a501e2467282e4bf~l8UZSwSC91839218392eucas1p1O;
        Fri,  7 Jun 2019 14:35:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B9.D0.04325.1367AFC5; Fri,  7
        Jun 2019 15:35:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607143529eucas1p2ed19649f0a5404a9a2a3b45cb07d0103~l8UYggfJo2700327003eucas1p2X;
        Fri,  7 Jun 2019 14:35:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190607143529eusmtrp2a5ad21d8e3edf1f5c1d513631ebe5b80~l8UYQ3RgY1494514945eusmtrp29;
        Fri,  7 Jun 2019 14:35:29 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-97-5cfa7631c057
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.56.04146.1367AFC5; Fri,  7
        Jun 2019 15:35:29 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190607143528eusmtip1b96ce22a9772f2d21fbde1f843f85d7c~l8UXYv2Cy2756327563eusmtip1j;
        Fri,  7 Jun 2019 14:35:28 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v9 06/13] drivers: memory: extend of_memory by LPDDR3
 support
Date:   Fri,  7 Jun 2019 16:35:00 +0200
Message-Id: <20190607143507.30286-7-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607143507.30286-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0yNcRj2O9+1OO1zin5o5JhNNoWYn2tl2r6RYWw2zpZDXxd1Ds6nXGIO
        jdBFimodJ7dRO91P7XRZ635B9yFRHZyIVC6LpuLQ13fMf8/7vM/zvO/evTQme03MpUPUxzmN
        WhkmJ+1xU8NY67KVEeOK5f0sKkjNI9CL7x8IdLuulUBZ3/oAirqfR6KkJ3oJao5RoWt9gxhq
        a8unUMuFIQq90rqgb7FmAj0tu0Wikbg6gFLbKiQop66XQh1PfFH3+UwS1Q5FE8jaWYCjymdb
        UfeEAxp9ZAHezuzoj0Sc/dJ1kWJ12g6cLU3rpVij4QrJVuqzKTYu6jPJVn8ul7DxRQbAFjZF
        siPG+Tun77PfEMCFhURwGo9NB+yDXxgryKPpfifHL3yRaME9r6vAjobMKtjbHwuuAntaxmQC
        2J98HROL7wDeKS2yFSMA1heaJwt6yvLSqhb5DAAragwSIWrK8V6/VNCQjDssMRwTaCcmFUDd
        x92CHmOKMTjc3QOEhiOzA/62jk95cWYxfJxjIQQsZbxgQ0I5Ja63AGblV2ECtmO8oc5UQgpB
        kImj4dhwCi4utAWmVPuIekf4qbHI5nWBf0pvS0TMQ23cXSDiM7Dvmt6mWQ9rGzsIIQZj3GBe
        mYdI+8Cu96OEmO4Au4ZnCjQ2CRNNKbYrSOHlSzJRvQQWxbbbBs2GGdnJtnAWRhXkEuKlkiYv
        qH9LJYAFaf+H3QHAAJy5cF4VxPGeau6EO69U8eHqIPdDR1RGMPl2TdbGHyWg4tfBGsDQQD5D
        ylJjChmhjOBPqWoApDG5kzSi/adCJg1QnjrNaY74a8LDOL4GzKNxubM0ctqb/TImSHmcC+W4
        o5zmX1dC283Vgr09Wsufpjn+noer1nQmRMaYffb4hQLX17h3zvZtmvK08F2BrYfbU9besH49
        kL5o9blRl90DE5ewic0WU88asLHF2Gk0l4Vebh6Y9ZDrMcU/g8Vu9QtDlIHvhs6Wam5mRunk
        9xUtg/4P6j2e638NRSdwrifNSbkoOd03tHidxS1JjvPByhVLMQ2v/AtaD4+ycgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7qGZb9iDCau47TYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y7i+aR9bwTyfil9N75kaGBfZdzFycEgImEjc/JfXxcjFISSwlFFi6+5XrF2MnEBxMYlJ+7az
        Q9jCEn+udbFBFH1ilJj/qZ0RpJlNQE9ix6pCkLiIwBxGiZ9d2xhBHGaBs8wSu1e8YQLpFhbw
        lXj6Zg/YJBYBVYmTax+BbeAVsJc4NmEP1AZ5idUbDjCD2JwCDhKzt+1gA1kgBFSz6rnDBEa+
        BYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJjcNuxn5t3MF7aGHyIUYCDUYmH14HhZ4wQ
        a2JZcWXuIUYJDmYlEd6yCz9ihHhTEiurUovy44tKc1KLDzGaAt00kVlKNDkfmB7ySuINTQ3N
        LSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwql++XWQeIRee/3+Tned6TuaU
        JG6GxNakOP79EqeW7fjPuP/tzvCTNfM7OoKv31vQddq3wpBtVqPddfZpzyVfVUzYNylxfhlD
        6uxToSuyvznWix3Icrnb83rLAZOW5tm7nrUxqea9Cf2bHLw4arZd+dSXxYl/24WlfblXVyfM
        Oyx0wbbArea+EktxRqKhFnNRcSIAWgTN2dcCAAA=
X-CMS-MailID: 20190607143529eucas1p2ed19649f0a5404a9a2a3b45cb07d0103
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143529eucas1p2ed19649f0a5404a9a2a3b45cb07d0103
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143529eucas1p2ed19649f0a5404a9a2a3b45cb07d0103
References: <20190607143507.30286-1-l.luba@partner.samsung.com>
        <CGME20190607143529eucas1p2ed19649f0a5404a9a2a3b45cb07d0103@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch adds AC timings information needed to support LPDDR3 and memory
controllers. The structure is used in of_memory and currently in Exynos
5422 DMC. Add parsing data needed for LPDDR3 support.
It is currently used in Exynos5422 Dynamic Memory Controller.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
 drivers/memory/of_memory.h |  18 +++++
 include/memory/jedec_ddr.h |  62 +++++++++++++++
 3 files changed, 234 insertions(+)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 12a61f558644..30f3a3e75063 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -3,6 +3,12 @@
  * OpenFirmware helpers for memory drivers
  *
  * Copyright (C) 2012 Texas Instruments, Inc.
+ * Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  */
 
 #include <linux/device.h>
@@ -148,3 +154,151 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
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
+const struct lpddr3_timings
+*of_lpddr3_get_ddr_timings(struct device_node *np_ddr, struct device *dev,
+			   u32 device_type, u32 *nr_frequencies)
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
index b077cc836b0b..e39ecc4c733d 100644
--- a/drivers/memory/of_memory.h
+++ b/drivers/memory/of_memory.h
@@ -14,6 +14,11 @@ extern const struct lpddr2_min_tck *of_get_min_tck(struct device_node *np,
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
@@ -27,6 +32,19 @@ static inline const struct lpddr2_timings
 {
 	return NULL;
 }
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
 #endif /* CONFIG_OF && CONFIG_DDR */
 
 #endif /* __LINUX_MEMORY_OF_REG_ */
diff --git a/include/memory/jedec_ddr.h b/include/memory/jedec_ddr.h
index ddad0f870e5d..3601825f807d 100644
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
2.17.1

