Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC65B1D1E59
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbgEMS5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390395AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747AC05BD0A;
        Wed, 13 May 2020 11:56:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8CCAA2A29D1
Received: by jupiter.universe (Postfix, from userid 1000)
        id 844EA480109; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 11/19] power: supply: sbs-battery: add POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT/VOLTAGE_MAX support
Date:   Wed, 13 May 2020 20:56:07 +0200
Message-Id: <20200513185615.508236-12-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose maximum charge current/voltage information requested
by the battery.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index b697a42d9ccf..e6f61baa9bed 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -46,6 +46,8 @@ enum {
 	REG_CHEMISTRY,
 	REG_MANUFACTURER,
 	REG_MODEL_NAME,
+	REG_CHARGE_CURRENT,
+	REG_CHARGE_VOLTAGE,
 };
 
 #define REG_ADDR_SPEC_INFO		0x1A
@@ -114,6 +116,10 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG, 0x12, 0, 65535),
 	[REG_TIME_TO_FULL] =
 		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG, 0x13, 0, 65535),
+	[REG_CHARGE_CURRENT] =
+		SBS_DATA(POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX, 0x14, 0, 65535),
+	[REG_CHARGE_VOLTAGE] =
+		SBS_DATA(POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX, 0x15, 0, 65535),
 	[REG_STATUS] =
 		SBS_DATA(POWER_SUPPLY_PROP_STATUS, 0x16, 0, 65535),
 	[REG_CAPACITY_LEVEL] =
@@ -163,6 +169,8 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME
@@ -531,6 +539,8 @@ static void  sbs_unit_adjustment(struct i2c_client *client,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		val->intval *= BASE_UNIT_CONVERSION;
@@ -749,6 +759,8 @@ static int sbs_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 	case POWER_SUPPLY_PROP_CAPACITY:
 	case POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN:
 		ret = sbs_get_property_index(client, psp);
-- 
2.26.2

