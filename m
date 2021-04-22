Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C431836880C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhDVUb4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 16:31:56 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:49803
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239664AbhDVUbz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 16:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0kRd1EKPT5d+Gw83lkX4zPpSVhwjdfr83ewU+4afBpJDjIXKU3O089tms4HzyNeFKn7cKccwfZCPo0i3aug79dSX8Iz0G7e7ZHycklCQ6tGKFtLyys3TUyW//CxXDTVp3KDbB5EoPgBf/RgYBn+GJQM5v4MTh5xnK/TS7yJD96lXI4bEkYDGTwWkLbhAI17CpyrQPkl5ytzVrJph9kPnS/UslbL2xEzESOZSVEp9O0ss2TVjvbzmRFJeOciUqbKX6sZVTdnhLQxzhCpjhT5lDIw1m9EbqZ04EvCvCmwcId2R94bmwn0CtlKd58MRZy8IBwOpnluMKUCCTThxjwWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6S8lXDInWFaqTFEEZimN8g5hMJcs3Sm9N4Gcd+FskI=;
 b=oVN5ulDQ+ILV9MS03BOZwxPu9m/tGCmHLaTAJ88PQ/kpGAMmaBqPC0GvFnEpQfzM26oNFoO++k9e22xf/Lq7DA53HDpv+uvT9/xihv0Q6scdc7t1bUhhMgnH5T1YUVJZOLrQMGdzJCkOKBKSZRGKLSGPOL2HATSMJDKXAllld7vXok22pwSmUtfWegv+Q/ySUy0vThGFjyjU2E9emVI+JHAZGkzji8YotAdg5cKjumAK6kVGFx4hSJvN6NRUOWvEplVkJJL/do2LqUpj4XjyQrAi0CZXxw8wkUZKxy0A4indGYowxS8eDs9jNjDEyYsjv9vNq+mSf6aM0BxnIRzPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6S8lXDInWFaqTFEEZimN8g5hMJcs3Sm9N4Gcd+FskI=;
 b=cGCM6b5RRpC8x/Znslczax9MqRL0jApFRLe1Pu+S5Bdf/EW41SzX/WsVPMTIy669Q6HkSo42x8B6kArpMlcm6sEj6m/2NeeW/SQEAPUd8hrbzeD9r8fn/kyUxsru2kDEEbyZco0ugpiDn3fPd/vEVMi/LaxGGI7yRwPA7VSZw3zcJhHjdew5cJfnHZtAHaCrQhe/ekrSz1x3IwvH4zz2TLxQ5SlWnGeLdHVJVFHVFD5EBX/vblW+xY2H6wLUu6OdeYB8uEmVBEj2+cYCa/jClgupv0QNBs+1+msxzYzGAVj0gB06KRjYIFi+InJq8cQrw0UEpvmTF7U8hzFrlbufpw==
Received: from BN6PR22CA0033.namprd22.prod.outlook.com (2603:10b6:404:37::19)
 by BN7PR12MB2721.namprd12.prod.outlook.com (2603:10b6:408:2b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 20:31:19 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::e2) by BN6PR22CA0033.outlook.office365.com
 (2603:10b6:404:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 20:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 20:31:18 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 20:30:53 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:53 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <thierry.reding@gmail.com>, <skomatineni@nvidia.com>,
        <mark.rutland@arm.com>, <lorenzo.pieralisi@arm.com>,
        <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>
CC:     <jonathanh@nvidia.com>, <ksitaraman@nvidia.com>,
        <sanjayc@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC PATCH 0/4] Support for passing runtime state idle time to TF-A
Date:   Thu, 22 Apr 2021 13:30:44 -0700
Message-ID: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b4f9269-0ccb-477b-b99a-08d905cd95f2
X-MS-TrafficTypeDiagnostic: BN7PR12MB2721:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2721709EF992158DD9FADE1AC2469@BN7PR12MB2721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/kUcv4pRbNvK+M7X9riqq9vQ59PqytsacQUQnSpEXHA0Y0iEcavj9Citu2/n90FDV88uNeBxgRIqP7TR56Xob7uZkIyxDc0fXWG6MScdlgHwEgrdzZHSZdv/xvzZhmpH7Y6K+kZZ+a2Y1Uv8LFeVXTzEuqXM/t3nFet6XigP7iL1aGbqNF1kRc6sQDXncpMDlCqH7LT2sD0M6oNZ1lZOLTN+u+nuNHopigDz+jLQhDPOwIbsOX4hKGCrzEcJbpcT4XRN+4d0g2ytZ/fwDSA+6hA8odFJxHyU6MSWVPaa8wFHIkOoSN2Au4FP+hT1NgRWf/QxqTa9VBI++8C4Djj0lindnu9xphosba74y9tjJGuTlRUiY21Ocqln4rm1H06fyoShQTmTS+LCi7vMv2i7wecfuVhAMtOI7QwOvntNqmNwq54Urib8dF2L17BuSjldHmJqdmWW8xEtBXBBEEWoV9Z0yOGR1i/kp1qpKHUvdpXV0YMay/imygYDIsolA3Fk3+hi5f7Cva10TFAhmqq9/aC7lpflTVVnaEqQUbAN3KvmNxjJJTdjb7xGCVTcNEhUWgov7aLyI1IL91Zx6JM88nfpw541Rhwk7CFb4/YCjne84TUSvXmlWGA1eKdVzBM5SU12QRaSN1HuUl2NfuDc3MYh2WpRyV2Z7glE2RtrqQ=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(186003)(36906005)(316002)(83380400001)(7416002)(2616005)(2906002)(478600001)(86362001)(8676002)(6666004)(7696005)(70206006)(356005)(47076005)(26005)(70586007)(5660300002)(54906003)(336012)(426003)(36756003)(82740400003)(36860700001)(4326008)(8936002)(7636003)(110136005)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 20:31:18.9853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4f9269-0ccb-477b-b99a-08d905cd95f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2721
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra194 and Tegra186 platforms use separate MCE firmware for CPUs which is
in charge of deciding on state transition based on target state, state idle
time, and some other Tegra CPU core cluster states information.

Current PSCI specification don't have function defined for passing runtime
state idle time predicted by governor (based on next events and state target
residency) to ARM trusted firmware.

With the support of adding new PSCI function to allow passing runtime state
idle time from kernel to ARM trusted firmware, Tegra194 platforms can use
generic psci cpuidle driver rather than having Tegra specific cpuidle driver.

During Tegra specific cpuidle driver V1 review, Sudeep Holla from ARM also
suggested to use generic cpuidle driver by generalizing the need of runtime
state idle time.

So had internal discussion between ARM and NVIDIA on adding new PSCI function
to allow passing runtime state idle time from kernel to TF-A through PSCI and
once this implementation is accepted by upstream, ARM will look into further
to update PSCI specification for this new PSCI function.

So sending these patches as RFC as new PSCI function added in this series is
not part of PSCI specification and once this implementation is accepted by ARM
and upstream community, ARM can help to take this forward to add to PSCI
specification.

To keep the backward compatibility we can't update CPU_SUSPEND function to pass
state idle time argument. So added seperate function for passing state idle time
and serializing this with cpu suspend state enter.

Once this approach is agreed, we can either use this way of separate PSCI
function for passing state idle time or with PSCI specification update we can
use same CPU_SUSPEND function with extra argument for state idle time which can
be decided later for final patches based on discussion with ARM.


Sowjanya Komatineni (4):
  firmware/psci: add support for PSCI function SET_STATE_IDLE_TIME
  cpuidle: menu: add idle_time to cpuidle_state
  cpuidle: psci: pass state idle time before state enter callback
  arm64: dts: tegra194: Add CPU idle states

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 19 +++++++++++++++++++
 drivers/cpuidle/cpuidle-psci.c           | 11 +++++++++++
 drivers/cpuidle/governors/menu.c         |  7 ++++++-
 drivers/firmware/psci/psci.c             |  9 +++++++++
 include/linux/cpuidle.h                  |  1 +
 include/linux/psci.h                     |  1 +
 include/uapi/linux/psci.h                |  2 ++
 7 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.7.4

