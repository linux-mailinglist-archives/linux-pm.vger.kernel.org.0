Return-Path: <linux-pm+bounces-39749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDBCD3842
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73D403003861
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246622FF66B;
	Sat, 20 Dec 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BbiWNgiN"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549C2FE589;
	Sat, 20 Dec 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270170; cv=fail; b=Dc61a6S0j0WOCOEzb4Qy4CHxIFmpXiItCEDGmi+gFHHim8Kp57zxSgUD/ynEWZY6Icbqxb73WTsbNr6rWYaBvPMjZk1nDi1BVewp+uJgm9C1SrXZn8VyJpAGnVLaVHqJIC9XtQBQ/9IQknoboQdfP088aYha+6GmmuL8OaVkyOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270170; c=relaxed/simple;
	bh=oASRdbKaVEijQiABa69CHYEZwG3L9lK2TSF5OkN4aoQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=B2rliHcO/eAsXCti9BNp2OSlvLEiY9l8FjRa4ZjcFrb55DwfMM4kQTExCUg4pfqgTeuaRCczEmfj4lPFi4QQThgOXDv9E/mQKpkbTmwpPxTFYGk+9rlaxCxrlMsz0w4Oi0d8M0Y/KlunmlLDTovhiexIFlMa+qe4dyJuQHMU37I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BbiWNgiN; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTK/2MAFlbbo7EsO13RZXtv9qqvBBD53aO10frFlNazEbHScKAbL6pLIcMDiycCwtZCKtSmUcYFgbr9E55LDLzoy6OryV6nIFJsm3VBOqzzKQFVt7lhdFaqq7x5gh6xXdEwpMn8MfJKQ/YFg8H4SLdqiZmfoEMdPvNnyIlhWbLaPc2M4pke51vZDb7y5ehKp4BZt65YX4UGC4/90PmBaKZjVXHPMNIwyOn0BZSrSe3FQnJwR8K7k82ys4oupHlsk6vIKe4Vee4OoqBokZs+RSjA/P3epy6WLvwdQ+vxf3iaVM+Pb/KziFCTGN8guKrhP4ov8wKvOHiNjzAkBhZEG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+LGJylCelU95HsQ6RmVvDpxnmS/z5osJVLBcVxHwMc=;
 b=KRN6cQSyKO1cIQxhGM4lqFovQZggs0K83L0GtI5ceQgRs7OPeVH0+5fQsaasxR6ayOL1GtChUwcpkn+xUQ+OVTzaZ8AyLLdW4cuSD9YX+0fE3kYd+bO9LtjEWyxnSIdqWBwLVktNKqo3jzJyzYLIrITe4LueovSx1fXu7XIOa4Le4issYy6HlcMOp0BAjZpyB4+QcOeeZMjVWAisVN/18YylB5EeRtw2esUqkdGdg+EIRVFSiav84FPu00/+u8q3fSv0+64TzGdIn9uer42+2vX1r+annlZtixB0m6GCHnV8hKGk1RkBAcQs3bFGse4EMvT4mnXkDMfT6E/+fBqHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+LGJylCelU95HsQ6RmVvDpxnmS/z5osJVLBcVxHwMc=;
 b=BbiWNgiNrdQtf+OrtzbuGeu7hgx4yfcZG2r4PZ74NgrKI2BVz+RyX+rqUfHdtCjnk8LAsSKZy/DyIfRyTNBNYBUlKjwU6OMqev+719x5Twqb5p3dxJ6QdIICIFRaNz8fmnOvglDzWgd2AARz3n/UgRcyyjm43Z33LRKG4T0QoKE=
Received: from DU7P194CA0027.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::7) by
 VI2PR02MB11023.eurprd02.prod.outlook.com (2603:10a6:800:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:04 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::4f) by DU7P194CA0027.outlook.office365.com
 (2603:10a6:10:553::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.10 via Frontend Transport; Sat,
 20 Dec 2025 22:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:03 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:00 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] power: supply: cpcap-battery: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <81db58d610c9a51a68184f856cd431a934cccee2.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:36:00 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|VI2PR02MB11023:EE_
X-MS-Office365-Filtering-Correlation-Id: 07781e08-1728-4a41-5a1d-08de401828b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W65m1O6Jntwbj6lXu3xoR6vJFwDjpvJO8H3xw9Se+vqNzfv++kA/EHSYMfAF?=
 =?us-ascii?Q?n74OFWxvHBkmgUQEZ62j3L3vGQsYAcBe23c2Bp0iWrIkdBm03ftJgh0K6qHh?=
 =?us-ascii?Q?0qW/kGDSGLLODIgnXGyJ0tUZjmsWzQQKFJ+fG06lChf7lN4cxKQWFUeyugiq?=
 =?us-ascii?Q?Vc/t7dzrzvCwcigqdmV2Fo7S2D9Nonm58Jhs2tZeWKHofVqOUldBcFF4Yzsz?=
 =?us-ascii?Q?kuugurG2FbSUT5LxOFvTeGr/DzVT3AAeMWUVXP+0HJ5zvjGEPlbiiGA7Enfo?=
 =?us-ascii?Q?lKOtFKwZWLChMYmVm4nwR4IXN8oQ4RxbFVslbNbOsUSai+/9eEoJCzgCML+E?=
 =?us-ascii?Q?5qGHCVYlTOynMeNg3m2cP+PGl2Ih91D2aNPOIq3y8+BhdCFGEihQB2Hf329r?=
 =?us-ascii?Q?JTF0JiviTOA0nrqndHU6urENMdqRVLPI+0gkM+FGzPZvdtFXK6EMxfI5cp95?=
 =?us-ascii?Q?XuUGbPDgaWoaclWbfU1CpSXKy4m2ZqqgutES016kmePzJs3RyafgRnbuRf86?=
 =?us-ascii?Q?aAnhUZTupCfjY/OVfAaRu+P+/PsESZNq2TSkcilIPByvkCrqeWArkp5wT0q5?=
 =?us-ascii?Q?+FLvfK/xcA3sVnjny2UKbMnv7hTeoBuKytirJNKxABLFFtUcUTKxRnV9lRxU?=
 =?us-ascii?Q?VDog52bCcCPltGuYz7n0Spg03WW/KOHPtdd/hiQhwt+uC3Hj5/zlL8IqNbRH?=
 =?us-ascii?Q?NQTrnkAly+X+2PH/E9Vik4gkMqyIptKkZvkEtzUXv1+310E6tGjmInsKv6UJ?=
 =?us-ascii?Q?AtHavGEKWaviUfZcHRTqM3Wcqf283GnnLrktc4RU8752/rWKLAKi9fVHDTLV?=
 =?us-ascii?Q?paotjCqJLlktyL/1JmfVnLrlBck5jP7S5tV8rn94YEssNzvQ4TBrr/jbdhIW?=
 =?us-ascii?Q?a5ONzB5CJMd9Iw1q34WJw0lRAG/RtaadaTSo90HRG6f9TFtJCitDOerMEpEm?=
 =?us-ascii?Q?MmkyWtmOLKnAekokY7OhHtt5gd7whC1Gc4GXFIB0d3/i94ILGaYJMoxzpEQl?=
 =?us-ascii?Q?npKNBPNIlEx0mNA+OFrkCFLPWfkCimcUyzTyZZCrl0o+TLu0tIOCI/Bj3jYU?=
 =?us-ascii?Q?Lk8iXKAfj5sle/IxEjBb6Anp8DigiaMf5aDd2M1PmTCQn+5WXutMyw2ANA9y?=
 =?us-ascii?Q?gpA23FUxQq0Dz0edRm4zMi/gQQ5dm2Eb8Mky6fOYmiwVWqFZ8UgCr4qod4rE?=
 =?us-ascii?Q?Z6afTv7CHiFdP2B7fWYQqVjdwtnmpd4GKcugmWJRlUDW2tdX3GCBQFZhzUm2?=
 =?us-ascii?Q?PmFwexDAaW2Ik2wi3B30RkgcJa802xaW6+tIk6rr+gMhzUywKPOkt/4Cn33F?=
 =?us-ascii?Q?yERxFCrf6tAbxTzGZPJU8GiS3cPreQO8AFUMYWgQ1i+WwqY6M/rG+VAqNwTZ?=
 =?us-ascii?Q?4G0bL5HkeQpk4qhy1p9633D+E9ZNkOPZWKyo8xHNoquWPwW6PfdY/Tso4aYV?=
 =?us-ascii?Q?vP/V4nnnNgQYgukLVfEX2hZe+oIGG9l7s7McBxDnM14dKtV94+UGcQyW79a/?=
 =?us-ascii?Q?exVBTy275g6Uc1RMctG3QmcZNW8g8TWFhukCYc02qNwir4oqjU14bgW3ipBl?=
 =?us-ascii?Q?h7hIKlPaTl5NtO7EhNc=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:03.9281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07781e08-1728-4a41-5a1d-08de401828b9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR02MB11023

Using the `devm_` variant for requesting IRQ _before_ the `devm_`
variant for allocating/registering the `power_supply` handle, means that
the `power_supply` handle will be deallocated/unregistered _before_ the
interrupt handler (since `devm_` naturally deallocates in reverse
allocation order). This means that during removal, there is a race
condition where an interrupt can fire just _after_ the `power_supply`
handle has been freed, *but* just _before_ the corresponding
unregistration of the IRQ handler has run.

This will lead to the IRQ handler calling `power_supply_changed()` with
a freed `power_supply` handle. Which usually crashes the system or
otherwise silently corrupts the memory...

Note that there is a similar situation which can also happen during
`probe()`; the possibility of an interrupt firing _before_ registering
the `power_supply` handle. This would then lead to the nasty situation
of using the `power_supply` handle *uninitialized* in
`power_supply_changed()`.

Fix this racy use-after-free by making sure the IRQ is requested _after_
the registration of the `power_supply` handle.

Fixes: 874b2adbed12 ("power: supply: cpcap-battery: Add a battery driver")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/cpcap-battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 8106d1edcbc26..507fdc1c866d5 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1122,10 +1122,6 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ddata);
 
-	error = cpcap_battery_init_interrupts(pdev, ddata);
-	if (error)
-		return error;
-
 	error = cpcap_battery_init_iio(ddata);
 	if (error)
 		return error;
@@ -1142,6 +1138,10 @@ static int cpcap_battery_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	error = cpcap_battery_init_interrupts(pdev, ddata);
+	if (error)
+		return error;
+
 	atomic_set(&ddata->active, 1);
 
 	error = cpcap_battery_calibrate(ddata);
-- 
2.39.5


