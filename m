Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBC1D1E3F
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390397AbgEMS5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51934 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390388AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A65292A25D4
Received: by jupiter.universe (Postfix, from userid 1000)
        id 869D048010A; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 12/19] power: supply: sbs-battery: add MANUFACTURE_DATE support
Date:   Wed, 13 May 2020 20:56:08 +0200
Message-Id: <20200513185615.508236-13-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose the battery's manufacture date to userspace.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index e6f61baa9bed..4fa553d61db2 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -58,6 +58,8 @@ enum {
 #define SBS_VERSION_1_1			2
 #define SBS_VERSION_1_1_WITH_PEC	3
 
+#define REG_ADDR_MANUFACTURE_DATE	0x1B
+
 /* Battery Mode defines */
 #define BATTERY_MODE_OFFSET		0x03
 #define BATTERY_MODE_CAPACITY_MASK	BIT(15)
@@ -171,6 +173,9 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
+	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME
@@ -682,6 +687,38 @@ static int sbs_get_chemistry(struct i2c_client *client,
 	return 0;
 }
 
+static int sbs_get_battery_manufacture_date(struct i2c_client *client,
+	enum power_supply_property psp,
+	union power_supply_propval *val)
+{
+	int ret;
+	u16 day, month, year;
+
+	ret = sbs_read_word_data(client, REG_ADDR_MANUFACTURE_DATE);
+	if (ret < 0)
+		return ret;
+
+	day   = ret   & GENMASK(4,  0);
+	month = (ret  & GENMASK(8,  5)) >> 5;
+	year  = ((ret & GENMASK(15, 9)) >> 9) + 1980;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+		val->intval = year;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURE_MONTH:
+		val->intval = month;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURE_DAY:
+		val->intval = day;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int sbs_get_property(struct power_supply *psy,
 	enum power_supply_property psp,
 	union power_supply_propval *val)
@@ -790,6 +827,12 @@ static int sbs_get_property(struct power_supply *psy,
 		val->strval = manufacturer;
 		break;
 
+	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
+	case POWER_SUPPLY_PROP_MANUFACTURE_MONTH:
+	case POWER_SUPPLY_PROP_MANUFACTURE_DAY:
+		ret = sbs_get_battery_manufacture_date(client, psp, val);
+		break;
+
 	default:
 		dev_err(&client->dev,
 			"%s: INVALID property\n", __func__);
-- 
2.26.2

