Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A337688D
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhEGQWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 12:22:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51202 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbhEGQWe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 12:22:34 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lf3EL-00088T-PR
        for linux-pm@vger.kernel.org; Fri, 07 May 2021 16:21:33 +0000
Received: by mail-qv1-f69.google.com with SMTP id 99-20020a0c80ec0000b029017de514d56fso6949370qvb.17
        for <linux-pm@vger.kernel.org>; Fri, 07 May 2021 09:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW/9mYiVYyeTStSYaXn6R4LsQC+ZiyYHwHd014oNij8=;
        b=GMFp0ojN4kEn3E6o8oMfVi8PpczTLhzPnBUafN+amjAlQiXlpTwEWwzrj2/L7qNhP7
         gpN+s/UmM0F6SnJSulK3hNb6ooxnC0RkD4jEVDRepDpoLc1i3tZprbshdSI7TwRFde14
         JCQKtqwSsPrky7isqGUjGWRRB1EQ5vZ51fnqKc/17xtqioOH3/YCaOG0MMPCqRm1GBll
         WVd5QvMdCecZ2XXctqgwvDexSkr/gNhNKsps6DDZ/B+hyAZQzc8gWmwWPsFMfaodo5A1
         h/QraWByrcVpYNd3TzVY5CzykRsHG8KspTwteLAli+Wljh89mzZGjCPSBaVh3sxFJXc6
         rDTw==
X-Gm-Message-State: AOAM531TCfdMYEW1INCXQez4UiCx6+Wvqamt850IVGcvOkSdWg4tMLIs
        HFA6NvE0zIuX3nECyibZAjPXgDf1JKVbRo0e8OR16qA63opborxPataulUuA1oSs4ZiRyDn+J5z
        Rwqzt3TCNCwRks2uX2N1XMY1xV7NIm5WnYJpQ
X-Received: by 2002:a0c:bd13:: with SMTP id m19mr10619799qvg.29.1620404492932;
        Fri, 07 May 2021 09:21:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeTLsueDZAjedoM9qmR/TUIHVoHbW8SOlMK0023BrwGcAAfGdKnlBWj8QNSJ6uU2+0QlqFJQ==
X-Received: by 2002:a0c:bd13:: with SMTP id m19mr10619784qvg.29.1620404492706;
        Fri, 07 May 2021 09:21:32 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.1])
        by smtp.gmail.com with ESMTPSA id i5sm4991869qki.115.2021.05.07.09.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:21:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Matheus Castello <matheus@castello.eng.br>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [RFT PATCH 1/3] power: supply: max17040: remove non-working POWER_SUPPLY_PROP_STATUS
Date:   Fri,  7 May 2021 12:19:25 -0400
Message-Id: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver was reporting POWER_SUPPLY_PROP_STATUS via platform data
functions.  Without platform data, the max17040_get_status() functions
returns early with POWER_SUPPLY_STATUS_UNKNOWN.  Since there are no
platforms using the driver with platform data (no board files with the
driver), the status property was always unknown.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/power/supply/max17040_battery.c | 32 +++----------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 1aab868adabf..12854c87df53 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -147,8 +147,6 @@ struct max17040_chip {
 
 	/* battery capacity */
 	int soc;
-	/* State Of Charge */
-	int status;
 	/* Low alert threshold from 32% to 1% of the State of Charge */
 	u32 low_soc_alert;
 	/* some devices return twice the capacity */
@@ -225,24 +223,6 @@ static int max17040_get_online(struct max17040_chip *chip)
 		chip->pdata->battery_online() : 1;
 }
 
-static int max17040_get_status(struct max17040_chip *chip)
-{
-	if (!chip->pdata || !chip->pdata->charger_online
-			|| !chip->pdata->charger_enable)
-		return POWER_SUPPLY_STATUS_UNKNOWN;
-
-	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
-		return POWER_SUPPLY_STATUS_FULL;
-
-	if (chip->pdata->charger_online())
-		if (chip->pdata->charger_enable())
-			return POWER_SUPPLY_STATUS_CHARGING;
-		else
-			return POWER_SUPPLY_STATUS_NOT_CHARGING;
-	else
-		return POWER_SUPPLY_STATUS_DISCHARGING;
-}
-
 static int max17040_get_of_data(struct max17040_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
@@ -283,7 +263,6 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 static void max17040_check_changes(struct max17040_chip *chip)
 {
 	chip->soc = max17040_get_soc(chip);
-	chip->status = max17040_get_status(chip);
 }
 
 static void max17040_queue_work(struct max17040_chip *chip)
@@ -302,17 +281,16 @@ static void max17040_stop_work(void *data)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
-	int last_soc, last_status;
+	int last_soc;
 
 	chip = container_of(work, struct max17040_chip, work.work);
 
-	/* store SOC and status to check changes */
+	/* store SOC to check changes */
 	last_soc = chip->soc;
-	last_status = chip->status;
 	max17040_check_changes(chip);
 
 	/* check changes and send uevent */
-	if (last_soc != chip->soc || last_status != chip->status)
+	if (last_soc != chip->soc)
 		power_supply_changed(chip->battery);
 
 	max17040_queue_work(chip);
@@ -415,9 +393,6 @@ static int max17040_get_property(struct power_supply *psy,
 	struct max17040_chip *chip = power_supply_get_drvdata(psy);
 
 	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = max17040_get_status(chip);
-		break;
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = max17040_get_online(chip);
 		break;
@@ -444,7 +419,6 @@ static const struct regmap_config max17040_regmap = {
 };
 
 static enum power_supply_property max17040_battery_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
-- 
2.25.1

