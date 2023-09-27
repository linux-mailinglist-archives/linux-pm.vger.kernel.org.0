Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD87B0CB6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjI0TiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjI0Th7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:37:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350EB10A
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 12:37:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-0002F8-M5; Wed, 27 Sep 2023 21:37:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-009PZr-9L; Wed, 27 Sep 2023 21:37:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlaLw-005Rg7-0D; Wed, 27 Sep 2023 21:37:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/31] thermal: int3402: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 21:37:17 +0200
Message-Id: <20230927193736.2236447-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2055; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qoMLAjTRS9n8eyX+9x9h12/oeNtnXaQblOJdaPK8n74=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSRlnSNI3Vu7H6Hb6nHzJxhd8Va/+rHf3evGLAU2r+Tf ph1KMmhk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJMDGy/3fsWDUjqCPmUsHm nzp61nY+W1xjeJbP0zdJTwntOKFkHu7hW3FUpYmrV8Cup1U6IEbz8+ywrl6LCQdTlW6GiS/609I j1Me8Omla2xz/lDCO+ma3k6bfWRVy2VcbMlvk//xnPCnQ5cXNzZ+3+OqrPGYUcpFpXT9lzrLq68 eWrNxQlvx0jp9z9PS5vi0b+Cws/MMP/jgsyrRII8hB4+0nl63To/IXrb3efOHJvP6n5cm9099x/ XipcmyOehrb7xsyXyLn+4pW1Iny6pTt8a3itO9MDd+fcffA7JnzopU0ZHYsk07KncHap/aoS4yj cNEjAQOnlHO7+e+36ldo7lLLcpq05vqqbPcG/4q0+lUA
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
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 43fa351e2b9e..ab8bfb5a3946 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -71,15 +71,13 @@ static int int3402_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int int3402_thermal_remove(struct platform_device *pdev)
+static void int3402_thermal_remove(struct platform_device *pdev)
 {
 	struct int3402_thermal_data *d = platform_get_drvdata(pdev);
 
 	acpi_remove_notify_handler(d->handle,
 				   ACPI_DEVICE_NOTIFY, int3402_notify);
 	int340x_thermal_zone_remove(d->int340x_zone);
-
-	return 0;
 }
 
 static const struct acpi_device_id int3402_thermal_match[] = {
@@ -91,7 +89,7 @@ MODULE_DEVICE_TABLE(acpi, int3402_thermal_match);
 
 static struct platform_driver int3402_thermal_driver = {
 	.probe = int3402_thermal_probe,
-	.remove = int3402_thermal_remove,
+	.remove_new = int3402_thermal_remove,
 	.driver = {
 		   .name = "int3402 thermal",
 		   .acpi_match_table = int3402_thermal_match,
-- 
2.40.1

