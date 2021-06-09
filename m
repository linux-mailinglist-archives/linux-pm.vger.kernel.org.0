Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF63A0DAE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhFIHYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 03:24:30 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43222 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235509AbhFIHY3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 03:24:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UbpzKCG_1623223352;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbpzKCG_1623223352)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Jun 2021 15:22:33 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rui.zhang@intel.com
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH v2] thermal: devfreq_cooling: Fix kernel-doc
Date:   Wed,  9 Jun 2021 15:22:30 +0800
Message-Id: <1623223350-128104-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix function name in devfreq_cooling.c comment to remove a 
warning found by kernel-doc.

drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
devfreq_cooling_em_register_power(). Prototype was for
devfreq_cooling_em_register() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

Change in v2:
--replaced s/clang(make W=1 LLVM=1)/kernel-doc/ in commit.
https://lore.kernel.org/patchwork/patch/1442639/

 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 3a788ac..5a86cff 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
 EXPORT_SYMBOL_GPL(devfreq_cooling_register);
 
 /**
- * devfreq_cooling_em_register_power() - Register devfreq cooling device with
+ * devfreq_cooling_em_register() - Register devfreq cooling device with
  *		power information and automatically register Energy Model (EM)
  * @df:		Pointer to devfreq device.
  * @dfc_power:	Pointer to devfreq_cooling_power.
-- 
1.8.3.1

