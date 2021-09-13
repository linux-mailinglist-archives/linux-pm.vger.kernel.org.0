Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6B8409AED
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbhIMRkC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:40:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58796 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244247AbhIMRjp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B49E02005E2;
        Mon, 13 Sep 2021 19:38:27 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CD002005DD;
        Mon, 13 Sep 2021 19:38:27 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CF2F020363;
        Mon, 13 Sep 2021 19:38:26 +0200 (CEST)
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
Subject: [RFC 06/19] devfreq: imx8m-ddrc: Add late system sleep PM ops
Date:   Mon, 13 Sep 2021 20:38:01 +0300
Message-Id: <1631554694-9599-7-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Seems that, in order to be able to resume from suspend, the dram rate
needs to be the highest one available. Therefore, add the late system
suspend/resume PM ops which set the highest rate on suspend and the
latest one used before suspending on resume.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index f18a5c3c1c03..f39741b4a0b0 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -72,6 +72,8 @@ struct imx8m_ddrc {
 	struct clk *dram_alt;
 	struct clk *dram_apb;
 
+	unsigned long suspend_rate;
+	unsigned long resume_rate;
 	int freq_count;
 	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
 };
@@ -271,6 +273,22 @@ static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
 	return ret;
 }
 
+static int imx8m_ddrc_suspend(struct device *dev)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+
+	priv->resume_rate = clk_get_rate(priv->dram_core);
+
+	return imx8m_ddrc_target(dev, &priv->suspend_rate, 0);
+}
+
+static int imx8m_ddrc_resume(struct device *dev)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+
+	return imx8m_ddrc_target(dev, &priv->resume_rate, 0);
+}
+
 static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
 {
 	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
@@ -324,6 +342,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
 
 		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
 			return -ENODEV;
+
+		if (index ==  0)
+			priv->suspend_rate = freq->rate * 250000;
 	}
 
 	return 0;
@@ -399,11 +420,16 @@ static const struct of_device_id imx8m_ddrc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
 
+static const struct dev_pm_ops imx8m_ddrc_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8m_ddrc_suspend, imx8m_ddrc_resume)
+};
+
 static struct platform_driver imx8m_ddrc_platdrv = {
 	.probe		= imx8m_ddrc_probe,
 	.driver = {
 		.name	= "imx8m-ddrc-devfreq",
-		.of_match_table = imx8m_ddrc_of_match,
+		.pm = &imx8m_ddrc_pm_ops,
+		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
 	},
 };
 module_platform_driver(imx8m_ddrc_platdrv);
-- 
2.31.1

