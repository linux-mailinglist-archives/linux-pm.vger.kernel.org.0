Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7D403C16
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhIHPCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 11:02:02 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:15393
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344637AbhIHPCA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY/HY45Qe+NDsHPNmeoUcgAya5M57qAj0igAR2n0i2QtjNNX7rJ2MEd9tN5I/u+QHZHQRR+dtZe9uvZOUvHc1urqdGaPqZ3HDoMIZDpdvPBmG4qWtau8f+UQuThfPiSagoLdkcXkZ9MMY7TYnkB1HlpsFQOZVZzHcwnX+nbzva9uo8Zv7MPQeLxVaqguByjMo4P9WAySC5ORVGYN24dX91z6vyGxNfg6g9vdGDHEiVmp8P2mp0BeaBAXcWo80JCJqY4fI/vIa/ZSzNgBWWRMPPVf5cwcHwKh+P5OFAafm6br4a5/SB6hBkY212FPX+s6vWGag3IuOeDmlZzml6Jt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CmCwZ/aNLFJtzjMuekzZpewcdAy34hK9Tvkho7Ea4TM=;
 b=BOI4djodTe41XkY6Ww3t0eRe+WMwV51EGI5MyLIE85WAUOi8tRVCqVz6uU9E4utdZmQkfJfR2QNTjjhLoCPz1hpRDEgm5QAOCnWZYYUsiO7zWtPB7fWeuh9V3xqHii47w/pIdWOiUBP9vR6xcSzHqt+6mU+s9ETd0m+QIqnjax6Trw5/aBDKsITpGPjFVkZ0Sd7EyAVy/pbfXUaolV6go62QAZsX+npJhY0OZgfFaTqOpnTmBA0T4vLEqc82T1OebAMkEm5fjCP2KAyFU00vkm1pf170QeQ4UaSAA9if6m7o6MH/+43XxZcYMq0nIEL0jFbl+7rqoNTShq/KddExPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmCwZ/aNLFJtzjMuekzZpewcdAy34hK9Tvkho7Ea4TM=;
 b=TuQFws7i68t9RHEQJQ+T/JVxj27etwxs25vX2yNiWIjSajQ0Ok2EJkf2N0lKwQwBoNpitFZwRuFj2J/4HTpdI7lDvPZ00rX1QfvnymAztj5nXbC+Vwm5gTf8gk/QossFP9dtB53f68wbqHF87DQYwtLb+Au1uo2XjnMQMcNjDPA=
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 15:00:50 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f0) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 15:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 15:00:50 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 10:00:45 -0500
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 00/19] cpufreq: introduce a new AMD CPU frequency control mechanism
Date:   Wed, 8 Sep 2021 22:59:42 +0800
Message-ID: <20210908150001.3702552-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b540a0ac-89fe-44bf-a4d4-08d972d9725b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2956:
X-Microsoft-Antispam-PRVS: <DM6PR12MB295664D14149ABD1CFE7B325ECD49@DM6PR12MB2956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goniq85ZIN12Q6n7fP1L7CAnK2tnwN5TWGSm+jM2/EAPjubj01nRyyQrJ3TXVPKX5ZAqqNAe0IdN8xYghN91Wyr3KlOEW5pzq/c4Nes6YzSD5MnVAeBvPUGCj5Vg7lmYilFal6p4cj2I0tJw2r2tJA57lhP97EA9noM9yB7lR/MJRXsehWAaxyxb8tKJC/V8unpmiSyIk5F9SLe8cYNQKD3WCt9CTMeEFwaYg6bCCwY1feWCuamdwfgriaqgfuM/K7r895Jot6RRzxxJukJGMPHMLyw7f5xs/tEMRvpy5pvfIKOuGnIHYbKj480FSrgAmxLo1H89EcxrgjqCzm9RwGY3r9y47EYyJmTzf8sFGpe4qp6GsgCpVp01f81NHIEAFsXbxL1V5XYgaqM6tun5E0wMPKartbtp8sTo9XWXKEt18Z7S5Mkph3siMH1TLuHmsN/iSSDeerO4xryE0ru9Xyyqc6slDQ+HwI1A4TNQrOIeigMpS8Agli7rkEqnUmtdHCAtvS3clcEsUhI/S1HOVDWD4FIoIxo2OkpqF+78dyxim+YxGBXZtzFsweioGo+8YZY6UHOQ6nwHOYPy5lKZZWq6AmuKIdwqDeRIEjFC0WxNTR6p3toqcOf0KWco4oDeErHyTh3jHQYJBo/62JCliIaOwMZPJl2D1vUWN2WF8OK260t3/qTJ6vKs4BNP4OM8qjcOpBMIUT/JjeEB1SD3eauH22hPcN3FmkpePZ2vxkTnx1M0I/vH+OpoRCjp4rgVwehVDMpiS6Cz3gzp6XKOWAe9iJ+xtLS4lmmCHxsRrZ7HkBKitd3Ov6fbHODXQGCDQqmCHnPjrf90rTq4TnDYeVpMQNtNrVB1AtBIX/jduYg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(46966006)(5660300002)(336012)(356005)(81166007)(316002)(7696005)(70586007)(70206006)(110136005)(82310400003)(2906002)(54906003)(47076005)(1076003)(478600001)(8936002)(6666004)(8676002)(26005)(966005)(83380400001)(4326008)(186003)(36756003)(36860700001)(16526019)(426003)(2616005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 15:00:50.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b540a0ac-89fe-44bf-a4d4-08d972d9725b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
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
https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v1

For details introduction, please see the patch 19.

Thanks,
Ray

Huang Rui (18):
  x86/cpufreatures: add AMD CPPC extension feature flag
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
  cpupower: add amd-pstate sysfs entries into libcpufreq
  cpupower: enable boost state support for amd-pstate module
  cpupower: add amd-pstate get data function to query the info
  cpupower: print amd-pstate information on cpupower
  Documentation: amd-pstate: add amd-pstate driver introduction

Jinzhou Su (1):
  ACPI: CPPC: add cppc enable register function

 Documentation/admin-guide/pm/amd_pstate.rst   | 377 ++++++++
 .../admin-guide/pm/working-state.rst          |   1 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |  17 +
 drivers/acpi/cppc_acpi.c                      |  42 +
 drivers/cpufreq/Kconfig.x86                   |  13 +
 drivers/cpufreq/Makefile                      |   5 +
 drivers/cpufreq/amd-pstate-trace.c            |   2 +
 drivers/cpufreq/amd-pstate-trace.h            |  96 +++
 drivers/cpufreq/amd-pstate.c                  | 812 ++++++++++++++++++
 include/acpi/cppc_acpi.h                      |   5 +
 tools/power/cpupower/lib/cpufreq.c            |  44 +-
 tools/power/cpupower/lib/cpufreq.h            |  16 +
 tools/power/cpupower/utils/cpufreq-info.c     |  27 +-
 tools/power/cpupower/utils/helpers/cpuid.c    |  13 +
 tools/power/cpupower/utils/helpers/helpers.h  |   6 +
 tools/power/cpupower/utils/helpers/misc.c     |  27 +
 17 files changed, 1500 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/pm/amd_pstate.rst
 create mode 100644 drivers/cpufreq/amd-pstate-trace.c
 create mode 100644 drivers/cpufreq/amd-pstate-trace.h
 create mode 100644 drivers/cpufreq/amd-pstate.c

-- 
2.25.1

