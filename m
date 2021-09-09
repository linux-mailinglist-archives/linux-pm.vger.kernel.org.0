Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3936A404822
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 11:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhIIKAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 06:00:23 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:56655
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232630AbhIIKAX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 06:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrtm6i0FOJNQEEbcW5B/AeUTGpgDWbOAEY+a6G7LPMeq+qTTSCPB0qfXqrSOWBpvAS1pg290ll6d492iTxwMEJbZDf8SzTfI2AGPYr5FnO01P9NF1SHXtif313W7ytXHyWa4+oXpc/RQGgNOySCwn8L5lFqKQd6mfQXMoMPkuaxxDgwwMY7oQigtIVNIkv8aYGGyK4/z5HYcMV5fHgBUC/B0fCTFtvBE0a+ZXzeWSrRO4bi9oWI+0aGGihgvQg2nge5AziFvn3k4en/wl9ZvIphzBoLDfhvbzwJl1T8JISwm63D/lnfsnh2msRy5e+FuN4o7QfEer4HvqUCQKCihfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nOQoa0XYR4Lbzw8nDM3vWdwB2ok2bND8sQwbjwl1QGg=;
 b=Z9yNLKePaKhn1kXTjX7qxHFNulY2sIXcWD82zNDjoGzAsiryppL32sQ42yGpSrJyv2a4InLYTAfmF6dXJRSIiqSh1p5/A4q+zr5IT/w6IXdpgOpi260s9TyfdafG/YxaHghC9VGVTE+16y1bUlwWFGOYtKMPHBK1t1vcsoj2ohBdsWF+KkXMM3AM+1/UnOabQ2QA5TCAhsa1sFL3RUe6iXK3niiVVdJ438g66sTXKsUF5xaoUWjRLH9Pygzp2G7FNtH1Mesh9E1cBx8h9ui0g+uA8mj+gXeDJt3EEz6A5iA5N7c+lVtPhLeRKq14BKfQAb4Yk/UeciCHXXe24VrA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOQoa0XYR4Lbzw8nDM3vWdwB2ok2bND8sQwbjwl1QGg=;
 b=b/1MnDNhRaG9vYjbWfg3mAiyjDyZipmhBYGRWpIak0yskyTvK5tMNXya5s/yY2yX9H0uSIm3aidqnsZHZK3K6tSsCkulypBPVVMuJLyfFGduYEb4eOVgExkoGK8oWWhQvVIGCvitmq68CVLy8cKtgaSChAHV97hcyIbxxgDHrrA=
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by MW2PR12MB2553.namprd12.prod.outlook.com (2603:10b6:907:9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 09:59:12 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::65) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 09:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 09:59:12 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 04:59:08 -0500
Date:   Thu, 9 Sep 2021 17:58:13 +0800
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
Subject: Re: [PATCH 03/19] ACPI: CPPC: add cppc enable register function
Message-ID: <20210909095813.GC3702717@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-4-ray.huang@amd.com>
 <e23d49d3-1591-bd12-549a-efd2a1f28dea@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e23d49d3-1591-bd12-549a-efd2a1f28dea@linuxfoundation.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1144265b-45ba-4d15-8290-08d9737879b5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2553:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2553696ACA4D86BB3D80FFDCECD59@MW2PR12MB2553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDzY+D/ByjFm2MthZHKfpg0ri3VfTbiECsO7Gfn/fMWfAGiP+W7OaT1cLxpeeh6g6uj+tSg0rqc4pWKLJC/ekM2P3BKHX4NSS+KbupVmczFQCQuKyCiIIucUz6bxXJshBPDvAjSR7PNORyP8rAc3DeYhHjN1/IXGl8xv5e9V7aQbogyn6ICRBBn0r/a4a0G02XaOtsolO1uBED+4b9jg5tj2kQ39tjayWEW9VaDxyzMDby5dAGSjrlFAXVTkHu6rP3K1PxWuzvHYpk8JmDt+S7ST9QPnToYPzfcz0Yossgr7VAa5Z/LqV9JXXr34T+xKQNYbkh6vWu8aF5vFKH1hpeSPidwrGsXdUb+6Qlo/k5Z7cJk6rUWxNVwUKcWnCEyOq+VkjH8TApf0Cm6VN+GLqFsXSm7pt/eRm9PiLYtAm8aUJ1HDmlP+gsXC5aCTO33Q7dxgFmmhacLO/2Xjw2H4qw1gf7tFlgOpHUAd98sRV07hpYMQTbTSsK1ES9KwkvCfJCzbKlSSSOmv3GicdSCs/qL+H/sI39qzWtUIz0OUCV6HHTM3p0jWEsS5DlVhWBPAD/gvk/Lhf2/R8xhttuzwmVV/G08r15F1XIEksWwwfY3JnvMaAHVgtKRb1k6S8OVyQMcgBnNkEyVeee+SlzAD6lPniWB2UHbyC34K/De9ZhBhU59BBgZN6w3hxZ7aOC4k5+AQbDjIed7MR0OsJdZsSQy4Gk74tH6mkY1es3f4LpY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(70206006)(426003)(54906003)(336012)(36860700001)(5660300002)(55016002)(86362001)(8676002)(82740400003)(316002)(478600001)(81166007)(6916009)(53546011)(356005)(33656002)(4326008)(26005)(9686003)(83380400001)(186003)(70586007)(47076005)(16526019)(6666004)(2906002)(33716001)(8936002)(82310400003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 09:59:12.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1144265b-45ba-4d15-8290-08d9737879b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2553
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 08:21:48AM +0800, Shuah Khan wrote:
> On 9/8/21 8:59 AM, Huang Rui wrote:
> > From: Jinzhou Su <Jinzhou.Su@amd.com>
> > 
> > Export the cppc enable register function for future use.
> 
> This patch also adds a new function. How about saying something about
> adding a new function.
> 
> > 
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++++++++++
> >   include/acpi/cppc_acpi.h |  5 +++++
> >   2 files changed, 47 insertions(+)
> > 
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index a4d4eebba1da..de4b30545215 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1220,6 +1220,48 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> >   }
> >   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> >   
> > +/**
> > + * cppc_set_enable - Set to enable CPPC register.
> 
> Please make this more descriptive - does it write to register
> What is the behavior in error paths etc.
> 
> > + * @cpu: CPU for which to enable CPPC register.
> > + * @enable: enable field to write into share memory.
> 
> What should this be? What are the valid values to write?
> Also aren't we adding this to header file where prtotype
> is defined these days?

Thank you for the suggestions, I will refine the comments and commmit log
in V2.

> 
> > + *
> > + * Return: 0 for success, -ERRNO otherwise.
> > + */
> > +int cppc_set_enable(int cpu, u32 enable)
> > +{
> > +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > +	struct cpc_register_resource *enable_reg;
> > +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > +	struct cppc_pcc_data *pcc_ss_data = NULL;
> > +	int ret = -1;
> > +
> > +	if (!cpc_desc) {
> > +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> > +		return -ENODEV;
> > +	}
> > +
> 
> Don't we need to do some error checking on input args? What is the
> valid range for cpu and enbale?

Good point.

> 
> > +	enable_reg = &cpc_desc->cpc_regs[ENABLE];
> > +
> > +	if (CPC_IN_PCC(enable_reg)) {
> > +
> > +		if (pcc_ss_id < 0)
> > +			return -EIO;
> > +
> > +		ret = cpc_write(cpu, enable_reg, enable);
> > +		if (ret)
> > +			return ret;
> > +
> > +		pcc_ss_data = pcc_data[pcc_ss_id];
> > +
> > +		down_write(&pcc_ss_data->pcc_lock);
> > +		send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> 
> Could this fail?

Will add error handling in V2.

Thanks,
Ray
