Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249492D9912
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 14:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgLNNla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 08:41:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9523 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405793AbgLNNlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 08:41:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CvjDt4lMVzhtf2;
        Mon, 14 Dec 2020 21:39:58 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:40:24 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] power/supply/bq24190_charger: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:40:54 +0800
Message-ID: <20201214134054.4296-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/power/supply/bq24190_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index d14186525e1e..00c4f335481f 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1757,7 +1757,7 @@ static int bq24190_probe(struct i2c_client *client,
 	charger_cfg.drv_data = bdi;
 	charger_cfg.of_node = dev->of_node;
 	charger_cfg.supplied_to = bq24190_charger_supplied_to;
-	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to),
+	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to);
 	bdi->charger = power_supply_register(dev, &bq24190_charger_desc,
 						&charger_cfg);
 	if (IS_ERR(bdi->charger)) {
-- 
2.22.0

