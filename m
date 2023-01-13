Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E494669216
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 10:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjAMJB1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 04:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjAMJBP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 04:01:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7946086E
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 01:01:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vm8so50753872ejc.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 01:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14vWSUq8m0YB7K6+daykZcIVaA+luIuXLh3y27wDsWg=;
        b=bR2S7FuChvapbV2SSHw5GKXtn/l3a/gzcDyOBMAB4i/vnG0xHLw9sukVToJB4Lb+s5
         oGwlaUBgZl5433qp2rS02Fb8ddVxcxN5PLsDUG2LPUqw/L0cPbOVkGT1I9q74Jl+TzZ3
         p6Bhr4IGA+1NCUx52jxdBrcvPAH45TNeqcsH8620I7fF919Gw+Sah8QOHYL3hl4pg/9M
         UzoGRx70jgRYyhUg07tmt4gcmWmUcxXGGP+VqgO9oSYkflBV+tmxT/DUvJBZ/yyepUyH
         w7c/TETrHJigi+N5bIv3nPr1FocbznUgCUqUG4SZlSzPJ7O3VvC0ZNVW1IOWfT4uOdxh
         pG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14vWSUq8m0YB7K6+daykZcIVaA+luIuXLh3y27wDsWg=;
        b=mlsYHkB0ROYkPIhcQmioFmFm0PeME7/UJI8HFyAyTBGVhZgAKWrHhEImVT0U3aiqSo
         RKTwgt7J9a5Gg8kN7DO2zPtthOKJGP2hRbzvoxux0L3h6SM9n+xzDktKzkiXRs4RjDzo
         BthuPUCTbT7hHTwAAhIOgsBgr5BTeQ8SezCAagkzqK1TZTGiKGv3rwYLSUJM7soDfBob
         GUtICexnaj50BXVF/M/ieGzbQ5d16GUoYJElfAXQY4ogu0Ri04HB4UWZA4QhIDJyhteo
         aFpwny0HN7iSO533QdyNqw9+adnCIxiZqmaZY6CB4LAXVXcwzPmkCgVzv14f3ffand+M
         3F1g==
X-Gm-Message-State: AFqh2koYrbBLHJnXwgSwNF8trSJoFU5ZkoGhTid0274XkUDWpcq1rI9s
        R/N6ZwDdEOVUdX4yGHTMy6ywjw==
X-Google-Smtp-Source: AMrXdXuuNz3tvAd/ti33PZCvEok0i2r4nLgU2YcUyg8cns1TjEUS1Udl3Y8gFbByBGqo6fV5bBj07g==
X-Received: by 2002:a17:907:d48a:b0:7c0:971e:f6c5 with SMTP id vj10-20020a170907d48a00b007c0971ef6c5mr72138862ejc.14.1673600473231;
        Fri, 13 Jan 2023 01:01:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0082ddfb47d06sm8393331ejh.148.2023.01.13.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:01:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH] dt-bindings: thermal: qcom-spmi-adc-tm5: add qcom,adc-tm7
Date:   Fri, 13 Jan 2023 10:01:07 +0100
Message-Id: <20230113090107.18498-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The qcom,adc-tm7 compatible is already used in PMK8350 so add it to the
Qualcomm PMIC Thermal Monitoring ADC.  Based on downstream sources, the
new compatible for TM7 differs from older TM5 by allowing configuring
per sensor decimation, time measurement and number of sample averaging -
unlike one configuration per entire device.  This was not reflected in
the bindings, therefore comment the new compatible as incomplete as it
might change and its ABI is no stable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Resending because it is waiting for half a year.



 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index d20569b9b763..52ec18cf1eda 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -13,6 +13,7 @@ properties:
     enum:
       - qcom,spmi-adc-tm5
       - qcom,spmi-adc-tm5-gen2
+      - qcom,adc-tm7 # Incomplete / subject to change
 
   reg:
     maxItems: 1
-- 
2.34.1

