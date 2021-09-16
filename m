Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8640D634
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhIPJ3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 05:29:02 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:65185
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235578AbhIPJ3C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 05:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g44mdTGU/78H5+QCaR/0D94PUN0hvUj53SrDajreMZO8uVQ4MsjrI9jwguehq1cjPyoQ+jqVk8l1oz+IbQ3hgi3p15v+AhPWTlKUty6V1pqce3BLnqeAIS2qEhLlMuPjfft34sic9PLvxBVTohVNF7fy0YchLKAkZfGavGGqe4Kv+vrZQsCJ/P47m9qTzKNOxR9NuP5oVj/mwmhcplZTFXLeac2oCvbxUZR1hnLixPOTV46dKUCe/3uJnksVYErBQ7ZCxq3EjPy6sZSh7Kt1b/9HmYK62JUiWWjHv3lJP/Zi/r7ECoIrF9UdUec36o7XIlxEttQ1PTdM4TPrCoSBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5tbVTe/VHhfCtC76bjIOruce4boADXJ+gP5wUNayNcU=;
 b=EQJIR9k1bJIZtqFgTACRyKWWcEUpLUpEbp6EI+syUNTOV1ad696BVB5q8aF/q4LcISUNQ+dckRjbaINGAq1pqKe2ai9ys5PC8ocAtpTkp4c7b5WL4CP6Uy8o4Dsw60l5xGOLSUDgJIQy7G+fFy3hHMM+qlxpTme4qHvt3ctdXhMZ9npdkJPIBm2mX8mNvt8qqVc0uRHDKbi+aE0H48R4p7GZwliJrGA0O4jOYmAfGJC/uyN1wIVmL34buFRWgI5HZXzK41RtG4BqzOnSUuBgP/QR17WteZH29hI5jE3mc2c9gHuBsT/y0FYSqoxwZhF2/Ve0ranQJNAnRP4Ow29CCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tbVTe/VHhfCtC76bjIOruce4boADXJ+gP5wUNayNcU=;
 b=5fXcqz0EBfbg2/hIFKbGEbn4nYEQ9gA8HC6uwkfP85cdVeuqhk35VSPHusLDQsJiUuXFqbS9Q4FZC2fwU9mR+4/feW+TYn+7i4Z7rIBN1+VaH44QYpdmzV50jUqe1j+cM6mgTWiR3VtV1sN+fsuOrf1Bj5wTlrzn+4xbuJka7y8=
Received: from BN6PR19CA0066.namprd19.prod.outlook.com (2603:10b6:404:e3::28)
 by DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 09:27:40 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::a0) by BN6PR19CA0066.outlook.office365.com
 (2603:10b6:404:e3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 09:27:39 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 04:27:35 -0500
Date:   Thu, 16 Sep 2021 17:27:35 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 16/19] cpupower: enable boost state support for
 amd-pstate module
Message-ID: <20210916092735.GB3755511@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-17-ray.huang@amd.com>
 <ed2906aa-d898-9d3a-ed04-7ad0ecc51f96@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ed2906aa-d898-9d3a-ed04-7ad0ecc51f96@linuxfoundation.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b8273e-dc53-4ed8-591a-08d978f43a4b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24701665A08AFFF6E8381E1AECDC9@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANgF97uF/A/tHc3vVwT+sZk4FTjwhfkcuwlRk1rRprsduJpdhBPYHm7mBsobufKhJ5e4tFuVOVtX1Ba+chkyqJ94ObQtCc0EYGIAfoi2PpanJ2lNzsFUmnykTj/DZD64jeIAMzhqOhrCurklj34pmaEVajGB6jxw9Ba6M1jn/z/z+akUqAlYRQi2gwiVTTRkipN2Z5UW7YXL7v0foEUF+uclTofD6xOm57mof5lZhWZwx4eZqlkwjVfS8/ZWJqPAeQU1xEksQpeBizLKDF91vTXhALhiGVvfR/OdIuYWR7tBdK2E9S91d3E8NpFHRwh7BPCUwTdGdbPLEkMCUvjR02frP2we+0Nb6wyJe8INT3TPFziyZOT7mKFt078ko42xrRqdsGXUX+LOyGaaUE8BjVKmNAjqtvs8FZerk8v02MdfA7EGdqK27Rb3iIoX8zEgOQAgzpFQqXf4wNbtIB4HxGZqXtyH1/BFDe5PY+pUC+ReMojigFgxgp38SO64Go+TQE7PFMTVxGQd8MeZeu6OMIFK/tA/0t9aTHJFtq59QUuuPZSs5MmANaSWUQdSezoNagURZlgdFrgXw+3ruo9SeRNNGrjOPQ6+i1PbA8iTomDvNObSoVsgyMMwV0RyGj0EZ6MgnFJ+H+MBaGmSIptpLYDJmKGFs3SGr67JJYS+zKF/diLYX5+3ko0dlFh0QySrD0Eey71tL73gJGgfNs6gKWeBT6JNpFYzfLYAhRxdPxM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(36840700001)(26005)(70206006)(186003)(2906002)(36860700001)(9686003)(70586007)(81166007)(8936002)(16526019)(86362001)(6916009)(316002)(426003)(55016002)(82740400003)(478600001)(33656002)(336012)(82310400003)(356005)(54906003)(1076003)(33716001)(47076005)(8676002)(5660300002)(4326008)(83380400001)(53546011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 09:27:39.4575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b8273e-dc53-4ed8-591a-08d978f43a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 10, 2021 at 06:42:42AM +0800, Shuah Khan wrote:
> On 9/8/21 8:59 AM, Huang Rui wrote:
> > The AMD P-state boost API is different from ACPI hardware P-states, so
> > implement the support for amd-pstate kernel module.
> > 
> 
> This commit log doesn't make sense. If these sysfs entries are used
> for amd-pstate kernel module, why are they defined here.
> 
> Describe how these are used and the relationship between these defines
> and the amd-pstate kernel module

Will refine the commit log in V2.

> 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/lib/cpufreq.c        | 20 ++++++++++++++++++++
> >   tools/power/cpupower/lib/cpufreq.h        |  3 +++
> >   tools/power/cpupower/utils/helpers/misc.c |  7 +++++++
> >   3 files changed, 30 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> > index 3f92ddadaad2..37da87bdcfb1 100644
> > --- a/tools/power/cpupower/lib/cpufreq.c
> > +++ b/tools/power/cpupower/lib/cpufreq.c
> > @@ -790,3 +790,23 @@ unsigned long cpufreq_get_transitions(unsigned int cpu)
> >   {
> >   	return sysfs_cpufreq_get_one_value(cpu, STATS_NUM_TRANSITIONS);
> >   }
> > +
> > +int amd_pstate_boost_support(unsigned int cpu)
> > +{
> > +	unsigned int highest_perf, nominal_perf;
> > +
> > +	highest_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_HIGHEST_PERF);
> > +	nominal_perf = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_NOMINAL_PERF);
> > +
> > +	return highest_perf > nominal_perf ? 1 : 0;
> > +}
> > +
> > +int amd_pstate_boost_enabled(unsigned int cpu)
> > +{
> > +	unsigned int cpuinfo_max, amd_pstate_max;
> > +
> > +	cpuinfo_max = sysfs_cpufreq_get_one_value(cpu, CPUINFO_MAX_FREQ);
> > +	amd_pstate_max = sysfs_cpufreq_get_one_value(cpu, AMD_PSTATE_MAX_FREQ);
> > +
> > +	return cpuinfo_max == amd_pstate_max ? 1 : 0;
> > +}
> 
> Why are these amd specific routines added to common file.
> Why not add them to tools/power/cpupower/utils/helpers/amd.c?

You're right. As mentioned at last mail, I move all the amd_pstate* from
lib/cpufreq.c to utils/helpers/amd.c

> 
> > diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> > index 95f4fd9e2656..d54d02a7a4f4 100644
> > --- a/tools/power/cpupower/lib/cpufreq.h
> > +++ b/tools/power/cpupower/lib/cpufreq.h
> > @@ -203,6 +203,9 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
> >   int cpufreq_set_frequency(unsigned int cpu,
> >   				unsigned long target_frequency);
> >   
> > +int amd_pstate_boost_support(unsigned int cpu);
> > +int amd_pstate_boost_enabled(unsigned int cpu);
> > +
> >   #ifdef __cplusplus
> >   }
> >   #endif
> > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > index 07d80775fb68..aba979320760 100644
> > --- a/tools/power/cpupower/utils/helpers/misc.c
> > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > @@ -10,6 +10,7 @@
> >   #if defined(__i386__) || defined(__x86_64__)
> >   
> >   #include "cpupower_intern.h"
> > +#include "cpufreq.h"
> >   
> >   #define MSR_AMD_HWCR	0xc0010015
> >   
> > @@ -39,6 +40,12 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
> >   	
> 
> This logic here calls amd_pci_get_num_boost_states() ---
> There is another routine called decode_pstates() in
> tools/power/cpupower/utils/helpers/amd.c
> 

The decode_pstates() is for legacy ACPI hardware Pstates (AMD only has 3),
but new amd_pstate function supports the finer grain frequency range. It's
the different hardware design. So we don't have the pstate number anymore.

> 		if (ret)
> >   				return ret;
> >   		}
> > +	} if ((cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) &&
> > +	      amd_pstate_boost_support(cpu)) {
> 
> Coupled with the above routines, the naming amd_pstate_boost_support()
> is rather confusing.
> 
> Also why is this amd_pstate_boost_support() added to
> > +		*support = 1;
> > +
> > +		if (amd_pstate_boost_enabled(cpu))
> > +			*active = 1;

OK, yes, it can be merged in one function here. Will update this in V2.

If the boost is not enabled, the maximum perf will be the normal perf
(similiar with P0 before).

Thanks,
Ray
