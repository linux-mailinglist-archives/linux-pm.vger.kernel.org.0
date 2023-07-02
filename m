Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04650744ED8
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGBRnR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGBRmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:42:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A72E6C
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:42:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b69f216c73so53860071fa.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319771; x=1690911771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ca1lCqRiuB+dn4eD6wRvmXrlOFXjwi+eXsVfOaPlfrY=;
        b=DPMhhKcZnrCduJPLNWHXheMbw7Qk2BfD0Mvx5n4qijgodlZFH85ezf1bROG6mH1wtf
         +JHLyWt3bKfN+I7tNR8bXCzAbileB0OoYtqC7BsDb1oPlHfW3gcgu5v0PajvfQEtsBRG
         P7NnagoCNXmvYRlmgXowc+V2hu6Rt3pGyHxWljqrziuxfv5IHsQQRC1I+onZVN2/FXyk
         vcmLLmoQ849XjqvLKfLF6JR7GGeltkEGJTEg8wub3V3BDy+zcVUdkIbfDjsPDEpaIgBb
         YuX6P/kIz5SpXfqvJev+KJMZ8SmPnyqhufhHb52gVA+gfCkJ2OqQmMKYLKUuUqI0y8DO
         G9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319771; x=1690911771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ca1lCqRiuB+dn4eD6wRvmXrlOFXjwi+eXsVfOaPlfrY=;
        b=MP13X5GShlq1Vl8mgyZRYgonSBnzWE0ehH6d03KG56iBLi4lf5BmBVBVh8U2IRyDy2
         47YyZqaUmeeYoYSsT7zcsi9l/03D/eAT97JLCvQYwk6QPATWMaKJi7FuoDWbnBITxxu2
         O3GnnzRrze4r0LZYf7HPPWwLOqVY20BRkFdOqhx2FXssDoKE9x5KqyAQffrxEianNVZE
         /W5SQ5THoV5WIzFhuRMwVf9iagCARwUAZMVqZRJ372oi8Mgl9WgNLMyCZiaiqI3lY0GP
         MpK1TT9dam4QA/iYN23FnNNlQKNIjXxv8qRJO4/OlP/8PAhRCFcWG6HCL6jP7ZL/1fTU
         8liQ==
X-Gm-Message-State: ABy/qLbhTCsnrol1Y/dPoA6AYYNheOxIf5xW9wtCS6SuFtKPlN7HDVl+
        y58LA6vH18MPEzExurURFDYT+g==
X-Google-Smtp-Source: APBJJlGPpV/Nu2PasXCj/Q9XCsLgZPwbLMR/bJ2WY4I57bygugelB6693qEcO8IQs5TtREEuiX7Kow==
X-Received: by 2002:a2e:9d03:0:b0:2b6:e623:7b57 with SMTP id t3-20020a2e9d03000000b002b6e6237b57mr897118lji.25.1688319770837;
        Sun, 02 Jul 2023 10:42:50 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:42:50 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/28] dt-bindings: soc: qcom: qcom,saw2: define optional regulator node
Date:   Sun,  2 Jul 2023 20:42:21 +0300
Message-Id: <20230702174246.121656-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The SAW2 device can optionally provide a voltage regulator supplying the
CPU core, cluster or L2 cache. Change the boolean 'regulator' property
into a proper regulator description. This breaks schema compatibility
for the sake of properly describing the regulator.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,saw2.yaml   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
index 84b3f01d590c..a2d871ba8c45 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,saw2.yaml
@@ -47,7 +47,7 @@ properties:
     minItems: 1
 
   regulator:
-    type: boolean
+    $ref: /schemas/regulator/regulator.yaml#
     description: Indicates that this SPM device acts as a regulator device
       device for the core (CPU or Cache) the SPM is attached to.
 
@@ -96,4 +96,17 @@ examples:
         reg = <0x17912000 0x1000>;
     };
 
+  - |
+    /*
+     * Example 3: SAW2 with the bundled regulator definition.
+     */
+    power-manager@2089000 {
+        compatible = "qcom,apq8064-saw2-v1.1-cpu", "qcom,saw2";
+        reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
+
+        regulator {
+            regulator-min-microvolt = <850000>;
+            regulator-max-microvolt = <1300000>;
+        };
+    };
 ...
-- 
2.39.2

