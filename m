Return-Path: <linux-pm+bounces-4658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95934870CD4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 22:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365131F21862
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 21:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F534CE0E;
	Mon,  4 Mar 2024 21:29:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299610A1F
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587747; cv=none; b=gIFeEGkIIfoHb4vguu8csvZFmdN4xMC1AoSh26G1CKan8tv3lC03BwQL3ZBnpFHC9erAfga9ZYraVkr3S0lPLD3qcn/u/YM63OPiZSLDOvNMeB+ANq5dtMCjyfifaECGHC2xrPwNlgfE6x30YiI3V1XCbZL9fft/FpZq/EbZ0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587747; c=relaxed/simple;
	bh=6CAzFt3bd4MLuvqqWDKQBJQf14/nfYSjEqdN94WNtZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isdksGhBM2h1oyvNEUXxc1i6oyGsHGWgLxK/WXctqyRJwwkLJ8whZTDq8fnNV5zHYlCOGnaHwT24Qw04c6SR7HSGAmzxzG13RFAnEl2hvzhNMHAFYsGlLa6L5hD+QI0Y0H3DeYNVJQ1CAtQdpb/x86dtyajqKV3X7E4BvL5PHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrl-0002he-4I; Mon, 04 Mar 2024 22:28:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-004QhV-Ni; Mon, 04 Mar 2024 22:28:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhFrk-00H4uR-26;
	Mon, 04 Mar 2024 22:28:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 4/5] PM / devfreq: rk3399_dmc: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 22:28:42 +0100
Message-ID:  <ead8f47ba6121feb651be0b93d87dce3107ca546.1709587301.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6CAzFt3bd4MLuvqqWDKQBJQf14/nfYSjEqdN94WNtZw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5j0MxSdzyfEutO18odO0QQ6S9wEZk/C2ahR4o TIdt9QPTROJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeY9DAAKCRCPgPtYfRL+ TspzB/46m4CTpbS5esetYFAy7BV6n5oAucyWXewdLq9ubthm8n3zsFhSXS7IhXsMrrB6jSzqY6g 8vix1AXz4nLEGIe6WsmWQNo/QtvFMl9iQ/gbz6klDs0w+KP8u1jgMjGlKnRrwxsGsmPnrJ76wf7 AfQU7aRJA0mRRDekCCEnez+y31gOyQZWRy65iRiH430DlwR+O4M4fu8/ELrzMeCutMDCwSW472p gi27vLj7IPfSPW5Pf/xty++KSsrr/Lmefpo24TeGNf0sj5/Of7Fr0iZ+iph4Tv8cPEx/BVsDl2P S1v12NC4IKOrg/P/qWOGVZtNoQbB22+gBheCZQR9rMG5Gyys
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
 drivers/devfreq/rk3399_dmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index fd2c5ffedf41..d405cee92c25 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -459,13 +459,11 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rk3399_dmcfreq_remove(struct platform_device *pdev)
+static void rk3399_dmcfreq_remove(struct platform_device *pdev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
 
 	devfreq_event_disable_edev(dmcfreq->edev);
-
-	return 0;
 }
 
 static const struct of_device_id rk3399dmc_devfreq_of_match[] = {
@@ -476,7 +474,7 @@ MODULE_DEVICE_TABLE(of, rk3399dmc_devfreq_of_match);
 
 static struct platform_driver rk3399_dmcfreq_driver = {
 	.probe	= rk3399_dmcfreq_probe,
-	.remove = rk3399_dmcfreq_remove,
+	.remove_new = rk3399_dmcfreq_remove,
 	.driver = {
 		.name	= "rk3399-dmc-freq",
 		.pm	= &rk3399_dmcfreq_pm,
-- 
2.43.0


