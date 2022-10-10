Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559315FA0D9
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 17:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJJPDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJJPDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 11:03:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C1A5005B;
        Mon, 10 Oct 2022 08:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkTmXdb8nAG7WB51ThKE4Mu22/3MFZJGqP4quxlj6EOlkB5YG2sbNCM+MM5O8KUfr+m4dFyOvsdQnL3jmHXwh3KHnGSbN7gEcwc/uIibfGnsEgSKMBX6yG7BIChPxB2MMjr26zpJd7bOhHqeJTNicDfF1I2jpMyCWKVeIhAKcVaiGj/gesMUCLcSYCo9KGZ67aBNH8IfSlMijZLtYETT4Z6QLZzY+8f6Kr37K9hGB2WY6KJ4v6IOHdv7CITGo7fOAUtrfe2roRZ1sbRG3zBvzShynSUe9lcFsFE1ErglR1cS7n6X6XC1y6K+SnLv/gQeMz6SuEnDs6jVOA7AyoG5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAZF6+dHDtDA+/aceDuBVG6XS1oMfb0HzOsugIMjl5w=;
 b=kVaiFrYX9tzD3dS+CSy1ncJ/U81Lce3BgZQqmPhc6JQO1oJSplHXdFWwzhnPHk1fzr0UsepC3a0TOE1hAT+Czu5xTvIaZVPNc2hfQXt2qmJg1X/kc3zYdKaTO9Zimo6I6FdOuS5aRBzKWPfL0WAxRVmd5AzX8/RXQfrSU/yPdB8nOfnS4LrVB16b9xsw3fGQ0uOQre6yljZlUiNCnz8KyGey/pFwr2xYeSC2eBKaaCl61PxAydITjMaqI6yifPck4IX9Ds+8niTrXiyPkd+SD5rGzEglylqPkGOoWch2nMb0vVgVH/F2+NwIZhVIUi6PzcXx+mQtxALwpVbifzN/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAZF6+dHDtDA+/aceDuBVG6XS1oMfb0HzOsugIMjl5w=;
 b=mHLOyVB9z7BcIb6fyl1vmzZlrE95opttaI9uzfY2vKD4JP8x4NczznqMNVwjwubPQ7n3h9FCgcMnBvOVYrMgxNqsqgKf+MigisJLqJ2CK5OYSnYgwhG4ShAhtaC0b/yg1LxD4mYxwdGqaacBaPH8I83zolA/4Szo2TPMw+z0C4jyWwHW7g97dF94C6n/NCImhljLcTJEhEstOzsdISQcZbaQn+LXin7bFfLkOHEGOIjdGZnGAdPrsPOnyx0kxScZrdmRii35y9JeMwPU+34fzYVPMIZoply8IBAbab6tQaTUDryT0EwWQmZXw1qoLTtZOI1oPIVqio5hsA1eg1Iq+A==
Received: from BN7PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:20::16)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 15:03:31 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::3a) by BN7PR02CA0003.outlook.office365.com
 (2603:10b6:408:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 15:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 15:03:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 08:03:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 08:03:15 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 10 Oct 2022 08:03:14 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] thermal/drivers/tegra: Fix crash when getting critical temp
Date:   Mon, 10 Oct 2022 16:03:11 +0100
Message-ID: <20221010150311.40384-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: d552a42e-7f11-4d9c-ba95-08daaad0987a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcPhM9MqAIhYx+Ns84ZnduFMJul4IGKf8IMdSavQGTpHkueRQRM+S85/gTTLWMhAzlu43P3KAQKxIM/lCTabIqfHq+HZB7QU+ZVNQWglV+3945iME2C01U6ErdddP+hwrxPVK79gWJQzzji8QoABgQp2FlE+xMSW8BHNTS6mHh426TSSKdv0lcJkWBh6RBJsy6+S/ZOZ+Xd0YGI9lyEIp7tf6qVFXP4u9xIbDs6LDM829YMDw4r7+ezk9cTmFBwoAsIwuLD06YHtu9GRy50Cqk8m7/75JiXU8/qm1/nUD5YO5HREy8skH/NIbVcVfL7sSa9S3y65YRh8N82o9sKAPTZr+xOHtelSFMUmzmM9VA/2DIF7sGqzTduDM1qqIABNoPVU3PvTvU2DtEVCdrSBubx/LUAW7CZGBcGM4mJNg5AcjZZxRFjAoINMqXozrqNtuuds5zUtuJqpr3UADy9zhpyV3mXbAoLVS1AWpI9qHxqApXX6j2c/H3dD/vZ78iGOenM/XvLQrR/R6YQkXj3rfloJms76W47C08ePsNQla7zTZE4FmtxXrDVkP7w7TBYqdW8BmtjWnOmH0i0jYI4+5bPxvtSRIGW14pFSupQYO7Wewxh5dAaHE4u+eSWVlwfu/jvCsSu/aa8ROl9L2goeXJ1xZI68MheuM4E0SzEBjYqPHJA5tMTI1hiFPjob7n3Dlc1RIRdurebFSrxagq1dLxhhLHHY4jXEYqLWU1Nm3XSw8gJnhtNfuU4aVNUjhIw6C/OA/x3uNnuYU0ywJeta5A==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(82740400003)(86362001)(40460700003)(36756003)(7636003)(356005)(40480700001)(316002)(110136005)(54906003)(478600001)(8936002)(5660300002)(8676002)(4326008)(70586007)(70206006)(2906002)(41300700001)(82310400005)(83380400001)(47076005)(426003)(336012)(107886003)(6666004)(7696005)(2616005)(186003)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 15:03:31.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d552a42e-7f11-4d9c-ba95-08daaad0987a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
removed the function of_thermal_get_crit_temp() and this is causing a
NULL pointer deference crash when attempting to call the 'get_crit_temp'
function pointer because this function pointer is no longer initialised.
Fix this by replacing the call to the 'get_crit_temp' function pointer
with a call to the function thermal_zone_get_crit_temp() instead.

Fixes: 13bea86623be ("thermal/of: Remove of_thermal_get_crit_temp()")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index d2e454902689..4203e74e2f79 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -742,7 +742,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	/* Get thermtrips. If missing, try to get critical trips. */
 	temperature = tsensor_group_thermtrip_get(ts, sg->id);
 	if (min_low_temp == temperature)
-		if (tz->ops->get_crit_temp(tz, &temperature))
+		if (thermal_zone_get_crit_temp(tz, &temperature))
 			temperature = max_high_temp;
 
 	ret = thermtrip_program(dev, sg, temperature);
-- 
2.25.1

