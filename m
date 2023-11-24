Return-Path: <linux-pm+bounces-158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6DF7F6DB9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DC7B20C24
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646F5BA39;
	Fri, 24 Nov 2023 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC811F
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-0005Ko-Tt; Fri, 24 Nov 2023 09:10:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-00BDab-Fu; Fri, 24 Nov 2023 09:10:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-007Hhq-5q; Fri, 24 Nov 2023 09:10:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/9] pmdomain: imx93-blk-ctrl: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:30 +0100
Message-ID: <20231124080623.564924-7-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qlTqRAkHlYmqKK29fATW8unizLMrfP09jkrBAih35fw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFmG/UN8qYgG4O1CAZiiL7Pgwp2kRFh2lpG9c rcJb5XPWPKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZhgAKCRCPgPtYfRL+ TjhvCACxH0KfYKXiutfgoinNuzIIxkpnBLcXyGmmDksEkYt1HQdGYhuc0HveuhkcvNn7q6HkxRH XgWShZ1hyUiXNTUKxMrrvhXcUzBLQnMDaZ8WChtpvDUwNKk///wHYIH7V2ltNnKMLMO6WmF1IV1 6nkoZ49n765pD0YoVemRbtyniNnL8f3GwntkOmoepA8hCVF5e7JaXDpQ6yt/n3Lbnf0Daq3QesD HDDy5dc5bjqiP3KF+mNDd449hONfGmujz1/IBm5r976ZL7bz+n/uzwg/uo9joL8q2r20JI1EKHT 8T+0dX/70a8IQsg91ItxYEj5ZZt14QXMFI5QhKzYYmVc9mJo
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
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 40bd90f8b977..904ffa55b8f4 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -306,7 +306,7 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx93_blk_ctrl_remove(struct platform_device *pdev)
+static void imx93_blk_ctrl_remove(struct platform_device *pdev)
 {
 	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
 	int i;
@@ -318,8 +318,6 @@ static int imx93_blk_ctrl_remove(struct platform_device *pdev)
 
 		pm_genpd_remove(&domain->genpd);
 	}
-
-	return 0;
 }
 
 static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
@@ -438,7 +436,7 @@ MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
 
 static struct platform_driver imx93_blk_ctrl_driver = {
 	.probe = imx93_blk_ctrl_probe,
-	.remove = imx93_blk_ctrl_remove,
+	.remove_new = imx93_blk_ctrl_remove,
 	.driver = {
 		.name = "imx93-blk-ctrl",
 		.of_match_table = imx93_blk_ctrl_of_match,
-- 
2.42.0


