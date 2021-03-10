Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605EC334C64
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 00:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhCJXUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 18:20:12 -0500
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:3862
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233565AbhCJXTm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Mar 2021 18:19:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHldMle2Sxit3d7WpbI9uyLZTCXDgs2X0Izf1EgiU+XmL5+tRxJlYEGuzgQYiIiJtBRhOnRCgtCqPAJNcYjW0T7gZbVogon4WT5kgaLnR1yufNziaVcNvv6J2cEYWnmsYMKz0+k+4npOT7NbrpmNQwh+JViWpfptv34QVop9vnsBjp6EWqmOjJ/nKAtWdWqr+/NTTjdvQbA90verkIkLbvVLq3muEL0ZHKFbWJdxCgvBs2tytlp6cngiqWfUgZNobMM4qAaLRcs1jkh1ChbYB7xMLqYEeNwx7VGhyeJBukUXoI+1Ag4tCFAShL3fkfHZ+78B9OnMV42+ZctnflSAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFu505FR9RYT3OrjpTPnnBDCFaROic+fMpgLK+ozp0k=;
 b=hP914p2SKCSB043fgVg769+wxax7ldRfURjctuIqn1BSjkzj/nSRNNQaCtxk4+vTrW6WLaNUEGM75iFOREZ3IhUMlC8qkzBfY1F5VpcCnXhSsRyN0TO6q9MtR/41nFi5vCJzim3LkFp//W/59t7wjbkHvTpkqZ3yUWzpXGeJ9v4Cze3F5wFSYswJGkj1JtezZi54dCmdBU3/8i5FAIT636Lma7hteLfssK8ffqeIuS+dF8P7BaWvivkU/olU6LvEBojR5vWBM7kw+aLDxjiigOr8nbsumaDCllM8BAszcSzA6aidISUWJ5K5klbxUKu9ILuVrciqsUWz90DZZePWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFu505FR9RYT3OrjpTPnnBDCFaROic+fMpgLK+ozp0k=;
 b=VuFA1F9bKIujsFVa/0o7Q8JewNcMVaGNrS2UTyOZHRy8lEj1iq0HAMGjAL6hcsmBc/ffalKgvksPa20wVoXGwcsgcEDyqAvN1fXZgVUsBkyAq5HeDryj1YDAi/xuv51xzO0AtN2B3QMWNAKq3PWm5yafF2syu+cxPCcxf5diOcsm7qrMAyNI40xsLG03AJOeNMTmv77Zya6WbjqGN90xU9nm00hbiwwD3+P2KUk67lYDUgj/OlLuLiKZgoCyx4d2B/Ef2rZdmXpMzto6jCIUGatGgj+8W996oFcDxsng8hDQQtFMxSDEBvwimFIRP8eFVTvRvMk+QrCzXL/M5VpmzA==
Received: from DM6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:100::26)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 23:19:37 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::3) by DM6PR03CA0049.outlook.office365.com
 (2603:10b6:5:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 23:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Wed, 10 Mar 2021 23:19:37 +0000
Received: from [10.2.172.165] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Mar
 2021 23:19:35 +0000
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
Message-ID: <72ba3be5-670a-096c-4d48-9d1d8d6ae0c2@nvidia.com>
Date:   Wed, 10 Mar 2021 15:19:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 843c7f8d-8030-4d78-6ff3-08d8e41af917
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:
X-Microsoft-Antispam-PRVS: <MW3PR12MB44100BB0D71813FD45002DD4C2919@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNUKlBMzW1UNHVZpOqCYiWoDpXDnszdXrUmZjuKy7kTF9+s0yfJDHnHAxh67s0vYFY92muuZMuBjxjhVBnUrea6NIwgKs4Oik8i5sJ0JI4BDicyXtOLPQTrmH32fDFFOUI3qljqaPMRshWTWDhmYtMo0HurYA8ATsChZqKq93rdmP3bjWyjUq2nAq6wFNrL5TLUZOQhEgJVfceoA5MWSmwphz6UGOsgIsD0r7Mb1vb43PU89ozIZpXW+/k5GJLf1R1Ps8Iu53v6dPhyq3/Le3mtmlZO5AMoqkKHlwbW7VMr2ae6t/J1Ivt4RsuoVdu6OvV7VFie39afPkwftjOQCJj81PLTgRfHhZ3RMRITwuYo8+KL48c0jbV9juDHtZ8vwBtVlEnI11WiiIHnkM0gOGHUDY63Ged9apE8NGl8H9ihXZhE35tkFRseoyE/IW7cvyE38+OvAXNthgZ4K64h6XX7E8ftsVj+m1xXFaTYyhnjuZlTjhM+IDNJo5hkUlW7EkyWCHYdQg6uTcXJkAFsNbuG3AXL5OJs2W7PlxWQyX2I5ivAUAh2vY9DwLcef8jAUeixwc8rq9mjKVox6kPxZjxw0RZunoF89YjAy8xd6rRibh0PFS7zG4q84Qr+qtbgjUdRmA88v1YQP/pLvJbbnArzMrJcw5xyV++VqNgEqEhRcZih9fRCsyNBFkOB86p6Rh7zXXsseCPA8rq6nGLKnP/woyFCk7WZCKY/G7ldPbJ0=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(31696002)(53546011)(6916009)(82310400003)(8676002)(8936002)(4326008)(16576012)(316002)(5660300002)(478600001)(26005)(70586007)(2616005)(70206006)(86362001)(186003)(36906005)(2906002)(336012)(54906003)(7636003)(47076005)(16526019)(34070700002)(82740400003)(36756003)(356005)(83380400001)(31686004)(36860700001)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 23:19:37.1241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 843c7f8d-8030-4d78-6ff3-08d8e41af917
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/8/21 10:32 AM, Sowjanya Komatineni wrote:
>
> On 3/7/21 8:37 PM, Sudeep Holla wrote:
>> On Wed, Mar 03, 2021 at 10:08:10PM -0800, Sowjanya Komatineni wrote:
>>> This patch adds cpu-idle-states and corresponding state nodes to
>>> Tegra194 CPU in dt-binding document
>>>
>> I see that this platform has PSCI support. Can you care to explain why
>> you need additional DT bindings and driver for PSCI based CPU suspend.
>> Until the reasons are convincing, consider NACK from my side for this
>> driver and DT bindings. You should be really using those bindings and
>> the driver may be with minor changes there.
>>
> MCE firmware is in charge of state transition for Tegra194 carmel CPUs.
>
> For run-time state transitions, need to provide state request along 
> with its residency time to MCE firmware which is running in the 
> background.
>
> State min residency is updated into power_state value along with state 
> id that is passed to psci_cpu_suspend_enter
>
> Also states cross-over idle times need to be provided to MCE firmware.
>
> MCE firmware decides on state transition based on these inputs along 
> with its background work load.
>
> So, Tegra specific CPU idle driver is required mainly to provide 
> cross-over thresholds from DT and run time idle state information to 
> MCE firmware through Tegra MCE communication APIs.
>
> Allowing cross-over threshold through DT allows users to vary idle 
> time thresholds for state transitions based on different use-cases.
>
Hi Sudeep,

Can you please let me know if you have any more concerns for having this 
Tegra specific cpuidle driver?

Thanks

Sowjanya

