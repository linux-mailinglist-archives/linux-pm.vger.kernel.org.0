Return-Path: <linux-pm+bounces-9604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883CD90F26B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A67A28330B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB411514EF;
	Wed, 19 Jun 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IDJ+amt9"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D31514ED;
	Wed, 19 Jun 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811658; cv=fail; b=sSk+ap4Osc1gNNXlqwaq9ogaFyKWVI0uuwtoalfndWgxJQHM6lQaBNl2Kryq9AtXSStQB32o2RrWULItf3yxBVuDWsZxN+d1jOF/U+Ejbi6GicvTugPxbTZO0bR/aZ8G/JPoQyxiya1UpA18KKvJpuTwY3smm6uZZm1fafnuWh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811658; c=relaxed/simple;
	bh=8oi56JB51hKIMujwy9l7EX35vtzjTuRgxVMy8CWr1mU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTnkCtamqjcGL4tYb0xBGoMoNcoa7gYbYUk5VETUJkdqnz/5igtTzRMxWIG69MoTl5BjgG6+nBUiqhVYH/sm0cZfF0EJwpV4ktrYj1dMsIu3zGvIV1BqXVpp+HiXpp0mr6OjY2YUX5wpzEpCy/zDwcgVYC2Scx6FXDEL9lJHKv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IDJ+amt9; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHrgVLrqn17f5E1/7Ij786p/m0igyISv8vD58JsujZY72rN75jnaQ6OgAP04CELxgWa+ByLIBSV14iJdPMYIPBRC6HTtQYwBWboE9UmxdWn2uUUU19j26as63QYhJtWLSwUmKeQ2YtgfbW0NhBbZFP2WtxZD3nv7jAwU5l4jyh+VyvxRIHziAlNaMzFV1yuc0dLkIkfiKsP2xjwWrJ/IVq0e+nA1VNk2sqrBPJea7GibstYmCilHo+mq9o+HWqoF9jcgYcGSCZtWZVqfFrKejb8kjjjYW+O0J7JXvQaTGn9DVGZOil/nRVr6eovX8lCqdeHYP+FZl1n6P3FJhPVBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/E6IhBOVp2XXEspZ45Wryd1CtYnDAX00CJJW7w12rQ=;
 b=cY2ICkal2uXV9xjYbFX8Rnr4RwWulESrBuEV0q9cYSrq+KkY8G8k3ByMR+BCy//AQFzBWjpryZ52F9H/pLx4PXT8h9U2Ae8Rwx/srCDTt0/ERu7ZDyTtq4zI/Xj9QTNQK7cGXFRuEjHFgS2G5iygooS8jBpaLFGKUzJDTy0Y7/12NGXoT9PmC84/AC/UlzMVoVLr0vdRBRthw+r745FjjH0UuO8+CQhWWdGrP/+mdmvRULhDSogIRCtQeTlWlSU/S26IEf90R0tllTHbRp5I/UakhfhmwW8vo3rj6BaWsMakqLfNjOid+nHQRGRLEF56+OR0vuuXprelyU3eOh1Hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/E6IhBOVp2XXEspZ45Wryd1CtYnDAX00CJJW7w12rQ=;
 b=IDJ+amt9oE+GN7e4Ia2ItFpXLfzqcl/IPshsBysFFSlEjCf8iCMAzrTuDt42YUP8ex5dkFwnQO7LAa+d2UjZXVrxiwcDA3J+fSEdZTbiD4duHEe7YADNGuRMhvSjc+2Wyg78wZvp4k0aA+TURYZmto2C+2bxysyWjirNgNRuIdg=
Received: from CH2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:610:54::32)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 15:40:53 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::6d) by CH2PR11CA0022.outlook.office365.com
 (2603:10b6:610:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:53 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:50 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/8] Documentation: PM: amd-pstate: add guided mode to the Operation mode
Date: Wed, 19 Jun 2024 23:40:16 +0800
Message-ID: <a61d825ef71f6aacc8f1624fe9fb982b8446b5a7.1718811234.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718811234.git.perry.yuan@amd.com>
References: <cover.1718811234.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: a77eb4a7-fda6-43e6-e84e-08dc90763413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4cE9jB7AcEINVp6F+mKEjQza1ZVmeVW9/zTRHSgBooSTmFpAh4CM3LvTqnW?=
 =?us-ascii?Q?zgX9xhYLFg38Ausr96qDHaLJMX06z+TuTRJiZCq2g9Am+YN9M3E9CCZMxAfv?=
 =?us-ascii?Q?T+ca1veO+Aqn+jaZlRABAmpoJaycRu2vJZnlvNjXEtHICE166uhjeb8yNfkr?=
 =?us-ascii?Q?ObpKSIfA+zEbMcc7ZytY15aVzXEuggrG283w34xMAobffRDbKgLClzq9KNDv?=
 =?us-ascii?Q?hVPdt/H4+9wKppfGGy/cDH5NSJV/9Mh+u6wMzVWBGMmYwNHO58EyBnaGeUnN?=
 =?us-ascii?Q?M2VVcoP2/tPuTT06OcBwUbt/+RyDKC5KBqzPGY9aPVTuB6imnvRAY472Zqc2?=
 =?us-ascii?Q?QiS/AdwP6v6E7Xvz76eNJthqmZbSC+26+fcsWabll+DutYKh6MdQx5dLThJ1?=
 =?us-ascii?Q?5KyZIz+PTDHyOoHDGKVOjI0CzVe6KLxmCmkNjIUcYfZdiE4aQNoQCJ94bE85?=
 =?us-ascii?Q?a4TR8QUjTuDiyxFRZsZeVoFIEktVRD8FC6jdBxCvtW0Y1rYJguKVIe//KAIx?=
 =?us-ascii?Q?iab9fQ3iezQ3rArMf/Bchmkc9PxzWoa3AfminoNshB7ygTmM92KA7NUWsfQm?=
 =?us-ascii?Q?PgE1RtbN9ce2PCk3KWZ8xCqvZFNYTTcXhLq9O3E+HBinUcyV92KqhcdV21he?=
 =?us-ascii?Q?tNt3o1LfwMIm6fjKkKQzw8CpNmHXKnBbleAAk3ZMUfnMq7eg+PDL5WFHA1wD?=
 =?us-ascii?Q?R0mfVv7CRcoTJoOa8rhZk/k3CNtiqmBhIJka7XnFXRgGiPh72HfkHcVrIZad?=
 =?us-ascii?Q?io2DwvSGu/1/IC4gTuxKdsvMnuKlKqBQVjZ2xVQwEouj+4XHT4p5+x7rV1wp?=
 =?us-ascii?Q?zHKiziH45JR71zmtZqVcllitJexl2NXXAH5w0zdqJpeDKmUKznc3DvpM+XCN?=
 =?us-ascii?Q?p3d/Gy0CIl8o3qfGSmmf2ZJadhQAF+UylCt/5lJEfkbOPjLLpc0H24Zu+4B9?=
 =?us-ascii?Q?VwFN1Dou+ecyDNgIrrDq2feyPQECQOhLJtaEu4bhm89mOkYeLP/UM0tORa3V?=
 =?us-ascii?Q?kdNYrq1gSg9Vje6xG1fE41xNNvjCwWOESRtkRTn1xwQQMKTmexBHqq8gOriV?=
 =?us-ascii?Q?vutJgys6YR6NQDZV8EXn8TvXEy74TBR6AzgUn4CrH/qvTstyuqtVJgPy5nUI?=
 =?us-ascii?Q?pp1bLgmhB6Uo0yDZ4G+vA1QwDEeQnO/HVdrJYIDEHDVZvT9ZoJNwX53+IHkS?=
 =?us-ascii?Q?bwlnPweeE0tvvOcrNyvE7daKLjhzBkW+RB3cmX+OhUkHKoX4CRKr0TgORjA7?=
 =?us-ascii?Q?Mv1t5EdZj9LN1jab0hsR10187HEjX2QcT3q9zNC1oez7KISaTCb+guOsMw3e?=
 =?us-ascii?Q?AznDDDosHBJX2oWbFpGnJnAmQvDfh8myIy2XHsudTxqdF4kElBOze1neYgiX?=
 =?us-ascii?Q?FnhT744zfeiFYUjJBLimZRhKPydXAG0Tszil9grnxSDXQIei9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:53.3090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77eb4a7-fda6-43e6-e84e-08dc90763413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924

the guided mode is also supported, so the operation mode should include
that mode as well.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..f5ee81419a93 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -406,7 +406,7 @@ control its functionality at the system level.  They are located in the
 ``/sys/devices/system/cpu/amd_pstate/`` directory and affect all CPUs.
 
 ``status``
-	Operation mode of the driver: "active", "passive" or "disable".
+	Operation mode of the driver: "active", "passive", "guided" or "disable".
 
 	"active"
 		The driver is functional and in the ``active mode``
-- 
2.34.1


