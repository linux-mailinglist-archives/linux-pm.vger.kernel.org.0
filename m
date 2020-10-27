Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE729A204
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 02:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440622AbgJ0BGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 21:06:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:5423 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439444AbgJ0BGB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 21:06:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CKtn76hkWz6yYb;
        Tue, 27 Oct 2020 09:06:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 09:05:50 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <niklas.soderlund@ragnatech.se>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] thermal: rcar: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Tue, 27 Oct 2020 09:06:30 +0800
Message-ID: <1603760790-37748-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On RT or even on mainline with 'threadirqs' on the command line all
interrupts which are not explicitly requested with IRQF_NO_THREAD
run their handlers in thread context. The same applies to soft interrupts.
That means they are subject to the normal scheduler rules and no other
code is going to acquire that lock from hard interrupt context either,
so the irqsave() here is pointless in all cases.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/thermal/rcar_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5c2a13b..6ae757d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -409,16 +409,15 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 {
 	struct rcar_thermal_common *common = data;
 	struct rcar_thermal_priv *priv;
-	unsigned long flags;
 	u32 status, mask;
 
-	spin_lock_irqsave(&common->lock, flags);
+	spin_lock(&common->lock);
 
 	mask	= rcar_thermal_common_read(common, INTMSK);
 	status	= rcar_thermal_common_read(common, STR);
 	rcar_thermal_common_write(common, STR, 0x000F0F0F & mask);
 
-	spin_unlock_irqrestore(&common->lock, flags);
+	spin_unlock(&common->lock);
 
 	status = status & ~mask;
 
-- 
2.7.4

