Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5441842B8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 09:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCMIez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 04:34:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38956 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCMIez (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Mar 2020 04:34:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D4601A134F;
        Fri, 13 Mar 2020 09:34:53 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85CB91A1343;
        Fri, 13 Mar 2020 09:34:47 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6DDB4402D5;
        Fri, 13 Mar 2020 16:34:40 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] thermal: imx: Calling imx_thermal_unregister_legacy_cooling() in .remove
Date:   Fri, 13 Mar 2020 16:28:14 +0800
Message-Id: <1584088094-24857-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

imx_thermal_unregister_legacy_cooling() should be used for handling
legacy cpufreq cooling cleanups in .remove callback instead of
calling cpufreq_cooling_unregister() and cpufreq_cpu_put() directly,
especially for !CONFIG_CPU_FREQ scenario, no operation needed for
handling legacy cpufreq cooling cleanups at all.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index d2fa301..e761c9b 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -865,8 +865,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 
 	thermal_zone_device_unregister(data->tz);
-	cpufreq_cooling_unregister(data->cdev);
-	cpufreq_cpu_put(data->policy);
+	imx_thermal_unregister_legacy_cooling(data);
 
 	return 0;
 }
-- 
2.7.4

