Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333D1393785
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhE0Utt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhE0Utn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 16:49:43 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C42C06138A;
        Thu, 27 May 2021 13:48:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x38so2001718lfa.10;
        Thu, 27 May 2021 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=fXdyrKn2PV9pBQVHK78mBIFDGIcokAfVdJiGVYOSFe9ueSTUASVS2vpAC8vxvR4/+f
         MJyzjJC8cEn4ueHeqKT79JqqdeZJwy6KHb9TY0UvBaypKFEr6iHkVtjvZ4V5GnIdtTHe
         tzCY8wt+R6nvrb6YIMJMdBh/Hma03onFppk5AEw8Pl88NYRbTUR31VMGBOGyEszs7NH3
         yvOBUxS3EOMY3lTX/uPkgkCfWIcbDgxyOF0h+xNpweQ1Cze/WX+/xerYRQvP+xqHitX6
         3bVJbAxzwExRyswpbrdRscE0aXRh9g9Xueyg/9/vdMuWEBlbtEJswGEzgVfWA2q2Dg13
         6IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=PLMDOwawBHiw0MOoZhsVJtJH6q9IAXpcTh5IQW3syNruqzMUz0e/YlKflxLQE9sh9q
         kgN9fd3CWU1ssqI8ULA+efo7iNZ/KuhnVp6pAROlc0hZAP/Wbh9y66IHgeMwWbXc80fw
         ouBBNx2GGEtVMXDRSFuE+89w0hGFAdQeXYmmgyU/nzGBzZuvHnxqEwmFsp0LuEmX0wEA
         fChk38JQSRtnXDRrw1+v1XWZ4YCu6KEpUUs0yyAZKn3JlGldU8MPSNpM7v7rIjfKROxs
         c2eVANNEaTzCmWQQHn41OfgN/k+D2EbtfjDOz++FuECkXxy56URVhk8+mHTRUjRe0VXU
         OGNg==
X-Gm-Message-State: AOAM530DxyQG04xLmotMag6NcBBnWwFSfDtOBKZk3VlfkVYhrxop1eTk
        Ittb1J80+WLEiSdCuYyR1UE=
X-Google-Smtp-Source: ABdhPJzMClJ9BTyw0M0W1DeKgeBj/8t0zVMuqRA6WVG/KxJEVE7QopcFAnTDxFWPn3oLiBeH8Pwthg==
X-Received: by 2002:a05:6512:1392:: with SMTP id p18mr3498349lfa.294.1622148486337;
        Thu, 27 May 2021 13:48:06 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id 10sm347297ljq.39.2021.05.27.13.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:48:05 -0700 (PDT)
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
Subject: [PATCH v3 11/14] dt-bindings: soc: tegra-pmc: Document core power domain
Date:   Thu, 27 May 2021 23:47:39 +0300
Message-Id: <20210527204742.10379-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527204742.10379-1-digetx@gmail.com>
References: <20210527204742.10379-1-digetx@gmail.com>
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

