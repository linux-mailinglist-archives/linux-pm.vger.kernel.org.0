Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBB3F47FA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Aug 2021 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhHWJ5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Aug 2021 05:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhHWJ5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Aug 2021 05:57:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754BCC061760
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k24so16185325pgh.8
        for <linux-pm@vger.kernel.org>; Mon, 23 Aug 2021 02:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ZeBnnHmrDX1DWbaqOnNymOQXq0AvS6DifxDoxvu4dA=;
        b=zj2IfVFeA4lseTLPD9zBRySoSoX5hfnEX0Lj+QmtgxNrE/h/wVCU/4TPtQaYAjlmqW
         xKIDMM4fWQVTe8frhLuJMUudjJRAA3BZZJdSCmzxO8At1mrCZG1hAe9rPGJLaT9B2kz2
         gRVjQ5+rkWNl+GV77F+2QDtMr7q5QFjYAXny7AKLrb52x1ePzNHY1h6FCNCEPMjqVvtx
         l6TkxPMoTOQzLBCaznHv6scgmqwmvBnqxRVJ9ueWdLMfvRwJu2vQBKtzi9+X9oPVldlG
         oViIWO25QNCnxLFokeFgtmFlxCirxVAvpOIHmVUFnfyPmsEKqy/c4md3qSyzSk69vZ7j
         uc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ZeBnnHmrDX1DWbaqOnNymOQXq0AvS6DifxDoxvu4dA=;
        b=S8Rx6KL2k2IupKlsU2rLopYcqHNWQzkymuSaogmZ+fkx2JjkSowkz/Fqec/dmyqcNW
         jvxcZ1Skhpv/HOjIA8mrjsbZXwq3/MaNrWt68MZbSG4Z9TPj5B23fWhGh/v6y4hqIPX3
         gLGo6Yf2FuxQnZV/H3F7oFVHJ+OJVU3Iluh6e/PajIiIwNI+jSCZkPuhAZ5gZnwoCBzt
         GUxWJJKj+jkD3BfjbSmWP4JzCIzBf/fkQTdRbqyr40Q2ZU8uGdpOLlf00cSFtG3owWY9
         ULEyqGLQArzcM6tGs2KoVqZXvaV4/Lm7e43xXsbFap7dzt7GA3i/IilFmwrqwXtwlGe6
         HhIg==
X-Gm-Message-State: AOAM532GJoW9WZfIaTG1rmliIJtRFQQoSYQCDGLYv/1nFA1P8v+4AVHi
        HQ37NNA39FNbOOjxok84w5Sa0Q==
X-Google-Smtp-Source: ABdhPJy1v8GPKxg3BzAIJ9B4D4r7j9aBSOpmzmKZL95u2YJ23Q3i8Uzwc8ssO+Cul467MZaBCQ+NNQ==
X-Received: by 2002:a05:6a00:aca:b029:392:9c79:3a39 with SMTP id c10-20020a056a000acab02903929c793a39mr32914439pfl.57.1629712582014;
        Mon, 23 Aug 2021 02:56:22 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id z24sm18708230pjq.43.2021.08.23.02.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:56:21 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/3] dt-bindings: interconnect: sdm660: Add missing a2noc qos clocks
Date:   Mon, 23 Aug 2021 17:56:01 +0800
Message-Id: <20210823095603.5538-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823095603.5538-1-shawn.guo@linaro.org>
References: <20210823095603.5538-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It adds the missing a2noc clocks required for QoS registers programming
per downstream kernel[1].

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/interconnect/qcom,sdm660.yaml    | 41 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
index 29de7807df54..19bc3091ea40 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
@@ -72,6 +72,32 @@ allOf:
           contains:
             enum:
               - qcom,sdm660-a2noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus Clock.
+            - description: Bus A Clock.
+            - description: IPA Clock.
+            - description: UFS AXI Clock.
+            - description: Aggregate2 UFS AXI Clock.
+            - description: Aggregate2 USB3 AXI Clock.
+            - description: Config NoC USB2 AXI Clock.
+        clock-names:
+          items:
+            - const: bus
+            - const: bus_a
+            - const: ipa
+            - const: ufs_axi
+            - const: aggre2_ufs_axi
+            - const: aggre2_usb3_axi
+            - const: cfg_noc_usb2_axi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,sdm660-bimc
               - qcom,sdm660-cnoc
               - qcom,sdm660-gnoc
@@ -123,9 +149,20 @@ examples:
               compatible = "qcom,sdm660-a2noc";
               reg = <0x01704000 0xc100>;
               #interconnect-cells = <1>;
-              clock-names = "bus", "bus_a";
+              clock-names = "bus",
+                            "bus_a",
+                            "ipa",
+                            "ufs_axi",
+                            "aggre2_ufs_axi",
+                            "aggre2_usb3_axi",
+                            "cfg_noc_usb2_axi";
               clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-                       <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>;
+                       <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
+                       <&rpmcc RPM_SMD_IPA_CLK>,
+                       <&gcc GCC_UFS_AXI_CLK>,
+                       <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+                       <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+                       <&gcc GCC_CFG_NOC_USB2_AXI_CLK>;
       };
 
       mnoc: interconnect@1745000 {
-- 
2.17.1

