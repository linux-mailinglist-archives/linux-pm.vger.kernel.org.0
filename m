Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D199945A187
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 12:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhKWLgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 06:36:19 -0500
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:25313
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229899AbhKWLgS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Nov 2021 06:36:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4gGCofTDtRTfO6+2ZJo9gff91l5ibEikUPyjOBEX+SvE8sg0KYo2N7daHPzbymX5YsSAr0jdiR5X1N8wTcLVgJroXyTEVs217cXNQVAw+sd8g2ozl3T0eixjHCZ3rDUPcvULd5K/BV3r50ru1UUVxXfsQDzUP9J72OLPB8MF9b6KMVdEWDyV1t67T+yQdZS6Np8JdLt5DTv5IScnA4oMNsd4owMM4HIXBpIHWYZ9sr/z5l81889zjlgO5BnMxtXjOPA3y41el+9lx3Cl5qZp8hULeGB3wYsE2TQr/A0Kwt4iWIDKp496Rqe0CzOJdoUd9Xe9UqGuKfZQVHgjuvfSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvTYdRhbPP+WfS1cJZmF1SAu5LmLLzEK98/QbUS5R28=;
 b=fYkdHRLqShJg50V3qF3gDHfwVmb6YKWSuGBm/2oPwRo6oMTtvlMvhbhdJIEJaeV+6q/CYPLEZ1M1mUr203myevUtBJ5bH89QGK5EbPPrfmK/FPakj3DdGEU63766YeYd4LRftea2DCl7G8xttgGjTx8tojoaZxIp30pgY7OlYASCA/q2wHLLAnp/TaLt4dE7rg9IQmcsJB/By9hszXgfT+HYCcHzBppU5TeYIm5/tedQysd9LfuCwpe2PYU1AVE+leJ08Q3783Av4a6uX7apkKKlkMHXAClMQFLFr2gXUN6/FGYCNuDu+acxAX6KcWT5Pi7QJ/Dy/5iDiQ1FKDOUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvTYdRhbPP+WfS1cJZmF1SAu5LmLLzEK98/QbUS5R28=;
 b=R6d0grXmezv1PP9ecT9fLXNAdS+G8g7V6Rs0K91LxxQ/pvzg7KuheSnk1/7jKCeoKAjE88VUuQmg1Nxm/K3/PQWErTYw52e4awZ8USV5T6JkScZVTThJLQu9aOGOcBE70BlwZU3wzAxWjteSBUJl5kDwnOsh6b0W4ZOrv3FwG1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB4982.namprd12.prod.outlook.com (2603:10b6:a03:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 11:33:08 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 11:33:08 +0000
Date:   Tue, 23 Nov 2021 19:32:43 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Linux PM list <linux-pm@vger.kernel.org>, Jinzhou.Su@amd.com,
        Xiaojian.Du@amd.com
Subject: Re: AMD Pstate
Message-ID: <YZzRW3pjIoJ4k4O4@hr-amd>
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
 <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
 <YZzN4Nc2tcclbVIO@hr-amd>
 <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
X-ClientProxiedBy: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR02CA0151.apcprd02.prod.outlook.com (2603:1096:201:1f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 11:33:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7e8269c-b584-4ca2-5b86-08d9ae750614
X-MS-TrafficTypeDiagnostic: BYAPR12MB4982:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4982898BCBA2A2E6633540C2EC609@BYAPR12MB4982.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xv9Lj43JJf1oKCYfESZmLAHMputb8HxmNYLppmvItscpyp4v05l5lNJgcV5ENqjRqRU6Jq4aabnwPUgPckooSgvPRgTvK5zWdcmIqApqPH2lsvRxb35h1jPCoRi4fUuszS1DDWJ5ypQUw9B8+OaxjoEO2rfTrp+py8S8JfUQi9sTqWxJk/zM1/nH8NDXOj7NuLmnnYA63DlFDKXJzDM8C8JJs3DnDBYYrMDF6ljm8BNaGeLoqVUVkl3/FWNwcWg+cXU0IXicllMaTR0r1aS8bWcQBjGn0GRJq9934nc8BpOZ8BCax20w8cnGTOv/Jg/PMP7JrmIW26WtEVhgZjV+jV9KSU4dof8sWAskqBVjaAV9tnNyl3XWJU5TLiiF0tE/WKu4Yx75cnisKDQt3PPwCubUPIP+BqntVvYFkvZ6a7j1Przz0O9yz6tNEX3k19egZxqacsSGstIvqwEmZRHJeEHkzHRxgM9isTTfeXFAG3CUWvSgDv7W8X9wK7fm+htI1Qo2TGyL72p/7g4qF8BdWmYVSO/Xr0zKU5v4QHa6rawTrkJ3O/KPY2izZRda8ZEy7IyxALweRITJQOLWj9cNNODviUCKrEEXeY2HigGY6KSdKgd/6cNv3fGMk3mmPTVO207eRx1mDkRu99tnnBjsu3dB77d7OxK0wbsJ4mHk36ZoMZjZBT3uZxU4dXmlx7Wabp0J8VsKeGDBu75LWPifSTn3ArZ+Kt3CycazqsnxrM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(3480700007)(956004)(8676002)(5660300002)(7116003)(966005)(38100700002)(2906002)(45080400002)(316002)(508600001)(66556008)(66476007)(83380400001)(26005)(8936002)(6666004)(66946007)(33716001)(186003)(6916009)(9686003)(6496006)(55016003)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2gPM4dArcGRFkdK0iDiVmNgwd0KkAocR3kYAC6nEtthE1qJSF9AxYwmuAl8?=
 =?us-ascii?Q?8oNYVNYgEL60nexhIoFcSySeSX8fg4rtTTbzuS7iGbcsbYXlEyaKGu8geshx?=
 =?us-ascii?Q?Tvm4rH9kv3pGo6aTPOT+bvR5SMTzb6ckeWyMZYr6y8JguMkU5onM76UMivZF?=
 =?us-ascii?Q?ZwOEKBZ3mSDcBY3yvLMJqQxqMs2z6c8MSdUYfD7IgCgwdS3lYLblrrzkWjKt?=
 =?us-ascii?Q?CAConnYizsSvdxAXkrA7d0WjHaUNbMYorXOQu4aQZU7UVNskNKIJLlA+DuD/?=
 =?us-ascii?Q?+sXBJo8H9ySEupn+FFJbtE5TbV75sfbtr+NeqDOMrdpTlFIV8vhDenyaC6Ei?=
 =?us-ascii?Q?T0PdqXaZNNkf8FTHCk+003iPhWiKQ6ospx0j264xpnSJPH4iCYKBVNPTGnzF?=
 =?us-ascii?Q?C+VbJOvaoyfvM+xSGg6U7Fo2ceNF7a4I7ghWFPubiQxLkOzh0//sN2f0hBYL?=
 =?us-ascii?Q?tbaJPy1MJ8JNepytmVqXgRBSHt6XWVzxYSBTpD7ybZJPFCYPo9K/yaR3fkHj?=
 =?us-ascii?Q?4Ynz6xAP5K+ByRSWDojpe/tab2ld2IniGghPtJMvp9s0/0cbk9ry9XQ/ZXlB?=
 =?us-ascii?Q?sLFDP3PB7TA0uakOL30zTEWDiZYz73fBrnwCYu/kEVAHLr+HtJq25A+3DGsk?=
 =?us-ascii?Q?7RnTCEuSBh+7wxQyNRKMYX7zYFIFkCl0/AeGz2ulmwICQi6LPyj0sn1zqBEq?=
 =?us-ascii?Q?RAsjzOwZ1D4Trr9NQHQeeo6TavpF3YjPQgeqGBbCfVwzKAQ5no3j0JHXw1sI?=
 =?us-ascii?Q?ACnbpvsj8qY0ZPG+0CkSRH7d0l7EfLqKkWfnI/s5GysqtpYTcZbttlrROVzK?=
 =?us-ascii?Q?9XSh3WezdrJVjKwZOLIWjLpYBH1A/eGvw7jX3zIVG4fQ/hEgCMscM480DJOf?=
 =?us-ascii?Q?4op+mXZO5iXU81S6fZPXBJ5kU09qUg4FdDF00srPPI9r5M92dURdPB4AyYqv?=
 =?us-ascii?Q?GYqBK8l1GU/rvFtkDuMiOcr3kTUNPkipey0tXbg0kvhnLvvQV7puNhOzesDO?=
 =?us-ascii?Q?tlxdnVWnFD5pcEmCtis9Zi3OPj6F54aMXfA8MaAbfXzlt/v9Qb98pAqBXAWR?=
 =?us-ascii?Q?pHAuS+UY+wEVx2Ad7pvHN9ORpi2Vcwh6XQMG5slrG0JDI21YJCiz4KHdJKCc?=
 =?us-ascii?Q?LHGygF2Du9ATeSQsouK7LyvCk6LixoWT2c+ljc0Roz4UOXCN42ioJLJCbtkW?=
 =?us-ascii?Q?nkPixFrrpkOd+TAOxzhNleatmH4ivLJccQ93ndpF9oqMxAtO40OKTcLAWpLG?=
 =?us-ascii?Q?Kj8w5zkyCBvhvK+hMBf1qUzySa/at8Rvgw/4bWPUrVNMVS4slw9NKrmjPA95?=
 =?us-ascii?Q?Jx9svKRX8Ougw1W7Svnf8MOXk1D34dTViGoNixVFx1Hsa1PVi7cE2TtM+FWn?=
 =?us-ascii?Q?3jUfoJZz6ZYnE2oEXF/MhnpByHcWFnW3RFekHDWNQh7e1aKPW99X9IL8JHFC?=
 =?us-ascii?Q?oSk1F2FPrZqzv1qt4DmLP1pLfpqVRC+GFH+KbE6t3q5VrBizUwhfwnh4dksg?=
 =?us-ascii?Q?0eyc0Q+zuijLNR5B5x4SeAfZRjJYnPnhif0lhiZS6pHxGdnDmEkEeOK23nMU?=
 =?us-ascii?Q?zFGOpT7kEs4qOBhFJb7wziwPibFWPzbddrVvGDzZ3iMweDqtSP5qN0jCaFz2?=
 =?us-ascii?Q?RaO+/fBCVVZuEEdfZMtPH2E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e8269c-b584-4ca2-5b86-08d9ae750614
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 11:33:08.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xD1If7p5u9wQVPNvQK7l/+Ch7sal9c7I2HO2DXW0XXlaOZBxhWoMyAsAdjtoateBSUPV/zHH6vbi/j1mbtI0+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4982
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 23, 2021 at 07:22:24PM +0800, Mike Lothian wrote:
> On Tue, 23 Nov 2021 at 11:18, Huang Rui <ray.huang@amd.com> wrote:
> >
> > On Tue, Nov 23, 2021 at 06:47:34PM +0800, Mike Lothian wrote:
> > > Hi again
> > >
> > > Do I need to enable something else for shedutil to work, I've tried
> > > with and without shared_mem? Compiling a kernel with -j16 has the freq
> > > stuck at 1GHz on all cores - ondemand works fine
> > >
> >
> > If you set the CONFIG_CPU_FREQ_GOV_SCHEDUTIL, then no more configurations.
> >
> > Did you use the V4 version?
> >
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frui%2Flinux.git%2Flog%2F%3Fh%3Damd-pstate-dev-v4&amp;data=04%7C01%7Cray.huang%40amd.com%7C3006dbf33ae54ffaa1aa08d9ae738d2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637732633874328299%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=L1H7yy9UCweIH9CaSYTrfo4DZUDok1wgQxjtNCNLC9g%3D&amp;reserved=0
> >
> > > That's on a AMD Ryzen 9 5900HX
> > >
> > > Also compiling with Clang-13 gives the following warnings:
> > >
> > > drivers/cpufreq/amd-pstate.c:257:6: warning: variable 'amd_des_perf'
> > > is used uninitialized whenever 'if' condition is false
> > > [-Wsometimes-uninitialized]
> > >
> > >         if (target_perf < capacity)
> > >
> > >             ^~~~~~~~~~~~~~~~~~~~~~
> > >
> > > drivers/cpufreq/amd-pstate.c:272:40: note: uninitialized use occurs here
> > >
> > >         amd_des_perf = clamp_t(unsigned long, amd_des_perf,
> > >
> > >                                               ^~~~~~~~~~~~
> >
> > Ah, miss one line. Thanks for the info. I will correct it.
> >
> > Thanks,
> > Ray
> >
> 
> Hi
> 
> Yes I used v4 and CONFIG_CPU_FREQ_GOV_SCHEDUTIL was set as the
> default, is there any other info that would be useful, I can switch
> back to schedutil from ondemand and collect for you
> 

> > > That's on a AMD Ryzen 9 5900HX

May I know the CPU family/model id? (you can dump it from lscpu)

But you may need to add "amd_pstate.shared_mem=1" in your grub to enable
the shared memory manually. Because we are debugging the performance issue
on shared memory solution, so it is disabled by default.

> > >         amd_des_perf = clamp_t(unsigned long, amd_des_perf,

It's not the V4's codes. I renamed this variate in the V4.

Thanks,
Ray
