Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81395409ADA
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbhIMRjy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:39:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43904 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244910AbhIMRjt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 101E11A0396;
        Mon, 13 Sep 2021 19:38:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0261E1A0393;
        Mon, 13 Sep 2021 19:38:32 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 34AC320363;
        Mon, 13 Sep 2021 19:38:31 +0200 (CEST)
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
Subject: [RFC 11/19] interconnect: imx: Add imx_icc_get_bw and imx_icc_aggregate functions
Date:   Mon, 13 Sep 2021 20:38:06 +0300
Message-Id: <1631554694-9599-12-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The aggregate function will return whatever is the highest
rate for that specific node. The imx_icc_get_bw sets the
initial avg and peak to 0 in order to avoid setting them to
INT_MAX by the interconnect core.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/interconnect/imx/imx.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index db048df80011..5cc1ce55406c 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -25,6 +25,23 @@ struct imx_icc_node {
 	struct dev_pm_qos_request qos_req;
 };
 
+static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int imx_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg = max(*agg_avg, avg_bw);
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
 static int imx_icc_node_set(struct icc_node *node)
 {
 	struct device *dev = node->provider->dev;
@@ -233,7 +250,8 @@ int imx_icc_register(struct platform_device *pdev,
 	if (!provider)
 		return -ENOMEM;
 	provider->set = imx_icc_set;
-	provider->aggregate = icc_std_aggregate;
+	provider->get_bw = imx_icc_get_bw;
+	provider->aggregate = imx_icc_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev;
-- 
2.31.1

