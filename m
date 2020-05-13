Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9281D1D1E4D
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbgEMS5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390394AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE64C05BD09;
        Wed, 13 May 2020 11:56:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4D5722A2521
Received: by jupiter.universe (Postfix, from userid 1000)
        id 777C3480105; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 07/19] power: supply: sbs-battery: simplify read_read_string_data
Date:   Wed, 13 May 2020 20:56:03 +0200
Message-Id: <20200513185615.508236-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SBS battery implements SMBus block reads. Currently the
driver "emulates" this by doing an I2C byte read for the
length followed by an I2C block read. The I2C subsystem
actually provides a proper API for doing SMBus block reads,
which can and should be used instead. The current implementation
does not properly handle packet error checking (PEC).

This change requires, that I2C bus drivers support I2C_M_RECV_LEN
or directly provide the SMBus API to access device manufacturer
and model name.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 65 ++++++------------------------
 1 file changed, 12 insertions(+), 53 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 4356fdf25d4a..a9a1d28dabbe 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -202,66 +202,32 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
 				char *values)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
-	s32 ret = 0, block_length = 0;
-	int retries_length, retries_block;
-	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
-
-	retries_length = chip->i2c_retry_count;
-	retries_block = chip->i2c_retry_count;
+	int retries = chip->i2c_retry_count;
+	s32 ret = 0;
 
-	/* Adapter needs to support these two functions */
 	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_I2C_BLOCK)){
+				     I2C_FUNC_SMBUS_READ_BLOCK_DATA)) {
 		return -ENODEV;
 	}
 
-	/* Get the length of block data */
-	while (retries_length > 0) {
-		ret = i2c_smbus_read_byte_data(client, address);
-		if (ret >= 0)
-			break;
-		retries_length--;
-	}
-
-	if (ret < 0) {
-		dev_dbg(&client->dev,
-			"%s: i2c read at address 0x%x failed\n",
-			__func__, address);
-		return ret;
-	}
-
-	/* block_length does not include NULL terminator */
-	block_length = ret;
-	if (block_length > I2C_SMBUS_BLOCK_MAX) {
-		dev_err(&client->dev,
-			"%s: Returned block_length is longer than 0x%x\n",
-			__func__, I2C_SMBUS_BLOCK_MAX);
-		return -EINVAL;
-	}
-
 	/* Get the block data */
-	while (retries_block > 0) {
-		ret = i2c_smbus_read_i2c_block_data(
-				client, address,
-				block_length + 1, block_buffer);
+	while (retries > 0) {
+		ret = i2c_smbus_read_block_data(client, address, values);
 		if (ret >= 0)
 			break;
-		retries_block--;
+		retries--;
 	}
 
 	if (ret < 0) {
-		dev_dbg(&client->dev,
-			"%s: i2c read at address 0x%x failed\n",
-			__func__, address);
+		dev_dbg(&client->dev, "%s: failed to read block 0x%x: %d\n",
+			__func__, address, ret);
 		return ret;
 	}
 
-	/* block_buffer[0] == block_length */
-	memcpy(values, block_buffer + 1, block_length);
-	values[block_length] = '\0';
+	/* add string termination */
+	values[ret] = '\0';
 
-	return ret;
+	return 0;
 }
 
 static int sbs_write_word_data(struct i2c_client *client, u8 address,
@@ -465,14 +431,7 @@ static int sbs_get_battery_property(struct i2c_client *client,
 static int sbs_get_battery_string_property(struct i2c_client *client,
 	int reg_offset, enum power_supply_property psp, char *val)
 {
-	s32 ret;
-
-	ret = sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
-
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
 }
 
 static void  sbs_unit_adjustment(struct i2c_client *client,
-- 
2.26.2

