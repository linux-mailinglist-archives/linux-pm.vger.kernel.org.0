Return-Path: <linux-pm+bounces-4661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B826870CD9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 22:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9921F225AB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DCE7A736;
	Mon,  4 Mar 2024 21:29:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A4482DA
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587748; cv=none; b=TajP8UzkGii6qUZF5mff3Z4si/Kh5+1nrfgicXsjBVopKZp+yJH0S9sWdh2if6tmMMWx9bEDDVZRKgn33R2aW3NnThjwnHptH1JyX/lX9V6LvYfV8TD9xOJQpk7rVm14EaHSZmm3uJ3CIxXEM/yt5+QDQElFyTJ2KiF12gfW9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587748; c=relaxed/simple;
	bh=PBrEihezR5AA0ClQxijXvIVfy7IrlYrl4T4cYnc+AtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZ8dwBgxvGOh3l0s/x/SExCPXrjXUwRqlZZ1dB5ANScF7Ggv7FYQCkJV1zRYI6kRff0RQ0Fe6AnmwIhyZ40BpjijSN4HMxfO1BzfilXnOmltCNmheUU1r5AgKP4kbX2Y/owLtMtR8cSabVLpJVQvanGCbRmhmCSLiR6Bf5lf8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrm-0002hx-4i; Mon, 04 Mar 2024 22:28:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-004QhY-W6; Mon, 04 Mar 2024 22:28:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-00H4uV-2u;
	Mon, 04 Mar 2024 22:28:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 5/5] PM / devfreq: sun8i-a33-mbus: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 22:28:43 +0100
Message-ID:  <0ca3f35bdf9549ccda7c6c10a476f28350d987df.1709587301.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709587301.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709587301.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=PBrEihezR5AA0ClQxijXvIVfy7IrlYrl4T4cYnc+AtQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5j0Nd/4vLbyJrlXlBYNLAsGnaqFmZKtQd7jX+ srJRfHCOFqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeY9DQAKCRCPgPtYfRL+ TlM6CACbzzNWmx8B9+BCzK0no3gbBhtyaxUgC5dVdB5//xc7v2zhLurgFAbxXxysS/W3uJaFJ20 uDPXWRhb0pck20FRdiFPTu2laILpgow/u97a76d8Qch1dZUeLLgG3X61Y59PhP67Yb2eizO/92M vsV2a7bGLIK7g6+HXU0DhLbRYjemnmX2Wem8Ob6e1MXcVW05E25E3b7mvC8CHjlkIrduImVWYth X9ic/6CeF/54+KUL2LYdSLYH0UV3nPNpHBEwjMZhfdz/r0hkoOW29227mwb3GBTOM4O0vBC9pfT E73seSaecZz8dKy5CFKqs8hwHHseEra4F4MYorwHXI/o6j7D
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
 drivers/devfreq/sun8i-a33-mbus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index 13d32213139f..bcf654f4ff96 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -458,7 +458,7 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	return dev_err_probe(dev, ret, err);
 }
 
-static int sun8i_a33_mbus_remove(struct platform_device *pdev)
+static void sun8i_a33_mbus_remove(struct platform_device *pdev)
 {
 	struct sun8i_a33_mbus *priv = platform_get_drvdata(pdev);
 	unsigned long initial_freq = priv->profile.initial_freq;
@@ -475,8 +475,6 @@ static int sun8i_a33_mbus_remove(struct platform_device *pdev)
 	clk_rate_exclusive_put(priv->clk_mbus);
 	clk_rate_exclusive_put(priv->clk_dram);
 	clk_disable_unprepare(priv->clk_bus);
-
-	return 0;
 }
 
 static const struct sun8i_a33_mbus_variant sun50i_a64_mbus = {
@@ -497,7 +495,7 @@ static SIMPLE_DEV_PM_OPS(sun8i_a33_mbus_pm_ops,
 
 static struct platform_driver sun8i_a33_mbus_driver = {
 	.probe	= sun8i_a33_mbus_probe,
-	.remove	= sun8i_a33_mbus_remove,
+	.remove_new = sun8i_a33_mbus_remove,
 	.driver	= {
 		.name		= "sun8i-a33-mbus",
 		.of_match_table	= sun8i_a33_mbus_of_match,
-- 
2.43.0


