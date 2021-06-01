Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D246E396B54
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 04:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhFACf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhFACfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:35:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3CC0613ED;
        Mon, 31 May 2021 19:33:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a5so19409620lfm.0;
        Mon, 31 May 2021 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=Hu8yWa/HV/bSa/3P67EVQvdbUp+jOHQrhmOwm8fb/KKpfDIvQ3LOTkI/8LdxYdbEg/
         EDHIvB9F2/mPpmzm+JGNBKk4WfsoYRUITh+IWoj08Id8aT1UdeRSTx9sSmhefEipre3J
         p3noicxcCKSP0BtfKf3Ubdtl++bag2RhRrNxshVBNfBrdF3zeuL5b4YdQK454y1CLygU
         el5F0xTSPrd3BoC6JCrvDUxidn7o6ibBzdD0Ms4BsOKyFFxJ2w+wb5zNC/ETHTQ8Jw+A
         TGlnhBWelDche0i9D3WXU/a5l02pe9eWQ1Mfo99B7QrP3NnW2RbKHC6SVWSeU6s8PJds
         8VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=kBaB4rOV5OUpmxhwJGdB5CbzU2KWEM4vWQU2Ss/+SuVIIDnuHgqn13ftytOJ/DsliZ
         uUL09zsyq35XrHZKd3eGWd7Kehft076g9IJmkNabPas0L7QDpUGcDBPt05AtXn3cAeeG
         ZN5TFpYsYEo7TnnnMIGekfhbmkr3R1acvr397YLm17Bps1y2mrUIXTKy5rka9/zDKp8F
         oC6yRyOIw+/Bndyhi9DQYTEvPf+Z9ZaPLZEnZGyIGfaLJZgsbtnX0d/sAo+6kgOhxycf
         17T0laXNeoCXiM7Z4z/qP3ro2EMxtdc6eMg9VhmdwXh6t1btgAHrK6rKkuAzepHAQ0UH
         CgUw==
X-Gm-Message-State: AOAM531pFkmxf01e8xSdIJja65oC7yKjqojejc7YlERubTVU9Lq9FSLo
        Du1kL3h+NdMGvARPUG0WkC0=
X-Google-Smtp-Source: ABdhPJxgifVDPUhVxdpCsV/kmFrlJhVY7haeyHyiaZimqkk1Ax+Gh6S33WNl405Q4hlS1DSP59uT2A==
X-Received: by 2002:a05:6512:31c5:: with SMTP id j5mr16419583lfe.116.1622514814506;
        Mon, 31 May 2021 19:33:34 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id l21sm107848lfc.28.2021.05.31.19.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:33:34 -0700 (PDT)
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
Subject: [PATCH v6 11/14] dt-bindings: soc: tegra-pmc: Document core power domain
Date:   Tue,  1 Jun 2021 05:31:16 +0300
Message-Id: <20210601023119.22044-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601023119.22044-1-digetx@gmail.com>
References: <20210601023119.22044-1-digetx@gmail.com>
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

