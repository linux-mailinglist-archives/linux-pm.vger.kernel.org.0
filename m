Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18AAD787BC
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 10:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfG2Isu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 04:48:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43214 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfG2Ist (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 04:48:49 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B88A2000E0;
        Mon, 29 Jul 2019 10:48:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FA04201499;
        Mon, 29 Jul 2019 10:48:43 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 06CCB402F1;
        Mon, 29 Jul 2019 16:48:36 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/4] thermal: qoriq: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
Date:   Mon, 29 Jul 2019 16:39:13 +0800
Message-Id: <20190729083915.4855-2-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190729083915.4855-1-Anson.Huang@nxp.com>
References: <20190729083915.4855-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Use __maybe_unused for power management related functions
instead of #if CONFIG_PM_SLEEP to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 drivers/thermal/qoriq_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c7c7de2..2b2f79b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -240,8 +240,7 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int qoriq_tmu_suspend(struct device *dev)
+static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 {
 	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
@@ -254,7 +253,7 @@ static int qoriq_tmu_suspend(struct device *dev)
 	return 0;
 }
 
-static int qoriq_tmu_resume(struct device *dev)
+static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 {
 	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
@@ -266,7 +265,6 @@ static int qoriq_tmu_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 			 qoriq_tmu_suspend, qoriq_tmu_resume);
-- 
2.7.4

