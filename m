Return-Path: <linux-pm+bounces-11420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0B93D17F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B14B21B65
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE19176227;
	Fri, 26 Jul 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kLb5vKli"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC37179972
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991707; cv=none; b=VFpXNZTYongJTHnMH4LD3xJxQvgadpK1xB5A+uXMTwap/NByAHaQE6UP9KRMu4tvJ6HjLDmpU+PsUmCGsIPmMU5GJ0xHUARNw6bO8vqATTEkoJ9uBB8Kx1OynC0p1jmTZRnVUEkHArKUCHMbMlvio+0qnHvVpdY0OpgD0pMAgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991707; c=relaxed/simple;
	bh=qt4VkpsxYDl8K92L731DXaj/rMQp+nelsICkpmYz/lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=pMTjyqc6iSzuahxHExJry5g6IPbsCCGh5JQ8dl4R/0MfBYFLNZtv14CadPEJT4bfcQk7uee1EBNbIOd3KoO5hEd/6/Uj3MhFu4CSlL3g2lxyKnC5BAVbqEbsPLXabTkt/8gv217g7oOcHu5PbnzXQU8yRLnXbq1NmZmJK8R2gbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kLb5vKli; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240726110139euoutp01d0787924d1dc3c032ed2f18a83bf8026~lvlO7jKbv0351503515euoutp01g
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240726110139euoutp01d0787924d1dc3c032ed2f18a83bf8026~lvlO7jKbv0351503515euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721991699;
	bh=pPk3cJw9Upb64u9gbv/wgoHU4phpR3fMcYIsKwH4ySA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLb5vKlierHg17rFQjMbD1hEvpX0GPesLrqRTJRYhv8pfBG4mOBwN0ZMmQ7nog3HC
	 mGu+lsA3uZOaK+kXdaCyVoOQzwzxjNqWZginifGLHfR/oxw5S246yxRwXjNfRleD53
	 PoyCXMh+V9UZVhRr7GXhw12e/2GeHu9g4njK7+hc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240726110138eucas1p16d34d9cacaf57c5bb4d9f06f3271ea49~lvlOharvv1888618886eucas1p1I;
	Fri, 26 Jul 2024 11:01:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.72.09620.21283A66; Fri, 26
	Jul 2024 12:01:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110138eucas1p27f33fb42af84ba7938703796c3f80727~lvlOAWaEE2810128101eucas1p2A;
	Fri, 26 Jul 2024 11:01:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240726110138eusmtrp23ea3e0d8abe81a2cfdd0a5fb0fec5998~lvlN-nDji1722517225eusmtrp2T;
	Fri, 26 Jul 2024 11:01:38 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-d4-66a38212571a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.27.08810.21283A66; Fri, 26
	Jul 2024 12:01:38 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110137eusmtip20d1f2f32995ec671fa09edbd2e7c3c49~lvlNED4v92391923919eusmtip2g;
	Fri, 26 Jul 2024 11:01:37 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, Anand
	Moon <linux.amoon@gmail.com>
Subject: [PATCH v2 3/6] drivers/thermal/exynos: improve sanitize_temp_error
Date: Fri, 26 Jul 2024 13:01:07 +0200
Message-ID: <20240726110114.1509733-4-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240726110114.1509733-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87pCTYvTDD7OM7R4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcXHpdNaCe1IV3xbuY2lg7BPrYuTkkBAw
	kWiadpaxi5GLQ0hgBaPExXXPWSGcL4wSHQ1PWECqhAQ+M0o0vnSF6Tj54DoLRNFyRonu3k5m
	CKeVSWLB+qOsIFVsAgYSD94sYwdJiAgsBur+8Q5sLrPAE2aJn68WA23k4BAW8JZoOaoJ0sAi
	oCrR1fGKEcTmFbCT2P75MxPEOnmJ3v19YDangL3EkkkfoWoEJU7OhDiPGaimeetssCskBCZz
	SpxfvY8dZL6EgIvE5PmMEHOEJV4d38IOYctI/N85H2p+vsSMze9ZIMorJO4e9IIwrSU+nmEG
	MZkFNCXW79KHKHaU+NT2Amo2n8SNt4IQ+/kkJm2bzgwR5pXoaBOCqFaVOL5nEjOELS3xpOU2
	1EoPiYZjU1kmMCrOQvLJLCSfzELYu4CReRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg
	ijv97/jXHYwrXn3UO8TIxMF4iFGCg1lJhHfZ/YVpQrwpiZVVqUX58UWlOanFhxilOViUxHlV
	U+RThQTSE0tSs1NTC1KLYLJMHJxSDUzFWsG8P2vPyFxf6iYwR2/zsd0Vl5MKqrjK1xzcNIn/
	iHtRxbFLFx6+CjO5uk2+0yvN5bCy2Z/rpVN2te6/mZ+1Lbgs4AKX0wXz8sLJ5/fvm3JB3+zq
	qc1xHFd8wmZNv3FDICNw48pNCzWfLs7fka5r6JBx5d7EHaLn95r7i1qkRRYIMbm5iSkzyDZN
	+Ja8KsT7Q/q0A7eOlVvWubAdP/32tpiz+JdrsReMfKNnmmlUJsn99b5bo3FO5f763/dOSe+q
	E3rowXY0bcbS6n+L9G4FHGX11g0XXM4qxDd1zexf9dbtD6fIN/96v0GqTGHbhEpGpYc78nus
	IqO+1M8TmBT8mKHDLcBYQLNJQDJN+bUSS3FGoqEWc1FxIgDJvvKY4AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7pCTYvTDKav5rN4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi3Ubb7FbLGxqYbeY
	eGwys8XcL1OZLf7v2cFu8eRhH5vF8759TA6CHmvmrWH02DnrLrvH4j0vmTw2repk87hzbQ+b
	x+Yl9R59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9n
	k5Kak1mWWqRvl6CXcXHpdNaCe1IV3xbuY2lg7BPrYuTkkBAwkTj54DpLFyMXh5DAUkaJ1Y3r
	GSES0hKHv0xhh7CFJf5c62KDKGpmkliy5DcrSIJNwEDiwZtlYEUiAssZJTa3e4DYzALvmCXa
	z/t1MXJwCAt4S7Qc1QQJswioSnR1vAKbzytgJ7H982cmiPnyEr37+8BsTgF7iSWTPoLVCAHV
	3O9dDVUvKHFy5hMWiPHyEs1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYkO94sTc4tK8dL3k
	/NxNjMCI3Hbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEd9n9hWlCvCmJlVWpRfnxRaU5qcWHGE2B
	7p7ILCWanA9MCXkl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUxz
	HNvbJ94U31wbIM2bmN96YXXSJwO5WP7JD183+VeGaOQ/K07+17xsr63Q0wUG13uf8UdeVmiY
	Gf7U7pqx07R3Zaun+EpLMVfb662vKZ11+Zthe69e+uvF0Wfv7rQs8b7rx1CvYTzZ+bac4v1f
	Wmrb4msOl7FbvlgxJym+76Wf+uakNTveZqgwND4WLi29NlEwZFde7rrFlpE+Cyw/u2Zmarh/
	6LBeVuovPVdn/Z/ipOfG1lflV59Kff2lb36LVU99d8iLQ0KfPv05vTKL/cRhy0Ud6bItk/50
	c7exCxUFeQmf2PXvuhxv5H3XLMt8FW+DN1mdB37+7vzBnvw3KuPT4sVpV38LLz2yc15mrxJL
	cUaioRZzUXEiAJ+QUVpRAwAA
X-CMS-MailID: 20240726110138eucas1p27f33fb42af84ba7938703796c3f80727
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110138eucas1p27f33fb42af84ba7938703796c3f80727
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240726110138eucas1p27f33fb42af84ba7938703796c3f80727
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
	<CGME20240726110138eucas1p27f33fb42af84ba7938703796c3f80727@eucas1p2.samsung.com>

There are two minor issues regarding this function.

One is that it attempts to calculate the second calibration value even
if 1-point trimming is being used; in this case, the calculated value is
probably not useful and is never used anyway. Changing this also
requires a minor reordering in Exynos5433 initialization function, so
that we know which type of trimming is used before we call
sanitize_temp_error.

The second issue is that the function is not very consistent when it
comes to the use of Exynos7-specific parameters. This seems to not be an
issue in practice, in part because some of these issues are related to
the mentioned calculation of the second calibration value. However,
fixing this makes the code a bit less confusing, and will be required
for Exynos850 which has 9-bit temperature values and uses 2-point
trimming.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: reworked to change shift instead of only mask and to also fix
  the 2-point trimming issue.

 drivers/thermal/samsung/exynos_tmu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index b68e9755c933..087a09628e23 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -111,6 +111,7 @@
 #define EXYNOS7_TMU_REG_EMUL_CON		0x160
 
 #define EXYNOS7_TMU_TEMP_MASK			0x1ff
+#define EXYNOS7_TMU_TEMP_SHIFT			9
 #define EXYNOS7_PD_DET_EN_SHIFT			23
 #define EXYNOS7_TMU_INTEN_RISE0_SHIFT		0
 #define EXYNOS7_EMUL_DATA_SHIFT			7
@@ -234,20 +235,23 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 	u16 tmu_temp_mask =
 		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
 						: EXYNOS_TMU_TEMP_MASK;
+	int tmu_85_shift =
+		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_SHIFT
+						: EXYNOS_TRIMINFO_85_SHIFT;
 
 	data->temp_error1 = trim_info & tmu_temp_mask;
-	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
-				EXYNOS_TMU_TEMP_MASK);
-
 	if (!data->temp_error1 ||
 	    (data->min_efuse_value > data->temp_error1) ||
 	    (data->temp_error1 > data->max_efuse_value))
-		data->temp_error1 = data->efuse_value & EXYNOS_TMU_TEMP_MASK;
+		data->temp_error1 = data->efuse_value & tmu_temp_mask;
 
-	if (!data->temp_error2)
-		data->temp_error2 =
-			(data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
-			EXYNOS_TMU_TEMP_MASK;
+	if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
+		data->temp_error2 = (trim_info >> tmu_85_shift) & tmu_temp_mask;
+		if (!data->temp_error2)
+			data->temp_error2 =
+				(data->efuse_value >> tmu_85_shift) &
+				tmu_temp_mask;
+	}
 }
 
 static int exynos_tmu_initialize(struct platform_device *pdev)
@@ -510,7 +514,6 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 	int sensor_id, cal_type;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
-	sanitize_temp_error(data, trim_info);
 
 	/* Read the temperature sensor id */
 	sensor_id = (trim_info & EXYNOS5433_TRIMINFO_SENSOR_ID_MASK)
@@ -532,6 +535,8 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 		break;
 	}
 
+	sanitize_temp_error(data, trim_info);
+
 	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
 			cal_type ?  2 : 1);
 }
-- 
2.45.1


