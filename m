Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F965274125
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVLqq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 07:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgIVLpf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 07:45:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA9AC0613D5;
        Tue, 22 Sep 2020 04:43:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so16696330wrp.8;
        Tue, 22 Sep 2020 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGGgDc0zw64X8TwEtKAZByA+ztkHxVMcszbd5ooLrjg=;
        b=pCLsXh0VUjRRgzgjJWSD/of4QoW4h99ncz4DT3pAG3ijebmQaUYgUl8Xk1K5fVzEan
         c3XXRrm1Y1tFTD2LDpx9OEmpFN2JcKm0N/fFjcWpnPoSJfdC56lLN0xNDSyK3YInYqiu
         6Ktgwz9svQjKwm6u0c+viMw0Vd0kGMgQy8RFNQ1obpmPerrFllIVzJX1ku3eIGXaV25s
         79xIoHZyS1Qq6dk3bXIPvi2meoe108ACnSGPHkS156TULAOSi60gX1qgsvi3LInppJ1G
         5e1LaSfZE2yeAVzLwMAxrjzHcVfQcJS3dUVwI5SCHd9JLucg2mULFXjo5pf1g8F/QemO
         r08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGGgDc0zw64X8TwEtKAZByA+ztkHxVMcszbd5ooLrjg=;
        b=HuoIicHrDx28WzDWfip8PJW586VtwtdXGJgHAAtTvsD0QiAVUSwJkGvhTODVuEHUsu
         3nnny+g/sV1qfbPas9+elMJTiTtONxvR6gfEFtS+uRPa4TlmVmMtwdQX/eiWTjfIzpbg
         QCQECbEsuW+ZOd0q8A/r/3uSRdfKxpJdZnJW9xIZgI64e+nM57dFLLyVB6nHBSkeYHOj
         R+w3ChTueEpKnRm6BmqtI2VGJwyV9/hnLf8aeG9tYErtTYaFUpqQCKtPbsXIWKzmODRd
         Y41UeILUT1N8IebPFCYcc7rNw7uxta/BfL6vMgSjo97mKPTdmhesK8WhLPkxNCNrcLKe
         MBkQ==
X-Gm-Message-State: AOAM5322oMQmbZmFoMXVwWFr5VnYJnAfwvgt92nqtGwg6Um2w04qPA5L
        McT2cc93X36YuiageanatQ4=
X-Google-Smtp-Source: ABdhPJxvOtvhAYygLTXEEoViRwoEgzFw0G9wWsmoKFVMXYBuAmg//sMcJGnXgeiUMHL2nWcC6Bpv8g==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr4854602wrw.348.1600775018909;
        Tue, 22 Sep 2020 04:43:38 -0700 (PDT)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id t17sm26522049wrx.82.2020.09.22.04.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 04:43:38 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v5 7/7] power: supply: max17040: Support soc alert
Date:   Tue, 22 Sep 2020 14:42:37 +0300
Message-Id: <20200922114237.1803628-8-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922114237.1803628-1-iskren.chernev@gmail.com>
References: <20200922114237.1803628-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

max17048 and max17049 support SOC alerts (interrupts when battery
capacity changes by +/- 1%). At the moment the driver polls for changes
every second. Using the alerts removes the need for polling.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Tested-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/max17040_battery.c | 82 ++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index ae39ca5c6753e..1d7510a59295d 100644
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
@@ -300,11 +319,33 @@ static void max17040_work(struct work_struct *work)
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
@@ -428,6 +469,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
 	enum chip_id chip_id;
+	bool enable_irq = false;
 	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
@@ -479,6 +521,27 @@ static int max17040_probe(struct i2c_client *client,
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
@@ -487,12 +550,6 @@ static int max17040_probe(struct i2c_client *client,
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
 
@@ -503,7 +560,11 @@ static int max17040_suspend(struct device *dev)
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
@@ -519,7 +580,10 @@ static int max17040_resume(struct device *dev)
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
2.28.0

