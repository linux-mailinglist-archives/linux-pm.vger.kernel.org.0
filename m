Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 802BE17E247
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 15:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCIOK5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 10:10:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58920 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgCIOK5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 10:10:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ABB302000D1;
        Mon,  9 Mar 2020 15:10:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0011B2000C5;
        Mon,  9 Mar 2020 15:10:49 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DB271402FC;
        Mon,  9 Mar 2020 22:10:42 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx: Remove unused includes
Date:   Mon,  9 Mar 2020 22:04:28 +0800
Message-Id: <1583762668-12099-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove unused includes to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index e75dda5..d2fa301 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -3,24 +3,17 @@
 // Copyright 2013 Freescale Semiconductor, Inc.
 
 #include <linux/clk.h>
-#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
 #include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/slab.h>
 #include <linux/thermal.h>
-#include <linux/types.h>
 #include <linux/nvmem-consumer.h>
 
 #define REG_SET		0x4
-- 
2.7.4

