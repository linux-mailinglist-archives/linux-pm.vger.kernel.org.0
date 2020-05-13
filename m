Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D761D1E33
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390418AbgEMS4i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390413AbgEMS4h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0BEC061A0C;
        Wed, 13 May 2020 11:56:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9F2C02A27A9
Received: by jupiter.universe (Postfix, from userid 1000)
        id 90659480110; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 15/19] power: supply: sbs-battery: add ability to disable charger broadcasts
Date:   Wed, 13 May 2020 20:56:11 +0200
Message-Id: <20200513185615.508236-16-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

In certain designs, it is possible to add a battery on a populated i2c
bus without an sbs compliant charger. In that case, the battery will
un-necessarily and sometimes un-desirably master the bus trying to write
info in the charger.

It is observed in many occasion that these battery "broadcasts" are even
corrupting other ongoing master to slave communication. I.e. the
multi-master support in the battery is inadequate.

Thankfully, the CHARGER_MODE bit allows designers to disable that SBS
battery behaviour.

This needs to be done once when the battery is first seen on the bus.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
[rebased code]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/sbs_sbs-battery.txt |  2 ++
 drivers/power/supply/sbs-battery.c            | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index fa5a8b516dbf..a5093ccef5c5 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -16,6 +16,7 @@ Optional properties :
    after an external change notification.
  - sbs,battery-detect-gpios : The gpio which signals battery detection and
    a flag specifying its polarity.
+ - sbs,disable-charger-broadcasts: for systems without sbs compliant chargers
 
 Example:
 
@@ -25,4 +26,5 @@ Example:
 		sbs,i2c-retry-count = <2>;
 		sbs,poll-retry-count = <10>;
 		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
+		sbs,disable-charger-broadcasts;
 	}
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index e3c685b2c247..7c6905a486da 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -68,6 +68,7 @@ enum sbs_capacity_mode {
 	CAPACITY_MODE_AMPS = 0,
 	CAPACITY_MODE_WATTS = BATTERY_MODE_CAPACITY_MASK
 };
+#define BATTERY_MODE_CHARGER_MASK	(1<<14)
 
 /* manufacturer access defines */
 #define MANUFACTURER_ACCESS_STATUS	0x0006
@@ -193,6 +194,7 @@ struct sbs_info {
 	bool				is_present;
 	struct gpio_desc		*gpio_detect;
 	bool				enable_detection;
+	bool				charger_broadcasts;
 	int				last_state;
 	int				poll_time;
 	u32				i2c_retry_count;
@@ -207,6 +209,27 @@ static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
 static char chemistry[I2C_SMBUS_BLOCK_MAX + 1];
 static bool force_load;
 
+static int sbs_read_word_data(struct i2c_client *client, u8 address);
+static int sbs_write_word_data(struct i2c_client *client, u8 address, u16 value);
+
+static void sbs_disable_charger_broadcasts(struct sbs_info *chip)
+{
+	int val = sbs_read_word_data(chip->client, BATTERY_MODE_OFFSET);
+	if (val < 0)
+		goto exit;
+
+	val |= BATTERY_MODE_CHARGER_MASK;
+
+	val = sbs_write_word_data(chip->client, BATTERY_MODE_OFFSET, val);
+
+exit:
+	if (val < 0)
+		dev_err(&chip->client->dev,
+			"Failed to disable charger broadcasting: %d\n", val);
+	else
+		dev_dbg(&chip->client->dev, "%s\n", __func__);
+}
+
 static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 {
 	struct i2c_client *client = chip->client;
@@ -260,6 +283,9 @@ static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
 		"enabled" : "disabled");
 
+	if (!chip->is_present && is_present && !chip->charger_broadcasts)
+		sbs_disable_charger_broadcasts(chip);
+
 	chip->is_present = true;
 
 	return 0;
@@ -1017,6 +1043,9 @@ static int sbs_probe(struct i2c_client *client,
 	}
 	chip->i2c_retry_count = chip->i2c_retry_count + 1;
 
+	chip->charger_broadcasts = !of_property_read_bool(client->dev.of_node,
+					"sbs,disable-charger-broadcasts");
+
 	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
 			"sbs,battery-detect", GPIOD_IN);
 	if (IS_ERR(chip->gpio_detect)) {
-- 
2.26.2

