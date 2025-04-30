Return-Path: <linux-pm+bounces-26451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97167AA4A0A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993884E694E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0181E25B1C9;
	Wed, 30 Apr 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oV2iFnL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A425B1D5;
	Wed, 30 Apr 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746012672; cv=fail; b=hJFYg0NyoCVFM/L5Oc6IAREZ7DAhg3s+Ko8J18qkpfEPcIZp7AwhsUEtoqKG3o22H/PuVlFGPf+O0HHnC8ymjxc5S+WajNCplfmB/6EbNyyPDDk1jE1AcbwTPqRNqNOMVBsTXQYWDnqYezVaqsJzqW0vvVvWpxPCNNrZ+p3q5+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746012672; c=relaxed/simple;
	bh=VzcC3sJ/ZOtcOCqv2AP6S1L8tbXkoG6Uth844anZpl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBu9/L7mLkhuTVm2zMqvW10RtZQR0lsOYuQu1s9gfgxAZEsoWyfhOEZFP2tPTvVfe4t4Ioset820yOfG7VRLiKPfAu2ZHFhJPyZT1jWPUE71h7eqnPHlCWBMhYC9Y9Y/ya6v/CCaOmzJdcTZ4BtzoTeP7QgjutSrFM6/kodTwwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oV2iFnL+; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2cq9ungYwJ0xnSRIzGDlSeqaxn1lP968o8NWnmr3Z4ntcgYG7ppuWMHq1b3D9pRmKtbZJ+Nv3Q0/COJTQxIC/TR4bzyAS/GET1aTA8p8jYYTS9IWWj82RCNvJG80aXJJegHMq8nu7yHx7Pb/7zHJ+v52GcvRtuA+vi5OUIw8/PMWXys0UqUVH6kW9SrXuWEQyl7jMprfIRj6qaUa+IAHb15cdWLKOTQBQEBIwkXDz9RY1yQ0N9VPO2AFgfUegfrRchKSgM+bTNn7dtVTywaaQEe9wEU9zuNgIhOEyLSGXUtQvyXMiPvnuWvIgGfnaxsotQiqSJ3f+Nelc4yoqWvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCti1eYZbvVBy1ocxVxG02hmO+Zy5xWnAWvXgx8gwfo=;
 b=D73a+i7Feh2wd5tZKxA0dxmBdHoGj3er5AJhv9eIDnf43bJ60FbzajFmcnuajeTZkzS9ELw0xqtGFB8jzVIMoFVe7W/4qjn2kIG/k5YoDx+mzKYOihOmveZDw7/Ywe0dRv5lKQMUG6Ryqex+BWrQlMrq4VuWzr/gDCJXda9gcUxsQi6n1chsOINX6mNvG1rmkBiS0CdYkmmzzpq9vDgUKg/YUQxg3avHyCXyja3FmxU9XJaaCySuqAeKOocNHr6yU9ordX7bf9FS0ppdSCy6zeLOO8eDHCF8PBn2fKr/v0utCZGJ5qwMiNEG98jcMEDVBL0mNVgVVcodgt4GKEzoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.d smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCti1eYZbvVBy1ocxVxG02hmO+Zy5xWnAWvXgx8gwfo=;
 b=oV2iFnL+xSrI1Aj8s0y8/PyCHxxvfyo7+o9bCQlpjXQ6ndM6gCHnsYclpCCJpQIdzO2m/egdr8HXJN+ND+jR0DXd9bqeg8Elj2lHYnTWcZN61T/89q/OoMFhZ46zMAtPsrVmMlsl+8fCJ4db8YQXydmh1NHhE0bjRBstIgr8eco=
Received: from PH8PR02CA0051.namprd02.prod.outlook.com (2603:10b6:510:2da::21)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 11:31:06 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::67) by PH8PR02CA0051.outlook.office365.com
 (2603:10b6:510:2da::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 11:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 11:31:05 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 06:31:01 -0500
From: Shivank Garg <shivankg@amd.com>
To: <tglx@linutronix.d>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rafael@kernel.org>,
	<pavel@kernel.org>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<shivankg@amd.com>
Subject: [PATCH 2/4] x86/power: hibernate: Fix W=1 build kernel-doc warnings
Date: Wed, 30 Apr 2025 11:30:00 +0000
Message-ID: <20250430113001.546066-2-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430113001.546066-1-shivankg@amd.com>
References: <20250430113001.546066-1-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: b15f34ce-2fc6-4f44-acfa-08dd87da7edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z83qND0SdEGQITIAXLOh6hfeUc1R1FaPwYyevzNIRNWDl7eegoYhjWijPzTR?=
 =?us-ascii?Q?nMjU1B5xRUQi6F6T5ZsuH+5SuS5pIciUS6v192BXjHZcUUcFzZm5Z6dnTNp3?=
 =?us-ascii?Q?PA8jWpSu+Okisck0jVwIQpiwK9C4DgS2FGcPf+vaEiAhGud9kGYKhYEndAW6?=
 =?us-ascii?Q?EhgB5wsgMd0/MTJE9twNVxnfHDijIWyea+b2qWT4lHzmSGq3zxddwRw+ZJCi?=
 =?us-ascii?Q?HaVh8ZVpRHCJFuifzzkNPO9SI9RJAO4aFjRFLcW4MxBHi1JpCxtl3OvPsLYQ?=
 =?us-ascii?Q?rAfGGiwW841XXFSRbgn/Xvga4/6pJD5KcyBdLz+WJdvKY6+I0qAsxKi6bXlC?=
 =?us-ascii?Q?HChUYPvlrmYdhTIjY+F/XKVALcPTY+3Ry3rpv2vGVwOVi1wlBOQIfwC3L1/C?=
 =?us-ascii?Q?P1yhToT8srkmc4ucs0gTLB4KjkU/MvbveO53zfjTJfgUV8YiCqgPBqBUms2z?=
 =?us-ascii?Q?7IzFDEyogKEFpcUXOzyK4NxjWKRzhTlYCefymiZSB4FjdffOyDomstSBxgI1?=
 =?us-ascii?Q?9N5mGOJ0ajxYpuT3vehrkxfuqWuZD34VzhfnjBNzGYUtpeS3dTX1RdoyWj/G?=
 =?us-ascii?Q?xU5toTgVn2Wlj/w4mz8sJa+Punsj933gjwDYqzbHLYj57gN8ZDZkXn8WitRu?=
 =?us-ascii?Q?9QYS/9NB6fSss5N/nWNfzALDMLr74g7z+KCjTKlCfPWv2aukwZrR4q1ttrxU?=
 =?us-ascii?Q?ObsKstNBmkJTDY/HPQFh0JSc53UM5r2RfiDVISh6CMjvkTfQ2+Ax7KV/tf6Z?=
 =?us-ascii?Q?cmnW+WuDy34KuPgrnoqZBZ0DC+z2ayF3JZ7q/gqA9CfCtKdIboFBicjUU2ge?=
 =?us-ascii?Q?9Tp3ildW+nsYqTP3dkYcgFg8KLmwGPiw7G9CsbUXFJDak+NN00nv+ZUa7sOD?=
 =?us-ascii?Q?x3Fbvzm7B1YGJJwRfk8c9nsBtKLr0ixJD6zksD7g+8IY5wWeA+uPUnX7ZleC?=
 =?us-ascii?Q?TTS4uKz+wKli0CBmwVQxIkkHkTHsOO62crmkxNroDiZaVHIRwnxW97FlWrHS?=
 =?us-ascii?Q?KkzYhoJoe/IRewUBuOOw01R3zYaWxWkUMGCOfApyC5savlaPWRoRi+Uzlr8C?=
 =?us-ascii?Q?+uuAWc4Hxbp4NAdEuxCjbhRaVhuimILHpESiHa5k1jCbs1YwlwCyG+PY2/J5?=
 =?us-ascii?Q?MgH5OkjkLpfqqImyWLkXvbKKbs0azS/JBFb+Q7g8e9tjnzdff/VpxLtebYtK?=
 =?us-ascii?Q?iDbxX/0wT8aB/tZydFnnWp8g+57NLc6kUqDBqJ/xJbW3FCc7R8iy6XD7wDc+?=
 =?us-ascii?Q?cf0C/Jlwc3LUN2lZFC6hiOXMD9dcirXhsCINx+VWoFL/sq4njibCQyiGLfVg?=
 =?us-ascii?Q?MBNo/EAdr3M0AXk2ybDph+ouMOWtZBgOfhlma5ok5R41E/2fc3ShpVTfPaxc?=
 =?us-ascii?Q?crWa3aUNUWDHk1frz1e4XCOLSl547EsYcWmhdhK3V4Z6hQIDQJ5vPQzS0zwS?=
 =?us-ascii?Q?5xevsQjFzHLv4wAknvR881+6prvRPsZB5q48L56roAy/fKOw3XcoDlTScCOb?=
 =?us-ascii?Q?cNF+75ozRxwfYu/6gjgVdhN/VpEG7ufZkbByFdBFTaaCuhukfZbu4lmQJg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:31:05.7104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15f34ce-2fc6-4f44-acfa-08dd87da7edf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904

Sample warnings generated with 'make W=1':
arch/x86/power/hibernate.c:47: warning: Function parameter or struct member 'pfn' not described in 'pfn_is_nosave'
arch/x86/power/hibernate.c:92: warning: Function parameter or struct member 'max_size' not described in 'arch_hibernation_header_save'

Add missing parameter documentation in hibernate functions to
fix kernel-doc warnings.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/power/hibernate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 5b81d19cd114..a7c23f2a58c9 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -42,6 +42,7 @@ unsigned long relocated_restore_code __visible;
 
 /**
  *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ *	@pfn: the page frame number to check.
  */
 int pfn_is_nosave(unsigned long pfn)
 {
@@ -86,7 +87,10 @@ static inline u32 compute_e820_crc32(struct e820_table *table)
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
  *		of a hibernation image header
- *	@addr: address to save the data at
+ *	@addr: address where architecture specific header data will be saved.
+ *	@max_size: maximum size of architecture specific data in hibernation header.
+ *
+ *	Return: 0 on success, -EOVERFLOW if max_size is insufficient.
  */
 int arch_hibernation_header_save(void *addr, unsigned int max_size)
 {
-- 
2.34.1


