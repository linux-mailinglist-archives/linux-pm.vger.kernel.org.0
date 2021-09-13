Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2615A408A39
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhIMLbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 07:31:13 -0400
Received: from mail-dm6nam08on2067.outbound.protection.outlook.com ([40.107.102.67]:44416
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239598AbhIMLbL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 07:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P01SVEDUpSf19/sBbEUJyQ1FbMGna2cZw4PySFLfvEbWVyYy1FnoC5GB1NKzC2UDqVb9SfBAr96KA90KW0WM82XkdUzaeW36eUTEvz90llrcA6xcmXr65kLLW4oMd4EHDTBJskC1RtG1MUDHSdhsJYShMwqzPjzF3f8yHtm6yzjYUhG+VszqmGx4CihoWDAIJhuYf06L6yY8UaOjzwvqELRggehPEszXX1xAwzDw+KYkbwVxHQZwX7Io6/tLuEO7r+n4ob0ukTjGEYDsLbC1WfE9d/tvL0zTB5NqpUowX6h2tAQ+frGqFJpyPPGlTqkyBwTXzDZunKIyg8MAIktLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=huu3d78C9ehv5mPFwpRJb1QTF7HYkTOxJryv2LOni1s=;
 b=LhpVg+2argcO6h9AlXtIAUmt0o/kqzeS4V1UvnZn8VQurLvD2UuhvUqS/eXxm5xriQ0ma07ap0D9+IBN/jXHcjY2GRv88YKdJpcLjlB57T/jNI9x8fgaHz/JE/BJR+f1YBtgTbhDiphply07x/MoqRxbGmkqhgF3Z4mhqrYpQ3uPyD6oWSFZvWOw3cifXVL7CawveQ8R92QRNl0QBagIXLhSvs1YxcH3ZM+M/R891i1u4scCYkfhePLID6Co7EyYyxEc5fAuiDmZivlBdZbmJVYM9J8qVTw2M4qLncOM3iYc82pO14jNQAlk+Z+7E5nN/Zzi5zCbp7su+90qPpUKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huu3d78C9ehv5mPFwpRJb1QTF7HYkTOxJryv2LOni1s=;
 b=5bohTtEsMvv5yStbvtgWLr3gxZeok7cSF3UzdlH1PipxwD86o87dxKb0/0l46uQ3wws84HMtUH2JqLEPsS9N7viyfBIFnA2JZ/Px6jAHyOhBcmRr5l6ltWpKBVogDMjVIWvXB1+fyW3+A8zqRHrAGX1+lWWZg88uwmk93Hyece8=
Received: from DM3PR08CA0020.namprd08.prod.outlook.com (2603:10b6:0:52::30) by
 BYAPR12MB4984.namprd12.prod.outlook.com (2603:10b6:a03:105::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 11:29:53 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::5a) by DM3PR08CA0020.outlook.office365.com
 (2603:10b6:0:52::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 11:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 11:29:53 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 06:29:49 -0500
Date:   Mon, 13 Sep 2021 19:29:45 +0800
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
Subject: Re: [PATCH 13/19] cpupower: add the function to check amd-pstate
 enabled
Message-ID: <20210913112945.GE3731830@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-14-ray.huang@amd.com>
 <50412248-179d-3548-aeb0-d912a14a152f@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <50412248-179d-3548-aeb0-d912a14a152f@linuxfoundation.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87bd1362-60cf-4119-8eda-08d976a9ce4b
X-MS-TrafficTypeDiagnostic: BYAPR12MB4984:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4984B6371C03FF73665249FAECD99@BYAPR12MB4984.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xies/+w4Bl2/IolIgBL76ADv/kR1iwTrOZs0b1bU3LnVBn1EAVfOF2mTt6PhVfx2o35Cw2TLx2u30RIb/s6Eqa/rnkI8lnh3b6/x33vxvFBEsfXH+qxy+3/qcVMz+1k2hOETFjC/3PJWpDKSJrj8bWVxFS4mRAV6/UarYHWCkL/qwKMjjCj9OcZyDfGdu6yZyhmf5pef259dks85H2DpSEDyTfXfVSgllIgE5p3UhLAPWREEAzfVXM/NaicY8qujDpejoTZFZfbwE9LCbHyWa7mi7UQQGwReJxuXbalQXr3FqgQvLvKXbbN08EC9VpVRIGoKK6QmxJ87HtZ4jU4xg74YG+MzRZZQZESvDRCs4/pSVYYMv9KwWgr60gHiEeh554uZqsS2TszqjyvluONrQnXfftVRpTpFKm2ASxSSZlwQul4X5jMNKMyOwd1x8VJCE645pcJDaqGF8zcVTsUXrA0YJHg1S4+POIpFmETDLC1gCCaLxB6z96b/TqJSiWg+RFKWBSiixXta4OkugD5KxXg/7ahLVXugEBt4Wb4KziFPbWrntT2o9faxe2WXt7Kw7TQo7ovG/r5rk51lkQVk5OdNP2qiUde9MQKcA6Fbr9Wki0IGpqSyYzPcbHo7w+ifMFFUVa+OBU3+81zrna+iY066Ky+WzSy++xKcCMFSHdOePUgwG8+eIUplbU6Iwd8QAVq6O1Vz682iUwwh6tF3uYbfNywiQUG7px6hSCkuXjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(47076005)(81166007)(8936002)(356005)(55016002)(36860700001)(86362001)(478600001)(426003)(82740400003)(70586007)(186003)(70206006)(336012)(4326008)(33656002)(9686003)(53546011)(316002)(6666004)(6916009)(26005)(16526019)(82310400003)(33716001)(2906002)(8676002)(1076003)(54906003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 11:29:53.1255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bd1362-60cf-4119-8eda-08d976a9ce4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4984
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 10, 2021 at 06:16:21AM +0800, Shuah Khan wrote:
> On 9/8/21 8:59 AM, Huang Rui wrote:
> > Introduce the cpupower_amd_pstate_enabled() to check whether the kernel
> > mode enables amd-pstate.
> > 
> 
> What does "kernel mode" mean? Are you referring to kernel vs.
> firmware mode?

I am referring kernel. In fact, the proccessor which supports the AMD
P-States also supports the legacy ACPI P-States as well. So this API is to
check whether the kernel driver is using amd-pstate or acpi-cpufreq.

I would have explained this, sorry to make you confused, I will explain the
details in the commit log at V2.

Thanks,
Ray

> 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
> >   tools/power/cpupower/utils/helpers/misc.c    | 20 ++++++++++++++++++++
> >   2 files changed, 25 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> > index b4813efdfb00..eb43c14d1728 100644
> > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > @@ -136,6 +136,11 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
> >   
> >   extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
> >   				     int *active, int * states);
> > +
> > +/* AMD PSTATE enabling **************************/
> > +
> > +extern unsigned long cpupower_amd_pstate_enabled(unsigned int cpu);
> > +
> >   /*
> >    * CPUID functions returning a single datum
> >    */
> > diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> > index fc6e34511721..07d80775fb68 100644
> > --- a/tools/power/cpupower/utils/helpers/misc.c
> > +++ b/tools/power/cpupower/utils/helpers/misc.c
> > @@ -83,6 +83,26 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
> >   	return 0;
> >   }
> >   
> > +unsigned long cpupower_amd_pstate_enabled(unsigned int cpu)
> > +{
> > +	char linebuf[MAX_LINE_LEN];
> > +	char path[SYSFS_PATH_MAX];
> > +	unsigned long val;
> > +	char *endp;
> > +
> > +	snprintf(path, sizeof(path),
> > +		 PATH_TO_CPU "cpu%u/cpufreq/is_amd_pstate_enabled", cpu);
> > +
> > +	if (cpupower_read_sysfs(path, linebuf, MAX_LINE_LEN) == 0)
> > +		return 0;
> > +
> > +	val = strtoul(linebuf, &endp, 0);
> > +	if (endp == linebuf || errno == ERANGE)
> > +		return 0;
> > +
> > +	return val;
> > +}
> > +
> >   #endif /* #if defined(__i386__) || defined(__x86_64__) */
> >   
> >   /* get_cpustate
> > 
> 
