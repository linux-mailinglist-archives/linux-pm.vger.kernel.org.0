Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A273BAF74
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jul 2021 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhGDW6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhGDW6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 18:58:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB8C061764;
        Sun,  4 Jul 2021 15:56:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a18so29013990lfs.10;
        Sun, 04 Jul 2021 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSFxsgcC7IB3HSx0ANxMB9mFF3cPs/Q2rIvrPDwZKxo=;
        b=WhSc6MuMyIh3eW/VQ5xdXsll+639MMyJHqC+IO0vAMiA9M1xQlJorU/UjyfCyVfA9c
         Z6rsZ+PZP/MBH9MBuKXCWD05pY6C4oXbat4KiJe1NiCKgwmkAvNHZ6oqugDRDOtncdng
         d6En3fMNaECHn3+LJe31izZBVtMB/ci9jjpbfaKJdyj0i7AQqrGSUMbAaNgTOOfAmCT2
         0RIcEh0tNAqxS4NXhiyZiYw8L2grv/XntHSu9rX5tRbQEY5RSu+vszM9345ftP63AgJJ
         bq2PDxjPYIM81u8VJpIacThfAg+46N85FmqcLYVHsucXUxmgPeuV8WS/77GTuBE1rmZa
         1jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSFxsgcC7IB3HSx0ANxMB9mFF3cPs/Q2rIvrPDwZKxo=;
        b=TUBZjUF66qWE1VsO3J6bsVaYGKsTYpszlPBDw7ZYRlvEIYGn1W45SnIJlfQMFMPRPR
         9uS9wR9P2/2tYH9lSZWgVpGhxarV8gg41da8qsBBqu+pCKVA5ircIwlisObyGHnaue0J
         LjwRmiuaWSL7CXgre/JkcsrYaZTWEAk2dwmXb1J5VS2m/5zzqH0331Xxls0yrZWftYWt
         EclwcxNGSHMTvCKYsG0bQ5bvQhumAgO5O6Gu+0bj4fWKOPqxtmw08Fiic/AjJmnoLdqz
         g7tL0iNPigF0MMxlijoObupWyBX7uVN3Mv3OseN2ymsubQtKU3dJfKdqY3R9w6AsecYs
         7TyA==
X-Gm-Message-State: AOAM532mF9v+oy6kKwNxxS6tydjP27E+yE6yrd15nd6qVqbTuMQioEIK
        9buUlEKKcvknwN4GKwtPLDA=
X-Google-Smtp-Source: ABdhPJwE/dMvQH/Mp8wRg8UmCcyhmsQgDzCvkJAvNMj5yZrkTMAXyPRnjuaV2wkRUezaeEnE02DflQ==
X-Received: by 2002:ac2:46cc:: with SMTP id p12mr7994741lfo.357.1625439361431;
        Sun, 04 Jul 2021 15:56:01 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id i13sm497921lfc.111.2021.07.04.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:56:01 -0700 (PDT)
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
Subject: [PATCH v3 02/12] dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG mode
Date:   Mon,  5 Jul 2021 01:54:23 +0300
Message-Id: <20210704225433.32029-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210704225433.32029-1-digetx@gmail.com>
References: <20210704225433.32029-1-digetx@gmail.com>
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
2.32.0

