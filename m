Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C794670B2
	for <lists+linux-pm@lfdr.de>; Fri,  3 Dec 2021 04:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhLCDa6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 22:30:58 -0500
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:54689
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236794AbhLCDa5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Dec 2021 22:30:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AivV80p2kZz1u8crKRuqUS7+3uM+weMyMoV2KRp1xKQIjUhpAdmAPFGO75beqWybpNlgT5r5UmXNPycS3Go9Wo9/+K5EUvYuORh9U4Xtv2hBAkuPU4pv7HotCLFa5rgcKxtn6gHOdptZfDXaj5ih8Su0CdGgRGDxxz091j3NCEGBvGFGWV5li3Aw/9uuU+AQssS81c0klFoejYEyQgbWQ6cOUaP7CMdYjEyVgSg/SuU9NSsueHmlMMSh8aiH2lxtNNM4tjwjZuqZ5w+CeOvUeGKS/u6t0/ThSrswBPaoVlxSGbmDO+lPVk4ZxQ2UOjj45Apf+ox9tR/YrSDHLZrMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB/25aBw7dqzHS4M1JzJ+88fR0Sxls39P9Q8oW+QnZs=;
 b=Kuqk9Pnpw7jAc1uhKh76ZOGAOLE0Gz9sHIwbU4CeXBqKmZimS1dpgcGMFHhk86bAzXh0xa/gCqXqKOTbpMgyesjeCzYpv3WYmLxSM77Qcz+qmfnBtqBwibVT0fQA9iLAohoPZjL7jjh66smNLy0xAAiWPOkJyti27eMiElueYYIiWlYExHjgKqmA5tBxi5vuZo8M2/aLnujHga5JOFuY3hkkqC2YAkSqXvMclQ2uowDEyOTG/p6ui+QGTAVB/C+fja8EdftZ8AE48XJF6M6wh6+6uQ7hodWxwrSzFTA23o3rEyQh08Hc/5pkgcsDilYeGW6O+rEhpsRF6yGoQqTqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB/25aBw7dqzHS4M1JzJ+88fR0Sxls39P9Q8oW+QnZs=;
 b=krRsymNVyYsJu3cfxZu8pD5w2H3199BT8LPFGmBQ6M/jM2N5FtJ3iVm+pd8fakDr5cmJk5eoylWBckqntx8YG9yGNRVCbNjxjiMrJCEjZEp074IHZ0RaGZNzklY4sp0rMv+/B8fjCldlsthJ+4UrB5RlzyIeIYC3U7e71GRJmH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 03:27:32 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 03:27:32 +0000
Date:   Fri, 3 Dec 2021 11:27:11 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: AMD Pstate
Message-ID: <YamOj5ica/GY82gu@amd.com>
References: <CAHbf0-HnJzS7+DaX5o2v4bruVRgpSynDeUvSBhrZnn0NYGkRRw@mail.gmail.com>
 <YZ22dYQ8dgQTwqnh@amd.com>
 <CAHbf0-FnFpkmZ2bkfS2S=Cw_RLbK1y7eSHySAFGVecs+t+-aVg@mail.gmail.com>
 <CAHbf0-F2v_tziWORHFkAOBS0oRK15XcPZpTkDbxsOp4ibTX+wQ@mail.gmail.com>
 <DM4PR12MB513676A292976E478227E133F1639@DM4PR12MB5136.namprd12.prod.outlook.com>
 <CAHbf0-G7LEUuEtsh7XsK0Nv4xcKJQQbV9DAzUxxeJUvkhky9JA@mail.gmail.com>
 <YaYB6UoC1iqsNuJL@amd.com>
 <CAHbf0-EWVeD8xehHZc8ff-4vYbXC69z=kMf0_=RXJsHKG_2M7Q@mail.gmail.com>
 <YacbY0XD+p6d70Mj@amd.com>
 <CAHbf0-HBag=RBi_=FJ==0CGxsF456y3M13EvhtGpsuxc=+AtEQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-HBag=RBi_=FJ==0CGxsF456y3M13EvhtGpsuxc=+AtEQ@mail.gmail.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from amd.com (165.204.134.251) by HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Fri, 3 Dec 2021 03:27:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc6c300-bf86-4ab6-7c78-08d9b60cd788
X-MS-TrafficTypeDiagnostic: BY5PR12MB4083:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4083412AC7798E2DCB115242EC6A9@BY5PR12MB4083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1p5ov26pYEWScrHnXboEMbS0/P89n+NaOFfG5JSlwybfpVUF6j9JkhBxdMJ7ATXO+oa+xaHQHowxo3Q1mLKjt2gAAglinCtVZa8vr5M/g9oNA4AMg9f2uWhoCk39mTWyJ9gldZdjccTg6zEWgEgWTajPqKveAxOyP3ECrN+uMONl55+M711EZOeO92c3xfRVhqaq0ve0d2V+pGEcoHGf3oSVVVTk1gTmiTtcg/cm/W+AsF1ldAp3OD8ZtoftTmE96KK1Gq656nY8fsDs6GfdRHFJIoAfadvj5jBdgfHWVt0IaELWyyjoOH9XVYf5xKFy4yj5zwYlK6rVvmChmfS1ZdCQNaWupUt+wI6a/4gzmZ0qAVYCeM0+9WwTq1NtR0edWTUMyhT2KGDULKPn+PtmrS8ndq1+OzkodJEFz6C235oJ1y8PZVDlguE1ErjLQ1XIPjGz1OzpmFIN4vWEeQ/oybVNq42iLHODYOx5lSmYDz+0ftHkfC4Myi48RVvgqfFmyVm1KJlv+6ZTuaTGrlts/zdMr93U+xOzOsrisrqVN9jYGWxsE97/VB96Wm1wvKo8aWrQyQlC4zHYl4hZ3kYzS0QEJkkK7gkYv76/WXwwXwbOi2hu8LshoWn3BKzRMN0hbrPIN47kiBk+CQOLnn3Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(5660300002)(7116003)(83380400001)(26005)(186003)(3480700007)(54906003)(7696005)(6916009)(508600001)(316002)(4744005)(66946007)(55016003)(66556008)(8936002)(6666004)(8676002)(8886007)(956004)(36756003)(66476007)(38100700002)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D09hF5g9jEGTF33Ww9STS11cnVMbpt1NHKI2oKkGATqa86lZlbaNiWckO5n/?=
 =?us-ascii?Q?o/LJUNead3xTkXZQRBCQkAeNHINr052pdcHEa1yFbBPCqHx0JsZfFOnGVQla?=
 =?us-ascii?Q?E4GGq3051hWb96TA6d0tnTxSnINZOa2XUKjORsYWOCB9gsc3mB9/qsqy3u0c?=
 =?us-ascii?Q?AmQxOV5e/OttM1tufAaQ9GuFBnebZtwUWAgTAkAyiv+WnY6p8jFXj8NPTW9D?=
 =?us-ascii?Q?bKjObUv3A4TrDIE9nj4AiGfe19wwl5jtqySL2hOBjVx6qEB1tMw4bLpfo4iB?=
 =?us-ascii?Q?Swt1d0OygH6vF2riezMPl/JAT1wmoi77DMxsaCnq6Lxy7UGQ9BUqcKFQQwMf?=
 =?us-ascii?Q?32Gw4tHXgzl4oyXu/pv3dlw6u7jARPocPiB/qhrgmLld0F/88dcVWWHjNrmm?=
 =?us-ascii?Q?IilBgswO/ofHnPrGy9Ob3KpAxj8lCjvSZHC2Q589p3fFzVLw4LCDBGu2EfbI?=
 =?us-ascii?Q?HCG1FoXRNcI0joROF8Cb2o6G9w03kfuOnwuXnmD9tnVppPgCnxeKMLFqnhI2?=
 =?us-ascii?Q?i868WgwwCsKN1ms3JhnGjbZSFbbA/2la1E6esuU+ZVJCDlboEmmmRfNNcN+k?=
 =?us-ascii?Q?w02MLLB775bx1p59Soxs+pgVVHuvPXmZI8OSuZg60Xu5Qb4tmVS8o9J2UwOv?=
 =?us-ascii?Q?PH5oiCeyLhPHX6An1YzeUG9ga8GOxbaTmhQ0Gm+UgJBs/8CT42bTqIePQSsA?=
 =?us-ascii?Q?aa2bg+lzsMC3LYc2+M0u+1uUTArM+GLHs7HC69444K4Xh8pqsyrnA+8+4STq?=
 =?us-ascii?Q?h4o85LwAQqyFERwYKLhNSocPqoeiXs4Pa32WigKE1CpziCIQU0JxHPTTDktU?=
 =?us-ascii?Q?XwDdTAJZjN1/BgKS2yMiDJIAqmyN1b1NPhTQhlFt+EtFYrqo7Ildrtn/SKBw?=
 =?us-ascii?Q?GUnDSYu6tSWmOwX79XCSqm1fNgFp1WyuFod4on4htaKoJqduQkwNL/+eAzlF?=
 =?us-ascii?Q?nu2idGSJ4i0ViGa8ze2EIVSP/V2F8rL5isAlkR2DgaEdUnpomZ4nXRaT1ZXW?=
 =?us-ascii?Q?bcCU1K+PRPcA3UVUJ1LX1IyobC3DEgjBrEVSyEZodnp+OZ75rZiytNoaCKJ0?=
 =?us-ascii?Q?6/VKz91elA/gZlXRaSP0fc4kmJDhxHZRagDb6PtFYdNJrwnSGmd9jFWRLzgP?=
 =?us-ascii?Q?XxFwhAtG1/DqvQ8v/Pq8pbEm4Zz/ye+cObsLRPFDwN68NcT8YyLiJw63ROC+?=
 =?us-ascii?Q?By2n64AGjunbkC/IkFZnfc6a0Yo4JwXvt+0Evgi4OqU+WEdPy6PSlBwKiAOG?=
 =?us-ascii?Q?pF4yCf2BT9yPlwAOxAYIU6QODs/2pDdxvWflcaRGgzopsjakyBzSPCjGp2rZ?=
 =?us-ascii?Q?YJVCsAQNmyLZviS5VOoN4H0R91rLnXLowGSwX9k3bQVHC6p/vTOrGhV3W1NF?=
 =?us-ascii?Q?bvL6RgJpuhfRTwEPEv/yQBiQw8fx9Re9RS6J2C1vDlkNGwsmGlQ6LzbNNxRp?=
 =?us-ascii?Q?epqjaUaT4HmE7u7FTkSfFxQoko3QEc1mTSmGaBcwWXMl2aeoCe7+r6vhjqB5?=
 =?us-ascii?Q?x7h7dLvqCohR8iKYO5rgAkOAKpuK7Nil2h7OG0Sbo8v3fjNj1OIWCHhoId6j?=
 =?us-ascii?Q?r/BYBlTJSG0JEIg2sz//8UiCe29a21vEtyXFMX7ZN8F64ZgxlCSxPtmVVVpt?=
 =?us-ascii?Q?750CWe7pABy9wmJUEH3P1VI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc6c300-bf86-4ab6-7c78-08d9b60cd788
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:27:32.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acEYYx6KgZEsWJucdHzK+aXygqMZxq17NBSc+YUktQptzPHzZESpEnE0WdlWJ9Gb1ajNpn40g+b3UQipH6pCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 03, 2021 at 09:08:14AM +0800, Mike Lothian wrote:
> On Wed, 1 Dec 2021 at 06:51, Huang Rui <ray.huang@amd.com> wrote:
> >
> > On Wed, Dec 01, 2021 at 01:40:52PM +0800, Mike Lothian wrote:
> > >    I've just tested v5 of the patchset, the warnings are gone, kconfig
> > >    looks good and shedutil seems to be behaving
> > >    Would it still be useful to get the above trace?
> >
> > Is the previous issue that the cpu clock stuck on 1 GHz still existed on
> > V5?
> >
> > Thanks,
> > Ray
> >
> 
>  Hi
> 
> No the issue appears to be resolved, schedutil is now going to the
> maximum frequency - it appears to be behaving now
> 

Good to hear that, thanks!

Ray
