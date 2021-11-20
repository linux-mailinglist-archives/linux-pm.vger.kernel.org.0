Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF847457F22
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhKTP64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:58:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD80C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u3so58001898lfl.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AqL/UaCohebAVwKNo7ZLa3hBVlLeyB88cj1Sj1iaUVk=;
        b=F0WPzvEkyOLH4rK+XjpaJUMO1g647Kg9K5kAL3RCHDhKP6bEP8s64Mm8743jE0tgoz
         K4ezWDyf+mqsJOAYk9WxBj6vRnGloCeiIzz2HaBV4pSSCp2jjlKUp/1PqzF1wrcY6DY0
         RPfGvpSOMmMX83/d5vboFpfpvm7fSonlIPilPlgXPg/XTOLAdrVXtzfAg8O43LB5xQ3d
         PgddZo2e9H3ehgeVW1WdcAnRyrR2yKT0n+eETn+x9J39w7Y1yR8Xv48y+S6iRHynac+1
         YptPCGp1R/jtrsONtkZ6TTA6hmTcw8jVyQ68WNesy0g5Rp+kjW/9mY5JoJlDOBKRD/Dr
         P2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AqL/UaCohebAVwKNo7ZLa3hBVlLeyB88cj1Sj1iaUVk=;
        b=xD+dDAve56bnvegu7RmZMo+B6rE2fL6EP1q/7P/HrMzx/HOOn3TJgRkDI3zrZeCM/j
         k9uwGZa3S446e+aVMrNyEuKBaLlYh89qkezF0T91aanNJDCXA6mRY4KjDxGORqi93E7E
         fVBEXV/IPpnBOyT3w5v3rFErdAxrB598tfyjt5nJ2ImZnd3sNJdMRThVLacDpxJ5pF1D
         P4LpBcTlRD4Oo6SSt9C/bhO9lWRva+C1t6uW3o6miz1K1eGgdT83pNlVXRhZyHDd+u6p
         zsmAMYMjBMOsIZICi9wvSg/7hH1CihG090IVfd8jsF96YrxfwdjzU8syclYMFJpvG9N7
         dAow==
X-Gm-Message-State: AOAM533vdqxXv1WZ68TAUmfWVK1QdPUUXuRH5K8oSVDlkkpsNRDCYgE0
        sNouPEZyodEyjZOS6UhrbEmqa/1/TQZ1ZQ==
X-Google-Smtp-Source: ABdhPJzLmBQ5uP1IAVNtpdFhtoN+7Q0RLQRZiMa4N3lvVzZBxNfbSY4paE2KQwwar5N3qrCiTL14Gw==
X-Received: by 2002:a05:6512:3f1a:: with SMTP id y26mr41181669lfa.372.1637423751220;
        Sat, 20 Nov 2021 07:55:51 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:50 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 06/16] power: supply: ab8500: Standardize design capacity
Date:   Sat, 20 Nov 2021 16:53:16 +0100
Message-Id: <20211120155326.2891664-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that we know that we have only one battery type to
deal with we can proceed to transfer properties to
struct power_supply_battery_info.

The designed capacity for the battery was in a custom field
of the custom battery type in mAh, transfer this to the
standard charge_full_design_uah property in
struct power_supply_battery_info and augment the code
accordingly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h     | 2 --
 drivers/power/supply/ab8500_bmdata.c | 5 ++++-
 drivers/power/supply/ab8500_fg.c     | 8 ++------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 99ada7f08ec7..a5cae9288274 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -375,7 +375,6 @@ struct ab8500_maxim_parameters {
  * @name:			battery technology
  * @resis_high:			battery upper resistance limit
  * @resis_low:			battery lower resistance limit
- * @charge_full_design:		Maximum battery capacity in mAh
  * @nominal_voltage:		Nominal voltage of the battery in mV
  * @termination_vol:		max voltage upto which battery can be charged
  * @termination_curr		battery charging termination current in mA
@@ -404,7 +403,6 @@ struct ab8500_battery_type {
 	int name;
 	int resis_high;
 	int resis_low;
-	int charge_full_design;
 	int nominal_voltage;
 	int termination_vol;
 	int termination_curr;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 5db13b026d81..2d328d3007a9 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -85,7 +85,6 @@ static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
 	.battery_resistance = 300,
-	.charge_full_design = 612,
 	.nominal_voltage = 3700,
 	.termination_vol = 4050,
 	.termination_curr = 200,
@@ -189,6 +188,10 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		return ret;
 	}
 
+	/* Fill in defaults for any data missing from the device tree */
+	if (bi->charge_full_design_uah < 0)
+		/* The default capacity is 612 mAh for unknown batteries */
+		bi->charge_full_design_uah = 612000;
 	if (bi->temp_min == INT_MIN)
 		bi->temp_min = AB8500_TEMP_UNDER;
 	if (bi->temp_max == INT_MAX)
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 2013db0118ee..4f8b3a76c565 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -38,7 +38,6 @@
 
 #include "ab8500-bm.h"
 
-#define MILLI_TO_MICRO			1000
 #define FG_LSB_IN_MA			1627
 #define QLSB_NANO_AMP_HOURS_X10		1071
 #define INS_CURR_TIMEOUT		(3 * HZ)
@@ -2243,8 +2242,7 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 					di->flags.batt_id_received = true;
 
 					di->bat_cap.max_mah_design =
-						MILLI_TO_MICRO *
-						b->charge_full_design;
+						di->bm->bi.charge_full_design_uah;
 
 					di->bat_cap.max_mah =
 						di->bat_cap.max_mah_design;
@@ -3078,9 +3076,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
 	psy_cfg.drv_data = di;
 
-	di->bat_cap.max_mah_design = MILLI_TO_MICRO *
-		di->bm->bat_type->charge_full_design;
-
+	di->bat_cap.max_mah_design = di->bm->bi.charge_full_design_uah;
 	di->bat_cap.max_mah = di->bat_cap.max_mah_design;
 
 	di->vbat_nom = di->bm->bat_type->nominal_voltage;
-- 
2.31.1

