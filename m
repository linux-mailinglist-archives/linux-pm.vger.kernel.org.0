Return-Path: <linux-pm+bounces-26426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E4AA3D89
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 02:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6125480806
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895712882DB;
	Tue, 29 Apr 2025 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQPkJjl3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECD259CB4;
	Tue, 29 Apr 2025 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970689; cv=none; b=sPudJq52qW4JsO/ElDiuv0nMg74h+TVEi/l2t+Tr5grjRMbqxe9lgyrbxo1mtRzcV5rXIy/AmphM/3KSIMMES6eil5tzYfdOQnPauftD4MNFUxrLEw7qk2qC93018+7DODFHXezG2RtSxWqQ/r7+MdPdM7HREJ+nbxxaP0lFIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970689; c=relaxed/simple;
	bh=5Z0Lc1jqCPJytzaKfzQW4GTMGLBfE6pBD24mBrYp8hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A2FvmkotF/NGaLpIs9EPKfyyQKDrnkIaPn8mginPA+RSOWNtCbITacX8pD/Bj4tu50u4kxaeVK6b09+Trb+elTSlkMWqHeDhkUWB35BNKrhd5IYWJ+Ps5DSldhuQND5zcLRQCP8u5y7XXMpTAQGax4Lc/A7zTc8mHVwazRsLKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQPkJjl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5132DC4CEED;
	Tue, 29 Apr 2025 23:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970689;
	bh=5Z0Lc1jqCPJytzaKfzQW4GTMGLBfE6pBD24mBrYp8hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQPkJjl39LSp7DzJngMS1u5U3/npPgq/xxxsZhTqWcMjG4u89mlh3fSibMvrP4CkO
	 8tD0jMe5A8DHyIoTc4IduJa3Pa6eN3WDiXnC0t7AlevFTZB46BF25nKJOM51VEi7GZ
	 HZwebvIwftE/RhQrR9nJN2nUkSTrOFtiCojudeNdL+lD6HoypVqhzWn3odms0jNS8b
	 F9rzLoH4vyTsiqTQjA+0tuF1sZk2FeKm6FFPE6IPBNtSaTLKlaCaeVOLHT2TkEpEV7
	 razdoHHWTFnoE2mJyLXOpFCg1I9wNsm2ecu/xp7QOkILmG/p1qRGQtoIOIEYEdIieh
	 fFaDL6bw0PX6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 02/37] cpufreq: Do not enable by default during compile testing
Date: Tue, 29 Apr 2025 19:50:47 -0400
Message-Id: <20250429235122.537321-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit d4f610a9bafdec8e3210789aa19335367da696ea ]

Enabling the compile test should not cause automatic enabling of all
drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/Kconfig.arm | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e67b2326671c9..f6e6066e2e64b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -67,7 +67,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_BRCMSTB_AVS_CPUFREQ
 	tristate "Broadcom STB AVS CPUfreq driver"
 	depends on (ARCH_BRCMSTB && !ARM_SCMI_CPUFREQ) || COMPILE_TEST
-	default y
+	default ARCH_BRCMSTB
 	help
 	  Some Broadcom STB SoCs use a co-processor running proprietary firmware
 	  ("AVS") to handle voltage and frequency scaling. This driver provides
@@ -172,7 +172,7 @@ config ARM_RASPBERRYPI_CPUFREQ
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410 || COMPILE_TEST
-	default y
+	default CPU_S3C6410
 	help
 	  This adds the CPUFreq driver for Samsung S3C6410 SoC.
 
@@ -181,7 +181,7 @@ config ARM_S3C64XX_CPUFREQ
 config ARM_S5PV210_CPUFREQ
 	bool "Samsung S5PV210 and S5PC110"
 	depends on CPU_S5PV210 || COMPILE_TEST
-	default y
+	default CPU_S5PV210
 	help
 	  This adds the CPUFreq driver for Samsung S5PV210 and
 	  S5PC110 SoCs.
@@ -205,7 +205,7 @@ config ARM_SCMI_CPUFREQ
 config ARM_SPEAR_CPUFREQ
 	bool "SPEAr CPUFreq support"
 	depends on PLAT_SPEAR || COMPILE_TEST
-	default y
+	default PLAT_SPEAR
 	help
 	  This adds the CPUFreq driver support for SPEAr SOCs.
 
@@ -224,7 +224,7 @@ config ARM_TEGRA20_CPUFREQ
 	tristate "Tegra20/30 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
 
@@ -232,7 +232,7 @@ config ARM_TEGRA124_CPUFREQ
 	bool "Tegra124 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds the CPUFreq driver support for Tegra124 SOCs.
 
@@ -247,14 +247,14 @@ config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
 	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
 	depends on TEGRA_BPMP
-	default y
+	default ARCH_TEGRA
 	help
 	  This adds CPU frequency driver support for Tegra194 SOCs.
 
 config ARM_TI_CPUFREQ
 	bool "Texas Instruments CPUFreq support"
 	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
-	default y
+	default ARCH_OMAP2PLUS || ARCH_K3
 	help
 	  This driver enables valid OPPs on the running platform based on
 	  values contained within the SoC in use. Enable this in order to
-- 
2.39.5


