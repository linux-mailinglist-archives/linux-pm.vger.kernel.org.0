Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175C1552BD7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 09:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiFUHY3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 03:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiFUHY1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 03:24:27 -0400
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34EDD1A04B
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p60IA
        iOxTrC/ZvrfzwMGOXV7KuEYwkAQFguOrRfw5Jg=; b=Rrt6f1w7R2H1k9jwiV31B
        kg+QN1WG5Ljclg5XP/B8zjYPclcPTI9sc66n97NuZSEV4dVhmXnKP97Wz9fe1c95
        fx7uzkkGBng2NxgnIYU0gx6SC95xDSMp3Ea6Um41bEs/W8BJzdMBrO6M31oW00xX
        f/Do0TEsY/E9c08xtfpDgw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp1 (Coremail) with SMTP id C8mowADntDUZcrFi8ooyFA--.19587S2;
        Tue, 21 Jun 2022 15:24:10 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org, windhl@126.com
Subject: [PATCH] power/supply/olpc_battery: Hold the reference returned by of_find_compatible_node
Date:   Tue, 21 Jun 2022 15:24:08 +0800
Message-Id: <20220621072408.4080461-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8mowADntDUZcrFi8ooyFA--.19587S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1UAry5AF45uF1fCw47XFb_yoWkuFb_u3
        4xWr93Cr48uFW0kFnrAr4xZFy8KFnrZFy8ZF12qr9IqF15uw4UArWDXr93J34UW397CFWD
        JayDtrW3AFZ7tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRA5r43UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgonF1-HZWIOFgAAsn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In olpc_battery_probe(), we should hold the reference returned by
of_find_compatible_node() and use it to call of_node_put() for
refcount balance.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/power/supply/olpc_battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index e0476ec06601..9f122a02b70c 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -635,6 +635,7 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	struct power_supply_config bat_psy_cfg = {};
 	struct power_supply_config ac_psy_cfg = {};
 	struct olpc_battery_data *data;
+	struct device_node *np;
 	uint8_t status;
 	uint8_t ecver;
 	int ret;
@@ -649,7 +650,9 @@ static int olpc_battery_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
+	np = of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")
+	if (np) {
+		of_node_put(np);
 		/* XO 1.75 */
 		data->new_proto = true;
 		data->little_endian = true;
-- 
2.25.1

