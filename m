Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D472C10EC47
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 16:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfLBPZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 10:25:30 -0500
Received: from node.akkea.ca ([192.155.83.177]:57674 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBPZa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 10:25:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id EFCF64E201A;
        Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300329; bh=LqAPQbYVfeKVn7R2gdkEAlFUdhksqtddhTQBsuYeTik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=t5BLnjPaYhNY1EV3VqpeiR3CuSFcvVaBeL+ro/R9mWZTD1VHWg2NSzuld+jYtaNT4
         i5YZ0TXPaKnPB8lInxk9B2UWiTRTCRdW+BJ7BG2lD/q/69TmARCeAuBK07DeuBkV4X
         xgBAnG2AeG+Ol2GomCpP4HqPg0ewMZ8UYtjPYVck=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JVOeqvpIEaO1; Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id 228AA4E2006;
        Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300329; bh=LqAPQbYVfeKVn7R2gdkEAlFUdhksqtddhTQBsuYeTik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=t5BLnjPaYhNY1EV3VqpeiR3CuSFcvVaBeL+ro/R9mWZTD1VHWg2NSzuld+jYtaNT4
         i5YZ0TXPaKnPB8lInxk9B2UWiTRTCRdW+BJ7BG2lD/q/69TmARCeAuBK07DeuBkV4X
         xgBAnG2AeG+Ol2GomCpP4HqPg0ewMZ8UYtjPYVck=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 1/2] power: supply: max17042: add MAX17055 support
Date:   Mon,  2 Dec 2019 08:25:19 -0700
Message-Id: <20191202152520.27558-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202152520.27558-1-angus@akkea.ca>
References: <20191202152520.27558-1-angus@akkea.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The MAX17055 is very similar to the MAX17042 so extend the driver.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/power/supply/max17042_battery.c | 15 ++++++--
 include/linux/power/max17042_battery.h  | 48 ++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 0dfad2cf13fe..cecf6e2d8329 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -282,6 +282,8 @@ static int max17042_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 			ret = regmap_read(map, MAX17042_V_empty, &data);
+		else if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
+			ret = regmap_read(map, MAX17055_V_empty, &data);
 		else
 			ret = regmap_read(map, MAX17047_V_empty, &data);
 		if (ret < 0)
@@ -627,7 +629,8 @@ static void max17042_write_config_regs(struct max17042_chip *chip)
 			config->filter_cfg);
 	regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
 	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047 ||
-			chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)
+			chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050 ||
+			chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
 		regmap_write(map, MAX17047_FullSOCThr,
 						config->full_soc_thresh);
 }
@@ -758,6 +761,8 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 		max17042_override_por(map, MAX17042_V_empty, config->vempty);
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
+		max17042_override_por(map, MAX17055_V_empty, config->vempty);
 	else
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
@@ -765,7 +770,8 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	max17042_override_por(map, MAX17042_FCTC, config->fctc);
 	max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
 	max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
-	if (chip->chip_type) {
+	if (chip->chip_type &&
+	    (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055)) {
 		max17042_override_por(map, MAX17042_EmptyTempCo,
 						config->empty_tempco);
 		max17042_override_por(map, MAX17042_K_empty0,
@@ -929,7 +935,8 @@ max17042_get_default_pdata(struct max17042_chip *chip)
 	if (!pdata)
 		return pdata;
 
-	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17042) {
+	if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17042 &&
+	    chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055) {
 		pdata->init_data = max17047_default_pdata_init_regs;
 		pdata->num_init_data =
 			ARRAY_SIZE(max17047_default_pdata_init_regs);
@@ -1167,6 +1174,7 @@ static const struct of_device_id max17042_dt_match[] = {
 	{ .compatible = "maxim,max17042" },
 	{ .compatible = "maxim,max17047" },
 	{ .compatible = "maxim,max17050" },
+	{ .compatible = "maxim,max17055" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, max17042_dt_match);
@@ -1176,6 +1184,7 @@ static const struct i2c_device_id max17042_id[] = {
 	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
+	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 4badd5322949..d55c746ac56e 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -105,11 +105,56 @@ enum max17042_register {
 
 	MAX17042_OCV		= 0xEE,
 
-	MAX17042_OCVInternal	= 0xFB,
+	MAX17042_OCVInternal	= 0xFB,  /* MAX17055 VFOCV */
 
 	MAX17042_VFSOC		= 0xFF,
 };
 
+enum max17055_register {
+	MAX17055_QRes		= 0x0C,
+	MAX17055_TTF		= 0x20,
+	MAX17055_V_empty	= 0x3A,
+	MAX17055_TIMER		= 0x3E,
+	MAX17055_USER_MEM	= 0x40,
+	MAX17055_RGAIN		= 0x42,
+
+	MAX17055_ConvgCfg	= 0x49,
+	MAX17055_VFRemCap	= 0x4A,
+
+	MAX17055_STATUS2	= 0xB0,
+	MAX17055_POWER		= 0xB1,
+	MAX17055_ID		= 0xB2,
+	MAX17055_AvgPower	= 0xB3,
+	MAX17055_IAlrtTh	= 0xB4,
+	MAX17055_TTFCfg		= 0xB5,
+	MAX17055_CVMixCap	= 0xB6,
+	MAX17055_CVHalfTime	= 0xB7,
+	MAX17055_CGTempCo	= 0xB8,
+	MAX17055_Curve		= 0xB9,
+	MAX17055_HibCfg		= 0xBA,
+	MAX17055_Config2	= 0xBB,
+	MAX17055_VRipple	= 0xBC,
+	MAX17055_RippleCfg	= 0xBD,
+	MAX17055_TimerH		= 0xBE,
+
+	MAX17055_RSense		= 0xD0,
+	MAX17055_ScOcvLim	= 0xD1,
+
+	MAX17055_SOCHold	= 0xD3,
+	MAX17055_MaxPeakPwr	= 0xD4,
+	MAX17055_SusPeakPwr	= 0xD5,
+	MAX17055_PackResistance	= 0xD6,
+	MAX17055_SysResistance	= 0xD7,
+	MAX17055_MinSysV	= 0xD8,
+	MAX17055_MPPCurrent	= 0xD9,
+	MAX17055_SPPCurrent	= 0xDA,
+	MAX17055_ModelCfg	= 0xDB,
+	MAX17055_AtQResidual	= 0xDC,
+	MAX17055_AtTTE		= 0xDD,
+	MAX17055_AtAvSOC	= 0xDE,
+	MAX17055_AtAvCap	= 0xDF,
+};
+
 /* Registers specific to max17047/50 */
 enum max17047_register {
 	MAX17047_QRTbl00	= 0x12,
@@ -125,6 +170,7 @@ enum max170xx_chip_type {
 	MAXIM_DEVICE_TYPE_MAX17042,
 	MAXIM_DEVICE_TYPE_MAX17047,
 	MAXIM_DEVICE_TYPE_MAX17050,
+	MAXIM_DEVICE_TYPE_MAX17055,
 
 	MAXIM_DEVICE_TYPE_NUM
 };
-- 
2.17.1

