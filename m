Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD44A35B8FD
	for <lists+linux-pm@lfdr.de>; Mon, 12 Apr 2021 05:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhDLDkj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Apr 2021 23:40:39 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41044 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235366AbhDLDke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Apr 2021 23:40:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UVCP-NX_1618198809;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVCP-NX_1618198809)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Apr 2021 11:40:15 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     edubezval@gmail.com
Cc:     j-keerthy@ti.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] thermal: ti-soc-thermal: remove useless variable
Date:   Mon, 12 Apr 2021 11:40:08 +0800
Message-Id: <1618198808-22556-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following gcc warning:

drivers/thermal/ti-soc-thermal/ti-bandgap.c:1146:7: warning: variable
‘val’ set but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 8a3646e..2df0e09 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1143,13 +1143,12 @@ static int ti_bandgap_restore_ctxt(struct ti_bandgap *bgp)
 	for (i = 0; i < bgp->conf->sensor_count; i++) {
 		struct temp_sensor_registers *tsr;
 		struct temp_sensor_regval *rval;
-		u32 val = 0;
 
 		rval = &bgp->regval[i];
 		tsr = bgp->conf->sensors[i].registers;
 
 		if (TI_BANDGAP_HAS(bgp, COUNTER))
-			val = ti_bandgap_readl(bgp, tsr->bgap_counter);
+			ti_bandgap_readl(bgp, tsr->bgap_counter);
 
 		if (TI_BANDGAP_HAS(bgp, TSHUT_CONFIG))
 			ti_bandgap_writel(bgp, rval->tshut_threshold,
-- 
1.8.3.1

