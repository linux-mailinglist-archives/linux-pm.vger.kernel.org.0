Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E053B8C1B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jul 2021 04:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhGAC1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 22:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbhGAC1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 22:27:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730EC061756;
        Wed, 30 Jun 2021 19:24:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so8813188lfv.13;
        Wed, 30 Jun 2021 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adJQUfPeiRUepTm54Dxm95RAQuwCijRoZlMsrd5sNGE=;
        b=cp0NpAnDbAvL1gtaKp24aW4YAYHedFi6pBz8miFxT8PiwLGqoq15kgobcV0C+Rx9QV
         nn9XXL3Yt53SlGLzpayNWlkJ/0hZg01a0lXYzPm/kSnDKYVaPlVHNk7gtzAsKzxw8QeM
         KambJMloW2Bf63tKRe8icM51eFF2LuXSQE2wvgK3p/2B3npuUoWMtG0LyKljDix8agXc
         k/fCHOjrn1nIdac7Rc1SyCVa+oiisnCSDeic2wnuZf464Muf3Sd0tdEHsYDQYMQG4Bxr
         Y7c6vRiKoqeeHmcZQ3to4WlZrrkmqxJm8K00GGx3tjtDAWoinqQeVoxkur+/hHiXnXdm
         9p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adJQUfPeiRUepTm54Dxm95RAQuwCijRoZlMsrd5sNGE=;
        b=QUV3tOfREq74H2GRfp+tM4l7O4FwqC7dpKeprCZM2SV0UIo2PiNheIe2KjYVJ/J7Fu
         H78+o5omNYgwubFUmQhJ6MQVUtZKdzMfkMo3D7HgZ7hOf4r6utPc8goRJLxfRPp6940x
         054+SUFezA7ae3mD9XtKXIM1gg4vG+mNjwc2vixebHcqA9Mj78GqbYntNWpDq4b6vaPV
         YwH1KSED79vSRcCau3jQs1ifLv8i9cSkWzalDYPDpxURMO98NPetE60W7NxtF2fZ7pEa
         b7Dliq6ARGe3iPSq3Nl3cqOsUV7EbpAIhiAq9P5T/Qf65DK5+XBcKQNzTeLR5/ohPZZt
         tDQg==
X-Gm-Message-State: AOAM531mftTLfsXVDbPq8fLwpMkcTxrbVwjnp1sCeq4fM05lKzS+bG6o
        r4ido/P8Apd4TXaDsKPjntE=
X-Google-Smtp-Source: ABdhPJyZDcm45l/QcUDiHS/Tc4ugJPpHVJlwGCb6C7LRg4spWOGgMmFQMVShPlePDSiA0GD3IQVCRw==
X-Received: by 2002:a05:6512:694:: with SMTP id t20mr5331424lfe.344.1625106285937;
        Wed, 30 Jun 2021 19:24:45 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id v7sm2407262ljn.14.2021.06.30.19.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 19:24:45 -0700 (PDT)
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
Subject: [PATCH v1 02/12] dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG mode
Date:   Thu,  1 Jul 2021 05:23:55 +0300
Message-Id: <20210701022405.10817-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701022405.10817-1-digetx@gmail.com>
References: <20210701022405.10817-1-digetx@gmail.com>
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

