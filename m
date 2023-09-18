Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302567A4E94
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjIRQTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIRQTX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:19:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4349659FE
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:09:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-00024w-JQ; Mon, 18 Sep 2023 15:37:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-007EZO-5Y; Mon, 18 Sep 2023 15:37:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-002fXG-Sa; Mon, 18 Sep 2023 15:37:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 22/32] power: supply: qcom_smbb: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:50 +0200
Message-Id: <20230918133700.1254499-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4twwal5CxO05aJdYGCbLEbuMJZAYxeRM+s8fOAENmkE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCFJpl1W9dWhwlKYrUlRNCGkMmYKxzkyXXwa2c Rr+map4pUWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQhSaQAKCRCPgPtYfRL+ TtNYCACt0BLDIBGVZ16APWEjpvAppn36ltBpvcueMFQUST8wu0scA9Uog2gi/Z2bX12n+CVmQC+ 7WOTEoMO0BH9T/RkWUvNtsQUv7thWg6mCnv3FiN/Fsc+tiUHpYqqKzsSPj0CYkeQRqzTwtMiqVF UJeN9NqG+cCqb8jQ1GtbOLOACmHlRjVs900JWOdY5xv0VGrUKFcs4i+OT3WQRqjNaqvoTDVHq/x mzHTSF+0yegOczp/9wjWHco6dUZdb8W8AWCDsQFtEHFqscNi6fOL4zpi8mSWeAa31rsmFdKvE34 j/TnLb8Z0Og74Ht/22i2FO940CUFF8jNQdKMj2CPw+TU2/r6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/supply/qcom_smbb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index bd50124eef9f..4e57762e27ba 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -1000,15 +1000,13 @@ static int smbb_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int smbb_charger_remove(struct platform_device *pdev)
+static void smbb_charger_remove(struct platform_device *pdev)
 {
 	struct smbb_charger *chg;
 
 	chg = platform_get_drvdata(pdev);
 
 	regmap_update_bits(chg->regmap, chg->addr + SMBB_CHG_CTRL, CTRL_EN, 0);
-
-	return 0;
 }
 
 static const struct of_device_id smbb_charger_id_table[] = {
@@ -1020,7 +1018,7 @@ MODULE_DEVICE_TABLE(of, smbb_charger_id_table);
 
 static struct platform_driver smbb_charger_driver = {
 	.probe	  = smbb_charger_probe,
-	.remove	 = smbb_charger_remove,
+	.remove_new	 = smbb_charger_remove,
 	.driver	 = {
 		.name   = "qcom-smbb",
 		.of_match_table = smbb_charger_id_table,
-- 
2.40.1

