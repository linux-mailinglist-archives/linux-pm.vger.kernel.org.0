Return-Path: <linux-pm+bounces-18834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D549E9C11
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA45B2838D2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC514AD22;
	Mon,  9 Dec 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DcqQ5rGX"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CE144D1A;
	Mon,  9 Dec 2024 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762961; cv=fail; b=E8U7CArQsCJRpe1QsCn7GrsYEG32p4Zx+kc6+vZGYcW7+ASRLI+YmzUxlT7JgGYFYD9bJoF7LueEu4RIs0Jd6SRj0qDpfhKoMPHRq6TyRSwwh2y6W186/esXmeh7h0oN5Mk+kyjcaD+bm/KQo//XMR948G3NOJKwubT65bGKGrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762961; c=relaxed/simple;
	bh=D4JTDphGZ4L4O9Z5gGHAbxkHNI5pYOCVsTd548796HU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xtwm1gVfYg1gGQQo9OeGSR1aFN+u1bkj1INTDK3TxHXTcCo0xMmpmD8iaoeWZ12wRfa1FXg1aYdk3yyR+wMGJdA29jzYX05igQZfvCuXBP6HodriW6X/cV6gKgb585eZhByTeTQSr69l6gha/lBUXmwHd/O6JnWIJ9MVQBjJPcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DcqQ5rGX; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOGU4K0gB7352R9AP10J2MwqQFnwKkvdJHY0EqP/n8WWdR6aubpug9Pa+IFFs64+p7vHQzxx5VvfZ71SwuITt6WBeWlpTLiaC5MlfMs89QDyqImclpVYJ4d7OE7cy0W+lTk+rxqUcaOnZQnBzwV6iIKgW341I9t+foGVlAll/PWcx0fVmDicSGNeFB/wLzPG/kTb5waA/56uNWJAUVwxnGW6BFTxl3afziJgZPvFo0ufCJ2R+5O+DDsKSX5QGiPmq+1eTcBhYv4X127JjjD0r6raetf2302v6XunEjaTkMW0hByeSJ4gOPJxu8bXEE4MqPY2j2bn4v7UDhO1q9OPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SxbxVIQCHnLKYNw7JPTlbeXM/42LDVc5gzY5r0erRM=;
 b=OK1w5hb76pqpZq5hp9cOOD/AjRnBWW/O5tbzv3l2OumeUAfBdOqS6JC3oesalr75qvT2bEMjuD+O8g1/GVIjcVlykuXJCxfFQ4VeK51NayMdhfOa6EQFdOM8exoaSMzK3bxIYfxiN1rzevacxwJggAnXTDuq3PFXgxF3b3IXKj9N0r61/8J89KrKvDoNo6YY2EdErZnDw+5cSaPFcMfYAiP8jEG/OgttHj8amzUGK53WBTWCNVcCN1HmT4kO2ZODBCuqg3Oaq3CLmZFiJDyFtLAZg+JjpO3uc6UA9yY42is+/C+YXXF2QSSq3c4l2XSudwXnZ5PX8DfQD4nya3oADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SxbxVIQCHnLKYNw7JPTlbeXM/42LDVc5gzY5r0erRM=;
 b=DcqQ5rGXiHkYNVQarn90DjtCAykZRr0OV8UjIs6Na/EHZpPpMg3IFJ2W91W3rN9I7WJ76bvOFnN6DDnGU5L4QqtMSdUXvuNqANfxiCweiNrNBQg+U8id1Yk9XwyzkEmTSDRxXcb1UpJgZY+hdYkFBI3ssc4Ftp4k0MjB9wWS32t5cDVxQzaeaX2/bmDy/+EDQuEnhnMGvGrxjg8nWMXygQHFAe6XZiNij8vRID8p99AexZQwyEhnPGY/gN0oE6VoAcOiKgf51xYF8VX2AG3DJNGqhXAhtbn54KhTRZdCdeKm/IHFD86URuGz2LBEF75ews0kqu1vVSegOwlRAMNXPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10022.eurprd04.prod.outlook.com (2603:10a6:150:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 16:49:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 16:49:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/2] thermal/drivers/qoriq: Use dev_err_probe() simplify the code
Date: Mon,  9 Dec 2024 11:48:58 -0500
Message-Id: <20241209164859.3758906-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10022:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c558d9-36a8-4b27-ee75-08dd18716a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zc9trhIxAoCXSwt0PrUoAw3QYzw55aZH1yl7Syf2G6EAilPqrae/STAqDa1T?=
 =?us-ascii?Q?/SzhFTdT6vcZfTJdFWzrNTPbBIs4xn9x7/qC7aijitrUv59MutiXi6CSHbkc?=
 =?us-ascii?Q?I7MfVMS4XsmWyGdQUaQIUOLgZbs7QTgw0hTsToe4QEKvuMn/FBM+cObN2vW5?=
 =?us-ascii?Q?OyWvIuOonn7mwIHl3tgo+br3dX4RR2xbQYYcsZWlb2ANtjyhjC1/FBysktn7?=
 =?us-ascii?Q?AYrcNkt0Yo34JJlICrq3/9o6A+Zp6fIs4FID3bG7v/2PTNPWF3t36JxTWeoG?=
 =?us-ascii?Q?q4aU7AzMa0DLOwuBiKeOBbdfjLnTJh2eBte7psLQWbjuY/IZzfukXamcl2HY?=
 =?us-ascii?Q?AZnQkURWLAYHFFgua2jeWmHsEFs2Is4tqNwG7+2J6gAymVA5di52YPCyM9RR?=
 =?us-ascii?Q?Y22OZFWOGvLDVnaaFmY27OS/m7IvPx/AkQo5Ryutom8wL9lOrrjVQmD2KXb+?=
 =?us-ascii?Q?LF+BwnCqjebW1oTx9wCuIaPWHaQupqjb9EYGCFZKecqbmDM3H4wcHpdmeWGK?=
 =?us-ascii?Q?oeQORvgxepxuEY+3d/+J+Z2Kthog97aSTO1uVugPvh+lfNvQYl+Sw8bOsIm8?=
 =?us-ascii?Q?OZfmpHsgJ4S/uNrt7w7xbWyZVaQ3yGPdTyzqr5Pu7lrB4QCyGt/0Qq53LjjL?=
 =?us-ascii?Q?u0L+L7HWlYnqA4w+yuUe7KToJQhzhhKnILtRTVG2HwIBdURkrjlQl3WxPKoa?=
 =?us-ascii?Q?v3Mj/rhIkPRcV2JcXYTN/7+M1xziUUBiNjn8u7w3SZGg5hG6hMXIF2XJZOUK?=
 =?us-ascii?Q?KWoYxh3//ch7wZZ0FRPj80/+jHZ8ayNMJ+s3ZOk+/if+8Bf7BpCXDIdUXn3y?=
 =?us-ascii?Q?+4fyY2P5bRkVY7YE7nsIhcbHs4u59CVFvjnG0ZnpTxBcvhvTPPm+Oki6mVfe?=
 =?us-ascii?Q?vaK/EfQ9sjyrJ8VYg+Yci1a1bbS+ez6OC5nMptlObblPuBwBWHdQWOKjT/4e?=
 =?us-ascii?Q?7IZ+6mdwDgxh6/3kXnz3XPGIPnmk5hynenrNlm7mku7VchrRajTM0WQSKrre?=
 =?us-ascii?Q?kmdRk+7SS+Zr9o/NXAWJLboxnf3dlowxIs4xFKdF+Vut8Vs1lP4YNi3fjE+o?=
 =?us-ascii?Q?pxybqVe6TDHf7R/OWpIwxUe4UIqlioA0Jg68CzWmVKU0CW4lisJwlRD7v2vd?=
 =?us-ascii?Q?MuBVeajJIIkb/W+HxeBseFBJYjAPNm5+2xUD7JCn6/XkAxjiCB584K6QAun4?=
 =?us-ascii?Q?YneNg7H9mnzf5YDsmmTMllbb6c2tHZJxXVF1fO/2M2ONmEJENpcqrYqSAuI3?=
 =?us-ascii?Q?ejA6p5YSMB3N7bcdDnXApZipxWLWyQD4vWrcSIoNwW6BTbip75ABKhzuyGJB?=
 =?us-ascii?Q?MgVnv6xIRwZMa9KDPs9Pm0dlCs940lrFNCZ2WJTiiPRHuGilV6HqkWx73X06?=
 =?us-ascii?Q?jg6th6dvGZhzU1+sZUzBD/JYQfyNGyI4QvYSbXABtuhYA+n1Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skzLOeHD6ljrxayod4mwEoIL94dELXzBySkUBtAWDJAWzcXlDk4J6S3jAFWF?=
 =?us-ascii?Q?+rbrW4v8plr5H2lJ+c7R/qvorsvWcjdnPZv3P+uEp9EZgvRSFSEr1LjtZEXh?=
 =?us-ascii?Q?LgEP2NyIDaLQibd2I2W9feitcSe2Iiylqqxcegwwbo145+eUdYf96Uvgex7Q?=
 =?us-ascii?Q?j7URrKyMOFjGK17liJ9ZjorzJHZwraz5wKlrzKcZeNUSpyE9afntSE92V6a6?=
 =?us-ascii?Q?2GL1knV5ozt8HNu4gLikhmGLCe8qjlvpbwUPA+nhkAJYZ2SB1WQywjpPVeu2?=
 =?us-ascii?Q?kgCC/LPBjlzBOzrqcm47wCjEFoheKzpnhnl/Mf6ww/1Vxj+Pbz8Rk9uA10pH?=
 =?us-ascii?Q?3afrLhkWjLH7op1gXgIimagYfnnCnXZbfTNyK89+utimnH1kLADQMKNUWQna?=
 =?us-ascii?Q?F1rQrD3wp8HJwjQ4qPhOLkva7QMynS3vAy2kVC9STzZ8U3YO9Lj2Q1pOMaDF?=
 =?us-ascii?Q?igEGIi3htfwQjx2ogWVJ57+QxLR2BpSmpIiCR8fajYo55TKOQCQ2jIbEhFRN?=
 =?us-ascii?Q?oLl+hw9SNl2273BtlygNyZded0UdOrFD2bVCbxw1K8bxwMV3UNlh4gCd4EW+?=
 =?us-ascii?Q?1epCcz7AGsKmuKUKelz/KyrV3HzDX5VLQv0E29kG61etqreZXPBY/FssdzkE?=
 =?us-ascii?Q?GMk+SwrLUh5E+31XDoGyegBAY8us2JbXSyDFJHZGr+5n/WEMT1iGU1zBo02J?=
 =?us-ascii?Q?OWvY5XNBmD/NESzABRLoiT4u/mREep+SZPc6+PyVNQJXfYk6ZxmJBjujLk6h?=
 =?us-ascii?Q?hpoKhX7Pf7rGm3uBvvWRjHpC35QFwlSPCsEugE8z2f2Uw39ZnZnDu08ZBoRV?=
 =?us-ascii?Q?3yY2k0Ew2TXW/sVUGoToHTE02N8akfC3/8xkyuwh7gMRrFow8uDb4BkBAGVu?=
 =?us-ascii?Q?xxL9CukTnBrXlZEkQ3FNUh3k0aWi1iB39FBxn96Dy7JBkS/YrgOB4aa/Cwd8?=
 =?us-ascii?Q?1/h4GeLyJO439H4xEVAe9PNC1tj93c4DlmJapHhvSTT1jP+2r/Rr8ZFhLI3f?=
 =?us-ascii?Q?VSxs6lMkaOSYhP7KpGT4Fj8jC+VppqPXLDQ7GntIBD5PYv9lagR22+RqCmQi?=
 =?us-ascii?Q?FZ+/pW55nwVtJP8bxo338NFybIfmuq3toorT/RKnL+iABtQfIx+6S679t7Mz?=
 =?us-ascii?Q?j07AL5PxEoV7ChMrVcmU1tW+jRAwrL8RvwevX3eRAjLdOzZn9RH7utQN4X8f?=
 =?us-ascii?Q?KwOCgIYx73dd2/mBozyT1DoiiQfcYcRYXx4SnkY+Dqo4G4oXCqfW0Ab/Ag3q?=
 =?us-ascii?Q?auvWuTIiKzhqq3EWCybmjqNIcKPdurJy/RutEB6VABkR6YOryNwJ4H4QeGaq?=
 =?us-ascii?Q?SrAVaNNos8jo+7CPCVb/bEB1I96NdshaYO7r7rDwno3x5gWmmkl+MclBXkom?=
 =?us-ascii?Q?P74WVW9RqU7cpEGTMqtLW3ZgvrUPc+CN6ZOnvdmn/SQzbIu4pUDhkgCSXaKD?=
 =?us-ascii?Q?GAVMJEqTwtFfayL7cWRSx/X4sia4iPicCL67OehC1q5pIpYENdjw8di4RhVh?=
 =?us-ascii?Q?qfT4rsWL6lr9gmDyFwHyzFNPjldeJ8zgPZNPJmMvas4ZZQqEgY+wIxba/UNk?=
 =?us-ascii?Q?z2/NTJpUu9nJhZmaymw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c558d9-36a8-4b27-ee75-08dd18716a82
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:49:15.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOj7MpJ/H8EDf6vZnc4gqC2DRZzXk6+1u4C0mTy/EGDHZm6oE++6RemcvHESnJDGaTLVjX86V9EBoF8Ef57rmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10022

Use dev_err_probe() and devm_clk_get_optional_enabled() to simplify the
code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- Remove clk_disable_unprepare() in qoriq_tmu_action()
---
 drivers/thermal/qoriq_thermal.c | 34 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 52e26be8c53df..183af15c33769 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -265,7 +265,6 @@ static void qoriq_tmu_action(void *p)
 	struct qoriq_tmu_data *data = p;
 
 	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
-	clk_disable_unprepare(data->clk);
 }
 
 static int qoriq_tmu_probe(struct platform_device *pdev)
@@ -296,38 +295,27 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	ret = PTR_ERR_OR_ZERO(base);
-	if (ret) {
-		dev_err(dev, "Failed to get memory region\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get memory region\n");
 
 	data->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	ret = PTR_ERR_OR_ZERO(data->regmap);
-	if (ret) {
-		dev_err(dev, "Failed to init regmap (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regmap\n");
 
-	data->clk = devm_clk_get_optional(dev, NULL);
+	data->clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(dev, "Failed to enable clock\n");
-		return ret;
-	}
-
 	ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);
 	if (ret)
 		return ret;
 
 	/* version register offset at: 0xbf8 on both v1 and v2 */
 	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to read IP block version\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,  "Failed to read IP block version\n");
+
 	data->ver = (ver >> 8) & 0xff;
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
@@ -337,10 +325,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = qoriq_tmu_register_tmu_zone(dev, data);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register sensors\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register sensors\n");
 
 	platform_set_drvdata(pdev, data);
 
-- 
2.34.1


