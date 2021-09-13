Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42FB408884
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhIMJuT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 05:50:19 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:6785
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234476AbhIMJuS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 05:50:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd1F8g/tglWkfXPyZftWjcHrPfYtzVLzIM96eZj3WfyEpjVCCSL5pMJcmXIY9RlIwBhpowXelEpyxKHf/JdilTPccrdKzF4p8gBproz7Dm5Vg5KgqjuaX/qmgo6ZuXncSkBcltiKS9rE77vIlEgdUX7ZKAd6gWmu/BwLu2KH5ttgpwNygBhlYDkOTf1OFGL571Tw9ARaMJsqq2zr1hHN869ZKhIJNS1t0E1bGOSwhTB8zu0/QhRCC7uI/nZANpcSHZkhFkxLfLjajIGajsfc5G/QWIy0ChZAU8xAhCLVqvsNtmAhnuTVdk0mUieCmba1VUusDPLu2zSday4o2PygRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XQktMvw3mK1EhN16ykgpqAV3AxfCoJil+f4ApHYi1vI=;
 b=ZekvPK4BonpefdV2oPjRzF9FkRetUptmEOGslndx7/Q+3nw7ItT7GZKG6tGQb/OWnGMlKil9LwNcHfuV1Uu/osVXzyqHUlikmHzvJblT4aeb2GfkbFp3UZP31/sND6H81lP4y0/91CNFLpZwraVAW6F6ddH3L4+BMCRHjmnd5B/wvWUXYZxW0QyD4eJFSCQQBoSDHYrHI/gAdwehQcd4vU4AzN/1fvj6zCitbBjauY/7VnebkcJKK9nzgNWjnnA1jjqTPYJLG41/e9WaCcJK6ckCEzvNtQ3Ju8FEJ8J4u/CMVrm5lMXmk363McW46ut5wqCwPWIZ7R/5EADwulH2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQktMvw3mK1EhN16ykgpqAV3AxfCoJil+f4ApHYi1vI=;
 b=DLctx2Mm/ADEO8qQJV2xe/pkBvwJ/xTHK3oVxeljkLv2yHoDAeuz3wm/2h8q8f6O1fcTSK2PSh/zhzBSfUmUbJmo4NzDGMPlgsTCcIL3cnxAQi117vjMTpNqIsqrOvD6wGwmF/M8j0MgoI5bLjCKVMUJD4itN4oRRc8DfBONEwM=
Received: from DM5PR04CA0057.namprd04.prod.outlook.com (2603:10b6:3:ef::19) by
 DM5PR1201MB0252.namprd12.prod.outlook.com (2603:10b6:4:5b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Mon, 13 Sep 2021 09:48:59 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::bd) by DM5PR04CA0057.outlook.office365.com
 (2603:10b6:3:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 09:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 09:48:59 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 04:48:55 -0500
Date:   Mon, 13 Sep 2021 17:48:51 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 01/19] x86/cpufreatures: add AMD CPPC extension feature
 flag
Message-ID: <20210913094851.GB3731830@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-2-ray.huang@amd.com>
 <YTpLO6M2C0IqJ9XC@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YTpLO6M2C0IqJ9XC@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af216e3-205c-4366-6cfc-08d9769bb5ce
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0252:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0252E9922EBAAB12B975252BECD99@DM5PR1201MB0252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GD1gL0neXDTecTymXpIy7CSYd9i72xqb8TrZoZYsE1I9vkCwm0rzgV03M9BI04Rkdt7zZLlIoNCddSD5jDaxKe0FvNuNkNYPP3bGmPoeenVGTO4zePA9QijMeZnqiVGf2QIdCXVt5LK/3xTIWCtBFEGp5x4OqNfJhZnkBIcU/jjd1fv77441k94hDr0EmWCezYuGLi5rTwr6NMf3DzvKKuIQxadZ4sE5bHhg2JNAKM/7RPBttkpPiXYSau9uEAm3s9aLhGl9A//aFx0A+lN6/+Uw5GHkaM94nMer2KNxw4209hdtRHM2V+FNLr8PGJI3tEDYzHCoCeTlVvLwDoWf1LN+QhVFAZ324kUAWREpnDgsSY07Miu7gAMeM+ND3So7ERYHBzQRYNkJVRpQDz+A5KwHoYslzeaRmhXq5kIVoY71OL1N0a+2x4NHKfrM/Vu7MEOJdNqxcuUJ0yLhM3d6ckacvPt8waX+rYa8hTNuJI65WvbpamjtGJ6+IMF3aiBWDEvr+veGP+PLNDXEmWyV7GFZqUxEx+IKEYZ5Fw8nbDY2cw0eEOHSZiaB9o2UwYH5qOsHLqKgZet34BqclhPGS8bMsXdu6lYXfomSusq14mRPtu/PNlEuNi1crEMGRk1OgwbNdJzLPLbMYJQGA7vW7c6KgPrp155vcNT2fb7SaYfFwFQn1BPF2sK938akEQH+CmJ/vDE4OjW2uFIxv79XkNP2fELrEGRaMfLrmaybsRE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(36840700001)(46966006)(478600001)(70586007)(8936002)(82310400003)(5660300002)(356005)(6666004)(186003)(16526019)(47076005)(81166007)(9686003)(2906002)(4326008)(8676002)(70206006)(336012)(36860700001)(33656002)(33716001)(1076003)(55016002)(6916009)(26005)(316002)(82740400003)(54906003)(426003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 09:48:59.0849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af216e3-205c-4366-6cfc-08d9769bb5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0252
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Boris,

On Fri, Sep 10, 2021 at 01:58:19AM +0800, Borislav Petkov wrote:
> On Wed, Sep 08, 2021 at 10:59:43PM +0800, Huang Rui wrote:
> > Add Collaborative Processor Performance Control Extension feature flag
> > for AMD processors.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index d0ce5cfd3ac1..f7aea50e3371 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -313,6 +313,7 @@
> >  #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
> >  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
> >  #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> > +#define X86_FEATURE_AMD_CPPC_EXT	(13*32+27) /* Collaborative Processor Performance Control Extension */
> 
> Why not simply X86_FEATURE_AMD_CPPC ?

This feature flag indicates the full MSR hardware solution of AMD P-States,
if it is not set, that means we will go with in shared memory hardware
solution. So we name this as extension. I will explain the details in the
commit log at V2. ;-)

Thanks,
Ray
