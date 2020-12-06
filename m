Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75C22D04B6
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 13:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgLFMOw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Dec 2020 07:14:52 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:43756 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgLFMOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2020 07:14:52 -0500
Received: from localhost.localdomain ([93.22.38.146])
        by mwinf5d81 with ME
        id 10D32400439BigV030D3FQ; Sun, 06 Dec 2020 13:13:08 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Dec 2020 13:13:08 +0100
X-ME-IP: 93.22.38.146
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     georgi.djakov@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com, weiyongjun1@huawei.com,
        krzk@kernel.org, leonard.crestez@nxp.com, liushixin2@huawei.com,
        abailon@baylibre.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] interconnect: imx: Add a missing of_node_put after of_device_is_available
Date:   Sun,  6 Dec 2020 13:13:04 +0100
Message-Id: <20201206121304.29381-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add an 'of_node_put()' call when a tested device node is not available.

Fixes: f0d8048525d7 ("interconnect: Add imx core driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/interconnect/imx/imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 41dba7090c2a..e398ebf1dbba 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -99,6 +99,7 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 		if (!dn || !of_device_is_available(dn)) {
 			dev_warn(dev, "Missing property %s, skip scaling %s\n",
 				 adj->phandle_name, node->name);
+			of_node_put(dn);
 			return 0;
 		}
 
-- 
2.27.0

