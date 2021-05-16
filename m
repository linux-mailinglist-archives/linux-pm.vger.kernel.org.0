Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8538220D
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhEPXUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 May 2021 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhEPXUC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 May 2021 19:20:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC205C06174A;
        Sun, 16 May 2021 16:18:46 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a2so6038363lfc.9;
        Sun, 16 May 2021 16:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZcsIzeH0DWoGkSS04rOYJobp1UK2BVFhDOAjw1ppsU=;
        b=G7V5SLZb3ixTUCl1nXwIKwGVk7nBUcOSiLDxtEkQLthURcsbw8BeRKCX04Sc/rjbja
         cFjZhTNw21S/FO1KgN9QZ/cuKcXUjh9hoOGyiiLvI5MQeiqm0TegsHL7oU9tv0z/xUmU
         hT6gYmcfsZ0m+YdmAP5z5uEe4fpBn/tBs28z2t/86t4JHiseeSePDlxTGHqbupEeKKS0
         7hiY4Whuvw6kaTY27nZyGiDCXmgOp1Ufgu/8Uim9V5eg5CC0p+CSJR1xuAyE0oVsCF1t
         Ly6BsHlF9Wc/wMAWaagAz6vhgAsvQcxgP5XFLBbAFlv/PtBMKzX8d40+zch8TL7bS7pn
         Frsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZcsIzeH0DWoGkSS04rOYJobp1UK2BVFhDOAjw1ppsU=;
        b=cChL1VGD4i8q78jHYsIJIqUpzQhrcfvYh+PsiE9NJDOQJYPTTDuIOfX0m5nLK2Nyxx
         D88g11S4+TRzOBbZZa/7/kGsb54UBKvDfSlQHU0jvmuil+M6m99eJGDAuedcjFhNmSU4
         zfcpHSK9MFQDz0eQ/YFfCEIVjG319INq3KLrzD9XWfC+1ELyMlSqmdJNEZvRlLe1+7nw
         AQv2QdkqPFFPuZmUHVCPKLpZAPiIZSqn+ZBqrRcz/Z0OGEIUOXNBPDC3J/Rb2ZI/Fmeo
         8Cp4gCVqw4T3zg7TBAWIiGwWGxP+lh0nxZvJ2OfYe90zQWC0IXOu7VKufQCEIj2h/6pM
         89yg==
X-Gm-Message-State: AOAM532edg4on80TLBAnnDh99E8zvccBfwKoPznLcjz8nQyJLfCttVty
        5GgmSYDRBjTnnuLy7K9XeZ0=
X-Google-Smtp-Source: ABdhPJxMZtLn5XFAgoAZD2M0ACiR9pjjpL4jyr9vHxmSooS5hmtpH0bjqG44XnrA8k8hfeHtSLl2lQ==
X-Received: by 2002:a05:6512:1281:: with SMTP id u1mr23425988lfs.443.1621207125353;
        Sun, 16 May 2021 16:18:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id p6sm406478lfr.163.2021.05.16.16.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 16:18:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: soc: tegra-pmc: Document core power domain
Date:   Mon, 17 May 2021 02:17:53 +0300
Message-Id: <20210516231755.24193-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210516231755.24193-1-digetx@gmail.com>
References: <20210516231755.24193-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All NVIDIA Tegra SoCs have a core power domain where majority of hardware
blocks reside. Document the new core power domain properties.

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

