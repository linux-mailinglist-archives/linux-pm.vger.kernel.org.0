Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64067271D01
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 10:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgIUIDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 04:03:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbgIUICY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 59A5B41D858DED3A688D;
        Mon, 21 Sep 2020 16:02:23 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:13 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] interconnect: simplify the return expression of imx_icc_unregister
Date:   Mon, 21 Sep 2020 16:24:37 +0800
Message-ID: <20200921082437.2591461-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/interconnect/imx/imx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index ac420f86008e..40fa22a32a60 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -269,15 +269,10 @@ EXPORT_SYMBOL_GPL(imx_icc_register);
 int imx_icc_unregister(struct platform_device *pdev)
 {
 	struct icc_provider *provider = platform_get_drvdata(pdev);
-	int ret;
 
 	imx_icc_unregister_nodes(provider);
 
-	ret = icc_provider_del(provider);
-	if (ret)
-		return ret;
-
-	return 0;
+	return icc_provider_del(provider);
 }
 EXPORT_SYMBOL_GPL(imx_icc_unregister);
 
-- 
2.25.1

