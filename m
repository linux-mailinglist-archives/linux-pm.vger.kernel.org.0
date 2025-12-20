Return-Path: <linux-pm+bounces-39735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 355E8CD37A0
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51B95303ADF0
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC82E8B8F;
	Sat, 20 Dec 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="bBWXOkQU"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B42D8DC2;
	Sat, 20 Dec 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766266808; cv=fail; b=qModnvl2IDLsX84BWEwbd2W1FyTdqgRxaRRI3GgShkAzLT0eEJMeMk2x5P+t5lAyyD2EDa/IRLHQv6IWSUD4U8SKLqS2OMSBfqkeetjHHLhlwcvsEidiTm6u1Bu0uw6NvX6fkxyaLAw+FiwjF0JGR9kEYLDOA75kY74Vzgfvtrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766266808; c=relaxed/simple;
	bh=nV8upDMteWN35B5zSfUaghEx7pyKkoynn2ZRKCXXMEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qjMib+8odxQJ3sdREyPunGy/qIrOOdNMTQSjsST/EnRTj03YAE9jaydju+9CWTecMm9vwlzTzcMUQv4dV1fP8gHgVRyMcR12lTvpvwZtT/mQVUs9wo7OH5JpGAbU85/c2O9+Xe8W+ZmsxCrzAVbAL1bUtDI1iorN138rTqhQ3I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=bBWXOkQU; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiE7LDZJU5FN8nMBtchXKTwZsrRkJEB6MvlWmnvXTxC+OOqNMnJInUxs9M5l4vuIjxqeax/M+cXoNwzAr/oows52EJsJWwft5B3DJFffonreRmCUogRwMSOa3fb+wsJqyb3eTasM+2zz4K/0tfEEk+n3JjGoZG08GsNiEAT9CNUuhOtccZBnvICI4ysTKlZ7Bvk+P+0QNxO2LxqtOKshoxSYxwFkNEJYCQ5wOPpFYGEp4eaRSk3DITGYEf6D30LuHFk5ftk8Qgs9ctrcX57VQz8I/LPeAmY54yzG78PEhX1J791/v3wGn8c66YMCsrOMpyQF+c6Kac8ElDlzbXxgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmPIxjR+nF83cy1XcmbA88yv1OkhwXorvPRcczYpDDY=;
 b=EhZ1HRKgUdMeSnEWr45KSxQOI3zSat+lbr7w1E+Ctm+lXnu1ZDSZhj3AYpcTcUbkyQXCzxKn8AMPP1+8hSkqyQavW8jr17spCwhdJwF/u+n9KJZAJ4UKwqtCw7UG19EJ2sk0DlKooYIHHZBPAmFEMgoeZ+w6Rg6c0phXqncd+CkwnmnKHeMc5Ux2rvk8gKgkf666ULu6R+b32/k1PCudCqkNXM06laGqq9FiejSjJS80EiezkKhuyMeUov0lTKQ6oHNnY6Lp6d89YDplGK4kIKIxIlDcKDpfFsS7ysZF/HphjxQSzoEZk4SeXgzsa8Zz4Q2uiTu/kTLWt6OmKWfaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmPIxjR+nF83cy1XcmbA88yv1OkhwXorvPRcczYpDDY=;
 b=bBWXOkQU0+BbAUcKb4aCh3wIiLIzwdMWkPmBfKFmMqUYiQfhSjcPgWGlLgvt99B5PVWTvo4ARJ0c739EHi3xZ1fbB2mrhA1y92ivIV+bleJOW1Y/n7qUDPrD+Nja+2xza8wPwjM5iYwXyk0HnEQuc68WnVO1qnQXlbCezIcpTHQ=
Received: from AM8P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::14)
 by PAWPR02MB9829.eurprd02.prod.outlook.com (2603:10a6:102:2e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:40:00 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::ff) by AM8P191CA0009.outlook.office365.com
 (2603:10a6:20b:21a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:39:59 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:39:57 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] power: supply: ucs1002: Remove unused gpio include header
User-Agent: a.out
Date: Sat, 20 Dec 2025 22:39:57 +0100
Message-ID: <pnd3454zvbm.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|PAWPR02MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e684f65-f2e9-448a-974c-08de401053a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dBbz5TgNKHRyeJt4huJBfM/px08wJlNn9KxWsT6Wc6CoyXJtp0dk/48zdSJ?=
 =?us-ascii?Q?IhJEbcXCbHIC9odWRi76Ta/XB6Y/zC9fHAFBfjrjyABwqTb8oBqW0mkduVK6?=
 =?us-ascii?Q?qT0OdUE34gXEeyp1GuKPH/tta8wCAJU/c/UMBKXBEhV1lF+aAwWjigubpRue?=
 =?us-ascii?Q?KK3TkFiL/7wHX65jfiiJYakV8BzDPT/DRl5xEEXCt//r8ESNaLWemZToJT1V?=
 =?us-ascii?Q?Wgsbcr6FKTdD5uu0mJFvz7nkr5auQQN+Dh8ZAHRF4CRDXTh5rWu07EKSo/JJ?=
 =?us-ascii?Q?IvwIXmlNbgkBSwdBPz2ThwKR1h5NUnJQmbyEF1UZLaATGf8OmYgL2u2y3fQr?=
 =?us-ascii?Q?z6UCeRFNSPj3w+lXmC8tOKOMV0nItu2WvDobMJMwxc3jxVFzIckThpAmWRM3?=
 =?us-ascii?Q?YJ7PdzTHRtvsi8fEIRzz7isCRr9AfCz5F30wV5REMdFRPFIrMC3zGQccjKRc?=
 =?us-ascii?Q?PTuRE6o9eXamxhk2pKCsc5o5Gjwvh4ccOwfK7J/4Dc7adrMrnvENmHPgM5HG?=
 =?us-ascii?Q?72GgEUSzLU4ETrcBXMxX9uO3XFhk4MpWf3NzkQSK0ErxLwQR9uGbPHomSnsE?=
 =?us-ascii?Q?/dmYkgtD6tnnjORT48eQPDAZR7dTykk5vBgiupFYEdZfRMfNjYmA6bbz0Dm6?=
 =?us-ascii?Q?u/XwqZwzBOvjzPjF/hlseWHZSszDTRA90tNfCMD8+hu3tFQ1NrM75iSlSNjN?=
 =?us-ascii?Q?p4SGIACP0i9njoJb7eGzjI4wW6Vx1TAqkID/k1lB5tKSp9WXD4QKgrOILqgA?=
 =?us-ascii?Q?6Stb4lWRef08teWnCKdmx9ikJPVBCI0gGKuyR70ob6KIaG2p852w3/U4/lJE?=
 =?us-ascii?Q?8ledP4YNIHaLfPdq1kUevCiNEDUiXYxaOJk2fcxTBU53lQ5pkL7KE8FOQIoE?=
 =?us-ascii?Q?x3BiuXoB0sac28sNaIL8wIwO45S3eKxgbMNktLDZFKrddkahOxnOK68Upm6e?=
 =?us-ascii?Q?k6QVUbRkJ9JMKu3Cfz3xRWW7vkqbrEm59T+H9HnOw6vXwotTULPsrl64YEsL?=
 =?us-ascii?Q?KMTq666fCx2iyKEw9i6OVH24So6eIsOVWTvg13MhwPaQGsMRtMWMXznHQvMh?=
 =?us-ascii?Q?a4LtDPC+6IG2XqlEGcyyjfNwgfSL7ICGcRjLlijoEO8JgR6JSQUobf1LwPu7?=
 =?us-ascii?Q?Yj7nZPr0yvk3GbfiVJ3neBlMKJMYHmgsGgzqr3n6e2XclVorwtNWVa0FqUtq?=
 =?us-ascii?Q?7XKllvk0mjWKFoxEWaXALiwwst065GFTZb1aGhNL90o2LvTSWu3/LvHQA1fi?=
 =?us-ascii?Q?kgsRebM2lzdPr1ndGMS0p11GAwvw934tgGTq7Ts8ncNtdjnv468bKUuVOD8V?=
 =?us-ascii?Q?6+ul4QWCWIVSGL3qUJww5G2zqV39EF//ReQvZfSTeAisWkkxxCOWSz5eTgz9?=
 =?us-ascii?Q?D9Xwj1jC3nIoRk0bVPhEh37l7nHoKsUmvd6WTccV8lsZzMwVr+SyvFyEn6ge?=
 =?us-ascii?Q?7lFBUV99Mb1LBdhvMcIyPkkTWN/ZS3TSTjsFfg7uX8U7NfraPFt4kHuEGlL4?=
 =?us-ascii?Q?2UHQrnA+KFm131sZLrhEsqep4M5TMKE8CF9wH6uO+WK6tNYfn3EcEA9PlrF5?=
 =?us-ascii?Q?HtNe0LwJA7RGZYHVCcw=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:39:59.9861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e684f65-f2e9-448a-974c-08de401053a6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9829

This header file is not used anywhere in the driver. Remove it.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/ucs1002_power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index fe94435340de6..3f44cc902f84d 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -6,7 +6,6 @@
  */
 #include <linux/bits.h>
 #include <linux/freezer.h>
-#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-- 
2.39.5


