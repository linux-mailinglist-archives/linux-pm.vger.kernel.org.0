Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3CA45A132
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhKWLV1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 06:21:27 -0500
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:10081
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232545AbhKWLV0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Nov 2021 06:21:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz7pfVnke2HPJekl38nX3RHM+OG+alF8zrvMrSJVLVHprcwu7FQpdoaKAn1jSpccm/5Jr2dAaj9jGPi4ybMEE4g+2gyQMQ9xF4YefygdApU14zjxOiSxnuZwdV2YRIC+lDLFvzVD5yacksp9xjNP/aRVLZknfZswnKoRdQQcIGOgC6hrGX8xlYaDiZcTzsRJUHaeUt+agZHK3gn2PA26efbly7udKX4R55GIC7s1DSEUbmOqAqAaMaBEi1TyKJEGJgjHI9v4NRt0ZehSoeDhhH0xhoCAzosEbkEX0DaMuXWLyLSxOnTdFqL4f4nReTkuDoOeFXEgj68OwATBLD2ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmQyDBjvFMVD+PYGiz473/DryX9MS1FVx5wTEb7Dn2o=;
 b=dy+kFPoDIEzVW9jJMI1RNab0sUs2T7q6UoOc7U3XWHep7Z5PjT9vCPPg9EECIK5g+/52qngyt+OpoIot1mAzNYFvxHsYj+CRMLfKLWlJn4Lrf3x6ijEt9lKyXhWXj+4Cm8UGoETrnrD+GjHykYHqkqzBwLE2oH6KCW1MIaqg0oRV7RNXtLgkTMcgvKLR6fnRJfT45MD6Cqa7FFjqCTwmqgrt6Nkv6nsyQexSBdgC0cqhdFl9NsYbUVLfpJyMAiKtnLeplFh1ntjTpT+Sgu1gRVKJYcLEJ02cF5nK2mKgCSibs5dm/kHmsuq1cdrlGtI+2TAL4Ve6IxFeERL6Dyd4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmQyDBjvFMVD+PYGiz473/DryX9MS1FVx5wTEb7Dn2o=;
 b=LjDGFSXvncF7vJD+u8MX/bh1ca/JhitnaWu+3truBEWxvYXjZAchIHy3fGn5bMCDZlG9buoCOL7D6dzy/+vfc0b7DLN6ZkBw3cnICvdlVyF6Q8h4E8SDrwRRZ9nTgl4e0Xm/2HGZZvfmUUJH3GHLLHDaXIox8osCgzEimJnXs6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB3016.namprd12.prod.outlook.com (2603:10b6:a03:dc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 23 Nov
 2021 11:18:16 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 11:18:16 +0000
Date:   Tue, 23 Nov 2021 19:17:52 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: AMD Pstate
Message-ID: <YZzN4Nc2tcclbVIO@hr-amd>
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
 <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR02CA0156.apcprd02.prod.outlook.com (2603:1096:201:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 11:18:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de8a4b7b-0d70-42a6-aea9-08d9ae72f22f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3016:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30162024F766C100A1C65829EC609@BYAPR12MB3016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wd2+HcAWva00o6GCzzNChuW+DJamv5//vKrb5l/ZHBM5YVIz6joB/glMNX8eiLXes2KNCy675tyMUaodQdquSGRtCb4sbNstU3goTtbd5fxQu05Vr95N1rhgjzu1BWCDNOtBzPNC70Xk42ZjcfgMFNH5+qSBXXp65gnl6zaSEmxz2vJwkLh4F5n/QlZ8EVd5J66nelVfjqPFFiONBmnNWj36rdrt/kFkxUUMReAQ+XwUzZUBhHqLNy4Nstor7ctzHiYRaMzRHo9qAPLQMl8CSOrS4DRwtpjiouVBwJiarUfHeddcqpNXxELK5R/a+voGl9EgaUpF2x0CbUdqxkxox4vQbL3cqUvJh7XRdE/CHsbvZL+HFmj4s7PrZ2GvpC3BgYwyjTvy1q8Dsh5G0EyTX/x+VZhwrpizEc5xdv/xMnLNHpFVRdBBInwO/72RaRytm5CMdyqvGmPabthLXc/8CFCoHfFw0VHb+KfCQf2qfWXqsPPZHX9mO9r0LNfHkuKsyXg695mnU3I26photfwEtA9QHjy61f5lU48Q4GaRB/8F9724OwKxRNcE9xv/VBaZpfnUWYe1e93+1qGnAsMCkDfSCeBgHUTX/lzipjuIDnu3VcVciQW7udMe1pckmqfbGgAhWGWU6opMJoiVwf0NkO7jXAA/71AB2JdFG8RbMM4ZVuQAGmM6GC6tCW9EJRcwfij0YqjOpGd3WAB0V3D92isfv24DqgYX9eOXJkzaSuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(316002)(966005)(66556008)(2906002)(38100700002)(8676002)(8936002)(9686003)(26005)(6916009)(55016003)(186003)(6666004)(6496006)(33716001)(3480700007)(508600001)(86362001)(7116003)(66946007)(5660300002)(4326008)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?UFRjMDNOT2h0dnNSUldBRHd1TGJTTFg2ZDZkVnlZVENjdDl1WWlMN3VDcUpj?=
 =?gb2312?B?SEk3YWJGSUE4Y09IeUpmQ002dlhGU1pidUJ6dnVMUWg2NTFUUDc5VkxtdTFo?=
 =?gb2312?B?OUlrNHJPcFBpVWxDb3A2SkpINVVVMjVlM3NJVDNkczEySnBlTmF6S0krcU94?=
 =?gb2312?B?cEFjNFQyVGlpcmoxd2FzVHlpWmtjaEg0YVFrc2tMV01JUEpLNnRFVzNZQS9G?=
 =?gb2312?B?RmNDMU5uSE10R2hYaWpmQWIybU5LZkhxbGFkbFVlVmZkOW1YMUd0dC9NMmVJ?=
 =?gb2312?B?VUE2UmN3Mkc3RkNTT3VCeW1RVGdOSmE2a25TcG51cXpRWStQZVltUjVIZ0ZB?=
 =?gb2312?B?RzdTSzUxMXZ2T29rdEdSOGt1aGVjdkRlcjJLZXNhVS9DdFVWbnJkcXJNMnhs?=
 =?gb2312?B?c1Z3MWxwbitvYzNiVmh0ako3M1ZPNnR4Wjl2anJrNEdDd1hQUUpFczdzYlB5?=
 =?gb2312?B?RUhsQkRMcjFYc1lFR0p6OEtZZ0lwYkd6QVNrYVAxa2VXZE1JZFo0QzU2UFll?=
 =?gb2312?B?aFc4cS9HMGszVVM4ZjN5K1lWbHlsMU1ONVlGYXkwdmJuREthUzl1TzhEQlBx?=
 =?gb2312?B?V2kzUGl0QW1zRUMvL1QzdzdyQlc1aUpndmQ0dmkvdk15bXlCSDB0ejlZVzFD?=
 =?gb2312?B?TlBqZlErRk9XbmpuOW9hQVZLNUVNVXBURHBKcEhvdm44YmZ1NlJBdm1oVzhy?=
 =?gb2312?B?cklUZ01JUGdOOTlKaE9RODZPcm9xSThBcWlib1J2WkxRTjI3d0xIbUliOVBV?=
 =?gb2312?B?c0JzNC9wNGhJQit3TTZZVTM2MXN5dHB5bXpsdHhocVVLRG5BRVIxWUxJa1FF?=
 =?gb2312?B?SndSeFBLeUU3aU4zSlg4MWV3SFlnTmY2QWFHVGdRRnRNR3h4QWlYaE1zdDRJ?=
 =?gb2312?B?Uk1yam9IZjR5TUt2M0d5elpMaE8ydUJOWTJPZXgwemtzdElWbW0yTFBvMVVS?=
 =?gb2312?B?eWRWaUpRallpZmpiVVNaNi9jSUkwN3RQN3BmTEdab2dXRHFaSk4vMFZHVGxJ?=
 =?gb2312?B?MUsva1dFWWRaOFJTYTR0cVFSWEFpNlkrdjJCMWU1VlpVNFd2UFZSNUxUaS9W?=
 =?gb2312?B?ZnFvTEtoeGVMMi9HSDZQd1BjdjBkMlBJTU02djI5bFB3bHhhU1lsL3F3K2Vs?=
 =?gb2312?B?UGptTGNZa05vVDRvTDZvTWJVRXVjSTllMU1DdzB0UEFtODdNWTRkSVA0R044?=
 =?gb2312?B?WnNDeU9nTjBSSjVpVlBoSEZqdStaRG5kVFhIVzIyY3cwTCtDRTBwcHNxb3lH?=
 =?gb2312?B?UWxuUURBNVllQ3g5Q1pzbms0SHlGODVXNUNWWGRpR25Xc0w0cmlGU0V3ODUz?=
 =?gb2312?B?Mk40MEROSXp6NUdmK3RGZFRJSmswVXNXa24wRGhsYWxrcWhLWmoxNGVUVkhT?=
 =?gb2312?B?VnFZNWtRcXhCVVpaQ2FPMFE4WGpyMm5Kd3YrSlZXTXl4VDZNVk8wSU9pbkE0?=
 =?gb2312?B?MnU5bm8vUHgvMlE3aUpKRXBZZ1FjTVBCSU94aGFEZUlZbnNhMFl4cWRDK2pl?=
 =?gb2312?B?MlFwV05ZNVNqUlYyS1pKVlFKam0vQ3REZmhNb1h3aUI0ZkxIR3ZKMVdqSWFO?=
 =?gb2312?B?T3llWlFtOThqa1hFdDVxbGl6QU9SMmFuMnNPb3NpdTlmVTR3TXpjSXRyM05n?=
 =?gb2312?B?ODcrRFJNTURzL2psYVF2aXNrVW15UTE3eGFhNDU2WUNOQmdWekVNRi9sekxw?=
 =?gb2312?B?eDdOQWtLY3l2N2lLOWZwNmJyUHJmdFl0N3d0RlI5ZUc1Rm1iLytYWW1ZNjJy?=
 =?gb2312?B?N2htWFRhL1Fva2M1b3Y5cjVsM0tkQ0ZqZTlqbERURlFPWWNON2lBSkVWR0xV?=
 =?gb2312?B?RXg2dDRocU5zSzkrdTlNZmJ0VUkwVHhpTEJjalJmWGdNVFZEei9XdVpRU0dy?=
 =?gb2312?B?U0hDMWVZWk1nVFowQnRhczNoaVBuWkVrZ1h5bDVzU2hPK3o2c3UrUVVtZWxQ?=
 =?gb2312?B?Wi9ta0sxVDY4NUFtS2QwU1MvLy8zZjE0TXVJNWk3MEovT3ZxVGJvMjFUaTJq?=
 =?gb2312?B?TUx1NHFURHR6Z0hqREhYWTRXNFl5RlZNRGs1ZklVMFZuTWRscHM3Qk9QRG05?=
 =?gb2312?B?b3pnVDJGUWZsSk1XcmlzTEJWR2xnUUpiZ1Q5S3FMM3dEQXZ5eG1wbEJ6YlpP?=
 =?gb2312?B?VVAwcDFaVERqVTBFU1lDcTJsWksyMFZYSXF0NGs2VVZmRUxUamMwWlVYRkY2?=
 =?gb2312?Q?/Bnhe0UwPh7upIRjNdlgZ8I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a4b7b-0d70-42a6-aea9-08d9ae72f22f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 11:18:16.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +npzrGPXa80gAUYvQalmkiwx6KNlrm0uyWWzgokH9qiUaI3LJVZDJan+5zM/CKayW28b3gbLtV5TYC67R+EifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3016
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 23, 2021 at 06:47:34PM +0800, Mike Lothian wrote:
> Hi again
> 
> Do I need to enable something else for shedutil to work, I've tried
> with and without shared_mem? Compiling a kernel with -j16 has the freq
> stuck at 1GHz on all cores - ondemand works fine
> 

If you set the CONFIG_CPU_FREQ_GOV_SCHEDUTIL, then no more configurations.

Did you use the V4 version?

https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4

> That's on a AMD Ryzen 9 5900HX
> 
> Also compiling with Clang-13 gives the following warnings:
> 
> drivers/cpufreq/amd-pstate.c:257:6: warning: variable 'amd_des_perf'
> is used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
> 
>         if (target_perf < capacity)
> 
>             ^~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/cpufreq/amd-pstate.c:272:40: note: uninitialized use occurs here
> 
>         amd_des_perf = clamp_t(unsigned long, amd_des_perf,
> 
>                                               ^~~~~~~~~~~~

Ah, miss one line. Thanks for the info. I will correct it.

Thanks,
Ray

> 
> ./include/linux/minmax.h:124:60: note: expanded from macro 'clamp_t'
> 
> #define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
> 
>                                                            ^~~
> 
> ./include/linux/minmax.h:112:48: note: expanded from macro 'max_t'
> 
> #define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)
> 
>                                                      ^
> 
> ./include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'
> 
>                 __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
> 
>                            ^
> 
> note: (skipping 1 expansions in backtrace; use
> -fmacro-backtrace-limit=0 to see all)
> 
> ./include/linux/minmax.h:104:48: note: expanded from macro 'min_t'
> 
> #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
> 
>                                                      ^
> 
> ./include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'
> 
>                 __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
> 
>                            ^
> 
> ./include/linux/minmax.h:31:25: note: expanded from macro '__cmp_once'
> 
>                 typeof(x) unique_x = (x);               \
> 
>                                       ^
> 
> drivers/cpufreq/amd-pstate.c:257:2: note: remove the 'if' if its
> condition is always true
> 
>         if (target_perf < capacity)
> 
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/cpufreq/amd-pstate.c:249:56: note: initialize the variable
> 'amd_des_perf' to silence this warning
> 
>         unsigned long amd_max_perf, amd_min_perf, amd_des_perf,
> 
>                                                               ^
> 
>                                                                = 0
> 
> On Sun, 21 Nov 2021 at 10:37, Mike Lothian <mike@fireburn.co.uk> wrote:
> >
> > Hi
> >
> > I'm not subscribed to the mailing list so apologies for emailing you directly
> >
> > It looks like something isn't quite right with the kconfig selects
> >
> > SCHED_MC_PRIO can't be enabled without CPU_SUP_INTEL
> >
> >
> >
> > ©¦ Symbol: X86_AMD_PSTATE [=y]
> >
> >                                                               ©¦
> >  ©¦ Type  : bool
> >
> >                                                                ©¦
> >  ©¦ Defined at drivers/cpufreq/Kconfig.x86:37
> >
> >                                                                ©¦
> >  ©¦   Prompt: AMD Processor P-State driver
> >
> >                                                                ©¦
> >  ©¦   Depends on: CPU_FREQ [=y] && X86 [=y]
> >
> >                                                                ©¦
> >  ©¦   Location:
> >
> >                                                                ©¦
> >  ©¦     Main menu
> >
> >                                                                ©¦
> >  ©¦       -> Power management and ACPI options
> >
> >                                                                ©¦
> >  ©¦         -> CPU Frequency scaling
> >
> >                                                                ©¦
> >  ©¦           -> CPU Frequency scaling (CPU_FREQ [=y])
> >
> >                                                                ©¦
> >  ©¦ Selects: ACPI_PROCESSOR [=y] && ACPI_CPPC_LIB [=n] &&
> > CPU_FREQ_GOV_SCHEDUTIL [=y]
> >
> >
> >
> > ©¦ Symbol: ACPI_CPPC_LIB [=n]
> >
> >                                                               ©¦
> >  ©¦ Type  : bool
> >
> >                                                                ©¦
> >  ©¦ Defined at drivers/acpi/Kconfig:268
> >
> >                                                                ©¦
> >  ©¦   Depends on: ACPI [=y] && ACPI_PROCESSOR [=y]
> >
> >                                                                ©¦
> >  ©¦ Selects: MAILBOX [=n] && PCC [=n]
> >
> >                                                                ©¦
> >  ©¦ Selected by [n]:
> >
> >                                                                ©¦
> >  ©¦   - X86_INTEL_PSTATE [=n] && CPU_FREQ [=y] && X86 [=y] && X86_64
> > [=y] && ACPI [=y] && SCHED_MC_PRIO [=n]
> >                                                                   ©¦
> >  ©¦   - X86_AMD_PSTATE [=y] && CPU_FREQ [=y] && X86 [=y] && X86_64 [=y]
> > && ACPI [=y] && SCHED_MC_PRIO [=n]
> >                                                                ©¦
> >  ©¦   - ACPI_CPPC_CPUFREQ [=n] && CPU_FREQ [=y] && (ARM || ARM64) &&
> > ACPI_PROCESSOR [=y]
> >
> >
> >
> > ©¦ Symbol: SCHED_MC_PRIO [=n]
> >
> >                                                               ©¦
> >  ©¦ Type  : bool
> >
> >                                                                ©¦
> >  ©¦ Defined at arch/x86/Kconfig:1029
> >
> >                                                                ©¦
> >  ©¦   Prompt: CPU core priorities scheduler support
> >
> >                                                                ©¦
> >  ©¦   Depends on: SCHED_MC [=y] && CPU_SUP_INTEL [=n]
> >
> >                                                                ©¦
> >  ©¦   Location:
> >
> >                                                                ©¦
> >  ©¦     Main menu
> >
> >                                                                ©¦
> >  ©¦       -> Processor type and features
> >
> >                                                                ©¦
> >  ©¦ (1)     -> Multi-core scheduler support (SCHED_MC [=y])
> >
> >                                                                ©¦
> >  ©¦ Selects: X86_INTEL_PSTATE [=n] && CPU_FREQ [=y]
> >
> >
> >
> > I've used this patch to work around the issue:
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 95dd1ee01546..bdfcf155f48e 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1028,8 +1028,8 @@ config SCHED_MC
> >
> > config SCHED_MC_PRIO
> >        bool "CPU core priorities scheduler support"
> > -       depends on SCHED_MC && CPU_SUP_INTEL
> > -       select X86_INTEL_PSTATE
> > +       depends on SCHED_MC && CPU_SUP_AMD
> > +       select X86_AMD_PSTATE
> >        select CPU_FREQ
> >        default y
> >        help
> >
> > Which gets things working here
