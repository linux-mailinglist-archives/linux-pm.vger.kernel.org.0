Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D645A244084
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHMVer (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHMVek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B83BC061383;
        Thu, 13 Aug 2020 14:34:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s9so3803353lfs.4;
        Thu, 13 Aug 2020 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDN7toTIVhzK3vl2BFEECQNcRaypv+RPJaVRD3dX5gI=;
        b=i3GzF4xqY6Qw00PCzWfmYvuKwpxfBQmFokEKZaQYeHPR3fviAqENSgA1865VOgnT7r
         IRFG2VDTbfeaxJ7Kw0nJHRpTy2n8NQWOo1xZdvHFqPWAvb+WsxQ8aCvvR8duUN4hSEIr
         b9pOPrYaKIOA03SNe9k/durn4dm6K9paSrIkDXQFgcp9GMoHbhHzaid9Oa3S0wsgvadL
         p3pWidPdhzb8c4/VjcuXLtc8j5s2zjajYJnIOGoGfO3QyOvs2n5e5lMPn9jzF+LbTKFO
         FjrGKcDohZ2VT0QL9APKLc1bDPiIpUG+UP/gvVsM31eaAYyoF/GpiTFOO3bT/DQAVlVt
         LBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDN7toTIVhzK3vl2BFEECQNcRaypv+RPJaVRD3dX5gI=;
        b=qdGFvjUheB4SoGm3sUTT6iaQDAvak7aiLR9o3PnB9cjubz/zYXoD0E/MPiOdO9WfKL
         ycejb1b6iRJTzmoLN2UZ3YZVj6RRioG9Yyq+2CuqWuJXsUF9qxzzE/d2rPdo12ppc6nU
         VOLKQKlcP++Vqexox3fMAEiF+8IIixGf4eMkt9ZqeMxDqfWrroeaiwpjVNvSrPKCKa1o
         q/Jbb9Eybup2X02gCxw8r9ur51LfKGeaKtfIX5Mlcuc7Qosp7RzaFYOsFrsyytdUYQ71
         KuCjo6RFEneFdWj94OX+o7zi2vrRA2RdgGQHUgwukwGk+hVpUqLg+Q9XgjnDQbAjJu2H
         E4Rg==
X-Gm-Message-State: AOAM533V/mgaNZ/lXDk2g4LQ4PDFD9vo0UDS8zUdSUIWW/M9+cXalfv1
        O+BoJ81+6sVbupjEX46nblWYZmJa
X-Google-Smtp-Source: ABdhPJzNzH6A0dKJ/Ys8lpiFtSK9o7ZgUVZCtmM4omKFcNMzmqk5X8MkrU6+nD0G2KDp8je0vR7Psw==
X-Received: by 2002:a19:4857:: with SMTP id v84mr3000466lfa.195.1597354477549;
        Thu, 13 Aug 2020 14:34:37 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 06/10] power: supply: smb347-charger: Support SMB345 and SMB358
Date:   Fri, 14 Aug 2020 00:34:05 +0300
Message-Id: <20200813213409.24222-7-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
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
index e87b2434d835..7b1eda3257dd 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -639,12 +639,12 @@ config CHARGER_BQ25890
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
2.27.0

