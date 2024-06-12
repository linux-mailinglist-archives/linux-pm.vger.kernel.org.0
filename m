Return-Path: <linux-pm+bounces-8992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBE904BC8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 08:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62915286DC1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 06:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C732916B726;
	Wed, 12 Jun 2024 06:42:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573F13BC05;
	Wed, 12 Jun 2024 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174557; cv=none; b=KyH4gzljmhKrQFaR7EfpUXL6DZo+A8fodsN10ReLkFMAhSfbwHGFf7aYycT/Rh00rKESHjrw9tigx2a9pPMLSjO50aKpjzySigCLQLQjdWPodkf7xNOffwFOEcS5uaD2VIeQKWaS1LEG+9C5imO05fCTKOyblqK0LoCHCMKjrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174557; c=relaxed/simple;
	bh=XVpNvv7dutfr0NAL/LUAO2hwYx4PCPDqIKIqQ42xaXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyL03mMu56dUwHt3vGwFiXlXREo/ZFuE4nCpfWXqkLPHVRqQ4JVFTPTX3EPzHnukdEtz6bG3BOOZ9dPITUmEPDc6slBH/Pns+v24N5zTmZ7q4loxkRbaFOwJNpSGwCd3ARsbKUXsYdpeQ9mKmfPrV6dqKzLOlEEsauV1bfYR024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8747C32786;
	Wed, 12 Jun 2024 06:42:34 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 1/2] LoongArch: Add architectural preparation for CPUFreq
Date: Wed, 12 Jun 2024 14:42:04 +0800
Message-ID: <20240612064205.2041548-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612064205.2041548-1-chenhuacai@loongson.cn>
References: <20240612064205.2041548-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add architectural preparation for CPUFreq driver, including: Kconfig,
register definition and platform device registration.

Some of LoongArch processors support DVFS, their IOCSR.FEATURES has
IOCSRF_FREQSCALE set. And they has a micro-core in the package called
SMC (System Management Controller) to scale frequency, voltage, etc.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                 |  1 +
 arch/loongarch/include/asm/loongarch.h |  3 +++
 arch/loongarch/power/platform.c        | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e38139c576ee..dffa9c454123 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -696,6 +696,7 @@ config ARCH_HIBERNATION_POSSIBLE
 
 source "kernel/power/Kconfig"
 source "drivers/acpi/Kconfig"
+source "drivers/cpufreq/Kconfig"
 
 endmenu
 
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index eb09adda54b7..7d89b2ecf2c2 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1053,11 +1053,14 @@
 #define LOONGARCH_IOCSR_NODECNT		0x408
 
 #define LOONGARCH_IOCSR_MISC_FUNC	0x420
+#define  IOCSR_MISC_FUNC_SOFT_INT	BIT_ULL(10)
 #define  IOCSR_MISC_FUNC_TIMER_RESET	BIT_ULL(21)
 #define  IOCSR_MISC_FUNC_EXT_IOI_EN	BIT_ULL(48)
 
 #define LOONGARCH_IOCSR_CPUTEMP		0x428
 
+#define LOONGARCH_IOCSR_SMCMBX		0x51c
+
 /* PerCore CSR, only accessible by local cores */
 #define LOONGARCH_IOCSR_IPI_STATUS	0x1000
 #define LOONGARCH_IOCSR_IPI_EN		0x1004
diff --git a/arch/loongarch/power/platform.c b/arch/loongarch/power/platform.c
index 3ea8e07aa225..a19353f7d1b0 100644
--- a/arch/loongarch/power/platform.c
+++ b/arch/loongarch/power/platform.c
@@ -34,6 +34,21 @@ void enable_pci_wakeup(void)
 		acpi_write_bit_register(ACPI_BITREG_PCIEXP_WAKE_DISABLE, 0);
 }
 
+static struct platform_device loongson3_cpufreq_device = {
+	.name = "loongson3_cpufreq",
+	.id = -1,
+};
+
+static int __init loongson_cpufreq_init(void)
+{
+	if (!cpu_has_scalefreq)
+		return -ENODEV;
+
+	return platform_device_register(&loongson3_cpufreq_device);
+}
+
+arch_initcall(loongson_cpufreq_init);
+
 static int __init loongson3_acpi_suspend_init(void)
 {
 #ifdef CONFIG_ACPI
-- 
2.43.0


