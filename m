Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A155FEF54E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 07:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfKEGDF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 01:03:05 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.133]:43350 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730152AbfKEGDE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 01:03:04 -0500
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 01:03:04 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id BBCA1400CC65F
        for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2019 23:42:36 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id RrbwiASWB3Qi0RrbwiW9gJ; Mon, 04 Nov 2019 23:42:36 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lizOfj4n1A6GoFXXwE/W8Ky+XvCip5rrvcCbBwrCoBA=; b=rDqV+kXjbn94eip2zIJ1XvfaTp
        ehdMTbbbBXnapXd3AsL6od4lpkWgZqu2MuUVdiJcI1RZ47Q3IHNu35RvlYL1JE3GuHw+28jKoIEOL
        IiMf1T3/4obcWY3Snaf1N+o9/o27uvlz+d/twDTsVGN4YirucF3vMtt8P8Dt/X/tg1WYTOqxpxj6q
        JwRan1UeoXD/K4BJDKLpFvoDtI/eO+NwXeweEAgYUOb3P46JO1syU/Bg5sjUNQeV5aj4Ta0IOdhJo
        Hqxy92PQwldKD/mPxMB3kxENwb0d/53F6KJrf2nrHRwQywok3J0UmEovADRz+Adm+n3G9UxtmV8rb
        HROocdcA==;
Received: from [191.31.196.28] (port=37450 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iRrbv-002sjK-Ur; Tue, 05 Nov 2019 02:42:36 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v5 4/5] power: supply: max17040: Config alert SOC low level threshold from FDT
Date:   Tue,  5 Nov 2019 02:42:17 -0300
Message-Id: <20191105054218.29826-5-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191105054218.29826-1-matheus@castello.eng.br>
References: <20191105015827.GA332@bogus>
 <20191105054218.29826-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.28
X-Source-L: No
X-Exim-ID: 1iRrbv-002sjK-Ur
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.196.28]:37450
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 62
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For configuration of fuel gauge alert for a low level state of charge
interrupt we add a function to config level threshold and a device tree
binding property to set it in flatned device tree node.

Now we can use "maxim,alert-low-soc-level" property with the values from
1% up to 32% to configure alert interrupt threshold.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 96 +++++++++++++++++++++----
 1 file changed, 82 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 75459f76d02c..c48a691cbd7b 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -29,6 +29,9 @@
 #define MAX17040_DELAY		1000
 #define MAX17040_BATTERY_FULL	95

+#define MAX17040_ATHD_MASK		0xFFC0
+#define MAX17040_ATHD_DEFAULT_POWER_UP	4
+
 struct max17040_chip {
 	struct i2c_client		*client;
 	struct delayed_work		work;
@@ -43,6 +46,8 @@ struct max17040_chip {
 	int soc;
 	/* State Of Charge */
 	int status;
+	/* Low alert threshold from 32% to 1% of the State of Charge */
+	u32 low_soc_alert;
 };

 static int max17040_get_property(struct power_supply *psy,
@@ -99,6 +104,21 @@ static void max17040_reset(struct i2c_client *client)
 	max17040_write_reg(client, MAX17040_CMD, 0x0054);
 }

+static int max17040_set_low_soc_alert(struct i2c_client *client, u32 level)
+{
+	int ret;
+	u16 data;
+
+	level = 32 - level;
+	data = max17040_read_reg(client, MAX17040_RCOMP);
+	/* clear the alrt bit and set LSb 5 bits */
+	data &= MAX17040_ATHD_MASK;
+	data |= level;
+	ret = max17040_write_reg(client, MAX17040_RCOMP, data);
+
+	return ret;
+}
+
 static void max17040_get_vcell(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
@@ -115,7 +135,6 @@ static void max17040_get_soc(struct i2c_client *client)
 	u16 soc;

 	soc = max17040_read_reg(client, MAX17040_SOC);
-
 	chip->soc = (soc >> 8);
 }

@@ -161,6 +180,24 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }

+static int max17040_get_of_data(struct max17040_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct device_node *np = dev->of_node;
+	int ret = 0;
+
+	if (of_property_read_u32(np, "maxim,alert-low-soc-level",
+				 &chip->low_soc_alert)) {
+		chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
+	} else if (chip->low_soc_alert <= 0 ||
+			chip->low_soc_alert >= 33) {
+		/* low_soc_alert is not between 1% and 32% */
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void max17040_check_changes(struct i2c_client *client)
 {
 	max17040_get_vcell(client);
@@ -192,9 +229,27 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
 	/* send uevent */
 	power_supply_changed(chip->battery);

+	/* reset alert bit */
+	max17040_set_low_soc_alert(client, chip->low_soc_alert);
+
 	return IRQ_HANDLED;
 }

+static int max17040_enable_alert_irq(struct max17040_chip *chip)
+{
+	struct i2c_client *client = chip->client;
+	unsigned int flags;
+	int ret;
+
+	dev_info(&client->dev, "IRQ: enabled\n");
+	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					max17040_thread_handler, flags,
+					chip->battery->desc->name, chip);
+
+	return ret;
+}
+
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -216,6 +271,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	int ret;

 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -226,6 +282,12 @@ static int max17040_probe(struct i2c_client *client,

 	chip->client = client;
 	chip->pdata = client->dev.platform_data;
+	ret = max17040_get_of_data(chip);
+	if (ret) {
+		dev_err(&client->dev,
+			"failed: low SOC alert OF data out of bounds\n");
+		return ret;
+	}

 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -242,20 +304,26 @@ static int max17040_probe(struct i2c_client *client,

 	/* check interrupt */
 	if (client->irq) {
-		int ret;
-		unsigned int flags;
-
-		dev_info(&client->dev, "IRQ: enabled\n");
-		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
-		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						max17040_thread_handler, flags,
-						chip->battery->desc->name,
-						chip);
-
-		if (ret) {
-			client->irq = 0;
+		if (of_device_is_compatible(client->dev.of_node,
+					    "maxim,max77836-battery")) {
+			ret = max17040_set_low_soc_alert(client,
+							 chip->low_soc_alert);
+			if (ret) {
+				dev_err(&client->dev,
+					"Failed to set low SOC alert: err %d\n",
+					ret);
+				return ret;
+			}
+
+			ret = max17040_enable_alert_irq(chip);
+			if (ret) {
+				client->irq = 0;
+				dev_warn(&client->dev,
+					 "Failed to get IRQ err %d\n", ret);
+			}
+		} else {
 			dev_warn(&client->dev,
-				"Failed to get IRQ err %d\n", ret);
+				 "Device not compatible for IRQ");
 		}
 	}

--
2.24.0.rc2

