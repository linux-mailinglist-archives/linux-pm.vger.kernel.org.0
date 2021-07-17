Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AECC3CC328
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhGQMOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 08:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhGQMO0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Jul 2021 08:14:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BEEC06175F;
        Sat, 17 Jul 2021 05:11:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s18so17894028ljg.7;
        Sat, 17 Jul 2021 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGqBi/7wx0DIJyQ6zM9lk4bwmMrSqvbRFEiAuewm09c=;
        b=rxl/vB5MFpPfhWSNkV0IKayy4fstQuNK5+gA/ImsnTzQUiEKIyCOYhXg+I3iBRmweu
         1OFdEchjkJGeDWZRnTbXs4cJX8myugG0v8KPL0q1V3TYSFUr7e/sM/g2KlpcnUR6ryxL
         kPw0VjHs6Cr3AhOMjr5XNMEKTruivIXi3CI9IlWkUhetatMvaej3QxfuGUFnE0rhdIgR
         eEjJNi0PWn0a+ibtd0hRsS9EnEvoYUnJNbMnUAK+m5IXkbv1Hw8++XQBnYxcDoeUXaS4
         Sj39ZYXsFPk7Se1j4Gb+NviCSYgfg34r5GtzjP1wJrBo1Y8ZBxybESgWTBgfPRFv9H1n
         GJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGqBi/7wx0DIJyQ6zM9lk4bwmMrSqvbRFEiAuewm09c=;
        b=iXztN6WqCdfDO8ZUHlQfI4ZbGc1ma2s1GYKtWU1aPxGCXLMVJZ0HNBmQYC+C9fxpNe
         TaX6gUxuvSPX2gNVsgbnePcKe30p8JjEfFy+uLyYl/ASZ6fsxkKIccMPOx69ZLmoLP4/
         4YLug6DefhqRJMZSMeNvDPGsjFb6jwDDlAlH7WaE5Y610zzV8nwG/x4E2vR93D9FxiH7
         q5R0yGy/CamzHVnxmAbuZOkmnHbmou5Um4+ADljuOGp8Cgy5WcrIrVkn18PyWizSOqQm
         S60kFtD802ovnUok20Gfz2WLjz/cKF04sRpjMp8yTpUSq0hfuxpCcuJcLXevkmnv3Fl4
         yGcw==
X-Gm-Message-State: AOAM5327ZEuaKeGsWL3eZGv++sfx25YsMrv2DD+xIajhwUYImxoxvLKW
        U25BW/AjO1dgZUi9FP55HjLEMzSwwOk=
X-Google-Smtp-Source: ABdhPJyqYYAzyT9mXLM05ER5Bi3BMwjo8Zmmwev7fIPaN22lP0qMspS1aHO57ohoSRpECOkpANzozg==
X-Received: by 2002:a2e:6111:: with SMTP id v17mr13676423ljb.27.1626523887132;
        Sat, 17 Jul 2021 05:11:27 -0700 (PDT)
Received: from localhost.localdomain (46-138-17-250.dynamic.spd-mgts.ru. [46.138.17.250])
        by smtp.gmail.com with ESMTPSA id m16sm852597lfq.23.2021.07.17.05.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 05:11:26 -0700 (PDT)
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
Subject: [PATCH v4 02/12] dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG mode
Date:   Sat, 17 Jul 2021 15:11:02 +0300
Message-Id: <20210717121112.3248-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717121112.3248-1-digetx@gmail.com>
References: <20210717121112.3248-1-digetx@gmail.com>
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

