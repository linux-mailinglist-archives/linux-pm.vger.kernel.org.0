Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90865AB3E
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 20:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjAATkm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 14:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAATkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 14:40:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696551009
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 11:40:40 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g13so38867388lfv.7
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 11:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cCBsdaQnItdcF1eF5FaXm6HTYRvUTHP0RJaLQV670A=;
        b=o5gERM3nw7SorNGSbRnxR+v42iBjDaZp0VOJ2XGgokGNEZ+EvQR1qt0KGxyfb6z3wq
         00ZNJfyd7Ar8Elq5CBV1GWDg2/AqlhIzK/zzjWy7aI4pHlOW4YGX/Whk/OnKe2hPPfGO
         pYkCGF524p4ADXJ02TlO/s2LqTUa9m3NXv1SeFPHGaOWLFknSKEOtbAX8WZD1IzhqXu+
         6reZON7s7DOuLbnEdQSKDFCiO2mixhdJjVEHu6hR6R8sGk/jItY6rWTyyuVF0+wqcXsx
         hFpskVVczXmWYZcXo5Lg8rUUMJE5kZbfFLIU8BJPxdtUBRWVe26+MBOrAof7qLAotEF/
         piAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cCBsdaQnItdcF1eF5FaXm6HTYRvUTHP0RJaLQV670A=;
        b=0x6VAqminU61eMTZzJvZwk6263bjMpGKlQu51OYF5tx00IjI9Y/uw5o4Qq+Ai49vOf
         Lq0RQMoZXaF0pTpnu0fVUKEIvFDXoKpjJriQ53kCYIRFWGr50R0mpWGZIM27tz9H5nO7
         NInYyKXf1VnSPEsNdfUmdPjHHpPZH2/ZYYETKD6M+TiyICqMkzI8zgReX1ZFeaLbHjd0
         v27fPABEAwtvI4RxNVjz/jS3YVHcCB/WZNATy8DG5jp2iULYtK7Ju7EUIrWciDEeHhPB
         21OAu3LAvQ5Sbtd7pS408eeEaaWN/pcOgpW3E4Oqbg1XEx+0A3EEVWnQMe+nMP8NULcp
         pw6g==
X-Gm-Message-State: AFqh2kpJN9eQfiRKuUgKeikOmalJqxlul/1pdgzncAyXkNb8GihIDrcw
        I0WsWegFK5WyvVyCLaRp/QMqYQ==
X-Google-Smtp-Source: AMrXdXu/bQlPvcaw02bOWbyihyi4sh0Cdutt8E0cBhQy8zsaitfMVCiujOmY+9yiUARhZPb2qQiJvg==
X-Received: by 2002:ac2:50d9:0:b0:4cb:2c19:ec21 with SMTP id h25-20020ac250d9000000b004cb2c19ec21mr2010640lfm.0.1672602038819;
        Sun, 01 Jan 2023 11:40:38 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w11-20020a056512098b00b004a100c21eaesm4228013lft.97.2023.01.01.11.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:40:38 -0800 (PST)
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
Subject: [PATCH v6 03/20] dt-bindings: thermal: tsens: add per-sensor cells for msm8974
Date:   Sun,  1 Jan 2023 21:40:17 +0200
Message-Id: <20230101194034.831222-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
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
index 878e1d1bf6c5..926e9c51c93c 100644
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
@@ -137,6 +142,59 @@ properties:
           - pattern: '^s[0-9]+_p2$'
           - pattern: '^s[0-9]+_p1$'
           - pattern: '^s[0-9]+_p2$'
+        # special case for msm8974 / apq8084
+      - items:
+          - const: mode
+          - const: base1
+          - const: base2
+          - const: use_backup
+          - const: mode_backup
+          - const: base1_backup
+          - const: base2_backup
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

