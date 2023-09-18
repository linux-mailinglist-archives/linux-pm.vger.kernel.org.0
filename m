Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376687A4E84
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjIRQSu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIRQSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 12:18:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28806274AA
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER5-00021q-DE; Mon, 18 Sep 2023 15:37:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-007EZJ-UG; Mon, 18 Sep 2023 15:37:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiER4-002fXC-LC; Mon, 18 Sep 2023 15:37:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 21/32] power: supply: pcf50633-charger: Convert to platform remove callback returning void
Date:   Mon, 18 Sep 2023 15:36:49 +0200
Message-Id: <20230918133700.1254499-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1938; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YYvLO9P69QKCjKr7Gs/6YSWBHBfCqXLTkFvH9WwQtIw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSOoAwh67Loh20nJ78VvH3nRrP4BI9N4W++qBmvZvFYE fkk4ntUJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATMeTkYNjioipzx69dd/YW 2fueAXLTJydLF3w7rSZaucF/1V6n64dlsuJzWgp5J8yvECjRSMqXCdsvyz37Xlpnd3bEucv5qkw 7dH8dDf5Rc73czTNtirBl1obCtYuKiuf84pbPd4pqfHV03QP/pqsR5ssu2aavMqrkZxfS8bye0l 7zdPPOSwc3LLXxusF27O9B47SuutUStuJirmceautO32Czs0w1RWOLPfv6qx6fVvmKqfzp1dI8f t7FdOIaiaXyr098PcC7skTdpl+EU8Ao5B6X33L10EOi23nWh3TEGc/7Kq5grevheyn/hu3PaUWv Iqtez7EPP+YeKr1rVYb2760/s3xkjHTmn9JvmbnZuuYeAA==
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
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/supply/pcf50633-charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index fd44cb8ac0e2..950e30917c63 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -441,7 +441,7 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pcf50633_mbc_remove(struct platform_device *pdev)
+static void pcf50633_mbc_remove(struct platform_device *pdev)
 {
 	struct pcf50633_mbc *mbc = platform_get_drvdata(pdev);
 	int i;
@@ -453,8 +453,6 @@ static int pcf50633_mbc_remove(struct platform_device *pdev)
 	power_supply_unregister(mbc->usb);
 	power_supply_unregister(mbc->adapter);
 	power_supply_unregister(mbc->ac);
-
-	return 0;
 }
 
 static struct platform_driver pcf50633_mbc_driver = {
@@ -462,7 +460,7 @@ static struct platform_driver pcf50633_mbc_driver = {
 		.name = "pcf50633-mbc",
 	},
 	.probe = pcf50633_mbc_probe,
-	.remove = pcf50633_mbc_remove,
+	.remove_new = pcf50633_mbc_remove,
 };
 
 module_platform_driver(pcf50633_mbc_driver);
-- 
2.40.1

