Return-Path: <linux-pm+bounces-11943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A509492CF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45EE8B2A811
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B520FA89;
	Tue,  6 Aug 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK29PC5A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3DE20FA81;
	Tue,  6 Aug 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952720; cv=none; b=jIj11frmoG87qvihYT0nTWMEcduHYDNSi5d32uY+WbyGMwsR1X1k6vez57WmJqO4baGcgkJKKNo61b5Cg3O/euHoO+Mw1MlqTlSRJBoGb7Sm5mAatD8CtmioARIdXbTUFjiYA/1sGrtxhNe2GZdXdrOpvCxxrHghCzNfLv9e+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952720; c=relaxed/simple;
	bh=J8ubgUjHNrtLv0TxZJXPD766YdpBaBhWC+ww/EHkWQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nzaH0qRoZ3WooRC5oDWq4LX9L4ulUyRzp6SbXeovnMkEWQF+6EpNB6SYN2/roq+85gvhuUwT+BrZRvMORqmJPCO0lScVylGl/IbwHut6+3aw+nTzovZLhtO5Hue5mdYzWK5P6c4pcwiprSRNmHN879b3Q2zdUEdCFTM5B15UfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK29PC5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20285C32786;
	Tue,  6 Aug 2024 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722952720;
	bh=J8ubgUjHNrtLv0TxZJXPD766YdpBaBhWC+ww/EHkWQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oK29PC5Adw/jfmeGKjnKEqB8XHIQiPOVF5FhV1gFP0ZDuXhZkUmn8TAPSBRUA5ppb
	 HYKrMwFqMaQF4sYxTxRhtxRMbARAlQkB0ldAEfzTeseN3Tk+7g+s/bgXRZ3PctfIix
	 kOjeavcEoyz3YH5WOVOnlD2nj5+fXUh/3yRwfkOimC7PjZgMy+ajHXdTa6+kxjB3Ky
	 qhLnQ3tUDWFU8yt3PQ9QjikJv281uCickYzn+qhb7hUv9T0JsJGgNmpCZ8Jhcg9U7F
	 mwCxfv9D3m5EuK7YY49zuODD3Z0Dw/SZdgDLT2n9oYSxAl4joWlRIefE27hVCuJlAu
	 uNvitqc3KH0tg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 06 Aug 2024 07:58:26 -0600
Subject: [PATCH 5/6] cpufreq: Enable COMPILE_TEST on Arm drivers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dt-api-cleanups-v1-5-459e2c840e7d@kernel.org>
References: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
In-Reply-To: <20240806-dt-api-cleanups-v1-0-459e2c840e7d@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

COMPILE_TEST is useful for build testing without requiring a specific
architecture's compiler. Enable it for most of the Arm CPUFreq drivers.

As Kconfig.arm is only included on ARM and ARM64, COMPILE_TEST is only
enabled for those architectures until that is dropped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/cpufreq/Kconfig.arm | 50 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 96b404ce829f..5f7e13e60c80 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -5,7 +5,7 @@
 
 config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on NVMEM_SUNXI_SID
 	select PM_OPP
 	help
@@ -26,15 +26,17 @@ config ARM_APPLE_SOC_CPUFREQ
 
 config ARM_ARMADA_37XX_CPUFREQ
 	tristate "Armada 37xx CPUFreq support"
-	depends on ARCH_MVEBU && CPUFREQ_DT
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on CPUFREQ_DT
 	help
 	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
 	  The Armada 37xx PMU supports 4 frequency and VDD levels.
 
 config ARM_ARMADA_8K_CPUFREQ
 	tristate "Armada 8K CPUFreq driver"
-	depends on ARCH_MVEBU && CPUFREQ_DT
-	select ARMADA_AP_CPU_CLK
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on CPUFREQ_DT
+	select ARMADA_AP_CPU_CLK if COMMON_CLK
 	help
 	  This enables the CPUFreq driver support for Marvell
 	  Armada8k SOCs.
@@ -56,7 +58,7 @@ config ARM_SCPI_CPUFREQ
 config ARM_VEXPRESS_SPC_CPUFREQ
 	tristate "Versatile Express SPC based CPUfreq driver"
 	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
-	depends on ARCH_VEXPRESS_SPC
+	depends on ARCH_VEXPRESS_SPC || COMPILE_TEST
 	select PM_OPP
 	help
 	  This add the CPUfreq driver support for Versatile Express
@@ -75,7 +77,8 @@ config ARM_BRCMSTB_AVS_CPUFREQ
 
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
-	depends on ARCH_HIGHBANK && CPUFREQ_DT && REGULATOR
+	depends on ARCH_HIGHBANK || COMPILE_TEST
+	depends on CPUFREQ_DT && REGULATOR && PL320_MBOX
 	default m
 	help
 	  This adds the CPUFreq driver for Calxeda Highbank SoC
@@ -96,7 +99,8 @@ config ARM_IMX6Q_CPUFREQ
 
 config ARM_IMX_CPUFREQ_DT
 	tristate "Freescale i.MX8M cpufreq support"
-	depends on ARCH_MXC && CPUFREQ_DT
+	depends on CPUFREQ_DT
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  This adds cpufreq driver support for Freescale i.MX7/i.MX8M
 	  series SoCs, based on cpufreq-dt.
@@ -111,7 +115,8 @@ config ARM_KIRKWOOD_CPUFREQ
 
 config ARM_MEDIATEK_CPUFREQ
 	tristate "CPU Frequency scaling support for MediaTek SoCs"
-	depends on ARCH_MEDIATEK && REGULATOR
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on REGULATOR
 	select PM_OPP
 	help
 	  This adds the CPUFreq driver support for MediaTek SoCs.
@@ -130,12 +135,12 @@ config ARM_MEDIATEK_CPUFREQ_HW
 
 config ARM_OMAP2PLUS_CPUFREQ
 	bool "TI OMAP2+"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	default ARCH_OMAP2PLUS
 
 config ARM_QCOM_CPUFREQ_NVMEM
 	tristate "Qualcomm nvmem based CPUFreq"
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on NVMEM_QCOM_QFPROM
 	depends on QCOM_SMEM
 	select PM_OPP
@@ -166,7 +171,7 @@ config ARM_RASPBERRYPI_CPUFREQ
 
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
-	depends on CPU_S3C6410
+	depends on CPU_S3C6410 || COMPILE_TEST
 	default y
 	help
 	  This adds the CPUFreq driver for Samsung S3C6410 SoC.
@@ -175,7 +180,7 @@ config ARM_S3C64XX_CPUFREQ
 
 config ARM_S5PV210_CPUFREQ
 	bool "Samsung S5PV210 and S5PC110"
-	depends on CPU_S5PV210
+	depends on CPU_S5PV210 || COMPILE_TEST
 	default y
 	help
 	  This adds the CPUFreq driver for Samsung S5PV210 and
@@ -199,14 +204,15 @@ config ARM_SCMI_CPUFREQ
 
 config ARM_SPEAR_CPUFREQ
 	bool "SPEAr CPUFreq support"
-	depends on PLAT_SPEAR
+	depends on PLAT_SPEAR || COMPILE_TEST
 	default y
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
 config ARM_STI_CPUFREQ
 	tristate "STi CPUFreq support"
-	depends on CPUFREQ_DT && SOC_STIH407
+	depends on CPUFREQ_DT
+	depends on SOC_STIH407 || COMPILE_TEST
 	help
 	  This driver uses the generic OPP framework to match the running
 	  platform with a predefined set of suitable values.  If not provided
@@ -216,34 +222,38 @@ config ARM_STI_CPUFREQ
 
 config ARM_TEGRA20_CPUFREQ
 	tristate "Tegra20/30 CPUFreq support"
-	depends on ARCH_TEGRA && CPUFREQ_DT
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on CPUFREQ_DT
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
 
 config ARM_TEGRA124_CPUFREQ
 	bool "Tegra124 CPUFreq support"
-	depends on ARCH_TEGRA && CPUFREQ_DT
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on CPUFREQ_DT
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
 
 config ARM_TEGRA186_CPUFREQ
 	tristate "Tegra186 CPUFreq support"
-	depends on ARCH_TEGRA && TEGRA_BPMP
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on TEGRA_BPMP
 	help
 	  This adds the CPUFreq driver support for Tegra186 SOCs.
 
 config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
-	depends on ARCH_TEGRA_194_SOC && TEGRA_BPMP
+	depends on ARCH_TEGRA_194_SOC || (64BIT && COMPILE_TEST)
+	depends on TEGRA_BPMP
 	default y
 	help
 	  This adds CPU frequency driver support for Tegra194 SOCs.
 
 config ARM_TI_CPUFREQ
 	bool "Texas Instruments CPUFreq support"
-	depends on ARCH_OMAP2PLUS || ARCH_K3
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	default y
 	help
 	  This driver enables valid OPPs on the running platform based on
@@ -255,7 +265,7 @@ config ARM_TI_CPUFREQ
 
 config ARM_PXA2xx_CPUFREQ
 	tristate "Intel PXA2xx CPUfreq driver"
-	depends on PXA27x || PXA25x
+	depends on PXA27x || PXA25x || COMPILE_TEST
 	help
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 

-- 
2.43.0


