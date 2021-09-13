Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F49409ADE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbhIMRj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:39:56 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43846 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244020AbhIMRjr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:47 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 498691A0394;
        Mon, 13 Sep 2021 19:38:30 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AF011A038F;
        Mon, 13 Sep 2021 19:38:30 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CCDA20363;
        Mon, 13 Sep 2021 19:38:29 +0200 (CEST)
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
Subject: [RFC 09/19] interconnect: imx8mq: Add the pl301_per_m and pl301_wakeup nodes and subnodes
Date:   Mon, 13 Sep 2021 20:38:04 +0300
Message-Id: <1631554694-9599-10-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the bus diagram, there are two more pl301s that need to
be added here. The pl301_per_m which is an intermediary node between
pl301_main and its masters: usdhc1, usdhc2 and sdma. The pl301_wakeup
is an intermediary node between pl301_main and its masters, in this case
all the SAIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/interconnect/imx/imx8mq.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index b8c36d668946..010ad3d76286 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -57,14 +57,25 @@ static struct imx_icc_node_desc nodes[] = {
 	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, IMX8MQ_ICN_MAIN),
 
 	/* OTHER */
-	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("NAND", IMX8MQ_ICM_NAND, IMX8MQ_ICN_MAIN),
-	DEFINE_BUS_MASTER("USDHC1", IMX8MQ_ICM_USDHC1, IMX8MQ_ICN_MAIN),
-	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("PCIE1", IMX8MQ_ICM_PCIE1, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("PCIE2", IMX8MQ_ICM_PCIE2, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN,
 			IMX8MQ_ICN_NOC, IMX8MQ_ICS_OCRAM),
+	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_PER_M),
+	DEFINE_BUS_MASTER("USDHC1", IMX8MQ_ICM_USDHC1, IMX8MQ_ICN_PER_M),
+	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_PER_M),
+	DEFINE_BUS_INTERCONNECT("PL301_PER_M", IMX8MQ_ICN_PER_M,
+			IMX8MQ_ICN_MAIN),
+
+	DEFINE_BUS_MASTER("SAI1", IMX8MQ_ICM_SAI1, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI2", IMX8MQ_ICM_SAI2, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI3", IMX8MQ_ICM_SAI3, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI4", IMX8MQ_ICM_SAI4, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI5", IMX8MQ_ICM_SAI5, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI6", IMX8MQ_ICM_SAI6, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_INTERCONNECT("PL301_WAKEUP", IMX8MQ_ICN_WAKEUP,
+			IMX8MQ_ICN_MAIN),
 };
 
 static int imx8mq_icc_probe(struct platform_device *pdev)
-- 
2.31.1

