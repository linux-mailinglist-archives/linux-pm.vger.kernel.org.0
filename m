Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E643656D8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 12:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhDTKuP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 06:50:15 -0400
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:19169
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234599AbhDTKtW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 06:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhaEe+JloVQOesAxuwY59SpokCKaIpNr1mf3nvH/q2pnK7JJUdfyy9LF5q8ATfzOMGJxGbjC+cE4znANbDZ7T7BcpE1FQYh6ncBYcMtzoL9qvVATnApSDJCeqhw8/Ra2YmznqFZ5n0TNiu/R5zTmUxpeFkezwgw+UeL0bDiTZOl7TlzzMJTGxYVGwpIJGYInntXUDVRRsGC6GG21MCAEp7NCCVOVpWtp13Aqvi3Zn8WI6EOOH6gWHxTgC0E2sqBzjSZ5GX5xu0toByAJNaDPURP6Z5wf3khlg1MCu+10Dx3cRn1df3eZH7HommvFJJycvvK8Y+fepuydvAIXV3EZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER3qysAMmxzZIiWk6CEPmofuCM/VX66/U4wE9BPi9Ss=;
 b=kiUAuHP2wuxorsnnEmWKEOH0L0qDA9p77WLnY76NeTGDOZM7E22fbXJ6AVEyXs6rugC3u+Y1AlmKxZKhLYU+C6ViTM90Q43TrNG33aBOVMlVK5mvojaRRm5zyvQ6h+vucixZpBJEsHrrsrFs6HeL16pwPLE/d+pI71p5J9GQhpaIf6HPPrHOK01eMD4PKOFpZXsNabJj4c+4sQD4UthqyLNsOTy/ApWQYcloU5k5bhz3OMwrn2A8m74xtlOr8XsqNsLXab940eDhANEVUdWWdHf6mgh5PTB1tWT5mxa1yjy+Ya0L6TfSNIQi61tjC5lxGnEUWBHz95H1l6NzrO8NZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER3qysAMmxzZIiWk6CEPmofuCM/VX66/U4wE9BPi9Ss=;
 b=ABBq/7GY/4QRyeAZe/WS21tnT4KmEcqMtWwSaRFPlMQ9NyfosFTkBGz2zYdZne6Jadm9G5koaJ0PNYCr0eMXxCiGiYmyZb4dGz1Ep0GVRGpqCdBkQxQodcQfi2ep3or7c219Ai3q4Lu5qhBy0ddnDjhtRDcuRH+V9tZ2OB9V038=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1245.namprd12.prod.outlook.com (2603:10b6:300:13::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 10:48:49 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 10:48:49 +0000
Date:   Tue, 20 Apr 2021 18:48:39 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Jason Bagavatsingham <jason.bagavatsingham@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86, sched: Fix the AMD CPPC maximum perf on some
 specific generations
Message-ID: <20210420104839.GC4046046@hr-amd>
References: <20210420080943.1045886-1-ray.huang@amd.com>
 <20210420082231.GE2326@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420082231.GE2326@zn.tnic>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:c8::20) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by HKAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:203:c8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Tue, 20 Apr 2021 10:48:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5447786-b82a-463b-df2f-08d903e9e0fa
X-MS-TrafficTypeDiagnostic: MWHPR12MB1245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12454BB94539B24D877B4B1EEC489@MWHPR12MB1245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8StT4CTbfV8+e41lxFeiC9v9xOlge3noRDZRmQSlcQv21RshVxN3oXfkomi1iiHnWmNW6c7qCOAdI+mnEJv6Bpwb6vzQk4BGKWar7GsmqF0pqsgSjeSJvsttoenuu4M9+qAgQ5VojBDcCzjLMl0y5VQRu7LkffEbV9dPWN0sJ9LgXovfBHmWQBTqC58mah9DWgcdyqouAEQzw2cOPtoXp4U1k3pgZRYiZa365kycD2XIl0VsosrHZRXMMxiqslRdaEYuIs75zVN78bVImXVMnsNzZVW0WrN2h2DWzPo+Glb5MbqG0DdDKSLZaoD0jy7t84IZNf5HK6qZUZauarxQ+tw6HyUD1/QrYplLbdsuH7o2wwZJ7ufzR5noRByWkEn493Sdx8lhVYsf1cXLORgLMqAxD/TvK9f+07CXmPGR7Dp8LNlj0TjJNdq5J03MlZ88yOKtzYMB+pibMiSAoxM1TJLcfXyx4m/Ng8gxp+va8sjPtYc9pXduJnfO5764++On5MUP0gfSAEvGTcZqg8Q7SZCZrgmfSgVrMeezEVhBIPmWZHNFaJI9dWmmtyK2P1LdCvQmDv8raN5BeOMrmmyg2QCFdzH4BUFJjYjjAANZAzKeGlWzGsLDYbMnq3jq1w1hkpfB5uawz8hw8WYPDXwwJfJv+qPWeFWg+OYQQQ6Z7bA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(16526019)(1076003)(478600001)(26005)(83380400001)(6496006)(186003)(38350700002)(33656002)(2906002)(86362001)(6666004)(33716001)(66946007)(52116002)(54906003)(38100700002)(956004)(66476007)(8676002)(55016002)(8936002)(9686003)(4326008)(6916009)(5660300002)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9cFLe+nlCgGE+ojzJz9oa9cJl7yKUtL5lAqdzosrmElG7eGRSOe1l0hk+Ilg?=
 =?us-ascii?Q?SuYnf/QWO+mc9wU3+DoMvC8OIjSPbQduTcIPyob9nvH+mPDRqqlTyNmTYyvG?=
 =?us-ascii?Q?IOlzt+VBeIT9v2mmSjefciIsD5EMsIL7/sjYesZF6fO2gmqXOTZ0QMd+vtHv?=
 =?us-ascii?Q?L12uE7M9W0kh3pf1uPg6p3un0sFODHWa9DTM2CCrTnA4JQsPCHZr6s68es1R?=
 =?us-ascii?Q?8K8qOIvKvGjROuc04NSXFojBuKpGg2AG/qdOGI4ajjJMY7pQjA0w/gs4Imug?=
 =?us-ascii?Q?bZYgulw7pcrnuNj6+sjE6ABq7htEYCEdEWRTHai/d7LbJdVQJUE0/HZ9jVGj?=
 =?us-ascii?Q?myBiRIid6nKy3EdcSufahf4qKeWGycLkHb5DTPhwg74OBc0gn8pTeMWqVL+M?=
 =?us-ascii?Q?8poJ+goG1t3RHgSyRQ7jabpJpxO0MSbahLd6BygKYopGvfXfsdBKIMzu4Qzc?=
 =?us-ascii?Q?WFq/iO4gusemCTpEHTs4lyHkRXnkW5azdRFlqLG6nzngr8sd5M8mvNL/B/Gf?=
 =?us-ascii?Q?3uG5+2ibm3CD1YnHwp95A/lHLnBsbpMd5TNdvmN41EUMwLUVxH0lbhrUCl5G?=
 =?us-ascii?Q?0Lkw98rjLsrh3E9JTsqbOWpNc2PDkWOHhtS9mM3gCwMpJ2q2c4BejhO+0Rlc?=
 =?us-ascii?Q?EG93zng//JrRLAQke83AsQiBta4FIjqsJV2TodZeoJ1sgwnV+pYj9kCUmag7?=
 =?us-ascii?Q?OudNaWMaR4W+7dTKdSoIv/6PF8y5GUGrxhyKFc5qPSf4D+lbyIsffVlLZjNu?=
 =?us-ascii?Q?gzW+y/tIvvbIfhhk/Hb777i7PmrV4qQO6teI+/zRRnyx6SCVKpihDhzoeH6v?=
 =?us-ascii?Q?ivCWWmqIno23vXLLfk/OMQrahtQDzQ3B0wQfOzXRG8MUgvv9tVG76+0AB8fy?=
 =?us-ascii?Q?uEexjpXEdUk7yzBLgeqhEWXpsGr80jpn3kXhigPWt5uuBRq5WOWZCognNVCP?=
 =?us-ascii?Q?6ImE7o3MX6WYahYTO+wqgycsPVNbIGk8KewyIRuUlxFyE+7sYtR/4VVEkLoo?=
 =?us-ascii?Q?W+vPmMepLtS7RxXnf+HFEEH5KM2xF7LuTgvyxt6ZP8V1C9vPVQAUSfadHJNR?=
 =?us-ascii?Q?J5spRwM6FHCq2KFlbhPPxBXuifmi0ZdJIlsxygqlpwHyRWcdAZ/fzwMfA8vW?=
 =?us-ascii?Q?lNHbLor2zGygK4FXwSiIMPrZcLzQrsic5WypdS9Nlf60VOW45OygwCHC/9Im?=
 =?us-ascii?Q?Ec5GCGAAq6wt9+YPvGhhF3dYLJF4KLUsjTzTnEkKEvWtc1dugd0u0Up59Vc9?=
 =?us-ascii?Q?q2fNagBru4iJSC3tEa/WECnBYAYvQgymcBnUsvoegGNYK1dk8tqOIJ192wgO?=
 =?us-ascii?Q?A06Cszqr00KAYghnqKID9Jcq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5447786-b82a-463b-df2f-08d903e9e0fa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 10:48:49.2334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV0A37hy/786nwHB/DH2gc0Fxj5z3WTqGVnIKHio0iiV/57d3mOtKbnmeDfURuPbW5OPTZMO+iyGpZ5rDcV8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1245
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 20, 2021 at 04:22:31PM +0800, Borislav Petkov wrote:
> On Tue, Apr 20, 2021 at 04:09:43PM +0800, Huang Rui wrote:
> > Some AMD Ryzen generations has different calculation method on maximum
> > perf. 255 is not for all asics, some specific generations used 166 as
> > the maximum perf. This patch is to fix the different maximum perf value
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.

Thanks and good to know, I will enhance the commit message in V2.

> 
> > of AMD CPPC.
> > 
> > Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
> > Fixes: 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to cover boost frequencies")
> > 
> > Reported-by: Jason Bagavatsingham <jason.bagavatsingham@gmail.com>
> > Tested-by: Jason Bagavatsingham <jason.bagavatsingham@gmail.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Nathan Fontenot <nathan.fontenot@amd.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: x86@kernel.org
> > ---
> >  arch/x86/kernel/smpboot.c      | 33 ++++++++++++++++++++++++++-
> >  drivers/cpufreq/acpi-cpufreq.c | 41 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 02813a7f3a7c..705bc5ceb1ea 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -2033,6 +2033,37 @@ static bool intel_set_max_freq_ratio(void)
> >  }
> >  
> >  #ifdef CONFIG_ACPI_CPPC_LIB
> > +static u64 amd_get_highest_perf(void)
> > +{
> 
> 	struct cpuinfo_x86 *c = &boot_cpu_data;
> 
> and then you can use "c" everywhere.
> 
> > +	u64 cppc_max_perf;
> 
> u64 for something which fits in a byte?
> 
> Also,
> 	max_perf = 255;
> 
> and you can remove the else and default branches below.

I aligned with highest_perf type in get_max_boost_ratio() funciton.

Will clean the "else" and "default" branches in V2.

> 
> > +
> > +	switch (boot_cpu_data.x86) {
> > +	case 0x17:
> > +		if ((boot_cpu_data.x86_model >= 0x30 &&
> > +		     boot_cpu_data.x86_model < 0x40) ||
> > +		    (boot_cpu_data.x86_model >= 0x70 &&
> > +		     boot_cpu_data.x86_model < 0x80))
> > +			cppc_max_perf = 166;
> > +		else
> > +			cppc_max_perf = 255;
> > +		break;
> > +	case 0x19:
> > +		if ((boot_cpu_data.x86_model >= 0x20 &&
> > +		     boot_cpu_data.x86_model < 0x30) ||
> > +		    (boot_cpu_data.x86_model >= 0x40 &&
> > +		     boot_cpu_data.x86_model < 0x70))
> > +			cppc_max_perf = 166;
> > +		else
> > +			cppc_max_perf = 255;
> > +		break;
> > +	default:
> > +		cppc_max_perf = 255;
> > +		break;
> > +	}
> > +
> > +	return cppc_max_perf;
> > +}
> 
> Why is this here and not in arch/x86/kernel/cpu/amd.c?

OK, I will modify to abstract this function in amd.c and then call it both
on smpboot and acpi-cpufreq.

> 
> > +
> >  static bool amd_set_max_freq_ratio(void)
> >  {
> >  	struct cppc_perf_caps perf_caps;
> 
> 
> 
> > @@ -2046,8 +2077,8 @@ static bool amd_set_max_freq_ratio(void)
> >  		return false;
> >  	}
> >  
> > -	highest_perf = perf_caps.highest_perf;
> >  	nominal_perf = perf_caps.nominal_perf;
> > +	highest_perf = amd_get_highest_perf();
> >  
> >  	if (!highest_perf || !nominal_perf) {
> >  		pr_debug("Could not retrieve highest or nominal performance\n");
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index d1bbc16fba4b..e5c03360db20 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -630,6 +630,44 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
> >  #endif
> >  
> >  #ifdef CONFIG_ACPI_CPPC_LIB
> > +
> > +static u64 get_amd_max_boost_ratio(unsigned int cpu, u64 nominal_perf)
> > +{
> > +	u64 boost_ratio, cppc_max_perf;
> > +
> > +	if (!nominal_perf)
> > +		return 0;
> > +
> > +	switch (boot_cpu_data.x86) {
> > +	case 0x17:
> > +		if ((boot_cpu_data.x86_model >= 0x30 &&
> > +		     boot_cpu_data.x86_model < 0x40) ||
> > +		    (boot_cpu_data.x86_model >= 0x70 &&
> > +		     boot_cpu_data.x86_model < 0x80))
> > +			cppc_max_perf = 166;
> > +		else
> > +			cppc_max_perf = 255;
> > +		break;
> > +	case 0x19:
> > +		if ((boot_cpu_data.x86_model >= 0x20 &&
> > +		     boot_cpu_data.x86_model < 0x30) ||
> > +		    (boot_cpu_data.x86_model >= 0x40 &&
> > +		     boot_cpu_data.x86_model < 0x70))
> > +			cppc_max_perf = 166;
> > +		else
> > +			cppc_max_perf = 255;
> > +		break;
> > +	default:
> > +		cppc_max_perf = 255;
> > +		break;
> 
> This chunk is repeated here. Why?
> 

Yes, I should abstract the funciton in amd.c and avoid the repeated
implementation.

Thanks,
Ray
