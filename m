Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B70739F2A6
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFHJnj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 05:43:39 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39224 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHJnj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 05:43:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UbkgoD._1623145303;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UbkgoD._1623145303)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Jun 2021 17:41:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     amitk@kernel.org
Cc:     thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] thermal/drivers/tsens: fix usage of unititialized value
Date:   Tue,  8 Jun 2021 17:41:39 +0800
Message-Id: <1623145299-109090-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When "tsens_version(priv) > VER_0_1" is false,
"regmap_field_read(priv->rf[VER_MINOR], &ver_minor)" can't execute.
So, ver_minor has no initialization and assignment before it is
used, and we initialize it to 0.

Clean up smatch warning:
drivers/thermal/qcom/tsens.c:896 init_common() error: uninitialized
symbol 'ver_minor'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4c7ebd1..a36c43d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -743,8 +743,8 @@ int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct device *dev = priv->dev;
-	u32 ver_minor;
 	struct resource *res;
+	u32 ver_minor = 0;
 	u32 enabled;
 	int ret, i, j;
 	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
-- 
1.8.3.1

