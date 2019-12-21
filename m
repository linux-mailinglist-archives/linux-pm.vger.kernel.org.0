Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4A128731
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2019 05:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLUEp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 23:45:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:31824 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfLUEpz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Dec 2019 23:45:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620063"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:45:52 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v5 02/19] selftests: kvm: Replace manual MSR defs with common msr-index.h
Date:   Fri, 20 Dec 2019 20:44:56 -0800
Message-Id: <20191221044513.21680-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221044513.21680-1-sean.j.christopherson@intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The kernel's version of msr-index.h was pulled wholesale into tools by
commit 444e2ff34df8 ("tools arch x86: Grab a copy of the file containing
the MSR numbers"), use the common msr-index.h instead of manually
redefining everything in a KVM-only header.

Note, a few MSR related definitions remain in processor.h because they
are not covered by msr-index.h, including the awesomely named
APIC_BASE_MSR, which refers to starting index of the x2APIC MSRs, not
the actual MSR_IA32_APICBASE, which *is* defined by msr-index.h.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |   4 +-
 .../selftests/kvm/include/x86_64/processor.h  | 726 +-----------------
 2 files changed, 6 insertions(+), 724 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 3138a916574a..608fa835c764 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -45,9 +45,11 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
+LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
-	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
+	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
+	-I$(<D) -Iinclude/$(UNAME_M) -I..
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 635ee6c33ad2..aa6451b3f740 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -11,6 +11,8 @@
 #include <assert.h>
 #include <stdint.h>
 
+#include <asm/msr-index.h>
+
 #define X86_EFLAGS_FIXED	 (1u << 1)
 
 #define X86_CR4_VME		(1ul << 0)
@@ -348,444 +350,6 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
 #define X86_CR0_CD          (1UL<<30) /* Cache Disable */
 #define X86_CR0_PG          (1UL<<31) /* Paging */
 
-/*
- * CPU model specific register (MSR) numbers.
- */
-
-/* x86-64 specific MSRs */
-#define MSR_EFER		0xc0000080 /* extended feature register */
-#define MSR_STAR		0xc0000081 /* legacy mode SYSCALL target */
-#define MSR_LSTAR		0xc0000082 /* long mode SYSCALL target */
-#define MSR_CSTAR		0xc0000083 /* compat mode SYSCALL target */
-#define MSR_SYSCALL_MASK	0xc0000084 /* EFLAGS mask for syscall */
-#define MSR_FS_BASE		0xc0000100 /* 64bit FS base */
-#define MSR_GS_BASE		0xc0000101 /* 64bit GS base */
-#define MSR_KERNEL_GS_BASE	0xc0000102 /* SwapGS GS shadow */
-#define MSR_TSC_AUX		0xc0000103 /* Auxiliary TSC */
-
-/* EFER bits: */
-#define EFER_SCE		(1<<0)  /* SYSCALL/SYSRET */
-#define EFER_LME		(1<<8)  /* Long mode enable */
-#define EFER_LMA		(1<<10) /* Long mode active (read-only) */
-#define EFER_NX			(1<<11) /* No execute enable */
-#define EFER_SVME		(1<<12) /* Enable virtualization */
-#define EFER_LMSLE		(1<<13) /* Long Mode Segment Limit Enable */
-#define EFER_FFXSR		(1<<14) /* Enable Fast FXSAVE/FXRSTOR */
-
-/* Intel MSRs. Some also available on other CPUs */
-
-#define MSR_PPIN_CTL			0x0000004e
-#define MSR_PPIN			0x0000004f
-
-#define MSR_IA32_PERFCTR0		0x000000c1
-#define MSR_IA32_PERFCTR1		0x000000c2
-#define MSR_FSB_FREQ			0x000000cd
-#define MSR_PLATFORM_INFO		0x000000ce
-#define MSR_PLATFORM_INFO_CPUID_FAULT_BIT	31
-#define MSR_PLATFORM_INFO_CPUID_FAULT		BIT_ULL(MSR_PLATFORM_INFO_CPUID_FAULT_BIT)
-
-#define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
-#define NHM_C3_AUTO_DEMOTE		(1UL << 25)
-#define NHM_C1_AUTO_DEMOTE		(1UL << 26)
-#define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
-#define SNB_C1_AUTO_UNDEMOTE		(1UL << 27)
-#define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
-
-#define MSR_MTRRcap			0x000000fe
-#define MSR_IA32_BBL_CR_CTL		0x00000119
-#define MSR_IA32_BBL_CR_CTL3		0x0000011e
-
-#define MSR_IA32_SYSENTER_CS		0x00000174
-#define MSR_IA32_SYSENTER_ESP		0x00000175
-#define MSR_IA32_SYSENTER_EIP		0x00000176
-
-#define MSR_IA32_MCG_CAP		0x00000179
-#define MSR_IA32_MCG_STATUS		0x0000017a
-#define MSR_IA32_MCG_CTL		0x0000017b
-#define MSR_IA32_MCG_EXT_CTL		0x000004d0
-
-#define MSR_OFFCORE_RSP_0		0x000001a6
-#define MSR_OFFCORE_RSP_1		0x000001a7
-#define MSR_TURBO_RATIO_LIMIT		0x000001ad
-#define MSR_TURBO_RATIO_LIMIT1		0x000001ae
-#define MSR_TURBO_RATIO_LIMIT2		0x000001af
-
-#define MSR_LBR_SELECT			0x000001c8
-#define MSR_LBR_TOS			0x000001c9
-#define MSR_LBR_NHM_FROM		0x00000680
-#define MSR_LBR_NHM_TO			0x000006c0
-#define MSR_LBR_CORE_FROM		0x00000040
-#define MSR_LBR_CORE_TO			0x00000060
-
-#define MSR_LBR_INFO_0			0x00000dc0 /* ... 0xddf for _31 */
-#define LBR_INFO_MISPRED		BIT_ULL(63)
-#define LBR_INFO_IN_TX			BIT_ULL(62)
-#define LBR_INFO_ABORT			BIT_ULL(61)
-#define LBR_INFO_CYCLES			0xffff
-
-#define MSR_IA32_PEBS_ENABLE		0x000003f1
-#define MSR_IA32_DS_AREA		0x00000600
-#define MSR_IA32_PERF_CAPABILITIES	0x00000345
-#define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
-
-#define MSR_IA32_RTIT_CTL		0x00000570
-#define MSR_IA32_RTIT_STATUS		0x00000571
-#define MSR_IA32_RTIT_ADDR0_A		0x00000580
-#define MSR_IA32_RTIT_ADDR0_B		0x00000581
-#define MSR_IA32_RTIT_ADDR1_A		0x00000582
-#define MSR_IA32_RTIT_ADDR1_B		0x00000583
-#define MSR_IA32_RTIT_ADDR2_A		0x00000584
-#define MSR_IA32_RTIT_ADDR2_B		0x00000585
-#define MSR_IA32_RTIT_ADDR3_A		0x00000586
-#define MSR_IA32_RTIT_ADDR3_B		0x00000587
-#define MSR_IA32_RTIT_CR3_MATCH		0x00000572
-#define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
-#define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
-
-#define MSR_MTRRfix64K_00000		0x00000250
-#define MSR_MTRRfix16K_80000		0x00000258
-#define MSR_MTRRfix16K_A0000		0x00000259
-#define MSR_MTRRfix4K_C0000		0x00000268
-#define MSR_MTRRfix4K_C8000		0x00000269
-#define MSR_MTRRfix4K_D0000		0x0000026a
-#define MSR_MTRRfix4K_D8000		0x0000026b
-#define MSR_MTRRfix4K_E0000		0x0000026c
-#define MSR_MTRRfix4K_E8000		0x0000026d
-#define MSR_MTRRfix4K_F0000		0x0000026e
-#define MSR_MTRRfix4K_F8000		0x0000026f
-#define MSR_MTRRdefType			0x000002ff
-
-#define MSR_IA32_CR_PAT			0x00000277
-
-#define MSR_IA32_DEBUGCTLMSR		0x000001d9
-#define MSR_IA32_LASTBRANCHFROMIP	0x000001db
-#define MSR_IA32_LASTBRANCHTOIP		0x000001dc
-#define MSR_IA32_LASTINTFROMIP		0x000001dd
-#define MSR_IA32_LASTINTTOIP		0x000001de
-
-/* DEBUGCTLMSR bits (others vary by model): */
-#define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
-#define DEBUGCTLMSR_BTF_SHIFT		1
-#define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
-#define DEBUGCTLMSR_TR			(1UL <<  6)
-#define DEBUGCTLMSR_BTS			(1UL <<  7)
-#define DEBUGCTLMSR_BTINT		(1UL <<  8)
-#define DEBUGCTLMSR_BTS_OFF_OS		(1UL <<  9)
-#define DEBUGCTLMSR_BTS_OFF_USR		(1UL << 10)
-#define DEBUGCTLMSR_FREEZE_LBRS_ON_PMI	(1UL << 11)
-#define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
-#define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
-
-#define MSR_PEBS_FRONTEND		0x000003f7
-
-#define MSR_IA32_POWER_CTL		0x000001fc
-
-#define MSR_IA32_MC0_CTL		0x00000400
-#define MSR_IA32_MC0_STATUS		0x00000401
-#define MSR_IA32_MC0_ADDR		0x00000402
-#define MSR_IA32_MC0_MISC		0x00000403
-
-/* C-state Residency Counters */
-#define MSR_PKG_C3_RESIDENCY		0x000003f8
-#define MSR_PKG_C6_RESIDENCY		0x000003f9
-#define MSR_ATOM_PKG_C6_RESIDENCY	0x000003fa
-#define MSR_PKG_C7_RESIDENCY		0x000003fa
-#define MSR_CORE_C3_RESIDENCY		0x000003fc
-#define MSR_CORE_C6_RESIDENCY		0x000003fd
-#define MSR_CORE_C7_RESIDENCY		0x000003fe
-#define MSR_KNL_CORE_C6_RESIDENCY	0x000003ff
-#define MSR_PKG_C2_RESIDENCY		0x0000060d
-#define MSR_PKG_C8_RESIDENCY		0x00000630
-#define MSR_PKG_C9_RESIDENCY		0x00000631
-#define MSR_PKG_C10_RESIDENCY		0x00000632
-
-/* Interrupt Response Limit */
-#define MSR_PKGC3_IRTL			0x0000060a
-#define MSR_PKGC6_IRTL			0x0000060b
-#define MSR_PKGC7_IRTL			0x0000060c
-#define MSR_PKGC8_IRTL			0x00000633
-#define MSR_PKGC9_IRTL			0x00000634
-#define MSR_PKGC10_IRTL			0x00000635
-
-/* Run Time Average Power Limiting (RAPL) Interface */
-
-#define MSR_RAPL_POWER_UNIT		0x00000606
-
-#define MSR_PKG_POWER_LIMIT		0x00000610
-#define MSR_PKG_ENERGY_STATUS		0x00000611
-#define MSR_PKG_PERF_STATUS		0x00000613
-#define MSR_PKG_POWER_INFO		0x00000614
-
-#define MSR_DRAM_POWER_LIMIT		0x00000618
-#define MSR_DRAM_ENERGY_STATUS		0x00000619
-#define MSR_DRAM_PERF_STATUS		0x0000061b
-#define MSR_DRAM_POWER_INFO		0x0000061c
-
-#define MSR_PP0_POWER_LIMIT		0x00000638
-#define MSR_PP0_ENERGY_STATUS		0x00000639
-#define MSR_PP0_POLICY			0x0000063a
-#define MSR_PP0_PERF_STATUS		0x0000063b
-
-#define MSR_PP1_POWER_LIMIT		0x00000640
-#define MSR_PP1_ENERGY_STATUS		0x00000641
-#define MSR_PP1_POLICY			0x00000642
-
-/* Config TDP MSRs */
-#define MSR_CONFIG_TDP_NOMINAL		0x00000648
-#define MSR_CONFIG_TDP_LEVEL_1		0x00000649
-#define MSR_CONFIG_TDP_LEVEL_2		0x0000064A
-#define MSR_CONFIG_TDP_CONTROL		0x0000064B
-#define MSR_TURBO_ACTIVATION_RATIO	0x0000064C
-
-#define MSR_PLATFORM_ENERGY_STATUS	0x0000064D
-
-#define MSR_PKG_WEIGHTED_CORE_C0_RES	0x00000658
-#define MSR_PKG_ANY_CORE_C0_RES		0x00000659
-#define MSR_PKG_ANY_GFXE_C0_RES		0x0000065A
-#define MSR_PKG_BOTH_CORE_GFXE_C0_RES	0x0000065B
-
-#define MSR_CORE_C1_RES			0x00000660
-#define MSR_MODULE_C6_RES_MS		0x00000664
-
-#define MSR_CC6_DEMOTION_POLICY_CONFIG	0x00000668
-#define MSR_MC6_DEMOTION_POLICY_CONFIG	0x00000669
-
-#define MSR_ATOM_CORE_RATIOS		0x0000066a
-#define MSR_ATOM_CORE_VIDS		0x0000066b
-#define MSR_ATOM_CORE_TURBO_RATIOS	0x0000066c
-#define MSR_ATOM_CORE_TURBO_VIDS	0x0000066d
-
-
-#define MSR_CORE_PERF_LIMIT_REASONS	0x00000690
-#define MSR_GFX_PERF_LIMIT_REASONS	0x000006B0
-#define MSR_RING_PERF_LIMIT_REASONS	0x000006B1
-
-/* Hardware P state interface */
-#define MSR_PPERF			0x0000064e
-#define MSR_PERF_LIMIT_REASONS		0x0000064f
-#define MSR_PM_ENABLE			0x00000770
-#define MSR_HWP_CAPABILITIES		0x00000771
-#define MSR_HWP_REQUEST_PKG		0x00000772
-#define MSR_HWP_INTERRUPT		0x00000773
-#define MSR_HWP_REQUEST			0x00000774
-#define MSR_HWP_STATUS			0x00000777
-
-/* CPUID.6.EAX */
-#define HWP_BASE_BIT			(1<<7)
-#define HWP_NOTIFICATIONS_BIT		(1<<8)
-#define HWP_ACTIVITY_WINDOW_BIT		(1<<9)
-#define HWP_ENERGY_PERF_PREFERENCE_BIT	(1<<10)
-#define HWP_PACKAGE_LEVEL_REQUEST_BIT	(1<<11)
-
-/* IA32_HWP_CAPABILITIES */
-#define HWP_HIGHEST_PERF(x)		(((x) >> 0) & 0xff)
-#define HWP_GUARANTEED_PERF(x)		(((x) >> 8) & 0xff)
-#define HWP_MOSTEFFICIENT_PERF(x)	(((x) >> 16) & 0xff)
-#define HWP_LOWEST_PERF(x)		(((x) >> 24) & 0xff)
-
-/* IA32_HWP_REQUEST */
-#define HWP_MIN_PERF(x)			(x & 0xff)
-#define HWP_MAX_PERF(x)			((x & 0xff) << 8)
-#define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
-#define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long) x & 0xff) << 24)
-#define HWP_EPP_PERFORMANCE		0x00
-#define HWP_EPP_BALANCE_PERFORMANCE	0x80
-#define HWP_EPP_BALANCE_POWERSAVE	0xC0
-#define HWP_EPP_POWERSAVE		0xFF
-#define HWP_ACTIVITY_WINDOW(x)		((unsigned long long)(x & 0xff3) << 32)
-#define HWP_PACKAGE_CONTROL(x)		((unsigned long long)(x & 0x1) << 42)
-
-/* IA32_HWP_STATUS */
-#define HWP_GUARANTEED_CHANGE(x)	(x & 0x1)
-#define HWP_EXCURSION_TO_MINIMUM(x)	(x & 0x4)
-
-/* IA32_HWP_INTERRUPT */
-#define HWP_CHANGE_TO_GUARANTEED_INT(x)	(x & 0x1)
-#define HWP_EXCURSION_TO_MINIMUM_INT(x)	(x & 0x2)
-
-#define MSR_AMD64_MC0_MASK		0xc0010044
-
-#define MSR_IA32_MCx_CTL(x)		(MSR_IA32_MC0_CTL + 4*(x))
-#define MSR_IA32_MCx_STATUS(x)		(MSR_IA32_MC0_STATUS + 4*(x))
-#define MSR_IA32_MCx_ADDR(x)		(MSR_IA32_MC0_ADDR + 4*(x))
-#define MSR_IA32_MCx_MISC(x)		(MSR_IA32_MC0_MISC + 4*(x))
-
-#define MSR_AMD64_MCx_MASK(x)		(MSR_AMD64_MC0_MASK + (x))
-
-/* These are consecutive and not in the normal 4er MCE bank block */
-#define MSR_IA32_MC0_CTL2		0x00000280
-#define MSR_IA32_MCx_CTL2(x)		(MSR_IA32_MC0_CTL2 + (x))
-
-#define MSR_P6_PERFCTR0			0x000000c1
-#define MSR_P6_PERFCTR1			0x000000c2
-#define MSR_P6_EVNTSEL0			0x00000186
-#define MSR_P6_EVNTSEL1			0x00000187
-
-#define MSR_KNC_PERFCTR0               0x00000020
-#define MSR_KNC_PERFCTR1               0x00000021
-#define MSR_KNC_EVNTSEL0               0x00000028
-#define MSR_KNC_EVNTSEL1               0x00000029
-
-/* Alternative perfctr range with full access. */
-#define MSR_IA32_PMC0			0x000004c1
-
-/* AMD64 MSRs. Not complete. See the architecture manual for a more
-   complete list. */
-
-#define MSR_AMD64_PATCH_LEVEL		0x0000008b
-#define MSR_AMD64_TSC_RATIO		0xc0000104
-#define MSR_AMD64_NB_CFG		0xc001001f
-#define MSR_AMD64_PATCH_LOADER		0xc0010020
-#define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
-#define MSR_AMD64_OSVW_STATUS		0xc0010141
-#define MSR_AMD64_LS_CFG		0xc0011020
-#define MSR_AMD64_DC_CFG		0xc0011022
-#define MSR_AMD64_BU_CFG2		0xc001102a
-#define MSR_AMD64_IBSFETCHCTL		0xc0011030
-#define MSR_AMD64_IBSFETCHLINAD		0xc0011031
-#define MSR_AMD64_IBSFETCHPHYSAD	0xc0011032
-#define MSR_AMD64_IBSFETCH_REG_COUNT	3
-#define MSR_AMD64_IBSFETCH_REG_MASK	((1UL<<MSR_AMD64_IBSFETCH_REG_COUNT)-1)
-#define MSR_AMD64_IBSOPCTL		0xc0011033
-#define MSR_AMD64_IBSOPRIP		0xc0011034
-#define MSR_AMD64_IBSOPDATA		0xc0011035
-#define MSR_AMD64_IBSOPDATA2		0xc0011036
-#define MSR_AMD64_IBSOPDATA3		0xc0011037
-#define MSR_AMD64_IBSDCLINAD		0xc0011038
-#define MSR_AMD64_IBSDCPHYSAD		0xc0011039
-#define MSR_AMD64_IBSOP_REG_COUNT	7
-#define MSR_AMD64_IBSOP_REG_MASK	((1UL<<MSR_AMD64_IBSOP_REG_COUNT)-1)
-#define MSR_AMD64_IBSCTL		0xc001103a
-#define MSR_AMD64_IBSBRTARGET		0xc001103b
-#define MSR_AMD64_IBSOPDATA4		0xc001103d
-#define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
-#define MSR_AMD64_SEV			0xc0010131
-#define MSR_AMD64_SEV_ENABLED_BIT	0
-#define MSR_AMD64_SEV_ENABLED		BIT_ULL(MSR_AMD64_SEV_ENABLED_BIT)
-
-/* Fam 17h MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
-
-/* Fam 16h MSRs */
-#define MSR_F16H_L2I_PERF_CTL		0xc0010230
-#define MSR_F16H_L2I_PERF_CTR		0xc0010231
-#define MSR_F16H_DR1_ADDR_MASK		0xc0011019
-#define MSR_F16H_DR2_ADDR_MASK		0xc001101a
-#define MSR_F16H_DR3_ADDR_MASK		0xc001101b
-#define MSR_F16H_DR0_ADDR_MASK		0xc0011027
-
-/* Fam 15h MSRs */
-#define MSR_F15H_PERF_CTL		0xc0010200
-#define MSR_F15H_PERF_CTR		0xc0010201
-#define MSR_F15H_NB_PERF_CTL		0xc0010240
-#define MSR_F15H_NB_PERF_CTR		0xc0010241
-#define MSR_F15H_PTSC			0xc0010280
-#define MSR_F15H_IC_CFG			0xc0011021
-
-/* Fam 10h MSRs */
-#define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
-#define FAM10H_MMIO_CONF_ENABLE		(1<<0)
-#define FAM10H_MMIO_CONF_BUSRANGE_MASK	0xf
-#define FAM10H_MMIO_CONF_BUSRANGE_SHIFT 2
-#define FAM10H_MMIO_CONF_BASE_MASK	0xfffffffULL
-#define FAM10H_MMIO_CONF_BASE_SHIFT	20
-#define MSR_FAM10H_NODE_ID		0xc001100c
-#define MSR_F10H_DECFG			0xc0011029
-#define MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT	1
-#define MSR_F10H_DECFG_LFENCE_SERIALIZE		BIT_ULL(MSR_F10H_DECFG_LFENCE_SERIALIZE_BIT)
-
-/* K8 MSRs */
-#define MSR_K8_TOP_MEM1			0xc001001a
-#define MSR_K8_TOP_MEM2			0xc001001d
-#define MSR_K8_SYSCFG			0xc0010010
-#define MSR_K8_SYSCFG_MEM_ENCRYPT_BIT	23
-#define MSR_K8_SYSCFG_MEM_ENCRYPT	BIT_ULL(MSR_K8_SYSCFG_MEM_ENCRYPT_BIT)
-#define MSR_K8_INT_PENDING_MSG		0xc0010055
-/* C1E active bits in int pending message */
-#define K8_INTP_C1E_ACTIVE_MASK		0x18000000
-#define MSR_K8_TSEG_ADDR		0xc0010112
-#define MSR_K8_TSEG_MASK		0xc0010113
-#define K8_MTRRFIXRANGE_DRAM_ENABLE	0x00040000 /* MtrrFixDramEn bit    */
-#define K8_MTRRFIXRANGE_DRAM_MODIFY	0x00080000 /* MtrrFixDramModEn bit */
-#define K8_MTRR_RDMEM_WRMEM_MASK	0x18181818 /* Mask: RdMem|WrMem    */
-
-/* K7 MSRs */
-#define MSR_K7_EVNTSEL0			0xc0010000
-#define MSR_K7_PERFCTR0			0xc0010004
-#define MSR_K7_EVNTSEL1			0xc0010001
-#define MSR_K7_PERFCTR1			0xc0010005
-#define MSR_K7_EVNTSEL2			0xc0010002
-#define MSR_K7_PERFCTR2			0xc0010006
-#define MSR_K7_EVNTSEL3			0xc0010003
-#define MSR_K7_PERFCTR3			0xc0010007
-#define MSR_K7_CLK_CTL			0xc001001b
-#define MSR_K7_HWCR			0xc0010015
-#define MSR_K7_HWCR_SMMLOCK_BIT		0
-#define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
-#define MSR_K7_FID_VID_CTL		0xc0010041
-#define MSR_K7_FID_VID_STATUS		0xc0010042
-
-/* K6 MSRs */
-#define MSR_K6_WHCR			0xc0000082
-#define MSR_K6_UWCCR			0xc0000085
-#define MSR_K6_EPMR			0xc0000086
-#define MSR_K6_PSOR			0xc0000087
-#define MSR_K6_PFIR			0xc0000088
-
-/* Centaur-Hauls/IDT defined MSRs. */
-#define MSR_IDT_FCR1			0x00000107
-#define MSR_IDT_FCR2			0x00000108
-#define MSR_IDT_FCR3			0x00000109
-#define MSR_IDT_FCR4			0x0000010a
-
-#define MSR_IDT_MCR0			0x00000110
-#define MSR_IDT_MCR1			0x00000111
-#define MSR_IDT_MCR2			0x00000112
-#define MSR_IDT_MCR3			0x00000113
-#define MSR_IDT_MCR4			0x00000114
-#define MSR_IDT_MCR5			0x00000115
-#define MSR_IDT_MCR6			0x00000116
-#define MSR_IDT_MCR7			0x00000117
-#define MSR_IDT_MCR_CTRL		0x00000120
-
-/* VIA Cyrix defined MSRs*/
-#define MSR_VIA_FCR			0x00001107
-#define MSR_VIA_LONGHAUL		0x0000110a
-#define MSR_VIA_RNG			0x0000110b
-#define MSR_VIA_BCR2			0x00001147
-
-/* Transmeta defined MSRs */
-#define MSR_TMTA_LONGRUN_CTRL		0x80868010
-#define MSR_TMTA_LONGRUN_FLAGS		0x80868011
-#define MSR_TMTA_LRTI_READOUT		0x80868018
-#define MSR_TMTA_LRTI_VOLT_MHZ		0x8086801a
-
-/* Intel defined MSRs. */
-#define MSR_IA32_P5_MC_ADDR		0x00000000
-#define MSR_IA32_P5_MC_TYPE		0x00000001
-#define MSR_IA32_TSC			0x00000010
-#define MSR_IA32_PLATFORM_ID		0x00000017
-#define MSR_IA32_EBL_CR_POWERON		0x0000002a
-#define MSR_EBC_FREQUENCY_ID		0x0000002c
-#define MSR_SMI_COUNT			0x00000034
-#define MSR_IA32_FEATURE_CONTROL        0x0000003a
-#define MSR_IA32_TSC_ADJUST             0x0000003b
-#define MSR_IA32_BNDCFGS		0x00000d90
-
-#define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
-
-#define MSR_IA32_XSS			0x00000da0
-
-#define FEATURE_CONTROL_LOCKED				(1<<0)
-#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
-#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
-#define FEATURE_CONTROL_LMCE				(1<<20)
-
-#define MSR_IA32_APICBASE		0x0000001b
-#define MSR_IA32_APICBASE_BSP		(1<<8)
-#define MSR_IA32_APICBASE_ENABLE	(1<<11)
-#define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
-
 #define APIC_BASE_MSR	0x800
 #define X2APIC_ENABLE	(1UL << 10)
 #define	APIC_ICR	0x300
@@ -813,291 +377,7 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
 #define		APIC_VECTOR_MASK	0x000FF
 #define	APIC_ICR2	0x310
 
-#define MSR_IA32_TSCDEADLINE		0x000006e0
-
-#define MSR_IA32_UCODE_WRITE		0x00000079
-#define MSR_IA32_UCODE_REV		0x0000008b
-
-#define MSR_IA32_SMM_MONITOR_CTL	0x0000009b
-#define MSR_IA32_SMBASE			0x0000009e
-
-#define MSR_IA32_PERF_STATUS		0x00000198
-#define MSR_IA32_PERF_CTL		0x00000199
-#define INTEL_PERF_CTL_MASK		0xffff
-#define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
-#define MSR_AMD_PERF_STATUS		0xc0010063
-#define MSR_AMD_PERF_CTL		0xc0010062
-
-#define MSR_IA32_MPERF			0x000000e7
-#define MSR_IA32_APERF			0x000000e8
-
-#define MSR_IA32_THERM_CONTROL		0x0000019a
-#define MSR_IA32_THERM_INTERRUPT	0x0000019b
-
-#define THERM_INT_HIGH_ENABLE		(1 << 0)
-#define THERM_INT_LOW_ENABLE		(1 << 1)
-#define THERM_INT_PLN_ENABLE		(1 << 24)
-
-#define MSR_IA32_THERM_STATUS		0x0000019c
-
-#define THERM_STATUS_PROCHOT		(1 << 0)
-#define THERM_STATUS_POWER_LIMIT	(1 << 10)
-
-#define MSR_THERM2_CTL			0x0000019d
-
-#define MSR_THERM2_CTL_TM_SELECT	(1ULL << 16)
-
-#define MSR_IA32_MISC_ENABLE		0x000001a0
-
-#define MSR_IA32_TEMPERATURE_TARGET	0x000001a2
-
-#define MSR_MISC_FEATURE_CONTROL	0x000001a4
-#define MSR_MISC_PWR_MGMT		0x000001aa
-
-#define MSR_IA32_ENERGY_PERF_BIAS	0x000001b0
-#define ENERGY_PERF_BIAS_PERFORMANCE		0
-#define ENERGY_PERF_BIAS_BALANCE_PERFORMANCE	4
-#define ENERGY_PERF_BIAS_NORMAL			6
-#define ENERGY_PERF_BIAS_BALANCE_POWERSAVE	8
-#define ENERGY_PERF_BIAS_POWERSAVE		15
-
-#define MSR_IA32_PACKAGE_THERM_STATUS		0x000001b1
-
-#define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
-#define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
-
-#define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2
-
-#define PACKAGE_THERM_INT_HIGH_ENABLE		(1 << 0)
-#define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
-#define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
-
-/* Thermal Thresholds Support */
-#define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
-#define THERM_SHIFT_THRESHOLD0        8
-#define THERM_MASK_THRESHOLD0          (0x7f << THERM_SHIFT_THRESHOLD0)
-#define THERM_INT_THRESHOLD1_ENABLE    (1 << 23)
-#define THERM_SHIFT_THRESHOLD1        16
-#define THERM_MASK_THRESHOLD1          (0x7f << THERM_SHIFT_THRESHOLD1)
-#define THERM_STATUS_THRESHOLD0        (1 << 6)
-#define THERM_LOG_THRESHOLD0           (1 << 7)
-#define THERM_STATUS_THRESHOLD1        (1 << 8)
-#define THERM_LOG_THRESHOLD1           (1 << 9)
-
-/* MISC_ENABLE bits: architectural */
-#define MSR_IA32_MISC_ENABLE_FAST_STRING_BIT		0
-#define MSR_IA32_MISC_ENABLE_FAST_STRING		(1ULL << MSR_IA32_MISC_ENABLE_FAST_STRING_BIT)
-#define MSR_IA32_MISC_ENABLE_TCC_BIT			1
-#define MSR_IA32_MISC_ENABLE_TCC			(1ULL << MSR_IA32_MISC_ENABLE_TCC_BIT)
-#define MSR_IA32_MISC_ENABLE_EMON_BIT			7
-#define MSR_IA32_MISC_ENABLE_EMON			(1ULL << MSR_IA32_MISC_ENABLE_EMON_BIT)
-#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL_BIT		11
-#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL		(1ULL << MSR_IA32_MISC_ENABLE_BTS_UNAVAIL_BIT)
-#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL_BIT		12
-#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL		(1ULL << MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL_BIT)
-#define MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP_BIT	16
-#define MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP		(1ULL << MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP_BIT)
-#define MSR_IA32_MISC_ENABLE_MWAIT_BIT			18
-#define MSR_IA32_MISC_ENABLE_MWAIT			(1ULL << MSR_IA32_MISC_ENABLE_MWAIT_BIT)
-#define MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT		22
-#define MSR_IA32_MISC_ENABLE_LIMIT_CPUID		(1ULL << MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT)
-#define MSR_IA32_MISC_ENABLE_XTPR_DISABLE_BIT		23
-#define MSR_IA32_MISC_ENABLE_XTPR_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_XTPR_DISABLE_BIT)
-#define MSR_IA32_MISC_ENABLE_XD_DISABLE_BIT		34
-#define MSR_IA32_MISC_ENABLE_XD_DISABLE			(1ULL << MSR_IA32_MISC_ENABLE_XD_DISABLE_BIT)
-
-/* MISC_ENABLE bits: model-specific, meaning may vary from core to core */
-#define MSR_IA32_MISC_ENABLE_X87_COMPAT_BIT		2
-#define MSR_IA32_MISC_ENABLE_X87_COMPAT			(1ULL << MSR_IA32_MISC_ENABLE_X87_COMPAT_BIT)
-#define MSR_IA32_MISC_ENABLE_TM1_BIT			3
-#define MSR_IA32_MISC_ENABLE_TM1			(1ULL << MSR_IA32_MISC_ENABLE_TM1_BIT)
-#define MSR_IA32_MISC_ENABLE_SPLIT_LOCK_DISABLE_BIT	4
-#define MSR_IA32_MISC_ENABLE_SPLIT_LOCK_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_SPLIT_LOCK_DISABLE_BIT)
-#define MSR_IA32_MISC_ENABLE_L3CACHE_DISABLE_BIT	6
-#define MSR_IA32_MISC_ENABLE_L3CACHE_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_L3CACHE_DISABLE_BIT)
-#define MSR_IA32_MISC_ENABLE_SUPPRESS_LOCK_BIT		8
-#define MSR_IA32_MISC_ENABLE_SUPPRESS_LOCK		(1ULL << MSR_IA32_MISC_ENABLE_SUPPRESS_LOCK_BIT)
-#define MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT	9
-#define MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT)
-#define MSR_IA32_MISC_ENABLE_FERR_BIT			10
-#define MSR_IA32_MISC_ENABLE_FERR			(1ULL << MSR_IA32_MISC_ENABLE_FERR_BIT)
-#define MSR_IA32_MISC_ENABLE_FERR_MULTIPLEX_BIT		10
-#define MSR_IA32_MISC_ENABLE_FERR_MULTIPLEX		(1ULL << MSR_IA32_MISC_ENABLE_FERR_MULTIPLEX_BIT)
-#define MSR_IA32_MISC_ENABLE_TM2_BIT			13
-#define MSR_IA32_MISC_ENABLE_TM2			(1ULL << MSR_IA32_MISC_ENABLE_TM2_BIT)
-#define MSR_IA32_MISC_ENABLE_ADJ_PREF_DISABLE_BIT	19
-#define MSR_IA32_MISC_ENABLE_ADJ_PREF_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_ADJ_PREF_DISABLE_BIT)
-#define MSR_IA32_MISC_ENABLE_SPEEDSTEP_LOCK_BIT		20
-#define MSR_IA32_MISC_ENABLE_SPEEDSTEP_LOCK		(1ULL << MSR_IA32_MISC_ENABLE_SPEEDSTEP_LOCK_BIT)
-#define MSR_IA32_MISC_ENABLE_L1D_CONTEXT_BIT		24
-#define MSR_IA32_MISC_ENABLE_L1D_CONTEXT		(1ULL << MSR_IA32_MISC_ENABLE_L1D_CONTEXT_BIT)
-#define MSR_IA32_MISC_ENABLE_DCU_PREF_DISABLE_BIT	37
-#define MSR_IA32_MISC_ENABLE_DCU_PREF_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_DCU_PREF_DISABLE_BIT)
-#define MSR_IA32_MISC_ENABLE_TURBO_DISABLE_BIT		38
-#define MSR_IA32_MISC_ENABLE_TURBO_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_TURBO_DISABLE_BIT)
-#define MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE_BIT	39
-#define MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE		(1ULL << MSR_IA32_MISC_ENABLE_IP_PREF_DISABLE_BIT)
-
-/* MISC_FEATURES_ENABLES non-architectural features */
-#define MSR_MISC_FEATURES_ENABLES	0x00000140
-
-#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT	0
-#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT		BIT_ULL(MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT)
-#define MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT	1
-
-#define MSR_IA32_TSC_DEADLINE		0x000006E0
-
-/* P4/Xeon+ specific */
-#define MSR_IA32_MCG_EAX		0x00000180
-#define MSR_IA32_MCG_EBX		0x00000181
-#define MSR_IA32_MCG_ECX		0x00000182
-#define MSR_IA32_MCG_EDX		0x00000183
-#define MSR_IA32_MCG_ESI		0x00000184
-#define MSR_IA32_MCG_EDI		0x00000185
-#define MSR_IA32_MCG_EBP		0x00000186
-#define MSR_IA32_MCG_ESP		0x00000187
-#define MSR_IA32_MCG_EFLAGS		0x00000188
-#define MSR_IA32_MCG_EIP		0x00000189
-#define MSR_IA32_MCG_RESERVED		0x0000018a
-
-/* Pentium IV performance counter MSRs */
-#define MSR_P4_BPU_PERFCTR0		0x00000300
-#define MSR_P4_BPU_PERFCTR1		0x00000301
-#define MSR_P4_BPU_PERFCTR2		0x00000302
-#define MSR_P4_BPU_PERFCTR3		0x00000303
-#define MSR_P4_MS_PERFCTR0		0x00000304
-#define MSR_P4_MS_PERFCTR1		0x00000305
-#define MSR_P4_MS_PERFCTR2		0x00000306
-#define MSR_P4_MS_PERFCTR3		0x00000307
-#define MSR_P4_FLAME_PERFCTR0		0x00000308
-#define MSR_P4_FLAME_PERFCTR1		0x00000309
-#define MSR_P4_FLAME_PERFCTR2		0x0000030a
-#define MSR_P4_FLAME_PERFCTR3		0x0000030b
-#define MSR_P4_IQ_PERFCTR0		0x0000030c
-#define MSR_P4_IQ_PERFCTR1		0x0000030d
-#define MSR_P4_IQ_PERFCTR2		0x0000030e
-#define MSR_P4_IQ_PERFCTR3		0x0000030f
-#define MSR_P4_IQ_PERFCTR4		0x00000310
-#define MSR_P4_IQ_PERFCTR5		0x00000311
-#define MSR_P4_BPU_CCCR0		0x00000360
-#define MSR_P4_BPU_CCCR1		0x00000361
-#define MSR_P4_BPU_CCCR2		0x00000362
-#define MSR_P4_BPU_CCCR3		0x00000363
-#define MSR_P4_MS_CCCR0			0x00000364
-#define MSR_P4_MS_CCCR1			0x00000365
-#define MSR_P4_MS_CCCR2			0x00000366
-#define MSR_P4_MS_CCCR3			0x00000367
-#define MSR_P4_FLAME_CCCR0		0x00000368
-#define MSR_P4_FLAME_CCCR1		0x00000369
-#define MSR_P4_FLAME_CCCR2		0x0000036a
-#define MSR_P4_FLAME_CCCR3		0x0000036b
-#define MSR_P4_IQ_CCCR0			0x0000036c
-#define MSR_P4_IQ_CCCR1			0x0000036d
-#define MSR_P4_IQ_CCCR2			0x0000036e
-#define MSR_P4_IQ_CCCR3			0x0000036f
-#define MSR_P4_IQ_CCCR4			0x00000370
-#define MSR_P4_IQ_CCCR5			0x00000371
-#define MSR_P4_ALF_ESCR0		0x000003ca
-#define MSR_P4_ALF_ESCR1		0x000003cb
-#define MSR_P4_BPU_ESCR0		0x000003b2
-#define MSR_P4_BPU_ESCR1		0x000003b3
-#define MSR_P4_BSU_ESCR0		0x000003a0
-#define MSR_P4_BSU_ESCR1		0x000003a1
-#define MSR_P4_CRU_ESCR0		0x000003b8
-#define MSR_P4_CRU_ESCR1		0x000003b9
-#define MSR_P4_CRU_ESCR2		0x000003cc
-#define MSR_P4_CRU_ESCR3		0x000003cd
-#define MSR_P4_CRU_ESCR4		0x000003e0
-#define MSR_P4_CRU_ESCR5		0x000003e1
-#define MSR_P4_DAC_ESCR0		0x000003a8
-#define MSR_P4_DAC_ESCR1		0x000003a9
-#define MSR_P4_FIRM_ESCR0		0x000003a4
-#define MSR_P4_FIRM_ESCR1		0x000003a5
-#define MSR_P4_FLAME_ESCR0		0x000003a6
-#define MSR_P4_FLAME_ESCR1		0x000003a7
-#define MSR_P4_FSB_ESCR0		0x000003a2
-#define MSR_P4_FSB_ESCR1		0x000003a3
-#define MSR_P4_IQ_ESCR0			0x000003ba
-#define MSR_P4_IQ_ESCR1			0x000003bb
-#define MSR_P4_IS_ESCR0			0x000003b4
-#define MSR_P4_IS_ESCR1			0x000003b5
-#define MSR_P4_ITLB_ESCR0		0x000003b6
-#define MSR_P4_ITLB_ESCR1		0x000003b7
-#define MSR_P4_IX_ESCR0			0x000003c8
-#define MSR_P4_IX_ESCR1			0x000003c9
-#define MSR_P4_MOB_ESCR0		0x000003aa
-#define MSR_P4_MOB_ESCR1		0x000003ab
-#define MSR_P4_MS_ESCR0			0x000003c0
-#define MSR_P4_MS_ESCR1			0x000003c1
-#define MSR_P4_PMH_ESCR0		0x000003ac
-#define MSR_P4_PMH_ESCR1		0x000003ad
-#define MSR_P4_RAT_ESCR0		0x000003bc
-#define MSR_P4_RAT_ESCR1		0x000003bd
-#define MSR_P4_SAAT_ESCR0		0x000003ae
-#define MSR_P4_SAAT_ESCR1		0x000003af
-#define MSR_P4_SSU_ESCR0		0x000003be
-#define MSR_P4_SSU_ESCR1		0x000003bf /* guess: not in manual */
-
-#define MSR_P4_TBPU_ESCR0		0x000003c2
-#define MSR_P4_TBPU_ESCR1		0x000003c3
-#define MSR_P4_TC_ESCR0			0x000003c4
-#define MSR_P4_TC_ESCR1			0x000003c5
-#define MSR_P4_U2L_ESCR0		0x000003b0
-#define MSR_P4_U2L_ESCR1		0x000003b1
-
-#define MSR_P4_PEBS_MATRIX_VERT		0x000003f2
-
-/* Intel Core-based CPU performance counters */
-#define MSR_CORE_PERF_FIXED_CTR0	0x00000309
-#define MSR_CORE_PERF_FIXED_CTR1	0x0000030a
-#define MSR_CORE_PERF_FIXED_CTR2	0x0000030b
-#define MSR_CORE_PERF_FIXED_CTR_CTRL	0x0000038d
-#define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
-#define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
-#define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
-
-/* Geode defined MSRs */
-#define MSR_GEODE_BUSCONT_CONF0		0x00001900
-
-/* Intel VT MSRs */
-#define MSR_IA32_VMX_BASIC              0x00000480
-#define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
-#define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
-#define MSR_IA32_VMX_EXIT_CTLS          0x00000483
-#define MSR_IA32_VMX_ENTRY_CTLS         0x00000484
-#define MSR_IA32_VMX_MISC               0x00000485
-#define MSR_IA32_VMX_CR0_FIXED0         0x00000486
-#define MSR_IA32_VMX_CR0_FIXED1         0x00000487
-#define MSR_IA32_VMX_CR4_FIXED0         0x00000488
-#define MSR_IA32_VMX_CR4_FIXED1         0x00000489
-#define MSR_IA32_VMX_VMCS_ENUM          0x0000048a
-#define MSR_IA32_VMX_PROCBASED_CTLS2    0x0000048b
-#define MSR_IA32_VMX_EPT_VPID_CAP       0x0000048c
-#define MSR_IA32_VMX_TRUE_PINBASED_CTLS  0x0000048d
-#define MSR_IA32_VMX_TRUE_PROCBASED_CTLS 0x0000048e
-#define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
-#define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
-#define MSR_IA32_VMX_VMFUNC             0x00000491
-
-/* VMX_BASIC bits and bitmasks */
-#define VMX_BASIC_VMCS_SIZE_SHIFT	32
-#define VMX_BASIC_TRUE_CTLS		(1ULL << 55)
-#define VMX_BASIC_64		0x0001000000000000LLU
-#define VMX_BASIC_MEM_TYPE_SHIFT	50
-#define VMX_BASIC_MEM_TYPE_MASK	0x003c000000000000LLU
-#define VMX_BASIC_MEM_TYPE_WB	6LLU
-#define VMX_BASIC_INOUT		0x0040000000000000LLU
-
 /* VMX_EPT_VPID_CAP bits */
-#define VMX_EPT_VPID_CAP_AD_BITS	(1ULL << 21)
-
-/* MSR_IA32_VMX_MISC bits */
-#define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
-#define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
-/* AMD-V MSRs */
-
-#define MSR_VM_CR                       0xc0010114
-#define MSR_VM_IGNNE                    0xc0010115
-#define MSR_VM_HSAVE_PA                 0xc0010117
+#define VMX_EPT_VPID_CAP_AD_BITS       (1ULL << 21)
 
 #endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.24.1

