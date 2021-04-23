Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3788369C80
	for <lists+linux-pm@lfdr.de>; Sat, 24 Apr 2021 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhDWWZh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 18:25:37 -0400
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:37737
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232106AbhDWWZg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 18:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBmQ/44nQQL8SjgMuBcndyKhFTvzR79NtCulsljojcx8nNC0uJ/tsQyXkSt1ETDlWgm08KbgIvJrI+SjyrbZkGuO4JJ0QgY0qENYI5Z7OExUrRVsW4mWN4MzW5zIUTV7Y0dC+n0O8NNjW+5MbbhigLyeZl56Jivf3y/OQ/GSV4uyLVs4mTjkab3rGVYFjEYC4q7CsYpfw8/PZk9vuf35nJBrqmq1mVDNN0ybTEUtclLrbfKmooTKXqJ5N1CJzK/Lr/jmLelQwDvCXUd8ET6+YQeLpS+rK/BhNCYw265ey7ebsmCKo4O/V2pl8satehsk3NG3T5tzya0SviAsFh5nLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=botP2zId/xRiZZDutfnqUDSL1DvGz8+g4qdax7sNVQk=;
 b=T39aYewvGB4ZatN5mFfSAbytSDXNMSmC/eMwche0xG8q0/3nFs/Am+B8Cx2HloCSh1X5/BZSsAHMfcxqJHSgKPwzUBsd+TMtSg3RtFbQp+sVHxcoYuMEsBBB9aJowYNs2JZX/A1GK92F9oRmySwIavTANWHjSVJLt5hQcPOel/4aWmg76Bo6IzBUejm2oA6JL8hzXVzY730Dp7WGP2CaW0GwK4LDLYj47UNPpsDKkJde9xw9Gicng9Uw8shs2Y5WKoHHoDGKo4g3raDtBpB/s/IWWcmDdC9O5pdebmCUu39tWakFPdrb6cZgiYW6of+slAFibXDyGT+siVumwj022g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=botP2zId/xRiZZDutfnqUDSL1DvGz8+g4qdax7sNVQk=;
 b=EEptId7l1njpX+f6/L9Jddel3bz2XGRtzwq03yKcByP9y5hiIjWLzNgb41Dww0U06287WqRoSotY2Mj+28mN03fplYyV8fesu+WfpsZQI5iSIYM3CqcwN9/tZdV3Gk/5lryBhuEGT29/mGOSouHffqyaYdyda5ElUHLmdWsMAWfIW/CXxYKxHRocp2wNGxIKol0oamjNLcqGCv0QaYFblFcvHNpmiKxJ0BFjKO2EmTWIe55YW/120odgmcUeJK0yr3bch7LLx1FEZleRGnfX7l2poHmi3b0pmZCxFxFMu9bYoypeJjknSXLybM5iaxwjgIaHj2bheK1AetQbncbZ8g==
Received: from DM5PR12CA0003.namprd12.prod.outlook.com (2603:10b6:4:1::13) by
 BYAPR12MB3352.namprd12.prod.outlook.com (2603:10b6:a03:a8::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Fri, 23 Apr 2021 22:24:57 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::b6) by DM5PR12CA0003.outlook.office365.com
 (2603:10b6:4:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 22:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 22:24:56 +0000
Received: from [10.2.164.27] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 22:24:55 +0000
Subject: Re: [RFC PATCH 0/4] Support for passing runtime state idle time to
 TF-A
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <thierry.reding@gmail.com>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>, <jonathanh@nvidia.com>,
        <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
 <064341f7-dce3-5ad4-e69b-9568115035c1@arm.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <486856be-1e66-fd77-e306-949b91bcdb1d@nvidia.com>
Date:   Fri, 23 Apr 2021 15:24:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <064341f7-dce3-5ad4-e69b-9568115035c1@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3512c33c-6dcf-4cd7-b811-08d906a6a029
X-MS-TrafficTypeDiagnostic: BYAPR12MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR12MB33525412180C2FA4E7ED3D88C2459@BYAPR12MB3352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJCxerfL+Lfub4feEnLM5T1ip5dS8FIjOZtpgVqeN+2r0DsAk+eBzkmDM8WLnP59nrpL1iTLL70E3zWutn21s7hZ3VkHqnMpo8LvtRbXJoQVPt39CcdMqPuiLfgfdWPtfqYFml0cgTeYPt6tU61UlTxKtNn9uxANVZZHWJNN6BZq8fK71VudMPTWH692jqRuLiV4GSOaJTM8hm24ikhRJZFkwcbCr22jUHQ+drVWZfXrHUn9F5ZZBGJdH1E9vVCx616+2+jWkx8t3Rzh4bLXdFh9yJ/SxO01KhIMwJo6KFCNl7z+iqlFryQLDtdSxPABL+GC+4G/OJVghrw4UpQhQfvqClrx90QSHt+JaKEFdLRvCFOgRvIjjWqpewmCdj/xWkZRIlyMqU4qAFj3R6I+vz1fAvk2OpimH20xWcXLngp9GEtNwZrm0SKaj93tXPPq0xLSq2W95/T5gObH5ctIirIWT72rb5bxMfJOF/Bivd5h3Y0/QCCOTl5pw4XnP1DlgItzOPP/nw3mOlXs4uzfQUqs52rHIx0qpDasxBRIUqzqjPtrPZQz9eeKjwgVEmDC7Ea2J/Ne6JKuQnz+9UF3gUVX+7i9hu/uiIEZSOnvrkyhsLbz10aCQTjUQg9+T82ZTwItfZVah51eaavQiQ/9ij4VE0Zk6Fd+wwQirYfOGx71VXdCFy8Ts4bmrg4/p896
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(31686004)(47076005)(4326008)(16526019)(478600001)(186003)(8676002)(336012)(6916009)(8936002)(36860700001)(53546011)(36756003)(31696002)(16576012)(7416002)(54906003)(36906005)(26005)(83380400001)(7636003)(316002)(82740400003)(86362001)(356005)(82310400003)(426003)(2906002)(2616005)(70586007)(70206006)(6666004)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 22:24:56.9932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3512c33c-6dcf-4cd7-b811-08d906a6a029
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3352
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 4/23/21 1:16 PM, Lukasz Luba wrote:
> Hi Sowjanya,
>
> On 4/22/21 9:30 PM, Sowjanya Komatineni wrote:
>> Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs 
>> which is
>> in charge of deciding on state transition based on target state, 
>> state idle
>> time, and some other Tegra CPU core cluster states information.
>>
>> Current PSCI specification don't have function defined for passing 
>> runtime
>> state idle time predicted by governor (based on next events and state 
>> target
>> residency) to ARM trusted firmware.
>
> Do you have some numbers from experiments showing that these idle
> governor prediction values, which are passed from kernel to MCE
> firmware, are making a good 'guess'?
> How much precision (1us? 1ms?) in the values do you need there?

it could also be in few ms depending on when next cpu event/activity 
might happen which is not transparent to MCE firmware.

>
> IIRC (probably Rafael's presentations) predicting in the kernel
> something like CPU idle time residency is not a trivial thing.
>
> Another idea (depending on DT structure and PSCI bits):
> Could this be solved differently, but just having a knowledge that if
> the governor requested some C-state, this means governor 'predicted'
> an idle residency to be greater that min_residency attached to this
> C-state?
> Then, when that request shows up in your FW, you know that it must be at
> least min_residency because of this C-state id.
C6 is the only deepest state for Tegra194 Carmel CPU that we support in 
addition to C1 (WFI) idle state.

MCE firmware gets state crossover thresholds for C1 to C6 transition 
from TF-A and uses it along with state idle time to decide on C6 state 
entry based on its background work.

Assuming for now if we use min_residency as state idle time which is 
static value from DT, then it enters into deepest state C6 always as we 
use min_residency value we use is always higher than state crossover 
threshold.

But MCE firmware is not aware of when next cpu event can happen to 
predict if next event can take longer than state min_residency time.

Using min residency in such case is very conservative where MCE firmware 
exits C6 state early where we may not have better power saving.

But with MCE firmware being aware of when next event can happen it can 
use that to stay in C6 state without early exit for better power savings.

> It would depend on number of available states, max_residency, scale
> that you would choose while assigning values from [0, max_residency]
> to each state.
> IIRC there can be many state IDs for idle, so it would depend on
> number of bits encoding this state, and your needs. Example of
> linear scale:
> 4-bits encoding idle state and max predicted residency 10msec,
> that means 10000us / 16 states = 625us/state.
> The max_residency might be split differently, using different than
> linear function, to have some rage more precised.
>
> Open question is if these idle states must be all represented
> in DT, or there is a way of describing a 'set of idle states'
> automatically.
We only support C6 state through DT as C6 is the only deepest state for 
Tegra194 carmel CPU. WFI idle state is completely handled by kernel and 
does not require MCE sequences for entry/exit.
>
> Regards,
> Lukasz
