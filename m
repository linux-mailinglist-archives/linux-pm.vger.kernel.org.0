Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9B3196E62
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgC2QWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:22:43 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52582 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgC2QWm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:22:42 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id E4B16249A1;
        Sun, 29 Mar 2020 18:22:38 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 6/9] power: supply: smb347-charger: Support SMB345 and SMB358
Date:   Sun, 29 Mar 2020 18:21:25 +0200
Message-Id: <20200329162128.218584-7-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tested SMB345 on Nexus 7 2013. Works.

Based on:
- https://patchwork.kernel.org/patch/4922431/
- https://patchwork.ozlabs.org/patch/666877/

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/Kconfig          |   6 +-
 drivers/power/supply/smb347-charger.c | 109 ++++++++++++++------------
 2 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f3424fdce341..2581ed8aff5a 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -598,12 +598,12 @@ config CHARGER_BQ25890
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
index 852d2ab566e0..0cbd0743fd91 100644
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
@@ -1317,6 +1321,7 @@ static int smb347_probe(struct i2c_client *client,
 
 	mutex_init(&smb->lock);
 	smb->dev = &client->dev;
+	smb->id = id->driver_data;
 
 	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
 	if (IS_ERR(smb->regmap))
@@ -1391,13 +1396,17 @@ static int smb347_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id smb347_id[] = {
-	{ "smb347", 0 },
-	{ }
+	{ "smb345", SMB345 },
+	{ "smb347", SMB347 },
+	{ "smb358", SMB358 },
+	{}
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
 static const struct of_device_id smb3xx_of_match[] = {
+	{ .compatible = "summit,smb345" },
 	{ .compatible = "summit,smb347" },
+	{ .compatible = "summit,smb358" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, smb3xx_of_match);
-- 
2.25.0

