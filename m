Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4F3409AF0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbhIMRkE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:40:04 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43672 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244125AbhIMRjo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CC4AF1A0396;
        Mon, 13 Sep 2021 19:38:26 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE23F1A0394;
        Mon, 13 Sep 2021 19:38:26 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EF06520363;
        Mon, 13 Sep 2021 19:38:25 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 05/19] devfreq: imx8m-ddrc: Use the opps acquired from EL3
Date:   Mon, 13 Sep 2021 20:38:00 +0300
Message-Id: <1631554694-9599-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX8M platforms get their dram OPPs from the EL3.
We don't need to duplicate that in the kernel dram dts node.
We should just trust the OPPs provided by the EL3.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 50 +++---------------------------------
 1 file changed, 3 insertions(+), 47 deletions(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index 583123bf2100..f18a5c3c1c03 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -321,38 +321,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
 		if (freq->dram_core_parent_index == 2 &&
 				freq->dram_alt_parent_index == 0)
 			return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int imx8m_ddrc_check_opps(struct device *dev)
-{
-	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
-	struct imx8m_ddrc_freq *freq_info;
-	struct dev_pm_opp *opp;
-	unsigned long freq;
-	int i, opp_count;
-
-	/* Enumerate DT OPPs and disable those not supported by firmware */
-	opp_count = dev_pm_opp_get_opp_count(dev);
-	if (opp_count < 0)
-		return opp_count;
-	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
-		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		if (IS_ERR(opp)) {
-			dev_err(dev, "Failed enumerating OPPs: %ld\n",
-				PTR_ERR(opp));
-			return PTR_ERR(opp);
-		}
-		dev_pm_opp_put(opp);
 
-		freq_info = imx8m_ddrc_find_freq(priv, freq);
-		if (!freq_info) {
-			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
-					freq, DIV_ROUND_CLOSEST(freq, 250000));
-			dev_pm_opp_disable(dev, freq);
-		}
+		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
+			return -ENODEV;
 	}
 
 	return 0;
@@ -360,7 +331,6 @@ static int imx8m_ddrc_check_opps(struct device *dev)
 
 static void imx8m_ddrc_exit(struct device *dev)
 {
-	dev_pm_opp_of_remove_table(dev);
 }
 
 static int imx8m_ddrc_probe(struct platform_device *pdev)
@@ -407,16 +377,7 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = dev_pm_opp_of_add_table(dev);
-	if (ret < 0) {
-		dev_err(dev, "failed to get OPP table\n");
-		return ret;
-	}
-
-	ret = imx8m_ddrc_check_opps(dev);
-	if (ret < 0)
-		goto err;
-
+	priv->profile.polling_ms = 1000;
 	priv->profile.target = imx8m_ddrc_target;
 	priv->profile.exit = imx8m_ddrc_exit;
 	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
@@ -427,13 +388,8 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->devfreq)) {
 		ret = PTR_ERR(priv->devfreq);
 		dev_err(dev, "failed to add devfreq device: %d\n", ret);
-		goto err;
 	}
 
-	return 0;
-
-err:
-	dev_pm_opp_of_remove_table(dev);
 	return ret;
 }
 
-- 
2.31.1

