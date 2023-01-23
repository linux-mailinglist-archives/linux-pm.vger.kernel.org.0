Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61733677411
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjAWCbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Jan 2023 21:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjAWCbg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2023 21:31:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EF216338
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 18:31:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk16so9463182wrb.11
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 18:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6Z6SxNt59v/q1tzc92V2WGdngE9GnNNYwlh4MmijG0=;
        b=zuPWTtTO696nI6DcIOBy7rM+IxBFf8mrAJijmP7r+YiiB6Q3ar94HbnTh18nabxywW
         7TDx+sHX3hijMz9brH3yWS6OZVEeY7k5BVtqhVKANYBG3bnB/Whdvi+e5NeI8M8yXgRB
         7ooWyjIn9UgoAxsTl/2a5o0+PK0Y5uqRUp8wpbvsUdY3eOKg3sUWJXaGuOkoGxNafOd4
         bR5GEFFr+y/FQX9GU5r/N7UBO8nzgQXb9STZJ2MakTPF/elaHtr3C13FI+XTgbJpwbEy
         DCBMtrbJGy1BxQJ+b4hAUjeigTYNY/JJ82AEE6w+jjpXtf1CXdCKfROsVIL6ibU92Tex
         HkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6Z6SxNt59v/q1tzc92V2WGdngE9GnNNYwlh4MmijG0=;
        b=1RKdmAGiN+w2F2NefwuuMMRaJ4adXuUOz4tt7ev6ag74F96cU1rwd//vZ9utgGLgkv
         bBExycIeh5Vf6rtU7QXVqqU2QNqgsflMyVExnQkjiUdzimyeC5ftKt0U0a9yPEd0QyoM
         tnztaiSNZ1WXRyUkCYPsGOtfbK0h9cGhc/spcyXavj5xjj5TAZZMQMxhbsYSJBMkEi1M
         0Utn+bIef2U3FsYRa4OT9hAhA5beoZssCl4GmDP6v/Q95DsSA5TFasgqtfzq8Ou6tMxV
         EJ78bJS+GGGJE4QVVp4JIIupI3T0dXE316xO43bBlAt4GVBLtVVs0UR7g7vF0LvwrLLm
         pByg==
X-Gm-Message-State: AFqh2krJl75FkZyJkkVIHCuK9lZF3rWV5DWVhj4FnDzLpvNyCsX74dz0
        sjXCIT77senFgSyqiKJC/YfZnA==
X-Google-Smtp-Source: AMrXdXtnxzOlNJdhIR4KFNck/ZCdyo2ciJwXZ1fblEy1e3WPtItsYM83pvm1NXCTQEnLNziobcZ5Wg==
X-Received: by 2002:a5d:6d4a:0:b0:27a:d81:1137 with SMTP id k10-20020a5d6d4a000000b0027a0d811137mr14246396wri.38.1674441092561;
        Sun, 22 Jan 2023 18:31:32 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm18672703wrp.58.2023.01.22.18.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 18:31:32 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/6] dt-bindings: interconnect: Exclude all non msm8939 from snoc-mm
Date:   Mon, 23 Jan 2023 02:31:23 +0000
Message-Id: <20230123023127.1186619-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

New properties should be defined before the allOf. Move the
patternProperties definition to before the additionalProperties: false in
this file.

Exclude all non msm8939 compats from containing a matching
patternProperties.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/interconnect/qcom,rpm.yaml       | 73 +++++++++++--------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
index 5e6be4e79201e..d9d243c5514b5 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
@@ -62,6 +62,37 @@ properties:
   power-domains:
     maxItems: 1
 
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9]+$':
+    type: object
+    description:
+      snoc-mm is a child of snoc, sharing snoc's register address space.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,msm8939-snoc-mm
+
+      '#interconnect-cells':
+        const: 1
+
+      clock-names:
+        items:
+          - const: bus
+          - const: bus_a
+
+      clocks:
+        items:
+          - description: Bus Clock
+          - description: Bus A Clock
+
+    required:
+      - compatible
+      - '#interconnect-cells'
+      - clock-names
+      - clocks
+
 required:
   - compatible
   - reg
@@ -108,37 +139,6 @@ allOf:
             - description: Bus Clock
             - description: Bus A Clock
 
-      # Child node's properties
-      patternProperties:
-        '^interconnect-[a-z0-9]+$':
-          type: object
-          description:
-            snoc-mm is a child of snoc, sharing snoc's register address space.
-
-          properties:
-            compatible:
-              enum:
-                - qcom,msm8939-snoc-mm
-
-            '#interconnect-cells':
-              const: 1
-
-            clock-names:
-              items:
-                - const: bus
-                - const: bus_a
-
-            clocks:
-              items:
-                - description: Bus Clock
-                - description: Bus A Clock
-
-          required:
-            - compatible
-            - '#interconnect-cells'
-            - clock-names
-            - clocks
-
   - if:
       properties:
         compatible:
@@ -237,6 +237,17 @@ allOf:
             - description: Aggregate2 USB3 AXI Clock.
             - description: Config NoC USB2 AXI Clock.
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,msm8939-snoc
+    then:
+      patternProperties:
+        '^interconnect-[a-z0-9]+$': false
+
 examples:
   - |
       #include <dt-bindings/clock/qcom,rpmcc.h>
-- 
2.38.1

