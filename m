Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D268EB5F
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 10:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBHJaV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 04:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjBHJ3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 04:29:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DA26BF
        for <linux-pm@vger.kernel.org>; Wed,  8 Feb 2023 01:28:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPgjM-0001Fe-La; Wed, 08 Feb 2023 10:27:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPgjK-003U6H-F0; Wed, 08 Feb 2023 10:27:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPgjK-001oNs-U0; Wed, 08 Feb 2023 10:27:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Kevin Hilman <khilman@deeprootsystems.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] cpufreq: davinci: Fix clk use after free
Date:   Wed,  8 Feb 2023 10:26:54 +0100
Message-Id: <20230208092654.551466-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OhtEhe9xB7XLkvnPqNj66+aOQN1cEBGjGLrfZxrmedE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj42rZFo66+5m+S1ki5gtWRhGYgOqY2W1YfGLj6R7K h/7PereJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY+Nq2QAKCRDB/BR4rcrsCWimCA CMUJ53334giFhsf4/wvCKvXoecpy7kvTTGJXK1RF9yj6/zZzqzZvwHd+CpeNSQNAN5KBUo5ilqE5a+ vCP6hv1WslFK2oENktm7zf9rJ3uPq8/kTnPEq0CgnOJVWJCpEdkZATvuj3KXJOsXRTOdUcNvR5mGdV NCCBgERur7kLm4E9l5W95qyKTu3oskHjYkPmfxumFiovkKHUF3tNjKp0EMHyeIErYKg3kXGefTGis0 YU6L4hoUqm2E+X1CyoXlKTkwYMd7m15pKLsVAF8bOxaMxGTSaeD5/r9z/wTse/qvPy0jsIWva46iNF govuPc7L1wSrB6ZxGxVcEZONa6C2ij
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The remove function first frees the clks and only then calls
cpufreq_unregister_driver(). If one of the cpufreq callbacks is called
just before cpufreq_unregister_driver() is run, the freed clks might be
used.

Fixes: 6601b8030de3 ("davinci: add generic CPUFreq driver for DaVinci")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/cpufreq/davinci-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 2d23015e2abd..ebb3a8102681 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -133,13 +133,13 @@ static int __init davinci_cpufreq_probe(struct platform_device *pdev)
 
 static int __exit davinci_cpufreq_remove(struct platform_device *pdev)
 {
+	cpufreq_unregister_driver(&davinci_driver);
+
 	clk_put(cpufreq.armclk);
 
 	if (cpufreq.asyncclk)
 		clk_put(cpufreq.asyncclk);
 
-	cpufreq_unregister_driver(&davinci_driver);
-
 	return 0;
 }
 

base-commit: 05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
prerequisite-patch-id: fcb02b20a32d8a3c6f628d8c10bd42173c2df0b7
-- 
2.39.0

