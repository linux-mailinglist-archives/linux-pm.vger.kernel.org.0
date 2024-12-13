Return-Path: <linux-pm+bounces-19167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AD59F02BA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 03:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53A7188A698
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE013A271;
	Fri, 13 Dec 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AZZCxO30"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDD5FB95;
	Fri, 13 Dec 2024 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057510; cv=none; b=as2tlvDV3dey8pTDSvdkdmpH53rUFBYum+yfeVFFrDIelL/3yBWpRyumJpKAN7opF29VYEGcnsfG8QYWBjJuPbAgQfjCg1KKJX1hkYSTic9k6jo4JIv7p504WRiViyJBsbcNa3pLncutA0hB/J3SLwN3vmRS03x6lXIZBGTJ/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057510; c=relaxed/simple;
	bh=T3uaIe3e2rfq9w0DKr43V/fEeRGzf1WrdLOdrEyrEcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqj1u9BjCqnLZ6GPuLsQJfHvVGQUY612Cot8qdZ3sciBrf2m7lNPZvEN1lSqSpJEadGFT5mDRT2Y4OxAlKxAagpAwgy7c4x2TZorMdsrkn0So4maIctl0sJoe9GVoMF7H8rOVOD5gbco7qkH7R9SNK5h4uF/B00OdJI9zbaAXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AZZCxO30; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD0SlRT015771;
	Thu, 12 Dec 2024 21:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aHjO4
	ro3Pj1Utaln8Qszb0kYILmWARFKwCPqGVHRhQI=; b=AZZCxO30mZijk8N1XA4N6
	4Kdh2WFu+q2HhxI3/V6CxnfcpZp8PHQnPHN8/hrwOaPY3+w9FMHA2newB6vd8hUc
	3ncY4gCeuDjhAZhbcrqfz1pBLWAnOFjQP64Gv03jK3QA+6d7ysxBqyKILQp2SEY0
	M3V68bAVCdO9dXfvQ9HdMnOuRbrLbFCknq7F1PFvFoSc9AFXaR0mWGqSbVSiaBEG
	32zufw7Q0FxlG6loizbZ5VYJG7gDrX7LM7yvRIaLC6EKxGX+uSDcBd14inNz2L2X
	oUfdvMJ/ge+xjyuYcCGIOLvo4yA33KAYiAsMKzsDsGtHkHJu40hSwqPm1Y48I8HL
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43fbve0v0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:38:13 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BD2cCHI024829
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Dec 2024 21:38:12 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 12 Dec
 2024 21:38:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Dec 2024 21:38:12 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.223.26])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BD2bsXt028303;
	Thu, 12 Dec 2024 21:38:07 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v6 2/2] power/supply: Add support for ltc4162-f/s and ltc4015
Date: Fri, 13 Dec 2024 10:37:46 +0800
Message-ID: <20241213023746.34168-3-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213023746.34168-1-kimseer.paller@analog.com>
References: <20241213023746.34168-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vqsQA2xVgXkTsHAkZ1ZfiO1Xvw8pJxGz
X-Proofpoint-GUID: vqsQA2xVgXkTsHAkZ1ZfiO1Xvw8pJxGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130019

LTC4162-L 35V/3.2A Multi-Cell Lithium-Ion Step-Down Battery Charger
LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller

The LTC4162-L/F/S variants and LTC4015 share a common set of registers.
The difference lies in the resolution value of the scaling factor for
battery voltage and battery current measurement, input voltage, and
input current for different battery chemistries. The difference also
includes the calculation of setting and getting the actual voltage
setting applied to the charge voltage, as well as getting the die
temperature. Adding chip info structure to encapsulates these
differences by defining function pointers and parameters specific to
each device. This structure includes:
  - function pointers for getting and setting various parameters such as
    battery voltage, charge voltage, and die temperature
  - resolution parameters for battery current and input voltage
  - telemetry mask to specify which bits in the register are used for
    telemetry features

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/power/supply/ltc4162-l-charger.c | 434 ++++++++++++++++++++---
 1 file changed, 383 insertions(+), 51 deletions(-)

diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 2e4bc74e1c4a..24b62f0000cd 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  Driver for Analog Devices (Linear Technology) LTC4162-L charger IC.
+ *  Driver for Analog Devices (Linear Technology)
+ *  LTC4162-L 35V/3.2A Multi-Cell Lithium-Ion Step-Down Battery Charger
+ *  LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
+ *  LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
+ *  LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller
  *  Copyright (C) 2020, Topic Embedded Products
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -47,6 +52,20 @@
 #define LTC4162L_VBAT_FILT			0x47
 #define LTC4162L_INPUT_UNDERVOLTAGE_DAC		0x4B
 
+#define LTC4162L_CHEM_MASK			GENMASK(11, 8)
+
+enum ltc4162_chem {
+	ltc4162_lad,
+	ltc4162_l42,
+	ltc4162_l41,
+	ltc4162_l40,
+	ltc4162_fad,
+	ltc4162_ffs,
+	ltc4162_fst,
+	ltc4162_sst = 8,
+	ltc4162_sad,
+};
+
 /* Enumeration as in datasheet. Individual bits are mutually exclusive. */
 enum ltc4162l_state {
 	battery_detection = 2048,
@@ -75,10 +94,28 @@ enum ltc4162l_charge_status {
 /* Magic number to write to ARM_SHIP_MODE register */
 #define LTC4162L_ARM_SHIP_MODE_MAGIC 21325
 
+struct ltc4162l_info;
+
+struct ltc4162l_chip_info {
+	const char *name;
+	int (*get_vbat)(struct ltc4162l_info *info, unsigned int reg,
+			union power_supply_propval *val);
+	int (*get_vcharge)(struct ltc4162l_info *info, unsigned int reg,
+			   union power_supply_propval *val);
+	int (*set_vcharge)(struct ltc4162l_info *info, unsigned int reg,
+			   unsigned int value);
+	int (*get_die_temp)(struct ltc4162l_info *info,
+			    union power_supply_propval *val);
+	unsigned int ibat_resolution_pv;
+	unsigned int vin_resolution_uv;
+	u8 telemetry_mask;
+};
+
 struct ltc4162l_info {
 	struct i2c_client	*client;
 	struct regmap		*regmap;
 	struct power_supply	*charger;
+	const struct ltc4162l_chip_info *chip_info;
 	u32 rsnsb;	/* Series resistor that sets charge current, microOhm */
 	u32 rsnsi;	/* Series resistor to measure input current, microOhm */
 	u8 cell_count;	/* Number of connected cells, 0 while unknown */
@@ -108,6 +145,18 @@ static u8 ltc4162l_get_cell_count(struct ltc4162l_info *info)
 	return val;
 };
 
+static u8 ltc4162l_get_chem_type(struct ltc4162l_info *info)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(info->regmap, LTC4162L_CHEM_CELLS_REG, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(LTC4162L_CHEM_MASK, val);
+};
+
 /* Convert enum value to POWER_SUPPLY_STATUS value */
 static int ltc4162l_state_decode(enum ltc4162l_state value)
 {
@@ -223,25 +272,83 @@ static int ltc4162l_get_vbat(struct ltc4162l_info *info,
 				  unsigned int reg,
 				  union power_supply_propval *val)
 {
-	unsigned int regval;
+	unsigned int regval, chem_type;
 	int ret;
 
 	ret = regmap_read(info->regmap, reg, &regval);
 	if (ret)
 		return ret;
 
-	/* cell_count × 192.4μV/LSB */
-	regval *= 1924;
-	regval *= ltc4162l_get_cell_count(info);
-	regval /= 10;
-	val->intval = regval;
+	/*
+	 * cell_count × scaling factor
+	 * For ltc4162-s, it uses a cell_count value of 2 for each group of 3
+	 * physical (2V) cells, thus will return 2, 4, 6, 8 for 6V, 12V, 18V,
+	 * and 24V respectively, and has to divide by 2 to multiply the scale
+	 * factor by 1, 2, 3, or 4 to represent a 6V, 12V, 18V, or 24V battery
+	 * respectively.
+	 */
+	chem_type = ltc4162l_get_chem_type(info);
+	switch (chem_type) {
+	case ltc4162_lad ... ltc4162_fst:
+		regval *= 1924;
+		regval *= ltc4162l_get_cell_count(info);
+		regval /= 10;
+		val->intval = regval;
 
-	return 0;
+		return 0;
+	case ltc4162_sst ... ltc4162_sad:
+		regval *= 3848;
+		regval *= ltc4162l_get_cell_count(info) / 2;
+		regval /= 10;
+		val->intval = regval;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc4015_get_vbat(struct ltc4162l_info *info,
+			    unsigned int reg,
+			    union power_supply_propval *val)
+{
+	unsigned int regval, chem_type;
+	int ret;
+
+	ret = regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	/*
+	 * cell count x scaling factor
+	 * ltc4015 lead-acid fixed and lead-acid programmable corresponds to
+	 * 0x7 and 0x8 chem respectively
+	 */
+	chem_type = ltc4162l_get_chem_type(info);
+	switch (chem_type) {
+	case ltc4162_lad ... ltc4162_fst:
+		regval *= 192264;
+		regval *= ltc4162l_get_cell_count(info);
+		regval /= 1000;
+		val->intval = regval;
+
+		return 0;
+	case ltc4162_sst - 1 ... ltc4162_sad - 1:
+		regval *= 128176;
+		regval *= ltc4162l_get_cell_count(info);
+		regval /= 1000;
+		val->intval = regval;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ltc4162l_get_ibat(struct ltc4162l_info *info,
 			     union power_supply_propval *val)
 {
+	const struct ltc4162l_chip_info *chip_info = info->chip_info;
 	unsigned int regval;
 	int ret;
 
@@ -249,9 +356,8 @@ static int ltc4162l_get_ibat(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	/* Signed 16-bit number, 1.466μV / RSNSB amperes/LSB. */
 	ret = (s16)(regval & 0xFFFF);
-	val->intval = 100 * mult_frac(ret, 14660, (int)info->rsnsb);
+	val->intval = mult_frac(ret, chip_info->ibat_resolution_pv, info->rsnsb);
 
 	return 0;
 }
@@ -260,6 +366,7 @@ static int ltc4162l_get_ibat(struct ltc4162l_info *info,
 static int ltc4162l_get_input_voltage(struct ltc4162l_info *info,
 				      union power_supply_propval *val)
 {
+	const struct ltc4162l_chip_info *chip_info = info->chip_info;
 	unsigned int regval;
 	int ret;
 
@@ -267,8 +374,7 @@ static int ltc4162l_get_input_voltage(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	/* 1.649mV/LSB */
-	val->intval =  regval * 1694;
+	val->intval =  regval * chip_info->vin_resolution_uv;
 
 	return 0;
 }
@@ -276,6 +382,7 @@ static int ltc4162l_get_input_voltage(struct ltc4162l_info *info,
 static int ltc4162l_get_input_current(struct ltc4162l_info *info,
 				      union power_supply_propval *val)
 {
+	const struct ltc4162l_chip_info *chip_info = info->chip_info;
 	unsigned int regval;
 	int ret;
 
@@ -283,11 +390,9 @@ static int ltc4162l_get_input_current(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	/* Signed 16-bit number, 1.466μV / RSNSI amperes/LSB. */
 	ret = (s16)(regval & 0xFFFF);
-	ret *= 14660;
+	ret *= chip_info->ibat_resolution_pv;
 	ret /= info->rsnsi;
-	ret *= 100;
 
 	val->intval = ret;
 
@@ -336,7 +441,7 @@ static int ltc4162l_get_vcharge(struct ltc4162l_info *info,
 				unsigned int reg,
 				union power_supply_propval *val)
 {
-	unsigned int regval;
+	unsigned int regval, chem_type;
 	int ret;
 	u32 voltage;
 
@@ -348,37 +453,177 @@ static int ltc4162l_get_vcharge(struct ltc4162l_info *info,
 
 	/*
 	 * charge voltage setting can be computed from
-	 * cell_count × (vcharge_setting × 12.5mV + 3.8125V)
-	 * where vcharge_setting ranges from 0 to 31 (4.2V max).
+	 * cell_count × (vcharge_setting × a + b)
+	 * where vcharge_setting ranges from 0 to c (d).
+	 * for ltc4162l: a = 12.5mV , b = 3.8125V, c = 31, d = 4.2Vmax
+	 * for ltc4162f: a = 12.5mV , b = 3.4125V, c = 31, d = 3.8Vmax
+	 *
+	 * for ltc4162s, the charge voltage setting can be computed from
+	 * N x (vcharge_setting x 28.571mV + 6.0V)
+	 * where N is 1, 2, 3, or 4 for 6V, 12V, 18V, or 24V battery respectively,
+	 * and vcharge_setting ranges from 0 to 31
 	 */
-	voltage = 3812500 + (regval * 12500);
-	voltage *= ltc4162l_get_cell_count(info);
-	val->intval = voltage;
+	chem_type = ltc4162l_get_chem_type(info);
+	switch (chem_type) {
+	case ltc4162_lad ... ltc4162_l40:
+		voltage = 3812500 + (regval * 12500);
+		voltage *= ltc4162l_get_cell_count(info);
+		val->intval = voltage;
 
-	return 0;
+		return 0;
+	case ltc4162_fad ... ltc4162_fst:
+		voltage = 3412500 + (regval * 12500);
+		voltage *= ltc4162l_get_cell_count(info);
+		val->intval = voltage;
+
+		return 0;
+	case ltc4162_sst ... ltc4162_sad:
+		voltage = 6000000 + (regval * 28571);
+		voltage *= ltc4162l_get_cell_count(info) / 2;
+		val->intval = voltage;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
 }
 
-static int ltc4162l_set_vcharge(struct ltc4162l_info *info,
-				unsigned int reg,
-				unsigned int value)
+static int ltc4015_get_vcharge(struct ltc4162l_info *info,
+			       unsigned int reg,
+			       union power_supply_propval *val)
 {
-	u8 cell_count = ltc4162l_get_cell_count(info);
+	unsigned int regval, chem_type;
+	int ret;
+	u32 voltage;
+
+	ret = regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
 
-	if (!cell_count)
-		return -EBUSY; /* Not available yet, try again later */
+	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+
+	/*
+	 * charge voltage setting can be computed from:
+	 * cell_count × (vcharge_setting × a + b)
+	 * where vcharge_setting ranges from 0 to c (d).
+	 * Li-Ion: a = 1/80V, b = 3.8125V, c = 31, d = 4.2Vmax
+	 * LiFePO4: a = 1/80V, b = 3.4125V, c = 31, d = 3.8Vmax
+	 * Lead Acid: a = 1/105V, b = 2V, c = 35, d = 2.6Vmax
+	 */
+	chem_type = ltc4162l_get_chem_type(info);
+	switch (chem_type) {
+	case ltc4162_lad ... ltc4162_l40:
+		voltage = 3812500 + (regval * 12500);
+		voltage *= ltc4162l_get_cell_count(info);
+		val->intval = voltage;
+
+		return 0;
+	case ltc4162_fad ... ltc4162_fst:
+		voltage = 3412500 + (regval * 12500);
+		voltage *= ltc4162l_get_cell_count(info);
+		val->intval = voltage;
+
+		return 0;
+	case ltc4162_sst - 1 ... ltc4162_sad - 1:
+		voltage = 2000000 + mult_frac(regval, 1000000, 105);
+		voltage *= ltc4162l_get_cell_count(info);
+		val->intval = voltage;
 
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc4162l_vcharge(unsigned int base_voltage,
+			    unsigned int scale_factor,
+			    unsigned int range,
+			    unsigned int value,
+			    u8 cell_count)
+{
 	value /= cell_count;
 
-	if (value < 3812500)
+	if (value < base_voltage)
 		return -EINVAL;
 
-	value -= 3812500;
-	value /= 12500;
+	value -= base_voltage;
+	value /= scale_factor;
 
-	if (value > 31)
+	if (value > range)
 		return -EINVAL;
 
-	return regmap_write(info->regmap, reg, value);
+	return value;
+}
+
+static int ltc4162l_set_vcharge(struct ltc4162l_info *info,
+				unsigned int reg,
+				unsigned int value)
+{
+	unsigned int chem_type;
+	u8 cell_count;
+
+	chem_type = ltc4162l_get_chem_type(info);
+	switch (chem_type) {
+	case ltc4162_lad ... ltc4162_l40:
+		cell_count = ltc4162l_get_cell_count(info);
+		if (!cell_count)
+			return -EBUSY;
+
+		value = ltc4162l_vcharge(3812500, 12500, 31, value, cell_count);
+		return regmap_write(info->regmap, reg, value);
+	case ltc4162_fad ... ltc4162_fst:
+		cell_count = ltc4162l_get_cell_count(info);
+		if (!cell_count)
+			return -EBUSY;
+
+		value = ltc4162l_vcharge(3412500, 12500, 31, value, cell_count);
+		return regmap_write(info->regmap, reg, value);
+	case ltc4162_sst ... ltc4162_sad:
+		cell_count = ltc4162l_get_cell_count(info) / 2;
+		if (!cell_count)
+			return -EBUSY;
+
+		value = ltc4162l_vcharge(6000000, 28571, 31, value, cell_count);
+		return regmap_write(info->regmap, reg, value);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc4015_set_vcharge(struct ltc4162l_info *info,
+			       unsigned int reg,
+			       unsigned int value)
+{
+	unsigned int chem_type;
+	u8 cell_count;
+
+	chem_type = ltc4162l_get_chem_type(info);
+	switch (chem_type) {
+	case ltc4162_lad ... ltc4162_l40:
+		cell_count = ltc4162l_get_cell_count(info);
+		if (!cell_count)
+			return -EBUSY;
+
+		value = ltc4162l_vcharge(3812500, 12500, 31, value, cell_count);
+		return regmap_write(info->regmap, reg, value);
+	case ltc4162_fad ... ltc4162_fst:
+		cell_count = ltc4162l_get_cell_count(info);
+		if (!cell_count)
+			return -EBUSY;
+
+		value = ltc4162l_vcharge(3412500, 12500, 31, value, cell_count);
+		return regmap_write(info->regmap, reg, value);
+	case ltc4162_sst - 1 ... ltc4162_sad - 1:
+		cell_count = ltc4162l_get_cell_count(info);
+		if (!cell_count)
+			return -EBUSY;
+
+		value = ltc4162l_vcharge(2000000, 1000000 / 105, 35,
+					 value, cell_count);
+		return regmap_write(info->regmap, reg, value);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ltc4162l_get_iin_limit_dac(struct ltc4162l_info *info,
@@ -437,9 +682,30 @@ static int ltc4162l_get_die_temp(struct ltc4162l_info *info,
 	return 0;
 }
 
+static int ltc4015_get_die_temp(struct ltc4162l_info *info,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_DIE_TEMPERATURE, &regval);
+	if (ret)
+		return ret;
+
+	/* (die_temp - 12010) / 45.6°C */
+	ret = (s16)(regval & 0xFFFF);
+	ret -= 12010;
+	ret *= 1000;
+	ret /= 456;
+	val->intval = ret;
+
+	return 0;
+}
+
 static int ltc4162l_get_term_current(struct ltc4162l_info *info,
 				     union power_supply_propval *val)
 {
+	const struct ltc4162l_chip_info *chip_info = info->chip_info;
 	unsigned int regval;
 	int ret;
 
@@ -457,10 +723,9 @@ static int ltc4162l_get_term_current(struct ltc4162l_info *info,
 	if (ret)
 		return ret;
 
-	/* 1.466μV / RSNSB amperes/LSB */
-	regval *= 14660u;
+	regval *= chip_info->ibat_resolution_pv;
 	regval /= info->rsnsb;
-	val->intval = 100 * regval;
+	val->intval = regval;
 
 	return 0;
 }
@@ -534,10 +799,11 @@ static ssize_t vbat_show(struct device *dev,
 {
 	struct power_supply *psy = to_power_supply(dev);
 	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	const struct ltc4162l_chip_info *chip_info = info->chip_info;
 	union power_supply_propval val;
 	int ret;
 
-	ret = ltc4162l_get_vbat(info, LTC4162L_VBAT, &val);
+	ret = chip_info->get_vbat(info, LTC4162L_VBAT, &val);
 	if (ret)
 		return ret;
 
@@ -550,10 +816,11 @@ static ssize_t vbat_avg_show(struct device *dev,
 {
 	struct power_supply *psy = to_power_supply(dev);
 	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	const struct ltc4162l_chip_info *chip_info = info->chip_info;
 	union power_supply_propval val;
 	int ret;
 
-	ret = ltc4162l_get_vbat(info, LTC4162L_VBAT_FILT, &val);
+	ret = chip_info->get_vbat(info, LTC4162L_VBAT_FILT, &val);
 	if (ret)
 		return ret;
 
@@ -589,7 +856,8 @@ static ssize_t force_telemetry_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sysfs_emit(buf, "%u\n", regval & BIT(2) ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", regval &
+			  info->chip_info->telemetry_mask ? 1 : 0);
 }
 
 static ssize_t force_telemetry_store(struct device *dev,
@@ -607,7 +875,8 @@ static ssize_t force_telemetry_store(struct device *dev,
 		return ret;
 
 	ret = regmap_update_bits(info->regmap, LTC4162L_CONFIG_BITS_REG,
-				 BIT(2), value ? BIT(2) : 0);
+				 info->chip_info->telemetry_mask,
+				 value ? info->chip_info->telemetry_mask : 0);
 	if (ret < 0)
 		return ret;
 
@@ -681,6 +950,7 @@ static int ltc4162l_get_property(struct power_supply *psy,
 				 union power_supply_propval *val)
 {
 	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	const struct ltc4162l_chip_info *chip_info = info->chip_info;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -702,15 +972,13 @@ static int ltc4162l_get_property(struct power_supply *psy,
 		return ltc4162l_get_icharge(info,
 				LTC4162L_CHARGE_CURRENT_SETTING, val);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		return ltc4162l_get_vcharge(info,
-				LTC4162L_VCHARGE_DAC, val);
+		return chip_info->get_vcharge(info, LTC4162L_VCHARGE_DAC, val);
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		return ltc4162l_get_vcharge(info,
-				LTC4162L_VCHARGE_SETTING, val);
+		return chip_info->get_vcharge(info, LTC4162L_VCHARGE_SETTING, val);
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return ltc4162l_get_iin_limit_dac(info, val);
 	case POWER_SUPPLY_PROP_TEMP:
-		return ltc4162l_get_die_temp(info, val);
+		return chip_info->get_die_temp(info, val);
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 		return ltc4162l_get_term_current(info, val);
 	default:
@@ -772,7 +1040,6 @@ static enum power_supply_property ltc4162l_properties[] = {
 };
 
 static const struct power_supply_desc ltc4162l_desc = {
-	.name		= "ltc4162-l",
 	.type		= POWER_SUPPLY_TYPE_MAINS,
 	.properties	= ltc4162l_properties,
 	.num_properties	= ARRAY_SIZE(ltc4162l_properties),
@@ -781,6 +1048,50 @@ static const struct power_supply_desc ltc4162l_desc = {
 	.property_is_writeable = ltc4162l_property_is_writeable,
 };
 
+static const struct ltc4162l_chip_info ltc4162l_chip_info = {
+	.name = "ltc4162-l",
+	.get_vbat = ltc4162l_get_vbat,
+	.get_vcharge = ltc4162l_get_vcharge,
+	.set_vcharge = ltc4162l_set_vcharge,
+	.get_die_temp = ltc4162l_get_die_temp,
+	.ibat_resolution_pv = 1466000,
+	.vin_resolution_uv = 1649,
+	.telemetry_mask = BIT(2),
+};
+
+static const struct ltc4162l_chip_info ltc4162f_chip_info = {
+	.name = "ltc4162-f",
+	.get_vbat = ltc4162l_get_vbat,
+	.get_vcharge = ltc4162l_get_vcharge,
+	.set_vcharge = ltc4162l_set_vcharge,
+	.get_die_temp = ltc4162l_get_die_temp,
+	.ibat_resolution_pv = 1466000,
+	.vin_resolution_uv = 1649,
+	.telemetry_mask = BIT(2),
+};
+
+static const struct ltc4162l_chip_info ltc4162s_chip_info = {
+	.name = "ltc4162-s",
+	.get_vbat = ltc4162l_get_vbat,
+	.get_vcharge = ltc4162l_get_vcharge,
+	.set_vcharge = ltc4162l_set_vcharge,
+	.get_die_temp = ltc4162l_get_die_temp,
+	.ibat_resolution_pv = 1466000,
+	.vin_resolution_uv = 1649,
+	.telemetry_mask = BIT(2),
+};
+
+static const struct ltc4162l_chip_info ltc4015_chip_info = {
+	.name = "ltc4015",
+	.get_vbat = ltc4015_get_vbat,
+	.get_vcharge = ltc4015_get_vcharge,
+	.set_vcharge = ltc4015_set_vcharge,
+	.get_die_temp = ltc4015_get_die_temp,
+	.ibat_resolution_pv = 1464870,
+	.vin_resolution_uv = 1648,
+	.telemetry_mask = BIT(4),
+};
+
 static bool ltc4162l_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	/* all registers up to this one are writeable */
@@ -825,6 +1136,8 @@ static int ltc4162l_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct ltc4162l_info *info;
 	struct power_supply_config ltc4162l_config = {};
+	struct power_supply_desc *desc;
+	const struct ltc4162l_chip_info *chip_info;
 	u32 value;
 	int ret;
 
@@ -839,6 +1152,12 @@ static int ltc4162l_probe(struct i2c_client *client)
 	info->client = client;
 	i2c_set_clientdata(client, info);
 
+	chip_info = i2c_get_match_data(client);
+	if (!chip_info)
+		return -ENODEV;
+
+	info->chip_info = chip_info;
+
 	info->regmap = devm_regmap_init_i2c(client, &ltc4162l_regmap_config);
 	if (IS_ERR(info->regmap)) {
 		dev_err(dev, "Failed to initialize register map\n");
@@ -870,8 +1189,15 @@ static int ltc4162l_probe(struct i2c_client *client)
 	ltc4162l_config.drv_data = info;
 	ltc4162l_config.attr_grp = ltc4162l_attr_groups;
 
-	info->charger = devm_power_supply_register(dev, &ltc4162l_desc,
-						   &ltc4162l_config);
+	/* Duplicate the default descriptor to set name based on chip_info. */
+	desc = devm_kmemdup(dev, &ltc4162l_desc,
+			    sizeof(struct power_supply_desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	desc->name = chip_info->name;
+
+	info->charger = devm_power_supply_register(dev, desc, &ltc4162l_config);
 	if (IS_ERR(info->charger)) {
 		dev_err(dev, "Failed to register charger\n");
 		return PTR_ERR(info->charger);
@@ -903,14 +1229,20 @@ static void ltc4162l_alert(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ltc4162l_i2c_id_table[] = {
-	{ "ltc4162-l" },
+	{ "ltc4015", (kernel_ulong_t)&ltc4015_chip_info },
+	{ "ltc4162-f", (kernel_ulong_t)&ltc4162f_chip_info },
+	{ "ltc4162-l", (kernel_ulong_t)&ltc4162l_chip_info },
+	{ "ltc4162-s", (kernel_ulong_t)&ltc4162s_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc4162l_i2c_id_table);
 
 static const struct of_device_id ltc4162l_of_match[] __maybe_unused = {
-	{ .compatible = "lltc,ltc4162-l", },
-	{ },
+	{ .compatible = "lltc,ltc4015", .data = &ltc4015_chip_info },
+	{ .compatible = "lltc,ltc4162-f", .data = &ltc4162f_chip_info },
+	{ .compatible = "lltc,ltc4162-l", .data = &ltc4162l_chip_info },
+	{ .compatible = "lltc,ltc4162-s", .data = &ltc4162s_chip_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc4162l_of_match);
 
-- 
2.34.1


