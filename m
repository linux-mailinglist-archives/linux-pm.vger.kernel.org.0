Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A76279EB8
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 04:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfG3CbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 22:31:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45644 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730971AbfG3CbD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 22:31:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4FDF21A0271;
        Tue, 30 Jul 2019 04:31:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 699F41A0537;
        Tue, 30 Jul 2019 04:30:57 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 25307402F2;
        Tue, 30 Jul 2019 10:30:51 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 4/5] thermal: qoriq: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
Date:   Tue, 30 Jul 2019 10:21:25 +0800
Message-Id: <20190730022126.17883-4-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190730022126.17883-1-Anson.Huang@nxp.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
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
index 8d19601..39542c6 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -256,8 +256,7 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int qoriq_tmu_suspend(struct device *dev)
+static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 {
 	u32 tmr;
 	struct qoriq_tmu_data *data = dev_get_drvdata(dev);
@@ -272,7 +271,7 @@ static int qoriq_tmu_suspend(struct device *dev)
 	return 0;
 }
 
-static int qoriq_tmu_resume(struct device *dev)
+static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 {
 	u32 tmr;
 	int ret;
@@ -289,7 +288,6 @@ static int qoriq_tmu_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 			 qoriq_tmu_suspend, qoriq_tmu_resume);
-- 
2.7.4

