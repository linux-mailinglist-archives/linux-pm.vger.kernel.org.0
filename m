Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBF4A4B19
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jan 2022 16:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379947AbiAaP6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jan 2022 10:58:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbiAaP6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jan 2022 10:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643644683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfsfrrsN8FrgFVJ9Ene55agrKNg4tm5L4Ih4LtcuPPg=;
        b=AVw0btZhHwrRh/Lj3QIl+HD4mCyZcG/4eh0uul5IRDcJDkyd0bTcFdGhBt8kasO7GoeUbD
        fSyqUuwaKdT1Jmo61eUnKgvMb7aTALVy2lI9HDGywSAjzKPREIa8DAs7YpO626QMliy1K7
        6jbjDGtjNUOXdvKq6k+j2MVYIxmZzwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-u_KZ7eMwNGORyqyyNb9wig-1; Mon, 31 Jan 2022 10:57:58 -0500
X-MC-Unique: u_KZ7eMwNGORyqyyNb9wig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3F6B84DA40;
        Mon, 31 Jan 2022 15:57:56 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C776798BF;
        Mon, 31 Jan 2022 15:57:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: [PATCH 1/8] power: supply: core: Use fwnode_property_*() in power_supply_get_battery_info()
Date:   Mon, 31 Jan 2022 16:57:23 +0100
Message-Id: <20220131155730.309513-2-hdegoede@redhat.com>
In-Reply-To: <20220131155730.309513-1-hdegoede@redhat.com>
References: <20220131155730.309513-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Switch power_supply_get_battery_info() over to use the generic
fwnode_property_*() property read functions. This is a preparation patch
for adding support for reading properties from other fwnode types such
as swnode properties added by platform code on x86 devices.

Note the parsing of the 2d matrix "ocv-capacity-table-%d" and
"resistance-temp-table" properties is not converted since this depends on
the raw of_get_property() accessor function of which there is no
fwnode_property_*() equivalent AFAICT. This means that these properties
will not be supported in swnodes for now.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 69 ++++++++++++++----------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index df4471e50d33..fd08c018c18e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -572,9 +572,11 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	struct power_supply_resistance_temp_table *resist_table;
 	struct power_supply_battery_info *info;
 	struct device_node *battery_np;
+	struct fwnode_handle *fwnode;
 	const char *value;
 	int err, len, index;
 	const __be32 *list;
+	u32 min_max[2];
 
 	info = devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -618,7 +620,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	if (!battery_np)
 		return -ENODEV;
 
-	err = of_property_read_string(battery_np, "compatible", &value);
+	fwnode = of_fwnode_handle(battery_np);
+
+	err = fwnode_property_read_string(fwnode, "compatible", &value);
 	if (err)
 		goto out_put_node;
 
@@ -632,7 +636,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	 * Documentation/power/power_supply_class.rst.
 	 */
 
-	if (!of_property_read_string(battery_np, "device-chemistry", &value)) {
+	if (!fwnode_property_read_string(fwnode, "device-chemistry", &value)) {
 		if (!strcmp("nickel-cadmium", value))
 			info->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
 		else if (!strcmp("nickel-metal-hydride", value))
@@ -650,45 +654,56 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			dev_warn(&psy->dev, "%s unknown battery type\n", value);
 	}
 
-	of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
+	fwnode_property_read_u32(fwnode, "energy-full-design-microwatt-hours",
 			     &info->energy_full_design_uwh);
-	of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
+	fwnode_property_read_u32(fwnode, "charge-full-design-microamp-hours",
 			     &info->charge_full_design_uah);
-	of_property_read_u32(battery_np, "voltage-min-design-microvolt",
+	fwnode_property_read_u32(fwnode, "voltage-min-design-microvolt",
 			     &info->voltage_min_design_uv);
-	of_property_read_u32(battery_np, "voltage-max-design-microvolt",
+	fwnode_property_read_u32(fwnode, "voltage-max-design-microvolt",
 			     &info->voltage_max_design_uv);
-	of_property_read_u32(battery_np, "trickle-charge-current-microamp",
+	fwnode_property_read_u32(fwnode, "trickle-charge-current-microamp",
 			     &info->tricklecharge_current_ua);
-	of_property_read_u32(battery_np, "precharge-current-microamp",
+	fwnode_property_read_u32(fwnode, "precharge-current-microamp",
 			     &info->precharge_current_ua);
-	of_property_read_u32(battery_np, "precharge-upper-limit-microvolt",
+	fwnode_property_read_u32(fwnode, "precharge-upper-limit-microvolt",
 			     &info->precharge_voltage_max_uv);
-	of_property_read_u32(battery_np, "charge-term-current-microamp",
+	fwnode_property_read_u32(fwnode, "charge-term-current-microamp",
 			     &info->charge_term_current_ua);
-	of_property_read_u32(battery_np, "re-charge-voltage-microvolt",
+	fwnode_property_read_u32(fwnode, "re-charge-voltage-microvolt",
 			     &info->charge_restart_voltage_uv);
-	of_property_read_u32(battery_np, "over-voltage-threshold-microvolt",
+	fwnode_property_read_u32(fwnode, "over-voltage-threshold-microvolt",
 			     &info->overvoltage_limit_uv);
-	of_property_read_u32(battery_np, "constant-charge-current-max-microamp",
+	fwnode_property_read_u32(fwnode, "constant-charge-current-max-microamp",
 			     &info->constant_charge_current_max_ua);
-	of_property_read_u32(battery_np, "constant-charge-voltage-max-microvolt",
+	fwnode_property_read_u32(fwnode, "constant-charge-voltage-max-microvolt",
 			     &info->constant_charge_voltage_max_uv);
-	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
+	fwnode_property_read_u32(fwnode, "factory-internal-resistance-micro-ohms",
 			     &info->factory_internal_resistance_uohm);
 
-	of_property_read_u32_index(battery_np, "ambient-celsius",
-				   0, &info->temp_ambient_alert_min);
-	of_property_read_u32_index(battery_np, "ambient-celsius",
-				   1, &info->temp_ambient_alert_max);
-	of_property_read_u32_index(battery_np, "alert-celsius",
-				   0, &info->temp_alert_min);
-	of_property_read_u32_index(battery_np, "alert-celsius",
-				   1, &info->temp_alert_max);
-	of_property_read_u32_index(battery_np, "operating-range-celsius",
-				   0, &info->temp_min);
-	of_property_read_u32_index(battery_np, "operating-range-celsius",
-				   1, &info->temp_max);
+	if (!fwnode_property_read_u32_array(fwnode, "ambient-celsius",
+					    min_max, ARRAY_SIZE(min_max))) {
+		info->temp_ambient_alert_min = min_max[0];
+		info->temp_ambient_alert_max = min_max[1];
+	}
+	if (!fwnode_property_read_u32_array(fwnode, "alert-celsius",
+					    min_max, ARRAY_SIZE(min_max))) {
+		info->temp_alert_min = min_max[0];
+		info->temp_alert_max = min_max[1];
+	}
+	if (!fwnode_property_read_u32_array(fwnode, "operating-range-celsius",
+					    min_max, ARRAY_SIZE(min_max))) {
+		info->temp_min = min_max[0];
+		info->temp_max = min_max[1];
+	}
+
+	/*
+	 * The below code uses raw of-data parsing to parse
+	 * /schemas/types.yaml#/definitions/uint32-matrix
+	 * data, so for now this is only support with of.
+	 */
+	if (!battery_np)
+		goto out_ret_pointer;
 
 	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
 	if (len < 0 && len != -EINVAL) {
-- 
2.33.1

