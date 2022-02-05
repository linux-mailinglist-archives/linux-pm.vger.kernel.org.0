Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E635D4AAAF6
	for <lists+linux-pm@lfdr.de>; Sat,  5 Feb 2022 19:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiBESfb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Feb 2022 13:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiBESfb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Feb 2022 13:35:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED0BC061348
        for <linux-pm@vger.kernel.org>; Sat,  5 Feb 2022 10:35:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGPuC-0006Bh-AM; Sat, 05 Feb 2022 19:35:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGPuC-00EjqM-0a; Sat, 05 Feb 2022 19:35:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nGPuA-008MZ8-2e; Sat, 05 Feb 2022 19:35:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: rt9455: Don't pass an error code in remove callback
Date:   Sat,  5 Feb 2022 19:35:12 +0100
Message-Id: <20220205183512.11038-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; h=from:subject; bh=ImaO7aZj/l0NInJlnvO0hoXfA/qvB2vfu6KuyxD/dWQ=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMST+OxxT/TrjwsZjGX8r3Z+bfpL6fjbpz9mdzMwy/Zc2+3Fw cLx61slozMLAyMUgK6bIUlekJTZBYs1/u5Il3DCDWJlApjBwcQrARAp62P9pcqpvZ9cO5SpaoLb0i7 jJ+vu9uj8uFi/nfz3vnYAzo3H91xVef3LUSn4yiDDevXnV6sTpP8vL06r6Fyns7t/1aMIFfwsBNXn1 moh7KVFZbp1fvHljt+S1H717RcjUfs5Ly6RJm1+xsMsECt1+/fGo364u3hdPWJvmBSSukd0mHZkZmM a86DhHonOUuKvKOXlLg1KNmjKnbSwqDUsspvPMajxm0Nkaxpcq2MGf68K+c3n1C6WDN1QaxJeJX34z TcPV0C0+0tw3+9nMQOkp5tx6rHLPnlwNn7fubfIEnawHKzPT2Xks1/grszHcVMrS4HqVz8DYm7X0ul bZ7TDJ709yOViOxjDnrXv787wLAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When ret is not zero there were already one or two error messages emitted
about a problem (because rt9455_register_reset() emits a message in most
cases then). Passing on that error code to the i2c core only results in
another error message. Suppress that by returning zero unconditionally.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/supply/rt9455_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 594bb3b8a4d1..74ee54320e6a 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1716,7 +1716,7 @@ static int rt9455_remove(struct i2c_client *client)
 	cancel_delayed_work_sync(&info->max_charging_time_work);
 	cancel_delayed_work_sync(&info->batt_presence_work);
 
-	return ret;
+	return 0;
 }
 
 static const struct i2c_device_id rt9455_i2c_id_table[] = {

base-commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60
-- 
2.34.1

