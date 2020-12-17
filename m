Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D992DD18D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 13:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLQMhR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 07:37:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9901 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLQMhR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 07:37:17 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CxWgT33wHz7FLq;
        Thu, 17 Dec 2020 20:35:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 17 Dec 2020 20:36:26 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <sre@kernel.org>, <hdegoede@redhat.com>
CC:     <linux-pm@vger.kernel.org>
Subject: [PATCH] power: supply: axp288_charger: use devm_add_action_or_reset
Date:   Thu, 17 Dec 2020 20:36:34 +0800
Message-ID: <1608208594-29081-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When devm_add_action returns non-zero, it will return directly and
there is no place to call axp288_charger_cancel_work, while when
devm_add_action_or_reset returns non-zero, the system will
automatically call axp288_charger_cancel_work.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/power/supply/axp288_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index a4df1ea..6480c2e 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -855,7 +855,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	}
 
 	/* Cancel our work on cleanup, register this before the notifiers */
-	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
+	ret = devm_add_action_or_reset(dev, axp288_charger_cancel_work, info);
 	if (ret)
 		return ret;
 
-- 
2.7.4

