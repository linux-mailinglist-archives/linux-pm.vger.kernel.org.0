Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27291F030F
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgFEWob (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 18:44:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgFEWoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 18:44:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 85C4A2A51C6
Received: by jupiter.universe (Postfix, from userid 1000)
        id 33916480105; Sat,  6 Jun 2020 00:44:04 +0200 (CEST)
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
Subject: [PATCHv2 5/6] ARM: sa1100: Use GPIO descriptor for gpio-charger
Date:   Sat,  6 Jun 2020 00:44:02 +0200
Message-Id: <20200605224403.181015-6-sebastian.reichel@collabora.com>
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

Due to lack of hardware this has only been compile
tested.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm/mach-sa1100/collie.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 3cc2b71e16f0..3e871a3db3b0 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -30,6 +30,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/power/gpio-charger.h>
 
 #include <video/sa1100fb.h>
@@ -131,6 +132,14 @@ static struct irda_platform_data collie_ir_data = {
 /*
  * Collie AC IN
  */
+static struct gpiod_lookup_table collie_charger_gpiod_table = {
+	.dev_id = "gpio-charger",
+	.table = {
+		GPIO_LOOKUP("gpio", COLLIE_GPIO_AC_IN, NULL, GPIO_ACTIVE_HIGH),
+		{},
+	},
+};
+
 static char *collie_ac_supplied_to[] = {
 	"main-battery",
 	"backup-battery",
@@ -140,7 +149,6 @@ static char *collie_ac_supplied_to[] = {
 static struct gpio_charger_platform_data collie_power_data = {
 	.name			= "charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
-	.gpio			= COLLIE_GPIO_AC_IN,
 	.supplied_to		= collie_ac_supplied_to,
 	.num_supplicants	= ARRAY_SIZE(collie_ac_supplied_to),
 };
@@ -386,6 +394,7 @@ static void __init collie_init(void)
 
 	platform_scoop_config = &collie_pcmcia_config;
 
+	gpiod_add_lookup_table(&collie_charger_gpiod_table);
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
 		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
-- 
2.26.2

