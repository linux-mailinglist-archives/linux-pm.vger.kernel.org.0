Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9321A9FD
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGIVvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGIVvu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 17:51:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE3C08C5CE;
        Thu,  9 Jul 2020 14:51:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f12so3842114eja.9;
        Thu, 09 Jul 2020 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Hc4W3Js1OftAK/QTedCJSjWZ8huqh9WCdiCmuDtrwg=;
        b=gigcSDuZHB3jHtEQaZXocB2czt9wFU3H/z8E+3rF8NKJmU1HOisO/kqGIRjRQujkBC
         FGDwZFBzUwHKajoe3osHcrEOzBNUMLgQH9+VO3w/9bnji3ugqjbwkFZlCwjudJkEIh7V
         s797lbsoTzH0KzjeU1pLFCdRAbAqNRVW5iQH/SxyiuTx/k06JR/ZcVTH47jxvPMbMbpr
         SmqAuPG6yqQHhE+PU8IEVT5lkZsOB4EO9OkuKDPQXj7Z4Wc41EYYx5OxUcvhHIgMe17h
         lj35Tld+GwKEmNEXk11nIncoQejSmffsTyCstb8LOVfs47yL9o0I7na2b2VsQQ+xHObB
         uhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Hc4W3Js1OftAK/QTedCJSjWZ8huqh9WCdiCmuDtrwg=;
        b=qPNkasUHIgNwnvSzWkymO9HrXS4Xx50NIceKQ2GcOFyAoJAalTBBiDIA7tYIuo8fXK
         WKFuzX7I4Sk3iPmcmI7YEQQlHCCh/OUUts5Z8ZN6CPtExUEeUfxq8Q1pn+3aHdoYF6iP
         nQj4vorKZUvsk2+MpAGNyBGl/cospOvbNCr8f+cpVin/0PRQhPT9tQAEpaFkvf6M4TJ/
         Elg1GKgq/1aV5mLAPdiYH+kgvQqju7eSnzOi9+bXc9WxV2FmvURS9vhJqnX9aJikqo+z
         70dMmBpxdYEa7huW8kU3Cn8iCkB7e/oIMybTx2OUHdHAgQfcwj3S4pwGn/Igab4OHeqt
         a55g==
X-Gm-Message-State: AOAM532ghaEibkjTLktrhSe9Q8YM5PnbCPRT2Vz4Au1KsEJyEEahH9XM
        E94w6tJwJknv4btbDgdLTFY=
X-Google-Smtp-Source: ABdhPJwOcYX2QYznh3ZcvNVgFGDLNt77XVMVqpavPLymkdeUeAIVxVaOiwnFl8Trth5eBSHt8su4rA==
X-Received: by 2002:a17:906:2505:: with SMTP id i5mr57304428ejb.545.1594331508944;
        Thu, 09 Jul 2020 14:51:48 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id e16sm2498260ejt.14.2020.07.09.14.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:51:48 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: thermal: tsens: document ipq8064 bindings
Date:   Thu,  9 Jul 2020 23:51:33 +0200
Message-Id: <20200709215136.28044-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709215136.28044-1-ansuelsmth@gmail.com>
References: <20200709215136.28044-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the use of regmap phandle for ipq8064 SoCs

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/thermal/qcom-tsens.yaml          | 51 ++++++++++++++++---
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d7be931b42d2..5ceb5d720e16 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -24,6 +24,7 @@ properties:
           - enum:
               - qcom,msm8916-tsens
               - qcom,msm8974-tsens
+              - qcom,ipq8064-tsens
           - const: qcom,tsens-v0_1
 
       - description: v1 of TSENS
@@ -47,6 +48,11 @@ properties:
       - description: TM registers
       - description: SROT registers
 
+  regmap:
+    description:
+      Phandle to the gcc. On ipq8064 SoCs gcc and tsense share the same regs.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   interrupts:
     minItems: 1
     items:
@@ -111,17 +117,48 @@ allOf:
         interrupt-names:
           minItems: 2
 
-required:
-  - compatible
-  - reg
-  - "#qcom,sensors"
-  - interrupts
-  - interrupt-names
-  - "#thermal-sensor-cells"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq8064-tsens
+    then:
+      required:
+        - compatible
+        - regmap
+        - "#qcom,sensors"
+        - interrupts
+        - interrupt-names
+        - "#thermal-sensor-cells"
+
+    else:
+      required:
+        - compatible
+        - reg
+        - "#qcom,sensors"
+        - interrupts
+        - interrupt-names
+        - "#thermal-sensor-cells"
 
 additionalProperties: false
 
 examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example msm9860 based SoC (ipq8064):
+    tsens: thermal-sensor@900000 {
+           compatible = "qcom,ipq8064-tsens";
+           regmap = <&gcc>;
+
+           nvmem-cells = <&tsens_calib>, <&tsens_backup>;
+           nvmem-cell-names = "calib", "calib_backup";
+
+           interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+
+           #thermal-sensor-cells = <1>;
+    };
+
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     // Example 1 (legacy: for pre v1 IP):
-- 
2.27.0

