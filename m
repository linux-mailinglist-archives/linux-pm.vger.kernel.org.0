Return-Path: <linux-pm+bounces-40006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D45CE6454
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 09:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C463007EE3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03527E040;
	Mon, 29 Dec 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="yc4JkuVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A2F230BEC;
	Mon, 29 Dec 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766998605; cv=fail; b=Pl9IQH5MRDb3AIZ+U2Gr0K/FkdflKXpCHKZ8m+dt75IOjGH1f7Wo9/TG0CGdnoWqSAobJLVKbpSbhQKgSZxpTQWRw8dpFjIFXHac2sxdUegMItmckLv00rYwIav0H8RCL1uxLgK4AnY8t045WlgAeJmjarc9A+Ytgj4zMNmpPtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766998605; c=relaxed/simple;
	bh=qNGkzhiWIK9m1TpUlMK1vAIsFCAV/caxIAciH62P4rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g14Qv8LgJAEn6BVvUE8qrlb/wcB3O8qI08Z2Gst6UHHj/vblmBfqldz4w95xXVrx8bq7P2kyjaDfZv2UMFriri+WM27Qrtxmb4sLTiXma1mdd1BH3W+v8jl5OiSq7XnWT9qPK4Ru9Z4IzTdctA1Ju0Hu0+5YzZFCE/xoVSW6C1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=yc4JkuVB; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpfkmm2TLSWY/qYxKDdejc6YBBLewbPl/Iq+TN3sVWXDmfkwatvEPHdgBxHY3OeFZ8SxUhd1sVLOylz8bZHvaB6Cje+GW5xfzcDcZLwGamg6T3s9HxhAvx+mCM30V5zg0qZmHvEVUwOvxo3UE9F+K8Prl+d8/UFjln7ybq1KV0ebrljz6A82PQOVEpCN3/8AGb5pHOuO6V4LTqqIpeemf84Pk8Khdpo4Ex9BSRArhk2hgjtzOWpwwKxbYU/iwPsU66RZIE1x4pVq7rEDWmu7r1Cl4D4Q+fC3W6e2shv+EBqwIyusPMa/ku+v+w1BdTA93uW0v41F82e0LXnjr/xESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmgbkFlPA7P00XC/U3y4ftmBTlC1H2w0wom/36pCPp4=;
 b=OwznO94AbMSVx8JTB3HfDjpb4QpG24ltbxYyikURoaXT6MeLckajr8aABKBba9VvImGHvPWkz1s7ilNp1FIZuiXCdfapcUJIiXWUSjM9Lu+YDDFEjEDJOFFPl7wsc221QGkROvOPoYB7ihVnltVo2urwbAGGEfYsDxycfNaD9qALBEiUHfAtLdAqkq+FVNCIfFnqPofv7nH7/3GTULxBvFHIc7MA0egxLCaIUKoGh/kPwGE9EM9Hgs8RyEFoBE0V5FGZQFtqf6zH2By06/u1Ud0ya4Euw8wBszK4b20yBVyYVUtC+JHrc5DFSYwqSGJqRZrbDsQ1oida6PIHrKkBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.99) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=reject sp=reject
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmgbkFlPA7P00XC/U3y4ftmBTlC1H2w0wom/36pCPp4=;
 b=yc4JkuVBrCrxdp/nbvQZLX7XcjJwGxDgHqYSet4Mws5+1ewkIvb/Y5h2VoqmEvziOw43aArD7LU4T3E2/0GMwofEJufXSnRqthNe65GOMxklU2qYe9UcweNwPFDq+P23RTX1pV0NLCaOAsXhA26m7cYFl8AERX6NbwtgQK0yIX8=
Received: from DU2PR04CA0230.eurprd04.prod.outlook.com (2603:10a6:10:2b1::25)
 by VI0PR06MB9370.eurprd06.prod.outlook.com (2603:10a6:800:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Mon, 29 Dec
 2025 08:56:39 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::60) by DU2PR04CA0230.outlook.office365.com
 (2603:10a6:10:2b1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 08:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.99)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.99; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.99) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 29 Dec 2025 08:56:39 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.61.228.61]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 29 Dec 2025 09:56:38 +0100
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling interval property
Date: Mon, 29 Dec 2025 08:56:35 +0000
Message-ID: <20251229085636.4082852-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 29 Dec 2025 08:56:38.0332 (UTC) FILETIME=[0AF74FC0:01DC78A1]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|VI0PR06MB9370:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cc2d877c-bf9e-44b3-a276-08de46b82e4b
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fd79V7FfGQGDYA9jxrt3vyNF58ieGP7dUfSSawvrH9gP9s6a39Ldtv+CBOiy?=
 =?us-ascii?Q?ZRKaKqLBOsgegtknrmbp4VWaucjqX6N6L6qpRLcXD0/YQb159MW5wd4DcUrl?=
 =?us-ascii?Q?7qdKTJBD8EIxyfQHDGQ0JtRpI61I4YHzLA7GEJWjptNqH5oRPgj76Vw1cCmK?=
 =?us-ascii?Q?DgMoEOOgIRDGV85RfwFvkpBM+H9nxZ2Q0fuZ63G5vjmbDbztlkm1E5u3DFWT?=
 =?us-ascii?Q?4SVPhQleKAZQUJmN6FF4i0nuR9Y13h6cK9N4TyROOPK0gc7z1NoSwJlGHR/I?=
 =?us-ascii?Q?Cu+BtYANGvdBC20cUYZGiIquOEHd44CLD8THHRT8A9g8lgSIiidxg3d248k9?=
 =?us-ascii?Q?At15emFiNQKc+nqhgEmd+xSShG7+l1X3aDIYtslr1NGBkyIm861+Q0SjuKUC?=
 =?us-ascii?Q?+B2cjYou1N81kwKwQ9BcqyVqVhiaGP/jtna/JAircOkVuxrVXErTbKgciT9a?=
 =?us-ascii?Q?xnstCDZURSrq7LB1OcsABaPewZfMQ6z+bs+w9tIkR6bnhguT12+WYFhdyG4t?=
 =?us-ascii?Q?hcgEcTHQfDCxTSk5K9ssKoOwVMH6pHrmM9fwIzWYKwcEu7XmnwEQrxVFcumK?=
 =?us-ascii?Q?YEO324bgIezTnLJ6ztYq6iVKidpot9x72fnCVS7U77KZ6jqrREs6TkhOnfco?=
 =?us-ascii?Q?NHmOVCWRxA6ZHjHsTAhbHuRGOYY93HtnNLWTqYkvFv+i1SoAKlIWQCW+4S3o?=
 =?us-ascii?Q?oEXb5P59B3wEPG2pqrPc79uAQ6o4KL32xeP7NSaszoFKS7hSoJJWe3LA+8d+?=
 =?us-ascii?Q?dCABbVYY7Nt5rc+pip0xx6zbvAyiwW18CzcnchKc4Zn1cYGQcTg7QeW8EU45?=
 =?us-ascii?Q?mmGFO63rGen56gvV4lRxIMquwxXSLuhgPAD2LCPQSJaJfdHrJHJm/ujrTpDZ?=
 =?us-ascii?Q?ruAwzvaOOs3/a+4TC/R+XIcbEBhCBL8shzXzuVURnx4Db0jRaL1Oa9NqIM4y?=
 =?us-ascii?Q?vEd7+Wwe9SQhflyxRpx2L0jZHskes+bs8faqtQBhwox0RefddLCN+yQwVQUk?=
 =?us-ascii?Q?Fwed2brBVCu7cO7EtXdaj06OUfTNK6iMUlSiKR2NTGQlje4pbtbGBYz1yYzg?=
 =?us-ascii?Q?i2vgdPSZpWHx9oXXM9H3+/cFJsDIZKATR6TvLy2BL2WedLmTpK2NtioqxdAb?=
 =?us-ascii?Q?TDBL+AyV1AWHQ3nWrZtwo2DJEHVVyzQB1fQmpCBJW4ndRaWFg2xLQppxG7M6?=
 =?us-ascii?Q?KRUubzYy86BRgmHEPJp4tN6Jbd/rSMg1ESuNDohK4D8rg0Q2/F2Zsepou6bZ?=
 =?us-ascii?Q?DhnGpu5nWkmCnFfMORCW2Pi11bCxYVNEZEVtBrerzDrx5fGDd13ox1JMvha3?=
 =?us-ascii?Q?DJzQSfXxkLSJ5osiU+dIaJk+lv/SJ6HqATzjL+HkwQ/Eco5bXaKQVwZZWzfV?=
 =?us-ascii?Q?ezCQkHL+S316Wta2rfTrEtzBKtbUGIYgzLKrCWwhoE5aycSegRNrS0xlYgDA?=
 =?us-ascii?Q?8W21zq/dblgPkv1zCxSI8HU5eeOkvPCwWZQH4D8rjrkX5UGxoVZvsU1TNK6I?=
 =?us-ascii?Q?b/a0FpxWg0Dwk3qchDoUI9hPD4mNdrBFeUxUFeHKd2XV/Okw+gEbK73iYcIm?=
 =?us-ascii?Q?YHuOoTUlg55mA5en3cU=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.99;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom51.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 08:56:39.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2d877c-bf9e-44b3-a276-08de46b82e4b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.99];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB9370

Add the optional sbs,monitoring-interval-ms property for SBS-compliant
batteries to configure a periodic polling interval on systems without
interrupt support. The driver periodically checks the battery status and
notifies userspace of changes when this property is set, and ignores it
when a GPIO interrupt is available.

The property defaults to 0 to preserve existing behaviour.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 .../bindings/power/supply/sbs,sbs-battery.yaml           | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
index 90b9d3d882a4..fbdd5dd5dda8 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
@@ -59,6 +59,15 @@ properties:
       master implementation.
     type: boolean
 
+  sbs,monitoring-interval-ms:
+    description:
+      Polling interval in milliseconds for battery status monitoring on
+      systems without interrupt support. The driver periodically checks
+      the battery status and notifies userspace of changes. Ignored when
+      GPIO interrupt is available.
+    default: 0
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
   - reg
-- 
2.43.0


