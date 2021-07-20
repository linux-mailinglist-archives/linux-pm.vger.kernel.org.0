Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CF3CFBD4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhGTNfI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 09:35:08 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:6870 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbhGTNev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 09:34:51 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee660f6da5a009-3e58a; Tue, 20 Jul 2021 22:14:50 +0800 (CST)
X-RM-TRANSID: 2ee660f6da5a009-3e58a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.134])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee560f6da56c2c-93cd8;
        Tue, 20 Jul 2021 22:14:49 +0800 (CST)
X-RM-TRANSID: 2ee560f6da56c2c-93cd8
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, sre@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] power: supply: qcom_smbb: Remove superfluous error message
Date:   Tue, 20 Jul 2021 22:15:39 +0800
Message-Id: <20210720141539.7716-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the probe function, when get irq failed, the function
platform_get_irq_byname() logs an error message, so remove
redundant message here.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/power/supply/qcom_smbb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index c890e1cec..84cc9fba0 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -929,11 +929,8 @@ static int smbb_charger_probe(struct platform_device *pdev)
 		int irq;
 
 		irq = platform_get_irq_byname(pdev, smbb_charger_irqs[i].name);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "failed to get irq '%s'\n",
-				smbb_charger_irqs[i].name);
+		if (irq < 0)
 			return irq;
-		}
 
 		smbb_charger_irqs[i].handler(irq, chg);
 
-- 
2.20.1.windows.1



