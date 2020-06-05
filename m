Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F791F02FA
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgFEWoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 18:44:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41708 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgFEWoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 18:44:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 44DFA2A51AB
Received: by jupiter.universe (Postfix, from userid 1000)
        id 308C2480104; Sat,  6 Jun 2020 00:44:04 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 4/6] ARM: pxa: Use GPIO descriptor for gpio-charger
Date:   Sat,  6 Jun 2020 00:44:01 +0200
Message-Id: <20200605224403.181015-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605224403.181015-1-sebastian.reichel@collabora.com>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Provide AC detect GPIO via gpiod table instead of
legacy platform data so that legacy GPIO support
can be removed from the driver.

Also remove useless IRQ resource, which is not
used by the driver.

Due to lack of hardware this has only been compile
tested.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/mach-pxa/tosa.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 3d2c108e911e..e4da2b4c5055 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -369,6 +369,14 @@ static struct pxaficp_platform_data tosa_ficp_platform_data = {
 /*
  * Tosa AC IN
  */
+static struct gpiod_lookup_table tosa_charger_gpiod_table = {
+	.dev_id = "gpio-charger",
+	.table = {
+		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_AC_IN, NULL, GPIO_ACTIVE_LOW),
+		{},
+	},
+};
+
 static char *tosa_ac_supplied_to[] = {
 	"main-battery",
 	"backup-battery",
@@ -378,29 +386,14 @@ static char *tosa_ac_supplied_to[] = {
 static struct gpio_charger_platform_data tosa_power_data = {
 	.name			= "charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
-	.gpio			= TOSA_GPIO_AC_IN,
-	.gpio_active_low	= 1,
 	.supplied_to		= tosa_ac_supplied_to,
 	.num_supplicants	= ARRAY_SIZE(tosa_ac_supplied_to),
 };
 
-static struct resource tosa_power_resource[] = {
-	{
-		.name		= "ac",
-		.start		= PXA_GPIO_TO_IRQ(TOSA_GPIO_AC_IN),
-		.end		= PXA_GPIO_TO_IRQ(TOSA_GPIO_AC_IN),
-		.flags		= IORESOURCE_IRQ |
-				  IORESOURCE_IRQ_HIGHEDGE |
-				  IORESOURCE_IRQ_LOWEDGE,
-	},
-};
-
 static struct platform_device tosa_power_device = {
 	.name			= "gpio-charger",
 	.id			= -1,
 	.dev.platform_data	= &tosa_power_data,
-	.resource		= tosa_power_resource,
-	.num_resources		= ARRAY_SIZE(tosa_power_resource),
 };
 
 /*
@@ -950,6 +943,7 @@ static void __init tosa_init(void)
 
 	clk_add_alias("CLK_CK3P6MI", tc6393xb_device.name, "GPIO11_CLK", NULL);
 
+	gpiod_add_lookup_table(&tosa_charger_gpiod_table);
 	gpiod_add_lookup_table(&tosa_udc_gpiod_table);
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 }
-- 
2.26.2

