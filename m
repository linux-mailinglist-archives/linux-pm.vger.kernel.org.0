Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77367970E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 12:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjAXLve (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 06:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjAXLve (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 06:51:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325203B674;
        Tue, 24 Jan 2023 03:51:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCXxzrjSg1tPU1xBOf4TGywznTw2HAwdIsDRhdEsjUHyU5gZPiFKAhUpY2S+8Fq4yWPuxXdTrAeMvkQPZtdSw1zjowG9I2Ee9YE3qDTWIaAEBC1bcXYGPZW5SEFsS7qLXAN7UmSrDV04A8ZSahaK+9B1fIBQiCWTlQPAqDEbSa4kSuxTfOqAM3nyackVmuSfIFrPSfTsIPctILszKvSsF0ex5CbobT/MB4dZ2boJcVAMEUNM8JsICGaiCRbh00aLmVypLgy+tP5fPx02lAHUV8BSbf2yPCGpm0+2pZJqLWuP/xK6h4S7FShrARe9Q3iEJLCsQMdQbdS5WrsuOI6Ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOMMLyvkSCyfGEbA1vETQ2B8YjSpHu1130+96wAc270=;
 b=EKi5xIFrzy7X0c1AeUF+teos1sfX0iLV/LCRZF6+5CVWvW3vAnQMe4c5tcpKW+Pe2PiKWcOyx09xAUBbOWYFHRNnbrYoXyB0yRlGrBQThhRr6wxe9r2w1+/1HXdVa4UH1AxMkUNfwe+GEiU51H/LrDWsQgaX2C7OeccTV/l/9+8L+MCSl5R2R0VxayBYU1pPvOL6jj06NpIS/V4o5M9cS/GXOm/LQUZJr3FkN2vEyacGmZfDHvqMOYeN26n42+IVvGLXk3+1m2rHR8YUQlfKA466cbsrQcY6Sgf8TpccKMpZekgOtt3velxanBcuH0zspp0i/2Ja8/7+hlhiXTHNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOMMLyvkSCyfGEbA1vETQ2B8YjSpHu1130+96wAc270=;
 b=Gw6NIEXTqLOi5NzZk5tMXqPnesTMn835ik3sxvl/xlligdurdLXKP8pSwMZc3mTZMDxHA/NGZR/5pY7+nduTYxr4G4nnOA0FlxnB20+vywOhlX9RaLJb94MoSq7C86hnIwt7MvQyiZo0ey0a73schmf0LZzzoBuSWlGw+00/Mo/IgYROPHtTdWEuVQmdCjRMjFr2v9IbxXZ9Qy57EDc2AhSEeWuT8Qnzby7p0FAjk+tQwXxOC4ntJAiQp31A4Ph5l4oNx6RlEXNQ3PkYeoEsE3VJU1VO8dnfFJrDX0BgiCmVUN/5V+uYkZrTyobC+r7rtsjpbKefsE//WJtXAuXi3g==
Received: from DM6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:100::43)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:51:31 +0000
Received: from DS1PEPF0000B076.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::bb) by DM6PR03CA0066.outlook.office365.com
 (2603:10b6:5:100::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 11:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B076.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.13 via Frontend Transport; Tue, 24 Jan 2023 11:51:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 03:51:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 03:51:25 -0800
Received: from moonraker.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 24 Jan 2023 03:51:23 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Yi-Wei Wang <yiweiw@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/2] dt-bindings: thermal: Add Tegra234 BPMP thermal zones
Date:   Tue, 24 Jan 2023 11:51:18 +0000
Message-ID: <20230124115119.21451-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B076:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 428a8c3e-ea51-47df-3cfb-08dafe0154f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okaDB6eUBVpFBVpqjHncHyx+TNL7t36ro1M4Iz9nMHtvQGZ5ZzjG3wyZWDDejvUf2kcoYL5ucIyM4Nr/dZxMrwgkzKsVambK+sz1dpbVF/cmfbN5cTS4RS/3xQgh8KlY+xNsVMOTc0ETDEIYmxU8i9kbhADG9A68DVTkKh6JRARMB6g1jbt5iNWN7GXIz8yk1KiNxN7B56FLFCAK7oqh7CZYotWBvRCnwszdk6c9ZToo9f/UehNvyR5RANbT96SKsEm41+yt18mzpyCXFfUbiu2COuqBPW4nA6vnNl+ih2fbue94oTEoHImMQ/7fTFnbrJI4dTIcY71azSZDWTtmpMFXNp6Tlk3/sqYR2rmMzrEqb3NpE34aHqzLLwHYsLl2dg0u9sYjPI5HuFHVyYoXwJ7WIZ6lFupH6Kcb+Sow5pLHuOxWMLub134kiHKfgeLGCe7+/qrzb8lfXPRGnJ7ySgV32qN273rNhJtc98VmdSLJg+483wdiuOmYbxcsf16ycS9mzEanzbKVnlk5XaOdPQjlil69Ln5BXZyuK/4zeWM1Hpuro+H7fU31FezjQkd/mJnCcvCZCw6Sby8ZNL7aZl+vd6SspmV7r1m7xJi2P1doHRET64Vhi43xpQHEa760AykZJ2dwsStUk1N721JJu4NSUWTCNwGzqPUV+GlXqKEJm2n5nB81sSLmDShBH3JElXRCcdsyMJPq63xzj1a76w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(2616005)(336012)(1076003)(7636003)(2906002)(82740400003)(41300700001)(426003)(82310400005)(5660300002)(47076005)(40460700003)(8936002)(316002)(4326008)(36756003)(110136005)(70206006)(54906003)(186003)(26005)(8676002)(36860700001)(86362001)(70586007)(7696005)(356005)(478600001)(107886003)(40480700001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 11:51:29.8498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428a8c3e-ea51-47df-3cfb-08dafe0154f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B076.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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

Add BPMP thermal zone definitions for Tegra234.

Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../thermal/tegra234-bpmp-thermal.h           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/thermal/tegra234-bpmp-thermal.h

diff --git a/include/dt-bindings/thermal/tegra234-bpmp-thermal.h b/include/dt-bindings/thermal/tegra234-bpmp-thermal.h
new file mode 100644
index 000000000000..41a5efebcc7a
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra234-bpmp-thermal.h
@@ -0,0 +1,19 @@
+/*
+ * This header provides constants for binding nvidia,tegra234-bpmp-thermal.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA234_BPMP_THERMAL_H
+#define _DT_BINDINGS_THERMAL_TEGRA234_BPMP_THERMAL_H
+
+#define TEGRA234_THERMAL_ZONE_CPU	0
+#define TEGRA234_THERMAL_ZONE_GPU	1
+#define TEGRA234_THERMAL_ZONE_CV0	2
+#define TEGRA234_THERMAL_ZONE_CV1	3
+#define TEGRA234_THERMAL_ZONE_CV2	4
+#define TEGRA234_THERMAL_ZONE_SOC0	5
+#define TEGRA234_THERMAL_ZONE_SOC1	6
+#define TEGRA234_THERMAL_ZONE_SOC2	7
+#define TEGRA234_THERMAL_ZONE_TJ_MAX	8
+#define TEGRA234_THERMAL_ZONE_COUNT	9
+
+#endif
-- 
2.25.1

