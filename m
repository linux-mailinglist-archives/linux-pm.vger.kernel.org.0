Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7339F2C0
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 11:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFHJsf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 05:48:35 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55796 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHJsd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 05:48:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UbkdQgs_1623145597;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbkdQgs_1623145597)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jun 2021 17:46:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rui.zhang@intel.com
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] thermal: devfreq_cooling: Fix kernel-doc
Date:   Tue,  8 Jun 2021 17:46:02 +0800
Message-Id: <1623145562-111662-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix function name in devfreq_cooling.c kernel-doc comment
to remove a warning found by clang(make W=1 LLVM=1).

drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
devfreq_cooling_em_register_power(). Prototype was for
devfreq_cooling_em_register() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
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

