Return-Path: <linux-pm+bounces-16545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B19B2285
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 03:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFA71C2109E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 02:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40A1C1AD2;
	Mon, 28 Oct 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHM7gIxB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAD18B48B;
	Mon, 28 Oct 2024 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081012; cv=fail; b=Pf0tJdFsMobYzZVqEYFf0HIYERAxVhwSFSdViKSXZOYEH42/36Z45HqWRaGKBBBqIix6ggz+foef2vQGXwjeGrxKR8/VFLLCVg+ILBQU81zqq3GOsMSyMAz3hqeHexSi3wwtbHNjKrfrO2l1ZtnorMkL9qe1SMSaSpp/IGLN++4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081012; c=relaxed/simple;
	bh=xZ+taCNTZ1jgDGLVgjCIOEWuzKCw56wtp5UZIjT6bQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxvjO5HWVyc+Pm7/sZiJ0TByPNS6EOHNBhFpEMoQ6vpBdQ3Z25cuicT4Uov47yOUI1CgJ7oKs2cWLh3uzmdk/8QrA1fhuqUdaLf5H5XokcgMrJDF6RNWIIUntFtJeqdopXyiS7VFbbJICwKluGzJH/uxmlZZ/fxj9WM22TLuP38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHM7gIxB; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR/mTWv1cptAvvTiGSG7qUnLBj5+VVzMGPPF/3XmdZMkYdsW44fvCS1odmsD+fdQNUEaTkWxATb8KR8XkuCxMOYa2ROWZTsrqj/IW90kpHGSfgOwevnCZb8s/qBNjC6+U44yAAHrUXZZL989l8jqpH7l+PayFXUqNXwgAz+RozY1W9DVbdF7IrVJrthmNb/JxLrw5vfoiaIt8M/8HVjcMHv066RfjcmSenzvSV1xSl0u75jAZkyHxQFBgdIbwUUtqXCO1gO3cX3sdHTLDKgN0N5qOfh95sRnuee01qmejLiGISvh9MnzUKEhqc3hpdh2qJrABeKHNLocBLaN3opKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqyRdFVe1qkJ5+RpqpDLFm+LOL0dGKpfbdD5yvEaZJY=;
 b=tA6ldSvkvOkkxvC2XVxmr6qg73V9Zsw9yIs7rPnYXp/qIydyV8k6maIBKjGypTiJHMB5cf4Z48vL7rNW+v13dW8bkxcK+E8sLKK1WJ5BiGeFkRLuV+eiLncZ2bWP0vhF+9kJrhlSyjmZl3Rf3jtRWD9HnJV67I+5MBoPV6F/9oPiIrgbkO1vlXt3UUoUBrqZzzPF3woIm0W0HGv3VkfxBsH/6wHOF01hA+MDlcetcLa1K0OHGqQJeOfbaciF+xbrGzBdRZADJHzyo1eljPZSuL8h4mJz1hbuVChtc+6BJqYPFZq+IDLg3k9ruWNj9D7OXrx4Oz7ufL99GYu7I+NVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqyRdFVe1qkJ5+RpqpDLFm+LOL0dGKpfbdD5yvEaZJY=;
 b=aHM7gIxB2nJXeJZAc9xqqYrNDxN1nFcvE5xgQW7MgZSYDeJhzF0gl6b/kuKZDECutjMZsBdOAsagKnzdHpATs+rqWfgn6gn+OP2trUbI71l5Llrkb2356KLHNqpkNqv3ODmLIvnXRyhg4LsXogJJ2wKufpypzmve0vMSfW5VAM0=
Received: from BL1PR13CA0184.namprd13.prod.outlook.com (2603:10b6:208:2be::9)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 02:03:25 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::ef) by BL1PR13CA0184.outlook.office365.com
 (2603:10b6:208:2be::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Mon, 28 Oct 2024 02:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 02:03:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:03:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <x86@kernel.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v5 11/13] cpufreq/amd-pstate: Disable preferred cores on designs with workload classification
Date: Sun, 27 Oct 2024 21:02:49 -0500
Message-ID: <20241028020251.8085-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020251.8085-1-mario.limonciello@amd.com>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f534a9a-f145-413a-9674-08dcf6f4b4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vT1MXzHkWmor+pWqGGZWfIerLGGikuccs5+5hrRiQO549H1WD7krVT+SpVte?=
 =?us-ascii?Q?npBh5RSMNe7XlJOiXjaQ/LyOoRsFgNtDzzY7EDiekXDaePjEMPfpCvoQusH9?=
 =?us-ascii?Q?ieHg+OGbLo+IjYBrVS4xkBRdZckRxf+zrTOlFAkPN68ETKV1xcXl2e/z8u5k?=
 =?us-ascii?Q?bYPXGPmau0jnNWX//Wzapwz1HzcCGLIi3ahhERnhzHzT87FiTjwAFtkt9jJw?=
 =?us-ascii?Q?HEbMJJBZe/ri0hORacEm4DFimfvbjKz3ySbCmNGaFfBT6flcRJtww/ALM6et?=
 =?us-ascii?Q?q/I5TSGyTXwImaD1nD4bFT595CGLaDO9YwKaZEX1kU2W7z4VjhdKDmWtWVa5?=
 =?us-ascii?Q?n/vHaV8TGln0h5Qeye3DRTk5SETapGFilDgfGiMoujqU+XTZ/UrxHfGDh+Ir?=
 =?us-ascii?Q?r+6k1Bbof/qRYhC8KgEHq/4NMSDc3+BmoCfHKU7xZxox8mPtTU+1Je4xmb3t?=
 =?us-ascii?Q?0baPwcrTyQrOrSvDtBjLs30lqwBSXElJvPxChJHVEPPUqeP7l2bRU6zejlTW?=
 =?us-ascii?Q?8MoWPTPo2tHNTnbWEehCpTwEPJ0eG/XtwqM406chCAwmKz/r9v3hBfBEptPi?=
 =?us-ascii?Q?OVwOUQ9xs/ib9zC9vSo52oyQxPv8a0S5uQPdK9GI35g1DB8w9iQb59maj24/?=
 =?us-ascii?Q?7F3NOBPvsqxRKqKd9G17OuYLNTQoIqC8BfExhKb2+SQw6xZxKsWWk9r++EsM?=
 =?us-ascii?Q?wIyhbiKfCW9ORzwTpLx05rRLa1IciSCYIWoAFUD/wKZ9Ui3WeCQJkzuTdnWG?=
 =?us-ascii?Q?1+Zqo7ukO/bSPDqx+e7C20Y5mfPm+rr1fF6oNWHF73EzLCsdogJp/HNfuu4M?=
 =?us-ascii?Q?Crfd1HMcqfbSqvRRbc7P/7/Y0Iubjx6ZGzNLUg1wdgEVtwyGOzsD1jEVIz6w?=
 =?us-ascii?Q?pbUGE4wRnqchLNwTezfV/9/Z8bGJ2LlIMAIfQzVcG1pWi7n6qX3wjlAIrA6V?=
 =?us-ascii?Q?bUahQMkSxidy36UQZ22lUhrAwTRWW8i5/YnnnP4JfS07ozgydIAcxTCV+unZ?=
 =?us-ascii?Q?QFik3yfDPzsqAzbvqhDt+wsPjY5eJozSgMwpCEt0w5poOdfrgojhojiCgt6d?=
 =?us-ascii?Q?/GpEIQ3fDRIIgvWXMJmOxmBC7xvIZsb8oYSCpDdsDnc/QOmWXoKtISUAjQck?=
 =?us-ascii?Q?tkjj99zx7jd/CsPPDU1lBN9En1QgK8BYeApBPFC6vudAnB4WhIYxgtoO903J?=
 =?us-ascii?Q?FTsMuA49Tv/eca8hPVYEUWX/DnjW5dfS/xx0BP8pCTk6dB++h7amXSOqRZvA?=
 =?us-ascii?Q?1lVxK2MlASoNo+BK4RfMyjd1a8BLiclERG5x9OTqCJD69Zo378E8RzJlpKDh?=
 =?us-ascii?Q?uWhwtalMJF1BaYPpJvX93GVIJCTdaL3AqhWKvFzS0mV/3ajXiO0Ooz17paf7?=
 =?us-ascii?Q?5o5fPG5quRNVeizXyUq4Gr+LeB4gnZTZLtzQxjiXGdmXbBwG3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:03:24.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f534a9a-f145-413a-9674-08dcf6f4b4db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010

On designs that have workload classification, it's preferred that
the amd-hfi driver is used to provide hints to the scheduler of
which cores to use instead of the amd-pstate driver.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 32ddbf37a9f0a..c60cc84866982 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -780,6 +780,12 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	/* user disabled or not detected */
 	if (!amd_pstate_prefcore)
 		return;
+	/* should use amd-hfi instead */
+	if (boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI)) {
+		amd_pstate_prefcore = false;
+		return;
+	}
 
 	cpudata->hw_prefcore = true;
 
-- 
2.43.0


