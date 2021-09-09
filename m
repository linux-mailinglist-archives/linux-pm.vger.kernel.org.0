Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6752D40482B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhIIKBv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 06:01:51 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:52864
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233436AbhIIKBp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 06:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev+Rs9s5H2WSpMUWTLvIaY/ux/Nvldot/WkNCMYIFT+gYmZ8/XvaA5USUelYab2obdkxkHn4hqMbgU1mxMWG0zR/CXEqc5YaBv12BdQOD0tWbjdgQU701A3kEZgj0BnYhD7yHydumVJtTG4PWBoKUNgu5GFMw3ZQM2F9g7W58svr/6ii1n3BI9es6MRDYqzNB06j9Cochdfsbfkh2oWQZZl7krznGR9Pt0493BVR1F+3bPAiQtPqIzgCP0ZNGOr1JAqUL5EaUWIJoPGqXB2+iySB8JCZoiJFA0K6rw4jDrA57bKjquZdlGdpVcA1tR6SMSDX5A8H1LsZzBF15pKooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m3QpiA6+N9k3zNpTsG9eJkoywck3AF64rSThH06iuko=;
 b=Ld+PrftCtwqYH+IR7ZUZ1DeEkTCzlvycENWsr8l9TKAmpHQyNdtjbYOtWeVUYqoIzFJPm6coQfgwEB1zq16sTnMdDpdeRrQBi3SvU7JWtFkCWOQQAVx2vT1Yc47qlG3IsVo6tGCI5+W+PDdZ79Edn+OSbwyhqL6Eq6CsZhwzkveOJn1upBzLt5UvQQAqmtyYgE2WLC67Kgmn2c3ZAVR67QIgarVuii9cKSq5zJox5cVULnkAJNzfwIwd3T5HZaukCjo/O/HAExw4NdcVOckUZtkWAgP75oYzezDcenFNu0qGtaTdD54RFniOgrQvhO4nVqgr/tlcVJp6eYvpHwSKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3QpiA6+N9k3zNpTsG9eJkoywck3AF64rSThH06iuko=;
 b=YAKnoXrSH/USjL5zqtbCmGOIXFx4VCvzQH0EGgunOc6H+QuZcUQVnGsS60vUF+mR3A584VDYgcqyRo5iwGtnNvXu+Skxw9fgenjxHz4KUE79uXEq1Yo1h0RwXStRBcjJ54q4S4QrZOM3c8PMIMO3RAT7Zzk3wYy1ZNa/hgfvtbk=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 MWHPR12MB1613.namprd12.prod.outlook.com (2603:10b6:301:11::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Thu, 9 Sep 2021 10:00:31 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::55) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 10:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 10:00:31 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 05:00:27 -0500
Date:   Thu, 9 Sep 2021 17:59:33 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 16/19] cpupower: enable boost state support for
 amd-pstate module
Message-ID: <20210909095933.GD3702717@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-17-ray.huang@amd.com>
 <5353e053-084d-9a29-bae5-c1e1d597d1e3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5353e053-084d-9a29-bae5-c1e1d597d1e3@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6307a7fb-0c34-4691-a4c0-08d97378a8f2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1613:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16139D35B951BA6FB24A1016ECD59@MWHPR12MB1613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5U8NdvgSAQMGsew/3TykHJd0Rs7yyDYzkqielf9xfWeAGN7tBWh9k1RYHc6hqPunEPhGsgn4fTDlTdnnauf+FIwAPIAeSk+ZqDIreQilDSij/yTarP7SP9XIZXi0QBIIVX35eD7Mz3Z9OcWSEM7tJC0TPbzdGHVMiZDjxfqHYWKv14JN12rEigue/9X5L7+XbtqFmPknHAJZLwNTeqlufhSG0Bv5VDNz5mRN9qUZ0EDrh338nAkHONli5qZAkEDO5RnzyjOyuM1IfcyI4o2d/Qf0JrJbI3xVVM8oEsVtiKQj4mDettaL4ybRyJN2JVzByAl96QwuEywGkxgnAjJMn9PBJM7Iwj8Zou+QEgIxXg44URE7KYJYXt9kWNioaBWNAeKHeiD2P2F7Ai5yqcZoSgpxWy0eG+X+9XnazpmTKqALGZWpvgXZ5PomKctoLSoHI6sNIwTXjEedZNpBG4OhKeEB3z6mb+JZ4DeNVIkrSq4EfY1Jwzes8D7VsybA5YG5Yj0EuvsLMoL9G7gqy0far6XpcPXjf7xcPaf/yjcAgJe6SFGOE3GmRgTQISaHB1XUAK3ZSttqkdcghQ83JWTzvcBrgROEa8p9CqzJf9GPZ6/PXd5nokzsgOpoCkosVNtcLjig00HgQbSmexyidEoRtaPp7UNcS48VKlOz3Qwkytl+VaJrQQ5LMEpF5fqssASF7scokq1T6XHCPu4E0j6MkUXWGy/GQg/mx1dhnZzqeg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(478600001)(70206006)(426003)(70586007)(33716001)(47076005)(6636002)(4326008)(82740400003)(9686003)(336012)(1076003)(8936002)(316002)(81166007)(2906002)(6862004)(8676002)(356005)(54906003)(186003)(82310400003)(26005)(86362001)(36860700001)(5660300002)(16526019)(6666004)(53546011)(33656002)(55016002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 10:00:31.6400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6307a7fb-0c34-4691-a4c0-08d97378a8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1613
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 01:32:37AM +0800, Fontenot, Nathan wrote:
> On 9/8/2021 9:59 AM, Huang Rui wrote:
> > The AMD P-state boost API is different from ACPI hardware P-states, so
> > implement the support for amd-pstate kernel module.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  tools/power/cpupower/lib/cpufreq.c        | 20 ++++++++++++++++++++
> >  tools/power/cpupower/lib/cpufreq.h        |  3 +++
> >  tools/power/cpupower/utils/helpers/misc.c |  7 +++++++
> >  3 files changed, 30 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> > index 3f92ddadaad2..37da87bdcfb1 100644
> > --- a/tools/power/cpupower/lib/cpufreq.c
> > +++ b/tools/power/cpupower/lib/cpufreq.c
> > @@ -790,3 +790,23 @@ unsigned long cpufreq_get_transitions(unsigned int cpu)
> >  {
> >  	return sysfs_cpufreq_get_one_value(cpu, STATS_NUM_TRANSITIONS);
> >  }
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
> > diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
> > index 95f4fd9e2656..d54d02a7a4f4 100644
> > --- a/tools/power/cpupower/lib/cpufreq.h
> > +++ b/tools/power/cpupower/lib/cpufreq.h
> > @@ -203,6 +203,9 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
> >  int cpufreq_set_frequency(unsigned int cpu,
> >  				unsigned long target_frequency);
> >  
> > +int amd_pstate_boost_support(unsigned int cpu);
> > +int amd_pstate_boost_enabled(unsigned int cpu);
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > index 07d80775fb68..aba979320760 100644
> > --- a/tools/power/cpupower/utils/helpers/misc.c
> > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > @@ -10,6 +10,7 @@
> >  #if defined(__i386__) || defined(__x86_64__)
> >  
> >  #include "cpupower_intern.h"
> > +#include "cpufreq.h"
> >  
> >  #define MSR_AMD_HWCR	0xc0010015
> >  
> > @@ -39,6 +40,12 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
> >  			if (ret)
> >  				return ret;
> >  		}
> > +	} if ((cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) &&
> 
> Shouldn't this be
> 
> 	} else if ((cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) &&
> 

Nice catch, it's my typo.

Thanks,
Ray
