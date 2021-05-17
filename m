Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561B4382A35
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbhEQKx6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:53:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:19454 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhEQKx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:53:57 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2021 06:53:56 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1621248752; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JTks0mjNUN90jKTEtiz5afT/xRyjxtJlRFB7AMfifsS/gVI8gw6JEfYKGvyXeDfR/L
    v0kcIRb5gSAFNuFMXIK310TAOykeh9NC7/x8yZ+SPYQgASt81wM+4+TJjfNeMLPHKIjp
    C1LtA20aTzgB7Y3qJuMdY+whvLgbSeLOWDEciSdJWn1YaiVcFTxIGU/S8qX3s6cqUWDr
    Ai74lC1BvSX3qj6Fm4oXTeuSZijBTZzS3B5+EzGyQGeGZxNCdSdIsPQXG1fb8tDgqqaX
    h2xP4/fQKY9QRBvWJLU2zq89jnlk3CZ0S0QNUvhv7ZJjyY9Kqfsbnc8yHV4cgWi8H5+v
    uJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248752;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GoBa/ve6tAbPHz+sONXvnYl+mlT4vBV3kKMUhJYWd7E=;
    b=el1QpK/pJKEk0UG3VwtngQII7ieOlgh31wkNqwZlbwFtkagYTTIt3p2cfzpEW7Y1t0
    4xvKwNVmE4KT5PxNvtcKIPPuOMlW4cDK7Qk8svDpbZQgQqmOIgpGMf+c3gqln/BgihVW
    auZPaEOtQRcW/VCXt3H2FNmWokblohcbNsDwMUZaOH6V2KHj17EKwesnxf5udeY08WFD
    hZNSKkzdhKItxLSlm5MtTnaxJhNnhn4Y7afJoetfew5c36itk6TtYjnBWs5oszRjtA1p
    YLba1DlUtZ3bHvyWA3O+cgL7P24FYot90kC0z3LaN798UjLCZbvA4nHRR0lqZ+xPuQVL
    BoBQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248752;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=GoBa/ve6tAbPHz+sONXvnYl+mlT4vBV3kKMUhJYWd7E=;
    b=c3xEFe+BZ3JEgMIynvRh9Oazvxbn+wZd1SyBnr6p9rMlocpJvWJYouVE9FEdI4euD2
    Pj+akh42UXagfEzDipe51CgV57AhpTEOIp6WxcW+R1elN/+51dPi0aJ/HLAeDB2JmThf
    N6mHECN/7pZ4mg9ePoC5Op+JS4tBSVelLGVZUEe72MYj2IOZs9Y2VsqStqwsKn5xTnFw
    huqnFKA7zWyE8SesAUBqd5+9AZx71HG3QkaFqDDhMAoNzd6Ab8V3NRo78Sr9BVkylHrN
    tdKhq0A8qckSwkkhoZx+SJtdCUO5NCaruxqGZ+ezlnA3B9jlGalmtT0K/0yvuvx1i/wf
    RJUw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB526NcMiO"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAqW1VZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:52:32 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/3] dt-bindings: power: supply: Add DT schema for richtek,rt5033-battery
Date:   Mon, 17 May 2021 12:51:11 +0200
Message-Id: <20210517105113.240379-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517105113.240379-1-stephan@gerhold.net>
References: <20210517105113.240379-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RT5033 PMIC provides a simple fuel gauge via I2C.
Add a DT schema to describe how to set it up in the device tree.

Note that although RT5033 is a MFD with lots of functionality
(also charger, regulator, LEDs, ...) the fuel gauge has a separate
I2C bus and is not part of the MFD.

Cc: Beomho Seo <beomho.seo@samsung.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../power/supply/richtek,rt5033-battery.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
new file mode 100644
index 000000000000..ae647d3355a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/richtek,rt5033-battery.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Richtek RT5033 PMIC Fuel Gauge
+
+maintainers:
+  - Stephan Gerhold <stephan@gerhold.net>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: richtek,rt5033-battery
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@35 {
+        compatible = "richtek,rt5033-battery";
+        reg = <0x35>;
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery@35 {
+        compatible = "richtek,rt5033-battery";
+        reg = <0x35>;
+        interrupt-parent = <&msmgpio>;
+        interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
+      };
+    };
-- 
2.31.1

