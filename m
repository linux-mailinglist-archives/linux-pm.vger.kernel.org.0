Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD64361D2
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 18:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfFEQyi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 12:54:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32938 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfFEQyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 12:54:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605165435euoutp0139694af6ed2722bf70347688288efb2d~lW7QfEzIW0154001540euoutp01B
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 16:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605165435euoutp0139694af6ed2722bf70347688288efb2d~lW7QfEzIW0154001540euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559753675;
        bh=gmycAUpUmoIHpnxXoB0mYWs9IH1J1o7+LpFnjTIyYZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjY0vFoy6PsnnVlhaVVxgaBOT9LgH4HpadmjNsXtjoE6/TPUltvbU8BQgBMppRYWx
         qmlUpmuhnSNGSgIHkzVTqo9p7PIgEWXVNiEsAhtN/Fy1p1uGbozQ+2k+b1LxTxPT73
         4begFngXmvyKhbQF++gHOorUCOPteZiAlRsPY9bk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605165434eucas1p2af8f2021e6f6883b8214ea6f414c28ab~lW7PnTO8Y0085900859eucas1p2a;
        Wed,  5 Jun 2019 16:54:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.A9.04298.9C3F7FC5; Wed,  5
        Jun 2019 17:54:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165432eucas1p170415ca2025df5b2cefdaa4ae7fb0f64~lW7OXzR-b0348103481eucas1p1V;
        Wed,  5 Jun 2019 16:54:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190605165432eusmtrp224452c40bcf08812811fdf124686d031~lW7OINEs42868028680eusmtrp2Q;
        Wed,  5 Jun 2019 16:54:32 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-0c-5cf7f3c9c254
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.4D.04140.8C3F7FC5; Wed,  5
        Jun 2019 17:54:32 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605165431eusmtip14551ce12b22f0e4152d055f6c4d1b8ef~lW7MveWvD0338903389eusmtip1M;
        Wed,  5 Jun 2019 16:54:31 +0000 (GMT)
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
Subject: [PATCH v8 06/13] drivers: memory: extend of_memory by LPDDR3
 support
Date:   Wed,  5 Jun 2019 18:54:03 +0200
Message-Id: <20190605165410.14606-7-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605165410.14606-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSUUhTYRTH/Xbv3a7DxfVqeVAzWgYVuLIkPqjMwuJSQT30kCnUrItKbtpu
        amYP08BSm4mmLcvUF5VZmU40TbLmcpalWSMli0IJwaZWMzULy+ud9PY7//M//3P4+GiCtVGB
        dJL+HG/Qa5PVciXZ0v2rL+y5ezZuS8/4NtxobqDw4PQYhSvtfRSu/z6KcMmLChl+WaDD10a/
        Eri//4ECv8pxKfB7YzB+235bjt0mO8Lm/scyfM/+UYGHs+vkuMt1mcKdzgN4+PcKPNMzgqL8
        uJmfxSR3yzhAcm3lHxVckyVPzpkuTcq5p5MdMq6w2YI4a28W524KOeJ9XLnzNJ+clM4bNkee
        VCZ+cVQSqRMHzze4qkgjmonMR940MBFgruxC+UhJs0wdAqezzFNMI/h2/5NMKtwIhvJK0PJI
        X/YIKTLL1CKwmzQSL05Y3+/MRzQtZzTw0HJWlP2ZLPgw2EmIOQTjksGr+TlS9Pgxh6Hn9n7R
        QzLrYX5wailexeyGhZoiubRqDdQ/eEKI7M1EQZnDSoo5wIwooHuylJJM0WAttZAS+8G4o1kh
        cTD8bauUSSyA0VTtuf8ijF6r8Hh2QJdjgBLvIZiN0NC+WZL3gLm1cOlMYFbA0ISvKBOLWNxy
        g5BkFVzJZSX3Bmi++tqzaBXU3i3zhHNw3VStkB6nBEF2Y3QRWlP+f1cVQhYUwKcJugReCNfz
        GRpBqxPS9AmaUym6JrT4s3oXHD8eop9v4m2IoZHaRwWNs3EspU0XMnU2BDSh9ldph6fjWNVp
        beYF3pBywpCWzAs2FEST6gBVltfnWJZJ0J7jz/B8Km9Y7spo70AjUvAxzklz09HZsdWPyv8E
        751/drh620jRUbVvYWiFqzdke436GGur2nInJNaffSP3mp4vLoiYnTrkZV8bP37MdjbX3hFz
        qO5tK2sbDH0SpE4N/f5uVYrmVrS/V0nehdh9+q2GlxmdN6NOhs3tKXRO+biHcnxKrd+ad/kG
        UKOaleui1KSQqA3fRBgE7T+sK3qCVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xu7onPn+PMZj9SN5i44z1rBbXvzxn
        tZh/5ByrxeqPjxktJp+ay2RxpjvXov/xa2aL8+c3sFucbXrDbnGrQcbi8q45bBafe48wWsw4
        v4/JYu2Ru+wWtxtXsFkcftPOarH/ipfF7d98Ft9OPGJ0EPb49nUSi8fshossHjtn3WX32LSq
        k82jt/kdm8fBd3uYPPq2rGL02Hy62uPzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jKfH5zMXvPWuWP9mAUsD4ze7LkZODgkBE4lzjY9Y
        uhi5OIQEljJKbD73nR0iISYxad92KFtY4s+1LjaIok+MEj2nP7F2MXJwsAnoSexYVQhSIyJQ
        L9H/5hJYDbNAA7PEmu1XWUESwgK+Ev1z37OB2CwCqhK/rr9nBLF5Bewl/i2bwAaxQF5i9YYD
        zCA2p4CDxLTjm1lAbCGgmkvXfzNPYORbwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCW
        th37uWUHY9e74EOMAhyMSjy8Ehu/xwixJpYVV+YeYpTgYFYS4U28/SVGiDclsbIqtSg/vqg0
        J7X4EKMp0FETmaVEk/OBcZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaP
        iYNTqoExLvQou6XYXDtTq8KiPV31HkUOtZmhjDt2GnxvT9W9tNd5y3fFfZztb05t1Z7W0TPv
        pqv6Za4Or5RzrReFt8iss0iMS34iMiXF7LVw6n+zfrsOI+lI42ynSfd2Jfn7yUuwToqdZPds
        b1trYiGz3TL/TPYr2ss/bzwt+2GCjeGLpcKMc9hOximxFGckGmoxFxUnAgDb58xouwIAAA==
X-CMS-MailID: 20190605165432eucas1p170415ca2025df5b2cefdaa4ae7fb0f64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605165432eucas1p170415ca2025df5b2cefdaa4ae7fb0f64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605165432eucas1p170415ca2025df5b2cefdaa4ae7fb0f64
References: <20190605165410.14606-1-l.luba@partner.samsung.com>
        <CGME20190605165432eucas1p170415ca2025df5b2cefdaa4ae7fb0f64@eucas1p1.samsung.com>
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

