Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE407C9942
	for <lists+linux-pm@lfdr.de>; Sun, 15 Oct 2023 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJOOAZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Oct 2023 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJOOAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Oct 2023 10:00:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C314B7
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 07:00:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qs1f8-0005It-Kp; Sun, 15 Oct 2023 16:00:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qs1f7-001rWq-Ti; Sun, 15 Oct 2023 16:00:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qs1f7-00Gg98-KE; Sun, 15 Oct 2023 16:00:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] interconnect: qcom: Convert to platform remove callback returning void
Date:   Sun, 15 Oct 2023 15:59:56 +0200
Message-ID: <20231015135955.1537751-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11798; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2UrDKrtyMGyAoHwe+RkqXe3AcmNZEIMueBDj30f7KJs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlK/BcISbsK16M78Xzy4osMTQ/JtVUbm+u2kN3n ga8P60nNbWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSvwXAAKCRCPgPtYfRL+ TntuB/9AlUz9CHs5iV1X5nOL2jqenQ6N3f9sXViOOLJqJZSL5AW/OCbMv/NnYttHatwCKTwIu7u wVWAMZJgZmz0R4jdfK7rP8GaQvik0PETDVHVXIw9A51+WbKtNkotZAoOBy8JaM02LiWTotLIhEu vaCsJDE0e8BGZZ/1CLrOZgkXXCIV99vdkRwAEk1P0SyzT4VqKhmtbytUWx1NP4tGpf2/28VtZy5 AxZtMmR78yFgsy+PQ1fhwdwc8rzaPfXeOykjDvNhmjkfEUT5xTfVyCSfx5Q9VLerdB5h81U8OlJ rIlj1Uhh0LozmUKU2oISKFjLV9fSe1AGfDn0aYV9LjCtwRv2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Several drivers use qcom_icc_rpmh_remove() as remove callback which
returns zero unconditionally. Make it return void and use .remove_new in
the drivers. There is no change in behaviour.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/interconnect/qcom/icc-rpmh.c | 4 +---
 drivers/interconnect/qcom/icc-rpmh.h | 2 +-
 drivers/interconnect/qcom/qdu1000.c  | 2 +-
 drivers/interconnect/qcom/sa8775p.c  | 2 +-
 drivers/interconnect/qcom/sc7180.c   | 2 +-
 drivers/interconnect/qcom/sc7280.c   | 2 +-
 drivers/interconnect/qcom/sc8180x.c  | 2 +-
 drivers/interconnect/qcom/sc8280xp.c | 2 +-
 drivers/interconnect/qcom/sdm670.c   | 2 +-
 drivers/interconnect/qcom/sdm845.c   | 2 +-
 drivers/interconnect/qcom/sdx55.c    | 2 +-
 drivers/interconnect/qcom/sdx65.c    | 2 +-
 drivers/interconnect/qcom/sdx75.c    | 2 +-
 drivers/interconnect/qcom/sm6350.c   | 2 +-
 drivers/interconnect/qcom/sm8150.c   | 2 +-
 drivers/interconnect/qcom/sm8250.c   | 2 +-
 drivers/interconnect/qcom/sm8350.c   | 2 +-
 drivers/interconnect/qcom/sm8450.c   | 2 +-
 drivers/interconnect/qcom/sm8550.c   | 2 +-
 19 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index b9f27ce3b607..c1aa265c1f4e 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -253,14 +253,12 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpmh_probe);
 
-int qcom_icc_rpmh_remove(struct platform_device *pdev)
+void qcom_icc_rpmh_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_icc_rpmh_remove);
 
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 5f0af8b1fc43..2de29460e808 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -126,6 +126,6 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
 int qcom_icc_rpmh_probe(struct platform_device *pdev);
-int qcom_icc_rpmh_remove(struct platform_device *pdev);
+void qcom_icc_rpmh_remove(struct platform_device *pdev);
 
 #endif
diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index a7392eb73d4a..9cb477d2bdfe 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -1046,7 +1046,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qnoc_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-qdu1000",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index ef1b5e326089..dd6281db08ad 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -2519,7 +2519,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sa8775p",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index af2be1543840..34a1d163d6e1 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -1807,7 +1807,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc7180",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index a626dbc71999..7d33694368e8 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1835,7 +1835,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc7280",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index bdd3471d4ac8..20331e119beb 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1888,7 +1888,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc8180x",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 0270f6c64481..7acd152bf0dd 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -2391,7 +2391,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc8280xp",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdm670.c b/drivers/interconnect/qcom/sdm670.c
index 907e1ff4ff81..e5ee7fbaa641 100644
--- a/drivers/interconnect/qcom/sdm670.c
+++ b/drivers/interconnect/qcom/sdm670.c
@@ -1533,7 +1533,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdm670",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 855802be93fe..584800ac871a 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1802,7 +1802,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdm845",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 4117db046fa0..e97f28b8d2b2 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -913,7 +913,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdx55",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index d3a6c6c148e5..2f3f5479d8a5 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -897,7 +897,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdx65",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index 7ef1f17f3292..7f422c27488d 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -1083,7 +1083,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdx75",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index f41d7e19ba26..20923e8e6110 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -1702,7 +1702,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm6350",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index edfe824cad35..f29b77556a79 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -1864,7 +1864,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8150",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index 661dc18d99db..83aeb3eedc19 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -1991,7 +1991,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 562322d4fc3c..b321c3009acb 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -1961,7 +1961,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8350",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index eb7e17df32ba..b3cd0087377c 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1884,7 +1884,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8450",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index a10c8b6549ee..629faa4c9aae 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -2219,7 +2219,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qcom_icc_rpmh_probe,
-	.remove = qcom_icc_rpmh_remove,
+	.remove_new = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8550",
 		.of_match_table = qnoc_of_match,

base-commit: 9330bf741fdac78c398a866f979fd29fea435a88
-- 
2.42.0

