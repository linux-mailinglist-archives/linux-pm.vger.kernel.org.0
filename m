Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983643E1510
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbhHEMw0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 08:52:26 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:39939 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhHEMwZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 08:52:25 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7610bdeed4f9-1416d; Thu, 05 Aug 2021 20:51:59 +0800 (CST)
X-RM-TRANSID: 2ee7610bdeed4f9-1416d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7610bdee93b2-eb9fc;
        Thu, 05 Aug 2021 20:51:59 +0800 (CST)
X-RM-TRANSID: 2ee7610bdee93b2-eb9fc
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] power: supply: sc27xx: Delete superfluous error message
Date:   Thu,  5 Aug 2021 20:52:33 +0800
Message-Id: <20210805125233.16268-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the function sc27xx_fgu_probe(), when get irq failed,
platform_get_irq() logs an error message, so remove
redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 9c627618c..5e7f7a19e 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1229,10 +1229,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq resource specified\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(data->dev, irq, NULL,
 					sc27xx_fgu_interrupt,
-- 
2.20.1.windows.1



