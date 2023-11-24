Return-Path: <linux-pm+bounces-159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1277F6DB7
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1F4281043
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF8BA51;
	Fri, 24 Nov 2023 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB56DD
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGq-0005NC-BY; Fri, 24 Nov 2023 09:10:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-00BDaj-Rb; Fri, 24 Nov 2023 09:10:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-007Hhy-If; Fri, 24 Nov 2023 09:10:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 8/9] pmdomain: qcom-cpr: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:32 +0100
Message-ID: <20231124080623.564924-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231124080623.564924-1-u.kleine-koenig@pengutronix.de>
References: <20231124080623.564924-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TvkOctt3AvlLAkuA7GxL6uPUOFK92fQI8cfQjr4qIY4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFmIBeEvg/DyHJK/ahO9lV4PP34uEyctNMj+E cvI46N0asaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZiAAKCRCPgPtYfRL+ TlbdB/4qFE6/+10hVsz5J3BFePCqlF3xG9CFjV2dCmRPIfeL04RQZck3uHBTNMAWUKaoR+M++um Ncmq54V7xeWL3fIZ87Tukz3BHf8ZWQTJpyVZRWYP2tJknmIoBP5UXR1OjSzNX7pljM1Ke9nal8S Zn7Ql113eqKA/9um2mvKOmA/L4wxLqUsrjJw6krM3bW6UCgXhqOasyYGRFdB7AbS9og1Zq2wqzn ddk1auq9SU6A6ofhsTaKFYB3vX5yykuxbzGis6+GI2QmGOxkJ36wMVddwzmUcI2SrV0MNXV4C+U RInXtGrSPiRXSqCTXLAa1ioghWI9nsvV6FubE8nfuO5VO3Fp
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

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
 drivers/pmdomain/qcom/cpr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index e9dd42bded6f..c64e84a27cc7 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -1712,7 +1712,7 @@ static int cpr_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cpr_remove(struct platform_device *pdev)
+static void cpr_remove(struct platform_device *pdev)
 {
 	struct cpr_drv *drv = platform_get_drvdata(pdev);
 
@@ -1725,8 +1725,6 @@ static int cpr_remove(struct platform_device *pdev)
 	pm_genpd_remove(&drv->pd);
 
 	debugfs_remove_recursive(drv->debugfs);
-
-	return 0;
 }
 
 static const struct of_device_id cpr_match_table[] = {
@@ -1737,7 +1735,7 @@ MODULE_DEVICE_TABLE(of, cpr_match_table);
 
 static struct platform_driver cpr_driver = {
 	.probe		= cpr_probe,
-	.remove		= cpr_remove,
+	.remove_new	= cpr_remove,
 	.driver		= {
 		.name	= "qcom-cpr",
 		.of_match_table = cpr_match_table,
-- 
2.42.0


