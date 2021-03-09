Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C49332DC1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhCISEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:04:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35224 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhCISEQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F18881F457F7
Received: by jupiter.universe (Postfix, from userid 1000)
        id AD4A14800C6; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 1/7] power: supply: sbs-battery: use dev_err_probe
Date:   Tue,  9 Mar 2021 19:04:01 +0100
Message-Id: <20210309180407.650943-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309180407.650943-1-sebastian.reichel@collabora.com>
References: <20210309180407.650943-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce usage of dev_err_probe in probe routine, which
makes the code slightly more readable and removes some
lines of code. It also removes PROBE_DEFER errors being
logged by default, which are common when the battery is
waiting for the charger driver to be registered.

This also cleans up a useless goto and instead returns
directly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-battery.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index b6a538ebb378..4bf92831cb06 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1123,11 +1123,9 @@ static int sbs_probe(struct i2c_client *client)
 
 	chip->gpio_detect = devm_gpiod_get_optional(&client->dev,
 			"sbs,battery-detect", GPIOD_IN);
-	if (IS_ERR(chip->gpio_detect)) {
-		dev_err(&client->dev, "Failed to get gpio: %ld\n",
-			PTR_ERR(chip->gpio_detect));
-		return PTR_ERR(chip->gpio_detect);
-	}
+	if (IS_ERR(chip->gpio_detect))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->gpio_detect),
+				     "Failed to get gpio\n");
 
 	i2c_set_clientdata(client, chip);
 
@@ -1158,31 +1156,23 @@ static int sbs_probe(struct i2c_client *client)
 
 		rc = sbs_get_battery_presence_and_health(
 				client, POWER_SUPPLY_PROP_PRESENT, &val);
-		if (rc < 0 || !val.intval) {
-			dev_err(&client->dev, "Failed to get present status\n");
-			rc = -ENODEV;
-			goto exit_psupply;
-		}
+		if (rc < 0 || !val.intval)
+			return dev_err_probe(&client->dev, -ENODEV,
+					     "Failed to get present status\n");
 	}
 
 	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
 
 	chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc,
 						   &psy_cfg);
-	if (IS_ERR(chip->power_supply)) {
-		dev_err(&client->dev,
-			"%s: Failed to register power supply\n", __func__);
-		rc = PTR_ERR(chip->power_supply);
-		goto exit_psupply;
-	}
+	if (IS_ERR(chip->power_supply))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
+				     "Failed to register power supply\n");
 
 	dev_info(&client->dev,
 		"%s: battery gas gauge device registered\n", client->name);
 
 	return 0;
-
-exit_psupply:
-	return rc;
 }
 
 static int sbs_remove(struct i2c_client *client)
-- 
2.30.1

