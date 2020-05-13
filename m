Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619251D1E31
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbgEMS4g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390393AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED23C061A0F;
        Wed, 13 May 2020 11:56:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 68B3D2A28F8
Received: by jupiter.universe (Postfix, from userid 1000)
        id 80A39480108; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 10/19] power: supply: sbs-battery: Improve POWER_SUPPLY_PROP_TECHNOLOGY support
Date:   Wed, 13 May 2020 20:56:06 +0200
Message-Id: <20200513185615.508236-11-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reads the battery chemistry from the battery chip instead
of incorrectly hardcoding the type to be Li-Ion.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 43 ++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 611a11385496..b697a42d9ccf 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -43,6 +43,7 @@ enum {
 	REG_DESIGN_CAPACITY_CHARGE,
 	REG_DESIGN_VOLTAGE_MIN,
 	REG_DESIGN_VOLTAGE_MAX,
+	REG_CHEMISTRY,
 	REG_MANUFACTURER,
 	REG_MODEL_NAME,
 };
@@ -133,7 +134,9 @@ static const struct chip_data {
 	[REG_MANUFACTURER] =
 		SBS_DATA(POWER_SUPPLY_PROP_MANUFACTURER, 0x20, 0, 65535),
 	[REG_MODEL_NAME] =
-		SBS_DATA(POWER_SUPPLY_PROP_MODEL_NAME, 0x21, 0, 65535)
+		SBS_DATA(POWER_SUPPLY_PROP_MODEL_NAME, 0x21, 0, 65535),
+	[REG_CHEMISTRY] =
+		SBS_DATA(POWER_SUPPLY_PROP_TECHNOLOGY, 0x22, 0, 65535)
 };
 
 static enum power_supply_property sbs_properties[] = {
@@ -185,6 +188,7 @@ struct sbs_info {
 
 static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
 static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
+static char chemistry[I2C_SMBUS_BLOCK_MAX + 1];
 static bool force_load;
 
 static int sbs_update_presence(struct sbs_info *chip, bool is_present)
@@ -636,6 +640,38 @@ static int sbs_get_property_index(struct i2c_client *client,
 	return -EINVAL;
 }
 
+static int sbs_get_chemistry(struct i2c_client *client,
+		union power_supply_propval *val)
+{
+	enum power_supply_property psp = POWER_SUPPLY_PROP_TECHNOLOGY;
+	int ret;
+
+	ret = sbs_get_property_index(client, psp);
+	if (ret < 0)
+		return ret;
+
+	ret = sbs_get_battery_string_property(client, ret, psp,
+					      chemistry);
+	if (ret < 0)
+		return ret;
+
+	if (!strncasecmp(chemistry, "LION", 4))
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+	else if (!strncasecmp(chemistry, "LiP", 3))
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LIPO;
+	else if (!strncasecmp(chemistry, "NiCd", 4))
+		val->intval = POWER_SUPPLY_TECHNOLOGY_NiCd;
+	else if (!strncasecmp(chemistry, "NiMH", 4))
+		val->intval = POWER_SUPPLY_TECHNOLOGY_NiMH;
+	else
+		val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
+
+	if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
+		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
+
+	return 0;
+}
+
 static int sbs_get_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -673,7 +709,10 @@ static int sbs_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
-		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		ret = sbs_get_chemistry(client, val);
+		if (ret < 0)
+			break;
+
 		goto done; /* don't trigger power_supply_changed()! */
 
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
-- 
2.26.2

