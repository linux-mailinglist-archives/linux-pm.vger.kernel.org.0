Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D114089FD
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhIMLT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 07:19:56 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:16801
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239479AbhIMLTy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 07:19:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJgGGYXnGFgS7QjkJEXwRXI8L9Dm0Tc1b+gINOAAHGVCXzPRa4JTAFgKqV6CosmTTzOzIPCUExv1vYaZMfUVn1XVUoAlik2RZL4k/RYBh8FA1rI+IIXKg46iLqGQ7OEzBpCLaDtbd5tjsAUDzop73JEXY58oaApJx7eFBXfqDiPMtDCsVZC0PCnnX+/Iw7j845LCkewLmg2W14oxxE6IOpndUwmmyHtonv1cm2aw140KHsh3B4UgEvtTg5ZpXcP74AbvcxF7OD1CgcopZKhsHTvYGittCyIOSKAXXdlpwOctPv2rm9OPd0JQr0HmBB9+/gBWXOWbUoPcsHSKzcB4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8wvrwCVklbys9dezQcaeIKSx2B0QReUrQ2cqCsGOUEY=;
 b=We//KObRz5SW1o88Gakn10TK0arVVgIB8J53YFVkNZu83Ed/rPJy58xcBoLzooV+NcXZ4exbCzRm9Da78LJ7HpQWAf8TQxQy9AY5qDaxVchibyR9LdhcjRtmYLEJZ8Ri6bvK/RTSGl6Uv7TfLugGfgMYSryR3mBKFLAYtNd5I1w2Z8XeQaxJIrHyPtbNKFBEMwBL1+iqSht9qi9/Ufyzsip7OEbhghShwtP06DxgzURQCA0dwX6D6DK3KYlQjzkBZTahjUxkL/QT61A4OD2WEtJtEiUybqCcygOT3TYDLWurNAHUh8axr8ddcGsY1pdUbRS0tPjR/7DxGgon2A2bSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wvrwCVklbys9dezQcaeIKSx2B0QReUrQ2cqCsGOUEY=;
 b=q3oyH7vBYVI0QjSnVl7T0uoWW7G7A9tUfynOPTbsNUZIW0igzQ8OJbygFZZnrzydpKIWGuC4UFeJ3PzB45iJa5562bPEs0aicZ6CQ4+ssRfd11MQ7RQBNjcVEpkhmIdt5XWN3JUda4TX6WmpesqJwNgblB9NI1wfs6onBigBD84=
Received: from BN6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:405:2::21)
 by MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 11:18:36 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::72) by BN6PR11CA0011.outlook.office365.com
 (2603:10b6:405:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 11:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 11:18:36 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 06:18:32 -0500
Date:   Mon, 13 Sep 2021 19:18:28 +0800
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
Subject: Re: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to
 support future processors
Message-ID: <20210913111828.GD3731830@hr-amd>
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
 <c9601b78-10ce-e4c1-6056-3d1922c0ed41@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c9601b78-10ce-e4c1-6056-3d1922c0ed41@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ecb4eea-d5bc-4efa-bea8-08d976a83aaf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4991:
X-Microsoft-Antispam-PRVS: <MN2PR12MB49910992421267293E3DBD24ECD99@MN2PR12MB4991.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlbLsPSepq9IxyHvyWIwjhrc1Xo+oyc3ia4UetjBrAOrPhZPOQaO3HJYGAKA4MSD3l/3mDCsMlNqUEu8ObW2EwapFreIwLRsDVqFkvs8nnuTSSYA4qWTONAbDUr3L99hJWWj4lpX9gHCkNewh0T4O9R8eMOWc95pNxRPvJl227RmW0r3dgAnxpYKqorRAct50nb4vculkUkpmvY/50cOwVDx4upgMwtP2gZjaLCMKTp5v3xUUhr3zYlLklD+tNS/TdmF/LkcbDED1lNpRx/ObaY/aHeHaAQzBAC0O3XAMFIETWeAsZH+KxDC+s0f7zbki8T2ULD0wp51mBt2ZqY1OCertzFJ9xhoKY3ccgodkVxUHzrR6VCFC8nLTUFPiZaic539nszqpqRUQIhVY5N1IPbzNMtkeDNAXkMDBh9gk8gSScaTh2sOAndAcsfW4ZXLkYOC4pfJKAoLBRDbTUP2igzzhMbQlEEeLX2W9MTu6TBGsIqIRSN4b0Y2ZE/Nf9JCwoGRUVYcT3uZJV2XLHWqhEAILtg0m6GASouxJPT7BWLLDgIWvis1OFkrgSi/d4OHHy3KPd5f2Ii0r3wTTkm6AeqjZL/6sHwfT1lQlox4Uv7DCenJCT7o7SfsVSmAQVzmUwSqjeOE3aJn5EITZa9NzbHn5n+gDKo7cVx7k/RS/SU6NYPPmBdzcJHsRFep5lUXFo0SleC7JfIbTwTvJ6nUQS6frxxMaRdxa/VkhDhI8Wo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(53546011)(47076005)(5660300002)(6666004)(316002)(4326008)(356005)(2906002)(1076003)(83380400001)(336012)(426003)(26005)(55016002)(70206006)(36860700001)(8936002)(81166007)(8676002)(70586007)(186003)(16526019)(6636002)(54906003)(82310400003)(82740400003)(33656002)(9686003)(33716001)(6862004)(86362001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 11:18:36.0385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecb4eea-d5bc-4efa-bea8-08d976a83aaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 10, 2021 at 03:31:26AM +0800, Fontenot, Nathan wrote:
> 
> On 9/8/2021 9:59 AM, Huang Rui wrote:
> > amd-pstate is the AMD CPU performance scaling driver that introduces a
> > new CPU frequency control mechanism on AMD Zen based CPU series in Linux
> > kernel. The new mechanism is based on Collaborative processor
> > performance control (CPPC) which is finer grain frequency management
> > than legacy ACPI hardware P-States. Current AMD CPU platforms are using
> > the ACPI P-states driver to manage CPU frequency and clocks with
> > switching only in 3 P-states. AMD P-States is to replace the ACPI
> > P-states controls, allows a flexible, low-latency interface for the
> > Linux kernel to directly communicate the performance hints to hardware.
> >
> 
> This patch seems like it is just enabling CPPC on AMD and not a new mechanism
> based on CPPC. Can you clarify?
> 
> Also, if this is just enabling CPPC, shouldn't the driver be named something
> like amd_cppc and not amd_pstate? This isn't using P-states.

That's just a name. We use the "amd-pstate" to indicate the new driver that
use the kernel governors such as schedutil and others for frequency
control. And "amd_cppc" indicates the legacy solution with userspace tool
for frequency control.

>  
> > "amd-pstate" leverages the Linux kernel governors such as *schedutil*,
> > *ondemand*, etc. to manage the performance hints which are provided by CPPC
> > hardware functionality. The first version for amd-pstate is to support one
> > of the Zen3 processors, and we will support more in future after we verify
> > the hardware and SBIOS functionalities.
> > 
> > There are two types of hardware implementations for amd-pstate: one is full
> > MSR support and another is shared memory support. It can use
> > X86_FEATURE_AMD_CPPC_EXT feature flag to distinguish the different types.
> >
> 
> Looking at the drivers/acpi code for CPPC I don't think this distinction
> between MSRs and shared memory requires a feature flag. Shouldn't this be
> handled properly in cpc_read|write if the ACPI tables are set up correctly?
> Please correct me if I'm wrong.

MSR registers can be used for implementing the fast switch function which
has the better performance on schedutil and other governors.

> 
> This would also remove the need for the additional indirection pointed
> out by Peter.
> 
> Could you also provide an explanation as to why a new CPPC driver is need
> instead of updating the existing cppc_cpufreq driver.
> 

Good question, I had explained these in last mail with Peter.

Thanks,
Ray
