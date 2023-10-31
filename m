Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBB7DD84F
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 23:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346762AbjJaW3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346777AbjJaW33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 18:29:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A72102
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 15:29:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEa-0000aB-IW; Tue, 31 Oct 2023 23:29:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEa-005fLn-3t; Tue, 31 Oct 2023 23:29:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-00AENr-RA; Tue, 31 Oct 2023 23:29:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?utf-8?b?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 9/9] interconnect: exynos: Convert to platform remove callback returning void
Date:   Tue, 31 Oct 2023 23:29:01 +0100
Message-ID: <20231031222851.3126434-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hZLmC7oLRNI5ukNaFmDr8gB/uZ2elPw947ehL4cC39s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlQX+uv/wsbukTSOSrYJB8DdNPi4h69NPncXa5R TKW95WnLcKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUF/rgAKCRCPgPtYfRL+ TtHiCACcvV7MZOdsVioH8XA9UmxnlhGDmgwKxTdGYK046BY5M/HlRTEu7EVultLAaml53C+ux5m fLR17I1jXjsh+UkazrUqor0p1XI26sxG6fpq/5GBM34AnfIKGow+hIe8jI/Fv8uLHHhGMGrvkKh uRKnepjACshy/r55IV1HYsrkFAHdbQKHTR/LoCaEhsjCXwTFYOLTiAUutgV7c9T+XVaWES++9br r6t1dsQTaarc2Xkm+QbJ1ndMDQ2Kxn5FeQEahGFyGpfnfL6d/UFqp+nP8gxxDbWh/Y7Ip9fJ+zF Ye9w5HWr66HDAon/afGF2REVjqT/QUbCOdy+B+bfcou3idw2
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
 drivers/interconnect/samsung/exynos.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index ebf09bbf725b..1ba14cb45d5a 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -93,14 +93,12 @@ static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
 	return priv->node;
 }
 
-static int exynos_generic_icc_remove(struct platform_device *pdev)
+static void exynos_generic_icc_remove(struct platform_device *pdev)
 {
 	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
 
 	icc_provider_deregister(&priv->provider);
 	icc_nodes_remove(&priv->provider);
-
-	return 0;
 }
 
 static int exynos_generic_icc_probe(struct platform_device *pdev)
@@ -182,7 +180,7 @@ static struct platform_driver exynos_generic_icc_driver = {
 		.sync_state = icc_sync_state,
 	},
 	.probe = exynos_generic_icc_probe,
-	.remove = exynos_generic_icc_remove,
+	.remove_new = exynos_generic_icc_remove,
 };
 module_platform_driver(exynos_generic_icc_driver);
 
-- 
2.42.0

