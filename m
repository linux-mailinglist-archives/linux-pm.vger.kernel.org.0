Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763AC76C382
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 05:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjHBD1S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 23:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHBD1P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 23:27:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA431705
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 20:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWrHp60Qf9FiJAFkpcktOnSGUNamkh6o5PeN0/qEwA8OMm5rZ63nu9fCY9O6G8+ywueGVA0vqAgWmWDfcGugispaaKiXHE4HpoCfCY7A0rA9+BadjiIDJbITP+1WVD2aQf2Yzkf7bNXQ/n53WRoQD3ox+1juXGycdU1WhxhVwjarMBaSscHwRnfcPLKiN4e2CgfLy70rhc9UJl2UtrKU4nQEAWeT9BLdS78G8UQ5aZCImWKGd7LmMSuN4wqdTiJ9yNuwr9wnXpNwYjUoZVKELfs3urWxw2OxXryOBsqx2/sMSvRNtRRzCtf4R5UbZvcfpHMRlQv/FGF4w4M6Il7nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSfkO2KCMN6IV1AwLlYtHdNWGwi226lxQ3+y7plGrBs=;
 b=OLm5CqHCcs/rjerl+mRdWKrMF4Btnr4ONxusRKA2ssH7QU4ozSmGc7WxuQvU/sqMia02uh1stFlmBbzRRk9/UszWz1K8/ydXRincUdMmEZOF/v9Qu1QVvX/lR52g4RsY4OLZ1G/CX07rRZ7pwhXYGjsEqnN79E587b6UcCoP5vCO8MOSBNL6F+Jse1g33gap7zTTQa288JRVVylpPGufoVhrqeuFraPoTOg2oE8RrotUNJWR39+FUiKezGRDHIwX/7MEqcgY8CF2nSTZUyf6KQNnerjgayEZK3Zlb7hypIHODhGoJYdi//ar0KiaW2aOtOz/cRYLmhuM4xThf5Ck0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSfkO2KCMN6IV1AwLlYtHdNWGwi226lxQ3+y7plGrBs=;
 b=oPEgA2E5nPdWyWGs4lqah11PcG60BaWITy55VbTS8yCdn5r4HOepKOBVTh2U7MusLiXJY6shNrwVVzykxaJWYDlzEe8gSs55LTPMhnJtqmcUz6FcF9qrP9glw5TiAMscu7enucwvAShoaPxTVbXVL0w+ToncHyNfs/httrg2tY6bSjGNqDRC3SldCxq2fXFwlImLAgQRixzSnnMgc7qsfQBmbF7uOrO6A5jCDtFqqYfv8lp7zD1kNm4iRskR1s8uROG/6Ep+lKCjq++DnqU7ceQzyNGTgpcSZgC6THxrbkV2F0HaAud1K85C9fvndSbRWKUFaa9WH8PWmAl/k82t/A==
Received: from MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::7) by
 PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 03:27:11 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::b8) by MW4P221CA0002.outlook.office365.com
 (2603:10b6:303:8b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 03:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Wed, 2 Aug 2023 03:27:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 20:27:01 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 1 Aug 2023
 20:27:00 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-nvme@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme-core: init fault injection & mpath ctrl early
Date:   Tue, 1 Aug 2023 20:26:28 -0700
Message-ID: <20230802032629.24309-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230802032629.24309-1-kch@nvidia.com>
References: <20230802032629.24309-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ffba84-497e-4828-4906-08db93085b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KADcGE7ndm9uh9cFZAGGghvkTN6sDDTX/V0GZmFJhhytHV8NVLXGvARJQH4CvLlq1KdZlKviy3wQw2cM7idIiSb66JYMiAmGLxVYPfMeyDelEwO/8CSxo0XtbYfo7PceoU9YJEmHGVEo1HkRl1H9d8Wsue32aLOAF9rGxjvT7DCXMjCrkGCWrgbJPnkwF0SxuwF10QTmB6OrHWyyZkE/n7uzO/tsm/wOcDlpnp7M2ykCbdnM4P2wkNmLpC0daG69TWYrcM4FfM7/hI1sa+/4FCiyjb2C8SEKwLNabeUDgf9BFvDkNhlOHGzYpzbPCSwaQM41ZY2GBAs5oDxtdCg7K+uLho29Hsx4AiwDJFHJD91joKUjHxN1s3req+a4sUVulgIqx/iF/zfRYTJpYXah7TvazrkJXJ9bLN2q3DQB2kRkpf0x+1i4CeqnLikZEGw1PzON78zRGd21p2Qckn/2Gc6BuLo0Ampl614ibdpg+QGdOMQbRU0vOVJWxjPUrX7WJs5mXhhZKu6YEOS2SBm0/EjNEt7j9n3Ep5D13XdIjWNo7g/h/J7cFgVt+6OoYltTxAmHRGKsF8+YhmPINaljrKd8y0T4ISVZvRmUBqYyxFyyf1wTCtV72AArpCt4mm7Zmo6Ls+rDrZeA7NL/MLnyb8U9BBZyshHU3J+aDwfDvH3Oo6i1+0q5dYG2rM3kNXI902+c84rbT6hLmXDCXUNI7EMePuCOnv+hv9dHiDRWFJfiuSJgbzlALikotYNnRads
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(2616005)(5660300002)(426003)(8936002)(186003)(336012)(16526019)(36860700001)(8676002)(47076005)(83380400001)(478600001)(26005)(70586007)(70206006)(110136005)(4326008)(54906003)(316002)(107886003)(7696005)(6666004)(41300700001)(1076003)(40480700001)(36756003)(40460700003)(2906002)(356005)(7636003)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 03:27:10.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ffba84-497e-4828-4906-08db93085b8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
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

In order to avoid any initialization after cdev_device_add() move fault
injection and multipath ctrl initialization before cdev_device_add().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a732a862d6bf..555ec4af5b80 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4465,6 +4465,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_release_instance;
 
+	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
+	nvme_mpath_init_ctrl(ctrl);
 	nvme_get_ctrl(ctrl);
 	cdev_init(&ctrl->cdev, &nvme_dev_fops);
 	ctrl->cdev.owner = ops->module;
@@ -4480,8 +4482,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
-	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
-	nvme_mpath_init_ctrl(ctrl);
 	return 0;
 
 out_free_name:
-- 
2.40.0

