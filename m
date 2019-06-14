Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEBD445977
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfFNJxd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:53:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35857 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfFNJx3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:53:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614095327euoutp010a37c82ed38ea50374a98d4537a892a0~oB-I7Xkvm0797907979euoutp01P
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:53:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614095327euoutp010a37c82ed38ea50374a98d4537a892a0~oB-I7Xkvm0797907979euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560506007;
        bh=joPvOI2ssb0uSnbficTKFzJtwPdkaUxITkJsrrdAdmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMHmwuiYZPbRlSZgUE81wrpq7u+5+bDWfU0cSuoumXiIelrBvAi2RVtAQn3wpAv9+
         TnXrncQ12kdPuAwbHoiCRQF/VYhftNYVmWh3YRecBsDALOl4NgmsgkAoKZB4LatGcf
         SrtFGyDJa/Na5StOg8EEniMu2XzbesjWMhXmd6Vk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614095326eucas1p29b72f496ff47d675671458135bf38d86~oB-H8VBQ-0493104931eucas1p23;
        Fri, 14 Jun 2019 09:53:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CA.A5.04298.69E630D5; Fri, 14
        Jun 2019 10:53:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f~oB-HIKuJT0495004950eucas1p2C;
        Fri, 14 Jun 2019 09:53:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614095325eusmtrp2515bb64739d0718d5f5711ceeaa76cd0~oB-G4ihY32148521485eusmtrp27;
        Fri, 14 Jun 2019 09:53:25 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-32-5d036e968e55
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.EA.04140.59E630D5; Fri, 14
        Jun 2019 10:53:25 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190614095324eusmtip24506edc9e4c115f51d759e87370fa816~oB-F8fyNe2261522615eusmtip2s;
        Fri, 14 Jun 2019 09:53:24 +0000 (GMT)
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
Subject: [PATCH v10 06/13] drivers: memory: extend of_memory by LPDDR3
 support
Date:   Fri, 14 Jun 2019 11:53:02 +0200
Message-Id: <20190614095309.24100-7-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614095309.24100-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSayyVYRzvee/UsbdDeSaynVVDJbY+PKnQqu1dl2WrPlRDb7xhOYfOm1Ra
        neiCiNEQDt1EUqcwuS1CKUdutdgRKrVUItcz1cjxUt9+1+f3//AwuPwDacMEqY4JahUfrKDM
        iZLnE02rU1S4t0tkph16lKYjUfvoFxJl1zWR6N5QL0BRt3QUSm7QYqjxshIl9H7HUXPzQxq9
        iuynkUFji4biukn0ujyTQiPxdQClNT/B0P26Lhq1NmxFnefyKFTbf4lEk28fEajqzTbU+dsC
        jb/4CDytufGxJIIb7LhAcxmaVoIrS++iucL8GIqr0hbQXHzUAMU9HajEuCvF+YAr0kdwI4VL
        vebvN9/gLwQHHRfUa9wPmge2Fz6hQrN2nPgVOYhpwE2PWGDGQHYtzOi5RcUCc0bO5gH4+dJ3
        WiKjALZUGEiJjAB4d6gbm6vkjFTikpEL4NfUfvJfRf9SO00YhmKdYWn+UVPBik0DMKNvtymD
        s49x+KPzHTAZlqwXjOxooUx5gl0OxxtdTLKM9YBTFYmkNGYP7z2sxk3YjPWEz7L7Z26FbAwD
        H2haKSm0BTbG5xAStoTf6otpCdvCqbLs2atFqIm/ASR8GvYmaGcz62FtfevMzTjrCHXlayR5
        Exx+1oCZZMhawI4fC00yPg2TSlJxSZbB6ItyKe0Ai+NaZocWw9yClNnHOZjyxTijy9lkAI3p
        zonAPv3/1nUA8oG1ECYqAwTRVSWEO4u8UgxTBTj7hSgLwfTH00/WD5eCsbZDNYBlgGKBrNoN
        85aT/HHxpLIGQAZXWMmy1uPecpk/f/KUoA7xVYcFC2INWMIQCmtZxLz3B+RsAH9MOCIIoYJ6
        zsUYMxsNKDhz9tN5Nz91ZtXdPsdVK7brIpqcjgSltuOHqz1qizzGhtdNaD37DJtfGK/XVls2
        LrNgYkeH9+Ts5ekpp2h2X3jN3nJ/ksDCjD63fef32C5KLv3zM9mw+fDO8KsI++bpPmFM5Q12
        ep+MydBdZhvvoClHvUPAoFeezrAyO6HtWoKCEAN5VydcLfJ/AQ4aYIh0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7pT85hjDRYsUrHYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y7i+aR9bwTyfil9N75kaGBfZdzFyckgImEgs/byHGcQWEljKKLGqByouJjFp33Z2CFtY4s+1
        LrYuRi6gmk+MEh+vLQJKcHCwCehJ7FhVCBIXEZjDKPGzaxsjiMMscJZZYveKN0wg3cICfhLP
        D30Ea2ARUJX4dsYAJMwrYC/xf/cEVogF8hKrNxwAO4JTwEHi6Pw3bCDlQkA132fwT2DkW8DI
        sIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwArcd+7llB2PXu+BDjAIcjEo8vAesmGKFWBPL
        iitzDzFKcDArifDOs2aOFeJNSaysSi3Kjy8qzUktPsRoCnTSRGYp0eR8YHLIK4k3NDU0t7A0
        NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXA2CeZFC1un/ZN9zmn203JiI49oQzW
        l2e4iqsk2DIpexy0OrU37b6a8feILvdeh53TLIM/VzW6fPFzLBG7MWVPw+EtyrcU1rLeiRHi
        0D0u5LZ6csIP1wNnjjh2TWCY5t262ZpNJEJi1xkDBW6xi2q5cq/ELZmyNa/9fh3poS6uI9TX
        uox1Zp0SS3FGoqEWc1FxIgC7tb2W1gIAAA==
X-CMS-MailID: 20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f
References: <20190614095309.24100-1-l.luba@partner.samsung.com>
        <CGME20190614095325eucas1p20083d9290b36eca945ec3f1428bdbd4f@eucas1p2.samsung.com>
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

