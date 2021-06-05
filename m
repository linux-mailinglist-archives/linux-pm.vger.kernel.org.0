Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4339C39C4B1
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jun 2021 03:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFEBEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 21:04:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4309 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFEBEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 21:04:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fxh7z5QsHz19RQ1;
        Sat,  5 Jun 2021 08:58:07 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 09:02:53 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 5 Jun 2021 09:02:53 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] power: reset: add missing MODULE_DEVICE_TABLE
Date:   Sat, 5 Jun 2021 09:21:23 +0800
Message-ID: <1622856083-68097-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 drivers/power/reset/regulator-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/reset/regulator-poweroff.c
index f697088..2070120 100644
--- a/drivers/power/reset/regulator-poweroff.c
+++ b/drivers/power/reset/regulator-poweroff.c
@@ -64,6 +64,7 @@ static const struct of_device_id of_regulator_poweroff_match[] = {
 	{ .compatible = "regulator-poweroff", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, of_regulator_poweroff_match);
 
 static struct platform_driver regulator_poweroff_driver = {
 	.probe = regulator_poweroff_probe,
-- 
2.6.2

