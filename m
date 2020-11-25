Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A205B2C3845
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 05:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKYEtE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 23:49:04 -0500
Received: from comms.puri.sm ([159.203.221.185]:48258 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgKYEtE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 23:49:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 0BECBE0399;
        Tue, 24 Nov 2020 20:48:34 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W_YMHONlpVnG; Tue, 24 Nov 2020 20:48:33 -0800 (PST)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Subject: [PATCH 4/4] power: max17042_battery: Export charge termination current property
Date:   Wed, 25 Nov 2020 05:48:30 +0100
Message-ID: <3900768.gxICSWkFWK@pliszka>
In-Reply-To: <2264396.HPVdm0XNkV@pliszka>
References: <2264396.HPVdm0XNkV@pliszka>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The value is there, so let's export it.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 26f6f89eb648..79d4b5988360 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -78,6 +78,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
 	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
@@ -414,6 +415,14 @@ static int max17042_get_property(struct power_supply *psy,
 			return -EINVAL;
 		}
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret = regmap_read(map, MAX17042_ICHGTerm, &data);
+		if (ret < 0)
+			return ret;
+
+		data64 = data * 1562500ll;
+		val->intval = div_s64(data64, chip->pdata->r_sns);
+		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 		ret = regmap_read(map, MAX17042_TTE, &data);
 		if (ret < 0)
-- 
2.29.2



