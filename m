Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14606359236
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 04:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhDICvq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 22:51:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15633 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICvp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 22:51:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGjHt5pSSznZ5M;
        Fri,  9 Apr 2021 10:48:42 +0800 (CST)
Received: from huawei.com (10.67.174.78) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 10:51:21 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Chen Lifu <chenlifu@huawei.com>,
        <linux-pm@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] power: reset: hisi-reboot: add missing MODULE_DEVICE_TABLE
Date:   Fri, 9 Apr 2021 10:50:11 +0800
Message-ID: <20210409025011.8796-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.78]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 drivers/power/reset/hisi-reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/hisi-reboot.c b/drivers/power/reset/hisi-reboot.c
index 5abc5f6ba0fd..34409340528f 100644
--- a/drivers/power/reset/hisi-reboot.c
+++ b/drivers/power/reset/hisi-reboot.c
@@ -68,6 +68,7 @@ static const struct of_device_id hisi_reboot_of_match[] = {
 	{ .compatible = "hisilicon,sysctrl" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, hisi_reboot_of_match);
 
 static struct platform_driver hisi_reboot_driver = {
 	.probe = hisi_reboot_probe,

