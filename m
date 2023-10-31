Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846F07DD843
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 23:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbjJaW30 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 18:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbjJaW30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 18:29:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD0D101
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 15:29:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-0000Xx-1v; Tue, 31 Oct 2023 23:29:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEY-005fLL-IR; Tue, 31 Oct 2023 23:29:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEY-00AENP-9S; Tue, 31 Oct 2023 23:29:14 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] interconnect: imx8mm: Convert to platform remove callback returning void
Date:   Tue, 31 Oct 2023 23:28:54 +0100
Message-ID: <20231031222851.3126434-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LpwriCH/6jGpykirIpSXjJAs/28Ctqh388e4SJm7S1U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlQX+m+843Q6YUVTUXF8Xnl0SssXm902SxvQJr0 Zcub/GKOUKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUF/pgAKCRCPgPtYfRL+ TqnkB/9iCu6sMFPMQ7geGqgvaK2msz+beV7nFyF9NGiat/BLyVdb1LCn/E1LqKU2ZX9jIHo6FLg EwENzw3gLEVgR74b2CEG2l43fhs/UVg9BqyvMBvW2/4ptBJQ9Sz8XG3a+RSpVoBTejvhyyKovwp pEbyfNz198ux9OnLh40vYLQhWCmE6afkDY9ZV517JcdU1ep6A81AzkuU+C4tFZEMW7rc/0DLzJ1 8B8oDyg6SiIsuoLLI5LRknTMpfI2wv6qzjlK9fZmCr0ye6s69UuNna4/6KO60YbAxkU6F7emAyP S8bSfC2Y8PCtt+ncFiUULYlECRRDNFhY/p7UxMavoyFQWVzn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/interconnect/imx/imx8mm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
index b43325364aa3..8c40f4182263 100644
--- a/drivers/interconnect/imx/imx8mm.c
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -86,16 +86,9 @@ static int imx8mm_icc_probe(struct platform_device *pdev)
 	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
-static int imx8mm_icc_remove(struct platform_device *pdev)
-{
-	imx_icc_unregister(pdev);
-
-	return 0;
-}
-
 static struct platform_driver imx8mm_icc_driver = {
 	.probe = imx8mm_icc_probe,
-	.remove = imx8mm_icc_remove,
+	.remove_new = imx_icc_unregister,
 	.driver = {
 		.name = "imx8mm-interconnect",
 	},
-- 
2.42.0

