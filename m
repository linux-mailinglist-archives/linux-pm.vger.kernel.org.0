Return-Path: <linux-pm+bounces-30534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677AAFF9C1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 08:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680831C82DAA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 06:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA4288C0A;
	Thu, 10 Jul 2025 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P86Hg4AI"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702F28853C;
	Thu, 10 Jul 2025 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128625; cv=fail; b=Ul7B8WD7u1wNBwv5gg5cJrF8iL3eotq120ekljgn2sHNusMZyHpVy3/WOJ576prgFBo38e8Tm/ibnUSGTXC8M5fYPAUn0vJCaeSDeN38Tfp5WnZ3gHu1C9DeUlXnGcARN77qnxu4xzH51auEPU1a1JRJZeMNtMiJbLD/EVfol3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128625; c=relaxed/simple;
	bh=kwW9Oq/qVn6AANbiEj2Rnd9IDe0U59apBpcAiT03pCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJLWlKmwIi+C+7stifa7A8ifFlYK1vYoqSBjd7zlh5We43F/21FooExGechLXAskNH0Z7B+Lv0x+t+70m7vMVp9BfT3/sMft9EHbZwCgKXwu9SXUGFyiLEv4szaIZG9QCNFdrPIEeH/xeQite61InACTioXP7ru5Ugp0BctMdmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P86Hg4AI; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ6mJ4q5BjaxkbhiAdQA+c1feKIBXgf+ewZpoEhweicNKx0c9uXla+DwGLU2YtDVbTNSmHEtnS3WosjuVn9Ak7idzjD7f4KUvLQTDbtjIXJUW1igJMG3x0DjEFonHVvf68gUmbHX+gy1tpxtiI6lhrnMuDet567b+XKigiNUfTAlbUOMTPl6VUc8igmQQCZAd/NVlF6ZtEIei7D2mBLTwR1dPUrFdLdZm4AogGg2Cw9DL0zfAONB5VCs2gU6mU3wsGpdpUrArvT+oNJ3CGzoioqvPEtMsqe2k0+ST7QxWLN6K3PKIRG/teZGZ++K4Ekrj8M9wv2wBFlhok6DSKsFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru8LYGxvsrYd2i9KjHBkpvm+vgtJ3+RRX0zEPxvxteQ=;
 b=ZRZ/8XGEapzKMlDmhDLlfUF16i1o79fAfAYcyCQZIamIwZ4T10i7iwRMY6e9chlePJP1WuPn8tbWzqX4j83pORf7cuc6J20f6TaMa+gv7SwuPn1afJHyqnMqSye7TZ30AIdIbmyAHorZAhMDX/s99XKUkgL/8NgLekXTmsazJGmGq7XSUdvj3+MvWcNRjBGzgkoUkF6ys0kkzuMWhrBMg1rfY7gu0t8lfJ19lpBFAvqZ/CcdFYqcHn3lLqTdqdjVSfEEL99l/eOKKc30XUa2oYiWzh7iJHemW/ZI/qOxIpo+z+q2sXxRPgw0JaJIQd6dbrofBBtBSWplm0wsotP7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru8LYGxvsrYd2i9KjHBkpvm+vgtJ3+RRX0zEPxvxteQ=;
 b=P86Hg4AI1etKQ7Uea7CXucKcylkF/SxuEaLXXhazFddZEaQDT9HHMbg4Kcc38Vy9BkiFcDQJmgCTy3sx4DELDSNp8N0Azw7S48x5HamAPF+EamF9XfJfo5Yy2PVzGJAmmMpp0s0ZhojlezmKQhmG9q8uz5wJNx8s+OVa96oYSyY=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:23:40 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::be) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:23:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 01:23:38 -0500
Received: from hjbog-srdc-41.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 01:23:33 -0500
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
Subject: [PATCH v6 2/5] drm/amdgpu: move GTT to shmem after eviction for hibernation
Date: Thu, 10 Jul 2025 14:23:10 +0800
Message-ID: <20250710062313.3226149-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250710062313.3226149-1-guoqing.zhang@amd.com>
References: <20250710062313.3226149-1-guoqing.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e6aae7-2fa9-42a6-f7c1-08ddbf7a4f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGNkNGQ0MllYTWJDUkgyVUFXRlRFaWcxemY0SDJQeWYwb3ErZUg5Tk5GRmtE?=
 =?utf-8?B?a1lENks3L2RLNUM0Q3ZyRCt3VFp3L1NnMVlFWjVvbkN1MDF0ZWtuN3E3NU1N?=
 =?utf-8?B?cFVrSjNnMEcrd1R4b25WYkpORFlsd1k2akF0dWVzTTNLTnBWTjJBQkFXM25Y?=
 =?utf-8?B?VDF0aHpQckwwNjBPWnU1NG1XYkUzV2hKUTA0OWg5SEs5SVBwN1FRZkhTWGlx?=
 =?utf-8?B?VDk0WVhCaHNjSFh0bHpiSFRYOGNPQkpWMlZpUGtvUEpiZGhDdnRxU1NOVU1s?=
 =?utf-8?B?YS9uYy9qaEJSWE12OURPMEpwQVl2Qm5TUCtLTXFMS3V5RWFUbm5lWmpDeHdo?=
 =?utf-8?B?ZjBMNHpMdHNSRzBVWDI0cTQvMWEydW5BUXI3YlhCZFlaZk5PczFhK1BrNEY2?=
 =?utf-8?B?UldsY0V5WlU3UHZ2U09NZldMZ2xnMGdXaktQMDZ4ZWs1c1RpR1NPNUdoLzBE?=
 =?utf-8?B?UEozYlo5QVRlQmwzem9VSXQ3TFlSOU1GNUlraGl5Y0x4MDUyK1g3OTlHZTQy?=
 =?utf-8?B?ZjYwWERyaVhrMUZVNW8wbHY5Q0RRbXowS1hZRXRSbE9lL3hnVWZIYTJaYndN?=
 =?utf-8?B?TEFQdmEzUmxxbHhPL0dtMFhLWTB3Vkc2SytET3ZGUUV0eWsvRDlBRDRFVS9p?=
 =?utf-8?B?Y3J0UGxsb1h4dS9JaEtub29HSkkwZXdIZHVtUTVQL3RCVmpucWtNK0RkTkFS?=
 =?utf-8?B?TEhpZ09nUUM3UEdoS2NIR0o1TGJ2Ky9pQ3BEZEV0N0l5OUtEZXZZY0JiRmxS?=
 =?utf-8?B?dEZoZE84ZWRYeW4yYVYvK1QxbERMZWNsN0lmcDVpcDI0cG1GLzVOMkFROFc4?=
 =?utf-8?B?TUNMcWU3czhkeWNWMFJoTnhyWTY1eTVBZllnWUxjZXBWYVZsYUtsV25FMy83?=
 =?utf-8?B?bU9ITzJyVmlzWW5oOHkyZmwwRHdsOXBPampVN00vRGJCZk41Y003eFlRK1VV?=
 =?utf-8?B?WTBPcWFSWm1tajFYV0JxV2JqNkdtV3RpQzJyYTliOEtrY04vcjdJaHpDNGoy?=
 =?utf-8?B?cW5uMFBrRFlmZzUzcUswR25KaUZjZ3YzVWhqYitHeTA2RWs3eUtZTk5BQWRF?=
 =?utf-8?B?RWlmYndKYjI0dVBrV3duaWZUVHMvcU5Nalpoc2pOeGV0OXRBaUZIUDFoVUJH?=
 =?utf-8?B?QzRPK0paRTFqL2IwVnR2VDFyT0lxVDJaMzg0YnhVOWNDbjNvK3g5TzM4VDh2?=
 =?utf-8?B?RUkrN2VvYVk5eVdiUlNwa1lQWTJXbW11akl4NUQyQ0sxL0NpbkY3bHlSSDdn?=
 =?utf-8?B?R1FZT2Y3UWV3VVc2a0ZRUXBQTTJDMWxSK0J2SVovcUw1Uk14aHRxRkhHOFdF?=
 =?utf-8?B?QlpBaFJzdWFqZk5UOEptdmkzc2pRcG5ER0Fzd1hLaCtjbHJHeHlkWW9ZdDdU?=
 =?utf-8?B?Sy83ZnpWMFgzTDBUWTdXRzNvaEpxZkNCTSt1dWtWMnhKUE50RjhjM2tTVFNV?=
 =?utf-8?B?VE5BVFBoNmxRd1UwWW1wMUpWQUdZZ3VOUllQNWpHVHlnZGpsWk1SQjZtUlh5?=
 =?utf-8?B?SVYxSGJ5YTRIa3ZQcmsydzJObkdMN0l3L25rWU50M1U1Sm0zaEtzTU5TM0JL?=
 =?utf-8?B?Ynpla3hxMmRXWitZL25qMkUvbk55L1gyL0xCcHZYRGd0aTg5MHJvdjdpTjVX?=
 =?utf-8?B?MzZ3bjIrSVZ5WjlhaTR3NXFhOFl2TDFiSHBuaE1MS3VOVGd2eThoWnpicDR3?=
 =?utf-8?B?QTk1cWo1bmZEMDlYMDFvd3QvM1l4Qi9pVXFaSVhJblpwQjBTQVlGWFBlSmRD?=
 =?utf-8?B?WjI0c1FNeTFWbG1rblVwdnVFV01BZTBiTnhjN1VrdndzMENtYWd3N05TWURG?=
 =?utf-8?B?UWVxS2kycFpVdHo0ckJ5L29PcnVtMzJReFdtRFZ4azFacDFhMzZEV1FWNUsy?=
 =?utf-8?B?M1lHNkIwM3hhZ0FveHhTdTVMOG03VkVrYk9zcnR5SzN6MUo5UDNhL1ZhbDVS?=
 =?utf-8?B?SS9SQ2dIMlpjK2l3ZjRFeEVyTHFZZEdmU2FyMG4wU0hjKzNtQXlmdFM2TUpl?=
 =?utf-8?B?QThlWXBmellDZTlrbWJTemZyUmxBRjZjTTZFQ1Fzbmh6WDYxREh6djEvcURw?=
 =?utf-8?B?LzVUdWhON25oL2U2RDlhdDZyOVU1MDFDZlJBUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:23:39.5231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e6aae7-2fa9-42a6-f7c1-08ddbf7a4f6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

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
index 45b44dec0d7f..f72c353bdbac 100644
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


