Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C762B39A6
	for <lists+linux-pm@lfdr.de>; Sun, 15 Nov 2020 22:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgKOVdu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Nov 2020 16:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgKOVda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2020 16:33:30 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB79C0613D2;
        Sun, 15 Nov 2020 13:33:29 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id d17so22342734lfq.10;
        Sun, 15 Nov 2020 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dchum/w5tW6S8qZoSmLsyitcs7JqpsShTrIAD3uRjUU=;
        b=lZ8ly5BP+GAZtwOTaCG6bm2jamYGmQ1lPIt0NgmI0L4N8tdD4vYRhYmMCegDlgpDOT
         y+juXcTSiM1H3aBXYYNrFO9OVuduhjIxbNaKectXAFHFy0l6gUWPs02ZJbVqAdJzN+AL
         A9S3zJcZrgIkR20oYW3EVN9nm1h7iJz5NA+7sFqBBIt0QnG202qiY+E6GN+SeH7s+j49
         y0gxZ9g40ACIGEEAhAZvZP1CaD7Nxx+1dLYN8oW0B2/eWbOgxMcoedDMqMmr36vftlgv
         hwvaz3Rnx9SbI2J5/SEaKSLrcl+6xzcHjqaIcPdMwC4oxA6HY70Fjvdcs/D303Qd8Xoy
         zrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dchum/w5tW6S8qZoSmLsyitcs7JqpsShTrIAD3uRjUU=;
        b=NVJ4Tje9iMrXEMF643EH8MwHY3kc83DgGFjjYh69wAAf2XTZGIjxsx5efYN3NrlmEO
         0r5tCeBszXhZJIP//tIGsJTYsMq5Nu4QxPh5hSZCOI7bD9MdzYGkRN1pvBMF7uVpkEI8
         uN+pX6ejSMl6SMcZ0MjBWQXSbTSvemlw0kzQgK+phVeUMpFEJRUXCnF8bAaIhdWeMzhM
         IBmhYz2meA38V9YHLbGieKkJ3VuSOMFOgbAp6AHhQjpLc1DOkRWf+2ASmXm7lyj+/pCy
         gwl81/u5Je8O+OiIKrRgObWXmZ1Fu+0ghCrnL4u5WNSQZWU+r0B47nRvGDXsKcY39y/7
         wtVg==
X-Gm-Message-State: AOAM530cCqanOYOH5ve0IgYUkYLHkAnsR/81V5V+vOjfNk58tVz/QKr6
        LZX5/b9USWcO1m0dOCzzmc8=
X-Google-Smtp-Source: ABdhPJyiEMqI4M+YykOETmnrfbOOMNbdn5crvsVaOCjr6hbbt68QMSbomgV4ubWJVKv4aAAc6KEjWw==
X-Received: by 2002:a19:5f0b:: with SMTP id t11mr4695777lfb.326.1605476008317;
        Sun, 15 Nov 2020 13:33:28 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id o3sm2462055lfo.217.2020.11.15.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 13:33:27 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v9 11/17] ARM: tegra: Add interconnect properties to Tegra20 device-tree
Date:   Mon, 16 Nov 2020 00:29:16 +0300
Message-Id: <20201115212922.4390-12-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115212922.4390-1-digetx@gmail.com>
References: <20201115212922.4390-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect properties to the Memory Controller, External Memory
Controller and the Display Controller nodes in order to describe hardware
interconnection.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9347f7789245..2e1304493f7d 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -111,6 +111,17 @@ dc@54200000 {
 
 			nvidia,head = <0>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
+					<&mc TEGRA20_MC_DISPLAY0B &emc>,
+					<&mc TEGRA20_MC_DISPLAY1B &emc>,
+					<&mc TEGRA20_MC_DISPLAY0C &emc>,
+					<&mc TEGRA20_MC_DISPLAYHC &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -128,6 +139,17 @@ dc@54240000 {
 
 			nvidia,head = <1>;
 
+			interconnects = <&mc TEGRA20_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY1BB &emc>,
+					<&mc TEGRA20_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA20_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winb-vfilter",
+					     "winc",
+					     "cursor";
+
 			rgb {
 				status = "disabled";
 			};
@@ -630,15 +652,17 @@ mc: memory-controller@7000f000 {
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
-	memory-controller@7000f400 {
+	emc: memory-controller@7000f400 {
 		compatible = "nvidia,tegra20-emc";
 		reg = <0x7000f400 0x400>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA20_CLK_EMC>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#interconnect-cells = <0>;
 	};
 
 	fuse@7000f800 {
-- 
2.29.2

