Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE8404845
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhIIKO6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 06:14:58 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:52929
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229980AbhIIKO5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 06:14:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOYOhFLVoekUFXeusZb0cXysqEUI+znZuUrm88KUM29HE2KU7FpB4hqYsb1ZLZj7CKHsN+lhs3KAj4v+HIgSn1mEBv1xQDvNYqPTRwg7Aa34Tp6hA4zxekPPY+0er92VFkBBD4MSEg2zYvPpLnvqiAHwu+DvWzsVS4QMV55dlx/fiB7sMt07Gl14AXNyiATNyS/LJwnOaBjY+gjQSjsRPMe4fiYfGkyMmZeK3t9To0txzT8U9rtCP/oEADvjW2yLiocKYkMZoOs0LT8/HGD58FYupllK99zKALwg2NYXHkR+RFjRPN1YKqDEGImMG0KFZPtgVEppctd98TKPfy7OJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w508ZaL1ZoIpEhRxkDCJ4Yu40WkhzNdXVU+J9ivvXaA=;
 b=bPQROX1UoZBXP+OUEqUE5f/m4rj3H5Xd0IHKkIu6IONF9SEc5fv6/0SIQAFrqc5JdZD4DcbMiYk56bC3TjVnMc5elU0SDf4fi2ICb5H3GmqtlYOXbT7umX+LGF2xidDIkJ59vojhWxPK83yfp6gbQf4/UqhJug828tbopUQ3Z1wXix+xZZYAyU080siLDz3tLAQu/Po1MAvI22VQmj/0kxYOGt355oqs39tJfyNiNpr700taFV05174jFDAi53UlcsZy2O0tfG6ezdMhAe2tJ9r5MWit6FmQI+jg2azjSEWTCzjhbmLZr3sDTE08oO1iHiuWjtvBMTyRIqNojWbAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w508ZaL1ZoIpEhRxkDCJ4Yu40WkhzNdXVU+J9ivvXaA=;
 b=DqP6xztIcORwrwOb/8t2MvwEFnvRJD+5dhKctegR2U2zH7mcPCrMENTURiVErwe6jlrnAQXSbKUdF/Jm6ypvX1rDsLqjGDeM5aUxlcZ6hUi48g5n0X3eew47FELNBzYfYk0HAvOT9MTr8vE3r6qRe/kgQyJeNDz9YncUzDNfIHU=
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 10:13:47 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::f1) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Thu, 9 Sep 2021 10:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 10:13:47 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 05:13:43 -0500
Date:   Thu, 9 Sep 2021 18:12:48 +0800
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
Subject: Re: [PATCH 08/19] cpufreq: amd: add boost mode support for amd-pstate
Message-ID: <20210909101248.GE3702717@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-9-ray.huang@amd.com>
 <a2718365-5975-5c91-350f-fe9098b4de7b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a2718365-5975-5c91-350f-fe9098b4de7b@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 520be7cd-dafa-4b79-acd1-08d9737a832d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1338720FE4087FC2A051209AECD59@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZ3Hb5wPH43w01HWNjfBkiVnuPDNSYGspv44i9fFYiP1gW6yA/mlaTy6SRYXOUqkzA/mVY4F8tD3G/IWomo89T0TjXHmv9M/Ku+HeXyfo60PFGLKg1le5lHtH7WV7Yllhr44HXJcPLnKvje/WFYyI3lWz5L6gzSkKgCiD/02ObPM3RpBYo2UZfFs/BoYigoldLaQLwIsZeej/LIlAqTjChQkRWGh6STRCCdVxvgIHaJM1E6IwbTT6RueUiSpz0LwbUM5W0TF6Kraj9Uu26yBmi3okqR4qz/qMHMi2aWFjIO/QYQtgrUYYaz5y1q+v499dbCHgUv0RaKF5W8uaRIO91TNZzLPJbehJmmYzhAcJfVpJ6zs6WLWeFqadNBrE3Gi9kkZhYmFCUEHRsSvcBn558hYnZl0M8IBtNb5kdpK/fZAGg2EXB7mpbXJ08isfLzTT898MPPo6OoYo2qSGHg8bmL1H56Q0S+NoiEVOPiHLe0zoMlenbg54R9qvjVLWbxBmOmIxcVYU4KiEoMpmsgEyfHV/ZUdBddMfZ02gKfBcCZP4bi5+ntr3bC2PUx7FLtZnAKCJYB/F4HQ3xvzmkOoRso6FONnwywEeTQszu/pfTFm222GFCNfHBt/nKV9e42SjUctHFdGO675SwP+bbkuLI0sBXBMdYDrqpfslPS+8nhmF/aVjypoWNmW3RgjHZXpC1gQj3GGLPqTAO3YbTd04WrEQqGjJ7tpKK4Tzz6KZP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(86362001)(33656002)(356005)(81166007)(2906002)(55016002)(36860700001)(8936002)(82740400003)(8676002)(426003)(336012)(1076003)(47076005)(316002)(33716001)(9686003)(54906003)(4326008)(6862004)(70586007)(82310400003)(70206006)(53546011)(16526019)(186003)(478600001)(6636002)(83380400001)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 10:13:47.2729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 520be7cd-dafa-4b79-acd1-08d9737a832d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 02:24:54AM +0800, Fontenot, Nathan wrote:
> On 9/8/2021 9:59 AM, Huang Rui wrote:
> > If the sbios supports the boost mode of amd-pstate, let's switch to
> > boost enabled by default.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 50 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index ea965a122431..67a9a117f524 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -75,6 +75,8 @@ struct amd_cpudata {
> >  	u32	min_freq;
> >  	u32	nominal_freq;
> >  	u32	lowest_nonlinear_freq;
> > +
> > +	bool	boost_supported;
> >  };
> >  
> >  struct amd_pstate_perf_funcs {
> > @@ -229,6 +231,19 @@ amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> >  				      max_perf, fast_switch);
> >  }
> >  
> > +static bool amd_pstate_boost_supported(struct amd_cpudata *cpudata)
> > +{
> > +	u32 highest_perf, nominal_perf;
> > +
> > +	highest_perf = READ_ONCE(cpudata->highest_perf);
> > +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > +
> > +	if (highest_perf > nominal_perf)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> >  {
> >  	cpufreq_verify_within_cpu_limits(policy);
> > @@ -402,6 +417,37 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> >  	return lowest_nonlinear_freq * 1000;
> >  }
> >  
> > +static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
> > +{
> > +	struct amd_cpudata *cpudata = policy->driver_data;
> > +	int ret;
> > +
> > +	if (!cpudata->boost_supported) {
> > +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (state)
> > +		policy->cpuinfo.max_freq = cpudata->max_freq;
> > +	else
> > +		policy->cpuinfo.max_freq = cpudata->nominal_freq;
> > +
> > +	policy->max = policy->cpuinfo.max_freq;
> > +
> > +	ret = freq_qos_update_request(&cpudata->req[1],
> > +				      policy->cpuinfo.max_freq);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> > +{
> > +	cpudata->boost_supported = true;
> > +	amd_pstate_driver.boost_enabled = true;
> > +}
> > +
> >  static int amd_pstate_init_freqs_in_cpudata(struct amd_cpudata *cpudata,
> >  					    u32 max_freq, u32 min_freq,
> >  					    u32 nominal_freq,
> > @@ -504,6 +550,9 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >  
> >  	policy->driver_data = cpudata;
> >  
> > +	if (amd_pstate_boost_supported(cpudata))
> > +		amd_pstate_boost_init(cpudata);
> 
> Is there any reason to not merge amd_pstate_boost_supported() and
> amd_pstate_boost_init() into a single function? I don't see that
> amd_pstate_boost_supported() is called anywhere else.
> 

Sounds reasonable. Will update it in V2 as well.

Thanks,
Ray
