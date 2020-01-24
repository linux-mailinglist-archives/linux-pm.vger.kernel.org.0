Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2991486AA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbgAXOPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 09:15:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60366 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390280AbgAXOPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 09:15:09 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200124141508euoutp01ee2a8d8e5e480f1d709d4ed37086dd27~s2Dji7TnE1508015080euoutp01N
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 14:15:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200124141508euoutp01ee2a8d8e5e480f1d709d4ed37086dd27~s2Dji7TnE1508015080euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579875308;
        bh=Zj9SGg4W8FGzvWUQwtrRGP6fordYE7UZIdbAgofZujY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiDDUY6ZtZ3aAcaABU/t0Ow41dHF28uCWtO7txhAYmbALDmUCAklV77THGROGP9Ev
         l6RsbBXnqZGDGacIqgWktV40a9ODH4Q3SeTT1Eph+1CvZgHPDlHBNFmo9/NRDjrewk
         iqjBmkNKmDv9BCGmQkHW+PdLW1o6BeNgp4Rx9WSs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200124141507eucas1p231bc3e48f10952c8fa771f8a5374fe4d~s2DjW26tR1252412524eucas1p2v;
        Fri, 24 Jan 2020 14:15:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CB.0B.60679.BEBFA2E5; Fri, 24
        Jan 2020 14:15:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200124141507eucas1p115e87fdd6eda4a5f320d5145f5960889~s2Di-fSuP3110831108eucas1p1i;
        Fri, 24 Jan 2020 14:15:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200124141507eusmtrp1adb748a469d514b3f3ca96c976818340~s2Di_3ceG1786817868eusmtrp1k;
        Fri, 24 Jan 2020 14:15:07 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-b4-5e2afbeb85e1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C7.C2.07950.BEBFA2E5; Fri, 24
        Jan 2020 14:15:07 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200124141506eusmtip1f051cc28dd1857f2a39bff28b3fb3e93~s2DiUv6gu0071400714eusmtip1D;
        Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH RESEND 3/3] PM / devfreq: exynos-nocp: change load and total
 calculations
Date:   Fri, 24 Jan 2020 15:14:49 +0100
Message-Id: <20200124141449.19844-4-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124141449.19844-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7qvf2vFGZzrMrXYOGM9q8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLW43rmBz
        4PHYtKqTzWPzknqPvi2rGD0+b5ILYInisklJzcksSy3St0vgyrg+5TVLwS2lis5j/awNjMtl
        uhg5OSQETCTWflvP3MXIxSEksIJRYuKpJewQzhdGieuTGtkgnM+MErtv7GeEafm0ZjNUy3JG
        icVLTjPCtey5v5kdpIpNQF/i4NmTLCC2iIC0ROeiiUwgRcwCm5gl7r9+B5YQFoiWWL1tJ5jN
        IqAq8aNxITOIzStgI9F85y0TxDp5idmNp9lAbE4BW4lVZ1axQ9QISpyc+QSslxmopnnrbLCT
        JASWsUu8nHyTDaLZRWLp7UYWCFtY4tXxLewQtozE6ck9UPFyiacL+9ghmlsYJR60f4RKWEvc
        OfcLaBAH0AZNifW79CHCjhLHvrQwgoQlBPgkbrwVhLiBT2LStunMEGFeiY42IYhqVYnnp3qg
        XpGW6Pq/jhXC9pB4/OoX8wRGxVlIvpmF5JtZCHsXMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L
        10vOz93ECExKp/8d/7KDcdefpEOMAhyMSjy8M+5pxQmxJpYVV+YeYpTgYFYS4WUM04wT4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgbHz1OOG3Wt49+3+
        HfKxjvW/h5ZYzmvheYtvGa6vcjtV96cs7uLytd90Ou+k7Hood+Whn8exKa8/Sdg/ave3bDtp
        OqnhU5nfTtO9x/61W+UkpW0wW/RVJSBeZcqrpQXC6+eyy1h3aVz9JC2xgfVOsaiixpslK0xT
        r7/fuKNN4GP14derEqKWMhxUYinOSDTUYi4qTgQAVZdplEYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7qvf2vFGdz6Lm2xccZ6VovrX56z
        Wiz4NIPVov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMHm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl3F9ymuWgltKFZ3H+lkbGJfLdDFyckgImEh8WrOZGcQWEljK
        KNH5yQ4iLi3ReHo1E4QtLPHnWhcbRM0nRonvx0JBbDYBfYmDZ0+ygNgiQPWdiyYC1XNxMAvs
        YpZYMW022FBhgUiJd23vwGwWAVWJH40LwWxeARuJ5jtvoRbIS8xuPA22gFPAVmLVmVXsEMts
        JKZsXcUIUS8ocXLmE7BlzED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiI73ixNzi0rx0
        veT83E2MwMjZduznlh2MXe+CDzEKcDAq8fA63NGKE2JNLCuuzD3EKMHBrCTCyximGSfEm5JY
        WZValB9fVJqTWnyI0RToiYnMUqLJ+cCoziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKa
        nZpakFoE08fEwSnVwHjNZYZsh83sab3Xa5w+MSTYbTl6Z7pUXPqxTROYaoJdjyz5Oc/2S1qP
        w3vf/qrvC7evSV1WvWdJub7mqu9hEauubbl7N2JS0pldBWna16ZJyldpOJ49cLumUbpZkj9H
        OfbKmicBPbslLeSFJ7xk+W9U18Jjo9PgcfbbUpNv4QsOJjQcUf956LoSS3FGoqEWc1FxIgAB
        VReisgIAAA==
X-CMS-MailID: 20200124141507eucas1p115e87fdd6eda4a5f320d5145f5960889
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200124141507eucas1p115e87fdd6eda4a5f320d5145f5960889
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200124141507eucas1p115e87fdd6eda4a5f320d5145f5960889
References: <20200124141449.19844-1-k.konieczny@samsung.com>
        <CGME20200124141507eucas1p115e87fdd6eda4a5f320d5145f5960889@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are two problems with exynos-nocp driver. First one is reading
bytes and cycle counters and comparing them one to one without taking
into account wcore bus width. Second one is that cycle counter depends
on DREX DRAM clock, not on wcore clock. The latter problem was exposed
by commit 6e7674c3c6df5 ("memory: Add DMC driver for Exynos5422"),
which changes DRAM clock depending on memory read/write pressure and when
it gets at higher freqency, NoCP cycle counter also increases. Note that
both of these problems was there before this commit.
The proposed solution is to use byte counter from NoCP h/w registers
for current wcore bandwidth calculations and derive max bandwidth from
current frequency. While at it, change from bytes to kilobytes to avoid
overflow in later calculations in exynos-bus and devfreq drivers.
Also while at it, remove cycle counters setting and reading and extend
dev_dbg with time interval in miliseconds, percent of load, raw counter
value in hex.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/event/exynos-nocp.c | 61 ++++++++++++-----------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index ebe9cdf94f54..979ec094cf26 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/devfreq-event.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -60,19 +61,6 @@ static int exynos_nocp_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_2_SRC,
-				NOCP_CNT_SRC_INTEVENT_MASK,
-				NOCP_CNT_SRC_INTEVENT_CYCLE_MASK);
-	if (ret < 0)
-		goto out;
-
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_3_SRC,
-				NOCP_CNT_SRC_INTEVENT_MASK,
-				NOCP_CNT_SRC_INTEVENT_CHAIN_MASK);
-	if (ret < 0)
-		goto out;
-
-
 	/* Set an alarm with a max/min value of 0 to generate StatALARM */
 	ret = regmap_write(nocp->regmap, NOCP_STAT_ALARM_MIN, 0x0);
 	if (ret < 0)
@@ -95,18 +83,6 @@ static int exynos_nocp_set_event(struct devfreq_event_dev *edev)
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_2_ALARM_MODE,
-				NOCP_CNT_ALARM_MODE_MASK,
-				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
-	if (ret < 0)
-		goto out;
-
-	ret = regmap_update_bits(nocp->regmap, NOCP_COUNTERS_3_ALARM_MODE,
-				NOCP_CNT_ALARM_MODE_MASK,
-				NOCP_CNT_ALARM_MODE_MIN_MAX_MASK);
-	if (ret < 0)
-		goto out;
-
 	/* Enable the measurements by setting AlarmEn and StatEn */
 	ret = regmap_update_bits(nocp->regmap, NOCP_MAIN_CTL,
 			NOCP_MAIN_CTL_STATEN_MASK | NOCP_MAIN_CTL_ALARMEN_MASK,
@@ -145,6 +121,7 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
 {
 	struct exynos_nocp *nocp = devfreq_event_get_drvdata(edev);
 	unsigned int counter[4];
+	unsigned long dt;
 	int ret;
 
 	/* Read cycle count */
@@ -156,19 +133,29 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
 	if (ret < 0)
 		goto out;
 
-	ret = regmap_read(nocp->regmap, NOCP_COUNTERS_2_VAL, &counter[2]);
-	if (ret < 0)
-		goto out;
-
-	ret = regmap_read(nocp->regmap, NOCP_COUNTERS_3_VAL, &counter[3]);
-	if (ret < 0)
-		goto out;
-
 	edata->load_count = ((counter[1] << 16) | counter[0]);
-	edata->total_count = ((counter[3] << 16) | counter[2]);
-
-	dev_dbg(&edev->dev, "%s (event: %lu/%lu)\n", edev->desc->name,
-					edata->load_count, edata->total_count);
+	dt = jiffies_to_msecs((long)jiffies - (long)edata->prev_time);
+	if (dt == 0)
+		dt = 1;
+
+	/*
+	 * count load in kB/s
+	 * load = load / 1000 * 1000 / dt
+	 */
+	edata->load_count = edata->load_count / dt;
+
+	/*
+	 * count max bandwidth in kB/s:
+	 * bw = freq * ((bus width in bits / 8) / nr of mem channels) / 1000
+	 * where 128 bits / 8 bits per byte / 4 channels = 4
+	 * so it is: bw = freq * 4 / 1000
+	 */
+	edata->total_count = edata->curr_freq / 250;
+
+	dev_dbg(&edev->dev, "%s (event: %lu/%lu) %lums %lu%% 0x%08x\n",
+		edev->desc->name, edata->load_count, edata->total_count, dt,
+		edata->load_count * 100 / edata->total_count,
+		(counter[1] << 16) | counter[0]);
 
 	return 0;
 
-- 
2.25.0

