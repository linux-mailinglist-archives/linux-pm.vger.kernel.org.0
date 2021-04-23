Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620BF3699C4
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhDWSeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 14:34:25 -0400
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:13281
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231728AbhDWSeX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Apr 2021 14:34:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRhlCQphblMBPop9q0w4mUq9Xik5CilPWbDIX9RyfX0ftVpkTsdEbgxuAJJoh7zO5jQuD35sVED/y/4y2xhB/Aj05FsGdjJrDZMA+dBuLWZPZ4rwVrp74SswPYKjctfwWNYzdSF7aex9RI/BGnnwCsNdfv0lQ//oNjxkkuMfPP9dWhmZmaLXUpZ3KsuTBs9Gvt/gygBX3BwbAw9xeCOpTI4KGWqnWIV8t/QKjsG5xzwQXhn7XWc92QhAANkF64zAM86tJkNGOJxpgbxfjcBN3nTUkoSdnbC00Rb3QsaqEJzBnsJG6GXguvVs8yZgY4t+FnXkjwHkzc4fQ1j5KIUw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzSnUskQIolxLp7uFinzRSD99r8vMRIHAdFLvcFw8hw=;
 b=QKdTRvQhxDAQnQA6Der1ijwmQ0TglAUR4YMbvLo+WdZb5SXZr4UvhBFjwJTyyGEvokqwtbCh/NP2aVNGhIbGN2Rst/MBh9mvBBg0edPyjHgmZpwX7q/jM0EaxXIMPz634/GH1r0TFPgAwGL0PaHy3KNJ8GeTFw15vrqYCsBLNdHfFNsdcBN8/BtrwENAlQh5Yt6gr+8oWeVdtrqmBIaZXPHRx0T1hprlsszE1/k7eoFbDYRt7UgpHFbGz8IstU8dni2qlNvOik6TpzVt4h87lCPdULSkitLnGyp3ib1U21ztU5zgWnE+4pW5+YofSPe7IjHc2NnkBjTpQMeIqL5o3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzSnUskQIolxLp7uFinzRSD99r8vMRIHAdFLvcFw8hw=;
 b=O38/KSrOKmaIwI06eM0pybZSDvFbmaoZ4YkGprjJ1wJOVNQjn2Rqtbig+M6BCN4LIkrFeZCb7zpMSdrU8c/+waGaY1xWcKVPOuShe0vxNvw8x0HoMSumZ8UWZYAWgWAisTHriyhKNVnCKgeUlJvzZjmGNzdD9IG/Sc/sC78MEvgq4t6zLfyanzhd0GWbOAsR1DiBj9314myDeUC8saekHlofXkjp2cAkq/ZzyL1ZxcqN7515mxHppIED3+DIFKeBC2VFhoo04L5FumlOEdMbiXb+dDuLxUPcfyMuC7vhBSPArquqlq8Gp6l3Pyc6YEc4ZypgtZMR+19BggWSqoD7Ng==
Received: from MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22)
 by BN6PR1201MB0003.namprd12.prod.outlook.com (2603:10b6:404:b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:33:45 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::65) by MWHPR22CA0060.outlook.office365.com
 (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 18:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 18:33:45 +0000
Received: from [10.2.164.27] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Apr
 2021 18:33:44 +0000
Subject: Re: [RFC PATCH 2/4] cpuidle: menu: add idle_time to cpuidle_state
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
 <1619123448-10138-3-git-send-email-skomatineni@nvidia.com>
 <CAJZ5v0hb7AES4A2QHhtMo76GbbkH=FnyQb0oEpHOaWWirpJ80A@mail.gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <f4c0fba9-6f7d-3bc3-49cc-c239fba975ce@nvidia.com>
Date:   Fri, 23 Apr 2021 11:33:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hb7AES4A2QHhtMo76GbbkH=FnyQb0oEpHOaWWirpJ80A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4677f3a-8b92-41ea-2637-08d9068653f7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0003:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0003C213D514D9B82DCCCAF8C2459@BN6PR1201MB0003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMgeX3A+/tHv4cBSFWjAlxgXOfcQIvJjVuzNgWMxG15MdnReQ1ISrsG7EDlfbXmcxR/FsNomYnzjOQNaGPiNZXpIM6RgEjKBmY32SFU1cYwbmEW9EjhKVj6wWLnu0YOCvM00/Ei2ohFhUNCj8Ji9pb0gHcj3C2pyw7Bu81rgRm5Q850j7Cy2Bnq6um0v+FFpZebGhcd/i/xaoZZXY/NLJWlGc3+UaCCIvCOr163uxdC5YVmP8RuhdSAfrr+YsNVZwsb3uR+TPw8AsOPyU1odEDgCYhIYjGxvFz6Z8+x8w3ySV/8rN5a41PiaNVGEl+2VyG7WZ0JGgUgbI776htz+BVnD7SlOnPcA73R5c0fyCbsQijMhNCxkajPNoccYsVkaCpZPjEqu8xFYSgLJqgDTse77+OLRgbwFK+GYb951z6Z50B1rCuqmn2ETo9ZIu3lepNjfDi2R91j6ohH5AGY5tfNfS+tFrqiN0DTkVxQIuk5QoaUk1y7a/NM2wDEZziad4TFLArv4xv1EselITlyOZgTxULcpYBmUdDZDaY11vlE/mrIn1WAHulSumnfZnRwfWou+CaeSdNPFAMh+MuASbENMWq4U5DyEG48AfR8XfeTiSZ381f+c67lXq8PxMXQRmZe+ulTkIAuF4Gck0A18nulOjJ9OQbiJpb7yhCbspDreX5pfbD9/sOeuQDh1ea4/
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(31686004)(82310400003)(31696002)(36860700001)(82740400003)(47076005)(36756003)(86362001)(53546011)(356005)(4326008)(36906005)(2616005)(2906002)(316002)(8676002)(26005)(54906003)(426003)(8936002)(16576012)(16526019)(186003)(4744005)(70206006)(336012)(6666004)(70586007)(5660300002)(478600001)(7416002)(7636003)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 18:33:45.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4677f3a-8b92-41ea-2637-08d9068653f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0003
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 4/23/21 5:22 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 22, 2021 at 10:31 PM Sowjanya Komatineni
> <skomatineni@nvidia.com>  wrote:
>> Some platforms use separate CPU firmware running in background to
>> handle state transitions which may need runtime idle time of the
>> corresponding target state from the kernel.
> How exactly does this work?
>
Explained this as part of other feedback in Patch-0

Thanks

Sowjanya

