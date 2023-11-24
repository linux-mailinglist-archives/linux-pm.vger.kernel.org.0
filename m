Return-Path: <linux-pm+bounces-153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9AA7F6DB2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15151F20CA5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7BC8F67;
	Fri, 24 Nov 2023 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F61BD
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:10:45 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGq-0005Ot-H0; Fri, 24 Nov 2023 09:10:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGq-00BDan-1e; Fri, 24 Nov 2023 09:10:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6RGp-007Hi2-Ob; Fri, 24 Nov 2023 09:10:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 9/9] pmdomain: xilinx/zynqmp: Convert to platform remove callback returning void
Date: Fri, 24 Nov 2023 09:06:33 +0100
Message-ID: <20231124080623.564924-10-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=C8Pg2Nx+J98OmOxnB4V+j482CtteM/2CgjpQBglZCAU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSEyE67lfUdNpIzRaQVM7MdueOOZMoW12vXii+v0l3qy Jwgo9PJaMzCwMjFICumyGLfuCbTqkousnPtv8swg1iZQKYwcHEKwEQ8znIwrJZpU23POnS9I1aA jzFi0bQWwdvn7zOvX3/w/OE/134yr57xVdfCwIvRbe7P1OZTO2es+Ln1jbCxQ7OT0uyG5v5Ve4L aN80ofSylso5zQpbzba/DIf/8Wio7Pi18+InVcY531GyfVG7Nbxbzf+0IX/GuaTOX5dq43NcOws 5zIpZ0ZorcEnEWY5K9WigmbB/uVOjbfU7KfHJqp9X/uV1yWpfCVoQfPjd3PedZXpmo99ku95v3O DxI8sub1ZTyTNYv+76vqd8NzrMdr7ZGKf/9Oc/O/lxdw9eZWzat7GJaFP/IsObH/H1mcmoxfKkC byXKo/YpBc78dNJ+wiGFori7GhM/OT9kirT3VF59bEIJAA==
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
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
index 69d03ad4cf1e..6fd514286d82 100644
--- a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
+++ b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
@@ -293,11 +293,9 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int zynqmp_gpd_remove(struct platform_device *pdev)
+static void zynqmp_gpd_remove(struct platform_device *pdev)
 {
 	of_genpd_del_provider(pdev->dev.parent->of_node);
-
-	return 0;
 }
 
 static void zynqmp_gpd_sync_state(struct device *dev)
@@ -315,7 +313,7 @@ static struct platform_driver zynqmp_power_domain_driver = {
 		.sync_state = zynqmp_gpd_sync_state,
 	},
 	.probe = zynqmp_gpd_probe,
-	.remove = zynqmp_gpd_remove,
+	.remove_new = zynqmp_gpd_remove,
 };
 module_platform_driver(zynqmp_power_domain_driver);
 
-- 
2.42.0


