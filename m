Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F596408625
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhIMINB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 04:13:01 -0400
Received: from mail-bn1nam07on2082.outbound.protection.outlook.com ([40.107.212.82]:20480
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237873AbhIMINA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 04:13:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER68MMG7DZElY6l+r9zRB66iYMdY7taR1VecXgL5CrWKOCx/+zs8hhQgrqyk9aYy2RNJ8ax1dDVI3KNRp+wgzNAQlvWgLR9Wt+tWkDV1mWXSGCZjxBlEK2hB6wnkEDGUn+3F3kivYpK7z+eWu87lfpfclGiBDic3G1mOXWXYGwgHLqwvnAbKN0oiq4CA80V3Rgf/1IvGJk7qENSTAA922uAd+hkekZBEAj/7XlwbnFZ607Kln267anuzZ+KU8EAlOWl6vMB/NpfI//qPK3ypxeJMam9BhIWnkBFFZ1IPax2eNn6gmIYit4+wAxZHqqyGjAbWEJ1JaT4Zv320y3sPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2FJlukFlDY2JtcYT9fw0dDMhAWMAQjIVqCixFMv5C7k=;
 b=VwBbo11tFXpKgj2OLSM0+SX+TYKK9NVlsqvWmrxP1Up8GxZOYfjetV6aNHSRU6z7a7IXrSHH/H4oSIFK7/s/EY/LLZ8N5FfJwFkdQsVc6l18jbrhXFpLdPwUHEbIwvqUf2myvNhIoq6rVCcy4qWH8g+DZTiK7SURPH21m3VjwBUFFltsvyIyWeLthO5krxBuFPetZa9PjqLHcHiLPBaHxWmkQpDwxJEsGaKSBg1D+wIZnKQNd0VT+7xJitkyLaYZAXgxiRVCcgNSEP7NhaLBfjxMBF0BMlHYLV+Cgl9RLX7ovu57nfrbafWfI4Gmd4dVHfTa6zC4q30gKCHRdHEqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FJlukFlDY2JtcYT9fw0dDMhAWMAQjIVqCixFMv5C7k=;
 b=Fy95zCahfFc+/FoWyvoKY/wJypwQP7dKyt9E2MAxPk4RdUUYTj373KWkh/fLTlFUVNIGB0DNA+pnuitjCypHn2CXtEAQpKogTVYgHtqmnEZdK64YtOMeZ9cF6kc5xTBafsbR66DAQ7EE3KmoytHGlL08/Z3edy7OKLpbXL/dbsg=
Received: from DM6PR07CA0084.namprd07.prod.outlook.com (2603:10b6:5:337::17)
 by MWHPR12MB1504.namprd12.prod.outlook.com (2603:10b6:301:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 08:11:42 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::af) by DM6PR07CA0084.outlook.office365.com
 (2603:10b6:5:337::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 08:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:11:42 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 03:11:38 -0500
Date:   Mon, 13 Sep 2021 16:11:34 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to
 support future processors
Message-ID: <20210913081134.GA3731830@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fbeb0c3-ca8f-49a9-36db-08d9768e1ed4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1504:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1504FD063FA6603BB154BC2AECD99@MWHPR12MB1504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EpLAgcnGryvDPk7xLINMJ2jkeJBdiq2yXMZYGLW27+y6F8sSxhF8ZKv0iJ9606C+D3FD/xCdgTMuMFxH/aYt/r8muOZxXoOJL2XUHtQODulNH//WfTrN+LDxNzMIGCoTUQPqBZvIdzV4f00arkE3jxI5hAAYn75+WiWtMkIqaSajcGqKVoGSnPJ1vE1wbU4aYld8u4ku1a3fTfK+sGVj8JzqtPmsXHhhs0iQp+xAOR6w+ApvAUUuR4MObJ+sGjKLzC20g59uw/xqWlNAMBqP2eKOdRL2Jem6A5tvdP22nVrwAZMr6PjuFv0jC918DIBVWYGGw6q5GWCjE4OywvVd2npaRU2vEVVevmc5Z9WBljlmTSluOacQss5k8LZOaj8CZ1Zq6Sqyp+bftku3qRoFwdVPLker88AOiGSKSVqyOfGHR5O56KMX2SPlA1Mam1YAfHoxlPMPt8AfxdC9fC+gv6bfzBqDu9Jj0jd5A9eFo35ACWtwGnQQC/59oBuIvBmJeTnbj+1ND9C1zKIuh8R4NsFv0Dv0E+iDB7Gk/ut5AdvGV34UXcSkaE1rtV+dn4ypXWbX9rCxktV6Pj9Qdho8uIaC1AMU7dUfEiD9EzJmyJYfJp3PUfsEYKa0Nbfx7Yybov8CMYam38Vf9pM7a0CJXPo2CpWD4phcurw5Mnyz4TjCLbWjtUkNrXakYvDXGocZRAnXm0BNSnGdEJgCo3wnTtvRTehthYrfcDZjDB+OEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(336012)(82310400003)(1076003)(55016002)(47076005)(81166007)(82740400003)(8676002)(9686003)(186003)(356005)(26005)(4326008)(86362001)(478600001)(6916009)(33716001)(316002)(8936002)(5660300002)(70206006)(33656002)(36860700001)(16526019)(2906002)(426003)(6666004)(54906003)(70586007)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:11:42.3224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbeb0c3-ca8f-49a9-36db-08d9768e1ed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1504
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 11:01:41PM +0800, Peter Zijlstra wrote:
> On Wed, Sep 08, 2021 at 10:59:46PM +0800, Huang Rui wrote:
> 
> > +struct amd_pstate_perf_funcs {
> > +	int (*enable)(bool enable);
> > +	int (*init_perf)(struct amd_cpudata *cpudata);
> > +	void (*update_perf)(struct amd_cpudata *cpudata,
> > +			    u32 min_perf, u32 des_perf,
> > +			    u32 max_perf, bool fast_switch);
> > +};
> 
> > +static int
> > +amd_pstate_enable(struct amd_pstate_perf_funcs *funcs, bool enable)
> > +{
> > +	if (!funcs)
> > +		return -EINVAL;
> > +
> > +	return funcs->enable(enable);
> > +}
> 
> > +static int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
> > +
> > +	if (!funcs)
> > +		return -EINVAL;
> > +
> > +	return funcs->init_perf(cpudata);
> > +}
> 
> > +static int
> > +amd_pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> > +		       u32 des_perf, u32 max_perf, bool fast_switch)
> > +{
> > +	struct amd_pstate_perf_funcs *funcs = cpufreq_get_driver_data();
> > +
> > +	if (!funcs)
> > +		return -EINVAL;
> > +
> > +	funcs->update_perf(cpudata, min_perf, des_perf,
> > +			   max_perf, fast_switch);
> > +
> > +	return 0;
> > +}
> 
> > +static struct amd_pstate_perf_funcs pstate_funcs = {
> > +	.enable = pstate_enable,
> > +	.init_perf = pstate_init_perf,
> > +	.update_perf = pstate_update_perf,
> > +};
> 
> > +static int __init amd_pstate_init(void)
> > +{
> > +	int ret;
> > +	struct amd_pstate_perf_funcs *funcs;
> 
> > +
> > +	funcs = &pstate_funcs;
> 
> What is the purpose of this seemingly pointless indirection? Showing off
> how good AMD hardware is at doing retpolines or something?

Hi Petter,

Thanks to look at our codes again. We adopt your suggestion which raised
about two year ago that using the kernel governors such as schedutil to
manage frequency control for new cpufreq driver.

We will have two approaches (it depends on different AMD processor
hardware) to implement the amd-pstate driver. (Please see details in Patch
19)

1) Full MSR Support
If current hardware has the full MSR support, we register "pstate_funcs"
callback functions to implement the MSR operations to control the clocks.

The reason that we use the separated way is that we can implement the
fast_switch or adjust_perf functions for schedutil and other governors. The
fast switch function can provide the better performance and lower latency
during frequency control.

2) Shared Memory Support
If current hardware doesn't have the full MSR support, that means it only
provides share memory support. We will leverage APIs in cppc_acpi libs with
"cppc_funcs" to implement the target function for the frequency control.


The mainly reasons that we proposed a new amd-pstate driver, not use the
existing acpi-freq or cppc-cpufreq driver are below:

1. As mentioned above, amd-pstate driver can implement
fast_switch/adjust_perf function with full MSR operations that have better
performance for schedutil and other governors.

2. We will implement the AMD specific features such as Energy Performance
Preference, Preferred Core, and etc. in the amd-pstate driver next step.

3. acpi-cpufreq and cppc-cpufreq are absolutely very good drivers which
provide the general solution for ACPI standards. However, 
- <i> if add amd-pstate similar support in acpi-cpufreq driver, it will
  impact the legacy P-States function on old Intel and AMD processors.
- <ii> if add amd-pstate similar the support in cppc-cpufreq driver, that
  will make this driver bring a lot of x86 specific or AMD specific changes
  (quirks or AMD specific handling) in the cppc-cpufreq driver, then the
  cppc-cpufreq driver won't be general anymore and will impact the existing
  ARM SOCs. And Rafael also didn't want me to add the x86/amd specific
  things in cppc-acpi before.

4. AMD will do the performance and power tunning or profiling on each AMD
CPU chip in future, different types of chips will have different policies.
For example, mobile chip and performance desktop problably have the
different frequency control policies.

5. We can maintain amd-pstate driver and handle the bugs which are reported
from community. Make sure it validated on each future and previous AMD CPU
processor, it can reduce the upstream maintenance work load. :-)

Best Regards,
Ray
