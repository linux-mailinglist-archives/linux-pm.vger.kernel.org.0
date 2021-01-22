Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC530101F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 23:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbhAVWio (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 17:38:44 -0500
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:62720
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728179AbhAVTro (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 14:47:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqx21UQbV0pFwmZf8zdahOaE6K6kmaU7Ee+F+EGXXUcaNJrqal4XT0cC610wt7LhbsWu50J2sxJC3KZFK0AE2GKVholFzp1zt7IF7YDivtDTody2MH/gQvhGdQ2EQGyER1ZPTryyGBfoU4as1BeLBg+k47Qpbdj1vp9MsLcBz2AZH/cDjFgL9zvJ86zHACKNHDRLvcQlaF/mMLvmsCP/pgyzQ4qiYJgxGxIwiKTgTMO6vfqBPPTAYM1qpkB3c8/8X3Pg9eV8bHbnLSgd4JWDdwi4PFk6rsTIriF3L86sDItiOwHwlB9BBKYS6feUomUY2+zaCs5Sng7t/q7Iq/sVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MJmrtT+NPDroGPyYwLCxSzLJqCDAMHreiAnQ+sKdMg=;
 b=JkLgtKEJ9mZuOaSFUaDt1CpobMpXIxZdOQyOUGpo95IlQERbgS5gu8nNbk5BkKT70qItLBWQHPI0Jx/14UKEmTey0lMSItEUz8C4qXiwpAcc5tWzvqi0W6KB80cOyKd85zQKQ4LpUt6sp1jxhMjcZU0oyW14ainvKStovwR3jB0nx3QEviSuhETs+Cani+oT/LzXcTs4mDlmlWsn2RtWjDKgnMkDL7opUyDq0kkukVaZa+jDyMUEzQ4cQTGigtrtgFxRjiHseSZI6NGMuqSD5j+MLCofpn3Q/W1AQboVXp8OWBOD4bWKe4BaqobRbkipw01G+SrtbcwxWd9+IYMMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MJmrtT+NPDroGPyYwLCxSzLJqCDAMHreiAnQ+sKdMg=;
 b=q/ULrGHTaj8/ST6SUM0tRYBamol5TssKwJbG5wvF0y0Ht7pBZwQVFt+oQKzBI0ANGuSiY3nchqSSMu7mHpLOmQasssOT/I7WnTu91KyjBlyvwjwvYoZuI1bhTzfpNFxtNDWbGGBOO4lA63PUkNJVaNdzIrhbrqa/gEGTC9TFl1o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:46:15 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::a8fa:3299:8c02:430e]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::a8fa:3299:8c02:430e%7]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 19:46:15 +0000
Date:   Fri, 22 Jan 2021 20:46:07 +0100
From:   Robert Richter <rrichter@amd.com>
To:     Nathan Fontenot <nathan.fontenot@amd.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org, trenn@suse.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/8] cpupower: Updates and cleanup to support AMD Family
 0x19
Message-ID: <YAsrf1Cv70wl/Suv@rric.localdomain>
References: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161133705833.59625.6935511700675018185.stgit@ethanol01c7-host.amd.com>
X-Originating-IP: [31.208.27.44]
X-ClientProxiedBy: HE1PR0402CA0033.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::22) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.27.44) by HE1PR0402CA0033.eurprd04.prod.outlook.com (2603:10a6:7:7c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 19:46:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d332d4b7-b1aa-4c22-6033-08d8bf0e60f6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4580E6C76E530FA602C78A989CA09@DM6PR12MB4580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAKkoETORaDiz2BuqUel3mvDv3oWH209KpYbhTsXcfwZLMj0ZqivgUkaIWyoZPuNjAFYWS+VILqKph/FjDsQlA+Nnd+Vy9/5+DUwQobMq++l3UeG0mUi+7+ofqr5oSS1LSdaMTLCzJlRfHfsU/MckqxksHqkxlKBwwpY1BPi/T+ZWZF9QRue0U7f364NLOw+l/F3RFMT06+lpCKz0oMSDTm6LmG0Nl8C2KdJJYMMVWeAqyc3KYMVgSKCQsMtVbXWNGV3uElP6EXj6JUY2mLCthMgj5oAl593naaQFnFPgqoZMTnnWDBwEhdT7U3uyrdJYnFOQfn0ydwlIWNGVUgNfwWWFIzDVJF519yqHjBZGsL2ft/fPoy/YPZniD5Rq1fl+B9dFrOqPEzeNYq1TRy4lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(15650500001)(16526019)(6666004)(8676002)(2906002)(83380400001)(6506007)(956004)(6862004)(53546011)(6636002)(52116002)(5660300002)(4326008)(66946007)(66556008)(478600001)(66476007)(8936002)(316002)(26005)(186003)(55016002)(7696005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tObOle4btuUsOCC8fiFSFOR2wyPef1LSaUQre/IK/DI7sfD+IAaywrf/EiEQ?=
 =?us-ascii?Q?ZGdSxTkOXtWzJtpblN/xl4qK8oGEulsFSAucKn16mZoQu5JKIzgG3AqhbrAB?=
 =?us-ascii?Q?HNWF1fE7lQYs78MWH6Z7+z9yB1/w2ltKRnY1i75UxWDQO+bjytgTdEulIsQo?=
 =?us-ascii?Q?tO4xK5lAq5jcruG5+j9xf/veBaC4aJW2A6bnrjTr0cHYs873GeozgblZqVrL?=
 =?us-ascii?Q?bxaWpAv+fTYwNWGM9P4WcVd94d1P74s81BwPI1Vr6wLgmLVgqGZYgxLctaHu?=
 =?us-ascii?Q?qVKPpLOUtU0G5strZrZZP9IeojYx2JtzdzBPQ2Prd1gaM4l4Go6byEnjqS73?=
 =?us-ascii?Q?ftXS/34yLdIdJWFm1CS4eJ1mJjr2LGYx4WY6BeNshiCjF0L82vspSJd9ds1y?=
 =?us-ascii?Q?5M7qqZ59zOYtBL62w17EePs5lHCbeKpZdB82DsCK0X9aAxIPCz/CjEEVteq0?=
 =?us-ascii?Q?dhaqaFWvvUuCNiKTkkBDA5i34c2vCcy4P1aIjzZ+rLYvwVQ9YfdgvOfYAxN3?=
 =?us-ascii?Q?ewRloQz/yypKDnMrkGZfqmZTPshxYkeLYdfQGHf+Ha8aTfWUPwxe9gUSYfw0?=
 =?us-ascii?Q?/BN5wpZjlo7h/dR4HXvSf0BFyG/6bsSSyeGDyE38u4v4gE+GZ2P8a3lSJ9OO?=
 =?us-ascii?Q?xMe7CdIzWqQOpUMiuMdPfiPFQeubeSm9+dOEQaD6SJWHNNMJiBzxU6gjj3bU?=
 =?us-ascii?Q?sPXvqJLVxW5/wHtZs9abcw6YGTan2ZjUSLiBxy4SztP/MUmJblB8QnwVzvn9?=
 =?us-ascii?Q?7G8xg0TH47Fu4bZvG1/1ULU7mq6OJVT1zFH6JdT3QNtAY2f/IB1FR/4lOxSg?=
 =?us-ascii?Q?V1XhOzBK/X62Qjnlnojd8KS6VGrGBDC2YkqiM1TA1U0DaqSGScA5Wt4SgR6S?=
 =?us-ascii?Q?5x6uL4F+6N2Rux88ZLc3uEaw42E2dBJbJzm7rwZfbet8ZRjbZ2Y4D1+gZuxB?=
 =?us-ascii?Q?o0gkKAEj529pC4R7UjgfXep105QGBDQW4SSc0TUucNc8jB07HRcWLRyN98e/?=
 =?us-ascii?Q?mSHsvw2YgbDfPkXg1B4UlIiYU3dzOVNwX8bisvLW43amJXcH6y5RZn6/WAdF?=
 =?us-ascii?Q?aXoQC03q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d332d4b7-b1aa-4c22-6033-08d8bf0e60f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 19:46:15.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFfEJKZ3gJ2olDpkIutHViTD0VX3sPmQ3B+ej2Wwi1u7valem3q0jg5lwkCR+GRgufW9jRg6l4/dr8c5KWcj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22.01.21 11:38:28, Nathan Fontenot wrote:
> Updates to the cpupower command to add support for AMD family 0x19
> and cleanup the code to remove many of the family checks to hopefully
> make any future family updates easier.
> 
> The first couple of patches are simple updates to rename the structs
> in the msr_pstate union to better reflect current support and correcting
> the name of the CPUPOWER_CAP_AMD_CPB cpuid cap flag.
> 
> Patches 3, 5, and 8 update the family checks to either replace
> them with a new cpuid cap flag based off of cpuid checks or check for
> family >= 0x17 where removing the direct family check isn't possible.
> 
> The reamianing patches are cleanups to remove unneeded extra enabled bit
> checking, remove passing no longer used variables, and remove unused
> variables in decode_pstates().
> 
> ---
> 
> Nathan Fontenot (7):
>       cpupower: Update msr_pstate union struct naming
>       cpupower: Add CPUPOWER_CAP_AMD_HW_PSTATE cpuid caps flag
>       cpupower: Remove unused pscur variable.
>       cpupower: Update family checks when decoding HW pstates
>       cpupower: Condense pstate enabled bit checks in decode_pstates()
>       cpupower: Remove family arg to decode_pstates()
>       cpupower: Add cpuid cap flag for MSR_AMD_HWCR support
> 
> Robert Richter (1):
>       cpupower: Correct macro name for CPB caps flag

For the whole series:

Reviewed-by: Robert Richter <rrichter@amd.com>
