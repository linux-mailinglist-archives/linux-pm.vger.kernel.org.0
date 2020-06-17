Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A394B1FC812
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQH7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 03:59:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48712 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQH7G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 03:59:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BF1E20090F;
        Wed, 17 Jun 2020 09:59:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C739200900;
        Wed, 17 Jun 2020 09:59:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5CA40402B3;
        Wed, 17 Jun 2020 15:58:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx8mm: Support module autoloading
Date:   Wed, 17 Jun 2020 15:47:54 +0800
Message-Id: <1592380074-19222-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a missing MODULE_DEVICE_TABLE entry to support module autoloading.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx8mm_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index e6061e2..f5124f1 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -220,6 +220,7 @@ static const struct of_device_id imx8mm_tmu_table[] = {
 	{ .compatible = "fsl,imx8mp-tmu", .data = &imx8mp_tmu_data, },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, imx8mm_tmu_table);
 
 static struct platform_driver imx8mm_tmu = {
 	.driver = {
-- 
2.7.4

