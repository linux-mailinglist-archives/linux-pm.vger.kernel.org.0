Return-Path: <linux-pm+bounces-10358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D05924259
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D6A1C23D5B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D991BBBD4;
	Tue,  2 Jul 2024 15:28:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10371DFE3;
	Tue,  2 Jul 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934126; cv=none; b=mm1Uzu21Yins/OCVPIL2ihe4fcPlTAgkbCUTy5jyT1tAsBT7Kmxz+b2kuoSakTRjeM2Mj00gNmkeP29BPVIiRbLO9WoViVAQxOuxtgpQTKZ3Zqg3DPwX2OXu7QvnSQlCHZU0jcZrTerqiSUAvyn/zK9WtXQBw5T4A92qNNCmpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934126; c=relaxed/simple;
	bh=kNIFoFr+sMRrifkGqI15BiMwzzpaUIYjD+frgyWhr2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3MaET4N9vy3zxy3HkibMOMFabFDeEt8dgwTzYtFysI01jyn5zAaIiHBFYKmaf8NUxG4QM5PKy4Aq0AGz3FXFoBEZ0laJWbZeo3Blt+XofAlbJ37fV/Mj3u/pUZa9GzygTzYrCGESlathVej8TRin8cRA7trwUbSG5lMj7Hmwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1497C116B1;
	Tue,  2 Jul 2024 15:28:43 +0000 (UTC)
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
Subject: [PATCH V2 1/2] LoongArch: Add architectural preparation for CPUFreq
Date: Tue,  2 Jul 2024 23:27:36 +0800
Message-ID: <20240702152737.1184244-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702152737.1184244-1-chenhuacai@loongson.cn>
References: <20240702152737.1184244-1-chenhuacai@loongson.cn>
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
2.43.0


