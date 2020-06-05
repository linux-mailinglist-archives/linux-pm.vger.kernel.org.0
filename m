Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187871F0361
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 01:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgFEXGh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 19:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgFEXGh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 19:06:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CFDC08C5C2;
        Fri,  5 Jun 2020 16:06:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5F7F82A17C3
Received: by jupiter.universe (Postfix, from userid 1000)
        id AA463480102; Sat,  6 Jun 2020 01:06:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 2/2] power: supply: sbs-battery: add PEC support
Date:   Sat,  6 Jun 2020 01:06:25 +0200
Message-Id: <20200605230625.192427-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605230625.192427-1-sebastian.reichel@collabora.com>
References: <20200605230625.192427-1-sebastian.reichel@collabora.com>
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
 drivers/power/supply/sbs-battery.c | 64 ++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 74221b9279a9..49c3508a6b79 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -51,6 +51,14 @@ enum {
 	REG_CHARGE_VOLTAGE,
 };
 
+#define REG_ADDR_SPEC_INFO		0x1A
+#define SPEC_INFO_VERSION_MASK		GENMASK(7, 4)
+#define SPEC_INFO_VERSION_SHIFT		4
+
+#define SBS_VERSION_1_0			1
+#define SBS_VERSION_1_1			2
+#define SBS_VERSION_1_1_WITH_PEC	3
+
 #define REG_ADDR_MANUFACTURE_DATE	0x1B
 
 /* Battery Mode defines */
@@ -224,14 +232,57 @@ static void sbs_disable_charger_broadcasts(struct sbs_info *chip)
 
 static int sbs_update_presence(struct sbs_info *chip, bool is_present)
 {
+	struct i2c_client *client = chip->client;
+	int retries = chip->i2c_retry_count;
+	s32 ret = 0;
+	u8 version;
+
 	if (chip->is_present == is_present)
 		return 0;
 
 	if (!is_present) {
 		chip->is_present = false;
+		/* Disable PEC when no device is present */
+		client->flags &= ~I2C_CLIENT_PEC;
 		return 0;
 	}
 
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
 	if (!chip->is_present && is_present && !chip->charger_broadcasts)
 		sbs_disable_charger_broadcasts(chip);
 
@@ -273,7 +324,8 @@ static int sbs_read_string_data_fallback(struct i2c_client *client, u8 address,
 	retries_length = chip->i2c_retry_count;
 	retries_block = chip->i2c_retry_count;
 
-	dev_warn_once(&client->dev, "I2C adapter does not support I2C_FUNC_SMBUS_READ_BLOCK_DATA.\n");
+	dev_warn_once(&client->dev, "I2C adapter does not support I2C_FUNC_SMBUS_READ_BLOCK_DATA.\n"
+				    "Fallback method does not support PEC.\n");
 
 	/* Adapter needs to support these two functions */
 	if (!i2c_check_functionality(client->adapter,
@@ -336,8 +388,14 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address, char *val
 	int retries = chip->i2c_retry_count;
 	int ret = 0;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BLOCK_DATA))
-		return sbs_read_string_data_fallback(client, address, values);
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BLOCK_DATA)) {
+		bool pec = client->flags & I2C_CLIENT_PEC;
+		client->flags &= ~I2C_CLIENT_PEC;
+		ret = sbs_read_string_data_fallback(client, address, values);
+		if (pec)
+			client->flags |= I2C_CLIENT_PEC;
+		return ret;
+	}
 
 	while (retries > 0) {
 		ret = i2c_smbus_read_block_data(client, address, values);
-- 
2.26.2

