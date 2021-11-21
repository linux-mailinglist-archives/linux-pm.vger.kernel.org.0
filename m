Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37834458335
	for <lists+linux-pm@lfdr.de>; Sun, 21 Nov 2021 12:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhKUL4H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Nov 2021 06:56:07 -0500
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:22017
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233571AbhKUL4G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Nov 2021 06:56:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDKsBjynIDoO57Ri7nqSMzqVkS8CxnKr25XBqvS/1InDXJli5r2D/hIIp1InDDjNA9pWj7z3/fdj/jiYeji9p2hvDBXW57lIYH8YloIwPaWEU6VU1IUd1+mSCXdXwO8iZIgwsmlK+x1k1xjIVAufZI7B/QBzYya3lh7EsAKDjA3AjzX6N/nhZvrskT+tozO0VC8KVM5bQ3/2rrtukW9r+sc0vxaoNAuiUP4GbhTpiy+aH7NC9jmM/BrbeWhM1s61ob7kjJ8rJAdm+ltkrY+PYxOXc+q1sc9f3mDyN1cUmchMjlGJvaQ668+xIriO2KSIlkX4feDSYuDEMtucDG57sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKcJoa8njq+fqfmy+JLUrGl4k4k11E+/0G5W2n4rDWo=;
 b=TYMQSM+Kpdjc2q3T4lKOv3tHQ0zfNgeklfn97si+n75Lf8dlSj9uUv05l951DAYDVBWhKPM61nQvhS8ZapuDxan0MJeVGXLLxl/ZGeXBzPT4BegYw/wJeEpfDpY7xrBCWnz3/aF1JwZCyqHy6N1yi1cPuFcZThT6uTzTrivUOaarPo8tGgoj+rXH7skoPLM8H2zlCzzjl+Zp/2QMD9GzN/bNnRgjXvVfT5oGK2Qz1GxhlpzEQqNO4/AQYewBiBl4ihGXPvbHuLGNicejC545Nwno2Un9ZNC56mm516/l6AcLJEzObf58hkUjEueVi7Eea/xXrr7amYIR0lUcGKtDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKcJoa8njq+fqfmy+JLUrGl4k4k11E+/0G5W2n4rDWo=;
 b=mq92OJ145RQkX0jWpN+ii4q3UEgiRDit8J+CGVJbtw1/w40P4DxWVhiqpxUdNsU8OZqfSQUOL2727FJSam6fuhPM5KnpwGdB9P5uwdZ2+teY54wHLSPimmT7NmOUeNPEwX6bGZBebv8+hkbD6vJ9HuhKyhxFeB8kUUwcC+nuaiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB3350.namprd12.prod.outlook.com (2603:10b6:a03:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sun, 21 Nov
 2021 11:52:55 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 11:52:55 +0000
Date:   Sun, 21 Nov 2021 19:52:30 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: AMD Pstate
Message-ID: <YZoy/rm1R7K/tHz4@hr-amd>
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
X-ClientProxiedBy: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR02CA0171.apcprd02.prod.outlook.com (2603:1096:201:1f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 11:52:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5e2794e-77b2-4fc7-00a2-08d9ace5743e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3350EC3341DA661414C56B97EC9E9@BYAPR12MB3350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ejTNOJk1luH8jZ45GOTaBiH+zEaeUBMzNb8FmzMWip5L0I2/680NM8ntzVHEh8a17r6Iyc4272F77BXSge3H7FrtcS4vwdeNaV9qLocW9WQK1OmJRfy64cef6nv9yG39jR/FftoROl932xPYjKS5TRBhAf6ALgn9RxB7/EELdbagzDMand38nHdwWzPI32lHh7fD5xlEPlDOpRCmYEnSllyXTAVJi2yVnt29elSen40rvBvqGnNR1aMX3HI1qtDEdI0XBB90ABZWrEmz5jPFQqJK3+WbqSvnYstdsY3JTs5/r9Y/0kXwFqNpeqn+bt3/898XLq+37Y4cmQhdHB/Awqt8SbooeiDukP/XzKTrVes9ioRRVpW++NdVYhsxChBgs6B72+9dNxGjpoV5R7QYXP6oFAdoYfoxm7RXwzmvpEDCneHr4brAzHImF09yuFIDwHwvwVZkcSKfV9Dq/Bm9Du/jpnLGtA7klEpK37JiBzUe2zwJN3OINbfyEpijyuDJBr0hy6ejU45NoEJEkDJRBeXYSYMgC5+NGX0qtJKVHgEc7vllXjQxhfmtH9dlE7NvDIrwIr7ezLd52YmLgxWDicigLojiHsvJrU0zcgXtcR4V5l2CLfXKAoWF7agqbT26fpnU0XcmK3amqjUv+Lb+QSz7gYM75b14mUX4PI7GVa/hsLlJXWBuUt3e4d1cVSrmJJuCvbNnH4kfVtdKUWtqoBeNcc55iV+UGMLPID0EAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(956004)(4744005)(7116003)(5660300002)(8676002)(6916009)(2906002)(83380400001)(8936002)(33716001)(508600001)(86362001)(186003)(9686003)(26005)(6496006)(4326008)(38100700002)(3480700007)(66476007)(66556008)(6666004)(316002)(966005)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Az8zgv/o2DnW9pPLNI9Zecr407QIH7d1e7Rnfi24ffXIN6n3GUVCRjTfRQw5?=
 =?us-ascii?Q?5C0exrFXp5LCchoUU6Qa5xbKQ4G7PfDC1zFiSnAOcqZbOpcRgUAkd8dXW5ru?=
 =?us-ascii?Q?9iekDFEFesGLkTLdrGS0k8YP39mHRpZqHwRf6EOZCE39SCp8QyRTYw5oNrxl?=
 =?us-ascii?Q?TrDx7TNqED77qOFeVwcOpr0EAUOfwSqz9IkoKgWpm/jYOzLM0Pg02Fl0KQQX?=
 =?us-ascii?Q?BaTsgfD4nD6PbWxYcJevL9BwzsZkoncWxUoQYCThGgiN4wVGSP5fFgLNiRHQ?=
 =?us-ascii?Q?7y7nBLrCDG0x6ON6BKEOm7d9R+WoCf26Si1+zaWHuk+l757WNalwJ8UcbpNP?=
 =?us-ascii?Q?ZHUvV0lX1hxMqB/m2RdBVdV+eA8gZibPzmOf5aR7m1FeeZauy1F0pWBB2rk4?=
 =?us-ascii?Q?VjXH5vj35wMp9bezxKhvmIwjrYDdu27dWk98XAYKO17u14qa/L2thXGVPDYB?=
 =?us-ascii?Q?fFLF6iDOVwF0EXk24g4mgSR/UhQmwUfn7XTlb+1aHPB7sTn5GyzCUbaxD51s?=
 =?us-ascii?Q?X4MWi9qcIYF3qoUdtc/13fZF11iCgafABP3qAT2rnJB+4iP+XsZKXNomQLxu?=
 =?us-ascii?Q?BTGvpIPZadRtFkoUQR8WGyMao94O8NfFO7foycH6MBkeB0uF8nW28EpoafRq?=
 =?us-ascii?Q?OR7Lsakl6FopzQl6JEBGBqqm36a+sks87h4VEymo3rqcTyoxpVaK2LUdLrMx?=
 =?us-ascii?Q?dWDFUkfTj8qefgFYQt6L1aTbNgcmeKlBcls8zQ/+MvZVTochQrWI/QppfNzW?=
 =?us-ascii?Q?SwVkJ4JJ1xPpOGBhafqJDuhXzLFj4rIu2btIlVcvQOOzcb9RaJhbBITTzJnG?=
 =?us-ascii?Q?Q2Q2wkTRQB8haNUfnjL5+SUxeA2XH04D0TOOY/YQISJa7BdIC3AZXtWg/Vjc?=
 =?us-ascii?Q?TI134IT4+OrlSAQv21d93sImr6gYrJk0dVWyznF0bF192R1Y6tu3FPlY9yv0?=
 =?us-ascii?Q?VfYspnp2qdQ9W13KR2k3BVy6tbYqvh/8Xlu+3RvbahNZWTIpcIdrvacb/RtZ?=
 =?us-ascii?Q?Lh0SJ/upzVByUd59Lc8LmmY+noKiaIl8bSccDyqeenV9l4O0exim5o8zBGZh?=
 =?us-ascii?Q?xL3Vnm/dr/GLMI1MIgZ7+EiQf2EbnU4fuutZn/rGXvpLbSTpO9xkCf5G19JY?=
 =?us-ascii?Q?OygUPPqMXUWNVB+/9sZTISr1CqWxpohTCp5Jw0Hr1w0bW7lb3OwrN/rKuU5K?=
 =?us-ascii?Q?K8TXR4zBwGA5f1LUsMz1mdr2YMN5Ps4lEVg04RstN+mJNkGYtZcAu2/oUHtF?=
 =?us-ascii?Q?lJXh2x5t/B3VpQ+vGXlS1gGXAgNUBiaJSDST8K5/10tl6+SF3JK8LB1UY/mI?=
 =?us-ascii?Q?bWAOD0C3vUnazdS0StL2hyVALKuqBeLMXVfei1Rl2to5g7Oz7b8vK0C0AbC3?=
 =?us-ascii?Q?km3RrbbgNkdntRnrN3s0vTpCzPTUHM8LdYyFFSflnYbhTL8K/6NbP/QGOSwf?=
 =?us-ascii?Q?sialaxGItHNfcA2lTMWDBx0Kiftb6hidnIQDDP9jF7VLYawFXuXV9JLatmqo?=
 =?us-ascii?Q?1uQ3zJimToh/haAmumPUcTAuGUE+8ZJrmeCeRGgf/hWzc0CY6mDtmFGD7wzR?=
 =?us-ascii?Q?lC9Y0Y0Rnpk6d9ziDwWKPNk/DBgDp3qdVctHYknJ/xOzNjTX2PXvaRuits0r?=
 =?us-ascii?Q?8u2enFiyiOGxuku/QrpR3fw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e2794e-77b2-4fc7-00a2-08d9ace5743e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 11:52:54.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zw+X33J6wSG8ZhQSC/io45/oNLs4e4vVO8Qh6nPpvyTXsF+MgTsgJcDmLhXegs7B6O6vG/X0zCInjgtgJfjvDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 21, 2021 at 06:37:56PM +0800, Mike Lothian wrote:
> Hi
> 
> I'm not subscribed to the mailing list so apologies for emailing you directly
> 
> It looks like something isn't quite right with the kconfig selects
> 
> SCHED_MC_PRIO can't be enabled without CPU_SUP_INTEL
> 

Yes, right. I missed the update in this version, sorry. This issue was
actually reported from Stefano Picascia before in below history:

https://lore.kernel.org/linux-kernel/YYqDhaXDIqJyjGjg@hr-amd/

I will correct it in V5. Thank you again to raise this problem!

Thanks,
Ray
