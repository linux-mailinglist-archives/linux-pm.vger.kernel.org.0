Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18294187D2
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhIZJJi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:09:38 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:30433
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229727AbhIZJJZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:09:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhGke3Ae98fLdwP4OFgBaCWCsStMfpW6l0tOjvsLZjwvEYET4sqLh3HwgkOgU9QlpIjXnty4uvNejoVY68Kfww3uwCDKT86qxKAOUK71LDZpUvQVKoKAb7q7uhwfSrJnojX7YsREfwR0PQIP3zbL8ZM5kKwuWgxDCsFbHKNkGtEQDJCR/0smKLa44WwpXx56KBMQPsarkrdG5QcNzhV3v9frBXr+aF7GqJU6lkd3rnQOJ+CpNdyXSyyX5qBkB0hOhDJ07pBDcrfeVbbk3snZAv4qvdD08hVJ8AqXrBW9byW7+6wCL95esMnVaFz2i71eqUUCvTgAS+z9M5xV7hMkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1qbxvKk+Logi/YXTSn5znvJWC5lMdIkRYvIiqQPPLAg=;
 b=N0i+Q5GLYws+ilDGAKgkJz0Zba99H3KmQNx1z1w6RZgZ8kT+VO3jUy/vtVOvuevjHOXqevCJNn9YbVU87+3/IOI9hFxRl+lsumSdEOkfr+EKvjx1cRSkdHyIodhsBBLTZqBif7HGdrF3RjcODHzdYeFMEhPqxBow4mqz3dtxINOzViHCPaAVt9m/CuNjE5WbPqr+zOVzGJohrWYDwTKaRBy4BiTTxnytm2uA3xx1f9KiRkdKP4KL35bOmzVZk8ms7GiTn3oaN6Y4WKPJQWqc+a1tblmXDwb/tHxnjOul2ohTeSavtVRyKdxZSvonc+S0R1Pfay2aOSZg3CdYgBvPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qbxvKk+Logi/YXTSn5znvJWC5lMdIkRYvIiqQPPLAg=;
 b=FjgIhOv5B9hu0qXMrc5ZNfFWZM0UxLXdIBebJ+GgEvH3WIelqc6gDPVuvaYKRTzBFjNvUmbEbPa0JCUloxrpG6PnQedKJJmRlpfv3aiFd5WOivjy9KHhEqKdkhXkRVrGNyy9qUlC/tYosTwCwQPu+/YWGSRUzKGg+MrjkQ3J2Ik=
Received: from MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) by
 CY4PR12MB1575.namprd12.prod.outlook.com (2603:10b6:910:f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Sun, 26 Sep 2021 09:07:46 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::d9) by MW2PR16CA0010.outlook.office365.com
 (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:07:46 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:07:40 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v2 21/21] Documentation: amd-pstate: add amd-pstate driver introduction
Date:   Sun, 26 Sep 2021 17:06:05 +0800
Message-ID: <20210926090605.3556134-22-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926090605.3556134-1-ray.huang@amd.com>
References: <20210926090605.3556134-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51825cb0-0fc1-458f-6499-08d980cd1b21
X-MS-TrafficTypeDiagnostic: CY4PR12MB1575:
X-Microsoft-Antispam-PRVS: <CY4PR12MB157532DB871754D68F05ACD4ECA69@CY4PR12MB1575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtcGn1I+agkUJUUwMAVqurUsT3uBJqj5x41/+quHwQtO7p3F+Z54v+IgeqUAjZ+evzCquKTl3NYZat5yJMuZ4xqSM/ew3XizGqF/BZPg5enKnq8fuJg7Z5GCnThJDWVPcBjALUTNHrrYNZ9YRiFWiHmddCOU3x5V5Mz9QYit+Qq73Usw3Ze8zjepmvGUlg5cTxQkV7R73Q7uIHRBuVOLhBmUfSSJAqSlM8wsdtFwbJHuVLwmyloGhse9ofsStVDW+jlA2Q1e2YiHswNs+iRc+vfwCb2agjLXCGiqsQDZRVtAVKx7Aw8H5oWxDghM/pskk96i/BmPIVaXxQM9lGVYPqt4GpPzXyDJSMghgH3KbhVflofolScOKHrCCbHIyCCl2MpX2LMCYbtTtdKAiTzzTSr3T4AK5C+6EdkEfg/41xQVhSd8Ro08x2f5dN/tNtXpaAAvwEhkDhDWEUh+m6dHe3FoSr6SDcsDZbd4eJsahUUBudn82rIDZhJvqExYNjOOZ94ZmmJCAh91jFI5RiK4vGO49xoNXwK/N6lmR/7P+7+tL73wIDmkPi0ktzo6/AlrYBpI0kiWtcoG9Kqa2q08JaU811p6yv9RR/TDmXIkQYkJiS7l/qPVkk03+f2cMlpbWw/XCI+7ZpFuK9H3hcnzhtz6GNaJEwdXFie/4dGtfiOFYRrrwD4bSH93hldrcX4ETvsZwcoctz2UM/hmNZHJ42R2GuUTaB29XLC+larECaHWpJb6lfju3DB07HVFPGp38gezrG5V7I8mUNhFLjQW2/QANcFlh50J9J/IseazHkIG2SrQvzbIgfOqez0BSaH3nTAFg9pWY363YDpEp9Anv4JAKvc3FTCkIfD29zlIDlo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(356005)(36860700001)(316002)(4326008)(54906003)(110136005)(2906002)(86362001)(47076005)(8676002)(1076003)(70586007)(82310400003)(16526019)(186003)(70206006)(26005)(2616005)(336012)(426003)(6666004)(81166007)(966005)(83380400001)(8936002)(7696005)(36756003)(5660300002)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:07:46.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51825cb0-0fc1-458f-6499-08d980cd1b21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1575
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the amd-pstate driver design and implementation.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 Documentation/admin-guide/pm/amd_pstate.rst   | 377 ++++++++++++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 2 files changed, 378 insertions(+)
 create mode 100644 Documentation/admin-guide/pm/amd_pstate.rst

diff --git a/Documentation/admin-guide/pm/amd_pstate.rst b/Documentation/admin-guide/pm/amd_pstate.rst
new file mode 100644
index 000000000000..c3659dde0cee
--- /dev/null
+++ b/Documentation/admin-guide/pm/amd_pstate.rst
@@ -0,0 +1,377 @@
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
+<perf_cap_>`_. It can use :c:macro:`X86_FEATURE_AMD_CPPC_EXT` feature flag
+(for details refer to Processor Programming Reference (PPR) for AMD Family
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
+while the :c:macro:`X86_FEATURE_AMD_CPPC_EXT` CPU feature flag is set.
+``amd-pstate`` can handle the MSR register to implement the fast switch
+function in ``CPUFreq`` that can shrink latency of frequency control on the
+interrupt context.
+
+Shared Memory Support
+----------------------
+
+If :c:macro:`X86_FEATURE_AMD_CPPC_EXT` CPU feature flag is not set, that
+means the processor supports shared memory solution. In this case,
+``amd-pstate`` uses the ``cppc_acpi`` helper methods to implement the
+callback functions of ``amd_pstate_perf_funcs``.
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
+ /sys/devices/system/cpu/cpufreq/policy0/is_amd_pstate_enabled
+
+
+``is_amd_pstate_enabled``
+
+Query whether current kernel loads ``amd-pstate`` to enable the AMD
+P-States functionality.
+This attribute is read-only.
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
+``amd_pstate_lowest_perf / amd_pstate_min_freq``
+
+The lowest physical CPPC performance and CPU frequency.
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
+           <idle>-0       [000] d.s. 244057.464842: amd_pstate_perf: amd_min_perf=39 amd_des_perf=39 amd_max_perf=166 cpu_id=0 prev=0x2727a6 value=0x2727a6
+           <idle>-0       [000] d.h. 244057.475436: amd_pstate_perf: amd_min_perf=39 amd_des_perf=39 amd_max_perf=166 cpu_id=0 prev=0x2727a6 value=0x2727a6
+           <idle>-0       [000] d.h. 244057.476629: amd_pstate_perf: amd_min_perf=39 amd_des_perf=39 amd_max_perf=166 cpu_id=0 prev=0x2727a6 value=0x2727a6
+           <idle>-0       [000] d.s. 244057.484847: amd_pstate_perf: amd_min_perf=39 amd_des_perf=39 amd_max_perf=166 cpu_id=0 prev=0x2727a6 value=0x2727a6
+           <idle>-0       [000] d.h. 244057.499821: amd_pstate_perf: amd_min_perf=39 amd_des_perf=39 amd_max_perf=166 cpu_id=0 prev=0x2727a6 value=0x2727a6
+     avahi-daemon-528     [000] d... 244057.513568: amd_pstate_perf: amd_min_perf=39 amd_des_perf=39 amd_max_perf=166 cpu_id=0 prev=0x2727a6 value=0x2727a6
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
index f40994c422dc..28db6156b55d 100644
--- a/Documentation/admin-guide/pm/working-state.rst
+++ b/Documentation/admin-guide/pm/working-state.rst
@@ -11,6 +11,7 @@ Working-State Power Management
    intel_idle
    cpufreq
    intel_pstate
+   amd_pstate
    cpufreq_drivers
    intel_epb
    intel-speed-select
-- 
2.25.1

