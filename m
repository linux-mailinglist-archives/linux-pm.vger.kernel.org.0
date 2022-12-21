Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E176D652B2A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 03:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiLUCF2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 21:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiLUCFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 21:05:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4F1FCDC
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f34so6161218lfv.10
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 18:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjTuXszLa3PpvcC6GObAES0NeWmHYF7aB2zTBhEiXEk=;
        b=kHY1rWgQvT3q1BXkZe6BfIfA66EHDVKvVf1mRcgeZn9BgHXLfWva6LX6dZF/v/OMcB
         kEyHm+rsWw45ZUIsPfwzvrUrUxkJmbhEM0B1H5hAozYUYDzlP27R0IZaTJCL63TTX7kr
         bzQsGygNgcbmxBO8++oQOQevdlTys5fabf9udD8DT5RSqNJrUX/q7mSG2AuuCB7n3aPZ
         yhnasyQDy0mxu1zhQLLh5NtF0soRd+IEnzFZr77TNTj2DRi/3RZ7pt9391Bj2ev72+VT
         ODt61FvEcS0Z2KCVSvg9RmRri3HsXe3azYE1ahvgV74EbN07GiQwiWwDyHC5JGmW0Iz1
         kCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjTuXszLa3PpvcC6GObAES0NeWmHYF7aB2zTBhEiXEk=;
        b=TDAALoxCzuovTbhpzgB5UvKr/EpnGXLo72SyGpx58Q/yipG8PwgdNfqXFe5Gwu84SW
         EArN0nNMTAYoy+9ygC1lmmpncmCvxgVb8isKU/Cy2DNRxvaFqdE9gRnWOTRJxUOOfW0k
         SGxmIHSfwPOCiZRmls/u+5RPmz5gFRvFs5VF7dyWDGvyh4gtwPrU8o4thVdqnISPS/Yv
         zC90U6U1I2kWbXQb7jucilC9VhZW0lvjbfx2ZjCdotz/1UU72NXxfCTHukmJHsnhPU4P
         SFAW0XLLI1mQxMM89PqVw9puKHG3Vwarl0uIQ9Wj93vliXfNWkUTs0Rn9A2Zru/0F7MG
         L+uA==
X-Gm-Message-State: AFqh2krsYaruFiwd3IDSQJ90mYHFu7QADiXjWVdfk8biCcopZawd8VG8
        Pdz8Z5VEISi2iDaIkdwG1EegZw==
X-Google-Smtp-Source: AMrXdXvmgjP300KGyPQq4HaUcs3TrwwMxxnY7uxBSzKdLnoSskCL4/KjkKEpX+AgAzkTnGp6KhZIKQ==
X-Received: by 2002:a05:6512:c04:b0:4ad:6f9b:d683 with SMTP id z4-20020a0565120c0400b004ad6f9bd683mr1773083lfu.1.1671588323106;
        Tue, 20 Dec 2022 18:05:23 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b004b257fef958sm1673048lfr.94.2022.12.20.18.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 18:05:22 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/20] dt-bindings: thermal: tsens: support per-sensor calibration cells
Date:   Wed, 21 Dec 2022 04:05:02 +0200
Message-Id: <20221221020520.1326964-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
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

Allow specifying the exact calibration mode and calibration data as nvmem
cells, rather than specifying just a single calibration data blob.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Amit Kucheria <amitk@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 64 ++++++++++++++++---
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f3660af0b3bf..da7b5bd4abd5 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -81,18 +81,62 @@ properties:
     maxItems: 2
 
   nvmem-cells:
-    minItems: 1
-    maxItems: 2
-    description:
-      Reference to an nvmem node for the calibration data
+    oneOf:
+      - minItems: 1
+        maxItems: 2
+        description:
+          Reference to an nvmem node for the calibration data
+      - minItems: 5
+        maxItems: 35
+        description: |
+          Reference to nvmem cells for the calibration mode, two calibration
+          bases and two cells per each sensor
 
   nvmem-cell-names:
-    minItems: 1
-    items:
-      - const: calib
-      - enum:
-          - calib_backup
-          - calib_sel
+    oneOf:
+      - minItems: 1
+        items:
+          - const: calib
+          - enum:
+              - calib_backup
+              - calib_sel
+      - minItems: 5
+        items:
+          - const: mode
+          - const: base1
+          - const: base2
+          - const: s0_p1
+          - const: s0_p2
+          - const: s1_p1
+          - const: s1_p2
+          - const: s2_p1
+          - const: s2_p2
+          - const: s3_p1
+          - const: s3_p2
+          - const: s4_p1
+          - const: s4_p2
+          - const: s5_p1
+          - const: s5_p2
+          - const: s6_p1
+          - const: s6_p2
+          - const: s7_p1
+          - const: s7_p2
+          - const: s8_p1
+          - const: s8_p2
+          - const: s9_p1
+          - const: s9_p2
+          - const: s10_p1
+          - const: s10_p2
+          - const: s11_p1
+          - const: s11_p2
+          - const: s12_p1
+          - const: s12_p2
+          - const: s13_p1
+          - const: s13_p2
+          - const: s14_p1
+          - const: s14_p2
+          - const: s15_p1
+          - const: s15_p2
 
   "#qcom,sensors":
     description:
-- 
2.35.1

