Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0246318B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Nov 2021 11:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhK3KyE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Nov 2021 05:54:04 -0500
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:17152
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235404AbhK3KyE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Nov 2021 05:54:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUrsn8oTCWTbb+z5qStS7/NoozdvNXvWYwdjRnsJjzINZkXPpSTCr9Vudoe4bTqBEqYUUHKVniylbKDFpK9M3paDE0qgsoGm0lcKqn/yLJStRZhluX1+Za2rF1jF3Zq3vNu4M2uleaMFRLfjuls0R3bGm8JOVLDHOdx8klS5bGUfPafRota+4ZwY1yc2/NXtKTO06DPgHNXRdX0HsGmGLpUu1SL10NqBiZwECye6AXVj35bxODV4qFyhfI27Djcq4uVnt71g1rn8EpX8UOcXYEaY3JAHY7MlbTjSmxILlcjQNfv64yHRzH1MPTxNZCffegaMP7yOu3OgtIWDVko+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hnGFKRMj251m+SbL9L1hDk0mi0IryZSzAhoVxlBTtw=;
 b=mL8J3LI+ry4SO02wbQAZgojTkXKNSmDt4CGGzCCUHb4pgbf4X+kLKtWPOJRvZuqEFZWZVJqB168NWPtkm3S/RAsJRqml8ozvCQtnugdbolvcHNvYhC7zUdpJGjFVslQqi28YmnUv/xBGrSSOr9kSouh2fSDXr4UaCfwCCsSZ91//h8kusElRolA6WY2123MJLgXxh2kf7cI3peKMs+aqPY4Whh8xR40z10X44dui1L7QAe9bVNWcwbShgJ+fH13EmXBDTbARrVEjU4hikMG+fvDsUkO7eV2EJIQ/UAcfHOFl9iIGEzyN04LA3QeyrBRxC6T8zwt/IEEP7LgjEBWLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hnGFKRMj251m+SbL9L1hDk0mi0IryZSzAhoVxlBTtw=;
 b=xA6PkZQheuH1pNmln1CYoeb8L38KztBndrAY46UykqTVTDHLzDqloMSHFGIHLjlyLc8y0TT13y19cxudxjBRdvbJyhvaBJj3kQi+7HGtd8XqOdqHH0WyXDApNE06qksxtjp17bc6hIF6GohBJLm3uEW/J9v/M8aLrVpee2iDziI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BYAPR12MB3157.namprd12.prod.outlook.com (2603:10b6:a03:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 10:50:42 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:50:42 +0000
Date:   Tue, 30 Nov 2021 18:50:17 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: AMD Pstate
Message-ID: <YaYB6UoC1iqsNuJL@amd.com>
References: <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
 <YZzN4Nc2tcclbVIO@hr-amd>
 <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
 <YZzRW3pjIoJ4k4O4@hr-amd>
 <CAHbf0-HnJzS7+DaX5o2v4bruVRgpSynDeUvSBhrZnn0NYGkRRw@mail.gmail.com>
 <YZ22dYQ8dgQTwqnh@amd.com>
 <CAHbf0-FnFpkmZ2bkfS2S=Cw_RLbK1y7eSHySAFGVecs+t+-aVg@mail.gmail.com>
 <CAHbf0-F2v_tziWORHFkAOBS0oRK15XcPZpTkDbxsOp4ibTX+wQ@mail.gmail.com>
 <DM4PR12MB513676A292976E478227E133F1639@DM4PR12MB5136.namprd12.prod.outlook.com>
 <CAHbf0-G7LEUuEtsh7XsK0Nv4xcKJQQbV9DAzUxxeJUvkhky9JA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-G7LEUuEtsh7XsK0Nv4xcKJQQbV9DAzUxxeJUvkhky9JA@mail.gmail.com>
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from amd.com (165.204.134.251) by HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 10:50:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a237b5a-f166-4b4a-96cf-08d9b3ef4127
X-MS-TrafficTypeDiagnostic: BYAPR12MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR12MB315784DADAF191E98B063AB0EC679@BYAPR12MB3157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtj+ofHKQ3YhOIinYp4rolzNeJiOmSKbxwcc9Rn5PSmT52p6JKe0feRGxyznA3hrxylf+svewdMAm129jjJmk5ZhvyHgJGr9f1uG5ak5i8cN/qDIBKzlYDKzMdlC6z3dNso2n1mau8h1fRIV5nlq1+R7tN/QNOLPOPJLRNMSfgHHt/4Gma8zlbKEkncTfNuZXwWE2hfIWzpgh5eFlklX5bnkaOCX7OFNWRGqA4wXt0Op1gPraTfa8oivtr+rXQtP0SSSr3syjC2YeJuLcQ4tvm2wRN3vTC5QbRtWrvEE5r9f4G1V9NfSHkGQZ/dpKH6fI3DLvnxztX/gAjJaxXyYzDNK+Da2tIRd0APuVkZ2WoT7Az41km9mO8TwqoOuqn6e3w4Sw7uD9zcQt7MlEqsdgL1yJPPfldEmL+AzRpK/espug3Jqi2HbROfWGe+l+M3/5SF9YaVXesEP2lhVvlIXmIPpoUtP2vakzLRKvpw1MBsmq69kgZGIx25vBIgsM0vHyCiYOA4BSR5tqfx/Hqa/vEbO8oNJDnqw4Ig6dDRewoB3I0a4qemny9TrNQcqFINto9krY9W5zEWhaTm29P5pYvxheE9WVXBJY2Gws1rbjoTaZYDCcdWBp1M/1u6MDz2IazXjJQKwxgAzmhV0I92FJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(2616005)(6916009)(54906003)(2906002)(83380400001)(36756003)(86362001)(316002)(38100700002)(508600001)(55016003)(7696005)(66946007)(8676002)(7116003)(66556008)(956004)(26005)(66476007)(6666004)(8936002)(186003)(8886007)(5660300002)(3480700007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epRnnv32ru6twc6JioS3JSqJUA18N16lka7Yalk/0GpKiV04tSjVABwU0Fp+?=
 =?us-ascii?Q?8UMpq6ko6NsVXiTIresPgXBCzC2pOp1lJg+aGVO2BJ/hQSAELMbURK4KcQGF?=
 =?us-ascii?Q?7aYf6D/QjPC1HX9bXYSw9lbAXEB5i9nE/+tv38hlM8L05eoINlQEtyq7IErf?=
 =?us-ascii?Q?BJ2xhUCpfaFHgVoYwHB7i++ITBjPnACmGa0QTFuwW8T80G6gaSv9FtrbhL1r?=
 =?us-ascii?Q?K4zMM+Q5sCLxci/ZY+FUwnhLpXMboZVDexIzPQaqkWYCaoyLi4Ydnv/4xoWi?=
 =?us-ascii?Q?lBIwy8NBJza1NlpuEfq6b40AWK2u4LK+Gi5ctXxW/j6tneprSbgvTsQiJKqG?=
 =?us-ascii?Q?xpjtWCsQ647ruvfF1cm3+2VAacsBJlysWM30eIQqHft2otXT21lmcJvJWl93?=
 =?us-ascii?Q?cxzpzSGtBncA5aFMyyzxL/r1Aq/TJbniXI9nRw1xBrn7+VJYVWWRKOdntg97?=
 =?us-ascii?Q?5KCI2HahdAvdPlrqpIefubLUTxctNSO3bAjHTYvnNKm9Of0RC40PCRp6FCoT?=
 =?us-ascii?Q?WqbYxdq/W0URiR98A7cwwET23A0B7Kxo0x6+TF1qMKDapZYMnUtqETt+rkE/?=
 =?us-ascii?Q?9v+L9LsLw+j8KC16Cu5inj5aNYPDDJnhUQ/jDOa1E1Zs09266bF9QocS/+P0?=
 =?us-ascii?Q?X/Ive7cRv9J+ptWFMV1jTSnORYa2j1tj+0hsLQKU4rVjV6QqOzBFv6R0XND1?=
 =?us-ascii?Q?Qdpw9w4djFDIn9f55YTDR85xSBPDFDEOYN7BOJ8dgRA3hQyDwl6MA7rRsdKd?=
 =?us-ascii?Q?3LxDRYGcafjLoo1OYcvfOLgRRV5lii3VMDyw5CvJckPVb5dKdQLCpYWPKaow?=
 =?us-ascii?Q?qGSmiXuJBOtjaKS0PbVeMjBlhOKgJn9uWrjzUPMaB0sHklWfQlSEFTo5swoV?=
 =?us-ascii?Q?w/I5vJQ9IUv/5PDH9WAk9V/o7DFxU1ZMfJ2ZFqS/A8rWP7PDDT2FY2n86kzJ?=
 =?us-ascii?Q?LJ/N6kCES8htksiEcSCHyw9LEJySwSz0oiJGtw02az1bEcxp0yXCNbXlKpB0?=
 =?us-ascii?Q?2IVh95fB00xE+KYnbqgVlu+Nk40rLlcOg6+OBmumaeq8GvlkXxKd8ZOzds3O?=
 =?us-ascii?Q?drQs6yHjLt63LAr2AHrf0J2QxRy38gm7b1+MFRgR+qiEa0L1t7dAqO5gtm2y?=
 =?us-ascii?Q?V1YcvuLm6ZpLbrd0K3EvImSWXOQHaEcpDIXnbn8Fpo8V12aEPd/58QsZ40SQ?=
 =?us-ascii?Q?XXFouE35ImLbhO9HAP3mu/Vrl0Bh4aTstI0vXxEoWf/xfEQacgFUVA7TNV9r?=
 =?us-ascii?Q?hIqwTdOTjHeTz6ZQR5IwDKWQJKpBcDnuFFII0PSDzjuBKibdpjb6lL3KeG8k?=
 =?us-ascii?Q?PmsRAE8rjek8tSlCsC4Zlp+a3hPkD6oPCoukwk1TLQ1EaO5wDTWV4f+bDpF/?=
 =?us-ascii?Q?cwGtz5uA2Rxqai1u/1CX/asGQp62YdB2WoM39g2hMVP3It6MoOSnVYiLhVBw?=
 =?us-ascii?Q?84xVFvqrrpaLmCIJlG4lPx4RBxD4H7g4hhBBvDN8oaXszhjUVhuDC8cO8P25?=
 =?us-ascii?Q?2BUIBBWTmgA3rJ5Fq2RNVKfSbepWkL2un3sPCl2YrMHK/mhoYuXGoTMPDBPh?=
 =?us-ascii?Q?Yq9Xb+p2qbuHFNH3d3JelEbYeLxsk9XH9zkoY86NyI+GsRaMEUN01To3dfek?=
 =?us-ascii?Q?B50/T6vHmCAwLtvdZdcksGQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a237b5a-f166-4b4a-96cf-08d9b3ef4127
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:50:42.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxXhohHnttfrJ80HsjeeTOUsXpN3iw7pYg8cuBLeKYw0PFeN7SCoso2EFuAGRXZ7g/8Phl/PGLnGcmoEokQ02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3157
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 26, 2021 at 09:24:43PM +0800, Mike Lothian wrote:
> So
> 
> 0 is my 6800M
> 
> VCE feature version: 0, firmware version: 0x00000000
> UVD feature version: 0, firmware version: 0x00000000
> MC feature version: 0, firmware version: 0x00000000
> ME feature version: 40, firmware version: 0x00000040
> PFP feature version: 40, firmware version: 0x00000058
> CE feature version: 40, firmware version: 0x00000024
> RLC feature version: 1, firmware version: 0x00000044
> RLC SRLC feature version: 0, firmware version: 0x00000000
> RLC SRLG feature version: 0, firmware version: 0x00000000
> RLC SRLS feature version: 0, firmware version: 0x00000000
> MEC feature version: 40, firmware version: 0x0000005c
> MEC2 feature version: 40, firmware version: 0x0000005c
> SOS feature version: 0, firmware version: 0x0022020a
> ASD feature version: 553648226, firmware version: 0x21000062
> TA XGMI feature version: 0x00000000, firmware version: 0x00000000
> TA RAS feature version: 0x00000000, firmware version: 0x00000000
> TA HDCP feature version: 0x00000000, firmware version: 0x17000024
> TA DTM feature version: 0x00000000, firmware version: 0x1200000b
> TA RAP feature version: 0x00000000, firmware version: 0x0700000e
> TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x00000000
> SMC feature version: 0, firmware version: 0x00412e00 (65.46.0)
> SDMA0 feature version: 52, firmware version: 0x00000045
> SDMA1 feature version: 52, firmware version: 0x00000045
> VCN feature version: 0, firmware version: 0x02110001
> DMCU feature version: 0, firmware version: 0x00000000
> DMCUB feature version: 0, firmware version: 0x02020007
> TOC feature version: 0, firmware version: 0x00000000
> VBIOS version: SWBRT77321.001
> 
> And 1 is the onboard graphics for the 5900HX
> 
> VCE feature version: 0, firmware version: 0x00000000
> UVD feature version: 0, firmware version: 0x00000000
> MC feature version: 0, firmware version: 0x00000000
> ME feature version: 53, firmware version: 0x000000a6
> PFP feature version: 53, firmware version: 0x000000c0
> CE feature version: 53, firmware version: 0x0000004f
> RLC feature version: 1, firmware version: 0x0000003c
> RLC SRLC feature version: 1, firmware version: 0x00000001
> RLC SRLG feature version: 1, firmware version: 0x00000001
> RLC SRLS feature version: 1, firmware version: 0x00000001
> MEC feature version: 53, firmware version: 0x000001ce
> SOS feature version: 0, firmware version: 0x00000000
> ASD feature version: 0, firmware version: 0x21000064
> TA XGMI feature version: 0x00000000, firmware version: 0x00000000
> TA RAS feature version: 0x00000000, firmware version: 0x00000000
> TA HDCP feature version: 0x00000000, firmware version: 0x17000025
> TA DTM feature version: 0x00000000, firmware version: 0x1200000c
> TA RAP feature version: 0x00000000, firmware version: 0x00000000
> TA SECUREDISPLAY feature version: 0x00000000, firmware version: 0x00000000
> SMC feature version: 0, firmware version: 0x00402d00 (64.45.0)

Thanks for information. Could you please enable the trace event of
amd_pstate_perf before you run the test.

echo 1 > /sys/kernel/tracing/events/amd_cpu/enable

Then dump the traces with "cat /sys/kernel/debug/tracing/trace". We can
double confirm whether the amd-pstate driver program the correct
performance value in your processor.

Thanks,
Ray
