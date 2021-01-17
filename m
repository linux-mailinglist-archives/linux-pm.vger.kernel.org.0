Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446D72F95FC
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbhAQWjg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 17:39:36 -0500
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21136 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbhAQWje (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 17:39:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1610923120; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=gtDzAccVzCzxxn3KVxDPGh1sKsRW47QXSeOYGpfHAfjlNDVfRtP7yhq+SdJX/XdVpuxk7EQ4z3atCVYFsK5IsWh4yvPm/gS5UakAaBwfC0MmmO0oDOV+KcpuD9BGAAH7Vr5DSskg2ZuTmnaWzFqsc6pZW9h60wMipdAq070AKNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1610923120; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=yoGRNckFdbTOKMl8WUoqDy/QYR5eJJq+6GrEM7ukwQA=; 
        b=YOs8anrxU6uA93Ydn0qTzuKtzuuqRISzP5y/upFTXUCpcThE3sfECAnxFuMztea4JiYxauLGZftdP/nhnG3yd3AdOIPQnD7aFenQYqwWlQTGvg/PGqkisgP8UfE4M8LDiL+Fd3AuMusp9pxbfJ+i1tBEaoJP6jYAyWDRN4WH4Oo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from localhost.localdomain (ip-95-222-215-9.hsi15.unitymediagroup.de [95.222.215.9]) by mx.zoho.eu
        with SMTPS id 1610923119632933.916831167609; Sun, 17 Jan 2021 23:38:39 +0100 (CET)
Date:   Sun, 17 Jan 2021 23:38:39 +0100
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] drivers: power_supply: cpcap-battery: Add battery type auto
 detection for mapphone devices
Message-Id: <20210117233839.abcba42136d1fb9907e5bc6a@uvos.xyz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This allow cpcap-battery to detect whitch battery is inserted, HW4X or BW8X for
xt875 and EB41 for xt894 by examining the battery nvmem. If no known battery
is detected sane defaults are used.

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 drivers/power/supply/cpcap-battery.c | 117 ++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 8ae0c9c7ebcb..4bd7c71c6abe 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -28,6 +28,7 @@
 #include <linux/power_supply.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/moduleparam.h>
 
 #include <linux/iio/consumer.h>
@@ -73,6 +74,9 @@
 
 #define CPCAP_BATTERY_CC_SAMPLE_PERIOD_MS	250
 
+#define CPCAP_BATTERY_EB41_HW4X_ID 0x9E
+#define CPCAP_BATTERY_BW8X_ID 0x98
+
 enum {
 	CPCAP_BATTERY_IIO_BATTDET,
 	CPCAP_BATTERY_IIO_VOLTAGE,
@@ -97,6 +101,7 @@ struct cpcap_interrupt_desc {
 
 struct cpcap_battery_config {
 	int cd_factor;
+	char id;
 	struct power_supply_info info;
 	struct power_supply_battery_info bat;
 };
@@ -138,6 +143,7 @@ struct cpcap_battery_ddata {
 	int charge_full;
 	int status;
 	u16 vendor;
+	bool check_nvmem;
 	unsigned int is_full:1;
 };
 
@@ -146,6 +152,50 @@ struct cpcap_battery_ddata {
 static bool ignore_temperature_probe;
 module_param(ignore_temperature_probe, bool, 0660);
 
+/*
+ * Based on the values from Motorola mapphone Linux kernel for the
+ * stock Droid 4 battery eb41. In the Motorola mapphone Linux
+ * kernel tree the value for pm_cd_factor is passed to the kernel
+ * via device tree. If it turns out to be something device specific
+ * we can consider that too later. These values are also fine for
+ * Bionic's hw4x.
+ *
+ * And looking at the battery full and shutdown values for the stock
+ * kernel on droid 4, full is 4351000 and software initiates shutdown
+ * at 3078000. The device will die around 2743000.
+ */
+static const struct cpcap_battery_config cpcap_battery_eb41_data = {
+	.cd_factor = 0x3cc,
+	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+	.info.voltage_max_design = 4351000,
+	.info.voltage_min_design = 3100000,
+	.info.charge_full_design = 1740000,
+	.bat.constant_charge_voltage_max_uv = 4200000,
+};
+
+/* Values for the extended Droid Bionic battery bw8x. */
+static const struct cpcap_battery_config cpcap_battery_bw8x_data = {
+	.cd_factor = 0x3cc,
+	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+	.info.voltage_max_design = 4200000,
+	.info.voltage_min_design = 3200000,
+	.info.charge_full_design = 2760000,
+	.bat.constant_charge_voltage_max_uv = 4200000,
+};
+
+/*
+ * Safe values for any lipo battery likely to fit into a mapphone
+ * battery bay.
+ */
+static const struct cpcap_battery_config cpcap_battery_unkown_data = {
+	.cd_factor = 0x3cc,
+	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+	.info.voltage_max_design = 4200000,
+	.info.voltage_min_design = 3200000,
+	.info.charge_full_design = 3000000,
+	.bat.constant_charge_voltage_max_uv = 4200000,
+};
+
 static struct cpcap_battery_state_data *
 cpcap_battery_get_state(struct cpcap_battery_ddata *ddata,
 			enum cpcap_battery_state state)
@@ -531,6 +581,41 @@ static void cpcap_battery_external_power_changed(struct power_supply *psy)
 	power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS, &prop);
 }
 
+static int cpcap_battery_match_nvmem(struct device *dev, const void *data)
+{
+	if (strcmp(dev_name(dev), "89-500029ba0f73") == 0)
+		return 1;
+	else
+		return 0;
+}
+
+static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
+{
+	struct nvmem_device *nvmem;
+	u8 battery_id = 0;
+
+	ddata->check_nvmem = false;
+
+	nvmem = nvmem_device_find(NULL, &cpcap_battery_match_nvmem);
+	if (IS_ERR_OR_NULL(nvmem)) {
+		ddata->check_nvmem = true;
+	} else if (nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
+		battery_id = 0;
+		ddata->check_nvmem = true;
+	}
+
+	switch (battery_id) {
+	case CPCAP_BATTERY_EB41_HW4X_ID:
+		memcpy(&ddata->config, &cpcap_battery_eb41_data, sizeof(ddata->config));
+		break;
+	case CPCAP_BATTERY_BW8X_ID:
+		memcpy(&ddata->config, &cpcap_battery_bw8x_data, sizeof(ddata->config));
+		break;
+	default:
+		memcpy(&ddata->config, &cpcap_battery_unkown_data, sizeof(ddata->config));
+	}
+}
+
 static enum power_supply_property cpcap_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -564,6 +649,9 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 	int cached;
 	s64 tmp;
 
+	if (ddata->check_nvmem)
+		cpcap_battery_detect_battery_type(ddata);
+
 	cached = cpcap_battery_update_status(ddata);
 	if (cached < 0)
 		return cached;
@@ -981,30 +1069,10 @@ static int cpcap_battery_calibrate(struct cpcap_battery_ddata *ddata)
 	return error;
 }
 
-/*
- * Based on the values from Motorola mapphone Linux kernel. In the
- * the Motorola mapphone Linux kernel tree the value for pm_cd_factor
- * is passed to the kernel via device tree. If it turns out to be
- * something device specific we can consider that too later.
- *
- * And looking at the battery full and shutdown values for the stock
- * kernel on droid 4, full is 4351000 and software initiates shutdown
- * at 3078000. The device will die around 2743000.
- */
-static const struct cpcap_battery_config cpcap_battery_default_data = {
-	.cd_factor = 0x3cc,
-	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
-	.info.voltage_max_design = 4351000,
-	.info.voltage_min_design = 3100000,
-	.info.charge_full_design = 1740000,
-	.bat.constant_charge_voltage_max_uv = 4200000,
-};
-
 #ifdef CONFIG_OF
 static const struct of_device_id cpcap_battery_id_table[] = {
 	{
 		.compatible = "motorola,cpcap-battery",
-		.data = &cpcap_battery_default_data,
 	},
 	{},
 };
@@ -1024,19 +1092,14 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 	if (!match)
 		return -EINVAL;
 
-	if (!match->data) {
-		dev_err(&pdev->dev, "no configuration data found\n");
-
-		return -ENODEV;
-	}
-
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
+	cpcap_battery_detect_battery_type(ddata);
+
 	INIT_LIST_HEAD(&ddata->irq_list);
 	ddata->dev = &pdev->dev;
-	memcpy(&ddata->config, match->data, sizeof(ddata->config));
 
 	ddata->reg = dev_get_regmap(ddata->dev->parent, NULL);
 	if (!ddata->reg)
-- 
2.29.2
