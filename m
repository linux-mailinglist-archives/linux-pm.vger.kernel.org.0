Return-Path: <linux-pm+bounces-160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C57F6DB8
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FA928133C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261CBA57;
	Fri, 24 Nov 2023 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4A10E3
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-0005I3-U5; Fri, 24 Nov 2023 09:10:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-00BDaL-GZ; Fri, 24 Nov 2023 09:10:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-007Hha-6y; Fri, 24 Nov 2023 09:10:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Rob Herring <robh@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] pmdomain: imx-gpc: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:26 +0100
Message-ID: <20231124080623.564924-3-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mKChXHMFVY1JJWqUlD+w8FECqRJL7ZasmTNw0fEjF3w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFmBSON/a7bIBde/yMEceSyMp/wrEkc+FhAy5 8ivySAIsjKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZgQAKCRCPgPtYfRL+ TgbNCACYvUoW7hCPSuRRyrdtoNDgvF6/cS23DTEHBUfHrVAmGKxXuDWmluQrw8l4+Y4GFyeKwGh 2r0eO8u699EDCGVIbwQHz0VUfL0OspFhPRawwJ0iFTO8jqS+07YvwZEJF5PKMzJ/w4c3chBenHZ VcM3/ny6LOX+5mcg4IRO4lk6BLrnoN0BkKav4MozA5wPfOoK+3Gu/QtksmYH2ody5CVulJxYxQR caDhN8EQEfQ3+iqJzCGhnOgxze1Z4SiiKP2Zq7hKhoa/PfmiN6rzJFk/pbTDW+gFwTRvIaaa/MZ KrtIWSpLDmdNlWMtgRCzxAF/qiXeCMmT2dv2PgJHQ3WhCh1m
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

In the error path emit an error message replacing the (less useful)
message by the core. Apart from the improved error message there is no
change in behaviour.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pmdomain/imx/gpc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index d6cf3759570b..9517cce93d8a 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -509,7 +509,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx_gpc_remove(struct platform_device *pdev)
+static void imx_gpc_remove(struct platform_device *pdev)
 {
 	struct device_node *pgc_node;
 	int ret;
@@ -519,7 +519,7 @@ static int imx_gpc_remove(struct platform_device *pdev)
 	/* bail out if DT too old and doesn't provide the necessary info */
 	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
 	    !pgc_node)
-		return 0;
+		return;
 
 	/*
 	 * If the old DT binding is used the toplevel driver needs to
@@ -529,16 +529,20 @@ static int imx_gpc_remove(struct platform_device *pdev)
 		of_genpd_del_provider(pdev->dev.of_node);
 
 		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
-		if (ret)
-			return ret;
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to remove PU power domain (%pe)\n",
+				ERR_PTR(ret));
+			return;
+		}
 		imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
 
 		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
-		if (ret)
-			return ret;
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to remove ARM power domain (%pe)\n",
+				ERR_PTR(ret));
+			return;
+		}
 	}
-
-	return 0;
 }
 
 static struct platform_driver imx_gpc_driver = {
@@ -547,6 +551,6 @@ static struct platform_driver imx_gpc_driver = {
 		.of_match_table = imx_gpc_dt_ids,
 	},
 	.probe = imx_gpc_probe,
-	.remove = imx_gpc_remove,
+	.remove_new = imx_gpc_remove,
 };
 builtin_platform_driver(imx_gpc_driver)
-- 
2.42.0


