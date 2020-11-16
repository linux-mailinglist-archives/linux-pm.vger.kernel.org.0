Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C92C2B4C95
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 18:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbgKPRWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 12:22:51 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58526 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732777AbgKPRWv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 12:22:51 -0500
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 35CC33B5638
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 17:12:40 +0000 (UTC)
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0A516E0002;
        Mon, 16 Nov 2020 17:12:16 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>
Subject: [PATCH 2/5] power: reset: ocelot: Add support for reset switch on load time
Date:   Mon, 16 Nov 2020 18:11:56 +0100
Message-Id: <20201116171159.1735315-3-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116171159.1735315-1-gregory.clement@bootlin.com>
References: <20201116171159.1735315-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Lars Povlsen <lars.povlsen@microchip.com>

This patch add support for resetting the networking switch core at
reset driver load time. It is useful in order to bring the switch core
in a known state after a reboot or after a bootloader may have been
using the switch for network access.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/power/reset/ocelot-reset.c | 40 ++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index f74e1dbb4ba3..a203c42e99d4 100644
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
2.29.2

