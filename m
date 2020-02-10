Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C13157444
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJMME (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 07:12:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40118 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBJMMD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2020 07:12:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so6845797ljo.7;
        Mon, 10 Feb 2020 04:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KY6h38OrTl9v1GuFalSTU/piBjftlEdbF7ex5QgcZrw=;
        b=TKmnDU5+M9uA10BW7+e5n4/mZGx4AWelxki4suwWJ/Ai1h0fBZO0nStvxCWRHfU9My
         6WTeiDJRuOWFHaM53M3PiSuXMaPO3GcJ2rUOjaawf2BYg96Bf6+buEmKLQAkgaEgsvO3
         iBmPNRMIvk1yPRej7sE5F0p09yonsF3JaIWF/AWDxb2rOWE91tJ8eGbvXR5B32JNlK4F
         dWNl2ZHVWrecEYHPeZTbj8RH0d+BKivnMxkeZR235vYk6/MCTIYINKqntlOCcQnrRvgJ
         Bmcwn3zIGEJwhgFcqQjW00NOcaRePqoOkx4frq7DCJTutb117XeKQ/AoXA0jYjS2o7PF
         bcWQ==
X-Gm-Message-State: APjAAAWx6YjRzFUgAtO1LJRdFrqS7uFsOzvbHGUPpzmAaUwdYdbLYZiQ
        cNRpsFXRqE1tECDddYkd6go=
X-Google-Smtp-Source: APXvYqx2anjGXV8UVCUo0GBiLDMzRsqO7Sc+9LeJTmjiaI3eWYKzd8CrmWE40wKbBfVdaUhsxnAluQ==
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr708367lja.165.1581336721661;
        Mon, 10 Feb 2020 04:12:01 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t1sm116768lji.98.2020.02.10.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:12:01 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:11:52 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] dt_bindings: ROHM BD99954 Charger
Message-ID: <fc866eb870e1980fd2a5cd37cf02cde5e8fb3d06.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
secondary battery. Intended to be used in space-constraint equipment such
as Low profile Notebook PC, Tablets and other applications. BD99954
provides a Dual-source Battery Charger, two port BC1.2 detection and a
Battery Monitor.

Document the DT bindings for BD99954

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
I think these properties could probably be generic and not
vendor specific, right? If so, then I could try adding parser
function(s) for them in power/supply framework. How do you
guys see this?

 .../bindings/power/supply/rohm,bd9995x.yaml   | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
new file mode 100644
index 000000000000..ba9fe1dc3f2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/rohm,bd9995x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD99954 Battery charger driver
+
+maintainers:
+  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+  - Markus Laine <markus.laine@fi.rohmeurope.com>
+  - Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
+
+description: |
+  The ROHM BD99954 is a Battery Management LSI for 1-4 cell Lithium-Ion
+  secondary battery intended to be used in space-constraint equipment such
+  as Low profile Notebook PC, Tablets and other applications. BD99954
+  provides a Dual-source Battery Charger, two port BC1.2 detection and a
+  Battery Monitor.
+
+properties:
+  compatible:
+    const: rohm,bd9995x-charger
+
+  rohm,vbus-input-current-limit-microamp:
+    description:
+      system specific VBUS input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+  rohm,vcc-input-current-limit-microamp:
+    description:
+      system specific VCC/VACP input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+  rohm,trickle-charging-current-microamp:
+    description:
+      battery specific value for trickle-charging current.
+    minimum: 64000
+    maximum: 1024000
+    multipleOf: 64000
+
+  rohm,pre-charging-current-microamp:
+    description:
+      battery specific value for pre-charging current.
+    minimum: 64000
+    maximum: 1024000
+    multipleOf: 64000
+
+  rohm,fast-charging-regulation-microvolt:
+    description:
+      battery/system specific upper limit for battry/system voltage.
+    minimum: 2560000
+    maximum: 19200000
+    multipleOf: 16000
+
+  rohm,vsys-regulation-microvolt:
+    description:
+      system specific lower limit for system voltage.
+    minimum: 2560000
+    maximum: 19200000
+    multipleOf: 64000
+
+  rohm,pre-charge-voltage-threshold-microvolt:
+    description:
+      voltage limit for changing from trickle to pre-charging.
+    minimum: 2048000
+    maximum: 19200000
+    multipleOf: 64000
+
+  rohm,re-charge-battery-voltage-microvolt:
+    description:
+      voltage limit for automatically re-starting the battery charging.
+    minimum: 2560000
+    maximum: 19200000
+    multipleOf: 16000
+
+  rohm,battery-over-voltage-threshold-microvolt:
+    description:
+      voltage limit for detecting battery over voltage.
+    minimum: 2560000
+    maximum: 19200000
+    multipleOf: 16000
+
+required:
+  - compatible
+  - rohm,vbus-input-current-limit-microamp
+  - rohm,vcc-input-current-limit-microamp
+  - rohm,trickle-charging-current-microamp
+  - rohm,pre-charging-current-microamp
+  - rohm,fast-charging-regulation-microvolt
+  - rohm,vsys-regulation-microvolt
+  - rohm,pre-charge-voltage-threshold-microvolt
+  - rohm,re-charge-battery-voltage-microvolt
+  - rohm,battery-over-voltage-threshold-microvolt
+
+examples:
+  - |
+    i2c {
+        charger@9 {
+            compatible = "rohm,bd9995x-charger";
+            reg = <0x9>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <29 8>;
+            rohm,vsys-regulation-microvolt = <8960000>;
+            rohm,vbus-input-current-limit-microamp = <1472000>;
+            rohm,vcc-input-current-limit-microamp = <1472000>;
+            rohm,trickle-charging-current-microamp = <256000>;
+            rohm,pre-charging-current-microamp = <256000>;
+            rohm,fast-charging-regulation-microvolt = <8400000>;
+            rohm,pre-charge-voltage-threshold-microvolt = <2048000>;
+            rohm,re-charge-battery-voltage-microvolt = <8112000>;
+            rohm,battery-over-voltage-threshold-microvolt = <8912000>;
+        };
+    };
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
