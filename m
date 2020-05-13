Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AEC1D1E43
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbgEMS5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51936 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390390AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BB82F2A29D3
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8981648010B; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 13/19] power: supply: sbs-battery: add POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED support
Date:   Wed, 13 May 2020 20:56:09 +0200
Message-Id: <20200513185615.508236-14-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for reporting the SBS battery's condition flag
to userspace using the new "Calibration required" health status.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 4fa553d61db2..2a2b926ad75c 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -23,6 +23,7 @@
 
 enum {
 	REG_MANUFACTURER_DATA,
+	REG_BATTERY_MODE,
 	REG_TEMPERATURE,
 	REG_VOLTAGE,
 	REG_CURRENT_NOW,
@@ -94,6 +95,8 @@ static const struct chip_data {
 } sbs_data[] = {
 	[REG_MANUFACTURER_DATA] =
 		SBS_DATA(POWER_SUPPLY_PROP_PRESENT, 0x00, 0, 65535),
+	[REG_BATTERY_MODE] =
+		SBS_DATA(-1, 0x03, 0, 65535),
 	[REG_TEMPERATURE] =
 		SBS_DATA(POWER_SUPPLY_PROP_TEMP, 0x08, 0, 65535),
 	[REG_VOLTAGE] =
@@ -366,6 +369,17 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
 	return 0;
 }
 
+static bool sbs_bat_needs_calibration(struct i2c_client *client)
+{
+	int ret;
+
+	ret = sbs_read_word_data(client, sbs_data[REG_BATTERY_MODE].addr);
+	if (ret < 0)
+		return false;
+
+	return !!(ret & BIT(7));
+}
+
 static int sbs_get_battery_presence_and_health(
 	struct i2c_client *client, enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -385,9 +399,14 @@ static int sbs_get_battery_presence_and_health(
 
 	if (psp == POWER_SUPPLY_PROP_PRESENT)
 		val->intval = 1; /* battery present */
-	else /* POWER_SUPPLY_PROP_HEALTH */
-		/* SBS spec doesn't have a general health command. */
-		val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+	else { /* POWER_SUPPLY_PROP_HEALTH */
+		if (sbs_bat_needs_calibration(client)) {
+			val->intval = POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
+		} else {
+			/* SBS spec doesn't have a general health command. */
+			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+		}
+	}
 
 	return 0;
 }
@@ -441,6 +460,8 @@ static int sbs_get_ti_battery_presence_and_health(
 			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
 		else if (ret == 0x0C)
 			val->intval = POWER_SUPPLY_HEALTH_DEAD;
+		else if (sbs_bat_needs_calibration(client))
+			val->intval = POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
 		else
 			val->intval = POWER_SUPPLY_HEALTH_GOOD;
 	}
-- 
2.26.2

