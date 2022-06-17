Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B693154F85C
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiFQNd6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381974AbiFQNd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 09:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2232AB483
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 06:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2B8062002
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2022 13:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DC7C3411B;
        Fri, 17 Jun 2022 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655472836;
        bh=TUnzWPiJVms4vJ/5uPUiec9lpdYuPGzgrucHaS8uTLA=;
        h=From:To:Cc:Subject:Date:From;
        b=ACCw52riL+V8t6gppRrS6724V4KU95suPQTTscVBTTpBelg4q1pDbZ/JbHDR0eF4V
         WWaUQeSKLPcFtVUO2r3Ys2mz/MC/ERvSqkLf62qJSKrGuVlCpUDGBSK/MqKDLwXqGj
         T6jC25z5zQImtR/tmBdu97X0+9b0fCwMMgJ5/STSfRljZKnAPiaTat7Dfd/rfxWcLH
         7QYsQSE6EMJ7Ar9K3b4t4dS6rRjjZzb5zH+YxQubtHWmWl2Dfip1tGfWsqwVihcPSB
         s6LftU8eTrpHkIyxyrlfjrKMjlwoonG+6QpW0I51JI6H1eXfNYHPAS5JKFEcYCYc11
         YKIhq+WKJUieA==
From:   matthias.bgg@kernel.org
To:     dan.carpenter@oracle.com, johnson.wang@mediatek.com
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] PM / devfreq: mediatek: Fix possible dereference of null pointer
Date:   Fri, 17 Jun 2022 15:33:31 +0200
Message-Id: <20220617133330.6510-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

We dereference the driver data before checking of it's valid.
This patch fixes this, by accessing the PLL data struct after cheching
the pointer

Fixes: 07dc787be231 ("Add linux-next specific files for 20220617")
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 71abb3fbd042..77522f16c878 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -127,7 +127,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 			      u32 flags)
 {
 	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
-	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
+	struct clk *cci_pll;
 	struct dev_pm_opp *opp;
 	unsigned long opp_rate;
 	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
@@ -138,6 +138,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 	if (drv->pre_freq == *freq)
 		return 0;
 
+	cci_pll = clk_get_parent(drv->cci_clk);
 	inter_voltage = drv->inter_voltage;
 
 	opp_rate = *freq;
-- 
2.36.0

