Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A140D72F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbhIPKLO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 06:11:14 -0400
Received: from mail-sn1anam02on2050.outbound.protection.outlook.com ([40.107.96.50]:11619
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235574AbhIPKLO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 06:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsuboH9dL2/PIx2bMv7Cq43xG3u6C8+d36poMOlfM0gqJp+l59BK83mSgm88yyBX5JG2uTOTLRjT/W/UaOjK2lwv8ZHLaR5Tbpcthlvcal1o3zz0KB4W6CHE0CYBBFpfxBUW+6cGONDWIdr+opjWEBtJZ1iC6UwtKHS8Upl0Z/igAfMPzX1eF+dq2+dW48vMYVo7aR8VTEgKPVAER5TTMnSEcxm3TeWe97JOiwJRVb6nP5CMfbnQhZcLJFT5CQ+fkuRcfQkgSTpsuJtxQtFe72tnYvcomJ7QTEIYBAMG9c9rZorasQbWS8YAiJY5gCZNFbVYe22EQ1Ot1MCG/GNWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AV3m+M0I3p9O3QeT/iBnwwi4ckvBEGEc6WJZNGlSc1o=;
 b=QS7au3x9CUv1xX75kvlanOir5tR39ii0XCaHrRmflb7ODnpfptxMcVnDXWOKNwWWb6eknrM+ZKj002nX+QrlhkjEi9xtEDpF2QAEUDyQ6KTjaqG2v26EVMC19By+As2zkM8YX6ddv49cmp3d8axda0xmvRQo1t/mMuuyXpCcEFiJFAOAhibkfR63Nv0oVCyddnoUjzqtUVu4me+GMUq48ODGCfwz9MMMRWakOyOyW6rVMgxAC4uEDSaH1whjKyZJxScI9cdXA25AAo/Mlg/3YrGWbbV37KI38zJRnbKVd9DK3KccLTAG1/MaIvHW3uMCKqIfK5MAQ5lUq8gNIxZZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV3m+M0I3p9O3QeT/iBnwwi4ckvBEGEc6WJZNGlSc1o=;
 b=ruxt+VT4sVENLI1RSb/h2r7EJki342AoS+KVI80cMZu/H0VC3OY4jLVn5UrSLHv9ML/WVICw728wI7CusmOqzMp2k6Nda+y3RZmsPRiVwSKLoVuz9tbtmUoDeHx5dxY50QTvRSGFFUnYGp6pZQRXWTzHhnGxoSWjkUCf+2+Me8w=
Received: from BN8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:408:ac::45)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 16 Sep
 2021 10:09:52 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::d5) by BN8PR07CA0032.outlook.office365.com
 (2603:10b6:408:ac::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 10:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 10:09:51 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 05:09:47 -0500
Date:   Thu, 16 Sep 2021 18:09:47 +0800
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
Message-ID: <20210916100947.GE3755511@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <YToh1Vhei2PyhlW+@hirez.programming.kicks-ass.net>
 <20210913081134.GA3731830@hr-amd>
 <YT8SOMBDpB0HWm0d@hirez.programming.kicks-ass.net>
 <20210913105458.GC3731830@hr-amd>
 <YT88cJCetaGHUItH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YT88cJCetaGHUItH@hirez.programming.kicks-ass.net>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abb70e1-3acf-4b5a-6ae6-08d978fa1fa7
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0120E4D2B9D1B0DE972A0A05ECDC9@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBmIK3JLZXoSIuJMe1fKja9GxB6Lv2gmsUXhZEnPX07jH1weX2v28Q9+eAMOsL0nnM0c1+ysLyWJneCq67pvwmDDZ/Qab8PYWjehFgq3kCyxdeR90cXm2aGwso1A3LSYQ72wi4EWz5GbwJRo04Q7sqdf38v5WhWFcG6A9SFswFMvqAv8Cwi+gHBwhO9Yj5DaVXVPDs+hRj1bq+/v4P+unjaSJuDvzgA0DKdcX4p4gRLGolhR50ctlW3Sij2Ep3e8QjmnI2LK3UtkfyvoeGLF7gRJjg51ztEASQHgWJWk9Q8XBB/RVueLou87LJjtdvtaUh2NeUR7tdv91WyHoBAYfnHPfx/5JEm1oZefO7LhO9MBe5dLucSJ0xt3NovgMe2vX7o2Nj6emd2IUqNmOSL/DH9nKpu1FCyJ1ULhfJaPLhowMiN83bXCXkwd/mPpizm74fiGyiQcBWPw9OgDhC8foq+7SpuCWUEGzbkigDwOKCOW7mY8C9AfGgh95YIIQ0fH4qxDaSITOrd9f0W5tUh0pPa3zxJbXpJ/G/uc2/tLzVjsgC8N6HQLNskBELzIHheMSy061D5MHGQvqgskujygqzfvZMpbdOitV6fbJGieAcabLTtMdu1O1fwOIfsuQ9ThBdgQ9AX9muYeft9olF+CJX921JDwrrRi7B0P62FsxjRpsjyhqZCGoSgqTMXmtzRkLndmuPrn0cGzxwP2ZtBChvaGMbYjNX4eHn/4tFakhY8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(36840700001)(81166007)(55016002)(26005)(478600001)(8936002)(82740400003)(33656002)(2906002)(8676002)(54906003)(356005)(16526019)(1076003)(186003)(5660300002)(70206006)(70586007)(4326008)(47076005)(336012)(83380400001)(86362001)(33716001)(316002)(6916009)(426003)(36860700001)(82310400003)(9686003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 10:09:51.7409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abb70e1-3acf-4b5a-6ae6-08d978fa1fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 13, 2021 at 07:56:32PM +0800, Peter Zijlstra wrote:
> On Mon, Sep 13, 2021 at 06:54:58PM +0800, Huang Rui wrote:
> > On Mon, Sep 13, 2021 at 04:56:24PM +0800, Peter Zijlstra wrote:
> 
> > > > 1) Full MSR Support
> > > > If current hardware has the full MSR support, we register "pstate_funcs"
> > > > callback functions to implement the MSR operations to control the clocks.
> > > 
> > > What's the WRMSR cost for those? I've not really kept track of the MSR
> > > costs on AMD platforms, but on Intel it has (luckily) been coming down
> > > quite a bit.
> > 
> > Good to know this, I didn't have a chance to give a check. May I know how
> > did you test this latency? But MSR is new hardware design for this
> > solution, as designer mentioned, the WRMSR is low-latency register model is
> > faster than ACPI AML code interpreter.
> > 
> > > 
> > > > 2) Shared Memory Support
> > > > If current hardware doesn't have the full MSR support, that means it only
> > > > provides share memory support. We will leverage APIs in cppc_acpi libs with
> > > > "cppc_funcs" to implement the target function for the frequency control.
> > > 
> > > Right, the mailbox thing. How is the performance of this vs MSR accesses?
> > 
> > I will give a check. If you have a existing test method that can be used, I
> > can check it quickly.
> 
> Oh, I was mostly wondering if using the mailbox as MMIO would be faster
> than an MSR, but you've already answered that above. Also:
> 
> > > > 1. As mentioned above, amd-pstate driver can implement
> > > > fast_switch/adjust_perf function with full MSR operations that have better
> > > > performance for schedutil and other governors.
> > > 
> > > Why couldn't the existing cppc-cpufreq grow this?
> > 
> > Because fast_switch can adjust the frequency directly in the interrupt
> > context, if we use the acpi cppc handling with shared memory solution, it
> > will have a deadlock. So fast switch needs the control with registers
> > directly like acpi-cpufreq and intel-pstate.
> 
> Aah, I see, you're only doing fast_switch support when you have MSRs.
> That was totally non-obvious.. :/

Yes, I should have written a comment to there. :-)
Will update this in V2.

> 
> But then amd_pstate_adjust_perf() could just direct call the pstate
> methods and we don't need that indirection *at*all*, right?

Hmm, yes, if we use amd_pstate_adjust_perf here, we won't need to call
amd_pstate_fast_switch. I saw intel_pstate had adjust_perf and fast_switch
at the same time, would you mind to let me know how to distinguish these
two use scenario on intel processors?

Thanks,
Ray
