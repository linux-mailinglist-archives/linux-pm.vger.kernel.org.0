Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50BD409B04
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbhIMRkd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:40:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59214 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245000AbhIMRjy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:54 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 674092005AC;
        Mon, 13 Sep 2021 19:38:37 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F5EE2005E6;
        Mon, 13 Sep 2021 19:38:37 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 80C6820363;
        Mon, 13 Sep 2021 19:38:36 +0200 (CEST)
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
Subject: [RFC 17/19] net: ethernet: fec_main: Add interconnect support
Date:   Mon, 13 Sep 2021 20:38:12 +0300
Message-Id: <1631554694-9599-18-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On probe, if the dts node contains a valid icc path, then look for the
fsl,icc-rate property and get the rate. Also set the icc bandwidth
for that path to the nominal rate needed for fec to function right.
Then enable and disable the path every time the fec is used or not.
This will result in reducing the clock speeds along the icc path
for each pl301 and NoC, but still meet the requirements for all the
other icc consumers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7b4961daa254..2c5784febbeb 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -558,6 +558,9 @@ struct fec_enet_private {
 	unsigned int num_tx_queues;
 	unsigned int num_rx_queues;
 
+	struct icc_path *bus_path;
+	unsigned int bus_rate;
+
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
 	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 80bd5c629fa0..67374d436e73 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -48,6 +48,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/interconnect.h>
 #include <linux/clk.h>
 #include <linux/crc32.h>
 #include <linux/platform_device.h>
@@ -3805,6 +3806,18 @@ fec_probe(struct platform_device *pdev)
 	fep->pdev = pdev;
 	fep->dev_id = dev_id++;
 
+	fep->bus_path = devm_of_icc_get(&pdev->dev, "path");
+	if (IS_ERR(fep->bus_path)) {
+		return PTR_ERR(fep->bus_path);
+	} else if (fep->bus_path) {
+		if (of_property_read_u32(np, "fsl,icc-rate", &fep->bus_rate)) {
+			dev_err(&pdev->dev, "icc-rate missing\n");
+			return -EINVAL;
+		}
+
+		icc_set_bw(fep->bus_path, 0, fep->bus_rate);
+	}
+
 	platform_set_drvdata(pdev, ndev);
 
 	if ((of_machine_is_compatible("fsl,imx6q") ||
@@ -4075,6 +4088,8 @@ static int __maybe_unused fec_suspend(struct device *dev)
 	if (fep->clk_enet_out || fep->reg_phy)
 		fep->link = 0;
 
+	icc_disable(fep->bus_path);
+
 	return 0;
 }
 
@@ -4085,6 +4100,8 @@ static int __maybe_unused fec_resume(struct device *dev)
 	int ret;
 	int val;
 
+	icc_enable(fep->bus_path);
+
 	if (fep->reg_phy && !(fep->wol_flag & FEC_WOL_FLAG_ENABLE)) {
 		ret = regulator_enable(fep->reg_phy);
 		if (ret)
@@ -4134,6 +4151,7 @@ static int __maybe_unused fec_runtime_suspend(struct device *dev)
 	clk_disable_unprepare(fep->clk_ahb);
 	clk_disable_unprepare(fep->clk_ipg);
 
+	icc_disable(fep->bus_path);
 	return 0;
 }
 
@@ -4143,6 +4161,7 @@ static int __maybe_unused fec_runtime_resume(struct device *dev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int ret;
 
+	icc_enable(fep->bus_path);
 	ret = clk_prepare_enable(fep->clk_ahb);
 	if (ret)
 		return ret;
-- 
2.31.1

