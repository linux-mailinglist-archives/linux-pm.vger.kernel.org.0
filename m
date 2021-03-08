Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4D331627
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 19:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCHScl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 13:32:41 -0500
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:58144
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230173AbhCHScV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 13:32:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE6JV2EOoZM9nG43jCQmrXd282kzN7KBmjlm2DcaJbxq9eMEATAZfeSi/LeBcZ/Z42Zrg/mkwJTvizHQnquJvbYs14VWnGWGa0znjSASRXbiGRnC6eMV7hQlF87beZi+zsNEHRoaLcAaFkPhmkvIT46zkg2xa8toU3HL/456/2s+TdVxydc+aTuH2kUTNK3ezPVEvtBH7PUoiLAGggH4S5gjpfHIfos3McYjiOfz+HFXIeT1AuEZhWyXo9v+6HeVGpY8kUsbmNsRx8PmDzBTzPTK90Vc/hrlgv8iphIEgKeDll1lTesc0UsUlhVBY74WGfTWmGJ8Uo5lh+/9YHc70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58Hfx1fmBmQjldn69eDS4/4aivr59O+WczkW92z9Ayw=;
 b=MmzLZY+M426XUnwiiH7vPof3Z4KXSG/KMruyvTfCqhSXTjZzXYOhwC99jhPV8p7XyXV1ow7+FXklWeMEk+Cs60UWgRjio2dzt+SwuXeKiDHIm8biTRrBwOD3B6wOHZ5+ioDTLAXwq/5iJvG6TX4b9kmmI1oAKcl9ckPsttxXNnG3KM32BpqHvRJ62EFbo5NOE5ZntvuUxZY4r/YXmVBN7AiHYEWXeSLh+XwWWMKu3pT8oRt54kS93CPH1+B3kxru14ez493o8ymt+1XTPvWEIY0apaEwPLFgs2Wix7LtOE0fzQMeJIjUS0hox2a3Kl+VCEorZZOTE4xOrGPnAuOFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58Hfx1fmBmQjldn69eDS4/4aivr59O+WczkW92z9Ayw=;
 b=skrpZE/vYBJXRkMgTlmyIDDi3Ai4envTdYq2c9T8Aqq0KgLAhGulM8ijolYz1uINmbSaWf+E1jGopsL1iLknug4uuHuqAWOVlc/8vqevI0DtbONHZSSfIxm92PWQSKgCVaq3mXicW1on1YD5MIXmd3GaTQeTafSIVEWG86AF/Ws=
Received: from DM5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:3:d4::27) by
 DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Mon, 8 Mar 2021 18:32:19 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::86) by DM5PR05CA0017.outlook.office365.com
 (2603:10b6:3:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Mon, 8 Mar 2021 18:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 18:32:18 +0000
Received: from [10.2.163.31] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Mar
 2021 18:32:17 +0000
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
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <4cebf482-a2f8-5a79-a2f6-4ccd7d31c6ad@nvidia.com>
Date:   Mon, 8 Mar 2021 10:32:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308043755.llvdsuz2jwvweovb@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0cf7d4-9397-4f87-99bb-08d8e2608182
X-MS-TrafficTypeDiagnostic: DM6PR12MB3435:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3435AAC9166C0F93FE81F88CC2939@DM6PR12MB3435.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRIhupvFmo/cEyFBhYKdfgggdQo4n4r1w6tIutFfuBK6aKK8uiX1NcdCNZU2arChtdLAb4Q5XbSw1NduDR1AvR6gM4HPNfGp878yoRRNA+5Zgvqv342zFJqNddUaS596K7HQFzn7fNubQtJzwNvt809i/lxUh5Gbqm5fFK+3a1uLioqb1wFxsPAD51k4i78XXTRXUFfxmMHXOBnQmX8tE9dT1D+2qS41btf3tUKhA/gQOwUdizQr1ZVa6fe0bLkmyQw9b5gYO5eysrSE53AcrmDIWWRT9gaZ2yLq6qWrBq+je1LzwfubLbBTYcL573c9CeAjdOFf2dO6iiHFyfRxFzh77MTfo68NmC8eizzyITtHZxsY/Po5/f8BL212+xvCNL2Z8wZYZQOSzDhI+2nDbsvsmMYLJJtyDvTyKKbkbJxd/HyzYnCHmgJH4XgFpRaqYbES2w8z4wROJR63vxYMlHmx2vxnOz3bYmHad+Gr/jHmnoi/E60Cz/0TkeMBWz7lRNnMoSNWq3eWtlBR0xmwez2etTLKdP/79KJOfkKpto/Ig7jyhirtFoTAlP9C22GZqEb+Ih34Azm3W9ovLtzTAxUKpjJz2sAZ/+i71uUJRDya2o0cbftBX55KF2kjlQQykPHnUvULLYS9RiiYnzofVDnH74GArTAbqLAnfu452AW9BIuDaFSHuUaym+mHpUrdaXiImWyvdUDBpiMOmwo6YY2yppsaHR9PncB4AG8FK/Y=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(83380400001)(6916009)(34020700004)(2616005)(2906002)(478600001)(36906005)(316002)(36860700001)(70206006)(8936002)(16526019)(426003)(4326008)(26005)(36756003)(82310400003)(8676002)(53546011)(70586007)(54906003)(336012)(16576012)(82740400003)(5660300002)(7636003)(186003)(47076005)(31696002)(31686004)(356005)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 18:32:18.9403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0cf7d4-9397-4f87-99bb-08d8e2608182
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/7/21 8:37 PM, Sudeep Holla wrote:
> On Wed, Mar 03, 2021 at 10:08:10PM -0800, Sowjanya Komatineni wrote:
>> This patch adds cpu-idle-states and corresponding state nodes to
>> Tegra194 CPU in dt-binding document
>>
> I see that this platform has PSCI support. Can you care to explain why
> you need additional DT bindings and driver for PSCI based CPU suspend.
> Until the reasons are convincing, consider NACK from my side for this
> driver and DT bindings. You should be really using those bindings and
> the driver may be with minor changes there.
>
MCE firmware is in charge of state transition for Tegra194 carmel CPUs.

For run-time state transitions, need to provide state request along with 
its residency time to MCE firmware which is running in the background.

State min residency is updated into power_state value along with state 
id that is passed to psci_cpu_suspend_enter

Also states cross-over idle times need to be provided to MCE firmware.

MCE firmware decides on state transition based on these inputs along 
with its background work load.

So, Tegra specific CPU idle driver is required mainly to provide 
cross-over thresholds from DT and run time idle state information to MCE 
firmware through Tegra MCE communication APIs.

Allowing cross-over threshold through DT allows users to vary idle time 
thresholds for state transitions based on different use-cases.

