Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516C33687FD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhDVUbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 16:31:32 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:25628
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236851AbhDVUbb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 16:31:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS6aL6MzKteFSEetQiSEg+Oyr2zf1zmg0TURbVSiELh3T88ES2MJNp9BMo8HczVGPpd/0teSxrofRc7t4LIoR0ENvekriLmel+ub2DWjMye9tQIM5hAowtX+Z3EmGOvaV4ZtDxnPr2T8wEOM40Eur6+ZGPlNLHZnIAQhuA3ievWXMQaRE9sWWa3eeQ0W+JVkUIkdzL0kH2DJX3HjCaVRFOrJ6pIowOct2ytTS7JdNn5hRw+H+tyW85kmh1UQzVXF/EsIdLXOKmGBozjeoQWgG0XD+F+AuWXA0FUQ0KsVzU2jrLMcGQjalbZCYaDwQCoDmB5h7yXV1zft+RfM30ycyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPmanD2IU3+/ZPPGbnGFNPMOj7lmG+Oykm92/MPi4nE=;
 b=nZFPZXhoJEoPQhKAFEJeiJtN9+0HDcNyQCheNVhfMUjrkvWwuKTaN4O4mJiShQoBB7KYy7yhGgoWtxXF1D9CAkdBU6pmbMN1Zh1MSggcbUkgWaYkY5bt+3kXn7ZBd5XVlBemX7/B9ntysYbf+wgiKRt+CsJllkhkDTJJ9EDG2hHO/r2mDXuNTKapO6SFuHMNsj9NdTeooOrFw+rU1tEwD2IkRz0UE25Q3HXm7KbXgw/3QfkbRJbxvELhC/Z6LkrmQFWrFxl2jUdNUsxn7ZtAWLDCXM4s18MUcBCS1o3iGlvK8nRE8m1hOIxNKayXRTJ+wFcjJVDLlrQv2rlV4iypoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPmanD2IU3+/ZPPGbnGFNPMOj7lmG+Oykm92/MPi4nE=;
 b=m4m/UbIdzBBDjJCPt1ogewCIWf5OKP2BWy3RyoR5LwvgFu7AJ9m9AHOwIVJosz/udkyK49UA99rqcCqx+tLZKPpuwPPRdi+yGtjS7JEwaVoVKxd4mGb2pfsvjdN1lCB6FAqaXcYw+6Eqyn3mKuyJvaNLlwiBVi3ZAGkJnIEd2TalOyhwbHLgE6S0UME+JN9W1QVYPFiyJ879YfKKr++qnkO8PsDp5NK489uwDOmheoFZBwFVp79jERgW3P6iLoR/hCqTq/b+EP+2nWrcxmLAxyXhZRsEzPMjcpG1HV7xjASIiCyHpz8MUloXFioQ3tXkkNYfOB832tz7AugRcbqLXA==
Received: from MWHPR17CA0079.namprd17.prod.outlook.com (2603:10b6:300:c2::17)
 by DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 20:30:54 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::da) by MWHPR17CA0079.outlook.office365.com
 (2603:10b6:300:c2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 20:30:54 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 20:30:54 +0000
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
Subject: [RFC PATCH 1/4] firmware/psci: add support for PSCI function SET_STATE_IDLE_TIME
Date:   Thu, 22 Apr 2021 13:30:45 -0700
Message-ID: <1619123448-10138-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cfe9a73-b5f1-4378-481b-08d905cd8767
X-MS-TrafficTypeDiagnostic: DM5PR12MB2406:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24069935E9EAE196337D5FBEC2469@DM5PR12MB2406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73nIoR1sadg21M9yHzQ7tpaG3B/beY/yYsGRODVx6r313qc+A3s/rJgRYWtRvVVKfvCgCQ81vE4l9Fiatlu8jBH56fw5N2Md28RhxTgMuKjXZu54+7FSaiaj7Ej0W1RZQkAYiEdpiAHHxDMJGNOVZTlF59hoIG08ZxtqzDPIx6LFkX7iUfPKPiW97hsCwXOAkzvoyl5uKWHNft+YXlMap01ymsTGOBVtGH+BBjihV73vsmU4UY+Cmmw142vAGztI+1vC0mMN15rB4Q5Kp2Llh6UwbMSIMCpguTujSmSi8TcJqmPqSk2J1DBiGsU1N1ouTp21Q0D1id5Du0lAYEG+/RANsFcuGaTwJX+lhmj04wSgnoO+9XOB/V9pmy1R7mBM1SJhLcorxnKcFT7jMC7aJR/O+xVR/PdkAF/STJu3tPVpqyWjVFz7XuFt9szScc1/tADjeErOZDg7M9gDZtkywVJbNPwD+uk6n68YUlV5E3kmqmqo5EpoZQcliVl9VRtCn5Czt4GT1iWtE9Yuw/0Buy67pxbn6kMYFX4sqwXI1ed84YDZC5kRUFfQtvsG8be1FTkeDPYgQTl0XA0e8S6z+iXbi9K2daymbxECWCE13kSv1e+wnVxcFFgpNukJmQ1Wa9JB0ic+9e030+JWHmRu50X4V80y92AcQcwUgvfhzcg=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(82310400003)(83380400001)(6666004)(36860700001)(7636003)(8936002)(478600001)(36906005)(70206006)(110136005)(8676002)(356005)(82740400003)(4326008)(70586007)(2616005)(36756003)(54906003)(7416002)(186003)(426003)(2906002)(5660300002)(26005)(316002)(47076005)(86362001)(7696005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 20:30:54.6723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfe9a73-b5f1-4378-481b-08d905cd8767
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2406
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds support for new PSCI function ID SET_STATE_IDLE_TIME.

Some platforms use separate CPU firmware to handle all state transition
based on state enter request from kernel and may need runtime state
idle time of the corresponding state from kernel to pass to TF-A through
PSCI.

Current PSCI specification has no way of passing runtime state information
from kernel to TF-A.

So, this patch adds implementation for new PSCI function ID for this
purpose.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/firmware/psci/psci.c | 9 +++++++++
 include/linux/psci.h         | 1 +
 include/uapi/linux/psci.h    | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5bd0dc..3bd63d7 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -180,6 +180,14 @@ static int psci_0_1_cpu_suspend(u32 state, unsigned long entry_point)
 				  state, entry_point);
 }
 
+static int psci_set_state_idle_time(u32 idle_time)
+{
+	int err;
+
+	err = invoke_psci_fn(PSCI_1_1_FN_SET_STATE_IDLE_TIME, idle_time, 0, 0);
+	return psci_to_linux_errno(err);
+}
+
 static int psci_0_2_cpu_suspend(u32 state, unsigned long entry_point)
 {
 	return __psci_cpu_suspend(PSCI_FN_NATIVE(0_2, CPU_SUSPEND),
@@ -470,6 +478,7 @@ static void __init psci_0_2_set_functions(void)
 		.migrate = psci_0_2_migrate,
 		.affinity_info = psci_affinity_info,
 		.migrate_info_type = psci_migrate_info_type,
+		.set_state_idle_time = psci_set_state_idle_time,
 	};
 
 	arm_pm_restart = psci_sys_reset;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4ca0060..6643bfd 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -30,6 +30,7 @@ struct psci_operations {
 	int (*affinity_info)(unsigned long target_affinity,
 			unsigned long lowest_affinity_level);
 	int (*migrate_info_type)(void);
+	int (*set_state_idle_time)(u32 idle_time);
 };
 
 extern struct psci_operations psci_ops;
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 2fcad1d..0013db74 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -55,6 +55,8 @@
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 #define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
 
+#define PSCI_1_1_FN_SET_STATE_IDLE_TIME		PSCI_0_2_FN(25)
+
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
 #define PSCI_0_2_POWER_STATE_ID_SHIFT		0
-- 
2.7.4

