Return-Path: <linux-pm+bounces-996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DF80F48D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 18:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A611C20CED
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E87D896;
	Tue, 12 Dec 2023 17:27:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003A9F
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 09:27:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD6X0-0001uN-S6; Tue, 12 Dec 2023 18:26:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD6Ww-00FOPG-CS; Tue, 12 Dec 2023 18:26:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD6Ww-001nbZ-3C; Tue, 12 Dec 2023 18:26:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 1/5] PM / devfreq: sun8i-a33-mbus: Simplify usage of clk_rate_exclusive_get()
Date: Tue, 12 Dec 2023 18:26:38 +0100
Message-ID:  <5ef585a3d7bee42bac5be0e40efcfbc6e75adfff.1702400947.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702400947.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702400947.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=BWEEMlbdk3cKjZWyjUvI7IytAUTTT/WV9gCP1GmZcvI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBleJfOPmhzoDA5sG4qdhrM/sUvX0qCREHgSRiU7 27S9foq6kCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXiXzgAKCRCPgPtYfRL+ Thb/B/4w7Bw3FZfecp+Y/PyOwb2XfViWXvM2i2f8tgwva1QajIak9kWuF0ZP1djzjPmArx0WOgi YUd/05PoXflA6sbaolfQrr4uKIRiukF7cs3ohwBjLwCfdVM8FroeP9KIXAcvi3qyX783jicwxzz fLisYqpkTtYsnKPzHhLumHKKIMV4fmWgYpWm9cE8bIVn//IUWOwN5Of3ighdH0PZqg4CKWEuNSW APNEhWEhPIc1XPW5xsBB1SSTPRTRAlVvyFjO1JEO8LIYr1azhNzgV1YWEeWY9A0JKQXaYwNW8Sl 9L6/ctC/RrM5mOka4woknUF4DKZbyZ3GNUf/9rwQwdyWwYUv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

clk_rate_exclusive_get() returns 0 unconditionally. So remove error
handling. This prepares making clk_rate_exclusive_get() return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/devfreq/sun8i-a33-mbus.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index 13d32213139f..bbc577556944 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -381,18 +381,10 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 				     "failed to enable bus clock\n");
 
 	/* Lock the DRAM clock rate to keep priv->nominal_bw in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_dram);
-	if (ret) {
-		err = "failed to lock dram clock rate\n";
-		goto err_disable_bus;
-	}
+	clk_rate_exclusive_get(priv->clk_dram);
 
 	/* Lock the MBUS clock rate to keep MBUS_TMR_PERIOD in sync. */
-	ret = clk_rate_exclusive_get(priv->clk_mbus);
-	if (ret) {
-		err = "failed to lock mbus clock rate\n";
-		goto err_unlock_dram;
-	}
+	clk_rate_exclusive_get(priv->clk_mbus);
 
 	priv->gov_data.upthreshold	= 10;
 	priv->gov_data.downdifferential	=  5;
@@ -450,9 +442,7 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	dev_pm_opp_remove_all_dynamic(dev);
 err_unlock_mbus:
 	clk_rate_exclusive_put(priv->clk_mbus);
-err_unlock_dram:
 	clk_rate_exclusive_put(priv->clk_dram);
-err_disable_bus:
 	clk_disable_unprepare(priv->clk_bus);
 
 	return dev_err_probe(dev, ret, err);
-- 
2.42.0


