Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0539217CA71
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCGBcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 20:32:45 -0500
Received: from inva020.nxp.com ([92.121.34.13]:41048 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgCGBcp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 20:32:45 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FDE21A0DC5;
        Sat,  7 Mar 2020 02:32:42 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66C5E1A0DD9;
        Sat,  7 Mar 2020 02:32:23 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1AAD9402FC;
        Sat,  7 Mar 2020 09:32:09 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        linux@roeck-us.net, daniel.baluta@nxp.com, linux@rempel-privat.de,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, robh@kernel.org, yuehaibing@huawei.com,
        ronald@innovation.ch, krzk@kernel.org, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/7] firmware: imx: add COMPILE_TEST support
Date:   Sat,  7 Mar 2020 09:25:54 +0800
Message-Id: <1583544359-515-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
References: <1583544359-515-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add COMPILE_TEST support to i.MX SCU drivers for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change.
---
 drivers/firmware/imx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 1d2e5b8..116707a 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -12,7 +12,7 @@ config IMX_DSP
 
 config IMX_SCU
 	bool "IMX SCU Protocol driver"
-	depends on IMX_MBOX
+	depends on IMX_MBOX || COMPILE_TEST
 	help
 	  The System Controller Firmware (SCFW) is a low-level system function
 	  which runs on a dedicated Cortex-M core to provide power, clock, and
@@ -24,6 +24,6 @@ config IMX_SCU
 
 config IMX_SCU_PD
 	bool "IMX SCU Power Domain driver"
-	depends on IMX_SCU
+	depends on IMX_SCU || COMPILE_TEST
 	help
 	  The System Controller Firmware (SCFW) based power domain driver.
-- 
2.7.4

