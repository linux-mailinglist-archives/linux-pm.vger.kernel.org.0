Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310224C38C4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 23:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiBXW24 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 17:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiBXW2y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 17:28:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 353891B1DD9
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645741702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JmYV7jgPwA8PZtG5zv84XMT/KH4bR8M1jSaz+JwNc+k=;
        b=dhnQFQRI66y8VoIw8Lu+dbwbhQ6sTUIXyqcJ6ycmNEQ/grePEPWtuKpOy31mZOxt5aLbb6
        adAp+koY9gGgT8pnibexYj+6J4VKwRVo1B66VQtn6/JFejoQ2RrdcGIumgDJRfaEEmPnS2
        Q6jPfHuc/qonfzn133QYRoGhJefsnyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-q9sKV3-eNACoM9NhuHRCpw-1; Thu, 24 Feb 2022 17:28:18 -0500
X-MC-Unique: q9sKV3-eNACoM9NhuHRCpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 769EC1091DA3;
        Thu, 24 Feb 2022 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9274E4D716;
        Thu, 24 Feb 2022 22:28:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 1/2] power: supply: axp288_charger: Use acpi_quirk_skip_acpi_ac_and_battery()
Date:   Thu, 24 Feb 2022 23:28:04 +0100
Message-Id: <20220224222805.1689234-2-hdegoede@redhat.com>
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
 drivers/power/supply/Kconfig          | 2 +-
 drivers/power/supply/axp288_charger.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3520da74b8a7..ce7ecf2c821e 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -351,7 +351,7 @@ config AXP20X_POWER
 
 config AXP288_CHARGER
 	tristate "X-Powers AXP288 Charger"
-	depends on MFD_AXP20X && EXTCON_AXP288 && IOSF_MBI
+	depends on MFD_AXP20X && EXTCON_AXP288 && IOSF_MBI && ACPI
 	help
 	  Say yes here to have support X-Power AXP288 power management IC (PMIC)
 	  integrated charger.
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index c498e62ab4e2..19746e658a6a 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -838,6 +838,13 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	struct power_supply_config charger_cfg = {};
 	unsigned int val;
 
+	/*
+	 * Normally the native AXP288 fg/charger drivers are preferred but
+	 * on some devices the ACPI drivers should be used instead.
+	 */
+	if (!acpi_quirk_skip_acpi_ac_and_battery())
+		return -ENODEV;
+
 	/*
 	 * On some devices the fuelgauge and charger parts of the axp288 are
 	 * not used, check that the fuelgauge is enabled (CC_CTRL != 0).
-- 
2.35.1

