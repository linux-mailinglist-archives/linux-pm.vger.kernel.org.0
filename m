Return-Path: <linux-pm+bounces-15848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA749A1F64
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB21F2336F
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69F1D958B;
	Thu, 17 Oct 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tzv4ZUEz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310C1CCB44;
	Thu, 17 Oct 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159588; cv=fail; b=YkYEWKU7hzip2WJf+f8wX5hWfgXq7/9CFxR+QQwaHyXnov/8Tc4NQRk7kVyC7FE9hlf6BovfFzm5cSORwrtN9upWBRalSMngajAdS0r8LIk5rQnyfyszBlZ/K3EoprfyescVz6zOiP0R1jJQcbcwkpTzkgc873+vBk3F5ettCXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159588; c=relaxed/simple;
	bh=Wavb0ogGrXXoFzKhmctPk+T8UgG2qmkz+RkRVCXAwMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M2E+kiBr127wPs/4s9SmybzvEX8gRvAYxcOkqQQkrSj2pAXbc5P/6uKlWkxMQbO7zq9hMwkBxdsLaoP9AFWlAhT/v19z7dhsgpvCNz8phfBOuOC2g+1cKbilczde1HphEYV/UYDvmfG7frvjNuhQIsabAukxcx44XtvAaSWg3Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tzv4ZUEz; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF2avesH4lCZ1FSPE8TrQU0/F5uxXNf2WfEKnf4ltoDJqnteG8I4xeTSd05KZvwI4dSAl5NBCEEPxp+rhCdDH5KvyMyofjNwEPw52bBCmMZIHsdIrUkkp4OBTiJ9isPjMd7oEg+BAtg8QZB6NRRg9A5lO/5gvbtGch9tkg+BFPoVMdqlmCt+VrfsWBgN7aXOFo7PWRY46hag2x8LVzhZ962fLxsHs0/bG8VAxwCgyzF3SP/RkJ/97icIsLmofuPx4H2Jly8gtWFqb39uULxDWoq5fvX6fcYn65/A8GyGKaShuZbJLWzcj3KJcldzWl+/mwV6JWTP9uizpP/wZTzXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMTdYfpfyRu4UpN2oeiWknZYoJh+dkBHfNPcostNG84=;
 b=LB+ulqKg6b9/4Erxu7QB7Sp/k/5JwVPeF/78yCMaS7Aml13P/KVqdWUIymIKI/TPf6q+CKUqeNw55oMx3Pcz7B0iqD/+ozVi4r+jcIwsON/9DgopA2tMlAtBJJLsYO1cBs4PiZ5rRxUXpzmxeq+4FzLSfN83pDyWWshxcfGTddp3ppL07qa/nMO1QDEUaMJPGcytrC8/Wp1fpYqfEDPPazlnOnuhR7sMfjj9Qb9afKehqCCyMpncoOPe9a2Vev2Oz8Pgk+gCICgxcBjgHa2djN7PSRMAX+njgVmKzFaGlui/vfP9hquMF/DbTBPIIrBBOi6xy0RUBSJdHjhdjGrSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMTdYfpfyRu4UpN2oeiWknZYoJh+dkBHfNPcostNG84=;
 b=tzv4ZUEzMn1nBw755gdsdCMO/05jJF4//CKDgE1WbLIjSfQhZssRHtbLCWu6ABhfPXwmdFCRCDWgiMJ/z2IpkVWLs88/AfOHR/D7gWInLZbapWvnczSHOZC8HtFkofWQ5Zd9+XJafVmDJxVWYxvnEdXk65P30tE5JuroehTHdO4=
Received: from CY5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:930:15::14)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 10:06:22 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::e9) by CY5PR19CA0010.outlook.office365.com
 (2603:10b6:930:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 10:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 10:06:22 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 05:06:18 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 0/4] cpufreq/amd-pstate: Refactor amd_pstate_init() 
Date: Thu, 17 Oct 2024 10:05:25 +0000
Message-ID: <20241017100528.300143-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: d869f775-32ed-43ab-5e6f-08dcee935a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSCeDG2vCBHmZ6YXSRYV2xGUoZn9bboDnAUXhJVXF6hJpYGuoSWMNW8MCqcf?=
 =?us-ascii?Q?4O7oY7BMRcktR+y4/TBwzgtxqJ9Bco0ubzNT6x8FDZmHe10ahh/3q+SXUW5j?=
 =?us-ascii?Q?2JVUGfC8uzSUh4UhGPGhp6qTINJlIrCySJk8W8GkwVoDlz5tzwxoEBBf9gS4?=
 =?us-ascii?Q?FMkIoX49YDw712fnpi0rEWN+ViIv2NQXRRTmPLCLfq604Fc9ngtADUWk/EcA?=
 =?us-ascii?Q?KCxo9s9xFrfAD33v5oXIxSkcsHh+QJ5aqlROmTj0Y6rfyfh5Qjhq8qJh9ob4?=
 =?us-ascii?Q?WbNUN42XNhJSJcFAaT/2PaHD6RjtZ4TU+V7Xg0+wSLCUWp9RFHXwyDKxfP+I?=
 =?us-ascii?Q?jumMMscemuw1bRVOYjWcmRM4qR4qDNNZIrTne7t2HPvVqFl376BaTW+puxpS?=
 =?us-ascii?Q?FrQ+5fandVKLFM7Tw0j4LyoxszJsOKWNQWh81s1VA12aalA2tX8Xfc/gzxbP?=
 =?us-ascii?Q?n2GGxd+wOw3maDejVr+8a/jDRSKA9ZPShaygIrGhaf7gMkEsQrnocLATRNUJ?=
 =?us-ascii?Q?QxiqyNMHIS3MzEuk6a/zbGfRkDYWsxhTAaJV54M5wYCzYrbsGxlf4S1jV09X?=
 =?us-ascii?Q?l2nOG3zxO6G3bjdWp4HCJzULRCiBEHBbcFniIA+wVMt9iv8ClRLqwJEHb1Ns?=
 =?us-ascii?Q?Rg8f41GUmqrbmO+6Dt1bhlscjMJR3VC/KJyKTDcRYV7pQKD5PpQgDBuitvl1?=
 =?us-ascii?Q?S6zS8vV4Nw2tJ4MjkQb0Xl4Lnuzf/tQ1042z40fHIkiWlEGR+Eb1ktjeHglp?=
 =?us-ascii?Q?K9sVpvtpwI6U69vV3RLzMKSKuBtppIskVLNYs3j9axplmjIJiGKwpOixs1xv?=
 =?us-ascii?Q?D4E9RmVUzDPOARyAzLEhGyUXocDDdhps3/Vuz/m3G0ODmpZ/P0L+7cIwAvc2?=
 =?us-ascii?Q?wxsqMWpDRLVKIOUNKWJlUJfRmc41gpRuyd2s08NFlY87CAv4p91cgt1SvXsG?=
 =?us-ascii?Q?4PDcRoOnihCpqyVeLpbX+sZAhG7TpzrEvqfqmNh/lqmq8M3O1+/GEv28Ym46?=
 =?us-ascii?Q?k9dMBiodE59Yuq2MlBq+3EGx/MEMl4DrPXw7E2gZ8aN8/+yNXmU1wPdTz1fW?=
 =?us-ascii?Q?fTjiu5c7AAnnQwFC6qYfnWtHQclgJErbyCm5C+H6ZBv4py7XEJV9QccoxntQ?=
 =?us-ascii?Q?EEomLtGu5g66qb+HVsPueSQLuZYJ2k68vmBZ4tVfn3XGDDNmvYCWvndhu2jC?=
 =?us-ascii?Q?SBEpvixA/xZT1aqZDqy1xzi10rDeGEi69TaU32donLvuRriQ/xyXpmOHQ+ph?=
 =?us-ascii?Q?45E/T9kw2o/6gTMn0SlrFy/ZIpQ/WvTWmju7CYYD975QWBczEPiJ86A66DLn?=
 =?us-ascii?Q?sUg2/U9//HLkg9u1i8SZRaioJtQ6r/uF++2uUUWvRN+/1jdsFZSedxvFSpS1?=
 =?us-ascii?Q?nDNfGj2TuQnNdccD20Bv6GPoEhH0Kc+E0HzQvxEDA8Ruw3s19g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 10:06:22.3858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d869f775-32ed-43ab-5e6f-08dcee935a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008

Replace code chunks with function calls, improve readability and
reduce redundancy.

Base: superm1/linux-next + https://lore.kernel.org/linux-pm/20241017053927.25285-1-Dhananjay.Ugwekar@amd.com/

Dhananjay Ugwekar (4):
  cpufreq/amd-pstate: Call amd_pstate_register() in amd_pstate_init()
  cpufreq/amd-pstate: Call amd_pstate_set_driver() in
    amd_pstate_register_driver()
  cpufreq/amd-pstate: Remove the switch case in amd_pstate_init()
  cpufreq/amd-pstate: Remove the redundant amd_pstate_set_driver() call

 drivers/cpufreq/amd-pstate.c | 79 +++++++++++++-----------------------
 1 file changed, 29 insertions(+), 50 deletions(-)

-- 
2.34.1


