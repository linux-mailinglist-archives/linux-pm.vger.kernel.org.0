Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B887DD84D
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 23:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346659AbjJaW3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 18:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbjJaW33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 18:29:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F4F9
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 15:29:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEa-0000ZR-3c; Tue, 31 Oct 2023 23:29:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-005fLf-NK; Tue, 31 Oct 2023 23:29:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-00AENj-EO; Tue, 31 Oct 2023 23:29:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 7/9] interconnect: qcom/osm-l3: Convert to platform remove callback returning void
Date:   Tue, 31 Oct 2023 23:28:59 +0100
Message-ID: <20231031222851.3126434-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FV5lVSDNmSBDNC6b8cZGQhLCc2cvXfAAQZ+SUxO4eGA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlQX+sehtx7ih+fP7NLqS52CVF6FMjz6VlGSzF7 qXfiGdDZ/mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUF/rAAKCRCPgPtYfRL+ Tm00CACH6yKlJ5P3BYkbbmjZy4PrQ6nKRTxfvX0TjByVnjCBezZ7f3CZmrhdvttGT1F/+K5nEO2 ER8F6RPzmsrAFhr2lL2sMPbCUAU7jfFRYyV1qFdGS5Ed4jh1uodFbu37BnersrLE4Soz5gASS47 w/IzZHL1hrUbf83nUmR7p+1k4hRuv7HIE/QgE4nX/ssu1Yw1lXXnJHOZ6UjZ69P9vWh2JUWsOE2 JSm3dT+kHTo56qdjxWV9lq1/Ko5PnD6IS5hm5HKLiW+9SLVYyj26vf/EclhcmJyHCP+cGf0D9kt TZpcHpuWKx+/XpR1hBEkdMCxGWiUoaZ5X0kxqlWSaWu2scMw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/interconnect/qcom/osm-l3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index e97478bbc282..61a8695a9adc 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -148,14 +148,12 @@ static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
-static int qcom_osm_l3_remove(struct platform_device *pdev)
+static void qcom_osm_l3_remove(struct platform_device *pdev)
 {
 	struct qcom_osm_l3_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
-
-	return 0;
 }
 
 static int qcom_osm_l3_probe(struct platform_device *pdev)
@@ -292,7 +290,7 @@ MODULE_DEVICE_TABLE(of, osm_l3_of_match);
 
 static struct platform_driver osm_l3_driver = {
 	.probe = qcom_osm_l3_probe,
-	.remove = qcom_osm_l3_remove,
+	.remove_new = qcom_osm_l3_remove,
 	.driver = {
 		.name = "osm-l3",
 		.of_match_table = osm_l3_of_match,
-- 
2.42.0

