Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26FB679710
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjAXLvk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 06:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjAXLvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 06:51:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709043465;
        Tue, 24 Jan 2023 03:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtY9j+wNbKn6/ZxqWXgbMAX4Ifr9pZzjZaLktGzSenK/hgFlGTXa7n8RBXA7Yp0qJkmjBsCi9sCL2h4O1qbMR1nOVifpvQmTVXxVcPVIj3QpFWbkKxaK+9I2k+nA2pza6Yzv5JFb/SfwygjX8LFqpxYd0So22+ItGLuOGNi1p7scif7ZQiG94mJlCNMh73YRKSpbTmYg29iHi3cFc7IJA2jEXSKDPR/kOsBqm+O500mfqBBD/SBhvTlQUa+L9k/PdxPMQWfuSqrZYBopXa0Sw/QERYuAfplz1507SKWz+skczzFOxuRlAka2/w8krX9LqCkxnQoqIiO6kGg49kOBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/2yhU3pVNwSVzIxM8i6DmdCBTLSO/+9Bo8WYwG4CpI=;
 b=iypYdFPiomaSfhyqVFruWPza3v/OxANu3X3Nkw8CFrX5o+/MjovD14Cm6OVOS5BZuKQwryRi5ql6tahxiZKJ5D0QhjLz/UyNm6aUayGWYgm9edx6JwG3qPefMoO1zbycGUteXVR4qLJbtNUgbJ620fugqUKzgu6jnbXBc6qmvgozKk1/YY8KGI38K8txDQAEOY6AoZF6I+BGYHFkjfFI29ZeXWczZcdjt2ZodysgNWWBoC5+pTaqIpz+sCscxSkEUQle+t7j7GN4qiTvAisQ2gOo5lW36QVwYwwl/bG7T65l1jVVPOjV0Ilt3EFDUVH60bl80dQqWcylgXvpCZ1bCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/2yhU3pVNwSVzIxM8i6DmdCBTLSO/+9Bo8WYwG4CpI=;
 b=kCiiEEJ7sPZFANEAKdfwhyAqvpRB3ZRlDuPlXs711a0wX/g8Vb50b8v2TH7LX8Ve1oK8scE6xrFFPntf9Ub81iC7fwx/jlxUyvjVW1VeVbB55Wo8DPyQ436LelaMjGMdFGSXorqLmPFDhPy7MYGLiFA6GCc0op+N4meT4hB04tnS7sc7ZggULksx539MHZlTuMGm6O51MfjbkkWED83w8PEk+wSpXYfDnKuiS4ejhpDV0mM2gQtQewv4tGHoA4fY0qbetr1nDaz1HAJv7sZfGSr5/NaH4SFXCOnMUS3bq8yZjpuyEssVIv4WDCxxpPL9D1wHX6GPMpTOoaGRBffCWw==
Received: from DM6PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:100::22)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:51:35 +0000
Received: from DS1PEPF0000B076.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::f3) by DM6PR03CA0045.outlook.office365.com
 (2603:10b6:5:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 11:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B076.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.13 via Frontend Transport; Tue, 24 Jan 2023 11:51:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 03:51:27 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 03:51:27 -0800
Received: from moonraker.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 24 Jan 2023 03:51:25 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Yi-Wei Wang <yiweiw@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 2/2] arm64: tegra: Add thermal support for Tegra234
Date:   Tue, 24 Jan 2023 11:51:19 +0000
Message-ID: <20230124115119.21451-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124115119.21451-1-jonathanh@nvidia.com>
References: <20230124115119.21451-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B076:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fff281-60f9-4760-87b7-08dafe01586d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7aA0PzvQ0MHV1+NkrIuqf2uNvGBpMoqFXaJjFG1pjs9I/KvRIEVKwAn4sHk6cupCwKl0bMNp8n3f7mcbrOGCeG0Ho7NB/aaiYmiz5RKflcCml/av1EgXebOw49gAxBWYUHwd6rSpj3HMCal5hjBUlGl+2AEi9ASXW27qmR5a4vYIT8LFgN7wB15VReWnWGETm/PNa6H0OSSYR2QSLPs/Y4hnA5IOHb0nvQH0YUVfBjz+E6ZmPPCNiPbT6FUSDgf/EdK4Vec+iCLWJk0o865js67rI1TSiotDKL6LSaizwBtUIKUhl8RWP0unuXhHK+8pn/og/lHm57+QtU02ySEEHIDdhZmvKiankXAUX+2q64+zZY3jemEIPqhZ0wTECpdN6JFtYpg3ZlKZKOPb71ukjyFz+Wn5iAluvERpSoghs/nFV2ZjXri0H7olTtnW8RJQJQovfcXW0XJltR21QKkWbNDD8bJ+gg8xQP2JGNht5ApimAIrb4T4tdU2LmP/WBn+AtDauWDsqtgtCCy4/ooRrdiHuEh5wXgKPCE7EYM+/EL7XM9hATar79BGHGe87XqEjHXtNviXAhyXznovpMAZbWHxa/9QUHnXEi/R6K/EOk95XQK1J0x/GVXGY2KYyvWILtRmU+He6qPlxZolK+MZ1AJMDQ4VUP0PLVM6reybyHH7T8F72bzywwZ69v2XVulHnIQCthKiphudPUnis9d+g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(7636003)(356005)(2906002)(82740400003)(8936002)(4326008)(30864003)(82310400005)(5660300002)(41300700001)(83380400001)(36860700001)(86362001)(26005)(478600001)(110136005)(7696005)(54906003)(186003)(40480700001)(40460700003)(70206006)(8676002)(2616005)(316002)(70586007)(426003)(107886003)(1076003)(47076005)(336012)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 11:51:35.6779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fff281-60f9-4760-87b7-08dafe01586d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B076.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yi-Wei Wang <yiweiw@nvidia.com>

Add the BPMP thermal device node and thermal-zones for Tegra234 and
enable thermal support for the Tegra234 Jetson AGX Orin board.

Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 276 ++++++++++++++++++
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |  32 ++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  59 ++++
 3 files changed, 367 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
index 2378da324273..7f798742df43 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
@@ -80,6 +80,22 @@ pmc@c360000 {
 		};
 	};
 
+	bpmp {
+		i2c {
+			tegra_tmp451: thermal-sensor@4c {
+				compatible = "ti,tmp451";
+				reg = <0x4c>;
+				vcc-supply = <&vdd_1v8_ao>;
+				#thermal-sensor-cells = <1>;
+				status = "okay";
+			};
+		};
+
+		thermal {
+			status = "okay";
+		};
+	};
+
 	vdd_5v0_sys: regulator-vdd-5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "VIN_SYS_5V0";
@@ -139,4 +155,264 @@ vdd_12v_pcie: regulator-vdd-12v-pcie {
 		gpio = <&gpio TEGRA234_MAIN_GPIO(A, 1) GPIO_ACTIVE_LOW>;
 		regulator-boot-on;
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CPU>;
+			status = "okay";
+
+			trips {
+				cpu_sw_shutdown: cpu-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				cpu_sw_throttle: cpu-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_GPU>;
+			status = "okay";
+			status = "disabled";
+
+			trips {
+				gpu_sw_shutdown: gpu-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				gpu_sw_throttle: gpu-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cv0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CV0>;
+			status = "okay";
+
+			trips {
+				cv0_sw_shutdown: cv0-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				cv0_sw_throttle: cv0-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cv0_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+
+		cv1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CV1>;
+			status = "okay";
+			status = "disabled";
+
+			trips {
+				cv1_sw_shutdown: cv1-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				cv1_sw_throttle: cv1-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cv1_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cv2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CV2>;
+			status = "okay";
+
+			trips {
+				cv2_sw_shutdown: cv2-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				cv2_sw_throttle: cv2-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cv2_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		soc0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_SOC0>;
+			status = "okay";
+
+			trips {
+				soc0_sw_shutdown: soc0-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				soc0_sw_throttle: soc0-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&soc0_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		soc1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_SOC1>;
+			status = "okay";
+
+			trips {
+				soc1_sw_shutdown: soc1-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				soc1_sw_throttle: soc1-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&soc1_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		soc2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_SOC2>;
+			status = "okay";
+
+			trips {
+				soc2_sw_shutdown: soc2-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				soc2_sw_throttle: soc2-sw-throttle {
+					temperature = <99000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&soc2_sw_throttle>;
+					cooling-device = <&cpu0_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		tj-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_TJ_MAX>;
+			status = "okay";
+
+			trips {
+				tj_sw_shutdown: tj-sw-shutdown {
+					temperature = <104500>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index bfd935a86d19..b9c03a87fa5c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2377,4 +2377,36 @@ sound {
 
 		label = "NVIDIA Jetson AGX Orin APE";
 	};
+
+	thermal-zones {
+		tboard-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&tegra_tmp451 0>;
+			status = "okay";
+
+			trips {
+				tboard_sw_shutdown: tboard-sw-shutdown {
+					temperature = <107000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		tdiode-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&tegra_tmp451 1>;
+			status = "okay";
+
+			trips {
+				tdiode_sw_shutdown: tdiode-sw-shutdown {
+					temperature = <107000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 7b7a57c90e3d..b92427e397af 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -8,6 +8,8 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 #include <dt-bindings/power/tegra234-powergate.h>
 #include <dt-bindings/reset/tegra234-reset.h>
+#include <dt-bindings/thermal/tegra234-bpmp-thermal.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "nvidia,tegra234";
@@ -3135,6 +3137,12 @@ bpmp_i2c: i2c {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		thermal {
+			compatible = "nvidia,tegra186-bpmp-thermal";
+			#thermal-sensor-cells = <1>;
+			status = "disabled";
+		};
 	};
 
 	cpus {
@@ -3155,6 +3163,7 @@ cpu0_0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2c0_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu0_1: cpu@100 {
@@ -3219,6 +3228,7 @@ cpu1_0: cpu@10000 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2c1_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1_1: cpu@10100 {
@@ -3283,6 +3293,7 @@ cpu2_0: cpu@20000 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2c2_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2_1: cpu@20100 {
@@ -3580,4 +3591,52 @@ timer {
 		interrupt-parent = <&gic>;
 		always-on;
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CPU>;
+			status = "disabled";
+		};
+
+		gpu-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_GPU>;
+			status = "disabled";
+		};
+
+		cv0-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CV0>;
+			status = "disabled";
+		};
+
+
+		cv1-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CV1>;
+			status = "disabled";
+		};
+
+		cv2-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_CV2>;
+			status = "disabled";
+		};
+
+		soc0-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_SOC0>;
+			status = "disabled";
+		};
+
+		soc1-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_SOC1>;
+			status = "disabled";
+		};
+
+		soc2-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_SOC2>;
+			status = "disabled";
+		};
+
+		tj-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA234_THERMAL_ZONE_TJ_MAX>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.25.1

