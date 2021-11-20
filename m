Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E3457F28
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbhKTP7L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbhKTP7J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:59:09 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48065C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:05 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m27so57805018lfj.12
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SvJOFslJOE99OqDOXF5oC29C66NF7zsKBliDZH/ke1Q=;
        b=xBov3XmLBMjpUGAOCYUMPUS4CGE1ZaxyZGaV4HKSCkeNnkRiEa8145z/hHf36/imkS
         addltcpD/ewucHFHcaUO2rtV+18kZ7x32naE9DsbqnwDRbEcu/HeGvTWb7vdjxF8j0pK
         SxjpIaz7qDR9hUrXMkrohq16xeCHgh1In7GRZrWHqWgeYf8ft8gJHRC4eTlfNgLtp1TV
         lml1aOF6U6DrbUPAOb92NELDY22ymb9r3SfCyLKNvyaILybE2XpoJC93XFA2nbaB7dga
         oyjq3Z8KbE1Ar3E+qen6RX49vVfgme0pppDBAxs4ILPf2uD4bz3BeAo2U1ZguaZ7YQOc
         gW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvJOFslJOE99OqDOXF5oC29C66NF7zsKBliDZH/ke1Q=;
        b=3aHldpecavgvpoqrTl0MgXIul5FGnHsvo/vSSk6iuj/4M7H+AKsGrqiMEY3loHPCqw
         aER7nQM/6jbEeLgLy0V+GKiXix/oL/GxWSWz8d+yQK87CrpJ/PsgiD3g2HYLKPVRaKu3
         S4dy3aFdIOo5iQNxZViBFivbh039AVQIXPHVYLXae8SH3xfkp/RlbyO2sn1ekaO6xUl+
         5VNgrAA0BS0TN+KyTeNOhvWw6o5L1zDc0Qiz2JCqbOzMD3TEZo+7eYnD5mDUIsz7KgNo
         Xv90A+OenhWxvv2wND5VgefkzH3r/WGYv0mo38S2akWvIWkM6gqSimnS81OV/vm50JmE
         i/rQ==
X-Gm-Message-State: AOAM533DIieQgK2FWuoVH86PY/jArq6t6O7vISKnUXTlYSKu/2jKKARi
        RhwHpdBpkYOsNevPYm8MzZgQaLmm8ogGsw==
X-Google-Smtp-Source: ABdhPJxj4ow8fo0miiG6ruhOW0wY9xM5tpsfvVNoKYxmwLxlD2yNCbkJZ4YmI6UUfkq7sdzU4BjEZg==
X-Received: by 2002:a2e:9699:: with SMTP id q25mr34664590lji.6.1637423763654;
        Sat, 20 Nov 2021 07:56:03 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:56:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 12/16] power: supply: ab8500: Make recharge capacity a constant
Date:   Sat, 20 Nov 2021 16:53:22 +0100
Message-Id: <20211120155326.2891664-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h       |  4 ----
 drivers/power/supply/ab8500_bmdata.c   |  1 -
 drivers/power/supply/ab8500_chargalg.c | 10 ++++++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 4bc932109f63..58e4cb901076 100644
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
index cd1fc288314e..78182a396de7 100644
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

