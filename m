Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D4C409AD0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbhIMRjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:39:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58708 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242897AbhIMRjm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:42 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 193BC2005BE;
        Mon, 13 Sep 2021 19:38:25 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 00D1D2005AC;
        Mon, 13 Sep 2021 19:38:25 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 337AE20363;
        Mon, 13 Sep 2021 19:38:24 +0200 (CEST)
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
Subject: [RFC 03/19] devfreq: imx-bus: Decouple imx-bus from icc made
Date:   Mon, 13 Sep 2021 20:37:58 +0300
Message-Id: <1631554694-9599-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The link between an imx-bus device and its icc id will be done
through the fsl,icc-id property in each dts node. The imx
interconnect driver will pick up all the dts nodes that have that
property defined and will link them to the rightfull icc id.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/devfreq/imx-bus.c | 40 +++------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 9d8dc9824d21..95339de8cccf 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -53,36 +53,6 @@ static void imx_bus_exit(struct device *dev)
 	platform_device_unregister(priv->icc_pdev);
 }
 
-/* imx_bus_init_icc() - register matching icc provider if required */
-static int imx_bus_init_icc(struct device *dev)
-{
-	struct imx_bus *priv = dev_get_drvdata(dev);
-	const char *icc_driver_name;
-
-	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
-		return 0;
-	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
-		dev_warn(dev, "imx interconnect drivers disabled\n");
-		return 0;
-	}
-
-	icc_driver_name = of_device_get_match_data(dev);
-	if (!icc_driver_name) {
-		dev_err(dev, "unknown interconnect driver\n");
-		return 0;
-	}
-
-	priv->icc_pdev = platform_device_register_data(
-			dev, icc_driver_name, -1, NULL, 0);
-	if (IS_ERR(priv->icc_pdev)) {
-		dev_err(dev, "failed to register icc provider %s: %ld\n",
-				icc_driver_name, PTR_ERR(priv->icc_pdev));
-		return PTR_ERR(priv->icc_pdev);
-	}
-
-	return 0;
-}
-
 static int imx_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -130,10 +100,6 @@ static int imx_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = imx_bus_init_icc(dev);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -142,9 +108,9 @@ static int imx_bus_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_bus_of_match[] = {
-	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
-	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
-	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
+	{ .compatible = "fsl,imx8mq-noc",},
+	{ .compatible = "fsl,imx8mm-noc",},
+	{ .compatible = "fsl,imx8mn-noc",},
 	{ .compatible = "fsl,imx8m-noc", },
 	{ .compatible = "fsl,imx8m-nic", },
 	{ /* sentinel */ },
-- 
2.31.1

