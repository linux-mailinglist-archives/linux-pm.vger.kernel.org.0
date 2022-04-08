Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5240C4F9FBF
	for <lists+linux-pm@lfdr.de>; Sat,  9 Apr 2022 00:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiDHWuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiDHWuX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 18:50:23 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703F8E3394
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 15:48:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id b188so10261781oia.13
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2022 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6IvRUnp3o4+L39LVGXulx8aoh2j7iEyNQukDOsUs5E=;
        b=ZtUtLpB4VxJiVAWssifXbZbYwsIRAopp47nwktbjPJUBmJs/TuMWLJepqhLaWuf3oK
         fEtt6RCZVFKt5h9vWfdDFWJQlXdvZQekcIQLLnor/W43N8vP67sYEHzyoAmaBLb85zWB
         6bhT2Eg0vSb9OP+Pg+BCoLHyBjIIGHnt8V6Ddh6GlrN1/TrQ7OgKKW+LlRmZ5QFBxrYp
         KvY68W6HXZMuzESgXKjuaASeMfFKGsDbkkq+Ey7ZwfZsoiEgUUGtwLos0XbGNnO8nff9
         VVT4KKmH6DMNasJabVXYY9euQPXwZU4KtjbAtBrsHz2spsuYFoL2vaVG2dXws98vnXg0
         Ddag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6IvRUnp3o4+L39LVGXulx8aoh2j7iEyNQukDOsUs5E=;
        b=zXgwhO7wsZir8aYaZR/eEY9N0+6uK4/a4w4YfUDbnG4kJPDRVakfC+td4n7xcT/wDd
         5npLbUjiZ1rgumgB8HgWSdbpvfLgEGDJGxmZkZgvUaAkvwbdUe6rrN0mPWLiDAWrmcBM
         a33v8P3hQwGe1WXYhwSBbGA+bXNq/1F/AwgEc26CY5EFDF+pBDrkWUTIiPt15mkQRTqw
         KlucC8+pjnjLNvq5/KJSrtA8t8d5OUU7oX8bbwlEDfXwOJXD+s2Hix837nwW6roMhLZJ
         tzl21YwS+3UObioE42LWFkkyP7GSQc0UmXpvR/xjv+Iwx7OnI+qcDzpKP1E5AATo+3qO
         FRxg==
X-Gm-Message-State: AOAM531g8TMCpPHcNIHfWDWJ2IwCWBwFoNLeSn/V/lQeRQMgqFajqegt
        2qVUzU8Oqg/RhPb2z9lxZVm746E8jyO3IAf4
X-Google-Smtp-Source: ABdhPJxHhaai30aG1N9gFqyLv4OH8ZkEt+JMJx8PzvkSsQVRq1uKPDv3zyDue9xHeyWfANXvVjrFXw==
X-Received: by 2002:a05:6808:1303:b0:2d9:d72c:dfef with SMTP id y3-20020a056808130300b002d9d72cdfefmr939161oiv.29.1649458097816;
        Fri, 08 Apr 2022 15:48:17 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 64-20020aca0643000000b002f9b8a6ca98sm1920175oig.4.2022.04.08.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 15:48:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: tsens: Add sc8280xp compatible
Date:   Fri,  8 Apr 2022 15:50:37 -0700
Message-Id: <20220408225037.627432-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Qualcomm SC8280XP platform has three instances of the tsens block, add a
compatible for these instances.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b6406bcc683f..8ba8a3e14acc 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -49,6 +49,7 @@ properties:
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
               - qcom,sc8180x-tsens
+              - qcom,sc8180xp-tsens
               - qcom,sdm630-tsens
               - qcom,sdm845-tsens
               - qcom,sm8150-tsens
-- 
2.35.1

