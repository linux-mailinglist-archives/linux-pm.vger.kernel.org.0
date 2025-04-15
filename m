Return-Path: <linux-pm+bounces-25436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E116A89678
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B2C3AC1CB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23728DF1E;
	Tue, 15 Apr 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OBrRe3ti"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915CE28DF09;
	Tue, 15 Apr 2025 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705454; cv=fail; b=jjRV/3rlj6Ksv8ydNS6uE/cE4m9wdXjhEZ/SP4ehETJaIg3KNFaFxENsD7sejze8oNWBWCM+FlMQgAv4/EcPI0CksjOGfTJwPgRanxqmS3P3488izPvfDrQvUAhKUsHiDQRs6w7amjFmVf2xZeWWXL3aSoWiiu9vEgumVsT97l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705454; c=relaxed/simple;
	bh=g7WutZjfVuc73BeulvKBySmoVCaNnv4qriimrQX+qpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AjOgcxqeAb2hLtL7OZ6L6ACtJKdpPGHvewDKXlohDnNKusur1i8OJNTPIiCGuqZ+2oLKVnv1Mji8VPmBXFdaa8FcfwABXSL5lQkfqLzRBsHXoRShos1xo/dj/LM2qwNnMEJOCUYxZUmQ+WC80b8gWTazVHUBqt5IP3HVFqvwEbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OBrRe3ti; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE/imdEsrUU2djBdLG7QLh9rPA9H6AW7IWLMqiSKvtpwF3OOtsQ8zqTTpVzF+DsGn6k7+fHi4tDg2EiYwFIGG09Mnmt5q+LA2MXDzPXNR69sQ2DF/nU5I702mkMEYjJ8TNkUiDxcn0YAYnftsQd9JVqwfelQqkBisPqPcDQxE/B6+FGASMQ0Zpljf/2DekN0/TPL9QXnVhGwxRFGR6lPwOd6QlFjU9CUHOw9gFSZHj05gNFRcJ6im7zc0dlGdq6Qjv7WbvVUWJG5j0cLL+73Cf9+SYQuk5ijg7+4eIzn7Ypjtavx5K4TLaHyysT2Wi3sScGeJSW4RdjotWYjFffsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQR0nxA3P0cWsm0lRX9ACAgSnHQI3c8Vh/MOpTMRNjU=;
 b=tUgXRUtkC1fFa96msZJFDArwRU0oRmp7EWakCta6MjqTPFmowObXYzv13X0jiYXNCNtK4K8k6eEbDnsbZz6AivHA+AfCCwGluOV+Hq2oMQKUFspGhfD4SoSrLT/GQSH32BPLh6KkTL5/U+4+2L8ZlC4NPGbK3eUpb2xY7mlFjQ0TQWxr8s7SZTL18iwtd6ALqL7oF8C58o3hAyoQnnGlAdf1AoE227pW5oOXY53FdwXvqnYxJXN/pUGbuEHWu6X0x+YR1eaHXTpCgKH40fj6Yj9X9aKDVF0euZvfU+xh0WD0eVOYFvVnXpRgAr1ItDnzJAmCop9JheJajP+JwC57Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQR0nxA3P0cWsm0lRX9ACAgSnHQI3c8Vh/MOpTMRNjU=;
 b=OBrRe3tiHUHAa8Pp9rPpJ9IogQwPZq2sZKTQX4S+G0cEh82DuTC9iwI69asPRyn8AXVLZJMx1ikU02+3fnkJe58VoMRMI6FktV2FyaoAJqBqXPIqUtpL0IVlq2HUDb1jT8l0AdqKPi7WL2/mYTHa30s7v1qJkjiZnW86cvuUd/U=
Received: from BN8PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:d4::29)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 08:24:08 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::1) by BN8PR04CA0055.outlook.office365.com
 (2603:10b6:408:d4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 08:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 08:24:08 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 03:24:05 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH] cpufreq/amd-pstate: Move max_perf limiting in amd_pstate_update
Date: Tue, 15 Apr 2025 08:23:09 +0000
Message-ID: <20250415082308.3341-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 885efb35-15e8-418c-c797-08dd7bf6e4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D70VqllrqCX1WO458Z3wvibptlQ6a81zwmanN7/ZcJK0kpD1k+5GZ6EK7Evj?=
 =?us-ascii?Q?llm5WWjgdShjrQIVJz0mrCDWER6+Dsm95uCxPrnqbnHeqhaOqJTsCQu5N2cw?=
 =?us-ascii?Q?bojJbfA3ygqhxY6lKXNiU5sPxmCB9KSmjOGCr9o7X9dLP477CBSSl0HwPeE9?=
 =?us-ascii?Q?zlCvbJMQzTzI5CIqTr9o0gWy73CUfV5+YUuDFyle/xRzuMn5sg5h2Y+e7By8?=
 =?us-ascii?Q?D8GSMsY9T9C0RWpWqhYOJDW+fmfZUJZCg7lbQa4p7YECtGogfjmgKIvWiMnO?=
 =?us-ascii?Q?aafC/fVpbfDoSDlDz7ocW+Jj6L7qFgZz0ETNI0/rrs1oXqMTluIwZHPiI7ZY?=
 =?us-ascii?Q?67h22Yx8uYnA4OmlK9ZfU469t8T9c0BS7L/y2QLIhyzYxTTc7NaSuVJzYF6m?=
 =?us-ascii?Q?gekd1a57RfM+/yUlSSwYxVd4mn7qtv8fwRoD4lPhdZNLU7OnVOFVnRM8pXcw?=
 =?us-ascii?Q?9kf2QeUhv08xN1LWxN5oimuXt5TXnfSyBWmt0sRQpA/rMlUmQcs/Fiwme3CP?=
 =?us-ascii?Q?9SUdHYbBDDYrHLt2hVSzw7VtzvLovNg/7YSBy3jeCEZ+tmj8t/j2JiPDpRWN?=
 =?us-ascii?Q?TTzKv3oo8ug/6EszF5sazxgyjm2/LEe/kHLVMcAcxRAD0hS1SZ4lBMRRqP4B?=
 =?us-ascii?Q?4FxyqNV69RYDI3GJh7dGXGLlVHjtkRpNfHGWxOcoBRJijstk+AovL63bQXIX?=
 =?us-ascii?Q?FtHrOXhujUIhtWnm1xr4EF9r5819bt1RsiPF6Y6bxlnWJUFuP7bCtd0bXjqz?=
 =?us-ascii?Q?9r/+CcAU/x/ncsal9jft064buIrmclkvv8JKJ06+2waeFrDcEwv7X3lOybMY?=
 =?us-ascii?Q?dYtx+tAvsNglhFVKARXFTDDnpkZBFXwTt5ZQAu5H5QfynPgSFy02/dDwiOww?=
 =?us-ascii?Q?d104rWl/lj8eUiuezH5/y3CGde7oVbYEviExqYWAT1qbVPqBmQemijn0mMAs?=
 =?us-ascii?Q?0RFLwkwy+etrIiscs9auaPrtfJhgCfdmaI2r5BsdnbrddwJtcEc6UoidLBtL?=
 =?us-ascii?Q?bc5L7NpDNZe1c1pCQY1Tn6z65F85ZLF7WMutUkt0re7NMXu8DgKo8l8bGIZb?=
 =?us-ascii?Q?Qeipq86d75Gzb8ZE0A4GdEpX9VnKe2+9HU1z2dNfUIP1NB7Q0ru78/TtVKCB?=
 =?us-ascii?Q?DBDmqT32AzgJPcDezJ901/IL1ixmRtCEIjB23STTUNuq7Ts4LmBIw/4IJQ+T?=
 =?us-ascii?Q?lirQZBuUv4UY9baq39ospS2Tb6a4V1Y7dfbuS3G5fNTsk2wW+RYDOzEmz5lb?=
 =?us-ascii?Q?A+NCleUMI9LTYLNFsKFsvWtxSglnE9MVrwYtFU7moIFvZxHAAlC3dBx+KTIl?=
 =?us-ascii?Q?87QpOz8G3fEsSXdZX18RCxwguhf4GHLl3uGSsDYC3v+QZeYbNJB2Sgjklz/x?=
 =?us-ascii?Q?L/VygzAToT6XHwzaiJDzoislU917WOIvphGt0dKKMaqLY/6rp6OswFJqkMnJ?=
 =?us-ascii?Q?iPh6ExeLhg4WpdPB48e9rJ2ghxkqXAS0dmaL7aQctGbkISSkFoAKGDWFA/vL?=
 =?us-ascii?Q?0Ew1x04lWRbsxuY7FJh/E7DYhyTNRtxitTMy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:24:08.5324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885efb35-15e8-418c-c797-08dd7bf6e4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273

Move up the max_perf limiting, so that we clamp the des_perf with the
updated max_perf.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c54c031939c8..c29840ba3b30 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -554,6 +554,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 	if (!policy)
 		return;
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!cpudata->boost_supported)
+		max_perf = min_t(u8, perf.nominal_perf, max_perf);
+
 	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
 
 	policy->cur = perf_to_freq(perf, cpudata->nominal_freq, des_perf);
@@ -563,10 +567,6 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 		des_perf = 0;
 	}
 
-	/* limit the max perf when core performance boost feature is disabled */
-	if (!cpudata->boost_supported)
-		max_perf = min_t(u8, perf.nominal_perf, max_perf);
-
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
 			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
-- 
2.34.1


