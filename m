Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76E51D1E36
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgEMS4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390405AbgEMS4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A0F5C2A2A5C
Received: by jupiter.universe (Postfix, from userid 1000)
        id 9319A480128; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 16/19] power: supply: sbs-battery: switch from of_property_* to device_property_*
Date:   Wed, 13 May 2020 20:56:12 +0200
Message-Id: <20200513185615.508236-17-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switch from DT specific of_property_* API to generic and more
modern device_property_* API.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 7c6905a486da..73dfe526c867 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/of_device.h>
 #include <linux/power/sbs-battery.h>
 #include <linux/power_supply.h>
@@ -1016,7 +1016,7 @@ static int sbs_probe(struct i2c_client *client,
 	if (!chip)
 		return -ENOMEM;
 
-	chip->flags = (u32)(uintptr_t)of_device_get_match_data(&client->dev);
+	chip->flags = (u32)(uintptr_t)device_get_match_data(&client->dev);
 	chip->client = client;
 	chip->enable_detection = false;
 	psy_cfg.of_node = client->dev.of_node;
@@ -1027,13 +1027,13 @@ static int sbs_probe(struct i2c_client *client,
 	/* use pdata if available, fall back to DT properties,
 	 * or hardcoded defaults if not
 	 */
-	rc = of_property_read_u32(client->dev.of_node, "sbs,i2c-retry-count",
-				  &chip->i2c_retry_count);
+	rc = device_property_read_u32(&client->dev, "sbs,i2c-retry-count",
+				      &chip->i2c_retry_count);
 	if (rc)
 		chip->i2c_retry_count = 0;
 
-	rc = of_property_read_u32(client->dev.of_node, "sbs,poll-retry-count",
-				  &chip->poll_retry_count);
+	rc = device_property_read_u32(&client->dev, "sbs,poll-retry-count",
+				      &chip->poll_retry_count);
 	if (rc)
 		chip->poll_retry_count = 0;
 
@@ -1043,7 +1043,7 @@ static int sbs_probe(struct i2c_client *client,
 	}
 	chip->i2c_retry_count = chip->i2c_retry_count + 1;
 
-	chip->charger_broadcasts = !of_property_read_bool(client->dev.of_node,
+	chip->charger_broadcasts = !device_property_read_bool(&client->dev,
 					"sbs,disable-charger-broadcasts");
 
 	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
-- 
2.26.2

