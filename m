Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E532946D2
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 05:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406790AbgJUDEy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 23:04:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406694AbgJUDEy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 23:04:54 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A26D780450BD7FB833D0;
        Wed, 21 Oct 2020 11:04:51 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 21 Oct 2020 11:04:46 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <niklas.soderlund@ragnatech.se>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] thermal: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Wed, 21 Oct 2020 11:05:30 +0800
Message-ID: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

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

