Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6D679717
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjAXLxf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 06:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXLxe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 06:53:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882C55BB;
        Tue, 24 Jan 2023 03:53:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDcj+IzlVoPYrl/gtcP4T1m8Wtug2ixiwokmKjeYbkLA/C9lbRf81vWw7cUW3phTYjPJ3dd17e6uWJFejkQeBPRLxEq+qbsq1AGm6IAE6Boa/JtbjbFnrAUn0Uvos71pJyStBzWI7+7A/XFjkvQvPhSnqL1xcEmm4cxJDNNTHaYhGAxVuSi0S1qBoAPhYD1DDVDzVclkZmcpp3IPn1YBqsJ9F6aRP9F2ayKZr7MtOdCCEzRxGNyvGAeXqmIJNRm3XGtjgI4hVyv9x8hncueutJlX/8/MZL0jkUlnSeDM7vwzgAuSNGKE1Z/mzi4L8S3l8aXat7uxuwXPOilu9Tm0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZRvzApit7+eg+2vY7J1g6NLqVDpdwgXJdINMCeZdHk=;
 b=c9Q+3QsjW6jiBBRhXlu67kFYmM/pSIKg+caZ+wftAFeFvpFdw2DsJBVwC07OFYxix2V5jbH70AjKtpkIdtfJgobhJI/jeBIJlOYdx4vfR+Vw97uPT8TtH049G11hqRKi0cha4KrPoXuKUG9VQpLPseFQpIkTMnRiqN91PWEStETw1N2L/OmW1ed2n3qA4LMkf98mLERGw0doRSqrWvPMQ1Zellpr/0lpLhjTCAdXAi6rbmYJ+J2XMlPAZ3ivV2LE4IYaDd4DSXGt+W4E/DIrzD775/oMabX8vJNCrtes8BH/yaYIF/HLW+3FXVl8LPlx3/r3ugCi1tLehX2Dj1ZCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZRvzApit7+eg+2vY7J1g6NLqVDpdwgXJdINMCeZdHk=;
 b=rj42zcAtHcaZAgpvYQ7D3nkWOZx0wVViB+CxQt2Gwi7O7xzgWzbjtGF+9sQR+9dqPoGe+qbyf2tYgkrQh+E0RNqw8oHJ6JLrUM73mBhkEd7l4B9Vx1bEXg7rajZZwKXcBJx4poxB4fgvJMKsbFXXhREyX/OCO6/dQCumBSRo0C/EaQDbrVpQB8P7jLZJCN7c6wBWYE5HN09R7Udm/yURU0XCfP8p5fnEYOOxf+w44bdFHbx5AYduxgUYaEl1AbXjiN0vQYKf1AYTK7VUVMa0lvPdceU3A5/8QCvfERU30uYRk0AlS2CknWrIwsO2GvOjUagws9bB2/esagZTgSCEIQ==
Received: from DM6PR07CA0046.namprd07.prod.outlook.com (2603:10b6:5:74::23) by
 DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Tue, 24 Jan 2023 11:53:32 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::4) by DM6PR07CA0046.outlook.office365.com
 (2603:10b6:5:74::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 11:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.17 via Frontend Transport; Tue, 24 Jan 2023 11:53:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 03:53:31 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 24 Jan 2023 03:53:31 -0800
Received: from moonraker.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 24 Jan 2023 03:53:30 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Yi-Wei Wang <yiweiw@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] cpufreq: tegra194: Enable CPUFREQ thermal cooling
Date:   Tue, 24 Jan 2023 11:53:23 +0000
Message-ID: <20230124115323.21910-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: d239ba9b-0d1f-471e-724d-08dafe019e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TF2RkWVy/fklolHcS4vK+RqQU0giogmEd/pM83cj3zWLk34KZoD7uowudeaPQ8f88aoiwdAvH9zaGhqI26uOy421pNuLW+X5Bn9W/YD4mEARPsRIerXuP09VMaAdX2BjIrqEgarorO9qUekfGdjvayy+fqU1Jv5eCcx9a4mTzsdaQDsCl/TLl2e87T1NiPQApOydPTFTMMvjY9p/ME85WYQi24h8FB8sB+rv1tEyp8BCSnx2iKxzG6PS9/Ynm4RAuCVN0TrSw4NJ8cOd8ZRL6qTYRM8HUrLic9VqwdFdAX5gl7+9vmQK6x9TP/370G7CPsKfiE7Gu7fCI9tX5cz22vSLxby0MaUGq/3CJvJVlA2iBZGPgRZ8Bt8CL/aw+kpRUmvEMXUFXAyOE8YUbEx7usZf1//NfzAJqN4bDQCm6MZUmfDDp1ChZGsxOeflT6FaV5bxqKAR9QiCATmA+pSEGFXHy3/w6g/eKGoWrIgX2tcWAG4BOdZv3dr8EGQy4hFFyQHABqoi/N5VtBErjtyAVrvwnK0t8Tk9nMWJvfYWKn0ThqfjjI1f17WrhSgGG4fIfiqQtbVsDlwCXipWsm2YMMeMnDQVGLt5g4V1Sx/yY1Dv19hcHYK+Ligp6adItQkpXKohee3lBL6RO5t4o4o/qLMJQ829mzJtavPKpu63jBVWK08nehDdBcMBlzG/zXcFYumroSj062j8wdma2j0Pxg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(7636003)(356005)(2906002)(82740400003)(8936002)(4326008)(82310400005)(5660300002)(41300700001)(83380400001)(36860700001)(86362001)(26005)(478600001)(110136005)(7696005)(54906003)(186003)(40480700001)(40460700003)(70206006)(8676002)(2616005)(316002)(70586007)(426003)(107886003)(1076003)(47076005)(336012)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 11:53:32.5003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d239ba9b-0d1f-471e-724d-08dafe019e0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

Populate the flag CPUFREQ_IS_COOLING_DEV for the Tegra194 CPUFREQ driver
to register it as a cooling device. This enables CPU frequency
throttling for CPUs when the passive trip points are crossed.

Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 4596c3e323aa..5890e25d7f77 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -411,7 +411,8 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 
 static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.name = "tegra194",
-	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = tegra194_cpufreq_set_target,
 	.get = tegra194_get_speed,
-- 
2.25.1

