Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36AB40F075
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 05:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbhIQDnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 23:43:23 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:51936
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242037AbhIQDnX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 23:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/DoKatKQdHTeBcVltkT72H6vq87Wg8W2qmv3lyqw4epGF/MZJ8dKeMwQanEWZaRPNBz0neeBfYy/lrO38wndaEuxhg+MeyCEw1leZnCo92IA6ruh8RKdXLePYpN0k+Hko1yDhBamxfvifswVPwitNrd8w2sPm5agEvfUVTSccok6kuTjPhmvDNqJ2wUcHB/zW5vpWxV1G+awT+xAQwrt1YjnGhkagvynYVl/PDaaVE9iss5+md8XlGK0hDvB+pNxNbyWT4c7Dd6g7VrbeDhEHgGkVwX5MnwpIdsbbhw7/5TFPDLTz4GUHVZVcSSACd3sSepLjmCMnb2ybdsfqHlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ef2HpOQGN36RdNGIe6R2QcvfM0Nw6t+3nv5hRlSnue8=;
 b=b+srmmbMZVbp7mljbiRnVm6zUHLS2M19ld7TgzDdiKhm5G8XYc7A8yEAf8C+IpcBX2HFMGnVAmSeIgdVf98rmQoI+mMyyktVIDehuVvx9MRgaBH3s3e9IfwvBIrIHgLfRdKNTDWV7iyJmxCY8DsSieMUkcMBoNxLyk37mvFlMHkG6mdFs/eLAD00HtRD658LlAZFDN5M5GXj/35m5N1IICNa/bejlAEcg7StPcqYghu7t62IQmCto9IMH5UgpbeJj5af4/JCU/ZeqFINCRxwf6mjaD0yNcyBhtPsEObPmQrV/OfeJ1R+Yx4+kIOtv4RztvSYIlElxczCRc6gHcIEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef2HpOQGN36RdNGIe6R2QcvfM0Nw6t+3nv5hRlSnue8=;
 b=2HYIyUKiV3q3+dYHgXK13Vn5GmOWKIR/ELCZ7c8EJkWR+v1y+uqm84o4EfW7WMBaqAqELGUFn7/PaTinTZBCtnOEi81YTk5pEwwB5WyxCUMpE95tY40bhrrtMO+yI1WRn37MTJf6urDW2mfHjbDQsHYb47TDz9Rl0oxzR3qD4/8=
Received: from BN9PR03CA0185.namprd03.prod.outlook.com (2603:10b6:408:f9::10)
 by MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 03:41:58 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::8e) by BN9PR03CA0185.outlook.office365.com
 (2603:10b6:408:f9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 03:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 03:41:58 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 22:41:54 -0500
Date:   Fri, 17 Sep 2021 11:41:56 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Shuah Khan" <skhan@linuxfoundation.org>,
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
Subject: Re: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to
 support future processors
Message-ID: <20210917034156.GA3761456@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
 <20210913081134.GA3731830@hr-amd>
 <YT8SOMBDpB0HWm0d@hirez.programming.kicks-ass.net>
 <20210913105458.GC3731830@hr-amd>
 <YT88cJCetaGHUItH@hirez.programming.kicks-ass.net>
 <20210916100947.GE3755511@hr-amd>
 <CAJZ5v0i7OHBmQL-WdaiBsYaO2J6kCqW=YzA8jU6nQBJ2nw0JQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i7OHBmQL-WdaiBsYaO2J6kCqW=YzA8jU6nQBJ2nw0JQQ@mail.gmail.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab6f745c-1a96-4270-d464-08d9798d1a44
X-MS-TrafficTypeDiagnostic: MN2PR12MB2909:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2909890F53C2E60C5DFE8765ECDD9@MN2PR12MB2909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mu1xqBhRMXkt1RjJcO6TofN0EbtKbHQlscYoL2dLG8NJNY+1Aj/FjDsEVd5ZxtQTK5ta/xzH+fxMrtbkIYm6h8S7/cXHUy3HZ5nDr2fXiKpCSIutoAF7knSpn+bHWNNmCBTFJwFShh1nqdTbAVUA03P3cJ5/P+jcsczSftMKD0n0QRn3vx5O5IM4F80FFqJw6JR/HGZySaKhL7vDSCEWpWsnppV8N8pHSRGaiMVCzPzcaSGIt8uvVyrkHcocTrGq+VDMeH/0G4nZoHDEg+36yJgbplfg6R7wASqOTt99fyoeDIrKXIjiBRWeiwZEI+VXlkZHf13N2pyRweLYrK7t3GNW6K79GUfe4EZ3x3Qht2ukb2fR2tP0HWtZcw0llEFEIrP/X1MPD0sgulGSeyLJv0RWkYhzS7DhqqN2wpt//WPgDAxRwCNljGXxs7fChHXLuzm/uqXzhpzsnQAvXFDcdzKtj64E2cBp0yBxWapqE8VsWH75I9Jhn1slwZlXQ5c17vVsoJ/X+2LyVMDl4l+FSd8KHmHypmlkY8nMmR6oITnZNoDKDpOOYR5q2wrr27BDVw4HqwrIJ3A7NjzYIzhaNb2+PHZA2vCcjkRPNX2xcaCKgHXrpjnEvbwpM5S4y86HqTmitW6FuE5a+Cp8OtsNbedXPmIqCJdrobGZ+DWmxi/18pXT/AECf1FeQlxJbO8xV/gcgVejZPOUn8uhAgvydX/WgUKN+zi32jFWuXBWOg8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(36860700001)(47076005)(8676002)(336012)(356005)(81166007)(9686003)(7416002)(6916009)(83380400001)(16526019)(2906002)(54906003)(8936002)(1076003)(26005)(5660300002)(33716001)(82310400003)(426003)(70206006)(70586007)(82740400003)(86362001)(478600001)(33656002)(316002)(55016002)(53546011)(186003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 03:41:58.7274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6f745c-1a96-4270-d464-08d9798d1a44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2909
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 16, 2021 at 07:19:21PM +0800, Rafael J. Wysocki wrote:
> On Thu, Sep 16, 2021 at 12:09 PM Huang Rui <ray.huang@amd.com> wrote:
> >
> > On Mon, Sep 13, 2021 at 07:56:32PM +0800, Peter Zijlstra wrote:
> > > On Mon, Sep 13, 2021 at 06:54:58PM +0800, Huang Rui wrote:
> > > > On Mon, Sep 13, 2021 at 04:56:24PM +0800, Peter Zijlstra wrote:
> > >
> > > > > > 1) Full MSR Support
> > > > > > If current hardware has the full MSR support, we register "pstate_funcs"
> > > > > > callback functions to implement the MSR operations to control the clocks.
> > > > >
> > > > > What's the WRMSR cost for those? I've not really kept track of the MSR
> > > > > costs on AMD platforms, but on Intel it has (luckily) been coming down
> > > > > quite a bit.
> > > >
> > > > Good to know this, I didn't have a chance to give a check. May I know how
> > > > did you test this latency? But MSR is new hardware design for this
> > > > solution, as designer mentioned, the WRMSR is low-latency register model is
> > > > faster than ACPI AML code interpreter.
> > > >
> > > > >
> > > > > > 2) Shared Memory Support
> > > > > > If current hardware doesn't have the full MSR support, that means it only
> > > > > > provides share memory support. We will leverage APIs in cppc_acpi libs with
> > > > > > "cppc_funcs" to implement the target function for the frequency control.
> > > > >
> > > > > Right, the mailbox thing. How is the performance of this vs MSR accesses?
> > > >
> > > > I will give a check. If you have a existing test method that can be used, I
> > > > can check it quickly.
> > >
> > > Oh, I was mostly wondering if using the mailbox as MMIO would be faster
> > > than an MSR, but you've already answered that above. Also:
> > >
> > > > > > 1. As mentioned above, amd-pstate driver can implement
> > > > > > fast_switch/adjust_perf function with full MSR operations that have better
> > > > > > performance for schedutil and other governors.
> > > > >
> > > > > Why couldn't the existing cppc-cpufreq grow this?
> > > >
> > > > Because fast_switch can adjust the frequency directly in the interrupt
> > > > context, if we use the acpi cppc handling with shared memory solution, it
> > > > will have a deadlock. So fast switch needs the control with registers
> > > > directly like acpi-cpufreq and intel-pstate.
> > >
> > > Aah, I see, you're only doing fast_switch support when you have MSRs.
> > > That was totally non-obvious.. :/
> >
> > Yes, I should have written a comment to there. :-)
> > Will update this in V2.
> >
> > >
> > > But then amd_pstate_adjust_perf() could just direct call the pstate
> > > methods and we don't need that indirection *at*all*, right?
> >
> > Hmm, yes, if we use amd_pstate_adjust_perf here, we won't need to call
> > amd_pstate_fast_switch. I saw intel_pstate had adjust_perf and fast_switch
> > at the same time, would you mind to let me know how to distinguish these
> > two use scenario on intel processors?
> 
> The ->fast_switch() callback is for the use cases in which
> ->adjust_perf() cannot be installed, that is basically systems without
> HWP enabled.

OK, I see. Thanks to clarify this.

Thanks,
Ray
