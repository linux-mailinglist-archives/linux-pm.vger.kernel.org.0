Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7B1F0C13
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFGOpt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgFGOpZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:25 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5332C08C5C3;
        Sun,  7 Jun 2020 07:45:24 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 82so8633536lfh.2;
        Sun, 07 Jun 2020 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0p8Sk1v7EeJDCHft8mVeiI6+sfI1r+oyOxQ4USZEDU=;
        b=ClVNPEnjNB01G7uusxaoL90k7Dm0mOyLbOYWqm7N89Fx8E/xtRUuyC+7Dv/K60nj0W
         nDiMwrN2xG2/d3cJW+U3+xMQdmg9YpI1ikW8FkhxyoU8lsIU/ki1arzjB/iiY3+/bBi/
         R8q4XUO0QfSWL1ld+Fm+O0pKxIxRTSd97ZFKYAI5u+EzFl5KpRO0bMWzHmSdDNcl6a6W
         /MghdryGpY1Il+5H6zgpMk/OnximLVxItuW10MhnzutcNEK3A2rnYTx90jmbz6eGPkoN
         LHqbkM71kH7RN16wgp+uIKxiwXLSEUK+imXfnXYLqeLoGUQGEqHsbx8bwy34IwzDWweV
         oCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0p8Sk1v7EeJDCHft8mVeiI6+sfI1r+oyOxQ4USZEDU=;
        b=hf3kAxn6dYh/SomgjuoEV42/vZic8EWQw18elkK5pEDvFYNF/srn02wlC5LX3DMgeZ
         6YxelzJoYXlBQn+EddIMWeq3F8sSL/5Xxr1QG9xi0UeQNgtouurXGSNNxYnZkf9nCFab
         YQbWQ2pQUB+N36ZFIbAE8bCGPFfsUolTl7hc5XZ8hp16LabndEAHrVxGrXfnqfY2g/ME
         2DKzXv++70vo6Mq5yxltdAMfP43Qc/RUVK/7A+bR3+OnK7RV3B4GbgnX61d59FUmMXOk
         wplKj8E3YL8onR49K4U8p/jm1Xx5d1upgpDpL2nZYjTA2c0zEQ8yp5eyAPTB0lz38kKa
         UIcw==
X-Gm-Message-State: AOAM532tjC+TYAVkLI/xDYTpozwdSDwIjE6fRMmVasphnfxlMU/W6Ivy
        aktHIWh1pXaHBbmccTIB7j4=
X-Google-Smtp-Source: ABdhPJz2AOTaQs6OuXZwcYaQpx+OJfiI7T7A5lltH12OTjjUlG/SfqAcAKIw+LXtYhz5rPtZYmeMdQ==
X-Received: by 2002:a05:6512:691:: with SMTP id t17mr10571189lfe.85.1591541123197;
        Sun, 07 Jun 2020 07:45:23 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 6/9] power: supply: smb347-charger: Support SMB345 and SMB358
Date:   Sun,  7 Jun 2020 17:41:10 +0300
Message-Id: <20200607144113.10202-7-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

SMB345 tested on Nexus 7 2013.

Based on:
- https://patchwork.kernel.org/patch/4922431/
- https://patchwork.ozlabs.org/patch/666877/

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/Kconfig          |   6 +-
 drivers/power/supply/smb347-charger.c | 109 ++++++++++++++------------
 2 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 5dde0e2de232..3ace33b116a8 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -626,12 +626,12 @@ config CHARGER_BQ25890
 	  Say Y to enable support for the TI BQ25890 battery charger.
 
 config CHARGER_SMB347
-	tristate "Summit Microelectronics SMB347 Battery Charger"
+	tristate "Summit Microelectronics SMB3XX Battery Charger"
 	depends on I2C
 	select REGMAP_I2C
 	help
-	  Say Y to include support for Summit Microelectronics SMB347
-	  Battery Charger.
+	  Say Y to include support for Summit Microelectronics SMB345,
+	  SMB347 or SMB358 Battery Charger.
 
 config CHARGER_TPS65090
 	tristate "TPS65090 battery charger driver"
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index da2c337107bf..90a87e0624a6 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -128,6 +128,7 @@
  * @mains: power_supply instance for AC/DC power
  * @usb: power_supply instance for USB power
  * @battery: power_supply instance for battery
+ * @id: SMB charger ID
  * @mains_online: is AC/DC input connected
  * @usb_online: is USB input connected
  * @charging_enabled: is charging enabled
@@ -140,64 +141,61 @@ struct smb347_charger {
 	struct power_supply	*mains;
 	struct power_supply	*usb;
 	struct power_supply	*battery;
+	unsigned int		id;
 	bool			mains_online;
 	bool			usb_online;
 	bool			charging_enabled;
 	const struct smb347_charger_platform_data *pdata;
 };
 
-/* Fast charge current in uA */
-static const unsigned int fcc_tbl[] = {
-	700000,
-	900000,
-	1200000,
-	1500000,
-	1800000,
-	2000000,
-	2200000,
-	2500000,
+enum smb_charger_chipid {
+	SMB345,
+	SMB347,
+	SMB358,
+	NUM_CHIP_TYPES,
 };
 
+/* Fast charge current in uA */
+static const unsigned int fcc_tbl[NUM_CHIP_TYPES][8] = {
+	[SMB345] = {  200000,  450000,  600000,  900000,
+		     1300000, 1500000, 1800000, 2000000 },
+	[SMB347] = {  700000,  900000, 1200000, 1500000,
+		     1800000, 2000000, 2200000, 2500000 },
+	[SMB358] = {  200000,  450000,  600000,  900000,
+		     1300000, 1500000, 1800000, 2000000 },
+};
 /* Pre-charge current in uA */
-static const unsigned int pcc_tbl[] = {
-	100000,
-	150000,
-	200000,
-	250000,
+static const unsigned int pcc_tbl[NUM_CHIP_TYPES][4] = {
+	[SMB345] = { 150000, 250000, 350000, 450000 },
+	[SMB347] = { 100000, 150000, 200000, 250000 },
+	[SMB358] = { 150000, 250000, 350000, 450000 },
 };
 
 /* Termination current in uA */
-static const unsigned int tc_tbl[] = {
-	37500,
-	50000,
-	100000,
-	150000,
-	200000,
-	250000,
-	500000,
-	600000,
+static const unsigned int tc_tbl[NUM_CHIP_TYPES][8] = {
+	[SMB345] = {  30000,  40000,  60000,  80000,
+		     100000, 125000, 150000, 200000 },
+	[SMB347] = {  37500,  50000, 100000, 150000,
+		     200000, 250000, 500000, 600000 },
+	[SMB358] = {  30000,  40000,  60000,  80000,
+		     100000, 125000, 150000, 200000 },
 };
 
 /* Input current limit in uA */
-static const unsigned int icl_tbl[] = {
-	300000,
-	500000,
-	700000,
-	900000,
-	1200000,
-	1500000,
-	1800000,
-	2000000,
-	2200000,
-	2500000,
+static const unsigned int icl_tbl[NUM_CHIP_TYPES][10] = {
+	[SMB345] = {  300000,  500000,  700000, 1000000, 1500000,
+		     1800000, 2000000, 2000000, 2000000, 2000000 },
+	[SMB347] = {  300000,  500000,  700000,  900000, 1200000,
+		     1500000, 1800000, 2000000, 2200000, 2500000 },
+	[SMB358] = {  300000,  500000,  700000, 1000000, 1500000,
+		     1800000, 2000000, 2000000, 2000000, 2000000 },
 };
 
 /* Charge current compensation in uA */
-static const unsigned int ccc_tbl[] = {
-	250000,
-	700000,
-	900000,
-	1200000,
+static const unsigned int ccc_tbl[NUM_CHIP_TYPES][4] = {
+	[SMB345] = {  200000,  450000,  600000,  900000 },
+	[SMB347] = {  250000,  700000,  900000, 1200000 },
+	[SMB358] = {  200000,  450000,  600000,  900000 },
 };
 
 /* Convert register value to current using lookup table */
@@ -352,10 +350,11 @@ static int smb347_start_stop_charging(struct smb347_charger *smb)
 
 static int smb347_set_charge_current(struct smb347_charger *smb)
 {
+	unsigned int id = smb->id;
 	int ret;
 
 	if (smb->pdata->max_charge_current) {
-		ret = current_to_hw(fcc_tbl, ARRAY_SIZE(fcc_tbl),
+		ret = current_to_hw(fcc_tbl[id], ARRAY_SIZE(fcc_tbl[id]),
 				    smb->pdata->max_charge_current);
 		if (ret < 0)
 			return ret;
@@ -368,7 +367,7 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->pre_charge_current) {
-		ret = current_to_hw(pcc_tbl, ARRAY_SIZE(pcc_tbl),
+		ret = current_to_hw(pcc_tbl[id], ARRAY_SIZE(pcc_tbl[id]),
 				    smb->pdata->pre_charge_current);
 		if (ret < 0)
 			return ret;
@@ -381,7 +380,7 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->termination_current) {
-		ret = current_to_hw(tc_tbl, ARRAY_SIZE(tc_tbl),
+		ret = current_to_hw(tc_tbl[id], ARRAY_SIZE(tc_tbl[id]),
 				    smb->pdata->termination_current);
 		if (ret < 0)
 			return ret;
@@ -397,10 +396,11 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 
 static int smb347_set_current_limits(struct smb347_charger *smb)
 {
+	unsigned int id = smb->id;
 	int ret;
 
 	if (smb->pdata->mains_current_limit) {
-		ret = current_to_hw(icl_tbl, ARRAY_SIZE(icl_tbl),
+		ret = current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
 				    smb->pdata->mains_current_limit);
 		if (ret < 0)
 			return ret;
@@ -413,7 +413,7 @@ static int smb347_set_current_limits(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->usb_hc_current_limit) {
-		ret = current_to_hw(icl_tbl, ARRAY_SIZE(icl_tbl),
+		ret = current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
 				    smb->pdata->usb_hc_current_limit);
 		if (ret < 0)
 			return ret;
@@ -463,6 +463,7 @@ static int smb347_set_voltage_limits(struct smb347_charger *smb)
 
 static int smb347_set_temp_limits(struct smb347_charger *smb)
 {
+	unsigned int id = smb->id;
 	bool enable_therm_monitor = false;
 	int ret = 0;
 	int val;
@@ -587,7 +588,7 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->charge_current_compensation) {
-		val = current_to_hw(ccc_tbl, ARRAY_SIZE(ccc_tbl),
+		val = current_to_hw(ccc_tbl[id], ARRAY_SIZE(ccc_tbl[id]),
 				    smb->pdata->charge_current_compensation);
 		if (val < 0)
 			return val;
@@ -883,6 +884,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
  */
 static int get_const_charge_current(struct smb347_charger *smb)
 {
+	unsigned int id = smb->id;
 	int ret, intval;
 	unsigned int v;
 
@@ -898,10 +900,12 @@ static int get_const_charge_current(struct smb347_charger *smb)
 	 * and we can detect which table to use from bit 5.
 	 */
 	if (v & 0x20) {
-		intval = hw_to_current(fcc_tbl, ARRAY_SIZE(fcc_tbl), v & 7);
+		intval = hw_to_current(fcc_tbl[id],
+				       ARRAY_SIZE(fcc_tbl[id]), v & 7);
 	} else {
 		v >>= 3;
-		intval = hw_to_current(pcc_tbl, ARRAY_SIZE(pcc_tbl), v & 7);
+		intval = hw_to_current(pcc_tbl[id],
+				       ARRAY_SIZE(pcc_tbl[id]), v & 7);
 	}
 
 	return intval;
@@ -1349,6 +1353,7 @@ static int smb347_probe(struct i2c_client *client,
 
 	mutex_init(&smb->lock);
 	smb->dev = &client->dev;
+	smb->id = id->driver_data;
 
 	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
 	if (IS_ERR(smb->regmap))
@@ -1413,13 +1418,17 @@ static int smb347_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id smb347_id[] = {
-	{ "smb347", 0 },
-	{ }
+	{ "smb345", SMB345 },
+	{ "smb347", SMB347 },
+	{ "smb358", SMB358 },
+	{ },
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
 static const struct of_device_id smb3xx_of_match[] = {
+	{ .compatible = "summit,smb345" },
 	{ .compatible = "summit,smb347" },
+	{ .compatible = "summit,smb358" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, smb3xx_of_match);
-- 
2.26.0

