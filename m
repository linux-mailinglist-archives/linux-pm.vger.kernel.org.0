Return-Path: <linux-pm+bounces-30768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C950B03916
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE0016D0BE
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE623F417;
	Mon, 14 Jul 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lftX3dS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BBF23DEB6;
	Mon, 14 Jul 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481071; cv=none; b=eW8jR5M0i/pkdYTXiq0z1cYqs3FTXE8tLe2FHLi9oDmgQ47sQKCGu7RyBdjYBmMREUgHne3JwqZb3eCDVzIrYiP37+j2kvhUN7ojN8X8P5nAuhIp40KWmnTAKg9+5XT4g0sgu0rwYrNZG6FnJxBmsEvd/ye876Qm7nEpEOM/+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481071; c=relaxed/simple;
	bh=xVTUmk5wK8gtQSnPEozCad/1ZZEdP2mLrfNNJy7RfRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8KUCGMrnUaV8eDrtqDBtrVclTg2H4HQYCMKjwJB8LBb8SYLe9IjAEYtHwV0Cd6cG5tfHfMt4Q7++SBVAUTh0x6jVDA4zvB2r7YvXjGt3co5VRttx5j9RfFz5XBBWaouFTLx9POIby2ehji+AHvmqSSIfTieP9wQLd11sS/KvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lftX3dS/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae6fa02d8feso454559666b.0;
        Mon, 14 Jul 2025 01:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481068; x=1753085868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2Ol1UOEYNLKkG5Q441otqdf9QDG7fzV3P3+NIyafPM=;
        b=lftX3dS/ncYZOQmtBfWCWFFd4zZXER4JHSy2BGjRWSaCZxaMpVBtcLTNtPFXEOJjw0
         WDRXj51Tf9nknxR2uiVHQ7r88XjvEuGTM72wpkRkt8NEt1NACYT7V80lY1+oECWpBgvJ
         GjZgVnTE7zomrUI+OA6zemwhFBleDr2DHFjIeKSO3xzjbVOse/kn0LuxZu6sjq4AKLch
         KmXtFz6nuLR+XWDTqT3Kr3HNVbzSLERzRurasJIQmDEpziQYDBykE7UU2BEI3D+S8RTy
         wr12YfuwpugYeuEBXgefV6qTL7i0XIwm0LYeqe1r6x83VWfParxri4tW/BfnTqfh+ANS
         P5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481068; x=1753085868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2Ol1UOEYNLKkG5Q441otqdf9QDG7fzV3P3+NIyafPM=;
        b=T9gL3gaNNYih9DUWDpOZMKiWdcarc+1kz/7ezy/0w6u21XBtiFVegpLEeHAc2mt/7U
         KceO6a5R5tPp7GSxp+FVB4BhXlZzK8XK6yk2p6k8W7x/easjUSCmM9GWpkUa9g5jAY1M
         z6ZuS1sImoHwWu2JJ7uGlZ41/9ke7NA8QU9hh9p7uKRWyXkOJraur/eVZg/WJRCIczQ9
         AoE+nFx89dQTfqeH0YOI2/bcOoZDO59330RjLGMOgOu8mKadWACfvmUIGFU+lwDLARRg
         BP0+jqm0x7b3V++wm5CEpnDjEKTk5oBwntLWThO61yh/puWcU2FOjGjQpyTSoVXirxis
         /WfA==
X-Forwarded-Encrypted: i=1; AJvYcCU4kfyZkNijQEL+9/1ypLpF0SvnvJigEKBJoH7PLOGXCvU3JRnuiiHKxXP5hHF/zw4wh5qzkCAcTdI=@vger.kernel.org, AJvYcCU88VotYDn3N+fU9XMybUkh/0+D0l0YoCEdYXTGSl24cnYr4YofDTk5OoDwVc6eGoTIF52cHUhQAOQ=@vger.kernel.org, AJvYcCXgYAWT/rxkkBehv6cn5hZJoFN00z6SexIyb8fQdI2BIgwUd6DsXR+P/S9ffh/VLM746HLSSC+l5eMscwWv@vger.kernel.org
X-Gm-Message-State: AOJu0YyaTPmg92trQWKgRzJujLci7zMfLonK+TFh8/w37YfroXy0+DdP
	iQV4QztxB8Ln/ePCdG2v1n5BuZ7Lhjj+yNQ15r60rA8TVdX9yGK9DWJe
X-Gm-Gg: ASbGncv7yAz1bFxqttThQk3oeT1WT3giTTYXeZcjJiD/UPVg5EyHaxVEsC9XpVg5vCX
	eoqo+b5H9Rn/9p1wapmylBam8fwd8p7v8MKw+UM/5HEAKNdF3956XJ/LSQCVbV0CsATJJnHOCyR
	hw0OkMwbrF1dHJeNjOETC9OU5Zf+TBpFSUjMPU9WS1WJEaCSTpFydq8onTurJBt+jvppUR8RRUH
	XHMQ9poREaebL2GkebjUvY4xVs3AuvoYsg/IO+IpvMK5KF2kZGuhegCb0OXMM/WPdKyiSliw3yB
	Rw6MzbEFjMR20EeMcHcG51zi+Z7xuWHuYTy2BuM30mF8Ji/GGOoz8lMgB6uT0UfvF7HLNNd3EPQ
	3w8eG40dUSYn5wzwvJExVFudR
X-Google-Smtp-Source: AGHT+IEJnCGdr+8I3GjjyVQpD33j0o5roW38EDoCOs0+EHgWQU1I08uXgYucN/0e3vw6muh3vpF+Cw==
X-Received: by 2002:a17:906:c154:b0:ae0:dfa5:3520 with SMTP id a640c23a62f3a-ae6fcbc353fmr1315833666b.31.1752481068031;
        Mon, 14 Jul 2025 01:17:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e949f2sm787867166b.34.2025.07.14.01.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:17:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: tegra: Add DFLL clock support on Tegra114
Date: Mon, 14 Jul 2025 11:17:13 +0300
Message-ID: <20250714081713.8409-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714081713.8409-1-clamor95@gmail.com>
References: <20250714081713.8409-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DFLL clock node to common Tegra114 device tree along with clocks
property to cpu node.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 4caf2073c556..3ee51d7f3935 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/memory/tegra114-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/tegra114-car.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
 / {
@@ -693,6 +694,30 @@ mipi: mipi@700e3000 {
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
+	dfll: clock@70110000 {
+		compatible = "nvidia,tegra114-dfll";
+		reg = <0x70110000 0x100>, /* DFLL control */
+		      <0x70110000 0x100>, /* I2C output control */
+		      <0x70110100 0x100>, /* Integrated I2C controller */
+		      <0x70110200 0x100>; /* Look-up table RAM */
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA114_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA114_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA114_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		resets = <&tegra_car TEGRA114_RST_DFLL_DVCO>;
+		reset-names = "dvco";
+		#clock-cells = <0>;
+		clock-output-names = "dfllCPU_out";
+		nvidia,sample-rate = <11500>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <10>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		status = "disabled";
+	};
+
 	mmc@78000000 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000000 0x200>;
@@ -824,6 +849,15 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
+
+			clocks = <&tegra_car TEGRA114_CLK_CCLK_G>,
+				 <&tegra_car TEGRA114_CLK_CCLK_LP>,
+				 <&tegra_car TEGRA114_CLK_PLL_X>,
+				 <&tegra_car TEGRA114_CLK_PLL_P>,
+				 <&dfll>;
+			clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
+			/* FIXME: what's the actual transition time? */
+			clock-latency = <300000>;
 		};
 
 		cpu1: cpu@1 {
-- 
2.48.1


