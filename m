Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD814456D5F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 11:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhKSKep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 05:34:45 -0500
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:42177
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232543AbhKSKep (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 05:34:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0Sx3DIU5nbsklSTiO2mabDEZOEEXgHfSdBzyA9AbbPZ5WNXxQoGsNqbWSVeUWWjW30S2bCZta536scmU9oSaZwFmD/X54Ora1uhCFyxLcYE2JkS3Tdz72rtqIIAeVQDON/urhALBlLHbJbmEQ/6bb0fiKCXzFEF/mqk4XnE/35LIS+jaNYpWbES/KSumgF9qsAryLI/JNNy5uTSWeMzKNLYDG1uwwuXA3UAxG9evuTJZkmd6ULS5kemT+noRIbyZSiXLp9IyesTSa3ZcqQ17Eih6zHMEvZj+CizjpUNNsbqumlTIjSs33HsZrq7eaaefCBaDWS7mO5ec4n4F79cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSr1Veu5zDa/ygjs1T5sMi1ARBdP0FIfXZ/dD18TSRg=;
 b=QVCO4v4+Gxyn+1+zaVXBRJwIxWswuuW665fGoUfQq/6naO3BOI7CkDN/fDdsj1WDG1htvzXQ4UTovY1HDYXKXzNFpoZhhMTM1Zq7ZfQ2PqduMce+LAJ1fTaP2bjbN5PCv9DDWgAEbcPhB6tjEBcIGG6UUN7I37lMID6fhdhv9d/CupgdtDKOJHOMDChtU2/Q9RV9jVMMrsdM3Qxd0CslHQp+CK4kHL1IT8U+p6tvlsYO1ng/HO1WMJeyb/suE+5FOvqM0aXiGKHUt3Q2RBFVPCGzWb1jcKMnFaHuZuOmjKkjOxa82hpIl5Glj0JOgNBrZaD+hNJkb/fC91unhYIBBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSr1Veu5zDa/ygjs1T5sMi1ARBdP0FIfXZ/dD18TSRg=;
 b=B70mNLhpQr7Y8SX0ff+77sc2hm3B7Xw9fSoMWdRHOf4dNUD7Y/lkuT73O0Arz13QV5dkXiTZoRUeYUx/gGsLciqolDGg9ZhvFUBgxg3fyBwCuoA2P5TASgAXPSE/EpwxZNrT1d2YbzI4WvAvheW5Y/4H9FYipvu9NfuSDJqzfbc=
Received: from DS7PR03CA0110.namprd03.prod.outlook.com (2603:10b6:5:3b7::25)
 by CH2PR12MB3813.namprd12.prod.outlook.com (2603:10b6:610:2c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 10:31:42 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::c0) by DS7PR03CA0110.outlook.office365.com
 (2603:10b6:5:3b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 10:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 10:31:41 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 04:31:36 -0600
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
Subject: [PATCH v4 00/22] cpufreq: introduce a new AMD CPU frequency control mechanism
Date:   Fri, 19 Nov 2021 18:30:40 +0800
Message-ID: <20211119103102.88124-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b506e9b1-4201-41b5-bc48-08d9ab47c6f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3813:
X-Microsoft-Antispam-PRVS: <CH2PR12MB381321D543D6E3B54C0D4174EC9C9@CH2PR12MB3813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abYwYaeZGl9PYAaouQO3UvaCA9nQ2G4BNrTQaF2xi2p9xhn6C90JVApB23lZEePp3tYUreJwH8bIoxc3SG6jzL8gaWnTc6Sp7wdPjgN5OeTmH3u4HHGM5bgRTlQU61ePsYUX9IFzq8m3Cmc7PQfFvVINDCF2xxIG4XfYwtRhrw+SI/mtG6MKe7HKmmr1wf6TjAp8+zSjhf2GvZLzraGkWwivXuIa1xv8xmcrTvSgV535GQ8c9cjd9Mz7KzbEZmuoex3DtloXAKzCifwm7w7Non3mdMSdO3gnjQKb+lRqoXxe2q1ii8L9TM+kA40Sd80eveuJK4JZ7YfjZqLhUtvFsexGAetOtIpXAdmU6Esigd0u3USj5+hRAHpqPCjTBjqiPW4aQeznMzb6AlWol2hjZZKi8vKA7PZIPHoEtylPyhPuH0JpTpfME70Wf9YtCb9TdIUyLMbpCdDUVPbRBpPajEEWngqOV2sBpHl3LdJyHca683USWdGdhcbrJOZMHY5o3es7cAd7P+QBO0IKY5lQMH/8lIy20Y8mH6BSxgzDQ66vPf9AURKuVX8KGeYEqpPmclB3g8nsePUPqLK9SUENAGlxEaqkhXBRxYBUyVaxkDcxxbQrxfkF6/09nIVlu5rxKpCwsFEaQ7/Ya83jekDXJuCK1fOqa4oMVH7uv+lU1EMFYwpHw9gZsNlZb5BNXRz3edxE0IYrOWpgv4BCHcPmZa8DvzuDbgCFEBiYWtnT65aCcHTR1oRUUqQlENftw2O/E3SXaM8jhk0DzSW4r6QP/Ue3mBb/OZ3wnXj8QRm/7c/B9H3R1CmXZjlmExZK7Fg+dxff26RLmMxGvulKhjB5y1VhkLrY35f2XcsXrq4VxiE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(45080400002)(47076005)(36860700001)(8676002)(2906002)(30864003)(2616005)(966005)(83380400001)(82310400003)(81166007)(426003)(86362001)(7696005)(6666004)(54906003)(336012)(186003)(110136005)(316002)(4326008)(7416002)(1076003)(5660300002)(356005)(70586007)(70206006)(16526019)(8936002)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 10:31:41.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b506e9b1-4201-41b5-bc48-08d9ab47c6f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3813
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

We would like to introduce a new AMD CPU frequency control mechanism as the
"amd-pstate" driver for modern AMD Zen based CPU series in Linux Kernel.
The new mechanism is based on Collaborative processor performance control
(CPPC) which is finer grain frequency management than legacy ACPI hardware
P-States. Current AMD CPU platforms are using the ACPI P-states driver to
manage CPU frequency and clocks with switching only in 3 P-states. AMD
P-States is to replace the ACPI P-states controls, allows a flexible,
low-latency interface for the Linux kernel to directly communicate the
performance hints to hardware.

"amd-pstate" leverages the Linux kernel governors such as *schedutil*,
*ondemand*, etc. to manage the performance hints which are provided by CPPC
hardware functionality. The first version for amd-pstate is to support one
of the Zen3 processors, and we will support more in future after we verify
the hardware and SBIOS functionalities.

There are two types of hardware implementations for amd-pstate: one is full
MSR support and another is shared memory support. It can use
X86_FEATURE_AMD_CPPC feature flag to distinguish the different types. 

Using the new AMD P-States method + kernel governors (*schedutil*,
*ondemand*, ...) to manage the frequency update is the most appropriate
bridge between AMD Zen based hardware processor and Linux kernel, the
processor is able to adjust to the most efficiency frequency according to
the kernel scheduler loading.

Performance Per Watt (PPW) Calculation:

The PPW calculation is referred by below paper:
https://software.intel.com/content/dam/develop/external/us/en/documents/performance-per-what-paper.pdf

Below formula is referred from below spec to measure the PPW:

(F / t) / P = F * t / (t * E) = F / E,

"F" is the number of frames per second.
"P" is power measured in watts.
"E" is energy measured in joules.

We use the RAPL interface with "perf" tool to get the energy data of the
package power.

The data comparisons between amd-pstate and acpi-freq module are tested on
AMD Cezanne processor:

1) TBench CPU benchmark:

+---------------------------------------------------------------------+
|                                                                     |
|               TBench (Performance Per Watt)                         |
|                                                    Higher is better |
+-------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
|                   |  Unit: MB / (s * J)    |  Unit: MB / (s * J)    |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|    acpi-cpufreq   |         3.022          |        2.969           |
|                   |                        |                        |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|     amd-pstate    |         3.131          |        3.284           |
|                   |                        |                        |
+-------------------+------------------------+------------------------+

2) Gitsource CPU benchmark:

+---------------------------------------------------------------------+
|                                                                     |
|               Gitsource (Performance Per Watt)                      |
|                                                    Higher is better |
+-------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
|                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|    acpi-cpufreq   |     3.42172E-07        |     2.74508E-07        |
|                   |                        |                        |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|     amd-pstate    |     4.09141E-07        |     3.47610E-07        |
|                   |                        |                        |
+-------------------+------------------------+------------------------+

3) Speedometer 2.0 CPU benchmark:

+---------------------------------------------------------------------+
|                                                                     |
|               Speedometer 2.0 (Performance Per Watt)                |
|                                                    Higher is better |
+-------------------+------------------------+------------------------+
|                   |  Performance Per Watt  |  Performance Per Watt  |
|   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
|                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|    acpi-cpufreq   |      0.116111767       |      0.110321664       |
|                   |                        |                        |
+-------------------+------------------------+------------------------+
|                   |                        |                        |
|     amd-pstate    |      0.115825281       |      0.122024299       |
|                   |                        |                        |
+-------------------+------------------------+------------------------+


According to above average data, we can see this solution has shown better
performance per watt scaling on mobile CPU benchmarks in most of cases.

And we can see patch series in below git repo:
V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2
V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3
V4: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4

For details introduction, please see the patch 19.

Changes from V1 -> V2:
- cpufreq:
- - Add detailed description in the commit log.
- - Clean up the "extension" postfix in the x86 feature flag.
- - Revise cppc_set_enable helper.
- - Add a fix to check online cpus in cppc_acpi.
- - Use static calls to avoid retpolines.
- - Revise the comment style.
- - Remove amd_pstate_boost_supported() function.
- - Revise the return value in syfs attribute functions.
- cpupower:
- - Refine the commit log for cpupower patches.
- - Expose a function to get the sysfs value from specific table.
- - Move amd-pstate sysfs definitions and functions into amd helper file.
- - Move the boost init function into amd helper file and explain the
  details in the commit log.
- - Remove the amd_pstate_get_data in the lib/cpufreq.c to keep the lib as
  common operations.
- - Move print_speed function into misc helper file.
- - Add amd_pstate_show_perf_and_freq() function in amd helper for
  cpufreq-info print.

Changes from V2 -> V3:
- cpufreq:
- - Add a patch from Steven to add systemio register in cppc lib. (Thanks
  to verify the driver in his platform)
- - Update online cpu mask to present cpu.
- - Enhance cppc_set_enable to cover all valid use cases.
- - Add more description in the Kconfig definition.
- - Clean up some redundance functions and data members.
- - Revise amd-pstate trace event prints.
- - Move the amd-pstate traces into power trace system and set the driver
  as build-in instead of module.
- - Clean up the duplicated sysfs with core cpufreq driver.
- - Revise the amd-pstate RST documentation.
- cpupower:
- - Revise the cpupower_amd_pstate_enabled() function to use
  cpufreq_get_driver helper instead of read sysfs.
- - Clean up the amd-pstate max/min frequency APIs, because they are
  actually the same with cpufreq info sysfs.

Changes from V3 -> V4:
- cpufreq:
- - Rebase the whole series to Rafael's pm branch (5.15)
- - Fix the typo in the commit message and comment.
- - Clean up function implementation.
- - Clean up freq&perf sysfs APIs.
- - Fall back to move amd-pstate traces out of power trace system, because
  it's flexible to debug and fine tune processors with the shared memory
  soluation.
- - Add a kernel param to disable shared memory on amd-pstate, it can be
  enabled manually.
- cpupower:
- - Introduce acpi cppc library support.
- - Clean up the duplicated amd specific perf/frequency.

We received two issues that reported on the processors with shared memory
solution from the community. 

First one:
https://lore.kernel.org/linux-pm/a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz/ 

Thanks Giovanni's support and suggestions, we corrected the caculation method and
duplicated the performance issue in a 64 cores / 128 threads threadripper
which is simliar with EPYC 7713. Check with firmware guy, the sample rate
is about 1 ms that the hardware reponds the frequency change. We are
working to simulate the acpi pstates with cppc api and checking where is
the gap with acpi-cpufreq. Will share you the status later.

Second one:
https://lore.kernel.org/linux-pm/f9323c6fddd4a55d8ca4191a9539ebd056221045.camel@gmail.com/

Thanks Matt to help us reproduce this issue in our side with Ryzen 5900X.
Below is the video to compare with amd-pstate and acpi-cpufreq on "Control"
steam games. The FPS can be increased as well. It is probably something
wrong in the SBIOS.
https://lore.kernel.org/linux-pm/DM4PR12MB5136084E5DC1809FBB578075F1959@DM4PR12MB5136.namprd12.prod.outlook.com/

Due to some issues on shared memory solution, so we fallback to build as a
module and add a parameter "shared_mem" to disable amd-pstate on processors
with shared memory solution for the moment till we complete tunning on this
function.

Thanks,
Ray


Huang Rui (19):
  x86/cpufreatures: add AMD Collaborative Processor Performance Control
    feature flag
  x86/msr: add AMD CPPC MSR definitions
  cpufreq: amd: introduce a new amd pstate driver to support future
    processors
  cpufreq: amd: add fast switch function for amd-pstate
  cpufreq: amd: introduce the support for the processors with shared
    memory solution
  cpufreq: amd: add trace for amd-pstate module
  cpufreq: amd: add boost mode support for amd-pstate
  cpufreq: amd: add amd-pstate frequencies attributes
  cpufreq: amd: add amd-pstate performance attributes
  cpupower: add AMD P-state capability flag
  cpupower: add the function to check amd-pstate enabled
  cpupower: initial AMD P-state capability
  cpupower: add the function to get the sysfs value from specific table
  cpupower: introduce acpi cppc library
  cpupower: add amd-pstate sysfs definition and access helper
  cpupower: enable boost state support for amd-pstate module
  cpupower: move print_speed function into misc helper
  cpupower: print amd-pstate information on cpupower
  Documentation: amd-pstate: add amd-pstate driver introduction

Jinzhou Su (1):
  ACPI: CPPC: add cppc enable register function

Mario Limonciello (1):
  ACPI: CPPC: Check present CPUs for determining _CPC is valid

Steven Noonan (1):
  ACPI: CPPC: implement support for SystemIO registers

 Documentation/admin-guide/pm/amd-pstate.rst   | 373 +++++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |  17 +
 drivers/acpi/cppc_acpi.c                      |  93 ++-
 drivers/cpufreq/Kconfig.x86                   |  17 +
 drivers/cpufreq/Makefile                      |   5 +
 drivers/cpufreq/amd-pstate-trace.c            |   2 +
 drivers/cpufreq/amd-pstate-trace.h            |  77 +++
 drivers/cpufreq/amd-pstate.c                  | 607 ++++++++++++++++++
 include/acpi/cppc_acpi.h                      |   5 +
 tools/power/cpupower/Makefile                 |   6 +-
 tools/power/cpupower/lib/acpi_cppc.c          |  59 ++
 tools/power/cpupower/lib/acpi_cppc.h          |  21 +
 tools/power/cpupower/lib/cpufreq.c            |  21 +-
 tools/power/cpupower/lib/cpufreq.h            |  12 +
 tools/power/cpupower/utils/cpufreq-info.c     |  68 +-
 tools/power/cpupower/utils/helpers/amd.c      |  76 +++
 tools/power/cpupower/utils/helpers/cpuid.c    |  13 +
 tools/power/cpupower/utils/helpers/helpers.h  |  22 +
 tools/power/cpupower/utils/helpers/misc.c     |  62 ++
 21 files changed, 1494 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/admin-guide/pm/amd-pstate.rst
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h
 create mode 100644 drivers/cpufreq/amd-pstate.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
 create mode 100644 tools/power/cpupower/lib/acpi_cppc.h

-- 
2.25.1

