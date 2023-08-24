Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE8787534
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbjHXQYH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbjHXQXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 12:23:52 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F86D1736;
        Thu, 24 Aug 2023 09:23:50 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; 
   d="scan'208";a="177560536"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2023 01:23:49 +0900
Received: from localhost.localdomain (unknown [10.226.93.115])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1F3AC40116B6;
        Fri, 25 Aug 2023 01:23:46 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] power: supply: sbs-battery: Make similar OF and ID table
Date:   Thu, 24 Aug 2023 17:23:44 +0100
Message-Id: <20230824162344.385151-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make similar OF and ID table to extend support for ID match
using i2c_match_data(). Currently it works only for OF match
tables as the field is wrong for ID match.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped patch#2 as  Zero is a expected match value for this driver
   and the driver does not check for a NULL return value from
   *_get_match_data() anyway.
---
 drivers/power/supply/sbs-battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index cdfc8466d129..520bbde20451 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1135,7 +1135,7 @@ static int sbs_probe(struct i2c_client *client)
 	if (!chip)
 		return -ENOMEM;
 
-	chip->flags = (u32)(uintptr_t)device_get_match_data(&client->dev);
+	chip->flags = (u32)(uintptr_t)i2c_get_match_data(client);
 	chip->client = client;
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
@@ -1253,9 +1253,9 @@ static SIMPLE_DEV_PM_OPS(sbs_pm_ops, sbs_suspend, NULL);
 #endif
 
 static const struct i2c_device_id sbs_id[] = {
-	{ "bq20z65", 0 },
-	{ "bq20z75", 0 },
-	{ "sbs-battery", 1 },
+	{ "bq20z65", SBS_FLAGS_TI_BQ20ZX5 },
+	{ "bq20z75", SBS_FLAGS_TI_BQ20ZX5 },
+	{ "sbs-battery", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, sbs_id);
-- 
2.25.1

