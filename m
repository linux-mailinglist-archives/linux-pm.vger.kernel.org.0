Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE791CBC9F
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 04:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgEIC63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 22:58:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728353AbgEIC62 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 22:58:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DF718F04DBA6D651016;
        Sat,  9 May 2020 10:58:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 10:58:17 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] interconnect: imx: Fix return value check in imx_icc_node_init_qos()
Date:   Sat, 9 May 2020 03:02:14 +0000
Message-ID: <20200509030214.14435-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In case of error, the function of_parse_phandle() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/interconnect/imx/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 6884212511f0..ac420f86008e 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -90,10 +90,10 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 			node->name, node->id);
 	} else {
 		dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);
-		if (IS_ERR(dn)) {
-			dev_warn(dev, "Failed to parse %s: %ld\n",
-				 adj->phandle_name, PTR_ERR(dn));
-			return PTR_ERR(dn);
+		if (!dn) {
+			dev_warn(dev, "Failed to parse %s\n",
+				 adj->phandle_name);
+			return -ENODEV;
 		}
 		/* Allow scaling to be disabled on a per-node basis */
 		if (!dn || !of_device_is_available(dn)) {



