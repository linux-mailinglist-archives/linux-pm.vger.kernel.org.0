Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5245640D4E0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhIPIsb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 04:48:31 -0400
Received: from mail-dm3nam07on2087.outbound.protection.outlook.com ([40.107.95.87]:15200
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233791AbhIPIsb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 04:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km6agQaKTJF+BbyLZyKTnpqwUjkgPc8ROOgtrCl78GiVNPVPPWzmcsktkRJ7TqmoPdgXR9rLpQr1JgJKEiGOzuRbTeIJzzBIu46GVlDEwkoscB1HpN637RKStMbMJBbNxxRMMQnTNBkk0vmMGoXTRFd+ISpUerhVS4Llb8ZZQ/NWKCMG5AWft7zFp3jIEE4zWBizp03LAqY2kU+BcPHR4RZvvgP0ybv7csEkC67WIl34Eve2cd6ytrucAW4gEoXKAciJsHOasbyWDfifrF/w7msfoO2B0ngGPiU3wT7/xXCku2EjY9ZB9pd0e+f/fzSI6SzftG5pEs7GjhAy0ItZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=48DhawiAwYlhRqkNijUyauzMQTYdleuWgf3etLpP4gA=;
 b=AOugsF/izfESLWFS1wa9TJ5AHeCpwnVmoPJYWfVdw/MEOdvzw3coPVuB3NL/gPKIxFvy7xWpSyL9bBnl23ntvI5VewBZYoQMlHdPSYsIlfaosbsmji5xJ6gHVhlNI1LMzemODLT1mP0ttnUdYlZ7MM3PPrnbXMhT8MjF60YnJ4gD13VDYks5AwgeaclvHB7ND+lIn1WylqX7cSvr+gtNK7YErl16DPhXhwmS80dtSuGyMVFnkZy2Vahiz8K2vDZaBx5jyvH0F/dYknQfgWJhEbkuBDjEhn/OqTaCzsJBLMXggz/Alu866r1AFzKQhZ9MLqoSgKnVZevDscxcjSoGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48DhawiAwYlhRqkNijUyauzMQTYdleuWgf3etLpP4gA=;
 b=DNj/+wTJNrK2C0kZyCpMqXWI1tlAa700D4EsAH98bDP350VQzPVJHwDIB0RkWjW5a03zkVz2oEEluKzhfkv73yBlS1k4xJsKJH8x23+RDdUSZFLW6N0j4H+EdMgEQsjMjCjRF9kfe7WBB3TAZpnvuDuahYIlGYFShP7OBJIz5kE=
Received: from DM5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:3:d4::12) by
 BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 16 Sep
 2021 08:47:08 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::4b) by DM5PR05CA0002.outlook.office365.com
 (2603:10b6:3:d4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend
 Transport; Thu, 16 Sep 2021 08:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 08:47:08 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 03:47:04 -0500
Date:   Thu, 16 Sep 2021 16:47:04 +0800
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
Subject: Re: [PATCH 15/19] cpupower: add amd-pstate sysfs entries into
 libcpufreq
Message-ID: <20210916084704.GA3755511@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-16-ray.huang@amd.com>
 <870445a1-1148-e5d1-08f8-df630466d788@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <870445a1-1148-e5d1-08f8-df630466d788@linuxfoundation.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 898c3d58-7948-43b8-08cd-08d978ee9147
X-MS-TrafficTypeDiagnostic: BY5PR12MB4901:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4901D4A5F61EBAD1724A6236ECDC9@BY5PR12MB4901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1YphP70XODs3OP48BeY5UsxvCkCSSOzCmEcSHQZsYF5YLTnarSImTfUA5xpGULk6mXfAbeiEL9h+eKZdk8vdzya/Ozqo6lXeAlgeKDcqL9ufgWZFYZByxpRA39mNr1+zkXAb7SjKPKYWVEjj7MsETCeJ3qsSc7clmTFhtBNCtjEViOot8LVCNzr3xcRIrFH/fSFsYMZQ6BYZ0HsIEJBPJV5kzSxw4f+g6nOzgE5y52ZpxTIM15tE7PnjcloKZM8RQWKvWJWJtL+WQkqVd2v7KrY8UeIREtxfjCksPte/YIY2u7TAUm0iYr56Uunak5aPbsI/RKpVE6z0Z2G6+YZ2antMYUSNx6GTh422pwOKU3ANI8X8V7hp5igAw1Rn+Fma4x7HMYRuuMbP1Op/P/R7NjmjlZQxPdWN6PDz5g68WQP+Y1zP5eAsUvLRicdQyQ4h91l4zWEX5FiBNvem8E+IKaMKMuhAG4M7kTy3QO7oFR4ufVo26rJ4XHd8nFhpLe6ABj3GlgGGXAA0RFsWvsqF7sgC/HuBhFw968tEAMk0FeNMPqAhHai8eI76DHpU4SW/kM+yqlAVNrtFcrSo38cYqYHAp6qZUqaEk/fubyjxJbobzWRW1cD5LLnWh6n0Jh+/hf+jSQ590jgifvx66c+/IzBZyxdBwV79XnGpmNM+0nWuEv8bsc43+f8p8Xf+o5K/PafOjRKkLgyCYzSPJmKg6VxkHwefJjpVZ20G+9WJXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(8936002)(82740400003)(33716001)(54906003)(2906002)(8676002)(356005)(478600001)(70206006)(47076005)(81166007)(55016002)(36860700001)(53546011)(336012)(186003)(16526019)(26005)(316002)(82310400003)(86362001)(70586007)(1076003)(6916009)(426003)(5660300002)(4326008)(9686003)(83380400001)(33656002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 08:47:08.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898c3d58-7948-43b8-08cd-08d978ee9147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 10, 2021 at 06:26:06AM +0800, Shuah Khan wrote:
> On 9/8/21 8:59 AM, Huang Rui wrote:
> > These amd-pstate sysfs entries will be used on cpupower for amd-pstate
> > kernel module.
> > 
> 
> This commit log doesn't make sense. If these sysfs entries are used
> for amd-pstate kernel module, why are they defined here.
> 
> Describe how these are used and the relationship between these defines
> and the amd-pstate kernel module
> 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/lib/cpufreq.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> > index c3b56db8b921..3f92ddadaad2 100644
> > --- a/tools/power/cpupower/lib/cpufreq.c
> > +++ b/tools/power/cpupower/lib/cpufreq.c
> > @@ -69,6 +69,14 @@ enum cpufreq_value {
> >   	SCALING_MIN_FREQ,
> >   	SCALING_MAX_FREQ,
> >   	STATS_NUM_TRANSITIONS,
> > +	AMD_PSTATE_HIGHEST_PERF,
> > +	AMD_PSTATE_NOMINAL_PERF,
> > +	AMD_PSTATE_LOWEST_NONLINEAR_PERF,
> > +	AMD_PSTATE_LOWEST_PERF,
> > +	AMD_PSTATE_MAX_FREQ,
> > +	AMD_PSTATE_NOMINAL_FREQ,
> > +	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
> > +	AMD_PSTATE_MIN_FREQ,
> >   	MAX_CPUFREQ_VALUE_READ_FILES
> >   };
> >   
> 
> These are AMD specific values being added to a common code.
> 
> > @@ -80,7 +88,15 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
> >   	[SCALING_CUR_FREQ] = "scaling_cur_freq",
> >   	[SCALING_MIN_FREQ] = "scaling_min_freq",
> >   	[SCALING_MAX_FREQ] = "scaling_max_freq",
> > -	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
> > +	[STATS_NUM_TRANSITIONS] = "stats/total_trans",
> > +	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
> > +	[AMD_PSTATE_NOMINAL_PERF] = "amd_pstate_nominal_perf",
> > +	[AMD_PSTATE_LOWEST_NONLINEAR_PERF] = "amd_pstate_lowest_nonlinear_perf",
> > +	[AMD_PSTATE_LOWEST_PERF] = "amd_pstate_lowest_perf",
> > +	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
> > +	[AMD_PSTATE_NOMINAL_FREQ] = "amd_pstate_nominal_freq",
> > +	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
> > +	[AMD_PSTATE_MIN_FREQ] = "amd_pstate_min_freq"
> >   };
> >   
> >   
> > 
> 
> These are AMD specific values being added to a common code.
> It doesn't sound right. What happens if there is a conflict
> between AMD values and another vendor values?
> 
> This doesn't seem a good place to add these.
> 

Shuah, thanks for your suggestion, I went through the cpupower patches
again. And yes, we should not combine the amd specific and common things
together.

Could I expose a simliar sysfs_cpufreq_get_one_value in cpupower_intern.h
header, and move amd_pstate_* function implementation into
utils/helpers/amd.c? It can keep the lib/cpufreq still general.

Thanks,
Ray
