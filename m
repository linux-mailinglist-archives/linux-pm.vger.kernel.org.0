Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B843540480A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 11:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhIIJwP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 05:52:15 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:23008
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233312AbhIIJwN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 05:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E73k5m2U4nPTxF8PzgYDH31gcAH0tgV7qeB4rrbeWoiLf1o9Ko1X/l3JB5ryUtLFg1raHNjgefR03iu/BrpLJVKyoPauW/FFOZ3SQgwv1gu1wcYzgriFx11MhQW+OtSuU3M7HNA7NSdADUFhM/Z4QkknlyZ5fMLo4p2s73DopQnhfccvM42oTVXRxfAWpMTbTU1o46YdoeXzN2nJGkDl9CCBYyFrA2/T6OALqfQaES2ysv7OyRAn6lu5xUAba1DHZshU4lifdJNCjMa3p3qoTpaHEK8bdEVdjaaMqsHGDPE9D0QGMjZGjx6pxm5GEzAcWjNdxkjdwx/Ez9Y3fze5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/4istKz3GQ1avnSSWP6D4xMPzHAixO6sfAz8BvcblBg=;
 b=gZA0fSgru+kGrfigPi+dx5SZFjKCni2edr/N+1WGyFrTSvKahcSsJ0NCKMQQzpFYnS34l/s5xZz5G4mTAsfuN456QQoSxPnjBOx550MAE/eZJb0kFrveW0CrL9jOxW8EDPDHi8taYdyWcgsLohCqPGm5A8evcFIC/SkfVkyLtYAcZL9tnxTJm7uZOX1hS20bcG5PeP/yjp5gGHYeBMxQI7lt31cz1xwoNpLA117T2wGUT+rnKtblHYjI6dwMkiqWupZOVjYwiEg3i0GrSsPymlWt4QS7y6QiItKfoHvVAaikx+eeyprQEwE9/++d8jyHhoTx52t3+HKRBkTIhoA7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4istKz3GQ1avnSSWP6D4xMPzHAixO6sfAz8BvcblBg=;
 b=vcFUKvZZjEd/r7P1MnRBr2NNGdEM4FB3BTn6Hc+3QuHYFYa5Y+FoHCWCD46/IF97CLQzBpOieUyGJPN8D6Q0UMjjb1a5cMM7p9MkNCfTalhQd4Cg+HRlaUuGN0WTPjT+pKqvGsXg+it0kU6jOurg8MauPBGg/+5rDGZ6chnkhMA=
Received: from BN0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:408:142::35)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 09:51:01 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::35) by BN0PR08CA0016.outlook.office365.com
 (2603:10b6:408:142::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 09:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 09:51:01 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 04:50:58 -0500
Date:   Thu, 9 Sep 2021 17:50:04 +0800
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
Subject: Re: [PATCH 03/19] ACPI: CPPC: add cppc enable register function
Message-ID: <20210909094946.GB3702717@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-4-ray.huang@amd.com>
 <53962105-07cb-d964-28d0-1cc4d2e7fe8b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53962105-07cb-d964-28d0-1cc4d2e7fe8b@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d5aa2aa-5232-4339-dae7-08d973775540
X-MS-TrafficTypeDiagnostic: DM6PR12MB4233:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4233A7768D5950746317858BECD59@DM6PR12MB4233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/IWefASlVr+saURtxg9GuUf9ReU7/egM3xMe22KFvQTkq8BHBoldEJoSghD9+xpp6LO9qoxS/TuPnE15Us0CiFwAOBeEeSDgNXaQy7PcqHCeu93eQmNb1vf27FSH/X4MtqjOe2yizIpRiq0WeVT52IGyM9yvu/tcLx3MIjvTMwFB31GbGnT0EVIwL/aB8vMKVp/pTSZRziYUQZtq6BKWSb1ymQnL2V0BHf+bB6NRqh5EBGlcRsFLGCTxHQ24QYmFS+l382eOCweEncEbPUWpOIObrgxf3MHo1F2KtFT7rCu8VMxTg/1pf+wiJxUO49ilF0bsu7CD3d6Fgxf746IldeT2lg/81lIiZUvsb5CNF7WPSuA6AGHmrbiRF1rjR55weWbgFaedzyUkhpaZjVBu9hXAHdwNvKpS/gI3OklEJpi4Hd7FLuh2aJ+Y6Tu0ObFz4dew5VHrcVS4AzEPA92LEWepVLnUwQDe+VSSc7zoeA+VzAdClVs7CCn610gKKUNGWdBeZ8UuYss7HG3VCbtq87/BzgMol3KDW28zAlWR7Lvgwtdt2PK/JFUa/LqbXNcwtrWrfaSXQRwJEULxn85cK9IOOUkqzmrM7il/IuDuB2tf9jtteLaXx8yQkSK2Ek+qMvhZbN9yOVDC1yQqkLODR+yZdXFwHBEkur1yv3HcCHCOH8dVXo3xxydEIIik8roq49lsvX1Yy5Lqw8z2NeELWPqBWkpFafs1EC1k9owN9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(46966006)(82310400003)(6636002)(4326008)(6862004)(33716001)(2906002)(82740400003)(336012)(6666004)(5660300002)(33656002)(70206006)(8676002)(26005)(16526019)(186003)(53546011)(70586007)(8936002)(426003)(83380400001)(316002)(36860700001)(47076005)(86362001)(54906003)(1076003)(55016002)(9686003)(478600001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 09:51:01.7822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5aa2aa-5232-4339-dae7-08d973775540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 09, 2021 at 03:14:37AM +0800, Fontenot, Nathan wrote:
> On 9/8/2021 9:59 AM, Huang Rui wrote:
> > From: Jinzhou Su <Jinzhou.Su@amd.com>
> > 
> > Export the cppc enable register function for future use.
> > 
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/acpi/cppc_acpi.c | 42 ++++++++++++++++++++++++++++++++++++++++
> >  include/acpi/cppc_acpi.h |  5 +++++
> >  2 files changed, 47 insertions(+)
> > 
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index a4d4eebba1da..de4b30545215 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1220,6 +1220,48 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> >  }
> >  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> >  
> > +/**
> > + * cppc_set_enable - Set to enable CPPC register.
> > + * @cpu: CPU for which to enable CPPC register.
> > + * @enable: enable field to write into share memory.
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
> Shouldn't we be checking the return value from send_pcc_cmd()?
> 
> Also, if the call to send_pcc_cmd() fails do we need to update
> enable_reg? i.e. cpc_write(..., !enable);
> 

Sounds reasonable. I will modify this in V2.

Thanks,
Ray
