Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91761265F6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLSPnt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:43:49 -0500
Received: from inva021.nxp.com ([92.121.34.21]:50906 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSPnt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 10:43:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26551200196;
        Thu, 19 Dec 2019 16:43:48 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17B33201118;
        Thu, 19 Dec 2019 16:43:48 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 66C16203C8;
        Thu, 19 Dec 2019 16:43:47 +0100 (CET)
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
Subject: [PATCH] PM / devfreq: imx8m-ddrc: Fix argument swap in error print
Date:   Thu, 19 Dec 2019 17:43:45 +0200
Message-Id: <8485366fbf06600d528ac31ef4a873f6717f2fd7.1576770177.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When frequency adjustment fails the old/new frequencies are swapped on
the dev_err call.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index ecbb1db05ea0..53df7923d893 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -258,14 +258,14 @@ static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
 	ret = imx8m_ddrc_set_freq(dev, freq_info);
 
 	new_freq = clk_get_rate(priv->dram_core);
 	if (ret)
 		dev_err(dev, "ddrc failed freq switch to %lu from %lu: error %d. now at %lu\n",
-			old_freq, *freq, ret, new_freq);
+			*freq, old_freq, ret, new_freq);
 	else if (*freq != new_freq)
 		dev_err(dev, "ddrc failed freq update to %lu from %lu, now at %lu\n",
-			old_freq, *freq, new_freq);
+			*freq, old_freq, new_freq);
 	else
 		dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",
 			*freq, old_freq);
 
 	return ret;
-- 
2.17.1

