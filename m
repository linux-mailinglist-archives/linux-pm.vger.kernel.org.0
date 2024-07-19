Return-Path: <linux-pm+bounces-11260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D987937795
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B152832FC
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78066144316;
	Fri, 19 Jul 2024 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rlscTIXH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E3F13C904
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391000; cv=none; b=IydNebpgziO0+iVS47YCA/GFGL+k5TV3ka4GuxnD/+B8d5OMmczfxP+rZXPJ1VGdd1FwCnCbj45IOYf5sg9YiXBNZoB7XRERBLxUnf15m+VJQEqu+g5+Nq+96JOcFZoZWfXD/6bd5bo6nZt9sr8MzzLOseC3J5NnVTocTGDV00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391000; c=relaxed/simple;
	bh=/HNN8OFQ3R5ZoqZ2ogqxfXgFnBJjoJCicN2O7+LKRsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YVOnCKbxFpwN8mKIqxEqUbP1MlL190lC5tOvQlBCbpZUpiJhQswf0sTlMyKsocaxe9dRFJVJXPT46SNppZEcCFIMiFaE7LkdzdSY28aI/JX9TQ1v8LG5loaGUtcMYKK2YvQfDJUzBq9KUDTvzKAzBXnGWsP8wdT7A1XYklTHeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rlscTIXH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240719120949euoutp020b05e7462bf5159d56401be981df64d8~jm-v9vH2D2219622196euoutp025
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 12:09:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240719120949euoutp020b05e7462bf5159d56401be981df64d8~jm-v9vH2D2219622196euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721390989;
	bh=fmJbcmi/LwiFClTpNdD4BZjUdWpguzSvT0I1n6oqLKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlscTIXHpUdsNizDpI5F06naj0214ThtLZDGkj1xnpGVV+3IgAMOLn8t4dIz4aREg
	 +3Fxc3CFVUlKQUxC551Szjjq2NBYFCtNR0hmdj12Vxepylu7eO0esQqGZcfVNwcH9M
	 6KOseBzcNpAkMsWnZt7fODZ86I3s3h2I+mDANfj8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240719120948eucas1p110c64d876889330468cd3a6ef8dd4275~jm-vo9u9h0040800408eucas1p1r;
	Fri, 19 Jul 2024 12:09:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.8A.09875.C875A966; Fri, 19
	Jul 2024 13:09:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120948eucas1p13f3dc8f3aba56027da720d36c6057040~jm-vJouiz0450204502eucas1p1r;
	Fri, 19 Jul 2024 12:09:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240719120948eusmtrp18e8a0adba0296e1b231cb6b642b8740a~jm-vI8AqZ0601106011eusmtrp1G;
	Fri, 19 Jul 2024 12:09:48 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-ca-669a578cce93
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.EF.09010.C875A966; Fri, 19
	Jul 2024 13:09:48 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240719120947eusmtip143b83cffc393971c3187865d3eb15bfc~jm-uT2fcY0551205512eusmtip1R;
	Fri, 19 Jul 2024 12:09:47 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Bartlomiej Zolnierkiewicz
	<bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
	Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar
	<alim.akhtar@samsung.com>
Subject: [PATCH 5/6] drivers/thermal/exynos: add initial Exynos 850 support
Date: Fri, 19 Jul 2024 14:08:49 +0200
Message-ID: <20240719120853.1924771-6-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240719120853.1924771-1-m.majewski2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djPc7o94bPSDHb2qFo8mLeNzeL7lutM
	Fmv2nmOymPdZ1mL+kXOsFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+TxcKmFnaLiccmM1vM
	/TKV2eL/nh3sFk8e9rE58HusmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R79G1Zxejx
	eZNcAEcUl01Kak5mWWqRvl0CV8b6DXuYC67lVHRfOcvSwLgououRk0NCwETi6Mdu5i5GLg4h
	gRWMEvf717NBOF8YJda8m88K4XxmlFh+4h5QhgOs5d7xcIj4ckaJF9c2QhW1MknMXdbAAjKX
	TcBA4sGbZewgCRGBxYwSjT/egVUxC0xilji4ZiErSJWwgLfEo5szwWwWAVWJZdv6GUFW8ArY
	SVy84g9xoLxE7/4+JhCbU8Be4nfTWzYQm1dAUOLkzCdgy5iBapq3zgZ7QkKgn1Oif8V3Fohm
	F4nnh+ZC2cISr45vYYewZSROT+6BiudLzNj8ngXitQqJuwe9IExriY9nmEFMZgFNifW79CGi
	jhI71vJDmHwSN94KQuznk5i0bTozRJhXoqNNCGKyqsTxPZOYIWxpiSctt5kgbA+J1623WSYw
	Ks5C8sksJJ/MQli7gJF5FaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmA6O/3v+JcdjMtf
	fdQ7xMjEwXiIUYKDWUmE1+/bzDQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZ
	qakFqUUwWSYOTqkGJslriwq27DaTEpy56GGe5+vDmha/fj8xPhW3gD1T4MyFwBO6Dly2Bbsq
	KrmEM+QrtHcWXnr8xvPGvhnzGjvfZ+x9mdgb++aNO2udyOMeXfZL6to3avJjpwrURfkEHF3t
	3Op0SfXEnfzknyceGlafOLNEsmOO076OQxufb1ee7p6rd9M0+LfUvLrVi/sz/u64Lp26de6N
	nUzCR4+Y56j+bZj1Yp8Dr838zbrz5uxyWHzbrGbvnLqAPq3Kk0IZc3/9yoksC+R/321gGyV7
	NeRa9gSPvW8C1H228DqauD20YD1qUHeVQS/LVSCn9U+yst79vnv8qjwMLy91/JHusXXpNSrn
	XuZUHTupIlf7zd8eJZbijERDLeai4kQA8Gw+B9YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7o94bPSDBa94LJ4MG8bm8X3LdeZ
	LNbsPcdkMe+zrMX8I+dYLc6f38BusenxNVaLy7vmsFl87j3CaDHj/D4mi4VNLewWE49NZraY
	+2Uqs8X/PTvYLZ487GNz4PdYM28No8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n36NuyitHj
	8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsE
	vYz1G/YwF1zLqei+cpalgXFRdBcjB4eEgInEvePhXYxcHEICSxkl2iZPYOti5ASKS0sc/jKF
	HcIWlvhzrYsNoqiZSeJI3z4mkASbgIHEgzfLwIpEBJYzSmxu9wApYhaYxSzRe2oqI0hCWMBb
	4tHNmawgNouAqsSybf2MIJt5BewkLl7xh1ggL9G7vw9sJqeAvcTvprdgRwgBlez8OA/M5hUQ
	lDg58wkLiM0MVN+8dTbzBEaBWUhSs5CkFjAyrWIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM
	vm3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeP2+zUwT4k1JrKxKLcqPLyrNSS0+xGgKdPZEZinR
	5Hxg/OeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTDxPLSTPch8
	Wzt/juTqxo+bja7yXZluxVHyV8CjRfEiX2lH5PZYY2P1rS7njte397Pf6J31LdJYLevKtGLm
	fz37Tqj31V2bxrD8d5Kb/lmfWwd59b6lrmOLZS1q2HS3WGrR4jJd/4k/zN7tPRgnkr2IoSpx
	d6XrexMjLaknBm8u6xg/mXdj1fKdkpn1L/j88up//F79WK3lsuj7tdUuK+VyJVw+iL7Re+Do
	8mNX3N++h2dOyDvsixJL3i31/PYP5jcNkpYGNZXqm64GbPlY+yhNJLGmK+/9x6Dmjf9yOZjt
	Tnqcds4TPjfhwiPmWyo125+wTNWx++B+qNKJK+TiBC2xL71P3rP9+pByLXeb6mclluKMREMt
	5qLiRAA/7ZXyRwMAAA==
X-CMS-MailID: 20240719120948eucas1p13f3dc8f3aba56027da720d36c6057040
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240719120948eucas1p13f3dc8f3aba56027da720d36c6057040
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240719120948eucas1p13f3dc8f3aba56027da720d36c6057040
References: <20240719120853.1924771-1-m.majewski2@samsung.com>
	<CGME20240719120948eucas1p13f3dc8f3aba56027da720d36c6057040@eucas1p1.samsung.com>

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
- this SoC does not require a clock to work correctly, so we need an
  exception for data->clk,
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
 drivers/thermal/samsung/exynos_tmu.c | 214 +++++++++++++++++++++++++--
 1 file changed, 202 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f0de72a62fd7..bd52663f1a5a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -116,6 +116,43 @@
 #define EXYNOS7_EMUL_DATA_SHIFT			7
 #define EXYNOS7_EMUL_DATA_MASK			0x1ff
 
+/* Exynos850 specific registers */
+#define EXYNOS850_TMU_REG_AVG_CON		0x58
+#define EXYNOS850_TMU_REG_CONTROL1		0x24
+#define EXYNOS850_TMU_REG_COUNTER_VALUE0	0x30
+#define EXYNOS850_TMU_REG_COUNTER_VALUE1	0x34
+#define EXYNOS850_TMU_REG_CURRENT_TEMP1_0	0x40
+#define EXYNOS850_TMU_REG_THD_TEMP0_RISE	0x50
+#define EXYNOS850_TMU_REG_THD_TEMP0_FALL	0x60
+#define EXYNOS850_TMU_REG_TRIM0			0x3C
+
+#define EXYNOS850_TMU_AVG_CON_SHIFT		18
+#define EXYNOS850_TMU_AVG_MODE_MASK		0x7
+#define EXYNOS850_TMU_BGRI_TRIM_MASK		0xF
+#define EXYNOS850_TMU_BGRI_TRIM_SHIFT		20
+#define EXYNOS850_TMU_CLK_SENSE_ON_MASK		0xffff
+#define EXYNOS850_TMU_CLK_SENSE_ON_SHIFT	16
+#define EXYNOS850_TMU_DEM_ENABLE		1
+#define EXYNOS850_TMU_DEM_SHIFT			4
+#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK	0xffff
+#define EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT	0
+#define EXYNOS850_TMU_LPI_MODE_MASK		1
+#define EXYNOS850_TMU_LPI_MODE_SHIFT		10
+#define EXYNOS850_TMU_T_BUF_SLOPE_SEL_MASK	0xF
+#define EXYNOS850_TMU_T_BUF_SLOPE_SEL_SHIFT	18
+#define EXYNOS850_TMU_T_BUF_VREF_SEL_MASK	0x1F
+#define EXYNOS850_TMU_T_BUF_VREF_SEL_SHIFT	18
+#define EXYNOS850_TMU_TEM1051X_SENSE_VALUE	0x028A
+#define EXYNOS850_TMU_TEM1456X_SENSE_VALUE	0x0A28
+#define EXYNOS850_TMU_TEMP_SHIFT		9
+#define EXYNOS850_TMU_TRIMINFO_SHIFT		4
+#define EXYNOS850_TMU_T_TRIM0_MASK		0xF
+#define EXYNOS850_TMU_T_TRIM0_SHIFT		18
+#define EXYNOS850_TMU_VBEI_TRIM_MASK		0xF
+#define EXYNOS850_TMU_VBEI_TRIM_SHIFT		8
+#define EXYNOS850_TMU_VREF_TRIM_MASK		0xF
+#define EXYNOS850_TMU_VREF_TRIM_SHIFT		12
+
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
@@ -133,6 +170,7 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5433,
 	SOC_ARCH_EXYNOS7,
+	SOC_ARCH_EXYNOS850,
 };
 
 /**
@@ -231,13 +269,16 @@ static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 {
-	u16 tmu_temp_mask =
-		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
-						: EXYNOS_TMU_TEMP_MASK;
+	u16 tmu_temp_mask = (data->soc == SOC_ARCH_EXYNOS7 ||
+			     data->soc == SOC_ARCH_EXYNOS850) ?
+				    EXYNOS7_TMU_TEMP_MASK :
+				    EXYNOS_TMU_TEMP_MASK;
+	int tmu_85_shift = (data->soc == SOC_ARCH_EXYNOS850) ?
+				   EXYNOS850_TMU_TEMP_SHIFT :
+				   EXYNOS_TRIMINFO_85_SHIFT;
 
 	data->temp_error1 = trim_info & tmu_temp_mask;
-	data->temp_error2 = ((trim_info >> EXYNOS_TRIMINFO_85_SHIFT) &
-				tmu_temp_mask);
+	data->temp_error2 = ((trim_info >> tmu_85_shift) & tmu_temp_mask);
 
 	if (!data->temp_error1 ||
 	    (data->min_efuse_value > data->temp_error1) ||
@@ -245,9 +286,8 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
 		data->temp_error1 = data->efuse_value & tmu_temp_mask;
 
 	if (!data->temp_error2)
-		data->temp_error2 =
-			(data->efuse_value >> EXYNOS_TRIMINFO_85_SHIFT) &
-			tmu_temp_mask;
+		data->temp_error2 = (data->efuse_value >> tmu_85_shift) &
+				    tmu_temp_mask;
 }
 
 static int exynos_tmu_initialize(struct platform_device *pdev)
@@ -588,6 +628,129 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
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
+	int cal_type;
+	unsigned int avg_mode, buf, bgri, vref, vbei;
+
+	buf = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+	cal_type = (buf & EXYNOS5433_TRIMINFO_CALIB_SEL_MASK) >>
+		   EXYNOS5433_TRIMINFO_CALIB_SEL_SHIFT;
+	data->reference_voltage = (buf >> EXYNOS850_TMU_T_BUF_VREF_SEL_SHIFT) &
+				  EXYNOS850_TMU_T_BUF_VREF_SEL_MASK;
+	buf = readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
+		    EXYNOS850_TMU_TRIMINFO_SHIFT);
+	data->gain = (buf >> EXYNOS850_TMU_T_BUF_SLOPE_SEL_SHIFT) &
+		     EXYNOS850_TMU_T_BUF_SLOPE_SEL_MASK;
+	buf = readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
+		    2 * EXYNOS850_TMU_TRIMINFO_SHIFT);
+	avg_mode = (buf >> EXYNOS850_TMU_AVG_CON_SHIFT) &
+		   EXYNOS850_TMU_AVG_MODE_MASK;
+	buf = readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
+		    3 * EXYNOS850_TMU_TRIMINFO_SHIFT);
+	bgri = (buf >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+	       EXYNOS850_TMU_T_TRIM0_MASK;
+	buf = readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
+		    4 * EXYNOS850_TMU_TRIMINFO_SHIFT);
+	vref = (buf >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+	       EXYNOS850_TMU_T_TRIM0_MASK;
+	buf = readl(data->base + EXYNOS_TMU_REG_TRIMINFO +
+		    5 * EXYNOS850_TMU_TRIMINFO_SHIFT);
+	vbei = (buf >> EXYNOS850_TMU_T_TRIM0_SHIFT) &
+	       EXYNOS850_TMU_T_TRIM0_MASK;
+
+	buf = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+	sanitize_temp_error(data, buf);
+
+	switch (cal_type) {
+	case EXYNOS5433_TRIMINFO_TWO_POINT_TRIMMING:
+		data->cal_type = TYPE_TWO_POINT_TRIMMING;
+		break;
+	case EXYNOS5433_TRIMINFO_ONE_POINT_TRIMMING:
+	default:
+		data->cal_type = TYPE_ONE_POINT_TRIMMING;
+		break;
+	}
+
+	dev_info(&pdev->dev, "Calibration type is %d-point calibration\n",
+		 cal_type ? 2 : 1);
+
+	buf = readl(data->base + EXYNOS850_TMU_REG_AVG_CON);
+	buf &= ~(EXYNOS850_TMU_AVG_MODE_MASK);
+	buf &= ~(EXYNOS850_TMU_DEM_ENABLE << EXYNOS850_TMU_DEM_SHIFT);
+	if (avg_mode) {
+		buf |= avg_mode;
+		buf |= (EXYNOS850_TMU_DEM_ENABLE << EXYNOS850_TMU_DEM_SHIFT);
+	}
+	writel(buf, data->base + EXYNOS850_TMU_REG_AVG_CON);
+
+	buf = readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
+	buf &= ~(EXYNOS850_TMU_EN_TEMP_SEN_OFF_MASK
+		 << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT);
+	buf |= EXYNOS850_TMU_TEM1051X_SENSE_VALUE
+	       << EXYNOS850_TMU_EN_TEMP_SEN_OFF_SHIFT;
+	writel(buf, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE0);
+
+	buf = readl(data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
+	buf &= ~(EXYNOS850_TMU_CLK_SENSE_ON_MASK
+		 << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT);
+	buf |= EXYNOS850_TMU_TEM1051X_SENSE_VALUE
+	       << EXYNOS850_TMU_CLK_SENSE_ON_SHIFT;
+	writel(buf, data->base + EXYNOS850_TMU_REG_COUNTER_VALUE1);
+
+	buf = readl(data->base + EXYNOS850_TMU_REG_TRIM0);
+	buf &= ~(EXYNOS850_TMU_BGRI_TRIM_MASK << EXYNOS850_TMU_BGRI_TRIM_SHIFT);
+	buf &= ~(EXYNOS850_TMU_VREF_TRIM_MASK << EXYNOS850_TMU_VREF_TRIM_SHIFT);
+	buf &= ~(EXYNOS850_TMU_VBEI_TRIM_MASK << EXYNOS850_TMU_VBEI_TRIM_SHIFT);
+	buf |= (bgri << EXYNOS850_TMU_BGRI_TRIM_SHIFT);
+	buf |= (vref << EXYNOS850_TMU_VREF_TRIM_SHIFT);
+	buf |= (vbei << EXYNOS850_TMU_VBEI_TRIM_SHIFT);
+	writel(buf, data->base + EXYNOS850_TMU_REG_TRIM0);
+
+	buf = readl(data->base + EXYNOS850_TMU_REG_CONTROL1);
+	buf &= ~(EXYNOS850_TMU_LPI_MODE_MASK << EXYNOS850_TMU_LPI_MODE_SHIFT);
+	writel(buf, data->base + EXYNOS850_TMU_REG_CONTROL1);
+}
+
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -679,7 +842,8 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
 
 		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
 		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		if (data->soc == SOC_ARCH_EXYNOS7) {
+		if (data->soc == SOC_ARCH_EXYNOS7 ||
+		    data->soc == SOC_ARCH_EXYNOS850) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
 			val |= (temp_to_code(data, temp) <<
@@ -709,7 +873,8 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 		emul_con = EXYNOS5260_EMUL_CON;
 	else if (data->soc == SOC_ARCH_EXYNOS5433)
 		emul_con = EXYNOS5433_TMU_EMUL_CON;
-	else if (data->soc == SOC_ARCH_EXYNOS7)
+	else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		 data->soc == SOC_ARCH_EXYNOS850)
 		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
 	else
 		emul_con = EXYNOS_EMUL_CON;
@@ -766,6 +931,12 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }
 
+static int exynos850_tmu_read(struct exynos_tmu_data *data)
+{
+	return readw(data->base + EXYNOS850_TMU_REG_CURRENT_TEMP1_0) &
+	       EXYNOS7_TMU_TEMP_MASK;
+}
+
 static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
@@ -794,7 +965,8 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	if (data->soc == SOC_ARCH_EXYNOS5260) {
 		tmu_intstat = EXYNOS5260_TMU_REG_INTSTAT;
 		tmu_intclear = EXYNOS5260_TMU_REG_INTCLEAR;
-	} else if (data->soc == SOC_ARCH_EXYNOS7) {
+	} else if (data->soc == SOC_ARCH_EXYNOS7 ||
+		   data->soc == SOC_ARCH_EXYNOS850) {
 		tmu_intstat = EXYNOS7_TMU_REG_INTPEND;
 		tmu_intclear = EXYNOS7_TMU_REG_INTPEND;
 	} else if (data->soc == SOC_ARCH_EXYNOS5433) {
@@ -845,6 +1017,9 @@ static const struct of_device_id exynos_tmu_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS7,
+	}, {
+		.compatible = "samsung,exynos850-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS850,
 	},
 	{ },
 };
@@ -957,6 +1132,21 @@ static int exynos_map_dt_data(struct platform_device *pdev)
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
@@ -1051,7 +1241,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return ret;
 
 	data->clk = devm_clk_get(dev, "tmu_apbif");
-	if (IS_ERR(data->clk))
+	if (IS_ERR(data->clk) && data->soc != SOC_ARCH_EXYNOS850)
 		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
 
 	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
-- 
2.45.1


