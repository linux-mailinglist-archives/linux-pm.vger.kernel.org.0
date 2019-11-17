Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC8FFFA29
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2019 15:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfKQOPZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Nov 2019 09:15:25 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.182]:47160 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbfKQOPZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Nov 2019 09:15:25 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 02CE43D69
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2019 08:15:24 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id WLKli0cIM3Qi0WLKliJTgD; Sun, 17 Nov 2019 08:15:24 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rfUlDakKv5yVKMK73mGLsSF6+WI5OQYJrDn/ijazhPA=; b=WYR8x9KniX5zXkOL+mkmRtl2AD
        MLxmE7U5K3JxaVyKefnMW3ftT3VknIEBQcj1w+Uix352RsomNhbTgotINflbs7vu0n/i7ofR7eSUO
        qCX/xVQnGaqZHL8uy6ix9aUxYRr+hn+8Sv3CqCoqAPMZ0+hMApaNK6TgRP6QY85TcIiDAgfBt018X
        6PoX6xFJ82QQEPv5zZ5tsqdTy7502hK0LBix+P4Q7a//jGTV2rsATfX60z/32KoTuOMxQcf3LPyO2
        xzTk/ZOIiu00/CXQHKAUeHD2Jp/zT2+xbXe6isXgWmSZ2IvehCyc5uGMAeFjGisL/2gOuxAcqLI7X
        sblCQzyQ==;
Received: from [186.222.229.111] (port=47408 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iWLKk-001Ad4-Km; Sun, 17 Nov 2019 11:15:23 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v7 4/5] power: supply: max17040: Config alert SOC low level threshold from FDT
Date:   Sun, 17 Nov 2019 11:13:34 -0300
Message-Id: <20191117141335.23404-5-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191117141335.23404-1-matheus@castello.eng.br>
References: <20191117141335.23404-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 186.222.229.111
X-Source-L: No
X-Exim-ID: 1iWLKk-001Ad4-Km
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [186.222.229.111]:47408
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 49
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
 drivers/power/supply/max17040_battery.c | 75 ++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 9909f8cd7b5d..3fc9e1c7b257 100644
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
@@ -192,6 +229,9 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
 	/* send uevent */
 	power_supply_changed(chip->battery);

+	/* reset alert bit */
+	max17040_set_low_soc_alert(client, chip->low_soc_alert);
+
 	return IRQ_HANDLED;
 }

@@ -230,6 +270,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	int ret;

 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -240,6 +281,12 @@ static int max17040_probe(struct i2c_client *client,

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
@@ -256,14 +303,26 @@ static int max17040_probe(struct i2c_client *client,

 	/* check interrupt */
 	if (client->irq) {
-		int ret;
-
-		ret = max17040_enable_alert_irq(chip);
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
-				 "Failed to get IRQ err %d\n", ret);
+				 "Device not compatible for IRQ");
 		}
 	}

--
2.24.0.rc2

