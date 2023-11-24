Return-Path: <linux-pm+bounces-156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA047F6DB5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2678428124A
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56982944D;
	Fri, 24 Nov 2023 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2ADD73
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-0005I5-4I; Fri, 24 Nov 2023 09:10:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-00BDaO-Md; Fri, 24 Nov 2023 09:10:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-007Hhf-D8; Fri, 24 Nov 2023 09:10:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/9] pmdomain: imx-gpcv2: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:27 +0100
Message-ID: <20231124080623.564924-4-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dAOeMNKhHCDwwE6c9MHcnFhpVgfSNdxWzXiPKY4g5es=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFmCxVLnSZhIslltbQeBloQtDxcEOXHqj2Ect XaTJfQr2QWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZggAKCRCPgPtYfRL+ To7aCACxQixfrha80IEqSOawYFwgFgpRh9dJZ71jLo1QwPOabpWx1Z+l5jZwFlMl+pU3oIvTn5K nChatBkTRO4OvdUmibLzlAEiTOtGu/fwVqdyCHSJU+sciUt5vVYUlkK7CdY3g7GwE9wvE40pvX7 8y+ArkCekecKI0kF+svonV5OhF7LCfgxg63JPS+fNTFQaT4xq2OrpK0HyyybeNfiAqT4bjd0ky8 dIl62oLQERa+w3IppMAZvTHT8Oz7VLAb+NULjxikA8V11QnQC5zzjmzNzBMdkQ57/lhz6UlthL1 7dSxFMpwO4ArArTJCyZ2Ngm7DodNLy+/bfczN5Xb9buZMMap
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
 drivers/pmdomain/imx/gpcv2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index fbd3d92f8cd8..4b828d74a606 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1373,7 +1373,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_pgc_domain_remove(struct platform_device *pdev)
+static void imx_pgc_domain_remove(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
 
@@ -1385,8 +1385,6 @@ static int imx_pgc_domain_remove(struct platform_device *pdev)
 				   domain->bits.map, 0);
 
 	pm_runtime_disable(domain->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1430,7 +1428,7 @@ static struct platform_driver imx_pgc_domain_driver = {
 		.pm = &imx_pgc_domain_pm_ops,
 	},
 	.probe    = imx_pgc_domain_probe,
-	.remove   = imx_pgc_domain_remove,
+	.remove_new = imx_pgc_domain_remove,
 	.id_table = imx_pgc_domain_id,
 };
 builtin_platform_driver(imx_pgc_domain_driver)
-- 
2.42.0


