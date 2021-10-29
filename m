Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4843FD18
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhJ2NIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:08:23 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:27498
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231929AbhJ2NHp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:07:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijtAbYxDPAq0/iKYKhsRAJeRtN9tMSOH84JAeMgHgyi2+H+4VXQ2CGTxYNGRkt2XCFargCo48R3h0jZl6HgQaD4IHpELaBkI9ZDnUfsOdUqbvvirC0fYnBDQlDcKyxMfVepg2IHup+36ggNScv3jgBqpBR3RDaiwEX/Dh9MQXbT8XlMZ+TclcG5ZrQiNxXNnGoRHWFJursyZkSKev9drMPC4foYwKMi+FbSfDm8k9mQm7cVs1pX7SbSD1S0odIiXeK3TuzWzofq+WhZ1seN0Le3zUzGAAYLYMs8a0oh/JtTCJCT5tHusdV8PnOlZunzZuULgCm9ZlznItSNTO9gwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIpMTBJ3EqyeHUirXhvoCCS4sE29iB035X8KM51Alj4=;
 b=SaZUpejTzcLw5tnyCvwIo0kJrgbKsg0vYcT1jenYdo9EfS5gyVLzjaGCTf1qvQkSAKRMsvYclzcxPezCSoz5oXODLR3qWk+/mxd5p58PULTc2Ck/E4CS+BXndRuB+vdmlWF0XFY9RVnF/arkWIb4Kbq6upMenqPka5PV8Qff7IOow7/ohXagXzbnMMoqPte2qPpEIE7NguRYtfvNjJ9Z5RxYo1eGV+ogjLuHhNm7uQSKSgQre1mkX2Qh/Y6q21QLVHWy5DqMxuCfyyfUD52sKOYkONJntmNgudZC49ddEjTeZyrij8IUF6ky5TBd+fdsUy2fjD3hgQX23PhcW/Tt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIpMTBJ3EqyeHUirXhvoCCS4sE29iB035X8KM51Alj4=;
 b=3b4Xs+x1NmBxXWU/VVhYljs0JakldNq0I1KzaT6xASKUqy3OYu0zBwq7yuOSReRSjB3Q8lxWVZmFBLKVxE8mNNlyggCDpeP11PjwwoOV/L9TOLoHjLRBL4n9hECI+82ofErstDTN8CpyIuKc+86Q3Impg8szFn7eD2wM+cJMoG4=
Received: from BN9PR03CA0371.namprd03.prod.outlook.com (2603:10b6:408:f7::16)
 by BN7PR12MB2724.namprd12.prod.outlook.com (2603:10b6:408:31::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 13:05:12 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::ee) by BN9PR03CA0371.outlook.office365.com
 (2603:10b6:408:f7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Fri, 29 Oct 2021 13:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:05:11 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:04:55 -0500
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
Subject: [PATCH v3 21/21] Documentation: amd-pstate: add amd-pstate driver introduction
Date:   Fri, 29 Oct 2021 21:02:41 +0800
Message-ID: <20211029130241.1984459-22-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029130241.1984459-1-ray.huang@amd.com>
References: <20211029130241.1984459-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2e3f79-11df-4d38-3420-08d99adcbd71
X-MS-TrafficTypeDiagnostic: BN7PR12MB2724:
X-Microsoft-Antispam-PRVS: <BN7PR12MB27242717533678912945F9B7EC879@BN7PR12MB2724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nk77tOrXBqf15EboNwYmAJp7HD49lDG57brjIdJgc4rWTNGoL9E0mhpQ4QJQGKldxTG6ChhNuf2lhSfH1JSvCoEA2UtVmpUoWYsMhw1qMg9bolWi2Ot5s0tJojATjFslVGsYZkb7OaN03JCenhct5Qd11TE5jmjfyWDBd4tKDI1mB2UNkQRxFND7zyjGLh4q4mf+4NrmGPuKbyD2naqnx95hiCi9X/kWZSB6htF9eK/cUyBSKYAygU7OwJOP0Bczc1C8dpYINd+k9dqCDO4XQ748hNFKVOs+ToE4JwYiQNOjm0dJoXAhoxV+XmBy1iMamE2tLRO9jVcc6Q96gyz80R+XrgErn4qL0/ynDr5BYjEJOkHffSt6/QHoctL8KxS/ItU64iYca3mS7TQAvT9YfA5bejE2aij/xCHlbZfDshuSyA0CApiDd/XFP4DJdrlpvw3cIfbuA6UYhOeCxM1hH8xh7dAAlUX3hBQwcvQDY8fyiSl5QuCFa2Mxinlvp04Wjd75X1gkxNOBqbd6QK2w/TkUxd5YdC/vftCZ8HuVi7AK6jxzM713PHGEHwFFdhySNmwnYubPJ+QPSs1mQXpGNQU21ITriKQYWtJtldTLFtHYj+YVNflQRZyGOggL+DKzKJl4ZIGDWwQHuWqytLJS1cbBfdiHPurlVjzEhI3uH/GQRdRxNYU+FpGnd/kfeHiv6Xaa2LKIdQPr3vq/8e7kG5tjpEx0Huk0cQ+DqCla2dcsqglK6eM7lF+kEXTfHRQKhtApjOUUSrvUYYYamONu0CkzOV0bL3K65wucJEzGefa9/kUjdCJtzU/9jTg1Uqt8n/woqjWdq3nuvPp1zj5taJrqGaSIdj1RaqtaT2sMaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(316002)(7696005)(5660300002)(16526019)(356005)(6666004)(426003)(54906003)(26005)(110136005)(82310400003)(36860700001)(508600001)(47076005)(81166007)(70206006)(1076003)(36756003)(86362001)(2906002)(336012)(70586007)(8936002)(4326008)(83380400001)(2616005)(30864003)(966005)(7416002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:05:11.0761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2e3f79-11df-4d38-3420-08d99adcbd71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
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
index 000000000000..375374e3eb80
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
+<perf_cap_>`_. It can use :c:macro:`X86_FEATURE_AMD_CPPC` feature flag (for
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
+while the :c:macro:`X86_FEATURE_AMD_CPPC` CPU feature flag is set.
+``amd-pstate`` can handle the MSR register to implement the fast switch
+function in ``CPUFreq`` that can shrink latency of frequency control on the
+interrupt context.
+
+Shared Memory Support
+----------------------
+
+If :c:macro:`X86_FEATURE_AMD_CPPC` CPU feature flag is not set, that means
+the processor supports shared memory solution. In this case, ``amd-pstate``
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

