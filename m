Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C2E2852D3
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 22:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgJFUDu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 16:03:50 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48182 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFUDu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 16:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602014629; x=1633550629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8/lkY8tMVK8ISv95etsW5kDB9jLPtLYCNgLMwnSwlA=;
  b=hce4H4deENdbzzvQ+JcnPwDA0KLnUeDwuJUCk2bZvTwSwjBy72xgijgi
   1UROg9z81oCLT03bEG5/xTcahABxlv+yMUFKJomC8qwaVKdPuBxiK79p1
   73R1gnLqe+iPRMJZDlTywdwlslLtZhGY57KVQC8UBQ+mlv+xUlyyUMIgk
   bzIGysPwHAOzmI4PdtCs6jdkiHUE1lnCE6o4ncAaGdAtC6mUh5C626Y2+
   qOEE8yHfNs67qVcVUdlP4SN+HjqFe55VyPzvBE1hH6GnbDRWtOXi8lwgG
   ThLVeUwt7o/YxRrldXrFV0uBUxhWgcC4R1ABp/xXfu9ACiduqFQuAdFsN
   A==;
IronPort-SDR: uuedR3Hx3qmOk0TC2W/sUReDzG40NYgpg0xIOPsz+9fuNlrTslqu2m4PBmtJjFN0LgwuEuXGih
 bYTg0S8IBIT9ueFQL6erChdf3c6lGAJuxOBhjy7/DTw5kfG0/Z2PRBYr7ZdIOn6s5ZEGTFiA+P
 lZkgNTwFsfaPd0LOwvr3e39klpYqLa2yFBXrq9AEuwaK4C7RhfqGtWjeDZghVjCSJuzE437FIe
 qba+BXMW5RkL8GqZdqa4GNq9yxh38M3NCkauwGMhjEtfekfMD2+UKntv9NcPayd9pVItpRWHzb
 28U=
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="91665308"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2020 13:03:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 13:03:48 -0700
Received: from soft-dev10.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 6 Oct 2020 13:03:47 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/3] power: reset: ocelot: Add support for Sparx5
Date:   Tue, 6 Oct 2020 22:03:15 +0200
Message-ID: <20201006200316.2261245-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006200316.2261245-1-lars.povlsen@microchip.com>
References: <20201006200316.2261245-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds reset support for Sparx5 in the ocelot-reset driver.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/power/reset/Kconfig        |  3 +-
 drivers/power/reset/ocelot-reset.c | 55 +++++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 0a1fb5c74f83..6361569aacb7 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -129,10 +129,9 @@ config POWER_RESET_QCOM_PON

 config POWER_RESET_OCELOT_RESET
 	bool "Microsemi Ocelot reset driver"
-	depends on MSCC_OCELOT || COMPILE_TEST
 	select MFD_SYSCON
 	help
-	  This driver supports restart for Microsemi Ocelot SoC.
+	  This driver supports restart for Microsemi Ocelot SoC and similar.

 config POWER_RESET_OXNAS
 	bool "OXNAS SoC restart driver"
diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index 419952c61fd0..f74e1dbb4ba3 100644
--- a/drivers/power/reset/ocelot-reset.c
+++ b/drivers/power/reset/ocelot-reset.c
@@ -15,15 +15,20 @@
 #include <linux/reboot.h>
 #include <linux/regmap.h>

+struct reset_props {
+	const char *syscon;
+	u32 protect_reg;
+	u32 vcore_protect;
+	u32 if_si_owner_bit;
+};
+
 struct ocelot_reset_context {
 	void __iomem *base;
 	struct regmap *cpu_ctrl;
+	const struct reset_props *props;
 	struct notifier_block restart_handler;
 };

-#define ICPU_CFG_CPU_SYSTEM_CTRL_RESET 0x20
-#define CORE_RST_PROTECT BIT(2)
-
 #define SOFT_CHIP_RST BIT(0)

 #define ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
@@ -31,7 +36,6 @@ struct ocelot_reset_context {
 #define IF_SI_OWNER_SISL			0
 #define IF_SI_OWNER_SIBM			1
 #define IF_SI_OWNER_SIMC			2
-#define IF_SI_OWNER_OFFSET			4

 static int ocelot_restart_handle(struct notifier_block *this,
 				 unsigned long mode, void *cmd)
@@ -39,15 +43,18 @@ static int ocelot_restart_handle(struct notifier_block *this,
 	struct ocelot_reset_context *ctx = container_of(this, struct
 							ocelot_reset_context,
 							restart_handler);
+	u32 if_si_owner_bit = ctx->props->if_si_owner_bit;

 	/* Make sure the core is not protected from reset */
-	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
-			   CORE_RST_PROTECT, 0);
+	regmap_update_bits(ctx->cpu_ctrl, ctx->props->protect_reg,
+			   ctx->props->vcore_protect, 0);

 	/* Make the SI back to boot mode */
 	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   IF_SI_OWNER_MASK << IF_SI_OWNER_OFFSET,
-			   IF_SI_OWNER_SIBM << IF_SI_OWNER_OFFSET);
+			   IF_SI_OWNER_MASK << if_si_owner_bit,
+			   IF_SI_OWNER_SIBM << if_si_owner_bit);
+
+	pr_emerg("Resetting SoC\n");

 	writel(SOFT_CHIP_RST, ctx->base);

@@ -72,9 +79,13 @@ static int ocelot_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(ctx->base))
 		return PTR_ERR(ctx->base);

-	ctx->cpu_ctrl = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
-	if (IS_ERR(ctx->cpu_ctrl))
+	ctx->props = device_get_match_data(dev);
+
+	ctx->cpu_ctrl = syscon_regmap_lookup_by_compatible(ctx->props->syscon);
+	if (IS_ERR(ctx->cpu_ctrl)) {
+		dev_err(dev, "No syscon map: %s\n", ctx->props->syscon);
 		return PTR_ERR(ctx->cpu_ctrl);
+	}

 	ctx->restart_handler.notifier_call = ocelot_restart_handle;
 	ctx->restart_handler.priority = 192;
@@ -85,9 +96,29 @@ static int ocelot_reset_probe(struct platform_device *pdev)
 	return err;
 }

+static const struct reset_props reset_props_ocelot = {
+	.syscon		 = "mscc,ocelot-cpu-syscon",
+	.protect_reg     = 0x20,
+	.vcore_protect   = BIT(2),
+	.if_si_owner_bit = 4,
+};
+
+static const struct reset_props reset_props_sparx5 = {
+	.syscon		 = "microchip,sparx5-cpu-syscon",
+	.protect_reg     = 0x84,
+	.vcore_protect   = BIT(10),
+	.if_si_owner_bit = 6,
+};
+
 static const struct of_device_id ocelot_reset_of_match[] = {
-	{ .compatible = "mscc,ocelot-chip-reset" },
-	{}
+	{
+		.compatible = "mscc,ocelot-chip-reset",
+		.data = &reset_props_ocelot
+	}, {
+		.compatible = "microchip,sparx5-chip-reset",
+		.data = &reset_props_sparx5
+	},
+	{ /*sentinel*/ }
 };

 static struct platform_driver ocelot_reset_driver = {
--
2.25.1
