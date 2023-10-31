Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB87DD84B
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 23:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346693AbjJaW33 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346762AbjJaW32 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 18:29:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B9B101
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 15:29:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEa-0000Zt-BC; Tue, 31 Oct 2023 23:29:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-005fLi-Uc; Tue, 31 Oct 2023 23:29:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-00AENn-LX; Tue, 31 Oct 2023 23:29:15 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 8/9] interconnect: qcom/smd-rpm: Convert to platform remove callback returning void
Date:   Tue, 31 Oct 2023 23:29:00 +0100
Message-ID: <20231031222851.3126434-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7gsJHlELy9BTLl5Jw/58i2c4D7w+nXHlC5QTB4Or12M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlQX+tM+Cy1SnspZ3SEQLEoWArCkU06uzBA1+5D P+4XcTp64aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUF/rQAKCRCPgPtYfRL+ TsDyCACastPbBzbvr2e5MtlGTdzAN//5P6ujuhVp2Q7l7bGa2nN1MSGgVzqKfoWvJ3bYMK7ZKPq 2MgZFhiZkxsnA/IiGDdJQ7XpCje52efE59Rm2C4OOljfH+QCwBGJoC8o1ewHuw4Yn50WfLZq/Pk 6TCEPKUsKuq7HNDSQK/5JGw6qsGkR9YC/gmyU0cSnn1ze7yh/NJ3nvuJIBbmRk5+/NUh1fdzy29 HiUYiK0+FciKwWY+yAR5tlx2hsTQcRkqf4L39lBK7B0IFw8K9GTj1ui7XYLVItUczncDhpUOgW7 Z2JsgFp84cVvcpmm3oX4Uywiz3A+z8w4SV/gtWTijak9QP47
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
 drivers/interconnect/qcom/smd-rpm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
index 16a145a3c914..3816bfb4e2f3 100644
--- a/drivers/interconnect/qcom/smd-rpm.c
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -63,11 +63,9 @@ int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int ctx, u32 r
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpm_set_bus_rate);
 
-static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
+static void qcom_icc_rpm_smd_remove(struct platform_device *pdev)
 {
 	icc_smd_rpm = NULL;
-
-	return 0;
 }
 
 static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
@@ -87,7 +85,7 @@ static struct platform_driver qcom_interconnect_rpm_smd_driver = {
 		.name		= "icc_smd_rpm",
 	},
 	.probe = qcom_icc_rpm_smd_probe,
-	.remove = qcom_icc_rpm_smd_remove,
+	.remove_new = qcom_icc_rpm_smd_remove,
 };
 module_platform_driver(qcom_interconnect_rpm_smd_driver);
 MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
-- 
2.42.0

