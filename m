Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B75368A2E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 03:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhDWBEJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 21:04:09 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:42080
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236592AbhDWBEI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 21:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee6xvE++nrN6RKKyIZb1Ng4AXg1OQGpTAY2sVpCrjw21wGaWFP8M6WJUoU9ysjytxe/AXiSG205DTLpIT18GlHMgF9uCbv5MT5leDCaDIUDqiFrId4YLudsmohN1PnMDBUiNSlbULl7uD97Uzixo3+35+MR1nhNCDf6K6ki0KhjzHcbZyHRYBX/XMAeO3EhXn+/g4440fs1WhTizgqyrLV8pAvdDUXiPghzGskKOXE/uV/vtIa7UfL4Z890cZa+HPC8ytT3UM+mDfdn3qXnp8AXVq81x81bq92Com3qCChtlY87+9DU/0x5Yv0Tyi923QhunpBoKjdwrDIUCQvwWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v998voDw3Cf5C02v6jGO/sw763cByYuFiyI6fG2NQhk=;
 b=RSV7NFBJixB047XWhkB8CadwjZ8Z5YtMbcocQk2OUXEObLbuMClQr8A4Gs3haF90a3s7fZQGe4+Xalf89oeijwvBY5Ez4UQk9bvtfYu+z0oV2p6cI3OmYKQnV09KEcYB13fP5e1reoP5H6Rud17ChpFHKirCRe3cxOASqegb94w35j+xHQCNBR6TV7GQLgwYdRDtEPfk2AaNAV4n2Rq+0KJaZ0FLjgGW2HBXQZfm3CZmA+MXrvKN8ZOVbXtC7KWU2obazsuYHLVzDZ7Gc51LWaqCeyJGBkwcHJPBdoBDccMOrwUo3/tg8tfMneKT9q5vHEiIHq6cJaY6cY16xFXLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v998voDw3Cf5C02v6jGO/sw763cByYuFiyI6fG2NQhk=;
 b=Hcs14YSEeny7uJV9306+GNh+yOmMS9v5X4rw73Mw2qxS3+ZSpgxhMMeWa3vISRqiugjGd6NarE2fVfhhAfQsoNcJN2mKpTdpsGLNJSBfFeeIgJ6GjwdU8/VniCzQgtpsN3WoPCCGKYLMDhmhX9PZMe0YbGWuv49ehAPyir+OPSxTIFC8ezHh4/PG2HFWd4rxe4n1+yfatfteDYVTwTUfwaMW/TwYmra81qqxb8pFjjuk4wTFyZPFtVg/KSBOqw+F5pCZIeOrtV5K2/jUsNSd/8l9ba46KFJ6atufoTXBPnczVy8jI66aoz2A0ScXPfMre05/WbEYQRhiEFPP+pWv/A==
Received: from MWHPR17CA0049.namprd17.prod.outlook.com (2603:10b6:300:93::11)
 by DM6PR12MB3643.namprd12.prod.outlook.com (2603:10b6:5:3d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 23 Apr
 2021 01:03:31 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::f6) by MWHPR17CA0049.outlook.office365.com
 (2603:10b6:300:93::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 01:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 01:03:30 +0000
Received: from [10.2.164.27] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 01:03:29 +0000
Subject: Re: [RFC PATCH 0/4] Support for passing runtime state idle time to
 TF-A
To:     <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <thierry.reding@gmail.com>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>
CC:     <jonathanh@nvidia.com>, <ksitaraman@nvidia.com>,
        <sanjayc@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <82b57776-9002-0dc8-aa0e-f1057ce3beef@nvidia.com>
Date:   Thu, 22 Apr 2021 18:03:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88da28b7-2799-4c8b-15e0-08d905f39c76
X-MS-TrafficTypeDiagnostic: DM6PR12MB3643:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3643D92AC11507080CA1C170C2459@DM6PR12MB3643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBgk7NjKId9vCGYb6Gz4ixV296r0bt71vJBnISMUOKD1FZquHDIFN1mnYhyHeSZsgc3ANSHzxd0OLxmaGVZbwvv/y+3fxC5iJgq7vW05DgbcDHb2PkbJ/jz0kAf4/5IoalPdTKpJzYoWSek1MazwN/Ki0PQtFTqtDmCqpg6nDicYKpoCEuUxOMxm8IVk4VRqrEJ/wdbzUGG6i3HmdctOB8Z2ps70OVwFrB6owcNpP7d/4plw3R4d2DMKUSuApyauBjfHNjZBxeeEcEpe6O+ROqwWTLgStjs+qCNMDrj71vKQJbp76lGwsclWyAHiOtozrW5WGzkn9CDLPohiP6s9JD/phT7KgkCjan362F3xXwCUP5krgz2M+udNmC9rqOvPGFh0sFxjzLGna2I39CIeEJCUqqR6dRLQMxPpgqbUstYBYWKJqP5YTbPNs8mj+ceozM+qr5zYupTNVVwrmUJZMFrCbE2RetwxU8nTGIqKBI2lWohrqEHl8cjOdEYjkfsjSrDQb41fq+8xRTBsIw53f9MlFuXPjpzi0dIMRejVUC5rbOVI1t/tn0BPnsPem048uGxYq+0MHZ3g4VhSbGBOcT31CJLne6xWM6ZdEk/Ex4BqeRSkxtnWGARmSjerLhH6+GhxpzuVb9GMK1CaT2fZzv4AQaxlEpDscNx1moPuFnRZPw5X4AABiO1DqcsAmjvH
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966006)(36840700001)(4326008)(83380400001)(8676002)(8936002)(70206006)(16576012)(7416002)(356005)(36860700001)(186003)(26005)(426003)(16526019)(36756003)(36906005)(47076005)(7636003)(2906002)(478600001)(54906003)(31696002)(86362001)(82310400003)(2616005)(316002)(53546011)(5660300002)(31686004)(336012)(82740400003)(70586007)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 01:03:30.8722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88da28b7-2799-4c8b-15e0-08d905f39c76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3643
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

kernel test robot reported below errors for patch-2 of this series. Will 
fix in next version to use div_u64() for nsec to usec conversion along 
with the other feedback I may be receiving.

drivers/cpuidle/governors/menu.c:398: undefined reference to `__udivdi3'
ld: drivers/cpuidle/governors/menu.c:398: undefined reference to `__udivdi3'
ld: drivers/cpuidle/governors/menu.c:398: undefined reference to `__udivdi3'
ld: drivers/cpuidle/governors/menu.c:398: undefined reference to `__udivdi3'

Thanks

Sowjanya

On 4/22/21 1:30 PM, Sowjanya Komatineni wrote:
> Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs which is
> in charge of deciding on state transition based on target state, state idle
> time, and some other Tegra CPU core cluster states information.
>
> Current PSCI specification don't have function defined for passing runtime
> state idle time predicted by governor (based on next events and state target
> residency) to ARM trusted firmware.
>
> With the support of adding new PSCI function to allow passing runtime state
> idle time from kernel to ARM trusted firmware, Tegra194 platforms can use
> generic psci cpuidle driver rather than having Tegra specific cpuidle driver.
>
> During Tegra specific cpuidle driver V1 review, Sudeep Holla from ARM also
> suggested to use generic cpuidle driver by generalizing the need of runtime
> state idle time.
>
> So had internal discussion between ARM and NVIDIA on adding new PSCI function
> to allow passing runtime state idle time from kernel to TF-A through PSCI and
> once this implementation is accepted by upstream, ARM will look into further
> to update PSCI specification for this new PSCI function.
>
> So sending these patches as RFC as new PSCI function added in this series is
> not part of PSCI specification and once this implementation is accepted by ARM
> and upstream community, ARM can help to take this forward to add to PSCI
> specification.
>
> To keep the backward compatibility we can't update CPU_SUSPEND function to pass
> state idle time argument. So added seperate function for passing state idle time
> and serializing this with cpu suspend state enter.
>
> Once this approach is agreed, we can either use this way of separate PSCI
> function for passing state idle time or with PSCI specification update we can
> use same CPU_SUSPEND function with extra argument for state idle time which can
> be decided later for final patches based on discussion with ARM.
>
>
> Sowjanya Komatineni (4):
>    firmware/psci: add support for PSCI function SET_STATE_IDLE_TIME
>    cpuidle: menu: add idle_time to cpuidle_state
>    cpuidle: psci: pass state idle time before state enter callback
>    arm64: dts: tegra194: Add CPU idle states
>
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 19 +++++++++++++++++++
>   drivers/cpuidle/cpuidle-psci.c           | 11 +++++++++++
>   drivers/cpuidle/governors/menu.c         |  7 ++++++-
>   drivers/firmware/psci/psci.c             |  9 +++++++++
>   include/linux/cpuidle.h                  |  1 +
>   include/linux/psci.h                     |  1 +
>   include/uapi/linux/psci.h                |  2 ++
>   7 files changed, 49 insertions(+), 1 deletion(-)
>
