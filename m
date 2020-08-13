Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5624407C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHMVej (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHMVeh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0BC061757;
        Thu, 13 Aug 2020 14:34:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so7768281ljo.12;
        Thu, 13 Aug 2020 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7Fi9L3i7XzTcr6thO/0SWvSgth3FROAtfqsWSnrJqc=;
        b=nCI/rqUmNTDu+Fl5/y2BjihRHRHuAoXjTGy+pnXb6sz62NXrVptvuywTJDpUgbqXFt
         LvdgGGyVFRm9Rr2WnhhTRs6RTDEURphbUXMtsfRQNvDmyYQ9Ev3ju0zBiqUUTK5xmHKS
         24Td3vj5fjq+f0e8Op/0duH6usiBkBIkeaq9dMn6qeDPiloryVxUWWSz6JcX9dtyakKQ
         DP2GLHxrqBPeG5cYRRKGdLkGy+PlKzu0R/uSVZjO2wWxS+6pzCi7BpdDLZjJbyPRufaD
         GDjtaPytY2T9/fs7C7eLGLCFgEd1W11xEdHY9HbN9Y8LD+4OxkPmb0XnjbPWlU5dulZZ
         RWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7Fi9L3i7XzTcr6thO/0SWvSgth3FROAtfqsWSnrJqc=;
        b=X/NQ1MvllR807XBpLNOypJr72ck+9fyPfKnGR0O9+tl0r9u1bf18+6uwmfzSeBrVya
         0YGzakA6yli1aSkn9uzQzVVsFUsHU8id4t58R26wHcX1vn57SnFRMdh6w0GWYNIvA+pg
         Wot4uXhjgHGKZd3ytbcqx/V7tzbn5MfrSZDb+vQkjFTzQ9ZHvuSTdZJTvn8h0gflEXbp
         ycgi5tLF60oL6EG67jJlO2BwOgpMI/RQJvH0c2HQLtHWxAW3gZMx0hBEQQieOwrS16i0
         t3+SOUnV5aKDk6YVpvH//h2ZEz5MKpjY39Z6qvhAdahibIMhPD0Ojs6Zhim4SWiqrznr
         mnxQ==
X-Gm-Message-State: AOAM532PLi9p6S7YcnnERXYnJBhNeXcWjAgq2iHpAmUvPuTAK2ssdZWx
        Enpof9/oPiUJ8d8Sk89vX8E=
X-Google-Smtp-Source: ABdhPJwxbqgXVaBZrFY3PpKIRWKclZtqP6XwEoUawr6zgszysfLBYmbVMjc+91HdVTfS+xzKVXd4lg==
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr2949310ljp.306.1597354475176;
        Thu, 13 Aug 2020 14:34:35 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:34 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 04/10] power: supply: smb347-charger: Use resource-managed API
Date:   Fri, 14 Aug 2020 00:34:03 +0300
Message-Id: <20200813213409.24222-5-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
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
2.27.0

