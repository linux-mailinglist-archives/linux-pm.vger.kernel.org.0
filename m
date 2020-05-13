Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE571D1410
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 15:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgEMNJE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 09:09:04 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:31166 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgEMNJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589375342; x=1620911342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EVZAXO1o0L53j6vhD0cm7z0bP8p6Ac07Mbyf5NtalMA=;
  b=QW/yR+a5iuXx4irYnN5PszvtcZQCLeIYyVSABjDOdYVPVvksdYcl/nzz
   BAsi1W0Yx+aE7hdtzu52mKEj7ZIWY5eDTPwwkly/quWPoDYLFKxU5faby
   l5kEcXY28ZahdQDfLcninNTiCI7LuNI2tyw22PcnYZedKENHZoDC8vwHv
   F+ZFY8naT97lLbGNogLyiAwhVna6VPPtdY9rUVpU6G8kekc9rf/4jF4Sd
   TfO/P6Wwm3RD1Fyr8lpeMSm4l8P/5CoKmeb6EvC3q+tt9pDk6k1SfAsYC
   Eq1feHM7qiYRHRpSrmRWwYXy03IWL/iKn3wrCRzi/YtNhylE+RO0h2YGy
   Q==;
IronPort-SDR: Iaa2ZR9ylS9Tayj7EHHnyzAzRlCNlrf3R0bjVebGT6XxXfVlplPSISWXgmaRT4sdb0M2TJ7vUv
 ID/3pk3BOERFDrvkoykbBd092szXPaqF5KFfTewm2dNz/XQsUB/nw2Y2vuAwdTG7X/49K5ccg7
 xfcsJeFp0/7BOglHqe+jJ1d+3AGSjeWxTz9h4tlANigLLFQafCknXMz6VK1qT7aYPCLLWwsaqc
 UYWfU5kine1EOq5MJpj83RDpP8ttjyIpRBK2D5zIqXSO4hHw1riKiRra9jbDw9qINq4LYBHPUg
 Qc4=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="76497710"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:08:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:09:02 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:08:57 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/5] power: reset: ocelot: Add support for Sparx5
Date:   Wed, 13 May 2020 15:08:39 +0200
Message-ID: <20200513130842.24847-3-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513130842.24847-1-lars.povlsen@microchip.com>
References: <20200513130842.24847-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
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
index 8903803020805..9ecafbf9e64a6 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -118,10 +118,9 @@ config POWER_RESET_QCOM_PON
 
 config POWER_RESET_OCELOT_RESET
 	bool "Microsemi Ocelot reset driver"
-	depends on MSCC_OCELOT || COMPILE_TEST
 	select MFD_SYSCON
 	help
-	  This driver supports restart for Microsemi Ocelot SoC.
+	  This driver supports restart for Microsemi Ocelot SoC and similar.
 
 config POWER_RESET_PIIX4_POWEROFF
 	tristate "Intel PIIX4 power-off driver"
diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index 419952c61fd01..f74e1dbb4ba36 100644
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
2.26.2

