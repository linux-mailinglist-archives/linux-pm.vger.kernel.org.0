Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBF7DD847
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 23:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346613AbjJaW32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbjJaW31 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 18:29:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879EC109
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 15:29:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-0000Xy-5m; Tue, 31 Oct 2023 23:29:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEY-005fLO-PM; Tue, 31 Oct 2023 23:29:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEY-00AENT-GB; Tue, 31 Oct 2023 23:29:14 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/9] interconnect: imx8mn: Convert to platform remove callback returning void
Date:   Tue, 31 Oct 2023 23:28:55 +0100
Message-ID: <20231031222851.3126434-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pi9hxrh98TW1fq33tvO9dGpcMAyXvHi/wtWC2VrTHmI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTH+uV6TtGTMu8+inzyyz65JLPalD3DM9g2NjJdYeqm+ OSef4c7GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZgIvygHw3RWgemX9nv0TFHe kZoi7mC1+1nDpVsM3tZaKZXcP7xCjIpC5r9QrUzWXbA81GOuQ8KeHy0nDbpXtmz+cf/Jw4i3zxW uB5/uF6ky2r9Z+HLwC8WL9zOiQtQs5yWy3st4LLUy6+3/tK6mnimcHJHxc/WkzLVl+3ZLHpHcfD 3syb/AmQWvlXyW1jqf4trQ8rVqVv1WZpu+597Hp/9a6X3l6GP1RoFaXe8fCcoTDiutfG1vcnmZ+ K4J0pa51sKNMy1nTTpePqVck7ExSoFXnkl4y/PE8BmN6c937dJuy/DzYfzuyjfVY1srY9mba/w3 DdRnxTteZ/ryj4fvhGvi9AmXpgmFbH79q8Yj71r35pg9AA==
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
 drivers/interconnect/imx/imx8mn.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
index 8ce6d8e4bf5e..fa3d4f97dfa4 100644
--- a/drivers/interconnect/imx/imx8mn.c
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -75,16 +75,9 @@ static int imx8mn_icc_probe(struct platform_device *pdev)
 	return imx_icc_register(pdev, nodes, ARRAY_SIZE(nodes), NULL);
 }
 
-static int imx8mn_icc_remove(struct platform_device *pdev)
-{
-	imx_icc_unregister(pdev);
-
-	return 0;
-}
-
 static struct platform_driver imx8mn_icc_driver = {
 	.probe = imx8mn_icc_probe,
-	.remove = imx8mn_icc_remove,
+	.remove_new = imx_icc_unregister,
 	.driver = {
 		.name = "imx8mn-interconnect",
 	},
-- 
2.42.0

