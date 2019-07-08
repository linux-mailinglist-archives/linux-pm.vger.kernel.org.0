Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601D66196C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 05:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfGHDMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 23:12:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52430 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbfGHDMT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 Jul 2019 23:12:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A51D1A0028;
        Mon,  8 Jul 2019 05:12:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 459DD1A0D76;
        Mon,  8 Jul 2019 05:12:12 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7422D402A6;
        Mon,  8 Jul 2019 11:12:05 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] cpufreq: imx-cpufreq-dt: Add i.MX8MN support
Date:   Mon,  8 Jul 2019 11:03:08 +0800
Message-Id: <20190708030308.1815-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MN is a new SoC of i.MX8M series, it also uses speed
grading and market segment fuses for OPP definitions, add
support for this SoC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx-cpufreq-dt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index b54fd26..4f85f31 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -44,10 +44,11 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	 * According to datasheet minimum speed grading is not supported for
 	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
 	 *
-	 * Applies to 8mq and 8mm.
+	 * Applies to i.MX8M series SoCs.
 	 */
 	if (mkt_segment == 0 && speed_grade == 0 && (
 			of_machine_is_compatible("fsl,imx8mm") ||
+			of_machine_is_compatible("fsl,imx8mn") ||
 			of_machine_is_compatible("fsl,imx8mq")))
 		speed_grade = 1;
 
-- 
2.7.4

