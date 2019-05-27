Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8392AD0B
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfE0Crw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 May 2019 22:47:52 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.119]:11378 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfE0Crw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 May 2019 22:47:52 -0400
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 May 2019 22:47:51 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id CC8CB2D7B7
        for <linux-pm@vger.kernel.org>; Sun, 26 May 2019 21:23:13 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id V5I9hJVfk90onV5I9hN3ZN; Sun, 26 May 2019 21:23:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1wVE5xkruKE7AkDu9vtTUu9rgNnlV7zNF6bQeuJd2IM=; b=zjeEKHFkaz9zbTstnucDBMTt4S
        +OMIPIIlUXW21Cg94mr6SxsLOkd11thsSLDBWiEx0OOFnYFyW6pvEn3fFDrQSBh7uPpHIKGX1XaAb
        enT6ZW00w55p58qyWgzZA3D0UT4OyQG4L9V49gaxZxgseNwfKIMLd8ovOpYcEW7GGrhbbDLcGcStK
        FOOWqIrrdHyrmN/y0Uj3szwSM0G6KH8FrbOs2bcwjHadHa2MIrahZGF15RjHfpOR1YdNXLIGuKIF6
        VvTvcsZemM9E/8jMd5BEbdX6KPNy6C/xnOZdURRj7OCR9qQVV4Q0PmQ/cAsy7CcV+sSI29LcLYKoK
        3GUdfEMw==;
Received: from [177.34.20.96] (port=57660 helo=castello.castello.in)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1hV5I8-003JNX-Po; Sun, 26 May 2019 23:23:13 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v3 3/5] power: supply: max17040: Config alert SOC low level threshold from FDT
Date:   Sun, 26 May 2019 23:22:56 -0300
Message-Id: <20190527022258.32748-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527022258.32748-1-matheus@castello.eng.br>
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 177.34.20.96
X-Source-L: No
X-Exim-ID: 1hV5I8-003JNX-Po
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello.in) [177.34.20.96]:57660
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 48
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
 drivers/power/supply/max17040_battery.c | 52 +++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index b7433e9ca7c2..2f4851608cfe 100644
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
+	u32 low_soc_alert_threshold;
 };

 static int max17040_get_property(struct power_supply *psy,
@@ -99,6 +104,28 @@ static void max17040_reset(struct i2c_client *client)
 	max17040_write_reg(client, MAX17040_CMD, 0x0054);
 }

+static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
+	u32 level)
+{
+	int ret;
+	u16 data;
+
+	/* check if level is between 1% and 32% */
+	if (level > 0 && level < 33) {
+		level = 32 - level;
+		data = max17040_read_reg(client, MAX17040_RCOMP);
+		/* clear the alrt bit and set LSb 5 bits */
+		data &= MAX17040_ATHD_MASK;
+		data |= level;
+		max17040_write_reg(client, MAX17040_RCOMP, data);
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void max17040_get_vcell(struct i2c_client *client)
 {
 	struct max17040_chip *chip = i2c_get_clientdata(client);
@@ -161,6 +188,16 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }

+static void max17040_get_of_data(struct max17040_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct device_node *np = dev->of_node;
+
+	if (of_property_read_u32(np, "maxim,alert-low-soc-level",
+			&chip->low_soc_alert_threshold))
+		chip->low_soc_alert_threshold = MAX17040_ATHD_DEFAULT_POWER_UP;
+}
+
 static void max17040_check_changes(struct i2c_client *client)
 {
 	max17040_get_vcell(client);
@@ -226,6 +263,7 @@ static int max17040_probe(struct i2c_client *client,

 	chip->client = client;
 	chip->pdata = client->dev.platform_data;
+	max17040_get_of_data(chip);

 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -243,12 +281,20 @@ static int max17040_probe(struct i2c_client *client,
 	/* check interrupt */
 	if (client->irq) {
 		int ret;
-		unsigned int flags;
+
+		ret = max17040_set_low_soc_threshold_alert(client,
+			chip->low_soc_alert_threshold);
+		if (ret) {
+			dev_err(&client->dev,
+				"Failed to set low SOC alert: err %d\n",
+				ret);
+			return ret;
+		}

 		dev_info(&client->dev, "IRQ: enabled\n");
-		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
 		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-						max17040_thread_handler, flags,
+						max17040_thread_handler,
+						(client->flags | IRQF_ONESHOT),
 						chip->battery->desc->name,
 						chip);

--
2.20.1

