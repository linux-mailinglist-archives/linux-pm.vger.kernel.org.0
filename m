Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63456518FC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiLTCr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLTCr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:27 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E160E13D41
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:25 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so16668519lfk.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjTuXszLa3PpvcC6GObAES0NeWmHYF7aB2zTBhEiXEk=;
        b=ee42aMWfnHOOTkMbfGJpqmAkXFBhPOXz2Zi0utvhysgnT2JBKd3rXpiY9hpjkml9sw
         +CJfUfqxofaO0bXe7ARd8rTeAPr97702zSWyf8cBwWLhh2Ad+133/s1vONFGOvycQlgo
         l3cVeqAeZPEODJjPjpVybHwS/NK0Se5kDrvM9iL1UZVc9qUigBxoi9FSmoCq+I9cAeQ9
         /N1h864XE2k23dVqrJ1QIpqGm9rvkrI19c/b8SjknhZPi6GUvJFPrtLFxZg6D3vI3qOp
         eOGgot61ejWNOlcnXP1H471gwEpl0cR7d2qiuLjZgJW3+881d+yEoiGoke3TDKtDe460
         ZJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjTuXszLa3PpvcC6GObAES0NeWmHYF7aB2zTBhEiXEk=;
        b=gL8qU+wuW9B13XtMC9mLeYhZTQI85IuSrNKkLBXsnSR/xSzevSvl/z+AFMNttLlUYe
         rT7TZV7LHy5IIrYAW+6um6jS7yAquBuX1+qV+sxAEP7nCXzj/B4gP1VLUwvpqYj4dUe8
         hPheLTsGMfbeNRQ6AIZ+iv4HAByqhpK7OSCko7Z55jk/8F+SNQGmihNgZRZ6CSH4oKco
         LkJ2DJRKsm2b+KsAgCpzOf0UiiX3ZsYk69szxdUr1rG199kCJObPWLcTyrsJ0NIRe2uz
         yQ2yJ+YYWhWVHQPDjIitiu9/0MDZFr8vkH+Rns+fpTzceCWgu4uWjrLRTiutpGBELlTq
         ynqQ==
X-Gm-Message-State: AFqh2krp3wBco4aSwM9EjZjXKa+7X/hMNWO6SlT8/v3yRhVr22KU9SgG
        4HSdiwU8GcqyvTkMDeC/t63JCJUHt2eTS2g0pqE/0w==
X-Google-Smtp-Source: AMrXdXsAi+pQ7ZLNoxrVYL8ynWSDhmBf3tJWDRCPoJx/S8lpqFdXCbEbKrmzegbNxcSS27ZQt5xzxg==
X-Received: by 2002:a19:2d59:0:b0:4b5:1414:415f with SMTP id t25-20020a192d59000000b004b51414415fmr147928lft.59.1671504444223;
        Mon, 19 Dec 2022 18:47:24 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:23 -0800 (PST)
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
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 02/15] dt-bindings: thermal: tsens: support per-sensor calibration cells
Date:   Tue, 20 Dec 2022 04:47:08 +0200
Message-Id: <20221220024721.947147-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
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

