Return-Path: <linux-pm+bounces-30440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFCAFE536
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6FB486AC5
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820FB28BA9F;
	Wed,  9 Jul 2025 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hyok4LuO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BED28BA92;
	Wed,  9 Jul 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055547; cv=fail; b=uTj5nUYU67SLW4C9mytjQu9RayOdyWJGi5GotSEJRiINcL1hRaTVRrgkJe5gWTsck67ZcROagwjVYHle6BPsB/kUNYDgQ/FYjq9UUv1T0uW3K2KjpQEbPiLAR4IEfYOG/LS6Hu3RbbiiKtGis2tjDChrpqrLEidc8QSoUc/4XOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055547; c=relaxed/simple;
	bh=TV/azgZM0123VmrHV/+ukjn1LiBjTeWNWme6wukM2YU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlD0C9UfinBr4pEOhlN0qksJzBy5bedlUKEwK5t91gTB7QrRlD8GfbIAtNIIhJxi+rmxjj/oloArNcefaPX3xYPSSE+G2osjjswHsdxFNo4QBYwPI7BQrqu3chNb4axHGT1O5W+CJIMkV8wkS1O0hy0Q023Z5Uww2X3SVmTtx5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hyok4LuO; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzBgrAgzGcGvEq2MkIC13Bcayai8FcD74+cfLnwKh8HUAnyTpzHmlRQV9JANnKskYG19OgfzkXvnXbtUi/4ALLVy/qCd4GFMIgbHTLfuD3YNLcrkQAe4F0DE0KOCcovPmXwtgWSiv5i8s6wDwZOCIhIYROupwf2OomBnXQqyOwUY3rnf955kuGyI88cqXSHd3LgUCYhoCb1De05S9wS6Psm9QDFUE49w59+3gHF/KD1RsHGrZcsr/Hn1F5dWqVwYpVIEtJmHPm4CAElVodBKZRxaa/WwLcyqH4C3l4sAUieamJOjpbSVqzPh1cnlL1SqpARHmpOLMnlPWebrn9T+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoHTEnZKNxQwWmck8BFskTfr9fp6tbIxa6dAuUSSrZE=;
 b=LlEVCCXSdPCupyO6mXkTgptWibijrRqAdwnkg2tNTzQSBO698oOnKO+6im5gJfDINU/NtJOCzjqGATLeItyDr22HcQ/xDI+kk0B+1zmL0+yYGl4hJXruBnAfDWrGlTngY0g8NLfhY1SbFhAfGJuvVesNThoDGEoZsqx2PuS1qWs8rpn/C0BrGZmgoaOW3vckBGtzkYANM2ns8BLwupDGYitEKD+CvE31Box8BPpThjLDvWEwVdFEy0xJ3NGs6bGwW9/iJpmGinPxssq3altuYyRD1ni0XF/9hzI94FU9CivB1wWBkSOx30Gi6BXdeXRH3gGrwXv5X2AtLY7NkOIfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoHTEnZKNxQwWmck8BFskTfr9fp6tbIxa6dAuUSSrZE=;
 b=Hyok4LuODfYrbsCC251hEMegyxDtXjrKQQ1x3/eLbaJYM3KtqPNNN3E/SrtECxjEjsmh3yHAEVYdp028trqkFdpnMm0f4LCO2zXMZuYuAIIUbAS5NnayNicrctcYP5zK6WjDKFAPGgi8C/1ffqhUuYS1CDGgfQeuIRzNwHaTExM=
Received: from SA0PR11CA0143.namprd11.prod.outlook.com (2603:10b6:806:131::28)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 10:05:42 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::2a) by SA0PR11CA0143.outlook.office365.com
 (2603:10b6:806:131::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 10:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 10:05:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 05:05:41 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Jul 2025 05:05:36 -0500
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
Subject: [PATCH v5 2/5] drm/amdgpu: move GTT to shmem after eviction for hibernation
Date: Wed, 9 Jul 2025 18:05:09 +0800
Message-ID: <20250709100512.3762063-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250709100512.3762063-1-guoqing.zhang@amd.com>
References: <20250709100512.3762063-1-guoqing.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: bf780416-6e98-4da4-4496-08ddbed02a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGRYbXhzWThFREVQYkk3ZGVaeWJyc3p1ZXIrc3NBM0FVeE5sZUJaV0hWVGF3?=
 =?utf-8?B?OTlzWHJvcmhrR1FXeUVyUWdNaGtWQWg1cXcyb1FUNEw5Q0Q5MWFrR1ZmL1pV?=
 =?utf-8?B?Tmt0RHNQM0VtcjdSK1U5SXI4RXhNcEtlVXRBSW4wRVQrdUtxQ25pSG8ybFVl?=
 =?utf-8?B?V2FVRmlBWXg5K2JGUG51Y0xlMlZsc3VVeEdzSFpnd0NLNXN4TG0xVXF2THpZ?=
 =?utf-8?B?bEZYVmhRelpSK1g4UUZNRW82bkFQSTFNS1J1NEE0NXV5UnZ2U3hGajFqL1Qv?=
 =?utf-8?B?OWRIRVpYY2JSamJUbGNoNTczckhFanBsNzJhVER3R1NKOWVqWEg4Nmk5T3lj?=
 =?utf-8?B?NmMxZEFjZjkxU0daUkRLNkwydFpCelNlcjh1ZmZMeUMyUlo1djcyMm9lWGxz?=
 =?utf-8?B?SG1rYVkwbTJFcC9sUWExSVd0aGpBaVdIRUg2dlFFWU16WFV1Ulp0YWJRdVJo?=
 =?utf-8?B?eTAxcENucForcHAxeXdQa1k3MjI3ZlhHM29sOS9ROW5BTG9DL0hTb3RuUExO?=
 =?utf-8?B?Uzc2MGc1cVBpenRSL05sU2h5SXZiN0U1d3NlV1BtR1h2WmE3NnNmb2c0SWVD?=
 =?utf-8?B?ME1NQzQvc2pqWDVDZHAxSmUzVWozM1lzZklmZW1SSnlWbmtJMWd1bStwcW9l?=
 =?utf-8?B?Nk1DYm1BYytNaVhqVGVKMzQxZUVYNHFQUyt6bzJEcXFFVytyNU0wZ0ZZSFVt?=
 =?utf-8?B?Slk0ODNsaVJqeHZCNXZnU2hCRzFNR0pmeHpYTUFkQ0kzZ3l2QnVQa3d2TzRO?=
 =?utf-8?B?enFzOHl6SFhHbGhyNFZCaTBDUUlPemovNXpJaDR6dVdxMlM0NWpHV2lNWkZR?=
 =?utf-8?B?SWVvakVSU2Noa1RVK3NhSEhMeFROL2JZblZJMDlvODhKa1B4ZlZmenpEbC8x?=
 =?utf-8?B?WExWaHMzQVFURTI0Tjl4Y0dSUXovb3dYbDYwZ3FibE52RFNYMWZPZ3NEKzJN?=
 =?utf-8?B?RmROOFBWdFV0ODFMTnVHMEtuRkpGOTFVYjQvMXMySm1sQ3ZtaWF6THRrNFd6?=
 =?utf-8?B?ZWRNMHpycElZV2s2ZjVqbWVicTh2SnhOUmUwUzcraWx1eVQ1WWVDNjZjZDN1?=
 =?utf-8?B?ZlRySEs5eEptdTZoZmY0d0ZQbVBDanFaUk54ejlQMnF0VWhEMDFvaFNsWkJl?=
 =?utf-8?B?OC95QkFNYSt5WFZ1NlFJK3AvMDdaQXNxL1VVeUtIRE5WeFhCK0FxYnlod2JJ?=
 =?utf-8?B?Mk1wa1luWmRqamlJU0hXTDF1eWxzOGo2dU9HdlBpU0xjV1gwdFhHTnJBMUJ5?=
 =?utf-8?B?L3BNQ3llN2RxQWtLZFoxbTcvVEpnL3VTZmN5cS9MTDFtZFE3RWF2QVdRaUhX?=
 =?utf-8?B?MGJkRVBTR2ZCd3d5OVF1aFRiS292dnczdjNRamEzbzhsVlZ6a2pGbU9RcG9B?=
 =?utf-8?B?QXp0bStpb1ZuRFRPSDREK29vZ01jZW4rNE1USElFcklraGxYM3NGZVVCU1Jr?=
 =?utf-8?B?TnJXYzhMM3MxK0h0ZVZmL2ROK0NrYU1KSGtsUDVyYTlQbVdyN1l4T2F4c09D?=
 =?utf-8?B?bHQ3cXFrYzEzeFNXS2tlQ2dEZ0U5UEd6ektId1FTQTVCckIvUGdZWit0UGt4?=
 =?utf-8?B?TFJYTmVXbmREbGxKK3I5NGQzR0pidFEwWHByZUl6d2VtMGtmK2p4NldSbm1B?=
 =?utf-8?B?T0VObzhZN0pPY2s5THZzOS9UL252YmR5TGhaM2pJRGUreEFQdkJlVk11V0lM?=
 =?utf-8?B?Qkhha2tBME9wejJYdndFRzUzNno2MGlDbUFZRmxMeW5SRWxqSldjZDZUOEtM?=
 =?utf-8?B?azZTbWg3cUNyQ1FybXdpaTJBL1UxcUQ0aHZmdG9UWHJxdGp2N3ZFNU90Ukpz?=
 =?utf-8?B?SGN4Ui9hdHJlcEtnMWs4NElHd3BMQld1ZCtmSEQyL3Vja0ZBQnVsTGYvWGpi?=
 =?utf-8?B?YzRIcGRXdllabkFUNHZzMUNlZm1DYjgzNmhTakRxeXI3WWdQL201VENsUm04?=
 =?utf-8?B?OWx2bkRsenJBbzVhK1hnUFdzWSt6N0dLWUZGL0hZNkpiTGJuU1VaQ3hZOG9v?=
 =?utf-8?B?eE1XTGxRanlRcVoxaGl4U2dSRzNySlFpYjl5SWl0cEluNVpMb2ZkNnNjWFA0?=
 =?utf-8?B?Ujl4d21uSWIrSkpENjgvSlJWMkllU3BkMHZqdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 10:05:42.5965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf780416-6e98-4da4-4496-08ddbed02a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938

When hibernate with data center dGPUs, huge number of VRAM BOs evicted
to GTT and takes too much system memory. This will cause hibernation
fail due to insufficient memory for creating the hibernation image.

Move GTT BOs to shmem in KMD, then shmem to swap disk in kernel
hibernation code to make room for hibernation image.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 684d66bc0b5f..2f977fece08f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5021,8 +5021,16 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 		return 0;
 
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
-	if (ret)
+	if (ret) {
 		dev_warn(adev->dev, "evicting device resources failed\n");
+		return ret;
+	}
+
+	if (adev->in_s4) {
+		ret = ttm_device_prepare_hibernation(&adev->mman.bdev);
+		if (ret)
+			dev_err(adev->dev, "prepare hibernation failed, %d\n", ret);
+	}
 	return ret;
 }
 
-- 
2.43.5


