Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E547368808
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbhDVUbf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 16:31:35 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:27585
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239609AbhDVUbe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Apr 2021 16:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zfz48k+21k5nOD17p/vfAupHmF7lZqdjA5yaI9YpzWWmaPyQcRS7ueAYGmpuQYk5RIa6pi58qbyIuUrQCkg/E+goXW6VvpF6pahFO5TQ1KZGtZ70mFlx2TZka4NQiKu/nCeEHAyGtm7e1LRk+fuORmMqZmmXgbK9pK1c+lVRCAkIgX3ed8oW+PaZbskWEdwUD4Dfh9RSaHQbpTWhmdfX6Egao5gIay5/R/AUCgujwdj7o9CEl2HwzcQBJgCNvbkJPCTefGpoSX/13VQbhrpNGW/w347UALeKT5o/hEVpTRBZT3uF3Wfsa7ScDhu0tqS233VdCzen1x3LGSuFaGOpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtsiOu047O9vFV8NZ8TJJp6dBhvE5MnMYzf49G42uqU=;
 b=JKljzhHcJj529jGzDdp7NQEK1krqsmwC+ra/khddckf/7VxJrn8z/ueF5o27kGjU7CTlsz9Qp+o6e9DB4WwGnx6TvjlnDuPQ5Yqr0ClBPYCoJo2QLMjmJH775k1ovWQflSk2E4NqftQhKlM1rXDiywzb42fYVfTHCfTv4abC8S6kUt0qpto9TN2eAKXrR4FLuspFJY++/YZfPF/pQZMl1pXNIxUcIq+RO5Yx6OLWY/1Iwdroqv2kl/thU0dVTlkYbMMckApExso/p3Ewb46WRxF+ZQhB7w6xEnoOh6bJw4DvHLyjAdxdRCNYVCIhkMrBze/XwNsLZB0KS7dmWEC3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtsiOu047O9vFV8NZ8TJJp6dBhvE5MnMYzf49G42uqU=;
 b=FNPJUpvtgzQLAuqs2Vin3zHUIKrmy9R2+ukbcwEbnuschPRmytjQtU57MrGt0sof8ivdb6AV2YnkMesS/tnzihxF9Cwob4gbzFqUcaHxBMXUon29IlaN2ttJuTM2uWj6DtTJzuPh4kNmskyzvTUMqci+mMnCGS6xYBLZrEUZJLzSp+pg5GbfNxWy17FQKbhqMnNJt9Gs9ggcz4n1lghhIB80UEkYhafwozgID+8nkpDMrmb21uBHvfdXh10M8mnQ2qVhbkCPlMBEd1tcDAL/R9KvTyNuKAVBHgMXJfgTW6snpWnrS7Is5qDgBm08OC+zr5gKla3vyS/CvkXeSQLxkw==
Received: from BN9PR03CA0300.namprd03.prod.outlook.com (2603:10b6:408:f5::35)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 22 Apr
 2021 20:30:57 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::44) by BN9PR03CA0300.outlook.office365.com
 (2603:10b6:408:f5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 20:30:57 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 13:30:56 -0700
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 20:30:56 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <thierry.reding@gmail.com>, <skomatineni@nvidia.com>,
        <mark.rutland@arm.com>, <lorenzo.pieralisi@arm.com>,
        <daniel.lezcano@linaro.org>, <robh+dt@kernel.org>
CC:     <jonathanh@nvidia.com>, <ksitaraman@nvidia.com>,
        <sanjayc@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RFC PATCH 4/4] arm64: dts: tegra194: Add CPU idle states
Date:   Thu, 22 Apr 2021 13:30:48 -0700
Message-ID: <1619123448-10138-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
References: <1619123448-10138-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb6b35f2-6993-41f6-dad8-08d905cd891e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940747FF553CB9EFDC769D7C2469@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgrbMHM+gu96CyeyksYcqt3BlfmZBn6xG0Nd/aG6MSidPBJe5E1zu/1i1Ofu6NrnT3AlcrC/aSM3tQpMAoZBUUU4UIXlL1qSZ2wYkcXNUliEhebixK1mHmQwbZi4/dwu5I8nIMJHXWQwMENwnEsYlLyvF/DlpD24Cu8STMPqlXtuMfy90zs9tCXIv9KH13pQ1rULlmJad9zPhSbXppiUec8zB+mrWrZYoQXJaMsu1C07Pxz4rXny/LKDTgTUzuZ4X6WN54KfHQTZt5l+yjqWZLpYCEwjQbJVn9YPX6iuEy0zxCYXb/W/I4ykqvSZu/Iq06xWfgK2F8tQGYnAoIrT36Ets6z62TVgYbIget7Kip8HWGfTt6qplA/4gTQcI9VqsJOYLcvWAg2CTWMt/SCHpMPUJsVwLsXYJjUEOO3LkkDdh8PTExAb066zks+bDLK41cI99y8Xq+T8WFSExibx8c085WFt0qkdONhHt64X0KNhIKMa5pBQIQ0PdnCaSPQQLwS7wXbm1FJS1sJqDWWhKNu/gf7teEG2LENpIpduxMTpxgtO15NRqyFumlagdzBnrRHuq33uKCNPdBlavLSMmS8rhCB5TJf4w02gfWjl0oa0NZoogPaoPSVTbWu/wbCXFJkb39dxRktgAJIV1nMBl7WdCkpxrFDmR/hljV73GHw=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(83380400001)(478600001)(8676002)(426003)(336012)(70206006)(186003)(7636003)(7416002)(36756003)(6666004)(4326008)(5660300002)(70586007)(356005)(26005)(2906002)(54906003)(86362001)(316002)(47076005)(110136005)(82740400003)(7696005)(36860700001)(2616005)(82310400003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 20:30:57.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6b35f2-6993-41f6-dad8-08d905cd891e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds CPU core and cluster idle states to Tegra194
device tree

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 9449156..c3b478e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2161,6 +2161,7 @@
 			device_type = "cpu";
 			reg = <0x000>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2175,6 +2176,7 @@
 			device_type = "cpu";
 			reg = <0x001>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2189,6 +2191,7 @@
 			device_type = "cpu";
 			reg = <0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2203,6 +2206,7 @@
 			device_type = "cpu";
 			reg = <0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2217,6 +2221,7 @@
 			device_type = "cpu";
 			reg = <0x200>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2231,6 +2236,7 @@
 			device_type = "cpu";
 			reg = <0x201>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2245,6 +2251,7 @@
 			device_type = "cpu";
 			reg = <0x300>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2259,6 +2266,7 @@
 			device_type = "cpu";
 			reg = <0x301>;
 			enable-method = "psci";
+			cpu-idle-states = <&C6>;
 			i-cache-size = <131072>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <512>;
@@ -2343,6 +2351,17 @@
 			cache-line-size = <64>;
 			cache-sets = <4096>;
 		};
+
+		idle-states {
+			entry-method = "arm,psci";
+			C6: c6 {
+				compatible = "arm,idle-state";
+				wakeup-latency-us = <2000>;
+				min-residency-us = <30000>;
+				arm,psci-suspend-param = <0x6>;
+				status = "okay";
+			};
+		};
 	};
 
 	psci {
-- 
2.7.4

