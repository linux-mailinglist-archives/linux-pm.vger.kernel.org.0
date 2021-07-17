Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF13CC55F
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 20:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhGQS0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbhGQS0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 14:26:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17EC061765;
        Sat, 17 Jul 2021 11:23:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g8so15764719lfh.8;
        Sat, 17 Jul 2021 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGqBi/7wx0DIJyQ6zM9lk4bwmMrSqvbRFEiAuewm09c=;
        b=ugjrXjV3ScfVbF4QlFRROL7U62ARM3lX69dozp/g2HtnHb790enf9ytJPIV0q1F0f9
         xl4yPm0Ied2NeSdHRfXlyU6aroOPwDY/zFhumlopFLxjFh5afllJqW2pIvAK/L3j6Oh1
         94KnHBupfeRTmV0yeaFAPTXTyv1vFAx3Wen3QL/5Cz/TpU5N0ITPRvtkol+5AtRaH3WS
         c7dMEh4dAAXIGEe2M0CgNo7Va9PH7TQyPsP2MZK5U7o1O8JmOJRNyaSCdE6pg5h3f2Fg
         N6Zeakt88Ev8FWdkcLSBecBweGUsCvnvSPezwBH/eIIKyToUAVAkAe8RJK6lzHfm9z1j
         i/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGqBi/7wx0DIJyQ6zM9lk4bwmMrSqvbRFEiAuewm09c=;
        b=IcsmhdZ4VNLcqnWp2LfgcTDiFRPQGzTgEQgtPGjEX3dYBp/WtI/eVPovluGkODgzfy
         9MjbIXzoDkmKmS36Pzdk4rqillDvywztHTe9VY5MWxEutu06XcubRNWs9PSB/u92aBDR
         5xbxxIVONH0U+ByqTBPaxivD4cOEaIg5jU355UUdIyiD29uoXeXfDqNcT63OUbnIbCTL
         J0cv97jqH0BrmftNY41I1yAE9UTJmjeh0lmlfwYktIkuzsgpbhqHhvKeK1XRqv1BoXYk
         gfxry2ehs3ZxKmzVIXzrxa+4heF9yHNh/TT68h55UbuYuBYh13ZMj7Z8GR6ylTXZqtif
         AOOQ==
X-Gm-Message-State: AOAM533G/aRIshbEkg9sLbdfwycXocbWUi9Ti0fWd3ygGiq4PBnr2jWl
        ZbybOi33p3bgJX/Y25bM0j0=
X-Google-Smtp-Source: ABdhPJwa8G/trDYqtkZHz301cFFe8bx4TlPv1s/w1m5YNBJYV3EJKRs/6PbS0q71now9L4Wy/cxcYw==
X-Received: by 2002:a19:6e01:: with SMTP id j1mr12837163lfc.407.1626546182932;
        Sat, 17 Jul 2021 11:23:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id z20sm1409532ljk.123.2021.07.17.11.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:23:02 -0700 (PDT)
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
Subject: [PATCH v5 02/12] dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG mode
Date:   Sat, 17 Jul 2021 21:21:24 +0300
Message-Id: <20210717182134.30262-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717182134.30262-1-digetx@gmail.com>
References: <20210717182134.30262-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to support OTG mode we need these new properties:

	- interrupt
	- nvidia,pmc

Add the new properties to the binding.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.yaml
index 593187234e6a..dfde0eaf66e1 100644
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
@@ -199,6 +202,15 @@ properties:
     maxItems: 1
     description: GPIO used to reset the PHY.
 
+  nvidia,pmc:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to Power Management controller.
+          - description: USB controller ID.
+    description:
+      Phandle to Power Management controller.
+
 required:
   - compatible
   - reg
@@ -320,6 +332,7 @@ examples:
         compatible = "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
         reg = <0x7d008000 0x4000>,
               <0x7d000000 0x4000>;
+        interrupts = <0 97 4>;
         phy_type = "utmi";
         clocks = <&tegra_car TEGRA124_CLK_USB3>,
                  <&tegra_car TEGRA124_CLK_PLL_U>,
@@ -338,6 +351,7 @@ examples:
         nvidia,hssquelch-level = <2>;
         nvidia,hsdiscon-level = <5>;
         nvidia,xcvr-hsslew = <12>;
+        nvidia,pmc = <&tegra_pmc 2>;
     };
 
   - |
@@ -346,6 +360,7 @@ examples:
     usb-phy@c5004000 {
         compatible = "nvidia,tegra20-usb-phy";
         reg = <0xc5004000 0x4000>;
+        interrupts = <0 21 4>;
         phy_type = "ulpi";
         clocks = <&tegra_car TEGRA20_CLK_USB2>,
                  <&tegra_car TEGRA20_CLK_PLL_U>,
@@ -354,4 +369,5 @@ examples:
         resets = <&tegra_car 58>, <&tegra_car 22>;
         reset-names = "usb", "utmi-pads";
         #phy-cells = <0>;
+        nvidia,pmc = <&tegra_pmc 1>;
     };
-- 
2.32.0

