Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8A64A9E3
	for <lists+linux-pm@lfdr.de>; Mon, 12 Dec 2022 23:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiLLWCr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Dec 2022 17:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiLLWCo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2022 17:02:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2BE2ED
        for <linux-pm@vger.kernel.org>; Mon, 12 Dec 2022 14:02:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qsX-0001hb-7b; Mon, 12 Dec 2022 23:02:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qsU-0046gN-Bm; Mon, 12 Dec 2022 23:02:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qsU-004bNd-B3; Mon, 12 Dec 2022 23:02:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] thermal: imx_sc_thermal: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 23:02:17 +0100
Message-Id: <20221212220217.3777176-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=B+W99yawunGBul1VpXtz23cSOrdcTrugEON1rL8oNEM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl6TmPgJGnaz5jcTZ3lfVOPRAZS8yH6adoDziyQTz YOpKUNqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5ek5gAKCRDB/BR4rcrsCZW1B/ 0WhJjQuxmfWcgWJCPchMw7CPUllDFPaWMt3kNFcCCur+103ruZwmjT1Ib81r+vUmo7rU9xuH7Okr5E aIVIHL72qePwEhEU8A4PMHeUuYeiMSxXkY66aQ7TBXOeaN3UizYe5YzoADHNyDbJ00Kk3c8mGTIkTh tHuz308NQIluMNcfjcGlu9c4sVfOg7ewQXC1DWs8I37snQMBlPCjwjJ9n8WyciAOGNAlvyU1J1wWWA e1Klu/ySTPg4qPWEy/FH+mHaRk8xmLg9UZ9PnSpVL3uLCWE8LhiJoSmkDuzDGOjsUe+lo0U7T4ypYe 4SgCLV4UpkD5hMCvDMQ2I0Xa6sijX0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/imx_sc_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 5d92b70a5d53..4df925e3a80b 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -127,11 +127,6 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx_sc_thermal_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
 
 static const struct of_device_id imx_sc_thermal_table[] = {
@@ -142,7 +137,6 @@ MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
 
 static struct platform_driver imx_sc_thermal_driver = {
 		.probe = imx_sc_thermal_probe,
-		.remove	= imx_sc_thermal_remove,
 		.driver = {
 			.name = "imx-sc-thermal",
 			.of_match_table = imx_sc_thermal_table,

base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.38.1

