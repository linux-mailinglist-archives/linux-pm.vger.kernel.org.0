Return-Path: <linux-pm+bounces-30442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D2AFE52A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FDF1C4595C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2C28C860;
	Wed,  9 Jul 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXHn5M0Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524D28C84B;
	Wed,  9 Jul 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055560; cv=fail; b=TcnNM1U9vjwAf91CIxqxmoUu2lO7S1WeSnCgIxR1d+R0Z4cR9su/bLeXaDyML/eYgX39p/RPpCeOh4L3guW5L1hRqjO0m/qtfwaSysBTnfn1QPtt51uDR0LPd2HEtVWaFrCWV/N+FZSxKoCtMdqpusvEksd4y/Ao9jQgnkFu0bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055560; c=relaxed/simple;
	bh=lio1ueVqjV8dkx9kbpWZFyBOlP87gq4oIXfuOcV7vmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwEfhKuFhERW7sfb/ORkNze73Z2nOmdNLfIQy9F+bINFWGcU8d+bcffl1+ZaqH9wjaQXnz80ZT27H3xm2MBT5E3/sT/7FUKG6/LW3/A1SMYtOYayIVRq5421ox8emzx7uaRGKVtblsWOahEJui4/FOTg61OJFU8Fmjf0EZA7aIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SXHn5M0Q; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPC5cTY9leLNOroWtcesPeM0LWhSrRz9znYXOa777Kk3QpQqD9I+S8L1woEtiVsX7PegsJi3pI0mr4bkxjdiOwpD397PQd3nN+4y8AkJF4CNOhGkMaXElatkb+IMI+NfC5L9zAODkW30AmQ1YOBN60KXX+6i/aJ+DRRRLnoOsCBdC4VnNeRC/uhl7hkfGqLgM62RakQFApUtJDsyL9re/gcJqrJtdSgAaJn2NJgRxu4nTHf34Dat8Fbd83bsoatcXv85CPHUugky17nkH/hdTf6mDQS7kuCoayXpuhDzECuatoZWxyIPvHxBNF1TN/39UcCZbTRTAra2sTKsc5x4Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iP/0nTiOz+E/6L1nZdQagKM06XQp/ezk7nDDPYQ9J0=;
 b=aGXaxZo9PwpLY1uEjF7Z6N/lALZ6U/p1BRhLExhZZZmGFcp6VL8kYHkDxK77+4IMfFOqgYhFo4+P9s49iBo34TLAJAyyTsSigw9h2mfSyCGtzu86bUKcDE8LLBwO9RsMDAZ5H75rdZDmmSUHFBZAk65JAk6JG0f7qM6PKHgkTQK5J5e9IAL6x+X8hn0uLFGSQYZGxKLTtrFDKbuv3+HH7AY04fCRiepAOGEnY3qDxi/7kdltSO1toxcSA+OF4G3HOpscCNo06Mk7/4R0vFWKM7mtyCq/D0D9Qc6zecfeoFniBjohDr4yoxpp66QnrMiCs3eyQESDytImpG0/2czGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iP/0nTiOz+E/6L1nZdQagKM06XQp/ezk7nDDPYQ9J0=;
 b=SXHn5M0QVKAfAnuOdHcEfTyigwKLi3l0y/sZGQsmxbmbVOgP5r3kKyElj8s41yov5REtNqUCEZCuktit5ZmiM7AdmKMZO1LlBmib8ub/j2fhnBQO6+T6gOVorc09SqwW6LeAPb/YNjdgTfEUujr6Z+/xefusEec/wcvRy1AkCWc=
Received: from SA1P222CA0091.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::11)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 10:05:54 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::fe) by SA1P222CA0091.outlook.office365.com
 (2603:10b6:806:35e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 10:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 10:05:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 05:05:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 05:05:52 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Jul 2025 05:05:47 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@kernel.org>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ray.huang@amd.com>, <matthew.auld@intel.com>,
	<matthew.brost@intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>
CC: <mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <victor.zhao@amd.com>,
	<haijun.chang@amd.com>, <Qing.Ma@amd.com>, <Owen.Zhang2@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Samuel
 Zhang" <guoqing.zhang@amd.com>
Subject: [PATCH v5 4/5] PM: hibernate: add new api pm_hibernate_is_recovering()
Date: Wed, 9 Jul 2025 18:05:11 +0800
Message-ID: <20250709100512.3762063-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250709100512.3762063-1-guoqing.zhang@amd.com>
References: <20250709100512.3762063-1-guoqing.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acddbca-c08a-422f-5d87-08ddbed03102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxZ/xyDdB+6h/0+Bnljo2devjKOOvizoHli8d3SeN2R7mHd5RNX3Jfaw1Y6h?=
 =?us-ascii?Q?uKLjRy2OPwVe5SML5Vl0sHRIESGNJwX1gT5tte0WueDNeReser6NIz2QZ6sv?=
 =?us-ascii?Q?w18TNgg1xdF4QmzyvcQdS3kqdtFsXUWFAr5f29BjC3hEzBstUXKixw+1+SsI?=
 =?us-ascii?Q?J5OT06iJ1z6pMh8ulT+JyjDj0sdHWXbf+buPQEA6WPGbzmxLiW0fj/Wt/1I1?=
 =?us-ascii?Q?buytfUy29tryLga/RDJk/KjlkFyo6TUdM4QM/HRzlvZEVQ23ls5Rcun4+/OG?=
 =?us-ascii?Q?Sxqb2FeQleP59U6GMni+J+6nE+Yc7ZT8Iird5HJpv6mrtPe4BNuMyut1xFHe?=
 =?us-ascii?Q?KBgikauewLy8Mw0EhywWmBeO6u4aqTjTrx9rz9wZJHJEKzxSaIIKgS8FVa6g?=
 =?us-ascii?Q?LdWW0YMwoJ+vkUW4K3Le3cNfyVwNGteA5rXhKTrj3Kqzj4GaRmRwmFVl3dRs?=
 =?us-ascii?Q?PS6AmI1twq28PVJ9ElDvz59WRAX/+5JC9UNKf+WqadviYX6vbPlL8azjCZZ1?=
 =?us-ascii?Q?rhKZXC9W3H6Az03Zo8l8kihFwoFE+uArZdXQ0VNEejyMfFmmImkEC8DxhdR7?=
 =?us-ascii?Q?JlcWGk5KMTe+PWuTkzuBFnkBdhWIYR+lE5f5T3mDsQbikleLXV4K4+tMjAPm?=
 =?us-ascii?Q?lJRhCntY2aZaVxkvGWgZ0YDnKuYcysBsxzgCm9sBphdk0OaBsWZWjv0FVduR?=
 =?us-ascii?Q?mCUzHkGAN6lc6ON4cON4O4iYPrDt2sObBHzePg8B7ZFvwYtnn7rz0AlEv1z4?=
 =?us-ascii?Q?/IGwX2yUZ3H/Epa1vmEgOV2YJm/+wb3Ng04K/BVA7c0RCUhivy+gbt+D1p35?=
 =?us-ascii?Q?QPF83xgfIWQBLTMAGNrKirc3FSeHSEP3cTD3pdZPNAp9J3m5sRaFn471xuZB?=
 =?us-ascii?Q?MsQvr50d+meZxBfd9uLpZNoAmUjhFWFtQvtaVr2IHEQZAv2pwkvH7+hBWEZv?=
 =?us-ascii?Q?l9r7Jzjb2b3+XSmQW2Su7vtRgvwRVQhwci3zrCWXloQVTruU1w/ixbku8q9W?=
 =?us-ascii?Q?MDpA9wN251lugv6LDlXbpeoAiiok/qyzgC1EPP2nrP32/YrMgO9BJ9sWoFlC?=
 =?us-ascii?Q?/27UOk13GC0NZ9w16gHVReTa1o70UMUgXnJ7JLbrYnCUXwT8YJGCNy+2Mt32?=
 =?us-ascii?Q?/U1I1SfIypPMf5jnx0igfgRW5KIQWuuACKOIxJ6W8GPf04mFEQC92A+tQFqo?=
 =?us-ascii?Q?KbpGdKqbICUmGXUMjAPvdBJG8tVtrHF29mDDtNT/Hxk4h4ibZIYtGweu0day?=
 =?us-ascii?Q?9kj/ntQpEqp/dS04ukicnIXE61gwVe+qTPyuFXhoLSlCuZaeN248rzYKbu3A?=
 =?us-ascii?Q?LM2E8T0S2WJccp9niAOQxnYB70Juu2v4IPCJcboTmPdrT/XAP0r6z3ObuW6a?=
 =?us-ascii?Q?PotyEsSSp49tete3BRR46gM4/YFNy2rdIjVm9eBGcIyS/qy9laOO5g48OFP2?=
 =?us-ascii?Q?7XXv95KzqM+xGw6Ui7MJ2dtpOzkbOWDfYmSfEnTIadWVnxGbxqZtxOK9sPQZ?=
 =?us-ascii?Q?cClWmA1ADpnTSPkvyGh92PG8yhI2EzTGSW66AmaEefKWvvRekKJ2hYVq2Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:05:54.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acddbca-c08a-422f-5d87-08ddbed03102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802

dev_pm_ops.thaw() is called in following cases:
* normal case: after hibernation image has been created.
* error case 1: creation of a hibernation image has failed.
* error case 2: restoration from a hibernation image has failed.

For normal case, it is called mainly for resume storage devices for
saving the hibernation image. Other devices that are not involved
in the image saving do not need to resume the device. But since there's
no api to know which case thaw() is called, device drivers can't
conditionally resume device in thaw().

The new pm_hibernate_is_recovering() is such a api to query if thaw() is
called in normal case.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/base/power/main.c | 14 ++++++++++++++
 include/linux/pm.h        |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 40e1d8d8a589..ff78cf96f795 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -63,6 +63,20 @@ static LIST_HEAD(dpm_noirq_list);
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
 
+/**
+ * pm_hibernate_is_recovering - if recovering from hibernate due to error.
+ *
+ * Used to query if dev_pm_ops.thaw() is called for normal hibernation case or
+ * recovering from some error.
+ *
+ * Return: true for error case, false for normal case.
+ */
+bool pm_hibernate_is_recovering(void)
+{
+	return pm_transition.event == PM_EVENT_RECOVER;
+}
+EXPORT_SYMBOL_GPL(pm_hibernate_is_recovering);
+
 static int async_error;
 
 static const char *pm_verb(int event)
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 78855d794342..f54a803f2afb 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -657,6 +657,8 @@ struct pm_subsys_data {
 #define DPM_FLAG_SMART_SUSPEND		BIT(2)
 #define DPM_FLAG_MAY_SKIP_RESUME	BIT(3)
 
+bool pm_hibernate_is_recovering(void);
+
 struct dev_pm_info {
 	pm_message_t		power_state;
 	bool			can_wakeup:1;
-- 
2.43.5


