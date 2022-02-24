Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2F4C38BE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 23:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiBXW2x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 17:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiBXW2w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 17:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E79ED18E3C4
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 14:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645741701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26x3x2Orh1dv+U1j3ib8xPDZbQ0wuGwhdds74YuGxug=;
        b=jIZSGcbSb+KydtoNWLMFr/vmldgoqIVpEOa7y9fJWmLkCGy9b6nVDdv0PtAW78iA8zKwbw
        sViaphHPTyVq8XV7pq/V/ZYijVBaHK7xq20D4rtQmMvV1vevYuGCRGDdAaVlMMrYOYVYil
        7s7Osh+dswYsq88qrF5+8LBf7Yj9ddw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-83WEtj0_ONCl_WY1xHA5qA-1; Thu, 24 Feb 2022 17:28:19 -0500
X-MC-Unique: 83WEtj0_ONCl_WY1xHA5qA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BFE5824FA8;
        Thu, 24 Feb 2022 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3CCF4D739;
        Thu, 24 Feb 2022 22:28:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: axp288_fuel_gauge: Use acpi_quirk_skip_acpi_ac_and_battery()
Date:   Thu, 24 Feb 2022 23:28:05 +0100
Message-Id: <20220224222805.1689234-3-hdegoede@redhat.com>
In-Reply-To: <20220224222805.1689234-1-hdegoede@redhat.com>
References: <20220224222805.1689234-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Normally the native AXP288 fg/charger drivers are preferred but one some
devices the ACPI drivers should be used instead.

The ACPI battery/ac drivers use the acpi_quirk_skip_acpi_ac_and_battery()
helper to determine if they should skip loading because native fuel-gauge/
charger drivers like the AXP288 drivers will be used.

The new acpi_quirk_skip_acpi_ac_and_battery() helper includes a list of
exceptions for boards where the ACPI drivers should be used instead.

Use this new helper to avoid loading on such boards. Note this requires
adding a Kconfig dependency on ACPI, this is not a problem because ACPI
should be enabled on all boards with an AXP288 PMIC anyways.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/Kconfig             |  2 +-
 drivers/power/supply/axp288_fuel_gauge.c | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ce7ecf2c821e..8f9033679f49 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -358,7 +358,7 @@ config AXP288_CHARGER
 
 config AXP288_FUEL_GAUGE
 	tristate "X-Powers AXP288 Fuel Gauge"
-	depends on MFD_AXP20X && IIO && IOSF_MBI
+	depends on MFD_AXP20X && IIO && IOSF_MBI && ACPI
 	help
 	  Say yes here to have support for X-Power power management IC (PMIC)
 	  Fuel Gauge. The device provides battery statistics and status
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 13be2c1d6528..e9f285dae489 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -9,6 +9,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -544,12 +545,6 @@ static const struct dmi_system_id axp288_no_battery_list[] = {
 			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
 		},
 	},
-	{
-		/* ECS EF20EA */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
-		},
-	},
 	{
 		/* Intel Cherry Trail Compute Stick, Windows version */
 		.matches = {
@@ -673,6 +668,13 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i, pirq, ret;
 
+	/*
+	 * Normally the native AXP288 fg/charger drivers are preferred but
+	 * on some devices the ACPI drivers should be used instead.
+	 */
+	if (!acpi_quirk_skip_acpi_ac_and_battery())
+		return -ENODEV;
+
 	if (dmi_check_system(axp288_no_battery_list))
 		return -ENODEV;
 
-- 
2.35.1

