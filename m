Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C861B6D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfGHHzk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 03:55:40 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47222 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHHzk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 03:55:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 66E7E1A0136;
        Mon,  8 Jul 2019 09:55:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 223641A0238;
        Mon,  8 Jul 2019 09:55:34 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6C55B402DB;
        Mon,  8 Jul 2019 15:55:27 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] cpufreq: imx-cpufreq-dt: Assign max supported frequency as suspend frequency
Date:   Mon,  8 Jul 2019 15:46:24 +0800
Message-Id: <20190708074624.910-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

To reduce the suspend/resume latency, CPU's max supported frequency
should be used during low level suspend/resume phase, "opp-suspend"
property is NOT feasible since OPP defined in DT could be NOT supported
according to speed garding and market segment fuse settings. So we
can assign the cpufreq policy's suspend_freq with max available
frequency provided by cpufreq driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx-cpufreq-dt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 4f85f31..b6607e8 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -84,6 +85,16 @@ static int imx_cpufreq_dt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __init imx_cpufreq_dt_setup_suspend_opp(void)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
+
+	policy->suspend_freq = cpufreq_quick_get_max(0);
+
+	return 0;
+}
+late_initcall(imx_cpufreq_dt_setup_suspend_opp);
+
 static struct platform_driver imx_cpufreq_dt_driver = {
 	.probe = imx_cpufreq_dt_probe,
 	.remove = imx_cpufreq_dt_remove,
-- 
2.7.4

