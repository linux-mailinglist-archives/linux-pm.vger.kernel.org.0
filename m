Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52110CA86
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1OpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:45:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37740 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfK1OpR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:45:17 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so18568128ioc.4;
        Thu, 28 Nov 2019 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSx1W6k2m7YVIJkPLFSMsX2YfgHqtWK8uY9ek4Pmf8I=;
        b=X9Blg2OerSCWalXdH509wRdbP/CxlX29WC6jK8xUmtAVF+flTKe3nDE/R80ExoNQg+
         pS4agCBMfd3Vm+UgEKVFKB9UzmB64Bsi2v3m9ReIyiP+9/8/mrkkbp4dI8q4zs2gqk3A
         PzkVqCS36Iewh8ElHtAMwIIxnoM+YEjOmV96rgZHvFHkgAHDpzVY74sv1EXZtVID6Gn1
         qowx6YYdNALYN64bWll/BHYm8m1xSkp6B5G9QanY/Td1fGKoQ+sxva7n08LF8SAkTX3/
         UxT3cY5ZQ5RFNcjPjjZKy2Qtq/mbWZwD+E+3T7L2qgSaz0at0Lv7znMnmtP+khCNHP0A
         omkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSx1W6k2m7YVIJkPLFSMsX2YfgHqtWK8uY9ek4Pmf8I=;
        b=qaZaqLNpJ/dmsQaa1gxPurEXoKh/lnPyhQlKNqIH/LIbuuhdA9K/NmDBFxTDXmP2Im
         bogvGcg2t0ZXXBy/NwDKDPjtGOv+8xrBCVgXggdEdRuk/wK0U7t5vThrv7Vpn3M+b3YF
         6zwBXRF78FFju/6qNpLeEqWQ/z2BmY831mwS+HBYJIeifoONVoZ7gGEzC6D1W6aB/XtT
         I+qIhIWXR/hwlh//71046wqcMeDituTdWY9u8fSlsT5g9XhZfWfTNOx+XgBy6kvwKxv8
         AtzKLNuUKVzZg6TzKTTyMJxrWeuLdGa71zyfa44peSJ0s3xVqKAF2vJNuqitAK25AbZI
         dgVg==
X-Gm-Message-State: APjAAAWCcfU26RGLSXZK7mLfXEPT54YmBFyw+zfswVj1FRWoeGBcVkPg
        N27HD8m4URqdIT1NM5VVoHpeLfETo1Pg+n4c228=
X-Google-Smtp-Source: APXvYqzLCeJzhm0WCeJJ0618OO8UX+1l72IcYyuPZXCOKVkkwktb50xDTqNF45Yemd5l5HIoAr3ZFDwmyA/+m/fzT90=
X-Received: by 2002:a6b:b511:: with SMTP id e17mr12363141iof.18.1574952316211;
 Thu, 28 Nov 2019 06:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20191127052935.1719897-1-anarsoul@gmail.com> <20191127052935.1719897-3-anarsoul@gmail.com>
 <20191127174434.wousbqosmm5vxcsu@gilmour.lan> <CA+E=qVe22T1uhUo6iq9a82Y9bC014CZSkAtSJJNX4qsn6dJL9w@mail.gmail.com>
 <20191128074325.q47rpzhufwog6mbb@gilmour.lan> <CAEExFWs7A4TcB-QcatfR3w1hUX88dC-Sxd=epQppwB7p2CC6SA@mail.gmail.com>
In-Reply-To: <CAEExFWs7A4TcB-QcatfR3w1hUX88dC-Sxd=epQppwB7p2CC6SA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 28 Nov 2019 22:45:04 +0800
Message-ID: <CAEExFWu4MPxA+Vs1BNzCqeR5EkbVT2SjMf6hRBK6nZ2doJmduA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dt-bindings: thermal: add YAML schema for
 sun8i-thermal driver bindings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
new file mode 100644
index 000000000000..1be32f09fcc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sun8i-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner SUN8I Thermal Controller Device Tree Bindings
+
+maintainers:
+  - Yangtao Li <tiny.windzz@gmail.com>
+
+description: |-
+  This describes the device tree binding for the Allwinner thermal
+  controller which measures the on-SoC temperatures.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun8i-a83t-ths
+      - allwinner,sun8i-h3-ths
+      - allwinner,sun8i-r40-ths
+      - allwinner,sun50i-a64-ths
+      - allwinner,sun50i-h5-ths
+      - allwinner,sun50i-h6-ths
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: ths bus clock
+      - description: ths mod clock
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: bus
+      - const: mod
+
+  "#thermal-sensor-cells":
+    enum: [ 0, 1 ]
+
+  nvmem-cells:
+    description: ths calibrate data
+
+  nvmem-cell-names:
+    const: calibration
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#thermal-sensor-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun8i-h3-ths
+              - allwinner,sun8i-r40-ths
+              - allwinner,sun50i-a64-ths
+              - allwinner,sun50i-h5-ths
+              - allwinner,sun50i-h6-ths
+
+    then:
+      properties:
+        resets:
+          minItems: 1
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-ths
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+
+        clock-names:
+          minItems: 1
+          maxItems: 1
+
+    else:
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - allwinner,sun8i-h3-ths
+                - allwinner,sun8i-r40-ths
+                - allwinner,sun50i-a64-ths
+                - allwinner,sun50i-h5-ths
+
+      then:
+        properties:
+          clocks:
+            minItems: 2
+            maxItems: 2
+
+          clock-names:
+            minItems: 2
+            maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun8i-h3-ths
+
+    then:
+      properties:
+        "#thermal-sensor-cells":
+          const: 0
+
+    else:
+      properties:
+        "#thermal-sensor-cells":
+          const: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    ths: ths@5070400 {
+        compatible = "allwinner,sun50i-h6-ths";
+        reg = <0x05070400 0x100>;
+        clocks = <&ccu 89>;
+        clock-names = "bus";
+        resets = <&ccu 36>;
+        interrupts = <0 15 4>;
+        nvmem-cells = <&tsen_calib>;
+        nvmem-cell-names = "calibration";
+        #thermal-sensor-cells = <1>;
+    };
+
+    sid: sid@3006000 {
+        compatible = "allwinner,sun50i-h6-sid";
+        reg = <0x03006000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        tsen_calib: calib@14 {
+                reg = <0x14 6>;
+        };
+    };
+...

On Thu, Nov 28, 2019 at 10:35 PM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> Hi,
>
> How about this?
>
> Best regards,
> Yangtao
