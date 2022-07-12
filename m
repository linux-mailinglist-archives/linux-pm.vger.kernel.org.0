Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B80570FDC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 04:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiGLCAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jul 2022 22:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGLCAQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 22:00:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C9823BD
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 19:00:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m14so5992752plg.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=F7+XFiMayv44DZU1u90VfmYwY2lDY3XtWAg/SoBU2WdqVyiRqfO/MK4aaA1a+GI0/i
         AmRAGXmSTTBOoK9G68DhJMLf2LH5i2ZPgg1ZcJ9l8O4zoXXwlMax7YFxoVpAqECf7KPu
         5J2urz5HU8UqQUxKjcTQFiQG0j2/LprbKR1q0RTjYV1KSsRgWb+yEq6q+YNyh9ji2xkM
         1gJQ76pT7pxMceQVrA2rBj8S/IJ9brmRVEAmTBgF73GRbqqZF0GgSMEmXMu139/kcVLv
         3ngBg477iXfEe8EnSzzjpGr9+wJ4EK/tqJNFH6sfIM1ZsWtqj9RjLiUxhCns9W6b8XQ3
         6G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=6VBTPQAPfFkcZe4Uqb2Xh1vnmz17On1kd5RpGACuOEfdgedcnirCdniyObeCVQ8Q9S
         9hua2tpuDaBd/PqSNg+HEDYIrX3f6qlxB65dkGsX9taXj6WqS8bl0nDRTNKy+nFWTNtq
         XBCRWCe14TDfepXEMJQ7v2Fs7BxI0tuvVJGAmSOKdxM3LpvS2frEIWE38nJg0/mY3A62
         P/1Vs4mVmyww6YdxrEX7ewqKtXi26jeRy7lqT+Lb7+FettTjws2uy3QQ1jsY4e9A5594
         PV93f+MoriLRBmd+22X7UuScPUYl4fcUGKicyC4VvTZFpQZY9fZkR/vmuOYQ57hfK8gD
         0VgQ==
X-Gm-Message-State: AJIora+BZwtelGbLVyHaqCOXvdYDpXeqEjjzdMQCV9DceospIw3RG2RC
        xxjb9ZMZPkY2dEqMAw/tDtp1mw==
X-Google-Smtp-Source: AGRyM1uVTipl6JQXD+xSwYRPGggDqLZ8DuA4ILpqrtlHnYeSwS/6TqN+dBNg+DMSiNiVAunngq9YZw==
X-Received: by 2002:a17:903:1210:b0:168:dc70:e9d8 with SMTP id l16-20020a170903121000b00168dc70e9d8mr21845995plh.92.1657591209040;
        Mon, 11 Jul 2022 19:00:09 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a6b4500b001ef76dbae28sm5425821pjl.36.2022.07.11.19.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:00:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 3/5] interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
Date:   Tue, 12 Jul 2022 09:59:27 +0800
Message-Id: <20220712015929.2789881-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712015929.2789881-1-leo.yan@linaro.org>
References: <20220712015929.2789881-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit changes to use callback qcom_icc_xlate_extended().  This
is a preparation for population path tags from the interconnect DT
binding, it doesn't introduce functionality change for the existed DT
binding without path tags.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 7e8bcbb2f5db..8c9d5cc7276c 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include "smd-rpm.h"
+#include "icc-common.h"
 #include "icc-rpm.h"
 
 /* QNOC QoS */
@@ -414,7 +415,7 @@ int qnoc_probe(struct platform_device *pdev)
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
 	provider->aggregate = icc_std_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	provider->data = data;
 
 	ret = icc_provider_add(provider);
-- 
2.25.1

