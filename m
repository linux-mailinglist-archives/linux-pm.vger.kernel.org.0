Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83357B0CBC
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjI0TiD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjI0TiA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:38:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D596111D
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-0002Dh-I1; Wed, 27 Sep 2023 21:37:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-009PZn-L2; Wed, 27 Sep 2023 21:37:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLv-005Rg2-Ax; Wed, 27 Sep 2023 21:37:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/31] thermal: int3401: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:16 +0200
Message-Id: <20230927193736.2236447-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UeGDT0K7i3XheaJm4DPj9aGXN9/Y6aWaPEkQl4E5+Ls=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFIRlLtgRHsULkOjfm7hyz+66FcsCRJTZr0TTA mKsnrQe5fKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRSEZQAKCRCPgPtYfRL+ TvjAB/9X+ytYe+0Bu9f5vo/Tzd+s+nLpGck/vN6SiFoN/QOvxjnLNr8ZXZ1/lC7I4BgyNRRcapL NHkCiEOk8ZnG4/ZGSc3CMbnINNq61R7t2QEIXDzA95BDn2jQ7KuZ+bxVmqhEJd/1H2cH8przbyP UefFdNRNO9UjR5hHRWnK3KZjNLq3B1Hgxw9H8DfHD259C/e9xRP7fTmJcTixHCu8XB8cH5kMn3J XHUvok9wxWLvgSzGSya/8WaAb32uTVN0XFPL9cuFp1hxHkxPHfwwaH8ZMoEHxf8UshgDUtKymP6 yBbnlairffc1VMg90sVg7saZZ8zZlf0IUc5j4IP1S5KwS6Mh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
 drivers/thermal/intel/int340x_thermal/int3401_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
index c93a28eec4db..193645a73861 100644
--- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
@@ -36,11 +36,9 @@ static int int3401_add(struct platform_device *pdev)
 	return ret;
 }
 
-static int int3401_remove(struct platform_device *pdev)
+static void int3401_remove(struct platform_device *pdev)
 {
 	proc_thermal_remove(platform_get_drvdata(pdev));
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -62,7 +60,7 @@ static SIMPLE_DEV_PM_OPS(int3401_proc_thermal_pm, int3401_thermal_suspend,
 
 static struct platform_driver int3401_driver = {
 	.probe = int3401_add,
-	.remove = int3401_remove,
+	.remove_new = int3401_remove,
 	.driver = {
 		.name = "int3401 thermal",
 		.acpi_match_table = int3401_device_ids,
-- 
2.40.1

