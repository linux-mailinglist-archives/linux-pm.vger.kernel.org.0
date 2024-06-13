Return-Path: <linux-pm+bounces-9057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6842F906504
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1239D286564
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4713CA99;
	Thu, 13 Jun 2024 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l4FWJb1h"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5E13C9AE;
	Thu, 13 Jun 2024 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263571; cv=fail; b=EgetVs9EY8USrDRu8VkNnDzTZG63yeHJOaBq0CDTTL8F/x9sUgG5fhgcjtUiq/IMEAPXMptZteRBPjXiSBq7OzvkUMdO1b0haseE43afyDTKNW27Jhysqs4b4vb7tUOL0Tvm4YJO4S/NgbyswtjpbDDCkFQ8nIUMu36WHNZwUPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263571; c=relaxed/simple;
	bh=C4p2sKZdGRylYCgyqAJR+AyPOjBO2/pXljtXbG+zUuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORu84qpn6yVGyfr7C7CyC9FhHZ70UPAEKLj79/BrVekgtT9K1/FoA6YCOjjn81AD57Z8H3dy8BjkJS1+NgmeyMJNndCipMJS8Y+GEy7PHMibnmWLr7pEIchMniXozGoyilZnmVv5QCXTjcfAJGL4rO+S78aduH/IumbgST89Lns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l4FWJb1h; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5JudhQsbp/LguyJp65u3vhcuf66dXUU4n849Noas3+iwyec0+mNTZCdVhL8KkFytb1yY5E7/T9nENsS0ZoKVsOufxg8yhMrd3h88xuu3jdGynCoruul4BKdmmvPG7P+iZNfgmBiGp4HIC0dzYuwk44haerY8owG1vTB0fQXLQk/xCmNMuCur/dY/JvsDE62nDzEGSiTujelRra8sT3IWP+QN6YGialmQv1QjZpkvrUNC6jd9TyReZcBxOaAJ99+dEg+G/H0oAC9146H9qJ5QnycBBTinNXRNcIChDcvXoQCs22jI+5P0zWW3sQT41Hx++etQQxwmSfozyx2nKTt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqzLW2F6MFLyBn7JQVf8j5zr1FG2UBh8bVqCrKBuyes=;
 b=lrEUofuSoyDn9VPjWOp9yR9+5R7CwS+MecPvhWojHL1jsbFHhZF9NjMLz61RxYiqbKhu9jqfVCm9c81/AuLbZqul4Okq2VRbUlnWMWn1DrgzPlqjJu2UeZnWaPLLYznjcfIPHWBT7UpwnGyoCa39qv97am8vt878T15l5KBY/QSREO6GyBBTiGZ34YgjsQc7vGAm8mtXxCQJNdXVCWz/nN7j4ULMewPsBQFIA8rOj3ZY5IVrsrvzdo5m+ru135v9dVp/wzfGUgVK5GKX4N8VzPeOhEtBy+24kvjrqlmIXUDj2ffL67O1yJeIY9VmNU+F7LoEjQVcHMDIvn5EaeUc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqzLW2F6MFLyBn7JQVf8j5zr1FG2UBh8bVqCrKBuyes=;
 b=l4FWJb1h7mHrRN+3vjqCoUaS2Z/IG2BOQsbYG2SevIi1BetaXa5ZYqZlZmrMstC+ika35bNcRVxUndYfBybwksDVrhuL9yvmKI6YwnrICF250dzyCzxc9zz9JdsuFeyf7wJMPkKBGrgDETU2k4JD+FXjje9mXInL2U0/I3m1+4U=
Received: from BL1PR13CA0085.namprd13.prod.outlook.com (2603:10b6:208:2b8::30)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 07:26:07 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e2) by BL1PR13CA0085.outlook.office365.com
 (2603:10b6:208:2b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Thu, 13 Jun 2024 07:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 07:26:06 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 02:26:02 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <Mario.Limonciello@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
	<Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 8/9] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Thu, 13 Jun 2024 15:25:20 +0800
Message-ID: <deeab069d0aeed0d221a33345044f9faefbdd6f2.1718262992.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718262992.git.perry.yuan@amd.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e8edc4-b44f-4771-4787-08dc8b7a16ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|82310400020|1800799018|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RX6y4z2BTBJrTB2Sch135OXStdyMc7CQZAv/IKsnjAqyS85sc8dPNN/hUG04?=
 =?us-ascii?Q?4FGCsf/CRqyn+CWunh1N9q23Cj1TLW+ZXAQ7jAP9TCK3NL74Wr4h+F2IPWtP?=
 =?us-ascii?Q?3kpAz14zffBQxJvOqrrewLj4/KSwp9GVuTszJaFylpDh00LnqOoTs/erH6Iu?=
 =?us-ascii?Q?X50tpwaiznfPKBI66H2MHbODlPlcvhIpDnV9Y/WPI+6kRmqeKHI6y1Szg97a?=
 =?us-ascii?Q?sRTQxRpPD5c1rtWCRLAswE8xKwZUblOvvcngMIS/MsvnR4GyqJroWDuohOsH?=
 =?us-ascii?Q?POnATeKFVOm7mL7cG6amY2Ml9iGBRM3ULgNhCtiIZAY2m8uEL/fJcsCJIc3+?=
 =?us-ascii?Q?QM59Oi/B3nxECRLPYJrTh+cRHx6vHEijdcon4M7FP+qeg72jm5gMNahAe8ie?=
 =?us-ascii?Q?HPGDhuLaI8EzxgjJ3kiG6M26QUVNeRCP3o5eJkYGxF8DskY4EtLIH0rhWHYx?=
 =?us-ascii?Q?K/pMgPS7QXHqhE3f4vEgHBztkZpOJgO3ydnHJc/54q3uuzlkS3Q1He3QPfnB?=
 =?us-ascii?Q?tnOKSffbU9B8JbwZiLPzyCJG2x6XcYJ44svA/D9g7neduYPk1fHMtpZFOVQo?=
 =?us-ascii?Q?Xk/bDZY20nd7Kh9L1O/f2BuOQym9wRPn9db4KX7BlU/bWITq1YUfzn8UqM8O?=
 =?us-ascii?Q?AqHYF9bb1TszoxCVq/lcTE02tfdpO0wD1oXH7SAADve9evN/cU3sZckvppAt?=
 =?us-ascii?Q?sYHLDWcVVSSeOZSeKagVtmBJPEIUwWWyHorW8hH8jJrL/2PWBBPZcIfx4NN+?=
 =?us-ascii?Q?yGskTCCCipqST8Xhc64FxcJQLvmc1ewFjEZBzgBVFo1lMyG++eEbemT3A6Bj?=
 =?us-ascii?Q?RDywVkcBtfTefNcZXx4jPz6HLdmnt2C7h0HHwiANgjNaZNrtx1nqFSH1H1Pe?=
 =?us-ascii?Q?mqy6lxap8+i04mz0OloWg9qAoVulwmt+3be2edbs+zq3gfkLIo3Fcneb9gka?=
 =?us-ascii?Q?QxjrnI4gsW8asMumXxEFeMfuO8LGD5YLeVMm3JsIo8LEnPvEbP4i5cdvvqit?=
 =?us-ascii?Q?IASJMtI0fuq9ulnaGmnRHI80svaYo7UqlMkcsjGT2TKl9LU1lEUuR2XWXVWi?=
 =?us-ascii?Q?2RwxfgUlBuYPXG8HLoWd2FoocFQA2AIAZC3zpXvmcqynVG2vVZspDuBNAJFw?=
 =?us-ascii?Q?sv4PV+FoIK31UBOGHhNihFpN+jKdXD+fvUXsphqzfmazoF9JjlTfk67vUsWa?=
 =?us-ascii?Q?BapnVq5oG70uAe6ISPkwVT9OFcHf/TTys6cKtFH6w/J9gxSpGggKxySEO4p7?=
 =?us-ascii?Q?D7lmrar7d/+Vj0/6PtC1qJqiYRo7gRGQ37D9imbitigYHAoKXngGTC0DKTj5?=
 =?us-ascii?Q?8LdPRI1t9O0aGS06JubDn7Ho3B85MczpySKH6v8+aMgWOO6rFyX5+Kitxa5i?=
 =?us-ascii?Q?eUjH18PY8MBNWuYmBD9/qSEVGr4oSQyJJfxpInhmFERMuSFFpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230034)(376008)(82310400020)(1800799018)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 07:26:06.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e8edc4-b44f-4771-4787-08dc8b7a16ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which used for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1e0d101b020a..bcc0d9404c18 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -440,6 +440,16 @@ control its functionality at the system level.  They are located in the
         This attribute is read-only to check the state of preferred core set
         by the kernel parameter.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this attribute file which allows
+        user to change all cores frequency boosting state. It supports all amd-pstate modes.
+
+        "0" Disable Core Performance Boosting
+        "1" Enable  Core Performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


