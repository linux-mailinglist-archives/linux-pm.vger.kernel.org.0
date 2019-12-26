Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5808112AAB0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 07:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLZG4F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 01:56:05 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59632 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfLZG4F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Dec 2019 01:56:05 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 78D541A163E;
        Thu, 26 Dec 2019 07:56:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E5F71A0BFA;
        Thu, 26 Dec 2019 07:55:58 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 48DE7402B3;
        Thu, 26 Dec 2019 14:55:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] cpufreq: imx-cpufreq-dt: Add i.MX8MP support
Date:   Thu, 26 Dec 2019 14:52:47 +0800
Message-Id: <1577343167-16376-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577343167-16376-1-git-send-email-Anson.Huang@nxp.com>
References: <1577343167-16376-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add i.MX8MP cpufreq DT support for speed grading and market
segment check.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx-cpufreq-dt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 85a6efd..912e93d 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -35,7 +35,7 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_machine_is_compatible("fsl,imx8mn"))
+	if (of_machine_is_compatible("fsl,imx8mn") || of_machine_is_compatible("fsl,imx8mp"))
 		speed_grade = (cell_value & IMX8MN_OCOTP_CFG3_SPEED_GRADE_MASK)
 			      >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
 	else
@@ -54,7 +54,8 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 		if (of_machine_is_compatible("fsl,imx8mm") ||
 		    of_machine_is_compatible("fsl,imx8mq"))
 			speed_grade = 1;
-		if (of_machine_is_compatible("fsl,imx8mn"))
+		if (of_machine_is_compatible("fsl,imx8mn") ||
+			of_machine_is_compatible("fsl,imx8mp"))
 			speed_grade = 0xb;
 	}
 
-- 
2.7.4

