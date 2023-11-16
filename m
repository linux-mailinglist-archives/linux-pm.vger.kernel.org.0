Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC377EDFD0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 12:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjKPL1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Nov 2023 06:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjKPL1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2023 06:27:00 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BD7E0
        for <linux-pm@vger.kernel.org>; Thu, 16 Nov 2023 03:26:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWH-00084C-AH; Thu, 16 Nov 2023 12:26:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWG-009RE6-J8; Thu, 16 Nov 2023 12:26:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3aWG-002aLv-A1; Thu, 16 Nov 2023 12:26:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 1/2] thermal: amlogic: Make amlogic_thermal_disable() return void
Date:   Thu, 16 Nov 2023 12:26:35 +0100
Message-ID: <20231116112633.668826-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
References: <20231116112633.668826-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zS5bf2K9StbVA3TOdCPCK/qoOEqpcla6Ty+ZtVPLmWY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVfxrNgTH4AYOVvU000xsT7JO+KmseS6hL84j2 ICo8g/biOuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVX8awAKCRCPgPtYfRL+ Tiz6CACMTqm95KR5Ydn8/rVs3MdqY9osaf9rLaFoZH2F6mps4WDjCz77OFWsNxgSoFX7FuGIwI0 EnOnZGuqaowfkkQDv/gn7gW95l3pcGHSKbEvsne/0W5b/YjpAhwE77VTpFGbxLVF08ek5oE3NMd 5h7i6SEirOL2W9zlsKZiXdml/Zx5MnKt58bwaKTiCrM1CQ3ie+xx+t8NMbbXBTE2trpKX8pKNJ5 EYLkIygs3hZ+oqtyllVkStwGrrew/SFUe2krmKJHnvF1ue32OdR1G/HbEUB9yslono3Igh9vxjX JtSmETfzRiZ3vmTIGYTmX+7easlWI1zIP+LFhamEHe7GqyI2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

amlogic_thermal_disable() returned zero unconditionally and
amlogic_thermal_remove() already ignores the return value.

Make it return no value and modify amlogic_thermal_suspend to not check
the value.

This patch introduces no semantic changes, but makes it more obvious for
a human reader that amlogic_thermal_suspend() cannot fail.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/amlogic_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 5877cde25b79..562f63b7bf27 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -167,13 +167,11 @@ static int amlogic_thermal_enable(struct amlogic_thermal *data)
 	return 0;
 }
 
-static int amlogic_thermal_disable(struct amlogic_thermal *data)
+static void amlogic_thermal_disable(struct amlogic_thermal *data)
 {
 	regmap_update_bits(data->regmap, TSENSOR_CFG_REG1,
 			   TSENSOR_CFG_REG1_ENABLE, 0);
 	clk_disable_unprepare(data->clk);
-
-	return 0;
 }
 
 static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
@@ -302,7 +300,9 @@ static int __maybe_unused amlogic_thermal_suspend(struct device *dev)
 {
 	struct amlogic_thermal *data = dev_get_drvdata(dev);
 
-	return amlogic_thermal_disable(data);
+	amlogic_thermal_disable(data);
+
+	return 0;
 }
 
 static int __maybe_unused amlogic_thermal_resume(struct device *dev)
-- 
2.42.0

