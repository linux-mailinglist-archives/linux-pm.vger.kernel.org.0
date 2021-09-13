Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D28408A92
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 13:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhIML4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 07:56:34 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:52928
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236539AbhIML4a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 07:56:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPUee8J6lUklqiheeuTHEGTj0+f3XfBCdxRau+mW5P8wr/m8zLM9zvsyg+b0DOHf50R6lDRjQYKPb2P0yBrjVfpZy0/pM4vQFU5y4CRm83p1ED5pshl9P4pEhylwyA/kx2heSI3mKonJP8qqzrSUDws83hclZEPBg5LPFsQHO/Ymn5C3TjAJEUiwXDMFp2zVZ4MuXZodtmMq1EVD/+hm6GUMqouipTvPT9LovmXJK5m1CvYXuh6rx0wGgU7mYh4DDqpTsqYyhJVXHpWfrpTJxjgUpbY7Y7m02aGDKcPEFEofCkhaml3N4IcpLuf922jQmSc7+Ffdl1BD5TGH0Ma4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=meMr8gnt47P6LWgEaiBs0fGFpfaVWAE1Iz6nSHt/Qvw=;
 b=a1x7ddo8dfLLzWjScrZ/rLz5rLJHYfgZ2vWB386cDF9HeHJUOQZaXeRTOEyTl5OOwDBl7pmnJgXUvVaSZYjaogbXoMbCu2mPpTdLigaC+s4uy6UMNN9KR7FbtyJhfFy53JP5DdMERZ9aXfqEj8rqf1qQifNMHfpGgvb9m6K9isxUXzakDbK5beRl21HV9W2XDBt7ff7MdECiYAFGBb6+KdinC1rtxS3SQ6Nab+d8dNU4gofEhEyNkrdUWUXnBejcYNwjR9wkVIrtaVfuxZ+UGDeXpR6qTHXbchUachcoDu08MvY/it8Tw4Ix1H2/NiNqzXnkA0hzlb+0JgJBW6z3vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meMr8gnt47P6LWgEaiBs0fGFpfaVWAE1Iz6nSHt/Qvw=;
 b=wE7lA3jqEVMqKot8AeaTJu4gJWuuo1R20v9y/tuzWI/glnqsedrJ8jbgx6DjQG+HR/tCidZG1HiQ/2SUHSGXo06HkxH0tq0lp/8xceE+LKd2KpSdYKNbwa6qNvnWTo2i3LDSlsosWvRDAzujZZ/u5f5zcPt3FIVrt85/mq0gjLc=
Received: from BN0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:141::35)
 by BYAPR12MB3461.namprd12.prod.outlook.com (2603:10b6:a03:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 11:55:13 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::a0) by BN0PR07CA0008.outlook.office365.com
 (2603:10b6:408:141::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 11:55:12 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 06:55:08 -0500
Date:   Mon, 13 Sep 2021 19:55:05 +0800
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
Message-ID: <20210913115505.GA3732007@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <YToiWpGxHV5oE2z8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YToiWpGxHV5oE2z8@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bd1e758-dcca-412e-13cd-08d976ad5812
X-MS-TrafficTypeDiagnostic: BYAPR12MB3461:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34614AB1876662B1592F77E1ECD99@BYAPR12MB3461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqmz5v+IrK8vvNZH/P51PiRk7GCC0RvYqQVzoiT0CIj19r7TQ+x/VKTySUlPInuUGzy9wLCqqWWla0FtWEdENk1hx7U6iBtz5jkcFsjpJY/Z1aGiPNAbOlG5TAxP5dcoS61yVHp7PA5vfeHXDEVkHy3yuyl72mbTQLeQkprk0eTPeMlKX8UWfyZBKGi8qdVnHE/O4akOneyePKJr4aFXqFni9qb1X39wK92T9uogRh2kBi+WnZzugreqzHGk1QUzl2XTVwgu/uYzvO7JBjWrqGaOuEoyAeESGELV854zV2uq37t1MHHDkXQLf7itnzTSN2vnBBNWGTzsAkPedizE/3bnxW9iPAtnhELC2ZoxI4L8hjSsuQo6DTeGW6R1KrghhotS25cAkk24ENEocmCV5LeeKJr2mbdNFPEPGyUctk6lUHB4AUKwEbwDFp743lhB3UFfPcj0xvQ2haYFgKBAjeg+sad9mUE+aaEo8twwRyUVycXiz7K5+/JGT4sq+yLuj3KFPv4EDIqxCBZluSen5IRKdn3HeiiaTcKmDTbbd0ZBmwzLhLWGQCKsjq/CZk38yFJdP7y7Xj1o7hxNFy6O/qxrFG84tqJRWXPZ5BKJWThzR8uJp5AsMwcrl+Ypfks5TDZuYn81n2wOJlwhubI0nRyWVtF3vel/ukhI9tqYEWDPrHtJHJwMq+vY+/ElsRtWR+pgouNQKLMg6TqxHPfl6PA91xdl9Fdapz7mNPU5ViY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(36840700001)(426003)(8676002)(83380400001)(336012)(356005)(9686003)(70206006)(33656002)(26005)(6666004)(82310400003)(55016002)(4326008)(70586007)(33716001)(8936002)(478600001)(5660300002)(81166007)(82740400003)(2906002)(86362001)(36860700001)(1076003)(54906003)(186003)(316002)(6916009)(4744005)(16526019)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 11:55:12.8215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd1e758-dcca-412e-13cd-08d976ad5812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3461
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 11:03:54PM +0800, Peter Zijlstra wrote:
> On Wed, Sep 08, 2021 at 10:59:46PM +0800, Huang Rui wrote:
> 
> > +static int pstate_init_perf(struct amd_cpudata *cpudata)
> > +{
> > +	u64 cap1;
> > +
> > +	int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> > +				     &cap1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Some AMD processors has specific power features that the cppc entry
> > +	 * doesn't indicate the highest performance. It will introduce the
> > +	 * feature in following days.
> > +	 */
> 
> Wrong comment style; also imagine reading this comment half a year from
> now...

How about use a "TODO" to indicate the next step here?

Thanks,
Ray

> 
> > +	WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> > +
> > +	WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
> > +	WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
> > +	WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
> > +
> > +	return 0;
> > +}
