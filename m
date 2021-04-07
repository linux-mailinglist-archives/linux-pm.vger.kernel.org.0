Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3903567C6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 11:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhDGJNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 05:13:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16811 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhDGJNs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 05:13:48 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FFdtQ1mcZz9wjx;
        Wed,  7 Apr 2021 17:11:26 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 17:13:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <sre@kernel.org>
Subject: [PATCH -next] power: supply: generic-adc-battery: fix possible use-after-free in gab_remove()
Date:   Wed, 7 Apr 2021 17:17:06 +0800
Message-ID: <20210407091706.3266580-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver's remove path calls cancel_delayed_work(). However, that
function does not wait until the work function finishes. This means
that the callback function may still be running after the driver's
remove function has finished, which would result in a use-after-free.

Fix by calling cancel_delayed_work_sync(), which ensures that
the work is properly cancelled, no longer running, and unable
to re-schedule itself.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 0032069fbc2b..66039c665dd1 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -373,7 +373,7 @@ static int gab_remove(struct platform_device *pdev)
 	}
 
 	kfree(adc_bat->psy_desc.properties);
-	cancel_delayed_work(&adc_bat->bat_work);
+	cancel_delayed_work_sync(&adc_bat->bat_work);
 	return 0;
 }
 
-- 
2.25.1

