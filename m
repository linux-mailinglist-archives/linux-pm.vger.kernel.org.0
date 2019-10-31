Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B4EB7BC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 20:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfJaTFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 15:05:25 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.70]:34964 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729347AbfJaTFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 15:05:25 -0400
X-Greylist: delayed 1417 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 15:05:24 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 0BEF37C3B40
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 13:41:47 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id QFOEiQ26SPUvSQFOEirqdV; Thu, 31 Oct 2019 13:41:47 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0s7yqwze+IyjqCaWlQRpYCliMtnXouGLS0DZiyaG5jI=; b=qeMNWRacdzT21rXVTgy7O8X1d+
        Nk4KV3n7si3naxRSsiN98hwfTFtgz1lywNFlqvBOYYD1NZZVP8iL2fdjYaQhDMVaYoBdsXaobXcjv
        e4FHDu+Sj0Lh4oiD05HSB5VlQ0L+cKDRVJXGgVOMvgyuCP1SnVMYO/QoCYa5pPw9RDD5i9JOtzds8
        0zL9xYeuu9NrlC5HmLuuyvNw7rz9I0tMSmvIJrzTN2Gaa1Xr+dHX52bfkNl/4eynvK2WL+Hl+dmUD
        Gc48Hh5TFBlwIKGo30KrYOuuU/bezmD6unVadJDFRG1rZUvRbgmq2ZSIJjT+EX13fzRoncM752hc4
        c3xrmTrQ==;
Received: from [191.31.195.127] (port=35710 helo=castello.bz.toradex.local)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iQFOD-0035gz-JB; Thu, 31 Oct 2019 15:41:46 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v4 1/4] power: supply: max17040: Add IRQ handler for low SOC alert
Date:   Thu, 31 Oct 2019 15:41:31 -0300
Message-Id: <20191031184134.30621-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191031184134.30621-1-matheus@castello.eng.br>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.195.127
X-Source-L: No
X-Exim-ID: 1iQFOD-0035gz-JB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.bz.toradex.local) [191.31.195.127]:35710
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 14
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
---
 drivers/power/supply/max17040_battery.c | 65 +++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 62499018e68b..75459f76d02c 100644
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
@@ -160,21 +161,40 @@ static void max17040_get_status(struct i2c_client *client)
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
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -220,6 +240,25 @@ static int max17040_probe(struct i2c_client *client,
 	max17040_reset(client);
 	max17040_get_version(client);

+	/* check interrupt */
+	if (client->irq) {
+		int ret;
+		unsigned int flags;
+
+		dev_info(&client->dev, "IRQ: enabled\n");
+		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						max17040_thread_handler, flags,
+						chip->battery->desc->name,
+						chip);
+
+		if (ret) {
+			client->irq = 0;
+			dev_warn(&client->dev,
+				"Failed to get IRQ err %d\n", ret);
+		}
+	}
+
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
@@ -244,6 +283,14 @@ static int max17040_suspend(struct device *dev)
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

@@ -254,6 +301,14 @@ static int max17040_resume(struct device *dev)

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

