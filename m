Return-Path: <linux-pm+bounces-37910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B62DCC55F43
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 07:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D11C4E37DA
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 06:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64497322C9A;
	Thu, 13 Nov 2025 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RWmTGxe9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD43203A5
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763016052; cv=none; b=pZ4mosKY+usAoiZdInvvxteBLb9o9OIOzfFOHW7n/PHzV4I7xbF6sCi2D56SrZw2xGASj9RNhzWsUm3d3jMl6w/7MxcNuZm8o3NWOXzS+Uz7ScyN1dTQXjmd6lq2ldYMLV4ewps8ZLcLNynVI1HcfP+zS0nVfvN73QyFSM4XQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763016052; c=relaxed/simple;
	bh=nZ/OCImc1o1ZKL0kI36Xx6NpRJpxxnAVWRaNMmYGKbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=aQK1PtJ+3xX0zaRuI71COYHbby+99C0zSU4WJ8fEsac8abI/31z5ZSoCOL70izvrxJkq6tZEErbqsz+soPvb5Wh9uYkWWGrqMFERdpCyv1NUJ0yHbuqussQ6n+h0HrPHtE24ef2EOD6g2PdPlBKU9HyGD71vHK8fd0ufcDqcjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RWmTGxe9; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251113064046epoutp0338562c959dd8616c9f9847a887cbe2ba~3fcDgsfZ70265902659epoutp038
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 06:40:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251113064046epoutp0338562c959dd8616c9f9847a887cbe2ba~3fcDgsfZ70265902659epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763016046;
	bh=dA1CYvQDGRn1/ZdhJBrhCBYPIdLgWWLwobxHE73JqQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWmTGxe9lXFlpNx5pewPXTGu3yBPGG4QXtg+KwzPzLmsq/scZwpEcmLOu8CF/as8s
	 XpZdUb1K17xPYxUJl7kSk9AhkF6dc34yQGqtSCTF/ZxqQrLQmyCVC1B+1aV8vx3jKS
	 GFG6aYll8SbGHrs+UXBO035alSOXcSmPJRvQH+zk=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20251113064045epcas2p4e7aa40e1b08cbd9d2948a583ab85af0b~3fcC8D1xa1318413184epcas2p4C;
	Thu, 13 Nov 2025 06:40:45 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.212]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4d6Vyj2yPXz6B9m6; Thu, 13 Nov
	2025 06:40:45 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237~3fcB_RlIZ1747817478epcas2p1F;
	Thu, 13 Nov 2025 06:40:44 +0000 (GMT)
Received: from asswp60 (unknown [10.229.9.60]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251113064044epsmtip21a1e3803c7fa971807f6803ae3a1a8d3~3fcB4oeUj0163201632epsmtip2Q;
	Thu, 13 Nov 2025 06:40:44 +0000 (GMT)
From: Shin Son <shin.son@samsung.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Henrik Grimler <henrik@grimler.se>, Shin Son <shin.son@samsung.com>,
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 RESEND 2/3] thermal: exynos_tmu: Support new hardware and
 update TMU interface
Date: Thu, 13 Nov 2025 15:40:21 +0900
Message-ID: <20251113064022.2701578-3-shin.son@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113064022.2701578-1-shin.son@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237
References: <20251113064022.2701578-1-shin.son@samsung.com>
	<CGME20251113064044epcas2p1b87addb21473eca7cc52052e4e2e9237@epcas2p1.samsung.com>

The Exynos tmu driver's private data structure has been extended
to support the exynosautov920 hardware, which requires per-sensor interrupt
enablement and multiple-zone handling:

- Add 'slope_comp' : compensation parameter below 25 degrees.
- Add 'calib_temp' : stores the fused calibaration temperature.
- Add 'sensor_count' : reflects the maximum sensor numbers.
- Rename 'tzd' -> 'tzd_array' to register multiple thermal zones.

Since splitting this patch causes runtime errors during temperature
emulation or problems where the read temperature feature fails to
retrieve values, I have submitted it as a single commit. To add support
for the exynosautov920 to the exisiting TMU interface, the following
changes are included:

1. Simplify "temp_to_code" and "code_to_temp" to one computation path
   by normalizing calib_temp.
2. Loop over 'sensor_count' in critical-point setup.
3. Introduce 'update_con_reg' for exynosautov920 control-register updates.
4. Add exynosautov920-specific branch in 'exynos_tmu_update_temp' function.
5. Skip high & low temperature threshold setup in exynosautov920.
6. Enable interrupts via sensor_count in exynosautov920.
7. Initialize all new members during 'exynosautov920_tmu_initialize'.
8. Clear IRQs by iterating the sensor_count in exynosautov920.
9. Register each zone with 'devm_thermal_of_zone_register()'
   based on 'sensor_count'.

Reviewed-by: Henrik Grimler <henrik@grimler.se>
Signed-off-by: Shin Son <shin.son@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 322 ++++++++++++++++++++++++---
 1 file changed, 285 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..8fa188928b79 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -121,8 +121,51 @@
 
 #define EXYNOS_NOISE_CANCEL_MODE		4
 
+/* ExynosAutov920 specific registers */
+#define EXYNOSAUTOV920_SLOPE_COMP		25
+#define EXYNOSAUTOV920_SLOPE_COMP_MASK		0xf
+#define EXYNOSAUTOV920_CALIB_SEL_TEMP		30
+#define EXYNOSAUTOV920_CALIB_SEL_TEMP_MASK	0x2
+
+#define EXYNOSAUTOV920_SENSOR0_TRIM_INFO	0x10
+#define EXYNOSAUTOV920_TRIM_MASK		0x1ff
+#define EXYNOSAUTOV920_TRIMINFO_25_SHIFT	0
+#define EXYNOSAUTOV920_TRIMINFO_85_SHIFT	9
+
+#define EXYNOSAUTOV920_TMU_REG_TRIMINFO2	0x04
+
+#define EXYNOSAUTOV920_TMU_REG_THRESHOLD(p)	(((p)) * 0x50 + 0x00d0)
+#define EXYNOSAUTOV920_TMU_REG_INTEN(p)		(((p)) * 0x50 + 0x00f0)
+#define EXYNOSAUTOV920_TMU_REG_INT_PEND(p)	(((p)) * 0x50 + 0x00f8)
+
+#define EXYNOSAUTOV920_CURRENT_TEMP_P1_P0	0x084
+#define EXYNOSAUTOV920_TMU_REG_EMUL_CON		0x0b0
+
+#define EXYNOSAUTOV920_TMU_REG_CONTROL		0x50
+#define EXYNOSAUTOV920_TMU_REG_CONTROL1		0x54
+#define EXYNOSAUTOV920_TMU_REG_AVG_CONTROL	0x58
+#define EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL	0x70
+#define EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0	0x74
+#define EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1	0x78
+
+#define EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT		8
+#define EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK		0x1f
+#define EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT	3
+#define EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK		0xf
+#define EXYNOSAUTOV920_TMU_NUM_PROBE_MASK		0xf
+#define EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT		16
+#define EXYNOSAUTOV920_TMU_LPI_MODE_MASK		1
+#define EXYNOSAUTOV920_TMU_LPI_MODE_SHIFT		10
+
+#define EXYNOSAUTOV920_TMU_AVG_CON_UPDATE		0x0008011a
+#define EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE	0x030003c0
+#define EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE	0x03c0004d
+
 #define MCELSIUS	1000
 
+#define EXYNOS_DEFAULT_SENSOR_COUNT			1
+#define EXYNOS_MAX_SENSOR_COUNT				15
+
 enum soc_type {
 	SOC_ARCH_EXYNOS3250 = 1,
 	SOC_ARCH_EXYNOS4210,
@@ -133,6 +176,7 @@ enum soc_type {
 	SOC_ARCH_EXYNOS5420_TRIMINFO,
 	SOC_ARCH_EXYNOS5433,
 	SOC_ARCH_EXYNOS7,
+	SOC_ARCH_EXYNOSAUTOV920,
 };
 
 /**
@@ -150,6 +194,8 @@ enum soc_type {
  * @efuse_value: SoC defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
+ * @slope_comp: allocated value of the slope compensation.
+ * @calib_temp: calibration temperature of the TMU.
  * @temp_error1: fused value of the first point trim.
  * @temp_error2: fused value of the second point trim.
  * @gain: gain of amplifier in the positive-TC generator block
@@ -157,7 +203,8 @@ enum soc_type {
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
- * @tzd: pointer to thermal_zone_device structure
+ * @sensor_count: The maximum number of the sensors
+ * @tzd_array: pointer array of thermal_zone_device structure
  * @enabled: current status of TMU device
  * @tmu_set_low_temp: SoC specific method to set trip (falling threshold)
  * @tmu_set_high_temp: SoC specific method to set trip (rising threshold)
@@ -174,6 +221,7 @@ struct exynos_tmu_data {
 	void __iomem *base;
 	void __iomem *base_second;
 	int irq;
+	int sensor_count;
 	enum soc_type soc;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
@@ -181,10 +229,12 @@ struct exynos_tmu_data {
 	u32 efuse_value;
 	u32 min_efuse_value;
 	u32 max_efuse_value;
+	u16 slope_comp;
+	u16 calib_temp;
 	u16 temp_error1, temp_error2;
 	u8 gain;
 	u8 reference_voltage;
-	struct thermal_zone_device *tzd;
+	struct thermal_zone_device *tzd_array[EXYNOS_MAX_SENSOR_COUNT];
 	bool enabled;
 
 	void (*tmu_set_low_temp)(struct exynos_tmu_data *data, u8 temp);
@@ -205,13 +255,20 @@ struct exynos_tmu_data {
  */
 static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 {
+	s32 temp_diff, code;
+
 	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
 		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
 
-	return (temp - EXYNOS_FIRST_POINT_TRIM) *
-		(data->temp_error2 - data->temp_error1) /
-		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
-		data->temp_error1;
+	temp_diff = temp - EXYNOS_FIRST_POINT_TRIM;
+
+	code = temp_diff * (data->temp_error2 - data->temp_error1) * MCELSIUS /
+	       (data->calib_temp - EXYNOS_FIRST_POINT_TRIM);
+
+	if (data->soc == SOC_ARCH_EXYNOSAUTOV920 && temp_diff < 0)
+		code = code * (57 + data->slope_comp) / 65;
+
+	return code / MCELSIUS + data->temp_error1;
 }
 
 /*
@@ -220,13 +277,20 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
  */
 static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 {
+	s32 code_diff, temp;
+
 	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
 		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
 
-	return (temp_code - data->temp_error1) *
-		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
-		(data->temp_error2 - data->temp_error1) +
-		EXYNOS_FIRST_POINT_TRIM;
+	code_diff = temp_code - data->temp_error1;
+
+	temp = code_diff * (data->calib_temp - EXYNOS_FIRST_POINT_TRIM) * MCELSIUS /
+	       (data->temp_error2 - data->temp_error1);
+
+	if (data->soc == SOC_ARCH_EXYNOSAUTOV920 && code_diff < 0)
+		temp = temp * 65 / (57 + data->slope_comp);
+
+	return temp / MCELSIUS + EXYNOS_FIRST_POINT_TRIM;
 }
 
 static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
@@ -262,6 +326,9 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
+	if (data->soc == SOC_ARCH_EXYNOSAUTOV920)
+		status = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+
 	if (!status) {
 		ret = -EBUSY;
 	} else {
@@ -280,27 +347,34 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 static int exynos_thermal_zone_configure(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tzd = data->tzd;
-	int ret, temp;
+	struct thermal_zone_device *tzd;
+	int ret, temp, idx;
 
-	ret = thermal_zone_get_crit_temp(tzd, &temp);
-	if (ret) {
-		/* FIXME: Remove this special case */
-		if (data->soc == SOC_ARCH_EXYNOS5433)
-			return 0;
+	for (idx = 0; idx < data->sensor_count; idx++) {
+		tzd = data->tzd_array[idx];
 
-		dev_err(&pdev->dev,
-			"No CRITICAL trip point defined in device tree!\n");
-		return ret;
-	}
+		if (!tzd)
+			continue;
 
-	mutex_lock(&data->lock);
-	clk_enable(data->clk);
+		ret = thermal_zone_get_crit_temp(tzd, &temp);
+		if (ret) {
+			/* FIXME: Remove this special case */
+			if (data->soc == SOC_ARCH_EXYNOS5433)
+				return 0;
 
-	data->tmu_set_crit_temp(data, temp / MCELSIUS);
+			dev_err(&pdev->dev,
+				"No CRITICAL trip point defined in device tree!\n");
+			return ret;
+		}
 
-	clk_disable(data->clk);
-	mutex_unlock(&data->lock);
+		mutex_lock(&data->lock);
+		clk_enable(data->clk);
+
+		data->tmu_set_crit_temp(data, temp / MCELSIUS);
+
+		clk_disable(data->clk);
+		mutex_unlock(&data->lock);
+	}
 
 	return 0;
 }
@@ -323,6 +397,37 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 	return con;
 }
 
+static void update_con_reg(struct exynos_tmu_data *data)
+{
+	u32 val, t_buf_vref_sel, t_buf_slope_sel;
+
+	val = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+	t_buf_vref_sel = (val >> EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_SHIFT)
+				& EXYNOSAUTOV920_TMU_T_BUF_VREF_SEL_MASK;
+	t_buf_slope_sel = (val >> EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_SHIFT)
+				& EXYNOSAUTOV920_TMU_T_BUF_SLOPE_SEL_MASK;
+
+	val = readl(data->base +  EXYNOSAUTOV920_TMU_REG_CONTROL);
+	val &= ~(EXYNOS_TMU_REF_VOLTAGE_MASK << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
+	val |= (t_buf_vref_sel << EXYNOS_TMU_REF_VOLTAGE_SHIFT);
+	val &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
+	val |= (t_buf_slope_sel << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
+	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
+
+	val = readl(data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
+	val &= ~(EXYNOSAUTOV920_TMU_NUM_PROBE_MASK << EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);
+	val &= ~(EXYNOSAUTOV920_TMU_LPI_MODE_MASK << EXYNOSAUTOV920_TMU_LPI_MODE_SHIFT);
+	val |= (data->sensor_count << EXYNOSAUTOV920_TMU_NUM_PROBE_SHIFT);
+	writel(val, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL1);
+
+	writel(1, data->base + EXYNOSAUTOV920_TMU_SAMPLING_INTERVAL);
+	writel(EXYNOSAUTOV920_TMU_AVG_CON_UPDATE, data->base + EXYNOSAUTOV920_TMU_REG_AVG_CONTROL);
+	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE0_UPDATE,
+	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE0);
+	writel(EXYNOSAUTOV920_TMU_COUNTER_VALUE1_UPDATE,
+	       data->base + EXYNOSAUTOV920_TMU_REG_COUNTER_VALUE1);
+}
+
 static void exynos_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -354,9 +459,8 @@ static void exynos_tmu_update_temp(struct exynos_tmu_data *data, int reg_off,
 	u16 tmu_temp_mask;
 	u32 th;
 
-	tmu_temp_mask =
-		(data->soc == SOC_ARCH_EXYNOS7) ? EXYNOS7_TMU_TEMP_MASK
-						: EXYNOS_TMU_TEMP_MASK;
+	tmu_temp_mask = (data->soc == SOC_ARCH_EXYNOS7 || data->soc == SOC_ARCH_EXYNOSAUTOV920)
+		? EXYNOS7_TMU_TEMP_MASK	: EXYNOS_TMU_TEMP_MASK;
 
 	th = readl(data->base + reg_off);
 	th &= ~(tmu_temp_mask << bit_off);
@@ -582,6 +686,68 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 	sanitize_temp_error(data, trim_info);
 }
 
+static void exynosautov920_tmu_set_low_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	/*
+	 * Failing thresholds are not supported on Exynosautov920.
+	 * We use polling instead.
+	 */
+}
+
+static void exynosautov920_tmu_set_high_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	/*
+	 * Rising thresholds are not supported on Exynosautov920.
+	 * We use polling instead.
+	 */
+}
+
+static void exynosautov920_tmu_disable_low(struct exynos_tmu_data *data)
+{
+	/* Again, this is handled by polling. */
+}
+
+static void exynosautov920_tmu_disable_high(struct exynos_tmu_data *data)
+{
+	/* Again, this is handled by polling. */
+}
+
+static void exynosautov920_tmu_set_crit_temp(struct exynos_tmu_data *data, u8 temp)
+{
+	unsigned int idx;
+
+	for (idx = 0; idx < data->sensor_count; idx++) {
+		if (!data->tzd_array[idx])
+			continue;
+
+		exynos_tmu_update_temp(data, EXYNOSAUTOV920_TMU_REG_THRESHOLD(idx), 16, temp);
+		exynos_tmu_update_bit(data, EXYNOSAUTOV920_TMU_REG_INTEN(idx), 7, true);
+	}
+}
+
+static void exynosautov920_tmu_initialize(struct platform_device *pdev)
+{
+	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	unsigned int val;
+
+	data->tmu_control(pdev, false);
+
+	update_con_reg(data);
+
+	val = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
+	data->cal_type = TYPE_TWO_POINT_TRIMMING;
+	data->slope_comp = (val >> EXYNOSAUTOV920_SLOPE_COMP) & EXYNOSAUTOV920_SLOPE_COMP_MASK;
+
+	val = readl(data->base + EXYNOSAUTOV920_SENSOR0_TRIM_INFO);
+	data->temp_error1 = (val >> EXYNOSAUTOV920_TRIMINFO_25_SHIFT) & EXYNOSAUTOV920_TRIM_MASK;
+	data->temp_error2 = (val >> EXYNOSAUTOV920_TRIMINFO_85_SHIFT) & EXYNOSAUTOV920_TRIM_MASK;
+
+	val = readl(data->base + EXYNOSAUTOV920_TMU_REG_TRIMINFO2);
+	val = (val >> EXYNOSAUTOV920_CALIB_SEL_TEMP) & EXYNOSAUTOV920_CALIB_SEL_TEMP_MASK;
+
+	data->calib_temp = (EXYNOS_SECOND_POINT_TRIM + (20 * val));
+}
+
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
@@ -633,6 +799,24 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
 }
 
+static void exynosautov920_tmu_control(struct platform_device *pdev, bool on)
+{
+	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
+	unsigned int con;
+
+	con = readl(data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
+
+	if (on) {
+		con |= BIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
+		con |= BIT(EXYNOS_TMU_CORE_EN_SHIFT);
+	} else {
+		con &= ~BIT(EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
+		con &= ~BIT(EXYNOS_TMU_CORE_EN_SHIFT);
+	}
+
+	writel(con, data->base + EXYNOSAUTOV920_TMU_REG_CONTROL);
+}
+
 static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
@@ -671,7 +855,7 @@ static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned int val,
 
 		val &= ~(EXYNOS_EMUL_TIME_MASK << EXYNOS_EMUL_TIME_SHIFT);
 		val |= (EXYNOS_EMUL_TIME << EXYNOS_EMUL_TIME_SHIFT);
-		if (data->soc == SOC_ARCH_EXYNOS7) {
+		if (data->soc == SOC_ARCH_EXYNOS7 || data->soc == SOC_ARCH_EXYNOSAUTOV920) {
 			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
 				EXYNOS7_EMUL_DATA_SHIFT);
 			val |= (temp_to_code(data, temp) <<
@@ -703,6 +887,8 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
 		emul_con = EXYNOS5433_TMU_EMUL_CON;
 	else if (data->soc == SOC_ARCH_EXYNOS7)
 		emul_con = EXYNOS7_TMU_REG_EMUL_CON;
+	else if (data->soc == SOC_ARCH_EXYNOSAUTOV920)
+		emul_con = EXYNOSAUTOV920_TMU_REG_EMUL_CON;
 	else
 		emul_con = EXYNOS_EMUL_CON;
 
@@ -756,11 +942,23 @@ static int exynos7_tmu_read(struct exynos_tmu_data *data)
 		EXYNOS7_TMU_TEMP_MASK;
 }
 
+static int exynosautov920_tmu_read(struct exynos_tmu_data *data)
+{
+	return readw(data->base + EXYNOSAUTOV920_CURRENT_TEMP_P1_P0) &
+		EXYNOS7_TMU_TEMP_MASK;
+}
+
 static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
 {
 	struct exynos_tmu_data *data = id;
+	int idx;
 
-	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+	for (idx = 0; idx < data->sensor_count; idx++) {
+		if (!data->tzd_array[idx])
+			continue;
+
+		thermal_zone_device_update(data->tzd_array[idx], THERMAL_EVENT_UNSPECIFIED);
+	}
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
@@ -805,6 +1003,19 @@ static void exynos4210_tmu_clear_irqs(struct exynos_tmu_data *data)
 	writel(val_irq, data->base + tmu_intclear);
 }
 
+static void exynosautov920_tmu_clear_irqs(struct exynos_tmu_data *data)
+{
+	unsigned int idx, val_irq;
+
+	for (idx = 0; idx < data->sensor_count; idx++) {
+		if (!data->tzd_array[idx])
+			continue;
+
+		val_irq = readl(data->base + EXYNOSAUTOV920_TMU_REG_INT_PEND(idx));
+		writel(val_irq, data->base + EXYNOSAUTOV920_TMU_REG_INT_PEND(idx));
+	}
+}
+
 static const struct of_device_id exynos_tmu_match[] = {
 	{
 		.compatible = "samsung,exynos3250-tmu",
@@ -833,6 +1044,9 @@ static const struct of_device_id exynos_tmu_match[] = {
 	}, {
 		.compatible = "samsung,exynos7-tmu",
 		.data = (const void *)SOC_ARCH_EXYNOS7,
+	}, {
+		.compatible = "samsung,exynosautov920-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOSAUTOV920,
 	},
 	{ },
 };
@@ -865,6 +1079,10 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	data->soc = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
+	data->sensor_count = EXYNOS_DEFAULT_SENSOR_COUNT;
+
+	data->calib_temp = EXYNOS_SECOND_POINT_TRIM;
+
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
 		data->tmu_set_low_temp = exynos4210_tmu_set_low_temp;
@@ -945,6 +1163,19 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->min_efuse_value = 15;
 		data->max_efuse_value = 100;
 		break;
+	case SOC_ARCH_EXYNOSAUTOV920:
+		data->tmu_set_low_temp = exynosautov920_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynosautov920_tmu_set_high_temp;
+		data->tmu_disable_low = exynosautov920_tmu_disable_low;
+		data->tmu_disable_high = exynosautov920_tmu_disable_high;
+		data->tmu_set_crit_temp = exynosautov920_tmu_set_crit_temp;
+		data->tmu_initialize = exynosautov920_tmu_initialize;
+		data->tmu_control = exynosautov920_tmu_control;
+		data->tmu_read = exynosautov920_tmu_read;
+		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
+		data->tmu_clear_irqs = exynosautov920_tmu_clear_irqs;
+		data->sensor_count = EXYNOS_MAX_SENSOR_COUNT;
+		break;
 	default:
 		dev_err(&pdev->dev, "Platform not supported\n");
 		return -EINVAL;
@@ -952,6 +1183,14 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	data->cal_type = TYPE_ONE_POINT_TRIMMING;
 
+	if (data->soc == SOC_ARCH_EXYNOSAUTOV920) {
+		if (of_property_read_u32(pdev->dev.of_node, "samsung,sensors",
+					 &data->sensor_count)) {
+			dev_err(&pdev->dev, "failed to get sensor count\n");
+			return -ENODEV;
+		}
+	}
+
 	/*
 	 * Check if the TMU shares some registers and then try to map the
 	 * memory of common registers.
@@ -1006,7 +1245,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct exynos_tmu_data *data;
-	int ret;
+	struct thermal_zone_device *tzd;
+	int ret, idx;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -1084,11 +1324,19 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
-						  &exynos_sensor_ops);
-	if (IS_ERR(data->tzd)) {
-		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
-		goto err_sclk;
+	for (idx = 0; idx < data->sensor_count; idx++) {
+		tzd = devm_thermal_of_zone_register(dev, idx, data, &exynos_sensor_ops);
+
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV)
+				continue;
+
+			ret = dev_err_probe(dev, PTR_ERR(data->tzd_array[idx]),
+					    "Failed to register sensor\n");
+			goto err_sclk;
+		}
+
+		data->tzd_array[idx] = tzd;
 	}
 
 	ret = exynos_thermal_zone_configure(pdev);
-- 
2.50.1


