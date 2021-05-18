Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8DD388347
	for <lists+linux-pm@lfdr.de>; Wed, 19 May 2021 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbhERXog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 19:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhERXof (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 19:44:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757CBC061573;
        Tue, 18 May 2021 16:43:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id di13so13209018edb.2;
        Tue, 18 May 2021 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjYQwQ9/5/A/9HOipl1Xc8ES3BnP3H1XNLdUqpXzYhQ=;
        b=Z/AjHducSqpAGLVll4DWyqU1Hi227yYS+V5kmV2OGSvlOgN6q21SCjM3jWWqONZ5F1
         ipWptuA88u6fwyRu9zqxcm9sNQ1ysfRHG/LCIAmf1aNpkiMUOKfFLrhPbhpCY0DMMZOj
         bWCzW8m+u6Z/QuLb7HHa2vJkPvUPzn+Rd/ExBheI8Yb32cjiXzTx990AXjWMsaVcmmXG
         vbCipruJkhCHz4ZwMWGmvoMfsFPzgwbzb7RUl/Ap+HuXqk2UwdBfUFrR8nrIrfQk+y1K
         mj/W/8MpBDvtidNEw0jeV7KludCT3sSaKL75u1pBDSy5/9p6PqL86c7GO1r2lSTjl9xg
         noiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjYQwQ9/5/A/9HOipl1Xc8ES3BnP3H1XNLdUqpXzYhQ=;
        b=l4FKW+h9qB3bbxyDjpM4xlmZ5wDXS/2nJc8EBoEel7bh72K77J1Zv89sRAMcOzhu5S
         x21JoEDTkixSolO5SKQIKr5Qjb6O0c+bAjxA9rg0u+baQqttVCbIZOkapeTSmwFCMTsI
         j+WlXpQmr2kTiz1J/LTMnKUG/9bzUwZRyAZpW/oQqju9uGJ5RF7npJGcXk6Ie55thQge
         jPsN/yyeExZcsajZVccse7ldLN6qEzPbVHB7ERjkd6tE9VSEmrngYRRHlpYqQ9UvRVDR
         yUz7mWJ+/zBOHD4TPsdN31mcECjowpFE/SzrV4SiJC7Pma6JGyQ1VrzQHk2AdHlZAE0S
         LOlQ==
X-Gm-Message-State: AOAM530oz2KQLbIt7VOqzyLxi3BGpTAOLqjVT9c56FenpQBQ3YKOpYAG
        odum9RaqVxYvopqEdZkkzhoPRtClhuo1zg==
X-Google-Smtp-Source: ABdhPJwPVflDMFCOx01/mAVK5h1ssxwhSJiWGQsqrk8qcW7ZtII2zSzFY+Vcbxyt3RxYLxipUchZpw==
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr9772425edv.44.1621381394077;
        Tue, 18 May 2021 16:43:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id bm13sm11220567ejb.75.2021.05.18.16.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:43:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drivers: thermal: tsens: check if crit_int is supported in read_irq_state
Date:   Wed, 19 May 2021 01:43:07 +0200
Message-Id: <20210518234309.29014-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210518234309.29014-1-ansuelsmth@gmail.com>
References: <20210518234309.29014-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Robert Marko <robimarko@gmail.com>

Check if crit_int is supported by the current tsens feat and read crit
field only if needed or the kernel panic for reading unreadable memory.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 38afde1a599f..27777a05f755 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -325,16 +325,22 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 		ret = regmap_field_read(priv->rf[LOW_INT_MASK_0 + hw_id], &d->low_irq_mask);
 		if (ret)
 			return ret;
-		ret = regmap_field_read(priv->rf[CRIT_INT_CLEAR_0 + hw_id],
-					&d->crit_irq_clear);
-		if (ret)
-			return ret;
-		ret = regmap_field_read(priv->rf[CRIT_INT_MASK_0 + hw_id],
-					&d->crit_irq_mask);
-		if (ret)
-			return ret;
+		if (priv->feat->crit_int) {
+			ret = regmap_field_read(priv->rf[CRIT_INT_CLEAR_0 + hw_id],
+						&d->crit_irq_clear);
+			if (ret)
+				return ret;
+			ret = regmap_field_read(priv->rf[CRIT_INT_MASK_0 + hw_id],
+						&d->crit_irq_mask);
+			if (ret)
+				return ret;
 
-		d->crit_thresh = tsens_hw_to_mC(s, CRIT_THRESH_0 + hw_id);
+			d->crit_thresh = tsens_hw_to_mC(s, CRIT_THRESH_0 + hw_id);
+		} else {
+			d->crit_irq_clear = 0;
+			d->crit_irq_mask = 0;
+			d->crit_thresh = 0;
+		}
 	} else {
 		/* No mask register on older TSENS */
 		d->up_irq_mask = 0;
-- 
2.30.2

