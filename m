Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D863B997D
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhGAXqZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhGAXqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:46:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720D8C061764;
        Thu,  1 Jul 2021 16:43:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u20so10780956ljo.12;
        Thu, 01 Jul 2021 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adJQUfPeiRUepTm54Dxm95RAQuwCijRoZlMsrd5sNGE=;
        b=t4WwozpdNtQFm35n9vvIaC+3/5uF/mj+RGDBfVbac6Q8gdx0e68DgGpBd/ZWYnYRy5
         rRJVfBUY8GSWhsez485W9CfUou+UtylEFooQ9N3acejkPXqFqj6D7wUWCaxK4K8hSAjZ
         dCAw1d+zqsdcJFhE30UelMsJHRf7D1gAoqXbOzaCZy3sa/lflKUGE4cAZBtiDKLf7JFA
         mghrjxXa9UlzKnmP+NQy9DTYZ121pCOYqwRynadzRZdXQUeKFOj+ZF0JA8TYiNq1Netg
         8Nzqo48/GVlB9pTLFVmoS/r3lU/RnW7yxxjQhKka5IvrIFW+eR4RTtwN1DzQSSNz9QEH
         Wu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adJQUfPeiRUepTm54Dxm95RAQuwCijRoZlMsrd5sNGE=;
        b=pYKEvQkTkcc4esOndwOOuJley7kD2ks8BBaNUqNfOoNqeARAQBKPwkimPnO5JnLdxn
         2aisci2qif0/W8wmQ9AbAc4sDXZ5jpMYJiT7+DjtO0Za3qseadnEzhfcSTWBA+5Pc2UQ
         CJbxBRy/6JFgmCKyWYFT94SSlWQXrSYLuWNGv5tTrftmzuDn1UU9iXSlqjdgdJc4VF8P
         OU3TAwZ8PbCRCL3hN/3D54lB4k61+G5/wzntIDc4+IFtbduXB0qj8x8I/Z9bj5RMICBw
         8jH/R9E2U8L2TllMOQ+Rj2/lw5BuAhL8ko2+B8k42uAI7npjgnTAlQ/rA3Qr0lYrp/Kz
         EA8w==
X-Gm-Message-State: AOAM532jiK7rsxH47IgPYRFREA7iVlKMkhhy+WaLaA3w6a/g6atgQBny
        L4mugxkRc3/qMOv2GZdHBwY=
X-Google-Smtp-Source: ABdhPJwVf6Y/f55g2R6MJe4/lIwGUkfZNzgt5agcmDHckVkkenxJG89Yu0PLVAPgVPtTYj4gZ9gtHw==
X-Received: by 2002:a2e:9152:: with SMTP id q18mr1510345ljg.493.1625183031834;
        Thu, 01 Jul 2021 16:43:51 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e23sm60743lfq.221.2021.07.01.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:43:51 -0700 (PDT)
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
Subject: [PATCH v2 02/12] dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG mode
Date:   Fri,  2 Jul 2021 02:43:07 +0300
Message-Id: <20210701234317.26393-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701234317.26393-1-digetx@gmail.com>
References: <20210701234317.26393-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to support OTG mode we need these new properties:

	- interrupt
	- nvidia,pmc
	- nvidia,phy-instance

The nvidia,phy-instance isn't strictly needed for the OTG mode since we
know that only first controller supports it in practice, but it will be
needed in general for supporting more complex hardware features that
require knowledge of the PHY offset within common registers of the Power
Management controller (PMC).

Add the new properties to the bindings.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
index 593187234e6a..a108f1552042 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
@@ -77,6 +77,9 @@ properties:
           - const: timer
           - const: utmi-pads
 
+  interrupts:
+    maxItems: 1
+
   resets:
     oneOf:
       - maxItems: 1
@@ -199,6 +202,17 @@ properties:
     maxItems: 1
     description: GPIO used to reset the PHY.
 
+  nvidia,pmc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to Power Management controller.
+
+  nvidia,phy-instance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 2
+    description: Unique hardware ID.
+
 required:
   - compatible
   - reg
@@ -320,6 +334,7 @@ examples:
         compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
         reg = <0x7d008000 0x4000>,
               <0x7d000000 0x4000>;
+        interrupts = <0 97 4>;
         phy_type = "utmi";
         clocks = <&tegra_car TEGRA124_CLK_USB3>,
                  <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -338,6 +353,8 @@ examples:
         nvidia,hssquelch-level = <2>;
         nvidia,hsdiscon-level = <5>;
         nvidia,xcvr-hsslew = <12>;
+        nvidia,pmc = <&tegra_pmc>;
+        nvidia,phy-instance= <2>;
     };
 
   - |
@@ -346,6 +363,7 @@ examples:
     usb-phy@c5004000 {
         compatible = "nvidia,tegra20-usb-phy";
         reg = <0xc5004000 0x4000>;
+        interrupts = <0 21 4>;
         phy_type = "ulpi";
         clocks = <&tegra_car TEGRA20_CLK_USB2>,
                  <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -354,4 +372,6 @@ examples:
         resets = <&tegra_car 58>, <&tegra_car 22>;
         reset-names = "usb", "utmi-pads";
         #phy-cells = <0>;
+        nvidia,pmc = <&tegra_pmc>;
+        nvidia,phy-instance= <1>;
     };
-- 
2.30.2

