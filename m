Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE053CDB4
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jun 2022 19:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiFCREO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jun 2022 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiFCREO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2022 13:04:14 -0400
X-Greylist: delayed 3902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 10:04:12 PDT
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net [89.40.174.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F651E4D;
        Fri,  3 Jun 2022 10:04:12 -0700 (PDT)
Received: from [77.244.183.192] (port=64530 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.95)
        (envelope-from <luca@lucaceresoli.net>)
        id 1nx9iK-0009cb-P8;
        Fri, 03 Jun 2022 17:59:52 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 5/6] power: supply: max77976: update Luca Ceresoli's e-mail address
Date:   Fri,  3 Jun 2022 17:57:26 +0200
Message-Id: <20220603155727.1232061-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603155727.1232061-1-luca@lucaceresoli.net>
References: <20220603155727.1232061-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

My Bootlin address is preferred from now on.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/power/supply/max77976_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index 8b6c8cfa7503..4fed74511931 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -3,7 +3,7 @@
  * max77976_charger.c - Driver for the Maxim MAX77976 battery charger
  *
  * Copyright (C) 2021 Luca Ceresoli
- * Author: Luca Ceresoli <luca@lucaceresoli.net>
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
  */
 
 #include <linux/i2c.h>
@@ -504,6 +504,6 @@ static struct i2c_driver max77976_driver = {
 };
 module_i2c_driver(max77976_driver);
 
-MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
+MODULE_AUTHOR("Luca Ceresoli <luca.ceresoli@bootlin.com>");
 MODULE_DESCRIPTION("Maxim MAX77976 charger driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

