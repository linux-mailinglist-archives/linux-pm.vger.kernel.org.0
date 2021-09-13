Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B2408B6C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 14:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhIMM7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 08:59:51 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:44832
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229613AbhIMM7u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 08:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1YmRcLCs2lAREqghbprcTRszPH1EFRPETaEWv3v7BaAUgGkwUQ5RmXoX2e9whNia2WH644io0fnR5y1ZJunc0EkdVbl9xavY09DsAdCXtNMJJYQkII6sPh4we7pmvIVgsw8O8IsD5Zr+XXJwMo6Z3t5AfAAa35qIkcD4gyEJ6ugFaE0wsp/a2pIUqniCCDkWN/3RVWdkN3POIiEeLol7jWgKIj1GJM2nMyrbtqQ89PNfHsx7Qc6S7KeCpNFn2uc18TCbQjXplH/QJbxNrd031U0y+ojQdyxBZMonrZahaSWfVGIFi72d2wmvibIT0Is0qRGYFBywcpA910i2mez7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E4VSsTO5KNDOPjv+jhQV+1nkI5BlVf01smD+cPvg4OI=;
 b=K113Wm+ydkrFriNhajEqUxM6JMmqW1pqT1w72MteEZoFHv6GWiLs8WrGPWCqaegsnuEuLsnUarIzFemS27MnS4rh4/Tk7h7aX8mVvOk3WzED2IJ32+rvwQ+rphALrKTwBgENgiVX6/kQKXufpRpyjo+qAYLYkMUKECOn+NFZoJd+wa01Uc5oAs9R4Yyq3BGOAjVctfC7tpVpENYsx/GHdMPmjlYsoTA/mzcIg+ID77gDGcjt4X1KZMdY19Vupy8uLSudaK58/b5WYi00tCBlJnITetFwoeKW+x4/6WeyWLdsmn5ss0M8QZCc/S/FwW/Hr1+Q7nvq/dLGHmeTurCq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4VSsTO5KNDOPjv+jhQV+1nkI5BlVf01smD+cPvg4OI=;
 b=x8P1qwUOH2M3N15vEueVvYWASSszcaQ9qr2UZ4exWRqSPx5x7JtDIPXBVFOPo/rhjqWdOZyteuWjgcRnSjh4VZu3E0mW3G+iw5IKpJRw7IjTit5tbbK8kshz/hHVbHsTb2Fzc8Ua5LduouSw2Dic0TbhpT/zBqkji/z+R9kPmm8=
Received: from CO2PR04CA0083.namprd04.prod.outlook.com (2603:10b6:102:1::51)
 by BN6PR12MB1364.namprd12.prod.outlook.com (2603:10b6:404:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 12:58:31 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::60) by CO2PR04CA0083.outlook.office365.com
 (2603:10b6:102:1::51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 12:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 12:58:31 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 07:58:27 -0500
Date:   Mon, 13 Sep 2021 20:58:23 +0800
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
Subject: Re: [PATCH 14/19] cpupower: initial AMD P-state capability
Message-ID: <20210913125823.GF3731830@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-15-ray.huang@amd.com>
 <b030e734-e294-9bf5-ce88-a9e2970da0ef@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b030e734-e294-9bf5-ce88-a9e2970da0ef@linuxfoundation.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0402bdc4-4fd2-4026-7a0f-08d976b63049
X-MS-TrafficTypeDiagnostic: BN6PR12MB1364:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1364F24E5EA3F6E07E66FCFBECD99@BN6PR12MB1364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJhCHPnx/4GxVDsXObvM38tzUAELb+3mo/u2806lSmvimX/KzbIMhc+mmHIE816ozRz4/7YqVZLRFOe7nXSU7H8pBUfnFtXmxYfjpQpFHTMoMrkKQL4PZnO4vlgzK0Mw/x0A0CAf9r0IzZ0GtGFpR7jr3colZdUBQaFMvOcKYLLmGdwwjUfydWOPxUULYW47FE73MHAweReeHKl+zwG+sxX1qq7Ja8/fKzMfD9qrjMUXWC1NyebvAzCMsgTX0MGEYpUawk0DoIGRZonte655KTFW+xrePhrv23yLMRaetOuYMMyF+9Q3+cf6C5U6SiJV3kEgk1xe1ZhtrasFu30q5AX24udnMtwLrmsQvvPbXk1Nc6K8tQ7n2LnraNQsC9fo70AKxDVybBvFoBacAOVCtcJ/6fSOiIwyU4hUKEQPY/KPYOu5wUYL7QWbz/1lLx7lyyTb6Y2ibJvc5iiNV7ogWNA9DVcYfxaulDPbuCgSvIZdZvNyc8kQsFIrFEM/0UpwyiuPHzWMWBWHGyNMSKHJo3WP2UgrSmbJtR+5lbOpF/1D/dTym5jMcqFNI4eBot8ru8ZnHBYPlsnLd+rsPEo8ly1IUUkkG6jruNmkHxocwe73ZekTx5rL2aazLufaUIOo+0bDttK74FnLHw3azjc5LNEhB74qdtXsQ3sOCjqtDmD5qLs9uMn/WFtt3wXjpgqHK/yiUuRX+Bre42HaQtWdEqwfX0tpl/onxJaCI77Mylo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(16526019)(33716001)(336012)(6916009)(5660300002)(26005)(53546011)(55016002)(1076003)(8936002)(36860700001)(33656002)(8676002)(4326008)(54906003)(70586007)(6666004)(316002)(356005)(81166007)(86362001)(2906002)(70206006)(82310400003)(508600001)(9686003)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 12:58:31.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0402bdc4-4fd2-4026-7a0f-08d976b63049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1364
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 10, 2021 at 06:16:50AM +0800, Shuah Khan wrote:
> On 9/8/21 8:59 AM, Huang Rui wrote:
> > If kernel enables AMD P-state, cpupower won't need to respond ACPI
> > hardware P-states function anymore.
> > 
> 
> This commit log doesn't seem to match the code change. I see it
> calling cpupower_amd_pstate_enabled() and setting flags.

Hmm, yes, I should reword this as well. If the kernel uses the amd-pstate
module, we only need CPUPOWER_CAP_AMD_PSTATE flag, and disable the legacy
acpi-cpufreq relative flags.

> 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/utils/helpers/cpuid.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
> > index 72eb43593180..78218c54acca 100644
> > --- a/tools/power/cpupower/utils/helpers/cpuid.c
> > +++ b/tools/power/cpupower/utils/helpers/cpuid.c
> > @@ -149,6 +149,19 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
> >   		if (ext_cpuid_level >= 0x80000008 &&
> >   		    cpuid_ebx(0x80000008) & (1 << 4))
> >   			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
> > +
> > +		if (cpupower_amd_pstate_enabled(0)) {
> 
> What is the reason for calling this function with cpu id = 0?

No specific reason, actually, any cpu id should be ok here.

Thanks,
Ray

> 
> 
> > +			cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATE;
> > +
> > +			/*
> > +			 * If AMD P-state is enabled, the firmware will treat
> > +			 * AMD P-state function as high priority.
> > +			 */
> > +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB;
> > +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB_MSR;
> > +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_HW_PSTATE;
> > +			cpu_info->caps &= ~CPUPOWER_CAP_AMD_PSTATEDEF;
> > +		}
> >   	}
> >   
> >   	if (cpu_info->vendor == X86_VENDOR_INTEL) {
> > 
> 
> thanks,
> -- Shuah
