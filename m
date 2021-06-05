Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06E939C6C4
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jun 2021 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFEI3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Jun 2021 04:29:45 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4365 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhFEI3p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Jun 2021 04:29:45 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fxt2c0pDrz5sk7;
        Sat,  5 Jun 2021 16:24:08 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 16:27:55 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 16:27:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>
Subject: [PATCH -next] thermal: st: Use devm_platform_get_and_ioremap_resource()
Date:   Sat, 5 Jun 2021 16:32:12 +0800
Message-ID: <20210605083212.2069195-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
 drivers/thermal/st/st_thermal_memmap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index a0114452d11f..35e904da7582 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -121,17 +121,9 @@ static int st_mmap_regmap_init(struct st_thermal_sensor *sensor)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no memory resources defined\n");
-		return -ENODEV;
-	}
-
-	sensor->mmio_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(sensor->mmio_base)) {
-		dev_err(dev, "failed to remap IO\n");
+	sensor->mmio_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(sensor->mmio_base))
 		return PTR_ERR(sensor->mmio_base);
-	}
 
 	sensor->regmap = devm_regmap_init_mmio(dev, sensor->mmio_base,
 				&st_416mpe_regmap_config);
-- 
2.25.1

