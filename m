Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D5C786EDB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjHXMQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjHXMQE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 08:16:04 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D699170F;
        Thu, 24 Aug 2023 05:16:02 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 0E4388CC509; Thu, 24 Aug 2023 13:27:56 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Alexandre Courbot <acourbot@nvidia.com>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: bq24190: Support bq24193
Date:   Thu, 24 Aug 2023 13:27:34 +0200
Message-ID: <20230824112741.201353-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824112741.201353-1-linkmauve@linkmauve.fr>
References: <20230824112741.201353-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Alexandre Courbot <acourbot@nvidia.com>

This charger is working with the driver as-is, so enable it to be probed.

It is used in the Nintendo Switch for instance.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
 drivers/power/supply/bq24190_charger.c                      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index d3ebc9de8c0b..92a28d3c3070 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - ti,bq24190
       - ti,bq24192
+      - ti,bq24193
       - ti,bq24192i
       - ti,bq24196
 
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index ef8235848f56..a56122b39687 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -2018,6 +2018,7 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
 	{ "bq24192" },
+	{ "bq24193" },
 	{ "bq24192i" },
 	{ "bq24196" },
 	{ },
@@ -2027,6 +2028,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
 	{ .compatible = "ti,bq24192", },
+	{ .compatible = "ti,bq24193", },
 	{ .compatible = "ti,bq24192i", },
 	{ .compatible = "ti,bq24196", },
 	{ },
-- 
2.42.0

