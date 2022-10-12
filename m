Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE605FC6E0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJLOAo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJLOAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 10:00:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A763ECDF
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 07:00:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oicHl-0004J9-GI; Wed, 12 Oct 2022 16:00:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oicHk-0016Tb-86; Wed, 12 Oct 2022 16:00:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oicHj-007N3Q-95; Wed, 12 Oct 2022 16:00:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH] soc: ti: smartreflex: Simplify getting the opam_sr pointer
Date:   Wed, 12 Oct 2022 16:00:32 +0200
Message-Id: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=go2uoLVLTeknTfindMLyukuO+Mr+RUT3ge5KLA2yz7U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjRsh9XAZH6xG3bldx+P798iuNwqs6cU8bmOGQfunc s3naMFqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY0bIfQAKCRDB/BR4rcrsCUDKB/ wMyx4fYPQhFp9DHbOa4dhbykwNlaQuylcfdJCAWjyKs5ZH0GUHosbX5e2EIjhlyIi4uYfw+l+vb0Qm 50LK3N2G0NAqrWRSDRQgaSORB6yokJ6rJM+EmX8n+39Usi2io6GAAwY3FFwZ09I2oEexnnBiBsxyW9 qURSjrcXUKz6Lmnw1lw4dR6mO/TEamcPsGIiwi+5j/N+jr0b5a6YRNG7+ByaC02mjOiV7E5fNhZk6b cofQWf70Xo/9mQ4bWmQa08l7Q8RcWLWLcA80zwV2T+3esmfRFz0ZqOPC9vtMmcyC2QSW67R/zlLpt9 X8L0TEM6NCpVfrQS/kEGFYmtwj7wFU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The probe function stores the sr_info pointer using
platform_set_drvdata(). Use the corresponding platform_get_drvdata() to
retrieve that pointer in the remove and shutdown functions.

This simplifies these functions and makes error handling unnecessary.
This is a good thing as at least for .remove() returning an error code
doesn't have the desired effect.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/ti/smartreflex.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index ad2bb72e640c..1d0b50feae44 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -940,21 +940,8 @@ static int omap_sr_probe(struct platform_device *pdev)
 
 static int omap_sr_remove(struct platform_device *pdev)
 {
-	struct omap_sr_data *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
-	struct omap_sr *sr_info;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		return -EINVAL;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
-			__func__);
-		return PTR_ERR(sr_info);
-	}
+	struct omap_sr *sr_info = platform_get_drvdata(pdev);
 
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);
@@ -968,20 +955,7 @@ static int omap_sr_remove(struct platform_device *pdev)
 
 static void omap_sr_shutdown(struct platform_device *pdev)
 {
-	struct omap_sr_data *pdata = pdev->dev.platform_data;
-	struct omap_sr *sr_info;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
-		return;
-	}
-
-	sr_info = _sr_lookup(pdata->voltdm);
-	if (IS_ERR(sr_info)) {
-		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
-			__func__);
-		return;
-	}
+	struct omap_sr *sr_info = platform_get_drvdata(pdev);
 
 	if (sr_info->autocomp_active)
 		sr_stop_vddautocomp(sr_info);

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.37.2

