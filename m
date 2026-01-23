Return-Path: <linux-pm+bounces-41359-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCBSH2RMc2lDugAAu9opvQ
	(envelope-from <linux-pm+bounces-41359-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:24:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830CC744A2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ABFE30055D9
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E319E344D81;
	Fri, 23 Jan 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="G4haoJdQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250D2BE7BB;
	Fri, 23 Jan 2026 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163870; cv=fail; b=q35iPVcslItDR+BePy3j9e42YY0FLvH6dJt/EdB4yHvXXC0kQvm7M3nppbELuBgXL7JXqYxmfpEzglUcGG/8NxzhI4UaP4MZ7a+kr80eLKOqWxYUnGPnq51Gfejoy+FSQP7UaqmhXr6H+5uLnLE1W0U5QnWhsN2wvtZmeKezaWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163870; c=relaxed/simple;
	bh=3mfJfOGEkEFQAzogofCEBj19QwbX6QSx875V8bpHDWM=;
	h=From:To:CC:Subject:Message-ID:Date:MIME-Version:Content-Type; b=tSMSd1XmIw+iba2nApwP72E4tDS0vsGfzFKghWEdJW0ZzAaQIUB6hzQXNI2l8ctZ4zTDWfPsJ+TZgP240sN3Zm7Y5QQ9cDotk2M9SfgXFye1kaq97md5dVrloU3Cl7vHQgbA6QtX/X8C1xk2jVKCsOXm9TaXdFufZHHVByZwppk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=G4haoJdQ; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCaUSnJ8SXD6WsLSWKwJwCf6yQUdVdLYALPSxaYIfbet2hi37hI6nUhamro9L6qG6kJhHhTmWhBdsEfqbO+MAHgciS6xARcOOA+VK/3JmMkK0Vf9FTb2CxZQPAnbf4a2ggo3im7aNKWcJbzfwAS6lnbhB9gFfNoq3T5KMvYV+zWT7v5BFuid809e4XA1qcezlnJpP4WOSn+PrC+JiaS6YtLmkUizWByFlwewazLRkBt1Q/n4NJupOJauKevPW7GfQEOg7jj3UYiu9LA/OUDIT06UkEORysdD/F3Bumh/cyiUdRF46sqMxDaqoVSWAIM/DP6luWxlHzsJ2+CAgKpS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S5/KYGzEmEvYlgzW/3Xw1m6Vj43SNvpfAC5eGdkcOE=;
 b=rm7wB+eGTEHjpyy3JNiAN2Yic6ZjIjZjCn0tPR8v/TltDNtFh2jAdKUAIVcKTjNTo4BARzu4lnxTWooVT+W0cfmUPKvuCs3FQhws0q2P6DkTdyWZNj6hwII+cTYbyG4JfyZFPR3nc5G0hAw4+Q4LJZqfykMcbPZdH6jwkOLjIFeD5VsK9vaNl5teqc39CTL8Bxm5lmjHdZ1exXMIZA9pwEbPu+7cz11NGKJKu+B8RXKIljIGQDyULpChKZwnDw2deCg/wRO2vs+WM0FWKMG9ew7NVTNO00c4ClgJQhOqTKdKjFfl/39YI3bFbCFRs8cFO395UDCajtr3k+Rjm60RRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S5/KYGzEmEvYlgzW/3Xw1m6Vj43SNvpfAC5eGdkcOE=;
 b=G4haoJdQOfmT4SaAga6y8AoRPbdyzhH3KVKxzqk4lrqjn+6iZ4bgp0F3ISR1vwKNQ1j8c0Eh8E9Bt224QR9uBgMnLY9MJ66FV83vdHjGvWRjVNkJsPB0JvcBP6SkytYVakQU1b5o73KmzvjJ5qNPhEhDXpQnnAkPGPBhShdWQUQ=
Received: from DUZPR01CA0310.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::10) by PAVPR02MB9820.eurprd02.prod.outlook.com
 (2603:10a6:102:311::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:24:23 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::7f) by DUZPR01CA0310.outlook.office365.com
 (2603:10a6:10:4ba::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:24:21 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 23 Jan
 2026 11:24:20 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Nikita Travkin <nikita@trvn.ru>
CC: <kernel@axis.com>, Sebastian Reichel <sebastian.reichel@collabora.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: pm8916_lbc: Fix use-after-free for extcon in
 IRQ handler
User-Agent: a.out
Message-ID: <e2a4cd2fcd42b6cd97d856c17c097289a2aed393.1769163273.git.waqar.hameed@axis.com>
Date: Fri, 23 Jan 2026 11:24:20 +0100
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|PAVPR02MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 992ac7f5-e2a4-4065-ad0c-08de5a69930a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2IaZ8uvX46fwUVZY8h2YT9kRlZRtQazwfyXqI+OJEq2qw0kCoWaTvflA84ru?=
 =?us-ascii?Q?ZTS9J5abf9rCZddiX+IyZtn2sw+0Dve0Zvt+emEzAmAeZFDmZ1eXXxKB+HRc?=
 =?us-ascii?Q?WXXwYycscQArqCn7EOLubKBCdgw9GzUr5glt//Doymsm93ba/WOk66WjWjzJ?=
 =?us-ascii?Q?0uingYquaeU++i2gxT5jFlggpS+ezYKfNmceZUA0KJbAcR5DucAPppBg2zFP?=
 =?us-ascii?Q?C3+pOdlrLaQ2x8JTJ9Ew8MLUGQL4wQM2lE4l02z0DR6hBtowcufvdx1XSrPp?=
 =?us-ascii?Q?bgw+ri1tAV41agezAgLp8qgVl7z87sRr25krxbZl5SZx9OSFBbJJNa1kGANy?=
 =?us-ascii?Q?t/WFqOpvCO9DDNA6kdDiIRNAKwM1cPX/IHtShDDBH60QK6qjPhGY6MTK+l4i?=
 =?us-ascii?Q?1mKPL/AFHLxvNoarpy4GsJDkkly4GtqIG2yYSTMXxLpohBpP1ysiogbBSriI?=
 =?us-ascii?Q?p015Rfz92/mlEl5MCnmgUnv5NIW96RxF6M4BOnZVb2rvngl3Sfia/Qi0ZAU7?=
 =?us-ascii?Q?d2AfsJ+lgLBLWkpmOMQCzz0CXHbC0V7uGf4ZETXq53gJMAcIH+SQyTswxO54?=
 =?us-ascii?Q?Qh6ATSUptlOGgd2djzN8ORoyWFnqFsBqQR0iv2s18HE4fAkW5QqugoA1AwlT?=
 =?us-ascii?Q?byJ85fo/7sQUvxOvs+G4STpHqwcz825HNoPfWO25jxBCHsjit24365Rs3QmK?=
 =?us-ascii?Q?Dzfk75SMk14gY7QguOxWZB+HY2sTKV2w6emXFhyKoxPJMEGotYle01TtrLiT?=
 =?us-ascii?Q?SCIaGZBruLZhqdxxXDPUjShZcw+RKAaXl3MV/kSNHdpmNdpT/l+W3a7kyLPV?=
 =?us-ascii?Q?XjXVL+izMh0sRLiOps2aYD+095vg9eTT0XzDtG2n/5YI5l9YC+nctkcrmGLB?=
 =?us-ascii?Q?b49rdbVGWnK6TQNjTvvR78NoM7zMH1BHBOZ9KaiN+XRW4AXQ/IN2VXaQ3eWk?=
 =?us-ascii?Q?nFbQkvEST9trGiHtceDwq9rkJ0iRVSCjhVUpdWeaJbonhg+VPXpgrahvsE+q?=
 =?us-ascii?Q?ujTYqsl9ShsbDBadb+3FUAPIzHPIXh/3Vva+p7nTSVWksFK5lE/UNl6b4fuM?=
 =?us-ascii?Q?Hy5o7AIFfgyLmeVUf4IXcjSg+KwNiEJc2E/W1812KI2am1yUPYWl8zSl/KuZ?=
 =?us-ascii?Q?SK6G9xPmNYlYJxPOsrG0Wryn313gEkVl/iuqne8/HPdrXR9gKWWUlnDu3lxw?=
 =?us-ascii?Q?So5dm50b5mtJgCEp3eXt3pyF7/X8GPfT2DQX6XbAd9WIWT1IxpxVdihzrPdB?=
 =?us-ascii?Q?eWw4f18V94LeyBo6hdZw31Lr2WNdclzDwqVOI+mbnlR8PKzc3HC/6Hct5JHy?=
 =?us-ascii?Q?U+jZSZSLJC2AE59yH4Btd7YXQM/FG0lhoArZYaWsXlK01+fysnLuNHeWAED0?=
 =?us-ascii?Q?glI3MNv+Z0vppTWC3r2ItJuXtfK60pha9jibPGWO9/4KZY8v9sYvohq1EKZ+?=
 =?us-ascii?Q?dtxMS7mn2qkE1P4MrQBcw3DtXH0/20zWT3cyC2iOu1zENYv9hLIHV7OBdO7z?=
 =?us-ascii?Q?f/lwSvPTpUFtHN9hDBwRVXEj9nNG57Vums1nKqW0BrYbnM6vlHvg12a19tFk?=
 =?us-ascii?Q?KClyKur6qm53sPdiHfcP2i4prA0650lLI1vLIqZIrD0n4n6oShQ2E/cmfhfa?=
 =?us-ascii?Q?pvXT1t1kylg09gHA2rhj3QyzgcmGmJDPZyMkagrUbEryNU2sAETgoYy138ld?=
 =?us-ascii?Q?nQdtkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:24:21.7704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992ac7f5-e2a4-4065-ad0c-08de5a69930a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9820
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.35 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[axis.com,none];
	R_DKIM_ALLOW(-0.20)[axis.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-41359-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[waqar.hameed@axis.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axis.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[axis.com:email,axis.com:dkim,axis.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 830CC744A2
X-Rspamd-Action: no action

Using the `devm_` variant for requesting IRQ _before_ the `devm_`
variant for allocating/registering the `extcon` handle, means that the
`extcon` handle will be deallocated/unregistered _before_ the interrupt
handler (since `devm_` naturally deallocates in reverse allocation
order). This means that during removal, there is a race condition where
an interrupt can fire just _after_ the `extcon` handle has been
freed, *but* just _before_ the corresponding unregistration of the IRQ
handler has run.

This will lead to the IRQ handler calling `extcon_set_state_sync()` with
a freed `extcon` handle. Which usually crashes the system or otherwise
silently corrupts the memory...

Fix this racy use-after-free by making sure the IRQ is requested _after_
the registration of the `extcon` handle.

Fixes: f8d7a3d21160 ("power: supply: Add driver for pm8916 lbc")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Note that this patch is based on `for-next` branch in Sebastian
Reichel's tree [1]. See the discussion in a previous patch series [2]
for reason and background.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/?h=for-next
[2] https://lore.kernel.org/lkml/64d8dd3675a4e59fa32c3e0ef451f12d1f7ed18f.1766268280.git.waqar.hameed@axis.com/

 drivers/power/supply/pm8916_lbc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
index 3ca717d84aade..6b631012a7959 100644
--- a/drivers/power/supply/pm8916_lbc.c
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -327,11 +327,6 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
-					IRQF_ONESHOT, "pm8916_lbc", chg);
-	if (ret)
-		return ret;
-
 	chg->edev = devm_extcon_dev_allocate(dev, pm8916_lbc_charger_cable);
 	if (IS_ERR(chg->edev))
 		return PTR_ERR(chg->edev);
@@ -340,6 +335,11 @@ static int pm8916_lbc_charger_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to register extcon device\n");
 
+	ret = devm_request_threaded_irq(dev, irq, NULL, pm8916_lbc_charger_state_changed_irq,
+					IRQF_ONESHOT, "pm8916_lbc", chg);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(chg->regmap, chg->reg[LBC_USB] + PM8916_INT_RT_STS, &tmp);
 	if (ret)
 		goto comm_error;

base-commit: 432b119ab8d8bf1f550c247f7fbe960e87ba6c92
-- 
2.39.5


