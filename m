Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320DC445F17
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 05:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhKEEX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 00:23:59 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:10977
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229884AbhKEEX7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 00:23:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLMtPZfooPpPK6cd8kos+xPrXjhclAB+3uNjXZjGxWLeVsQW6ZBZ90XHq9YrcsJOtjvzW5Op+Xg2EDGMTRkpPC3D775nECTWcG5arlFk4RPTti+hSZ/57RHnsOmo9t7l3RIq0Z4CoI+1wvdfl6tRWw6b9W9rbgPOY6TV5choLGwbowtMDu1WSucCMIwRHejiLcJyJJjGKAtl+gO3nGkDc++WaH3cZcWRmVNyMaKAyD/eollGbjWAQhHalj1d/6E56Us8dlJv7kNR5Igkrl9SblSUZm0/ZZoN7HVuabDLnliytbs5hd23E8B01Tya82wtiovPzggUskmEbeB80c3Pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKqWy1pJJGy/QKWOgc6LSUReHTQFSHjGqwlCgaZeBRg=;
 b=BmfU9M/0Ht+mVep6lbffWz3acwLQxLuB9P7KTmN5YbaZmvie8gEzsNFtmn78pDR0kzUV/riM6VH9OiGFxg4YO7hcF15ayJVImdooQy7rd0cpzXJ+0v8QgPiGvlWZGany3GnOJJYtv8n/B9lUlnycdHc5jLM5VBmQI8F2fsjx4weTJjWvM1Ly5eyspZp0oU8GbkckdOhdrN8l5CyDohfxoBiGL5fznH3Kb1cIKiCDAFuPEqinOs/VBLYbQMSQppwEIy1nkFycZFU513VvXQeF02gmnmwYCcQ3RKg0Y6NBFOp8UnXI3fCQQ0v6gE69qg5U8WdPICP4IgZNrWqEO0cayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKqWy1pJJGy/QKWOgc6LSUReHTQFSHjGqwlCgaZeBRg=;
 b=2XeY1tsgWXM1eE1lk1k/kFrGPnt0Uv2yLAZM4SiVtai1lxGiE2V25qEwheU5TAeXbpKvl6zFwXk2YvyHTnN0V6A8DO3Eij6uD7QmaVfb2WHWfDW/AWKBB44fP+jusPsMXIpWTHXEfhKSRYdhJLrC8sH41uvFRHN5EPcdZSV8Xg4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1432.namprd12.prod.outlook.com
 (2603:10b6:903:44::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 04:21:12 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.021; Fri, 5 Nov 2021
 04:21:12 +0000
Date:   Fri, 5 Nov 2021 12:20:47 +0800
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
Message-ID: <YYSxH3PN70zeyNLX@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-7-ray.huang@amd.com>
 <012f60e6-af5a-5102-b35f-7b14ac9ad198@amd.com>
 <YYIzwuzoqXRscqif@hr-amd>
 <6e1831dc-9d7c-151c-ca83-594d249d6442@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1831dc-9d7c-151c-ca83-594d249d6442@amd.com>
X-ClientProxiedBy: HK2PR06CA0020.apcprd06.prod.outlook.com
 (2603:1096:202:2e::32) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR06CA0020.apcprd06.prod.outlook.com (2603:1096:202:2e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Fri, 5 Nov 2021 04:21:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a51882e-50a1-4617-742a-08d9a013b32f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1432:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14327A34A02F521BD59BCBB2EC8E9@CY4PR12MB1432.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+fZ2eldZ8hS0h+K7Cuv4mE3XIMAvZR77S+9nin1odp6+WTzYgI9pBnwP9chXCoy8+7QPuMUiWMfDiDdF29fbtocWA8WeEtoLKB5H/OGc5v4QPuytK6HckYT48iwo/G8+h1Inwz9UZcW38xlgMss8D1A6pJonf41a6n+nvO67Sv85/7qYobiZ04JfS+3E3KYrriYg8uRoxQrDgMe84NTrE+05xAAf5z0G5DfAl0k2fPd+5qgXJ8l74azsZ4kLVxz3jDef3CQHpHUitXpZ74IubFnz+09jgbQT/Bh+kGT3MJTZ1pOOVIVl3xcasa2yYwvu1leNs+XXKgfd8alpIr1/+B+XkbA57v3/0hF/RJQb6ncyuvev0k/05O1QuEORad1ZUeTcHntE86gG6mVNYpqqKgjgxFZKGQIcxl8uePsi6dNS6FtY0WEr+a6oqf9NHyV0Wp0fqFTeIKV62HDHegAXhNdtyMM2I6Unf+2TaIj2GGmgmYMoM+mfQ3/CPdD/jyqevQzfkAMvkenHAerwtM4M131J/l31cgzVR/I8Q2vXiApepHddWiCtKbFZzzAqt+1JWj8LswOIS4PZGkYsgytSVCtLXkNWtVdYRGmrYqI5QhTt1JUPoQgrpa4iwY4kwOmSIsx3nVMsGHlzaJBizCyoV8valo5b9JHQm2tEK/lp7Bs1zBgtkPE/GhD6ZQFSauxMxBW5Hgyf7wq7vC2VpI+mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(316002)(6666004)(53546011)(956004)(6636002)(33716001)(86362001)(7416002)(186003)(4326008)(6862004)(54906003)(38100700002)(508600001)(66946007)(83380400001)(55016002)(2906002)(26005)(66476007)(8936002)(9686003)(6496006)(66556008)(5660300002)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x6G7ynq054Pp0vHx1j698X80DCLq84JVLgR/Rz2QC5avkdxJ28R5daviHyQC?=
 =?us-ascii?Q?Fnn7RRjvQAIzI8nCHv5UBg9+XlZHbIh39HetDm1Ay8e8sWvb+VFeUxoFx095?=
 =?us-ascii?Q?/suz1aVP+yFuTMAPfThMNkjNgt4+RapWxeAM9UtwkzGa4NeTh67k9LI53FTJ?=
 =?us-ascii?Q?rsinTZ8dHSuIC/B5P2eysHix4OhAfr07f9FRI7ciizNT/EcVSk4dNpWyzmCc?=
 =?us-ascii?Q?9TCsB4rxUbbTQ60tCmWIasIJbCEaieWRQYi0NlNNK36L1untuCPtZ/BCRc4N?=
 =?us-ascii?Q?8UToLwCzCT0QdbozF3nbYOI8aibxwiFZj2moegXzkHrgtYJv+qzkDmYDh3/3?=
 =?us-ascii?Q?mHO78gt/hBor3WKItUEDlnF/Zg/E+dmEDk+kDqTWqcGgD1+mP2Z4mojYzIdI?=
 =?us-ascii?Q?j9IRMumSXl8bP+w4eUFZEpbXYqzls6AZfGA5H0QwElMCaO6LTm0/Pw4BeHvZ?=
 =?us-ascii?Q?hvcYf/f3DSz0+6M276eKs9j8lMuVHaTvPQUZd3Ukc7pzkSTQhqEEszvvmf0P?=
 =?us-ascii?Q?WpVc7liXe986MVttWLC1LJL6UtiyDK8ffgr1wZFlravCK0NLFV3rXkzYylTp?=
 =?us-ascii?Q?SbEVXMSOOlhlX4A734Dds6b/Z9vbs9kYHc5E3dpalGmLi31CLfazmWfl5tm4?=
 =?us-ascii?Q?ZT0WJNVQ3mEVFILjzHAOhSI6WN1f5WubyQATlb4CpB+jWW1KMA5/0cAvhgTV?=
 =?us-ascii?Q?Pg0GH6PqLz1ePEGYIqdUkDcyqRFIscOadcCKU4d2u6nOccwKqaBYzGXtgY18?=
 =?us-ascii?Q?qEfysWRWcD1Fs3HdyD//TmnXMWtTSNtbqkUFQjCWsKY6tBZShHgOIftJGGzC?=
 =?us-ascii?Q?hcPInnbIQeqXPolilNuIjOH5YNMmfBZNY0JYBrzDpXwLPbs7lDYRGOYcUE3k?=
 =?us-ascii?Q?3eHAx6k+2IT34BajvHNDFl23tNrz5LTU3wxY2EE1sRg9FWRqWHrB/4JEV7jF?=
 =?us-ascii?Q?QaLz7dnIMWKGlPB7qPltBmXsxee+OCr3qs+cOU+KEu1zWmahhsIRYdZ+LXjd?=
 =?us-ascii?Q?uoQ0SpUna/Gj8Fz5K32/m2tTIW9x4X7P4RoeaWq4iZx9YJ7A59EA545BOgmW?=
 =?us-ascii?Q?k9Jjm0p/n4F3w57E882qPzx1gSY2ebBDGO5Hu+Bu3gzma8eBtpZYX4lb01GL?=
 =?us-ascii?Q?LyJyOKew8NRuMoUvyPhtxZNVy7imqsOIogosp9NqpaK8SQATF4PEFRNxnlk4?=
 =?us-ascii?Q?cfwdl7QFjGJHqqAO4h2X/lWxe5pEg3W6sVM7dfZ5RmVweRTbaytWwGJV4rrC?=
 =?us-ascii?Q?Ja/vpTD0NXaDKqHMmfF8i9QmV/6HsuaysXvfLDP5pIvCvAYuaVAwwclcN+M0?=
 =?us-ascii?Q?gMJ03MZxpq0hbuElV+63R3A7RH6Jv5Z+xQtWt+9tOPxR646GhH0qFyhS6srL?=
 =?us-ascii?Q?52VGZttWqUErK4/Do9KoQw4LA/9GHZ5ADLOQooF6NT5k1UshdffAAXZqVQ2e?=
 =?us-ascii?Q?5s2SsdcuYSlOtGL2IdmenXLNnQ7xyAgcT2A2MNinzXE8zmLvfpWxP2azme/K?=
 =?us-ascii?Q?s8OWqWBAdV2TA7crijBD2YpNjMYBdueMEedKcOgMD8Tpx28qzTqz1si03icE?=
 =?us-ascii?Q?Cdb/B9gAecWXRQxm9VzZcBx84iv3wkhhYmYNPhdg73wQipn+JnXUWwWPKL73?=
 =?us-ascii?Q?6uFdgL64H7jSDMJGNvLBRUQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a51882e-50a1-4617-742a-08d9a013b32f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 04:21:12.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIpCUrvfUDOnWMuHP4vLYU5O3ogmztFyvajqZNLSf1hYcCeDuq3x8EPEifnWJnDq+nnotxTXogPuoHm3g7Nurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1432
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 04, 2021 at 11:10:59PM +0800, Fontenot, Nathan wrote:
> On 11/3/21 2:01 AM, Huang Rui wrote:
> 
> >>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> >>> new file mode 100644
> >>> index 000000000000..a400861c7fdc
> >>> --- /dev/null
> >>> +++ b/drivers/cpufreq/amd-pstate.c
> >>> @@ -0,0 +1,413 @@
> >>> +/*
> >>> + * amd-pstate.c - AMD Processor P-state Frequency Driver
> >>> + *
> >>> + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or
> >>> + * modify it under the terms of the GNU General Public License
> >>> + * as published by the Free Software Foundation; either version 2
> >>> + * of the License, or (at your option) any later version.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >>> + * GNU General Public License for more details.
> >>> + *
> >>> + * You should have received a copy of the GNU General Public License along with
> >>> + * this program; if not, write to the Free Software
> >>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
> >>
> >> You should use a SPDX license identifier instead of copying the GPL text
> >> in the file. See Documentation/process/license-rules.rst
> > 
> > The SPDX license identifier is an alternative way to instead of the common
> > way to express the license at the top comment of the file. Acutally it's
> > not mandatory, right?
> > 
> 
> It's not mandatory but I believe using SPDX identifiers is the preferred method.
> 

Yes, indeed, I will change this in V4.

> ...
> 
> >>> +static int __init amd_pstate_init(void)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> >>> +		return -ENODEV;
> >>> +
> >>> +	if (!acpi_cpc_valid()) {
> >>> +		pr_debug("%s, the _CPC object is not present in SBIOS\n",
> >>> +			 __func__);
> >>
> >> Do we need to print the function name here (and below)?
> > 
> > It's a soft reminder to tell the user where the message comes from.
> >
> 
> True, but you do define pr_fmt at the top of the file so users will know
> this is coming from the amd_pstate driver.
> 

Hmm, yes, will clean this in V4.

Thanks,
Ray
