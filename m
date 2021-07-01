Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6569B3B995E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 01:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhGAXbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 19:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhGAXbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 19:31:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEDEC0613DB;
        Thu,  1 Jul 2021 16:28:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e3so2337549ljo.6;
        Thu, 01 Jul 2021 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DaVg58VwcLbItWaczAlA+37LBsl+OcUmZQx7FRqBDs=;
        b=iuFDev8Nu31h2W8bt5CuDYxgDVM6Gkh1ZnUdsk43kN37tSS/rtGqfE9H9MQX+5wo69
         MQPTmp7z4iFjI5SbNkPyxNUA4Zj8CheXWkRGcdm0K1Tql2Ogj8kgBk68jS8AK0wF0Ihq
         vZnMH3BbX3xCHnCzaGwUT7dOxjuWE09/aHW6deNe59akxleQLe7Fv9HnGVHt/zgtqUFK
         yaJWhWzGLwQBdHXoxePKujOmScuDHAU0TqPFXaWhOCeMpmqqGXylb0OsC2AoqlWGczkH
         bKLG1IHaOcpGI3UXfoErlboDpE5Dm5BkzuvMetx76o4WjQN2Pca0/eFzkdJPmVa0Zywy
         saFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DaVg58VwcLbItWaczAlA+37LBsl+OcUmZQx7FRqBDs=;
        b=SsjgHIpWIBr2uOld/kvuob+R9aMALqWTfgRRSSjWQXuAxVrIE5p0P1VEeyAAebSZ82
         iSFCFLToulcF5QFTJn3ljnfgqioWhzbHFyWIjB4S0ZjH2MIYlrGL0Cbs4eCKaiubs4cj
         aXjR3xYXaj9eYaxzbDLToRrHmRWSrpNKhkJPBz7VbHb1tKSUmuCFC+kOX/b7/W45BNEZ
         CzgO3wEqNFuVYEocNOuEaLud7QgCH2EcC59Brb9QxdMNtYUOMHpjelL1UV06TfZMcx5y
         pbvoMwWkIsW/W+Ty9qr9qB1kBLfNVKTiNPVbG2nIJCT7Hz23QGQ95GqMrOf1as7dZijX
         S0zw==
X-Gm-Message-State: AOAM531U1eIJRLDdfNWz6D33RdYVcvJw5rV2bR9xwKfHuQQSiGvvNwmF
        YRO6GmXHwOGn2Mr6FBLEv3U=
X-Google-Smtp-Source: ABdhPJz7jWXAfc6DqWAsQXeB5YgTZceRT0lApLOIlGMHCV5Rxt1ru4hSHrG/nVj6das8BLvhtlCxLA==
X-Received: by 2002:a2e:8147:: with SMTP id t7mr1444493ljg.241.1625182112298;
        Thu, 01 Jul 2021 16:28:32 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id s20sm102655lfr.39.2021.07.01.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 16:28:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 05/37] dt-bindings: clock: tegra-car: Document new tegra-clocks node
Date:   Fri,  2 Jul 2021 02:26:56 +0300
Message-Id: <20210701232728.23591-6-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701232728.23591-1-digetx@gmail.com>
References: <20210701232728.23591-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document tegra-clocks sub-node which describes Tegra SoC clocks that
require a higher voltage of the core power domain in order to operate
properly on a higher clock rates.  Each node contains a phandle to OPP
table and power domain.

The root PLLs and system clocks don't have any specific device dedicated
to them, clock controller is in charge of managing power for them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/clock/nvidia,tegra20-car.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index 459d2a525393..89c388782d5b 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -42,6 +42,48 @@ properties:
   "#reset-cells":
     const: 1
 
+  tegra-clocks:
+    description: child nodes are the output clocks from the CAR
+    type: object
+
+    patternProperties:
+      "^[a-z]+[0-9]+$":
+        type: object
+        properties:
+          compatible:
+            - items:
+              - enum:
+                - nvidia,tegra20-sclk
+                - nvidia,tegra30-sclk
+                - nvidia,tegra30-pllc
+                - nvidia,tegra30-plle
+                - nvidia,tegra30-pllm
+              - enum:
+                - nvidia,tegra-clock
+
+          operating-points-v2:
+            $ref: /schemas/types.yaml#/definitions/phandle
+            description:
+              Phandle to OPP table that contains frequencies, voltages and
+              opp-supported-hw property, which is a bitfield indicating
+              SoC process or speedo ID mask.
+
+          clocks:
+            items:
+              - description: node's clock
+
+          power-domains:
+            maxItems: 1
+            description: phandle to the core SoC power domain
+
+        required:
+          - compatible
+          - operating-points-v2
+          - clocks
+          - power-domains
+
+        additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -59,6 +101,15 @@ examples:
         reg = <0x60006000 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+
+        tegra-clocks {
+            sclk {
+                compatible = "nvidia,tegra20-sclk", "nvidia,tegra-clock";
+                operating-points-v2 = <&opp_table>;
+                clocks = <&tegra_car TEGRA20_CLK_SCLK>;
+                power-domains = <&domain>;
+            };
+        };
     };
 
     usb-controller@c5004000 {
-- 
2.30.2

