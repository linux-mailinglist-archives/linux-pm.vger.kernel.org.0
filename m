Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0BD379F74
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEKGB1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 02:01:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2617 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhEKGBZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 02:01:25 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FfRyJ6788zPvqh;
        Tue, 11 May 2021 13:56:56 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 14:00:11 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <sre@kernel.org>, <orsonzhai@gmail.com>, <baolin.wang7@gmail.com>,
        <zhang.lyra@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] power: supply: sc2731_charger: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 14:17:12 +0800
Message-ID: <1620713832-106431-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
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
 drivers/power/supply/sc2731_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 335cb85..288b798 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -524,6 +524,7 @@ static const struct of_device_id sc2731_charger_of_match[] = {
 	{ .compatible = "sprd,sc2731-charger", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sc2731_charger_of_match);
 
 static struct platform_driver sc2731_charger_driver = {
 	.driver = {
-- 
2.6.2

