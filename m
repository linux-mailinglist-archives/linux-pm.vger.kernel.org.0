Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA64187A6
	for <lists+linux-pm@lfdr.de>; Sun, 26 Sep 2021 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhIZJH6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Sep 2021 05:07:58 -0400
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:64097
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhIZJH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Sep 2021 05:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaziwjEQU3AFdpsEa5h/i0fPkYl/JykYnbgoSiVGu4I24u37+Fdg81zomXjk/SjMCyO7dcOdE+81hfpw949SBQe7LcOKhqtx28ZO/UC1rVqwWZJZAHW05Qi1618FkpD54UlK/GDEc73PAarnwjV0qwPV/GZtX89oJePeQo82gnPkeXIm5nClw+Y5f97ZE1j1pxuJeiAkmtHRQbhSDM3pKGmeIWLwAzPIXlUNzfYswEEMZhXJgEPnLG3x66R/J/WLdd3cUDhbS8n52bDJwAJiWY4+0TBG29B3T0/QDBjEy1Kiq8bjFpz2h4vLTqLDM2XLl58zCWB3US6IQEW/OFA45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O4Iwqu/x/gEyzh6WoESdZZ524Q5z4F3H3IHILzwtHRw=;
 b=GTiwUel4DeHPf6j2uJkHFYYXqPt9P7OJ7Pdby/SYObCXBgOxnPs2rtEPQKN9Cq9U7p14yVV2A/A+gpcN66TCAWrMDl/pv+5r51vpIX5vcGHb4nJuzajJySZwwQ32TtHCfAhpytS/YqbIz6wRrUKHXYKW6a7L6b4Y6tRaTte4aMhr2kJJZYbnwSdiQmXzT1ByQpvOoaV7mui8su5fe6l0FQdV6c3EWliwnBOsTxgQuj1C4yLL5n7t4YEAIE+YG3EI7EQ4emhKEQLZ4TFrIXgc5jk0I1sVD2DKHPmkys9k64EDFd3Y+HkMjESiB4BTUny8tsa4ZyaTgHffiffRm2Dxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4Iwqu/x/gEyzh6WoESdZZ524Q5z4F3H3IHILzwtHRw=;
 b=TSpsuBzLSE/yO3+skVFMA7yHiISOPFh/pQl12lI7jmyqg1fF9fxlwmIIN+kLivFJHIda+Lm7nxaWYYonDabRnQLniHy9WkPO77cKzCSlE1IRnRpAgWAaVShDZ7q/hVAU4BPYLyHGowrW7P+i1Pbf2RC4ywSkxsXJutawEgzWoeM=
Received: from CO2PR04CA0152.namprd04.prod.outlook.com (2603:10b6:104::30) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.20; Sun, 26 Sep 2021 09:06:19 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::db) by CO2PR04CA0152.outlook.office365.com
 (2603:10b6:104::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 09:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 09:06:18 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 04:06:13 -0500
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
Subject: [PATCH v2 00/21] cpufreq: introduce a new AMD CPU frequency control mechanism
Date:   Sun, 26 Sep 2021 17:05:44 +0800
Message-ID: <20210926090605.3556134-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 787afc67-9476-44d6-a11a-08d980cce73d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360C07405E86375E72D1ED9ECA69@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9JJRYAU8q+AKwB4rHw2tICLJwJZi0TZqvwLCZaGv5I0YR/Cs55p3atB3HR7MYPI9VogSaHUUYr4+0b99DAfKJukYzNHb2rcrRAibHBrl3R6bVr5DUedrlRROnmBm8pWjW2q4W6irxNvItgWfBkR9KWzn+7WGKb1RF1eBT1mmB8HV9gfQbX6+MQREdUlhQ30v88nW01e1oDQp2ibCuA3s8Ggsfvh/gmvAdDHkH8afDuapY0725nG7hArLBmpMztEuvgZzB3LEvaf1WCINh3YLO8/VwIBOLM4eriApSDp1XJsWccqv6srNT/gh8+pe7tAYYjo3130Eh1LbhTq+sAcz2LcBvVdXtMDTbbMdazVsaA6iTcuIQi4ZOIrft4DpEUc6RcNZRUrmA373gG7nv9asGH26DAWzcZBv6o9VjOquwdA1k4hJiY06GovdR4/fQymmtaOfS+lOF5nsVvI+Xvfn321zDA4cx9S7v8WBDTQoTkUFZOj+XgJCRe5f7HpTC/flctRJlWPvB7WLTuEZ0PBrZdcriH3h701z0NL3E/QTjJB//Nu2vyUMPswIygkEEinhY6sDafRl1qh4gcBh9O64aK9KO3UnkZmkT8vbcbDWa9mFiA7OpdASTbuZkLXi6oi3YVYNDq+mWVwpBtCO8dMYQo357yjl2SOpejd6GSSlk4c5aU/Pzcf0HHm+zPXBBCYn5hC+Idc0JzrkR0lSM4b4iEmaAKffFhLU1rHbn9EgOi3n72o6tQGt2/hhIMmK+4FzduKSY3WcmQostL1wgAJgnDlSFJZThzqLxL0gD/4AI5Drlf4IcyOi63SNCboQnUs/kD82eoHQksFNNMBqRZQqKBJ0awwaAFGMqe8ZBxchk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(336012)(6666004)(316002)(83380400001)(508600001)(47076005)(81166007)(8936002)(7696005)(70586007)(8676002)(2906002)(36860700001)(36756003)(26005)(54906003)(186003)(5660300002)(426003)(966005)(110136005)(82310400003)(1076003)(16526019)(86362001)(2616005)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 09:06:18.9446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787afc67-9476-44d6-a11a-08d980cce73d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
X86_FEATURE_AMD_CPPC_EXT feature flag to distinguish the different types. 

Using the new AMD P-States method + kernel governors (*schedutil*,
*ondemand*, ...) to manage the frequency update is the most appropriate
bridge between AMD Zen based hardware processor and Linux kernel, the
processor is able to ajust to the most efficiency frequency according to
the kernel scheduler loading.

Performance Per Watt (PPW) Caculation:

The PPW caculation is referred by below paper:
https://software.intel.com/content/dam/develop/external/us/en/documents/performance-per-what-paper.pdf

Below formula is referred from below spec to measure the PPW:

(F / t) / P = F * t / (t * E) = F / E,

"F" is the number of frames per second.
"P" is power measurd in watts.
"E" is energy measured in joules.

We use the RAPL interface with "perf" tool to get the energy data of the
package power.

The data comparsions between amd-pstate and acpi-freq module are tested on
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

These patch series depends on a "hotplug capable" CPU fix below (Only few
of CPU parts with "un-hotplug" core will encounter the issue and Mario is
working on the fix):
https://lore.kernel.org/linux-pm/20210813161842.222414-1-mario.limonciello@amd.com/

And we can see patch series in below git repo:
V1: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1
V2: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v2

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

Thanks,
Ray

Huang Rui (19):
  x86/cpufreatures: add AMD Collaborative Processor Performance Control
    feature flag
  x86/msr: add AMD CPPC MSR definitions
  cpufreq: amd: introduce a new amd pstate driver to support future
    processors
  cpufreq: amd: add fast switch function for amd-pstate module
  cpufreq: amd: add acpi cppc function as the backend for legacy
    processors
  cpufreq: amd: add trace for amd-pstate module
  cpufreq: amd: add boost mode support for amd-pstate
  cpufreq: amd: add amd-pstate checking support check attribute
  cpufreq: amd: add amd-pstate frequencies attributes
  cpufreq: amd: add amd-pstate performance attributes
  cpupower: add AMD P-state capability flag
  cpupower: add the function to check amd-pstate enabled
  cpupower: initial AMD P-state capability
  cpupower: add the function to get the sysfs value from specific table
  cpupower: add amd-pstate sysfs definition and access helper
  cpupower: enable boost state support for amd-pstate module
  cpupower: move print_speed function into misc helper
  cpupower: print amd-pstate information on cpupower
  Documentation: amd-pstate: add amd-pstate driver introduction

Jinzhou Su (1):
  ACPI: CPPC: add cppc enable register function

Mario Limonciello (1):
  ACPI: CPPC: Check online CPUs for determining _CPC is valid

 Documentation/admin-guide/pm/amd_pstate.rst   | 377 +++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |  17 +
 drivers/acpi/cppc_acpi.c                      |  50 +-
 drivers/cpufreq/Kconfig.x86                   |  13 +
 drivers/cpufreq/Makefile                      |   5 +
 drivers/cpufreq/amd-pstate-trace.c            |   2 +
 drivers/cpufreq/amd-pstate-trace.h            |  96 +++
 drivers/cpufreq/amd-pstate.c                  | 724 ++++++++++++++++++
 include/acpi/cppc_acpi.h                      |   5 +
 tools/power/cpupower/lib/cpufreq.c            |  21 +-
 tools/power/cpupower/lib/cpufreq.h            |  12 +
 tools/power/cpupower/utils/cpufreq-info.c     |  68 +-
 tools/power/cpupower/utils/helpers/amd.c      |  82 ++
 tools/power/cpupower/utils/helpers/cpuid.c    |  13 +
 tools/power/cpupower/utils/helpers/helpers.h  |  21 +
 tools/power/cpupower/utils/helpers/misc.c     |  64 ++
 18 files changed, 1514 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/admin-guide/pm/amd_pstate.rst
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h
 create mode 100644 drivers/cpufreq/amd-pstate.c

-- 
2.25.1

