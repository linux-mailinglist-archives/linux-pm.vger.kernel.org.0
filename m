Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC13BB54C
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 04:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhGECxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 22:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGECxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 22:53:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66DCC061764
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 19:50:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j199so15022097pfd.7
        for <linux-pm@vger.kernel.org>; Sun, 04 Jul 2021 19:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVkVvoLhlvv3KppO1b0TRg6fddRYWUrnF61FALx2Tlg=;
        b=RLMt+5SGRUMwjcxTeILVJP0YqCzVQGNhwSlb7M1kOV12rHTmadCBJTIMw9keQJpKtM
         te5EyOcJv5Hhtw/VzLQ0WQ/SfMchIiYf0akkEUWulD68s1lj/rWCanhMI7DcKDGUJ5RM
         c3WmV3+OKUy4E5eA5vxDpHl+HJLRBJH1D6zFpvsTr6DnJj8AJhzsWWMdQHhhM4rz763o
         /K8V40tpnHRMo+HAOZTjf472ihe0bZwAeoUqeOHm//CkTMTtWY5RbH1HT0uirq/rl36V
         mTnHkUhxHi+fsaB5AhaebK9+aWUv4BgPTSaH6buwSL4g9PRFpDL+dxQ0+fPRfuJXmaBe
         fTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BVkVvoLhlvv3KppO1b0TRg6fddRYWUrnF61FALx2Tlg=;
        b=kqZ5igrTGUyaXv6TSFddX/2d0YU/kYIE5VGGxVyZAPNFCuiIncNE1StiDsMycKZUwn
         9KbOSSicDFOfteWqwWAi5OyuWI+bBYetU4HlZ703pRmoDEpA1scvWk4QPY+ZTQOuLtIc
         v0YyGlmCpz2hTE2I4Kn/l0yHWKwsbq+O8J+3cIkdhzfQOi7hGxqL7xJNUGba3mtsg2WK
         mXTVFlSO+v3H9hftO0sc1zHReqGSLdLkbxDTmkkUkezGb4VCsCKsfNccYZ5cWH45UnqI
         hQi4azW9HxTjsNTqFnNbGXBG5v1PMQgp/FKqxB0zlyx1pxGXNEMrUrXpYv4k0a8tMhCX
         M/5g==
X-Gm-Message-State: AOAM5327ZbVPypyyMhotBlmp7NIB3jsxasnH62p0/pByiFfdnKciCTEx
        +5wKLIkZQvOgCQ9lmoB3lEOgPA==
X-Google-Smtp-Source: ABdhPJy2wxkmR9njdKtQHvZAuf5Z8esv5vUXz+zBwMP32HUxP1F5FUGrVZJDfmyfKZa2xtORNFJonw==
X-Received: by 2002:a63:5117:: with SMTP id f23mr13113629pgb.200.1625453454408;
        Sun, 04 Jul 2021 19:50:54 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i13sm11891041pgm.26.2021.07.04.19.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 19:50:53 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/3] dt-bindings: power: reset: Convert qcom,pon to DT schema
Date:   Mon,  5 Jul 2021 10:50:30 +0800
Message-Id: <20210705025032.12804-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210705025032.12804-1-shawn.guo@linaro.org>
References: <20210705025032.12804-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It converts qcom,pon DT bindings from legacy bare text to YAML format.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/power/reset/qcom,pon.txt         | 49 -------------------
 .../bindings/power/reset/qcom,pon.yaml        | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
deleted file mode 100644
index 0c0dc3a1e693..000000000000
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Qualcomm PON Device
-
-The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
-and resin along with the Android reboot-mode.
-
-This DT node has pwrkey and resin as sub nodes.
-
-Required Properties:
--compatible: Must be one of:
-	"qcom,pm8916-pon"
-	"qcom,pms405-pon"
-	"qcom,pm8998-pon"
-
--reg: Specifies the physical address of the pon register
-
-Optional subnode:
--pwrkey: Specifies the subnode pwrkey and should follow the
- qcom,pm8941-pwrkey.txt description.
--resin: Specifies the subnode resin and should follow the
- qcom,pm8xxx-pwrkey.txt description.
-
-The rest of the properties should follow the generic reboot-mode description
-found in reboot-mode.txt
-
-Example:
-
-	pon@800 {
-		compatible = "qcom,pm8916-pon";
-
-		reg = <0x800>;
-		mode-bootloader = <0x2>;
-		mode-recovery = <0x1>;
-
-		pwrkey {
-			compatible = "qcom,pm8941-pwrkey";
-			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
-			debounce = <15625>;
-			bias-pull-up;
-			linux,code = <KEY_POWER>;
-		};
-
-		resin {
-			compatible = "qcom,pm8941-resin";
-			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-			debounce = <15625>;
-			bias-pull-up;
-			linux,code = <KEY_VOLUMEDOWN>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
new file mode 100644
index 000000000000..7764c804af1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/qcom,pon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PON Device
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description: |
+  The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
+  and resin along with the Android reboot-mode.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8916-pon
+      - qcom,pms405-pon
+      - qcom,pm8998-pon
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^mode-.+":
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Vendor-specific mode value written to the mode register
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pon@800 {
+            compatible = "qcom,pm8916-pon";
+            reg = <0x800>;
+            mode-bootloader = <0x2>;
+            mode-recovery = <0x1>;
+        };
+    };
-- 
2.17.1

