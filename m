Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0E781EF8
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 19:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjHTRQT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjHTRQM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 13:16:12 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ECB5198C;
        Sun, 20 Aug 2023 10:11:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,188,1684767600"; 
   d="scan'208";a="177097985"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2023 02:11:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.18])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1832A40062AF;
        Mon, 21 Aug 2023 02:11:50 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2 RESEND] power: supply: sbs-battery: Make similar OF and ID table
Date:   Sun, 20 Aug 2023 18:11:44 +0100
Message-Id: <20230820171145.82662-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make similar OF and ID table to extend support for ID match
using i2c_match_data()/device_get_match_data() later. Currently
it works only for OF match tables as the driver_data is wrong for
ID match.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/power/supply/sbs-battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index cdfc8466d129..50b11b6df1b3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
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

