Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C72C0157446
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 13:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJMN2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 07:13:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33647 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgBJMN2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 07:13:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so6897109lji.0;
        Mon, 10 Feb 2020 04:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lHGMKqeMA2Au3oh56NUt8jI2nYccd7lFNWPVY5DVrc4=;
        b=OUqrHDS38QfeRJbs048OT24Sn5HsfT5fwEbbuqPj1gbxXLtIbiXBIrlZSIT19ASTZA
         J/AJknbrDuvHRLDrydonQ7YjkdIg0HqNdN9yCazKCZMmH+tyWa/ToSXMEUbxVwPsQLEP
         KKfGEi0qhi4Q4PmcEC4GEGmmZO6iexMc5V0R3dgswp1P8FOL+cyTT2ftOKsv4Kfob6AY
         V8sw9vziKUZmPhPywJI5L8+mvz5+KZs1lOsC6HBURsmBP1Ji6tXDzcWlHzow0wGu/0ts
         lPv1S2At4Zyk6lyhha7MiyD4EZfZcLQoKU6vDVGbGDl+MFd4gO95P849hM6kRBkXgu9k
         916A==
X-Gm-Message-State: APjAAAUSiomD0H2MXKLBi1Mmu/srses7YHvibxThXluLcT69mZTTRftu
        C8oKb0RR9vAepoE9T3NRs+0=
X-Google-Smtp-Source: APXvYqypmOWRxSX2DmxLjVhqcAcmZydEKdXFDghWPs6rMoj67jEO0dg3bSGXst0uv7GG1CPOozesHw==
X-Received: by 2002:a2e:8646:: with SMTP id i6mr789496ljj.122.1581336802770;
        Mon, 10 Feb 2020 04:13:22 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 138sm35685lfa.76.2020.02.10.04.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:13:22 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:13:13 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Message-ID: <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Many devices have control registers which control some measurable
property. Often a register contains control field so that change in
this field causes linear change in the controlled property. It is not
a rare case that user wants to give 'meaningfull' control values and
driver needs to convert them to register field values. Even more
often user wants to 'see' the currently set value - again in
meaningfull units - and driver needs to convert the values it reads
from register to these meaningfull units.

Provide a linear_range helper which can do conversion from user value
to register value 'selector'.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Mark, this is loosely bound to register handling... Do you think
the regmap could host these helpers?

 drivers/power/supply/Kconfig           |  4 ++
 drivers/power/supply/Makefile          |  1 +
 drivers/power/supply/bd70528-charger.c | 65 +++----------------
 drivers/power/supply/linear-ranges.h   | 36 +++++++++++
 drivers/power/supply/linear_ranges.c   | 89 ++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 57 deletions(-)
 create mode 100644 drivers/power/supply/linear-ranges.h
 create mode 100644 drivers/power/supply/linear_ranges.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 27164a1d3c7c..f5386d703310 100644
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
@@ -710,4 +711,7 @@ config CHARGER_WILCO
 	  information can be found in
 	  Documentation/ABI/testing/sysfs-class-power-wilco
 
+config LINEAR_RANGES
+	tristate
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 6c7da920ea83..985028cc2c16 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD70528)	+= bd70528-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
+obj-$(CONFIG_LINEAR_RANGES)	+= linear_ranges.o
diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index b8e1ec106627..63e2e33ca6a2 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -72,6 +72,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include "linear-ranges.h"
 
 #define CHG_STAT_SUSPEND	0x0
 #define CHG_STAT_TRICKLE	0x1
@@ -335,13 +336,6 @@ static int bd70528_get_present(struct bd70528_psy *bdpsy, int *val)
 	return 0;
 }
 
-struct linear_range {
-	int min;
-	int step;
-	int vals;
-	int low_sel;
-};
-
 static const struct linear_range current_limit_ranges[] = {
 	{
 		.min = 5,
@@ -398,56 +392,6 @@ static const struct linear_range warm_charge_curr[] = {
 #define MAX_WARM_CHG_CURR_SEL 0x1f
 #define MIN_CHG_CURR_SEL 0x0
 
-static int find_value_for_selector_low(const struct linear_range *r,
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
-static int find_selector_for_value_low(const struct linear_range *r,
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
@@ -588,6 +532,13 @@ static int set_charge_current(struct bd70528_psy *bdpsy, int ma)
 		goto set;
 	}
 
+/*
+ * For BD70528 voltage/current limits we happily accept any value which
+ * belongs the range. We could check if value matching the selector is
+ * desired by computing the range min + (sel - sel_low) * range step - but
+ * I guess it is enough if we use voltage/current which is closest (below)
+ * the requested?
+ */
 	ret = find_selector_for_value_low(&warm_charge_curr[0],
 					  ARRAY_SIZE(warm_charge_curr), ma,
 					  &reg, &found);
diff --git a/drivers/power/supply/linear-ranges.h b/drivers/power/supply/linear-ranges.h
new file mode 100644
index 000000000000..d4233c2a50ca
--- /dev/null
+++ b/drivers/power/supply/linear-ranges.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2020 ROHM Semiconductors */
+
+#ifndef _LINEAR_RANGES_H
+#define _LINEAR_RANGES_H
+
+#include <linux/types.h>
+
+/**
+ * struct linear_range - table of values incrementing with constant amount
+ *
+ * @min:	Smallest value in range
+ * @step:	Amount the value is incremented at each step
+ * @vals:	Amount of values in the range
+ * @low_sel:	Index (selector) matching smallest value
+ *
+ * Define a lookup-table for range of values. Intended to help when looking
+ * for a register value matching certaing physical measure (like voltage).
+ * Usable when increment of one in register always causes a constant increment
+ * of the physical measure (like voltage).
+ */
+struct linear_range {
+	int min;
+	int step;
+	int vals;
+	int low_sel;
+};
+
+int find_selector_for_value_low(const struct linear_range *r, int ranges,
+				unsigned int val, unsigned int *sel,
+				bool *found);
+
+int find_value_for_selector_low(const struct linear_range *r, int ranges,
+				unsigned int sel, unsigned int *val);
+
+#endif
diff --git a/drivers/power/supply/linear_ranges.c b/drivers/power/supply/linear_ranges.c
new file mode 100644
index 000000000000..f79dfec0363a
--- /dev/null
+++ b/drivers/power/supply/linear_ranges.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2020 Rohm Semiconductors
+
+#include "linear-ranges.h"
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+/**
+ * find_value_for_selector_low - find value matching given selector
+ *
+ * r:		array of ranges
+ * ranges:	amount of ranges in an array
+ * sel:		selector for which we are searching the value
+ * val:		pointer in which the value will be stored.
+ *
+ * Search the given table of ranges starting from lowest range index and
+ * return the value which matches given selector.
+ *
+ * Returns 0 on success and -EINVAL if selector is not within given
+ * ranges.
+ */
+int find_value_for_selector_low(const struct linear_range *r, int ranges,
+				unsigned int sel, unsigned int *val)
+{
+	int i;
+
+	for (i = 0; i < ranges; i++) {
+		if (r[i].low_sel <= sel && r[i].low_sel + r[i].vals >= sel) {
+			*val = r[i].min + (sel - r[i].low_sel) * r[i].step;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+EXPORT_SYMBOL(find_value_for_selector_low);
+
+/**
+ * find_selector_for_value_low - find selector matching given value
+ *
+ * r:		array of ranges
+ * ranges:	amount of ranges in an array
+ * val:		value for which we are searching the selector
+ * sel:		pointer in which we are storing the found selector
+ * found:	whether the given value was in the range
+ *
+ * Search the given table of ranges @r starting from lowest range index and
+ * return the selector @sel pointing at range-value which is lower or equal to
+ * the given value @val. The @found is set to false if given value was greater
+ * than the maximum value in given ranges and @sel is then set to biggest
+ * selector in the last range which minimum is smaller than @val. The @found
+ * is set to true if given value @val was in the range.
+ *
+ * Returns 0 on success and -EINVAL if value is smaller than minimum of the
+ * given ranges.
+ */
+int find_selector_for_value_low(const struct linear_range *r, int ranges,
+				unsigned int val, unsigned int *sel,
+				bool *found)
+{
+	int i;
+	int ret = -EINVAL;
+
+	*found = false;
+	for (i = 0; i < ranges; i++) {
+		if (r[i].min <= val) {
+			if (r[i].min + r[i].step * r[i].vals >= val) {
+				*found = true;
+				*sel = r[i].low_sel + (val - r[i].min) /
+				       r[i].step;
+				ret = 0;
+				break;
+			}
+			/*
+			 * If the range max is smaller than requested
+			 * we set the max supported value from range
+			 */
+			*sel = r[i].low_sel + r[i].vals;
+			ret = 0;
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL(find_selector_for_value_low);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("Linear range helpers");
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
