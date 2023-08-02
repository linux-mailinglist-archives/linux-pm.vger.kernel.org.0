Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1BE76C381
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 05:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjHBD1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Aug 2023 23:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjHBD1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2023 23:27:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD53F1990
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2023 20:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg5c+8jk3u+KtciqDCkzQaeWF4HFBQxu98p6+mYp0jA7A6ycg7vFNXqXLCyWKz4GJaiyM13DzsxhjyvWkds/hbX8Kabt/wwDmKVPPp7lV7Ii6BOXA6vtXgfxSRgdmE3U0S0rd5T8WtOIEbyM/2mamzad2HFftaw5WBO3UO9voCbcWR4p8lbcRyx2G1aBS5h1+FXlDv7Xbcyyl+/jKlB01mtzIt5WNxsHEQ8oHvxHX7I6mfB1BeDG4vByeZCid77PE3RgcyJBnBPbJ5TLWjPMF4ei13lxp6suglkKGo0nYGo+X1MhzdcbE96HWTtrrL6v6vJEa0Nt8/fszZ5bTJ8dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXWE0D79dU6sChd2MozY6tprLj+NzHL+YdDPGzMCMzs=;
 b=WUiSQ9obasHIKtlzRS1fCUO6JJOU7BL2d7bjbjPz+2TomGNrUraQLAmKFC29eIOS1WHAkQnylmzPMPoqoBHdkytX1/QVLRk+Lnzkdp2QQRzeU41/VPfcsrKhG9mp7ZcA2UVFy5rXaySd5i5gqoXIDMAf4Sxo1HgnpxZIYw3QXIFGYRHM01fJ54NgkY578pY0OF2sJn/UB4c8IPde3YgQva4a9/tk/4QPNaMV4b19GRji0ot9JYgPdeLpo3A5Ju5+bFkn3HK/Cn9NvO2ALm9C4bCJ4A3F/fnQFzz+SA4x7+m8zG4eUVzHAEUn4+avJqmIqbggEzBuQJL8lhA40qEGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXWE0D79dU6sChd2MozY6tprLj+NzHL+YdDPGzMCMzs=;
 b=g7nR+XtE8xoP1Clin/3LQxZ/B4hiHBzBQRXH3pPhkUeUrYS2+z1Ja3KjU8NBsZOTVBVUIzMdnW6Ju/caFJjiLohq7O/k6V52ytEij9ZmHk4C6etU+cfqXDNb3nnlKNnZORS6bx/aWwMZ80AgqnVQ/aiEMzfKrl0UcK/9jQUkLitDIz07alQ4VCXDZsNOg/TB/YeXUm51k4U/3iZYnuRHFT9zKivPyc2egcgNeHQCB5f8HTCXlDNM3gJ4cMqS4iS7pxY2+++B5tpp1WQP9Y3tv58PHoO7Fpf1pr1UCKc2CxwH+HUXvml+qYCtkNeU3ncwKMiuU8+k4gPg+Jer0YLXIg==
Received: from CYXPR02CA0075.namprd02.prod.outlook.com (2603:10b6:930:ce::28)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 2 Aug
 2023 03:27:01 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::ec) by CYXPR02CA0075.outlook.office365.com
 (2603:10b6:930:ce::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 03:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 03:27:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 20:26:49 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 1 Aug 2023
 20:26:48 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-nvme@lists.infradead.org>, <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <gregkh@linuxfoundation.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] nvme-core: init auth ctrl early
Date:   Tue, 1 Aug 2023 20:26:27 -0700
Message-ID: <20230802032629.24309-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9cb279-d17a-460c-0aa1-08db93085608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Esv4CjVp6zkCLYoOHEPl16SRt84QQiuZtZztweM6Y9AlTPDe4QsUNpOxWp/Ny2OWUzrIk0a7phtY7wg8n/2tq5e6nstydYbZGlGNocTH6ZLdeVN6Rne7Ss5U8x7Aw+PDLvNvyAmfnDYP5+Np37X2qYqtxdEkdwAO/ypor74aE6U1Eq2mI5JjkSUvyFYM+tLTNF6kCXvUsDHxfCxsAdE3z1vAPmpk1HA+1IqQpYh7Uztm2iWjHT9UdqVkdukfU1bme4sj1eluGydo78U44J6ip8octgv6tHK6PPEF6R8SM8dvVdvtK3rkoOAR3xsxeeWgaY0+77jLMGnhOJbkuTcdxdsQ7N1bDcazXFamN5AnwJNndcrWrHyQCNz5ojr+FPbsZYbzLF5itG6uj1ynoV8N9TYp/51G8WcUGwOL7sGphm2vyWC3qs277pmdmVLBVBO/zP6IfPTTJ+uiojKE1k4H50WW/Aqp4AM1jIWM3aL8GY5Rsq6u6sWj06GXBa5rUAWFWIlTyeplY9xcjnWg7SOWOSbvjhcOb4rt5s+I+cfUEMBnOV0BgWBOM2kLrOaWzFmgyrJCKzh+QBMb2Ioy2IziNXf/Mz4+nxYuEuXIsnTJzlFaklVSayLEPbUbornW3H79tN2fv4ciHSMLx8Vc7u547LWB3fWi084ukLhOFe9X/hQQshSpCgjDjURzunDv991eaWtpvPooQoFfWDiNyTtFrr/XysRHXsfIZwfC5tSCKXrKaYJNEQYgFmZEOJaBkOgBdDhgOlYXvt7D2eZzJnzuUw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(4326008)(70586007)(40480700001)(40460700003)(356005)(7636003)(36860700001)(70206006)(107886003)(2616005)(66899021)(47076005)(426003)(83380400001)(2906002)(36756003)(54906003)(8676002)(110136005)(8936002)(7696005)(478600001)(316002)(336012)(16526019)(41300700001)(1076003)(5660300002)(26005)(186003)(6666004)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 03:27:01.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9cb279-d17a-460c-0aa1-08db93085608
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

Currently, nvme_auth_init_ctrl() is called at the end of the
nvme_init_ctrl(). Prior to that call, we allocate the discard page,
allocate ida get the controller reference, and add cdev(). None of these
steps are required for the successful initialization of
nvme_auth_init_ctrl().

The only non-nvme-auth properties accessed by nvme_auth_init_ctrl()
in ctrl_max_dhchaps() are ctrl->opts->nr_io_queues,
ctrl->opts->nr_write_queues, and ctrl->opts->nr_poll_queues that are
set by transports.

Ideally, we should avoid adding anything after device's addition to the
the system that could result in failure, since current position of the
nvme_auth_init_ctrl() adds more code in the error unwind path that can
lead to potential bugs which can be avoided.

Move nvme_auth_init_ctrl() call to the top of the function in the
nvme_init_ctrl() since it allows us to make the error unwind path
smaller that requires less debugging and maintenance.

Note that the addition of the whiteline after return 0 is intentional.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa746662..a732a862d6bf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4410,6 +4410,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 {
 	int ret;
 
+	ret = nvme_auth_init_ctrl(ctrl);
+	if (ret)
+		return ret;
+
 	ctrl->state = NVME_CTRL_NEW;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
@@ -4478,15 +4482,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
-	ret = nvme_auth_init_ctrl(ctrl);
-	if (ret)
-		goto out_free_cdev;
-
 	return 0;
-out_free_cdev:
-	nvme_fault_inject_fini(&ctrl->fault_inject);
-	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	cdev_device_del(&ctrl->cdev, ctrl->device);
+
 out_free_name:
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
-- 
2.40.0

