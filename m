Return-Path: <linux-pm+bounces-25792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3961A94DA0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 10:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DBE3A94C8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23BC1A3BD7;
	Mon, 21 Apr 2025 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kpehA241"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FA12B63;
	Mon, 21 Apr 2025 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222710; cv=fail; b=pVvEQOlIKPcJZU8EgB/rpVWC7j8fonKnpFB+UY+HcHWXKmThu0lHBSavGbnwALFU6M6ZpmEYpjcMyT5P6432tJv3oZ0BSru3jxhnLHnh/R6SXRD14LS6kxenZPTRmaaqtIQJm4VGSLC2WfPYpJ1ooJtT8EQ77skQQAjtbbKWkTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222710; c=relaxed/simple;
	bh=77IcCQ6qFH3666+1Hu3ifq8LajrE1RJb8iQHRbJeX6I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cpaSZk/wieJFby73bsqs79kR3gwTQURtTGsMXdtcTLkgluJPi/CP6Y2hvuAVqmAuHE93QCjlVHw9CBnKMizB7hgwtybbRsjLMPejh2JIGJPaws6zDOR9bt6BtAUulozQEHzt6fOAKsICUnVVpVc/LXwuXBoHJCOvE/bfMGZNmHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kpehA241; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDofDtwZawsoAQu4+yD2EF/F6pay2gbtwSdmWunreaxAbugOyNPGM9H+5IC6st1dR4x69gWUPMVgK9XgRH+GmRbsqcqzRQr1OSgkr4GGu/a+eMskhCejth9kgVqsoCaF3Pmmwy3FsvZS12XNiq/mZBikUoQTqpD1rmTuZs90k61wpBneFD4Uh3q+G1/Y0oO91iP1PDoPlP2Cnh4dSFLIohJPTb/256jAwQmanCWbVgyIrDxDyD05A6jdd2MiRwKe/ktC0bO4vM2RqZhz/83AFMNyXzKzqheNOoJ9SnMNBAmOWheoFe8w+NIulu730KQ/5ui8ofO8Q6NaTCDWKSpO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLdSl1qovkiPlnltHCy6rcWEq44Yoz9sVYCYTriHHvg=;
 b=yNsy5TKGI9UIzcklb5KsQojQqYSOLhWbVNTUjUfMr5Xp+zV44oqTYNZ75CRcOKdNZo1tAm5gU27XWFF/1qNMVb8/gDkE66T5a4Gsv73s4dTS2/vCnIlMrWdZWSIOZhTUqkuQWM+JIVOPXnX01zF+oADJtoT2TQsaR+IqVS9Icv67WMqh7rg/oRHK1aAKBUvxEkF1NWl0JnbpwFhygpguFjCfpt0xmhmg7bOhiKSGM9leExb9a6sSF4lwXNl7Mm0LEVc5iWSxNE++7uQwr9IDHKV0pOX8NUssk3UPNCQ8rkLWhafJA14rsz+cu4AI7IjZxFIp0Sx4lr/h4115qYdJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLdSl1qovkiPlnltHCy6rcWEq44Yoz9sVYCYTriHHvg=;
 b=kpehA241j2mE0lx2L4c0XEPhlHaC0DymuRkaC5TGFKw4RVyjKBfYqI5RtvJi2TF3rN8m178jL7zs1swH3jryc+ORJITsBtCuiAX+uN72GmYtysVoDu0EFsUg8GdH/e7kaTWyHgY3GVy6zFUhFJLgbCi6rGnY5tRWa5jvq31C8e4=
Received: from BL1PR13CA0226.namprd13.prod.outlook.com (2603:10b6:208:2bf::21)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 08:05:06 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::de) by BL1PR13CA0226.outlook.office365.com
 (2603:10b6:208:2bf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Mon,
 21 Apr 2025 08:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 08:05:05 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 03:05:03 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dhananjay
 Ugwekar" <dhananjay.ugwekar@amd.com>
Subject: [PATCH v2 0/2] Add support for "Requested CPU Min Frequency" BIOS option
Date: Mon, 21 Apr 2025 08:04:43 +0000
Message-ID: <20250421080444.707538-1-dhananjay.ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3628a859-6294-4093-d352-08dd80ab3a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIH3tLoGt6AIKvIhbg2CcJ+9vVlyX6EtLnAKD/UajnNDtAF6WkZyyXEbmuz6?=
 =?us-ascii?Q?VE8HTx5c+jVTwJNni5D+aTMj1MMvYiQZ7MPzGUQBW4Ud1/29uhfSr4Rnh0sj?=
 =?us-ascii?Q?XL/yO16UzS8rE4qFRMzJxqBj63Co/F0O0BWmaguF05Vh1xwL3E1y2zHS/zYc?=
 =?us-ascii?Q?1pZgY5pp4dcs8/pnenBNVQeFKq95USjvwmkGoaR4O+ScAubRXwnV6UKEtM6R?=
 =?us-ascii?Q?vE8EAJO3LHEDiJXKZjTGXMa7N5x0+KMaNEJK6O2QKZQtetj3DBuIf5Vw+o0Y?=
 =?us-ascii?Q?udYybF55+0gNT7v04D4utm/Ner959ZGMEouox3i3YAnt/SY17ToRPUag+k8O?=
 =?us-ascii?Q?/JCjxm8u9qAJp0gHWZWOZLDbOPQ55LBEBhQEZdBJe4gZjOYVN1dRs5SUn9/d?=
 =?us-ascii?Q?U9ioFl1pBV9PYHNFadqz2m9YlWNVbvgBOKwEWDbvkK1KV528+4ANSpRHa+F9?=
 =?us-ascii?Q?17XmCbtSQ8ocUvMf/49OSxQ/PchlY6gg4+vuu7hXAt7nxYmlXs2B/EWeWMKL?=
 =?us-ascii?Q?arSaBYZVV+mLMP+Sohd7sulhG/S0EIt4tddYqB7iUoNoU/lMb0a3MYKBKHzZ?=
 =?us-ascii?Q?ZAtzInOQVpCMtduzhbY6WaafSSpVKa1dLix+mIPy4YeY98c0Iiu3sMv7lkg7?=
 =?us-ascii?Q?7fIN7uS8pkXdKLIwoPyIYdxsAIBS1KpVnRfiQD39tb6NIhIc+S94NyPulb/Y?=
 =?us-ascii?Q?OM78B9TIgbQHhloCpSyDmoTFjaoWQyKhV51egFrQoFvjYCLBTIoXpabyLAH5?=
 =?us-ascii?Q?i+HICvtQ4zpLZ4AcKE2Vog06US3RZZRhMOxCTXM1oG86rmy9r6DH25l7hvTp?=
 =?us-ascii?Q?o1C6YIXItuip5XznChFPK/6qRnDMk2G8fEYOACMPHLudrFekk4yA0KKd/0oo?=
 =?us-ascii?Q?dGzj/7cKRPod9+/lH20pshNAG/FcHj82rE0FCP+PtmkREUli3gDjWQrz7iVq?=
 =?us-ascii?Q?s9VfP1lTL6ge1E9KNR5BGmobvodLR2UgpmVkYPamjBhMdRX+17MSujLcDuC6?=
 =?us-ascii?Q?D0o1ZworMIFSh96K3CsoEDenUoCQtYOAdONct3iSKt1+GIrS+y9aFvb4W8mk?=
 =?us-ascii?Q?nv0eLiHwMDHknYcflOcrZT/gO6GGaAMSqJ9jrK8EsqNZHSHy46+6TUiAAZqN?=
 =?us-ascii?Q?Tg0yfZRAAzpXHSTn4M0VWQq6merce/7xHPwMeViTfQhM+pOMp4E9AafJWPXX?=
 =?us-ascii?Q?p8v5IuGUYWRn6c1J/6gc+2icok8Odd+9veMRzO9+ESKb5SGjEjsoaPjFBUa9?=
 =?us-ascii?Q?ebAXMq5SQDEQimE87/DGkQoxXSHvz4TuNvDozVVTESMnkYKHTbAP4ZJtfUQE?=
 =?us-ascii?Q?8aggwK507jlsag6LG9vf77pAobYft0XEOMA4AQhCC1s+E3j0xE0s+iv+MQz5?=
 =?us-ascii?Q?frVECBHSYSlZpw3ph0YpfdLUuQ7u+ivD1EoAzg55UkmCUZxnN1A7Dtit1StQ?=
 =?us-ascii?Q?0rJs6KLblAQL7d42Ul3DUiybJ1bNU4a/HbiKT/ClCo96Ahu0AryK0uu7QU/r?=
 =?us-ascii?Q?yvkMSEwLX4KtGO2KuvZDIDC+hVPJ1mDpmC6P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 08:05:05.7847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3628a859-6294-4093-d352-08dd80ab3a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436

Zen 4 AMD EPYC systems and above have a "Requested CPU Min Frequency" 
BIOS option which allows the user to set an initial lower frequency 
limit. This limit can later be overridden by the user by writing to the
sysfs file "scaling_min_freq".

Initialize lower frequency limit to the "Requested CPU Min frequency" 
BIOS option (if it is set) value as part of the driver->init() 
callback. The BIOS specified value is passed as min_perf in the CPPC_REQ 
MSR. To ensure that we don't mistake a stale min_perf value in CPPC_REQ 
value as the "Requested CPU Min frequency" during a kexec wakeup, reset 
the CPPC_REQ.min_perf value back to the BIOS specified one in the offline,
exit and suspend callbacks. 

amd_pstate_target() and amd_pstate_epp_update_limit() which are invoked 
as part of the resume() and online() callbacks will take care of restoring
the CPPC_REQ back to the last sane values.

Dhananjay Ugwekar (2):
  cpufreq/amd-pstate: Add offline, online and suspend callbacks for
    amd_pstate_driver
  cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency"
    BIOS option

 drivers/cpufreq/amd-pstate.c | 84 +++++++++++++++++++++++++++---------
 drivers/cpufreq/amd-pstate.h |  2 +
 2 files changed, 65 insertions(+), 21 deletions(-)

-- 
2.34.1


