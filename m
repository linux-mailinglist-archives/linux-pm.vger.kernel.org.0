Return-Path: <linux-pm+bounces-41351-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD3tCqw3c2lItAAAu9opvQ
	(envelope-from <linux-pm+bounces-41351-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:56:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D372572C59
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 09:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22EC43029A66
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52356329395;
	Fri, 23 Jan 2026 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="S6d7KjuI"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA6318BBF;
	Fri, 23 Jan 2026 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158550; cv=fail; b=mkw4Fq7hwHseWvyIRM9VkkJBAt50VCai2lI190/snN9DaQgW6SfU6F8MWWLy+CRrqzG6JuX/iLP0I3A+ZALUQFzFgc6k8dDTxjRCe+vIc5GzaH5FpBvIOahxRHmVmnCJ2mzFL3HDkpxQagMaPhAEfuekJL+ut30M8tQwJo6zhWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158550; c=relaxed/simple;
	bh=uFmMUsCDe0lD+DK0TfE+JoYw6JwYqsnwSqZgDvzaaGw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=AarZkp7/IEpSqI0rn7QrLNr6D78p3HnL+b13+AwaOWznDW5CFTMSJoKpd0z0haxEbJ6G/PlJ3mzBnmTjf9zweo9+du+OzIhWE2ELIlrR/n3W7O2NiWFeB0sMUIcCA4ARFU4fGoE12RpBiM76R/QKviKwwjSrT33wvvjDLii5WLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=S6d7KjuI; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcKsc5FCLAjUytOwEtzxKF8FOUE6m8vx1SQRZI3XUxNSn8B4iHV7m60kGTWVXFfIEw9f665Oy/WTS5zjXc+Du1mKdavoABtasxG4aHt2cNphLZg6AiM1CEJ6rdvvmtlcglnJXbUMDVSyWqgf+MfJoGAMP56TdOLTscasH/IRdqqXd+7g4/P6EcxFh+YuCWuHsmQqHzI8fugNJPTzuxCtHfDcmeEWUIzAcXvzTAl0sEzZbgLa4TVSuDuH0mzG5r90Xgu44Y+r99xov693GG+U3kzT7/4uhJSgw+/T8zJXxhuNH1BFmSo1EZDxdmKIAFYsx7jejK/5NSsjDhsuEd1MjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khRa5WMZOr5twJvYoO4a+WRzoxzReeg+eaapXqLXQpw=;
 b=JO3KiP5wphohFOzpjGqftC4axnlYz1t3abET9O4sm6M1w0ss7fGgaR+8+LRMinMhhKyTEI22VqiXcscbr/k2aCR9l7x1coesbMjHly8M2NfNCHuTGXSpbCfy+BPLuspNjNe5zdFth24yk2TaoQe3qYDnDA80njtKyCA+wsZEjpfFjaH/e8vMm57VKQwLWTA2lsr+gYx9MUYSaOR0hjR9/bCg3Mo1edE6tmy4VRkXRZxq/reMmX9K8uI3JmwoUg2xRMHdbHM+TnzCA0qUq7lVsILoMex/2kN1zJbxu2yLwCTe1g9JGqh4Q4HwkhxGtHkN6ht2D/MPvVhaiy3Q/FVrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khRa5WMZOr5twJvYoO4a+WRzoxzReeg+eaapXqLXQpw=;
 b=S6d7KjuIaFNl0vkK7NjtTyOCHRJCxQVvW5RlsLsWQ+8gj6HTReuiNZJfzIIvCOJvN14mKJ7hwh5Ejcd3C8e88sFd8Nj5cSgA0XYnCIW3Y2KLQUhe4HYoBUn3n0D7JoKABAA2POETowNYB7hDMEPTS0eVfkAxHmgNcBtQazTp+oA=
Received: from DU7PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::11) by AS2PR02MB9261.eurprd02.prod.outlook.com
 (2603:10a6:20b:5fd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 08:55:44 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::e3) by DU7PR01CA0016.outlook.office365.com
 (2603:10a6:10:50f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 08:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 08:55:44 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 23 Jan
 2026 09:55:43 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] power: supply: wm97xx: Use devm_kcalloc()
In-Reply-To: <cover.1769158280.git.waqar.hameed@axis.com>
References: <cover.1769158280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <5ac93f5b0fa417bb5d9e93b9302a18f2c04d4077.1769158280.git.waqar.hameed@axis.com>
Date: Fri, 23 Jan 2026 09:55:43 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|AS2PR02MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b63a30f-ec01-4bd3-dbbf-08de5a5d31be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m5T1sg10c9pqQ7N/VyeRDl0z4NvFvJF8Av+oCEmYs/JZApKKaKiv2VJx99St?=
 =?us-ascii?Q?/Y21OphPDdzjR9LhOS3BHjZFjcSUUkrb8DlUfuNSIcmMrOKFM8fa7M0oLWgw?=
 =?us-ascii?Q?RtkVczWmCTD8KeovPLpUfsZP1fqqoPNajmeTWu2Ps06S2emNO6FFbUA4BBdP?=
 =?us-ascii?Q?XJFON0nZrcmvHjm2e+QtmnJowfdTsb5WYFdMAwjBlAmDKotP5jcQTQQsRsAS?=
 =?us-ascii?Q?B8ppewcqwcfX02PQeyl5zDbDWHIewLgFLw4PfMzWqzysQ8CDAtOZqwC3JnGf?=
 =?us-ascii?Q?c8W7lxQsNLadj7gIyFkzNIDz5B5IvNweOW1RtSDDz8s62AEBn78zHRT1njeo?=
 =?us-ascii?Q?MJpONiOog4JiaQT2AN8uDoDJe7fCv/yB0VL05C1Oz0C1AvIAvxC6lzvdIODu?=
 =?us-ascii?Q?Jb5Cr2+QZ1rcNDM3qUSzxfI0eHAIBUBE+vJg93DKmWU3l4tGp07PTekL2+GF?=
 =?us-ascii?Q?vNTAXlfCb1D83WyfEjNnuh8QdGrtRcj0iVgMhDo362/YlHYBZg/ZnlxubNTM?=
 =?us-ascii?Q?vV4PKU/KzuavdhNL3Jt2ASzcWOcDhzrEGjR04sERplDVYAkCWsji9bMEcIpp?=
 =?us-ascii?Q?4VNrTZ6qQzMZ2+y7AwfQU1zKt6/Un9mQgn+UqOvQMOjyrjFBOcr7i6Sb+OlB?=
 =?us-ascii?Q?XGjY+QHcV5wrpLcNOp/HsCFmTL6Rg/Qw02e/Z/cPxn1ZIkbvwHWfvTOXlH4B?=
 =?us-ascii?Q?u3orFgneXVYiLrPi+aDYxBC5Aet1li89oeBhUaLCo9tEpQiyZE03MIdrhWiC?=
 =?us-ascii?Q?4r/IUPEWSAZIwKosNDOijyNnIjL2dRo42BsJdZLqgyYqzjExsQbYctKydsG5?=
 =?us-ascii?Q?MCwgr/BeR3yV80ktpJlIdIMMgAGPTjYXkP7YRgGvQuguLQ6MNBg8Ry1vYQd+?=
 =?us-ascii?Q?8/qeeHSRb9MqccaLYoY0wZ/+WUoWt9mdaN19CM+obMlKWoxmar5KPDwNuG0h?=
 =?us-ascii?Q?VDME9c+tTtDxqQ6dpvRiC1K3kt+l7yA/5u7/djcoASZpjX62QAbX99IyXz+m?=
 =?us-ascii?Q?TkTkw72tf2tWOsOp4ccADpBVArTUQIXceRYizVHuU9x2Vrj0V5vD3zkbqnod?=
 =?us-ascii?Q?6k29hDWzOHQP0QDVF9KGt+8EO6sq8jyQAvylf8N2T89dDnCKhBMEmkmuWhOw?=
 =?us-ascii?Q?lwyx8PXh6kSQf/p9whBo/mDCwb6SZlbIigkwP501c3gDH6UAD04iArLXHZQs?=
 =?us-ascii?Q?ISbpAua7EFFvUCAdbRQFBV2gKNIynXM1OUMXAaimynDTcGaJkhl5H3OOqG6o?=
 =?us-ascii?Q?ab9YukFrq+WXME0sADWuOYtyZVVS8Gu9chMGvH1YZyCc5D2UTb9hI3wlCGfo?=
 =?us-ascii?Q?H+4RU0f/0Gb+obyLhUSzWunCI4NuXxhFwhWGkulqYWhUodi8MKYM41Nl5a+V?=
 =?us-ascii?Q?bFQnvGpd5sK7fvvmKiVNxnTR6KKq4yIEc9X2jrf+3nlclpabqkJ2WWpm5L+7?=
 =?us-ascii?Q?tLoQQmna/Afpj2Itj1a2J1As4qSDZgvC+du0uBHCHp78bb/vVgf4y8QsQPmL?=
 =?us-ascii?Q?McP+CAjrA1LKh2l8cdRxoW2cB3CiGo2hOjA/aoeGcPS7WWZHTKO421QiGrYa?=
 =?us-ascii?Q?VV6XF6Apx1rixPhU/PYLpvjpsTRjw6sWc3RlgDK7rtYVjTdqNgflfmVrAIf3?=
 =?us-ascii?Q?eMsEBypIUFiHzPRonZSR3cUa8hN7rsDk/tiHCkIAOJTlGvm2vPvpjJci90Kk?=
 =?us-ascii?Q?EFjgKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 08:55:44.5752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b63a30f-ec01-4bd3-dbbf-08de5a5d31be
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9261
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.35 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41351-lists,linux-pm=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axis.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[axis.com:email,axis.com:dkim,axis.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D372572C59
X-Rspamd-Action: no action

Instead of handling the memory allocation manually, use the automatic
`devres` variant `devm_kcalloc()`. This is less error prone and
eliminates the `goto`-path.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/wm97xx_battery.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index f00722c88c6fe..c30c347b48f99 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -192,7 +192,7 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	if (pdata->min_voltage >= 0)
 		props++;	/* POWER_SUPPLY_PROP_VOLTAGE_MIN */
 
-	prop = kcalloc(props, sizeof(*prop), GFP_KERNEL);
+	prop = devm_kcalloc(&dev->dev, props, sizeof(*prop), GFP_KERNEL);
 	if (!prop)
 		return -ENOMEM;
 
@@ -224,12 +224,10 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 	bat_psy_desc.num_properties = props;
 
 	bat_psy = power_supply_register(&dev->dev, &bat_psy_desc, &cfg);
-	if (!IS_ERR(bat_psy)) {
-		schedule_work(&bat_work);
-	} else {
-		ret = PTR_ERR(bat_psy);
-		goto free;
-	}
+	if (IS_ERR(bat_psy))
+		return PTR_ERR(bat_psy);
+
+	schedule_work(&bat_work);
 
 	if (charge_gpiod) {
 		ret = request_irq(gpiod_to_irq(charge_gpiod), wm97xx_chrg_irq,
@@ -246,9 +244,6 @@ static int wm97xx_bat_probe(struct platform_device *dev)
 unregister:
 	power_supply_unregister(bat_psy);
 
-free:
-	kfree(prop);
-
 	return ret;
 }
 
@@ -258,7 +253,6 @@ static void wm97xx_bat_remove(struct platform_device *dev)
 		free_irq(gpiod_to_irq(charge_gpiod), dev);
 	cancel_work_sync(&bat_work);
 	power_supply_unregister(bat_psy);
-	kfree(prop);
 }
 
 static struct platform_driver wm97xx_bat_driver = {
-- 
2.39.5


