Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDB441649
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhKAJX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 05:23:59 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:48736
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232186AbhKAJXD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Nov 2021 05:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSfAcM591LvC0tcAACVZCKDXDqnpuOM2yK+y1hm+YF3nxciThfiXQg4iOPZ2Jguk+4uoyFarQNYOJljk0yRJNxv4MdykzVgKFEShsFEj9UO3TDi6+lwBkVyfes6Pb3C0vY+ilpiAqdt+Ts1lWoknuC76J1S7n8ZYJjP3W4IrH17IppcQA/TlnT3JSKgyVJxNOJzbcspLlubb3oPxvFzyVJ/oN+pH/uiV6fN2pzmPV6yF2lJvdrvJJycFaGS0JlKry2PxpCs6HbEeDRhyKsw/KPTkD7goOvUdIjLiwnTKU0HXtj4viJbvY++246D5mQn0a552EfR53EkSjFGeZjM1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpjweFOXf+8mDnKWBlzvuAh7F86V5SJosjeiRDDMv88=;
 b=W/IXy7TExqaEieeP5IPOAUdYXWU7U78rOZGfR5q2EeP9aJICBqJ3nlMdOdB6LKxag1pwsNaA2NlryCwZn6ILT62kdXT8f+7dZ8VpNhw1V+/CmLOVV4GF3GQVpZ6p6/IgaKOdBg2E+UeD8Xy0JDLHgo1MQ2WCK+qvQegVGv2f5F7vjrniQosAMzsBML19G4pT9Smr3Jrc9VfC6CakgPhCS2Cxwv9ZYxuABdK9gkw6WC12IZN/bLDOGd7d3LGhvulw6UXXS7CRcJk8zLXUgK/NjmbZb6WErwqBueGbmEdFJXIsmp3ILrwnDbIHmd//1pQ3TvRXSPeOsq1ZWRIbjC2Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpjweFOXf+8mDnKWBlzvuAh7F86V5SJosjeiRDDMv88=;
 b=IX5qEYYbtO/PADo3/0aRcNJOke3ser2YttOglFZ5uIKpNsZfEJnEJH8QagEvBxjaWqqarIDue5epc42GSoYPbHYxfL9Ybb4LpOYh367AHX/cUTAjKG6korFGUIIM+RQG1IClFdc5i+YxMvaNeBTRa5n5e3XAa5NoCyfrt2kSxXs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1848.namprd12.prod.outlook.com
 (2603:10b6:903:11d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 09:20:29 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 09:20:29 +0000
Date:   Mon, 1 Nov 2021 17:20:00 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 05/21] ACPI: CPPC: add cppc enable register function
Message-ID: <YX+xQGDr478esAEq@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-6-ray.huang@amd.com>
 <14fc11ed-1383-495c-f080-ade3f62493d6@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14fc11ed-1383-495c-f080-ade3f62493d6@amd.com>
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.2 via Frontend Transport; Mon, 1 Nov 2021 09:20:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d1fb8e0-77c6-4044-5594-08d99d18d884
X-MS-TrafficTypeDiagnostic: CY4PR12MB1848:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18489E1B0FF5BA5E89DBC18AEC8A9@CY4PR12MB1848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMkQfU9RBGh7AZCm+IAlz3tcyX9TIVvS1itNZNOGanQRAjj0Tl+59YgdrVf6/zOTSppOM0TVx8z06Tr5XR6gaHXgCLBRDbp8QT7BIHOs+HYBb9Gb4NhI/+5Zk55NEmd9zriD/Uyw+frHQhAGwpJHV8As2ExXHAyIv6W16sb6t+Xtc3FXpkGIZqS1/MO4DuEGMRfwHWvWDTsUG5WszFNM/Fq/GXsVTCxgyj7U7Y38WW7ZuTnbCWmha2dCO4JliDyoLyGuk1NHSKC6vbStKsiG4fEMbQXprv0iObTXVOayLcgK+XgEwW+kqeHQh+hC07FaR1VQfvuhBWdavwk6LcBBsfB5MPGUj+IqvI1eZw8qprFO26XHJsVlH7V2TNgFUfb8pHWb6VkY65vTXwVV6nqokJ8PVLZe3lwftl/B4r/0R5UnPm8KrvxSv7hr4OOhDvNZ0OAatu9cF9m6T0USEk6Gr1E7VxKVIBdnu/B0sLJskpk8MxJeFuBBNCgNW5OH9k8pkEcKU2B4q9L0d//WdbDTFYt75bf4Pee4vRR0hMEu0qnceV6anAQql8YIicVqym/7hCYjaaROezw00lvpcV944n9cTa9N8Q/vqNMGpdrxxAUQX6cpwYcu8CNIonxE5U1DLX/IJFJPzQTEF+AKH1U2t3tUA2PNNrGeCvJAE3WYiFVAOwxrsHa5NdS3kSdNgR49Ry7NMGh1nWEUYTf6zl+l5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(508600001)(6496006)(5660300002)(26005)(66556008)(66946007)(66476007)(86362001)(7416002)(8676002)(83380400001)(4326008)(6636002)(186003)(6666004)(956004)(6862004)(55016002)(316002)(54906003)(9686003)(33716001)(38100700002)(53546011)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/miZTywJZRNiJlmBfCxvX9VdFd5Ehvaze+18vC1g7cZwis31jMoPKkDbti3K?=
 =?us-ascii?Q?3ra4RJQx0WKfiLnIjOX3pP31aCJ/41YIr88E7mNBedxl/ovVQUENy2gQb7uD?=
 =?us-ascii?Q?WoDqEF0KTFxGealye+oQJxDN5dBfZOkloewDnEhUHafGKdk8pyOh3s8/Jk8x?=
 =?us-ascii?Q?FQZ0l+0RDtOekvnPEyVjcTLHK0YVbv0gtxFaCwYW9J0+TOYBfhimJSTwUABQ?=
 =?us-ascii?Q?Ji/qO50UxfEskcn7A/nU+ED8jZQfIXkPKR0P1Cfq+P5118G2l6p2PvxWdT0q?=
 =?us-ascii?Q?tVhZZ95Cmq9HCr69p77qcYgGqzjtqmwGIGpMXVrqZBsonXcxgzKhmJTxoykN?=
 =?us-ascii?Q?lrP2Qspj5AnmYM15JEVGeFrQDamymgTS+NxK4Oz9BjeA96roe5e59RkEsfsf?=
 =?us-ascii?Q?3POCzRaovRiNCBG+oVaF5OJSA6eNaW/SRa93BNObxfroNbet9BrRMZhGlmnD?=
 =?us-ascii?Q?M3BKaK+HcLTVZcH5+3uOMLrzE2VOrKs5otOdK3E0fuaWVnRfKkAWgy5AK+Kq?=
 =?us-ascii?Q?0+dVQ8qWMpKg1LlXRyyY2juIBVG818yM+Io217IQ3zwz6GT+c+wi1K5mjkWD?=
 =?us-ascii?Q?f4lEdRHxUBp0h3P8BkKU8Pi6eHADCa+WjXz+ypOBYzuz9APbQrKYoRtcZPNc?=
 =?us-ascii?Q?C3j8w9eUL1yAEaus0+8RAfgOvd3IKCygd4RZ+EmcJ/rSHEqAEM5vY97fh+Jv?=
 =?us-ascii?Q?ZedjDrEf8MaXXamEfLMtJmx+cEx4+CDn+00bXEid+vSlpk5hqdOQXAXdMtwI?=
 =?us-ascii?Q?g9kaQK60rr6LxqYHaup6tMf/A2s0mG9QY36R+BvpmR1r5cDBb9z6c2AtCjNR?=
 =?us-ascii?Q?t1kdVXxooPSfhi+Ag6bPK8wLIUghXgbvU1CkuEEaMUCFWThzxD13tmY/ITju?=
 =?us-ascii?Q?QY4U92SLQVGlEH1joRz4A9zNv9HBhZZi/sgSKXg/daPr9BiMIHoYWMvIyGic?=
 =?us-ascii?Q?F7IiduPP965X1imgKV0U8AEfdJ8+rUKTFNIu1FJgk1mftothJk4ZMUVwFh/d?=
 =?us-ascii?Q?7ka8Rums00Lq3ZL2IA5kCqoR/zAohuvHARtEZ1ViYb10WGQL7kCmxHX6EsfZ?=
 =?us-ascii?Q?02QJzzti1n8uqma4+v8h864kbd8V3SDYbjl8JoIcbbnkFAxuxREOGmiTUDB9?=
 =?us-ascii?Q?4qgSibcyk1aqzvRTRv65UHo34xzFB3L90qN4iWnh7bjleT9148/XHhQilYGV?=
 =?us-ascii?Q?zdw9zyTjTwS/FcG0gMAU0b+vpQ8Y0XJJwmpmN9rgUO/KKx4pWWSB/y4MWPrh?=
 =?us-ascii?Q?Z7SLzSgyZ3SoLXwn6P8p0A0iH3NAzGEVSctj9yTRkfTkqziUampeqzEsvBCT?=
 =?us-ascii?Q?bgqbzoW4uIprSx5MYUrOiiS2gpPVI+wsfUOOVsSPkUrzbWEMhgNuaIOdvrhs?=
 =?us-ascii?Q?Dw8szujWYvkQQxuGuVXuA3vBn69wTczRIBZs7GPTfbWiPc4lBYd9M1k9EafH?=
 =?us-ascii?Q?h6G0uOnghTTZwdzDIEiiAae9E2zPIGzAyKSiJKk1PXtPPeC+GbR7uaH6pGC9?=
 =?us-ascii?Q?hfYAWgyA4eljL/BmsuOiJU2I8Kfq3IJvVZ2qX1VXOoBPeoot8VLOwKqV3EC4?=
 =?us-ascii?Q?FOxkgPxrDFLW5cXtm4rhGkBzR/E1BCokLXEfLHqZ9+12x4eXSM3Izl3oBVed?=
 =?us-ascii?Q?uPeG6fuYgshyrIEmY6uiU0c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1fb8e0-77c6-4044-5594-08d99d18d884
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 09:20:28.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKlCFCxznZt/7iETs0i1iBh+smv+j01/pBWzMIySWddLU8IDZKshvR/WhlxvrOSHI02m1Uh8utWyehYCEzBa4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1848
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 29, 2021 at 10:15:35PM +0800, Limonciello, Mario wrote:
> On 10/29/2021 08:02, Huang Rui wrote:
> > From: Jinzhou Su <Jinzhou.Su@amd.com>
> > 
> > Add a new function to enable CPPC feature. This function
> > will write Continuous Performance Control package
> > EnableRegister field on the processor.
> > 
> > CPPC EnableRegister register described in section 8.4.7.1 of ACPI 6.4:
> > This element is optional. If supported, contains a resource descriptor
> > with a single Register() descriptor that describes a register to which
> > OSPM writes a One to enable CPPC on this processor. Before this register
> > is set, the processor will be controlled by legacy mechanisms (ACPI
> > Pstates, firmware, etc.).
> > 
> > This register will be used for AMD processors to enable amd-pstate
> > function instead of legacy ACPI P-States.
> > 
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/acpi/cppc_acpi.c | 45 ++++++++++++++++++++++++++++++++++++++++
> >   include/acpi/cppc_acpi.h |  5 +++++
> >   2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index c9169c221209..2d2297ef5bf9 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1275,6 +1275,51 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> >   }
> >   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> >   
> > +/**
> > + * cppc_set_enable - Set to enable CPPC on the processor by writing the
> > + * Continuous Performance Control package EnableRegister feild.
> 
> s/feild/field/
> 
> > + * @cpu: CPU for which to enable CPPC register.
> > + * @enable: 0 - disable, 1 - enable CPPC feature on the processor.
> > + *
> > + * Return: 0 for success, -ERRNO or -EIO otherwise.
> > + */
> > +int cppc_set_enable(int cpu, bool enable)
> > +{
> > +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > +	struct cpc_register_resource *enable_reg;
> > +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > +	struct cppc_pcc_data *pcc_ss_data = NULL;
> > +	int ret = -EINVAL;
> > +
> > +	if (!cpc_desc) {
> > +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> > +		return -EINVAL;
> > +	}
> 
> Can this actually happen or is just an extra safety check?
> Don't you block running based on acpi_cpc_valid?
> 

It's a helper function in cppc lib, is this possible called on other driver
might not be protected by acpi_cpc_valid in future?

Thanks,
Ray
