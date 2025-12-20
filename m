Return-Path: <linux-pm+bounces-39740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE5CD37D5
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61944301E19C
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46092FE048;
	Sat, 20 Dec 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hL1dMESz"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475C2F99AE;
	Sat, 20 Dec 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267656; cv=fail; b=qst4bAPIpwJjgUldAD/w0dn3U1qh0MT+9HOx+qyd+OPGaqteakzuWCQDo7bGiQ/otI685uXzndbxXcnI/Or37eTCzu/xhaR3lk3iLf5yHjTdr2igEDd446yzkdCN/L7oMtHUvHGqXupt4lzSiEDtSBj8drlTya4GNi6YfwO6q0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267656; c=relaxed/simple;
	bh=7YaCLmdrGL3x4T6qNuLV97JOvB+dTL2J/7TCXEumQ1A=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=DfbWsmtFpI9/EsFvESGddyCzq+ilW6csQ/NrJFgf6pDIC7Bz7u8BjQCmgHETnPpDf6SrUPm/1loTA0m3/GqpZ82a23fiSgr0wvN4K7ntxKiI60NyGCH3JzgHuCZcgxfIF/k0FDwdTQdzzqKWYHUsEuCMu9/XkiIh+I59IfhrHms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hL1dMESz; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKAfpzDnM5rlT8yO8mwl02gUPw1aOMsqdDHycP2W9YDcriDzLxYpLQj7XtVb8dQ8auLgThNSLsr7Dfr3guEvUN2L9m9kmpRSXP6uR8oCw3i8gRBWIJInh5Mtcvhw1pzNKKPF4kAPmkSfEu1slcYStFoIF4p4rsr6SpXp2klGwrKzC2uMdoO3owtw+m+AHB2T2GEjmt64pXEGvU3XuAzfQOCKzPebe3D4dV+ORgjU8A41LYOixdCNux8CfEDp7hGCGHVoqWN9fkkqq9QOigbTCCRCxm8wgls1Pw2SmhFu6TReJpCoIA9mSnd9JwiSuijKije4qjelBFm4jQrRKd6qKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KELMdIN3cWjqzvrTDsFzmhkZ94e1sgpPV4LAmF2F9c=;
 b=swNELFGJsuvqozFe7GJsCDy5NgLaPGxKFFrmVauvcfX10dX3U4zS3ho0FetRBP1/n1dQ6LbPC2Tsf6R0g/ROIT6a3PpCLKUslEBol+bcrrF0bhZHCG4bb6V974Ghjpzn8izb2FC+qPzPVz1ypJ8hWQwT0pLf9c0HPDGPZDMMwCOXQ2GrzpdnfN9FpnCsJZddjjUxWE8vnw4AUfuIJ/MY8R48dXxQj5mXHOsH4raDStezYsBnpwisiWhBAsgPGfFHWEWgeATMcM1Hacp8ba5qzqDUWc3J/ALHO1Tn/9qxEYWPL3XZG9tbyi/QPI7dKNzijVNRawD7+Mnbi7yQL3lbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KELMdIN3cWjqzvrTDsFzmhkZ94e1sgpPV4LAmF2F9c=;
 b=hL1dMESz9F49KCH9+9U/Mg5B6CcCH3DDycNOjiTnLt4EKDcsh1umfV66D1ElptcHhx0VitmJPGNnWQqmgtoxy0DRMC+8KFjMvuXlWpjrDVaGZWljmVFe+3FBV4YElKl3PmgvHRbmElYOfMKsMzOhH5GzU2D7Tr5nHaznLygJpVU=
Received: from AS4P189CA0004.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::7)
 by DB9PR02MB8842.eurprd02.prod.outlook.com (2603:10a6:10:3c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:54:11 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::58) by AS4P189CA0004.outlook.office365.com
 (2603:10a6:20b:5d7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:54:11 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:54:09 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Tobias Schrammm <t.schramm@manjaro.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] power: supply: cw2015: Remove unused gpio include header
In-Reply-To: <cover.1766266985.git.waqar.hameed@axis.com>
References: <cover.1766266985.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <6c6ea228f39f3c01c0a89d8ba545be6f3ec13c2a.1766266985.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 22:54:09 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DB9PR02MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7e0e8b-a324-4819-bc06-08de40124f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rM1g40CMdnJwUtlT7gg23UGn7CFAxdbhsZTtg+QK60ZqJJklV1CgCMYKau9?=
 =?us-ascii?Q?FN/8bhB5uqdz2BjLeXoT8f6oQ0ExVikzhZV7f1JeVl4AdQ2pBw3eDonL/P9i?=
 =?us-ascii?Q?bHGkSWtbmTXFmY3EcERXYa5Wci/I9F1u4d0bxg0LPXVxojgzm5a4xYx4dYeX?=
 =?us-ascii?Q?vJQvkULu17L78jetL/Q03cqd8avy6JP4XDyyWnK7foHMPsXvmXxlc56DFPOx?=
 =?us-ascii?Q?Nw7ZWC4xnflxwcPpq+zkUDGZZQoP64e6sCWuUmgIZxAiwQpBWo+dIHZMSstz?=
 =?us-ascii?Q?d7Qupp/xLHG4H69SeuNwbgK+DJkiFvQwR3EC1lJq0qETpUNiwKQxyQfXY7Ki?=
 =?us-ascii?Q?uij31ET7IDzy4JCAh1gNHoQTTfnwAB6thnec1xikQuzXHhDUvsQWQreYHkg+?=
 =?us-ascii?Q?vdb8G2iEHZQd1mDGM8+7TA0f9dl/2n4Kh8/PmjhHDACRIWutuqKqQjm0e3R+?=
 =?us-ascii?Q?TBQa2o96dLYLkvTVWpjbS4Rg3wHl6tucfRFImvO8tOxiES19uAjuDcX2zuMn?=
 =?us-ascii?Q?IbKhumswPGSsSv4R0FD80kWkCFcrtyJE3FF49lUScsK/omjRHc0eD/pboxEZ?=
 =?us-ascii?Q?mNc9r7s2trUILOggIB6+6/JZD5hUhezsPfNkt0tgQ1L3rw1y6cJpKCyVOok9?=
 =?us-ascii?Q?INocsaptf45ky/BGe02hDkVeyQgl2E4A+w8+mVS0PBYMLP9Hz2b8MwIkSBEk?=
 =?us-ascii?Q?ia2qCnmoxIhZRwpxzAYDoQbYxgbkVaKEfYe7ks19kogWScjY3OzeP2g9L+75?=
 =?us-ascii?Q?d/6JJM3quHXlQZMyw5ymYweZHsc9poZgRmKuajBSIsm8ldJHaZ+UYt0dv5bA?=
 =?us-ascii?Q?hM/n06yWJzdd6p/Vi/xuxjWMTm8HOBQB851AflM0omF6qULvUnTl0Bc2RQy/?=
 =?us-ascii?Q?0Beth6bbzjNlXtSEfVR8r5+fr06ubyE9H7Fyq01YHBirGkxlIogvhsqXUDWl?=
 =?us-ascii?Q?xh2gM2Kp/E6ye1WbVrI/XcKEFBzZZh70zOwVtYSxyo131puGpj2/Vn5U+Hah?=
 =?us-ascii?Q?4P/dEShWsIFJz7wwPVAQxcoO9stTE8PDt4V/GPMGkOMJTfmU+MJBzgyEkATz?=
 =?us-ascii?Q?zZ8dfrM6vCqyskgz95pfF423kbbgkL5k1Lsu3E9NJBz1w1t4xevojiWydAtE?=
 =?us-ascii?Q?5qn2dcL9IW8n0W1V+H2k4dw5lBFehVLhaYqgV5+u4jnw57eyusVLT9hnNiI7?=
 =?us-ascii?Q?HBJL4fr2fc9vnudIaDfmFFtgDwF2U0CqKbAQymtOY0AJHIlyeCkiCRuUB91j?=
 =?us-ascii?Q?0ELnA70LwMr5HMxDWglKWbwJi75JZ6jmP1G1jXRr/RW0NKTGt4GvaZ6iCFmU?=
 =?us-ascii?Q?Llen6shlsn1jMFHdK8xC0zbVdXwAve0ud7z71C1zc6JB4MsKxjmmWXXIHWga?=
 =?us-ascii?Q?uCQ+VtveB1NLTjTLAqPiUqZEc8e9K7PorzlU6Scc/HwX3mxDMcfyr7j8I3RP?=
 =?us-ascii?Q?UHXvnTBWuh/GA08WKGy6y+I9+VctAZRWgQh+dP6K25YlgIOLXhZJXcyIp7FE?=
 =?us-ascii?Q?WcwB3SjgXnXkoFldMuIG3lDl9Rn8JA7qCXLjDUQEo0DlFEvTqIKscTxjR8Rb?=
 =?us-ascii?Q?rx24y+nuCVlDUwiHG00=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:54:11.6638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7e0e8b-a324-4819-bc06-08de40124f4a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8842

This header file is not used anywhere in the driver. Remove it.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/cw2015_battery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 0806abea2372f..a05dcc4a48f22 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -13,7 +13,6 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/gfp.h>
-#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/power_supply.h>
-- 
2.39.5


