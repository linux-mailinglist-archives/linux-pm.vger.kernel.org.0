Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC141706A9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 18:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgBZRwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 12:52:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39025 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBZRwi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 12:52:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so1552507pjr.4;
        Wed, 26 Feb 2020 09:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k7iT4GrI5yyiC3bdf9c5dyExt5qMZdlA9mJ9WFhT8VQ=;
        b=T/f0sR86DpBSgwBHj/qumjfxYbPIuuZnq+pr7zT7WNGfuEKhCSphCa3ipqVZgkC8RO
         8IfOkn1oQI0L8X0MjE0dEKJfGcwEM4CYTynmLToajh6AMtgmSSjMH7w+F6rf1+dTObQX
         F3PhzLkBE8a8Lq+9r0r+kyTnaZYmeQhbAoyvKNygwzUvxHW5HCuONhUeKR2F1pVyVtrA
         h8fMO+wGXPGQ5KcvhkREK45oiukYwji0eaeCuDPd04YoLMXqKLFK2SHEa7Sc/040JuCK
         oGfHI7A8lz6V4/JURb9s6CQAHefPr47T8iytsrkq2WwOEcr4acNGhD7wbe421kEarynk
         8WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k7iT4GrI5yyiC3bdf9c5dyExt5qMZdlA9mJ9WFhT8VQ=;
        b=NOO7ypnj9K0FuZEJOGp1RuEkHp1VTC4WFbaxg2gS4f1ncX7d+GX+4O/eDOatIFwiDJ
         FozAPYIda6gdwQtMEWLw2SZif+fdI/WRIVLa8+WaWwwvhY5YTnSXWO5t3FQGghR+iXH8
         L/GSQiFVQjgW4k1KhhCgrmm+YZ85Cmkvh2kqnkN4LXGe3tWzXDTR2wgtgYdYAsPvYeHP
         Luw6Tt89ZUjA+tch/Ua+QUd3eqUQ8HTwCgwH9Qtxd20cqjk++sb5k12h6MiceIoCQ4jg
         3oRZLDNUrJMSbwPshwHSGhM43qYO2N83HbJ+CKC3J+qshS0a2kKnmevX5AqIRX6dXZbG
         bDgg==
X-Gm-Message-State: APjAAAVa3MWHdmxymZkquGfYBSk/RbuDQ9ihDBEgc/QT0QPTiGhMCWIh
        zArIUEPMc1z/lIlSpHsg5b4=
X-Google-Smtp-Source: APXvYqyZtETWVzvs0Jc1XUbM4e7Y1ELo1ehv2dB4oW/Wi9WjY98luCiz0SsIBBkV5ghOqdXpuHQSew==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr288436pjr.74.1582739556005;
        Wed, 26 Feb 2020 09:52:36 -0800 (PST)
Received: from localhost.localdomain ([192.140.153.91])
        by smtp.gmail.com with ESMTPSA id d4sm3422962pjz.12.2020.02.26.09.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:52:35 -0800 (PST)
From:   Ashish Chavan <ashish.gschavan@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashish Chavan <ashish.gschavan@gmail.com>
Subject: [PATCH] power: supply: ab8500_charger: Fix typos in commit messages
Date:   Wed, 26 Feb 2020 23:22:23 +0530
Message-Id: <20200226175223.6371-1-ashish.gschavan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Trivial fix to spelling mistake in commit messages.

Signed-off-by: Ashish Chavan <ashish.gschavan@gmail.com>
---
 drivers/power/supply/ab8500_charger.c | 35 +++++++++++++++------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 98b335042ba6..65741bab8552 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -398,7 +398,7 @@ static void ab8500_enable_disable_sw_fallback(struct ab8500_charger *di,
 }
 
 /**
- * ab8500_power_supply_changed - a wrapper with local extentions for
+ * ab8500_power_supply_changed - a wrapper with local extensions for
  * power_supply_changed
  * @di:	  pointer to the ab8500_charger structure
  * @psy:  pointer to power_supply_that have changed.
@@ -677,7 +677,7 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 	/*
 	 * Platform only supports USB 2.0.
 	 * This means that charging current from USB source
-	 * is maximum 500 mA. Every occurence of USB_STAT_*_HOST_*
+	 * is maximum 500 mA. Every occurrence of USB_STAT_*_HOST_*
 	 * should set USB_CH_IP_CUR_LVL_0P5.
 	 */
 
@@ -1372,13 +1372,13 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 
 		/*
 		 * Due to a bug in AB8500, BTEMP_HIGH/LOW interrupts
-		 * will be triggered everytime we enable the VDD ADC supply.
+		 * will be triggered every time we enable the VDD ADC supply.
 		 * This will turn off charging for a short while.
 		 * It can be avoided by having the supply on when
 		 * there is a charger enabled. Normally the VDD ADC supply
-		 * is enabled everytime a GPADC conversion is triggered. We will
-		 * force it to be enabled from this driver to have
-		 * the GPADC module independant of the AB8500 chargers
+		 * is enabled every time a GPADC conversion is triggered.
+		 * We will force it to be enabled from this driver to have
+		 * the GPADC module independent of the AB8500 chargers
 		 */
 		if (!di->vddadc_en_ac) {
 			ret = regulator_enable(di->regu);
@@ -1448,7 +1448,7 @@ static int ab8500_charger_ac_en(struct ux500_charger *charger,
 		if (is_ab8500_1p1_or_earlier(di->parent)) {
 			/*
 			 * For ABB revision 1.0 and 1.1 there is a bug in the
-			 * watchdog logic. That means we have to continously
+			 * watchdog logic. That means we have to continuously
 			 * kick the charger watchdog even when no charger is
 			 * connected. This is only valid once the AC charger
 			 * has been enabled. This is a bug that is not handled
@@ -1545,13 +1545,13 @@ static int ab8500_charger_usb_en(struct ux500_charger *charger,
 
 		/*
 		 * Due to a bug in AB8500, BTEMP_HIGH/LOW interrupts
-		 * will be triggered everytime we enable the VDD ADC supply.
+		 * will be triggered every time we enable the VDD ADC supply.
 		 * This will turn off charging for a short while.
 		 * It can be avoided by having the supply on when
 		 * there is a charger enabled. Normally the VDD ADC supply
-		 * is enabled everytime a GPADC conversion is triggered. We will
-		 * force it to be enabled from this driver to have
-		 * the GPADC module independant of the AB8500 chargers
+		 * is enabled every time a GPADC conversion is triggered.
+		 * We will force it to be enabled from this driver to have
+		 * the GPADC module independent of the AB8500 chargers
 		 */
 		if (!di->vddadc_en_usb) {
 			ret = regulator_enable(di->regu);
@@ -1575,7 +1575,10 @@ static int ab8500_charger_usb_en(struct ux500_charger *charger,
 			return -ENXIO;
 		}
 
-		/* ChVoltLevel: max voltage upto which battery can be charged */
+		/*
+		 * ChVoltLevel: max voltage up to which battery can be
+		 * charged
+		 */
 		ret = abx500_set_register_interruptible(di->dev, AB8500_CHARGER,
 			AB8500_CH_VOLT_LVL_REG, (u8) volt_index);
 		if (ret) {
@@ -2007,7 +2010,7 @@ static void ab8500_charger_check_hw_failure_work(struct work_struct *work)
  * Work queue function for kicking the charger watchdog.
  *
  * For ABB revision 1.0 and 1.1 there is a bug in the watchdog
- * logic. That means we have to continously kick the charger
+ * logic. That means we have to continuously kick the charger
  * watchdog even when no charger is connected. This is only
  * valid once the AC charger has been enabled. This is
  * a bug that is not handled by the algorithm and the
@@ -2255,7 +2258,7 @@ static void ab8500_charger_usb_link_status_work(struct work_struct *work)
 	 * Some chargers that breaks the USB spec is
 	 * identified as invalid by AB8500 and it refuse
 	 * to start the charging process. but by jumping
-	 * thru a few hoops it can be forced to start.
+	 * through a few hoops it can be forced to start.
 	 */
 	if (is_ab8500(di->parent))
 		ret = abx500_get_register_interruptible(di->dev, AB8500_USB,
@@ -3214,7 +3217,7 @@ static int ab8500_charger_resume(struct platform_device *pdev)
 
 	/*
 	 * For ABB revision 1.0 and 1.1 there is a bug in the watchdog
-	 * logic. That means we have to continously kick the charger
+	 * logic. That means we have to continuously kick the charger
 	 * watchdog even when no charger is connected. This is only
 	 * valid once the AC charger has been enabled. This is
 	 * a bug that is not handled by the algorithm and the
@@ -3451,7 +3454,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 
 	/*
 	 * For ABB revision 1.0 and 1.1 there is a bug in the watchdog
-	 * logic. That means we have to continously kick the charger
+	 * logic. That means we have to continuously kick the charger
 	 * watchdog even when no charger is connected. This is only
 	 * valid once the AC charger has been enabled. This is
 	 * a bug that is not handled by the algorithm and the
-- 
2.17.1

