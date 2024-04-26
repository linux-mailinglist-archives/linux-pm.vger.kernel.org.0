Return-Path: <linux-pm+bounces-7194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E114D8B394F
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4ACB2515C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6897A1487FF;
	Fri, 26 Apr 2024 13:58:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA58148317;
	Fri, 26 Apr 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139923; cv=none; b=Ax+MU30b7+Pn1kqzsP5hP1w2mOW6SB7yPJ13mJ41C7ERjEFgkfDB03YofChufmm/0c95eJf8zLPGVeND0dyK5P1MUXyAxCXZCznFl6b4qY4Q+bPBKiqPctvxPdQDd7KncPM+rMKNHLsi/yvRbRoRuJgkMDb4RLDR78UFUEZKYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139923; c=relaxed/simple;
	bh=kdlYUCV3Md6Cg91FTWPIeZpb+G6UbOiI5GcDos6hRHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1VAw6bIaaMyPQk4xOAhK4HgyrjftIENTEIxyN/XwYoBT8u20h86EJnKRXHbpjNK4vZTG037VA7WabsFjbS0AFQEiJCbksLaR1hRhuMDPyQxWImD5Z/2+DFnba87Fq2ZILcwU2CS2vHzdv3jRLpOE08nTSHy/oXmsBJOJ8hIIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQvQM0KKWz67Q7R;
	Fri, 26 Apr 2024 21:56:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C08B2140A70;
	Fri, 26 Apr 2024 21:58:39 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 14:58:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v8 14/16] arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is enabled.
Date: Fri, 26 Apr 2024 14:51:24 +0100
Message-ID: <20240426135126.12802-15-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

In order to move arch_register_cpu() to be called via the same path
for initially present CPUs described by ACPI and hotplugged CPUs
ACPI_HOTPLUG_CPU needs to be enabled.

The protection against invalid IDs in acpi_map_cpu() is needed as
at least one production BIOS is in the wild which reports entries
in DSDT (with no _STA method, so assumed enabled and present)
that don't match MADT.

Tested-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v8: If acpi_map_cpu() stub is passed an error code as pcpu, don't
    pretend it worked.
    Note that x86 relies on passing an invalid error code in here
    to indicate a CPU ID needs to be allocated, on ARM64 if we
    don't get something valid there is nothing we can do about it.
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..fed7d0d54179 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,6 +5,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
+	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dba8fcec7f33..fb9368197c74 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -29,6 +29,7 @@
 #include <linux/pgtable.h>
 
 #include <acpi/ghes.h>
+#include <acpi/processor.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/daifflags.h>
@@ -413,6 +414,27 @@ void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	memblock_mark_nomap(addr, size);
 }
 
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 apci_id,
+		 int *pcpu)
+{
+	/* If an error code is passed in this stub can't fix it */
+	if (*pcpu < 0) {
+		pr_warn_once("Unable to map CPU to valid ID\n");
+		return *pcpu;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_map_cpu);
+
+int acpi_unmap_cpu(int cpu)
+{
+	return 0;
+}
+EXPORT_SYMBOL(acpi_unmap_cpu);
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
 #ifdef CONFIG_ACPI_FFH
 /*
  * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
-- 
2.39.2


