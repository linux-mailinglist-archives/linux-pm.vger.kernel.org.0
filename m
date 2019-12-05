Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E041143F7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 16:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfLEPp2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 10:45:28 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.108]:22807 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729685AbfLEPp1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 10:45:27 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 0A7D18D4E
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 09:45:25 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id ctJkiQyMF4kpjctJki1Uh5; Thu, 05 Dec 2019 09:45:25 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BN2nEjpg+x00XnYYNUvlHvE6AR/JK9MUUT1AQ93Ybys=; b=jX+io2Rug9tnCDgoUfnwG6LHDx
        n3SwTRyi7qf/3J6uXx8Fdv1iD+fP587k1+NIWORnxNVmzP6qwQ64dAw0xHyOgQX50dOkj/g3flx3B
        sDBQenPFkY1/eKQgfTDxfCcVM5vH6wfHvNSCpwbRlDrGePzwHmXxWW0piYV5i6ez+BI2misDwcCX1
        p2konMeA5PXjfGs+94urVHCEsKywkTdMZmRahnERzjhfSB7NpnDL29I9H25sUCoym47rOQbRjHx1B
        pL5VclkMgpy19m4SIDaACqiqjETRJNXKbwHAKFYcLyh3Oj6AGwefmpqklkjj/UE+6zRNzVhPl7kX3
        N25CUmAA==;
Received: from [191.31.196.215] (port=35544 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1ictJj-001jEH-Vw; Thu, 05 Dec 2019 12:45:24 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v8 4/5] power: supply: max17040: Config alert SOC low level threshold from FDT
Date:   Thu,  5 Dec 2019 12:44:09 -0300
Message-Id: <20191205154410.29462-5-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191205154410.29462-1-matheus@castello.eng.br>
References: <20191205154410.29462-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.215
X-Source-L: No
X-Exim-ID: 1ictJj-001jEH-Vw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.196.215]:35544
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
 drivers/power/supply/max17040_battery.c | 52 ++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 5a8cd365a61e..2a2a1fd8d4eb 100644
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
@@ -161,6 +181,21 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }

+static int max17040_get_of_data(struct max17040_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+
+	chip->low_soc_alert = MAX17040_ATHD_DEFAULT_POWER_UP;
+	device_property_read_u32(dev,
+				 "maxim,alert-low-soc-level",
+				 &chip->low_soc_alert);
+
+	if (chip->low_soc_alert <= 0 || chip->low_soc_alert >= 33)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void max17040_check_changes(struct i2c_client *client)
 {
 	max17040_get_vcell(client);
@@ -192,6 +227,9 @@ static irqreturn_t max17040_thread_handler(int id, void *dev)
 	/* send uevent */
 	power_supply_changed(chip->battery);

+	/* reset alert bit */
+	max17040_set_low_soc_alert(client, chip->low_soc_alert);
+
 	return IRQ_HANDLED;
 }

@@ -230,6 +268,7 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = client->adapter;
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	int ret;

 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -240,6 +279,12 @@ static int max17040_probe(struct i2c_client *client,

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
@@ -257,7 +302,12 @@ static int max17040_probe(struct i2c_client *client,
 	/* check interrupt */
 	if (client->irq && of_device_is_compatible(client->dev.of_node,
 						   "maxim,max77836-battery")) {
-		int ret;
+		ret = max17040_set_low_soc_alert(client, chip->low_soc_alert);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to set low SOC alert: err %d\n", ret);
+			return ret;
+		}

 		ret = max17040_enable_alert_irq(chip);
 		if (ret) {
--
2.24.0.rc2

