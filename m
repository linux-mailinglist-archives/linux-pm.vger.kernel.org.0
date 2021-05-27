Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0A393847
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 23:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhE0Vpt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 17:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhE0Vpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 17:45:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA84C061760;
        Thu, 27 May 2021 14:44:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p20so2706620ljj.8;
        Thu, 27 May 2021 14:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=FXegwalCVFnEXsgeGk1/n14rulDVlLtbIYrjxqso/fjOpN5QdSkK5AUUgOLthsVi+2
         dgOkEoBAGF6zO5EZ4QDuaEH5rrZS5KVwz8ns1K/C2stLaLsdTwhuZaOi/Ms2LFUk/Z0X
         TfbowLyqUtwRSuDRuNQ/u5HxSvDYXcrttetU3kg4fNrAPVLK28XDywrbEAa4dEG0Siqo
         XG0vB3rdsbWArjquLm5knLaHIPFspwl0cYbhR8leC5UIanOgV+sInSrvzvCwFCz6/FoX
         VFlLkyonmA1aQaytTVyusFUtCT5hokH5n7UoqgA2hMuNKKv55EwOCWCx1L7zdGj6apCA
         PKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=cQX4CgJcBWBSqIGsz1jHYENquF4qFtRLCWX27Px7gfU8SVrUDfvQNIQATxMeTiaWJo
         qmiUIGJNxcc2d1Rwjx6e/pyOzlwtx0o1FGDSXmebp2Lhu88Fb9RlfZYg0BXaFPFeuqeq
         +VaKLmolyW+gFb5k6GzzuMBtPeKMVAAGc/jT/QrepCnijZ9xTU7LV/sc8LJT0JJg/zoB
         pjzGNyhnEgcpDbKOXh5Os21+zJ496t50cEIs4cFNvSbCt6PB/ppeDSljz+g1EaEGgGsH
         koxE7YXNw9TDdGSm0OT151jOghAeebLxnWW+xB35ZYCUw8F42VzgSqbu7lyW2pnNJcBA
         BwIw==
X-Gm-Message-State: AOAM530GqSCdz3mHIRBiOu4G7XaPECZA0TAiFIZcAdfFdQDZhUOLJUxe
        np8zoqd+e5DgMX7SmD64tK1+FziJzA8=
X-Google-Smtp-Source: ABdhPJwb4FBmK45V3zumCRnOnWzlQidN1kKvpl4OTPT3g4cB5wHLAj9zh6uxeuY+cZzplyzszQBORQ==
X-Received: by 2002:a2e:9dcf:: with SMTP id x15mr4157662ljj.257.1622151841832;
        Thu, 27 May 2021 14:44:01 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id v11sm298153lfr.44.2021.05.27.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 14:44:01 -0700 (PDT)
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
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
Subject: [PATCH v4 11/14] dt-bindings: soc: tegra-pmc: Document core power domain
Date:   Fri, 28 May 2021 00:43:14 +0300
Message-Id: <20210527214317.31014-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527214317.31014-1-digetx@gmail.com>
References: <20210527214317.31014-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All NVIDIA Tegra SoCs have a core power domain where majority of hardware
blocks reside. Document the new core power domain properties.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
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

