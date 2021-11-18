Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980BE455299
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbhKRCXZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbhKRCXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:24 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A03BC061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n12so18191164lfe.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkJmaZyXa0qnJQKIEoPV8/w271B2CRpKLAwKWy8RIwE=;
        b=xMlTqLprZbVHcF1CWqhxPnqDmx/x10f29Irh3BDV1LE+cLqwGMH9btMWbDEVpWkCjQ
         84mCDyxYDA+w1SBfrJLqblqLnjVf5VHpGGdj71c6Sr+uiUSs/K98LfQd8ImygN/q88RT
         XFA8PxeCoRj+42sMlSrxrBGrmO36g/ZOeEcQbWOncbsf5QaVtKy+Q0Rm2azO8hymMitz
         l8UFk3n6F5nc5y8CQNzcsZUSC7nWZPaEJIgBc+1tMZ18+vKggdedsexCHKXgPHRc9DJW
         6GX1WeSCZH0DJoHNzum8NFuppqiW3IqBVBrk2fgqxs7/vV4YKtFJADa85sMPYqVO3yWC
         ZNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkJmaZyXa0qnJQKIEoPV8/w271B2CRpKLAwKWy8RIwE=;
        b=QFVBwfJcb5ndGMV1ywIn8AIeKPNr8R8XD+rlzvYLw2XJmhChg0LnlrCQUcQLMTiTmO
         0ivOkCK6ufjQALbXEFUk/EwusC1vthoo6LfjN1QtPugz5lZ5fcYTMNisLocWasKvv/ra
         2BgcndaxgWG2rrpeCmhKDmBPW6FPdNCuxBWeBzp3xO3gcI7Ri5puyKRNVDJ5FuOTyuup
         FsrcNPzDG+Y9EK9dJW4WzioBPcybCRPb5tgvDgEUGMgUCtQGh4ZdSq2lPnljwnqeZdBq
         fvzLFdXCG3C3J+YWQMjnn/3DdAM0VpVgpSKn0lJ7yRT7BYwtKG4mRBAzQIapICXgdMda
         JP6w==
X-Gm-Message-State: AOAM530w+csuOaDkuBNPkaWXm8E5YKOBD1Y4fN4jdy26W5ziomYt9zLf
        Z8paGWF19AU8EZ4x2jeTE/8ksPvItDCBwg==
X-Google-Smtp-Source: ABdhPJwe4K98YcmCQetAJiRqjf8DtF/oX9XfxdCuOTp2RuNSL8JAQ03vIVwwHEGH5PzKfB8k/YAN9Q==
X-Received: by 2002:a19:c3d5:: with SMTP id t204mr20125107lff.303.1637202023686;
        Wed, 17 Nov 2021 18:20:23 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/16] power: supply: ab8500: Make recharge capacity a constant
Date:   Thu, 18 Nov 2021 03:17:48 +0100
Message-Id: <20211118021752.2262818-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The recharge capacity is the hysteresis level for a charger to
restart when a battery does not support maintenance charging.

All products using the AB8500 have batteries supporting
maintenace charging and all code has always set this to 95%.

Turn it into a constant.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h       |  4 ----
 drivers/power/supply/ab8500_bmdata.c   |  1 -
 drivers/power/supply/ab8500_chargalg.c | 10 ++++++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 949e6d9f13c7..5f515d2a2260 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -374,9 +374,6 @@ struct ab8500_maxim_parameters {
  * struct ab8500_battery_type - different batteries supported
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @recharge_cap		battery capacity limit that will trigger a new
- *				full charging cycle in the case where maintenan-
- *				-ce charging has been disabled
  * @normal_cur_lvl:		charger current in normal state in mA
  * @normal_vol_lvl:		charger voltage in normal state in mV
  * @maint_a_cur_lvl:		charger current in maintenance A state in mA
@@ -397,7 +394,6 @@ struct ab8500_maxim_parameters {
 struct ab8500_battery_type {
 	int resis_high;
 	int resis_low;
-	int recharge_cap;
 	int normal_cur_lvl;
 	int normal_vol_lvl;
 	int maint_a_cur_lvl;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 1e43c9f751e1..18d83a0e5a7d 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -83,7 +83,6 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.recharge_cap = 95,
 	.normal_cur_lvl = 400,
 	.normal_vol_lvl = 4100,
 	.maint_a_cur_lvl = 400,
diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 49e7167d0362..90974a8887cd 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -49,6 +49,13 @@
 #define CHARGALG_CURR_STEP_LOW		0
 #define CHARGALG_CURR_STEP_HIGH	100
 
+/*
+ * This is the battery capacity limit that will trigger a new
+ * full charging cycle in the case where maintenance charging
+ * has been disabled
+ */
+#define AB8500_RECHARGE_CAP		95
+
 enum ab8500_chargers {
 	NO_CHG,
 	AC_CHG,
@@ -1544,8 +1551,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 		fallthrough;
 
 	case STATE_WAIT_FOR_RECHARGE:
-		if (di->batt_data.percent <=
-		    di->bm->bat_type->recharge_cap)
+		if (di->batt_data.percent <= AB8500_RECHARGE_CAP)
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
-- 
2.31.1

