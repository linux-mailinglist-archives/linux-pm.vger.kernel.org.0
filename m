Return-Path: <linux-pm+bounces-9784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5D912BD4
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 18:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C027F28C146
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD8176228;
	Fri, 21 Jun 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLaQicnq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38319168483;
	Fri, 21 Jun 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988708; cv=fail; b=Man4VfXcgCCcVZUCb+ug0RppOahCTPvhgxANItv274Tgex5YSnJOlkMA594iiixNU4N8lqIHDEOMk6MOjP2t0lRTtrDA/3GxfAjaotWrGbZ0ddmpyqMTaq/9vUS8kbuswyJTqUbUyuJBCVmJO2rBC1NljaoV/fOXLg55qGEuyRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988708; c=relaxed/simple;
	bh=dyz/A7b8bt6YXHT3er8fK2/6IKJLoZGiReFbziqknaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSyoerD+wkAqgCXndl61i/x4CFKlwyMfkqov1wB+7LaZhf5z+CNLI/vU4bACBmAX/D9c2nvx0P4akIU/6TCntsrOPNHqxE5Gb0TN5MB4AOwSATYr4OrQ4EKu/WuJrnt0vzWoAI/LbyjY4/sAiCr/7F0cRSbEd/4c6l0vE4f7QLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLaQicnq; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq/MQ87V5SeRYPFLlZZZA2WryW5HXLzwfIktomqqmGjVxF/IKkSkSZ4PiG7QLhbI7knQb7apUaU+SC4g9/D1oovQ5Nhbw+9tGiANwtDi8nrcrESx+UYv3646PtgapmW9chsGEAfa2Amqbr55Qdqlb8kn2nGPPahIiia8CVyLbJNOadUAcZ77UBmCKVbYdrGSNkq8nuIUShZxWGk/oV4lEG/6YYtzJOdHiiUOgRxyauYFw02uhoPINNnTyxyOQnIH5xi/sEj5M2SH4Vcfbcf6VwtKDsV7Y8apD/Q/SCy28iwgb6eOxdk3vTWFG9n2LAd68rMkdkIMSBAXFQH2fFm4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnE2l2SmN1ZHN0lvVbSWR9bGHmsB9izVA1/npTkmmD0=;
 b=edrQyfJwDtsH7DPf8xkIWwCw9l3GXaeyBC5qpSD1ShFsaEZx9ApY4we3zBMKnX24STGnqZrjs6PwlA7lBBLwXba+AdyArXh9DRPkIieapG2yw4aXGq4oylExoGbkAhEJ1rAjW30OjeUQt1oLUVMUvdWd8ObHD8lyRZcrNecVwCR0PzcHIioNy+MJEta0mip56jjkyS880bZYI17DeVn33qZqFF90+Ia0w4ebHJstbs1pn6yM0j/iuSdZs+uZKgWP5byMEZz2J8KGyQOkJKyCOO5iKoapKShNGJAVbuSm2bCEcyZur5lzO9rGG0pD9q9AsyxLPo9wGyChkWxh4Ri83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnE2l2SmN1ZHN0lvVbSWR9bGHmsB9izVA1/npTkmmD0=;
 b=kLaQicnqa/yEnIP/R71FxFQmFw/0eDMqu4e6Qv/TRFLOaqY/GBPgHxdntrOBl7JxcGE0V3BETIF1o3NqzOP2xI0Zz2V9W5sEA5MOi48yHq4h4EQZ+P7yKl+BBe/sJGFPVP6z/iFJ3AR/2+ZbHu+6gbgjQX+bcZPa6/phLdYrAHg=
Received: from SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:51:43 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::21) by SJ0PR03CA0171.outlook.office365.com
 (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Fri, 21 Jun 2024 16:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 16:51:42 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 11:51:36 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v13 7/9] cpufreq:amd-pstate: Cap the CPPC.max_perf to nominal_perf if CPB is off
Date: Sat, 22 Jun 2024 00:51:02 +0800
Message-ID: <66f55232be01092c423f0523f68b82b80c293943.1718988436.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718988436.git.perry.yuan@amd.com>
References: <cover.1718988436.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a887171-5d66-45c2-c1c6-08dc92126dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h5gM06GNdDerso3vbcappaNi7wklf/WkvDaWXmZ+uR/zeJzsRaWDv2XinvQT?=
 =?us-ascii?Q?LRS0KCf/lI1coQGdX8yp6snSnOgtCEWOBJ04UxkloU6ngekLrTP0Ou2il5If?=
 =?us-ascii?Q?dbaM75hiW3cANUwf7gl3G5E7idkacMP31bghFXTqhNSu6+6nytTGfmqDHMQX?=
 =?us-ascii?Q?yKlafNmBqlLMrCTdgzVuA+uuyEawxd/xYBpGw2qlQGHKuFqsRvuPt3npT62n?=
 =?us-ascii?Q?91Djr8UFke51ZhAr19XdJ3WrvZjSvS0UFJXCC8EoW4MOQcvCUZjX2paj9ndj?=
 =?us-ascii?Q?HZPcMuq69jMtZ66IEd5cfa0BUSsY/Sv7kAoDaY0APdSwgcLF3wsytvSeTF2y?=
 =?us-ascii?Q?mVmM3k/e/gXsJ1GcaQ25yhyVJ87N2thqaQVnFbN/5gMbfw8S9X0RDBmdjaLO?=
 =?us-ascii?Q?tPiD6OIheK1C6myBuIv/R3qWOb92U/SY2oDiy2tF4AumYyg1HRn5+QcnMB1J?=
 =?us-ascii?Q?/QJjn7DGSJ+JCj3IvRG3D6psRirWe//9jt8gv6ObcL3ke5FMiFKj6aLQh5pD?=
 =?us-ascii?Q?ufgEW7QXpubdQa8SgunCgjEqMK0UawewTyJqZkRMINjMy5OCj1+3PQ8HQhNT?=
 =?us-ascii?Q?l3SfUOFEPJNVlcH3KgfdNJPTu0wV/B/5ZZTx1tHfNgqdv387nHmNIh4TiPVR?=
 =?us-ascii?Q?cV90wPgae4aKffuSI2wwKBPIv6G5QOC4U8Umu49O0ecsVwRW6xDZN2+5OjTK?=
 =?us-ascii?Q?iEIhiaX1D/45eXMNuRD9CVa71zP0rlj5lN4u02ZQLUDEHgUb8Le/OJRrV8VY?=
 =?us-ascii?Q?ymVWCxgihUbwzuHysM7mqQW6DNFf8OXf1YwG4XMU2U/Eo2UMWQgk0nEIZ6da?=
 =?us-ascii?Q?L2tRIon1d/fOmrX42TqNGBRK+ZSxGxOcQs5Zh8gkcYTK9N10817yaWwaxR3B?=
 =?us-ascii?Q?++9NOr4L6pzmB6NNItvAbeO/BH9voiygvy9igQ0+KZOHyOWPly1RKNpvz75F?=
 =?us-ascii?Q?8l79ppvLrmzJ6Z6OOZnOES24K935q0vN3wuSH+S9ICvSyycmi/T3sVg3DBhd?=
 =?us-ascii?Q?cvJxRKVv22N9V0fQob5v2JwDG9yyyG9tpnvsbrURZ/fyk/jEXxFTfWy8UdND?=
 =?us-ascii?Q?usnlg1MyJXeiCLTdydCwYOK/FCmQ7wnNrdtUNp4Z1GI2k/BKUNbqloVN9cS4?=
 =?us-ascii?Q?J1dazEAPmLsSECDipMmaF708gIkareicrlm4RoUmjpDZun/bmLgjRw02/4SD?=
 =?us-ascii?Q?/7a/JDFvtd1oeKqtIDHy3AcI3y4CnRln6bHMFP49r/hbfnG9uRFiCn857xTd?=
 =?us-ascii?Q?DgM7okp0WWVv3QWxwnk2HesVsEbvYKzB7ngRcCFcZVh+60mxZ6IMgGTsf6aM?=
 =?us-ascii?Q?B0z7LKrDHDn71kSPdpNT9T/meN6893jmPYE819QiqrcMhl+Pv6lhvH+HLZo4?=
 =?us-ascii?Q?OhOz/SAYy9GKXT74Lgh0NcJxYhHoUc3leGKOzNJoQUL1txQjHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:51:42.8587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a887171-5d66-45c2-c1c6-08dc92126dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

From: Perry Yuan <Perry.Yuan@amd.com>

When Core Performance Boost is disabled by the user, the
CPPC_REQ.max_perf should not exceed the nominal_perf since by definition
the frequencies between nominal_perf and the highest_perf are in the
boost range. Fix this in amd_pstate_update()

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 02767230524e..05e80d2f8803 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -529,6 +529,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -551,6 +552,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


