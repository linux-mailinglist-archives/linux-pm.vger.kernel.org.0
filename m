Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5644A52F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 04:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbhKIDLr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 22:11:47 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:8481
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242289AbhKIDLr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 22:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdkYc7EnpKxBLDbQKuHIgGbrgOz4ADCc311CODejPare2Ey/GUO7TLzcWomS89OFyimdW/IdcRHmC5UHkRLwVICHze3wHjml5J2LN6dg52jg6ZGSwZ87RvVc7yN3sN+YV6zO4Pa5UtszrabSHDfr0iYjwEi1qdWLzVfjdvZ6xYfQHnGtFi8A99qZ+j6oUeOSsLlutsFZWrE2cmKK0FEhWhcuXIKIY6UJhV9p1K9N0PGjHLh4udewI+6Ed+iSeeSnAuPFxhMx0z37pp90DZmFF1ej1M4qW7YEFXvDt5Q05WmwoMJANekHLg4MFxYw5pASF9Y/zvwNrypA/72ymmL7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/+2r2HSxVZY2Qp8LJrsNtgCTQhAZLrp8AJ8ZwId3Uo=;
 b=dQahrBgouwJOiKSuttdvKIMY3T5Mjl42HmMmBrNdOFqWDbkN1nABfBP/VI56R4F7LXHsk4C75wY5Ep/StdAfc6AieLG65vEFCMMc68hnaDOB/1UEtkZxgYZb8OgzuZa7iILJvErYnvR2LtSmYLGaGey55vWGcGi64L5emvaeGNQhHk89yNBvYqEm8+09zQ/6R7fJ4gO4T3BhIS3kn7fgsaGVrVDDCPf0311/DqXn3FhY+JoCy+ObTah8B8Squ2sTHhSi0ACrzqx3p2bVpkyJ/MzJJmiq97/j59y0j67Y4tjZ/gC4+ffoIfqfJv1xXXqZ9f0BgGcjBozte+vuDCvS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/+2r2HSxVZY2Qp8LJrsNtgCTQhAZLrp8AJ8ZwId3Uo=;
 b=lgI5EKJE+xHWM8+of3mgPM9iw/0+9F6p+GjKRYKQTkkAN+INf1Vlt8myjZH6WDTRIP408pD132oRjPHMe+kPVeB9wzFcAkKHkXGefgYI/rR7Fwamy4JNBpBIS2Ow0zIaaRkCGT6c5lrpRVSHJt01/eWpJCYiwhOzuQNUVggoqyk=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1864.namprd12.prod.outlook.com
 (2603:10b6:903:11c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 03:08:59 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 03:08:59 +0000
Date:   Tue, 9 Nov 2021 11:08:19 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 01/21] x86/cpufreatures: add AMD Collaborative
 Processor Performance Control feature flag
Message-ID: <YYnmI8C0sINmtNKF@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-2-ray.huang@amd.com>
 <YYZY5koNqNZD/Fio@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYZY5koNqNZD/Fio@zn.tnic>
X-ClientProxiedBy: SG2PR0302CA0003.apcprd03.prod.outlook.com
 (2603:1096:3:2::13) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by SG2PR0302CA0003.apcprd03.prod.outlook.com (2603:1096:3:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Tue, 9 Nov 2021 03:08:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0c68742-7302-4903-ca8c-08d9a32e45fc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1864:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1864062A018FB7ABDB5E1110EC929@CY4PR12MB1864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v636QOi3Lity95X1MBtG42GKrIZjPKsuyJ/sHB1Ub/ltNgm6/RRks7A7JEtDnM6v1fNoZZS3EyQREiqYjLMIocDXssp1OY9HgsWkeXwtKWKhLc4eNLcY6wIhrllor6GI6/ulVeotHxMT0Jq3ccCxI3BvshzhsG/nYfaw9PJb6/dMqxPh12laXaINgS8QFgZxYB9Ci3yZsGhncRZNOWX0x58I7WGxQecJ3gmYicqmG/o80V8CM72nFLm0FQWg61RAm+17xSGcmkxTzj2oEj1gzGnnhwROTaM8RGuL5ooBf1guck+X9L7Bn7ECvYdbnOpGsf1IJ8dMx0KwDtJhPTUhbUuLa08tMX4Dl0xvxqYT0Mh50TegS+F+i4HRHPxG/ME7P4DEGF8VpC3LN8OcuzH37VCmiycRCWPqvqOEoVbz0B2xzsEfh6govpQ/f2MqaoaZYTEu9IH+vQ8/uvVUC+lbKuxDd8S9aEJ8kTjrAaSSuTqame4GihX6x52wm8cD6SyEcgFs8iyBGPzQTEnqeiZYcchskxAqbVKQHI7hIxEy8YxZ1oKdumvRlnW7hkgteQSn+Hd0iczmC3DhjwgX9/J+v3eMiU0ASeIlP8f/QCjB7Y9gOtcd+hg9UZPtp39yO3FNpDBa5wRBJqr8mwwKTmSbDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(956004)(186003)(8676002)(33716001)(66476007)(66556008)(66946007)(38100700002)(6916009)(83380400001)(5660300002)(55016002)(4326008)(6666004)(508600001)(8936002)(6496006)(2906002)(86362001)(9686003)(54906003)(316002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EHUvXA5PFibYUkZD+IwCZZUAjbFkQsLcCv3U/w97509VQwwhaVnNI4ilBbje?=
 =?us-ascii?Q?nRgeUX6j7aNoDwQRWnDDhfG+fZ6EnX43ph1QMx1RdVVrRI+4DFkqIQWGFVO8?=
 =?us-ascii?Q?3vdIwr0hv4DrHu5iB8k/c0hKKF7+aYKe8UMjyyQqM2ZDgH+QBO2BXUzkh+SK?=
 =?us-ascii?Q?FydVQsu+8kqmHcymWskfqSX+ZX+6UEX02MwIro3F/9KQVFOPklB7XQkwIacA?=
 =?us-ascii?Q?IYhgDFAgSBMzSSIJptfZpf79hzktUn0ZY+HSlPXG4D2Y57zvModgOQdcXigp?=
 =?us-ascii?Q?vHv/QXrDn8ng5AURFyaRESpt9KZNf0hb1LdO7FB9NxhsUSE2V09AmvhRoBm0?=
 =?us-ascii?Q?qi8jAUoU7Y0DpzyvO2SYDehwzCxUwWVxwtzuddrnQYvBPzc95ZkOL0xE4b1x?=
 =?us-ascii?Q?NaSwuVZq+VGApM6iTfzOhIYpuii1S5wwkvCdr/ShUT4KsNtUs/QM0iKXNcDj?=
 =?us-ascii?Q?V+c3UJJeY19B0LjAYlO3oCkIb5kLplYwhCy7raLDlGcpgkLTBLbGrfpsNfMH?=
 =?us-ascii?Q?2KMQyEYhzme272pyYg8Xj351LhAVbuwOjQuV9rNDKTIhQdGVY4zf+Y04hDN3?=
 =?us-ascii?Q?aty25FOMR2ZV0EuqEMB2aPCzT83/WZj7STlwtnZfQS/Qbjr93bL1CZkhhTvt?=
 =?us-ascii?Q?1HJ/XpjH3Zs1QgXlpdGliBVbzEOq16gkj2cE294Wk4pezV/n7hOZzIRhgCXM?=
 =?us-ascii?Q?rbEqUC7UrWjzJROWMKcIe9i/MefiS2LWggauzCbyUtHCeKjQdaqjFxB/cvlF?=
 =?us-ascii?Q?3wmsJUTQKgXackHHyMtUkVgdDqkQZivKnLWSAsHvccAylGgOrr6o/k44bevF?=
 =?us-ascii?Q?PwmCC/VRfP+f6NBY4I8jn+SO/xhrFJ+M2S2ZWeApPc9h5Vcp8nD6YiOmvmFn?=
 =?us-ascii?Q?23i43+sa/gRZzpdbBndZ1CwvamquP/s0gw08YFGKDam1WYFu4dyY340hjuT3?=
 =?us-ascii?Q?TCJAyZfmCikyLbvuSbAy2Ub8cTda15F1fkQqnnAa7SD6VaIgZHMjTWcDPrLp?=
 =?us-ascii?Q?Jx0+yj9Sfklh8zJN+qMA9wWEtJKwjAa2SoMdNNnG8eGaw2N7tFd+fk2WgC3w?=
 =?us-ascii?Q?a8n/B3zMiUTRzNJE4KiYMwY67WegrcwOojOP+fa42kiDbR88pNtNWlaA1C4U?=
 =?us-ascii?Q?RWZwPd0BfbRCanFf/oC/VmnhENYHtTiu/EexUi1Vs1sluJpS1oclF2zrC3bv?=
 =?us-ascii?Q?Uc4xPCOMxIcVt2IElVm5EaeNH7M6jgLCcEVuJjln7AgdAQ2JblkHAnPRq0xE?=
 =?us-ascii?Q?Ukq3I03P8sxzMFKFxRCJl76W72Ra3LMkxbFQHTmjaC9WjumJwTgmy7+5LenU?=
 =?us-ascii?Q?vubr0XbevjeuNJHzSbxkDVIxrNgLuCj8Mxx1CJpCYF3H7m5pHeo1uUz4QZhR?=
 =?us-ascii?Q?L+oL+SMu6htyaGDct9Q6ZFwnozURIpDbx+2sLsMWBuQUI4BixBVGdaTTCOFY?=
 =?us-ascii?Q?BSV5bgJmiJ1ZNo3kFD/8rBlL9pvSVMqpQpMUh42aspyoLwXS4nb6hhOdKq+g?=
 =?us-ascii?Q?4QAhxaflpF39wY9VDbamkqSZ5PZoNeMHQiwdGMtM1gj6+LE68yDxlQjlnvnY?=
 =?us-ascii?Q?G3O46KKEQBuXHDBhOryVX21mseD+KcS83eU67kLpzndI1k6U4ncz3BpWmmjh?=
 =?us-ascii?Q?ybZauw4Wrm75Dz9VmYxykNU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c68742-7302-4903-ca8c-08d9a32e45fc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 03:08:59.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBOj3G0MH2XQxyCSXraantkNaWCSnzZmTO4QO6bpzSMqe2qKGERaOjFVPBw5wpQWovZta2unEAGb6GjAJVjs6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1864
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 06, 2021 at 06:28:54PM +0800, Borislav Petkov wrote:
> On Fri, Oct 29, 2021 at 09:02:21PM +0800, Huang Rui wrote:
> > Add Collaborative Processor Performance Control feature flag for AMD
> > processors.
> > 
> > This feature flag will be used on the following amd-pstate driver. The
> > amd-pstate driver has two approaches to implement the frequency control
> > behavior. That depends on the CPU hardware implementation. One is "Full
> > MSR Support" and another is "Shared Memory Support". The feature flag
> > indicates the current processors with "Full MSR Support".
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index d0ce5cfd3ac1..f23dc1abd485 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -313,6 +313,7 @@
> >  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
> >  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
> >  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> > +#define X86_FEATURE_AMD_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
> 
> I know I have acked this already but an Intel patchset made me look at
> this again: there's no need to have the vendor name in the feature name:
> 
> X86_FEATURE_CPPC
> 
> is perfectly fine.
> 

Fine. Will update it in V4.

Thanks,
Ray
