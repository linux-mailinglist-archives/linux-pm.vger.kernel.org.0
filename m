Return-Path: <linux-pm+bounces-161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5F27F6DBA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D951F28136C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162CBE6D;
	Fri, 24 Nov 2023 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C88210D9
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-0005I2-Tj; Fri, 24 Nov 2023 09:10:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGo-00BDaI-6L; Fri, 24 Nov 2023 09:10:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGn-007HhX-TE; Fri, 24 Nov 2023 09:10:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Rob Herring <robh@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] pmdomain: imx-pgc: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:25 +0100
Message-ID: <20231124080623.564924-2-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ScaChVC/V9kVu3ZY1XlqRdIWQ3sKRhQOvuoS/CziQJU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYFmAFDn11bRSgO85PzcCVt2SoWj1zdCIam3kP t2Snn8JSo6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWBZgAAKCRCPgPtYfRL+ Tkp8B/9Tx4X4wh7sDEPlA886O2ZvTcoAutxUdtAa4igcSK1DgiV1/SMjlRM+68oat+kQZ+sehYI 14cRqC4w3vSHdxdAKv3VKlXpFLmpRrZGinarZgDTQxSgi6ur4sQVVmPRqc2O+xf/kxh9WKYjFQB bk8kX0HgCDmBKP7nuzWj3Vn7hKE8E0ob/hp+072bVPY3/XNcaaIbK7OG4O1o+stSn9MlX4JHmkm dCm0DNJzxdHTaOwDv28IeNWRg1WRnf5krEw69AH8AzmPXzU70tq9iZ9x2xGhDzwZkcv4Wa4xTdi gBICvRhNgbImtt26BoT6IMKbZlPwFZtYJdHuNbeYNrkl2bwD
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
 drivers/pmdomain/imx/gpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 7d81e3171d39..d6cf3759570b 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -212,7 +212,7 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx_pgc_power_domain_remove(struct platform_device *pdev)
+static void imx_pgc_power_domain_remove(struct platform_device *pdev)
 {
 	struct imx_pm_domain *domain = pdev->dev.platform_data;
 
@@ -221,8 +221,6 @@ static int imx_pgc_power_domain_remove(struct platform_device *pdev)
 		pm_genpd_remove(&domain->base);
 		imx_pgc_put_clocks(domain);
 	}
-
-	return 0;
 }
 
 static const struct platform_device_id imx_pgc_power_domain_id[] = {
@@ -235,7 +233,7 @@ static struct platform_driver imx_pgc_power_domain_driver = {
 		.name = "imx-pgc-pd",
 	},
 	.probe = imx_pgc_power_domain_probe,
-	.remove = imx_pgc_power_domain_remove,
+	.remove_new = imx_pgc_power_domain_remove,
 	.id_table = imx_pgc_power_domain_id,
 };
 builtin_platform_driver(imx_pgc_power_domain_driver)
-- 
2.42.0


