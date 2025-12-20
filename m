Return-Path: <linux-pm+bounces-39737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E15CD37BA
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B6783008D64
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD52F616C;
	Sat, 20 Dec 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="O47Jn4rM"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B32F12D3;
	Sat, 20 Dec 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766267654; cv=fail; b=E0/SJyC0fhHqh07tqBENGx6hHZW8WUKNDACTriosWIsaaGxpJ4uJ1ZKiDwYGVK7otxu25vli34zEtjBb9mGzuQYG41k0/sWxm6/fasEp/64I2Mfj3OaW1Y5NaIsCt8iO8kK1GIGk8qSMs0EtMFgvsFkxLvpz6F2hpmu8pU2VdRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766267654; c=relaxed/simple;
	bh=r6OPlZiPLoSgtFORyyH1556suQEtBpAndHQ50QiHylI=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=oG/zUBZ/X71QzK6SHCKxLqrCC1PWmougAWRLVLzSCaCapbQV34JtTmnT4ETRovM6eATeCYmKaLZ2fGJ3oq8JUC5grRE54Y9clWorB5pMii6E6HhS38HOtLDOpwuMqmSPXJdAdjGrPVv4oFHsqvO6Mr0rONrWf/cDgANuc01PKQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=O47Jn4rM; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5DAM7UPPu5fUP7DGzTVp8wWJJJseR2/UXjFmljzirhdbdA3etKPSAHoohaLvV0XzPofEdRx8t+LLxtKPrQFcXfY9gD1Eqj3TM2gzd81Ie999hnKQWa4YI1mZxm843bE7YVVBesG/9HwdzPDsu7WE4C52QwxfutT13BBI9xyvP88vKbgTdae65Wr+3u+fOshn2hmy1QJmrxDiW7Z9vtLwhDA5ULOkfLlJUS0Ew6lHnciGCQjfwLxNGJEpkuHpKhIlk8sSdqN9R0PcXUP5o9UsmFbcqikZsbcbKw0WrMx8lkkIDE1SZaFPdLgK+epKxOnQfWESXUIDiG9OEsp0fr3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohph213EUeoR3z09xL9xg9OLMfTCUHebtCyOomQiGWo=;
 b=m9KMZOQ+yZk1G9vOG4M5h89Yvk3Aunk/F1xofeC3lcMPefbEYlwW+ilE6K9HXq+0c/djts5pfCDUaxp+IKVb+y1kgbAMrc1w58LpFdvXZgM4nb337x7peh+r1g1REiAaPkHw8z12jJP5yOlfrjFYKUGS+CrlvIyuzGPuY8rBUmpPNSAIrQLkG2v7KiJWOm8HJi7K6L2qcRCrUy5zIPCKD/D2z2QCY99Gw8ysjEXXo7tEHXwZrk9TUA/5ki4xO/gePcjUP6ReBxpWunJckaEDk5WdUQyVRmFooXmvM7usjb+RLPMXw9HisaMdhTANJjxIhnL0gTim28yNPzqyRnDBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohph213EUeoR3z09xL9xg9OLMfTCUHebtCyOomQiGWo=;
 b=O47Jn4rMQWYh+5rjj7GRPh+W3FESqCA62XpupP4ZQ2Bjs+pymhr4ht6zJHENhX92HorW8NN1d2nqu4wKmtVch4Wt6q2MIP4+WhOkc0ql+98eAOhpEjN18vd0NMJS44otc1O9ZofoeOinbBB0FWOkMG148vlOPvCeZs9vNEq9kr0=
Received: from AS4P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::13)
 by DB9PR02MB7868.eurprd02.prod.outlook.com (2603:10a6:10:33f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Sat, 20 Dec
 2025 21:54:09 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::1e) by AS4P189CA0009.outlook.office365.com
 (2603:10a6:20b:5d7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Sat, 20 Dec 2025 21:54:09 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 22:54:08 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Sebastian Reichel
	<sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] power: supply: bd99954: Remove unused gpio include header
In-Reply-To: <cover.1766266985.git.waqar.hameed@axis.com>
References: <cover.1766266985.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <ee74b461a8b8f02093e0beb519a1f0b8de7b64bc.1766266985.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 22:54:08 +0100
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DB9PR02MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b74ac57-3a46-494b-3169-08de40124df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78d+68GtGMcW3GlwOFkH+GE+oErseZ+9VKM/NU4zfU5KUq+CR52vPNOfzyo0?=
 =?us-ascii?Q?3I/4jMxLubzx8/uOIONuGJfW7WK0mzsoCZQ9Ieg9hHsnZ4tZtenQs8iTmadT?=
 =?us-ascii?Q?abtJur/lllV7mtKjl8MU28sH2cYxDbwm2z9nfJZzFbHx1NPRH/8fTWx3INKk?=
 =?us-ascii?Q?51T9+K9KB0fkirX1w5XGDsmS9NRYPMT825mzpxMv1Ms0cQvqfXYUe2jbDmKi?=
 =?us-ascii?Q?apMGN0fdKYV1fpJj3pVjN1C3ch7nc1Sf7gOaL5M7U8UZoRpuzeHMa/vhDUI9?=
 =?us-ascii?Q?CXC/5F3jNYAI5ZePnAyxrA8FqcWQHFvsHdM3jRK0YjnSC82y3vaw6tlV+1l6?=
 =?us-ascii?Q?zDuyALdoXrrJEif0CAlSuVc6me2wLxIy/1aJidG5N9uw3VK9gfCfKW6ll5uF?=
 =?us-ascii?Q?P+y6S0Mh06itIG/79Isx51hmmLhwnvtbEWSMhXcJMd+Yh0D8RMEy0riQEDad?=
 =?us-ascii?Q?BI8tYBeDr/wIHE6HH5Qhut9BjIfo6TJMm6/4Id57gh6oXAhO4kyV1X6PqiWW?=
 =?us-ascii?Q?4PGq20Gx997jyo71UJeKf2KBIars5zQbq0NayEC2eIRJh11Xj74oFXcyzIAQ?=
 =?us-ascii?Q?VG1JRSSaDmiozFYhygrJ+DQR+udScY1ATWvFqPOh3PxMrDM2JPctKTMa7Q9/?=
 =?us-ascii?Q?o862OMBqp4+Gj1vG9ZqM3KFE58zExDwg8FrBbbVY95UOkpWR/al18V30dG9d?=
 =?us-ascii?Q?JRxQxGpT4bgkZvlRjNVdlhr13MCKMNGMfV8Rd7TWkUTEeenFOj4KEzbipa5t?=
 =?us-ascii?Q?Y9DjWReGXBsw7AoXR/AVxJxoqye8qnp+cKb3MnTVd+XkkP3E1BvZ/d3LI8eM?=
 =?us-ascii?Q?jgShqxx8OqidyAxan3CaBxApcTJMAHDIcwZ3mrrOZE9tZXBULFqwkKyCKyIL?=
 =?us-ascii?Q?F3JYwc9P+o8mNEBY0yCDlI2P0T24fRl1bpR3Bo9Omo1bIr3br960y7ufqVMt?=
 =?us-ascii?Q?TsjXZQJxvBYOPTGPmNbKibOw7oBVGFi7X7KdAnqVEjUIaaPdKM3U+OGFgucY?=
 =?us-ascii?Q?wWmrf4Q5uziPYLqNz4B93tHTd3wp8xNGiLSGNfwLlnU5jVSiBWWhM98pCP85?=
 =?us-ascii?Q?MydN9RHmfAjWYYR8ZaJeAGL2ZDqEDb4NfemMtmKhm9bIKOCgAqWRTdDWTI0w?=
 =?us-ascii?Q?OzQW6pS7xNqRZsEyKOEb0+pN9i34xjCqPLGFj1kdLmKN7bpY5F9qxuTlzYdT?=
 =?us-ascii?Q?vcApFir3rkIOhrX0vp4pFcTvDIo4N2AiCEQgQP2hmlwe65Abc9ht+tNYA9VF?=
 =?us-ascii?Q?8IxNfYdY+uyRlpd58SJC8pQJhhsH9OnTbENXgsbwtAwk9mGcYkKAZ4GfNXda?=
 =?us-ascii?Q?7N34MfJhm27u72fWdnSFaGvvPCSir9y4RRXgFDcYc9b9wpHudGMieDmnh8Xn?=
 =?us-ascii?Q?4TLvn/d+FWdW9rND7Dywyd3/ukeg24ap9wMdjlB0crn1FYZLfIZ5iwCaAfBG?=
 =?us-ascii?Q?AV6sgv1idxWqHy9O8Jtx/CB60h4igCdkG2H/Gnq9AHRUG+XXqNB6jGLohThu?=
 =?us-ascii?Q?KXsgAKIfC5YwURlO4baJKpbNW7KJl0kC3FlCoeyEazf+hy7Y0KmnxfPBP5Yu?=
 =?us-ascii?Q?/SGjn6Pe3+mkP2ymAXo=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:54:09.4507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b74ac57-3a46-494b-3169-08de40124df9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7868

This header file is not used anywhere in the driver. Remove it.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/bd99954-charger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/supply/bd99954-charger.c
index d03a70cf84067..5c447b0882233 100644
--- a/drivers/power/supply/bd99954-charger.c
+++ b/drivers/power/supply/bd99954-charger.c
@@ -56,7 +56,6 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
-- 
2.39.5


