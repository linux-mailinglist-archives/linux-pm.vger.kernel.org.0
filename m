Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783AE33C6CA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhCOT0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 15:26:17 -0400
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:8198
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233528AbhCOTZ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 15:25:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYga/delsisT+JOvfyrwae/j2r3JPogJaEYDr+CcI6LnIwGHZv7hT90QlJ4s6egFQcq6wVdIiMU2MxsZ6d4VNYygNuic1lKOb3CdU93pfhii9d0MNE+8FEj1A8mgbgPgGpAoqMrnmSIkMrwKOXgYzvaPCFufK5HL3vi4B8zvkcdqDGfJXaJucrHc4KGm+nIuixl4o1kRnZN3ZAWkAVP4qwW4lLMYFOVnCXkEqXgDRGgBRMGVDaVb3EK9DJwWT48evhP2QHtxVLGNBJECQwFRpf/1jBcXLFfnYnGnJCeRHbPDuW4/MQx4MvIneXewvSH1hxr9cFu8/oFEzTLoTvw5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eJJL+5qpR+s6baeYll1mdAG5mt/LTZaWlwL1PD9tzA=;
 b=UvMXaI8XVVnZe8HLOvf38n9PKakKRYur/9ZUG1TTWlCwLroL+c6MMfd2S8MAz5fWRzlwZxdluedUDOF8hAGfNIlUfvEzjzVdAZSruZZtDUCDcXBUNieviu5XOfrJpz+4wKaC4VTquapjyHemuDz2E+vgUicHllAJ8qWZzBwBvELJvuqy5cDmxPaTQBhItxasus0HxBgMbYPmFrr04KiPuGV+uS5HE+ZwZpLIB/8JAWUhENS4g1Fclug3RE9M5dlZiEk7GlMxNmot96FHnVCtJ+JnvrowEudbndZ4ne9LWqObwVnbHddBWsDF77Nukut2BfHSa0sVFnnUD11MxQnBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eJJL+5qpR+s6baeYll1mdAG5mt/LTZaWlwL1PD9tzA=;
 b=JiKr/hXjDqa4CbnB9aFHlT3qOfi7patIkNpKqi0KPGZ3Ddhq+mG1hgXkoOHHijMvd2GSn+ltkgrcNcQlw4J4fYjPEon551jOxZMf/pJgtVt+NCRuxfruO1NrJot06JjZvkEXyViXEhsE6tKqH1PYXTnK94tXlFv2isZGnoNmbp0COgzEXhbUuJ+NmtKFvZHSEqaeydMWQThYT/XKROSGSnUBsK4vf0bR6ykm67ktTe1d+zZlT0Q1MoJNDvPPLJ/s0S8eUxugvGbc60nzhWkK04KCWExmVAPxf/PShka+fkq31l2Vnfp/Wx5rxaYqJ9BJmoP/BZZCHwdb6cfM72JkUA==
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by SN1PR12MB2592.namprd12.prod.outlook.com (2603:10b6:802:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 19:25:57 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::8e) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 19:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 19:25:57 +0000
Received: from [10.2.173.122] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 15 Mar
 2021 19:25:56 +0000
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
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
 <b31d14ef-81d8-0480-805b-a3cb64404b12@nvidia.com>
 <08ac26c1-8257-4c6d-d274-595fee28a00f@nvidia.com>
 <4b21f4c7-19cd-fcea-dd1b-9203be60a523@nvidia.com>
Message-ID: <ed102a55-d584-3399-f7f4-e4fee378fb81@nvidia.com>
Date:   Mon, 15 Mar 2021 12:26:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b21f4c7-19cd-fcea-dd1b-9203be60a523@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c15e9c3e-b4fd-4b92-f596-08d8e7e828bb
X-MS-TrafficTypeDiagnostic: SN1PR12MB2592:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2592FEAE681F912D2AA1691FC26C9@SN1PR12MB2592.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUTzk3SpgyzkJwD7jsON2DqWaiWyeAmnGT+UrnPWK8t1ms7Ho/xRZmv0n8sNkKIgmW3FlGOf1iZuoMqWmF/UDELelvOUek6LhZN3HZCXVNVyzHDqmZya4rXwDGRxMfSc0GJPK1nNERJcGlILvy8CEeRS5WwrVbd502iOg9v2gS6iTXFIHpyZB+mo2E1ZH3INilGuoKB+3IxYWwVAAXjt69LmMixpM3nT2LV2/bA3IW3EmosYmRmRl9aSa+rz8GkBTCiruqQX1/PTNy6Tv2lwdBoT55Xu0MSDUqO/TuE9JbyZkvRK/EzR/KzDOdSSXk3iOxcKDRohkRIfPquPESn2bRpPLgejhuPwFVf7KR+d+pGT86dijC0ubS11U4uaY+hu2Whmyv8oFtwWJ/3nFA0j8LofeW/92usndydjbXCEmKFyWoHqAXLYj//KHZ7Ju+jWpfbZGGv+tSEuqKWCQ/J+pnKJ8Tk8fDei0krgdCQhlxgbID6N62+yk4zVveLVvKPWAogVLskeAAVPP43jEHguUoyNSwJb52ewz6ipE/jYK1b3zwzac8uL2PFIl3GAwog+p8eBGGGswHdnJzWCPCzbmnO3nh3A/HiZMTIJKBFXeBQXNi7Iay9jBzU9Eb1nLDZIBOw9e610T4sHtQd2bBfNkp0SpUOs3D+0W0y+I7hMgFadBksT5EE2nEIS6Wk/X+MRb1psIjoGU3w5LuHupO9icA66GTON1c+jwGbIKRhQBuo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(2906002)(47076005)(16526019)(426003)(336012)(53546011)(31686004)(86362001)(31696002)(316002)(6916009)(82740400003)(54906003)(2616005)(8676002)(16576012)(186003)(26005)(36906005)(8936002)(4326008)(478600001)(356005)(34020700004)(36860700001)(6666004)(83380400001)(36756003)(70586007)(70206006)(7636003)(5660300002)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:25:57.3041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15e9c3e-b4fd-4b92-f596-08d8e7e828bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2592
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Re-sending as it went out as HTML instead of plain text.


On 3/15/21 11:13 AM, Sowjanya Komatineni wrote:
>
> Hi Sudeep,
>
> I see you are one of the maintainer of PSCI driver. Please add any 
> other right persons if you think should also agree/comment.
>
> Can you please comment on below 2 items based on your feedback?
>
> 1. Can you please suggest on proper way of generalizing to pass state 
> residency time run-time along with state during state enter?
>
> Not sure if any other drivers need this but for Tegra as MCE firmware 
> is in-charge of states enter and decisions, passing run-time state 
> residency from kernel to ATF is required and agree on not using 
> power_state value for this which is against PSCI spec.
>
> 2. Regarding state thresholds, although state thresholds are policy 
> related in Tegra cpu idle perspective these thresholds are platform 
> specific based on use case and mainly for MCE firmware usage to decide 
> on state transitions for core and core clusters as well.
>
> As these are Tegra platform specific, Please comment if any other 
> concerns in having this configured by Tegra CPU Idle kernel driver.
>
> Based on my understanding only above issue-1 is PSCI compliant 
> related. Please confirm.
>
> Thanks
>
> Sowjanya
>
>
> On 3/12/21 2:27 PM, Sowjanya Komatineni wrote:
>>
>> Hi Sudeep,
>>
>> To make our driver PSCI compliant below are few updates to be done
>>
>> 1. Standardize passing residency time run-time thru PSCI to ATF.
>>
>>     From PSCI specification I only see PSCI_STAT_RESIDENCY and 
>> PSCI_STAT_COUNT optional functions for PSCI1.0/PSCI1.1
>>
>>    Can you please help add right people to explore on possible ways 
>> to add PSCI function for passing corresponding state residency time 
>> to ATF?
>>
>> 2. Tegra CPU Idle support definitely need to pass deepest cluster 
>> state and threshold to MCE firmware from DT and looks like we can 
>> move this implementation to ATF
>>
>>      With both of the above implementation changes Tegra194 driver 
>> will be PSCI compliant.
>>
>> Thanks
>>
>> Sowjanya
>>
>>
>> On 3/11/21 1:11 PM, Sowjanya Komatineni wrote:
>>>
>>> On 3/10/21 6:52 PM, Sudeep Holla wrote:
>>>> On Mon, Mar 08, 2021 at 10:32:17AM -0800, Sowjanya Komatineni wrote:
>>>>> On 3/7/21 8:37 PM, Sudeep Holla wrote:
>>>>>> On Wed, Mar 03, 2021 at 10:08:10PM -0800, Sowjanya Komatineni wrote:
>>>>>>> This patch adds cpu-idle-states and corresponding state nodes to
>>>>>>> Tegra194 CPU in dt-binding document
>>>>>>>
>>>>>> I see that this platform has PSCI support. Can you care to 
>>>>>> explain why
>>>>>> you need additional DT bindings and driver for PSCI based CPU 
>>>>>> suspend.
>>>>>> Until the reasons are convincing, consider NACK from my side for 
>>>>>> this
>>>>>> driver and DT bindings. You should be really using those bindings 
>>>>>> and
>>>>>> the driver may be with minor changes there.
>>>>>>
>>>>> MCE firmware is in charge of state transition for Tegra194 carmel 
>>>>> CPUs.
>>>>>
>>>> Sure, but I assume only TF-A talks to MCE and not any OSPM/Linux 
>>>> kernel.
>>> No. Tegra194 CPU idle driver works with MCE firmware running in 
>>> background so cpuidle kernel driver also talks to MCE firmware 
>>> directly on state information.
>>>>
>>>>> For run-time state transitions, need to provide state request 
>>>>> along with its
>>>>> residency time to MCE firmware which is running in the background.
>>>>>
>>>> Sounds similar to x86 mwait, perhaps we need to extend PSCI if we need
>>>> to make this firmware PSCI compliant or just say it is not and 
>>>> implement
>>>> completely independent implementation. I am not saying that is 
>>>> acceptable
>>>> ATM but I prefer not to mix some implementation to make it look like
>>>> PSCI compliant.
>>>>
>>>>> State min residency is updated into power_state value along with 
>>>>> state id
>>>>> that is passed to psci_cpu_suspend_enter
>>>>>
>>>> Sounds like a hack/workaround. I would prefer to standardise that. 
>>>> IIUC
>>>> the power_state is more static and derived from DT. I don't like to
>>>> overload that TBH. Need to check with authors of that binding.
>>>
>>> Passing state idle time to ATF along with state to enter is Tegra 
>>> specific as ATF firmware updates idle time to Tegra MCE firmware 
>>> which will be used for deciding on state transition along with other 
>>> information and background load.
>>>
>>> Not sure if this need to be standardized but will try to find 
>>> alternate way to update idle time without misusing power-state value.
>>>
>>> Will discuss on this internally and get back.
>>>
>>>>
>>>>> Also states cross-over idle times need to be provided to MCE 
>>>>> firmware.
>>>>>
>>>> New requirements if this has to be PSCI compliant.
>>>
>>> Updating cross-over idle times from DT to MCE firmware directly from 
>>> cpuidle kernel driver with corresponding MCE ARI commands is again 
>>> Tegra specific.
>>>
>>>>
>>>>> MCE firmware decides on state transition based on these inputs 
>>>>> along with
>>>>> its background work load.
>>>>>
>>>>> So, Tegra specific CPU idle driver is required mainly to provide 
>>>>> cross-over
>>>>> thresholds from DT and run time idle state information to MCE 
>>>>> firmware
>>>>> through Tegra MCE communication APIs.
>>>>>
>>>> I am worried if different vendors will come up with different custom
>>>> solution for this. We need to either standardise this is Linux/DT or
>>>> in PSCI.
>>>>
>>>>> Allowing cross-over threshold through DT allows users to vary idle 
>>>>> time
>>>>> thresholds for state transitions based on different use-cases.
>>>>>
>>>> Sounds like policy and not platform specific to be in DT, but I 
>>>> will leave
>>>> that to DT maintainers.
>>>
>>> cross-over idle times are based on supported CPU core and cluster 
>>> states and updating these from DT to Tegra MCE firmware running in 
>>> the background is Tegra specific.
>>>
>>>>
>>>> -- 
>>>> Regards,
>>>> Sudeep
