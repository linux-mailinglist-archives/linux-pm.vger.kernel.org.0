Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D061E189B32
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 12:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgCRLt6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 07:49:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33312 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRLt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 07:49:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id f13so26673169ljp.0;
        Wed, 18 Mar 2020 04:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FSX2KRPkbn5W9dakUVXlf3UmUaijxOrOQb/z1feN3Bo=;
        b=nWDAiMVfDfHUBmRiSWoLV4DSc6MEgfZOL9gxo2GDglrxe2oRIFqd5y3wogyIlDSXWj
         N4f9o55ysIL1v9SV0EHJbL+5Ig+2Cm/jUDCQ1RK40Di1vc2e5C/e/zW/0VLjy393zyjR
         6G6VFdUjASpl3nmDo05Ky8G3oseXX/I++Zlhe0pUn3is7qkfv5KfxfqDvT6rFsf1aGUo
         //D74tnyV1CIvPvVHNqIDkfXe8rdhu4EBoor/1s8JkLuOg8JuwLpiayJvuSJ+MQmQ9Kc
         dGzACCDfAjebMG1E8SsqGt1npExqu+HmNuTl+jOS8zuISblrYzNHZUA9S42x/6UkbRMN
         B6hg==
X-Gm-Message-State: ANhLgQ0wDDqKD+WGWBpf4Ofkx3GEd9k6SSjP8M/JJo8VFLOjkTygRqYW
        od3PypW56SNc/zQ7SDgE7Jg=
X-Google-Smtp-Source: ADFU+vvYIRL1AoNCriE04/mFuYGDD1Z1+Cwqn+6pE+NpLNPDlUhAaQmy2avH0K4yozo+FWxO1hGlWA==
X-Received: by 2002:a2e:151e:: with SMTP id s30mr2261463ljd.92.1584532195328;
        Wed, 18 Mar 2020 04:49:55 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id u1sm847992lju.95.2020.03.18.04.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 04:49:54 -0700 (PDT)
Date:   Wed, 18 Mar 2020 13:49:47 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [PATCH v5 2/9] dt_bindings: ROHM BD99954 Charger
Message-ID: <a697e85a2c21758e00a28ca64b6e55ff7fb2f7d0.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584468798.git.matti.vaittinen@fi.rohmeurope.com>
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


Changes since v4:
 - change compatible name and file name accordingly
 - Fix the title



 .../bindings/power/supply/rohm,bd99954.yaml   | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
new file mode 100644
index 000000000000..7e0f73a898c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/rohm,bd99954.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD99954 Battery charger
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
+
+properties:
+  compatible:
+    const: rohm,bd99954
+#
+#    The battery charging profile of BD99954.
+#
+#    Curve (1) represents charging current.
+#    Curve (2) represents battery voltage.
+#
+#    The BD99954 data sheet divides charging to three phases.
+#    a) Trickle-charge with constant current (8).
+#    b) pre-charge with constant current (6)
+#    c) fast-charge with:
+#       First a constant current (5) phase (CC)
+#       Then constant voltage (CV) phase (after the battery voltage has reached
+#       target level - until charging current has dropped to termination
+#       level (7)
+#
+#     V ^                                                        ^ I
+#       .                                                        .
+#       .                                                        .
+# (4)- -.- - - - - - - - - - - - - -  +++++++++++++++++++++++++++.
+#       .                            /                           .
+#       .                     ++++++/++ - - - - - - - - - - - - -.- - (5)
+#       .                     +    /  +                          .
+#       .                     +   -   --                         .
+#       .                     +  -     +                         .
+#       .                     +.-      -:                        .
+#       .                    .+         +`                       .
+#       .                  .- +       | `/                       .
+#       .               .."   +          .:                      .
+#       .             -"      +           --                     .
+#       .    (2)  ..."        +       |    :-                    .
+#       .    ...""            +             -:                   .
+# (3)- -.-.""- - - - -+++++++++ - - - - - - -.:- - - - - - - - - .- - (6)
+#       .             +                       `:.                .
+#       .             +               |         -:               .
+#       .             +                           -:             .
+#       .             +                             ..           .
+#       .   (1)       +               |               "+++- - - -.- - (7)
+#       -++++++++++++++- - - - - - - - - - - - - - - - - + - - - .- - (8)
+#       .                                                +       -
+#       -------------------------------------------------+++++++++-->
+#       |             |       |   CC   |      CV         |
+#       | --trickle-- | -pre- | ---------fast----------- |
+#
+#   The charger uses the following battery properties
+# - trickle-charge-current-microamp:
+#     Current used at trickle-charge phase (8 in above chart)
+#     minimum: 64000
+#     maximum: 1024000
+#     multipleOf: 64000
+# - precharge-current-microamp:
+#     Current used at pre-charge phase (6 in above chart)
+#     minimum: 64000
+#     maximum: 1024000
+#     multipleOf: 64000
+# - constant-charge-current-max-microamp
+#     Current used at fast charge constant current phase (5 in above chart)
+#     minimum: 64000
+#     maximum: 1024000
+#     multipleOf: 64000
+# - constant-charge-voltage-max-microvolt
+#     The constant voltage used in fast charging phase (4 in above chart)
+#     minimum: 2560000
+#     maximum: 19200000
+#     multipleOf: 16000
+# - precharge-upper-limit-microvolt
+#     charging mode is changed from trickle charging to pre-charging
+#     when battery voltage exceeds this limit voltage (3 in above chart)
+#     minimum: 2048000
+#     maximum: 19200000
+#     multipleOf: 64000
+# - re-charge-voltage-microvolt
+#     minimum: 2560000
+#     maximum: 19200000
+#     multipleOf: 16000
+#     re-charging is automatically started when battry has been discharging
+#     to the point where the battery voltage drops below this limit
+# - over-voltage-threshold-microvolt
+#     battery is expected to be faulty if battery voltage exceeds this limit.
+#     Charger will then enter to a "battery faulty" -state
+#     minimum: 2560000
+#     maximum: 19200000
+#     multipleOf: 16000
+# - charge-term-current-microamp
+#     minimum: 0
+#     maximum: 1024000
+#     multipleOf: 64000
+#     a charge cycle terminates when the battery voltage is above recharge
+#     threshold, and the current is below this setting (7 in above chart)
+#   See also Documentation/devicetree/bindings/power/supply/battery.txt
+
+  monitored-battery:
+    description:
+      phandle of battery characteristics devicetree node
+
+  rohm,vsys-regulation-microvolt:
+    description: system specific lower limit for system voltage.
+    minimum: 2560000
+    maximum: 19200000
+    multipleOf: 64000
+
+  rohm,vbus-input-current-limit-microamp:
+    description: system specific VBUS input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+  rohm,vcc-input-current-limit-microamp:
+    description: system specific VCC/VACP input current limit (in microamps).
+    minimum: 32000
+    maximum: 16352000
+    multipleOf: 32000
+
+required:
+  - compatible
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        charger@9 {
+            compatible = "rohm,bd99954";
+            monitored-battery = <&battery>;
+            reg = <0x9>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <29 8>;
+            rohm,vsys-regulation-microvolt = <8960000>;
+            rohm,vbus-input-current-limit-microamp = <1472000>;
+            rohm,vcc-input-current-limit-microamp = <1472000>;
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
