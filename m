Return-Path: <linux-pm+bounces-11423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70093D186
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C7C1C20EA3
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22E17B410;
	Fri, 26 Jul 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="slQv8NWL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB417A595
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991709; cv=none; b=dClYWCIJ9qSFYAOkdjxAtdTkArp8qkFBf3dwHdGRtQFmZnVHRtOsH7dKsq5DKA8Qhv8QiV04Dv8pF+X/xMw8dnA0XMpCUNDQ9SQ5quCnqC+vFaJ3XTP1VO1t6OZzF8kiuHMTtXLpamT/gIUrjEVqwwteYH1bqt/xD2AJkpwrqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991709; c=relaxed/simple;
	bh=zQ2+gDeiPf9CiNsgXp+CCGUYLTxnIQxkzR6m3P+aU7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=D52WzCzm5KjmPEhOn42tcWCypnCNFu24hGz1X+5ja+4i7n6rAqIC6BVZyC9SG/RzSkYFboPlHypoOfZYak3wxWJ8rBSgTm0qNFmk7bMXKWLPZBp5Bh0gtDyZsptbhMEdeHQ+d1pRtf7fzuujQkJTxAa0lkgNiRO4bk0nbv4qz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=slQv8NWL; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240726110142euoutp02dcbc24b12539fe765330a22476315729~lvlRgjPZG0058000580euoutp02v
	for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2024 11:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240726110142euoutp02dcbc24b12539fe765330a22476315729~lvlRgjPZG0058000580euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721991702;
	bh=PR+//AUGtX3oXehWtz9OmipJug99cq/9RVo6GE3O8Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slQv8NWLclUV5ZMXCv7wAYJSpBjnNHQYpvyWd1tQ0y11RMss5erdW7KWxRrRNjcN2
	 ut49hPZjckWy1r9etuHRryefDfwioOqjnjKKZ8Zb4YsI8Lucc0zDW49mDXUSZgJ4ZQ
	 XcJlvRaYvAbUAA2MXSNAQ6gC9+pg6+vf6wWQG9PI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240726110141eucas1p12bfb72a228f99dc5f2b9fe0f7ff5d23c~lvlRJ51_80293902939eucas1p1t;
	Fri, 26 Jul 2024 11:01:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4E.FB.09624.51283A66; Fri, 26
	Jul 2024 12:01:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110141eucas1p279c474e8737dcf4752808a20219e12d4~lvlQi2lWv1980819808eucas1p2d;
	Fri, 26 Jul 2024 11:01:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240726110141eusmtrp2dc4214e02e5ba516a9f5adf1c1865b48~lvlQhYUXn1722117221eusmtrp2j;
	Fri, 26 Jul 2024 11:01:41 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-fd-66a38215aaf7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.27.08810.41283A66; Fri, 26
	Jul 2024 12:01:40 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240726110140eusmtip219dc7f492cf628101bbceb121ce52512~lvlPooRcz2391923919eusmtip2h;
	Fri, 26 Jul 2024 11:01:40 +0000 (GMT)
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
Subject: [PATCH v2 5/6] drivers/thermal/exynos: add initial Exynos850
 support
Date: Fri, 26 Jul 2024 13:01:09 +0200
Message-ID: <20240726110114.1509733-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240726110114.1509733-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7qiTYvTDNqeyVk8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLul6nMFv/37GC3ePKwj83ied8+JgdBjzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofN
	Y/OSeo++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKuL33PUvB84SKr6f72RsYtwR2MXJySAiY
	SDw4/Z+li5GLQ0hgBaPEvpOfGCGcL4wSp5/eZ4VwPjNKzP4wgRWm5cb3v1CJ5YwSc3b1sUM4
	rUwS7V9fMoFUsQkYSDx4swwsISKwmFGi8cc7sBZmgSfMEj9fLWYEqRIW8Jc4tnwrcxcjBweL
	gKrE12+iIGFeATuJn6t2MkGsk5fo3d8HZnMK2EssmfSREaJGUOLkzCcsIDYzUE3z1tnMIPMl
	BKZzSizYd5UZotlFYnn3JHYIW1ji1fEtULaMxP+d86EW5EvM2PyeBeQGCYEKibsHvSBMa4mP
	Z8AuYxbQlFi/Sx+i2FFi2qmvTBAVfBI33gpCHMAnMWnbdGaIMK9ER5sQRLWqxPE9k6BOkZZ4
	0nIbaqWHxKwjK1gmMCrOQvLKLCSvzELYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7u
	JkZgmjv97/inHYxzX33UO8TIxMF4iFGCg1lJhHfZ/YVpQrwpiZVVqUX58UWlOanFhxilOViU
	xHlVU+RThQTSE0tSs1NTC1KLYLJMHJxSDUwiuUzxh9NOOZx7wf7neI2dUaPlWotjJ2adiG0S
	L/hRF3TtnP284EUM5ZUH7x4xWyrQf/rzuZbeoBm/JBYYbfzGlred2/AudzrbyQ1hyV9KzzEk
	/CmR2vjpGMckLR3tOkW+2JaK3IcV8xg3x29smfn9et0PxreznjanvX1Ypl9yP9jqfJOHkviH
	+DM3T+0TWG6/5/vHk9GmLHse3fKemh3So9a7K+tNxXY3GWuBh5XhIQc+/e0SjbykWh60R/h4
	RvDns8ucpm8VzsvUdt75wUhzflsuw5pXTSyW008eb3dcNbm3SHIBf+LTq4vYG7l+NDoe+pPM
	+/mJv9pj7WPZCeHa86TtndYGTsvUKhBYW6TEUpyRaKjFXFScCADaDljd4gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7oiTYvTDD422Fo8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLul6nMFv/37GC3ePKwj83ied8+JgdBjzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofN
	Y/OSeo++LasYPT5vkgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
	SUnNySxLLdK3S9DLuL33PUvB84SKr6f72RsYtwR2MXJySAiYSNz4/pe1i5GLQ0hgKaPE8dsn
	2SES0hKHv0yBsoUl/lzrYoMoamaSuNt6mwUkwSZgIPHgzTKwIhGB5YwSm9s9QGxmgXfMEu3n
	/UBsYQFfiSUv9zN1MXJwsAioSnz9JgoS5hWwk/i5aicTxHx5id79fWA2p4C9xJJJHxlBbCGg
	mvu9qxkh6gUlTs58wgIxXl6ieets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeu
	l5yfu4kRGJHbjv3cvINx3quPeocYmTgYDzFKcDArifAuu78wTYg3JbGyKrUoP76oNCe1+BCj
	KdDZE5mlRJPzgSkhryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
	Kf92Vvflqsf9bc0eu2pq9Ob8drqa+CJTcm2x1EypjVc2a7E8DU+rYXYSXSk7XdxvdlLRI+m7
	rXu4LimpL/906dphDsE4j6kbFy35vjZeX8VpqnLiTLPidadSGmLMT0XsTi/PZyxgEZDyC23N
	6vzAmbB668SH057x2IT11JyflPhnFUN0wuF6ruySJRER8078MC3/lG7TErzFWTvG9srdxkkr
	QirvcVa8CT3y4eED83O3UufE9HzeLmnjkZXPf66gyshLcPfPmDKhd+sXXno+j4vDJ9L4a33X
	BKalO89vsl+yx1/j7eu8aaxnb7u9OizTs+xCQcir/lNRRatlDpqpchu/imfsfd+6gyPKwU1W
	iaU4I9FQi7moOBEAPPB4LVEDAAA=
X-CMS-MailID: 20240726110141eucas1p279c474e8737dcf4752808a20219e12d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240726110141eucas1p279c474e8737dcf4752808a20219e12d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240726110141eucas1p279c474e8737dcf4752808a20219e12d4
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
	<CGME20240726110141eucas1p279c474e8737dcf4752808a20219e12d4@eucas1p2.samsung.com>

This is loosely adapted from an implementation available at
https://gitlab.com/Linaro/96boards/e850-96/kernel/-/blob/android-exynos-4.14-linaro/drivers/thermal/samsung/exynos_tmu.c
Some differences from that implementation:
- unlike that implementation, we do not use the ACPM mechanism, instead
  we just access the registers, like we do for other SoCs,
- the SoC is supposed to support multiple sensors inside one unit. The
  vendor implementation uses one kernel device per sensor, we would
  probably prefer to have one device for all sensors, have
  #thermal-sensor-cells = <1> and so on. We implemented this, but we
  could not get the extra sensors to work on our hardware so far. This
  might be due to a misconfiguration and we will probably come back to
  this, however our implementation only supports a single sensor for
  now,
- the vendor implementation supports disabling CPU cores as a cooling
  device. We did not attempt to port this, and this would not really fit
  this driver anyway.

Additionally, some differences from the other SoCs supported by this
driver:
- we do not really constrain the e-fuse information like the other SoCs
  do (data->{min,max}_efuse_value). In our tests, those values (as well
  as the raw sensor values) were much higher than in the other SoCs, to
  the degree that reusing the data->{min,max}_efuse_value from the other
  SoCs would cause instant critical temperature reset on boot,
- this SoC provides more information in the e-fuse data than other SoCs,
  so we read some values inside exynos850_tmu_initialize instead of
  hardcoding them in exynos_map_dt_data.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: rename and reorder some registers, use the correct register
  offset for EXYNOS850_TMU_REG_AVG_CON, make the clock required,
  additionally do some minor style changes.

 drivers/thermal/samsung/exynos_tmu.c | 191 +++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 087a09628e23..2618a81fca53 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -117,6 +117,41 @@
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
+/* Exynos850 specific registers */
+#define EXYNOS850_TMU_REG_CURRENT_TEMP0_1	0x40
+#define EXYNOS850_TMU_REG_THD_TEMP0_RISE	0x50
+#define EXYNOS850_TMU_REG_THD_TEMP0_FALL	0x60
+
+#define EXYNOS850_TMU_TRIMINFO_SHIFT		4
+#define EXYNOS850_TMU_TRIMINFO_OFFSET(n) \
+	(EXYNOS_TMU_REG_TRIMINFO + (n) * EXYNOS850_TMU_TRIMINFO_SHIFT)
+#define EXYNOS850_TMU_T_TRIM0_SHIFT		18
+
+#define EXYNOS850_TMU_REG_CONTROL1		0x24
+#define EXYNOS850_TMU_LPI_MODE_MASK		1
+#define EXYNOS850_TMU_LPI_MODE_SHIFT		10
+
+#define EXYNOS850_TMU_REG_COUNTER_VALUE0	0x30
+#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK	0xffff
+#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT	0
+
+#define EXYNOS850_TMU_REG_COUNTER_VALUE1	0x34
+#define EXYNOS850_TMU_CLK_SENSE_ON_MASK		0xffff
+#define EXYNOS850_TMU_CLK_SENSE_ON_SHIFT	16
+
+#define EXYNOS850_TMU_REG_AVG_CON		0x38
+#define EXYNOS850_TMU_AVG_MODE_MASK		0x7
+#define EXYNOS850_TMU_DEM_ENABLE		BIT(4)
+
+#define EXYNOS850_TMU_REG_TRIM0			0x3c
+#define EXYNOS850_TMU_TRIM0_MASK		0xf
+#define EXYNOS850_TMU_VBEI_TRIM_SHIFT		8
+#define EXYNOS850_TMU_VREF_TRIM_SHIFT		12
+#define EXYNOS850_TMU_BGRI_TRIM_SHIFT		20
+
+#define EXYNOS850_TMU_TEM1051X_SENSE_VALUE	0x028a
+#define EXYNOS850_TMU_TEM1456X_SENSE_VALUE	0x0a28
+
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
@@ -134,6 +169,7 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5433,
 	SOC_ARCH_EXYNOS7,
+	SOC_ARCH_EXYNOS850,
 };
 
 /**
@@ -232,12 +268,14 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 {
-	u16 tmu_temp_mask =
-		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
-						: EXYNOS_TMU_TEMP_MASK;
-	int tmu_85_shift =
-		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_SHIFT
-						: EXYNOS_TRIMINFO_85_SHIFT;
+	u16 tmu_temp_mask = (data->soc == SOC_ARCH_EXYNOS7 ||
+			     data->soc == SOC_ARCH_EXYNOS850) ?
+				    EXYNOS7_TMU_TEMP_MASK :
+				    EXYNOS_TMU_TEMP_MASK;
+	int tmu_85_shift = (data->soc == SOC_ARCH_EXYNOS7 ||
+			    data->soc == SOC_ARCH_EXYNOS850) ?
+				   EXYNOS7_TMU_TEMP_SHIFT :
+				   EXYNOS_TRIMINFO_85_SHIFT;
 
 	data->temp_error1 = trim_info & tmu_temp_mask;
 	if (!data->temp_error1 ||
@@ -587,6 +625,114 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 }
 
+static void exynos850_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_FALL + 12, 0,
+			       temp);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, true);
+}
+
+static void exynos850_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_RISE + 12, 16,
+			       temp);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, true);
+}
+
+static void exynos850_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS_TMU_INTEN_FALL0_SHIFT + 0, false);
+}
+
+static void exynos850_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 1, false);
+}
+
+static void exynos850_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	exynos_tmu_update_temp(data, EXYNOS850_TMU_REG_THD_TEMP0_RISE + 0, 16,
+			       temp);
+	exynos_tmu_update_bit(data, EXYNOS_TMU_REG_CONTROL,
+			      EXYNOS_TMU_THERM_TRIP_EN_SHIFT, true);
+	exynos_tmu_update_bit(data, EXYNOS7_TMU_REG_INTEN,
+			      EXYNOS7_TMU_INTEN_RISE0_SHIFT + 7, true);
+}
+
+static void exynos850_tmu_initialize(struct platform_device *pdev)
+{
+	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	u32 cal_type, avg_mode, reg, bgri, vref, vbei;
+
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(0));
+	cal_type = (reg & EXYNOS5433_TRIMINFO_CALIB_SEL_MASK) >>
+		   EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT;
+	data->reference_voltage = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+				  EXYNOS_TMU_REF_VOLTAGE_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(1));
+	data->gain = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+		     EXYNOS_TMU_BUF_SLOPE_SEL_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(2));
+	avg_mode = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+		   EXYNOS850_TMU_AVG_MODE_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(3));
+	bgri = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRIM0_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(4));
+	vref = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRIM0_MASK;
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(5));
+	vbei = (reg >> EXYNOS850_TMU_T_TRIM0_SHIFT) & EXYNOS850_TMU_TRIM0_MASK;
+
+	data->cal_type = cal_type == EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING ?
+				 TYPE_TWO_POINT_TRIMMING :
+				 TYPE_ONE_POINT_TRIMMING;
+
+	reg = readl(data->base + EXYNOS850_TMU_TRIMINFO_OFFSET(0));
+	sanitize_temp_error(data, reg);
+
+	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
+		 cal_type ? 2 : 1);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_AVG_CON);
+	reg &= ~EXYNOS850_TMU_AVG_MODE_MASK;
+	reg &= ~EXYNOS850_TMU_DEM_ENABLE;
+	if (avg_mode) {
+		reg |= avg_mode;
+		reg |= EXYNOS850_TMU_DEM_ENABLE;
+	}
+	writel(reg, data->base + EXYNOS850_TMU_REG_AVG_CON);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
+	reg &= ~(EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK
+		 << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT);
+	reg |= EXYNOS850_TMU_TEM1051X_SENSE_VALUE
+	       << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT;
+	writel(reg, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
+	reg &= ~(EXYNOS850_TMU_CLK_SENSE_ON_MASK
+		 << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT);
+	reg |= EXYNOS850_TMU_TEM1051X_SENSE_VALUE
+	       << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT;
+	writel(reg, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_TRIM0);
+	reg &= ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_BGRI_TRIM_SHIFT);
+	reg &= ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_VREF_TRIM_SHIFT);
+	reg &= ~(EXYNOS850_TMU_TRIM0_MASK << EXYNOS850_TMU_VBEI_TRIM_SHIFT);
+	reg |= bgri << EXYNOS850_TMU_BGRI_TRIM_SHIFT;
+	reg |= vref << EXYNOS850_TMU_VREF_TRIM_SHIFT;
+	reg |= vbei << EXYNOS850_TMU_VBEI_TRIM_SHIFT;
+	writel(reg, data->base + EXYNOS850_TMU_REG_TRIM0);
+
+	reg = readl(data->base + EXYNOS850_TMU_REG_CONTROL1);
+	reg &= ~(EXYNOS850_TMU_LPI_MODE_MASK << EXYNOS850_TMU_LPI_MODE_SHIFT);
+	writel(reg, data->base + EXYNOS850_TMU_REG_CONTROL1);
+}
+
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -676,7 +822,8 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
 
 		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
 		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		if (data->soc == SOC_ARCH_EXYNOS7) {
+		if (data->soc == SOC_ARCH_EXYNOS7 ||
+		    data->soc == SOC_ARCH_EXYNOS850) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
 			val |= (temp_to_code(data, temp) <<
@@ -706,7 +853,8 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 		emul_con = EXYNOS5260_EMUL_CON;
 	else if (data->soc == SOC_ARCH_EXYNOS5433)
 		emul_con = EXYNOS5433_TMU_EMUL_CON;
-	else if (data->soc == SOC_ARCH_EXYNOS7)
+	else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		 data->soc == SOC_ARCH_EXYNOS850)
 		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
 	else
 		emul_con = EXYNOS_EMUL_CON;
@@ -761,6 +909,12 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }
 
+static int exynos850_tmu_read(struct exynos_tmu_data *data)
+{
+	return readw(data->base + EXYNOS850_TMU_REG_CURRENT_TEMP0_1) &
+	       EXYNOS7_TMU_TEMP_MASK;
+}
+
 static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
@@ -787,7 +941,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	if (data->soc == SOC_ARCH_EXYNOS5260) {
 		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
 		tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
-	} else if (data->soc == SOC_ARCH_EXYNOS7) {
+	} else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		   data->soc == SOC_ARCH_EXYNOS850) {
 		tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
 		tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
 	} else if (data->soc == SOC_ARCH_EXYNOS5433) {
@@ -838,6 +993,9 @@ static const struct of_device_id exynos_tmu_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS7,
+	}, {
+		.compatible = "samsung,exynos850-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS850,
 	},
 	{ },
 };
@@ -950,6 +1108,21 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->min_efuse_value = 15;
 		data->max_efuse_value = 100;
 		break;
+	case SOC_ARCH_EXYNOS850:
+		data->tmu_set_low_temp = exynos850_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos850_tmu_set_high_temp;
+		data->tmu_disable_low = exynos850_tmu_disable_low;
+		data->tmu_disable_high = exynos850_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos850_tmu_set_crit_temp;
+		data->tmu_initialize = exynos850_tmu_initialize;
+		data->tmu_control = exynos4210_tmu_control;
+		data->tmu_read = exynos850_tmu_read;
+		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
+		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->efuse_value = 55;
+		data->min_efuse_value = 0;
+		data->max_efuse_value = 511;
+		break;
 	default:
 		dev_err(&pdev->dev, "Platform not supported\n");
 		return -EINVAL;
-- 
2.45.1


