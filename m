Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A495FB799
	for <lists+linux-pm@lfdr.de>; Tue, 11 Oct 2022 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJKPoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Oct 2022 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiJKPnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2022 11:43:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B111B2CD;
        Tue, 11 Oct 2022 08:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbpGWa8rBi29ZLi9kOd1PMJ5SpeRobe0h4YCkHMC8+PwmgF8jo+GnH2qstOA1RLMtyqpbM+kLmfvt4kBELyMWMpLcSweeG6FaOGB7YjBpX/IH+W4Isaa20YvBhLfwE1jpVpLleVQBWyiOgUqgLoF19ar/xVoku1Nr8wGt7m5SA5r3TpPptgsGVXlV2Uqgl65T0ZKkSs0IWC4hV4z46R8ptD2evDrrd5xkJxX5BIlVYQ2x8uARK7s6bGyNl3E08/z6t7q6TRuKDxmp9j55W8oMh2DOevf4L6ubamugkU2fyd3C0CU8Kv9XJjI8vwkWA8cH4AMnY50Iz78IIrx+QulKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp7K0xxQWUh+zbu9Z4fUWOzaIlxkMdnNlMcV6CmCYmE=;
 b=fOsKFQbhXfZKmRRVeWO2l3o+vh1ZisB8W5Pb8yYsCwzp00ye5elENZ1F7X0ly9tLzO2tFz/7MnMnIy1EMIJO7wEA2Gj7PUTJDVlH/X4j4cgwyL9VOp7hzHE9s++WgZax1rIbe/IhmE/72XOPT2A4RLB+GMbbqLU98sBEeRN66iY3o7/fY1vCPIHp64uWKB/Aj5izcmBsF6z5wRn8+s2DZ6Mq4/SrwPQ2siG4tixluJVNH2Zm4kOdvsvNy/sd05Mbw4oVd9FEKOsMBAvOhkXhb8gyc85P2GEgc3xlySt+55IUmmgHKtAWCj0LEN8xY3SUzGeMzI98IKZJ89OCmoVfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp7K0xxQWUh+zbu9Z4fUWOzaIlxkMdnNlMcV6CmCYmE=;
 b=lyoTPkxuyYdtlplpgF/cjZr0n2fEvKXik4vd2Zw070qT6R63kqXWmCgetnPUN2FBvHumxIwBZRI3yxoAP4vhsCwc3teSW90IfJDHojkKBTifNIegoKdjsV+S9riAvvTLu+sz/oS8CahdqvDDKz1mrRKFMdHGitXqur7eY+fu4STN0H7ea5nwbNv5+6xn6ojvXzl3exRxZm0UuEOxJ7DWdPw0vgDzdAwUrkvqTt2qy4ZhA7Gju+Ivu2FQD2TQp0kMw33rc924k6PJhRRfGM9xH9RPzjk41RHCh7HfHz63i1JkN6d+xJCSYFvvHJ6EzCh7BqoYGrIEb+ijTXSOpwNbkg==
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 11 Oct
 2022 15:33:00 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::8b) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.20 via Frontend
 Transport; Tue, 11 Oct 2022 15:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 15:32:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 11 Oct
 2022 08:32:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 11 Oct 2022 08:32:46 -0700
Received: from moonraker.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 11 Oct 2022 08:32:45 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] cpufreq: tegra194: Fix module loading
Date:   Tue, 11 Oct 2022 16:32:43 +0100
Message-ID: <20221011153243.133712-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec4a4d1-19f0-435f-3346-08daab9de0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/rpku5tj/7qji58GQorNhjhpxu9aGRDNFVTrbT/gwfgBc10saYzqQj0hhIrvKOdzfsx5hbYFPCH5tXIQb1tGtF5SPwyqnINqd5u3VXX03oFUoNjCqvV/xSQPKlqVw2Gpdc6Z1xVgVPt2CubJg6iteMOyX6zA3BHGpOaCwbMipNb5kRj03fmbrvC8AVwmFkj/IOMurlMK4ncUoooffHFIIuFC4Lfce1fPwtSrD8ptGoROibelHNbHoVzKvInrAJuBYkGZfWpolX3UoQAkVUV9S8fq0s+HTQ23E6UNrmSxNU62DnnLi9Xme8Sj9zcPHIZt/a5Oi9CaFe8NNRtTCozEv2WvyAcby4pJrHeeWz2Zx1P94xut1eB2/LxaoOUDig6VnSCXF5NMATVlNuk+eo0RwyBkPQ+tLaU6D7YdBIIDihmZnWpbyuneqf3pX8jkw8+T6fNGGDv862oyhZFHrawDRS/f9rINNbIVlVCX/X8H2pKvDcMjgMQk1rcXmturAEHboyDBU+D7OBXewSdcEFohlgbC4y4V/gR03pnGiSPuuH88qOdVes+gREZIY58gPDFchFRzWUC+P97Mh40h7ncWxMw4P0KDufSbCUTEFZTqcnWVgB3OHDiEtaDlznDLbPYyVMnKuEx7tZFsfPKKA+zjR8dgV80xLizp1COtdivXCws1daBn5DYGu9DM18d24jDrCo3F6ehnip7w74oPCUDilqvuzW+IJpyIiMpAIxp4sF/WdvzJpoFMBolC+M9AgK4yln6BTog1kNNinaUgPAzGg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(356005)(82310400005)(1076003)(2616005)(186003)(54906003)(110136005)(4326008)(107886003)(8676002)(36756003)(316002)(41300700001)(40460700003)(478600001)(70586007)(40480700001)(26005)(5660300002)(86362001)(336012)(7696005)(8936002)(4744005)(82740400003)(426003)(70206006)(47076005)(7636003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:32:59.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec4a4d1-19f0-435f-3346-08daab9de0eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When the Tegra194 CPUFREQ driver is built as a module it is not
automatically loaded as expected on Tegra194 devices. Populate the
MODULE_DEVICE_TABLE to fix this.

Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index c2004cae3f02..4596c3e323aa 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -589,6 +589,7 @@ static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
 
 static struct platform_driver tegra194_ccplex_driver = {
 	.driver = {
-- 
2.25.1

