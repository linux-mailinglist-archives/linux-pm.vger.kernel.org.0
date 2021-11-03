Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936EA443D7E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 08:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhKCHEe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 03:04:34 -0400
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com ([40.107.236.74]:27465
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhKCHEd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 03:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X70lAsQPKfIAxD5tMmtUoJncvXr+x3ZxVoFwygCvVPoOD7RfUJji+wuIrJHFEhcwzpiSroAhPqVx7zCKefNSm7x42s4Ys5cCNg+rsTBlxvlii0W4ur0hbfjUgLTTDxtxhImOCVGS774ECMKF3g5G9imgt3rGunSmxljQmCrYX1Dyeg7SuVq+HepBf9PA5Lbl5xm8VwlhneOkIUBsjS0R0sDeaZgMueKwq/2rlvxDt6gcZ46UTkCZlGtrI/feyFoQrSgQj/zyfoLNA2cj4nbETopCo7lICbcpdWhWpl11Yqjh6hqFvIWE4W17K2+WCPr6YRkQaOYyH3QEJT075sQrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhhl73Vi5JwBhds15VkcJwYu8vPqC8N5vlss6Xu0OW0=;
 b=YLalqMu6TYy/g9DiDoqGvhKK9y3GgcxUMWTDP+u/ySEiY+Jout98toSOqik61BTeVqJ/aseXc0BB2ggzopOZQmWnv3W+tY4g7+lmQ+0if77tnRnA7JzQE44tDVUYC0SLj6Y3Y/3jYjHq2i40Dm6575lrY8NxwPq8WnMC4cyZ44Qlcks1LBKaZ19NWBw9lh72flYbBlbPDAAdnoyXYaaPVQdQXesB9rdxFMw4HvCKKPdL1nda++Hh9IOgkRTRPpanuAEincA71oqE/TN04/uSjASDGwK+9s4IeNv3cdHiMAimnnVpTh2hNH8hGkpWpi8wICKiAOGJKr9BD82yVGQQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhhl73Vi5JwBhds15VkcJwYu8vPqC8N5vlss6Xu0OW0=;
 b=nN/Ym81hPuGWbUSZLEcDnv59JcMQDfMXznr275FD0WTk61WEf07U7+jGhduAIT16Sz34PaaxGXwp9+k+flZDDhjhOu/Fn2JEBQdADzlzKwufP64VHhMkTuT93HYfwADJfs1A7nAZ2ayntQof5opg7XMe4EDSFyTs64SLJL2HzP0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1461.namprd12.prod.outlook.com
 (2603:10b6:910:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 3 Nov
 2021 07:01:54 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 07:01:53 +0000
Date:   Wed, 3 Nov 2021 15:01:22 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 06/21] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
Message-ID: <YYIzwuzoqXRscqif@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-7-ray.huang@amd.com>
 <012f60e6-af5a-5102-b35f-7b14ac9ad198@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012f60e6-af5a-5102-b35f-7b14ac9ad198@amd.com>
X-ClientProxiedBy: HK2PR0401CA0012.apcprd04.prod.outlook.com
 (2603:1096:202:2::22) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR0401CA0012.apcprd04.prod.outlook.com (2603:1096:202:2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend Transport; Wed, 3 Nov 2021 07:01:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1f6095e-3d9a-49c5-b2d8-08d99e97d0f6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1461:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14618F5173BDE1684490971FEC8C9@CY4PR12MB1461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxPR+7dXVnxSB/b4RBo1Lr7dGHJGJYTW0LdzrcjEUfyevpP3xDpejpNtFJTx5zB2AAVyN2lNSo7ySeJUQWZFVJh3uEMWPP7adZD2aMMU61LN1xofRAxpy5Ug19kNqShtHw6GqaE7cjQrSQI+cEWFhrEKbGnu8FrKzhOUGqoIrxqQkZoXFE0ijcbw4YS4h1Q4HikBnWUNoLWnvJnxYP3lxr5hIzJRk2IfIx0tjJ6xkurwLLJeYQqTGJqjdEMh0hLTniG+BEnQZsCQbeJ1Y9zmHg8dz+o8Tzn5ghKsmukBwKMVbgW4L9sj3akABkcRxymk34TPSIr2rHD0rxsKT3WoT8394NtMzxNv79DmrXlkw7aouES6vnhs4uwzQcdV/TwEEjIilfdpHL4jNzaEDbExvKuB9rHqGpHJH8HpitgW0Iw8fDiRNtQpxMGighUVdRmceYxz2t3Fl87bGfruqbYu4GIMMrM10n+R3plDyPZMtMO6mmGvRe5zDoEUOdNCynRP09J5sg+c5iqtu6L8PS9URZ1xmmkUAiZfYlAlEcaMDMJD+J1h85r/tL/jxdwhJROXyhZmUi6AtRHghlw1izb2eJr3cSBZFFxueNk+xp2gte/k0uFXQMFjGkLKDvH+hgG5ON0aB0mGMnU/1JhJjJJRrwi3d9Vl/qvFw8yyMuLGzme+h30C3QPr4foMrE/7HCvYZ3ZG3+ZNSGgg4gk9WEk+DNRAAHnm6RVu0XhTfUxq+vpZWLqcDDwzINQHi+0eafPcWk3nKu6hQrZbDV+mCtelWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(30864003)(26005)(4326008)(38100700002)(55016002)(186003)(2906002)(83380400001)(9686003)(7416002)(956004)(508600001)(966005)(316002)(6636002)(6666004)(54906003)(6496006)(66946007)(33716001)(86362001)(53546011)(8676002)(5660300002)(66476007)(6862004)(66556008)(8936002)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UIfZJeC0fY5eL9D4e2RCm1XtxWro+h+OPn2OlUzZsHGuzDRn2lQjnAQuF1DP?=
 =?us-ascii?Q?7QB9Gt0+6ZS3U8EWXP9nTryro+ffTyba/BR+5hPAPE2SUPbpwlBmgBxAJRlC?=
 =?us-ascii?Q?JwOBzBAY/gBKreVu29MecjoNhCZiWmGXQQKAN5XM0mez5KJwLHt+0zOf7JcR?=
 =?us-ascii?Q?ik6QZVmJPmwn9A7tPQjb5XOiVGJIYRnNHqmDrY8IvY7qUTDZNHjTlmjSXNHM?=
 =?us-ascii?Q?2Z1eenAk6a67BBLjrZc2LmD96gw89gnTgYu5OncE3KUZe9OWpe+BiT5o6zpk?=
 =?us-ascii?Q?T/rGd9DS4+BzZQqkFTPlZ4aico+SMSTmnntrtSX7zwfGO1llUcFWb2LnQFCY?=
 =?us-ascii?Q?jtAulVh6agJtuI7w58O1Nm/lyX3ZXQfE4739ADwnpjD46Dh6Q8/w5F6MJVe4?=
 =?us-ascii?Q?d5nhoqVz6XGXltf49oXrfRk2TSQlezI+gM9cL4YcdYaaPqasjsZJjaqvGFcA?=
 =?us-ascii?Q?0DHjL1YWqieoy5fI6/q6IiHnbKc3ai4/19Xp8kf/wZHzQ6ZODv6ZCWA9oSI0?=
 =?us-ascii?Q?DfuyG8y9tDMsD6ZPci9TE7OnKSwmQMfdbR/CE0KkYcEYKjg+RFeB0hI7Iwts?=
 =?us-ascii?Q?1jb8HQPcJF0lJ/xcLZlqGzmeqUvXeRMzxwwc7JNYB2X8n/B0BHrKo6JVW1+h?=
 =?us-ascii?Q?PvMs7H5lVNWe0P7YdTmYM2JGSrJiBvK+fwgQ9rIjaZd8L46lbi6BfysAmYKU?=
 =?us-ascii?Q?r2L0hXAxuKIJJNv/XD5tVM8hkOxtOP9o8gWEBSn/mhE/leaV9vhchThYbYKI?=
 =?us-ascii?Q?nmRsqaB6tTylCfwfk7z/ZVnZpD9CzWbMJjHqmMpeNkwMAcJmXnZqZ4PSPFpO?=
 =?us-ascii?Q?waNBH5lFvLzkos4vUG8If98Qa9gkIiM3kimVeHadY3JZuxGFKZDHwlZ8D9vO?=
 =?us-ascii?Q?//GfgtyVQPePjBvuUGFqbKQJORSEMm2/t8eWGd8ry8tKAGcpKHAfLIbAvqxS?=
 =?us-ascii?Q?EjzbZS+eJQWqUzIpMLfpURQxYD+Z1T0gJbu0gdtCN2I1LjyC2K2DVJ9UZ+MI?=
 =?us-ascii?Q?+gg8q9mWJZToYLR8ZN5wU42xfzCf6i8HdtrAALF/sh2SBg2YWCiHtg2dr3jK?=
 =?us-ascii?Q?S5ksbKh4sANaYCS5vtUBgAuVmQszCl2sCUysZXpVXHK5IWXLtm4cYTxaqTfD?=
 =?us-ascii?Q?ZncOX2VH2fKM5Tu1z2tJexUNrnwuPKQ3OKQ50gFEe1H1bd5e+u89/LaMMH5N?=
 =?us-ascii?Q?CxHEdP2qSIVzFG7zcwGs5LgqElDrMRLH1esBtkyfMwT8R4F65mHDxJGo0wXD?=
 =?us-ascii?Q?n1nOhS2iEPqeZ/JLuMYNQyx2dZufP+S+XHrO6rKe2QA7KXhaFQwSE9dvK+JF?=
 =?us-ascii?Q?PppSZ4xUkEPvQoa+dQ8wSTt1TwaTNuDZhPxJf9bcPnqNlum1XBj+WTnehzoo?=
 =?us-ascii?Q?i0nmPp6shYw9Vj4jxXx/Uoj4O/0RVaNaNj0enTNgRMFAys5RowDpDNRWW1Bq?=
 =?us-ascii?Q?PP/ljUOdWS5aT0hMhfhbNQDZ6XTcGn5+u6dR7Z2TwocZOYBiAUNIbaye88Tq?=
 =?us-ascii?Q?0jadijfU8+dXmjdytdgC9dj5su32AHF5rMwOGM6i/nC/C/C4YFeKVMJq0Nuy?=
 =?us-ascii?Q?Rbk/l76oF7Tt7A8hLCUyhsLeyg7Z6E4d/OCeo+uyFs1wcj48FCGtoKILWvXu?=
 =?us-ascii?Q?oUy57tYcz/LVqQALnsnAvBM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f6095e-3d9a-49c5-b2d8-08d99e97d0f6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 07:01:53.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlbMHp2OsKoxeMIRoSBgVfhabxhl8m0noYcGq+EV69TWjriwJmTgvBMNOQMmQpVMEfIrsZrV7fyZ1rl8k2eXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1461
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 03, 2021 at 03:38:43AM +0800, Fontenot, Nathan wrote:
> On 10/29/21 8:02 AM, Huang Rui wrote:
> > amd-pstate is the AMD CPU performance scaling driver that introduces a
> > new CPU frequency control mechanism on AMD Zen based CPU series in Linux
> > kernel. The new mechanism is based on Collaborative processor
> > performance control (CPPC) which is finer grain frequency management
> > than legacy ACPI hardware P-States. Current AMD CPU platforms are using
> > the ACPI P-states driver to manage CPU frequency and clocks with
> > switching only in 3 P-states. AMD P-States is to replace the ACPI
> > P-states controls, allows a flexible, low-latency interface for the
> > Linux kernel to directly communicate the performance hints to hardware.
> > 
> > "amd-pstate" leverages the Linux kernel governors such as *schedutil*,
> > *ondemand*, etc. to manage the performance hints which are provided by CPPC
> > hardware functionality. The first version for amd-pstate is to support one
> > of the Zen3 processors, and we will support more in future after we verify
> > the hardware and SBIOS functionalities.
> > 
> > There are two types of hardware implementations for amd-pstate: one is full
> > MSR support and another is shared memory support. It can use
> > X86_FEATURE_AMD_CPPC_EXT feature flag to distinguish the different types.
> > 
> > Using the new AMD P-States method + kernel governors (*schedutil*,
> > *ondemand*, ...) to manage the frequency update is the most appropriate
> > bridge between AMD Zen based hardware processor and Linux kernel, the
> > processor is able to ajust to the most efficiency frequency according to
> 
> s/ajust/adjust/
> 
> > the kernel scheduler loading.
> > 
> > Performance Per Watt (PPW) Caculation:
> > 
> > The PPW caculation is referred by below paper:
> > https://software.intel.com/content/dam/develop/external/us/en/documents/performance-per-what-paper.pdf
> > 
> > Below formula is referred from below spec to measure the PPW:
> > 
> > (F / t) / P = F * t / (t * E) = F / E,
> > 
> > "F" is the number of frames per second.
> > "P" is power measurd in watts.
> 
> s/measurd/measured/
> 
> > "E" is energy measured in joules.
> > 
> > We use the RAPL interface with "perf" tool to get the energy data of the
> > package power.
> > 
> > The data comparsions between amd-pstate and acpi-freq module are tested on
> 
> s/comparsions/comparisons/
> 
> > AMD Cezanne processor:
> > 
> > 1) TBench CPU benchmark:
> > 
> > +---------------------------------------------------------------------+
> > |                                                                     |
> > |               TBench (Performance Per Watt)                         |
> > |                                                    Higher is better |
> > +-------------------+------------------------+------------------------+
> > |                   |  Performance Per Watt  |  Performance Per Watt  |
> > |   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> > |                   |  Unit: MB / (s * J)    |  Unit: MB / (s * J)    |
> > +-------------------+------------------------+------------------------+
> > |                   |                        |                        |
> > |    acpi-cpufreq   |         3.022          |        2.969           |
> > |                   |                        |                        |
> > +-------------------+------------------------+------------------------+
> > |                   |                        |                        |
> > |     amd-pstate    |         3.131          |        3.284           |
> > |                   |                        |                        |
> > +-------------------+------------------------+------------------------+
> > 
> > 2) Gitsource CPU benchmark:
> > 
> > +---------------------------------------------------------------------+
> > |                                                                     |
> > |               Gitsource (Performance Per Watt)                      |
> > |                                                    Higher is better |
> > +-------------------+------------------------+------------------------+
> > |                   |  Performance Per Watt  |  Performance Per Watt  |
> > |   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> > |                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
> > +-------------------+------------------------+------------------------+
> > |                   |                        |                        |
> > |    acpi-cpufreq   |     3.42172E-07        |     2.74508E-07        |
> > |                   |                        |                        |
> > +-------------------+------------------------+------------------------+
> > |                   |                        |                        |
> > |     amd-pstate    |     4.09141E-07        |     3.47610E-07        |
> > |                   |                        |                        |
> > +-------------------+------------------------+------------------------+
> > 
> > 3) Speedometer 2.0 CPU benchmark:
> > 
> > +---------------------------------------------------------------------+
> > |                                                                     |
> > |               Speedometer 2.0 (Performance Per Watt)                |
> > |                                                    Higher is better |
> > +-------------------+------------------------+------------------------+
> > |                   |  Performance Per Watt  |  Performance Per Watt  |
> > |   Kernel Module   |       (Schedutil)      |       (Ondemand)       |
> > |                   |  Unit: 1 / (s * J)     |  Unit: 1 / (s * J)     |
> > +-------------------+------------------------+------------------------+
> > |                   |                        |                        |
> > |    acpi-cpufreq   |      0.116111767       |      0.110321664       |
> > |                   |                        |                        |
> > +-------------------+------------------------+------------------------+
> > |                   |                        |                        |
> > |     amd-pstate    |      0.115825281       |      0.122024299       |
> > |                   |                        |                        |
> > +-------------------+------------------------+------------------------+
> > 
> > According to above average data, we can see this solution has shown better
> > performance per watt scaling on mobile CPU benchmarks in most of cases.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/Kconfig.x86  |  17 ++
> >  drivers/cpufreq/Makefile     |   1 +
> >  drivers/cpufreq/amd-pstate.c | 413 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 431 insertions(+)
> >  create mode 100644 drivers/cpufreq/amd-pstate.c
> > 
> > diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> > index 92701a18bdd9..2e798b2c0bdb 100644
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -34,6 +34,23 @@ config X86_PCC_CPUFREQ
> >  
> >  	  If in doubt, say N.
> >  
> > +config X86_AMD_PSTATE
> > +	bool "AMD Processor P-State driver"
> > +	depends on X86
> > +	select ACPI_PROCESSOR if ACPI
> > +	select ACPI_CPPC_LIB if X86_64 && ACPI && SCHED_MC_PRIO
> > +	select CPU_FREQ_GOV_SCHEDUTIL if SMP
> > +	help
> > +	  This driver adds a CPUFreq driver which utilizes a fine grain
> > +	  processor performance freqency control range instead of legacy
> 
> s/freqency/frequency/
> 
> > +	  performance levels. This driver supports the AMD processors with
> > +	  _CPC object in the SBIOS.
> > +
> > +	  For details, take a look at:
> > +	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
> > +
> > +	  If in doubt, say N.
> > +
> >  config X86_ACPI_CPUFREQ
> >  	tristate "ACPI Processor P-States driver"
> >  	depends on ACPI_PROCESSOR
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index 48ee5859030c..c8d307010922 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -25,6 +25,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
> >  # speedstep-* is preferred over p4-clockmod.
> >  
> >  obj-$(CONFIG_X86_ACPI_CPUFREQ)		+= acpi-cpufreq.o
> > +obj-$(CONFIG_X86_AMD_PSTATE)		+= amd-pstate.o
> >  obj-$(CONFIG_X86_POWERNOW_K8)		+= powernow-k8.o
> >  obj-$(CONFIG_X86_PCC_CPUFREQ)		+= pcc-cpufreq.o
> >  obj-$(CONFIG_X86_POWERNOW_K6)		+= powernow-k6.o
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > new file mode 100644
> > index 000000000000..a400861c7fdc
> > --- /dev/null
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -0,0 +1,413 @@
> > +/*
> > + * amd-pstate.c - AMD Processor P-state Frequency Driver
> > + *
> > + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program; if not, write to the Free Software
> > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
> 
> You should use a SPDX license identifier instead of copying the GPL text
> in the file. See Documentation/process/license-rules.rst

The SPDX license identifier is an alternative way to instead of the common
way to express the license at the top comment of the file. Acutally it's
not mandatory, right?

>  
> > + *
> > + * Author: Huang Rui <ray.huang@amd.com>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/smp.h>
> > +#include <linux/sched.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/compiler.h>
> > +#include <linux/dmi.h>
> > +#include <linux/slab.h>
> > +#include <linux/acpi.h>
> > +#include <linux/io.h>
> > +#include <linux/delay.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/static_call.h>
> > +
> > +#include <acpi/processor.h>
> > +#include <acpi/cppc_acpi.h>
> > +
> > +#include <asm/msr.h>
> > +#include <asm/processor.h>
> > +#include <asm/cpufeature.h>
> > +#include <asm/cpu_device_id.h>
> > +
> > +#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
> > +#define AMD_PSTATE_TRANSITION_DELAY	500
> > +
> > +static struct cpufreq_driver amd_pstate_driver;
> > +
> > +struct amd_cpudata {
> > +	int	cpu;
> > +
> > +	struct freq_qos_request req[2];
> > +
> > +	u64	cppc_req_cached;
> > +
> > +	u32	highest_perf;
> > +	u32	nominal_perf;
> > +	u32	lowest_nonlinear_perf;
> > +	u32	lowest_perf;
> > +
> > +	u32	max_freq;
> > +	u32	min_freq;
> > +	u32	nominal_freq;
> > +	u32	lowest_nonlinear_freq;
> > +};
> > +
> > +static inline int pstate_enable(bool enable)
> > +{
> > +	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
> > +
> > +static inline int amd_pstate_enable(bool enable)
> > +{
> > +	return static_call(amd_pstate_enable)(enable);
> > +}
> > +
> > +static int pstate_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +	u64 cap1;
> > +
> > +	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> > +				     &cap1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * TODO: Introduce AMD specific power feature.
> > +	 *
> > +	 * CPPC entry doesn't indicate the highest performance in some ASICs.
> > +	 */
> > +	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> > +
> > +	WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
> > +	WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
> > +	WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> > +
> > +static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +	return static_call(amd_pstate_init_perf)(cpudata);
> > +}
> > +
> > +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> > +			       u32 des_perf, u32 max_perf, bool fast_switch)
> > +{
> > +	if (fast_switch)
> > +		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> > +	else
> > +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> > +			      READ_ONCE(cpudata->cppc_req_cached));
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> > +
> > +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> > +					  u32 min_perf, u32 des_perf,
> > +					  u32 max_perf, bool fast_switch)
> > +{
> > +	static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> > +					    max_perf, fast_switch);
> > +}
> > +
> > +static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> > +			      u32 des_perf, u32 max_perf, bool fast_switch)
> > +{
> > +	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> > +	u64 value = prev;
> > +
> > +	value &= ~REQ_MIN_PERF(~0L);
> > +	value |= REQ_MIN_PERF(min_perf);
> > +
> > +	value &= ~REQ_DES_PERF(~0L);
> > +	value |= REQ_DES_PERF(des_perf);
> > +
> > +	value &= ~REQ_MAX_PERF(~0L);
> > +	value |= REQ_MAX_PERF(max_perf);
> > +
> > +	if (value == prev)
> > +		return;
> > +
> > +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +	amd_pstate_update_perf(cpudata, min_perf, des_perf,
> > +			       max_perf, fast_switch);
> > +}
> > +
> > +static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> > +{
> > +	cpufreq_verify_within_cpu_limits(policy);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_target(struct cpufreq_policy *policy,
> > +			     unsigned int target_freq,
> > +			     unsigned int relation)
> > +{
> > +	struct cpufreq_freqs freqs;
> > +	struct amd_cpudata *cpudata = policy->driver_data;
> > +	unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
> > +		      amd_cap_perf;
> 
> Is there a need to preface each of the variables with amd_? This is
> not something you do in any of the other routines.

Just the names of the temporary variables, They are used on _target and
_adjust_perf functions.

> 
> > +
> > +	if (!cpudata->max_freq)
> > +		return -ENODEV;
> > +
> > +	amd_cap_perf = READ_ONCE(cpudata->highest_perf);
> > +	amd_min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> > +	amd_max_perf = amd_cap_perf;
> > +
> > +	freqs.old = policy->cur;
> > +	freqs.new = target_freq;
> > +
> > +	amd_des_perf = DIV_ROUND_CLOSEST(target_freq * amd_cap_perf,
> > +					 cpudata->max_freq);
> > +
> > +	cpufreq_freq_transition_begin(policy, &freqs);
> > +	amd_pstate_update(cpudata, amd_min_perf, amd_des_perf,
> > +			  amd_max_perf, false);
> > +	cpufreq_freq_transition_end(policy, &freqs, false);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_get_min_freq(struct amd_cpudata *cpudata)
> > +{
> > +	struct cppc_perf_caps cppc_perf;
> > +
> > +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Switch to khz */
> > +	return cppc_perf.lowest_freq * 1000;
> > +}
> > +
> > +static int amd_get_max_freq(struct amd_cpudata *cpudata)
> > +{
> > +	struct cppc_perf_caps cppc_perf;
> > +	u32 max_perf, max_freq, nominal_freq, nominal_perf;
> > +	u64 boost_ratio;
> > +
> > +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	nominal_freq = cppc_perf.nominal_freq;
> > +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > +	max_perf = READ_ONCE(cpudata->highest_perf);
> > +
> > +	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
> > +			      nominal_perf);
> > +
> > +	max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> > +
> > +	/* Switch to khz */
> > +	return max_freq * 1000;
> > +}
> > +
> > +static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
> > +{
> > +	struct cppc_perf_caps cppc_perf;
> > +	u32 nominal_freq;
> > +
> > +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	nominal_freq = cppc_perf.nominal_freq;
> > +
> > +	/* Switch to khz */
> > +	return nominal_freq * 1000;
> 
> You could just do
> 	return cppc_perf.nominal_freq * 1000;

Updated.

> 
> > +}
> > +
> > +static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> > +{
> > +	struct cppc_perf_caps cppc_perf;
> > +	u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
> > +	    nominal_freq, nominal_perf;
> > +	u64 lowest_nonlinear_ratio;
> > +
> > +	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	nominal_freq = cppc_perf.nominal_freq;
> > +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > +
> > +	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> > +
> > +	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf <<
> > +					 SCHED_CAPACITY_SHIFT, nominal_perf);
> 
> Please put the two args to the shift operation should be on the same line.
> 

No problem.

> > +
> > +	lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
> > +
> > +	/* Switch to khz */
> > +	return lowest_nonlinear_freq * 1000;
> > +}
> > +
> > +static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> > +	unsigned int cpu = policy->cpu;
> > +	struct device *dev;
> > +	struct amd_cpudata *cpudata;
> > +
> > +	dev = get_cpu_device(policy->cpu);
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> > +	if (!cpudata)
> > +		return -ENOMEM;
> > +
> > +	cpudata->cpu = cpu;
> 
> You could do the following and get rid of the cpu variable, it's only used here.
> 
> 	cpudata->cpu = policy->cpu;

Updated.

> 
> > +
> > +	ret = amd_pstate_init_perf(cpudata);
> > +	if (ret)
> > +		goto free_cpudata1;
> > +
> > +	min_freq = amd_get_min_freq(cpudata);
> > +	max_freq = amd_get_max_freq(cpudata);
> > +	nominal_freq = amd_get_nominal_freq(cpudata);
> > +	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> > +
> > +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> > +			min_freq, max_freq);
> > +		ret = -EINVAL;
> > +		goto free_cpudata1;
> > +	}
> > +
> > +	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
> > +	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
> > +
> > +	policy->min = min_freq;
> > +	policy->max = max_freq;
> > +
> > +	policy->cpuinfo.min_freq = min_freq;
> > +	policy->cpuinfo.max_freq = max_freq;
> > +
> > +	/* It will be updated by governor */
> > +	policy->cur = policy->cpuinfo.min_freq;
> > +
> > +	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
> > +				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
> > +		goto free_cpudata1;
> > +	}
> > +
> > +	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[1],
> > +				   FREQ_QOS_MAX, policy->cpuinfo.max_freq);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
> > +		goto free_cpudata2;
> > +	}
> > +
> > +	/* Initial processor data capability frequencies */
> > +	cpudata->max_freq = max_freq;
> > +	cpudata->min_freq = min_freq;
> > +	cpudata->nominal_freq = nominal_freq;
> > +	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
> > +
> > +	policy->driver_data = cpudata;
> > +
> > +	return 0;
> > +
> > +	freq_qos_remove_request(&cpudata->req[1]);
> 
> Is this line of code reachable?
> 
> Perhaps this was meant as cleanup if a freq_qos_add_request() call failed but
> it shouldn't be needed with the current code flow.

Nice catch! This line should be cleaned up as well.

> 
> > +free_cpudata2:
> > +	freq_qos_remove_request(&cpudata->req[0]);
> > +free_cpudata1:
> > +	kfree(cpudata);
> > +	return ret;
> > +}
> > +
> > +static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +	struct amd_cpudata *cpudata;
> > +
> > +	cpudata = policy->driver_data;
> > +
> > +	freq_qos_remove_request(&cpudata->req[1]);
> > +	freq_qos_remove_request(&cpudata->req[0]);
> > +	kfree(cpudata);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct cpufreq_driver amd_pstate_driver = {
> > +	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> > +	.verify		= amd_pstate_verify,
> > +	.target		= amd_pstate_target,
> > +	.init		= amd_pstate_cpu_init,
> > +	.exit		= amd_pstate_cpu_exit,
> > +	.name		= "amd-pstate",
> > +};
> > +
> > +static int __init amd_pstate_init(void)
> > +{
> > +	int ret;
> > +
> > +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> > +		return -ENODEV;
> > +
> > +	if (!acpi_cpc_valid()) {
> > +		pr_debug("%s, the _CPC object is not present in SBIOS\n",
> > +			 __func__);
> 
> Do we need to print the function name here (and below)?

It's a soft reminder to tell the user where the message comes from.

> 
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* don't keep reloading if cpufreq_driver exists */
> > +	if (cpufreq_get_current_driver())
> > +		return -EEXIST;
> > +
> > +	/* capability check */
> > +	if (!boot_cpu_has(X86_FEATURE_AMD_CPPC)) {
> > +		pr_debug("%s, AMD CPPC MSR based functionality is not supported\n",
> > +			 __func__);> +		return -ENODEV;
> > +	}
> > +
> > +	/* enable amd pstate feature */
> > +	ret = amd_pstate_enable(true);
> > +	if (ret) {
> > +		pr_err("%s, failed to enable amd-pstate with return %d\n",
> > +		       __func__, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = cpufreq_register_driver(&amd_pstate_driver);
> > +	if (ret) {
> > +		pr_err("%s, return %d\n", __func__, ret);
> > +		return ret;
> 
> No need to do a return ret here...
> 
> > +	}
> > +
> > +	return 0;
> 
> ...just do a return ret here.
> 

Updated.

Thanks,
Ray
