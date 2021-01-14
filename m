Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EDC2F6E4D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 23:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhANWhT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 17:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbhANWhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 17:37:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F2C061575;
        Thu, 14 Jan 2021 14:36:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C91691F4587E
Received: by jupiter.universe (Postfix, from userid 1000)
        id 296C54800BB; Thu, 14 Jan 2021 23:36:35 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH] power: supply: cpcap-battery: constify psy_desc
Date:   Thu, 14 Jan 2021 23:36:17 +0100
Message-Id: <20210114223617.313588-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no dynamic information in cpcap-battery's
power-supply description struct, so let's make it
static const.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
I noticed this while reviewing Tony's patch series.
---
 drivers/power/supply/cpcap-battery.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 86ed41d9627f..6d5bcdb9f45d 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -999,9 +999,19 @@ static const struct of_device_id cpcap_battery_id_table[] = {
 MODULE_DEVICE_TABLE(of, cpcap_battery_id_table);
 #endif
 
+static const struct power_supply_desc cpcap_charger_battery_desc = {
+	.name		= "battery",
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= cpcap_battery_props,
+	.num_properties	= ARRAY_SIZE(cpcap_battery_props),
+	.get_property	= cpcap_battery_get_property,
+	.set_property	= cpcap_battery_set_property,
+	.property_is_writeable = cpcap_battery_property_is_writeable,
+	.external_power_changed = cpcap_battery_external_power_changed,
+};
+
 static int cpcap_battery_probe(struct platform_device *pdev)
 {
-	struct power_supply_desc *psy_desc;
 	struct cpcap_battery_ddata *ddata;
 	const struct of_device_id *match;
 	struct power_supply_config psy_cfg = {};
@@ -1056,23 +1066,11 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	psy_desc = devm_kzalloc(ddata->dev, sizeof(*psy_desc), GFP_KERNEL);
-	if (!psy_desc)
-		return -ENOMEM;
-
-	psy_desc->name = "battery";
-	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
-	psy_desc->properties = cpcap_battery_props;
-	psy_desc->num_properties = ARRAY_SIZE(cpcap_battery_props);
-	psy_desc->get_property = cpcap_battery_get_property;
-	psy_desc->set_property = cpcap_battery_set_property;
-	psy_desc->property_is_writeable = cpcap_battery_property_is_writeable;
-	psy_desc->external_power_changed = cpcap_battery_external_power_changed;
-
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = ddata;
 
-	ddata->psy = devm_power_supply_register(ddata->dev, psy_desc,
+	ddata->psy = devm_power_supply_register(ddata->dev,
+						&cpcap_charger_battery_desc,
 						&psy_cfg);
 	error = PTR_ERR_OR_ZERO(ddata->psy);
 	if (error) {
-- 
2.29.2

