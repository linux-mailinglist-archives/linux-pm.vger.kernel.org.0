Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A455BC92
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 15:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGANL4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 09:11:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57931 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfGANLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 09:11:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190701131154euoutp01ad0b515d005ebffa33fbf57eaa1f3aff~tSqQK-CSX2478224782euoutp01G
        for <linux-pm@vger.kernel.org>; Mon,  1 Jul 2019 13:11:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190701131154euoutp01ad0b515d005ebffa33fbf57eaa1f3aff~tSqQK-CSX2478224782euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561986714;
        bh=hQeFiWy8EHTRpvJ4ZW4yso2J7tvM0AvA1qKr3bJVWHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddEILP9n1pmox+p/3QdsgmhZGqBJFmXC+Id4+XOF9XoU4nYcKvDa/KVA7YMVb7mHT
         D8HPx1dSuyumWHswA30jGnXBsU/aN0cogsh2jU4xFmsVb7h2fKTM6XlayWlVBHpuDh
         WiegqWsg15A9SzaQTjhe0OapB/6O6lq/Mpw0LRjY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190701131153eucas1p20c3c6ced382e45b6df921ed1ee11c322~tSqPPLgVH0905409054eucas1p2e;
        Mon,  1 Jul 2019 13:11:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 13.30.04377.8960A1D5; Mon,  1
        Jul 2019 14:11:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190701131152eucas1p2c5ac5f1611fd07e3b7a4ad289abe3e81~tSqOa7Eek1069110691eucas1p2J;
        Mon,  1 Jul 2019 13:11:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190701131152eusmtrp2ec6b79dd345031188dc4377d283303c6~tSqOMysOu0782307823eusmtrp2b;
        Mon,  1 Jul 2019 13:11:52 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-bc-5d1a06983d30
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 90.EA.04140.7960A1D5; Mon,  1
        Jul 2019 14:11:52 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190701131151eusmtip157c773bb138002ea3157a809314f5000~tSqNTEVuD2804728047eusmtip1R;
        Mon,  1 Jul 2019 13:11:51 +0000 (GMT)
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
Subject: [PATCH v11 3/9] drivers: memory: extend of_memory by LPDDR3 support
Date:   Mon,  1 Jul 2019 15:11:32 +0200
Message-Id: <20190701131138.22666-4-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701131138.22666-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzu7D59zG5L9KQ9YBGUkGUYHCjMQuFmIpGSPVi18jarzdmuj8yE
        mZnls7SHaKJh5JyWtkw3k8wHWWqaFb61bERSpvgMUSrnnfXf9/se5/udw6ExiZlwoc+ERXCa
        MLlSStrila9m2zZnky6yrVm/tqMn2WUE6pr6RqD8xjYClYybAUooLCNRVnOeCLWmqFCG+QeG
        2tvLKfT28giFerWr0XjqIIE+VN8j0WRaI0DZ7S9E6FHjAIU6mn1RX7yORA0jSQT63fkER7Uf
        /VDfnAOaef0FeDuzM9OZODvWnUixudoOnDXlDFCsQX+dZGvzSik2LWGUZOtGa0RseoUesE9b
        YtlJw9r9dkdsd4ZwyjNRnGaL1wnb0FtdZiI8cd+Fz+UdpBbovZKBDQ0ZT1hdZKKSgS0tYXQA
        JiY/xoVhCsCetglMGCYBNKUaRUuRyqp0kSAUAagfnCX/RW5eubUw0DTJuEOj/rwl4MhkA5g7
        HGjxYEwVBn/29QOLsJLxh/qnA5QF48wGWNZZhFmwmNkFC559ooS2dbCk/OUib8N4w/fTA4tl
        kEmjYUnNPC6YfODttjprYCX83lRhxavhH1O+dW0eatPuAwFfguaMPKtnB2xo6iAsS2PMJlhW
        vUWgd8PhMcst6QXsALt/rrDQ2ALMrLyLCbQYXrsqEdwbYUXqO2uREywqvWM9nIWG5HwgPE8W
        gL13xogbYF3O/7ICAPTAmYvkVQqO3xbGRbvzchUfGaZwP6VWGcDC12v53TRlBNXzJ+sBQwOp
        vVjbD2USQh7Fx6jqAaQxqaO4VrdKJhGHyGMuchr1cU2kkuPrgSuNS53Fscs+H5UwCnkEd47j
        wjnNkiqibVy0QPZgzcR1xd7g5V41b2rclGb+yCVqqNjN9XXdiaFYXx043G+X+sjx6/MA9TAK
        cBdj/geOB0kiv6fI5g+tt+/1PRhca2xVlAbOqDxOj3a/aKBxZXTSlJoNkDzc40BinkHHhntm
        HeMKi5dl/VD72Y8nxSmKAxiDzifCKd5mLgY/K8X5ULmHG6bh5X8BkSkRq3YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7oz2KRiDd6eY7LYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNucatBxuJjzz1Wi8u7
        5rBZfO49wmgx4/w+Jou1R+6yW1w85Wpxu3EFm8XhN+2sFv+ubWSx2H/Fy+L2bz6LbyceMTqI
        e3z7OonF4/2NVnaP2Q0XWTx2zrrL7rFpVSebx/65a9g9epvfsXkcfLeHyaNvyypGj82nqz0+
        b5IL4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQ
        y5hy/TFrQat3xYMNF9kaGFfZdTFyckgImEhs297H1MXIxSEksJRR4uyUwywQCTGJSfu2s0PY
        whJ/rnWxQRR9YpT4ums5UBEHB5uAnsSOVYUgcRGBOYwSP7u2MYI4zAJnmSV2r3jDBNItLOAj
        sWrzXbBJLAKqEuuvLWcGsXkF7CUWbL0PtUFeYvWGA2BxTgEHiUtf77KB2EJANesW32CcwMi3
        gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmAcbjv2c8sOxq53wYcYBTgYlXh4NW5JxAqx
        JpYVV+YeYpTgYFYS4d2/QjJWiDclsbIqtSg/vqg0J7X4EKMp0FETmaVEk/OBKSKvJN7Q1NDc
        wtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjnMMULX6V4KrUnMB7DqtXv3ol
        ofv5vPN00cSPl5/3djcuCdirvvdB72PtwDn/S/MYN69Vso/QFJoX6CIXMStJjmNbxPNXfCvz
        Hy8WXiz4/8hdgQkfV0fnFPy3lfuZldncwdAuLvAkKlc4+uDCyMSm5mV/PP2Frtw0/d09rWEC
        Y9W0d/um5zYrsRRnJBpqMRcVJwIAU/C9H9kCAAA=
X-CMS-MailID: 20190701131152eucas1p2c5ac5f1611fd07e3b7a4ad289abe3e81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701131152eucas1p2c5ac5f1611fd07e3b7a4ad289abe3e81
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701131152eucas1p2c5ac5f1611fd07e3b7a4ad289abe3e81
References: <20190701131138.22666-1-l.luba@partner.samsung.com>
        <CGME20190701131152eucas1p2c5ac5f1611fd07e3b7a4ad289abe3e81@eucas1p2.samsung.com>
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
 drivers/memory/of_memory.c | 149 +++++++++++++++++++++++++++++++++++++
 drivers/memory/of_memory.h |  18 +++++
 include/memory/jedec_ddr.h |  61 +++++++++++++++
 3 files changed, 228 insertions(+)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 2f5ed7366eec..3227903edae4 100644
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
@@ -152,3 +153,151 @@ const struct lpddr2_timings *of_get_ddr_timings(struct device_node *np_ddr,
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
index ef2514f553d3..b532044830f4 100644
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
index ddad0f870e5d..675670a8c597 100644
--- a/include/memory/jedec_ddr.h
+++ b/include/memory/jedec_ddr.h
@@ -32,6 +32,7 @@
 #define DDR_TYPE_LPDDR2_S4	3
 #define DDR_TYPE_LPDDR2_S2	4
 #define DDR_TYPE_LPDDR2_NVM	5
+#define DDR_TYPE_LPDDR3		6
 
 /* DDR IO width */
 #define DDR_IO_WIDTH_4		1
@@ -172,4 +173,64 @@ extern const struct lpddr2_timings
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
 #endif /* __LINUX_JEDEC_DDR_H */
-- 
2.17.1

