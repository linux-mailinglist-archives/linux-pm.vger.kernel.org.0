Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413AD455293
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbhKRCXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbhKRCXL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD2C061570
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:12 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l22so17864092lfg.7
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9j/+9vNRUOuE2OUGHIWjiFJX54aRqGsYS2DHbcFsR74=;
        b=bOu49EpG1z6ALVV4/cXJHXcvwA+h6l2/XujvF1+xwf7lfxqKheAdiseTR0c85ecnjh
         1QAAg5jIHYC7mJacGY6DbUr/djnKrwcaqwjqdMyAZ1Ldh7KUE231PcVC4/4CFYdzuw0d
         NLKTt/ZylmGR8e56X9sobV3O5xra0QY/BhDL7l6B/6k7dWgkOrU5t20TxboxKKFOiWAk
         2sVRILXMQYn3Y41rVjh435GxlWlwbczEpSxjj17PqUevh31YN3UvGEPYRYgn7LkI9GTs
         uaLy56cr29CpZ/DAIewud+U3oN1RPaZzFh0sU3IWvQTjjzMWt+4V3zuw8W5xPsGOSzZi
         xbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9j/+9vNRUOuE2OUGHIWjiFJX54aRqGsYS2DHbcFsR74=;
        b=jLcRHMzPdJhTCLt1+KST2sBRhnpCkLYPxJ6w3IkwNTmwZoosXIIme4dwSOMnuw4Z9o
         FlWwEXjvZ9Mq8S/SwpjXVpA3b+SiY4bBv+itzT5ihICd0SlqtuEz4uN2+QKzf/U3pumD
         E/p2P7H4F6abyBdJ/5e6Dkp3itKs/+LbXv/8oGdS1vIM5AU8rstvG4AQ0bU14RA7Shfa
         Y2lyk0BdPmWSCpQbivzCVfKkUV/R2TWcYJNVHUvPeKdCutQMdNk7U0dNbx9cSMoo81gF
         tyK1ceyKegKp+CfiaXdXTknY15rnbnM2q7G89I1wJXDxooC6HS4qvZdG+oBIEYP8A21N
         FcJQ==
X-Gm-Message-State: AOAM532e3MRyLIXEO6fAtNbIexM3eS2BL+uHXPkfjMaK8z2qY3LtoMlc
        HVr2CyJJpJNzqKmU+t7DXKTDyw==
X-Google-Smtp-Source: ABdhPJwWBe3Q+je0o/XZ3VD9hHvBEeY9DxkK2sCrD5JWBRFFobrBD3Nq/ag/t0uBNuuVxmmTCcxgvA==
X-Received: by 2002:a2e:a696:: with SMTP id q22mr12656342lje.423.1637202010412;
        Wed, 17 Nov 2021 18:20:10 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:09 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/16] power: supply: ab8500: Standardize design capacity
Date:   Thu, 18 Nov 2021 03:17:42 +0100
Message-Id: <20211118021752.2262818-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
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
 drivers/power/supply/ab8500-bm.h     | 2 --
 drivers/power/supply/ab8500_bmdata.c | 5 ++++-
 drivers/power/supply/ab8500_fg.c     | 8 ++------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 9c96722f33d6..79c00808a372 100644
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
index 17c9b8700883..6e876ba03956 100644
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

