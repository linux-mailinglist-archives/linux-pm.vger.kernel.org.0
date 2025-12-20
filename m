Return-Path: <linux-pm+bounces-39730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDFCD377F
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEE1E3001FC0
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856B2C1788;
	Sat, 20 Dec 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pA8ynxiI"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2430274FD3;
	Sat, 20 Dec 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766266802; cv=fail; b=jyV9QnbRojLj+IcYxWgHv8x1QWpwEPeG4KwqIUIUnjPCh35KERuqbfNHXoKaCeEztFF4lMpOpJxt6iaadBSw92ZVOzwbBsvXyKcDNAFd7smNySyV3uUcjOPQXLqnJWFeAjSADFKu0TxSjrscKauucz1voja2H3c2bopDcLtVxac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766266802; c=relaxed/simple;
	bh=r6OPlZiPLoSgtFORyyH1556suQEtBpAndHQ50QiHylI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abc4wVZSgHy4R4QIi9OieMrjTMEj3ZCb9SkkvGDq/5WPdKooHg4ei2To2JgVzsDX1Lfo6zXFX42M0qepn4G3xcwrwvaVQrQnuRJOFqEZayxoBpKBdoLi+H28rQ6dP+8uE8coNLlQ8DbukzjX76l2fGcNB2MpOlFWFlRS8C+eyFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pA8ynxiI; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWWVLe7gC7pXRszfjqTk0gTqFdc2qFxT49CsUIWUcAp8716rmfvG8v8Cvik0sD5UfUK6zG3auDUMyYMknI6tL9T7DOBuvlVGok3LHrsf6YPU+Aii4xQHA4V0z/CjBEFG1n7OYfJxm3fwJWK4fw/AYj30thuoFshZxBnTmxYwx6qVIOAT4YDNUZD8s1lYSDVTQG4tP1LTZag42ZqYiIP1pVX2uniosuXZMNBoVVnrhqB9mIJPGgHh9J3j0I4F2ueZYDs9SnvaQ+uEmkfidcJPLrc4b8AGKq5yRfa1Y0P1bhN6iaEDMUBiLeI5t3wAtmml05q+gCk1Qh4FQT9U/UFnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohph213EUeoR3z09xL9xg9OLMfTCUHebtCyOomQiGWo=;
 b=iQmMRIjdILKMQOPMJKzzRM25dCB+sVDHgQBhGBcJdB3Cgt2iCLFzag2N/XKX3rFfQCBusyCjiPN5YDGZN1htsjkjU2S7Z4mur8oU8vfzL0lDVlAYeFk9/pombfQWlt8Y+Atan9q+IjeeFbEdJCtM46GNS+Dqh3cmzDLvHhu0/FPubzFbHhM8yeh/Y66+7WD9ACe3+6s2J9caQK8ZSuUiCKelQ4Z73E29a/7ek1qSh4xn7DRvyZNuJhbUyjxhM/UHo/BvlfxoovhJcZzsrhqLVED2Qvvu1adQFjryYbHh5rE6YU9wn0keqBzruM7GX/tt0A68vcUHwGx6ZgFxfAXPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohph213EUeoR3z09xL9xg9OLMfTCUHebtCyOomQiGWo=;
 b=pA8ynxiIQESfIH+2GJVip/qUB2+kf0RJ0QoXyfHnlTAqMF/H6uYUC1EJzxjDhDdHwa/RGVuWOMezcDbSxksJ3RDzGAACLEyz3bTQm7E28YqZumHBWOYGfMtz1QF0Bv0isr7372oYQUnMoB7rSHakkiC1ubCb2E65gbqTV8de7/k=
Received: from AM8P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::8)
 by DB4PR02MB8462.eurprd02.prod.outlook.com (2603:10a6:10:379::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 21:39:57 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:21a:cafe::7f) by AM8P191CA0003.outlook.office365.com
 (2603:10a6:20b:21a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 21:39:47 +0000
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
To: Matti Vaittinen <mazziesaccount@gmail.com>, Sebastian Reichel
	<sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] power: supply: bd99954: Remove unused gpio include header
User-Agent: a.out
Date: Sat, 20 Dec 2025 22:39:55 +0100
Message-ID: <pndecoozvbo.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|DB4PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4f432c-4c14-4263-b683-08de401051f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2FOSH3kn4UUmQIIcknkqD/JlxjZoXK0DXLPq6iTNQbAAhgIi0a1VYdNRebuU?=
 =?us-ascii?Q?XyD5CuFPlvO2KW88Q8rpvQyofmGCY9Zpqavj4IYWDpouGJPFhi/+VjrYWWEQ?=
 =?us-ascii?Q?u6WMEC7t47etnWbLvVH35KGBabVnURaNsX1KuL9dlc2n2zTWxikR21ctC1mF?=
 =?us-ascii?Q?n0XofGt4TCn9ploVpV8bNZ9T3UHBLPr0BSqCiYYSGgyzuSae8ByDxszFlOM0?=
 =?us-ascii?Q?IBlNQLPwRcPDCzfX5beJH8mwsmJNARbAcunCidFx22Pfot9RkefUeFpgQFxr?=
 =?us-ascii?Q?xxtFDapNQSlKRng0Imz6QOMWYFcPGE+WNu3+ZtpbyH2MXwO4N/orq+gKjEhh?=
 =?us-ascii?Q?kD2Wa7kj7A4Ch5HYNweVmeXLT9JTmdcxR0MtjrpM583A6eIOKOJcDvn/iEB9?=
 =?us-ascii?Q?dC+6DuUcECheGmDdKV8nmNpsQjtwo4Xn8qDj6crHrBCijvZyl50M7KXNenM8?=
 =?us-ascii?Q?93cUeaWNRfSoGH5l9+AfS3RJJ//lihSUMn2qSLlH2kyVSsWHH+uRVSZ9I3MP?=
 =?us-ascii?Q?qX3LWpRr8hrtAwNomjOJmcmRXoW7D+KJD9jJcjcNhLz0c2DVPMIb/76ptkp+?=
 =?us-ascii?Q?WeqqK2dLMao+WXIApJ3KxIb0yRDfcLwweNMfV4i90Z/WRcIWi+f97tBfM72u?=
 =?us-ascii?Q?sjkEaZpXGL5jKJa7oI1vy5hJLHOm2+mlMkGNrdFZ7ebnRQLl7DH7sk08/ph6?=
 =?us-ascii?Q?4gn8H6jLuAHLqsIQV0BlI/mTgiZoEV6cidG24PtuTDfsjEOlA8pkyZN1vclq?=
 =?us-ascii?Q?/zOPYF1Ob0Zdv8Wqo20hTkB+JeLyX4Z5MYnO7yTkIbjheD7QkW+cGSLD91m6?=
 =?us-ascii?Q?eX5F/T/3A0oleOui1g789W8BIpj1EUbWKDGUvz0wwngBd9oAzgiJnYq7647X?=
 =?us-ascii?Q?uTPcsaanmACSGIjEEyLLZBRCOj8tYeUqg4R6C4oOkxF17sgVmMZj0NziswbF?=
 =?us-ascii?Q?DwVPSdVfmQSr4BgUCfw6alAnF9ScVfYDlzqdKD/PfvGJ9cFsmnRPbHrfA6cG?=
 =?us-ascii?Q?/Gyod/Uu3EF7K8BKtmvhr1E8ZyAcsI3d9DDX/ZvClpDvQhRv9e0nJuwvy9Rl?=
 =?us-ascii?Q?VVFAIUQ2dm/N45p1XWZXcg9nNqHr+Z/yq0MYHLfFEjaYV7sUYC9k0p0zDhIJ?=
 =?us-ascii?Q?xty1x8C+cFhizZ7902TrjMLtnk8MoXSPNIffmHgpA/Gzq5aWyw2fcpNn4sRY?=
 =?us-ascii?Q?f7oCjRWjrqtJ+slLN4d/Vwa1bj6VZmcPIHAxwWDVZIMneAGvfk6zDHqCFI6F?=
 =?us-ascii?Q?dv6OIxzRZzYz6iAH3Cl11qZGAf8iFmlOixSI+n70Z/ghyeKPBE6AzA4IO6fg?=
 =?us-ascii?Q?ZYI87bySloXbI2/t8+ewRTLOkWi/9LMjI9PrlQF+OTq4TJOO1Hiv/JkT7IVz?=
 =?us-ascii?Q?gCL2rgGRVZPx6FMZtwCuhd6DmibJzuWElZa9myoAvyIzaXnsqVaETOcE/BKl?=
 =?us-ascii?Q?a7J9Huy01xnHfVCtpziEvLPPSeUWeSHeocleMpRy2JXE8a/nkjg4rDfelbMt?=
 =?us-ascii?Q?KtKerjxl6esRIkp17WvuNErMi2MlbF1T5OCmv+DV21d9SObuAP0uYc1t0070?=
 =?us-ascii?Q?zQGSkzXMiOuRAMpN2Og=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 21:39:57.1484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4f432c-4c14-4263-b683-08de401051f5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8462

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


