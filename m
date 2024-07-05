Return-Path: <linux-pm+bounces-10647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFE89281B4
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5F41C22710
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 06:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4213E04C;
	Fri,  5 Jul 2024 06:07:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8D13D28F;
	Fri,  5 Jul 2024 06:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159659; cv=none; b=pUhDSqqzfPyECzIEBj378UQO8h0nmmY37bxQ41t7Y4VmyDAmziOCR8YmXD9BA7N81236sDxYLx1801a9SqqH/FzdwDZmFiBas4n3yHuLe0Et5vWxz95lWrbXmG+/SYeOn8Kdc/k6+YjJlbZ1ndUsv/8RzBJa+qDHljQfC/5WX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159659; c=relaxed/simple;
	bh=z2yNAs9QN3BsTFTRHxT303RRV+Q8iC8JSWUbleuMPuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELS1bpEuWGxYyUm1w3Nch6yxXFwPcNfHhrN7zRentdvucBmA3JbxKjFXG14Q+7Eox1NiqDocovtT4dga0Gy3l4l2LhxqA45HmKot9KMZNXMtSGfj2waP6Qz5i+jpBHnfIwEBc0P+tnTRiYgZCN7bQrxOLpjArWeiVQRW2vBIxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5B2C116B1;
	Fri,  5 Jul 2024 06:07:36 +0000 (UTC)
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
Subject: [PATCH V3 1/2] LoongArch: Add architectural preparation for CPUFreq
Date: Fri,  5 Jul 2024 14:06:48 +0800
Message-ID: <20240705060650.243497-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240705060650.243497-1-chenhuacai@loongson.cn>
References: <20240705060650.243497-1-chenhuacai@loongson.cn>
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
index e346b5b0a5ca..692adf6aad7e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -701,6 +701,7 @@ config ARCH_HIBERNATION_POSSIBLE
 
 source "kernel/power/Kconfig"
 source "drivers/acpi/Kconfig"
+source "drivers/cpufreq/Kconfig"
 
 endmenu
 
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index c430df595376..1501f0f8b06e 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1061,11 +1061,14 @@
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
index 4b5d82643c23..0909729dc2e1 100644
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
 static void default_suspend_addr(void)
 {
 	acpi_enter_sleep_state(ACPI_STATE_S3);
-- 
2.43.5


