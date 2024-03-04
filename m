Return-Path: <linux-pm+bounces-4659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79633870CD5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 22:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA5A1F21C84
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 21:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366078B69;
	Mon,  4 Mar 2024 21:29:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63F200CD
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587748; cv=none; b=ImvQWe4m7VdRujvlEERDf/VrM/3X49MAsYSVS5WebO9JaJxWWAwg7ErR9b99Yzw3Z1IY7dkZdtNiitOO5KvUnNChLH7ttnqcaD/0soKPI5JYDTy/SETFqPVrny7MKnd8lJgHdnhf5CrXFUfSY2VnJctv9QRn5inJbAjZiz8RUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587748; c=relaxed/simple;
	bh=WkAMU1jS5gkMcXbruT0u3SkkBeEdVbI821m1pxNR9Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3zj+6Rg/OJB5tydtp9xgeUoBMon4n0iebR+xCym9NP7EPhQTx8zha4N35yiBxqgw5zDwHFEFf+/xJZFtdLP/NcuX0gqRRqcSVpfJ1+oWR7fRATysmOm4Bvb99rA5lnuwr+njVN63cAXZ1q6cNlkv5t9MW05HHeatfx2b/47zfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrl-0002hc-4Q; Mon, 04 Mar 2024 22:28:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-004QhP-8m; Mon, 04 Mar 2024 22:28:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-00H4uJ-0a;
	Mon, 04 Mar 2024 22:28:56 +0100
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
Subject: [PATCH 2/5] PM / devfreq: exynos-ppmu: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 22:28:40 +0100
Message-ID:  <028822439693e7d6a74f33385a3f634bdd7143dd.1709587301.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=WkAMU1jS5gkMcXbruT0u3SkkBeEdVbI821m1pxNR9Wc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5j0Jb0TQlki/z6X9KXH7N4rgac6Lp9lbuNz7h gP4vNA6OdGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeY9CQAKCRCPgPtYfRL+ TqTrB/wIv8LL0R1fUF2/7b5G90138vYJMxUul0GE2smFvfiKra8cp1Xn8D02oQ7FM5eUOH4Ie09 reB94nWjr04NeYD0rFQqYOzhA9Fdawt5QTumuVVW1US2C35npQziC6GN18RLKRjJPJJfRblmJtE ucMb26BdgJrTguBbD+PwzEt8ZmVLZkIZlJ5S8xn2Dyb4eJadbp2bxxoWW4jQwI/AOWxYl5GR+/4 PO1jJ7U4lySywt/EhhGDrtAf163QHJtM07Vgd95zOoqy+ecFdzqxSyR+BJgzWvZOITTjCgP0Hrr hjCwK0Crq06txUdyHo4eRIbROwoJDCidajzEf3I4sQnahtwo
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
 drivers/devfreq/event/exynos-ppmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 56bac4702006..7002df20a49e 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -692,18 +692,16 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int exynos_ppmu_remove(struct platform_device *pdev)
+static void exynos_ppmu_remove(struct platform_device *pdev)
 {
 	struct exynos_ppmu *info = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(info->ppmu.clk);
-
-	return 0;
 }
 
 static struct platform_driver exynos_ppmu_driver = {
 	.probe	= exynos_ppmu_probe,
-	.remove	= exynos_ppmu_remove,
+	.remove_new = exynos_ppmu_remove,
 	.driver = {
 		.name	= "exynos-ppmu",
 		.of_match_table = exynos_ppmu_id_match,
-- 
2.43.0


