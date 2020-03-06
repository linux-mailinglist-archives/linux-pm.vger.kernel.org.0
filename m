Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8125A17C21C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCFPtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 10:49:20 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40852 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCFPtT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 10:49:19 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EC42D200BFC;
        Fri,  6 Mar 2020 16:49:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A214200C23;
        Fri,  6 Mar 2020 16:49:01 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7B7094029B;
        Fri,  6 Mar 2020 23:48:47 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        linux@roeck-us.net, daniel.baluta@nxp.com, linux@rempel-privat.de,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, enric.balletbo@collabora.com, ronald@innovation.ch,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for KEYBOARD_IMX_SC_KEY
Date:   Fri,  6 Mar 2020 23:42:34 +0800
Message-Id: <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add COMPILE_TEST support to i.MX SC keyboard driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4706ff0..81e26f6 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -467,7 +467,7 @@ config KEYBOARD_IMX
 
 config KEYBOARD_IMX_SC_KEY
 	tristate "IMX SCU Key Driver"
-	depends on IMX_SCU
+	depends on IMX_SCU || COMPILE_TEST
 	help
 	  This is the system controller key driver for NXP i.MX SoCs with
 	  system controller inside.
-- 
2.7.4

