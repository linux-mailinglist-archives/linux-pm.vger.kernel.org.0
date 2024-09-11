Return-Path: <linux-pm+bounces-14017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769F2975196
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E931C21B78
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E3C187FE1;
	Wed, 11 Sep 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TSS7trxo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C643192B9F
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056723; cv=none; b=oxSA8W32HIXO13meIvdDkJzjdA6qX1vulo3GK29xFllFq+naQgVva5LWLWUgkgQ79Cg1dmdi/rMMi1fmk4G1uwuAeTpNwYYy2kFIy4lhUZ6AtDgYh7BeUQ6r8Y/YkE0cIeHv8Q1VucQ7VkKPjPfDQQAYkfs4eRxH+dQyBiXrflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056723; c=relaxed/simple;
	bh=gNQ2tE7EWB1AI0nO5W0Zynui8PoA6aK9BqaMLy90mPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qh3/wKQBP1ceyCOiLHSVObg3PoqZhDme+LlPvMClmKqgxFBtf29dhOTpwJuFO/P9Z/3cW/yno/yjsd2zaIbudjiJgzhqn8/OjA1ukJkRG4B9lzseRnoAb075oq/H+mvcmhqTdmdjh+qEPupneymxx4YtTHSc49swzXsUDciswDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TSS7trxo; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240911121159euoutp01522f0c5c51da236e56504a56fbfcf736~0L3D6-a5M1084710847euoutp011
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 12:11:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240911121159euoutp01522f0c5c51da236e56504a56fbfcf736~0L3D6-a5M1084710847euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726056719;
	bh=S3zwFMdOfOUMhX015nExx0+RoZXJIo6huLDw+tGPrXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSS7trxogvcSRL/K5DfeR+xx5ih7zM4vWELgtHBDDMgGQ6n9F++7oPy/AjKCcmchp
	 X8o33ezcW9wY920Ndzwh9rs/4lx5zTzOXkQxq+nMLYMQb/0J5b+mXjXm7vY+S1N0te
	 tey+CGBrnvPCuCHZ/Ku2bxeLGxETCNvwtsvz6wEo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911121159eucas1p2e097336e5a263c87eeb3e393e6f09985~0L3Dhem3A2873128731eucas1p2W;
	Wed, 11 Sep 2024 12:11:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5B.D1.09624.E0981E66; Wed, 11
	Sep 2024 13:11:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911121158eucas1p2ab3ec5b5b59351af22c5740e02236b16~0L3Cv561f3175631756eucas1p2L;
	Wed, 11 Sep 2024 12:11:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911121158eusmtrp28ab9473e10a4db5afac116835ff782fa~0L3CvL4dj2708727087eusmtrp2q;
	Wed, 11 Sep 2024 12:11:58 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-a8-66e1890e1a9e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BF.4D.19096.D0981E66; Wed, 11
	Sep 2024 13:11:58 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911121157eusmtip1882ba911a83418a9736a09c51fae7dc2~0L3BtpZL70674806748eusmtip1I;
	Wed, 11 Sep 2024 12:11:57 +0000 (GMT)
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
	Moon <linux.amoon@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 6/7] drivers/thermal/exynos: add initial Exynos850
 support
Date: Wed, 11 Sep 2024 14:11:29 +0200
Message-ID: <20240911121136.1120026-7-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121136.1120026-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djPc7p8nQ/TDLruGFs8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLtkbvsFnO/TGW2+L9nB7vFk4d9bBbP+/YxOQh5rJm3htFj56y77B6L97xk8ti0qpPN
	4861PWwem5fUe/RtWcXo8XmTXABHFJdNSmpOZllqkb5dAldG86Q3bAWfoitOzFrL2MB40beL
	kZNDQsBE4kz7RNYuRi4OIYEVjBLN/2ezQThfGCWubD3NDOF8ZpT427ILyOEAa3k/xxwivpxR
	ov3tfCYIp5VJomvnBxaQuWwCBhIP3ixjB0mICCxmlGj88Q5sCbPARBaJ9W+6GUGqhAX8JW5N
	bQKzWQRUJdZvuwbWzStgJ9HZ+ZQN4kJ5iYtrnoPZnAL2Et9fL2eEqBGUODnzCVg9M1BN89bZ
	YLdKCMznlGhs7oBqdpHYCgxRCFtY4tXxLVC2jMT/nSB3g9j5EjM2v2eB+K1C4u5BLwjTWuLj
	GbCPmQU0Jdbv0ocodpRoXHgZqphP4sZbQYgD+CQmbZsODR9eiY42IYhqVYnjeyYxQ9jSEk9a
	bkOt9JB4vXEW0wRGxVlIXpmF5JVZCHsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93E
	CEx4p/8d/7SDce6rj3qHGJk4GA8xSnAwK4nw9tvdSxPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	q5oinyokkJ5YkpqdmlqQWgSTZeLglGpgknox45bHF9XKpGuyc79IlHR7y+aLCKpHbivf5eVf
	90J3nfzkq9FXOF7LWWUZvCvw4TlazL345dnLHzLz/69czyqRujZCTXTFy7MyWg9d//mmvxT5
	MVWlfFoj0xvPAO7mIwc3M6z0qDcWWXDlhHTuwv+nD1d4eT5ee1PJyb0qylpMfs6DB01r38Yc
	LJUJ+PZogTWDtzfPxWrt7bHSv/Yl+W6dHfLqmCiXTOgB5tlX/hdFyk2zUY2cIvDa45+j6vLp
	zz1SgpRuft1dOPWPTJTkmwm/L0ociGp/+37JfsV5P26e23G2iO3bxCar2wqsx54tqEi8smux
	bfPWI0ztzydqHin/+l03cKmk2olE4Sc/kpRYijMSDbWYi4oTAZ+Y7RfnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7p8nQ/TDJoeMVo8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxbqNt9gtFja1sFtM
	PDaZ2WLtkbvsFnO/TGW2+L9nB7vFk4d9bBbP+/YxOQh5rJm3htFj56y77B6L97xk8ti0qpPN
	4861PWwem5fUe/RtWcXo8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayV
	kamSvp1NSmpOZllqkb5dgl5G86Q3bAWfoitOzFrL2MB40beLkYNDQsBE4v0c8y5GTg4hgaWM
	Ej+Xs4DYEgLSEoe/TGGHsIUl/lzrYuti5AKqaWaSaNjfDZZgEzCQePBmGZgtIrCcUWJzuwdI
	EbPAXBaJzterwRLCAr4Sa6acArNZBFQl1m+7BraBV8BOorPzKRvEBnmJi2ueg9mcAvYS318v
	Z4S4yE7i48aTrBD1ghInZz4B62UGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvpFSfm
	Fpfmpesl5+duYgTG5rZjP7fsYFz56qPeIUYmDsZDjBIczEoivP1299KEeFMSK6tSi/Lji0pz
	UosPMZoC3T2RWUo0OR+YHPJK4g3NDEwNTcwsDUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj
	4uCUamCavWuhk9zBPtfpOncnmBrW754S/lltQ5FJwL/1H3r9vkeXXUh3mKm4w06wboKgh49M
	WMNrbeZjTDV9mqnxeySqCj+K9HgYXPh+RXjGoY+JKekKobYdG9y//DD82TjxfqLWQy5fRjcD
	zj9vzweyBZ2PuM28yXnz563ruuffrD8r2+ct9e9hpL3vk88zD7XmPF9vyyN9OCFh+xGVQo+/
	k0LEWdbfXp+X+Dmw6JWpBIdC/hm2kwVtsgu/tjfXev68/kN70rev5747JZ0MWWwRsvRvS0aH
	+bkX+55XFdXkv/NP4LZtn9fku2xat8qUeWHztA8ttmHV+bbGV5sz61BkC/OKpaXfCvfMb0vY
	t/33Y1YlluKMREMt5qLiRACJPi8EVgMAAA==
X-CMS-MailID: 20240911121158eucas1p2ab3ec5b5b59351af22c5740e02236b16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240911121158eucas1p2ab3ec5b5b59351af22c5740e02236b16
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240911121158eucas1p2ab3ec5b5b59351af22c5740e02236b16
References: <20240911121136.1120026-1-m.majewski2@samsung.com>
	<CGME20240911121158eucas1p2ab3ec5b5b59351af22c5740e02236b16@eucas1p2.samsung.com>

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

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v3 -> v4: adapted to sanitize_temp_error change.
v1 -> v2: rename and reorder some registers, use the correct register
  offset for EXYNOS850_TMU_REG_AVG_CON, make the clock required,
  additionally do some minor style changes.

 drivers/thermal/samsung/exynos_tmu.c | 179 ++++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9bddf9fd5049..c5769f9b6471 100644
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
@@ -584,6 +620,114 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
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
@@ -673,7 +817,8 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
 
 		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
 		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		if (data->soc == SOC_ARCH_EXYNOS7) {
+		if (data->soc == SOC_ARCH_EXYNOS7 ||
+		    data->soc == SOC_ARCH_EXYNOS850) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
 			val |= (temp_to_code(data, temp) <<
@@ -703,7 +848,8 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 		emul_con = EXYNOS5260_EMUL_CON;
 	else if (data->soc == SOC_ARCH_EXYNOS5433)
 		emul_con = EXYNOS5433_TMU_EMUL_CON;
-	else if (data->soc == SOC_ARCH_EXYNOS7)
+	else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		 data->soc == SOC_ARCH_EXYNOS850)
 		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
 	else
 		emul_con = EXYNOS_EMUL_CON;
@@ -758,6 +904,12 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
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
@@ -784,7 +936,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	if (data->soc == SOC_ARCH_EXYNOS5260) {
 		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
 		tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
-	} else if (data->soc == SOC_ARCH_EXYNOS7) {
+	} else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		   data->soc == SOC_ARCH_EXYNOS850) {
 		tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
 		tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
 	} else if (data->soc == SOC_ARCH_EXYNOS5433) {
@@ -835,6 +988,9 @@ static const struct of_device_id exynos_tmu_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS7,
+	}, {
+		.compatible = "samsung,exynos850-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS850,
 	},
 	{ },
 };
@@ -952,6 +1108,23 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
+		data->temp_mask = EXYNOS7_TMU_TEMP_MASK;
+		data->temp_85_shift = EXYNOS7_TMU_TEMP_SHIFT;
+		data->efuse_value = 55;
+		data->min_efuse_value = 0;
+		data->max_efuse_value = 511;
+		break;
 	default:
 		dev_err(&pdev->dev, "Platform not supported\n");
 		return -EINVAL;
-- 
2.45.2


