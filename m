Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226DE3237C2
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 08:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhBXHQL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 02:16:11 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47789 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232560AbhBXHQC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 02:16:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UPQXqKn_1614150912;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPQXqKn_1614150912)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 15:15:16 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sre@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] power: supply: max8997-charger: remove unneeded semicolon
Date:   Wed, 24 Feb 2021 15:15:10 +0800
Message-Id: <1614150910-21023-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/power/supply/max8997_charger.c:266:3-4: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/power/supply/max8997_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index 321bd6b..a90c018 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -263,7 +263,7 @@ static int max8997_battery_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register extcon notifier\n");
 			return ret;
-		};
+		}
 	}
 
 	return 0;
-- 
1.8.3.1

