Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8373274A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 08:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjFPGWP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 02:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFPGWM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 02:22:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D1270E
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 23:22:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q7-0006nY-VX; Fri, 16 Jun 2023 08:21:44 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q5-007kxF-8Y; Fri, 16 Jun 2023 08:21:41 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q4-003FTy-8e; Fri, 16 Jun 2023 08:21:40 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 01/26] PM / devfreq: rockchip-dfi: Make pmu regmap mandatory
Date:   Fri, 16 Jun 2023 08:20:36 +0200
Message-Id: <20230616062101.601837-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616062101.601837-1-s.hauer@pengutronix.de>
References: <20230616062101.601837-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As a matter of fact the regmap_pmu already is mandatory because
it is used unconditionally in the driver. Bail out gracefully in
probe() rather than crashing later.

Fixes: b9d1262bca0af ("PM / devfreq: event: support rockchip dfi controller")
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20230524083153.2046084-2-s.hauer@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Notes:
    Changes since v4:
    - move to beginning of the series to make it easier to backport to stable
    - Add a Fixes: tag
    - add missing of_node_put()

 drivers/devfreq/event/rockchip-dfi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 39ac069cabc75..74893c06aa087 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -193,14 +193,15 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->clk),
 				     "Cannot get the clk pclk_ddr_mon\n");
 
-	/* try to find the optional reference to the pmu syscon */
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-	if (node) {
-		data->regmap_pmu = syscon_node_to_regmap(node);
-		of_node_put(node);
-		if (IS_ERR(data->regmap_pmu))
-			return PTR_ERR(data->regmap_pmu);
-	}
+	if (!node)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf registers\n");
+
+	data->regmap_pmu = syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(data->regmap_pmu))
+		return PTR_ERR(data->regmap_pmu);
+
 	data->dev = dev;
 
 	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
-- 
2.39.2

