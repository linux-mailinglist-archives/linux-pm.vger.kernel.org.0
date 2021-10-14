Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51C42D663
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJNJsp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 05:48:45 -0400
Received: from comms.puri.sm ([159.203.221.185]:42902 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhJNJso (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 05:48:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id EACDDE11E8;
        Thu, 14 Oct 2021 02:46:09 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6EcBzhtxUJVG; Thu, 14 Oct 2021 02:46:09 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     kernel@puri.sm, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] power: bq25890: add return values to error messages
Date:   Thu, 14 Oct 2021 11:45:33 +0200
Message-Id: <20211014094533.4169157-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add more details to the error messages that indicate what went wrong
and use dev_err_probe() at a few places in the probe() path in order
to avoid error messages for deferred probe after which the driver probes
correctly.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/power/supply/bq25890_charger.c | 34 ++++++++++++--------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 0e23d2db0fc4..ec81653e58c0 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -979,13 +979,13 @@ static int bq25890_get_chip_version(struct bq25890_device *bq)
 
 	id = bq25890_field_read(bq, F_PN);
 	if (id < 0) {
-		dev_err(bq->dev, "Cannot read chip ID.\n");
+		dev_err(bq->dev, "Cannot read chip ID: %d\n", id);
 		return id;
 	}
 
 	rev = bq25890_field_read(bq, F_DEV_REV);
 	if (rev < 0) {
-		dev_err(bq->dev, "Cannot read chip revision.\n");
+		dev_err(bq->dev, "Cannot read chip revision: %d\n", rev);
 		return rev;
 	}
 
@@ -1028,10 +1028,9 @@ static int bq25890_irq_probe(struct bq25890_device *bq)
 	struct gpio_desc *irq;
 
 	irq = devm_gpiod_get(bq->dev, BQ25890_IRQ_PIN, GPIOD_IN);
-	if (IS_ERR(irq)) {
-		dev_err(bq->dev, "Could not probe irq pin.\n");
-		return PTR_ERR(irq);
-	}
+	if (IS_ERR(irq))
+		return dev_err_probe(bq->dev, PTR_ERR(irq),
+				     "Could not probe irq pin.\n");
 
 	return gpiod_to_irq(irq);
 }
@@ -1153,34 +1152,33 @@ static int bq25890_probe(struct i2c_client *client,
 	mutex_init(&bq->lock);
 
 	bq->rmap = devm_regmap_init_i2c(client, &bq25890_regmap_config);
-	if (IS_ERR(bq->rmap)) {
-		dev_err(dev, "failed to allocate register map\n");
-		return PTR_ERR(bq->rmap);
-	}
+	if (IS_ERR(bq->rmap))
+		return dev_err_probe(dev, PTR_ERR(bq->rmap),
+				     "failed to allocate register map\n");
 
 	for (i = 0; i < ARRAY_SIZE(bq25890_reg_fields); i++) {
 		const struct reg_field *reg_fields = bq25890_reg_fields;
 
 		bq->rmap_fields[i] = devm_regmap_field_alloc(dev, bq->rmap,
 							     reg_fields[i]);
-		if (IS_ERR(bq->rmap_fields[i])) {
-			dev_err(dev, "cannot allocate regmap field\n");
-			return PTR_ERR(bq->rmap_fields[i]);
-		}
+		if (IS_ERR(bq->rmap_fields[i]))
+			return dev_err_probe(dev, PTR_ERR(bq->rmap_fields[i]),
+					     "cannot allocate regmap field\n");
 	}
 
 	i2c_set_clientdata(client, bq);
 
 	ret = bq25890_get_chip_version(bq);
 	if (ret) {
-		dev_err(dev, "Cannot read chip ID or unknown chip.\n");
+		dev_err(dev, "Cannot read chip ID or unknown chip: %d\n", ret);
 		return ret;
 	}
 
 	if (!dev->platform_data) {
 		ret = bq25890_fw_probe(bq);
 		if (ret < 0) {
-			dev_err(dev, "Cannot read device properties.\n");
+			dev_err(dev, "Cannot read device properties: %d\n",
+				ret);
 			return ret;
 		}
 	} else {
@@ -1189,7 +1187,7 @@ static int bq25890_probe(struct i2c_client *client,
 
 	ret = bq25890_hw_init(bq);
 	if (ret < 0) {
-		dev_err(dev, "Cannot initialize the chip.\n");
+		dev_err(dev, "Cannot initialize the chip: %d\n", ret);
 		return ret;
 	}
 
@@ -1225,7 +1223,7 @@ static int bq25890_probe(struct i2c_client *client,
 
 	ret = bq25890_power_supply_init(bq);
 	if (ret < 0) {
-		dev_err(dev, "Failed to register power supply\n");
+		dev_err_probe(dev, ret, "Failed to register power supply.\n");
 		goto irq_fail;
 	}
 
-- 
2.30.2

