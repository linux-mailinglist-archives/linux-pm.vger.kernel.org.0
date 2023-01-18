Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0173F67123B
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 04:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjARDzo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 22:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjARDzi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 22:55:38 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7EB54B22;
        Tue, 17 Jan 2023 19:55:30 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pHzXs-00032R-2C;
        Wed, 18 Jan 2023 04:55:28 +0100
Date:   Wed, 18 Jan 2023 03:55:22 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v4 1/2] thermal: mediatek: use function pointer for
 raw_to_mcelsius
Message-ID: <69c17529e8418da3eec703dde31e1b01e5b0f7e8.1674012985.git.daniel@makrotopia.org>
References: <cover.1674012985.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674012985.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of having if-else logic selecting either raw_to_mcelsius_v1 or
raw_to_mcelsius_v2 in mtk_thermal_bank_temperature introduce a function
pointer raw_to_mcelsius to struct mtk_thermal which is initialized in the
probe function.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/thermal/mtk_thermal.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0084b76493d9a..992750ee09e62 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -292,6 +292,8 @@ struct mtk_thermal {
 
 	const struct mtk_thermal_data *conf;
 	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
+
+	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
 };
 
 /* MT8183 thermal sensor data */
@@ -656,13 +658,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
 		raw = readl(mt->thermal_base + conf->msr[i]);
 
-		if (mt->conf->version == MTK_THERMAL_V1) {
-			temp = raw_to_mcelsius_v1(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		} else {
-			temp = raw_to_mcelsius_v2(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		}
+		temp = mt->raw_to_mcelsius(
+			mt, conf->bank_data[bank->id].sensors[i], raw);
+
 
 		/*
 		 * The first read of a sensor often contains very high bogus
@@ -1075,6 +1073,11 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 
+	if (mt->conf->version == MTK_THERMAL_V1)
+		mt->raw_to_mcelsius = raw_to_mcelsius_v1;
+	else
+		mt->raw_to_mcelsius = raw_to_mcelsius_v2;
+
 	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
 		for (i = 0; i < mt->conf->num_banks; i++)
 			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
-- 
2.39.1

