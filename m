Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140A43536AF
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 06:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhDDEcb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 00:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhDDEca (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 00:32:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA27C061756;
        Sat,  3 Apr 2021 21:32:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q5so6117924pfh.10;
        Sat, 03 Apr 2021 21:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B74+pCF36od4K/ybosaLY+s77x1n5114fK05sPXpTnw=;
        b=Vfxcf6GDu5TykSAhDMWLPTa3KvfmONLbZ3wjKDqAHBz6unAUfddWA6M/Ez7kkDrtKW
         FccS4nNth6X461jjOfTe2KR/7fOigSrM4WFeqCkKswkrc1/C4wDgGznXHh0i1lNbUS7l
         gO95eM5V6CkwuFDsuBfdYxkIT5UXC1WhrJYckAqyAbE4t1ONfADtnoAz7glp6SgP6DCB
         Xbat+Zbn0AthfFKZNpUD6eXoU6edG8oSVU4EF7pjUzXZCOkzFF5gFQo3b2g29hDrOBtc
         5EWwQUs+6gjgtH5pGM7bkEyf/YVvxGijcIqcdN0OEvukg9a7gNRBHaMliRxeUE1NowQ0
         CCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B74+pCF36od4K/ybosaLY+s77x1n5114fK05sPXpTnw=;
        b=UMyazcDJs/D26zXqYfhQHDIkWVmrrnu9xJ6Hg/DEcr5C0oHOzvnCzdO2sZkn6cDSws
         TVq+n8VH/d3xrms/rGYU7UTL1sn22vNBvS10E1GUle9E9FvZtY92quKDE8ZmqUuOJhRJ
         V1oLETSaHYmHoJSaES8VyAWSzdSq0/bbhUVxLx/q+p26VJiQXomRlAoKy2ByNFmm4yPZ
         RervYLuE+5f9kpbNZsLBFJLOf1x4pfoJa0vXqj2E7KHEkg229aWj8CxRqi7TevmFqec/
         Yuez7jIjnjiTtn9kFfNXl9XMb+4JJFwr5jF8jrYPKt0S+j+2wIwi8vBaVKwzdmdnOKdc
         XJ/A==
X-Gm-Message-State: AOAM532F+YGqy0E/eFUeGfMqyh4pxQyzdoRLB89sp1eN6aJENoDqi0vK
        lCXd9Z0xc5pDo3WuOymf19s=
X-Google-Smtp-Source: ABdhPJysvBz25i1d4OqyDpvH2pSSsYSd+Y3X/iTSWruDDCNFhCghqxmR8b1HsnXsr7X9cZEisvnNKw==
X-Received: by 2002:a63:e903:: with SMTP id i3mr13201266pgh.374.1617510746254;
        Sat, 03 Apr 2021 21:32:26 -0700 (PDT)
Received: from localhost.localdomain ([124.108.22.4])
        by smtp.gmail.com with ESMTPSA id n6sm8948285pfq.214.2021.04.03.21.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 21:32:25 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] thermal/drivers/tsens: fix missing put_device error
Date:   Sun,  4 Apr 2021 12:32:19 +0800
Message-Id: <20210404043219.11334-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Fixes coccicheck error:

drivers/thermal/qcom/tsens.c:759:4-10: ERROR: missing put_device; call
of_find_device_by_node on line 715, but without a corresponding object
release within this function.

Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into
tsens.c")

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index d8ce3a687b80..cc4c6a9853a4 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -755,9 +755,10 @@ int __init init_common(struct tsens_priv *priv)
 		for (i = VER_MAJOR; i <= VER_STEP; i++) {
 			priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
 							      priv->fields[i]);
-			if (IS_ERR(priv->rf[i]))
-				return PTR_ERR(priv->rf[i]);
-		}
+			if (IS_ERR(priv->rf[i])) {
+				ret = PTR_ERR(priv->rf[i]);
+				goto err_put_device;
+			}
 		ret = regmap_field_read(priv->rf[VER_MINOR], &ver_minor);
 		if (ret)
 			goto err_put_device;
-- 
2.17.1

