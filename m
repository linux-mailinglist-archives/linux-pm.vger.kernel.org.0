Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD0C1265F4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLSPmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:42:52 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56510 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfLSPmw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 10:42:52 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 70EDA1A0B95;
        Thu, 19 Dec 2019 16:42:50 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 63AC01A079C;
        Thu, 19 Dec 2019 16:42:50 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8290E203C8;
        Thu, 19 Dec 2019 16:42:49 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Adam Ford <aford173@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Jacky Bai <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM / devfreq: imx8m-ddrc: Remove unused defines
Date:   Thu, 19 Dec 2019 17:42:47 +0200
Message-Id: <9e89485ca173e1d118748dbe5cfc7068f74079bf.1576769985.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The IMX_SIP_DDR_DVFS_WAIT_CHANGE and IMX_SIP_DDR_FREQ_SET_HIGH defines
are not used so they can be removed.

Fixes: 518e99e2a22e ("PM / devfreq: Add dynamic scaling for imx8m ddr controller")

Reported-by: Shawn Guo <shawn.guo@kernel.org>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index fea169619c59..ecbb1db05ea0 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -13,16 +13,10 @@
 #include <linux/clk-provider.h>
 #include <linux/arm-smccc.h>
 
 #define IMX_SIP_DDR_DVFS			0xc2000004
 
-/* Values starting from 0 switch to specific frequency */
-#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00
-
-/* Deprecated after moving IRQ handling to ATF */
-#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F
-
 /* Query available frequencies. */
 #define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10
 #define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11
 
 /*
-- 
2.17.1

