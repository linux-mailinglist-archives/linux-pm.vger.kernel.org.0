Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B73476C383
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 05:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHBD1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 23:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHBD1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 23:27:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08E1990
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 20:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZRw+V55jweBlUwa6vqKZrp+IcvOEY0HGfgkwOVROuY/BeXkMCbP98d15CuatXd5SlyXJuRg2OrNFqy9/mT+YmKD6eT5mzg8MniRFESdMXJEQG9OVGhxOh6lmO8xlRYMBhw7AnwPfva6vJAUThOT5nHlrUUU+uFoE9+I76LoFOhRPGPULkNDurc1t6udjjyUBd0GT6LLvUgG0AxiufUwfQLmHAENbE/3GNTsbI1+I17yWzCKYmvHZ41D3iBLiNWU3JUG6BZul+A4ovA4yfYt51N7Dr6dE/7RMMZCFFr6vddS0OFEMOziMpHz76TOMJNWxDYI1S9PAB/vyQS+XFyZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkEHW3v5+R1s2/bfUAr6/yLWUEU72Ino6/E7xbTibHM=;
 b=PCR4ng5L4OlNMr9p4I/KHiM2laFp66BrpuRvdWHYUmGqNf9BCOi3LfCkWb5gWgylSKRKGPKWDBCUNAbHeSZYI88r5CaF+3sHvYeKkVo8r9ml8q23FENHSDPbO7FLuLOkStfNqe1Iw/g9HMV0p7t31JZTxp0g0j6YJYyEnDijmhAhE5HiIZRCw/OxqDHx8ITMIzGTFhDtva1y8KOteawxeHlsl+UnoIETomZcfJOX575xzfAQHP0sCKDlQPZ6wtQJdV5JJsjBgHdITD7a9ms6/yjp6JyfUXe57bDmUxkHE8u0uaN4KtLNMxQV4ysqLv+BEtyqa1yxmNC5NIHVnG2j5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkEHW3v5+R1s2/bfUAr6/yLWUEU72Ino6/E7xbTibHM=;
 b=KH3Mk5JY85OirppToJizrE1HVPlPD09Iv43EshFEWo+WSXrGzl2osCJDqAN02oyPzBjYpjT/s7snGVvi+Z4KknLrs4bQ4M3CTqLYHkaYmMvVphC2JksJAIxEY292Gwv4eAMNx9clLcsH7ODO5nwEn5Z8nNaI4aPMx+qm4VcQoyxVlXxZBNKosjqOrV8y9JlLSBOOH9pIeXwJWfWGAdtEjdDR/N/exsRg6R7kKWXHOSmLqIWHU/NXM9BifYt93J2YtrbZTd9vaIpcmcCvyDD2KtvZKW4MHO55YI9FSmU3cA0P2v3f3sQTEPigvjWCNFOh54bS+O1xQLZoi1Vt1z1fBQ==
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 03:27:29 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::ff) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Wed, 2 Aug 2023 03:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 03:27:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 20:27:12 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 1 Aug 2023
 20:27:11 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-nvme@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] nvme-core: init power qoe ops early
Date:   Tue, 1 Aug 2023 20:26:29 -0700
Message-ID: <20230802032629.24309-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230802032629.24309-1-kch@nvidia.com>
References: <20230802032629.24309-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d834b8-6091-48d4-568b-08db93086652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtE0QDu+d6d9Zj5GptPCArnYqxEkPAgu3YY3HoaG2jvsgkdCznEll+L0uz4hQBp8LY5H1AB/obvcGpSnMjN8kU5Dqo71pVrJ0hwV0zpbB7Kcc225ZtP9AszFENkZ2hsts7QEeYHz7cP+nnjPBWSbSH775y/CfIqixi+WUxplojFh0Vp/3XCbdVymq8rJDgTi7kqofJNXZ2EdqqPe4RlgimI6hCTPZnDQn3tVsK8+GYMu7xRMD71+080BQr6fR4Riu+CxDGEsCFb+4ggGCeBaQFAB0X2iBZwDTlg6jHJQtqE+QwDyCOGM2vmUrWDpcyg3DR+vjetuUitYyDuxfqXk+xXAHuhUlrbUptSw5yxunLBNOzBQ19uaoVRtYPQEhDY9QNmX1ERiCqczpmVM/QrPRBBpm7eVWRYiv55NUqMOQ8w59uvdh1HiIk7iq/hPDvXDhiptWKS+RuwW1J4kTQTe0KoEMv69g0wNrRVB9haYJIuRttIovMj9qpgK4kCVuZreLS66d1+WTdj3awFfQsUvoJH7UNcmoRHFI2yEjlnP7wzJV/s8vUGGjiteJVE8P7tn/SNOuOl2GuSapEmChQDllW3fko/udfT+Wsf4G3w5OHM63LbLNJ/nO1jSJDQdx41uEe9VLRXHIP8nN7d5kBLr+/suSanOn3OpmqPWJOXfGMo8Zq6m+nhy1i1V8laAQ3Rm6sy2CkhVlq95H1OH4oigwVoDzqhaRyoLJLzKJr/cAw3ghqEWKy15hL0f8q2XU/qC92xEcgdXbSyaApxeOk6R3w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(1076003)(7636003)(356005)(26005)(186003)(82740400003)(16526019)(107886003)(426003)(336012)(2616005)(2906002)(36860700001)(47076005)(83380400001)(36756003)(8676002)(110136005)(8936002)(40460700003)(478600001)(54906003)(6666004)(41300700001)(7696005)(316002)(40480700001)(5660300002)(70206006)(70586007)(4326008)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 03:27:28.7188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d834b8-6091-48d4-568b-08db93086652
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to avoid any initialization after cdev_device_add() move
dev pm qos latency tolerance before cdev_device_add().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 555ec4af5b80..cd27df7a5751 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4465,6 +4465,14 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
+	/*
+	 * Initialize latency tolerance controls.  The sysfs files won't
+	 * be visible to userspace unless the device actually supports APST.
+	 */
+	ctrl->device->power.set_latency_tolerance = nvme_set_latency_tolerance;
+	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
+		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
+
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
 	nvme_get_ctrl(ctrl);
@@ -4474,14 +4482,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_free_name;
 
-	/*
-	 * Initialize latency tolerance controls.  The sysfs files won't
-	 * be visible to userspace unless the device actually supports APST.
-	 */
-	ctrl->device->power.set_latency_tolerance = nvme_set_latency_tolerance;
-	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
-		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
-
 	return 0;
 
 out_free_name:
-- 
2.40.0

