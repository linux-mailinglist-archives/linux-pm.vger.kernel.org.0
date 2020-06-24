Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03F120781F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404651AbgFXP5M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 11:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404718AbgFXP5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 11:57:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E60C061573;
        Wed, 24 Jun 2020 08:57:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so2758327wrj.13;
        Wed, 24 Jun 2020 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fWqoRxWBCqdBHBS2H2/Nb85DBqENZwJYZ563FQxmmA=;
        b=rUBalvyyjuzbg5xoceVShBhFF0BzgWQFg0AOoc2qHtRNRvowsiWu2pqejfNGvdB8Jx
         PqlgYIvst/jtIVEav/2Prz3BcJM0RS+lWSQL/7VO3UzP/EDXVnxcC/Psp89gK1j2+kRg
         F500TJuLDZ5cPhwEtUA2yOW26s3nYXMcvaNrVCFN9pps60OzDa2NOdIowPfMyx2SFTpj
         v9dN9zXh94YjcZOgYwrRtTJMojpU85Sq6EOnjVZs9l/Vr5UpAQ0TE9O+U9l9F1Krk9gO
         vZnzpn1YJOG9lqEvkXLWMn19OdHhlR7vLHIa/CgCAuv/9JecmxVztty5ZJHQSNMFnkuH
         TL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fWqoRxWBCqdBHBS2H2/Nb85DBqENZwJYZ563FQxmmA=;
        b=oofsVO7uUu+Xy5FvPIapjPoiDJYO183T6a8ieLi86j0++ivTuuLCGjVHlP6ou1nSRA
         NFgCt+15cEfoG6zrjQCQ44ckMCmQSMsvQS1BLQttC2vF++aXFPqgONHTEcDElz6NocnD
         1JoWMH/NiByIxBrIdcOtuiWskc5qIqUypHo/xXs/73BZAY+qj5K4m4HFy7wjZlE8r52h
         ptLyD1EP7Et96avb7xvQC4w9RrA7k7yWHlKX2M9cHuY/+v66DF5mgS8BD6Q5SDAjINgT
         XA/taG+IKzT99afwO1jJym2PhKG0biV8fX3QbhSWqbBbUKxjM5po8jt+WknPFIZIJ+IN
         esVg==
X-Gm-Message-State: AOAM533w4QcbgcCSquNWY2UgZfv1VzwN/VqWPazsVkqtisq/wc5FZRaY
        iJKNyibG7+0uBi7HFsRTR54=
X-Google-Smtp-Source: ABdhPJxD6+qpz0n4qf0xCNR0wrqQdIU/JLb07XUrL0PuZCeycXAeQEX77+AbjTC4v/5AjrgguvFV3Q==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr31143871wrp.82.1593014220595;
        Wed, 24 Jun 2020 08:57:00 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id u186sm8951064wmu.10.2020.06.24.08.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:57:00 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 6/6] power: supply: max17040: Support soc alert
Date:   Wed, 24 Jun 2020 18:56:33 +0300
Message-Id: <20200624155633.3557401-7-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624155633.3557401-1-iskren.chernev@gmail.com>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

max17048 and max17049 support SOC alerts (interrupts when battery
capacity changes by +/- 1%). At the moment the driver polls for changes
every second. Using the alerts removes the need for polling.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/power/supply/max17040_battery.c | 82 ++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 54393f411211e..4425411775f26 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -25,6 +25,7 @@
 #define MAX17040_MODE	0x06
 #define MAX17040_VER	0x08
 #define MAX17040_CONFIG	0x0C
+#define MAX17040_STATUS	0x1A
 #define MAX17040_CMD	0xFE
 
 
@@ -33,7 +34,10 @@
 #define MAX17040_RCOMP_DEFAULT  0x9700
 
 #define MAX17040_ATHD_MASK		0x3f
+#define MAX17040_ALSC_MASK		0x40
 #define MAX17040_ATHD_DEFAULT_POWER_UP	4
+#define MAX17040_STATUS_HD_MASK		0x1000
+#define MAX17040_STATUS_SC_MASK		0x2000
 #define MAX17040_CFG_RCOMP_MASK		0xff00
 
 enum chip_id {
@@ -55,6 +59,7 @@ struct chip_data {
 	u16 vcell_div;
 	u8  has_low_soc_alert;
 	u8  rcomp_bytes;
+	u8  has_soc_alert;
 };
 
 static struct chip_data max17040_family[] = {
@@ -65,6 +70,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 1,
 		.has_low_soc_alert = 0,
 		.rcomp_bytes = 2,
+		.has_soc_alert = 0,
 	},
 	[ID_MAX17041] = {
 		.reset_val = 0x0054,
@@ -73,6 +79,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 1,
 		.has_low_soc_alert = 0,
 		.rcomp_bytes = 2,
+		.has_soc_alert = 0,
 	},
 	[ID_MAX17043] = {
 		.reset_val = 0x0054,
@@ -81,6 +88,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 1,
 		.has_low_soc_alert = 1,
 		.rcomp_bytes = 1,
+		.has_soc_alert = 0,
 	},
 	[ID_MAX17044] = {
 		.reset_val = 0x0054,
@@ -89,6 +97,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 1,
 		.has_low_soc_alert = 1,
 		.rcomp_bytes = 1,
+		.has_soc_alert = 0,
 	},
 	[ID_MAX17048] = {
 		.reset_val = 0x5400,
@@ -97,6 +106,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 8,
 		.has_low_soc_alert = 1,
 		.rcomp_bytes = 1,
+		.has_soc_alert = 1,
 	},
 	[ID_MAX17049] = {
 		.reset_val = 0x5400,
@@ -105,6 +115,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 4,
 		.has_low_soc_alert = 1,
 		.rcomp_bytes = 1,
+		.has_soc_alert = 1,
 	},
 	[ID_MAX17058] = {
 		.reset_val = 0x5400,
@@ -113,6 +124,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 8,
 		.has_low_soc_alert = 1,
 		.rcomp_bytes = 1,
+		.has_soc_alert = 0,
 	},
 	[ID_MAX17059] = {
 		.reset_val = 0x5400,
@@ -121,6 +133,7 @@ static struct chip_data max17040_family[] = {
 		.vcell_div = 4,
 		.has_low_soc_alert = 1,
 		.rcomp_bytes = 1,
+		.has_soc_alert = 0,
 	},
 };
 
@@ -156,6 +169,12 @@ static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 level)
 			MAX17040_ATHD_MASK, level);
 }
 
+static int max17040_set_soc_alert(struct max17040_chip *chip, bool enable)
+{
+	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
+			MAX17040_ALSC_MASK, enable ? MAX17040_ALSC_MASK : 0);
+}
+
 static int max17040_set_rcomp(struct max17040_chip *chip, u16 rcomp)
 {
 	u16 mask = chip->data.rcomp_bytes == 2 ?
@@ -298,11 +317,33 @@ static void max17040_work(struct work_struct *work)
 	max17040_queue_work(chip);
 }
 
+/* Returns true if alert cause was SOC change, not low SOC */
+static bool max17040_handle_soc_alert(struct max17040_chip *chip)
+{
+	bool ret = true;
+	u32 data;
+
+	regmap_read(chip->regmap, MAX17040_STATUS, &data);
+
+	if (data & MAX17040_STATUS_HD_MASK) {
+		// this alert was caused by low soc
+		ret = false;
+	}
+	if (data & MAX17040_STATUS_SC_MASK) {
+		// soc change bit -- deassert to mark as handled
+		regmap_write(chip->regmap, MAX17040_STATUS,
+				data & ~MAX17040_STATUS_SC_MASK);
+	}
+
+	return ret;
+}
+
 static irqreturn_t max17040_thread_handler(int id, void *dev)
 {
 	struct max17040_chip *chip = dev;
 
-	dev_warn(&chip->client->dev, "IRQ: Alert battery low level");
+	if (!(chip->data.has_soc_alert && max17040_handle_soc_alert(chip)))
+		dev_warn(&chip->client->dev, "IRQ: Alert battery low level\n");
 
 	/* read registers */
 	max17040_check_changes(chip);
@@ -384,6 +425,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
 	enum chip_id chip_id;
+	bool enable_irq = false;
 	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
@@ -434,6 +476,27 @@ static int max17040_probe(struct i2c_client *client,
 			return ret;
 		}
 
+		enable_irq = true;
+	}
+
+	if (client->irq && chip->data.has_soc_alert) {
+		ret = max17040_set_soc_alert(chip, 1);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to set SOC alert: err %d\n", ret);
+			return ret;
+		}
+		enable_irq = true;
+	} else {
+		/* soc alerts negate the need for polling */
+		INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
+		ret = devm_add_action(&client->dev, max17040_stop_work, chip);
+		if (ret)
+			return ret;
+		max17040_queue_work(chip);
+	}
+
+	if (enable_irq) {
 		ret = max17040_enable_alert_irq(chip);
 		if (ret) {
 			client->irq = 0;
@@ -442,12 +505,6 @@ static int max17040_probe(struct i2c_client *client,
 		}
 	}
 
-	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
-	ret = devm_add_action(&client->dev, max17040_stop_work, chip);
-	if (ret)
-		return ret;
-	max17040_queue_work(chip);
-
 	return 0;
 }
 
@@ -458,7 +515,11 @@ static int max17040_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
-	cancel_delayed_work(&chip->work);
+	if (client->irq && chip->data.has_soc_alert)
+		// disable soc alert to prevent wakeup
+		max17040_set_soc_alert(chip, 0);
+	else
+		cancel_delayed_work(&chip->work);
 
 	if (client->irq && device_may_wakeup(dev))
 		enable_irq_wake(client->irq);
@@ -474,7 +535,10 @@ static int max17040_resume(struct device *dev)
 	if (client->irq && device_may_wakeup(dev))
 		disable_irq_wake(client->irq);
 
-	max17040_queue_work(chip);
+	if (client->irq && chip->data.has_soc_alert)
+		max17040_set_soc_alert(chip, 1);
+	else
+		max17040_queue_work(chip);
 
 	return 0;
 }
-- 
2.27.0

