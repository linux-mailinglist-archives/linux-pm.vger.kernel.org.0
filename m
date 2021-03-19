Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0735F3411C6
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhCSAxH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhCSAwt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:52:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5463C06174A;
        Thu, 18 Mar 2021 17:52:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id l18so655931edc.9;
        Thu, 18 Mar 2021 17:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBoIInb/cFrB8GkTWJ/fkeyLJF+HUm2hVs09Cz8kxE4=;
        b=EK1UhSHsFArWHjfAp+AgqOkgyYE6OtzYhj1VfMAUZMx0YOPHID6+bOlNP2n/diXOpY
         Cs0WWBEqixjUHRH1iRueN+hApJHl0cMipwVAQBKj2RLeXrOA+b4H1vEMmmNVX3SeykFT
         4E+FWJAweMLKc7v3oploca+/domRhO+Cn0mC9x2GTW5zywDqz6Wrtgae1WguB69R7h54
         Uz9sW7J4Do+4hsTtopwfFTGGXnfwJg4tOljMLMOj66iJl3uwC0M6iudq5pN4dD98f2mg
         OAPz6iYb2DCwrMAXmPzaXdkObHrudWcsVGui2AdP/XsxHOrjCh16dOTH2Ap/91yCtcbC
         jzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBoIInb/cFrB8GkTWJ/fkeyLJF+HUm2hVs09Cz8kxE4=;
        b=F/Unyi0ysTJ+MEtCo9qNDy3IlUroDo6UH3YAFRheCd8x/lf+DKVBeYRhvt4Wb/KUff
         7VpLPXdvMopvbF3KST3cs4rV77baJI6oUdxAqgV8EeBFNd6AHS03bAJSNt2il/7Li+ht
         cOxOE+U0rfnN2e9YGKq5zWKKYv39Q40xhdymYtQo7z/XsF3mHKB6kJqQOBxU8PxrD4BN
         6xP/XQCuLX3GuWLnVkCFeyuSa6u3uKlk8uSDR61ySHzPgIvaW0ym6rbpA5nj6wG6UBhQ
         zIBAN/x6XtsIAPz7PceOEsumMGWP82bxKueblHdhkBTKpTVU7Jq97mhjIDZufY9ZBno5
         D9Hg==
X-Gm-Message-State: AOAM531kaHyoyDHluck+I7VnKTF9uzi8kQMB6SQS1Aq8Pz9B4CqpadnN
        AttTsV/aFTmGJUNzBn2u1Dw=
X-Google-Smtp-Source: ABdhPJyurCARFEI8RocKMYxvZUJ3Fa6nJ6OBbclfT95CcGlrpmd8R3yFvlXeZDAZegGn2lQKhHuWyA==
X-Received: by 2002:aa7:c14a:: with SMTP id r10mr6593968edp.132.1616115167397;
        Thu, 18 Mar 2021 17:52:47 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:52:47 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/9] drivers: thermal: tsens: Don't hardcode sensor slope
Date:   Fri, 19 Mar 2021 01:52:20 +0100
Message-Id: <20210319005228.1250-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005228.1250-1-ansuelsmth@gmail.com>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function compute_intercept_slope hardcode the sensor slope to
SLOPE_DEFAULT. Change this and use the default value only if a slope is
not defined. This is needed for tsens VER_0 that has a hardcoded slope
table.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 277d9b17e949..44bce16217db 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -86,7 +86,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
 			__func__, i, p1[i], p2[i]);
 
-		priv->sensor[i].slope = SLOPE_DEFAULT;
+		if (!priv->sensor[i].slope)
+			priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
-- 
2.30.2

