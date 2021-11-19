Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE0456D9B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhKSKgi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:36:38 -0500
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:57697
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234866AbhKSKgY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:36:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4291vRbeBpYueysQQovbcYY3dnUndmEwq/O5Xc2outkIHCleVfAZYBwJ3SWPVoOBcEaqB/BWGZRGTWDjz5vzsjWAksVVPWkKmJiNqBhfnIa9cflmRcUGi37/bkwMeuPq9s2OMYYmpxyqN6jIm644H1tmMLuiD1ce6g47RWDsohQil6Ew//mjR3eDMKDpDejqk4rvIWGJ8Sif71DUzk3pjb+/eg4sXFMrcwasCqEcS9tnxUg6VvEA9p+NSTtXMP1fSEbG7ykPaJnGZHVCv0QU+pLSJXzoFizcQC3YGtAFLDOoo7NJGpQ3Dhk++OtLr7dQYOHdkPadyMFVmCBJ5ZGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWDsUldiU+tNEJxwm74gpp0kZR7H+FDAFZG6PRDCs6M=;
 b=ANzNfCB/VFdE7CYxmzSDC1XgYU+Ry4wcmPGOBWR8UiQMbQatVyJN+eLJ6/H1lqfk43Mg7FC3dsJ276HyYrLbsdps/B6ECYlY4a0FZm7FaQCVnT7Vpcl2taPEevB97jQ4QG7/R8uu88DuOmaSdV/L2LfD7e1qnnrByCxfQ9PTzJQa6tZrfnmPGFqix4kBFqRYaMFAfMZyACaZJXTa7eIPgt9cJ5rMHJFfpKb3pXxK1RyaJ0ypTbJMHFmX9bqX0A5/J7xtHKCcQixAy9AgXF3jMHaUuOTnkjdIUTczf+vCHp+B8vNqlgmPmBijXSrdal4BhXmonyF8Q/ms2jF8gw2Vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWDsUldiU+tNEJxwm74gpp0kZR7H+FDAFZG6PRDCs6M=;
 b=xy5c4nxQ0O7HGScOuY8Kw0vK+wtF1+riI6YlawqMRj9lhhoVc9SCD78olK7ln1V8qlcgOF+OmBlR/s012GLXEi9zQ6ves5Xp1vP/J3n6ijfNjT91oq7qARwmCDzkgyg+THCoKFzgeLBHkjW7HAl406uBkUL+bDzbreW8rSYQ3rk=
Received: from DS7PR03CA0270.namprd03.prod.outlook.com (2603:10b6:5:3b3::35)
 by MN2PR12MB3840.namprd12.prod.outlook.com (2603:10b6:208:16f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 10:33:20 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::21) by DS7PR03CA0270.outlook.office365.com
 (2603:10b6:5:3b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:33:20 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:33:15 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v4 22/22] Documentation: amd-pstate: add amd-pstate driver introduction
Date:   Fri, 19 Nov 2021 18:31:02 +0800
Message-ID: <20211119103102.88124-23-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119103102.88124-1-ray.huang@amd.com>
References: <20211119103102.88124-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da77043b-d132-47bb-c1d5-08d9ab4801ca
X-MS-TrafficTypeDiagnostic: MN2PR12MB3840:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3840BBF66EFADBDB86638D78EC9C9@MN2PR12MB3840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGksGLolgSdBoy80S4DnVnN5vnsat6MAfS0ZVGNTtOIJoV/+cQcCyBSiBoeVCSq5TPk5g8vhF3Lg4E4crkgos33pMOxZXkDi0lSMo2sMbQjGSC2zk84QZqBAmDZjQ1CEEhmoUe/GNZa6YZ8q/q8Zii7dyJ0Locc4RF5EozoeQrO5kkmKUU+xtwDUjJhcVGTo2YtDbHLpU8EDeicSLqvnxpPDAt91ojFQjQ3qBkrc8s1zFpH7qyfXdu04w7mUfbj+CWPu59NwJ1wo5Uu5ecNmq4vwYs9QMojJT4/aNAuXX0+F2UlFuJUafJ3FGXF6kqWHYMPvFDWPoJhI39EXDrf4MT3rLvz+FyWKjmX2dvChHPRX5o6dBT2KVgGaKb/u4B/S2pge7GxaZE3CXoVoqxNGMntwHn6aSkRlUnvZlTtCkNSKuiL1aq6X6SCcL9I/s9qai1u0rXF3W7Bh9MzTWFroyKTFTLrNSpy4pC8J0yoVvDZ46K96Dn9xG99N0tEcQsJWXPuRZKLy0M9hoHsQA+a1sxbB/QUpPrGQQmHLHxqNd6s3zlB9uuaigx+YJnqE3j7i9ZGBFkmjhKm5etSpDEZ/Igeg2jQclBTfLa7r35LVZMTZCuM61QCCR0PeEXwoVhL7BTEJ8cmBNyW7a1k0kQinKgcLcKU3yG/pIqACNO/Y7w8wpsCpZpD9Jv3+7Bwqyj7EIYCu+dRZ8hKpr7CqMwBshGT7GIGNcEFU8fXfNZydqtuAyy5GBx3PsVfF2yCvjcFh0cQR+oSnNcnnt5LZ7RxFR8t580YJ5VsRKEcLEaEgcYOL+WEteNyZ+oO3KJYfSYKoXCKA/JvCZPVTWeo8dw5k8g8sSC7IE07of3Ak8FkLtlk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(6666004)(2906002)(86362001)(356005)(81166007)(70586007)(70206006)(8936002)(8676002)(36860700001)(47076005)(186003)(508600001)(16526019)(7696005)(966005)(316002)(83380400001)(2616005)(5660300002)(336012)(30864003)(82310400003)(7416002)(54906003)(426003)(4326008)(26005)(36756003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:33:20.4836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da77043b-d132-47bb-c1d5-08d9ab4801ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the amd-pstate driver design and implementation.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst   | 373 ++++++++++++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 2 files changed, 374 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/amd-pstate.rst

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
new file mode 100644
index 000000000000..24a88476fc69
--- /dev/null
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -0,0 +1,373 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===============================================
+``amd-pstate`` CPU Performance Scaling Driver
+===============================================
+
+:Copyright: |copy| 2021 Advanced Micro Devices, Inc.
+
+:Author: Huang Rui <ray.huang@amd.com>
+
+
+Introduction
+===================
+
+``amd-pstate`` is the AMD CPU performance scaling driver that introduces a
+new CPU frequency control mechanism on modern AMD APU and CPU series in
+Linux kernel. The new mechanism is based on Collaborative Processor
+Performance Control (CPPC) which provides finer grain frequency management
+than legacy ACPI hardware P-States. Current AMD CPU/APU platforms are using
+the ACPI P-states driver to manage CPU frequency and clocks with switching
+only in 3 P-states. CPPC replaces the ACPI P-states controls, allows a
+flexible, low-latency interface for the Linux kernel to directly
+communicate the performance hints to hardware.
+
+``amd-pstate`` leverages the Linux kernel governors such as ``schedutil``,
+``ondemand``, etc. to manage the performance hints which are provided by
+CPPC hardware functionality that internally follows the hardware
+specification (for details refer to AMD64 Architecture Programmer's Manual
+Volume 2: System Programming [1]_). Currently ``amd-pstate`` supports basic
+frequency control function according to kernel governors on some of the
+Zen2 and Zen3 processors, and we will implement more AMD specific functions
+in future after we verify them on the hardware and SBIOS.
+
+
+AMD CPPC Overview
+=======================
+
+Collaborative Processor Performance Control (CPPC) interface enumerates a
+continuous, abstract, and unit-less performance value in a scale that is
+not tied to a specific performance state / frequency. This is an ACPI
+standard [2]_ which software can specify application performance goals and
+hints as a relative target to the infrastructure limits. AMD processors
+provides the low latency register model (MSR) instead of AML code
+interpreter for performance adjustments. ``amd-pstate`` will initialize a
+``struct cpufreq_driver`` instance ``amd_pstate_driver`` with the callbacks
+to manage each performance update behavior. ::
+
+ Highest Perf ------>+-----------------------+                         +-----------------------+
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |          Max Perf  ---->|                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+ Nominal Perf ------>+-----------------------+                         +-----------------------+
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |      Desired Perf  ---->|                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+  Lowest non-        |                       |                         |                       |
+  linear perf ------>+-----------------------+                         +-----------------------+
+                     |                       |                         |                       |
+                     |                       |       Lowest perf  ---->|                       |
+                     |                       |                         |                       |
+  Lowest perf ------>+-----------------------+                         +-----------------------+
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+                     |                       |                         |                       |
+          0   ------>+-----------------------+                         +-----------------------+
+
+                                     AMD P-States Performance Scale
+
+
+.. _perf_cap:
+
+AMD CPPC Performance Capability
+--------------------------------
+
+Highest Performance (RO)
+.........................
+
+It is the absolute maximum performance an individual processor may reach,
+assuming ideal conditions. This performance level may not be sustainable
+for long durations and may only be achievable if other platform components
+are in a specific state; for example, it may require other processors be in
+an idle state. This would be equivalent to the highest frequencies
+supported by the processor.
+
+Nominal (Guaranteed) Performance (RO)
+......................................
+
+It is the maximum sustained performance level of the processor, assuming
+ideal operating conditions. In absence of an external constraint (power,
+thermal, etc.) this is the performance level the processor is expected to
+be able to maintain continuously. All cores/processors are expected to be
+able to sustain their nominal performance state simultaneously.
+
+Lowest non-linear Performance (RO)
+...................................
+
+It is the lowest performance level at which nonlinear power savings are
+achieved, for example, due to the combined effects of voltage and frequency
+scaling. Above this threshold, lower performance levels should be generally
+more energy efficient than higher performance levels. This register
+effectively conveys the most efficient performance level to ``amd-pstate``.
+
+Lowest Performance (RO)
+........................
+
+It is the absolute lowest performance level of the processor. Selecting a
+performance level lower than the lowest nonlinear performance level may
+cause an efficiency penalty but should reduce the instantaneous power
+consumption of the processor.
+
+AMD CPPC Performance Control
+------------------------------
+
+``amd-pstate`` passes performance goals through these registers. The
+register drives the behavior of the desired performance target.
+
+Minimum requested performance (RW)
+...................................
+
+``amd-pstate`` specifies the minimum allowed performance level.
+
+Maximum requested performance (RW)
+...................................
+
+``amd-pstate`` specifies a limit the maximum performance that is expected
+to be supplied by the hardware.
+
+Desired performance target (RW)
+...................................
+
+``amd-pstate`` specifies a desired target in the CPPC performance scale as
+a relative number. This can be expressed as percentage of nominal
+performance (infrastructure max). Below the nominal sustained performance
+level, desired performance expresses the average performance level of the
+processor subject to hardware. Above the nominal performance level,
+processor must provide at least nominal performance requested and go higher
+if current operating conditions allow.
+
+Energy Performance Preference (EPP) (RW)
+.........................................
+
+Provides a hint to the hardware if software wants to bias toward performance
+(0x0) or energy efficiency (0xff).
+
+
+Key Governors Support
+=======================
+
+``amd-pstate`` can be used with all the (generic) scaling governors listed
+by the ``scaling_available_governors`` policy attribute in ``sysfs``. Then,
+it is responsible for the configuration of policy objects corresponding to
+CPUs and provides the ``CPUFreq`` core (and the scaling governors attached
+to the policy objects) with accurate information on the maximum and minimum
+operating frequencies supported by the hardware. Users can check the
+``scaling_cur_freq`` information comes from the ``CPUFreq`` core.
+
+``amd-pstate`` mainly supports ``schedutil`` and ``ondemand`` for dynamic
+frequency control. It is to fine tune the processor configuration on
+``amd-pstate`` to the ``schedutil`` with CPU CFS scheduler. ``amd-pstate``
+registers adjust_perf callback to implement the CPPC similar performance
+update behavior. It is initialized by ``sugov_start`` and then populate the
+CPU's update_util_data pointer to assign ``sugov_update_single_perf`` as
+the utilization update callback function in CPU scheduler. CPU scheduler
+will call ``cpufreq_update_util`` and assign the target performance
+according to the ``struct sugov_cpu`` that utilization update belongs to.
+Then ``amd-pstate`` updates the desired performance according to the CPU
+scheduler assigned.
+
+
+Processor Support
+=======================
+
+The ``amd-pstate`` initialization will fail if the _CPC in ACPI SBIOS is
+not existed at the detected processor, and it uses ``acpi_cpc_valid`` to
+check the _CPC existence. All Zen based processors support legacy ACPI
+hardware P-States function, so while the ``amd-pstate`` fails to be
+initialized, the kernel will fall back to initialize ``acpi-cpufreq``
+driver.
+
+There are two types of hardware implementations for ``amd-pstate``: one is
+`Full MSR Support <perf_cap_>`_ and another is `Shared Memory Support
+<perf_cap_>`_. It can use :c:macro:`X86_FEATURE_CPPC` feature flag (for
+details refer to Processor Programming Reference (PPR) for AMD Family
+19h Model 21h, Revision B0 Processors [3]_) to indicate the different
+types. ``amd-pstate`` is to register different ``amd_pstate_perf_funcs``
+instances for different hardware implementations.
+
+Currently, some of Zen2 and Zen3 processors support ``amd-pstate``. In the
+future, it will be supported on more and more AMD processors.
+
+Full MSR Support
+-----------------
+
+Some new Zen3 processors such as Cezanne provide the MSR registers directly
+while the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is set.
+``amd-pstate`` can handle the MSR register to implement the fast switch
+function in ``CPUFreq`` that can shrink latency of frequency control on the
+interrupt context.
+
+Shared Memory Support
+----------------------
+
+If :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, that means the
+processor supports shared memory solution. In this case, ``amd-pstate``
+uses the ``cppc_acpi`` helper methods to implement the callback functions
+of ``amd_pstate_perf_funcs``.
+
+
+AMD P-States and ACPI hardware P-States always can be supported in one
+processor. But AMD P-States has the higher priority and if it is enabled
+with :c:macro:`MSR_AMD_CPPC_ENABLE` or ``cppc_set_enable``, it will respond
+to the request from AMD P-States.
+
+
+User Space Interface in ``sysfs``
+==================================
+
+``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
+control its functionality at the system level. They located in the
+``/sys/devices/system/cpu/cpufreq/policyX/`` directory and affect all CPUs. ::
+
+ root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_perf
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_min_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_nominal_freq
+ /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_nominal_perf
+
+
+``amd_pstate_highest_perf / amd_pstate_max_freq``
+
+Maximum CPPC performance and CPU frequency that the driver is allowed to
+set in percent of the maximum supported CPPC performance level (the highest
+performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
+This attribute is read-only.
+
+``amd_pstate_nominal_perf / amd_pstate_nominal_freq``
+
+Nominal CPPC performance and CPU frequency that the driver is allowed to
+set in percent of the maximum supported CPPC performance level (Please see
+nominal performance in `AMD CPPC Performance Capability <perf_cap_>`_).
+This attribute is read-only.
+
+``amd_pstate_lowest_nonlinear_perf / amd_pstate_lowest_nonlinear_freq``
+
+The lowest non-linear CPPC performance and CPU frequency that the driver is
+allowed to set in percent of the maximum supported CPPC performance level
+(Please see the lowest non-linear performance in `AMD CPPC Performance
+Capability <perf_cap_>`_).
+This attribute is read-only.
+
+``amd_pstate_lowest_perf``
+
+The lowest physical CPPC performance. The minimum CPU frequency can be read
+back from ``cpuinfo`` member of ``cpufreq_policy``, so we won't expose it
+here.
+This attribute is read-only.
+
+
+``amd-pstate`` vs ``acpi-cpufreq``
+======================================
+
+On majority of AMD platforms supported by ``acpi-cpufreq``, the ACPI tables
+provided by the platform firmware used for CPU performance scaling, but
+only provides 3 P-states on AMD processors.
+However, on modern AMD APU and CPU series, it provides the collaborative
+processor performance control according to ACPI protocol and customize this
+for AMD platforms. That is fine-grain and continuous frequency range
+instead of the legacy hardware P-states. ``amd-pstate`` is the kernel
+module which supports the new AMD P-States mechanism on most of future AMD
+platforms. The AMD P-States mechanism will be the more performance and energy
+efficiency frequency management method on AMD processors.
+
+``cpupower`` tool support for ``amd-pstate``
+===============================================
+
+``amd-pstate`` is supported on ``cpupower`` tool that can be used to dump the frequency
+information. And it is in progress to support more and more operations for new
+``amd-pstate`` module with this tool. ::
+
+ root@hr-test1:/home/ray# cpupower frequency-info
+ analyzing CPU 0:
+   driver: amd-pstate
+   CPUs which run at the same hardware frequency: 0
+   CPUs which need to have their frequency coordinated by software: 0
+   maximum transition latency: 131 us
+   hardware limits: 400 MHz - 4.68 GHz
+   available cpufreq governors: ondemand conservative powersave userspace performance schedutil
+   current policy: frequency should be within 400 MHz and 4.68 GHz.
+                   The governor "schedutil" may decide which speed to use
+                   within this range.
+   current CPU frequency: Unable to call hardware
+   current CPU frequency: 4.02 GHz (asserted by call to kernel)
+   boost state support:
+     Supported: yes
+     Active: yes
+     AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.68 GHz.
+     AMD PSTATE Nominal Performance: 117. Nominal Frequency: 3.30 GHz.
+     AMD PSTATE Lowest Non-linear Performance: 39. Lowest Non-linear Frequency: 1.10 GHz.
+     AMD PSTATE Lowest Performance: 15. Lowest Frequency: 400 MHz.
+
+
+Diagnostics and Tuning
+=======================
+
+Trace Events
+--------------
+
+There are two static trace events that can be used for ``amd-pstate``
+diagnostics.  One of them is the cpu_frequency trace event generally used
+by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
+specific to ``amd-pstate``.  The following sequence of shell commands can
+be used to enable them and see their output (if the kernel is generally
+configured to support event tracing). ::
+
+ root@hr-test1:/home/ray# cd /sys/kernel/tracing/
+ root@hr-test1:/sys/kernel/tracing# echo 1 > events/amd_cpu/enable
+ root@hr-test1:/sys/kernel/tracing# cat trace
+ # tracer: nop
+ #
+ # entries-in-buffer/entries-written: 47827/42233061   #P:2
+ #
+ #                                _-----=> irqs-off
+ #                               / _----=> need-resched
+ #                              | / _---=> hardirq/softirq
+ #                              || / _--=> preempt-depth
+ #                              ||| /     delay
+ #           TASK-PID     CPU#  ||||   TIMESTAMP  FUNCTION
+ #              | |         |   ||||      |         |
+          <idle>-0       [015] dN...  4995.979886: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=15 changed=false fast_switch=true
+          <idle>-0       [007] d.h..  4995.979893: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=7 changed=false fast_switch=true
+             cat-2161    [000] d....  4995.980841: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=0 changed=false fast_switch=true
+            sshd-2125    [004] d.s..  4995.980968: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=4 changed=false fast_switch=true
+          <idle>-0       [007] d.s..  4995.980968: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=7 changed=false fast_switch=true
+          <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=3 changed=false fast_switch=true
+          <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=11 changed=false fast_switch=true
+
+The cpu_frequency trace event will be triggered either by the ``schedutil`` scaling
+governor (for the policies it is attached to), or by the ``CPUFreq`` core (for the
+policies with other scaling governors).
+
+
+Reference
+===========
+
+.. [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
+       https://www.amd.com/system/files/TechDocs/24593.pdf
+
+.. [2] Advanced Configuration and Power Interface Specification,
+       https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
+
+.. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 21h, Revision B0 Processors
+       https://www.amd.com/system/files/TechDocs/55898_B1_pub_0.50.zip
+
diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentation/admin-guide/pm/working-state.rst
index f40994c422dc..5d2757e2de65 100644
--- a/Documentation/admin-guide/pm/working-state.rst
+++ b/Documentation/admin-guide/pm/working-state.rst
@@ -11,6 +11,7 @@ Working-State Power Management
    intel_idle
    cpufreq
    intel_pstate
+   amd-pstate
    cpufreq_drivers
    intel_epb
    intel-speed-select
-- 
2.25.1

