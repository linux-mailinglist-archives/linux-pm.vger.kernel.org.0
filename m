Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4C21BDF0
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgGJTqM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgGJTqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:46:09 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900EBC08C5DC;
        Fri, 10 Jul 2020 12:46:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so7288944ejn.10;
        Fri, 10 Jul 2020 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MapCcG3rDVQikXJqKbCdGCP4OroaHsdmgZ0eMywfhvo=;
        b=sFqj3VWsrm76BzKIOMnLfmJvaMAqKXp1P4/5CpT5DwgTy3BhBvsBvqJpqrrf91VJJm
         LRAo2Wi/adJcTO+0PtFX7iXLe9TG9Xu0DwhKbK9LvP0qvwyfQq9snm03EqxNiMJbVK1w
         t9l90w9zMVmGvLmgCiFODb7/IuRPm8kM5d2qr4uAU/LHuUAMk3RSeP5v6gx5cT8L9Lbk
         7fv1+C9kv0NltibnHjby+5bJkih44Mrr2ifkD3zA26ji5F8m+x9oybw01nv0tR4FLzWa
         RzHyT6XAO43QnCu6/TLHbax1fpd2VxdY8RS2ND/a3qTkTqEcB08p96agDvjPP/RdlViK
         zz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MapCcG3rDVQikXJqKbCdGCP4OroaHsdmgZ0eMywfhvo=;
        b=CDYK5oLx/mFdwAeGThguofhtgsoiBaCb4dfar1hGjDrrPZZfZSxuSjRsdxi9Gy3SQA
         tITv81VJhsiBNMO//dmNZxYrT4y70aYlSFcg/UvraFHK+7Y/1gfmm+dIuNqCGZDp8Uop
         gP1slRtpOKSVjStvskgcSa+HW8CCk0cR20Nz8bYSV3fmKUWP0fvejtFZxrgEvtH2dlBd
         2vZfeaCvEnxFZLD2fl8ueA/88E5WLnuu3iFZ3DQFfWqbXtGmskFyhW1mTBLcyY4BeNzt
         yjq1LDTJLZO7ndfZHJm3crX+lYWBeOTAxmdSvvsjo7a1knlfaW/DyEMKvBq6FXc+7ru/
         lULQ==
X-Gm-Message-State: AOAM532FDk6fQSYro0I8JxGD8ewKF/UGu7blvK/d/TZ4JgUkMsu4ZYWf
        CadjSjD8k/KJgM7TS2Kv4FI=
X-Google-Smtp-Source: ABdhPJyjeBCtVLAvL+QcjeWmyjyJ130OGzPm5THEkcOG8tUsCE7Tz0Y+MoqkD4O/M+IA9BN1RdJeIA==
X-Received: by 2002:a17:906:2b9b:: with SMTP id m27mr51778565ejg.19.1594410367046;
        Fri, 10 Jul 2020 12:46:07 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id kt4sm4155768ejb.48.2020.07.10.12.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:46:06 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] drivers: thermal: tsens: load regmap from phandle for 8960
Date:   Fri, 10 Jul 2020 21:45:52 +0200
Message-Id: <20200710194558.26487-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710194558.26487-1-ansuelsmth@gmail.com>
References: <20200710194558.26487-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Devices based on 8060 tsens driver (ipq8064) use the reg of the gcc
driver. Permit to load the regmap from a syscon phandle instead of fail
as the reg are already used by another driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 2a28a5af209e..890baf1b5542 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 #include <linux/thermal.h>
 #include "tsens.h"
 
@@ -168,8 +169,12 @@ static int init_8960(struct tsens_priv *priv)
 	u32 reg_cntl;
 
 	priv->tm_map = dev_get_regmap(priv->dev, NULL);
-	if (!priv->tm_map)
-		return -ENODEV;
+	if (!priv->tm_map) {
+		priv->tm_map = syscon_regmap_lookup_by_phandle(
+			priv->dev->of_node, "regmap");
+		if (IS_ERR(priv->tm_map))
+			return -ENODEV;
+	}
 
 	/*
 	 * The status registers for each sensor are discontiguous
-- 
2.27.0

