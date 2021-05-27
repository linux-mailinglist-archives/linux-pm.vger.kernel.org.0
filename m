Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637833939A9
	for <lists+linux-pm@lfdr.de>; Fri, 28 May 2021 01:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhE0X4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 19:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbhE0X4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 May 2021 19:56:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBEFC061343;
        Thu, 27 May 2021 16:54:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i9so2580076lfe.13;
        Thu, 27 May 2021 16:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=jn8q6M74Aum7oOl5gO6NuflqDNTgVvEfxsU/MPXrBns79VMVx2shzWP08sdWAKBcb0
         tMAS2cYdK7C7gxs8ebar7Cx+SWHHK1IZiqG1jnFF7B6moOUATpvB9LN8BE5Ab0BmRnW3
         gMrXDm4CWVOtHjzQ+4jWv69KjNcw/zjbxqWRk5VnJUD3TWafFDFXqWQreBY1DSMTnzuW
         SiDOTLqqxGhITmNxf/ptBnH9FjsL/2dMz9LAy+ptoEQd/vjenOXwQTFO0HX9VlxQywlT
         xWymIe84+TE5OCT2xmJl6nwWbAjv7klcKt+oj6ol219MMMkFayMJoXKXJ/iw4U5bk7Ql
         lYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrCxAlPUucoEt+gGLLTmwPl8GAwFzF+H/pcyQba15ag=;
        b=GKxTRFGmdUWqexrF07hm7cNFzW+6ze7X6h7ou1wrCfbnms5csKmEHwLeDORtLUu/RB
         745IWd46F/GPQwS9DCHU1OIJP8/zY+UxNmEURh3GfwDSJ/tgvhXkHhK+jqGsCngXAblq
         5h4+af2+oFqYDSgBA+iiHQx89UKiPxedii7W3i6v3pUgpjEqeJSigcipCtd1N4y5woSs
         G5P7H37zWWRuLx1yvgM1eguH6CggbyDfY59mZjyCVY+rsDCSs490uw1IR9KNV/EbaP15
         XEVEL04PFT+vnSNTbR4bsbfwRswZRUWZ6SVxhajfJdykRRw7DY9Myf0CjFww/NLVZj3s
         t1tA==
X-Gm-Message-State: AOAM533EJuhZWT+81qoI1uA2UYkOJE1RzbUMbHcLyoEyp+XI0UFFtOJP
        aq4a5mDOB34/kOne9pzyPRQ=
X-Google-Smtp-Source: ABdhPJyQE8q4cgpfVKMvIKWpEjH6pj+T8w4vBUPMWPUwUWrrYhb6b8TI5pR36dPs7JttCDS9WE/XSg==
X-Received: by 2002:a19:8609:: with SMTP id i9mr3957774lfd.72.1622159668572;
        Thu, 27 May 2021 16:54:28 -0700 (PDT)
Received: from localhost.localdomain (46-138-12-55.dynamic.spd-mgts.ru. [46.138.12.55])
        by smtp.gmail.com with ESMTPSA id t129sm319000lff.109.2021.05.27.16.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 16:54:28 -0700 (PDT)
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
Subject: [PATCH v5 11/14] dt-bindings: soc: tegra-pmc: Document core power domain
Date:   Fri, 28 May 2021 02:54:10 +0300
Message-Id: <20210527235413.23120-12-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527235413.23120-1-digetx@gmail.com>
References: <20210527235413.23120-1-digetx@gmail.com>
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

