Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF91F2613
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 04:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfKGDjp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 22:39:45 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.212]:15887 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733038AbfKGDjp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 22:39:45 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 23424149C95
        for <linux-pm@vger.kernel.org>; Wed,  6 Nov 2019 21:17:20 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id SYISizHK9OdBHSYISiFlu4; Wed, 06 Nov 2019 21:17:20 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hDIhrFBd0ww359PJX8lv7FR9yopVFZC5THcbdkAE3CQ=; b=NMOEql7I5nljhUvbHk16kPxZAF
        KjXOLsXqFbhxlfFPF2zVkH5ElGA5qeyyQpdsPYNtkRXSbd4C+haEDTaaWQVXskvkZ96Afus4bsdam
        RGG/vU8KamnF6gfRZ/fI760TIVJQ7dUwW7aqemJyAKMuDg5ayeQ1MxT/GzoYPJFd6ciVep7iIl27p
        kr0bqRK7tnSBnxKKYJ5wY3f+OGxD4pP8XCNWPWVJ3n0H2z3c5aMJTwuOX0Ng4iQ8qg3WF82yNAUU6
        tIMDMEKJJPIxDlgwSBGyHNlIPllO/g/rgTHFBP7Gs9V9QcHpMZFcu3a6O52bXnZ/3GvfWICqE1eC9
        RW1nqI4A==;
Received: from [191.31.194.59] (port=34854 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iSYIR-000Mrk-6i; Thu, 07 Nov 2019 00:17:19 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v6 1/5] power: supply: max17040: Add IRQ handler for low SOC alert
Date:   Thu,  7 Nov 2019 00:17:06 -0300
Message-Id: <20191107031710.5672-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191107031710.5672-1-matheus@castello.eng.br>
References: <20191105095905.GA31721@pi3>
 <20191107031710.5672-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.194.59
X-Source-L: No
X-Exim-ID: 1iSYIR-000Mrk-6i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.194.59]:34854
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 29
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According datasheet max17040 has a pin for alert host for low SOC.
This pin can be used as external interrupt, so we need to check for
interrupts assigned for device and handle it.

In handler we are checking and storing fuel gauge registers values
and send an uevent to notificate user space, so user space can decide
save work or turn off since the alert demonstrate that the battery may
no have the power to keep the system turned on for much longer.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max17040_battery.c | 73 +++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 62499018e68b..9909f8cd7b5d 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/max17040_battery.h>
 #include <linux/slab.h>
@@ -160,21 +161,54 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }

+static void max17040_check_changes(struct i2c_client *client)
+{
+	max17040_get_vcell(client);
+	max17040_get_soc(client);
+	max17040_get_online(client);
+	max17040_get_status(client);
+}
+
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;

 	chip = container_of(work, struct max17040_chip, work.work);
-
-	max17040_get_vcell(chip->client);
-	max17040_get_soc(chip->client);
-	max17040_get_online(chip->client);
-	max17040_get_status(chip->client);
+	max17040_check_changes(chip->client);

 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }

+static irqreturn_t max17040_thread_handler(int id, void *dev)
+{
+	struct max17040_chip *chip = dev;
+	struct i2c_client *client = chip->client;
+
+	dev_warn(&client->dev, "IRQ: Alert battery low level");
+	/* read registers */
+	max17040_check_changes(chip->client);
+
+	/* send uevent */
+	power_supply_changed(chip->battery);
+
+	return IRQ_HANDLED;
+}
+
+static int max17040_enable_alert_irq(struct max17040_chip *chip)
+{
+	struct i2c_client *client = chip->client;
+	unsigned int flags;
+	int ret;
+
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
@@ -220,6 +254,19 @@ static int max17040_probe(struct i2c_client *client,
 	max17040_reset(client);
 	max17040_get_version(client);

+	/* check interrupt */
+	if (client->irq) {
+		int ret;
+
+		ret = max17040_enable_alert_irq(chip);
+
+		if (ret) {
+			client->irq = 0;
+			dev_warn(&client->dev,
+				 "Failed to get IRQ err %d\n", ret);
+		}
+	}
+
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
@@ -244,6 +291,14 @@ static int max17040_suspend(struct device *dev)
 	struct max17040_chip *chip = i2c_get_clientdata(client);

 	cancel_delayed_work(&chip->work);
+
+	if (client->irq) {
+		if (device_may_wakeup(dev))
+			enable_irq_wake(client->irq);
+		else
+			disable_irq_wake(client->irq);
+	}
+
 	return 0;
 }

@@ -254,6 +309,14 @@ static int max17040_resume(struct device *dev)

 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
+
+	if (client->irq) {
+		if (device_may_wakeup(dev))
+			disable_irq_wake(client->irq);
+		else
+			enable_irq_wake(client->irq);
+	}
+
 	return 0;
 }

--
2.24.0.rc2

