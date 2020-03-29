Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59826196E6F
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgC2QZ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:25:58 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52676 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgC2QZw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:25:52 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 99DD72498B;
        Sun, 29 Mar 2020 18:17:08 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>
Subject: [PATCH 3/9] power: supply: smb347-charger: Use resource-managed API
Date:   Sun, 29 Mar 2020 18:15:46 +0200
Message-Id: <20200329161552.215075-4-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200329161552.215075-1-david@ixit.cz>
References: <20200329161552.215075-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify code, more convenient to use with Device Tree.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 45 +++++++++++++--------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index f99026d81f2a..4add9f64ba90 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -836,21 +836,31 @@ static int smb347_irq_init(struct smb347_charger *smb,
 			   struct i2c_client *client)
 {
 	const struct smb347_charger_platform_data *pdata = smb->pdata;
-	int ret, irq = gpio_to_irq(pdata->irq_gpio);
+	unsigned long irqflags = IRQF_ONESHOT;
+	int ret;
 
-	ret = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
-	if (ret < 0)
-		goto fail;
+	/* Requesting GPIO for IRQ is only needed in non-DT way */
+	if (!client->irq) {
+		int irq = gpio_to_irq(pdata->irq_gpio);
+
+		ret = devm_gpio_request_one(smb->dev, pdata->irq_gpio,
+					    GPIOF_IN, client->name);
+		if (ret < 0)
+			return ret;
+
+		irqflags |= IRQF_TRIGGER_FALLING;
+		client->irq = irq;
+	}
 
-	ret = request_threaded_irq(irq, NULL, smb347_interrupt,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   client->name, smb);
+	ret = devm_request_threaded_irq(smb->dev, client->irq, NULL,
+					smb347_interrupt, irqflags,
+					client->name, smb);
 	if (ret < 0)
-		goto fail_gpio;
+		return ret;
 
 	ret = smb347_set_writable(smb, true);
 	if (ret < 0)
-		goto fail_irq;
+		return ret;
 
 	/*
 	 * Configure the STAT output to be suitable for interrupts: disable
@@ -860,20 +870,10 @@ static int smb347_irq_init(struct smb347_charger *smb,
 				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
 				 CFG_STAT_DISABLED);
 	if (ret < 0)
-		goto fail_readonly;
+		client->irq = 0;
 
 	smb347_set_writable(smb, false);
-	client->irq = irq;
-	return 0;
 
-fail_readonly:
-	smb347_set_writable(smb, false);
-fail_irq:
-	free_irq(irq, smb);
-fail_gpio:
-	gpio_free(pdata->irq_gpio);
-fail:
-	client->irq = 0;
 	return ret;
 }
 
@@ -1299,11 +1299,8 @@ static int smb347_remove(struct i2c_client *client)
 {
 	struct smb347_charger *smb = i2c_get_clientdata(client);
 
-	if (client->irq) {
+	if (client->irq)
 		smb347_irq_disable(smb);
-		free_irq(client->irq, smb);
-		gpio_free(smb->pdata->irq_gpio);
-	}
 
 	power_supply_unregister(smb->battery);
 	if (smb->pdata->use_usb)
-- 
2.25.0

