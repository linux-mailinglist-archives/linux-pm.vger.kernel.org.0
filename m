Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CD44A2ABB
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbiA2Avx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbiA2Avv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:51 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706CC061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:51 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b14so11411584ljb.0
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Go5l1ipxY1cYiE+l65MFV3WUsERyMFiSAzh/nJDqkFQ=;
        b=uzYUHmxVbNcusBUOgZ97xxmdoPmsTTBm8jI3T7uh+avoaVjQPtA4vcpB5S3x0qbupQ
         fAIbugTw4WI16QkNl803cBYee8u2XNHxF7L/vKS+lZoJZlybgDcboQfrsN5ymKIgssHF
         t4lX8rRZdg49wEVRohzxHsXO1JrIXLou11n0gL/ryO9p37f3zv3pth7Pv5tZpdgenUQd
         5p9CPkedjOrf5WAZgYMMYd5I7OcWP6exYM5qNxHMhK9RNJ5IbEnJuG+bEsDJOi3RGE1w
         gnAx68y9VuU+anNZc7xQf831h3o8C11FviAaRZGnFb4C6+hAilyCIZtrmq/4Zo7lt7Eb
         cNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Go5l1ipxY1cYiE+l65MFV3WUsERyMFiSAzh/nJDqkFQ=;
        b=hlEdOVeBZFKpFyyDL/2+n4cJrjgkcfhMCh1WFqd1JSziVkjQ/i6KpQ1tFciUvxrRaU
         8EIQ7MJB2K6tBFa6/UAqP0++Fr0JAdQ0OWCQQ0MDSD64I7OXE+CvkaKXreRl0x3/H9yp
         z95bzpK91FWurwJTo6t1yrn4hdptUTu+6xvA6QmaPSycxBQN2b8VAP7gofBfjV/BHivf
         nMY3sH0FsRGEnZcyRaTeny2h7sgDctcclz1IRlcyt32F81BXZ5oCmXkpeW8kJCpOVTK1
         8MLIDhz89UUMOTlQOdgVaqPsSkV5eB/aysNzf2lSlKdQfT85zLf5gYFbSZaOKf+XlD2z
         cP9g==
X-Gm-Message-State: AOAM532c8kY3bDJMCJv4dmCUkNJrcbrSrkJw38UBQCpORVnhMIy60+Yx
        pW9r2XUc3RfPGPMjdr4ZSd7fUu7LZxdfVA==
X-Google-Smtp-Source: ABdhPJwefXdqthQ9MYL1WFlyQkiTT4FsDwccap8iSby3llepHPHGyUxWPMVOEBmqHqXkkqAfVWkd7w==
X-Received: by 2002:a2e:a594:: with SMTP id m20mr7114159ljp.491.1643417509576;
        Fri, 28 Jan 2022 16:51:49 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:49 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/11 v2] power: supply: ab8500_charger: Fix VBAT interval check
Date:   Sat, 29 Jan 2022 01:49:25 +0100
Message-Id: <20220129004925.639684-12-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Resending with other patches, no changes.
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

