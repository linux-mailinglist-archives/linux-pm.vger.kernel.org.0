Return-Path: <linux-pm+bounces-9551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADD90E6AB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33861C215BF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DD380633;
	Wed, 19 Jun 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eqbVSgU9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971CA80626;
	Wed, 19 Jun 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788636; cv=fail; b=GJumjpnFpQbcNxbGeHs+CQHd2ue/j6EoAmAsqQbYreuCpTwXpECq+U2aYzw3DH+jBUoUNNp4hZfCPEKpEouI5/3/BlhjZao7VMmlepuFDYYB+8lSRsa7OLd/nudirwhJq8wLKpJaoQoznbxFtwdDK1hFHdsmNbPocZzPowOGYfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788636; c=relaxed/simple;
	bh=uw8ywGJDHUMbfmLzSr1I+771RxDsmIinuCm8dav4Chw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLudWBrHEzM6wCG+1j9GVV63ECQxzl/c/zjK4b4ZR03xXf20L6s5VxHgoJWt2Tm1f5L6tu/aEvlrL8eN4BLR6gQifooepAuRjoxvd9aNb7DBSXZFi0p9vf+397qvo/a2RcS5CB2ygaWmFxxQBbthicunQnFRanlunTaSOt2x5ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eqbVSgU9; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3z0dlXFEAo02tFTawQMcfUsvWhNRxjA9Qsl2eW6i4uvJtX2pFExL6+QQEiT5On7P1IUFWqlLazQiAH9OLSsNSQ0ZbAkrZTv/8zeKvb5fjGS1imkbuD9jBrdcfxHoJxsUzE6BBTZUQNewqVoAdc3Rx28DbceTVdmZxC7H1/+pomLK7Sy++Cw71heaU6IYZA6NwvhmtdxNSXV0JoRjWVFp26+vToxkdHApAQQdI8EgZwNkqtA3RGRe1eSyOEO9mc9imDWx/5w6KH3DeZvAoZwayTsCcDucVQQxc7BGbQD224cBXQ9X7MlJlDLnThTyyMVtxHnYDk9RY+jCCdKpQ5wSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBp8CM/hTbL7WuYutn4nWtkMkIgzWgTrmXBZB58+xL0=;
 b=dbofz1mi6q1JpKmfojleO6M4VEnKhtlL8hxXZOqob9lUbHz8lBg/47Zb1Gw5TluzrPJhTGaww8B5XOr0r1ya8x9pP/3r6gjvIaZ5Ee71jaZVyMxfW39pEWKlq6rFmnGGrlQwGfV5eDyAOwLH58HOtnYFvqw5rsyxdoBqXakQq66PwvSLemGgPgEKd7iYtVDngq7BmLrabmthnd53YkoSph1lt+Xg+OYHMWN/v031RsHkUGxGPoeA68PUzfcY20qmGIxz4aCjsRRBZNoZJnDsfnP7UEDa/VYtx4DcRlmxgH/GsxFPuBA3Bw0lIuRvEjr4grbNKRCu/Y+va4hSVYp6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBp8CM/hTbL7WuYutn4nWtkMkIgzWgTrmXBZB58+xL0=;
 b=eqbVSgU99rr7duU/VGFjo/6/l5YvtYLmbIUOj3RrCabAy7Fo5QDaBXnRgagHl+m8xVqh80PCuFrBCcr7pKsVejAz5NAsY3I0f0trobwLhqkz3CDW3z/0oMO/t3s+znl6aD62c9oVaHYpNxCudD7h42VfaelGrqIVtXnFtiCo1Yc=
Received: from BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:17:12 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::21) by BL0PR02CA0102.outlook.office365.com
 (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 09:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 09:17:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 04:17:03 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 2/9] cpufreq: simplify boolean parsing with kstrtobool in store function
Date: Wed, 19 Jun 2024 17:16:35 +0800
Message-ID: <26f6ce59390a157cf37c622dd2fcf14b5738a8cf.1718787627.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718787627.git.perry.yuan@amd.com>
References: <cover.1718787627.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 482c9195-840b-4137-b40d-08dc90409a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qeo27Dq9fIO5eNm8KfRK6m2bu1exN1k38l87hpCwnvJcn2Alq9xt+mu5Z/a5?=
 =?us-ascii?Q?J35yxXQpYukgfkbVkc4YXyrmh25RSXc1vf8G3i5FcsZH5yC6o2Ld42xXiZvp?=
 =?us-ascii?Q?koaxDZI0VreEtPIscwFBJ5J8ef77mZzN4oMB/b6V3Gz6B+qN/IpGWW2rYxAr?=
 =?us-ascii?Q?M9LhZbmeI1wLtrisVCBDN/JzD30QJFGU8SObaGiqC9mbBdB1v7fPApXmKEEZ?=
 =?us-ascii?Q?mpdDwhvNCVySxa7mu94RHX4XmJHY2nTOA9B50ZDcReiIFxZkhRBTb8x2reR1?=
 =?us-ascii?Q?b83F03QjFXz1J81pc4OX45bfe8uzJBEfdAbJc90GsS8NHnIy8xMoAkoo0WBg?=
 =?us-ascii?Q?DCMJ6p4+g4rNgA9dVEJ71y5eqMuuAaavLgUTC72CXk6hGJgX6XFgg/Lrya6U?=
 =?us-ascii?Q?nbahqkwKlgxYo5HObw16vh7BJ5h1dhQK8RCQtnwq5q217lCshTsoZo8O2yaL?=
 =?us-ascii?Q?jURRrxpHJ/NlwRx+gumQZ0/QLF9dCuKQ0BUa3e54rypLjKzL+LzTq2zME7hx?=
 =?us-ascii?Q?rqhQEvvi5PX4xNizTYxVEsSwS9XRLZgicknRDHQN9pAxp5qip92jfTqcZUTR?=
 =?us-ascii?Q?lZla3qNTrTqOBjfx0osE5QBu9RrLTBz91iltM6+AiJ9OsJ/BM8TEd5e/b2Cr?=
 =?us-ascii?Q?vdndpRDFRyxOn38gjShsg3jCUpFYPA7BwoLo3Vi/HE5D5sCePREs8hiEibis?=
 =?us-ascii?Q?ILopenlj2tO5veOnAKQb+6hvGpQwa1pGqDYZEWHpsxhKJ573u3uS8KVcrz5t?=
 =?us-ascii?Q?dthcKzRb1kcj3ElQAA2lpCkAD53MqHBZUj4seH/nLanDyh6RQYcszSEuTYCr?=
 =?us-ascii?Q?NBYH2CDZ0VlsjGeYbZX4SGQTpjQ3c9P4wNq1rOma5HvD7qJlA9UhgFTYrSyJ?=
 =?us-ascii?Q?GZKXvjzVrHMqPI+daSWCEbrlEarKF/V+onNtDt53lpxPC8aMRCycmCMR4UYj?=
 =?us-ascii?Q?D220i9QPLvaBxyUN5h60J9X1+5WHp0MBivyrgx3kCqyzMxFW4jk8gNcWTx1G?=
 =?us-ascii?Q?vrYgV95L/M7ACiSF8RX1Tw7v29J4uyjcuIL3MaioaFCEqCj4vHA9aD9IXmve?=
 =?us-ascii?Q?iTHsNoxVU/L2x+OEniZ0r1PrhqzgJnyU4x87Po1Yie7HFHVK2lMWExpTZLBI?=
 =?us-ascii?Q?AVlThOAxXQrTbYsbkmP6AiTV8uxXJBQULsGcD+d8Lqtjq2dUYiH4V40tna6r?=
 =?us-ascii?Q?yIiHmBDhSaOm9NYucd81BuJyxkpj5zIDrEXNkYddSqri0eAqt4ZrvDrhm3ZG?=
 =?us-ascii?Q?quyeEfRq8JMAjsvAqwGnzIptFvvMggEfYSEE8Ee7X1DDuDmkJI3/LYUgXxT4?=
 =?us-ascii?Q?XhpFRlkyoTAdAX1rlvbf71z9tbASuU+LMMwfAzaiQqOsZu8ZANtQG2GGVe5n?=
 =?us-ascii?Q?GJy7jzCIzbsJwC0PZM4sqHBQmKJ56IakHmClicLYE+Qb9vnXlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:17:12.4492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482c9195-840b-4137-b40d-08dc90409a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

Update the cpufreq store function to use kstrtobool for parsing boolean
values. This simplifies the code and improves readability by using a
standard kernel function for boolean string conversion.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a45aac17c20f..1fdabb660231 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -614,10 +614,9 @@ static ssize_t show_boost(struct kobject *kobj,
 static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
 			   const char *buf, size_t count)
 {
-	int ret, enable;
+	bool enable;
 
-	ret = sscanf(buf, "%d", &enable);
-	if (ret != 1 || enable < 0 || enable > 1)
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
 	if (cpufreq_boost_trigger_state(enable)) {
@@ -641,10 +640,10 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
-	int ret, enable;
+	int ret;
+	bool enable;
 
-	ret = kstrtoint(buf, 10, &enable);
-	if (ret || enable < 0 || enable > 1)
+	if (kstrtobool(buf, &enable))
 		return -EINVAL;
 
 	if (!cpufreq_driver->boost_enabled)
-- 
2.34.1


