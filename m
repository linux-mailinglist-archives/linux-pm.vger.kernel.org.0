Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC4516E99
	for <lists+linux-pm@lfdr.de>; Mon,  2 May 2022 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiEBLQK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 May 2022 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiEBLQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2022 07:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B6112ADA
        for <linux-pm@vger.kernel.org>; Mon,  2 May 2022 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651489959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TN2vE/T4AM3Yw6dQpd+4RQDf364dAJFuWPRX2Q7ZyXo=;
        b=Eo2bmjKz8ns6+9w2tPBF+PfDEVd8RsKnqBZVnbzF9tS7W9B+hpLS+xJq2wCqAzsF26QZW4
        zTKBVcMgRvp/ptnLmvo8a6tfSMcZ2ofau0sQYfeH8DEmafzkf7kGG4LOpuik/NCdro8itU
        OhKm1eGbbGzpqGiVuGngR3nUI4c0jEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Jrpo3cNQPQKear1_5UfzlQ-1; Mon, 02 May 2022 07:12:38 -0400
X-MC-Unique: Jrpo3cNQPQKear1_5UfzlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E508185A7A4;
        Mon,  2 May 2022 11:12:38 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 064C114C4D78;
        Mon,  2 May 2022 11:12:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power: supply: axp288_fuel_gauge: Fix battery reporting on the One Mix 1
Date:   Mon,  2 May 2022 13:12:34 +0200
Message-Id: <20220502111235.331877-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 3a06b912a5ce ("power: supply: axp288_fuel_gauge: Make "T3 MRD"
no_battery_list DMI entry more generic") added a generic no-battery DMI
match for many mini-PCs / HDMI-sticks which use "T3 MRD" as their DMI
board-name.

It turns out that the One Mix 1 mini laptop also uses "T3 MRD" for its
DMI boardname and it also has its chassis-type wrongly set to a value
of "3" (desktop). This was causing the axp288_fuel_gauge driver to
disable battery reporting because this matches the no-battery DMI
list entry for generic "T3 MRD" mini-PCs.

Change the no-battery DMI list into a quirks DMI list and add a
specific match for the One Mix 1 mini laptop before the generic
"T3 MRD" no-battery quirk entry to fix this.

Fixes: 3a06b912a5ce ("power: supply: axp288_fuel_gauge: Make "T3 MRD" no_battery_list DMI entry more generic")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 40 +++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index e9f285dae489..5b8aa4a980cd 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -90,6 +90,8 @@
 #define AXP288_REG_UPDATE_INTERVAL		(60 * HZ)
 #define AXP288_FG_INTR_NUM			6
 
+#define AXP288_QUIRK_NO_BATTERY			BIT(0)
+
 static bool no_current_sense_res;
 module_param(no_current_sense_res, bool, 0444);
 MODULE_PARM_DESC(no_current_sense_res, "No (or broken) current sense resistor");
@@ -524,7 +526,7 @@ static struct power_supply_desc fuel_gauge_desc = {
  * detection reports one despite it not being there.
  * Please keep this listed sorted alphabetically.
  */
-static const struct dmi_system_id axp288_no_battery_list[] = {
+static const struct dmi_system_id axp288_quirks[] = {
 	{
 		/* ACEPC T8 Cherry Trail Z8350 mini PC */
 		.matches = {
@@ -534,6 +536,7 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 			/* also match on somewhat unique bios-version */
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
 		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
 		/* ACEPC T11 Cherry Trail Z8350 mini PC */
@@ -544,6 +547,7 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 			/* also match on somewhat unique bios-version */
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
 		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
 		/* Intel Cherry Trail Compute Stick, Windows version */
@@ -551,6 +555,7 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "STK1AW32SC"),
 		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
 		/* Intel Cherry Trail Compute Stick, version without an OS */
@@ -558,34 +563,55 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "STK1A32SC"),
 		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
 		/* Meegopad T02 */
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MEEGOPAD T02"),
 		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{	/* Mele PCG03 Mini PC */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Mini PC"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Mini PC"),
 		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
 		/* Minix Neo Z83-4 mini PC */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
-		}
+		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{
-		/* Various Ace PC/Meegopad/MinisForum/Wintel Mini-PCs/HDMI-sticks */
+		/*
+		 * One Mix 1, this uses the "T3 MRD" boardname used by
+		 * generic mini PCs, but it is a mini laptop so it does
+		 * actually have a battery!
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_BIOS_DATE, "06/14/2018"),
+		},
+		.driver_data = NULL,
+	},
+	{
+		/*
+		 * Various Ace PC/Meegopad/MinisForum/Wintel Mini-PCs/HDMI-sticks
+		 * This entry must be last because it is generic, this allows
+		 * adding more specifuc quirks overriding this generic entry.
+		 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
 			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
 			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 			DMI_MATCH(DMI_BIOS_VERSION, "5.11"),
 		},
+		.driver_data = (void *)AXP288_QUIRK_NO_BATTERY,
 	},
 	{}
 };
@@ -665,7 +691,9 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		[BAT_D_CURR] = "axp288-chrg-d-curr",
 		[BAT_VOLT] = "axp288-batt-volt",
 	};
+	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
+	unsigned long quirks = 0;
 	int i, pirq, ret;
 
 	/*
@@ -675,7 +703,11 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	if (!acpi_quirk_skip_acpi_ac_and_battery())
 		return -ENODEV;
 
-	if (dmi_check_system(axp288_no_battery_list))
+	dmi_id = dmi_first_match(axp288_quirks);
+	if (dmi_id)
+		quirks = (unsigned long)dmi_id->driver_data;
+
+	if (quirks & AXP288_QUIRK_NO_BATTERY)
 		return -ENODEV;
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
-- 
2.36.0

