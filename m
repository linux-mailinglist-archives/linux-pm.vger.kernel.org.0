Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB43699C0
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 20:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243503AbhDWSdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 14:33:42 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:61695
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231760AbhDWSdl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 14:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmHEPcyQRI1STAb0UqVjdYmXh0F9BMefpT+Jja4bIy0OOFWM4MhQbL8jPMRL4jgO5bQunJ3WsZtfMgxn5g/IIfplqAKFsuZoFV6+s+GIJPZOZBzRrJT/fB3Lp1UhEDjMQVDbw53gxYdPgiac+JhFcVbfsfC+rKurxxUfSVpVhCCirmNQOMgXkqmYcTyVcXxEJFP7UJLlI8ObuVpDW7uuE+d9KaPUPhEj6cQH/VRSQefomtnuFFsJajFBUGqR7/Z+iF0P9FGln+ONixAz6m4VafRKNd0ly0bVWFlDyIv4uC64FodoQ7Pz8Hqqqi/4xOlhS7tfhDcuVTNCxBB7fphDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0plbX69qHnosr3Qa02BBKmUgABxrcp0luBXAAdA3MZg=;
 b=T58SlwFFXzZqHSI/Z9Wjs6Br1QSgYXfJD2xpKtu4JGn14eqo51nl05fG971XoGh8ZtWd2P7rLArVdB3FltYDwXZVs78IyZTT8xsnZNXwhD2Nf9ELGkdO1pFXoD+seHGjnO+JRYvTjNnbStmUG25oGvSdiokpszYT9r2c1UowdjNuGeHwp27rYmtH6W/NlQ/HrTJirdwh9xgW9q1ApdDiZ35dUVn/KxiVXAQOUBfV1P8OqW5+43BAQjcrHXkOH10eUK/viXM/MZMIN72ic1N+hktKE0NiOT87oxF/eksf+T/DS6X/R2Mqjl5oiv9ts9Eir1KX8MuYDLWSDCBss5SxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0plbX69qHnosr3Qa02BBKmUgABxrcp0luBXAAdA3MZg=;
 b=Mlr6Q575AA61fdwwTvrWOXs2wHdmvELSX6tLNdki1UbGvc4HcPQDKgwoBA3yVB2dPX9IMi2/oIQoEVMfGRpkKndpynMyyblaCIEIz9DFRYVw1h68jozC87T3XGX5oDKzb8aFeNtAg2L8czn2bDDiOHbRe37PoAmGuCkQYhLcXx+VS9b0DifxDEiEJE/j1iuYnSOr00gn1+nkqwLi+/ycvZDOaOBylc+Hu7dUzPA7+0XYC4vrYlsnUuxpljPBvrfMrodDUjwM9Kg5p3yX/JXIr4QdeIH16/UtZq+UO7VM1JoFOdf1IIY+JgQTLW6nHtayKq/uLe/psQf2/LCg3fLdtA==
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 18:33:02 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c::4) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Fri, 23 Apr 2021 18:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 18:33:02 +0000
Received: from [10.2.164.27] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 18:33:01 +0000
Subject: Re: [RFC PATCH 0/4] Support for passing runtime state idle time to
 TF-A
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, <ksitaraman@nvidia.com>,
        <sanjayc@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
 <CAJZ5v0hivxQjA2AZpPxVadzaM7gB+L3BRnoNyeD7hyvr-3Fh4g@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <9c01bdb9-90cf-f14a-a886-c91ef01bcf25@nvidia.com>
Date:   Fri, 23 Apr 2021 11:32:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hivxQjA2AZpPxVadzaM7gB+L3BRnoNyeD7hyvr-3Fh4g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b6523a2-23b1-4a36-71fb-08d906863a6d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4359:
X-Microsoft-Antispam-PRVS: <MN2PR12MB435907B4FF6BF87780061C9FC2459@MN2PR12MB4359.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5ZGQZ24GbaGFHoJfAKOyP16uZ1+Xg24Tu8jmstgrepdrE4qAINCSXQ5bK1vyKF6DF/r568A6wptjBkvoTSeFHRPJZUDiM7K5l2ZDHK+Wsnrc3g0tJ7Una1HN2u5K1BfdKWzfN0IlmGdPeJN/ZZtAiIdmHAuePxnPNjyjszWkPgkJofONfq8QbeM2i45PtqPweGsPia+9U+FL0MSirt1rSLUyAIg5TLrclAeZGoaDsO63mIZhvde8nii2gqkaVvMUAm4+nCR9ETdZ+qPbTbL8GJTOgwI1+Mwx2L5vqFtWy/8/BSUOMTHAFq8cidQFziUNe+fCYjqYCyxeY2p1LMOVdaW2lNyVQSvDNtcJEyzOxnYwD6qF4lGMJyqX44v+eBJMW/CBa1BGRGpliKXEeyxy77ViD7db66G1/TI0vG0bx5xxm3sfNW0J55VxQ3urMu5IoM1EUMYQa4uS/AdMHx1RbnEg5hnP2M0M5rPHWMDnc0GAfSwI50qUKFyqDDHGw8/MzoUpV7W0rX8CyFIeGTH5sToGM/cwYcd6SCiB1TKxhBk/wYxi5F5ex7pxmz0LP/in83lU5AeiZcsx2JFZrKMrWwwNqrqbvVsk/UuNXfwJvayPkSLEwccY6oMXE9WPBu3R6KgSSkUozeQV20xACOZndUkOpcoTXn7wiZg5dvovTWgLHfrdMdVpPxwV5LFqPw6
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(5660300002)(36906005)(316002)(4326008)(86362001)(6666004)(54906003)(16576012)(31696002)(478600001)(70586007)(186003)(70206006)(36860700001)(16526019)(7416002)(36756003)(26005)(83380400001)(53546011)(47076005)(31686004)(82740400003)(8936002)(356005)(8676002)(6916009)(82310400003)(7636003)(336012)(2906002)(2616005)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 18:33:02.4251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6523a2-23b1-4a36-71fb-08d906863a6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 4/23/21 5:27 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 22, 2021 at 10:31 PM Sowjanya Komatineni
> <skomatineni@nvidia.com> wrote:
>> Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs which is
>> in charge of deciding on state transition based on target state, state idle
>> time, and some other Tegra CPU core cluster states information.
>>
>> Current PSCI specification don't have function defined for passing runtime
>> state idle time predicted by governor (based on next events and state target
>> residency) to ARM trusted firmware.
> Presumably that's because this is not a good idea.
Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs.

MCE firmware handles CPU complex power management states entry/exit 
based on its background tasks and uses expected wake time of the core to 
decide on state transition.

Expected wake time is based on next event and allowed  min residency of 
the state which governor predicts in kernel which MCE is not aware of.

So need a way to pass this info from kernel through PSCI to TF-A and 
TF-A will update this to MCE along with requested state of entry.

For example, When C6 core idle state is requested, MCE notes the time at 
which core is likely to wake up. There could be background tasks running 
on core which kernel is not aware of.

When those tasks are completed it will check the remaining time against 
states crossover thresholds (programmed by ARM trusted FW) to determine 
if its still have enough time to enter into C6 state.

While a core is power gates, it could be woken up for background tasks 
and put back to power gated state again by MCE based on expected wake 
time of the corresponding core.


So, Tegra194/Tegra186 CPU idle support, we need this runtime state 
expected wake time predicted by governor to be passed from kernel to TF-A.

Thanks

Sowjanya

>
> A basic design principle of cpuidle is that it should be possible to
> use every governor with every driver and the changes in this series
> make the platforms in question only work with menu AFAICS.
