Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17A055216B
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiFTPoB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 11:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244224AbiFTPn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 11:43:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD061AD8F
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 08:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51AF3B811C7
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 15:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E5C3411B;
        Mon, 20 Jun 2022 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655739833;
        bh=FRsip9+0icriLz8iFAwx+5Xu+yMJNijStZ3Xui+swUg=;
        h=From:To:Cc:Subject:Date:From;
        b=J8hdYrXJXaMAraP3Ke+ZPz7Yp9lfihvSY/PBGrZ+OXhYbtEh4akhFUDwsWfl87Q/E
         YkqvIdHxOJ6c6QMRfXO72S2+NkqravikbY6w+e6mIxjMG1EZ8DqsRV2iwEkp+VxH8q
         glqSKOpYPkc+XNn5zOsE5Q1+V/nWJuuj0E1c3Naj683ChPAx8opvjIst+9RVIy+mr0
         4mjqxgKrLhyK1diBXFIDqTsKdBiQQJWBp2MzN6T+8Zvm+RMKsO7chxHMdH3eJDoAf3
         aTphELwe62mK6fPRsH01MWKf/f/+bz4HWgauJmc9s9JwB1/YlQ6FhHGc3P5N0cHP1X
         HGP+b2iZakZVA==
From:   matthias.bgg@kernel.org
To:     dan.carpenter@oracle.com, johnson.wang@mediatek.com
Cc:     linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] PM / devfreq: mediatek: Fix unnecessary check of drvdata
Date:   Mon, 20 Jun 2022 17:43:47 +0200
Message-Id: <20220620154347.14756-1-matthias.bgg@kernel.org>
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

Probe function will error out if drvdata 'mtk_ccifreq_drv' is null.
So when mtk_ccifreq_target get's called, the drv pointer will never be
NULL. This fixes a static checker warning.

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/devfreq/mtk-cci-devfreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 71abb3fbd042..ad05b152071d 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -132,9 +132,6 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 	unsigned long opp_rate;
 	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
 
-	if (!drv)
-		return -EINVAL;
-
 	if (drv->pre_freq == *freq)
 		return 0;
 
-- 
2.36.0

