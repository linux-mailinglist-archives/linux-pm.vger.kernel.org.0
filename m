Return-Path: <linux-pm+bounces-154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA77F6DB3
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A951C20DD3
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E229473;
	Fri, 24 Nov 2023 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C949ED44
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-0005Jn-KJ; Fri, 24 Nov 2023 09:10:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-00BDaX-65; Fri, 24 Nov 2023 09:10:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-007Hhn-T3; Fri, 24 Nov 2023 09:10:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Jindong Yue <jindong.yue@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/9] pmdomain: imx8mp-blk-ctrl: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:29 +0100
Message-ID: <20231124080623.564924-6-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=J5TKZe9XLCtZo13dKntrQAhmrW1hBWN7ep3GErxGSb4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFmFzRQ+zF7AayhzjkInvefSsyDYQVsRWydC2 ExeqteDVgaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZhQAKCRCPgPtYfRL+ TuerCACjUkhJOMTAWU5F7ffBVTR02zxyGwXwDjPmTyAB7JwraU26/yU8U0fMz8Nw6fqdo7i636Q uCTzHklNV/XddZcv5JET/PNz9mdO8KS7shoVHBxjQKd59/Cgrn+uBRpXbq2AFrkFyl50fUdQedS SFUwf8L8/Zk96wOmqvK+bHbU6/M/eXv2b6V1naO6QM29/9JeJko9Q6zOzm0m+qJX/a9+7vmVZfW OZdYexRy5xmhAh1U50TH8ZRQg7s1RwCwlbODRIW7SOsBCH3v/lOzrUwdp8ixUIlf2dLs/Cz/swe W22tBXxsSzXq4KaxBXaouzEdebmasB9SxvFfhxtY84/IFsYD
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
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
index c6ac32c1a8c1..e3203eb6a022 100644
--- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
@@ -760,7 +760,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx8mp_blk_ctrl_remove(struct platform_device *pdev)
+static void imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 {
 	struct imx8mp_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
 	int i;
@@ -777,8 +777,6 @@ static int imx8mp_blk_ctrl_remove(struct platform_device *pdev)
 	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
 
 	dev_pm_domain_detach(bc->bus_power_dev, true);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -856,7 +854,7 @@ MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);
 
 static struct platform_driver imx8mp_blk_ctrl_driver = {
 	.probe = imx8mp_blk_ctrl_probe,
-	.remove = imx8mp_blk_ctrl_remove,
+	.remove_new = imx8mp_blk_ctrl_remove,
 	.driver = {
 		.name = "imx8mp-blk-ctrl",
 		.pm = &imx8mp_blk_ctrl_pm_ops,
-- 
2.42.0


