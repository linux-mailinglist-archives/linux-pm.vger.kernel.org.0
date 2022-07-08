Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1EE56B024
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 03:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbiGHBo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 21:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiGHBo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 21:44:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48829821
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 18:44:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so286983wms.5
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2022 18:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gg24pBkx9uxXH81vY9HTkL7j8WN9zHUs35lE66OFcP8=;
        b=u/REpx/iqr2PSY72P1Lkc6VLwh13iknvaEhtYOv243VQ9iV98yr0v58azAQssn1k4/
         yhEZTwWEvEBudD1y6YqwrkVzW0fFzrOScShiyEKDkPxN4+e/14rPyw3evJa1imriLefh
         M/wUsSLGJFaWNsqmTgsj9ytFYOyPJDf4PDabzPo4O8VoCmiuITzM7sjQRHFtCwbvPhLV
         Hi1lNWea4TffuqCnqdbHP5H8/alvjOEOtwqx8ION5SKaX6+4uSWB/bL758bUJQTYzOpD
         aQGDU7M7pCIDZH1w8m1S+paJbHWP+KOaDiRXSeRugxqJ2+PHc28JKs8TpptTUC/uMmFz
         Vcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gg24pBkx9uxXH81vY9HTkL7j8WN9zHUs35lE66OFcP8=;
        b=MzVrUEqsqQg+2oTTOn6w1Gb2HOmTp/2B25TRstuCBIN8yUOknf11PLUmBhPJKTe9xi
         8sWEZRW9kYY0oEXOFMwU7Jg3kuQDKrG0CWyWLN9PdsytGkHijhKWfJHs6qLiq+qY5qnO
         43PREV4t7YzQzbfyUoG2tIFt7XlJXSkiPEjocOauDWBK8xpDoiz+ueSE7ZUDVWUjXhe4
         e73MFMcjGJUOjtmfpOp3Y6ya1bwvaaBrZLF8wNA1qP9WuAU7lzMJGQEeeK+qk0ZpP0h+
         xjzbHpBoW6dvfKVACgvkGpAZJPiedL3tGMmlUvn1oeSTYeaCdJRxJEldOAPqtraNpwvR
         3sFw==
X-Gm-Message-State: AJIora8W71iVG6C+MxjjpDiY9h99KNn+LHdI3rJ2s1UB4L5p/LpB2W8H
        +anWJ01SRNQHKMrEia1+6IhxtEqVhJI/Gg==
X-Google-Smtp-Source: AGRyM1uwXsJL6ZYFg/20F5dBKhnHJv+gtRAmCuidCs83OIKDB+j2FlDtzCKLxrAzhDy73C1ZLHOl2w==
X-Received: by 2002:a05:600c:3658:b0:3a0:390e:ea00 with SMTP id y24-20020a05600c365800b003a0390eea00mr785989wmq.128.1657244663370;
        Thu, 07 Jul 2022 18:44:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d4d8a000000b0021d4aca9d1esm22732846wru.99.2022.07.07.18.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 18:44:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     ilia.lin@kernel.org, agross@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, stephan@gerhold.net
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v2 1/4] dt-bindings: opp: opp-v2-kryo-cpu: Fix example binding checks
Date:   Fri,  8 Jul 2022 02:44:16 +0100
Message-Id: <20220708014419.2009018-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708014419.2009018-1-bryan.odonoghue@linaro.org>
References: <20220708014419.2009018-1-bryan.odonoghue@linaro.org>
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

Adding missing compat entries to the cpufreq node
Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml shows up
a dt_binding_check in this file.

opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domains' is a required property
opp-v2-kryo-cpu.example.dtb: /: cpus:cpu@0: 'power-domain-names' is a required property
opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-307200000: 'required-opps' is a required property

Fixes: ec24d1d55469 ("dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index 30f7b596d609b..59663e897dae9 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -98,6 +98,8 @@ examples:
                 capacity-dmips-mhz = <1024>;
                 clocks = <&kryocc 0>;
                 operating-points-v2 = <&cluster0_opp>;
+                power-domains = <&cpr>;
+                power-domain-names = "cpr";
                 #cooling-cells = <2>;
                 next-level-cache = <&L2_0>;
                 L2_0: l2-cache {
@@ -115,6 +117,8 @@ examples:
                 capacity-dmips-mhz = <1024>;
                 clocks = <&kryocc 0>;
                 operating-points-v2 = <&cluster0_opp>;
+                power-domains = <&cpr>;
+                power-domain-names = "cpr";
                 #cooling-cells = <2>;
                 next-level-cache = <&L2_0>;
             };
@@ -128,6 +132,8 @@ examples:
                 capacity-dmips-mhz = <1024>;
                 clocks = <&kryocc 1>;
                 operating-points-v2 = <&cluster1_opp>;
+                power-domains = <&cpr>;
+                power-domain-names = "cpr";
                 #cooling-cells = <2>;
                 next-level-cache = <&L2_1>;
                 L2_1: l2-cache {
@@ -145,6 +151,8 @@ examples:
                 capacity-dmips-mhz = <1024>;
                 clocks = <&kryocc 1>;
                 operating-points-v2 = <&cluster1_opp>;
+                power-domains = <&cpr>;
+                power-domain-names = "cpr";
                 #cooling-cells = <2>;
                 next-level-cache = <&L2_1>;
             };
@@ -182,18 +190,21 @@ examples:
                 opp-microvolt = <905000 905000 1140000>;
                 opp-supported-hw = <0x7>;
                 clock-latency-ns = <200000>;
+                required-opps = <&cpr_opp1>;
             };
             opp-1401600000 {
                 opp-hz = /bits/ 64 <1401600000>;
                 opp-microvolt = <1140000 905000 1140000>;
                 opp-supported-hw = <0x5>;
                 clock-latency-ns = <200000>;
+                required-opps = <&cpr_opp2>;
             };
             opp-1593600000 {
                 opp-hz = /bits/ 64 <1593600000>;
                 opp-microvolt = <1140000 905000 1140000>;
                 opp-supported-hw = <0x1>;
                 clock-latency-ns = <200000>;
+                required-opps = <&cpr_opp3>;
             };
         };
 
@@ -207,24 +218,28 @@ examples:
                 opp-microvolt = <905000 905000 1140000>;
                 opp-supported-hw = <0x7>;
                 clock-latency-ns = <200000>;
+                required-opps = <&cpr_opp1>;
             };
             opp-1804800000 {
                 opp-hz = /bits/ 64 <1804800000>;
                 opp-microvolt = <1140000 905000 1140000>;
                 opp-supported-hw = <0x6>;
                 clock-latency-ns = <200000>;
+                required-opps = <&cpr_opp4>;
             };
             opp-1900800000 {
                 opp-hz = /bits/ 64 <1900800000>;
                 opp-microvolt = <1140000 905000 1140000>;
                 opp-supported-hw = <0x4>;
                 clock-latency-ns = <200000>;
+                required-opps = <&cpr_opp5>;
             };
             opp-2150400000 {
                 opp-hz = /bits/ 64 <2150400000>;
                 opp-microvolt = <1140000 905000 1140000>;
                 opp-supported-hw = <0x1>;
                 clock-latency-ns = <200000>;
+                required-opps = <&cpr_opp6>;
             };
         };
 
-- 
2.36.1

