Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F6A2B4C96
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 18:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbgKPRWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 12:22:51 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58536 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732779AbgKPRWv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 12:22:51 -0500
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A22613B5CB1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 17:12:42 +0000 (UTC)
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 938971C0003;
        Mon, 16 Nov 2020 17:12:19 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4/5] power: reset: ocelot: Add support 2 othe MIPS based SoCs
Date:   Mon, 16 Nov 2020 18:11:58 +0100
Message-Id: <20201116171159.1735315-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116171159.1735315-1-gregory.clement@bootlin.com>
References: <20201116171159.1735315-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds reset support for Luton and Jaguar2 in the ocelot-reset
driver. They are both MIPS based belonging to the VvoreIII family.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/power/reset/ocelot-reset.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index a203c42e99d4..0f92416f2907 100644
--- a/drivers/power/reset/ocelot-reset.c
+++ b/drivers/power/reset/ocelot-reset.c
@@ -29,6 +29,8 @@ struct ocelot_reset_context {
 	struct notifier_block restart_handler;
 };
 
+#define BIT_OFF_INVALID				32
+
 #define SOFT_SWC_RST  BIT(1)
 #define SOFT_CHIP_RST BIT(0)
 
@@ -77,9 +79,11 @@ static int ocelot_restart_handle(struct notifier_block *this,
 			   ctx->props->vcore_protect, 0);
 
 	/* Make the SI back to boot mode */
-	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   IF_SI_OWNER_MASK << if_si_owner_bit,
-			   IF_SI_OWNER_SIBM << if_si_owner_bit);
+	if (if_si_owner_bit != BIT_OFF_INVALID)
+		regmap_update_bits(ctx->cpu_ctrl,
+				   ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
+				   IF_SI_OWNER_MASK << if_si_owner_bit,
+				   IF_SI_OWNER_SIBM << if_si_owner_bit);
 
 	pr_emerg("Resetting SoC\n");
 
@@ -127,6 +131,20 @@ static int ocelot_reset_probe(struct platform_device *pdev)
 	return err;
 }
 
+static const struct reset_props reset_props_jaguar2 = {
+	.syscon		 = "mscc,ocelot-cpu-syscon",
+	.protect_reg     = 0x20,
+	.vcore_protect   = BIT(2),
+	.if_si_owner_bit = 6,
+};
+
+static const struct reset_props reset_props_luton = {
+	.syscon		 = "mscc,ocelot-cpu-syscon",
+	.protect_reg     = 0x20,
+	.vcore_protect   = BIT(2),
+	.if_si_owner_bit = BIT_OFF_INVALID, /* n/a */
+};
+
 static const struct reset_props reset_props_ocelot = {
 	.syscon		 = "mscc,ocelot-cpu-syscon",
 	.protect_reg     = 0x20,
@@ -143,6 +161,12 @@ static const struct reset_props reset_props_sparx5 = {
 
 static const struct of_device_id ocelot_reset_of_match[] = {
 	{
+		.compatible = "mscc,jaguar2-chip-reset",
+		.data = &reset_props_jaguar2
+	}, {
+		.compatible = "mscc,luton-chip-reset",
+		.data = &reset_props_luton
+	}, {
 		.compatible = "mscc,ocelot-chip-reset",
 		.data = &reset_props_ocelot
 	}, {
-- 
2.29.2

