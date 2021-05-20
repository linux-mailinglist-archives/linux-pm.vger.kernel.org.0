Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960D438BA32
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhETXKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 19:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhETXKO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 May 2021 19:10:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89420C06138E;
        Thu, 20 May 2021 16:08:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so21775056ljr.7;
        Thu, 20 May 2021 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkke/HcONrz1nur5ujlnw3lyx3GmqHu2azh4sgzjwjI=;
        b=dc5zdhHqU0+LUEcAkUQQErD7HDoaZp37aXI5yU3KLyl8P2h3O79/tcb+YHwpYl36wp
         sQKequVns1AZ3lp/zLB9VYS+NIw+PhSIk7AEeGVLUfLVB8ZiqUZrx26D8g3ob7Mkbp8P
         kjSf/jfwoVUAWMU+Q06Fpibn3Z8thPLiNeuduEVkwXNWWnmD+6CB0TVRL44bp+dddPNs
         ka0oJvNpnNt/g8Q23B3E56OsCEi694G5bGbyXzl95KEm1KC46uuPLSs+kq86SnkFgEeN
         ALbjDVHeCfHqv+V9cccdp8lQkMTS7auRFkc09TRHcIibKzWBa8OdGUEnsfay22IAWCWH
         7Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkke/HcONrz1nur5ujlnw3lyx3GmqHu2azh4sgzjwjI=;
        b=c6nb9m8PKVEkHps8qizKGwAVGcbmhU6YDzIWwserrZ4aPP9SU0ngiEkewsYgHdQOLM
         dXet/rLCcoC7ajWop+wub9bCDrWoWuJ37rjNQXY4Y0f07uFWTZ8IWdAp6U+dYDiEoTLW
         Wt0Jhvpg/SchYKJsBrIdBiiJVn0BCY0Rgvi5KzEgsCDaVVDgxcaIHpSxYWQcGO39jNNN
         kVWJyoPS+M1GgEV19Iwsihp3FJhEtV+JfYH8k6jfvpemn7viArcjkORoU63UEZXkCPjU
         GLdHfoccNTYbF5J2A2A42dLSXHlUfInAPOeZbFNz6VuKTDQGN0l46IK6Wu/RTqvh2TMI
         hXkg==
X-Gm-Message-State: AOAM533J506Eg6HX/H+kKb9TprCQsBEe/wpQAgnTBRjOfzEdB1j1w11U
        XunqxL/ZjfvtxWzjIxq5TvE=
X-Google-Smtp-Source: ABdhPJy9pwti41z22kCUOZd9W/EHVVqYpH7wzkEFwJKtBSOBK11OfKUN0Girh6l4Pi6D5L0P83LaGA==
X-Received: by 2002:a2e:8859:: with SMTP id z25mr4731480ljj.186.1621552129957;
        Thu, 20 May 2021 16:08:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-76.dynamic.spd-mgts.ru. [109.252.193.76])
        by smtp.gmail.com with ESMTPSA id 4sm427821lfr.175.2021.05.20.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 16:08:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?q?Nikola=20Milosavljevi=C4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 11/13] dt-bindings: soc: tegra-pmc: Document core power domain
Date:   Fri, 21 May 2021 02:07:49 +0300
Message-Id: <20210520230751.26848-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520230751.26848-1-digetx@gmail.com>
References: <20210520230751.26848-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All NVIDIA Tegra SoCs have a core power domain where majority of hardware
blocks reside. Document the new core power domain properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../arm/tegra/nvidia,tegra20-pmc.yaml         | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
index 43fd2f8927d0..0afec83cc723 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
@@ -301,6 +301,33 @@ patternProperties:
 
     additionalProperties: false
 
+  core-domain:
+    type: object
+    description: |
+      The vast majority of hardware blocks of Tegra SoC belong to a
+      Core power domain, which has a dedicated voltage rail that powers
+      the blocks.
+
+    properties:
+      operating-points-v2:
+        description:
+          Should contain level, voltages and opp-supported-hw property.
+          The supported-hw is a bitfield indicating SoC speedo or process
+          ID mask.
+
+      "#power-domain-cells":
+        const: 0
+
+    required:
+      - operating-points-v2
+      - "#power-domain-cells"
+
+    additionalProperties: false
+
+  core-supply:
+    description:
+      Phandle to voltage regulator connected to the SoC Core power rail.
+
 required:
   - compatible
   - reg
@@ -325,6 +352,7 @@ examples:
     tegra_pmc: pmc@7000e400 {
               compatible = "nvidia,tegra210-pmc";
               reg = <0x7000e400 0x400>;
+              core-supply = <&regulator>;
               clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
               clock-names = "pclk", "clk32k_in";
               #clock-cells = <1>;
@@ -338,17 +366,24 @@ examples:
               nvidia,core-power-req-active-high;
               nvidia,sys-clock-req-active-high;
 
+              pd_core: core-domain {
+                      operating-points-v2 = <&core_opp_table>;
+                      #power-domain-cells = <0>;
+              };
+
               powergates {
                     pd_audio: aud {
                             clocks = <&tegra_car TEGRA210_CLK_APE>,
                                      <&tegra_car TEGRA210_CLK_APB2APE>;
                             resets = <&tegra_car 198>;
+                            power-domains = <&pd_core>;
                             #power-domain-cells = <0>;
                     };
 
                     pd_xusbss: xusba {
                             clocks = <&tegra_car TEGRA210_CLK_XUSB_SS>;
                             resets = <&tegra_car TEGRA210_CLK_XUSB_SS>;
+                            power-domains = <&pd_core>;
                             #power-domain-cells = <0>;
                     };
               };
-- 
2.30.2

