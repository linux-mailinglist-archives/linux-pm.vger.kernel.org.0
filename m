Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F4040D637
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 11:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhIPJao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 05:30:44 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:35072
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235130AbhIPJao (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 05:30:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWJ6dGw0dhdapxplprVsFqD1JQrPFhAKm5ILQMnbYl7pZvUf3Bl5a0viV2Qcj5dXXh2iQT3lmesCgC+QDGNDhzTUSiusuwOFX+IREm8Pjb51W5ABQrKsjwBcDb+4LVUWXyNod2+BMDsJwMDSMQzYu3wqy9wwjUC016hvxs+0lvdlym7IDCMcP4hwFn22YLjnAdtqelUOm/ojFII8AlVHKasoJ/8GhFMy8qy2OvlXPSmUWFYPL7/P7ts8bbehTkgskenPyb4Rgs9uFjjNZWV2qMNLhj4IlJIgft4S6IJMJnZhnqSU40qKnXbHN2FvauMhRDjYK8GbaTTS0ISYjWsVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GQD9XJMZ/eARLKQvT9cNTuTBAA7nQJrTvlldiv3C5TY=;
 b=huTv6smAe8MHxWZmwILzVuuhE+Hi9p3TN++nL+leRx4+48pRvWw5QTR0s5/paV9lWtA9j/24CRZQ+cV6tSyzPtLxiojOstWXqbDcU6p75+C9lXqjF8eRNDHMdWulEBslrsF8PKirfN44Zs4I1kUpgy8dvGdkvdQik/+v9GtU5Bydb90o9R/+9pewFpBx5vJJMpYTO9UD+4ZcwYQ4lN//t+1Uh0vyfo8akfZ+Q5DuI6NKHKlsQFujH3lu/BRerUrDD9T/NwpkHQKU2m4qNSSJa6NbjjLf5Bvef2PPg5PBpqOnQuDeLmtsbdJUjJjJKkY1UTRc0YUMAa/G8eBdjDwyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQD9XJMZ/eARLKQvT9cNTuTBAA7nQJrTvlldiv3C5TY=;
 b=XG2ms8ZNQfDOMdBCWw2NxraeU579/CT7norBfNun0g7i+eVO5+h4Kac+quOFAW2PB11EkRItYND5Hv5zMESPEYz9DgUcCu19oM9DofqvOBMAaF6eqdNv6PMVYRzSw/F/0BnxuhAdM0ovVM76vNkSMpkNnKMZILxCErrFgu00K7A=
Received: from BN6PR17CA0038.namprd17.prod.outlook.com (2603:10b6:405:75::27)
 by DM5PR12MB1529.namprd12.prod.outlook.com (2603:10b6:4:3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Thu, 16 Sep 2021 09:29:22 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::bb) by BN6PR17CA0038.outlook.office365.com
 (2603:10b6:405:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 09:29:21 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 04:29:17 -0500
Date:   Thu, 16 Sep 2021 17:29:18 +0800
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
Subject: Re: [PATCH 18/19] cpupower: print amd-pstate information on cpupower
Message-ID: <20210916092918.GC3755511@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-19-ray.huang@amd.com>
 <70bef125-398b-8a3c-07f5-a4ebc68dc0c8@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <70bef125-398b-8a3c-07f5-a4ebc68dc0c8@linuxfoundation.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a1cd117-b4be-4c32-63c9-08d978f47731
X-MS-TrafficTypeDiagnostic: DM5PR12MB1529:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15292BE1D2E709B33CB61D68ECDC9@DM5PR12MB1529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9R3NRB9nIuULtMV0SFvkra9D6mF4hrh635S71TIug3qCNI0UrIYB+qkiDMva/P3pr76jtGvkkEv4VKW4/e/Hpapo14cspEALTrPOWVqh+hUColfvi30W5azddGmr2KSu5FQpA9lpI39TPTPmPYT/jBliQdsw2Q5r6khNADXwe37igz0wjGcmjLUhL2fA0KAAs1zFcqPLDqKZT15A+vdMrXfYwt3fPZ/RtCZvT1XJ9DmyAuVHuYvOmv4b86hOQsUI9Xf7bQMTqLIqMqrdoLz0yMlxnafpUbSFK+ajGNUB7L02WLt/fUvRmurAxHblUJ50mjXfxVstbEiusXsz4gMc5tO5Gmg2/LxFjPUmkG4DOcjbc8NCmp0+n/OOclQmaoIVkXIN6YnpKjv1ACXqb2pUvm7QlH8JVedIOy/GZwLeHnHgvEPPPFdT0rNb0BL9eaj2BzPIhRvVgL3CMUQ6nomMukPAVkxIMdlHaLVcK4trw0EUMGF46ADJKotCoe9+i+k04LL6DAjr1b6B4Gu3PMdnTGJDhpe6IoO0vZWMsgn/YrNVVwLYSWBh+8YFxrIvrOav/WLRfKqDj/qDNHapFvYxGHooC/HzydUSuFe5QlNxmoxAuDdc8Cc4P8KfH7HNrYqmmk6a+JBKKHju73FKW+abZR3w2Unm108lAqGwgSadPV7PLyX+Yn/Oc/sl+feqqviehf34PZtl9i5KAnQzgzPZLnWc4AVMCv7pLj3E4yvZvpc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(356005)(9686003)(55016002)(478600001)(36860700001)(16526019)(186003)(33716001)(1076003)(53546011)(47076005)(26005)(2906002)(81166007)(54906003)(83380400001)(70586007)(82310400003)(6916009)(4326008)(8936002)(8676002)(336012)(426003)(316002)(33656002)(5660300002)(70206006)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 09:29:21.6284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1cd117-b4be-4c32-63c9-08d978f47731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 10, 2021 at 06:46:39AM +0800, Shuah Khan wrote:
> On 9/8/21 9:00 AM, Huang Rui wrote:
> > amd-pstate kernel module is using the fine grain frequency instead of
> > acpi hardware pstate. So the performance and frequency values should be
> > printed in frequency-info.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/utils/cpufreq-info.c | 27 ++++++++++++++++++++---
> >   1 file changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> > index f9895e31ff5a..9eabed209adc 100644
> > --- a/tools/power/cpupower/utils/cpufreq-info.c
> > +++ b/tools/power/cpupower/utils/cpufreq-info.c
> > @@ -183,9 +183,30 @@ static int get_boost_mode_x86(unsigned int cpu)
> >   	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
> >   	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
> >   
> > -	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
> > -	     cpupower_cpu_info.family >= 0x10) ||
> > -	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
> > +	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
> > +	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
> > +		printf(_("    AMD PSTATE Highest Performance: %u. Maximum Frequency: "),
> > +		       amd_pstate_get_data(cpu, HIGHEST_PERF));
> > +		print_speed(amd_pstate_get_data(cpu, MAX_FREQ));
> > +		printf(".\n");
> > +
> > +		printf(_("    AMD PSTATE Nominal Performance: %u. Nominal Frequency: "),
> > +		       amd_pstate_get_data(cpu, NOMINAL_PERF));
> > +		print_speed(amd_pstate_get_data(cpu, NOMINAL_FREQ));
> > +		printf(".\n");
> > +
> > +		printf(_("    AMD PSTATE Lowest Non-linear Performance: %u. Lowest Non-linear Frequency: "),
> > +		       amd_pstate_get_data(cpu, LOWEST_NONLINEAR_PERF));
> > +		print_speed(amd_pstate_get_data(cpu, LOWEST_NONLINEAR_FREQ));
> > +		printf(".\n");
> > +
> > +		printf(_("    AMD PSTATE Lowest Performance: %u. Lowest Frequency: "),
> > +		       amd_pstate_get_data(cpu, LOWEST_PERF));
> > +		print_speed(amd_pstate_get_data(cpu, MIN_FREQ));
> > +		printf(".\n");
> > +	} else if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
> > +		    cpupower_cpu_info.family >= 0x10) ||
> > +		   cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
> >   		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
> >   		if (ret)
> >   			return ret;
> > 
> 
> Same issue here - amd specific code sprinkled all over the common routines.
> Needs fixing.

I will make a funciton in utils/helpers/amd.c to prints amd_pstate status.

Thanks,
Ray
