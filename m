Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0607409AFC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbhIMRkR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:40:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59276 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343524AbhIMRjz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B02C2005F5;
        Mon, 13 Sep 2021 19:38:38 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2DE712005F0;
        Mon, 13 Sep 2021 19:38:38 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6011620363;
        Mon, 13 Sep 2021 19:38:37 +0200 (CEST)
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
Subject: [RFC 18/19] mmc: sdhci-esdhc-imx: Add interconnect support
Date:   Mon, 13 Sep 2021 20:38:13 +0300
Message-Id: <1631554694-9599-19-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On probe, if the dts node contains a valid icc path, then look for the
fsl,icc-rate property and get the rate. Also set the icc bandwidth
for that path to the nominal rate needed for sdhc to function right.
Then enable and disable the path every time the sdhc is used or not.
This will result in reducing the clock speeds along the icc path
for each pl301 and NoC, but still meet the requirements for all the
other icc consumers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f18d169bc8ff..9773a9efaae1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/interconnect.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/delay.h>
@@ -324,6 +325,9 @@ struct pltfm_imx_data {
 	struct clk *clk_ahb;
 	struct clk *clk_per;
 	unsigned int actual_clock;
+	struct icc_path *bus_path;
+	unsigned int bus_rate;
+
 	enum {
 		NO_CMD_PENDING,      /* no multiblock command pending */
 		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
@@ -1573,6 +1577,19 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
 
+	imx_data->bus_path = devm_of_icc_get(&pdev->dev, "path");
+	if (IS_ERR(imx_data->bus_path)) {
+		err = PTR_ERR(imx_data->bus_path);
+		goto free_sdhci;
+	} else if (imx_data->bus_path) {
+		if (of_property_read_u32(pdev->dev.of_node, "fsl,icc-rate", &imx_data->bus_rate)) {
+			dev_err(&pdev->dev, "icc-rate missing\n");
+			return -EINVAL;
+		}
+
+		err = icc_set_bw(imx_data->bus_path, 0, imx_data->bus_rate);
+	}
+
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
 		err = PTR_ERR(imx_data->clk_ipg);
@@ -1762,14 +1779,20 @@ static int sdhci_esdhc_suspend(struct device *dev)
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
+	icc_disable(imx_data->bus_path);
+
 	return ret;
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	icc_enable(imx_data->bus_path);
+
 	ret = pinctrl_pm_select_default_state(dev);
 	if (ret)
 		return ret;
@@ -1821,6 +1844,8 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 
+	icc_disable(imx_data->bus_path);
+
 	return ret;
 }
 
@@ -1831,6 +1856,8 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int err;
 
+	icc_enable(imx_data->bus_path);
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
 
-- 
2.31.1

