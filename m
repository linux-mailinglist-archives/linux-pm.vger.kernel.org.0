Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276E4F5648
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 08:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiDFFii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 01:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579407AbiDFEQg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 00:16:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8D2B4A69
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 17:26:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so1255568lfa.12
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhtdAyfV1krIwAG7X02HHXOhQylPf2Ui3KgfDhnX9YE=;
        b=CFcKRx8zjMfHkvfqxMH7Lx2oDqvzmEIMDONQMqZEcz0reIlU5bhqElJIyYqv/9uNLH
         7N1g+h562p4Q6xaKLgTca6/ieQz0etL8JUX9DJGyM5C0+KBUmPXX1IBUwL8MnwsC9RrH
         vrIbIukOBBzC+c14tLx8edKBiIVIK33USBuXIVCSszm3VJ/ks8OpU47OQaVKxENHeQWm
         kaPhl2v4DUNIzQ3VIa3Gtxm48PhhQV1iDPY7GoiIPbUM3jc4takTI0x6XfJVbezlWxi1
         yGQn5Zb3eTtcNW5VRspGry1Hqn0XN0aHcgo2g+noVvGgczOo1fH+OIDt2uxCFioV0nDz
         dNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhtdAyfV1krIwAG7X02HHXOhQylPf2Ui3KgfDhnX9YE=;
        b=B9IJlN3AmLyGzSyWFRC8iyNfGy8m93UYwCru7n7klNQnPs+u1cFO+WfmkBGxNhMCoe
         nu8Fyw5K4l2cizw8qXquov3SPrwRm6bwXvwOEg5sUC7wyP8sVEc7ttZRwfM6RICWZ5ZJ
         C7vLEYkLnvt2uEPpU4cAcsBZPto44bokfo2NjIvzr/9RvYG+/226zCycu1BPqOYTxwrf
         hZ6xAeWOjVtyGVjRX4Gl9Ly8Z9nPdhJf6awaR0scF9pc6l0Buy3Wgwg4KAeCGtWz8oL4
         iZfowHop22kQIa29CfUGEXNi+owkyEnPpyZefLGhk6pTLmEe5qTsdXyhfeVS6mg5euc+
         aJBA==
X-Gm-Message-State: AOAM5324vKe/o18/A+Mo1aaunrW3InrEdtEU5bf6NSpZ7Vko4c98YCkW
        882YgAj22zXyflwHN0LFLM188g==
X-Google-Smtp-Source: ABdhPJxC7NteBZ93rBkWZ9uUjKIuSKkb3n2GOkLHSmEeZ8acGDSxWD+8WDC4jzQGxX6MOgejL3W9SA==
X-Received: by 2002:a05:6512:3f1f:b0:44a:a85d:a0e0 with SMTP id y31-20020a0565123f1f00b0044aa85da0e0mr4226422lfa.170.1649204811325;
        Tue, 05 Apr 2022 17:26:51 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c21-20020a056512239500b0044aa21dadeasm1660270lfv.60.2022.04.05.17.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:26:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: thermal: qcom-tsens.yaml: add msm8960 compat string
Date:   Wed,  6 Apr 2022 03:26:45 +0300
Message-Id: <20220406002648.393486-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
References: <20220406002648.393486-1-dmitry.baryshkov@linaro.org>
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

Add compatibility string for the thermal sensors on MSM8960/APQ8064
platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b6406bcc683f..43510b8399ff 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -19,10 +19,11 @@ description: |
 properties:
   compatible:
     oneOf:
-      - description: msm9860 TSENS based
+      - description: msm8960 TSENS based
         items:
           - enum:
               - qcom,ipq8064-tsens
+              - qcom,msm8960-tsens
 
       - description: v0.1 of TSENS
         items:
@@ -116,6 +117,7 @@ allOf:
               - qcom,ipq8064-tsens
               - qcom,mdm9607-tsens
               - qcom,msm8916-tsens
+              - qcom,msm8960-tsens
               - qcom,msm8974-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens
-- 
2.35.1

