Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB64F332DC8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 19:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhCISEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 13:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhCISES (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 13:04:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E556C06175F;
        Tue,  9 Mar 2021 10:04:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F225A1F4580D
Received: by jupiter.universe (Postfix, from userid 1000)
        id B66994800DC; Tue,  9 Mar 2021 19:04:12 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5/7] power: supply: sbs-manager: use dev_err_probe
Date:   Tue,  9 Mar 2021 19:04:05 +0100
Message-Id: <20210309180407.650943-6-sebastian.reichel@collabora.com>
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
logged by default.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/sbs-manager.c | 55 +++++++++---------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index cd2bf0b247fe..bd2af3ef1021 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -294,10 +294,8 @@ static int sbsm_gpio_setup(struct sbsm_data *data)
 	gc->owner = THIS_MODULE;
 
 	ret = devm_gpiochip_add_data(dev, gc, data);
-	if (ret) {
-		dev_err(dev, "devm_gpiochip_add_data failed: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "devm_gpiochip_add_data failed\n");
 
 	return ret;
 }
@@ -349,11 +347,8 @@ static int sbsm_probe(struct i2c_client *client,
 	data->supported_bats = ret & SBSM_MASK_BAT_SUPPORTED;
 	data->muxc = i2c_mux_alloc(adapter, dev, SBSM_MAX_BATS, 0,
 				   I2C_MUX_LOCKED, &sbsm_select, NULL);
-	if (!data->muxc) {
-		dev_err(dev, "failed to alloc i2c mux\n");
-		ret = -ENOMEM;
-		goto err_mux_alloc;
-	}
+	if (!data->muxc)
+		return dev_err_probe(dev, -ENOMEM, "failed to alloc i2c mux\n");
 	data->muxc->priv = data;
 
 	ret = devm_add_action_or_reset(dev, sbsm_del_mux_adapter, data);
@@ -368,45 +363,29 @@ static int sbsm_probe(struct i2c_client *client,
 				break;
 		}
 	}
-	if (ret) {
-		dev_err(dev, "failed to register i2c mux channel %d\n", i + 1);
-		goto err_mux_register;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register i2c mux channel %d\n", i + 1);
 
-	psy_desc = devm_kmemdup(dev, &sbsm_default_psy_desc,
-				sizeof(struct power_supply_desc),
-				GFP_KERNEL);
-	if (!psy_desc) {
-		ret = -ENOMEM;
-		goto err_psy;
-	}
+	psy_desc = devm_kmemdup(dev, &sbsm_default_psy_desc, sizeof(*psy_desc), GFP_KERNEL);
+	if (!psy_desc)
+		return -ENOMEM;
+
+	psy_desc->name = devm_kasprintf(dev, GFP_KERNEL, "sbsm-%s", dev_name(&client->dev));
+	if (!psy_desc->name)
+		return -ENOMEM;
 
-	psy_desc->name = devm_kasprintf(dev, GFP_KERNEL, "sbsm-%s",
-					dev_name(&client->dev));
-	if (!psy_desc->name) {
-		ret = -ENOMEM;
-		goto err_psy;
-	}
 	ret = sbsm_gpio_setup(data);
 	if (ret < 0)
-		goto err_psy;
+		return ret;
 
 	psy_cfg.drv_data = data;
 	psy_cfg.of_node = dev->of_node;
 	data->psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
-	if (IS_ERR(data->psy)) {
-		ret = PTR_ERR(data->psy);
-		dev_err(dev, "failed to register power supply %s\n",
-			psy_desc->name);
-		goto err_psy;
-	}
+	if (IS_ERR(data->psy))
+		return dev_err_probe(dev, PTR_ERR(data->psy),
+				     "failed to register power supply %s\n", psy_desc->name);
 
 	return 0;
-
-err_psy:
-err_mux_register:
-err_mux_alloc:
-	return ret;
 }
 
 static const struct i2c_device_id sbsm_ids[] = {
-- 
2.30.1

