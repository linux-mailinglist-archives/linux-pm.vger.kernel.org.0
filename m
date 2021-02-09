Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E495D315A46
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 00:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhBIXut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 18:50:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59022 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbhBIXI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 18:08:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 119N5jYi085769;
        Tue, 9 Feb 2021 17:05:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612911945;
        bh=GcQzqYKJwgDexlG9Xg9xMgI/iACkxn59AC3j0/BofoY=;
        h=From:To:CC:Subject:Date;
        b=kDe9Mmmupo93JrFvaj2JRUxwFeuec7Z20pqb5jvfaU+6zYT9J3ijPIiZwU7dYBnXW
         UKD8FwT5vqVyyRy/UIiWNlKsuTWlzSX1Ps6mHaT1uJmXVg0HUzBKubXxdOLK18sJoK
         C+Jt5pZRFArFJ1tt5RUtPaOSCGz4gn7wqz9Cv6aE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 119N5jmC122470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 17:05:45 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Feb
 2021 17:05:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Feb 2021 17:05:44 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 119N5iP3019855;
        Tue, 9 Feb 2021 17:05:44 -0600
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH 1/2] power: supply: bq25980: Applies multiple fixes brought on 
Date:   Tue, 9 Feb 2021 17:05:26 -0600
Message-ID: <20210209230527.26712-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

fix: corrects various register step size and offset values

fix: corrects bq25980_get_input_curr_lim() and bq25980_set_input_curr_lim()

fix: corrects bq25980_get_const_charge_curr() and bq25980_set_const_charge_curr()

fix: corrects BQ25960_BATOVP_MIN_uV, BQ25960_BATOVP_OFFSET_uV,

BQ25960_BATOVP_STEP_uV, and BQ25960_BATOVP_MAX_uV

fix: corrects busocp_sc_min and busocp_byp_min members

fix: removes unnecessary polarity check from bq25980_get_adc_ibus()

fix: removes unnecessary polarity check from bq25980_get_adc_ibat()

fix: clamps ibat_adc to match datasheet change

Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
---
 drivers/power/supply/bq25980_charger.c | 141 ++++++++++++++++++++-----
 drivers/power/supply/bq25980_charger.h |  77 ++++++++++----
 2 files changed, 173 insertions(+), 45 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 530ff4025b31..7c489a9e8877 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -52,6 +52,10 @@ struct bq25980_chip_info {
 	int busocp_byp_max;
 	int busocp_sc_min;
 	int busocp_byp_min;
+	int busocp_sc_step;
+	int busocp_byp_step;
+	int busocp_sc_offset;
+	int busocp_byp_offset;
 
 	int busovp_sc_def;
 	int busovp_byp_def;
@@ -73,6 +77,20 @@ struct bq25980_chip_info {
 
 	int batocp_def;
 	int batocp_max;
+	int batocp_min;
+	int batocp_step;
+
+	int vbus_adc_step;
+	int vbus_adc_offset;
+
+	int ibus_adc_step;
+	int ibus_adc_offset;
+
+	int vbat_adc_step;
+	int vbat_adc_offset;
+
+	int ibat_adc_step;
+	int ibat_adc_offset;
 };
 
 struct bq25980_init_data {
@@ -275,13 +293,22 @@ static int bq25980_watchdog_time[BQ25980_NUM_WD_VAL] = {5000, 10000, 50000,
 static int bq25980_get_input_curr_lim(struct bq25980_device *bq)
 {
 	unsigned int busocp_reg_code;
+	int offset, step;
 	int ret;
 
+	if (bq->state.bypass) {
+		step = bq->chip_info->busocp_byp_step;
+		offset = bq->chip_info->busocp_byp_offset;
+	} else {
+		step = bq->chip_info->busocp_sc_step;
+		offset = bq->chip_info->busocp_sc_offset;
+	}
+
 	ret = regmap_read(bq->regmap, BQ25980_BUSOCP, &busocp_reg_code);
 	if (ret)
 		return ret;
 
-	return (busocp_reg_code * BQ25980_BUSOCP_STEP_uA) + BQ25980_BUSOCP_OFFSET_uA;
+	return (busocp_reg_code * step) + offset;
 }
 
 static int bq25980_set_hiz(struct bq25980_device *bq, int setting)
@@ -293,6 +320,7 @@ static int bq25980_set_hiz(struct bq25980_device *bq, int setting)
 static int bq25980_set_input_curr_lim(struct bq25980_device *bq, int busocp)
 {
 	unsigned int busocp_reg_code;
+	int step, offset;
 	int ret;
 
 	if (!busocp)
@@ -303,13 +331,17 @@ static int bq25980_set_input_curr_lim(struct bq25980_device *bq, int busocp)
 	if (busocp < BQ25980_BUSOCP_MIN_uA)
 		busocp = BQ25980_BUSOCP_MIN_uA;
 
-	if (bq->state.bypass)
+	if (bq->state.bypass) {
 		busocp = min(busocp, bq->chip_info->busocp_sc_max);
-	else
+		step = bq->chip_info->busocp_byp_step;
+		offset = bq->chip_info->busocp_byp_offset;
+	} else {
 		busocp = min(busocp, bq->chip_info->busocp_byp_max);
+		step = bq->chip_info->busocp_sc_step;
+		offset = bq->chip_info->busocp_sc_offset;
+	}
 
-	busocp_reg_code = (busocp - BQ25980_BUSOCP_OFFSET_uA)
-						/ BQ25980_BUSOCP_STEP_uA;
+	busocp_reg_code = (busocp - offset) / step;
 
 	ret = regmap_write(bq->regmap, BQ25980_BUSOCP, busocp_reg_code);
 	if (ret)
@@ -374,6 +406,7 @@ static int bq25980_set_input_volt_lim(struct bq25980_device *bq, int busovp)
 
 static int bq25980_get_const_charge_curr(struct bq25980_device *bq)
 {
+	int step = bq->chip_info->batocp_step;
 	unsigned int batocp_reg_code;
 	int ret;
 
@@ -381,19 +414,20 @@ static int bq25980_get_const_charge_curr(struct bq25980_device *bq)
 	if (ret)
 		return ret;
 
-	return (batocp_reg_code & BQ25980_BATOCP_MASK) *
-						BQ25980_BATOCP_STEP_uA;
+	return (batocp_reg_code & BQ25980_BATOCP_MASK) * step;
 }
 
 static int bq25980_set_const_charge_curr(struct bq25980_device *bq, int batocp)
 {
+	int step = bq->chip_info->batocp_step;
+	int max = bq->chip_info->batocp_max;
+	int min = bq->chip_info->batocp_min;
 	unsigned int batocp_reg_code;
 	int ret;
 
-	batocp = max(batocp, BQ25980_BATOCP_MIN_uA);
-	batocp = min(batocp, bq->chip_info->batocp_max);
+	batocp = clamp(batocp, min, max);
 
-	batocp_reg_code = batocp / BQ25980_BATOCP_STEP_uA;
+	batocp_reg_code = batocp / step;
 
 	ret = regmap_update_bits(bq->regmap, BQ25980_BATOCP,
 				BQ25980_BATOCP_MASK, batocp_reg_code);
@@ -490,10 +524,8 @@ static int bq25980_get_adc_ibus(struct bq25980_device *bq)
 
 	ibus_adc = (ibus_adc_msb << 8) | ibus_adc_lsb;
 
-	if (ibus_adc_msb & BQ25980_ADC_POLARITY_BIT)
-		return ((ibus_adc ^ 0xffff) + 1) * BQ25980_ADC_CURR_STEP_uA;
-
-	return ibus_adc * BQ25980_ADC_CURR_STEP_uA;
+	return (ibus_adc * bq->chip_info->ibus_adc_step) +
+					bq->chip_info->ibus_adc_offset;
 }
 
 static int bq25980_get_adc_vbus(struct bq25980_device *bq)
@@ -512,7 +544,8 @@ static int bq25980_get_adc_vbus(struct bq25980_device *bq)
 
 	vbus_adc = (vbus_adc_msb << 8) | vbus_adc_lsb;
 
-	return vbus_adc * BQ25980_ADC_VOLT_STEP_uV;
+	return (vbus_adc * bq->chip_info->vbus_adc_step) +
+					bq->chip_info->vbus_adc_offset;
 }
 
 static int bq25980_get_ibat_adc(struct bq25980_device *bq)
@@ -531,29 +564,31 @@ static int bq25980_get_ibat_adc(struct bq25980_device *bq)
 
 	ibat_adc = (ibat_adc_msb << 8) | ibat_adc_lsb;
 
-	if (ibat_adc_msb & BQ25980_ADC_POLARITY_BIT)
-		return ((ibat_adc ^ 0xffff) + 1) * BQ25980_ADC_CURR_STEP_uA;
+	ibat_adc = clamp(ibat_adc, BQ25960_ADC_IBAT_MIN_CODE,
+					BQ25960_ADC_IBAT_MAX_CODE);
 
-	return ibat_adc * BQ25980_ADC_CURR_STEP_uA;
+	return (ibat_adc * bq->chip_info->ibat_adc_step) +
+					bq->chip_info->ibat_adc_offset;
 }
 
 static int bq25980_get_adc_vbat(struct bq25980_device *bq)
 {
-	int vsys_adc_lsb, vsys_adc_msb;
-	u16 vsys_adc;
+	int vbat_adc_lsb, vbat_adc_msb;
+	u16 vbat_adc;
 	int ret;
 
-	ret = regmap_read(bq->regmap, BQ25980_VBAT_ADC_MSB, &vsys_adc_msb);
+	ret = regmap_read(bq->regmap, BQ25980_VBAT_ADC_MSB, &vbat_adc_msb);
 	if (ret)
 		return ret;
 
-	ret = regmap_read(bq->regmap, BQ25980_VBAT_ADC_LSB, &vsys_adc_lsb);
+	ret = regmap_read(bq->regmap, BQ25980_VBAT_ADC_LSB, &vbat_adc_lsb);
 	if (ret)
 		return ret;
 
-	vsys_adc = (vsys_adc_msb << 8) | vsys_adc_lsb;
+	vbat_adc = (vbat_adc_msb << 8) | vbat_adc_lsb;
 
-	return vsys_adc * BQ25980_ADC_VOLT_STEP_uV;
+	return (vbat_adc * bq->chip_info->vbat_adc_step) +
+					bq->chip_info->vbat_adc_offset;
 }
 
 static int bq25980_get_state(struct bq25980_device *bq,
@@ -984,6 +1019,10 @@ static const struct bq25980_chip_info bq25980_chip_info_tbl[] = {
 		.busocp_sc_max = BQ25980_BUSOCP_SC_MAX_uA,
 		.busocp_byp_max = BQ25980_BUSOCP_BYP_MAX_uA,
 		.busocp_byp_min = BQ25980_BUSOCP_MIN_uA,
+		.busocp_sc_step = BQ25980_BUSOCP_STEP_uA,
+		.busocp_byp_step = BQ25980_BUSOCP_STEP_uA,
+		.busocp_sc_offset = BQ25980_BUSOCP_OFFSET_uA,
+		.busocp_byp_offset = BQ25980_BUSOCP_OFFSET_uA,
 
 		.busovp_sc_def = BQ25980_BUSOVP_DFLT_uV,
 		.busovp_byp_def = BQ25980_BUSOVP_BYPASS_DFLT_uV,
@@ -1004,6 +1043,20 @@ static const struct bq25980_chip_info bq25980_chip_info_tbl[] = {
 
 		.batocp_def = BQ25980_BATOCP_DFLT_uA,
 		.batocp_max = BQ25980_BATOCP_MAX_uA,
+		.batocp_min = BQ25980_BATOCP_MIN_uA,
+		.batocp_step = BQ25980_BATOCP_STEP_uA,
+
+		.vbus_adc_step = BQ25980_ADC_VBUS_STEP_uV,
+		.vbus_adc_offset = BQ25980_ADC_VBUS_OFFSET_uV,
+
+		.ibus_adc_step = BQ25980_ADC_IBUS_STEP_uA,
+		.ibus_adc_offset = BQ25980_ADC_IBUS_OFFSET_uA,
+
+		.vbat_adc_step = BQ25980_ADC_VBAT_STEP_uV,
+		.vbat_adc_offset = BQ25980_ADC_VBAT_OFFSET_uV,
+
+		.ibat_adc_step = BQ25980_ADC_IBAT_STEP_uA,
+		.ibat_adc_offset = BQ25980_ADC_IBAT_OFFSET_uA,
 	},
 
 	[BQ25975] = {
@@ -1015,6 +1068,10 @@ static const struct bq25980_chip_info bq25980_chip_info_tbl[] = {
 		.busocp_sc_max = BQ25975_BUSOCP_SC_MAX_uA,
 		.busocp_byp_min = BQ25980_BUSOCP_MIN_uA,
 		.busocp_byp_max = BQ25975_BUSOCP_BYP_MAX_uA,
+		.busocp_sc_step = BQ25980_BUSOCP_STEP_uA,
+		.busocp_byp_step = BQ25980_BUSOCP_STEP_uA,
+		.busocp_sc_offset = BQ25980_BUSOCP_OFFSET_uA,
+		.busocp_byp_offset = BQ25980_BUSOCP_OFFSET_uA,
 
 		.busovp_sc_def = BQ25975_BUSOVP_DFLT_uV,
 		.busovp_byp_def = BQ25975_BUSOVP_BYPASS_DFLT_uV,
@@ -1035,6 +1092,20 @@ static const struct bq25980_chip_info bq25980_chip_info_tbl[] = {
 
 		.batocp_def = BQ25980_BATOCP_DFLT_uA,
 		.batocp_max = BQ25980_BATOCP_MAX_uA,
+		.batocp_min = BQ25980_BATOCP_MIN_uA,
+		.batocp_step = BQ25980_BATOCP_STEP_uA,
+
+		.vbus_adc_step = BQ25975_ADC_VBUS_STEP_uV,
+		.vbus_adc_offset = BQ25975_ADC_VBUS_OFFSET_uV,
+
+		.ibus_adc_step = BQ25975_ADC_IBUS_STEP_uA,
+		.ibus_adc_offset = BQ25975_ADC_IBUS_OFFSET_uA,
+
+		.vbat_adc_step = BQ25975_ADC_VBAT_STEP_uV,
+		.vbat_adc_offset = BQ25975_ADC_VBAT_OFFSET_uV,
+
+		.ibat_adc_step = BQ25975_ADC_IBAT_STEP_uA,
+		.ibat_adc_offset = BQ25975_ADC_IBAT_OFFSET_uA,
 	},
 
 	[BQ25960] = {
@@ -1042,10 +1113,14 @@ static const struct bq25980_chip_info bq25980_chip_info_tbl[] = {
 		.regmap_config = &bq25960_regmap_config,
 
 		.busocp_def = BQ25960_BUSOCP_DFLT_uA,
-		.busocp_sc_min = BQ25960_BUSOCP_SC_MAX_uA,
+		.busocp_sc_min = BQ25960_BUSOCP_SC_MIN_uA,
 		.busocp_sc_max = BQ25960_BUSOCP_SC_MAX_uA,
-		.busocp_byp_min = BQ25960_BUSOCP_SC_MAX_uA,
+		.busocp_byp_min = BQ25960_BUSOCP_BYP_MIN_uA,
 		.busocp_byp_max = BQ25960_BUSOCP_BYP_MAX_uA,
+		.busocp_sc_step = BQ25960_BUSOCP_SC_STEP_uA,
+		.busocp_byp_step = BQ25960_BUSOCP_BYP_STEP_uA,
+		.busocp_sc_offset = BQ25960_BUSOCP_SC_OFFSET_uA,
+		.busocp_byp_offset = BQ25960_BUSOCP_BYP_OFFSET_uA,
 
 		.busovp_sc_def = BQ25975_BUSOVP_DFLT_uV,
 		.busovp_byp_def = BQ25975_BUSOVP_BYPASS_DFLT_uV,
@@ -1066,6 +1141,20 @@ static const struct bq25980_chip_info bq25980_chip_info_tbl[] = {
 
 		.batocp_def = BQ25960_BATOCP_DFLT_uA,
 		.batocp_max = BQ25960_BATOCP_MAX_uA,
+		.batocp_min = BQ25960_BATOCP_MIN_uA,
+		.batocp_step = BQ25960_BATOCP_STEP_uA,
+
+		.vbus_adc_step = BQ25960_ADC_VBUS_STEP_uV,
+		.vbus_adc_offset = BQ25960_ADC_VBUS_OFFSET_uV,
+
+		.ibus_adc_step = BQ25960_ADC_IBUS_STEP_uA,
+		.ibus_adc_offset = BQ25960_ADC_IBUS_OFFSET_uA,
+
+		.vbat_adc_step = BQ25960_ADC_VBAT_STEP_uV,
+		.vbat_adc_offset = BQ25960_ADC_VBAT_OFFSET_uV,
+
+		.ibat_adc_step = BQ25960_ADC_IBAT_STEP_uA,
+		.ibat_adc_offset = BQ25960_ADC_IBAT_OFFSET_uA,
 	},
 };
 
diff --git a/drivers/power/supply/bq25980_charger.h b/drivers/power/supply/bq25980_charger.h
index 39f94eba5f6c..7394bd9d7263 100644
--- a/drivers/power/supply/bq25980_charger.h
+++ b/drivers/power/supply/bq25980_charger.h
@@ -66,22 +66,29 @@
 #define BQ25980_DEGLITCH_TIME		0x39
 #define BQ25980_CHRGR_CTRL_6	0x3A
 
-#define BQ25980_BUSOCP_STEP_uA		250000
-#define BQ25980_BUSOCP_OFFSET_uA	1000000
+#define BQ25980_BUSOCP_STEP_uA		262500
+#define BQ25980_BUSOCP_OFFSET_uA	1050000
 
-#define BQ25980_BUSOCP_DFLT_uA		4250000
-#define BQ25975_BUSOCP_DFLT_uA		4250000
+#define BQ25960_BUSOCP_SC_STEP_uA	254375
+#define BQ25960_BUSOCP_SC_OFFSET_uA	1017500
+#define BQ25960_BUSOCP_BYP_STEP_uA	261875
+#define BQ25960_BUSOCP_BYP_OFFSET_uA	1047500
+
+#define BQ25980_BUSOCP_DFLT_uA		4462500
+#define BQ25975_BUSOCP_DFLT_uA		4462500
 #define BQ25960_BUSOCP_DFLT_uA		3250000
 
-#define BQ25980_BUSOCP_MIN_uA		1000000
+#define BQ25980_BUSOCP_MIN_uA		1050000
+#define BQ25960_BUSOCP_SC_MIN_uA	1017500
+#define BQ25960_BUSOCP_BYP_MIN_uA	1047500
 
-#define BQ25980_BUSOCP_SC_MAX_uA	5750000
-#define BQ25975_BUSOCP_SC_MAX_uA	5750000
-#define BQ25960_BUSOCP_SC_MAX_uA	3750000
+#define BQ25980_BUSOCP_SC_MAX_uA	6037500
+#define BQ25975_BUSOCP_SC_MAX_uA	6037500
+#define BQ25960_BUSOCP_SC_MAX_uA	4578750
 
-#define BQ25980_BUSOCP_BYP_MAX_uA	8500000
-#define BQ25975_BUSOCP_BYP_MAX_uA	8500000
-#define BQ25960_BUSOCP_BYP_MAX_uA	5750000
+#define BQ25980_BUSOCP_BYP_MAX_uA	8925000
+#define BQ25975_BUSOCP_BYP_MAX_uA	8925000
+#define BQ25960_BUSOCP_BYP_MAX_uA	6808750
 
 #define BQ25980_BUSOVP_SC_STEP_uV	100000
 #define BQ25975_BUSOVP_SC_STEP_uV	50000
@@ -120,11 +127,11 @@
 
 #define BQ25980_BATOVP_STEP_uV		20000
 #define BQ25975_BATOVP_STEP_uV		10000
-#define BQ25960_BATOVP_STEP_uV		10000
+#define BQ25960_BATOVP_STEP_uV		9985
 
 #define BQ25980_BATOVP_OFFSET_uV	7000000
 #define BQ25975_BATOVP_OFFSET_uV	3500000
-#define BQ25960_BATOVP_OFFSET_uV	3500000
+#define BQ25960_BATOVP_OFFSET_uV	3491000
 
 #define BQ25980_BATOVP_DFLT_uV		14000000
 #define BQ25975_BATOVP_DFLT_uV		8900000
@@ -132,24 +139,26 @@
 
 #define BQ25980_BATOVP_MIN_uV		7000000
 #define BQ25975_BATOVP_MIN_uV		3500000
-#define BQ25960_BATOVP_MIN_uV		3500000
+#define BQ25960_BATOVP_MIN_uV		3491000
 
 #define BQ25980_BATOVP_MAX_uV		9540000
 #define BQ25975_BATOVP_MAX_uV		4770000
-#define BQ25960_BATOVP_MAX_uV		4770000
+#define BQ25960_BATOVP_MAX_uV		4759000
 
 #define BQ25980_BATOCP_STEP_uA		100000
+#define BQ25960_BATOCP_STEP_uA		102500
 
 #define BQ25980_BATOCP_MASK		GENMASK(6, 0)
 
 #define BQ25980_BATOCP_DFLT_uA		8100000
-#define BQ25960_BATOCP_DFLT_uA		6100000
+#define BQ25960_BATOCP_DFLT_uA		7277500
 
 #define BQ25980_BATOCP_MIN_uA		2000000
+#define BQ25960_BATOCP_MIN_uA		2050000
 
 #define BQ25980_BATOCP_MAX_uA		11000000
 #define BQ25975_BATOCP_MAX_uA		11000000
-#define BQ25960_BATOCP_MAX_uA		7000000
+#define BQ25960_BATOCP_MAX_uA		8712500
 
 #define BQ25980_ENABLE_HIZ		0xff
 #define BQ25980_DISABLE_HIZ		0x0
@@ -165,10 +174,40 @@
 #define BQ25980_EN_HIZ			BIT(6)
 #define BQ25980_ADC_EN			BIT(7)
 
-#define BQ25980_ADC_VOLT_STEP_uV        1000
-#define BQ25980_ADC_CURR_STEP_uA        1000
 #define BQ25980_ADC_POLARITY_BIT	BIT(7)
 
+#define BQ25980_ADC_IBUS_STEP_uA	1070
+#define BQ25980_ADC_IBUS_OFFSET_uA	0
+#define BQ25980_ADC_VBUS_STEP_uV	1007
+#define BQ25980_ADC_VBUS_OFFSET_uV	-60000
+
+#define BQ25980_ADC_IBAT_STEP_uA	1000
+#define BQ25980_ADC_IBAT_OFFSET_uA	0
+#define BQ25980_ADC_VBAT_STEP_uV	1006
+#define BQ25980_ADC_VBAT_OFFSET_uV	0
+
+#define BQ25975_ADC_IBUS_STEP_uA	1070
+#define BQ25975_ADC_IBUS_OFFSET_uA	0
+#define BQ25975_ADC_VBUS_STEP_uV	1003
+#define BQ25975_ADC_VBUS_OFFSET_uV	-40000
+
+#define BQ25975_ADC_IBAT_STEP_uA	1000
+#define BQ25975_ADC_IBAT_OFFSET_uA	12000
+#define BQ25975_ADC_VBAT_STEP_uV	1001
+#define BQ25975_ADC_VBAT_OFFSET_uV	10000
+
+#define BQ25960_ADC_IBUS_STEP_uA	1000
+#define BQ25960_ADC_IBUS_OFFSET_uA	65000
+#define BQ25960_ADC_VBUS_STEP_uV	1002
+#define BQ25960_ADC_VBUS_OFFSET_uV	0
+
+#define BQ25960_ADC_IBAT_STEP_uA	999
+#define BQ25960_ADC_IBAT_OFFSET_uA	-150
+#define BQ25960_ADC_IBAT_MIN_CODE	0x96
+#define BQ25960_ADC_IBAT_MAX_CODE	0x2ee0
+#define BQ25960_ADC_VBAT_STEP_uV	1017
+#define BQ25960_ADC_VBAT_OFFSET_uV	1000
+
 #define BQ25980_WATCHDOG_MASK	GENMASK(4, 3)
 #define BQ25980_WATCHDOG_DIS	BIT(2)
 #define BQ25980_WATCHDOG_MAX	300000
-- 
2.30.0

