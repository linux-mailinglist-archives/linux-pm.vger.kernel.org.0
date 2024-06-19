Return-Path: <linux-pm+bounces-9606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F3990F274
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082FB1C21B62
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F381156C5E;
	Wed, 19 Jun 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="46HXFTEN"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DE15666F;
	Wed, 19 Jun 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811663; cv=fail; b=MvxyKPCuaxeFM0G1V2HEARRlVzMB2kK3HK/bBRu/YJ6prhCYO6SZtlBBj05VICgJoeqyB72uogdOBaePBoxycL/MVdoPpIK5rSQD/ZcrrgfZrh3ByG3C9Olcim8dU1O2/PdzSBBygT3yqEaIleb87mQx6okTaYbxZmVzWDkQ7gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811663; c=relaxed/simple;
	bh=WbwQO8JdPcf4kLFbtaG1OPNY5dsLdn3zPQCltGWFHEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzBXzgsCcxAuMmeA9AOXcHgcTqj5WQ4LD1Udm7ETOG9a6JNoy5r2cJyYEuZ/Nu8IePZ33D+PYcXaLaRjAwzRCEr2VgXiZQYblrcE5HeO8DSrW8vmCZoHYRkUJzDT+o8eBOR6e7yuUOldu+gQcyDoSlm1dm4b7AvIEnvr/7AdTgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=46HXFTEN; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA5qS0RScF2qvu9HRhDOFMS4/Lk1/tfAmwFCBEMGlQpyqRvQBU6w0ajPnCwuBDtW58fAPRzR/aLzK4EOe5my+F8Pw0cs/nSBZPcYpgVRMQmwjGTapb4JZeLK2hR4wYnrLUxBbO6FiqgpvqPIk46uZaDf1Ol6orrAUaFRVNBw546sEQC5+jDuXM7rM3j4sDMV0+EcUV9Ny+hi3hVa6ltZDW789IbnCj47SWNDKqIwYtDC+MI8iceKhGIBe+DQOeYVBDIZBiJ5HP1V2NFiHB0fIdqpNFLldUB4XHYalk5byqoD9pAG23zhJq+7+peoNoHyjngtq2aciosthDlAkeMghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZynmX/QXfKCaPcqU6fY4iQPhK0ZtwTKe70opGBMX8w=;
 b=nnpC35UlSkh/w7NLX5H8cGDtZO0gM4UA7vcMTPLwTbEHDZJ0GUZWYb7XA0bojCUCZih0HgZHkYH0HDHgREknQUIP2mmwVqaQL+NFQJf3eXVmuWIEhyNNqE6eF9nMrGddOSgmYrnA3zDDhkLeXeUeBycYMwbLIV6Un+RAQOTfuEYn6VIyHa6mOsZeBX5TyFq2Sich5zo3CHLyD2IR+mUyi1QnPYvgrkjHZ37XtPBw4h4vIfbIbW8mU5pxVX3fQMcsh+GzVXp5RnNevlzmj0zFwIWDSQI3LTV32cnnh5dhqVn8QRyxDj3XHh5AVolrGdurBTHrfQ+R8abmUtgSfJei8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZynmX/QXfKCaPcqU6fY4iQPhK0ZtwTKe70opGBMX8w=;
 b=46HXFTENRQPWUpQbEoW42r0h5aoWwMQSj7Z8oo9hbxEpEbl3u3HTYu7Db0eRNKtXyEutjIp1jDhneesWw0xz2+TuSiuPuXe1Z1to95HORZEJ1r1GcomBDq/ULdStXFXqWVnxM1EsaeaIjnDK3D/OBbhNksjMUhvS9iTQ9tfJmNM=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 15:40:59 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::66) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 15:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:40:58 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 10:40:55 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<gautham.shenoy@amd.com>, <Alexander.Deucher@amd.com>,
	<Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 7/8] cpufreq: amd-pstate: enable shared memory type CPPC by default
Date: Wed, 19 Jun 2024 23:40:18 +0800
Message-ID: <c705507cf3ee790e544251cfd897ed11e8e57712.1718811234.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 323166b2-9fef-4c9a-51da-08dc9076375e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|36860700010|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GW6dkU3LZFIQ+HBjRT35moSmkIpwtY3Pr2ueIugGEDNWC8oG/xJ7QZgsht3K?=
 =?us-ascii?Q?zEf6o21P3W59e+HL02edy+HlX2N+Jwi/koz04dHFcp6o+2VbJopJPXlcmEY+?=
 =?us-ascii?Q?3WBiBfJQtkWunJTosscOLbqWKu1fezppFkVKEf4nF5zSyblTMIdoBbBOI9Ju?=
 =?us-ascii?Q?lezT2TPT/FB1DkAK+/JG19lJtSuvoXYjSjak6rN7V7TTdhzBisC4HqRgtgJM?=
 =?us-ascii?Q?MNUchdVNHB4wfHiWMBifTk+X4z1ykn2yY/UP/HEx32GOg5ipqZY+8RjzYDdL?=
 =?us-ascii?Q?VpBDHAfcTZonF5IdwbF6VZz38HGPXNCwJDEKaS2XToAIp0fSZVz6CNUGZOSz?=
 =?us-ascii?Q?NNaPzf3InP/7uaiqGfaY4X5AJMl81J5UqKDwWTBpCjhyRSy2nVf2R3F8Y2Y7?=
 =?us-ascii?Q?RjDOXie7U0AJB0DvHOUitV9kGFLxzptz/Z5uQagqqRYzLe4ZWtUoA5ldOw4n?=
 =?us-ascii?Q?yl6uovoZRavD3jyXMEmyp/fiwvSVFNsAdeNyVpjusa4X/FiXzfNrHolkM6zF?=
 =?us-ascii?Q?d/JPOhGAW4ay3s2586qooP5+z/5x4gmWKScHtyuJFUaNAjadhAxGNbqk7Whj?=
 =?us-ascii?Q?2gTGpgStJoem035/5KgO/iDkE7Y2eCo82jxuns7BR6pIR1gs0Bft9E/2yzcI?=
 =?us-ascii?Q?e8CK4jdNwCdurYm1WpFK1n7r/a9Qpw99j706VwPrjcRMDex8zQjymird0Ne2?=
 =?us-ascii?Q?TSXURuD0KbK5CiVudT5TboLkJYtnJCSrEG8uO4EsZXPC3bbeWkQivY0qiFwf?=
 =?us-ascii?Q?29EO+Rzefubv53r9rFrAyHOMcWbj67FCirRKeMvCFstSZ0U6W69ROEaeQkVO?=
 =?us-ascii?Q?o1FTQ1E0EdDIoOfc9ZPJ2+utfkBywHGp4mD4THcxxJK7u9K+tYgRsd+g2b0y?=
 =?us-ascii?Q?fvtwLdWyBafMMUBBCo3bSIllOYsYEBXUfJ/DpFOoIQ8vPvA5f+B0yjE7+ubW?=
 =?us-ascii?Q?c0eWRmSrHmtkfSvLDeP44l5tvnK+9jDZJzmAARkUpJepTwGjBjQ+iQB8TIqY?=
 =?us-ascii?Q?DdhO8ViErO6FnJ0Hq1UPqyE7wo340XosYzpc9f+KEgk/ttOfODUKVVdTFbKK?=
 =?us-ascii?Q?EJ4WpFzQJJX5a3lASAMiMMaUYUJRrO96nhsRz3wYm44HyrNW1dpYx7vN085J?=
 =?us-ascii?Q?Qo9EP1vT8ghU0Azx+EybYKA65KgYqzDzqUoLBrSDbTwJqwLjtq1343e+SLk5?=
 =?us-ascii?Q?FprV8CvqGKyTeum3fdAzto2zx4mqbvX3/fJHzSk9Vpncu8AvSQchC+Yp1I4J?=
 =?us-ascii?Q?lrF7RLtESrQSkPYSUE4sJSrtt9rb1K8q3LUn6w8Cd2fGUObsrdnpCg23rbJU?=
 =?us-ascii?Q?V5NORjjJXeERnbg0UgBhRMUCaHEt7mHzO+ItrXt3DvYtFgsigVSo5iO1m3vu?=
 =?us-ascii?Q?tKOh5b+Urr6aMf94sBYENMLG2jSUq5KIH8LWeq4c+9QTGBKxFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(36860700010)(1800799021)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:40:58.8299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 323166b2-9fef-4c9a-51da-08dc9076375e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732

The amd-pstate-epp driver has been implemented and resolves the
performance drop issue seen in passive mode for shared memory type
CPPC systems. Users who enable the active mode driver will not
experience a performance drop compared to the passive mode driver.
Therefore, the EPP driver should be loaded by default for shared
memory type CPPC system to get better performance.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cb750ef305fe..0f8ffbc0dc2a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -86,15 +86,6 @@ struct quirk_entry {
 	u32 lowest_freq;
 };
 
-/*
- * TODO: We need more time to fine tune processors with shared memory solution
- * with community together.
- *
- * There are some performance drops on the CPU benchmarks which reports from
- * Suse. We are co-working with them to fine tune the shared memory solution. So
- * we disable it by default to go acpi-cpufreq on these processors and add a
- * module parameter to be able to enable it manually for debugging.
- */
 static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
@@ -1815,11 +1806,9 @@ static int __init amd_pstate_init(void)
 		/* Disable on the following configs by default:
 		 * 1. Undefined platforms
 		 * 2. Server platforms
-		 * 3. Shared memory designs
 		 */
 		if (amd_pstate_acpi_pm_profile_undefined() ||
-		    amd_pstate_acpi_pm_profile_server() ||
-		    !cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		    amd_pstate_acpi_pm_profile_server()) {
 			pr_info("driver load is disabled, boot with specific mode to enable this\n");
 			return -ENODEV;
 		}
-- 
2.34.1


