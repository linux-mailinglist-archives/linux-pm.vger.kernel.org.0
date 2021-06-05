Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B131E39C800
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jun 2021 13:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFEL7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Jun 2021 07:59:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4489 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhFEL7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Jun 2021 07:59:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fxyk52FwZzYn8p;
        Sat,  5 Jun 2021 19:55:09 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 19:57:56 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 19:57:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>
Subject: [PATCH net-next v2] thermal: st: Use devm_platform_get_and_ioremap_resource()
Date:   Sat, 5 Jun 2021 20:02:05 +0800
Message-ID: <20210605120205.2459578-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify
code and remove error message which within
devm_platform_get_and_ioremap_resource() already.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2:
 remove 'res'
---
 drivers/thermal/st/st_thermal_memmap.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index a0114452d11f..d68596c40be9 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -119,19 +119,10 @@ static int st_mmap_regmap_init(struct st_thermal_sensor *sensor)
 {
 	struct device *dev = sensor->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no memory resources defined\n");
-		return -ENODEV;
-	}
-
-	sensor->mmio_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(sensor->mmio_base)) {
-		dev_err(dev, "failed to remap IO\n");
+	sensor->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(sensor->mmio_base))
 		return PTR_ERR(sensor->mmio_base);
-	}
 
 	sensor->regmap = devm_regmap_init_mmio(dev, sensor->mmio_base,
 				&st_416mpe_regmap_config);
-- 
2.25.1

