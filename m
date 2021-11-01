Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4844415EA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 10:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhKAJRs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 05:17:48 -0400
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:39265
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231223AbhKAJRr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Nov 2021 05:17:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7BHUPC5n3/9vniKAlYfeCrSL0lX/FIcCcoIsVyH2Ie+xp3IgRKaMUgM1TIumFB3rxmVYWDyLMLRFDuoK5KRg26AFb+RJ7PccPtWYbmUe5XnhQY7NVJomEQczMkGkIkfMPG9yjknyzuqyEdXAGl0zrlvV4+oAOzr/c+q/1I9mh0Cv6IaNnmSYwb2dRCtae8HASbXwQFGLgA4BTlM/X8toJM/euMshDT1fHev5vOMYzz1mg1JE3Nxy/Zbt0VdgF2Xuu6kdy20W7CA0BQZHUc97A6p72yGXNhvqhzHomHYkSKxw57X8rRFX2/JkwqcEilDqvpFRv5DlQFb2haTsEXJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCM5M4/WnJXrX/MINJm9b10JHLXlY1qabC1zZAO6IaM=;
 b=ZSVUid0HwsC/5GEmlkTQgUSo9I2e2wwPbTgWERz4dupStmrH3dIRdM3wDuI+RvHUA43YHcXI8DeREP5FbHfuETMnf3B2bHoHt/woBTdRpXohvCeR+VJE8QqY104Z34Vwj7/v+UUilyJiU9cYY9DPnyBGye1MXMGBjlOzMryTdd/CsgytXhdRFeRXzSWgHtIibxGMDkUwR192vEP1q5gmfpBRrHqkg5D7HcS7G0J87hJfIUmycRGKVoC5fF0t420f7N7waKFx39PMwi53CUuOMeJCzwcvyDXbNaRRyKwykOIqz31K9L4n5XARIkRA/2mVMF7ZSDGQtEa4k8OiKG6XQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCM5M4/WnJXrX/MINJm9b10JHLXlY1qabC1zZAO6IaM=;
 b=pV7wpB72hPgyDg7JVhLLxC6WBXhVk2FS2BFPONSR/mV+jWdH7NeVwmPOICEhLCosr5DGrPIuFRa2/RCvXedAr7/c+TOUi6GOecJoAUF5ogb+k7udiTnzRdaQ5J74Pq2F8Gx0Ucly4BWWmAZknrAIppyK+lXAokoORI0aQB0D9s0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1848.namprd12.prod.outlook.com
 (2603:10b6:903:11d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 09:15:11 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 09:15:11 +0000
Date:   Mon, 1 Nov 2021 17:14:47 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 17/21] cpupower: add amd-pstate sysfs definition and
 access helper
Message-ID: <YX+wB+pqeTHSqBa6@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-18-ray.huang@amd.com>
 <89c43242-a112-4ba2-ff3d-5e3a0b048a35@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c43242-a112-4ba2-ff3d-5e3a0b048a35@amd.com>
X-ClientProxiedBy: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR02CA0145.apcprd02.prod.outlook.com (2603:1096:202:16::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 09:15:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd67c48-1877-46f1-532d-08d99d181b38
X-MS-TrafficTypeDiagnostic: CY4PR12MB1848:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18484A2E189810DDC2898368EC8A9@CY4PR12MB1848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9j9gXpRk/SAVAwExZw3BuEgNw9BXduFJ8tCwVdmjH+q1xUIKyU81xp11YA3rLqWBUpYGQ2kA8vVIdWrC2KgQENeDRzArN+qzGmeLX5vrhwcpCkyHMtq7HonIQCowNP9CQHWRJo1FalARyhsUc//aj/P3HeZiMCh1ZV6vYrLNCs+aQG0k26FZLgd6rTqomVInGElAMltpzfN90UXqLgC6XYkgWoCId7SyHTDpEUV+YBbvDlXeE7PAueA1AzB/FpDwmzEZWBKe/4sMP6vVMPaPRLfsqi5mmbhDi6RjBC3fIwAOD4il1yB1ooBSyha8DqK84rCQebdkacwh+5QwqGz6onztuR6JCpxiUE/U71/IW7zh+gvCiNB87KIJb0YFjkA97Fe4fNtEnkchL3b6/WhD/9fcLw9/tYw+Rw232b5yBxqjPgm5TFSHvBQSQ0YfsZ/nB1QpIZNXQl4tU2Z/K+qnuV+z3BFZJgAN98Ek10BOniJ7mLVdOd6cnozNbt2P4xH+lohwLhO0ARUWty8VxNS38KPqHhFEUTzv5qkBbo4Q38KqfUT9EK2ecWaKyX8VJeQUG06hoEU76g/Q8T1kV1fGu8GxD4q/Dz2rcnvD+7NZXOyC5FqHVqN860aFYne6hVb7N+cOxHmC/FdEXXP8MrvJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(6496006)(5660300002)(26005)(66556008)(66946007)(66476007)(86362001)(7416002)(8676002)(83380400001)(4326008)(6636002)(186003)(6666004)(956004)(6862004)(55016002)(316002)(54906003)(9686003)(33716001)(38100700002)(53546011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qe8h12vNk2oNPXitb5dB0F4txpVIQ9UkWoV0ilW6i4AXIYQEWLZeQIrQrqGQ?=
 =?us-ascii?Q?vfvq5fOZfFfOXyGRMAdBao7lqWArRYMxNlGgim1v5QDns5/t55BlXkfW0ee5?=
 =?us-ascii?Q?sNGkG5GWGO/dnxjNF+45wTe8mfezRvPTGUp7Bmv6/QtsOAIPVQXiWGbEtoXn?=
 =?us-ascii?Q?MxeSpx+PZyqeycnShhK/Ci5jFwEOsFH8gP+gKLsD9w8UVQ91hTRAsfgjL9Zz?=
 =?us-ascii?Q?7JdKqYKUJKAWE5RhS+u2MbJ0tcQB1rFsjM7z7Cf753/dIXVAmU/BUhKanWfx?=
 =?us-ascii?Q?fDwwbk/Nk6pTPpXNJ5TWcnl35gtyaw6mYdn44P1UlPeZSGC8DPECqjm+mmHS?=
 =?us-ascii?Q?xLpOZewbzauPpURNOiHxDmF1omaIYGtWk/0X/5h53jUavLnq1LIk7hcqrep2?=
 =?us-ascii?Q?Xd2m68mKK44Aovnz+W96dAmMyXXLgvnHXwOvdzLLh68WB5wBOuH1P2ELpBlK?=
 =?us-ascii?Q?XumNr0YLgPgGmbCag5f7ykOMdPFT3ihxk4b/GaUW9JOzZTWTDpe1mn5tga2e?=
 =?us-ascii?Q?6lsW8PMwWrz2g55t/V10Iffp9hwTQ+qV1YEUbuCkck/mNoGVaEqk7aOVObU/?=
 =?us-ascii?Q?emzQvq2+c14Cb6VPZ5DY08p9EtFK4VKefknmoMrJSJP8/R5euacILbeMDM0A?=
 =?us-ascii?Q?DfZy7ZgnEQyPthz5gO0sHs1c1DNuiDhv3mRGVw/65btrOQ2yyiVr+e1fqk4M?=
 =?us-ascii?Q?tdj8TNZtwnnLDQaXOtSPzQXR+xHKoz4CVMOhVR+AgfYxe6eyasL0/Rzn1s9U?=
 =?us-ascii?Q?evK9cDyyQA7KcQtLc7TW7SMVLImYrR0i2BbXQzey2ODokr99F8HzxA5EI5Wg?=
 =?us-ascii?Q?BjpSA7hUlqV36WT96dXIN0h1/evu1tnvrVij6ClhMI83aa9Q4ZaOVi42Lym7?=
 =?us-ascii?Q?jwBYaYGL4cNYwTtyX7SaMzyE0cjZ46ZxxN1w2GLJ0op9O0ESenKrs4FJ46Bw?=
 =?us-ascii?Q?B+xka/TRrpetMLQ+YGnQiorrT0DzzXvXgu4oi8imdLSK8it2aDueJywyYFei?=
 =?us-ascii?Q?eTdhELCrhhYoDwhsGKQ2mF6Ql4ADuUkXxiHEBN5G6sieNFGl9cdA6vZm8aEy?=
 =?us-ascii?Q?gqCsp+zfUINK7LeQdLMWI0abJDtohFdEubwDfTKkE1zu+4NHl5ewBFidnLqd?=
 =?us-ascii?Q?x/oZHA5wOWOK9ydVUM4uKfnrg8/LIeSvqa432q67hOOrBYHAyrbnYZ0bP53o?=
 =?us-ascii?Q?XLEaghR+V+yY+7cdTCh36JJFGEIKNgdykBtZ3qMKEA2ymO4HqC0WsjGwGlDs?=
 =?us-ascii?Q?aKDlkYyHi6rSUQgkINH6trEhMLd5mQKHWhGrZYsuzg0NgXn+aPKd+xuUdxey?=
 =?us-ascii?Q?zvq6rtx/DA4eVmrs1WCJMh6gyc2ljRfQJxCFpMaC2D4iAHXJbl/zz+ximS+b?=
 =?us-ascii?Q?ADQ8+IL//fCIMEI1aTbFoHadIB6Rn3lidm+aRvDcHNt3XS45btLsoiUYVHYE?=
 =?us-ascii?Q?iGTVe2/gjUQac9jq41uoX44YFgAGcDcOeRR8BhUyyC3RlQROZwMvghBo6Ayk?=
 =?us-ascii?Q?VvsuqgBpmTDO2UR4YJEF7pDIjRngwXxJaxRxCEMCsXk6uBPCww104uSWvkpY?=
 =?us-ascii?Q?BAqFv0JuNFfdJ70v9pT64+SDXEbMACixxW8RLB/SaKf+ttw9EIkQgQDyDCKB?=
 =?us-ascii?Q?RTLYIvlgzCqoXfmysxwCpZ4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd67c48-1877-46f1-532d-08d99d181b38
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 09:15:11.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWLqjsfJU8/9z3reFdEYQzlQ8XZHFVy6nofbpoESF+YiuuQtaC9pj8AGXcWBZz2aUKFIBB7TRzjQTfA40tox+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1848
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 29, 2021 at 10:10:13PM +0800, Limonciello, Mario wrote:
> On 10/29/2021 08:02, Huang Rui wrote:
> > Introduce the marco definitions and access helper function for
> 
> You've got a spelling error here.

Thanks, it's should be "macro".

Ray

> 
> > amd-pstate sysfs interfaces such as each performance goals and frequency
> > levels in amd helper file. They will be used to read the sysfs attribute
> > from amd-pstate cpufreq driver for cpupower utilities.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/utils/helpers/amd.c | 37 ++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> > index 97f2c857048e..f233a6ab75ac 100644
> > --- a/tools/power/cpupower/utils/helpers/amd.c
> > +++ b/tools/power/cpupower/utils/helpers/amd.c
> > @@ -8,7 +8,9 @@
> >   #include <pci/pci.h>
> >   
> >   #include "helpers/helpers.h"
> > +#include "cpufreq.h"
> >   
> > +/* ACPI P-States Helper Functions for AMD Processors ***************/ >   #define MSR_AMD_PSTATE_STATUS	0xc0010063
> >   #define MSR_AMD_PSTATE		0xc0010064
> >   #define MSR_AMD_PSTATE_LIMIT	0xc0010061
> > @@ -146,4 +148,39 @@ int amd_pci_get_num_boost_states(int *active, int *states)
> >   	pci_cleanup(pci_acc);
> >   	return 0;
> >   }
> > +
> > +/* ACPI P-States Helper Functions for AMD Processors ***************/
> > +
> > +/* AMD P-States Helper Functions ***************/
> > +enum amd_pstate_value {
> > +	AMD_PSTATE_HIGHEST_PERF,
> > +	AMD_PSTATE_NOMINAL_PERF,
> > +	AMD_PSTATE_LOWEST_NONLINEAR_PERF,
> > +	AMD_PSTATE_LOWEST_PERF,
> > +	AMD_PSTATE_MAX_FREQ,
> > +	AMD_PSTATE_NOMINAL_FREQ,
> > +	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
> > +	MAX_AMD_PSTATE_VALUE_READ_FILES
> > +};
> > +
> > +static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
> > +	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
> > +	[AMD_PSTATE_NOMINAL_PERF] = "amd_pstate_nominal_perf",
> > +	[AMD_PSTATE_LOWEST_NONLINEAR_PERF] = "amd_pstate_lowest_nonlinear_perf",
> > +	[AMD_PSTATE_LOWEST_PERF] = "amd_pstate_lowest_perf",
> > +	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
> > +	[AMD_PSTATE_NOMINAL_FREQ] = "amd_pstate_nominal_freq",
> > +	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
> > +};
> > +
> > +static unsigned long amd_pstate_get_data(unsigned int cpu,
> > +					 enum amd_pstate_value value)
> > +{
> > +	return cpufreq_get_sysfs_value_from_table(cpu,
> > +						  amd_pstate_value_files,
> > +						  value,
> > +						  MAX_AMD_PSTATE_VALUE_READ_FILES);
> > +}
> > +
> > +/* AMD P-States Helper Functions ***************/
> >   #endif /* defined(__i386__) || defined(__x86_64__) */
> > 
> 
