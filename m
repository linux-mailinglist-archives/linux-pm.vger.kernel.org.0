Return-Path: <linux-pm+bounces-39731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4972CD3788
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E765F3011ED3
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455072D8370;
	Sat, 20 Dec 2025 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="q/Y9Amcr"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF629C325;
	Sat, 20 Dec 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766266803; cv=fail; b=ZAsKAXRS2RLuzHw8rzmuXQesQGMYyQtH6kZ5cVhaOnaaQg8k8qyat/Q5Po2wgT3z0Qen5b4xp5VRnoekOVlOu/W3hhq+I4huY0vHgyF3BpYyIPGWnAIf3xE3FYrPO1JEcJ6z8ZHDnk14gjshWL/gKf08w4QqcTCrWwLkZ3YhWOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766266803; c=relaxed/simple;
	bh=HaZ+btVsSSkOycn46ZgPFoo0OiMCKsZCWcp8JRrf1IM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B51Pf9/oXZCKOtoz00ojcQEgL67QeXxMKyVuk2YG2Y7AsuR7JB5iRF9IFTrvzcSZ9S4wXnmLNr4ueCG1Vcos2RXsfXbqIRyj3mbvhhieoNnhOtyOFWchq3A9t0C1U2nqZvQjnTLci5D3Vz/uMmVTb9WAs11NjNXgOwRsAqtQEPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=q/Y9Amcr; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYG9M1xJ20rnf+Yiugn+NYGdaJn7M+xGYk0xaMhOi5DlluJBXlL8PN+TmRoey4EZeQwkLFlfrKnAMW2w35NytoD2/lUzpJRc3MC40qAVlo4oQ2e+h1SU6RO2H2vVyyECw/NXP7ts7pgRmlakqcfPmX+w5e281RHaLYb6pTv0wAUMgq0W6w6FbXuePyDfwPvWJy4drDEzy9LFuf0zoM20iCht67rbyld/+UkKBWS7Q8c1Bo7UwA3eueXuuRsRqO3I4WcVdngBlnlBWHp5n9Ysc/uB9RP0d4jfDP9LnEcdZTGnVcLNVjSkAviARnuy6hZD/Z+gDVL/dnwY6Yv7Me1RjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wff7TPCndBNfAhqgFG3r+4GuCKBzKD4rchHhvvMDhRA=;
 b=zKiAttEC01NvJRcCidQknTNrPMkJZorZVV7SgvC524bb+DqjXxR2F5OUaeVqC9NPOGD+7VlCdBEqgifCR2eC4PUN/c9+bsGUywlHWYxTCVHjXBDw1wRtIYlmO6gRgDzs2bti4aCqsswW3SFOi5ml0ga0hCwnZmewrV/Kx4VHLRyIE36AKss5TA+EXoxy5Sy7+aRAOdbeKjf8sXYvs3HcmnS54j33B4/PpH3Fl4xB4uRsEKlVVajXTacEX2EB+dB7wpIMgK+6XLJdYfZKrNBbKrINWxwnYNthZSdt1sC3Kl1pzcPvuwNp8dE8Q09m9B/TJMDTKbAEV9JnbVF4g1t/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wff7TPCndBNfAhqgFG3r+4GuCKBzKD4rchHhvvMDhRA=;
 b=q/Y9AmcrPus41go2WrZGe9RThjRQOTrJkBYdMDO6Ffm9BX4AN7kcDUhdeUChqWuOyM4a22xOfgN1OY1MtO6FqSSTIYHxVokFhMhy045/o2Hi9FakRZIA/CKP7zSbl9f1F96ss81sSvjPdWNi80O586gjCt4BEVl+VgBhGK8TaSc=
Received: from AM8P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::25)
 by DB4PR02MB9622.eurprd02.prod.outlook.com (2603:10a6:10:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:39:58 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::b8) by AM8P191CA0020.outlook.office365.com
 (2603:10a6:20b:21a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:39:57 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:39:56 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] power: supply: bq256xx: Remove unused gpio include header
User-Agent: a.out
Date: Sat, 20 Dec 2025 22:39:56 +0100
Message-ID: <pndbjjszvbn.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|DB4PR02MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 007eb692-fef2-4820-d4d5-08de4010525e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hu+OC4RXz9CjQXRrwG+KpjFTFCT21gGJrZ0YjZ6ru8VCRhIMtEzXC1crDaJj?=
 =?us-ascii?Q?JCcfJJrjEuC23Zr1h1/3nPx+gAnDN3Q49AQe8d+mEULK6kR3k9YmN3jFWw/7?=
 =?us-ascii?Q?U5NWGExRnOBjwCIci5ypHHCHI8LQJ+hPuCfIKjmZrj8YYUlpr+O8vesAgYC1?=
 =?us-ascii?Q?YEKeXnkJsGPcBGJjONKco0JsUILLrFFXb0n1Ddqlgsp0Q7PBl1TaBkFI9gg8?=
 =?us-ascii?Q?uYdXLSeWZbkd1nfkFfrNC0tgPuzJzEZTkXwfkIvxzreKxLv/FM7ZDvp1nLAz?=
 =?us-ascii?Q?ZK8Hpbs+Za2kJq/RLPJVTgYvuQF2YTGZ8wvVwqvLqJgObBkMNS1SQb1RgTyp?=
 =?us-ascii?Q?dLZ3fBvbRwQzo/GtC2s2w5YKZPn4qEQKfldtlkN6ECLpjpyPfxRmKWSZfsG1?=
 =?us-ascii?Q?puJqEiOGx3rmhnvE6Vlpd09TiXLaXAnnH4juk1TukkzD4Y7CZho1hjoBlcPo?=
 =?us-ascii?Q?dzbzSlNWZaEXJhqHHcsw2anEfi2k/xPTjmrfNcmUPWgxvXTYlBlt8DQmHTZ/?=
 =?us-ascii?Q?fl/1jpd8g8yQoEW9FQ9EljXMRkLgRpAN6ugE5c8Tw9hEDAqCThoUAQg7Bcz7?=
 =?us-ascii?Q?hX2QjDA9xMiv5d1wu2QfpTOZQjql/W7iINuDBh5bjL06sidfJ5P4teukTmjZ?=
 =?us-ascii?Q?EXRAn/JeJQlvOPxMwz+/VsYysyAP7rDrQrvObp85ykBE0Nqbc264vUVNAQHS?=
 =?us-ascii?Q?EYKYGPIet3UyRtewF+oh63KoGcDD8TQj6eo7JMLxqrrPl53E3JrwX1/2sx2l?=
 =?us-ascii?Q?f3KMerks8xabNXTAyyRnvFhPbiuGKr8ryNmt/IKbk+SgYvVRW3c4V0fYwvPC?=
 =?us-ascii?Q?R+NsyAVQvoYtXnLRHUVHFWyQRwexOfgwdOXfGzGn9KuwXvjizcOTx2X3Hb2V?=
 =?us-ascii?Q?kEpiMlqN9hUEQTadKYQkpMcm4X6CmMt2Qtg+8OS2Xgh4GUHoEbRDQJJ9dLaP?=
 =?us-ascii?Q?rjgbCEy+pqnFb3Ab0pbKjZjniKD2ezxib4ZrU/+Hf3nBHINeKShJTc0IuQeT?=
 =?us-ascii?Q?DK+tSEcfgkk6wwXTpWMGcOs6oBIrWqAOywuxX+aa4Dp+QryTlksdimaFkgIQ?=
 =?us-ascii?Q?7+CuMEtVsZYMV50x6K7xYta0S95J/duW3W/rBRedrjRU1lVFKSqZUS3aceXp?=
 =?us-ascii?Q?RgG4vd+BEu84iiT1XXkKWCEg1gBw0dxEkWeDZ7e4zRlp0l9sI0Mfaxm7trZ3?=
 =?us-ascii?Q?4gW5mc8QChg+sEKo68w/n7XuWB0ywk7KwcyYgxCWwhEhxIK1q48Py3iPBnbm?=
 =?us-ascii?Q?dYrOmiLkwnzh1lvYSaGnAa3cXF53mT8wMR7dIcL3rXiHXNjbFPY9Xn9bhK5m?=
 =?us-ascii?Q?7Eroe9W+dFodKcCmntGBsds1R41aHW2afegvxO6DeBZ8njXIj9EDDnyQuPnm?=
 =?us-ascii?Q?Bbq66/aV/8lcU2UDUbqOexqpL18Pb0pmQIIzAJXgQIm5bRE1k/Mk+VvBxOdL?=
 =?us-ascii?Q?k9fAbfK9N5QyDHP5sPNQB5OQTT5yMLJJS/c2Yhk3RVUFDmiWap0JS4l4Gkta?=
 =?us-ascii?Q?Vjr0cDWRLCYPQPfcXcGLdcDH/iGmvGHFbLEwu6+OiiltCpXN7CqgW7DzjdY+?=
 =?us-ascii?Q?B8sCxNk98YuIdc6ERII=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:39:57.8380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007eb692-fef2-4820-d4d5-08de4010525e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9622

This header file is not used anywhere in the driver. Remove it.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bq256xx_charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index ae14162f017a9..3eb1733940054 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/gpio/consumer.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
-- 
2.39.5


