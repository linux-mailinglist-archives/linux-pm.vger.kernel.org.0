Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391A9E57B0
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2019 03:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfJZBED (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 21:04:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfJZBED (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 21:04:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0EAF6DA20EAAE861033;
        Sat, 26 Oct 2019 09:03:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sat, 26 Oct 2019 09:03:53 +0800
From:   Tian Tao <tiantao6@huawei.com>
To:     <talel@amazon.com>, <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <linux-pm@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] thermal: no need to set .owner when using module_platform_driver
Date:   Sat, 26 Oct 2019 09:04:35 +0800
Message-ID: <1572051875-35861-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

the module_platform_driver will call platform_driver_register.
and It will set the .owner to THIS_MODULE

Signed-off-by: Tian Tao <tiantao6@huawei.com>
---
 drivers/thermal/thermal_mmio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 40524fa..d0bdf1e 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -110,7 +110,6 @@ static struct platform_driver thermal_mmio_driver = {
 	.probe = thermal_mmio_probe,
 	.driver = {
 		.name = "thermal-mmio",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(thermal_mmio_id_table),
 	},
 };
-- 
2.7.4

