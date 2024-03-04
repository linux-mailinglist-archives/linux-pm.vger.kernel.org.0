Return-Path: <linux-pm+bounces-4662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1D870CDA
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 22:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F35289936
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B37AE47;
	Mon,  4 Mar 2024 21:29:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D1200A9
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587749; cv=none; b=ZsUx4RUQLBUPvi24lJJ3NLnsGphXwCyb6d9kPs79kc6CwC068JbggiFLIe/lxw5A7lV8v0SiyvJq/l+1ciWCPXlubKFolUXp/ejb6jIIrmczA25rYOUGTFZAAN30aWv2X5jfQOpYqPxeNte7Sk1M9c6QhBhrVFY8u6JpGosPzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587749; c=relaxed/simple;
	bh=0GTgiI9XNwKLwdfdM0l4i/fGODkeH75DZ0pc7W7YrQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHRAONrX4OMhpxo+17zBnEBR/cI7d27s50gUCdz84YcDAKrRoE7hkFIIFF8PlFNkO661eb4I3RRuWf7sMTo1i+pVUKiUIbdCzr8Q/4eO0blfhAHC+YXUKz8tgf9gn8JAgFdeJbRoeSJJWZc8tM5uXT2coAOTod0yaZiJ67GCUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrl-0002hb-4Q; Mon, 04 Mar 2024 22:28:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-004QhM-2A; Mon, 04 Mar 2024 22:28:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrj-00H4uF-3A;
	Mon, 04 Mar 2024 22:28:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/5] PM / devfreq: exynos-nocp: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 22:28:39 +0100
Message-ID:  <8385454855ae5899a4db7655e7a57629855157d8.1709587301.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0GTgiI9XNwKLwdfdM0l4i/fGODkeH75DZ0pc7W7YrQ8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5j0IAzLtKlpzTiHhWfwGAM2RoJHs3l7fVAgvJ 3RuwWqj5UKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeY9CAAKCRCPgPtYfRL+ TpoKB/93Yq8l627M/Q1v+xnPyLEA3as2YGI1ineGJcEWTWPQbYY031YgDzhZsGULV10dpNbF0xU LxsY1kSWt2tKBqxkq0JtjdYuBkc/2yc5DMx6uoRSFbsF5IvShjv4v8BRFqq647mVVJsAoFpo3gs E15REVIFsTsxvR8IK6md3OPDuq5yDTBSglXbL06zbbBMe4sEX7CWUQgP0ABWE8Mkjd0zHGiKu+f ew72rMZrvjtzyYhdO6XdYAdPpA9ll9IqZa+Mnrz1H38rg7xdp/NupLiozyTMVr1uoxhn4i6wdoi ajKGup2aDg/yzE4YI/Tsa55qhpqazRAkwsezFHOznnK0xJ0E
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
 drivers/devfreq/event/exynos-nocp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index c1cc23bcb995..5edc522f715c 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -275,18 +275,16 @@ static int exynos_nocp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int exynos_nocp_remove(struct platform_device *pdev)
+static void exynos_nocp_remove(struct platform_device *pdev)
 {
 	struct exynos_nocp *nocp = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(nocp->clk);
-
-	return 0;
 }
 
 static struct platform_driver exynos_nocp_driver = {
 	.probe	= exynos_nocp_probe,
-	.remove	= exynos_nocp_remove,
+	.remove_new = exynos_nocp_remove,
 	.driver = {
 		.name	= "exynos-nocp",
 		.of_match_table = exynos_nocp_id_match,
-- 
2.43.0


