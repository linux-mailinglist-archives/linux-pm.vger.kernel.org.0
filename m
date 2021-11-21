Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7319D458367
	for <lists+linux-pm@lfdr.de>; Sun, 21 Nov 2021 13:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhKUMio (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Nov 2021 07:38:44 -0500
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:28769
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232729AbhKUMin (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Nov 2021 07:38:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfsWX1Eloa8dHUDflztaLE2JH/+LTanRxRjzdlGeMzOVWCnHoCEoMbcBuPaMLrDDIi4WLW4oMBGxSm4Wda1GpBv2SobB6bRvkCVcNBdt15jCBtA0cXvvR8KTfsoQrezNThhB9oqhdpvQ12EQd/5JjZSH9PBmm1Nw2tNuRw/ZNgQ1p4FXi/h8mIAZHhrl5vZool9U4Z0aGuEcQ/u7rSsPEUEa9JExGgnQWKkIoUqyCpllccEr//U/F/Mkmto/r80uSO+e6qFiDuEyM1dOQ+d7j1G8+LXSKKqGomJLWMJEmy7GG+UCre7OoOXIA2wIQGZdlb/rHk9uEkWqSgdxHxza5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLHGzd6MPqoFqBKU7UMkkwdlWOeP5YCvk4E8f54ev3k=;
 b=JCX9REuk2EibQyNif2BNfDNTvWrCZGfZDI0ANPZVz71UYsS5aESZLSGsg2v+7btZ1eNkl184WVg+iBpARrPYVP8VGKw7TPRWR1dVFkc8M/Z6SmSEHkdRD6yS59XVh7dWjpvd/5ZAObNLrDU9Yqk3wTlC9Mb2UCfN/T/su+7yzTwO4ybCwY+j730OhCqc0QIGfVWbclArvKwPkgLu6CNLdfjF88vj2YkKGoOpnzBtrnX147pXCrW5uc/egzvm9LHNeCXeZkbhlH+eLAM4dDXFLqg4hsjg4Y5qJ1m/SggjaTYoFX7oEWeN5R4xU77Yq+kAIbR+RE0ocjjISDJsuiHe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLHGzd6MPqoFqBKU7UMkkwdlWOeP5YCvk4E8f54ev3k=;
 b=tM2wxh6TS5GpTcLnm1UITbNuFxu62/8+cukpsu7sVrVZpzsRuaCvGxgkStZe83KjVfZzsNibBg/SWXCJyu+lsUZtOWXfsY1ueoVcPVRmgsOLkufEiefnN7HRZovnjlizri76RfY/YcdEzPNRLVuL6IvddhwlqV2SNmPqgAHmdkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB3047.namprd12.prod.outlook.com (2603:10b6:a03:d9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sun, 21 Nov
 2021 12:35:33 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 12:35:33 +0000
Date:   Sun, 21 Nov 2021 20:35:13 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: AMD Pstate
Message-ID: <YZo9AXFaf4PtYXH/@hr-amd>
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
 <YZoy/rm1R7K/tHz4@hr-amd>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZoy/rm1R7K/tHz4@hr-amd>
X-ClientProxiedBy: HK2PR0302CA0023.apcprd03.prod.outlook.com
 (2603:1096:202::33) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR0302CA0023.apcprd03.prod.outlook.com (2603:1096:202::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 12:35:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5259f155-d9c0-40e1-9f85-08d9aceb6961
X-MS-TrafficTypeDiagnostic: BYAPR12MB3047:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30470B3478624499D40589F3EC9E9@BYAPR12MB3047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SlF9wygpHFSbv1LzJnTnfzdz6U9bxLuYT4h1OvxQec+/lSJ8XftywNOVtEZfsomiPrH0HB+r8vh+XddvFz/AShT1NxDxWInTmETP0BZfqGOLFYEwoaAB0dtpHeHp383EBKSVZN8caQczRPKDr2cgM+9RjHqzUNOXUOkhBTNN6dtuk2WL6YIRLDkaTWK8iwCUE7wHNPe3axXhZOf7TI7AWgbr3qcHGwalauUBNvE7FvFKSxsTCjInMECuN+p2TsoVf7I4lgtUtZuVFEKT/h4f/A6zRgw1Ca5M9wcy6rUi0oS/MGLMqXJD9tbCrcWThoBo5NAIOww4Gu81JXwE7VvgnzeSb3vZYjaiRlVlcBObBh1N1Nk0Iusz57U4pkHroXMsWBengzD5rmzsjeYhSk96l7ZTmxaWmMnQRTENan2IqxZC3UmNJK1siCZ2aTzMNvQxKaz9x01MTPRUp5bNnDhlmwGCBA/FPD2jaKDxQ/UmFYmS/DgtUY5bEaOHlft1Z79VkSXdFT1MFoXdsu/jM3tchEEVBm5LEkPkTxmfFICseLzdBjTusPR1UwF/I1zA+cuDEGnCzuO5S4vDnf16PuDpn38m1KpbOQK3MryFYmzCEaH7CApdvyClzUtCr/LlQFGcpefJHkhOz70zWixnakyV6NQEKyN98w2AYG0B8/VHLwffVIsOq3WloHZrCJ0cSCj0DEwTl14ovsQ1R1tvbnZFvkpJEcX8xBLrIO94TxAex8MCKo8AU+9+LcYLGdMwogEFWWvE54/tl6Lq+J0z8JoQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(33716001)(186003)(508600001)(956004)(2906002)(86362001)(6916009)(83380400001)(55016002)(66476007)(8676002)(966005)(4326008)(8936002)(66946007)(45080400002)(6666004)(66556008)(6496006)(7116003)(26005)(9686003)(5660300002)(38100700002)(3480700007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5x291Yo/+2jm6PZGAjn6smZAruW3Jx+uUENL3rLLj6lzYUeBRg+dnr7WlC8?=
 =?us-ascii?Q?KxZC+gpx1sSoxWyqAE52aFHUHePbhUxWvxnI97ZTExv+G1Ewtwq8LWhYOOWz?=
 =?us-ascii?Q?iBnoO/Rueqw1ikTSpMclBROnWqPJl3VMzFoyqwJlQs33N3o8OhWAhSSn53Ae?=
 =?us-ascii?Q?rdJBjTgrq/RbBG2XEXArlHRWPFy+QQ+anoDdZMhXMGrAuUVzlJvlrPJEXX5h?=
 =?us-ascii?Q?Sm09BnhkSKJkLwJJ3YInT2svt9XVA6VMYL4XK+IBjhdD0LYH509KIuG3UyTa?=
 =?us-ascii?Q?g3CAWXp2qoL7rGoMJ/lmn+F9gwXl0ZAJcl58Fki6r32s2lxfmDT3oXi+2C98?=
 =?us-ascii?Q?C6ouXCCNkj2n1JF+9FA6ZGayuDIlMu5YgqJ+IJ4/tWJcQx4OnTqFTJ7OAKnB?=
 =?us-ascii?Q?dDtAVVghzBM3q4xzZ/1FbnCWDEH/sfkz03W7Q/dhojCxAQsbZQ+nmgyZAzF5?=
 =?us-ascii?Q?2hSgNhLGfZPTOpPVkbDFKTRAQLOQrvDY25UcyomPobR4VA8D9Rk9M2Vihf3P?=
 =?us-ascii?Q?jYj3yNWV9ku8LFpwo0zrFocm18Wp/fnFNBJ/rUhX23eyTAe93F+/BWB6wKyG?=
 =?us-ascii?Q?H+LGOc8D5tpZC7h7X0956du6GL4/hJf+g4rtW0vz9Ww5mIFCfe7YvQiM1szk?=
 =?us-ascii?Q?vCZIYM1RnnISuitvnK7nDFdUiOkeAAwBei67Xt+MQsBDhPw4vb5lbnu3vmmI?=
 =?us-ascii?Q?lp5f09u703cQBkp9janXZKtBS9ptPePs3VNmxiuM0+FNMYVWaLGuACW6U0Qq?=
 =?us-ascii?Q?yCoWrglf+zTfF3i1/cEbY5Shm0pbQLt/FJO5YAPLJJZNB+YbXc8H26IdDwtH?=
 =?us-ascii?Q?oMaIkr8FLoafVGKpgt4xFS3/EnPrGy9IbV/K57Q6kv390ag1mk/vKkSreXGp?=
 =?us-ascii?Q?tHphSvUpwZ8IHOH9A7ulgCtH5ybnWr9DYzdLXTgd1EuW/ebqRWnBC1Pkkak+?=
 =?us-ascii?Q?EnPDVKuQ99cjQUPqLdRDnKN+UJ9L8J9i4ejLD4JSAPSmXrl3IFvxRI8grqka?=
 =?us-ascii?Q?0GmRcRAVYDlyrSykyaDh+KkyVm/A87zi8U3icheuG7XHhw+AxrwkksT29A2p?=
 =?us-ascii?Q?ziO7xwegvmi8WTe3BZXYiM6fnH1KIHXXkF1QIFubWeo7vewK3INzPhiX81he?=
 =?us-ascii?Q?JQfhrxfdKMG6M7D/+OWTgOghGpornpReFx38w7CFI3NX3k0hk2copUuY6WTe?=
 =?us-ascii?Q?Q5S9W1g5A+lSf0jsvLAj3r8iZ5AajeAnTuna7G+FYJQ/cZtZ2vUmv95MmL8b?=
 =?us-ascii?Q?g3Pe2lfVXsboqCDdHmmcZcw2wx0pvN572taCVHoAiuWXMSTiYNGP1u/QpbuX?=
 =?us-ascii?Q?0/yo1q3r38v+cSKJdrT/amqJjHlrNRPtXf8mga220k0FBvTJO7rSY9eZvrQg?=
 =?us-ascii?Q?tQDO/X5Ly8FlahCjYxT8nEERe4VzYmYPqGBMUhs+K5rOiHGKBvFCrsUTSHjZ?=
 =?us-ascii?Q?8C9TBGfthBkTX5E+eyA1IyfDqq5yxnQ34h9szeAXDoCGon4peEBlcDGgxWyD?=
 =?us-ascii?Q?vld6LwVG5feYRxnzKpIyD5P/nh4rvH6bLqDHxJEEOZx+JwS9lGn6fvCwUNKc?=
 =?us-ascii?Q?RyCwd9l4crahyrCREcw7Aphaxg9hA7jsXak7RnaIK5DgeuIb/EjpBPf8eaDJ?=
 =?us-ascii?Q?3fSsz2NxNhZeFj0u5BIJUDU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5259f155-d9c0-40e1-9f85-08d9aceb6961
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 12:35:33.5948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLkKJ0tQ7QD28UkyZs8n8B5Yp2W+6bvOTg1WbAQhjL8v4cyLGX8BTjPEdQdDg8Gvp28yyuotXx2lF/ZRMHBgXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3047
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 21, 2021 at 07:52:30PM +0800, Huang Rui wrote:
> On Sun, Nov 21, 2021 at 06:37:56PM +0800, Mike Lothian wrote:
> > Hi
> > 
> > I'm not subscribed to the mailing list so apologies for emailing you directly
> > 
> > It looks like something isn't quite right with the kconfig selects
> > 
> > SCHED_MC_PRIO can't be enabled without CPU_SUP_INTEL
> > 
> 
> Yes, right. I missed the update in this version, sorry. This issue was
> actually reported from Stefano Picascia before in below history:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-kernel%2FYYqDhaXDIqJyjGjg%40hr-amd%2F&amp;data=04%7C01%7Cray.huang%40amd.com%7Cd921714980b241b6fbb208d9ace5794c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637730923851487352%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3wqjeuesO0bZ79G%2BOpQmyPlQ3sDvAWBV2RGydgWjfTY%3D&amp;reserved=0
> 
> I will correct it in V5. Thank you again to raise this problem!
> 

Just read back patches again. I had addressed the comment in V4:

https://lore.kernel.org/linux-pm/20211119103102.88124-7-ray.huang@amd.com/

Thanks,
Ray
