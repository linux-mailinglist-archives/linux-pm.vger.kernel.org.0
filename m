Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E1221F11
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgGPIy5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 04:54:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgGPIy4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jul 2020 04:54:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ACAD59071DE4AB4BA700;
        Thu, 16 Jul 2020 16:54:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:54:53 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] power: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 16:58:49 +0800
Message-ID: <20200716085849.11571-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yongqiang Liu <liuyongqiang13@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/power/supply/da9030_battery.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 292ecf875..0deba48d2 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -172,17 +172,7 @@ static int bat_debug_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bat_debug_show, inode->i_private);
-}
-
-static const struct file_operations bat_debug_fops = {
-	.open		= debug_open,
-	.read_iter		= seq_read_iter,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bat_debug);
 
 static struct dentry *da9030_bat_create_debugfs(struct da9030_charger *charger)
 {
-- 
2.17.1

