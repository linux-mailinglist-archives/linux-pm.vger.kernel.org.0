Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AB540D63D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhIPJb7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 05:31:59 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:40929
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235481AbhIPJbz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 05:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkyUkjkLYGC56h2921zM3BfDZ2c/HCLHehe3DoknyiZQtl+5oH553lieA11Cz/ODtHulDnD6XI+4r7M2wXE7vYx/T8oIvAwIbUpidkJfMQ9PvJA1inj9LDufap0b12ig/6Okdm/dRYyM053iwUtsIsig7hmzsu/lJayRCTkMzg5GiOO0hJ7C8kycJCiyAGk9fhm1/sAJwSnHL6mDeCKICQ2qMt1yOdHiJohVeShSpPt4BcuT9xtRv3HRaA2DQzja3MMawptcCq17bD412mFj5UD/JX3hi3bowlhPR855ByyWUzl3AKRTwu70ox1JtTo0H3pVsCNFnzbCWv4+76f6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JU07ocTRAWQofNexg+gbdyHyqLAt/i0qpcokFBXgsGc=;
 b=Dmcva8UHgelr2EWqWhuWDnNaXd/f/6V6yyra5ENhBGvLDfl22iDb5tINP5llNBiqlNC9uS7oyFbRyUUlB8U8uw4MxKJP56EJOfemi5muModIPyonDSSZjz8518O7aT40Iu9XLUKmiRqsIyM+6PUl80UWg9G3X5ys6ywF/fcgMePJ21CdDp++PGk1Rc3lAfTXcm9Wfh4/gPccA+zzqlOVMpLWF+YRYgsoDzCOptk6ESt49R3Ws8MItcSAPEoSYHV6xyMnrf4w4/3lr6WFSf323aiyC4GQvlLQdrgSW20JnKZNvj7MTqJWXaEG81J5Z5QSeSqQdNEJ9DCTdfpQ2mn34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU07ocTRAWQofNexg+gbdyHyqLAt/i0qpcokFBXgsGc=;
 b=xV8oXWlaR1WgwXO7sRvneaM+hLAulmp9gwICcQ7Sq0xMEn/AzrkKSzdVQSMHZ3xcZauxVbArUk29eifA9LxPaD4/UhsXw97XbpJYw9G4aa0ASmkNrK6wZo4e88gmFxQRCkOzkMKJrb4vH57MIS4gKtmUhtNVgbef1cEpKH7pUxk=
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 09:30:32 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::af) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 09:30:30 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 16 Sep
 2021 04:30:26 -0500
Date:   Thu, 16 Sep 2021 17:30:27 +0800
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
Message-ID: <20210916093027.GD3755511@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-2-ray.huang@amd.com>
 <YTpLO6M2C0IqJ9XC@zn.tnic>
 <20210913094851.GB3731830@hr-amd>
 <YT9ManjgABReBVX2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YT9ManjgABReBVX2@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f15c07c5-caa9-4571-5a52-08d978f4a081
X-MS-TrafficTypeDiagnostic: CH2PR12MB3957:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3957478857297BFE34ABB8CEECDC9@CH2PR12MB3957.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d94OapSG6xqnAnatvtZU5V9XYjIIT4ZTqciWXmEyOeZfpInCEdrysZ5YsNCfg2LFNiTjKMsV800mfFAK76c8Qn4Nq/BhJSlnIfhmfbS1e0zLtoY1+QjhU3nrjcxJ+F5vNy2va4rTbkE5LaQZ78NE2qFWj2j/Y2TeAEKCZC1drWx11wDyFEh3vDoCIU8SLXSBgmwIKffGtl2J+5i3pPNMwsDXeJfTxcxWNaKNvBVGrW0hykOP3OpCYeAgjbFnM0CBwbRkWFW1pcpAjZ4yoX0OV1vOg8w/qsDUkNTC49lBolfDmcU80skt7squ/VooRq/oD1oxvNAEYRmN26al0P41Zt58/sWGoh7T6gAUU0aQBJp1HUjQfFo3FWwaiqpdCr6pN6ANhJtu1AozDEQKOgpkO0jZqz2rKkqg3LJlXLsx74DAMZ5I6QIOR0/z7xpyGm7y/D9lHCyWXuOIhfEzoomrHvojqnM4rIb7ZlNxZksMZyjGYki+wIEwgdakGwHACZpEykJcw8kuKtKHaZiTeJEbjQV/yrYc5icQ0BgvC8oQ0Cfr7pYsaJENa8FF9rgdUJ27auSJU0d5z3OAPz6vw4ZzYR+vwN06gvuTEjzb2d16u604TfXXP9i39XYZo+pU2+MtjT3l15Vl44jFOjU02zRnNh9EyZngjbnJz+4zf8n48c6ZIvOVYQ0kJoLGUTtoogPon3NJ8xs14dVGXyrRw2a33TBcQrlvM+KL3ZdzITag8lo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(83380400001)(8936002)(1076003)(9686003)(36860700001)(5660300002)(478600001)(70586007)(4744005)(70206006)(6916009)(86362001)(33716001)(8676002)(82310400003)(4326008)(356005)(81166007)(16526019)(186003)(2906002)(54906003)(426003)(316002)(47076005)(82740400003)(336012)(26005)(33656002)(55016002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 09:30:30.8691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f15c07c5-caa9-4571-5a52-08d978f4a081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3957
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 13, 2021 at 09:04:42PM +0800, Borislav Petkov wrote:
> On Mon, Sep 13, 2021 at 05:48:51PM +0800, Huang Rui wrote:
> > This feature flag indicates the full MSR hardware solution of AMD
> > P-States, if it is not set, that means we will go with in shared
> > memory hardware solution. So we name this as extension.
> 
> Nobody cares whether it is an extension except you guys. Also, having
> AMD_CPPC_EXT suggests there already is AMD_CPPC. But there isn't.
> 
> So call it X86_FEATURE_AMD_CPPC, please, for simplicity's sake.
> 

OK, no problem. I will update this in V2.

Thanks,
Ray
