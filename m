Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7A3DC746
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jul 2021 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhGaRjJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Jul 2021 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhGaRjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Jul 2021 13:39:07 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99631C06175F;
        Sat, 31 Jul 2021 10:39:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x8so11575575lfe.3;
        Sat, 31 Jul 2021 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DJ1MRIl0Zi+gsGIXueupXObT5Ha/664YNw+4KYR5oE=;
        b=Ndo/ln/LJgucIkXa+NdYmveNGbw7EB0EycmBkU6pH0M0NgyaKcABlSipaVW0gG7ixa
         evZyBYAelq8cgmkkIeQHTbnVd3Scxvlahs6vFbiXEC2pHXvZ756Aj0gCWf/1FkJr+9qA
         u5C9ksEmCwqzcFPL0bOl0w0dYr6jnPxTdtxizBirH2Wv4ZFbgQoRGEASLOl6Rd5RU0wW
         +IoJZFfTMeUJSFr/fy3wmIKc1nA6FSO+u8X1eq+XYRhRORiQ5oQ0Eq+6TAZd0kLhCO6S
         Ql1Kq99PUGQ34l5E0etYHLvQTRI/xDFOWjy/RVp96l4sCfVBvDFEkWF1WBUSGEgyBZE+
         /A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DJ1MRIl0Zi+gsGIXueupXObT5Ha/664YNw+4KYR5oE=;
        b=cbV8lecT0GtgtM9MVLfezKhlt4a9Y0U9ChVJy+FqrRKZ9RWuHjo0O2BTdxpOLDTUCe
         ZhZL80tvdrIG8/3PwWXpo2XmnKYHFstwDveRjkk6L1YzQLmH+IPvlsSljF099/5VdhxC
         n1q3e4Uht7Ldn7DP8EZ6dRDGAUWw9YVxcv1caGkHNbUchRoYcBcYVWnEcOIg6M5h+Kr7
         C3SSBa1MjpFlhB90r4ilzI2+EPw5UBi15TIKAwvb7T8AIsItFaJ4/0nXoLIs9lVorIpl
         HEoi7ehMjGHeL7ueCSJfi8WcFxv/2pKakx+UYllrzWcl8nIxc/MUmdpPLxCLg4pbCy4m
         QrmQ==
X-Gm-Message-State: AOAM531d1MxQquN824zr8FNSQ71RHqfuVTdm/IRXCqdXUvSSNluY6Iux
        TjZ+xHPrpzk8pqSa0gcUx9s=
X-Google-Smtp-Source: ABdhPJxgHNYiE+5NaS0/ziBWbqk4fopEsqMpJ4w3ZxUPSpHh7NZ87dPKFcO9f2xp+kpfvEl3MrC2FQ==
X-Received: by 2002:ac2:4d99:: with SMTP id g25mr6012481lfe.643.1627753138995;
        Sat, 31 Jul 2021 10:38:58 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id s15sm445272lfp.216.2021.07.31.10.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:38:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v6 02/12] dt-bindings: phy: tegra20-usb-phy: Document properties needed for OTG mode
Date:   Sat, 31 Jul 2021 20:38:32 +0300
Message-Id: <20210731173842.19643-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731173842.19643-1-digetx@gmail.com>
References: <20210731173842.19643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to support OTG mode we need these new properties:

	- interrupt
	- nvidia,pmc

Add the new properties to the binding.

Reviewed-by: Rob Herring <robh@kernel.org>
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

