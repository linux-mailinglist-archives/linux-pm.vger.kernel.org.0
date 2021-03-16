Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04133D2ED
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 12:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhCPLZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 07:25:10 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:27616
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234251AbhCPLYt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 07:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfbUU2BILoye5kGlxwgWXTyUC9BDqYjqmm0EArUqhG+1N0I42+QR1qyfug+zG7VrCxPaNdwMf/LD75UtHMjICySZPrVY6ygZPd230mpeHT/zFRthSPGxZt4tO8AA1hT3azcdzh0xASMcEVHTZiipAMY0OfYmkm6YFb8KcYr1pXTS65PWz0cCRN0sFho8TIRq5cf+P9lBHuiM3x1iB3EJ8JLLV5vz65N/NkOjOUlsgUzhIonUAJmRfK4ay8HR0GvPvRoXGnwG2w/B5yUxkzyY408FkTQKYFM6eVkgqd1C9sVHc1pamZN6WruXZ6vEhOmRGg0DdVnmCH82ebvFDC78MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLrqSKl5LomAT1wWEOwc0Vvx8sTrtanRpjjdXZzOLDU=;
 b=b6nkjdy2yztT/VCN4spiWkVGsNktSlElq5ijH+WZp+BRo2Me1/P++Yln0Lup3EqbIf3aMiuocDVP+1ngir3VpH0/+8sSsGpUed/gz/5BaJo8goM8nTC4vCWZ4qBW8q2s3Tyj5t4OrjCfnHop3dWAVmIXPa73EFjbY7avh8JDzmtAanRlRBH6f9ffEIr8jXJdMefUPEpUyJysKCqHDNZZy+pHfjl+lCTLa1UreONsOfxPjAnvha3bK2URKVOJkIgywVfat7aC48SCgyECcl/uzMzXjjEFZ+kv9eGoFh30r8i/B1qHd24in4etNMz/Lx6Q6kvxPBzlLTfIfvPYNW6qmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLrqSKl5LomAT1wWEOwc0Vvx8sTrtanRpjjdXZzOLDU=;
 b=YAoV6MGdb7czW7b7vMfvv2glBVTKS7lk60GqmFugt+mHJznvTgBmMgKicehsqkrztjWOk9opP987/wBgUzqqWxDT/MBlLMm5phO23skD6favd2kFm1aXt+juuTJl2nQIr2+21jiWXS41DgIGVA6uBD1mDzXUSiG1hnTsnIn8tQr0R3vLPs8+VnjB29reTaHYPccc+hu/N+/Od+4QhtfueVZcX0KsjRrW+Pnz9XXcHPvRxHxYz9RS76GLiRmlLNejU5RGSHKJL/pWpGNkE5N02EBTuoksRfkc54GisoNu7w0hpMq0Ud/84InNGQeVPhUV4CwrJb4tBXqLGHeVkoXqJg==
Received: from BN0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:408:ec::31)
 by BN7PR12MB2659.namprd12.prod.outlook.com (2603:10b6:408:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 11:24:46 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::63) by BN0PR04CA0116.outlook.office365.com
 (2603:10b6:408:ec::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Tue, 16 Mar 2021 11:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 11:24:46 +0000
Received: from [10.2.167.16] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar
 2021 11:24:44 +0000
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194
 CPU nodes
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>,
        <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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
 <20210316071811.5mqcatmmbvrask2p@bogus>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <f1d49d3b-0d6f-dda0-ea44-1bff21b52fb4@nvidia.com>
Date:   Tue, 16 Mar 2021 04:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316071811.5mqcatmmbvrask2p@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c535ab82-3f8b-4199-153d-08d8e86e1aa5
X-MS-TrafficTypeDiagnostic: BN7PR12MB2659:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2659896D82EED61F0A60CCD4C26B9@BN7PR12MB2659.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKxcHlkNxp4sAI006xtFC6wivygvc9Y6P7UI23BbKoyj+izTATlDMoTyw3s8i0uB4H2acVPmnH/o3Lr/frzA/lOuYIMHInolJiZBbAmWQRFntphfn7uRUeN4gu80h5OSRbZDF7dowP/YU2a4DcNkaoWw/8wPJfh7PT1zk0mS8VLapgQ3yLK2MiLQN6MhymH3INkJ50rS4CMApMGJjDEHUkiUEZQD7gbMzWkWbfiCqiypHYw3ZkUQ3gxt0KOIjQZuzsK4y+6IGZ/rS7YFWGFjmwmJBgFoKjtMQuqnZGZ/lO+hDi3pEzAa9QX/tx7hugJnVMe8MjbfLc8dvLXYzevpTliP1+RYKL9TJ8hJqgHdENib9ZLn7uE8Fs/M7+XkuMOuL2u8Oq6RKdtO8MkmylAebmKCDKl2iIMtHzpyfn75SRsm7FEhpS61+hXDSJZS1d1SRsIMmkpPui0oYz1x0xRXNC7jAvnBQMLa2ZWHNuNg7Uf9gYVzEeLgzkM4XW6yFBHqXK6ZpflEAG+wt4i6RLhkiFUvfpfoey+k71VsSA6bm0FlIQucIAfsX600obpVToJ2CLvjoqOBOLAyvDKvj/l+PKLAPlULEu7OWAyzNqrUclUDZDp0wscxHLvIyBjhxJbIJrFoD4EmeNSLn6E4fCdsYrbso9T+rXDHpZgr/YJrtCZJmTvwRPQgBOwIn9dVZ8fR2MnW2vI+xxGDz05ZTQGQXEGOltkxJtdos2+Z0PgKhPQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(7636003)(53546011)(36906005)(86362001)(186003)(70586007)(83380400001)(4326008)(34020700004)(16526019)(82740400003)(356005)(47076005)(31696002)(2906002)(36860700001)(82310400003)(316002)(2616005)(26005)(8676002)(6916009)(478600001)(36756003)(54906003)(426003)(336012)(70206006)(8936002)(16576012)(31686004)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 11:24:46.1399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c535ab82-3f8b-4199-153d-08d8e86e1aa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2659
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/16/21 12:18 AM, Sudeep Holla wrote:
> On Mon, Mar 15, 2021 at 11:13:24AM -0700, Sowjanya Komatineni wrote:
>> Hi Sudeep,
>>
>> I see you are one of the maintainer of PSCI driver. Please add any other
>> right persons if you think should also agree/comment.
>>
>> Can you please comment on below 2 items based on your feedback?
>>
>> 1. Can you please suggest on proper way of generalizing to pass state
>> residency time run-time along with state during state enter?
>>
>> Not sure if any other drivers need this but for Tegra as MCE firmware is
>> in-charge of states enter and decisions, passing run-time state residency
>> from kernel to ATF is required and agree on not using power_state value for
>> this which is against PSCI spec.
>>
> Yes, I prefer you need to get this added in the PSCI specification.
> I have passed this thread to the author of the specification.
Thanks Sudeep.
>
>> 2. Regarding state thresholds, although state thresholds are policy related
>> in Tegra cpu idle perspective these thresholds are platform specific based
>> on use case and mainly for MCE firmware usage to decide on state transitions
>> for core and core clusters as well.
>>
>  From previous emails, I gather these can be moved to firmware and need not be
> there in DT ?

Yes we can move state thresholds programming from kernel driver to ATF 
but we still need to use DT properties for this to allow users to tweak 
for their use-cases.

With DT access in ATF this can be done. But checking internally on 
having DTB access in ATF as currently we don't support that.

>
>> As these are Tegra platform specific, Please comment if any other concerns
>> in having this configured by Tegra CPU Idle kernel driver.
>>
> I prefer not to have Tegra specific idle driver if we can get the necessary
> changes in PSCI spec. We must then have just one PSCI idle driver in the
> kernel.

Agree by adding state residency run-time propagation along with power 
state to PSCI specification and moving state thresholds update to MCE 
from kernel driver to AT looks like we can use same PSCI cpu idle driver 
although we will be using state thresholds additional DT properties 
under cpu nodes which will be used by ATF firmware once we decide on no 
concerns to allow DTB access in ATF.


>> Based on my understanding only above issue-1 is PSCI compliant related.
>> Please confirm.
>>
> Correct.
>
> --
> Regards,
> Sudeep
