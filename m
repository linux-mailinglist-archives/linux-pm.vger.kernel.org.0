Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8038E3FF
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhEXK1q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 06:27:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:8490 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232422AbhEXK1q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 06:27:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UZvuUPT_1621851964;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UZvuUPT_1621851964)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 18:26:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     edubezval@gmail.com
Cc:     j-keerthy@ti.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] thermal: ti-soc-thermal: Fix kernel-doc
Date:   Mon, 24 May 2021 18:26:03 +0800
Message-Id: <1621851963-36548-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix function name in ti-bandgap.c kernel-doc comment
to remove a warning.

drivers/thermal/ti-soc-thermal/ti-bandgap.c:787: warning: expecting
prototype for ti_bandgap_alert_init(). Prototype was for
ti_bandgap_talert_init() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ebe7cb7..ea0603b 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -770,7 +770,7 @@ static int ti_bandgap_tshut_init(struct ti_bandgap *bgp,
 }
 
 /**
- * ti_bandgap_alert_init() - setup and initialize talert handling
+ * ti_bandgap_talert_init() - setup and initialize talert handling
  * @bgp: pointer to struct ti_bandgap
  * @pdev: pointer to device struct platform_device
  *
-- 
1.8.3.1

