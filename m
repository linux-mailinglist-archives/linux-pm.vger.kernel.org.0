Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E583ACF87
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2019 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfIHP22 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Sep 2019 11:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfIHP22 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Sep 2019 11:28:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C33218AC;
        Sun,  8 Sep 2019 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567956506;
        bh=YKmhN+Se2Y3IMrQ2x38fkd/ztznfVO75BAYKGc83xaw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dpXA3ExPt8L4KmpiEqJ07UcnYXxKtcBL+Sf5FMVVU2A8EDHFdHXiPvlL4rWEhdBFn
         nN/gAWVZ9wPvYXBj3ApV2cWpesh2aF5rysvh2rQ2n9D7rMOGAwBPwErlSRYPzrFhRv
         fT2Zu9H9H/1qAMah51HV0oB8+aVcJtLXMJdTYw7Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC 2/2] dt-bindings: power: Convert Samsung Exynos Power Domain bindings to json-schema
Date:   Sun,  8 Sep 2019 17:28:13 +0200
Message-Id: <20190908152813.20646-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908152813.20646-1-krzk@kernel.org>
References: <20190908152813.20646-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert Samsung Exynos Soc Power Domain bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/power/pd-samsung.txt  | 45 ------------
 .../devicetree/bindings/power/pd-samsung.yaml | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/pd-samsung.txt
 create mode 100644 Documentation/devicetree/bindings/power/pd-samsung.yaml

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.txt b/Documentation/devicetree/bindings/power/pd-samsung.txt
deleted file mode 100644
index 92ef355e8f64..000000000000
--- a/Documentation/devicetree/bindings/power/pd-samsung.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-* Samsung Exynos Power Domains
-
-Exynos processors include support for multiple power domains which are used
-to gate power to one or more peripherals on the processor.
-
-Required Properties:
-- compatible: should be one of the following.
-    * samsung,exynos4210-pd - for exynos4210 type power domain.
-    * samsung,exynos5433-pd - for exynos5433 type power domain.
-- reg: physical base address of the controller and length of memory mapped
-    region.
-- #power-domain-cells: number of cells in power domain specifier;
-    must be 0.
-
-Optional Properties:
-- label: Human readable string with domain name. Will be visible in userspace
-	to let user to distinguish between multiple domains in SoC.
-- power-domains: phandle pointing to the parent power domain, for more details
-		 see Documentation/devicetree/bindings/power/power_domain.txt
-
-Deprecated Properties:
-- clocks
-- clock-names
-
-Node of a device using power domains must have a power-domains property
-defined with a phandle to respective power domain.
-
-Example:
-
-	lcd0: power-domain-lcd0 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10023C00 0x10>;
-		#power-domain-cells = <0>;
-		label = "LCD0";
-	};
-
-	mfc_pd: power-domain@10044060 {
-		compatible = "samsung,exynos4210-pd";
-		reg = <0x10044060 0x20>;
-		#power-domain-cells = <0>;
-		label = "MFC";
-	};
-
-See Documentation/devicetree/bindings/power/power_domain.txt for description
-of consumer-side bindings.
diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
new file mode 100644
index 000000000000..0fc012734a79
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/pd-samsung.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Power Domains
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |+
+  Exynos processors include support for multiple power domains which are used
+  to gate power to one or more peripherals on the processor.
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4210-pd
+      - samsung,exynos5433-pd
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    deprecated: true
+    maxItems: 1
+
+  clock-names:
+    deprecated: true
+    maxItems: 1
+
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Human readable string with domain name. Will be visible in userspace
+      to let user to distinguish between multiple domains in SoC.
+
+  "#power-domain-cells":
+    const: 0
+
+  power-domains:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle pointing to the parent power domain, for more details
+      see power-domain-consumers.yaml.
+
+required:
+  - compatible
+  - "#power-domain-cells"
+  - reg
+
+examples:
+  - |
+    lcd0: power-domain-lcd0 {
+      compatible = "samsung,exynos4210-pd";
+      reg = <0x10023C00 0x10>;
+      #power-domain-cells = <0>;
+      label = "LCD0";
+    };
+
+    mfc_pd: power-domain@10044060 {
+      compatible = "samsung,exynos4210-pd";
+      reg = <0x10044060 0x20>;
+      #power-domain-cells = <0>;
+      label = "MFC";
+    };
-- 
2.17.1

