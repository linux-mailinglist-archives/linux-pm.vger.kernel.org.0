Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B326CFCF3B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 21:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNUKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 15:10:46 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39442 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKNUKq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Nov 2019 15:10:46 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E91520045A;
        Thu, 14 Nov 2019 21:10:43 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 844F1200079;
        Thu, 14 Nov 2019 21:10:43 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7479E205D5;
        Thu, 14 Nov 2019 21:10:42 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC v6 3/9] PM / devfreq: imx: Register interconnect device
Date:   Thu, 14 Nov 2019 22:09:50 +0200
Message-Id: <e0e6a1685ccdad95c9d0c922801afdda8adb9f05.1573761527.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573761527.git.leonard.crestez@nxp.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1573761527.git.leonard.crestez@nxp.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no single device which can represent the imx interconnect.
Instead of adding a virtual one just make the main &noc act as the
global interconnect provider.

The imx interconnect provider driver will scale the NOC and DDRC based
on bandwidth request. More scalable nodes can be added in the future,
for example for audio/display/vpu/gpu NICs.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/imx-devfreq.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
index 620b344e87aa..585d340c0f6e 100644
--- a/drivers/devfreq/imx-devfreq.c
+++ b/drivers/devfreq/imx-devfreq.c
@@ -15,10 +15,11 @@
 struct imx_devfreq {
 	struct devfreq_dev_profile profile;
 	struct devfreq *devfreq;
 	struct clk *clk;
 	struct devfreq_passive_data passive_data;
+	struct platform_device *icc_pdev;
 };
 
 static int imx_devfreq_target(struct device *dev,
 			      unsigned long *freq, u32 flags)
 {
@@ -60,11 +61,40 @@ static int imx_devfreq_get_dev_status(struct device *dev,
 	return 0;
 }
 
 static void imx_devfreq_exit(struct device *dev)
 {
+	struct imx_devfreq *priv = dev_get_drvdata(dev);
+
 	dev_pm_opp_of_remove_table(dev);
+	platform_device_unregister(priv->icc_pdev);
+}
+
+/* imx_devfreq_init_icc() - register matching icc provider if required */
+static int imx_devfreq_init_icc(struct device *dev)
+{
+	struct imx_devfreq *priv = dev_get_drvdata(dev);
+	const char *icc_driver_name;
+
+	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX))
+		return 0;
+	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
+		return 0;
+
+	icc_driver_name = of_device_get_match_data(dev);
+	if (!icc_driver_name)
+		return 0;
+
+	priv->icc_pdev = platform_device_register_data(
+			dev, icc_driver_name, 0, NULL, 0);
+	if (IS_ERR(priv->icc_pdev)) {
+		dev_err(dev, "failed to register icc provider %s: %ld\n",
+				icc_driver_name, PTR_ERR(priv->devfreq));
+		return PTR_ERR(priv->devfreq);
+	}
+
+	return 0;
 }
 
 static int imx_devfreq_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -120,18 +150,25 @@ static int imx_devfreq_probe(struct platform_device *pdev)
 		ret = PTR_ERR(priv->devfreq);
 		dev_err(dev, "failed to add devfreq device: %d\n", ret);
 		goto err;
 	}
 
+	ret = imx_devfreq_init_icc(dev);
+	if (ret)
+		goto err;
+
 	return 0;
 
 err:
 	dev_pm_opp_of_remove_table(dev);
 	return ret;
 }
 
 static const struct of_device_id imx_devfreq_of_match[] = {
+	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
+	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
+	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
 	{ .compatible = "fsl,imx8m-noc", },
 	{ .compatible = "fsl,imx8m-nic", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
-- 
2.17.1

