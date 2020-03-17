Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDAA187891
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 05:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgCQEpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 00:45:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34630 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgCQEpo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Mar 2020 00:45:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B836200C66;
        Tue, 17 Mar 2020 05:45:42 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5CF03200CA5;
        Tue, 17 Mar 2020 05:45:37 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C14F04029F;
        Tue, 17 Mar 2020 12:45:30 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] cpufreq: imx6q-cpufreq: Improve the logic of -EPROBE_DEFER handling
Date:   Tue, 17 Mar 2020 12:38:54 +0800
Message-Id: <1584419934-2303-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Improve the -EPROBE_DEFER handling logic to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 285b8e9..fdb2fff 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -400,11 +400,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		ret = imx6q_opp_check_speed_grading(cpu_dev);
 	}
 	if (ret) {
-		if (ret == -EPROBE_DEFER)
-			goto out_free_opp;
-
-		dev_err(cpu_dev, "failed to read ocotp: %d\n",
-			ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(cpu_dev, "failed to read ocotp: %d\n",
+				ret);
 		goto out_free_opp;
 	}
 
-- 
2.7.4

