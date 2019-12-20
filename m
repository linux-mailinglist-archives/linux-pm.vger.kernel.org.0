Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943EF127818
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 10:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTJ1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 04:27:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727167AbfLTJ1J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Dec 2019 04:27:09 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 251A4338C9E44F655816;
        Fri, 20 Dec 2019 17:27:07 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 17:27:00 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <sebastian.reichel@collabora.com>, <l.stach@pengutronix.de>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH next] power: suppy: ucs1002: Make the symbol 'ucs1002_regulator_enable' static
Date:   Fri, 20 Dec 2019 17:41:44 +0800
Message-ID: <20191220094144.41142-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following sparse warning:

drivers/power/supply/ucs1002_power.c:492:5: warning: symbol 'ucs1002_regulator_enable' was not declared. Should it be static?

Fixes: a3d70dacc727 ("power: suppy: ucs1002: disable power when maxcurrent is 0")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/power/supply/ucs1002_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index 0ca80d00b80a..cdb9a23d825f 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -489,7 +489,7 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int ucs1002_regulator_enable(struct regulator_dev *rdev)
+static int ucs1002_regulator_enable(struct regulator_dev *rdev)
 {
 	struct ucs1002_info *info = rdev_get_drvdata(rdev);
 
-- 
2.17.1

