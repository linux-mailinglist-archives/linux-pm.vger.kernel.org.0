Return-Path: <linux-pm+bounces-11251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD2937686
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3D81F211D7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52A37BAF7;
	Fri, 19 Jul 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r1H94PYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175782C697;
	Fri, 19 Jul 2024 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383999; cv=fail; b=s6M2mpVRLduBaL8utc60gqqpBBfGZTY9XeZZMITqphoFxu3WCFopRqio5dW6wWb8NQpAlQN8VY3hOeyaA6JHH9M909ip2i5N0vsmyXkjeWiG2Cyqka0YKHCkdqiyz7/olmcQTXQ4KHOaqRu7Oq0eZTndlC5OkixbplL9GK6pVp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383999; c=relaxed/simple;
	bh=loqol6Y92HRcV0ih9cs/VhjlTgckH85EnQj+L57JcF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyQrK33BwHNq2b1I4/6MR7R2mzPAf2qzTHq81HVQ8ch5wlIRpgO+YLKaXgeAXTX6rYe+jowxJexTTDizMbHAcOsAD091QwbHZ95xDNxggMjNQtCMD5phzFzaHNqSCf6EhTsHE0RXy+Wi7fx6lg2Wp14VsQdwAKjueHP/ZeGwrsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r1H94PYT; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBGvKUwBJd7OpGjsKsowjikCTbSYSW0Duw+9h76ELkzOkHUs7uPgI5gSNh5Fgx+2MWkDiWwBHebjYeTpNegGEtkQifPJyd3SZRehuoZJsmpgYnFZtTCwcwD2y00XepymeNyWSY3Uz4pv7SNB/InuvLSzpC7HvstMWk3Va3mjQW+dh4Y8ablEBIVajITsaVVeMyZiuq8JeLyhT9eN7AmC+6iF5WJ+my/zdZDhebQ90msEu2yweD6P6DsXS7PHbSEIJRe8Hb0Osb+8H7vkabyzqY8CTPkQAeN8AiTNxWdwj3CyDaGd4fkeZecz4H0Eqm4uabiw+U/fKmOLk+8yq3z+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjgJvl2tkCmC3KmSGQ25nsed8ToDrzLbNg+Lr3QNL7U=;
 b=J7xsW0dmJi/KN/ZPJYlliUkuAafy+CIrh6TE1jww5ROI4cka1EuWzVl4DTxYZYMDyqfGLHT+J8Ab3VdqikcsKAsc3LBuDQmJsTgutcqTsLplTVQBnvq3VNoATJW0f3MAMfyK54RkM/XjBIPxp6IppXjojCGx7kHgpHRqjK2Aqz2ma04oW3LQ4miY/y56NanADpP6dsWs07EdZEQlrG1xLK6/n7xr5b01VLQn60MvbRgHNnjliJRBWljbbE98sbxvZzDh82XhRtXjJ3YFqWqjGyExZwgKXtmcySsFR83b3yVHSmKsnSJVPYFQmJbJ9PxS0QYtCcZfwoXWFzeYf0W8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjgJvl2tkCmC3KmSGQ25nsed8ToDrzLbNg+Lr3QNL7U=;
 b=r1H94PYTkwfqVuo3TQeJ3qs+rg7kQ2iYbzi7//FM36LXKX/S7AJmcRQ6n+z3dRW1fVA1xC2zMkjAbFOy1nY+Z3UIxQVGepO145cJk9VCnnwPnICCarbRbtZyQcMdt6+2iuu/oVbwXJZ+9DHjrcBhdh7a6XkhuWIplCZFWu2km74=
Received: from DM6PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:333::17)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 10:13:14 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::73) by DM6PR03CA0084.outlook.office365.com
 (2603:10b6:5:333::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Fri, 19 Jul 2024 10:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 10:13:13 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 05:13:11 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gautham.shenoy@amd.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH] powercap/intel_rapl: Add support for AMD family 1Ah
Date: Fri, 19 Jul 2024 10:12:35 +0000
Message-ID: <20240719101234.50827-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 2551f4d0-b2dc-4541-025b-08dca7db666a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4jNf0Q2rhv7/0EForbU+T2PVAZzSAHHWkqyatadPC7/o+4SE7wtaACf+qTTa?=
 =?us-ascii?Q?BQNZ+hifTay5LLmHVbtPU8uNZAEqEWKCmShKyXFeOKJWsWPFwgTbjGoBLc6W?=
 =?us-ascii?Q?tvB7rko9YR8VyBYC1fjFKI/vPgzcIzGQpQYoiv5Ka2jHdHKWlPfarRUE+w+Q?=
 =?us-ascii?Q?ni1e3fSb7YAb/oh/lBc1PZn40qmIA9pYxxEPkVwGDbgSzMfDySMcXlXujvqn?=
 =?us-ascii?Q?s620ZglcuaI7WaM1Gprag3k62ZCmIAoPiPaqUi0mwhzb3N89FxA/d8ETA967?=
 =?us-ascii?Q?sVfCc0pdi0ZU/HvHmHx+2q0AGa+CErNJ0b0CJ+bGpFjRl/u3hOHSV8CunS1R?=
 =?us-ascii?Q?Z3ZegOP7pOMhC+yGgyThVxinnCYFIRWMfRZEAE8VovDvMyootrueNg/gMJKR?=
 =?us-ascii?Q?fjfef0ZwuM0UmVe3nbPjcbY79m75WH0kprZtfKTw6uqE65yFssL1PmdYNE4e?=
 =?us-ascii?Q?PHpxqKRyhuIoq+QzWg+0gB8doTLTYxMj+B7aeE6A8cvk4xRZur5Qe4mTC9w4?=
 =?us-ascii?Q?9D7mKhaDB1+whdkbskWzU0Hmkuwc3pBGDrH1k2lQIrowXkKFFcw9n1lwSpi5?=
 =?us-ascii?Q?EkPyh1kS0ECRR4uF3uKYtnGbeJHLPDDs9VQVd5W3XsdrPYc1xL2Jqd9B1pra?=
 =?us-ascii?Q?AhKrMvz88jQs8uMzXcU4tXRRUD2xsqX7NkD64GWGTpZYpvieXwsnR4HZATsv?=
 =?us-ascii?Q?5eP7xcQBvZ7M9oW8xDF8wO4htnJ85TtDwUc3AWOmqxZbRJDxCkbKKs0t/FIT?=
 =?us-ascii?Q?nxTUaicxZsclARYirsf5ZNvGn890HigoEZsuhdy20OaMagz1PGziq/w4V9Pv?=
 =?us-ascii?Q?Yy6DoWH/p31aguxFbamj7VA2haK9OmGfFXmBAQsavAF9nWIv2rRk9Oh30nhg?=
 =?us-ascii?Q?HfI8bh3Jq3947IneeXjLPEEl2oUCh+8dS7+NlKkyVd+NC61TkN8iw/qhxA91?=
 =?us-ascii?Q?XM/rZ4+xM5WvfWeYtp+axfWF9AQGO95IWJtQir1//7i4xGuaNJp21Ab9sVV1?=
 =?us-ascii?Q?rH759qT2oY5yr3AG1pRXjkJ8eZK+qyKDwN7lZI0q8PBnLhJAJpimD3D/Kkw1?=
 =?us-ascii?Q?CxwoEbuVFb+buNRWrFbCz774PUMz8X3Jt6EhB3rF/Yw4unQnWphaN2s7ySTG?=
 =?us-ascii?Q?pzfDk/pRdBe02I+BDjPDlv9fq0DMoQUntZ//pXGJFteVFcLIph7LPwsaHFJM?=
 =?us-ascii?Q?/JNA2DG5uCuNEJNStf1y/qr1lIph3LlXUXEHzHnUwA912b+HP9uUOScDGKdP?=
 =?us-ascii?Q?VilCzBqWG21pS+TOIg23sXfxGEFwOQOjwRqc94Pd2sCRl5xpGUMri1ub2KF7?=
 =?us-ascii?Q?I62KOXqeG4i2H9HMARAAeMdNegX028zvN/zlqwowQtvFBd8CY9HmUMyf6U92?=
 =?us-ascii?Q?tcB1wWYP7EXcuv1Y2mGhL2xra5+p01MIXUCNtjtAQdrxejlQxS8esszZDDZO?=
 =?us-ascii?Q?xWxNck2pwZvfRi+GMqNBNf6bcAS+q+lC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 10:13:13.6417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2551f4d0-b2dc-4541-025b-08dca7db666a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

AMD Family 1Ah's RAPL MSRs are identical to Family 19h's,
extend Family 19h's support to Family 1Ah.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2f24ca764408..1622f1d6aed0 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1285,6 +1285,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1A, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
 	{}
 };
-- 
2.34.1


