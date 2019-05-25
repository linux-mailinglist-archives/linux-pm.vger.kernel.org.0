Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6662A443
	for <lists+linux-pm@lfdr.de>; Sat, 25 May 2019 13:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfEYLxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 May 2019 07:53:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfEYLxp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 May 2019 07:53:45 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 663B9E6C2804F89FB817;
        Sat, 25 May 2019 19:53:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 19:53:29 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] drivers: base: power: Use of_clk_get_parent_count()
Date:   Sat, 25 May 2019 20:01:55 +0800
Message-ID: <20190525120155.108948-1-wangkefeng.wang@huawei.com>
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

Use of_clk_get_parent_count() instead of open coding.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/base/power/clock_ops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59d19dd64928..9c7e83267eac 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -195,8 +195,7 @@ int of_pm_clk_add_clks(struct device *dev)
 	if (!dev || !dev->of_node)
 		return -EINVAL;
 
-	count = of_count_phandle_with_args(dev->of_node, "clocks",
-					   "#clock-cells");
+	count = of_clk_get_parent_count(dev->of_node);
 	if (count <= 0)
 		return -ENODEV;
 
-- 
2.20.1

