Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C393B997E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhGAXq0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhGAXqZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F2C061762;
        Thu,  1 Jul 2021 16:43:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r16so10817954ljk.9;
        Thu, 01 Jul 2021 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GPfDEmQQJhXgHdxr1BFSN2ruNpULfNm16Js3A20DV4=;
        b=H0NwiYxrpC/IPsMqOLBtWoyM2ObE+wt15XSLmM2lYjLAYx5Up6ZUnSrwvmCcNptLti
         57/yTXuiCzoU6t/alk/AL6AEe+819DmBaYs7SANK1LgN9cTYbxDgjZBFyFDWkSuah3gR
         9xFir7rucR986XVnB+3Bogt6GoDD5t8gHBrkEyyssLLmeSBZ7Kg4aFuVYIjBIpA9niao
         IJCTulUeAjorCxrHdMQC6Su5fVkjRx8Xk2gV7UzxSnBVfouy90FQ38V2wIwotTTGDCem
         lHMeSfhwARqtW4qfz6bp/hrKvOkckvF1eMQ/lJh0i8T9j5JJ5zsgQge6FT6RtAAH2IH2
         TzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GPfDEmQQJhXgHdxr1BFSN2ruNpULfNm16Js3A20DV4=;
        b=CaT2SbRxR5rXTauYdIhOqeH3F8kRt5nJkGHQOLy34l+I6t5captcgnd5mdVG8PfdJk
         LZDQc34MLHam/g/rHmC2XneWMYMkPVgfHdaN81mEovwy/HXwHsIKTSEleE6/V5cv6wxW
         /kpCEpuyZTCylKK+bbyrWggo8NAJYcmzr82YFyy/7On5AoDIOHhCh0+TZ4I4M8xLyV9d
         ARq4JiOb0lZAs69kaDNdpLrelGQyoZwC2ILW/MsBP2ra/D5vx2KsRHVEr/x0PLloVhlZ
         R702XYQZvxuGmDkTCRg3ZHcDdURym0CnLbNoTT58gA3VTEIPZrazLuEE8SFFU14TzYc+
         9e2A==
X-Gm-Message-State: AOAM533HLWNOrkgIS6ga12RxHzR/At13vetYUdCfzVL41IniMrC0iXqK
        xG0/DVcCzNyCefbddznoDHE=
X-Google-Smtp-Source: ABdhPJy9+JS94Te3RYhlizxvb/3uD9uANXA8P80xYZBTQ+EUgh6/j2j040wImxT1a+2/MMqrgG6zwQ==
X-Received: by 2002:a2e:7306:: with SMTP id o6mr1522013ljc.125.1625183031093;
        Thu, 01 Jul 2021 16:43:51 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 01/12] dt-bindings: phy: tegra20-usb-phy: Convert to schema
Date:   Fri,  2 Jul 2021 02:43:06 +0300
Message-Id: <20210701234317.26393-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert NVIDIA Tegra20 USB PHY binding to schema.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/phy/nvidia,tegra20-usb-phy.txt   |  74 ----
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml  | 357 ++++++++++++++++++
 2 files changed, 357 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
deleted file mode 100644
index 1aa6f2674af5..000000000000
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt
+++ /dev/null
@@ -1,74 +0,0 @@
-Tegra SOC USB PHY
-
-The device node for Tegra SOC USB PHY:
-
-Required properties :
- - compatible : For Tegra20, must contain "nvidia,tegra20-usb-phy".
-   For Tegra30, must contain "nvidia,tegra30-usb-phy".  Otherwise, must contain
-   "nvidia,<chip>-usb-phy" plus at least one of the above, where <chip> is
-   tegra114, tegra124, tegra132, or tegra210.
- - reg : Defines the following set of registers, in the order listed:
-   - The PHY's own register set.
-     Always present.
-   - The register set of the PHY containing the UTMI pad control registers.
-     Present if-and-only-if phy_type == utmi.
- - phy_type : Should be one of "utmi", "ulpi" or "hsic".
- - clocks : Defines the clocks listed in the clock-names property.
- - clock-names : The following clock names must be present:
-   - reg: The clock needed to access the PHY's own registers. This is the
-     associated EHCI controller's clock. Always present.
-   - pll_u: PLL_U. Always present.
-   - timer: The timeout clock (clk_m). Present if phy_type == utmi.
-   - utmi-pads: The clock needed to access the UTMI pad control registers.
-     Present if phy_type == utmi.
-   - ulpi-link: The clock Tegra provides to the ULPI PHY (usually pad DAP_MCLK2
-     with pad group aka "nvidia,pins" cdev2 and pin mux option config aka
-     "nvidia,function" pllp_out4).
-     Present if phy_type == ulpi, and ULPI link mode is in use.
- - resets : Must contain an entry for each entry in reset-names.
-   See ../reset/reset.txt for details.
- - reset-names : Must include the following entries:
-   - usb: The PHY's own reset signal.
-   - utmi-pads: The reset of the PHY containing the chip-wide UTMI pad control
-     registers. Required even if phy_type == ulpi.
-
-Required properties for phy_type == ulpi:
-  - nvidia,phy-reset-gpio : The GPIO used to reset the PHY.
-
-Required PHY timing params for utmi phy, for all chips:
-  - nvidia,hssync-start-delay : Number of 480 Mhz clock cycles to wait before
-    start of sync launches RxActive
-  - nvidia,elastic-limit : Variable FIFO Depth of elastic input store
-  - nvidia,idle-wait-delay : Number of 480 Mhz clock cycles of idle to wait
-    before declare IDLE.
-  - nvidia,term-range-adj : Range adjusment on terminations
-  - Either one of the following for HS driver output control:
-    - nvidia,xcvr-setup : integer, uses the provided value.
-    - nvidia,xcvr-setup-use-fuses : boolean, indicates that the value is read
-      from the on-chip fuses
-    If both are provided, nvidia,xcvr-setup-use-fuses takes precedence.
-  - nvidia,xcvr-lsfslew : LS falling slew rate control.
-  - nvidia,xcvr-lsrslew :  LS rising slew rate control.
-
-Required PHY timing params for utmi phy, only on Tegra30 and above:
-  - nvidia,xcvr-hsslew : HS slew rate control.
-  - nvidia,hssquelch-level : HS squelch detector level.
-  - nvidia,hsdiscon-level : HS disconnect detector level.
-
-Optional properties:
-  - nvidia,has-legacy-mode : boolean indicates whether this controller can
-    operate in legacy mode (as APX 2500 / 2600). In legacy mode some
-    registers are accessed through the APB_MISC base address instead of
-    the USB controller.
-  - nvidia,is-wired : boolean. Indicates whether we can do certain kind of power
-    optimizations for the devices that are always connected. e.g. modem.
-  - dr_mode : dual role mode. Indicates the working mode for the PHY. Can be
-    "host", "peripheral", or "otg". Defaults to "host" if not defined.
-      host means this is a host controller
-      peripheral means it is device controller
-      otg means it can operate as either ("on the go")
-  - nvidia,has-utmi-pad-registers : boolean indicates whether this controller
-    contains the UTMI pad control registers common to all USB controllers.
-
-VBUS control (required for dr_mode == otg, optional for dr_mode == host):
-  - vbus-supply: regulator for VBUS
diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
new file mode 100644
index 000000000000..593187234e6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
@@ -0,0 +1,357 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nvidia,tegra20-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra USB PHY
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - nvidia,tegra124-usb-phy
+              - nvidia,tegra114-usb-phy
+          - enum:
+              - nvidia,tegra30-usb-phy
+      - items:
+          - enum:
+              - nvidia,tegra30-usb-phy
+              - nvidia,tegra20-usb-phy
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    description: |
+      PHY0 and PHY2 share power and ground, PHY0 contains shared registers.
+      PHY0 and PHY2 must specify two register sets, where the first set is
+      PHY own registers and the second set is the PHY0 registers.
+
+  clocks:
+    anyOf:
+      - items:
+          - description: Registers clock
+          - description: Main PHY clock
+
+      - items:
+          - description: Registers clock
+          - description: Main PHY clock
+          - description: ULPI PHY clock
+
+      - items:
+          - description: Registers clock
+          - description: Main PHY clock
+          - description: UTMI pads control registers clock
+
+      - items:
+          - description: Registers clock
+          - description: Main PHY clock
+          - description: UTMI timeout clock
+          - description: UTMI pads control registers clock
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: reg
+          - const: pll_u
+
+      - items:
+          - const: reg
+          - const: pll_u
+          - const: ulpi-link
+
+      - items:
+          - const: reg
+          - const: pll_u
+          - const: utmi-pads
+
+      - items:
+          - const: reg
+          - const: pll_u
+          - const: timer
+          - const: utmi-pads
+
+  resets:
+    oneOf:
+      - maxItems: 1
+        description: PHY reset
+
+      - items:
+          - description: PHY reset
+          - description: UTMI pads reset
+
+  reset-names:
+    oneOf:
+      - const: usb
+
+      - items:
+          - const: usb
+          - const: utmi-pads
+
+  "#phy-cells":
+    const: 0
+
+  phy_type:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [utmi, ulpi, hsic]
+
+  dr_mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [host, peripheral, otg]
+    default: host
+
+  vbus-supply:
+    description: Regulator controlling USB VBUS.
+
+  nvidia,has-legacy-mode:
+    description: |
+      Indicates whether this controller can operate in legacy mode
+      (as APX 2500 / 2600). In legacy mode some registers are accessed
+      through the APB_MISC base address instead of the USB controller.
+    type: boolean
+
+  nvidia,is-wired:
+    description: |
+      Indicates whether we can do certain kind of power optimizations for
+      the devices that are always connected. e.g. modem.
+    type: boolean
+
+  nvidia,has-utmi-pad-registers:
+    description: |
+      Indicates whether this controller contains the UTMI pad control
+      registers common to all USB controllers.
+    type: boolean
+
+  nvidia,hssync-start-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+    description: |
+      Number of 480 MHz clock cycles to wait before start of sync launches
+      RxActive.
+
+  nvidia,elastic-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+    description: Variable FIFO Depth of elastic input store.
+
+  nvidia,idle-wait-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+    description: |
+      Number of 480 MHz clock cycles of idle to wait before declare IDLE.
+
+  nvidia,term-range-adj:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description: Range adjustment on terminations.
+
+  nvidia,xcvr-setup:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 127
+    description: Input of XCVR cell, HS driver output control.
+
+  nvidia,xcvr-setup-use-fuses:
+    description: Indicates that the value is read from the on-chip fuses.
+    type: boolean
+
+  nvidia,xcvr-lsfslew:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: LS falling slew rate control.
+
+  nvidia,xcvr-lsrslew:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: LS rising slew rate control.
+
+  nvidia,xcvr-hsslew:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 511
+    description: HS slew rate control.
+
+  nvidia,hssquelch-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description: HS squelch detector level.
+
+  nvidia,hsdiscon-level:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: HS disconnect detector level.
+
+  nvidia,phy-reset-gpio:
+    maxItems: 1
+    description: GPIO used to reset the PHY.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#phy-cells"
+  - phy_type
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        phy_type:
+          const: utmi
+
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        resets:
+          maxItems: 2
+
+        reset-names:
+          maxItems: 2
+
+      required:
+        - nvidia,hssync-start-delay
+        - nvidia,elastic-limit
+        - nvidia,idle-wait-delay
+        - nvidia,term-range-adj
+        - nvidia,xcvr-lsfslew
+        - nvidia,xcvr-lsrslew
+
+      anyOf:
+        - required: ["nvidia,xcvr-setup"]
+        - required: ["nvidia,xcvr-setup-use-fuses"]
+
+      if:
+        properties:
+          compatible:
+            contains:
+              const: nvidia,tegra30-usb-phy
+
+      then:
+        properties:
+          clocks:
+            maxItems: 3
+
+          clock-names:
+            items:
+              - const: reg
+              - const: pll_u
+              - const: utmi-pads
+
+        required:
+          - nvidia,xcvr-hsslew
+          - nvidia,hssquelch-level
+          - nvidia,hsdiscon-level
+
+        else:
+          properties:
+            clocks:
+              maxItems: 4
+
+            clock-names:
+              items:
+                - const: reg
+                - const: pll_u
+                - const: timer
+                - const: utmi-pads
+
+  - if:
+      properties:
+        phy_type:
+          const: ulpi
+
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+
+        clocks:
+          minItems: 2
+          maxItems: 3
+
+        clock-names:
+          minItems: 2
+          maxItems: 3
+
+          oneOf:
+            - items:
+                - const: reg
+                - const: pll_u
+
+            - items:
+                - const: reg
+                - const: pll_u
+                - const: ulpi-link
+
+        resets:
+          minItems: 1
+          maxItems: 2
+
+        reset-names:
+          minItems: 1
+          maxItems: 2
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra124-car.h>
+
+    usb-phy@7d008000 {
+        compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
+        reg = <0x7d008000 0x4000>,
+              <0x7d000000 0x4000>;
+        phy_type = "utmi";
+        clocks = <&tegra_car TEGRA124_CLK_USB3>,
+                 <&tegra_car TEGRA124_CLK_PLL_U>,
+                 <&tegra_car TEGRA124_CLK_USBD>;
+        clock-names = "reg", "pll_u", "utmi-pads";
+        resets = <&tegra_car 59>, <&tegra_car 22>;
+        reset-names = "usb", "utmi-pads";
+        #phy-cells = <0>;
+        nvidia,hssync-start-delay = <0>;
+        nvidia,idle-wait-delay = <17>;
+        nvidia,elastic-limit = <16>;
+        nvidia,term-range-adj = <6>;
+        nvidia,xcvr-setup = <9>;
+        nvidia,xcvr-lsfslew = <0>;
+        nvidia,xcvr-lsrslew = <3>;
+        nvidia,hssquelch-level = <2>;
+        nvidia,hsdiscon-level = <5>;
+        nvidia,xcvr-hsslew = <12>;
+    };
+
+  - |
+    #include <dt-bindings/clock/tegra20-car.h>
+
+    usb-phy@c5004000 {
+        compatible = "nvidia,tegra20-usb-phy";
+        reg = <0xc5004000 0x4000>;
+        phy_type = "ulpi";
+        clocks = <&tegra_car TEGRA20_CLK_USB2>,
+                 <&tegra_car TEGRA20_CLK_PLL_U>,
+                 <&tegra_car TEGRA20_CLK_CDEV2>;
+        clock-names = "reg", "pll_u", "ulpi-link";
+        resets = <&tegra_car 58>, <&tegra_car 22>;
+        reset-names = "usb", "utmi-pads";
+        #phy-cells = <0>;
+    };
-- 
2.30.2

