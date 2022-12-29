Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383DF6588D7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Dec 2022 04:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiL2DBV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Dec 2022 22:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiL2DBO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2022 22:01:14 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC5812635
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:11 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id j17so16405796lfr.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2022 19:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypbo/EG+CCbOPVP6v32WJ2aGuI/TH4SxJj9NvxF05hE=;
        b=B7toiSH+czOIPebZ+y7EP1/eyVNv2nQhI9o6Qm2kkMiRMzUMAcHuyRtAfXZjwe9goB
         bNJ/Y+uu/GhPMAbwPiOw3KNF4d6ZXbVH4L3okSoNhCD6J6gAlopAHVrPEYbleVrX+AZv
         rpRqLKnOBy88qoEIY/vGHNVrBFal1YSO+ue8HAPTNosJBdkGyte0jO3cQ8iOQ+qRqqo/
         +oNDCWIkgKa2rKsGazYhTAI0G+53DpEA8FhgYpMkxquWwAK0mRB7IyeLkfZsKz8safwQ
         8UyYgKbYoy7gkr69HqEHfjaQsLCxLYz+y18f+cz4ZJ7YkW07CMoyQa8SSOjxuSA/V1TD
         TbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypbo/EG+CCbOPVP6v32WJ2aGuI/TH4SxJj9NvxF05hE=;
        b=NYxJaDkK970NY/502/MwJeHFb2V2ujkykwBVfo3uPqYXKPxw617VR5HJhVtTOaM9AH
         XldBx/32pZmpjbWKpDiSJjQM1XVGwi+81gezDDMh8oQ9Uazk6y/eoOBgska/JqS7jrcL
         bKSoblll81OllqmP14UUrel/ryQ/0b3+WpA/EAonXI/6ZTI0HqU/D0f2zFI2JYGmeLMV
         Cx1jPKKHN+SMpgn0pzOTxFKKV6kt4mKtkiofHdVbQfIVRD6PtIF3vYzHTCoHalCdl5oq
         5FaB2R6cnYuy25r8JqBcYAhykdWbdgFi1oX/LOBO+2Y+GnMpJhj1V47rwBpP28PU0PTe
         RNig==
X-Gm-Message-State: AFqh2krIgspNy8++lopY7M2fRn4jeWET+Ty0kDb84+5Z6z2rwW0sFaUy
        UsCg5DOY8BeD+NtEEu+xMKIprg==
X-Google-Smtp-Source: AMrXdXvz7biNYmlWPb422q4PVD/IwnI+0dxWcsMzxs9Tqcz1M7Nh9ff3u/uJ/eY2mgIe9M+lC+JxyA==
X-Received: by 2002:a05:6512:4014:b0:4b6:f22c:8001 with SMTP id br20-20020a056512401400b004b6f22c8001mr12740347lfb.56.1672282870179;
        Wed, 28 Dec 2022 19:01:10 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b004b57277474esm2883070lfo.106.2022.12.28.19.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:01:09 -0800 (PST)
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
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 03/20] dt-bindings: thermal: tsens: add per-sensor cells for msm8974
Date:   Thu, 29 Dec 2022 05:00:49 +0200
Message-Id: <20221229030106.3303205-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
References: <20221229030106.3303205-1-dmitry.baryshkov@linaro.org>
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

The msm8974 platform uses two sets of calibration data, add a special
case to handle both of them.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 4bb689f4602d..5543df93f752 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -91,6 +91,11 @@ properties:
         description: |
           Reference to nvmem cells for the calibration mode, two calibration
           bases and two cells per each sensor
+        # special case for msm8974 / apq8084
+      - maxItems: 51
+        description: |
+          Reference to nvmem cells for the calibration mode, two calibration
+          bases and two cells per each sensor, main and backup copies, plus use_backup cell
 
   nvmem-cell-names:
     oneOf:
@@ -138,6 +143,59 @@ properties:
             - s14_p2
             - s15_p1
             - s15_p2
+        # special case for msm8974 / apq8084
+      - items:
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
+          - const: use_backup
+          - const: mode_backup
+          - const: base1_backup
+          - const: base2_backup
+          - const: s0_p1_backup
+          - const: s0_p2_backup
+          - const: s1_p1_backup
+          - const: s1_p2_backup
+          - const: s2_p1_backup
+          - const: s2_p2_backup
+          - const: s3_p1_backup
+          - const: s3_p2_backup
+          - const: s4_p1_backup
+          - const: s4_p2_backup
+          - const: s5_p1_backup
+          - const: s5_p2_backup
+          - const: s6_p1_backup
+          - const: s6_p2_backup
+          - const: s7_p1_backup
+          - const: s7_p2_backup
+          - const: s8_p1_backup
+          - const: s8_p2_backup
+          - const: s9_p1_backup
+          - const: s9_p2_backup
+          - const: s10_p1_backup
+          - const: s10_p2_backup
 
   "#qcom,sensors":
     description:
-- 
2.39.0

