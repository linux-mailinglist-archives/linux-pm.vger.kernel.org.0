Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7919966F
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgCaM0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 08:26:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33098 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgCaM0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 08:26:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id f20so21784398ljm.0;
        Tue, 31 Mar 2020 05:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S9FPxJtkvbs2QQbxNMkV4KX7hSoD+fUQ1BX8fpZW+PY=;
        b=Px3R+olFvb9Ut38OyX0+OMfo+isp7bNHI7+DYEceMUBeihVkq0W1XUr9pq43YXBW1t
         M0NXe3KhKAg53Fe+R+BlrdBzjNd7IK5ArMwzv9hj5e23vZnO+JHMoQH4dQc8ux2UGT7n
         GApHA++/mEsXodXFDYQ8Cer9uqDryyiSi+YNuBhq8kGEuluZeQxGFha9bN5HLbyfTZWQ
         YBGGYGvTHvJVtzc9UTH/pfIEzdcfu/qpizZGt/SXKagCzhY4b8Agd0wIPZ38AASZ1A7q
         M0ePcoou2tXj1qfJVpgZlrAg0fzTQbd1V7JWymVFU9pPAp4LlkU/I6s6RFgKBHpJwBs3
         jc4w==
X-Gm-Message-State: AGi0PubpM0sR5rX1swJrBpn0GR3GYphgpZVTZK/jnYMPfqCkD7yqZGyD
        GiZEcrYCbI6Ip1F+7bYn1Dg=
X-Google-Smtp-Source: APiQypICU+F92WBrMuDRM3M/ebu5bO1p5/lsWI6PARyEne/ujG/gsL6KV/8GObqa1Ju85m3LW63cmg==
X-Received: by 2002:a05:651c:92:: with SMTP id 18mr6281008ljq.141.1585657574412;
        Tue, 31 Mar 2020 05:26:14 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id e2sm6264453ljl.83.2020.03.31.05.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:26:13 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:26:06 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v7 07/10] power: supply: bd70528: use linear ranges
Message-ID: <3ad3cc1cfaffc85259af4499bf43f9ce3eb488e2.1585656144.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the bd70528 to use common linear_range code instead of
implementing a copy of it in this driver.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

No changes since v6

 drivers/power/supply/Kconfig           |   1 +
 drivers/power/supply/bd70528-charger.c | 144 ++++++++++---------------
 2 files changed, 56 insertions(+), 89 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9a5591ab90d0..8781c674ed07 100644
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
index 3b820110ecfa..7a805faeee83 100644
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
+		.max_sel = 0x12
 	},
 	{
 		.min = 200,
 		.step = 25,
-		.vals = 13,
-		.low_sel = 0x13,
+		.min_sel = 0x13,
+		.max_sel = 0x1f
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
