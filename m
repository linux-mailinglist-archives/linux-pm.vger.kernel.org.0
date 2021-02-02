Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350F630B822
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 07:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhBBG4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 01:56:42 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51842 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhBBG4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 01:56:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNeszCN_1612248925;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNeszCN_1612248925)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 14:55:25 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     myungjoo.ham@samsung.com
Cc:     kyungmin.park@samsung.com, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] PM / devfreq: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 14:55:24 +0800
Message-Id: <1612248924-54419-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/devfreq/rk3399_dmc.c:403:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/devfreq/rk3399_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 2e91216..9e9d3b4c 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -400,7 +400,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	default:
 		ret = -EINVAL;
 		goto err_edev;
-	};
+	}
 
 no_pmu:
 	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
-- 
1.8.3.1

