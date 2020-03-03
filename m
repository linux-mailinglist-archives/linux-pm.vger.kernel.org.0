Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD41779FA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgCCPID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 10:08:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41670 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgCCPID (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 10:08:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id u26so3883547ljd.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjdkayiJ3LtaxLYwkOTc4CgwJfOkW9drdJX4syz3ipw=;
        b=RLvtGSvlL2ZKg9u7qpjybj0cciaEsfBIgh3is2uiAVm4n6IckIp3MkKk6iFbZnTVM5
         O6lLxvUF8qz2nwZmU3Q6eCIVfOwulTGgR4EHDNSECKnc5555BIEqnYF7zjeOmUl3xbD7
         U6wYkHSrd9uchIET6VRsOPD0SevSqh1Iczx1tsjJYWxllqemSjoXyCL8kPEarsdyA6HS
         gXF8Mu+RgmcX3QTQy6b+pLhrO208Vcev6r394VRimrDKIz3QnGUD6u7fX/OwP/AgfxO0
         R2pBEQSqA7M4UKmbP3pvymYqa+hWokMcOJI+LMsbz5NAoI71o9THo3BQg38H9+jZNkKd
         FgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjdkayiJ3LtaxLYwkOTc4CgwJfOkW9drdJX4syz3ipw=;
        b=fJty9Yi5JHwo7XXgsdfHgD8WyKtpSAt6hBcJzqpl3PO283UFoi7k8YRx1htqhF7phw
         JM3cgYy5IjnJHQuLan9IvlILzsVb0x8adOKmao8Ehe/xTxYDi+UXs17um+lIgnnBqNfG
         fyJmFKObcb+BkNVLSPMf1Pirwiduv8Hw3QEHXeJqz/Iml2wPR2JsrG0YaBJvkXHDT4ja
         iPiOawm8R/M3qLDgd4jDGWE3/s0ahd7C9uY+LQJ8JPpr+51uwHsYd6TsF6fOoZY4UiyM
         cmoHfnjOlVyHWy2F0AohlCbA7Se+F/zc5eiAn7gfEP5I+XINoO1fVAOtREubn382MTEC
         h+VQ==
X-Gm-Message-State: ANhLgQ13VV75kThqwUUPU+69U5kN+6Hyoq8mpgD07CR3HCexqPhXnlHE
        bCDl22wjgPGmFWtQZk8BDyFoMg==
X-Google-Smtp-Source: ADFU+vsy8RXa2JkubLPVYUS7N5uh4Nl43LrVHX6u5UwJJSRxFFz+CIWvNB+Watcu8JNZX00LUTOhBQ==
X-Received: by 2002:a2e:556:: with SMTP id 83mr2723344ljf.127.1583248080801;
        Tue, 03 Mar 2020 07:08:00 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n189sm12143135lfa.14.2020.03.03.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:08:00 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/7] dt-bindings: power: Convert domain-idle-states bindings to json-schema
Date:   Tue,  3 Mar 2020 16:07:45 +0100
Message-Id: <20200303150749.30566-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303150749.30566-1-ulf.hansson@linaro.org>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While converting to the json-schema, let's also take the opportunity to
further specify/clarify some more details about the DT binding.

For example, let's define the label where to put the states nodes, set a
pattern for nodename of the state nodes and finally add an example.

Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/arm/psci.yaml         |  2 +-
 .../bindings/power/domain-idle-state.txt      | 33 ---------
 .../bindings/power/domain-idle-state.yaml     | 67 +++++++++++++++++++
 .../bindings/power/power-domain.yaml          | 22 +++---
 .../bindings/power/power_domain.txt           |  2 +-
 5 files changed, 79 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
 create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.yaml

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 540211a080d4..0bc3c43a525a 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -123,7 +123,7 @@ properties:
       to mandate it.
 
       [3] Documentation/devicetree/bindings/power/power_domain.txt
-      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
+      [4] Documentation/devicetree/bindings/power/domain-idle-state.yaml
 
   power-domains:
     $ref: '/schemas/types.yaml#/definitions/phandle-array'
diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
deleted file mode 100644
index eefc7ed22ca2..000000000000
--- a/Documentation/devicetree/bindings/power/domain-idle-state.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-PM Domain Idle State Node:
-
-A domain idle state node represents the state parameters that will be used to
-select the state when there are no active components in the domain.
-
-The state node has the following parameters -
-
-- compatible:
-	Usage: Required
-	Value type: <string>
-	Definition: Must be "domain-idle-state".
-
-- entry-latency-us
-	Usage: Required
-	Value type: <prop-encoded-array>
-	Definition: u32 value representing worst case latency in
-		    microseconds required to enter the idle state.
-		    The exit-latency-us duration may be guaranteed
-		    only after entry-latency-us has passed.
-
-- exit-latency-us
-	Usage: Required
-	Value type: <prop-encoded-array>
-	Definition: u32 value representing worst case latency
-		    in microseconds required to exit the idle state.
-
-- min-residency-us
-	Usage: Required
-	Value type: <prop-encoded-array>
-	Definition: u32 value representing minimum residency duration
-		    in microseconds after which the idle state will yield
-		    power benefits after overcoming the overhead in entering
-i		    the idle state.
diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
new file mode 100644
index 000000000000..27da43076b85
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/domain-idle-state.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PM Domain Idle States binding description
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+
+description:
+  A domain idle state node represents the state parameters that will be used to
+  select the state when there are no active components in the PM domain.
+
+properties:
+  $nodename:
+    const: domain-idle-states
+
+patternProperties:
+  "^(cpu|cluster|domain)-":
+    type: object
+    description:
+      Each state node represents a domain idle state description.
+
+    properties:
+      compatible:
+        const: domain-idle-state
+
+      entry-latency-us:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The worst case latency in microseconds required to enter the idle
+          state. Note that, the exit-latency-us duration may be guaranteed only
+          after the entry-latency-us has passed.
+
+      exit-latency-us:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The worst case latency in microseconds required to exit the idle
+          state.
+
+      min-residency-us:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The minimum residency duration in microseconds after which the idle
+          state will yield power benefits, after overcoming the overhead while
+          entering the idle state.
+
+    required:
+      - compatible
+      - entry-latency-us
+      - exit-latency-us
+      - min-residency-us
+
+examples:
+  - |
+
+    domain-idle-states {
+      domain_retention: domain-retention {
+        compatible = "domain-idle-state";
+        entry-latency-us = <20>;
+        exit-latency-us = <40>;
+        min-residency-us = <80>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index 455b573293ae..207e63ae10f9 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -29,18 +29,16 @@ properties:
 
   domain-idle-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    description:
-      A phandle of an idle-state that shall be soaked into a generic domain
-      power state. The idle state definitions are compatible with
-      domain-idle-state specified in
-      Documentation/devicetree/bindings/power/domain-idle-state.txt
-      phandles that are not compatible with domain-idle-state will be ignored.
-      The domain-idle-state property reflects the idle state of this PM domain
-      and not the idle states of the devices or sub-domains in the PM domain.
-      Devices and sub-domains have their own idle-states independent
-      of the parent domain's idle states. In the absence of this property,
-      the domain would be considered as capable of being powered-on
-      or powered-off.
+    description: |
+      Phandles of idle states that defines the available states for the
+      power-domain provider. The idle state definitions are compatible with the
+      domain-idle-state bindings, specified in ./domain-idle-state.yaml.
+
+      Note that, the domain-idle-state property reflects the idle states of this
+      PM domain and not the idle states of the devices or sub-domains in the PM
+      domain. Devices and sub-domains have their own idle states independent of
+      the parent domain's idle states. In the absence of this property, the
+      domain would be considered as capable of being powered-on or powered-off.
 
   operating-points-v2:
     $ref: /schemas/types.yaml#/definitions/phandle-array
diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 5b09b2deb483..08497ef26c7a 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -109,4 +109,4 @@ Example:
 		required-opps = <&domain1_opp_1>;
 	};
 
-[1]. Documentation/devicetree/bindings/power/domain-idle-state.txt
+[1]. Documentation/devicetree/bindings/power/domain-idle-state.yaml
-- 
2.20.1

