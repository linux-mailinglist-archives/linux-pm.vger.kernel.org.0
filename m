Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8B10D65F
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 14:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfK2NwX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 08:52:23 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63861 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfK2NwR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 08:52:17 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: x5YS1I3D2j7XGv86JQvyX3I/EJaSZt0RW5/bPmaB5dvo3CwFhJl01o1XkrDmmwKXJ0l6OlmBtR
 ZJSyKc8RY7j2W706PlLrtHc8VFr2COszWyWBmaBTkxmv6naTR93lDcab7osqShIfC7QUQYGsKo
 E/GjSHebITcd7fz2rbWh9DJjFoownkzHSOW7ltlyKwkWEawFHe1YHXTvM4po3+4FEX4Twb6LQq
 IIMuSfTxXJ3CROlmgVRSgT3I1JVhDZxn6I4rBfO+whRY3mXr9j6ZgmiMNVS7oBy2ks9vorY/YJ
 vhk=
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="58778690"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2019 06:52:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 Nov 2019 06:52:03 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 29 Nov 2019 06:51:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/9] ARM: at91: pm: move SAM9X60's PM under its own SoC config flag
Date:   Fri, 29 Nov 2019 15:51:39 +0200
Message-ID: <1575035505-6310-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
References: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move SAM9X60's PM part under SoC config flag. This allows the building
of SAM9X60 platform withouth depending on CONFIG_SOC_AT91SAM9 flag,
allowing us to select only necessary config flags for SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/Makefile   |  1 +
 arch/arm/mach-at91/at91sam9.c | 18 ------------------
 arch/arm/mach-at91/pm.c       |  2 +-
 arch/arm/mach-at91/sam9x60.c  | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-at91/sam9x60.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index de64301dcff2..f565490f1b70 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -6,6 +6,7 @@
 # CPU-specific support
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
+obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index bf629c90c758..7e572189a5eb 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -31,21 +31,3 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM9")
 	.init_machine	= at91sam9_init,
 	.dt_compat	= at91_dt_board_compat,
 MACHINE_END
-
-static void __init sam9x60_init(void)
-{
-	of_platform_default_populate(NULL, NULL, NULL);
-
-	sam9x60_pm_init();
-}
-
-static const char *const sam9x60_dt_board_compat[] __initconst = {
-	"microchip,sam9x60",
-	NULL
-};
-
-DT_MACHINE_START(sam9x60_dt, "Microchip SAM9X60")
-	/* Maintainer: Microchip */
-	.init_machine	= sam9x60_init,
-	.dt_compat	= sam9x60_dt_board_compat,
-MACHINE_END
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d5af6aedc02c..56a6a49b19e2 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -805,7 +805,7 @@ void __init at91rm9200_pm_init(void)
 
 void __init sam9x60_pm_init(void)
 {
-	if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
+	if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
 		return;
 
 	at91_pm_modes_init();
diff --git a/arch/arm/mach-at91/sam9x60.c b/arch/arm/mach-at91/sam9x60.c
new file mode 100644
index 000000000000..d8c739d25458
--- /dev/null
+++ b/arch/arm/mach-at91/sam9x60.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Setup code for SAM9X60.
+ *
+ * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/system_misc.h>
+
+#include "generic.h"
+
+static void __init sam9x60_init(void)
+{
+	of_platform_default_populate(NULL, NULL, NULL);
+
+	sam9x60_pm_init();
+}
+
+static const char *const sam9x60_dt_board_compat[] __initconst = {
+	"microchip,sam9x60",
+	NULL
+};
+
+DT_MACHINE_START(sam9x60_dt, "Microchip SAM9X60")
+	/* Maintainer: Microchip */
+	.init_machine	= sam9x60_init,
+	.dt_compat	= sam9x60_dt_board_compat,
+MACHINE_END
-- 
2.7.4

