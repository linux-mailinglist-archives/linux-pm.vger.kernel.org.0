Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CEF3B8C42
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhGAC1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbhGAC1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AB8C0613A2;
        Wed, 30 Jun 2021 19:24:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f13so6137658ljp.10;
        Wed, 30 Jun 2021 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esff+ZXqqz83swKvK/vBkagYD4H4gF2qZzwq0FaHQEk=;
        b=LfHrbtJT8SQNYgOxuByF33zsi0fUJ2IMbfbtKeIMm49coJc97ACnpMGGtCM9PDt+fc
         up57htuFcMKqIJNIWGYbatAi+OVn40wnQw0ij8HAj/TYUkIJdpuwfIZCYFxDg6iQJPQr
         wuw3W23Fi43sVQZ7XcQ11LiM+Q5nasbnPy6SalNEeHUiXzMEwVsdFOrmKLYXyPJezuGK
         z8MEjs7L4J/THe1x1Bd7V5seBpsTE8kEw63svctJBGTbyJ+jmd0IRoeLkteQXPB41F6+
         +ZTKcBG1xpJ+mEpIPS/IDXqgaenRzs9Q9TXm9oZTO7wHAHhcE6duhKhsg7YtZdO9FJ1n
         dO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esff+ZXqqz83swKvK/vBkagYD4H4gF2qZzwq0FaHQEk=;
        b=QrTW5Ee1EbqY7juR6IB1Bc4FDzObPvc+zXZsMORjcui9k+A1UISVP3O5aB+LZcCkCf
         Ow+lH7iqP+l1cprh2Z24LfyZZSf0seWLM/cF3B49AyM6ldr6HsFS01I5XsezuDJVXRFl
         TTANFDx16GWx8EGHkA3Vc6SyUsv4Jo6echF78q7ql+7xfxBJaYvnBnX+DNY7mKZInDkm
         mJtYajWkDRh6r2iGHEg/FUhMpzzayZqEKKP2v5v59yTrLFAa5DAVzh5q3efMFw9u435A
         Si3VkcXfH5Twt5t5zp5GY+vtD9UXXlMykHEDIRAeNN6ASRTKhK/bvNXbkad6CGlh6yF5
         nX4g==
X-Gm-Message-State: AOAM531RLzbSuTniDf5DokG3dcmtkO5IpSQqwL9tHT9LZt6Kz4ao24g2
        yQtTw8N1xSzO8DBL6fOHIGI=
X-Google-Smtp-Source: ABdhPJz+J6+TdtzyRYMkQ/xx/qSunXyMi5ChDbDhNBwakwQ2/5icuNKzrcTHjPloczTgbBDUBe87qQ==
X-Received: by 2002:a2e:6d11:: with SMTP id i17mr10419938ljc.75.1625106289654;
        Wed, 30 Jun 2021 19:24:49 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 07/12] power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
Date:   Thu,  1 Jul 2021 05:24:00 +0300
Message-Id: <20210701022405.10817-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The smb347_set_writable() is used by interrupt handler and outside of it.
The interrupt should be disabled when the function is used outside of
interrupt handler in order to prevent racing with the interrupt context.
Add new parameter to smb347_set_writable() that allows to disable IRQ.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index df240420f2de..db1378b41f80 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -671,10 +671,22 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
  *
  * Returns %0 on success and negative errno in case of failure.
  */
-static int smb347_set_writable(struct smb347_charger *smb, bool writable)
+static int smb347_set_writable(struct smb347_charger *smb, bool writable,
+			       bool irq_toggle)
 {
-	return regmap_update_bits(smb->regmap, CMD_A, CMD_A_ALLOW_WRITE,
-				  writable ? CMD_A_ALLOW_WRITE : 0);
+	struct i2c_client *client = to_i2c_client(smb->dev);
+	int ret;
+
+	if (writable && irq_toggle && !smb->irq_unsupported)
+		disable_irq(client->irq);
+
+	ret = regmap_update_bits(smb->regmap, CMD_A, CMD_A_ALLOW_WRITE,
+				 writable ? CMD_A_ALLOW_WRITE : 0);
+
+	if ((!writable || ret) && irq_toggle && !smb->irq_unsupported)
+		enable_irq(client->irq);
+
+	return ret;
 }
 
 static int smb347_hw_init(struct smb347_charger *smb)
@@ -682,7 +694,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	unsigned int val;
 	int ret;
 
-	ret = smb347_set_writable(smb, true);
+	ret = smb347_set_writable(smb, true, false);
 	if (ret < 0)
 		return ret;
 
@@ -758,7 +770,7 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	ret = smb347_start_stop_charging(smb);
 
 fail:
-	smb347_set_writable(smb, false);
+	smb347_set_writable(smb, false, false);
 	return ret;
 }
 
@@ -866,7 +878,7 @@ static int smb347_irq_set(struct smb347_charger *smb, bool enable)
 	if (smb->irq_unsupported)
 		return 0;
 
-	ret = smb347_set_writable(smb, true);
+	ret = smb347_set_writable(smb, true, true);
 	if (ret < 0)
 		return ret;
 
@@ -891,7 +903,7 @@ static int smb347_irq_set(struct smb347_charger *smb, bool enable)
 	ret = regmap_update_bits(smb->regmap, CFG_PIN, CFG_PIN_EN_CHARGER_ERROR,
 				 enable ? CFG_PIN_EN_CHARGER_ERROR : 0);
 fail:
-	smb347_set_writable(smb, false);
+	smb347_set_writable(smb, false, true);
 	return ret;
 }
 
@@ -919,7 +931,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
 	if (!client->irq)
 		return 0;
 
-	ret = smb347_set_writable(smb, true);
+	ret = smb347_set_writable(smb, true, false);
 	if (ret < 0)
 		return ret;
 
@@ -931,7 +943,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
 				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
 				 CFG_STAT_DISABLED);
 
-	smb347_set_writable(smb, false);
+	smb347_set_writable(smb, false, false);
 
 	if (ret < 0) {
 		dev_warn(smb->dev, "failed to initialize IRQ: %d\n", ret);
-- 
2.30.2

