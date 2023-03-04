Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2E6AAAD4
	for <lists+linux-pm@lfdr.de>; Sat,  4 Mar 2023 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCDPjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Mar 2023 10:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCDPjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Mar 2023 10:39:31 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A914485
        for <linux-pm@vger.kernel.org>; Sat,  4 Mar 2023 07:39:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t11so7326059lfr.1
        for <linux-pm@vger.kernel.org>; Sat, 04 Mar 2023 07:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677944367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkQLsP65fImQui6Vksp9H8jTY7ieBpcQFwnHm8FDZDI=;
        b=s6YJGuNh9e7vwlzJtoi28QZS/Y3lCyOfgBtkjUAqBXGnwdBamHYcyKYag0Y54JvjZV
         BfJ8ztDs7rWu5pWKQSsAW5KvfkUGhqgHSaasEPRugBl6vmrByEVFBZAD0WwL6ecVatJ5
         kfUPVNdW2E9Ue+9j1TMQ3Xc69TzSK8NMK03dm5QliL5WHiiniFsCy1e4BdQbhByK3A2R
         qClNq7905EnW8vwjvWjHDpu6tBGkH2PteQZakKNtrGRuVl39htKni9K8u8r5AoL9NxkR
         tb6aAsVkxmZAyEz1awjIs/HT3ywyy5C4MQs/jF4iTQ2Bq3RtmfInCaIUPR40fiCNY+s6
         tCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677944367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkQLsP65fImQui6Vksp9H8jTY7ieBpcQFwnHm8FDZDI=;
        b=nCaeyy3l1fTO+CX7YKsgZnuZ1TMAM74R3XtNOU3SdQY0AN9zzorub3yXnvkA6zOjWW
         blxrh2EwEU/lej27aHFijFkRV2MhBNaqoFp1j0/oTx4/Je6KgEr8DFRKxE37syf5llw6
         xgJm1xhkDJsv1hROkprG8T0ISTqN/qoMLbHDMbTm1owkdPgRrFXsSGhTvjg5ua/FapyZ
         JBb0cKIniT2T+KoLGTutkRr1D0GyisXroDP6k403rr6z6YTAqjpF15jeQWosZf4nOpvH
         /LMfu8dNjuzNL05cSRolE/YfhZivXk6STPqKXWlP1nO7xVm2QGWKkPBxFiMSRhfw/7km
         E0yw==
X-Gm-Message-State: AO0yUKVV1tIx8LAmMRj+OTuXaKcvAigY+LE0VE2b0mxSrzAofKUvn/A+
        /N39aAAZnJ2H/2ez3JKwucDsrg==
X-Google-Smtp-Source: AK7set984gSDOF95hAvgeVWxAH84/h7tQGhGoRr204EqszEnVK0B/I535UZkA5P23YBu3xYIs5DyiA==
X-Received: by 2002:ac2:5637:0:b0:4d5:716a:1c05 with SMTP id b23-20020ac25637000000b004d5716a1c05mr1461737lff.12.1677944367810;
        Sat, 04 Mar 2023 07:39:27 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2532e000000b004ab52b0bcf9sm855065lfh.207.2023.03.04.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:39:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 16:39:19 +0100
Subject: [PATCH 1/3] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 global registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v1-1-e563837dc7d1@linaro.org>
References: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v1-0-e563837dc7d1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677944365; l=2057;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GpWlgVV1H1bLYPigQ1OzrJ4jZWWfQSXtviV8ZB/PRmE=;
 b=yzDdXn/c20Uluh2T350t7wUZniq3/HP+GGR8FndDqzLW+kh24W69K9X2ImVbFXGS90cva9BxMlQJ
 NFnii4w1CKyt5XfH+tkluTcFVaOWAGXKDr3d4m4jY4E7K1d1+spu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BWMON has two sets of registers: one for handling the monitor itself
and one called "global", which we didn't care about before, as on newer
SoCs it was made contiguous with (but not the same as) the monitor's
register range. Describe it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  | 28 ++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 12a0d3ecbabb..6dd0cb0a1f43 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -49,9 +49,13 @@ properties:
     type: object
 
   reg:
-    # BWMON v4 (currently described) and BWMON v5 use one register address
-    # space.  BWMON v2 uses two register spaces - not yet described.
-    maxItems: 1
+    # BWMON v5 uses one register address space, v1-v4 use one or two.
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
 
 required:
   - compatible
@@ -63,6 +67,21 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8998-bwmon
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+        reg-names:
+          items:
+            - const: monitor
+            - const: global
+
 examples:
   - |
     #include <dt-bindings/interconnect/qcom,sdm845.h>
@@ -70,7 +89,8 @@ examples:
 
     pmu@1436400 {
         compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
-        reg = <0x01436400 0x600>;
+        reg = <0x01436400 0x600>, <0x01436300 0x200>;
+        reg-names = "monitor", "global";
         interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
         interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
 

-- 
2.39.2

