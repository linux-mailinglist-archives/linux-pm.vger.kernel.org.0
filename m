Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7759769515
	for <lists+linux-pm@lfdr.de>; Mon, 31 Jul 2023 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGaLkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Jul 2023 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGaLkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2023 07:40:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A786E4B
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2023 04:40:38 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDx9N1KhXzrS3s;
        Mon, 31 Jul 2023 19:39:36 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 19:40:36 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] power: supply: 88pm860x_battery: fix the return value handle for platform_get_irq()
Date:   Mon, 31 Jul 2023 19:39:59 +0800
Message-ID: <20230731113959.1957820-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no possible for platform_get_irq() to return 0,
and the return value of platform_get_irq() is more sensible
to show the error reason.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/power/supply/88pm860x_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index f3f3f8cd1a7f..34619c4d4ece 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -921,12 +921,12 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->irq_cc = platform_get_irq(pdev, 0);
-	if (info->irq_cc <= 0)
-		return -EINVAL;
+	if (info->irq_cc < 0)
+		return info->irq_cc;
 
 	info->irq_batt = platform_get_irq(pdev, 1);
-	if (info->irq_batt <= 0)
-		return -EINVAL;
+	if (info->irq_batt < 0)
+		return info->irq_batt;
 
 	info->chip = chip;
 	info->i2c =
-- 
2.34.1

