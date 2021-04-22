Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C64367F68
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 13:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhDVLRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 07:17:32 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51652 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235937AbhDVLRb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 07:17:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UWOpOPG_1619090214;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UWOpOPG_1619090214)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Apr 2021 19:16:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ssantosh@kernel.org
Cc:     nm@ti.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] soc: ti: smartreflex after the relocation to maintain consistency
Date:   Thu, 22 Apr 2021 19:16:52 +0800
Message-Id: <1619090212-103038-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v2: According to Nishanth Menon's suggestion, the subject has been 
corrected.
https://lore.kernel.org/patchwork/patch/1383883/

Fix the following coccicheck warning:
./drivers/soc/ti/smartreflex.c:820:0-23: WARNING: pm_sr_fops should be
defined with DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 drivers/soc/ti/smartreflex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index 5376f3d..b3c7460 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -817,7 +817,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
+DEFINE_DEBUGFS_ATTRIBUTE(pm_sr_fops, omap_sr_autocomp_show,
 			omap_sr_autocomp_store, "%llu\n");
 
 static int omap_sr_probe(struct platform_device *pdev)
-- 
1.8.3.1

