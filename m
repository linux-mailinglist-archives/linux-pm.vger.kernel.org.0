Return-Path: <linux-pm+bounces-25599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE034A91466
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 08:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FF416E5F1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B42153CC;
	Thu, 17 Apr 2025 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V770wU8i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71C1DDA0C;
	Thu, 17 Apr 2025 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872950; cv=none; b=pra8Rxe2B0IF6wGx0Ob6UFaaO0hd04G+deNGYCZ/sB+ZbA/JoYuhQg7oEGrNrFDLT5hveKds7/Bew5kJIxutiQw6VMsD8hUEA7GFYk9SjzJy396dJNb1b1LIUfJ16ltvCeUDTvMFpd98Rd2Ybg5zPJtZUdeEK/63HNpC4yHvQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872950; c=relaxed/simple;
	bh=zS+OjcIKQ+Y6v5jlFZggKEL7/Tj/nnx2WpwH7HpJDyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJktFxny16E+/kv1C2KBBm/ZSzgWOvjBGdIEP7bGTVo/tsOJgF/NeghyC1ZTibRC+OKXca2K9bxl8tYKgKvyilZ4mxjP+P7mASx9YKBWSKwqhF4m9+OMRrKZYNIYTw/eL5RmfucW4DKUtsTKpXA/cyA53FaglJ8x1rZLFEIa3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V770wU8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F96C4CEE4;
	Thu, 17 Apr 2025 06:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744872950;
	bh=zS+OjcIKQ+Y6v5jlFZggKEL7/Tj/nnx2WpwH7HpJDyE=;
	h=From:To:Cc:Subject:Date:From;
	b=V770wU8iokoNTMizO22mU90/8J9yzKJjztMbEa6AR3Gp5X5BUsU9oIRsVyWCFEZE7
	 AZ7G34m3gzT4tOP0xtWEPHEFSa/Kmdn3b2Va3DF1nvrWk5fudgeyZM7TXj4j6P5q1H
	 746guOvuqRU7PwUFiEBkXQkHCWITeqfUWP0NDYRkneZLbjZWNI1MZw45RuoPxcLVvH
	 e1Sb7mOS0MkupuQcoE0muP4CxYHUNMxnX4y+4wP9+C7LVkDBA9UARHUFm1CrXavCAQ
	 /K7qBS/4gzmYOhrBv5vojj4eubiE89xKEhsGz7zQA6YMSvCOmyt5PbLpyuQy/F7Fq6
	 Sw+KLIwqvNXkg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1u5JA5-000000005Yn-1hBN;
	Thu, 17 Apr 2025 08:55:49 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: fix compile-test defaults
Date: Thu, 17 Apr 2025 08:55:35 +0200
Message-ID: <20250417065535.21358-1-johan+linaro@kernel.org>
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
Fixes: d4f610a9bafd ("cpufreq: Do not enable by default during compile testing")
Cc: stable@vger.kernel.org	# 6.12
Cc: Rob Herring (Arm) <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

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


