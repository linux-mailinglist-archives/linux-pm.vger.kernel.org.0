Return-Path: <linux-pm+bounces-4781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07374876031
	for <lists+linux-pm@lfdr.de>; Fri,  8 Mar 2024 09:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAFDB227FB
	for <lists+linux-pm@lfdr.de>; Fri,  8 Mar 2024 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A7524AD;
	Fri,  8 Mar 2024 08:51:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0C210E7
	for <linux-pm@vger.kernel.org>; Fri,  8 Mar 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887914; cv=none; b=XPKCwQ3A6O729UISDsEBrVDNMzE+h5inkZH43RQIkjdEyR2068jvaU9KHRfdHW2lmPpa0zUMNMdqB+L2q48tDGoEuBXHc03kbq09mSA3Fkqutksc/XrCOvemOV4biXjyQ2g2uyxx+EOy/5aPbtqceWwe2FnUYFdbDnF+e8oQo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887914; c=relaxed/simple;
	bh=fAr/1KB3617mo1ngm0neer59sygqeqbk+SM1BcwFDt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GaLLG6LbgrsFVnd+9d6qcfJm7FTcb08p916OOsPQphrihepPZcdA8ccM4610QpTYeU369y29m3B14/ZgNXQJlbJRk/ToYm4OYi/XDGtV8I8jOzWZZax75g65efwV1cHWbiAl8eQ7S5cPyaobkmR7zJ8VwbqzeHHokjYmuqqojRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-0006wd-I5; Fri, 08 Mar 2024 09:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-0056NW-5X; Fri, 08 Mar 2024 09:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-00245x-0J;
	Fri, 08 Mar 2024 09:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] powercap: intel_rapl: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:14 +0100
Message-ID:  <98afe4627bcfbddedfa36fb5631bb47913f5fa94.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fAr/1KB3617mo1ngm0neer59sygqeqbk+SM1BcwFDt8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tGGddnQAkd6yGxnMFJMK1HXc4ZtkavKeLQba L64w3fBhjiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRhgAKCRCPgPtYfRL+ TnWkB/4hvEPTer+lkRC3Z0NhryaXnJ76mrqDXdoGfYyChUkQ+U+r5eBq+SRTdpHxIa3H4k9R52L p+QL0ut0Fo2f7zYs81/abOVcAGnV/iPlASece0bZAsu55MsabvjQJRY5T5JOkYmF6ytmhXTBJ3e fhWVLYFCG7NSLeYUthWffWGEZchsW/o+T+FDzo21L4QEMf8h1RCDPUF8t1lT7cChyJA2ZAyaAsg Zr++KNXesWwhTIUYkjjfp2W3IVDB/4bwgYDbPbqE4FkwuOI+VsGIDQpUo2EIs5jYk8rzE4Rx4h7 VOKMMGaw0hqlIL+IXAQgfoLf6mJsrQ2P11t0qr4k7pCgoEr0
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
 drivers/powercap/intel_rapl_msr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index b4b6930cacb0..35cb152fa9aa 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -197,11 +197,10 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rapl_msr_remove(struct platform_device *pdev)
+static void rapl_msr_remove(struct platform_device *pdev)
 {
 	cpuhp_remove_state(rapl_msr_priv->pcap_rapl_online);
 	powercap_unregister_control_type(rapl_msr_priv->control_type);
-	return 0;
 }
 
 static const struct platform_device_id rapl_msr_ids[] = {
@@ -212,7 +211,7 @@ MODULE_DEVICE_TABLE(platform, rapl_msr_ids);
 
 static struct platform_driver intel_rapl_msr_driver = {
 	.probe = rapl_msr_probe,
-	.remove = rapl_msr_remove,
+	.remove_new = rapl_msr_remove,
 	.id_table = rapl_msr_ids,
 	.driver = {
 		.name = "intel_rapl_msr",

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


