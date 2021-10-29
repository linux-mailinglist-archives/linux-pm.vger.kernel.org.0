Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0EA43FCE3
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhJ2NF6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:05:58 -0400
Received: from mail-bn8nam08on2054.outbound.protection.outlook.com ([40.107.100.54]:49377
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230273AbhJ2NF5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 09:05:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqGjsfNkcwAfi3w47tlEP2gmSKwvUbiTPySRP4Vl4lJr7OwnFze4TdVGoZ89dOmJZmLhByTaNyDb2LKQtRBcocXlZ7/xHFUAFK/3T9dMD3+eDJN98yqUfS5UKXUXIK0Ij0Ne66BETS3Q3IGw3DFN7TJvQFW4nJGoyplNme+Ood/zzHJhYFMtD8fdUjbhXdNNJflL7UdLCLa7FtByQOYhdVmITiNd8zsq2+lVBuiBoslKs9/Dfgkt5m3tEbSQMQ57CnkKqTImaMzK+vD+t1L/hpFnlRL94cx+lek4IZVleiDPggz0+phiuryEhg25lj1EZ4G+y6+oLsI5Zb1+yHjDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0RPCkBe2eKxPlmsi/WzCGPxu9w1j+diIiKZ691N1cY=;
 b=cg9p8nKC5mHn9NyEbyRsWZqnHXT2E9mkEY+DgCsFlrH2FoJ9vbREE7M7gl9l40CuPSVi2CNtmE/RhxZhzCfNNEVBQ48/yVt8ofKzZf6XNrOOSgT5UFfc60q+w1ory3N7G0pyOy4KDiRSYvRHiblfmMqMWFOIQWQvfLmqqIFuGhmW42dkPcq26vhIl0lmcoVol2xrRPmWSzLPsw7lub8vlkGIN0AIuOl3sdksTSkzmYkbAQWOOZZeiMPCncv1XXdr2QFnGwHcNtPzyexywULsvdNZK+kn5E62BGW7AoH1nyhBrjWfsKCHjBFnxLug6tKgsPcIJw6fgaJLfxo9Tde1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0RPCkBe2eKxPlmsi/WzCGPxu9w1j+diIiKZ691N1cY=;
 b=C5taPQexjYc/QO1fwFXsPmDDccXbywrSRkNKZ58qrdpHzOg79lrHijI1COGQaG9ksY3Yg07TRCS//NelROMtiV3yKCz8FcyBJgFbzT+CSkDphJQYEDhoOVYDc+Lf022Dvk7LtHrR6dLGF3oh+udKoqvccyETGS1CVQBSmZ6Szqs=
Received: from MWHPR21CA0025.namprd21.prod.outlook.com (2603:10b6:300:129::11)
 by BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 13:03:20 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::60) by MWHPR21CA0025.outlook.office365.com
 (2603:10b6:300:129::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend
 Transport; Fri, 29 Oct 2021 13:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:03:18 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 08:03:12 -0500
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
Subject: [PATCH v3 00/21] cpufreq: introduce a new AMD CPU frequency control mechanism
Date:   Fri, 29 Oct 2021 21:02:20 +0800
Message-ID: <20211029130241.1984459-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9b006da-d4b0-453c-6e15-08d99adc7a5b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2675776923CBFBCA9FDBDCA9EC879@BN7PR12MB2675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97T32dWMJZCVVrWpDc9NYG1tI+rr2NB6DT4H4UXhh+qtHbyhvKfpt5A9OWJdcpCu97W1KSRdmHbTRa8hCPpULKbOyiMGzSmVgjQc2rw1Fb+v17icg49HAPqHVVtDZTn0oQf8Df+zhlmko7D4KiyH4/ffM//nYbghllfRrvwEMdJkEf9qx8/q3YjxeLN6C0+42nXoWtO3xubu2ektGGm98cgwxa7ScBYJ5hd4Re8sBnkZdC2UgcDXJV/WiOjt85OVt9eG59Gq38QmNo0TibXlZmxP7dR3jdf6Zzf0MfO+ocL0QNglps+HQi1PgCyeFhmYdzIg+/xMowBr21IAISWoZrwOqdHulCvkHHBm5osIeMmWwSq8Cl0DPFDEQze8lzWp4vhiuDwvAvu4Og/fBDvBgEzO8a3KAUJC2n9PO34xjNWxjIIZcHMoNE+YcNAQXbLqy/F2KCbrV/aq9iG4q6zQYRX2m1Q5ocJvNQN8akVB5+xD/gTFmaM9e0ujsfS+3KWI4SYKkNJkLvYsQbdzF3mnqnMQH3VqBVmLnBl8dyl2h+QKwW5ES0ItcdHqQW7ySNrPyiCYchV657fNCSn5CbD4uzhtIS8KuqjriD7Ev3pkG+854WRkErtPhdGR0Wq9wBFXBG+OOR8K8lXtwQteDgfPJccK+faR6Pp2D3+X/Juur+5AiXRNtydYPII7DoMkh7U0Gbwunnt7RVf0W/5JZp4E9twPRECOwFdBjSlLabfzHCggVAAn172aTVozWqsflGfUjbXtEEVEJ0+DbOhrJDEngxL8qqEYmi4N2szZDhm2YuvdDIPfPQP9+0WeD0MvfItayaUthNUCLNde0U3U6fc7y+PcXYY21T8KUwniZXianac=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(6666004)(47076005)(508600001)(83380400001)(4326008)(54906003)(82310400003)(8936002)(316002)(86362001)(7696005)(8676002)(36756003)(5660300002)(7416002)(426003)(356005)(110136005)(16526019)(26005)(81166007)(186003)(2616005)(36860700001)(336012)(70586007)(2906002)(966005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:03:18.4231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b006da-d4b0-453c-6e15-08d99adc7a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
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
V3: https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v3

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

Thanks,
Ray

Huang Rui (18):
  x86/cpufreatures: add AMD Collaborative Processor Performance Control
    feature flag
  x86/msr: add AMD CPPC MSR definitions
  cpufreq: amd: introduce a new amd pstate driver to support future
    processors
  cpufreq: amd: add fast switch function for amd-pstate
  cpufreq: amd: add acpi cppc function as the backend for legacy
    processors
  cpufreq: amd: add trace for amd-pstate module
  cpufreq: amd: add boost mode support for amd-pstate
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
  ACPI: CPPC: Check present CPUs for determining _CPC is valid

Steven Noonan (1):
  ACPI: CPPC: implement support for SystemIO registers

 Documentation/admin-guide/pm/amd-pstate.rst   | 373 ++++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |  17 +
 drivers/acpi/cppc_acpi.c                      |  93 ++-
 drivers/cpufreq/Kconfig.x86                   |  17 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/amd-pstate.c                  | 663 ++++++++++++++++++
 include/acpi/cppc_acpi.h                      |   5 +
 include/trace/events/power.h                  |  46 ++
 tools/power/cpupower/lib/cpufreq.c            |  21 +-
 tools/power/cpupower/lib/cpufreq.h            |  12 +
 tools/power/cpupower/utils/cpufreq-info.c     |  68 +-
 tools/power/cpupower/utils/helpers/amd.c      |  87 +++
 tools/power/cpupower/utils/helpers/cpuid.c    |  13 +
 tools/power/cpupower/utils/helpers/helpers.h  |  22 +
 tools/power/cpupower/utils/helpers/misc.c     |  62 ++
 17 files changed, 1441 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/admin-guide/pm/amd-pstate.rst
 create mode 100644 drivers/cpufreq/amd-pstate.c

-- 
2.25.1

