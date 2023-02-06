Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219BA68BCB9
	for <lists+linux-pm@lfdr.de>; Mon,  6 Feb 2023 13:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBFMUo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Feb 2023 07:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBFMUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2023 07:20:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B222DEC
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 04:20:40 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P9QMC1z2nzfZ49;
        Mon,  6 Feb 2023 20:20:23 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 20:20:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <sre@kernel.org>, <alina_yu@richtek.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2] power: supply: rt9471: fix using wrong ce_gpio in rt9471_probe()
Date:   Mon, 6 Feb 2023 20:20:18 +0800
Message-ID: <20230206122018.3601419-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Pass the correct 'ce_gpio' to IS_ERR(), and remove the ce_gpio in
chip data, make it all by SW control only, not to control by HW pin.

Fixes: 4a1a5f6781d8 ("power: supply: rt9471: Add Richtek RT9471 charger driver")
Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Remove the ce_gpio in chip data.
---
 drivers/power/supply/rt9471.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/rt9471.c b/drivers/power/supply/rt9471.c
index 5d3cf375ad5c..1ea40876494b 100644
--- a/drivers/power/supply/rt9471.c
+++ b/drivers/power/supply/rt9471.c
@@ -141,7 +141,6 @@ enum {
 
 struct rt9471_chip {
 	struct device *dev;
-	struct gpio_desc *ce_gpio;
 	struct regmap *regmap;
 	struct regmap_field *rm_fields[F_MAX_FIELDS];
 	struct regmap_irq_chip_data *irq_chip_data;
@@ -851,7 +850,7 @@ static int rt9471_probe(struct i2c_client *i2c)
 
 	/* Default pull charge enable gpio to make 'CHG_EN' by SW control only */
 	ce_gpio = devm_gpiod_get_optional(dev, "charge-enable", GPIOD_OUT_HIGH);
-	if (IS_ERR(chip->ce_gpio))
+	if (IS_ERR(ce_gpio))
 		return dev_err_probe(dev, PTR_ERR(ce_gpio),
 				     "Failed to config charge enable gpio\n");
 
-- 
2.25.1

