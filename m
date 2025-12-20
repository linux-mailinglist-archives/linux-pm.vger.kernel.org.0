Return-Path: <linux-pm+bounces-39734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DADCD378E
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 778303003132
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230F2F83B2;
	Sat, 20 Dec 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="T/VwD3jq"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC32E1F0E;
	Sat, 20 Dec 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766266805; cv=fail; b=bB1v6ugyVuFhNF5V1h6qFOFzxyRlnhkuXKocpMpPaXr/UeOQCbKdrnalId8OktBR85JzHWXuBNclf3EEdzU92o9wKN7vMzmsH6uRdR0LSzp8pEhkRuI2UdKMXmmMEUGFddqozYijJXYO9w8BDF0TK0dbgFgq4BuX9Prf42lNgo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766266805; c=relaxed/simple;
	bh=7YaCLmdrGL3x4T6qNuLV97JOvB+dTL2J/7TCXEumQ1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWmIRZFifXziChd8ikHXCmxXSkhrZIBCA/TnQaLFZ8ZVq0uXLI7BVA/pjZgHxBNa0xH+VsA/Xj/kfknxc9Wdca6BDZy4AE9+S/cbnigSU39LAuApyIl5Hx60EFRDePzfnmYDCBPxvG/wUzoac13XfwHaPuJ88KUiGG2nx3i69Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=T/VwD3jq; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEdApaBAkNqFSb7S/xFXFylRzTmN2ZffRwc2+Nr7MnWkMCxbPPkYBp888GVLfzeoY4un33e9Qb68eiRS5zgzpxbL0MSEH83cb7loL4l8/1jA7CavRKk5+nNWbSQnH9AxEn+rq1xGNh48dZFpoWZHUh0n5zZxnvvX1rX8ir+EUTVJeCGaZR1G5RjH0Q0Cn7c82zMDwnV4iwuqTT7+TOwTGbNlUy+g+m5UFyEsUl/T+oNdGIOZz0rpNOlug5xv3FGwsseEoMvOj5vTwrMbcyF41FEt+qcAM7tsu8G+CXV//LZsb8JPtHzWkoqcdfUMqXjQNk6KxtS7HoetxOcgtwE9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KELMdIN3cWjqzvrTDsFzmhkZ94e1sgpPV4LAmF2F9c=;
 b=NzBBkkw2aUs0IgaJVwlV0G3MWy1Wu58vCGZu325iXPvNYTYIrBYqAFdfs5DJAmFW04ti1sTITF/AMGLChZl08R+dQm5s86DHOnZVNeF062YDfR5xXmZZMq2YtPyMKiky8Fh1d/geMueBqhVRrHMkdR5tRxOkq+RhqnQmhuynFA+yLPEODpY9RNzA7wMceem7DrLIg2TuAJxCNbhEL0LH4sFqMMUinsRLZQ6hYVdgwE9ajMlnbwqeiBLhHIHDyC+LC0GkxY233FsRtuk8xuh3EGsZQh6oCaRkQkd2q8VLn2GVBhoWOhcLLFf9YFpp3QhhFEWodu+dFlmmdXHdPNwwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KELMdIN3cWjqzvrTDsFzmhkZ94e1sgpPV4LAmF2F9c=;
 b=T/VwD3jq3j1Q+0Qmh8Elj7MHmsAXUZWBXPyzLCZXqU+Rw8rZn8izEIK0lrArtcjQ6mDS5tLpw7jmNZw09Ce81RM3kUXRUVGjvnL/5VsdzDffdu8K5uS5MSZxzMLzVwCzz3geAAAS1VldTw5aquxOCOQNIjvDiGJTpxxSEBBh1q0=
Received: from AM8P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::32)
 by DB8PR02MB5788.eurprd02.prod.outlook.com (2603:10a6:10:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:39:59 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::c0) by AM8P191CA0027.outlook.office365.com
 (2603:10a6:20b:21a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:39:59 +0000
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
To: Tobias Schrammm <t.schramm@manjaro.org>, Sebastian Reichel
	<sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] power: supply: cw2015: Remove unused gpio include header
User-Agent: a.out
Date: Sat, 20 Dec 2025 22:39:56 +0100
Message-ID: <pnd5xa0zvbn.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|DB8PR02MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 38676fd1-a045-4cb6-43d4-08de4010533d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9SnvS8MxjNfa6NDgpHLBtVG2lgqHVCRuRk+2025R+vtFBG42yw5OvNS7Zxag?=
 =?us-ascii?Q?zfnYGOzTsGFlIq+DC2PZ4U9CsvRjHiA04ySsXS98SQpbGqf/PMfINeJ8Zrie?=
 =?us-ascii?Q?Gm6xQVhfzEDvksaj1j7naqsY75+64KbsYCsTc2eq2XUQYCqTdKa7IQpRdW69?=
 =?us-ascii?Q?BtewUKgNy21ulwFQ2gEqF+FoeSedYdySbxxGTsMsD63uW9BmoxOgREBZH7r7?=
 =?us-ascii?Q?n2qXYLarlUmsPAadbOVHYPpy4UkHtm8S2Pp+UdB1wmw472TpHvQrUNqy3tdA?=
 =?us-ascii?Q?p21OhHOMOHDBSxorIlvGsxpaN0t7Hopxhs+F83S6YMRQAmsTs6+ElKVfxwOe?=
 =?us-ascii?Q?O3WoqYtk4opy3PZwxPaOOrgeqZboWxti2+dKYlknoABcX/n59RUb6C4ReP1C?=
 =?us-ascii?Q?20WnRtjmBlvhfo5kAvGTDo563Oeia58frETKRipIdfDdBdxTI+pQGM0H5bBb?=
 =?us-ascii?Q?u1rkDOLXMiWaUUOc7BiwG37XTmlQF/2HcYyut04iB+e7QHqFzl2Dp+cLcriJ?=
 =?us-ascii?Q?bC9kAX/Ehma+PI5oAkMMqhFf1+pvjSGyaLLr4ufrs8VHK9im2JEGPkTxyMsS?=
 =?us-ascii?Q?LRKCu4EDM1IVO9vaC82ADMMlcqeD3b2mOY/phyPOhZ9ioMPadq3UiMDB4QmS?=
 =?us-ascii?Q?cHWdZfLFtCD2LJj+Yz3XNhiYD8JCcjHjrr+5Tjf1VyV6YSnkillT9l99ii2n?=
 =?us-ascii?Q?HYdsLtO0iTlqgnzGqRP0gYysmM6oquzgY4NlULldVJlcATuwHefPaHDKMazY?=
 =?us-ascii?Q?2fyXl0ies6PCL5lNL7RMeszU3Pbpzz5VAwYb0vTqwOLmt2jNq4OP6XVZkC9/?=
 =?us-ascii?Q?9Uq9ldpLIxZ1qSV0kYd3NgUzj2vQB3uTdZLW0+lm5QQBaBhGk+qoD+FUeEaP?=
 =?us-ascii?Q?YmbiiwJl1IpsCr8dN6STiYrB6Vb5O9H9VSBZevGfMnTdKuqSl1rffReGpWwj?=
 =?us-ascii?Q?3EsvrmugVPVOdSr4n9D5HLuUX4cDQbsPTeCer+dWReQ22o9kJ2MegcSjSZE1?=
 =?us-ascii?Q?LOWlFE5i+mep51Vm9JRLyPvhDKNg4l8GBYMpyePk7lrzaIcsMlJv6ngu+ouZ?=
 =?us-ascii?Q?gsVCLUivHGs4/oOh+RRgBGEPMM/TaAbI5jJc63c4QK3z8VrZ9aMEHUWsrUYx?=
 =?us-ascii?Q?8bp32PEMtjoYCbcmk7h8slatTzsMw5DXXajslTMrwIoGbrNfRwfwI9Q9pqd2?=
 =?us-ascii?Q?uSD65XCMFNpUOopuE10LogpX0KLdJ2wacJonqR0dxuhtl5P6LhxsiiVFwkoY?=
 =?us-ascii?Q?1hX5+yaN+EYoNuqudDhWtmzN8cfoF8RISkGrXhAqJLLc6pzOAleEB0fADtfO?=
 =?us-ascii?Q?0l1wqvHdWRJDCoKFvGDKlloGxNzzxj9y0+5cGEjkRUdC6UJef/Qdc2QaDo3V?=
 =?us-ascii?Q?eizdBli79MRY2yIpmoXyxGav6YwXauvFkrF/zrAR7X8cH9XwpVUlMLqX4Squ?=
 =?us-ascii?Q?jJsy7FwonqAuUvgy5psmcI1JJ/87/aFSq79XqhWmhXDBWuqbzRdYPTi+uU4E?=
 =?us-ascii?Q?0ja/UasxCiePtw9r+KYawUBvfViy+zifCDyZspyS56B2kuxQDl/ea2ziGw3J?=
 =?us-ascii?Q?03y4FPq80f0POz8jJ3M=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:39:59.2957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38676fd1-a045-4cb6-43d4-08de4010533d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5788

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


