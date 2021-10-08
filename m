Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CB6426495
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 08:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhJHG0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 02:26:01 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:24177 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhJHG0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Oct 2021 02:26:01 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HQdQd684cz1DHfX;
        Fri,  8 Oct 2021 14:22:33 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 14:24:04 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 14:24:03 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <sre@kernel.org>, <iskren.chernev@gmail.com>
Subject: [PATCH] power: supply: max17040: fix null-ptr-deref in max17040_probe()
Date:   Fri, 8 Oct 2021 14:31:50 +0800
Message-ID: <20211008063150.822066-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add check the return value of devm_regmap_init_i2c(), otherwise
later access may cause null-ptr-deref as follows:

KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
RIP: 0010:regmap_read+0x33/0x170
Call Trace:
  max17040_probe+0x61b/0xff0 [max17040_battery]
 ? write_comp_data+0x2a/0x90
 ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
 ? tracer_hardirqs_on+0x33/0x520
 ? __sanitizer_cov_trace_pc+0x1d/0x50
 ? _raw_spin_unlock_irqrestore+0x4b/0x60
 ? trace_hardirqs_on+0x63/0x2d0
 ? write_comp_data+0x2a/0x90
 ? __sanitizer_cov_trace_pc+0x1d/0x50
 ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
 i2c_device_probe+0xa31/0xbe0

Fixes: 6455a8a84bdf ("power: supply: max17040: Use regmap i2c")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/power/supply/max17040_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 3cea92e28dc3..a9aef1e8b186 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -449,6 +449,8 @@ static int max17040_probe(struct i2c_client *client,
 
 	chip->client = client;
 	chip->regmap = devm_regmap_init_i2c(client, &max17040_regmap);
+	if (IS_ERR(chip->regmap))
+		return PTR_ERR(chip->regmap);
 	chip_id = (enum chip_id) id->driver_data;
 	if (client->dev.of_node) {
 		ret = max17040_get_of_data(chip);
-- 
2.25.1

