Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCB3A8F91
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhFPDrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 23:47:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10082 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFPDrl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 23:47:41 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4WGl5CgnzZcBp;
        Wed, 16 Jun 2021 11:42:39 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.62) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 16 Jun 2021 11:45:34 +0800
From:   Yu Jiahua <yujiahua1@huawei.com>
To:     <ssantosh@kernel.org>, <sre@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Yu Jiahua <yujiahua1@huawei.com>
Subject: [PATCH -next] drivers: power: add missing MODULE_DEVICE_TABLE in keystone-reset.c
Date:   Tue, 15 Jun 2021 19:46:22 -0800
Message-ID: <20210616034622.35766-1-yujiahua1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.62]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Signed-off-by: Yu Jiahua <yujiahua1@huawei.com>
---
 drivers/power/reset/keystone-reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index 211eeef0c81a..c720112db704 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -71,6 +71,7 @@ static const struct of_device_id rsctrl_of_match[] = {
 	{.compatible = "ti,keystone-reset", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, rsctrl_of_match);
 
 static int rsctrl_probe(struct platform_device *pdev)
 {
-- 
2.17.1

