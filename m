Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773951D1E4F
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390538AbgEMS5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390392AbgEMS4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B762C061A0E;
        Wed, 13 May 2020 11:56:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 51D7C2A28F6
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7D6D4480107; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 09/19] power: supply: sbs-battery: add POWER_SUPPLY_PROP_CURRENT_AVG support
Date:   Wed, 13 May 2020 20:56:05 +0200
Message-Id: <20200513185615.508236-10-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Expose averaged current information, which is part of the SBS
standard and should be supported by all batteries.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index ab774d491269..611a11385496 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -25,7 +25,8 @@ enum {
 	REG_MANUFACTURER_DATA,
 	REG_TEMPERATURE,
 	REG_VOLTAGE,
-	REG_CURRENT,
+	REG_CURRENT_NOW,
+	REG_CURRENT_AVG,
 	REG_MAX_ERR,
 	REG_CAPACITY,
 	REG_TIME_TO_EMPTY,
@@ -92,8 +93,10 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_TEMP, 0x08, 0, 65535),
 	[REG_VOLTAGE] =
 		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_NOW, 0x09, 0, 20000),
-	[REG_CURRENT] =
+	[REG_CURRENT_NOW] =
 		SBS_DATA(POWER_SUPPLY_PROP_CURRENT_NOW, 0x0A, -32768, 32767),
+	[REG_CURRENT_AVG] =
+		SBS_DATA(POWER_SUPPLY_PROP_CURRENT_AVG, 0x0B, -32768, 32767),
 	[REG_MAX_ERR] =
 		SBS_DATA(POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN, 0x0c, 0, 100),
 	[REG_CAPACITY] =
@@ -142,6 +145,7 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN,
 	POWER_SUPPLY_PROP_TEMP,
@@ -324,7 +328,7 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
 {
 	int ret;
 
-	ret = sbs_read_word_data(client, sbs_data[REG_CURRENT].addr);
+	ret = sbs_read_word_data(client, sbs_data[REG_CURRENT_NOW].addr);
 	if (ret < 0)
 		return ret;
 
@@ -521,6 +525,7 @@ static void  sbs_unit_adjustment(struct i2c_client *client,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
@@ -699,6 +704,7 @@ static int sbs_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
 	case POWER_SUPPLY_PROP_TEMP:
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
-- 
2.26.2

