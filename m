Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231B21D1E41
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390494AbgEMS5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51916 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390383AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4FD212A28AB
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7AAD6480106; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 08/19] power: supply: sbs-battery: add PEC support
Date:   Wed, 13 May 2020 20:56:04 +0200
Message-Id: <20200513185615.508236-9-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SBS batteries optionally have support for PEC. This enables
PEC handling based on the implemented SBS version as suggested
by the standard. The support for PEC is re-evaluated when the
battery is hotplugged into the system, since there might be
systems supporting batteries from different SBS generations.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 72 ++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index a9a1d28dabbe..ab774d491269 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -46,6 +46,14 @@ enum {
 	REG_MODEL_NAME,
 };
 
+#define REG_ADDR_SPEC_INFO		0x1A
+#define SPEC_INFO_VERSION_MASK		GENMASK(7, 4)
+#define SPEC_INFO_VERSION_SHIFT		4
+
+#define SBS_VERSION_1_0			1
+#define SBS_VERSION_1_1			2
+#define SBS_VERSION_1_1_WITH_PEC	3
+
 /* Battery Mode defines */
 #define BATTERY_MODE_OFFSET		0x03
 #define BATTERY_MODE_CAPACITY_MASK	BIT(15)
@@ -175,6 +183,64 @@ static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
 static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
 static bool force_load;
 
+static int sbs_update_presence(struct sbs_info *chip, bool is_present)
+{
+	struct i2c_client *client = chip->client;
+	int retries = chip->i2c_retry_count;
+	s32 ret = 0;
+	u8 version;
+
+	if (chip->is_present == is_present)
+		return 0;
+
+	if (!is_present) {
+		chip->is_present = false;
+		/* Disable PEC when no device is present */
+		client->flags &= ~I2C_CLIENT_PEC;
+		return 0;
+	}
+
+	/* Check if device supports packet error checking and use it */
+	while (retries > 0) {
+		ret = i2c_smbus_read_word_data(client, REG_ADDR_SPEC_INFO);
+		if (ret >= 0)
+			break;
+
+		/*
+		 * Some batteries trigger the detection pin before the
+		 * I2C bus is properly connected. This works around the
+		 * issue.
+		 */
+		msleep(100);
+
+		retries--;
+	}
+
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to read spec info: %d\n", ret);
+
+		/* fallback to old behaviour */
+		client->flags &= ~I2C_CLIENT_PEC;
+		chip->is_present = true;
+
+		return ret;
+	}
+
+	version = (ret & SPEC_INFO_VERSION_MASK) >> SPEC_INFO_VERSION_SHIFT;
+
+	if (version == SBS_VERSION_1_1_WITH_PEC)
+		client->flags |= I2C_CLIENT_PEC;
+	else
+		client->flags &= ~I2C_CLIENT_PEC;
+
+	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
+		"enabled" : "disabled");
+
+	chip->is_present = true;
+
+	return 0;
+}
+
 static int sbs_read_word_data(struct i2c_client *client, u8 address)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
@@ -579,7 +645,7 @@ static int sbs_get_property(struct power_supply *psy,
 			return ret;
 		if (psp == POWER_SUPPLY_PROP_PRESENT) {
 			val->intval = ret;
-			chip->is_present = val->intval;
+			sbs_update_presence(chip, ret);
 			return 0;
 		}
 		if (ret == 0)
@@ -678,7 +744,7 @@ static int sbs_get_property(struct power_supply *psy,
 
 	if (!chip->gpio_detect &&
 		chip->is_present != (ret >= 0)) {
-		chip->is_present = (ret >= 0);
+		sbs_update_presence(chip, (ret >= 0));
 		power_supply_changed(chip->power_supply);
 	}
 
@@ -709,7 +775,7 @@ static void sbs_supply_changed(struct sbs_info *chip)
 	ret = gpiod_get_value_cansleep(chip->gpio_detect);
 	if (ret < 0)
 		return;
-	chip->is_present = ret;
+	sbs_update_presence(chip, ret);
 	power_supply_changed(battery);
 }
 
-- 
2.26.2

