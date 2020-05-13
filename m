Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34581D1417
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 15:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgEMNJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 09:09:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:31166 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733281AbgEMNJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 09:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589375347; x=1620911347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1OANcDGi3Zb91vsck9iJpexMcTamnhCI2LiIcyTydQ=;
  b=D/1ildm50PF/rPVvySWQMOjkLsGTd+NKJ+yKdS4RzULRxaZz6eNooIV7
   PElwPyWb7e9t/X5KAiJjfJjcBg3OK+u/DogrtlY2z2NVqSsncF7ER95fF
   oFHgItZw/LB9uKqyi4ydpCHUTqnxiuQT6BsCcfzcl5qJR8eHa6xRq2Pl5
   ZtNF32JQJE0DOwPqJnakdEbZL84X0VY74XB25bog0D9vTwcgDAqx7dOuE
   Z8xXQWLlQcn/sfnrVm2QQCuu79SQLEe/tq412WtxEtIspWvEd3IhfxPsn
   s+9pZGLmyu/ZngcD5vg6O5nf73VnHMgNRtxWfWdMLOMjyl4GKahtOMo37
   A==;
IronPort-SDR: +6yZhiMfqJQ38vJrskCsDMyrAr18DNmhZ3317VdPR7QUzEaMe4qimJp20CkWP8Bj9mzJCC42Q3
 CVr3uFHSqn/rfsSuhh/f7GADhQ7TNdN64qyaGiUp5diAs3V6ZmkLA3VGgxPMNRL57HPCxcPgHy
 AGXKL6ZD33hHcCI0zLk9MgkT9sM/sD7LJMTTa3sUNxa3PmGyn1X712gZao6FOAbRIwLTJhacxO
 d1fS7k0335S56Tan42EQEHuwZViwJJET6rY7jMwwSYWh/cMfPj1mLNUqIrmWPE9Xcktq/MWl9V
 jvs=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="76497730"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 06:09:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 06:09:06 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 06:09:01 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Sebastian Reichel <sre@kernel.org>, SoC Team <soc@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/5] power: reset: ocelot: Add support for reset switch on load time
Date:   Wed, 13 May 2020 15:08:41 +0200
Message-ID: <20200513130842.24847-5-lars.povlsen@microchip.com>
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

This patch add support for resetting the networking switch core at
reset driver load time. It is useful in order to bring the switch core
in a known state after a reboot or after a bootloader may have been
using the switch for network access.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/power/reset/ocelot-reset.c | 40 ++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index f74e1dbb4ba36..a203c42e99d42 100644
--- a/drivers/power/reset/ocelot-reset.c
+++ b/drivers/power/reset/ocelot-reset.c
@@ -29,6 +29,7 @@ struct ocelot_reset_context {
 	struct notifier_block restart_handler;
 };
 
+#define SOFT_SWC_RST  BIT(1)
 #define SOFT_CHIP_RST BIT(0)
 
 #define ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
@@ -37,6 +38,32 @@ struct ocelot_reset_context {
 #define IF_SI_OWNER_SIBM			1
 #define IF_SI_OWNER_SIMC			2
 
+static int ocelot_switch_core_reset(const struct ocelot_reset_context *ctx)
+{
+
+	const char *driver = "ocelot-reset";
+	int timeout;
+
+	pr_notice("%s: Resetting Switch Core\n", driver);
+
+	/* Make sure the core is PROTECTED from reset */
+	regmap_update_bits(ctx->cpu_ctrl, ctx->props->protect_reg,
+			   ctx->props->vcore_protect,
+			   ctx->props->vcore_protect);
+
+	writel(SOFT_SWC_RST, ctx->base);
+	for (timeout = 0; timeout < 100; timeout++) {
+		if ((readl(ctx->base) & SOFT_SWC_RST) == 0) {
+			pr_debug("%s: Switch Core Reset complete.\n", driver);
+			return 0;
+		}
+		udelay(1);
+	}
+
+	pr_warn("%s: Switch Core Reset timeout!\n", driver);
+	return -ENXIO;
+}
+
 static int ocelot_restart_handle(struct notifier_block *this,
 				 unsigned long mode, void *cmd)
 {
@@ -66,7 +93,6 @@ static int ocelot_reset_probe(struct platform_device *pdev)
 {
 	struct ocelot_reset_context *ctx;
 	struct resource *res;
-
 	struct device *dev = &pdev->dev;
 	int err;
 
@@ -87,6 +113,11 @@ static int ocelot_reset_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->cpu_ctrl);
 	}
 
+	/* Optionally, call switch reset function */
+	if (of_property_read_bool(pdev->dev.of_node,
+				  "microchip,reset-switch-core"))
+		ocelot_switch_core_reset(ctx);
+
 	ctx->restart_handler.notifier_call = ocelot_restart_handle;
 	ctx->restart_handler.priority = 192;
 	err = register_restart_handler(&ctx->restart_handler);
@@ -128,4 +159,9 @@ static struct platform_driver ocelot_reset_driver = {
 		.of_match_table = ocelot_reset_of_match,
 	},
 };
-builtin_platform_driver(ocelot_reset_driver);
+
+static int __init reset_init(void)
+{
+	return platform_driver_register(&ocelot_reset_driver);
+}
+postcore_initcall(reset_init);
-- 
2.26.2

