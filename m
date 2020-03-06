Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3917C20B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 16:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCFPny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 10:43:54 -0500
Received: from inva021.nxp.com ([92.121.34.21]:35292 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFPny (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 10:43:54 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 66F65200BF2;
        Fri,  6 Mar 2020 16:43:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EED8A200BED;
        Fri,  6 Mar 2020 16:43:48 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6F9A240294;
        Fri,  6 Mar 2020 23:43:44 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: add COMPILE_TEST support for i.MX8MM
Date:   Fri,  6 Mar 2020 23:37:37 +0800
Message-Id: <1583509057-8197-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add COMPILE_TEST support to i.MX8MM thermal driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4d6753f..91af271 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -265,7 +265,7 @@ config IMX_SC_THERMAL
 
 config IMX8MM_THERMAL
 	tristate "Temperature sensor driver for Freescale i.MX8MM SoC"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on OF
 	help
 	  Support for Thermal Monitoring Unit (TMU) found on Freescale i.MX8MM SoC.
-- 
2.7.4

