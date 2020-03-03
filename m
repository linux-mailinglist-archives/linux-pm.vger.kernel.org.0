Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2729E1770DB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 09:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgCCIKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 03:10:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:53916 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgCCIKx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 03:10:53 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A378C200EF8;
        Tue,  3 Mar 2020 09:10:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B490200EDD;
        Tue,  3 Mar 2020 09:10:48 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B4007402A7;
        Tue,  3 Mar 2020 16:10:43 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] thermal: Remove COMPILE_TEST for IMX_SC_THERMAL
Date:   Tue,  3 Mar 2020 16:04:44 +0800
Message-Id: <1583222684-10229-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583222684-10229-1-git-send-email-Anson.Huang@nxp.com>
References: <1583222684-10229-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX SCU thermal driver depends on IMX_SCU which does NOT have
COMPILE_TEST enabled, so need to remove COMPILE_TEST for i.MX
SCU thermal as well.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 165b7d6..4fb87df 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -253,7 +253,7 @@ config IMX_THERMAL
 
 config IMX_SC_THERMAL
 	tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
-	depends on IMX_SCU || COMPILE_TEST
+	depends on IMX_SCU
 	depends on OF
 	help
 	  Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
-- 
2.7.4

