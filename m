Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0ADE337F6C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhCKVLt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 16:11:49 -0500
Received: from mail-bn8nam08on2048.outbound.protection.outlook.com ([40.107.100.48]:61280
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230506AbhCKVLU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Mar 2021 16:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK6UYE8dO9rYcvkvEUrmOmMVgU9nqimTmkc0tW6g+N+jF+4Uhg302iKt4b9xtXGtGyGm6XpIv+6ZpaDTdXG4VP/vkGTLzXXQiptRN0gEiH2UV4P3mjuFzj5wNBiWqBKP1HSviKRCZBFByRxiyOc8MoXg55QJu5yFs4MNb3Xo7r/ze8JkF6OdUSHyMhkrTW3hg94lMvg+Olq5Trkd0sLJWcZHO81HeQNXRwSwWYscy9hiwAXPoklW8oMePZFbskdGl3JdXKMfWgMR7xyu0rwUtVq0bd2Q0Z/DOUVHCpo2IZP1aINPz3FwvGK7dTnbSNrlbTWr/G19nh1o87iLTm2bXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqReati72x7eEmx88ks4uHPB1XlPFIvLlhDeTBAVVCQ=;
 b=HLzsM6U6+w64zYXBo2ptFy9d9MfPiIj1vM0+HZC3shQj56LS0IMlmUZqwfYiu4e8J44PNHDiigq/hA8pplVu6INLh3vc0/jf4PkfHMzLMhLUmR/1ZXOCIQC8tRBaScUxTWL4E01M5tCVCk/3HinWNYB07gauPkqAlrtZmi79JH4OflB4MX4wj8jZwEy29bXMbFpARNeg8S0p70YjSOoeg/y0f2D4o1KZnu6fGEo4rhNpgXBTLy/uF5VztfQeHEDdOlgw9CVdSohsCuOO01kT3WF68tkV+H9QgcVePNWiqtQ/yJV47vKzsSy02HqDjnKitk0O5MlBfr/9onw/ki8tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqReati72x7eEmx88ks4uHPB1XlPFIvLlhDeTBAVVCQ=;
 b=b0Vx0WcA/mdztB9epjQt9FdsKKGaGeN6trQTJOQfprnLJ9MyctlxA8zOE0LErvsCTC+A+HwcPmyJOK/ytji+mJ2ZOjgPvX779Wre9rY5tMk0mz+yjfRjT5i3xLYRjzoj25GgnckI0YxF12j0FBOr5gkm12/oipUr6pxLP2lN1Txwy7GX8S1+YXdgfLpFIWBchQY8sCpAzihAkWHE6E81kdNm6dcSA1P1unMSdlPSawD+phB5ChacNiRpBO5MoPFoTi4b/bwfvh9PdnDRl2Q7KiBiDfW2o7V4gdnbgtu1fVl5IBeeY21G92oCi3qS8qiJz5+7Ez2E2oFeJGgdMLQebA==
Received: from DM5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:3:93::11) by
 BL0PR12MB2404.namprd12.prod.outlook.com (2603:10b6:207:4c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Thu, 11 Mar 2021 21:11:14 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::f2) by DM5PR20CA0001.outlook.office365.com
 (2603:10b6:3:93::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 21:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Thu, 11 Mar 2021 21:11:14 +0000
Received: from [10.2.172.165] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Mar
 2021 21:11:04 +0000
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>,
        <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
 <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
 <20210308043755.llvdsuz2jwvweovb@bogus>
 <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
 <20210311025138.o4ub4j2ss725zpv4@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <b31d14ef-81d8-0480-805b-a3cb64404b12@nvidia.com>
Date:   Thu, 11 Mar 2021 13:11:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311025138.o4ub4j2ss725zpv4@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdbe0880-db4b-4a14-0989-08d8e4d23455
X-MS-TrafficTypeDiagnostic: BL0PR12MB2404:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2404FE036A75D3910391BCC7C2909@BL0PR12MB2404.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Spv+RYSiwL+jcJA2OagJ+05o4lB/zMDrw8MEoMFCg2ezFIlDkPDLRshzIwgVDCHx6Xq0RTZH7HuW5dyDNyLcqcaXZ6sKF3YmoRjcxOZagPIQxDeyKrqW+BHikQoGwVIXXjYAReV2neHUGNkXkdnM15HfgDuiVnHXOp2Z3mLzG2/oXD66IFagP8F+0jmPs6V3Vqh+EAExctUVx/CtuOwhqjOmN+3Nestdw+AwuGD+JDHc52OJm1+3K/P8mPqkbDokQ6P11bBA8P9Jik6KeSjD/4+ziXYPOjtaQpjEPDwrwle7J3l7TFjXaOW2GcwcCgOYJ46DosHs4CWuxuh1hcEd2DS0+uk7FxzfM6U5ZzBI4g5KmtjfbO5MBsEnz3VdctQu6nCRXFzdqjTcF0M8j75Wg1tgGl89B+3889gdIRaqM0OK1bwFKpBa4uR7UDhlKhbbepq1bRQHgfqs4WQ3pR6rSEtNxcbLUTKgdWRFSJQX45F8N7+VcMW+t59G9mfYYk0if3MSB+EEG5MgQkVbOqixwYEQtQ5uNbfhBZDS1VJ5sUZZAsyKUjiq6//4XBZMN8UwaEFIlTZ96V+H1IYFNa1pF/YZxbPzgtWtg6cSCi6ySK6FuxYeAOqtUcuXlR9UP7Lq4E1ImFGQLPNyBerNHfKFQejskZjMPj+CUwPSmz81Y04kVpp+fZxTxEJH1EyxRArXdN08NLn34YBjIaDKmQASa6PK4ZAeDpNrk/P4SXEfQI4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(36756003)(6916009)(8676002)(356005)(2906002)(4326008)(2616005)(47076005)(8936002)(82740400003)(7636003)(82310400003)(34020700004)(86362001)(36860700001)(83380400001)(31696002)(16576012)(426003)(336012)(6666004)(36906005)(54906003)(53546011)(316002)(70586007)(186003)(16526019)(478600001)(31686004)(26005)(5660300002)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 21:11:14.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbe0880-db4b-4a14-0989-08d8e4d23455
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2404
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/10/21 6:52 PM, Sudeep Holla wrote:
> On Mon, Mar 08, 2021 at 10:32:17AM -0800, Sowjanya Komatineni wrote:
>> On 3/7/21 8:37 PM, Sudeep Holla wrote:
>>> On Wed, Mar 03, 2021 at 10:08:10PM -0800, Sowjanya Komatineni wrote:
>>>> This patch adds cpu-idle-states and corresponding state nodes to
>>>> Tegra194 CPU in dt-binding document
>>>>
>>> I see that this platform has PSCI support. Can you care to explain why
>>> you need additional DT bindings and driver for PSCI based CPU suspend.
>>> Until the reasons are convincing, consider NACK from my side for this
>>> driver and DT bindings. You should be really using those bindings and
>>> the driver may be with minor changes there.
>>>
>> MCE firmware is in charge of state transition for Tegra194 carmel CPUs.
>>
> Sure, but I assume only TF-A talks to MCE and not any OSPM/Linux kernel.
No. Tegra194 CPU idle driver works with MCE firmware running in 
background so cpuidle kernel driver also talks to MCE firmware directly 
on state information.
>
>> For run-time state transitions, need to provide state request along with its
>> residency time to MCE firmware which is running in the background.
>>
> Sounds similar to x86 mwait, perhaps we need to extend PSCI if we need
> to make this firmware PSCI compliant or just say it is not and implement
> completely independent implementation. I am not saying that is acceptable
> ATM but I prefer not to mix some implementation to make it look like
> PSCI compliant.
>
>> State min residency is updated into power_state value along with state id
>> that is passed to psci_cpu_suspend_enter
>>
> Sounds like a hack/workaround. I would prefer to standardise that. IIUC
> the power_state is more static and derived from DT. I don't like to
> overload that TBH. Need to check with authors of that binding.

Passing state idle time to ATF along with state to enter is Tegra 
specific as ATF firmware updates idle time to Tegra MCE firmware which 
will be used for deciding on state transition along with other 
information and background load.

Not sure if this need to be standardized but will try to find alternate 
way to update idle time without misusing power-state value.

Will discuss on this internally and get back.

>
>> Also states cross-over idle times need to be provided to MCE firmware.
>>
> New requirements if this has to be PSCI compliant.

Updating cross-over idle times from DT to MCE firmware directly from 
cpuidle kernel driver with corresponding MCE ARI commands is again Tegra 
specific.

>
>> MCE firmware decides on state transition based on these inputs along with
>> its background work load.
>>
>> So, Tegra specific CPU idle driver is required mainly to provide cross-over
>> thresholds from DT and run time idle state information to MCE firmware
>> through Tegra MCE communication APIs.
>>
> I am worried if different vendors will come up with different custom
> solution for this. We need to either standardise this is Linux/DT or
> in PSCI.
>
>> Allowing cross-over threshold through DT allows users to vary idle time
>> thresholds for state transitions based on different use-cases.
>>
> Sounds like policy and not platform specific to be in DT, but I will leave
> that to DT maintainers.

cross-over idle times are based on supported CPU core and cluster states 
and updating these from DT to Tegra MCE firmware running in the 
background is Tegra specific.

>
> --
> Regards,
> Sudeep
