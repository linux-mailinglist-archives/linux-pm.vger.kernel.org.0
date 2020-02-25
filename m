Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2804C16BCB8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 09:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgBYIyk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 03:54:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46647 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgBYIyk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 03:54:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so13068458ljd.13;
        Tue, 25 Feb 2020 00:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JWL/gFL8qBSVx9TomuVyL56WbqVwJiBjGf03oY0bgSw=;
        b=n4tMn5dm2EC1nvOcAnjV+kuevr18ERe8hoSrwzaxwrreDgOaDdoEwOi9zPlIrwOsSr
         CXv7tunS6duAw1bwhOBTr37dWVaiRJR5LnPOwRUbFnpQOsMnAbbXE4JSzxN4/cLP+k1l
         M1Sx2IfVmhc/SpcXd8Saut2TkHZR0+99W7b8UT9vPS0YLZuG5DUAO/iYqVL2UKNXsrTq
         ducXN7Y5LWtN9B49ocup8KKWDqg/OjdUSXReZHqMHIrWr5Fe3vbIbMC2d8eoiiaIYM2m
         V/npZHYgNnMExrOZsragG3agdeA1OpRa2w3r2sC8EHlOmW79XkdlbT+K/InUHHHAnVCF
         xz2Q==
X-Gm-Message-State: APjAAAUya4Qsy6IY1ijelZGKraDKb1IHG9CSWw1w0s3evxF1OUmyfTvl
        V2Bw8PNmA49Th4vS7Qbf4CWJMxeQ
X-Google-Smtp-Source: APXvYqwNeOoZYbO49vKeRR5kDrDtBubVlfCX7+YekXHKQcwaxb7jF2hH1BPmHC3yRZ4RV2IjkdrNIg==
X-Received: by 2002:a2e:8651:: with SMTP id i17mr33624196ljj.121.1582620877762;
        Tue, 25 Feb 2020 00:54:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y21sm6986669lfy.46.2020.02.25.00.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:54:37 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:54:25 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [PATCH v4 6/9] regulator: use linear_ranges helper
Message-ID: <1deb837ed325b25e4e5bc878f2ddcb733b441a82.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the regulator helpers to use common linear_ranges code.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

no changes since rfc-v3

 drivers/regulator/Kconfig        |   1 +
 drivers/regulator/helpers.c      | 124 ++++++++++++++-----------------
 include/linux/regulator/driver.h |  25 +------
 3 files changed, 59 insertions(+), 91 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 074a2ef55943..1fd2fe2b0c7a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig REGULATOR
 	bool "Voltage and Current Regulator Support"
+	select LINEAR_RANGES
 	help
 	  Generic Voltage and Current Regulator support.
 
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index d436cc867d10..e970e9d2f8be 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -131,10 +131,11 @@ int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
 	unsigned int r_val;
 	int range;
 	unsigned int val;
-	int ret, i;
-	unsigned int voltages_in_range = 0;
+	int ret;
+	unsigned int voltages = 0;
+	const struct linear_range *r = rdev->desc->linear_ranges;
 
-	if (!rdev->desc->linear_ranges)
+	if (!r)
 		return -EINVAL;
 
 	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
@@ -152,11 +153,9 @@ int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
 	if (range < 0)
 		return -EINVAL;
 
-	for (i = 0; i < range; i++)
-		voltages_in_range += (rdev->desc->linear_ranges[i].max_sel -
-				     rdev->desc->linear_ranges[i].min_sel) + 1;
+	voltages = linear_range_values_in_range_array(r, range);
 
-	return val + voltages_in_range;
+	return val + voltages;
 }
 EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_pickable_regmap);
 
@@ -179,8 +178,11 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 	unsigned int voltages_in_range = 0;
 
 	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
-		voltages_in_range = (rdev->desc->linear_ranges[i].max_sel -
-				     rdev->desc->linear_ranges[i].min_sel) + 1;
+		const struct linear_range *r;
+
+		r = &rdev->desc->linear_ranges[i];
+		voltages_in_range = linear_range_values_in_range(r);
+
 		if (sel < voltages_in_range)
 			break;
 		sel -= voltages_in_range;
@@ -407,6 +409,8 @@ int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 {
 	const struct linear_range *range;
 	int ret = -EINVAL;
+	unsigned int sel;
+	bool found;
 	int voltage, i;
 
 	if (!rdev->desc->n_linear_ranges) {
@@ -415,35 +419,19 @@ int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 	}
 
 	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
-		int linear_max_uV;
-
 		range = &rdev->desc->linear_ranges[i];
-		linear_max_uV = range->min_uV +
-			(range->max_sel - range->min_sel) * range->uV_step;
 
-		if (!(min_uV <= linear_max_uV && max_uV >= range->min_uV))
+		ret = linear_range_get_selector_high(range, min_uV, &sel,
+						     &found);
+		if (ret)
 			continue;
-
-		if (min_uV <= range->min_uV)
-			min_uV = range->min_uV;
-
-		/* range->uV_step == 0 means fixed voltage range */
-		if (range->uV_step == 0) {
-			ret = 0;
-		} else {
-			ret = DIV_ROUND_UP(min_uV - range->min_uV,
-					   range->uV_step);
-			if (ret < 0)
-				return ret;
-		}
-
-		ret += range->min_sel;
+		ret = sel;
 
 		/*
 		 * Map back into a voltage to verify we're still in bounds.
 		 * If we are not, then continue checking rest of the ranges.
 		 */
-		voltage = rdev->desc->ops->list_voltage(rdev, ret);
+		voltage = rdev->desc->ops->list_voltage(rdev, sel);
 		if (voltage >= min_uV && voltage <= max_uV)
 			break;
 	}
@@ -480,30 +468,25 @@ int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
 
 	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
 		int linear_max_uV;
+		bool found;
+		unsigned int sel;
 
 		range = &rdev->desc->linear_ranges[i];
-		linear_max_uV = range->min_uV +
-			(range->max_sel - range->min_sel) * range->uV_step;
+		linear_max_uV = linear_range_get_max_value(range);
 
-		if (!(min_uV <= linear_max_uV && max_uV >= range->min_uV)) {
-			selector += (range->max_sel - range->min_sel + 1);
+		if (!(min_uV <= linear_max_uV && max_uV >= range->min)) {
+			selector += linear_range_values_in_range(range);
 			continue;
 		}
 
-		if (min_uV <= range->min_uV)
-			min_uV = range->min_uV;
-
-		/* range->uV_step == 0 means fixed voltage range */
-		if (range->uV_step == 0) {
-			ret = 0;
-		} else {
-			ret = DIV_ROUND_UP(min_uV - range->min_uV,
-					   range->uV_step);
-			if (ret < 0)
-				return ret;
+		ret = linear_range_get_selector_high(range, min_uV, &sel,
+						     &found);
+		if (ret) {
+			selector += linear_range_values_in_range(range);
+			continue;
 		}
 
-		ret += selector;
+		ret = selector + sel;
 
 		voltage = rdev->desc->ops->list_voltage(rdev, ret);
 
@@ -513,7 +496,7 @@ int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
 		 * exit but retry until we have checked all ranges.
 		 */
 		if (voltage < min_uV || voltage > max_uV)
-			selector += (range->max_sel - range->min_sel + 1);
+			selector += linear_range_values_in_range(range);
 		else
 			break;
 	}
@@ -571,18 +554,28 @@ int regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
 	}
 
 	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
-		unsigned int sels_in_range;
+		unsigned int sel_indexes;
 
 		range = &rdev->desc->linear_ranges[i];
 
-		sels_in_range = range->max_sel - range->min_sel;
+		sel_indexes = linear_range_values_in_range(range) - 1;
 
-		if (all_sels + sels_in_range >= selector) {
+		if (all_sels + sel_indexes >= selector) {
 			selector -= all_sels;
-			return range->min_uV + (range->uV_step * selector);
+			/*
+			 * As we see here, pickable ranges work only as
+			 * long as the first selector for each pickable
+			 * range is 0, and the each subsequent range for
+			 * this 'pick' follow immediately at next unused
+			 * selector (Eg. there is no gaps between ranges).
+			 * I think this is fine but it probably should be
+			 * documented. OTOH, whole pickable range stuff
+			 * might benefit from some documentation
+			 */
+			return range->min + (range->step * selector);
 		}
 
-		all_sels += (sels_in_range + 1);
+		all_sels += (sel_indexes + 1);
 	}
 
 	return -EINVAL;
@@ -604,27 +597,18 @@ EXPORT_SYMBOL_GPL(regulator_list_voltage_pickable_linear_range);
 int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 					     unsigned int selector)
 {
-	const struct linear_range *range;
-	int i;
-
-	if (!desc->n_linear_ranges) {
-		BUG_ON(!desc->n_linear_ranges);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < desc->n_linear_ranges; i++) {
-		range = &desc->linear_ranges[i];
-
-		if (!(selector >= range->min_sel &&
-		      selector <= range->max_sel))
-			continue;
+	unsigned int val;
+	int ret;
 
-		selector -= range->min_sel;
+	BUG_ON(!desc->n_linear_ranges);
 
-		return range->min_uV + (range->uV_step * selector);
-	}
+	ret = linear_range_get_value_array(desc->linear_ranges,
+					   desc->n_linear_ranges, selector,
+					   &val);
+	if (ret)
+		return ret;
 
-	return -EINVAL;
+	return val;
 }
 EXPORT_SYMBOL_GPL(regulator_desc_list_voltage_linear_range);
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 8419a4321775..7a3982da8868 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -13,6 +13,7 @@
 #define __LINUX_REGULATOR_DRIVER_H_
 
 #include <linux/device.h>
+#include <linux/linear_range.h>
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
 #include <linux/ww_mutex.h>
@@ -39,31 +40,13 @@ enum regulator_status {
 	REGULATOR_STATUS_UNDEFINED,
 };
 
-/**
- * struct linear_range - specify linear voltage ranges
- *
- * Specify a range of voltages for regulator_map_linear_range() and
- * regulator_list_linear_range().
- *
- * @min_uV:  Lowest voltage in range
- * @min_sel: Lowest selector for range
- * @max_sel: Highest selector for range
- * @uV_step: Step size
- */
-struct linear_range {
-	unsigned int min_uV;
-	unsigned int min_sel;
-	unsigned int max_sel;
-	unsigned int uV_step;
-};
-
-/* Initialize struct linear_range */
+/* Initialize struct linear_range for regulators */
 #define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
 {									\
-	.min_uV		= _min_uV,					\
+	.min		= _min_uV,					\
 	.min_sel	= _min_sel,					\
 	.max_sel	= _max_sel,					\
-	.uV_step	= _step_uV,					\
+	.step		= _step_uV,					\
 }
 
 /**
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
