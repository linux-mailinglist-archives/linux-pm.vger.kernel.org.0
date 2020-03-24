Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD73519186A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 19:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCXSFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 14:05:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43165 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgCXSFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 14:05:17 -0400
Received: by mail-il1-f196.google.com with SMTP id g15so8511425ilj.10;
        Tue, 24 Mar 2020 11:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9FwT4hBATnVfznxi1cnrb0F4y7CCgXvMmx9RvvvTuk=;
        b=HQFyIs64REozGG698aB7gxXHmc92rNPosEpkNH5SrahMuIhYpfZSvr9aVIw6uoqlZk
         9ImqfjsiST5bg4Q0oVynq1uB8aJrEnIS1d+ikgPmXEiBvPk1aXIhE8LkWCmjZT+Rj2ln
         skE/NKiNIWz16/da1dtjBPsNWSXYKWLk/3GANp0xht7OqPggVawDoA9Q44ryktbPCEyv
         EKQI2Z5z7OtL5JT9DKq5OFINe9hb9JAWF0XXnkJQVtHZTLm1VvydguVbMYrysIsYdRRE
         qMET8ENLXm9XKCe1Qomx9F0+HBFyqP8BVkdZSH7UF4wpiOua5sWDNVqY1fn6OR8CgpOI
         eFXA==
X-Gm-Message-State: ANhLgQ034nJwvC4HvNYcEb+/8EIUf7YcPQ0olCFQNlH3h+OFBoEYswMq
        0fo4ErOOzFXABXNn6k2oJw==
X-Google-Smtp-Source: ADFU+vtWYXZGcZ5Xm5GdMRAWBGF58PhfvWP3D92WD4x1uhj4RylpNyqfXK314CqkENzaR4qEWKuXbQ==
X-Received: by 2002:a92:8316:: with SMTP id f22mr703764ild.169.1585073116525;
        Tue, 24 Mar 2020 11:05:16 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.250])
        by smtp.googlemail.com with ESMTPSA id h12sm5348493iob.22.2020.03.24.11.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:05:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: thermal: tsens: Set 'additionalProperties: false'
Date:   Tue, 24 Mar 2020 12:05:13 -0600
Message-Id: <20200324180513.3882-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180513.3882-1-robh@kernel.org>
References: <20200324180513.3882-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ensure the node only contains the properties listed in the schema by
setting 'additionalProperties: false'. Doing this requires reworking the
interrupt properties schemas so that they are defined in the main
'properties' section.

Fixes: a877e768f655 ("dt-bindings: thermal: tsens: Convert over to a yaml schema")
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/qcom-tsens.yaml          | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 7a38d2116059..3492447e42e9 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -46,6 +46,18 @@ properties:
       - description: TM registers
       - description: SROT registers
 
+  interrupts:
+    minItems: 1
+    items:
+      - description: Combined interrupt if upper or lower threshold crossed
+      - description: Interrupt if critical threshold crossed
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: uplow
+      - const: critical
+
   nvmem-cells:
     minItems: 1
     maxItems: 2
@@ -88,22 +100,16 @@ allOf:
     then:
       properties:
         interrupts:
-          items:
-            - description: Combined interrupt if upper or lower threshold crossed
+          maxItems: 1
         interrupt-names:
-          items:
-            - const: uplow
+          maxItems: 1
 
     else:
       properties:
         interrupts:
-          items:
-            - description: Combined interrupt if upper or lower threshold crossed
-            - description: Interrupt if critical threshold crossed
+          minItems: 2
         interrupt-names:
-          items:
-            - const: uplow
-            - const: critical
+          minItems: 2
 
 required:
   - compatible
@@ -113,6 +119,8 @@ required:
   - interrupt-names
   - "#thermal-sensor-cells"
 
+additionalProperties: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.20.1

