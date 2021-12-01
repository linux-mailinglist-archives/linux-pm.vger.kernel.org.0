Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5546530C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 17:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351498AbhLAQpj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 11:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351395AbhLAQpY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 11:45:24 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C34C061748
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 08:42:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so1633214wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3fr5sB/hWF6oqc9m6hzOo1nMZaFOt3GJ2Ovlo132VCQ=;
        b=edPaqO5xvP3OJ9dsMgrn3NJJjrZSdjdw+30GE0TCznSZCEhE/+IeIqW40S81GY9zcU
         J3xJVgyr/iCyMG1qVB5Zgtd8y+i0m+BgXLtVSeLhzoO35w5JE1/D1Y8M9zls8skse1fh
         2j+jmHvmzmXybWpBnu1PTixUOjeMv/1LSyp7iAjj2r6WHt8tY2qVGCCxVWMBMBKDGQ2q
         IIyTMRqS1f0n0WDX2magPspnVJ6J6Pd1Yg9UvIqNlwo/qBFJtn9Q0WFtJCUFGbP1N2pP
         B1LFkWomE3Kqvm46T9Zw4g5iQxp4jLYYj7SStbKk9EAOdRLMTvkiyTKsn1bI81oxaYqN
         acEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3fr5sB/hWF6oqc9m6hzOo1nMZaFOt3GJ2Ovlo132VCQ=;
        b=gPNu9Pm/6Yx1SvQoXrm3TC+bUz+TwYbOolMGrfFI1IfxD9j8XcCCwRZwzPxZoJOVqg
         W3jHG17AeXSZvBSQESKo0pVrySIw0oVBomYuZGro2/F7bvISOp2T4QB2xBYkBDlDTj6Q
         ZYLBPUiLMYoGe9qJIHQpfjvXqnart10sZAxqFJN5+gubI7fw0a0oMPEqNrBPRHd0Togf
         M9n7P++zeOrOrrTJAL4zFlwboorwUA2JtBUSNys+d5v6lGlOzIewZSkY/7DNVgMAk2w6
         r7RLkhC/5OdYQYI/jvznYBr2Qx4ZuimC2/0wxwrK9Tihnl5X/7o9fIXt//ZM8oMZUeWD
         xoAw==
X-Gm-Message-State: AOAM532ij0Uw7np7hHrAtkOIuLKBbQhZEC0vSnwr4vyYvFCgQnRNgGtt
        Yfxf1r1sIBoodngmqDDycRRhpA==
X-Google-Smtp-Source: ABdhPJwZs1Eb9XLIHSC22SB5RhOI84i+Yyfqvzl0zjy3mqksUQU5ZTohyeD569HO712YaEOlrL1fnA==
X-Received: by 2002:a1c:80c5:: with SMTP id b188mr8663137wmd.57.1638376921939;
        Wed, 01 Dec 2021 08:42:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:72d0:52a1:d4ea:f564])
        by smtp.gmail.com with ESMTPSA id v8sm255547wrd.84.2021.12.01.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:42:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, robh@kernel.org
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v3 2/5] arm64: dts: rockchip: Add powerzones definition for rock960
Date:   Wed,  1 Dec 2021 17:38:51 +0100
Message-Id: <20211201163856.41419-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201163856.41419-1-daniel.lezcano@linaro.org>
References: <20211201163856.41419-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the powerzones description. This first step introduces the big,
the little as powerzone places.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
   V3:
     - Remove GPU section as no power is available (yet)
     - Remove '#powerzone-cells' conforming to the bindings change
   V2:
     - Move description in the SoC dtsi specific file
   V1: Initial post
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d3cdf6f42a30..c41b20888a44 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -76,6 +76,7 @@ cpu_l0: cpu@0 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_l1: cpu@1 {
@@ -88,6 +89,7 @@ cpu_l1: cpu@1 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_l2: cpu@2 {
@@ -100,6 +102,7 @@ cpu_l2: cpu@2 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_l3: cpu@3 {
@@ -112,6 +115,7 @@ cpu_l3: cpu@3 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_b0: cpu@100 {
@@ -124,6 +128,7 @@ cpu_b0: cpu@100 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			powerzone = <&PKG_PZ>;
 
 			thermal-idle {
 				#cooling-cells = <2>;
@@ -142,6 +147,7 @@ cpu_b1: cpu@101 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			powerzone = <&PKG_PZ>;
 
 			thermal-idle {
 				#cooling-cells = <2>;
@@ -791,6 +797,17 @@ spi5: spi@ff200000 {
 		status = "disabled";
 	};
 
+	powerzones {
+
+		PKG_PZ: pkg {
+			#powerzone-cells = <0>;
+                        powerzone = <&SOC_PZ>;
+		};
+
+		SOC_PZ: soc {
+		};
+	};
+
 	thermal_zones: thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <100>;
-- 
2.25.1

