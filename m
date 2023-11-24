Return-Path: <linux-pm+bounces-157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F67F6DB6
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF0A2813ED
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171CF9465;
	Fri, 24 Nov 2023 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2210C9
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGq-0005Lb-5P; Fri, 24 Nov 2023 09:10:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-00BDaf-M7; Fri, 24 Nov 2023 09:10:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-007Hhv-Ch; Fri, 24 Nov 2023 09:10:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Deepak R Varma <drv@mailo.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] pmdomain: imx93-pd: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:31 +0100
Message-ID: <20231124080623.564924-8-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yy9gFuFNpTLc/Pe0aEdJde7KOwn/xDLMN/UNcrEXH34=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFmHUZpLEUUV3mYdabWBwU87kR9TLyLhza+Y3 uwAWZ5Z02SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZhwAKCRCPgPtYfRL+ Tr99CACMuZoZzrgU6ld8SXN7idj3I7cjJlqRT+NB/oqr57VuP6FBd0hGfuP4ksBeH7dykRJbie2 jw+cBZBfz4zAln7CTVPyqO0vtWzGgbUyoc+WLz0VUmC5rzZLlMrVLkNP1KJ4ra4kpk0zviJAxiy m3MnC7ayg00mfxqZWl8aXzOKJ0WANucH+pllNr58S9EOi7uh/jPYwmN3WnWhtl4yI2Ythdizaru xCUqQ28kqu6PsGR0NpM84/Dvtizl83mgTFRq5D29QO5PygHm979i2MKbv6uSrPLTFxykWEzNb3x L2mxIhjwppFERbtNBV8a2DBmVhI2IJvzRA3cKnIL4IlRuPLr
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
 drivers/pmdomain/imx/imx93-pd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
index b9e60d136875..1e94b499c19b 100644
--- a/drivers/pmdomain/imx/imx93-pd.c
+++ b/drivers/pmdomain/imx/imx93-pd.c
@@ -83,7 +83,7 @@ static int imx93_pd_off(struct generic_pm_domain *genpd)
 	return 0;
 };
 
-static int imx93_pd_remove(struct platform_device *pdev)
+static void imx93_pd_remove(struct platform_device *pdev)
 {
 	struct imx93_power_domain *domain = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -94,8 +94,6 @@ static int imx93_pd_remove(struct platform_device *pdev)
 
 	of_genpd_del_provider(np);
 	pm_genpd_remove(&domain->genpd);
-
-	return 0;
 }
 
 static int imx93_pd_probe(struct platform_device *pdev)
@@ -167,7 +165,7 @@ static struct platform_driver imx93_power_domain_driver = {
 		.of_match_table = imx93_pd_ids,
 	},
 	.probe = imx93_pd_probe,
-	.remove = imx93_pd_remove,
+	.remove_new = imx93_pd_remove,
 };
 module_platform_driver(imx93_power_domain_driver);
 
-- 
2.42.0


