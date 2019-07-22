Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDF6FCB4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfGVJrb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 05:47:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42181 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbfGVJrb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:47:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190722094728euoutp025eb7ada998b110e5a275d4db22a83535~zsaw8mMYd2848028480euoutp024
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 09:47:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190722094728euoutp025eb7ada998b110e5a275d4db22a83535~zsaw8mMYd2848028480euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563788848;
        bh=NOteMYCa1WF+4GdXMIe35a4uj6W81Ldk1G4gl67OZ9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1oBZ54w6Xavml7CQFB8b8kGMWwxSzq9dNeemvxvGp9bnLujwc5Mg6BCcezEz4JLz
         BKkqsX92BDftuHT1M+BGTDcNhLdPcO/JHxRCzJx/lRyvj3F2y7aKvygK+5hLNhkosi
         nIHBnZMU2/Rbs2KyFl98kjCfeE3l53i5bPP0Flzk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190722094728eucas1p2274baec0ebd56580525e9035e4c58712~zsawKuTsc2318823188eucas1p2T;
        Mon, 22 Jul 2019 09:47:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 21.26.04377.F26853D5; Mon, 22
        Jul 2019 10:47:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722094727eucas1p10041ba25819e6e62d639423a97435f2d~zsavO4k5o1120311203eucas1p1N;
        Mon, 22 Jul 2019 09:47:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722094726eusmtrp1761971ebbbf3b626bd649c5404583f83~zsavAmZHs3266032660eusmtrp1u;
        Mon, 22 Jul 2019 09:47:26 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-f7-5d35862f9d1c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 65.2A.04140.E26853D5; Mon, 22
        Jul 2019 10:47:26 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190722094725eusmtip23ec009a66ffd71fbd99b2d96f78cc687~zsauCkttk1003910039eusmtip2S;
        Mon, 22 Jul 2019 09:47:25 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v12 3/9] drivers: memory: extend of_memory by LPDDR3 support
Date:   Mon, 22 Jul 2019 11:46:40 +0200
Message-Id: <20190722094646.13342-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722094646.13342-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTcRTH/e3eu3tdTW7T6miStCh6+oikH/TQqPASQtGDoJJadTHJLdtV
        y5RYhZrmozYq0SztQb7Csim5zFJHE1ezZak9tGzQ+4lWSrLa7U7673O+53u+5/DjxxCqr1QQ
        k6BL5vU6TaJariAb7o045odlRcaFV+ZG4OtFtRTuGXpL4fNWB4Wrv7sQPnqxVo5NHaUyfP+4
        Fhe6PhK4s/MajR8c+UTjZ4Zg/D2vn8JdlrNyPJhvRbios1mGr1r7aHy5xynDzo5V+PnhCjnO
        vG2lcdunbAq7u6+T+M7j1fj5bz/8s/01ig7kas7VIO7nDyPJfe3NpLkSg5PkGov7aK6uKkfO
        3Smtobn8o1/kXMuXJhlXYK5C3A17OjdYN3Xt+M2KJbv4xIRUXh+2bLtid/9IA5V0KvbAqOmu
        3IBKonKRLwPsQvhVaaFFVrEVCCpGOImHEBypD8tFCg8PIvjVMkyNDRibHJTUuILA/ecMIRWe
        iaantz0Fw8jZULhZtU8cCGCLEJS8Wy96CHaAgIKrZ5HY8Gdj4Vuv499qkp0BrS97SJGVbBQM
        vy2USdtCoPra3X+Zvmw0vLdpxRxgyxm4XPCDkDwrwWauJyX2hw82My1xMNhNeV5dAEN+OZI4
        A1yFpV7PYmizOSkxn2BnQ60lTJKXg7viERJlYP2g9/MEUSY8aGw4Q0iyEo5lqST3LDDnPfQe
        PAmu1Jz2hnNQ/+ap93VMCFyXhtEJFFL8f1kZQlVoMp8iaON5YYGO3x8qaLRCii4+dOdebR3y
        fEO72zZ0E1lGd7QilkHq8crwhoVxKkqTKqRpWxEwhDpAqQuPjFMpd2nSDvL6vdv0KYm80Iqm
        MKR6sjLd59UWFRuvSeb38HwSrx/ryhjfIAMaFzmQ0NidUGbJGFfus2FeO+MsBvsafdPcLks0
        c35RQHhzXGC2zTfbVFk9rcC+dnhin3Hqhcb09imqF+bEYkVz4IqOQ5tmRgQ0f1xzy7Xi8Ea3
        cTo+NS+nzOF3MvLgix7/jNq0h9nv1+Us3bM1aL/V1PJb9+xJfldMTH/J+uS2R5sy1aSwWxMx
        h9ALmr9VdWqLggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7p6baaxBuvXG1hsnLGe1eL6l+es
        FvOPnGO1WP3xMaNF8+L1bBaTT81lsjjTnWvR//g1s8X58xvYLc42vWG3uNUgY/Gx5x6rxeVd
        c9gsPvceYbSYcX4fk8XaI3fZLZZev8hkcfGUq8XtxhVsFq17j7BbHH7Tzmrx79pGFov9V7ws
        bv/ms/h24hGjg6THmnlrGD2+fZ3E4vH+Riu7x+yGiyweO2fdZffYtKqTzWP/3DXsHr3N79g8
        Dr7bw+TRt2UVo8fm09UenzfJBfBE6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZ
        mSrp29mkpOZklqUW6dsl6GXc+7mNtWCqT8WfyQfYGhhn23cxcnJICJhITNpzjrWLkYtDSGAp
        o8ThD1/YIBJiEpP2bWeHsIUl/lzrYoMo+sQo0XzpG2MXIwcHm4CexI5VhSBxEYE5jBI/u7Yx
        gjjMAr+ZJQ7e7QfrFhbwkfhw4xyYzSKgKnHo/nUWEJtXwF7ix/N+JogN8hKrNxxgBhnKKeAg
        8fJ4LkhYCKhk/4vtjBMY+RYwMqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNFtx35u2cHY
        9S74EKMAB6MSD++NzSaxQqyJZcWVuYcYJTiYlUR48wxMY4V4UxIrq1KL8uOLSnNSiw8xmgLd
        NJFZSjQ5H5g+8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MJ53
        Ltt+aIUb94YnqtLhuzZ5u2kcNgnK461eJJv38J72VLad51T28iR2ql24IPvspKtA6wuZXWwH
        c2QluFSELGaGF/5SqTOXed1ztu+0r7fJlQtLthi4qrrqnPURX6q0flpxhvi8FiUj8w3sV3+K
        /9mTFdB/Pagm+Mjb6QVrjG5rvVvmwsNZr8RSnJFoqMVcVJwIAHUMAOrnAgAA
X-CMS-MailID: 20190722094727eucas1p10041ba25819e6e62d639423a97435f2d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094727eucas1p10041ba25819e6e62d639423a97435f2d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094727eucas1p10041ba25819e6e62d639423a97435f2d
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094727eucas1p10041ba25819e6e62d639423a97435f2d@eucas1p1.samsung.com>
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
 drivers/memory/jedec_ddr.h |  61 +++++++++++++++
 drivers/memory/of_memory.c | 154 +++++++++++++++++++++++++++++++++++++
 drivers/memory/of_memory.h |  18 +++++
 3 files changed, 233 insertions(+)

diff --git a/drivers/memory/jedec_ddr.h b/drivers/memory/jedec_ddr.h
index 4a21b5044ff8..38e26d461bdb 100644
--- a/drivers/memory/jedec_ddr.h
+++ b/drivers/memory/jedec_ddr.h
@@ -29,6 +29,7 @@
 #define DDR_TYPE_LPDDR2_S4	3
 #define DDR_TYPE_LPDDR2_S2	4
 #define DDR_TYPE_LPDDR2_NVM	5
+#define DDR_TYPE_LPDDR3		6
 
 /* DDR IO width */
 #define DDR_IO_WIDTH_4		1
@@ -169,4 +170,64 @@ extern const struct lpddr2_timings
 	lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
 extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
 
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
 #endif /* __JEDEC_DDR_H */
diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 46539b27a3fb..4f5b8c81669f 100644
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
@@ -149,3 +155,151 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
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
-- 
2.17.1

