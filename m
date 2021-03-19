Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632023411AF
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCSAxI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhCSAwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:52:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABA7C06174A;
        Thu, 18 Mar 2021 17:52:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o19so8880461edc.3;
        Thu, 18 Mar 2021 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=gUCdWsuLqwaPlkuEDt9Oop1znM7h12O8xPPcUuOQjNIJtPM+E3wGf1dSAAf8wUCGwF
         0fBFkY2ne/n9nY22Xb1Nj5H04hc+tW9quqCK5puaExrZGAyMR//onn26gBFGCayipUfS
         8Xz+InUrXzpc41ejkUsurzzgDLrZflrB/uhwYigO8IIdCRSjxaPA5xCxZ/eoWtU7YTqr
         PXv9U5ib8gm8+YlHyzZAC6vwFclUzfSd3EPZ0qU6tVSoZGx0lF1Y8P3wX/+FJmTzmJ89
         z3wpRfaL5uktbPbZC6Y34Vku92xP9PT4MUZ2ixNrevwDnos1uyRHMucXcEba5RbwppsI
         W64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDfaDBQwdj1r2Yr+BxzE8VnBhjB9D9cT/n8UjW/MV9w=;
        b=OosEuh/v0ZQoeu75wF8gDRqDLqcaCmapv4TPfM0rLJzQ3r7UqgxCb8vDOOq8r1tFcs
         nzLnnZc87N1B5MJK0hLJlBia1BfIYX75kHdEAgHT8eoxv3s4wG9LnBMMU4UzWYUTIqQz
         Vv4kGHumUl9aeWYxjQWyYzabWxBqoFfc+dJqnWuhNBjKpDX0jUxAQctfmNCnAkyt/Vf8
         djsOKCde5KmXIhWfAO4fCXODOH10VuHR7M2uTHJT2GEfONEnk8Jm5XvP/hJ0eFR3P1EG
         hfWcZaCj4VSESIHCSBn/VUdK/ZVC1DD8Db8brzUxEyFTVwWBHRWBK948zXkoD5IB1TuQ
         CMig==
X-Gm-Message-State: AOAM533JV2a1zQkANQrd3TJVYCz6DMlAmhE3NM5M8X0lFF5kaI0ZB72W
        UM8kks2Nhz92jNe6G7bM7m0=
X-Google-Smtp-Source: ABdhPJx8W9IVThfrUrd7Xx6hNNF7z66eirAkmHc2Wj+kxARx+gdqj8Q/FPBWB9ZNkN68r0/vdTnkQA==
X-Received: by 2002:a50:eb8f:: with SMTP id y15mr6845942edr.115.1616115171947;
        Thu, 18 Mar 2021 17:52:51 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:52:51 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 4/9] drivers: thermal: tsens: Use init_common for msm8960
Date:   Fri, 19 Mar 2021 01:52:22 +0100
Message-Id: <20210319005228.1250-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005228.1250-1-ansuelsmth@gmail.com>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use init_common and drop custom init for msm8960.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens-8960.c | 52 +------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 3f4fc1ffe679..86585f439985 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -173,56 +173,6 @@ static void disable_8960(struct tsens_priv *priv)
 	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 }
 
-static int init_8960(struct tsens_priv *priv)
-{
-	int ret, i;
-	u32 reg_cntl;
-
-	priv->tm_map = dev_get_regmap(priv->dev, NULL);
-	if (!priv->tm_map)
-		return -ENODEV;
-
-	/*
-	 * The status registers for each sensor are discontiguous
-	 * because some SoCs have 5 sensors while others have more
-	 * but the control registers stay in the same place, i.e
-	 * directly after the first 5 status registers.
-	 */
-	for (i = 0; i < priv->num_sensors; i++) {
-		if (i >= 5)
-			priv->sensor[i].status = S0_STATUS_ADDR + 40;
-		priv->sensor[i].status += i * 4;
-	}
-
-	reg_cntl = SW_RST;
-	ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
-	if (ret)
-		return ret;
-
-	if (priv->num_sensors > 1) {
-		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
-		reg_cntl &= ~SW_RST;
-		ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
-					 CONFIG_MASK, CONFIG);
-	} else {
-		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
-		reg_cntl &= ~CONFIG_MASK_8660;
-		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
-	}
-
-	reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	reg_cntl |= EN;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
@@ -346,7 +296,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 };
 
 static const struct tsens_ops ops_8960 = {
-	.init		= init_8960,
+	.init		= init_common,
 	.calibrate	= calibrate_8960,
 	.get_temp	= get_temp_8960,
 	.enable		= enable_8960,
-- 
2.30.2

