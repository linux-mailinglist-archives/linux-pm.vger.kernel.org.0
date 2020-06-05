Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069AF1F035F
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgFEXGg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 19:06:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41986 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgFEXGg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 19:06:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5F8CF2A5230
Received: by jupiter.universe (Postfix, from userid 1000)
        id A7670480101; Sat,  6 Jun 2020 01:06:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 1/2] power: supply: sbs-battery: use i2c_smbus_read_block_data()
Date:   Sat,  6 Jun 2020 01:06:24 +0200
Message-Id: <20200605230625.192427-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605230625.192427-1-sebastian.reichel@collabora.com>
References: <20200605230625.192427-1-sebastian.reichel@collabora.com>
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

Not all upstream systems using sbs-battery have I2C bus drivers
supporting I2C_M_RECV_LEN, so old implementation is kept as
fallback to keep things working. But this prints a warning,
which hopefully results in people implementing support for it.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 31 ++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 83b9924033bd..74221b9279a9 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -263,8 +263,7 @@ static int sbs_read_word_data(struct i2c_client *client, u8 address)
 	return ret;
 }
 
-static int sbs_read_string_data(struct i2c_client *client, u8 address,
-				char *values)
+static int sbs_read_string_data_fallback(struct i2c_client *client, u8 address, char *values)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
 	s32 ret = 0, block_length = 0;
@@ -274,6 +273,8 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
 	retries_length = chip->i2c_retry_count;
 	retries_block = chip->i2c_retry_count;
 
+	dev_warn_once(&client->dev, "I2C adapter does not support I2C_FUNC_SMBUS_READ_BLOCK_DATA.\n");
+
 	/* Adapter needs to support these two functions */
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE_DATA |
@@ -329,6 +330,32 @@ static int sbs_read_string_data(struct i2c_client *client, u8 address,
 	return ret;
 }
 
+static int sbs_read_string_data(struct i2c_client *client, u8 address, char *values)
+{
+	struct sbs_info *chip = i2c_get_clientdata(client);
+	int retries = chip->i2c_retry_count;
+	int ret = 0;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+		return sbs_read_string_data_fallback(client, address, values);
+
+	while (retries > 0) {
+		ret = i2c_smbus_read_block_data(client, address, values);
+		if (ret >= 0)
+			break;
+		retries--;
+	}
+
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to read block 0x%x: %d\n", address, ret);
+		return ret;
+	}
+
+	/* add string termination */
+	values[ret] = '\0';
+	return ret;
+}
+
 static int sbs_write_word_data(struct i2c_client *client, u8 address,
 	u16 value)
 {
-- 
2.26.2

