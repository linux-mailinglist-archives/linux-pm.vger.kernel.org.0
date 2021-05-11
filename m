Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6B379D98
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhEKDVx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 23:21:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2051 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEKDVx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 23:21:53 -0400
Received: from dggeml767-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FfNPD15sXzWhLv;
        Tue, 11 May 2021 11:16:32 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggeml767-chm.china.huawei.com (10.1.199.177) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 11:20:45 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 11:20:45 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <sre@kernel.org>, <orsonzhai@gmail.com>, <baolin.wang7@gmail.com>,
        <zhang.lyra@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] power: supply: sc27xx: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 11:37:45 +0800
Message-ID: <1620704265-104090-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 9c62761..1ae8374 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1342,6 +1342,7 @@ static const struct of_device_id sc27xx_fgu_of_match[] = {
 	{ .compatible = "sprd,sc2731-fgu", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sc27xx_fgu_of_match);
 
 static struct platform_driver sc27xx_fgu_driver = {
 	.probe = sc27xx_fgu_probe,
-- 
2.6.2

