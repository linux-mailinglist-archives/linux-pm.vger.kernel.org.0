Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD3443D8B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 08:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhKCHHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 03:07:16 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:29281
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232021AbhKCHHP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 03:07:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMWOGyW/FMVS+STeMmNZfhDs//+kUXdAB6BsEbPSTiGUuPoPQeviG/C0xPJlCZfovsu3ySpLmyxF4Hf+ja2JicIT15dJq7WDRiMi3Ee9qIH2WvBZD/97aeNR5ad0SkJO5f4T2qNnNwnL8jaeMF6OvCICFOQNIrZq5e0naSzCwVoexb3UjRMiC6P8bnuiysB1NJo3qUkzh15vkvWXv6yp7TGZTXzaog1MNsALpVhDEfXHQ9PQUZOtLwMXDkdnBh4CuHG8YHMM9fvGg1EeG5pwVyHdcFaAgg0rCjQoZyaqTYM7FTFjGIKxjy8hn3L9Xu88XxHYKiVIwo6D+BFXb48szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kql3QgyuAxVT1gLit6MIvVOoYrKCdNCtHc1ze8qp6c=;
 b=Ah/TRpg4deSX9MYgi4VEkDWWqD+n9Eyv87cGFpwP8jDhdPcW9nSb7Ke/pgY/4iSDlsn/Uf50WNYeoYX80Y+zy4Zk7mjQIgYYKcuf3+VObMZ+w3uM+GvwOuAycrlGJuBIC/N2BNHctaaZtItHCqmgHA6nb2Yk3+0pMJqmhRCC+Q9bgzX9wHQPQWOQjCwXWzgWYdRQSJCfanBff5bnP+0dJzBjRF/GxS+XU/PVpShN8+7vYfeRxHQ0VsyER593eyPS0fiV2FSlB61hSqfmVyT15YK7A6/ScgJl4N3cCXhHGjGvy8KbK99RwqmwHaP3c/cGuux7GvyXutr/wDt+j+h5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kql3QgyuAxVT1gLit6MIvVOoYrKCdNCtHc1ze8qp6c=;
 b=MFvlQngOzXfTBysElNcql0+WuM0ZYcX/Eaibq3lOc/Uz3AqjZpll+vjuLjlS9ahDfqCslsvodNEK3h/4U9Q4Oo4znklNY3WPtU4T6XMFz824IP2OzAqbwbKnPnDrzvmT/Ho03ikSkdQHwwmNcQBocEWw5jo6AZT2Jz/m7ulL13A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1461.namprd12.prod.outlook.com
 (2603:10b6:910:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 3 Nov
 2021 07:04:37 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 07:04:37 +0000
Date:   Wed, 3 Nov 2021 15:04:08 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
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
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 18/21] cpupower: enable boost state support for
 amd-pstate module
Message-ID: <YYI0aPAw5t1WbC+E@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-19-ray.huang@amd.com>
 <5ec8afe8-d157-84e5-c877-649d4484ddc3@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec8afe8-d157-84e5-c877-649d4484ddc3@amd.com>
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by SG2PR06CA0243.apcprd06.prod.outlook.com (2603:1096:4:ac::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Wed, 3 Nov 2021 07:04:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3f391c-f248-46da-7edc-08d99e9832ad
X-MS-TrafficTypeDiagnostic: CY4PR12MB1461:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1461DC9F1FA6AFBA70E0A95CEC8C9@CY4PR12MB1461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: re5DRFu6UX0JuKooiWmLjS4Z6hKRjcKNIjMcy485MizvG4aWE18AwZ3sd7RP4SL0QXUtQQNFQsFcwis1BpPPpZoLXbeWKXykn77Khlpv9Y1FMGxD6poazetjYi4t/zzpXiAuWl6f9RH77lBh9QtHSpv4MMbZTDVy+hmXdfiS5JsCZoPCcg8PfUt6mU3Dj797JT6gpZ3L7IusmrbJiupdd8Xtbpk8sYHkp1OmEnbthJ0EAlynN+Ud4DNhUn6aN8kzKHBYdTfBdK5ASxc/4+q7OfQj+QAzV7TosapYLarUklGtrETcxfLYqLfsa/5js1swoXr5mJhGMSrxxd7LTmptI/nOda0/Z66mJs90GRgpiAy3aillzO85sUaHrV0ZjUnapYni3x55LMA7ram3C87D/dGi/i5ndCUxjneILSk+ELgvKnqphN3Jaf9ikFB/TD4hK72AYFTlUl/KKae2Qrzu4AfTktdCzMLpilzKFCuEvrpDFmeLxNpcg0PFoBzUthP3kzJHIdTw23AAYPT0p7/Q13V+15LTRqSdmccZH6nx/0L1cx6FnBwQH3+y2ESkFldbZUMYujaKLKJCd17P/22/isCUjVb/yehffb6EN5ginMi2BZhpfjdqtOjQgshC77ICdIbQIkqTc44NLWg8U9QjNg6WGJJM9lE/m1KGixV29iOaANjkAHWRy/mkG328AtNAwV0E7dtGotUujxlb3W3QgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(4326008)(38100700002)(55016002)(186003)(2906002)(83380400001)(9686003)(7416002)(956004)(508600001)(316002)(6636002)(6666004)(54906003)(6496006)(66946007)(33716001)(86362001)(53546011)(8676002)(5660300002)(66476007)(6862004)(66556008)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?120zdfDwU8cnmcfAupCk6f2azBlwfWwAtUjEqK0alXD+NO4fdM/HxMQASg0j?=
 =?us-ascii?Q?yctXS9SjFU/48VggNBwvdemCow1x3zuRomewaOGHFljN7QY3VuBKDLkeQqVF?=
 =?us-ascii?Q?ckyKJOM3bpMnx8550DhwYa5f7kZu3Xh+TupQ4fqv/JtId9VsrmRMDRWQajKX?=
 =?us-ascii?Q?gGv1rLrq1JPKtsv+ST9l1+jUEBfiQebAZIDAaTq0H1EwY0TdjFSQRH71RxGP?=
 =?us-ascii?Q?wqsY144OLpX4srlJhKHXkT0PSuOpdtgACODRKS4bcyM1tanPR7T4GZ3rbuDJ?=
 =?us-ascii?Q?G3+6EeZClJA1wyeSVcHPYsuWr+0lYV9TD9nsw46MLX9vwSauuX2G+wEQPGcF?=
 =?us-ascii?Q?0O6rToiUzRet4soxxRQAS7byvsUBTmXMIkAx+Oy08G4MxA4vNEyLyfahOpod?=
 =?us-ascii?Q?0fmc1c0Dxp1mFDKDpfjgD2fK4NYwDlbxKCnS5l09VxctKX1Qi7uX44bazs+J?=
 =?us-ascii?Q?k5To8yWP3COkc7PMZhPQ5x5HGAdkq9LQ7wK1ceZzLCKg/A9CXPou228X03zw?=
 =?us-ascii?Q?tsaGvCx3zj/t0/tSLrOnUFQlKVVfPr+3mOI426jk0egqwojqeGcDU6guIbzF?=
 =?us-ascii?Q?erdhvMjGLFfTpIv27W+3lR609H8kyblaybdz71PVgZeuNzcMwXWH+TwccPmS?=
 =?us-ascii?Q?WyTdgIS3Ug7BTQM6pfYWGqYTW4tDYzuTJuIOwPw8n12aFM/rvhPnfYVKFd8S?=
 =?us-ascii?Q?eRe3EDeAXyuo2X3P2qWwaQ+dGfwi6Oe4Sae7IJO+0q5xLjtXjswVG5zwDF0z?=
 =?us-ascii?Q?YGVeOJS5B/Ovi+F+iF66HPyfSzlNXAlFPN0/ZIBaEJdAf3a3XYEgf/SW0Sg9?=
 =?us-ascii?Q?kOSkyjcePppdaK6P/P7TYqBM3HNiDqwUtLvnh8/nqFNoh/0O6OnHxL9cvVK+?=
 =?us-ascii?Q?hIqKkkVVq1rrdaut3rrGN/00f+/YlXnBKGU7BiDzRa4QzIglI8cf1Giis/xM?=
 =?us-ascii?Q?5lDdxCklH++uHWZHlD0VpQWS1RykKKKFpvAeZXqnzdwLXJi4Rm1DKCeQKUWd?=
 =?us-ascii?Q?wnpp2LRqP0YA/TrVBKfbxJlNlngdJaVGVTwkxoowbmxtrL7qRPCpXxBmzmOE?=
 =?us-ascii?Q?BquMvBbRwmZJ0g+Nzjl2C+6uWbXIFTxLSClQDeFhfW3/3KQWp0kfX87tEt8/?=
 =?us-ascii?Q?P0sLXEKAoIVgF4MCX/PJPYwFQdrA0lbzHJE3LsO27Y9mAH67kTysLjEYmbrY?=
 =?us-ascii?Q?UVVaXs89JSiV5FRA+ZU7iFoNpxrjSiVCmmraOOqATdtgvk3qKlcUpmvVXBrg?=
 =?us-ascii?Q?yfpVYqbPqXpMSA1dhuxW8C9cTBHeKwHAj4zn4rmgePg97To1BfwSgZtgvLMO?=
 =?us-ascii?Q?/47pGj6Gf3ozIG/5j/bztwociFmY3Kiro+tdjfJXyZlPZygxMxEQp4Ph81p2?=
 =?us-ascii?Q?wPPw/ll3lhRLs+swwGyHyg/aFfc0FvYRBRq/fn2fbCf3j2c3hbHmlUB8kGdx?=
 =?us-ascii?Q?XOo7K83YxymDw5evPrb6JeIkeB1amdJHjk/VaEwqbsNoM9ezud7T2nHBVH3P?=
 =?us-ascii?Q?18mX2cQQ62JdMlZHrIAWrT3CjOm+WBXYyR6AIpVT2KJjtfne5H1opC/EsltO?=
 =?us-ascii?Q?RRfLgoPpxwFywIToeQB0+4Y0qD0zATiSPbWYn3jTimC+WEaXWMAUgIkdEQ+4?=
 =?us-ascii?Q?sKYihSwURqwK9MEU/vcDoJ4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3f391c-f248-46da-7edc-08d99e9832ad
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 07:04:37.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G6X4PVhHojpzvbJMRA4anelEhePqhCNjFjDouIPJTwJndGow0myddYAl6t5KtiljUfFxZqVlJXenPz3X1tr9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1461
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 03, 2021 at 04:11:09AM +0800, Fontenot, Nathan wrote:
> 
> 
> On 10/29/21 8:02 AM, Huang Rui wrote:
> > The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
> > the CPU frequency only can be switched between the 3 P-States. While the
> > processor supports the boost state, it will have another boost state
> > that the frequency can be higher than P0 state, and the state can be
> > decoded by the function of decode_pstates() and read by
> > amd_pci_get_num_boost_states().
> > 
> > However, the new AMD P-States function is different than legacy ACPI
> > hardware P-State on AMD processors. That has a finer grain frequency
> > range between the highest and lowest frequency. And boost frequency is
> > actually the frequency which is mapped on highest performance ratio. The
> > similiar previous P0 frequency is mapped on nominal performance ratio.
> 
> s/similiar/similar/
> 
> > If the highest performance on the processor is higher than nominal
> > performance, then we think the current processor supports the boost
> > state. And it uses amd_pstate_boost_init() to initialize boost for AMD
> > P-States function.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
> >  tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
> >  tools/power/cpupower/utils/helpers/misc.c    |  2 ++
> >  3 files changed, 25 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> > index f233a6ab75ac..92b9fb631768 100644
> > --- a/tools/power/cpupower/utils/helpers/amd.c
> > +++ b/tools/power/cpupower/utils/helpers/amd.c
> > @@ -182,5 +182,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
> >  						  MAX_AMD_PSTATE_VALUE_READ_FILES);
> >  }
> >  
> > +void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
> > +{
> > +	unsigned long highest_perf, nominal_perf, cpuinfo_min,
> > +		      cpuinfo_max, amd_pstate_max;
> > +
> > +	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
> > +	nominal_perf = amd_pstate_get_data(cpu, AMD_PSTATE_NOMINAL_PERF);
> > +
> > +	*support = highest_perf > nominal_perf ? 1 : 0;
> > +	if (!(*support))
> > +		return;
> > +
> > +	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
> > +	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
> > +
> > +	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
> > +}
> > +
> >  /* AMD P-States Helper Functions ***************/
> >  #endif /* defined(__i386__) || defined(__x86_64__) */
> > diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> > index e03cc97297aa..c03925bea655 100644
> > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > @@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
> >  
> >  /* AMD P-States stuff **************************/
> >  extern bool cpupower_amd_pstate_enabled(void);
> > +extern void amd_pstate_boost_init(unsigned int cpu,
> > +				  int *support, int *active);
> >  
> >  /* AMD P-States stuff **************************/
> >  
> > @@ -177,6 +179,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> >  
> >  static inline bool cpupower_amd_pstate_enabled(void)
> >  { return false; }
> > +static void amd_pstate_boost_init(unsigned int cpu,
> > +				  int *support, int *active)
> > +{ return; }
> 
> I don't believe the return statement is needed here, can just be {}
> 

Updated.

Thanks,
Ray
