Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1777368804
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhDVUbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 16:31:34 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:27617
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239587AbhDVUbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 16:31:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/zYGp6RX8RGCGzDPwebJeUx7tH5EtKhXP+O+1/Dd553IC89N+mJovkqYpJuc6FRJmk6L9mHAFLre5ylk4kD6evzkEbDySyEfswfzICHfLJM2L2Y04zNeYf7cZDJo+0CkAzGddY8qNo781FFUH/ktrwD+GeDqgnBDx4R7pBAPXZaEYkKylAxRGbCOS5JAOtLB9FtW1hB4CcdzXY7tz/w2x7Dg6EodGMwHjiyflpGT8SNAxzlsFiAoGOmto+95kDr6spnPTGDiIvAmlE9IHot1ChXbCGjlNQFNlqfTY0eaQAG5Z+cl/wSRTKTziOohOZZ23McnG7Hy/gyJRhgbjwAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=865GoqnmwjzddJxjksRbmVcCiIohdzLb3zHx8OnYwtk=;
 b=GbRYnsKI5/iBaWceeS9ymeLdTFff8jXxswL+cw4CBk8T4u5GZs/gv/DjZoD5MokP5LrllnGdQ7bxAaszzyZ5Mfzk/8PrFoeEQxJ23BBArjVpQVg7TmLxg0HnYBZAZIAO8eUyzjrKt8tC7LSoxU9v+Oh4/XhMir8Vnje79jziOhUkUTFTsubzIGayo6nQ5evqyyEHcehRdX2ZwMnzpBWOAFWP5Un+FT3nL/CDALkO9/lpouK5vBSqKhdC/kaSCnDlKupPBG7+VqL2P66cwfh9YYVsG1GYFa2GC9FoeppgsIWuDXt4gaXpZ8RXdGqcQ1F9zhvWMCIVX71LXBfboRcaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=865GoqnmwjzddJxjksRbmVcCiIohdzLb3zHx8OnYwtk=;
 b=HcsvxDUkmFEjggUL7O2fqmQIDcEHfebCqxxMGatFK0yZIICngpH5X+vzC2Z0yF2RLD0RuF7BGo2KSKCnGGF1DaDrqas3+0k8n1pgRzQNd2YaT3nFrrsxuMohdkm2ad5mdNV8blrMD2jrXfDoxKrX6PPAbh0jD1MfV+W+tYuYbKjDQDXtyG/n9MnnA4g+blw1Ov/UGFbnrBIjpH9NAkOqk47DbK3fVkpfJgcZQ/yf5k86DyykT7q8gQ2dFI4JOa+S3S2P+geto4wZZ73v1d3xfl1X7AHPNhI+wLQ5OAFB8F9sbH+FFScJh36Vov5DfdltijmQao/WnNUSWbuoQd9sag==
Received: from MWHPR01CA0034.prod.exchangelabs.com (2603:10b6:300:101::20) by
 CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Thu, 22 Apr 2021 20:30:56 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::4c) by MWHPR01CA0034.outlook.office365.com
 (2603:10b6:300:101::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 20:30:56 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 20:30:55 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:55 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <thierry.reding@gmail.com>, <skomatineni@nvidia.com>,
        <mark.rutland@arm.com>, <lorenzo.pieralisi@arm.com>,
        <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>
CC:     <jonathanh@nvidia.com>, <ksitaraman@nvidia.com>,
        <sanjayc@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC PATCH 3/4] cpuidle: psci: pass state idle time before state enter callback
Date:   Thu, 22 Apr 2021 13:30:47 -0700
Message-ID: <1619123448-10138-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca233226-44e0-4ab5-c21b-08d905cd8897
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5393379C1B370746B1D99A21C2469@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cv+SNcGnD5iRJ6Er3xxUA6p/e0ddqOFKzwCjcUnMye0AyfGgEyEKqxmpYkHh2ym8gpETSBKWMsskVGDEj2LxB8OXBpcdJj2Q9kT0z7VaW5viUG2y8BirQZHHNQeWZs+IKd1He9sMRqSTI0Cr/J3aTFSce/ufdnrRSaa/lvGCmJ1K7PKxwhR+kUonMDTgUuz+MsSYvbpS1Mjmj3f6zpvKFv1wqqyEEHdu563Hs/ZaCP/etOEBBOzXL/PuUgFV004iTpBg+rhTTMJRpwC+gXkUqV0QCTG0CIN3jwaEgUXUGgESY1Ei6HbLOeQhzWbRgW979XQfOFMAFLGzPVAkQa4/jzz37uxR/PkJHXOJeHb312cCZrWACc7uB+NjJ5nfhj6RKdq+rO3oC2L4fqw7VZ3mz3ElWZO9LpRl+7nffYWQd6eu172OMVp1U66KgtSYwsB3dDzc76BL3AldYXYCSVdPK2WDFNCnpBm4zCcHpnY32aQW3OYMWidFs53px/dCvMMtXhe5zft7TgDlKybHVweJ06Yu4EDcmD9BkgpWWU10j8grWZDgLutluZ37iQvwdW0JUm0PsQcrkYf0SmYCmA5woBuWqfMIn+E0SOVCfVCMbQzxT10VWuZEDQ4dkw5lrxRpG9CgO28QLFQ8FFXhjChhFBR2vorCx3HsGrOLDrR/ObY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(8676002)(8936002)(54906003)(7696005)(2906002)(47076005)(36756003)(7416002)(110136005)(4326008)(316002)(70206006)(186003)(478600001)(26005)(426003)(2616005)(336012)(86362001)(5660300002)(7636003)(70586007)(36906005)(82740400003)(6666004)(36860700001)(356005)(83380400001)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 20:30:56.6498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca233226-44e0-4ab5-c21b-08d905cd8897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some platforms use separate CPU firmware to handle all state transition
decisions and may need runtime state idle time of the target state it is
going to enter.

This patch calls set_state_idle_time psci operation callback to pass the
state idle time to TF-A through PSCI before calling psci_enter_state.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/cpuidle/cpuidle-psci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index b51b5df..22a5003 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -151,6 +151,17 @@ static int psci_enter_idle_state(struct cpuidle_device *dev,
 {
 	u32 *state = __this_cpu_read(psci_cpuidle_data.psci_states);
 
+	/*
+	 * Some platforms use separate CPU firmware running in background to
+	 * handle state transition which may need runtime idle time of the
+	 * corresponding state from kernel.
+	 * So, pass the state idle time from kernel to TF-A firmware through
+	 * PSCI. Platform specific TF-A firmware may update this to CPU
+	 * firmware.
+	 */
+	if (idx)
+		psci_ops.set_state_idle_time(drv->states[idx].idle_time);
+
 	return psci_enter_state(idx, state[idx]);
 }
 
-- 
2.7.4

