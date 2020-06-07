Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2301A1F0C16
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgFGOpY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgFGOpX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9ADC08C5C3;
        Sun,  7 Jun 2020 07:45:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so8644763lfe.5;
        Sun, 07 Jun 2020 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8Cu9juxYNFZC2z0hTA24pcBzRFIIFKT2GRI02KZjfs=;
        b=Ot4EUtsPYfXjE8+Ykn9xXH6MgLhqxOAXc1rwB12oNHaHemWntn9+WIkCtvWJza1JuQ
         R/10HqjsM865LG/N0nfAKAK3rEnIgKELqOeqeKGdCPCpbsJS0WG8v/dSIl3hQJsQk4dD
         4oX8LcQ0h4TOLVB3vUWYrFsZk7fnunCb0JTIgYFEG0hbygQ6NdXAilpG6CpNgrpYlSWX
         rcIJNEnUfXxviG1PeNWV3uZmz22v/m/TgO5ZJOHLMS2KiBwsPgUgAc9yPrjA4YTYwTSe
         kuvRozgNNxtqG6eIV7kjTiB9dHp31E/pLxl7i6ZPWf6rUglbazND8MfyPRTBVULAZO77
         vbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8Cu9juxYNFZC2z0hTA24pcBzRFIIFKT2GRI02KZjfs=;
        b=bemjClezu8SJs/XQ8QwjlzAOGHDlhfo9kj6CkUmMty/4bvds9hjtNTzPITOMBDfuZl
         9CRX6Q0/dxilgpZig4ssRBDJIbOemYYo9ofjNjEJomqcudKTxtX+46yJ7FscwZ3lgTgQ
         s/VxQg5tyeDIE3ognAGhRCK0dCjapo4ZI7JDRZdOOHzMJVaaN2MC87yeS5pEEos1u7gn
         nUA7bvFp9RWq8YTVF1NgMg8LSTNdC9nJmD6naGYPOMhGs+XNmzHzsKVsLLXF6pOZYAiS
         0gq/79RSUIAAk5SkJezm3TfCbiv3yb95mwOrqcjX6cvHhwWQFS45Zls+aMfbdOZRt/Wh
         d7tQ==
X-Gm-Message-State: AOAM530pSRdYJ1T8i558PvCqkM87arVPszXb5DeNo3qlyyQX1HkprUTG
        riiuIzDQ88LtbZWHYb5YAP8=
X-Google-Smtp-Source: ABdhPJwphUUrahUtVUqL+i+apuVy8jMi8VlW9DoLZAsgClvEpyuManKqwgS/kE4GLZ8pDEEf9DppUQ==
X-Received: by 2002:a19:6e0e:: with SMTP id j14mr10320178lfc.155.1591541120964;
        Sun, 07 Jun 2020 07:45:20 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 4/9] power: supply: smb347-charger: Use resource-managed API
Date:   Sun,  7 Jun 2020 17:41:08 +0300
Message-Id: <20200607144113.10202-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Simplify code, more convenient to use with Device Tree.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/power/supply/smb347-charger.c | 75 +++++++++++----------------
 1 file changed, 29 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index f99026d81f2a..60894105fcbd 100644
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
 
@@ -1251,32 +1251,24 @@ static int smb347_probe(struct i2c_client *client,
 	mains_usb_cfg.num_supplicants = ARRAY_SIZE(battery);
 	mains_usb_cfg.drv_data = smb;
 	if (smb->pdata->use_mains) {
-		smb->mains = power_supply_register(dev, &smb347_mains_desc,
-						   &mains_usb_cfg);
+		smb->mains = devm_power_supply_register(dev, &smb347_mains_desc,
+							&mains_usb_cfg);
 		if (IS_ERR(smb->mains))
 			return PTR_ERR(smb->mains);
 	}
 
 	if (smb->pdata->use_usb) {
-		smb->usb = power_supply_register(dev, &smb347_usb_desc,
-						 &mains_usb_cfg);
-		if (IS_ERR(smb->usb)) {
-			if (smb->pdata->use_mains)
-				power_supply_unregister(smb->mains);
+		smb->usb = devm_power_supply_register(dev, &smb347_usb_desc,
+						      &mains_usb_cfg);
+		if (IS_ERR(smb->usb))
 			return PTR_ERR(smb->usb);
-		}
 	}
 
 	battery_cfg.drv_data = smb;
-	smb->battery = power_supply_register(dev, &smb347_battery_desc,
-					     &battery_cfg);
-	if (IS_ERR(smb->battery)) {
-		if (smb->pdata->use_usb)
-			power_supply_unregister(smb->usb);
-		if (smb->pdata->use_mains)
-			power_supply_unregister(smb->mains);
+	smb->battery = devm_power_supply_register(dev, &smb347_battery_desc,
+						  &battery_cfg);
+	if (IS_ERR(smb->battery))
 		return PTR_ERR(smb->battery);
-	}
 
 	/*
 	 * Interrupt pin is optional. If it is connected, we setup the
@@ -1299,17 +1291,8 @@ static int smb347_remove(struct i2c_client *client)
 {
 	struct smb347_charger *smb = i2c_get_clientdata(client);
 
-	if (client->irq) {
+	if (client->irq)
 		smb347_irq_disable(smb);
-		free_irq(client->irq, smb);
-		gpio_free(smb->pdata->irq_gpio);
-	}
-
-	power_supply_unregister(smb->battery);
-	if (smb->pdata->use_usb)
-		power_supply_unregister(smb->usb);
-	if (smb->pdata->use_mains)
-		power_supply_unregister(smb->mains);
 	return 0;
 }
 
-- 
2.26.0

