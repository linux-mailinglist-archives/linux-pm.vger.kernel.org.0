Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A57B2C36
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 08:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjI2GNR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GNQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 02:13:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC4298
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 23:13:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm6kR-0006t6-Jz; Fri, 29 Sep 2023 08:13:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm6kQ-009kcb-DQ; Fri, 29 Sep 2023 08:13:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qm6kQ-005q0n-30; Fri, 29 Sep 2023 08:13:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     kernel@pengutronix.de, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] thermal: amlogic: Fix build failure after conversion to .remove_new()
Date:   Fri, 29 Sep 2023 08:13:05 +0200
Message-Id: <20230929061305.2351953-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=13Z1to5MG3FIfiSVPPchPg9gsuDRWRE9cMd7HsLPULM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFmrwVgajUhEsC20E8NOZ4T/fEWNbhyqEvmByM c3ujLPIxseJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRZq8AAKCRCPgPtYfRL+ To8wB/9Htf20WNbgD4mF3exvAEiOkhGYvEjGNMT2/kzqJ6ICxintj2SIJtavL1m2DMAp9d5WtL0 i2Lm6DSwcnI1YQhSWysYDvxSVNNJx61kPQ5dQKSwE6uMOn3+d8Z6XaDOgqXhaxPuSUWglNuOIha 5zAXRLvU562DVevp8iLlqn94udoPQOQGXiIf2t4QVdlXYDGgXvZbJBMwusKLBBH+SKM/yaUmpXJ uxvDVlGWNNzpjQS9lo2mslUkKRwSJ+P4Db/WRMgfmE6oVGrbS76dr1TMVHbS1A/9KxTiqrUR2QR RXRpYo9LBvGAliW23ei2+tx/+kTL7QbRN64PR7vrrZbMrvJA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 88af8b66ffed ("thermal: amlogic: Convert to platform remove
callback returning void") converted amlogic_thermal_disable() to return
no value but missed that amlogic_thermal_suspend() makes use of the int
returned by this function. As amlogic_thermal_disable() returned zero
unconditionally before, add a return 0 to get the same behaviour as
before the offending commit.

Fixes: 88af8b66ffed ("thermal: amlogic: Convert to platform remove callback returning void")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309291214.Hjn3gJ94-lkp@intel.com/
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

sorry for not catching that before sending. I don't understand yet what
was wrong with my testing; I would have bet the series was tested with
an ARCH=arm64 allmodconfig build. :-\

If you prefer it, feel free to squash this patch into the offending
commit.

Best regards, sorry and thanks,
Uwe

 drivers/thermal/amlogic_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 1426f1eb4ac6..562f63b7bf27 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -300,7 +300,9 @@ static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
 {
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
 
-	return amlogic_thermal_disable(data);
+	amlogic_thermal_disable(data);
+
+	return 0;
 }
 
 static int __maybe_unused amlogic_thermal_resume(struct device *dev)
-- 
2.40.1

