Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB36B49D766
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiA0BPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiA0BPG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:15:06 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C8C06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:15:06 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n8so2265319lfq.4
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykjGaL0hTNu/sFC5BS2s3FG5tHHOkoccsGYthrfBM5s=;
        b=paQumlxaFdnS3Y1aaB/QbnjiND43BhcQvxtYiFNyUrrIYwnLwNOysR0C5WOcJ981pP
         F2dhTvsembDYjy/PURZ6lD0Qj9Huoy8aAQhCZpA3sG910jLMl7oKA7yUSOrU5pd/z89C
         95xPNTxwiLWx1BEVlGV/2kxA2HsC5WFF+npKoMsK4dknG/KjPliVXbXRXEbS0MFJpOtm
         bMSyNapgQI+vH1E/ec/jYN6bIPw2zQJpFXg0QOPptfhIEUh8boEqEPnR/8bOUBHW8X74
         D8PQaci8uBBCnXsHwti7LivwIj6d/wg3C8Y6M4c4PM1xqivOI1XAOP0zxPXPBPFgrESZ
         S+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykjGaL0hTNu/sFC5BS2s3FG5tHHOkoccsGYthrfBM5s=;
        b=2BG8ceIZyCLXzQfh0V4ORwcLXNJDv5T/9DaAJ0oyJOuk+55ZJKPsga2kniT9eWC0Ai
         wAph09XN4tq59P0kBaJxKUW4kqhXoLoawDH2V+MLfNanaXxpJSazCgxAtKGCjLSGbgHD
         GMpzOCbhHBnbYGZC1wHe6FXra3j/y83NBCw7VX/SXl2fd5u+zSJe3PbqN7iCzkci5Pc3
         c+oEuo4WOiHTRhpdfrDZ5lGYdZLRRGPZCmvZrJll7f8btJTs4sDbPp0WEUVyiUCD7TGk
         CpSCEyga7dmlfW/+HY5yVx+XkUTnxbFruOOSaOCfqz2QYSOpc5mQ4sWxJRcZgNgd5hw1
         vp8g==
X-Gm-Message-State: AOAM5302dWz5tv9rPwv6tQPBUJ/x2QmEAPe3FhWJ2tPjAavg1OgU2i7H
        XzcjL949DCRp9lzC2e2XAyhjyQ==
X-Google-Smtp-Source: ABdhPJyhI4nFtxKHbYxKGY8ZI794y18fImfolRZynLn1n5NgQGhzXZrBhWkrXkDXNulh/Ymynysssw==
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr1249321lfu.590.1643246104781;
        Wed, 26 Jan 2022 17:15:04 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:15:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/11] power: supply: ab8500_charger: Fix VBAT interval check
Date:   Thu, 27 Jan 2022 02:12:36 +0100
Message-Id: <20220127011236.332687-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When using USB charging, the AB8500 charger is periodically
checking VBAT for a threshold at 3.8V.

This crashes badly, as the class_for_each_device() was passed
the wrong argument. I think this has maybe worked by chance
in the past because of how the structs were arranged but it
is leading to crashes now.

Fix this up and also switch to using microvolts for the
voltages like the rest of the code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500_charger.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 681b53bb0df0..88099cdba8a7 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -163,7 +163,7 @@ enum ab8500_usb_state {
 #define USB_CH_IP_CUR_LVL_1P4		1400000
 #define USB_CH_IP_CUR_LVL_1P5		1500000
 
-#define VBAT_TRESH_IP_CUR_RED		3800
+#define VBAT_TRESH_IP_CUR_RED		3800000
 
 #define to_ab8500_charger_usb_device_info(x) container_of((x), \
 	struct ab8500_charger, usb_chg)
@@ -1920,7 +1920,11 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 
 	di = to_ab8500_charger_usb_device_info(usb_chg);
 
-	/* For all psy where the driver name appears in any supplied_to */
+	/*
+	 * For all psy where the driver name appears in any supplied_to
+	 * in practice what we will find will always be "ab8500_fg" as
+	 * the fuel gauge is responsible of keeping track of VBAT.
+	 */
 	j = match_string(supplicants, ext->num_supplicants, psy->desc->name);
 	if (j < 0)
 		return 0;
@@ -1937,7 +1941,10 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_BATTERY:
-				di->vbat = ret.intval / 1000;
+				/* This will always be "ab8500_fg" */
+				dev_dbg(di->dev, "get VBAT from %s\n",
+					dev_name(&ext->dev));
+				di->vbat = ret.intval;
 				break;
 			default:
 				break;
@@ -1966,7 +1973,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 		struct ab8500_charger, check_vbat_work.work);
 
 	class_for_each_device(power_supply_class, NULL,
-		di->usb_chg.psy, ab8500_charger_get_ext_psy_data);
+			      &di->usb_chg, ab8500_charger_get_ext_psy_data);
 
 	/* First run old_vbat is 0. */
 	if (di->old_vbat == 0)
@@ -1991,8 +1998,8 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 	 * No need to check the battery voltage every second when not close to
 	 * the threshold.
 	 */
-	if (di->vbat < (VBAT_TRESH_IP_CUR_RED + 100) &&
-		(di->vbat > (VBAT_TRESH_IP_CUR_RED - 100)))
+	if (di->vbat < (VBAT_TRESH_IP_CUR_RED + 100000) &&
+		(di->vbat > (VBAT_TRESH_IP_CUR_RED - 100000)))
 			t = 1;
 
 	queue_delayed_work(di->charger_wq, &di->check_vbat_work, t * HZ);
-- 
2.34.1

