Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C585012CDD2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 09:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfL3I57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 03:57:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbfL3I57 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Dec 2019 03:57:59 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0887C5C749BE4B0CB7FE;
        Mon, 30 Dec 2019 16:57:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 16:57:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <cw00.choi@samsung.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] PM / devfreq: imx8m-ddrc: Fix inconsistent IS_ERR and PTR_ERR
Date:   Mon, 30 Dec 2019 16:47:31 +0800
Message-ID: <20191230084731.15776-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in imx8m_ddrc_probe().
Detected using Coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/devfreq/imx8m-ddrc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index 53df792..bc82d36 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -395,15 +395,27 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
 	}
 
 	priv->dram_core = devm_clk_get(dev, "core");
+	if (IS_ERR(priv->dram_core)) {
+		ret = PTR_ERR(priv->dram_core);
+		dev_err(dev, "failed to fetch core clock: %d\n", ret);
+		return ret;
+	}
 	priv->dram_pll = devm_clk_get(dev, "pll");
+	if (IS_ERR(priv->dram_pll)) {
+		ret = PTR_ERR(priv->dram_pll);
+		dev_err(dev, "failed to fetch pll clock: %d\n", ret);
+		return ret;
+	}
 	priv->dram_alt = devm_clk_get(dev, "alt");
+	if (IS_ERR(priv->dram_alt)) {
+		ret = PTR_ERR(priv->dram_alt);
+		dev_err(dev, "failed to fetch alt clock: %d\n", ret);
+		return ret;
+	}
 	priv->dram_apb = devm_clk_get(dev, "apb");
-	if (IS_ERR(priv->dram_core) ||
-		IS_ERR(priv->dram_pll) ||
-		IS_ERR(priv->dram_alt) ||
-		IS_ERR(priv->dram_apb)) {
-		ret = PTR_ERR(priv->devfreq);
-		dev_err(dev, "failed to fetch clocks: %d\n", ret);
+	if (IS_ERR(priv->dram_apb)) {
+		ret = PTR_ERR(priv->dram_apb);
+		dev_err(dev, "failed to fetch apb clock: %d\n", ret);
 		return ret;
 	}
 
-- 
2.7.4


