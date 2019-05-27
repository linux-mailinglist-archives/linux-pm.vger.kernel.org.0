Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55022B3B4
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfE0L5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 07:57:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbfE0L5a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 May 2019 07:57:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF862B0A799E918D0980;
        Mon, 27 May 2019 19:57:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 27 May 2019 19:57:19 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] drivers: base: power: Use of_clk_get_parent_count()
Date:   Mon, 27 May 2019 20:05:35 +0800
Message-ID: <20190527120535.176015-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAMuHMdX=o+gT6fbpZcj8jQbHi9LJci9CX72DG5j+DKYxuSkYvQ@mail.gmail.com>
References: <CAMuHMdX=o+gT6fbpZcj8jQbHi9LJci9CX72DG5j+DKYxuSkYvQ@mail.gmail.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/base/power/clock_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59d19dd64928..3e84e3085d43 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -12,6 +12,7 @@
 #include <linux/pm_clock.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/of_clk.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/pm_domain.h>
@@ -195,8 +196,7 @@ int of_pm_clk_add_clks(struct device *dev)
 	if (!dev || !dev->of_node)
 		return -EINVAL;
 
-	count = of_count_phandle_with_args(dev->of_node, "clocks",
-					   "#clock-cells");
+	count = of_clk_get_parent_count(dev->of_node);
 	if (count <= 0)
 		return -ENODEV;
 
-- 
2.20.1

