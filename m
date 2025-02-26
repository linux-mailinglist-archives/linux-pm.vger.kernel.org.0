Return-Path: <linux-pm+bounces-22999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E57A4612A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112CA3A6A8E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD61219E86;
	Wed, 26 Feb 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PkYybYxv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEA2153C5;
	Wed, 26 Feb 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577396; cv=none; b=YXeHhyYP8BBtfoHhzY/3Wl+/mlhmhX/Io9iZ1cluBtGby7OWTrgdpW/IErOSCmQhrgdyMpYJ0XM4AatVddfNAGKrTkncLdFP95f9qX5Rh/eXF4tZ1AJX9w7LW2vQwUPNYV8ila0dHsy0cipYuZ2/Dj+MPgmmE/UfwQ39+pdhC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577396; c=relaxed/simple;
	bh=hiHMIoBuD8osVbyki6C8WOtP96rVTw9ivZsgkM/hiIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BiidZA2g3DovLEI6CI7MXHKd/ZpSnDjAs6GcbhuoP8tuW4/V+XDsP95Hf245zz2Wr6K99+G7vbB5/2PhOwylByuK/uZu9w2GCscF8eSOMItbrujc6/7uAYsTXjq1xSV9/Pl4Wvjpjd3jMlk+iPPkwVX5ujSMRckkOZx1FWXvS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PkYybYxv; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740577391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nhwGszginm29R9tGt1orXfgyR/gnEBSnFDv+JXvAq7M=;
	b=PkYybYxvtdHJnQIxbW/84jopdyHg7bzO2Tcz7qCtWbGWbmgD7op15gGB1R00P/TWedpidw
	EVUyZeTtRR7npDuCIU+kLuYE+0A3rYHWCaDiNdTtZSrFbAtGup6ZYHRDzFe8lDq030cU9t
	LXPpnn5EgjXgdiYmBtCsfLHeq3Lz0Dys/U3aCaAQ0376lsLJHWX9z4rZWXFWUv776ydJnj
	E+kN2sL9bwSBv7vseLMH0LTcS08DWkMq2HoCAyfC1Gu5UN4xLZGJoOcWALLDTop1w9OXgo
	nr6MLovbt2s21FcQ+Zfd0hypJOxVA+doEmR/qhz4dRanTtPBkvdtdZv9kOJJsw==
To: linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org
Cc: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	heiko@sntech.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] thermal: rockchip: Extract TSADC conversion tables into a header file
Date: Wed, 26 Feb 2025 14:42:59 +0100
Message-Id: <08d2fc6e1972f1f90c900542bf66945d6dc6db63.1740577122.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move the TSADC code-to-temperature mapping tables from the Rockchip thermal
driver to a separate header file, to no longer have the somewhat cluttering
mapping data as part of the driver itself. [1]

These mapping tables come verbatim from the SoC technical reference manuals
(TRMs) and the downstream kernel code, [2] and may be updated at some point
in the future, according to the manufacturer test results, [3] so extracting
the tables into a separate header file not just improves the readability of
the driver code, but introduces a clear separation.

Improve the wording of the moved comment block, sprinkle a few short comments
over the newly introduced header file, and move the already existing single
stray #include directive in the driver code to its beginning.

[1] https://lore.kernel.org/linux-rockchip/7f17cc55-a741-4bb8-9513-0580ca6fedd3@linaro.org/T/#u
[2] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/drivers/thermal/rockchip_thermal.c
[3] https://lore.kernel.org/linux-rockchip/b4ab86b56177a234f3738c477693e858@manjaro.org/T/#u

Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Heiko Stubner <heiko@sntech.de>
Suggested-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/thermal/rockchip_thermal.c        | 305 +-------------------
 drivers/thermal/rockchip_thermal_tables.h | 321 ++++++++++++++++++++++
 2 files changed, 324 insertions(+), 302 deletions(-)
 create mode 100644 drivers/thermal/rockchip_thermal_tables.h

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f551df48eef9..9fdad2a08c27 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -19,6 +19,9 @@
 #include <linux/mfd/syscon.h>
 #include <linux/pinctrl/consumer.h>
 
+#include "rockchip_thermal_tables.h"
+#include "thermal_hwmon.h"
+
 /*
  * If the temperature over a period of time High,
  * the resulting TSHUT gave CRU module,let it reset the entire chip,
@@ -49,8 +52,6 @@ enum adc_sort_mode {
 	ADC_INCREMENT,
 };
 
-#include "thermal_hwmon.h"
-
 /**
  * struct chip_tsadc_table - hold information about chip-specific differences
  * @id: conversion table
@@ -205,10 +206,6 @@ struct rockchip_thermal_data {
 #define TSADCV3_INT_PD_CLEAR_MASK		~BIT(16)
 #define TSADCV4_INT_PD_CLEAR_MASK		0xffffffff
 
-#define TSADCV2_DATA_MASK			0xfff
-#define TSADCV3_DATA_MASK			0x3ff
-#define TSADCV4_DATA_MASK			0x1ff
-
 #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
 #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
 #define TSADCV2_AUTO_PERIOD_TIME		250 /* 250ms */
@@ -249,302 +246,6 @@ struct rockchip_thermal_data {
 
 #define GRF_CON_TSADC_CH_INV			(0x10001 << 1)
 
-/**
- * struct tsadc_table - code to temperature conversion table
- * @code: the value of adc channel
- * @temp: the temperature
- * Note:
- * code to temperature mapping of the temperature sensor is a piece wise linear
- * curve.Any temperature, code faling between to 2 give temperatures can be
- * linearly interpolated.
- * Code to Temperature mapping should be updated based on manufacturer results.
- */
-struct tsadc_table {
-	u32 code;
-	int temp;
-};
-
-static const struct tsadc_table rv1108_table[] = {
-	{0, -40000},
-	{374, -40000},
-	{382, -35000},
-	{389, -30000},
-	{397, -25000},
-	{405, -20000},
-	{413, -15000},
-	{421, -10000},
-	{429, -5000},
-	{436, 0},
-	{444, 5000},
-	{452, 10000},
-	{460, 15000},
-	{468, 20000},
-	{476, 25000},
-	{483, 30000},
-	{491, 35000},
-	{499, 40000},
-	{507, 45000},
-	{515, 50000},
-	{523, 55000},
-	{531, 60000},
-	{539, 65000},
-	{547, 70000},
-	{555, 75000},
-	{562, 80000},
-	{570, 85000},
-	{578, 90000},
-	{586, 95000},
-	{594, 100000},
-	{602, 105000},
-	{610, 110000},
-	{618, 115000},
-	{626, 120000},
-	{634, 125000},
-	{TSADCV2_DATA_MASK, 125000},
-};
-
-static const struct tsadc_table rk3228_code_table[] = {
-	{0, -40000},
-	{588, -40000},
-	{593, -35000},
-	{598, -30000},
-	{603, -25000},
-	{608, -20000},
-	{613, -15000},
-	{618, -10000},
-	{623, -5000},
-	{629, 0},
-	{634, 5000},
-	{639, 10000},
-	{644, 15000},
-	{649, 20000},
-	{654, 25000},
-	{660, 30000},
-	{665, 35000},
-	{670, 40000},
-	{675, 45000},
-	{681, 50000},
-	{686, 55000},
-	{691, 60000},
-	{696, 65000},
-	{702, 70000},
-	{707, 75000},
-	{712, 80000},
-	{717, 85000},
-	{723, 90000},
-	{728, 95000},
-	{733, 100000},
-	{738, 105000},
-	{744, 110000},
-	{749, 115000},
-	{754, 120000},
-	{760, 125000},
-	{TSADCV2_DATA_MASK, 125000},
-};
-
-static const struct tsadc_table rk3288_code_table[] = {
-	{TSADCV2_DATA_MASK, -40000},
-	{3800, -40000},
-	{3792, -35000},
-	{3783, -30000},
-	{3774, -25000},
-	{3765, -20000},
-	{3756, -15000},
-	{3747, -10000},
-	{3737, -5000},
-	{3728, 0},
-	{3718, 5000},
-	{3708, 10000},
-	{3698, 15000},
-	{3688, 20000},
-	{3678, 25000},
-	{3667, 30000},
-	{3656, 35000},
-	{3645, 40000},
-	{3634, 45000},
-	{3623, 50000},
-	{3611, 55000},
-	{3600, 60000},
-	{3588, 65000},
-	{3575, 70000},
-	{3563, 75000},
-	{3550, 80000},
-	{3537, 85000},
-	{3524, 90000},
-	{3510, 95000},
-	{3496, 100000},
-	{3482, 105000},
-	{3467, 110000},
-	{3452, 115000},
-	{3437, 120000},
-	{3421, 125000},
-	{0, 125000},
-};
-
-static const struct tsadc_table rk3328_code_table[] = {
-	{0, -40000},
-	{296, -40000},
-	{304, -35000},
-	{313, -30000},
-	{331, -20000},
-	{340, -15000},
-	{349, -10000},
-	{359, -5000},
-	{368, 0},
-	{378, 5000},
-	{388, 10000},
-	{398, 15000},
-	{408, 20000},
-	{418, 25000},
-	{429, 30000},
-	{440, 35000},
-	{451, 40000},
-	{462, 45000},
-	{473, 50000},
-	{485, 55000},
-	{496, 60000},
-	{508, 65000},
-	{521, 70000},
-	{533, 75000},
-	{546, 80000},
-	{559, 85000},
-	{572, 90000},
-	{586, 95000},
-	{600, 100000},
-	{614, 105000},
-	{629, 110000},
-	{644, 115000},
-	{659, 120000},
-	{675, 125000},
-	{TSADCV2_DATA_MASK, 125000},
-};
-
-static const struct tsadc_table rk3368_code_table[] = {
-	{0, -40000},
-	{106, -40000},
-	{108, -35000},
-	{110, -30000},
-	{112, -25000},
-	{114, -20000},
-	{116, -15000},
-	{118, -10000},
-	{120, -5000},
-	{122, 0},
-	{124, 5000},
-	{126, 10000},
-	{128, 15000},
-	{130, 20000},
-	{132, 25000},
-	{134, 30000},
-	{136, 35000},
-	{138, 40000},
-	{140, 45000},
-	{142, 50000},
-	{144, 55000},
-	{146, 60000},
-	{148, 65000},
-	{150, 70000},
-	{152, 75000},
-	{154, 80000},
-	{156, 85000},
-	{158, 90000},
-	{160, 95000},
-	{162, 100000},
-	{163, 105000},
-	{165, 110000},
-	{167, 115000},
-	{169, 120000},
-	{171, 125000},
-	{TSADCV3_DATA_MASK, 125000},
-};
-
-static const struct tsadc_table rk3399_code_table[] = {
-	{0, -40000},
-	{402, -40000},
-	{410, -35000},
-	{419, -30000},
-	{427, -25000},
-	{436, -20000},
-	{444, -15000},
-	{453, -10000},
-	{461, -5000},
-	{470, 0},
-	{478, 5000},
-	{487, 10000},
-	{496, 15000},
-	{504, 20000},
-	{513, 25000},
-	{521, 30000},
-	{530, 35000},
-	{538, 40000},
-	{547, 45000},
-	{555, 50000},
-	{564, 55000},
-	{573, 60000},
-	{581, 65000},
-	{590, 70000},
-	{599, 75000},
-	{607, 80000},
-	{616, 85000},
-	{624, 90000},
-	{633, 95000},
-	{642, 100000},
-	{650, 105000},
-	{659, 110000},
-	{668, 115000},
-	{677, 120000},
-	{685, 125000},
-	{TSADCV3_DATA_MASK, 125000},
-};
-
-static const struct tsadc_table rk3568_code_table[] = {
-	{0, -40000},
-	{1584, -40000},
-	{1620, -35000},
-	{1652, -30000},
-	{1688, -25000},
-	{1720, -20000},
-	{1756, -15000},
-	{1788, -10000},
-	{1824, -5000},
-	{1856, 0},
-	{1892, 5000},
-	{1924, 10000},
-	{1956, 15000},
-	{1992, 20000},
-	{2024, 25000},
-	{2060, 30000},
-	{2092, 35000},
-	{2128, 40000},
-	{2160, 45000},
-	{2196, 50000},
-	{2228, 55000},
-	{2264, 60000},
-	{2300, 65000},
-	{2332, 70000},
-	{2368, 75000},
-	{2400, 80000},
-	{2436, 85000},
-	{2468, 90000},
-	{2500, 95000},
-	{2536, 100000},
-	{2572, 105000},
-	{2604, 110000},
-	{2636, 115000},
-	{2672, 120000},
-	{2704, 125000},
-	{TSADCV2_DATA_MASK, 125000},
-};
-
-static const struct tsadc_table rk3588_code_table[] = {
-	{0, -40000},
-	{215, -40000},
-	{285, 25000},
-	{350, 85000},
-	{395, 125000},
-	{TSADCV4_DATA_MASK, 125000},
-};
-
 static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
diff --git a/drivers/thermal/rockchip_thermal_tables.h b/drivers/thermal/rockchip_thermal_tables.h
new file mode 100644
index 000000000000..54e3512ce50c
--- /dev/null
+++ b/drivers/thermal/rockchip_thermal_tables.h
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014-2016, Fuzhou Rockchip Electronics Co., Ltd
+ * Caesar Wang <wxt@rock-chips.com>
+ */
+
+#ifndef __ROCKCHIP_THERMAL_TABLES_H
+#define __ROCKCHIP_THERMAL_TABLES_H
+
+#include <linux/types.h>
+
+/* TSADC sensor register mask descriptions */
+#define TSADCV2_DATA_MASK	0xfff
+#define TSADCV3_DATA_MASK	0x3ff
+#define TSADCV4_DATA_MASK	0x1ff
+
+/**
+ * struct tsadc_table - code-to-temperature conversion table
+ * @code: the value of TSADC channel
+ * @temp: the temperature
+ * Code-to-temperature mappings of the temperature sensor readings are
+ * piecewise-linear curves, so any temperature codes falling between the
+ * provided consecutive temperature codes can be linearly interpolated.
+ * These mappings come from the SoC TRMs and the downstream kernel code,
+ * and may be updated, based on the manufacturer test results.
+ */
+struct tsadc_table {
+	u32 code;
+	int temp;
+};
+
+/* RV1108 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rv1108_table[] = {
+	{0, -40000},
+	{374, -40000},
+	{382, -35000},
+	{389, -30000},
+	{397, -25000},
+	{405, -20000},
+	{413, -15000},
+	{421, -10000},
+	{429, -5000},
+	{436, 0},
+	{444, 5000},
+	{452, 10000},
+	{460, 15000},
+	{468, 20000},
+	{476, 25000},
+	{483, 30000},
+	{491, 35000},
+	{499, 40000},
+	{507, 45000},
+	{515, 50000},
+	{523, 55000},
+	{531, 60000},
+	{539, 65000},
+	{547, 70000},
+	{555, 75000},
+	{562, 80000},
+	{570, 85000},
+	{578, 90000},
+	{586, 95000},
+	{594, 100000},
+	{602, 105000},
+	{610, 110000},
+	{618, 115000},
+	{626, 120000},
+	{634, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
+/* RK3228 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rk3228_code_table[] = {
+	{0, -40000},
+	{588, -40000},
+	{593, -35000},
+	{598, -30000},
+	{603, -25000},
+	{608, -20000},
+	{613, -15000},
+	{618, -10000},
+	{623, -5000},
+	{629, 0},
+	{634, 5000},
+	{639, 10000},
+	{644, 15000},
+	{649, 20000},
+	{654, 25000},
+	{660, 30000},
+	{665, 35000},
+	{670, 40000},
+	{675, 45000},
+	{681, 50000},
+	{686, 55000},
+	{691, 60000},
+	{696, 65000},
+	{702, 70000},
+	{707, 75000},
+	{712, 80000},
+	{717, 85000},
+	{723, 90000},
+	{728, 95000},
+	{733, 100000},
+	{738, 105000},
+	{744, 110000},
+	{749, 115000},
+	{754, 120000},
+	{760, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
+/* RK3288 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rk3288_code_table[] = {
+	{TSADCV2_DATA_MASK, -40000},
+	{3800, -40000},
+	{3792, -35000},
+	{3783, -30000},
+	{3774, -25000},
+	{3765, -20000},
+	{3756, -15000},
+	{3747, -10000},
+	{3737, -5000},
+	{3728, 0},
+	{3718, 5000},
+	{3708, 10000},
+	{3698, 15000},
+	{3688, 20000},
+	{3678, 25000},
+	{3667, 30000},
+	{3656, 35000},
+	{3645, 40000},
+	{3634, 45000},
+	{3623, 50000},
+	{3611, 55000},
+	{3600, 60000},
+	{3588, 65000},
+	{3575, 70000},
+	{3563, 75000},
+	{3550, 80000},
+	{3537, 85000},
+	{3524, 90000},
+	{3510, 95000},
+	{3496, 100000},
+	{3482, 105000},
+	{3467, 110000},
+	{3452, 115000},
+	{3437, 120000},
+	{3421, 125000},
+	{0, 125000},
+};
+
+/* RK3328 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rk3328_code_table[] = {
+	{0, -40000},
+	{296, -40000},
+	{304, -35000},
+	{313, -30000},
+	{331, -20000},
+	{340, -15000},
+	{349, -10000},
+	{359, -5000},
+	{368, 0},
+	{378, 5000},
+	{388, 10000},
+	{398, 15000},
+	{408, 20000},
+	{418, 25000},
+	{429, 30000},
+	{440, 35000},
+	{451, 40000},
+	{462, 45000},
+	{473, 50000},
+	{485, 55000},
+	{496, 60000},
+	{508, 65000},
+	{521, 70000},
+	{533, 75000},
+	{546, 80000},
+	{559, 85000},
+	{572, 90000},
+	{586, 95000},
+	{600, 100000},
+	{614, 105000},
+	{629, 110000},
+	{644, 115000},
+	{659, 120000},
+	{675, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
+/* RK3368 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rk3368_code_table[] = {
+	{0, -40000},
+	{106, -40000},
+	{108, -35000},
+	{110, -30000},
+	{112, -25000},
+	{114, -20000},
+	{116, -15000},
+	{118, -10000},
+	{120, -5000},
+	{122, 0},
+	{124, 5000},
+	{126, 10000},
+	{128, 15000},
+	{130, 20000},
+	{132, 25000},
+	{134, 30000},
+	{136, 35000},
+	{138, 40000},
+	{140, 45000},
+	{142, 50000},
+	{144, 55000},
+	{146, 60000},
+	{148, 65000},
+	{150, 70000},
+	{152, 75000},
+	{154, 80000},
+	{156, 85000},
+	{158, 90000},
+	{160, 95000},
+	{162, 100000},
+	{163, 105000},
+	{165, 110000},
+	{167, 115000},
+	{169, 120000},
+	{171, 125000},
+	{TSADCV3_DATA_MASK, 125000},
+};
+
+/* RK3399 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rk3399_code_table[] = {
+	{0, -40000},
+	{402, -40000},
+	{410, -35000},
+	{419, -30000},
+	{427, -25000},
+	{436, -20000},
+	{444, -15000},
+	{453, -10000},
+	{461, -5000},
+	{470, 0},
+	{478, 5000},
+	{487, 10000},
+	{496, 15000},
+	{504, 20000},
+	{513, 25000},
+	{521, 30000},
+	{530, 35000},
+	{538, 40000},
+	{547, 45000},
+	{555, 50000},
+	{564, 55000},
+	{573, 60000},
+	{581, 65000},
+	{590, 70000},
+	{599, 75000},
+	{607, 80000},
+	{616, 85000},
+	{624, 90000},
+	{633, 95000},
+	{642, 100000},
+	{650, 105000},
+	{659, 110000},
+	{668, 115000},
+	{677, 120000},
+	{685, 125000},
+	{TSADCV3_DATA_MASK, 125000},
+};
+
+/* RK3568 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rk3568_code_table[] = {
+	{0, -40000},
+	{1584, -40000},
+	{1620, -35000},
+	{1652, -30000},
+	{1688, -25000},
+	{1720, -20000},
+	{1756, -15000},
+	{1788, -10000},
+	{1824, -5000},
+	{1856, 0},
+	{1892, 5000},
+	{1924, 10000},
+	{1956, 15000},
+	{1992, 20000},
+	{2024, 25000},
+	{2060, 30000},
+	{2092, 35000},
+	{2128, 40000},
+	{2160, 45000},
+	{2196, 50000},
+	{2228, 55000},
+	{2264, 60000},
+	{2300, 65000},
+	{2332, 70000},
+	{2368, 75000},
+	{2400, 80000},
+	{2436, 85000},
+	{2468, 90000},
+	{2500, 95000},
+	{2536, 100000},
+	{2572, 105000},
+	{2604, 110000},
+	{2636, 115000},
+	{2672, 120000},
+	{2704, 125000},
+	{TSADCV2_DATA_MASK, 125000},
+};
+
+/* RK3588 TSADC code-to-temperature conversion table */
+static const struct tsadc_table rk3588_code_table[] = {
+	{0, -40000},
+	{215, -40000},
+	{285, 25000},
+	{350, 85000},
+	{395, 125000},
+	{TSADCV4_DATA_MASK, 125000},
+};
+
+#endif

