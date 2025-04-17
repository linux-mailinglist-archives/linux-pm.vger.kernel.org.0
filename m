Return-Path: <linux-pm+bounces-25606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214D6A91524
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF833B351C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F6821ABCB;
	Thu, 17 Apr 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFy10jB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34902219A76;
	Thu, 17 Apr 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874938; cv=none; b=pFuGrHgJE/AgvLMT9Ne2UNhiCfAVO7tGKTwv0O50nGfnJqABE6nyarPoxx036Bbajdo/mcM3kRofbS/NGtiNKYsfRuLmz8yOhMiDUyjhtRK0UTYHBuQXxoNF/7nyyuCsCq/LY0GyCEWmGPtGPvfgm7ZMiT85f9eQxyvkJ2/HBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874938; c=relaxed/simple;
	bh=1Go1rOeSwKFJb+OGsYoOU4Np68HqJFr1nvpQbJt93ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7ifJx53pD96RH8fHNGOVvijSs9EIWFWmSKeXD41DzyzaLeJvg1j60ibx2OUW7WXPYSS5Zw1D51Tw7z03cSzz5ek1Ojtczg7ffwqCAP7Fll4czrnH615KV84Y6fvFGvDxkFHWuY2TFshvJIQCwCQAWPzhvX4gHir3Dy2KI+qLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFy10jB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E447C4CEE4;
	Thu, 17 Apr 2025 07:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744874937;
	bh=1Go1rOeSwKFJb+OGsYoOU4Np68HqJFr1nvpQbJt93ck=;
	h=From:To:Cc:Subject:Date:From;
	b=vFy10jB2gwIdklMCwQUJWAbjJg5c0eS9HYkRp8cdZat4o4XaI3cO2neYY/aslV5rO
	 4LdlCsnmUTplRIAl4Ij7mm5jGWFXUoI40fW5X4FuUMrM+lHFSGfAvEXckACb8rwsXk
	 4bI07zOTbXmMoRHJx6GX5OFgOwgbMukafjWTXbEJtQmTFHjkn2H+4b3xSFxlajbqOy
	 1nhfaglzyMb0xyq0Uk0vSPY8Bea8gTLpihzAv67MB5BKHmj4gJBqTkYZRY2LCzKhGc
	 +29UXUCsNu9CBZ+s9CIUy8XUemRqW/3DO6DGvJgctmQ1LVPAMvvzTM5PypUHIRSMUt
	 AiEIkae5VfCFw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1u5Jg8-000000000CH-31wy;
	Thu, 17 Apr 2025 09:28:57 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3] cpufreq: fix compile-test defaults
Date: Thu, 17 Apr 2025 09:28:38 +0200
Message-ID: <20250417072838.734-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
enabled compile testing of most Arm CPUFreq drivers but left the
existing default values unchanged so that many drivers are enabled by
default whenever COMPILE_TEST is selected.

This specifically results in the S3C64XX CPUFreq driver being enabled
and initialised during boot of non-S3C64XX platforms with the following
error logged:

	cpufreq: Unable to obtain ARMCLK: -2

Commit d4f610a9bafd ("cpufreq: Do not enable by default during compile
testing") recently fixed most of the default values, but two entries
were missed and two could use a more specific default condition.

Fix the default values for drivers that can be compile tested and that
should be enabled by default when not compile testing.

Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
Cc: stable@vger.kernel.org	# 6.12: d4f610a9bafd
Cc: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v3:
 - use stable backport dependency notation instead of a Fixes tag for
   the partial fix

Changes in v2:
 - rebase on commit d4f610a9bafd ("cpufreq: Do not enable by default
   during compile testing")


 drivers/cpufreq/Kconfig.arm | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index d4d625ded285..0d46402e3094 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -76,7 +76,7 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_BRCMSTB_AVS_CPUFREQ
 	tristate "Broadcom STB AVS CPUfreq driver"
 	depends on (ARCH_BRCMSTB && !ARM_SCMI_CPUFREQ) || COMPILE_TEST
-	default ARCH_BRCMSTB
+	default y if ARCH_BRCMSTB && !ARM_SCMI_CPUFREQ
 	help
 	  Some Broadcom STB SoCs use a co-processor running proprietary firmware
 	  ("AVS") to handle voltage and frequency scaling. This driver provides
@@ -88,7 +88,7 @@ config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK || COMPILE_TEST
 	depends on CPUFREQ_DT && REGULATOR && PL320_MBOX
-	default m
+	default m if ARCH_HIGHBANK
 	help
 	  This adds the CPUFreq driver for Calxeda Highbank SoC
 	  based boards.
@@ -133,7 +133,7 @@ config ARM_MEDIATEK_CPUFREQ
 config ARM_MEDIATEK_CPUFREQ_HW
 	tristate "MediaTek CPUFreq HW driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	default m
+	default m if ARCH_MEDIATEK
 	help
 	  Support for the CPUFreq HW driver.
 	  Some MediaTek chipsets have a HW engine to offload the steps
@@ -256,7 +256,7 @@ config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
 	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
 	depends on TEGRA_BPMP
-	default ARCH_TEGRA
+	default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
 	help
 	  This adds CPU frequency driver support for Tegra194 SOCs.
 
-- 
2.49.0


