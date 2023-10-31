Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906467DD846
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 23:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbjJaW32 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Oct 2023 18:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbjJaW31 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Oct 2023 18:29:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1CB103
        for <linux-pm@vger.kernel.org>; Tue, 31 Oct 2023 15:29:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEZ-0000Xw-1v; Tue, 31 Oct 2023 23:29:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEY-005fLI-Bv; Tue, 31 Oct 2023 23:29:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qxxEY-00AENL-2k; Tue, 31 Oct 2023 23:29:14 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/9] interconnect: qcom: Make qnoc_remove return void
Date:   Tue, 31 Oct 2023 23:28:53 +0100
Message-ID: <20231031222851.3126434-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
References: <20231031222851.3126434-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5551; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IoeCKLYUiMYEB258k7BTNsrq5ClLeVUSXQAw7TiXaII=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlQX+lfWzKuPxqbeIMsV6SjJ41Q5mqOqeN3gppg ncILFknb/SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUF/pQAKCRCPgPtYfRL+ Ttk6B/sEtvTvWt/GBiLA6kJSW5TYu1ghUWoXzlwRbrVQlYkSIt0mvdZ8cEm0x9ApnkCYtSS7I5j Wmuh5jvEUo+/YLmPK68kvlC4rpEK+BGSM53insYgpomkqpC5o5Hw24MqBvrs0AmKeXwmlabU/C+ KrBKaKV27ELgsQzhQlA4pIPzgizJhWQLlhXTnz5eUJBpxgdO9TLQ6YV+WltR2GVhU+aKZnaJQa7 QKZ0RZYngXgMNshY7VuHT7WxNThx5uHXCZrHc93oD3/aN/YNkVDVLzdGUCe+q28m6Nn1F4BChA2 OAOoyX0Uc+DKf39vieEitDaa1o72/GLqeJVZL/LaFssRmlJa
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

Several interconnect/qcom drivers use qnoc_remove() as remove callback.
Make this function return void (instead of unconditionally zero) and
adapt the drivers using this function accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 +---
 drivers/interconnect/qcom/icc-rpm.h | 2 +-
 drivers/interconnect/qcom/msm8916.c | 2 +-
 drivers/interconnect/qcom/msm8939.c | 2 +-
 drivers/interconnect/qcom/msm8996.c | 2 +-
 drivers/interconnect/qcom/qcm2290.c | 2 +-
 drivers/interconnect/qcom/qcs404.c  | 2 +-
 drivers/interconnect/qcom/sdm660.c  | 2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 628e651c555c..fb54e78f8fd7 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -627,14 +627,12 @@ int qnoc_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(qnoc_probe);
 
-int qnoc_remove(struct platform_device *pdev)
+void qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_provider_deregister(&qp->provider);
 	icc_nodes_remove(&qp->provider);
 	clk_disable_unprepare(qp->bus_clk);
-
-	return 0;
 }
 EXPORT_SYMBOL(qnoc_remove);
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index a13768cfd231..f4883d43eae4 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -161,7 +161,7 @@ extern const struct rpm_clk_resource aggre1_branch_clk;
 extern const struct rpm_clk_resource aggre2_branch_clk;
 
 int qnoc_probe(struct platform_device *pdev);
-int qnoc_remove(struct platform_device *pdev);
+void qnoc_remove(struct platform_device *pdev);
 
 bool qcom_icc_rpm_smd_available(void);
 int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 35148880b3e8..499b1a9ac413 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1344,7 +1344,7 @@ MODULE_DEVICE_TABLE(of, msm8916_noc_of_match);
 
 static struct platform_driver msm8916_noc_driver = {
 	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.remove_new = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8916",
 		.of_match_table = msm8916_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index b52c5ac1175c..8ff2c23b1ca0 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1421,7 +1421,7 @@ MODULE_DEVICE_TABLE(of, msm8939_noc_of_match);
 
 static struct platform_driver msm8939_noc_driver = {
 	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.remove_new = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8939",
 		.of_match_table = msm8939_noc_of_match,
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index b73566c9b21f..788131400cd1 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -2108,7 +2108,7 @@ MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
 	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.remove_new = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8996",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index b88cf9a022e0..96735800b13c 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1367,7 +1367,7 @@ MODULE_DEVICE_TABLE(of, qcm2290_noc_of_match);
 
 static struct platform_driver qcm2290_noc_driver = {
 	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.remove_new = qnoc_remove,
 	.driver = {
 		.name = "qnoc-qcm2290",
 		.of_match_table = qcm2290_noc_of_match,
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 9fa1da70c843..11b49a89c03d 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -1083,7 +1083,7 @@ MODULE_DEVICE_TABLE(of, qcs404_noc_of_match);
 
 static struct platform_driver qcs404_noc_driver = {
 	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.remove_new = qnoc_remove,
 	.driver = {
 		.name = "qnoc-qcs404",
 		.of_match_table = qcs404_noc_of_match,
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 7392bebba334..ab91de446da8 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -1714,7 +1714,7 @@ MODULE_DEVICE_TABLE(of, sdm660_noc_of_match);
 
 static struct platform_driver sdm660_noc_driver = {
 	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.remove_new = qnoc_remove,
 	.driver = {
 		.name = "qnoc-sdm660",
 		.of_match_table = sdm660_noc_of_match,
-- 
2.42.0

