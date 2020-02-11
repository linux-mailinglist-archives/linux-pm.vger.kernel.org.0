Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70C78159D4A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 00:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgBKXip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 18:38:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42015 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBKXio (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 18:38:44 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 1502ec76482e32b6; Wed, 12 Feb 2020 00:38:43 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Peter Chen <Peter.Chen@nxp.com>, linux-usb@vger.kernel.org
Subject: [PATCH 23/28] drivers: usb: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:28:44 +0100
Message-ID: <19064076.ICumzjfW0v@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/remove_request() instead of
pm_qos_add/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index d8e7eb2f97b9..a479af3ae31d 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -393,8 +393,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	}
 
 	if (pdata.flags & CI_HDRC_PMQOS)
-		pm_qos_add_request(&data->pm_qos_req,
-			PM_QOS_CPU_DMA_LATENCY, 0);
+		cpu_latency_qos_add_request(&data->pm_qos_req, 0);
 
 	ret = imx_get_clks(dev);
 	if (ret)
@@ -478,7 +477,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		/* don't overwrite original ret (cf. EPROBE_DEFER) */
 		regulator_disable(data->hsic_pad_regulator);
 	if (pdata.flags & CI_HDRC_PMQOS)
-		pm_qos_remove_request(&data->pm_qos_req);
+		cpu_latency_qos_remove_request(&data->pm_qos_req);
 	data->ci_pdev = NULL;
 	return ret;
 }
@@ -499,7 +498,7 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 	if (data->ci_pdev) {
 		imx_disable_unprepare_clks(&pdev->dev);
 		if (data->plat_data->flags & CI_HDRC_PMQOS)
-			pm_qos_remove_request(&data->pm_qos_req);
+			cpu_latency_qos_remove_request(&data->pm_qos_req);
 		if (data->hsic_pad_regulator)
 			regulator_disable(data->hsic_pad_regulator);
 	}
@@ -527,7 +526,7 @@ static int __maybe_unused imx_controller_suspend(struct device *dev)
 
 	imx_disable_unprepare_clks(dev);
 	if (data->plat_data->flags & CI_HDRC_PMQOS)
-		pm_qos_remove_request(&data->pm_qos_req);
+		cpu_latency_qos_remove_request(&data->pm_qos_req);
 
 	data->in_lpm = true;
 
@@ -547,8 +546,7 @@ static int __maybe_unused imx_controller_resume(struct device *dev)
 	}
 
 	if (data->plat_data->flags & CI_HDRC_PMQOS)
-		pm_qos_add_request(&data->pm_qos_req,
-			PM_QOS_CPU_DMA_LATENCY, 0);
+		cpu_latency_qos_add_request(&data->pm_qos_req, 0);
 
 	ret = imx_prepare_enable_clks(dev);
 	if (ret)
-- 
2.16.4





