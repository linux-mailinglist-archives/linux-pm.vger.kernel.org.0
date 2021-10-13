Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889EC42BB55
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhJMJTn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 05:19:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23375 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbhJMJTn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 05:19:43 -0400
Received: from dggeml709-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HTmzB3VXTzR5d4;
        Wed, 13 Oct 2021 17:13:10 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 dggeml709-chm.china.huawei.com (10.3.17.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:17:38 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Kate Hsuan <hpa@redhat.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <linux-pm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] power: supply: axp288_charger: Fix missing mutex_init()
Date:   Wed, 13 Oct 2021 09:31:15 +0000
Message-ID: <20211013093115.2841167-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeml709-chm.china.huawei.com (10.3.17.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver allocates the mutex but not initialize it.
Use mutex_init() on it to initialize it correctly.

Fixes: ed229454856e ("power: supply: axp288-charger: Optimize register reading method")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/power/supply/axp288_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index fd4983c98fd9..9987b1731e38 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -865,6 +865,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	mutex_init(&info->lock);
 	info->pdev = pdev;
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;

