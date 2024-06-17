Return-Path: <linux-pm+bounces-9285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58390A651
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98F828A3BD
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FD190041;
	Mon, 17 Jun 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vt6LIxYV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2E18FDCD;
	Mon, 17 Jun 2024 07:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607642; cv=fail; b=AuR2Ce7/tMQLyOIukM7DSLgpeHCv+XV99W623B+xkj3U4PolhOUU6xSpzGVGV06d8s4iOsMF36iMDd9p1i32MmrsPyDP+lfJsIUVZ82D9KFfTGoE1s/J33EwaUFTHg5ISWpuVtEauP0ZuNxMY0BHK4jNKLAnZjWLwpaUiq9Cb+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607642; c=relaxed/simple;
	bh=mt4v0XGv4Ex7oJevbf6wJNio6PTDlabbM6HbpkGLkz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYBSR1F549QGsTuP7wcgfCD6vXFZkMlGu5ltE7GLxN74QkzPzkrOJORWdRf+r7j127+I+a2q1+fR1NdlqgfOzF3BXapushyJFIoWGOAaPfbF9kHShMtrtdRfciOcx+HagwdIf4iZ+aMPXfIMo1JvOLARXnEXS1WU/z+9FR28eHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vt6LIxYV; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0QjZtgw0Q0TGzPD3emVEcd80cx85OxJyAY2wb8G88aGup4WaqfEqmL6M0GJlsBFRHNYJc2RkwVTJtvebdiEjFY4x/c+NORwGxt2MMJBExYVWZoWqiOJtPxIL32K7v7lajvltxrAl4lHdZsH1LuAqjybR2fwY/TViCIZwx158bbhQbAySqSC+cAAnqYPZlmT2OiaPYW9GaDFiNGdWVZXZBVjkjZZ9XdBecHGZLDmFFZoh/wtLCga9Q9aEUHjGjXGkqvhMSJGArJ2StQiJCWRcHAmYCQwQ7rteEpvJuk4dnGkwGRIGlTb5iSWOUnbZ/d+nO9HH3Uq29SzSdJAKoosrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy9L/qcUirO3oZnP6+bFhiSq9MAQyttMUJbSdfiRTB8=;
 b=fhbhpHlBO34Gc0W3/DlW3X0xgc9DAiSBGUqwwsR9L+yjYJ6H81Z583l6QgjXjeAVN8satDuVAgDOfvDhDL6Hie8Ns5MMRFILScVVR9v9HarGDqlP1hP+xi4QluDd0B2wHkKmK/0IiaqvRhML8fbMjQiZEJGTq/TH2ipNs6RyXypoUyxmu+mVaUOEv3UvnkMcop+Ev8k0h2swJMVk3QotHbDuNF4oOKbSPoAzWz49QZaR9CXjMBmoIHABWuYt0wdTq4O4U3SA85O6TzfSHb1OFf1Chb45gwqitxPY30KcgEb9hgtALe5J49Ph7NehOLrfJsH07vJNZ6Q50icsXDI9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy9L/qcUirO3oZnP6+bFhiSq9MAQyttMUJbSdfiRTB8=;
 b=Vt6LIxYV/L+GxC6mSWOZ34skJvvSp2fYUxg9WaU7I+AToIN4i8zsQJwGCN1PiDsCzvoLdFuW98+MbRWeeaRA/d4ranrUnI0Dgi5CCzK3mGyF8QNf+15CKBdb8iwXshnQhtaFvNNq5Po9OizMI21Aiq50jC2Y/7iH0gE3ZaudkBg=
Received: from CH2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:610:4d::28)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 17 Jun
 2024 07:00:35 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::5f) by CH2PR19CA0018.outlook.office365.com
 (2603:10b6:610:4d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 07:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:00:34 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 02:00:31 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 06/11] Documentation: PM: amd-pstate: add guided mode to the Operation mode
Date: Mon, 17 Jun 2024 14:59:08 +0800
Message-ID: <24cdc45b7b167387d3abba116633a5ca2a169658.1718606975.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718606975.git.perry.yuan@amd.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 841fee8e-33d7-4d74-8dfe-08dc8e9b2f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?99eUzOyUFybRfc99j7vrQSbAJhZrYhCPAaaSDRg3ph3cc2eAkAoObjbGibPK?=
 =?us-ascii?Q?syqIFaRc8N1aGEgrWv6CYScjpRa+poWhJPY7HOB4SdMcLDSx3Rnr3TY4WRZu?=
 =?us-ascii?Q?uCrLhzUYT6NdQYVi3H6GScvNd0j7bVdHkoUxK9fpKCQQXWHyd39nhR/iliG3?=
 =?us-ascii?Q?EXpqhXHZYKwAbWsSe3TdiSbpjJHPwwuTCeo5onzEOlpspqsb9U16gas0mkm/?=
 =?us-ascii?Q?ge3J1/WNV8EEiJvqzs1mRxsAuXPE2kCPomgH/8aJWY0HU2VmnZjFV1NcpqAX?=
 =?us-ascii?Q?jcEBVnbkckM38zd3j5RZXRAmXJ1NrzVRyk71dc7FdMr2rs2fJsAWkRXk5Dp/?=
 =?us-ascii?Q?VcM2DfHPqhHlrwiLRN/2ikPEQSRl+KFIGWUHqSArqgsEG/Mr6BWzgE0unhY6?=
 =?us-ascii?Q?mM9ThQuQp2WejjGV6SUB6PErPimoG8bwBEh0pjD/Un3szQFGD9zZbYIYsE4h?=
 =?us-ascii?Q?v+PvlieOhMPSuuAGDPDr55SJd/D3pL1g/ggTOs+sy6rrWpGPdfgcwZiwhJ8T?=
 =?us-ascii?Q?zYWp1Nk68XrjDYDX9eNSRfoevH9uySGMbrygTaVeldGKGGjHiG1R6nUUzdTw?=
 =?us-ascii?Q?ihJt/w5ia4sbzh6FTq92qwkkl3aUUs5HWkP0+UwKnGsCilclKSDX0IhSM74L?=
 =?us-ascii?Q?5BqK4yLd5AWF+3t3xf0RZ3YEaicPSdjnD0FOR2zuGbbl9Wr/bhtMZK0AbTPG?=
 =?us-ascii?Q?fQO5MX4N3+ZY7bnqzkeMM3Tf6QPbuIIc3Tsywg1fw3njtJPc7aQVDu1sOH6P?=
 =?us-ascii?Q?VNCljSrdd6bFTXOMYgNyE2JV1CiUI+TbB6qrQ3VS+AS9wrgbSfFLkNMyY4Yg?=
 =?us-ascii?Q?b7OzvcvU8txL1t6x5lx2P2rjr7wyf/8D87h0Qa2UF9jrbA9G6o4o9ILk1nxv?=
 =?us-ascii?Q?r9UCK0N0U4qWV7NwWzfX/wxaKTXGAVbACX0LQgqH8jr3TF6ufIziYRkz+3OQ?=
 =?us-ascii?Q?QBiLFCORcxPA1D/E+26zd75XrEVHe3c8z7vFNiRIiLRN19Y4bOKPQbpUNLEV?=
 =?us-ascii?Q?y7duqpINDYpR+Ugm2AszgEqwi0sSyrt+WrDLA0+ashPPy5iCGBSQo1FckTrq?=
 =?us-ascii?Q?jM67UOcBnipXhrmEIs9NX8pF5H3zbVhq2slG3Pt5gGt49475z22W0vyOdiFx?=
 =?us-ascii?Q?rxcpmWzhT0lksUz+FRK4VHgGMoKQf4dSkcdKzg8WacH/Iwrhk4Z/UHy6Wmb+?=
 =?us-ascii?Q?11gJHAwxqKeHicpJfmI75l07knozkt5zdfJ0xvxByT062h2HEZ44T6+CZ8dc?=
 =?us-ascii?Q?aW4TIq3n5DFDfAdWdgMrC25PZFKXstwoyhP8bRaF1fav9LVUj6QcW+auOGPw?=
 =?us-ascii?Q?I3Xb9sniexyHDWHVX4Zi9yJYY8i2xnHeQT2ZDup3O706nP8XDaE5VSlvuWYS?=
 =?us-ascii?Q?cJPWMxd37tOjqEVQ+3N/Fk5ekcsZgCeHHL2uNx4eifs0z6Dj1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:00:34.6950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841fee8e-33d7-4d74-8dfe-08dc8e9b2f7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426

the guided mode is also supported, so the operation mode should include
that mode as well.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index ceeb073c9ada..3e2d085a6999 100644
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


