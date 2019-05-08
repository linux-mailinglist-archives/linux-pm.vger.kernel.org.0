Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD26518122
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEHUic (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 16:38:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53569 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHUic (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 16:38:32 -0400
Received: by mail-it1-f194.google.com with SMTP id l10so6352229iti.3
        for <linux-pm@vger.kernel.org>; Wed, 08 May 2019 13:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQBFz1okmzo6p65rJ6h6JglvmDUI2R8q94Dv4BJb9Ng=;
        b=RCtguyaCjnAGNgvZ4CrD1XwaJ/lBYIi+QaFOPKkStOr47FvPaZ0k1v6PZ+9Yyshmn9
         NyeF19TUcgJEn07tN9XCewS2IriL3KKkJk8/LZriHgg6DRInMvF4rJoRvNmolF5q0M+o
         wPggGOdlOH29bkvFGudaPYTAUnbwn2XlGN0QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQBFz1okmzo6p65rJ6h6JglvmDUI2R8q94Dv4BJb9Ng=;
        b=NXrqOYLlv1RrE5BMG5KixPSVIMPgaKnmurVjNsVqO8XbSB8EMKQagTDE/i959SY+Jo
         z0JXsjfcBpUHrWHV1SEpWGiT6gYVzrl2mnIROXiIz1jTnMD97zo43NkJ6IZH1yaOlObo
         Fj6QBvCDopbAfzXQi0vLdr4BVwF4MsDUpIa3CZlRqVm5zGrWIJ2KQwqOVilag/QEStPW
         jSC2D16lnt54OLj9tT4LrMy6hrAMldjXzPtwproTsJMRCJq+cdmvRnPurkjkhPRybXBQ
         hvUDU3UqZpeNSvoX8/aMG3xLjPdCgHk5PU8gUwpBRATxzs/Wcgz4Fw3Tr/AJbXoRuR7U
         WliQ==
X-Gm-Message-State: APjAAAVw6I+PS+CspKNrUXHIor5ZIQxToeziK0kxx2GinqSTNeV3ZK/a
        d2V2D4uZBistbcbd31PIG8UzWQ==
X-Google-Smtp-Source: APXvYqx6XQl4B0mnHhbX/yXX1hsJFtMUDfIe9S79hkND75hFC3/5zQc2KjH0JLgtD6R5ZGu/qZnxsg==
X-Received: by 2002:a24:3c4c:: with SMTP id m73mr5451991ita.23.1557347911209;
        Wed, 08 May 2019 13:38:31 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id l129sm96060ioa.28.2019.05.08.13.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 May 2019 13:38:30 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, derat@google.com,
        dtor@google.com, sjg@chromium.org, jchwong@chromium.org,
        tbroch@chromium.org, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v9 1/2] power_supply: wilco_ec: Add charging config driver
Date:   Wed,  8 May 2019 14:38:25 -0600
Message-Id: <20190508203826.120741-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a driver to control the charging algorithm used on Wilco
devices. See Documentation/ABI/testing/sysfs-class-power-wilco
for the userspace interface and other info.

Signed-off-by: Nick Crews <ncrews@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
v9 changes:
-Split up adding the driver and adding the device.
v8 changes:
-Several documentation and comment fixups.
v6 changes:
-Remove CHARGE_MODE_ILLEGAL from enum charge_mode. It's not a
 public type, and error checking could be performed in other ways.
-Split up the commit so properties are added in a first commit
-Move CONFIG_CHARGER_WILCO to the power/supply Kconfig
-Use PTR_ERR_OR_ZERO() macro in probe()
v5 changes:
-Remove OP_SYNC, it has no immediate use case.
-Merge properties.h into wilco-ec.h
-Remove enum get_set_sync_op from the public interface,
 since without OP_SYNC they are irrelevant.
-Fix Kconfigs and Makefiles so they actually work
 with the v4 changes
-Tweak some formatting, spacing, and comments
-Fix validation of charge_type so illegal values
 can't be set. Before negative error codes were
 accidentally getting casted to positive numbers
-Remove more unneeded parentheses.
v4 changes:
-Use put_unaligned_le32() to store PID in request.
-Move implementation from
 drivers/platform/chrome/wilco_ec/charge_config.c to
 drivers/power/supply/wilco_charger.c
-Move drivers/platform/chrome/wilco_ec/properties.h to
 include/linux/platform_data/wilco-ec-properties.h
-Remove parentheses in switch statement in psp_val_to_charge_mode()
-Check for any negatvie return code from psp_val_to_charge_mode()
 instead of just -EINVAL so its less brittle
-Tweak comments in wilco-ec-properties.h
v3 changes:
-Add this changelog
-Fix commit message tags
v2 changes:
-Update Documentation to say KernelVersion 5.2
-Update Documentation to explain Trickle mode better.
-rename things from using *PCC* to *CHARGE*
-Split up conversions between POWER_SUPPLY_PROP_CHARGE_TYPE values
and Wilco EC codes
-Use devm_ flavor of power_supply_register(), which simplifies things
-Add extra error checking on property messages received from the EC
-Fix bug in memcpy() calls in properties.c
-Refactor fill_property_id()
-Add valid input checks to charge_type
-Properly convert charge_type when get()ting

 .../ABI/testing/sysfs-class-power-wilco       |  30 +++
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/wilco-charger.c          | 187 ++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-wilco
 create mode 100644 drivers/power/supply/wilco-charger.c

diff --git a/Documentation/ABI/testing/sysfs-class-power-wilco b/Documentation/ABI/testing/sysfs-class-power-wilco
new file mode 100644
index 000000000000..da1d6ffe5e3c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-wilco
@@ -0,0 +1,30 @@
+What:		/sys/class/power_supply/wilco-charger/charge_type
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		What charging algorithm to use:
+
+		Standard: Fully charges battery at a standard rate.
+		Adaptive: Battery settings adaptively optimized based on
+			typical battery usage pattern.
+		Fast: Battery charges over a shorter period.
+		Trickle: Extends battery lifespan, intended for users who
+			primarily use their Chromebook while connected to AC.
+		Custom: A low and high threshold percentage is specified.
+			Charging begins when level drops below
+			charge_control_start_threshold, and ceases when
+			level is above charge_control_end_threshold.
+
+What:		/sys/class/power_supply/wilco-charger/charge_control_start_threshold
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		Used when charge_type="Custom", as described above. Measured in
+		percentages. The valid range is [50, 95].
+
+What:		/sys/class/power_supply/wilco-charger/charge_control_end_threshold
+Date:		April 2019
+KernelVersion:	5.2
+Description:
+		Used when charge_type="Custom", as described above. Measured in
+		percentages. The valid range is [55, 100].
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879e7e..0c67eff871c8 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
 	 Say Y here to enable support for fuel gauge with SC27XX
 	 PMIC chips.
 
+config CHARGER_WILCO
+	tristate "Wilco EC based charger for ChromeOS"
+	depends on WILCO_EC
+	help
+	  Say Y here to enable control of the charging routines performed
+	  by the Embedded Controller on the Chromebook named Wilco. Further
+	  information can be found in
+	  Documentation/ABI/testing/sysfs-class-power-wilco
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b731c2a9b695..2b603a142701 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/wilco-charger.c
new file mode 100644
index 000000000000..b3c6d7cdd731
--- /dev/null
+++ b/drivers/power/supply/wilco-charger.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Charging control driver for the Wilco EC
+ *
+ * Copyright 2019 Google LLC
+ *
+ * See Documentation/ABI/testing/sysfs-class-power and
+ * Documentation/ABI/testing/sysfs-class-power-wilco for userspace interface
+ * and other info.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/power_supply.h>
+
+#define DRV_NAME "wilco-charger"
+
+/* Property IDs and related EC constants */
+#define PID_CHARGE_MODE		0x0710
+#define PID_CHARGE_LOWER_LIMIT	0x0711
+#define PID_CHARGE_UPPER_LIMIT	0x0712
+
+enum charge_mode {
+	CHARGE_MODE_STD = 1,	/* Used for Standard */
+	CHARGE_MODE_EXP = 2,	/* Express Charge, used for Fast */
+	CHARGE_MODE_AC = 3,	/* Mostly AC use, used for Trickle */
+	CHARGE_MODE_AUTO = 4,	/* Used for Adaptive */
+	CHARGE_MODE_CUSTOM = 5,	/* Used for Custom */
+};
+
+#define CHARGE_LOWER_LIMIT_MIN	50
+#define CHARGE_LOWER_LIMIT_MAX	95
+#define CHARGE_UPPER_LIMIT_MIN	55
+#define CHARGE_UPPER_LIMIT_MAX	100
+
+/* Convert from POWER_SUPPLY_PROP_CHARGE_TYPE value to the EC's charge mode */
+static int psp_val_to_charge_mode(int psp_val)
+{
+	switch (psp_val) {
+	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
+		return CHARGE_MODE_AC;
+	case POWER_SUPPLY_CHARGE_TYPE_FAST:
+		return CHARGE_MODE_EXP;
+	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
+		return CHARGE_MODE_STD;
+	case POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE:
+		return CHARGE_MODE_AUTO;
+	case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
+		return CHARGE_MODE_CUSTOM;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Convert from EC's charge mode to POWER_SUPPLY_PROP_CHARGE_TYPE value */
+static int charge_mode_to_psp_val(enum charge_mode mode)
+{
+	switch (mode) {
+	case CHARGE_MODE_AC:
+		return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+	case CHARGE_MODE_EXP:
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
+	case CHARGE_MODE_STD:
+		return POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+	case CHARGE_MODE_AUTO:
+		return POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE;
+	case CHARGE_MODE_CUSTOM:
+		return POWER_SUPPLY_CHARGE_TYPE_CUSTOM;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum power_supply_property wilco_charge_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+};
+
+static int wilco_charge_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct wilco_ec_device *ec = power_supply_get_drvdata(psy);
+	u32 property_id;
+	int ret;
+	u8 raw;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		property_id = PID_CHARGE_MODE;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		property_id = PID_CHARGE_LOWER_LIMIT;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		property_id = PID_CHARGE_UPPER_LIMIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = wilco_ec_get_byte_property(ec, property_id, &raw);
+	if (ret < 0)
+		return ret;
+	if (property_id == PID_CHARGE_MODE) {
+		ret = charge_mode_to_psp_val(raw);
+		if (ret < 0)
+			return -EBADMSG;
+		raw = ret;
+	}
+	val->intval = raw;
+
+	return 0;
+}
+
+static int wilco_charge_set_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     const union power_supply_propval *val)
+{
+	struct wilco_ec_device *ec = power_supply_get_drvdata(psy);
+	int mode;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		mode = psp_val_to_charge_mode(val->intval);
+		if (mode < 0)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_CHARGE_MODE, mode);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		if (val->intval < CHARGE_LOWER_LIMIT_MIN ||
+		    val->intval > CHARGE_LOWER_LIMIT_MAX)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_CHARGE_LOWER_LIMIT,
+						  val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		if (val->intval < CHARGE_UPPER_LIMIT_MIN ||
+		    val->intval > CHARGE_UPPER_LIMIT_MAX)
+			return -EINVAL;
+		return wilco_ec_set_byte_property(ec, PID_CHARGE_UPPER_LIMIT,
+						  val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int wilco_charge_property_is_writeable(struct power_supply *psy,
+					      enum power_supply_property psp)
+{
+	return 1;
+}
+
+static const struct power_supply_desc wilco_ps_desc = {
+	.properties		= wilco_charge_props,
+	.num_properties		= ARRAY_SIZE(wilco_charge_props),
+	.get_property		= wilco_charge_get_property,
+	.set_property		= wilco_charge_set_property,
+	.property_is_writeable	= wilco_charge_property_is_writeable,
+	.name			= DRV_NAME,
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+};
+
+static int wilco_charge_probe(struct platform_device *pdev)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+	struct power_supply_config psy_cfg = {};
+	struct power_supply *psy;
+
+	psy_cfg.drv_data = ec;
+	psy = devm_power_supply_register(&pdev->dev, &wilco_ps_desc, &psy_cfg);
+
+	return PTR_ERR_OR_ZERO(psy);
+}
+
+static struct platform_driver wilco_charge_driver = {
+	.probe	= wilco_charge_probe,
+	.driver = {
+		.name = DRV_NAME,
+	}
+};
+module_platform_driver(wilco_charge_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Wilco EC charge control driver");
-- 
2.20.1

