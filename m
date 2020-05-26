Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9F1CB3D1
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgEHPpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:45:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34832 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHPpm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 11:45:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id g4so2172618ljl.2;
        Fri, 08 May 2020 08:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9gYLaHYZJKZckAryntApHd1C+vXPx8xLJKhLTIvXSY=;
        b=Dkihip5gLtQi6wr7fAekMFRzge0DOGLBG43nLxsmYvldhLDvhH6RQFTGlhwGGFVjGW
         sPI7kU71X7pdddsmXN1ewZU3Mg2+YzWsekafFxXJd8bsDhSSoZr/xNbVqZkCYv5LUXKq
         tk+nzZ3Y8P75vJwYEmH9VA7CzGl69lBnMrn8mE30Ds2DijZ/ej/C0mFfMTZ9Sy+ZxOGG
         YB236yrvMtAAFiqv+HLo74GgibwQdexrxGNfiuSX/6FosHj1Uo3LjEka4qVxAI7myH1Y
         8Hgy0LdlZcAO+QiUTsKZbvTNiJEu6P/YdIuke98XdSzVW9cgo/A3EB2GS/cGLBNz5FMs
         Dkug==
X-Gm-Message-State: AOAM531tQTD5MKWh34Fkg89MmQvD8A/YsqKQATet7CNJ5eueBpvafDRU
        9aLLbqv7tyoDbw0UN+CsAdM=
X-Google-Smtp-Source: ABdhPJz/TSluaqTPI9YgOwnoCghL3uo5gIoWekqagbcmMpPFY606cgReVrBBAtGztw5sRu4x8VSaMw==
X-Received: by 2002:a05:651c:1121:: with SMTP id e1mr2111226ljo.205.1588952737591;
        Fri, 08 May 2020 08:45:37 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id m6sm1632978ljp.32.2020.05.08.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 08:45:37 -0700 (PDT)
Date:   Fri, 8 May 2020 18:44:45 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 05/11] power: supply: bd70528: use linear ranges
Message-ID: <46fa0d17ac06aeda054d2080fb39693c6eabfea6.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the bd70528 to use common linear_range code instead of
implementing a copy of it in this driver.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/Kconfig           |   1 +
 drivers/power/supply/bd70528-charger.c | 144 ++++++++++---------------
 2 files changed, 56 insertions(+), 89 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index f3424fdce341..9f19636db922 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -695,6 +695,7 @@ config CHARGER_UCS1002
 config CHARGER_BD70528
 	tristate "ROHM bd70528 charger driver"
 	depends on MFD_ROHM_BD70528
+	select LINEAR_RANGES
 	default n
 	help
 	 Say Y here to enable support for getting battery status
diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index 3b820110ecfa..7c1f0b99c71b 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -72,6 +72,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/linear_range.h>
 
 #define CHG_STAT_SUSPEND	0x0
 #define CHG_STAT_TRICKLE	0x1
@@ -335,38 +336,37 @@ static int bd70528_get_present(struct bd70528_psy *bdpsy, int *val)
 	return 0;
 }
 
-struct bd70528_linear_range {
-	int min;
-	int step;
-	int vals;
-	int low_sel;
-};
-
-static const struct bd70528_linear_range current_limit_ranges[] = {
+static const struct linear_range current_limit_ranges[] = {
 	{
 		.min = 5,
 		.step = 1,
-		.vals = 36,
-		.low_sel = 0,
+		.min_sel = 0,
+		.max_sel = 0x22,
 	},
 	{
 		.min = 40,
 		.step = 5,
-		.vals = 5,
-		.low_sel = 0x23,
+		.min_sel = 0x23,
+		.max_sel = 0x26,
 	},
 	{
 		.min = 60,
 		.step = 20,
-		.vals = 8,
-		.low_sel = 0x27,
+		.min_sel = 0x27,
+		.max_sel = 0x2d,
 	},
 	{
 		.min = 200,
 		.step = 50,
-		.vals = 7,
-		.low_sel = 0x2e,
-	}
+		.min_sel = 0x2e,
+		.max_sel = 0x34,
+	},
+	{
+		.min = 500,
+		.step = 0,
+		.min_sel = 0x35,
+		.max_sel = 0x3f,
+	},
 };
 
 /*
@@ -374,18 +374,18 @@ static const struct bd70528_linear_range current_limit_ranges[] = {
  * voltage for low temperatures. The driver currently only reads
  * the charge current at room temperature. We do set both though.
  */
-static const struct bd70528_linear_range warm_charge_curr[] = {
+static const struct linear_range warm_charge_curr[] = {
 	{
 		.min = 10,
 		.step = 10,
-		.vals = 20,
-		.low_sel = 0,
+		.min_sel = 0,
+		.max_sel = 0x12,
 	},
 	{
 		.min = 200,
 		.step = 25,
-		.vals = 13,
-		.low_sel = 0x13,
+		.min_sel = 0x13,
+		.max_sel = 0x1f,
 	},
 };
 
@@ -398,56 +398,6 @@ static const struct bd70528_linear_range warm_charge_curr[] = {
 #define MAX_WARM_CHG_CURR_SEL 0x1f
 #define MIN_CHG_CURR_SEL 0x0
 
-static int find_value_for_selector_low(const struct bd70528_linear_range *r,
-				       int selectors, unsigned int sel,
-				       unsigned int *val)
-{
-	int i;
-
-	for (i = 0; i < selectors; i++) {
-		if (r[i].low_sel <= sel && r[i].low_sel + r[i].vals >= sel) {
-			*val = r[i].min + (sel - r[i].low_sel) * r[i].step;
-			return 0;
-		}
-	}
-	return -EINVAL;
-}
-
-/*
- * For BD70528 voltage/current limits we happily accept any value which
- * belongs the range. We could check if value matching the selector is
- * desired by computing the range min + (sel - sel_low) * range step - but
- * I guess it is enough if we use voltage/current which is closest (below)
- * the requested?
- */
-static int find_selector_for_value_low(const struct bd70528_linear_range *r,
-				       int selectors, unsigned int val,
-				       unsigned int *sel, bool *found)
-{
-	int i;
-	int ret = -EINVAL;
-
-	*found = false;
-	for (i = 0; i < selectors; i++) {
-		if (r[i].min <= val) {
-			if (r[i].min + r[i].step * r[i].vals >= val) {
-				*found = true;
-				*sel = r[i].low_sel + (val - r[i].min) /
-				       r[i].step;
-				ret = 0;
-				break;
-			}
-			/*
-			 * If the range max is smaller than requested
-			 * we can set the max supported value from range
-			 */
-			*sel = r[i].low_sel + r[i].vals;
-			ret = 0;
-		}
-	}
-	return ret;
-}
-
 static int get_charge_current(struct bd70528_psy *bdpsy, int *ma)
 {
 	unsigned int sel;
@@ -463,9 +413,9 @@ static int get_charge_current(struct bd70528_psy *bdpsy, int *ma)
 
 	sel &= BD70528_MASK_CHG_CHG_CURR;
 
-	ret = find_value_for_selector_low(&warm_charge_curr[0],
-					  ARRAY_SIZE(warm_charge_curr), sel,
-					  ma);
+	ret = linear_range_get_value_array(&warm_charge_curr[0],
+					   ARRAY_SIZE(warm_charge_curr),
+					   sel, ma);
 	if (ret) {
 		dev_err(bdpsy->dev,
 			"Unknown charge current value 0x%x\n",
@@ -491,10 +441,9 @@ static int get_current_limit(struct bd70528_psy *bdpsy, int *ma)
 
 	sel &= BD70528_MASK_CHG_DCIN_ILIM;
 
-	ret = find_value_for_selector_low(&current_limit_ranges[0],
-					  ARRAY_SIZE(current_limit_ranges), sel,
-					  ma);
-
+	ret = linear_range_get_value_array(&current_limit_ranges[0],
+					   ARRAY_SIZE(current_limit_ranges),
+					   sel, ma);
 	if (ret) {
 		/* Unspecified values mean 500 mA */
 		*ma = 500;
@@ -588,15 +537,28 @@ static int set_charge_current(struct bd70528_psy *bdpsy, int ma)
 		goto set;
 	}
 
-	ret = find_selector_for_value_low(&warm_charge_curr[0],
-					  ARRAY_SIZE(warm_charge_curr), ma,
-					  &reg, &found);
+/*
+ * For BD70528 voltage/current limits we happily accept any value which
+ * belongs the range. We could check if value matching the selector is
+ * desired by computing the range min + (sel - sel_low) * range step - but
+ * I guess it is enough if we use voltage/current which is closest (below)
+ * the requested?
+ */
+
+	ret = linear_range_get_selector_low_array(warm_charge_curr,
+						  ARRAY_SIZE(warm_charge_curr),
+						  ma, &reg, &found);
 	if (ret) {
+		dev_err(bdpsy->dev,
+			 "Unsupported charge current %u mA\n", ma);
 		reg = MIN_CHG_CURR_SEL;
 		goto set;
 	}
 	if (!found) {
-		/* There was a gap in supported values and we hit it */
+		/*
+		 * There was a gap in supported values and we hit it.
+		 * Yet a smaller value was found so we use it.
+		 */
 		dev_warn(bdpsy->dev,
 			 "Unsupported charge current %u mA\n", ma);
 	}
@@ -648,17 +610,21 @@ static int set_current_limit(struct bd70528_psy *bdpsy, int ma)
 		goto set;
 	}
 
-	ret = find_selector_for_value_low(&current_limit_ranges[0],
-					  ARRAY_SIZE(current_limit_ranges), ma,
-					  &reg, &found);
+	ret = linear_range_get_selector_low_array(current_limit_ranges,
+					ARRAY_SIZE(current_limit_ranges),
+					ma, &reg, &found);
 	if (ret) {
+		dev_err(bdpsy->dev, "Unsupported current limit %umA\n", ma);
 		reg = MIN_CURR_LIMIT_SEL;
 		goto set;
 	}
 	if (!found) {
-		/* There was a gap in supported values and we hit it ?*/
-		dev_warn(bdpsy->dev, "Unsupported current limit %umA\n",
-			 ma);
+		/*
+		 * There was a gap in supported values and we hit it.
+		 * We found a smaller value from ranges and use it.
+		 * Warn user though.
+		 */
+		dev_warn(bdpsy->dev, "Unsupported current limit %umA\n", ma);
 	}
 
 set:
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
