Return-Path: <linux-pm+bounces-39752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 991EACD386C
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 23:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A11843043F75
	for <lists+linux-pm@lfdr.de>; Sat, 20 Dec 2025 22:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F463019BE;
	Sat, 20 Dec 2025 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="fBIQPair"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEF02FDC22;
	Sat, 20 Dec 2025 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766270174; cv=fail; b=hhcGJL1Suo+f16bl2aek9t+BSzxXbszA6sK2Ru4+blrdJnMNfUCq4S+rnoWGq81zOQI5g8c703RTRyvEPjp2qIuPYc/tEayI5Z/+CuygQndliZMtOMI7az8StsvRgcQXZ8iTX6XwCDWimaKgGxJh0z6MialtunWr8PWXVIvpKWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766270174; c=relaxed/simple;
	bh=zMHmxuNpZia48mVFphmzqBVe/q6Zopow3HBSNn5CQvk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=RNHDnLnT25rpMhCZK0NYqniRoKKAgz3R1DxHVtuQi+Kh+q6FMfa69bUmEBtxoKVemTIE+eE8+P3TA7ZTOlL/U3BXM8VasH/4V+UDS7P1VNj/yHoL2+KyGezibPOLsQC96aYFJD2dttSnAF46nz+fNq49/y3q2067vlPA7zj0oss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=fBIQPair; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbsyGTWBzVuyMKeu8+Ek6mqKc15WZ9APrlnFqm1RWNTaUQWNTOrrGSGIVeJcFRMNlFxkZhZbnnNFwWdsyOfJD0m4jUOP2bZPK3HfLFlKWlQaoBqtmZi1pliHWDr6fvgSFdUy7rhudLTf/jYQbZF2yNUqjA8AZvBvlrotoY67QPpMLzg5846sha3kBaNEV+iDdcVc+31EepHs6jGOsmk5Yuc18pO0PDOq+RA5JADLiQ5ZYohwy4lIXnykhEtp4KptfT98kncEbuJTaWYjbjstJC3wfeBUzLDHmjxJ5RnNH+KO/jk4O2nvDE8CSYzxDBXCtUMFrPsxKCgR3lchBSamPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7ZsVuWo0vaweejhMkaUiTR3tiSrF/ZvkBSe2rUG7d8=;
 b=mTQuW62Yxi0+U3DHWXF3JoyOxCDv4lEnIebJmOYLpxQQQ6GCF7IPk3TP8u2XZc0mnLcggATjaqlb8/l/UmgvHaBaWwDdQsuefO/W8TiN7iyK+yL41o64QpZE1CqcwxQkKUR9ylZsH50Jf8aq7kVl4fhAOhT1Pp2QNF17MhMb61xrFyv8IdDPjhXmYuHESxiJ2vYj6t5p68L6y6AlIMJ0Xyxk3b54T1Dj5HTsKY6YLoPzKvb6ZFTEAoe/9PxRihIUgy1HCIYA257Ddf0HKrlzxvj0Sp0JLznMwt+JBvgzC8NOd/Mh+9pmRQLCbxsXqQ3DKWauY3dwIqNlmA4+HUsVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7ZsVuWo0vaweejhMkaUiTR3tiSrF/ZvkBSe2rUG7d8=;
 b=fBIQPairO1/2xtUpWdSEEpv4uerHVKmeVlaHxm6WWH9X3q53R9rz1dpH6HkAueW0OnMCF7DMIDk//1wQlsL2QwZX4ks0jgtVtRimJBfW9CrkbrbUCCge01D23vSO/4f9x74SAjF3llbLXkmahNdfrDiTakgxP81AoMH/uSIlijE=
Received: from DU7P194CA0014.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::31)
 by AS4PR02MB8527.eurprd02.prod.outlook.com (2603:10a6:20b:586::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sat, 20 Dec
 2025 22:36:07 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::ba) by DU7P194CA0014.outlook.office365.com
 (2603:10a6:10:553::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Sat,
 20 Dec 2025 22:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Sat, 20 Dec 2025 22:36:06 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Sat, 20 Dec
 2025 23:36:01 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Nikita Travkin <nikita@trvn.ru>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] power: supply: pm8916_bms_vm: Fix use-after-free in
 power_supply_changed()
In-Reply-To: <cover.1766268280.git.waqar.hameed@axis.com>
References: <cover.1766268280.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <2749c09ff81fcac87ae48147e216135450d8c067.1766268280.git.waqar.hameed@axis.com>
Date: Sat, 20 Dec 2025 23:36:01 +0100
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AS4PR02MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a975e6-0327-4ded-0f72-08de40182a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UoM0Ao7sngAEB8GK89Bu2VJTZgdQBhby9ElV7egirKRi9XIYFwh/1OFHKp9F?=
 =?us-ascii?Q?pLy8UBSsU3bg6Fv5nstQcShMzjqbXi4qfQSaYP47abYyIqb/zrsKeZOK7jx4?=
 =?us-ascii?Q?GnOSUeiyWlbmEbsbrIKjU511syXg1hwVM+11jcj8RvgLf4rtbAxv03Wuh+EB?=
 =?us-ascii?Q?6r4pA0kvzojUSjPZO1kzKWgHYgOIA/shmfqvKjkb1OqEh7t59119NY6A0kf3?=
 =?us-ascii?Q?MiGQhlQCy1UQAr00G/YKRd5DVfqcsjSEUq2TEtgnJCBEQ4p7+iHFLot7qGDb?=
 =?us-ascii?Q?IS7/su7B9YRKD8FnmlTqQgRUADzVBhg1LOvwHs9lcCTUPVA0AqDSCyZ+r5ir?=
 =?us-ascii?Q?gL7aKhOFmN6X8+Vohpxfa1XOUpsnfYpUUq+1RGbSdWljvjKK6NpbwcHvrWDU?=
 =?us-ascii?Q?W0X2MRdw2ooS9MQbG3+5Xww9CirzwAr7opd8iBRTZXrwfacJDPSKU4WvNxnt?=
 =?us-ascii?Q?mDIt5HNObYOmembS5Qrng4cDuiGGUANsbJcEASZjFLQLSOWbz1EFFw0Z+jIB?=
 =?us-ascii?Q?YjzXQBWXsaPnjLdKo948aSpBIMAAuYzm0kXPodxTLMlFPi4zkevfhvXeA0fa?=
 =?us-ascii?Q?0fClzfYAggOCa5CD18P1Q9r0D+i4k1Olw3VzlkmCtLUhHxI4Pyq52TLPJ8uD?=
 =?us-ascii?Q?aTbP9ubQcyC9WGk0L4PXVoQW6u7LSbrJXKo2SiFrKsAsqpiMYK8I3g2GG/7w?=
 =?us-ascii?Q?kjmlXB6xaPHqdQ0wJMlajbZQ3H1VUbdpo/VPGzNUsePlxvoohfjQa29yM4Bn?=
 =?us-ascii?Q?OLnENck2cJQ5pJIkQV3SOwg3TYk/cckwX5SPZwBk/IIQxvuAvS9sufz7gYl/?=
 =?us-ascii?Q?c58WOV0w8X1gBw2kXooZWfXZBstD21SH9ZrQIdBdRRtPu4EOT/cxSA06f/6i?=
 =?us-ascii?Q?tMvsGNfVCjXUNt36Vy3SJUPraONdgc0UKj2EI5UPUfIyOp5uWQLDGTPb8MZ1?=
 =?us-ascii?Q?YdPCjBMKPaGUolBqSbP/mG7i9/Yhau674C5MEj0xdzitE5+CHSHecAa6Oesa?=
 =?us-ascii?Q?G9l8VJtt/mhTvChcmpDzluz8vAloDFxeU70e6fh6jsgVrTSoAFEyBsQAevBL?=
 =?us-ascii?Q?F602Gh/meWvCO3dEFtPVU5wsF9ZJD45i0LDb7k+xJJLKfi8cMVQtl4TF/WGN?=
 =?us-ascii?Q?j3mLJ5FmSyjq6j3PObH69I0+FomRUC6zvx/1cnFPeXYqvriZOHv6jSJCjth5?=
 =?us-ascii?Q?+WjqyoW52ZOl54CpGNLf31XoyyZwq16t7PdKSuyVpcUEL5/Xjxepc0MnAfRx?=
 =?us-ascii?Q?z2wMasS0NcxYUr/a9dnxK4e6N4N7hfHVU2hk7ZPcVOjBAnY3C4Da2DYT3YQ4?=
 =?us-ascii?Q?L0VXMHW9zRdyiJf1slYicNMOcpbf2WTygfSCry1TUct2KKixoe1TrH0Xtz4y?=
 =?us-ascii?Q?hHp164yWTby/fm3qCUbjy3bVBn4e5Uzqo8eDW8Tsf4ms0siYhrjBr7lHUsQ9?=
 =?us-ascii?Q?4IYmEJ5SXW6LCKsZwzDz5205ctzRPviuGpqAtCIDzvegGEI0SiLPE7DjlA4k?=
 =?us-ascii?Q?YnzWddH8tzE3ZPdPiHx/DK0CzDVx9Qa5/eTV9vAIxHHlP2SBpTyVN3Hw6H+m?=
 =?us-ascii?Q?Tp67yuuYWJenDNogWho=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 22:36:06.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a975e6-0327-4ded-0f72-08de40182a7a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8527

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

Fixes: 098bce1838e0 ("power: supply: Add pm8916 VM-BMS support")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/power/supply/pm8916_bms_vm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/pm8916_bms_vm.c b/drivers/power/supply/pm8916_bms_vm.c
index 5120be086e6ff..de5d571c03e21 100644
--- a/drivers/power/supply/pm8916_bms_vm.c
+++ b/drivers/power/supply/pm8916_bms_vm.c
@@ -167,15 +167,6 @@ static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return -EINVAL;
 
-	irq = platform_get_irq_byname(pdev, "fifo");
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
-					IRQF_ONESHOT, "pm8916_vm_bms", bat);
-	if (ret)
-		return ret;
-
 	ret = regmap_bulk_read(bat->regmap, bat->reg + PM8916_PERPH_TYPE, &tmp, 2);
 	if (ret)
 		goto comm_error;
@@ -220,6 +211,15 @@ static int pm8916_bms_vm_battery_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to get battery info\n");
 
+	irq = platform_get_irq_byname(pdev, "fifo");
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_bms_vm_fifo_update_done_irq,
+					IRQF_ONESHOT, "pm8916_vm_bms", bat);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, bat);
 
 	return 0;
-- 
2.39.5


