Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5AA366724
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhDUInZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 04:43:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16146 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhDUInY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 04:43:24 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FQDWV33SKznbTc;
        Wed, 21 Apr 2021 16:39:50 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Wed, 21 Apr 2021
 16:42:43 +0800
From:   Lin Ruizhe <linruizhe@huawei.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <j-keerthy@ti.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <gregkh@linuxfoundation.org>, <radhesh.fadnis@ti.com>,
        <eballetbo@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linruizhe@huawei.com>
Subject: [PATCH v3] thermal: ti-soc-thermal: Remove unused variable 'val'
Date:   Wed, 21 Apr 2021 16:42:56 +0800
Message-ID: <20210421084256.57591-1-linruizhe@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The variable 'val'in function ti_bandgap_restore_ctxt is
the register value of read bandgap registers. This function is to
restore the context. But there is no operation on the return value
of this register, so this block is redundant. Hulk robot scans this
warning.This commit remove the dead code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: b87ea759a4cc ("staging: omap-thermal: fix context restore function")
Signed-off-by: Lin Ruizhe <linruizhe@huawei.com>
---
v3:
-Add Fixes tag and more accurate commit message in this patch.
v2:
-As suggest remove the whole unuesed block in fuction
 ti_bandgap_restore_ctxt

 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index d81af89166d2..684ffb645aa9 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1142,14 +1142,10 @@ static int ti_bandgap_restore_ctxt(struct ti_bandgap *bgp)
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		struct temp_sensor_registers *tsr;
 		struct temp_sensor_regval *rval;
-		u32 val = 0;
 
 		rval = &bgp->regval[i];
 		tsr = bgp->conf->sensors[i].registers;
 
-		if (TI_BANDGAP_HAS(bgp, COUNTER))
-			val = ti_bandgap_readl(bgp, tsr->bgap_counter);
-
 		if (TI_BANDGAP_HAS(bgp, TSHUT_CONFIG))
 			ti_bandgap_writel(bgp, rval->tshut_threshold,
 					  tsr->tshut_threshold);
-- 
2.22.0

