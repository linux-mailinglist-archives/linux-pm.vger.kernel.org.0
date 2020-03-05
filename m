Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D9017A1F8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCEJHJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 04:07:09 -0500
Received: from foss.arm.com ([217.140.110.172]:45182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEJHJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Mar 2020 04:07:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D231045;
        Thu,  5 Mar 2020 01:07:08 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3DED3F534;
        Thu,  5 Mar 2020 01:07:05 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        pkondeti@codeaurora.org, ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 4/7] Documentation: arm64: document support for the AMU extension
Date:   Thu,  5 Mar 2020 09:06:24 +0000
Message-Id: <20200305090627.31908-5-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305090627.31908-1-ionela.voinescu@arm.com>
References: <20200305090627.31908-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The activity monitors extension is an optional extension introduced
by the ARMv8.4 CPU architecture.

Add initial documentation for the AMUv1 extension:
 - arm64/amu.txt: AMUv1 documentation
 - arm64/booting.txt: system registers initialisation

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/arm64/amu.rst     | 112 ++++++++++++++++++++++++++++++++
 Documentation/arm64/booting.rst |  14 ++++
 Documentation/arm64/index.rst   |   1 +
 3 files changed, 127 insertions(+)
 create mode 100644 Documentation/arm64/amu.rst

diff --git a/Documentation/arm64/amu.rst b/Documentation/arm64/amu.rst
new file mode 100644
index 000000000000..5057b11100ed
--- /dev/null
+++ b/Documentation/arm64/amu.rst
@@ -0,0 +1,112 @@
+=======================================================
+Activity Monitors Unit (AMU) extension in AArch64 Linux
+=======================================================
+
+Author: Ionela Voinescu <ionela.voinescu@arm.com>
+
+Date: 2019-09-10
+
+This document briefly describes the provision of Activity Monitors Unit
+support in AArch64 Linux.
+
+
+Architecture overview
+---------------------
+
+The activity monitors extension is an optional extension introduced by the
+ARMv8.4 CPU architecture.
+
+The activity monitors unit, implemented in each CPU, provides performance
+counters intended for system management use. The AMU extension provides a
+system register interface to the counter registers and also supports an
+optional external memory-mapped interface.
+
+Version 1 of the Activity Monitors architecture implements a counter group
+of four fixed and architecturally defined 64-bit event counters.
+  - CPU cycle counter: increments at the frequency of the CPU.
+  - Constant counter: increments at the fixed frequency of the system
+    clock.
+  - Instructions retired: increments with every architecturally executed
+    instruction.
+  - Memory stall cycles: counts instruction dispatch stall cycles caused by
+    misses in the last level cache within the clock domain.
+
+When in WFI or WFE these counters do not increment.
+
+The Activity Monitors architecture provides space for up to 16 architected
+event counters. Future versions of the architecture may use this space to
+implement additional architected event counters.
+
+Additionally, version 1 implements a counter group of up to 16 auxiliary
+64-bit event counters.
+
+On cold reset all counters reset to 0.
+
+
+Basic support
+-------------
+
+The kernel can safely run a mix of CPUs with and without support for the
+activity monitors extension. Therefore, when CONFIG_ARM64_AMU_EXTN is
+selected we unconditionally enable the capability to allow any late CPU
+(secondary or hotplugged) to detect and use the feature.
+
+When the feature is detected on a CPU, we flag the availability of the
+feature but this does not guarantee the correct functionality of the
+counters, only the presence of the extension.
+
+Firmware (code running at higher exception levels, e.g. arm-tf) support is
+needed to:
+ - Enable access for lower exception levels (EL2 and EL1) to the AMU
+   registers.
+ - Enable the counters. If not enabled these will read as 0.
+ - Save/restore the counters before/after the CPU is being put/brought up
+   from the 'off' power state.
+
+When using kernels that have this feature enabled but boot with broken
+firmware the user may experience panics or lockups when accessing the
+counter registers. Even if these symptoms are not observed, the values
+returned by the register reads might not correctly reflect reality. Most
+commonly, the counters will read as 0, indicating that they are not
+enabled.
+
+If proper support is not provided in firmware it's best to disable
+CONFIG_ARM64_AMU_EXTN. To be noted that for security reasons, this does not
+bypass the setting of AMUSERENR_EL0 to trap accesses from EL0 (userspace) to
+EL1 (kernel). Therefore, firmware should still ensure accesses to AMU registers
+are not trapped in EL2/EL3.
+
+The fixed counters of AMUv1 are accessible though the following system
+register definitions:
+ - SYS_AMEVCNTR0_CORE_EL0
+ - SYS_AMEVCNTR0_CONST_EL0
+ - SYS_AMEVCNTR0_INST_RET_EL0
+ - SYS_AMEVCNTR0_MEM_STALL_EL0
+
+Auxiliary platform specific counters can be accessed using
+SYS_AMEVCNTR1_EL0(n), where n is a value between 0 and 15.
+
+Details can be found in: arch/arm64/include/asm/sysreg.h.
+
+
+Userspace access
+----------------
+
+Currently, access from userspace to the AMU registers is disabled due to:
+ - Security reasons: they might expose information about code executed in
+   secure mode.
+ - Purpose: AMU counters are intended for system management use.
+
+Also, the presence of the feature is not visible to userspace.
+
+
+Virtualization
+--------------
+
+Currently, access from userspace (EL0) and kernelspace (EL1) on the KVM
+guest side is disabled due to:
+ - Security reasons: they might expose information about code executed
+   by other guests or the host.
+
+Any attempt to access the AMU registers will result in an UNDEFINED
+exception being injected into the guest.
diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 5d78a6f5b0ae..a3f1a47b6f1c 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -248,6 +248,20 @@ Before jumping into the kernel, the following conditions must be met:
     - HCR_EL2.APK (bit 40) must be initialised to 0b1
     - HCR_EL2.API (bit 41) must be initialised to 0b1
 
+  For CPUs with Activity Monitors Unit v1 (AMUv1) extension present:
+  - If EL3 is present:
+    CPTR_EL3.TAM (bit 30) must be initialised to 0b0
+    CPTR_EL2.TAM (bit 30) must be initialised to 0b0
+    AMCNTENSET0_EL0 must be initialised to 0b1111
+    AMCNTENSET1_EL0 must be initialised to a platform specific value
+    having 0b1 set for the corresponding bit for each of the auxiliary
+    counters present.
+  - If the kernel is entered at EL1:
+    AMCNTENSET0_EL0 must be initialised to 0b1111
+    AMCNTENSET1_EL0 must be initialised to a platform specific value
+    having 0b1 set for the corresponding bit for each of the auxiliary
+    counters present.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.
diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 5c0c69dc58aa..09cbb4ed2237 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -6,6 +6,7 @@ ARM64 Architecture
     :maxdepth: 1
 
     acpi_object_usage
+    amu
     arm-acpi
     booting
     cpu-feature-registers
-- 
2.17.1

