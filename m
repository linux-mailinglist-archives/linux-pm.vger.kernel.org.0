Return-Path: <linux-pm+bounces-12712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817995B23D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BFD2868D5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1A17DFF5;
	Thu, 22 Aug 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ogoNV6xN"
X-Original-To: linux-pm@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010003.outbound.protection.outlook.com [52.101.128.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5BF17C20E;
	Thu, 22 Aug 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319859; cv=fail; b=iwm9adnsc9YLp3Z4AWcsghMbUlz35LsvaH7XleLWUlWLR4KAZM/oooYphMJeUNVrwe14k7x0I9w0nWuFgq8PGz362k8qUenfOuIctHoitSog2xYnXA5i7VKmxTldHEISrTHBhcFxEA0BGQCUvVRKgwC+FSggvnML13L7TKE7lDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319859; c=relaxed/simple;
	bh=WEQfA48oLE55+pZ55CSwKWYzWCY8ZHledGhxG9ZdVFE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PSgK/nZFtyuHFgzC5M5g80ufqTT7+hI1Bx80bBhLwKdQA3xX6GfGJDZzCQqJJ33hc0BU5sYkr+8p963pvFZPdcQTcqR3KdQ9xKWSz8fIXw+IST+oY+gWbB5RbSSHaniYr5fPKj8xDWSL+m5n5l9WC45xDIwL+L7oam3u4DWw2bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ogoNV6xN; arc=fail smtp.client-ip=52.101.128.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArorOc211oyO6TQtk0CM7Am1UaKLdmr58yYZ1ygN3UvJaxWRh5zBE9JiTu2MoAHyRokB0GWvcW0USmTV9mQ7tkS0FkA2PDCDMxiWNoN59EdnwL/0rh/e6zuKdpSFeqd5ukOdbuOeuwZGKx+EG7wF1G9jcgjpxYi/gdDs/dDCV3pDsI8YLloEo8+oxW/jovBr9H/TKiU+lDRLctzuuP4pJ9WLeOe2P7wkXL4NNWbktRzGP5u8XmTZkNOhu/zwi26cU5npgqtLuyN4bK7NllcVuMJhfFSvzt7rO98iEZQr9QazM1dOaahZvOV01tkOmE2nTrL9hsaG5MYnH6PVx0lM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCs4cUO+FnPpFNr90feC2GCznaYbsGPqupsQA81Df6s=;
 b=v/w35PRnHAMQjiUVf3yiQeR3n74g7MbWysZHzkn4ub1PsRN764+yIebZ1BGmt8C456uY7hVCeb6aHnaGlJHDlh2oJqxlZyt4x2GrSuNYm2+BPQlZttm1Vy8SbZK0/LNoAk1cfufgdVuMm+znfeCO9MzWDmvu0UY9DG2x5PG8T9jUnDJ8N9/RHpvBH5dP/7jRUUUFc+J/voiSAXxMZDq7lFAuhkcOkmS5WWCLaLICnNivKbRF58p+CVb9aY2BdTRWJ0HKSAtHwG8y42jnmE5NeAYE7Sy3l2gHGWe7cQmejzbTaqVSMNgLIo64DObvwJj2FRtdkq9X+51ffqqcABMsrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCs4cUO+FnPpFNr90feC2GCznaYbsGPqupsQA81Df6s=;
 b=ogoNV6xN+8NBmzA/FT2iF9+66wuGQDpiulzYc3fevJCShNg3KioCFrBgbcvXm7aPFOLkR23cmWwxDOmrGJOezvFI8Xmti4ZIN1OKkqzbsF+XPnUfLbpUaj9QZ29U9mXDG8k+AmUXnJxPbU3M1q6QBSJ3VqJuFe5D3hDMq59TChFnb5Fps9cwcXzvz6oxijB3BX2RW986L4ll2hsG8KSZYxCPm6XDGE9FGSqlU2/eC6UWJVhFGhiK0MJaGxfDIg7gUU2IGvzBLCE6tksyIKfjmfnf67xPT7IHrs2xuYCqh6rHLaNQh3PdT3JVgPfJzx8xPtN0x9kls5eproqjJ7A4pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by TYZPR06MB7315.apcprd06.prod.outlook.com (2603:1096:405:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 09:44:14 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:44:14 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH] soc: ti: smartreflex: change to use devm_clk_get_prepared() helpers
Date: Thu, 22 Aug 2024 03:59:11 -0600
Message-Id: <20240822095911.1644729-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|TYZPR06MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: a187c96e-8515-43b0-6753-08dcc28efb65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4z/2e+fCNhZA+aCTWmzF2gJu+wzFzmjLGh2R0eqrrhfmBE4VfzXE1c6nQxF?=
 =?us-ascii?Q?49plPCTiHCd2+odIJ4f2Y4UndvhpSP5ToU/RrRp5BuBx5IvAkv0PKLGrzQxz?=
 =?us-ascii?Q?VPLM9exzZkDIdZPsLRfIyseLXsUbg3HGlqbREYwxHb/1EP/OO4Cs0Xg6in6O?=
 =?us-ascii?Q?dBVJUkVHm+l+1Vu2lgM3WO53lmgZxFr4roIEjAlaCs/oQtt0MrryEH0qaO4w?=
 =?us-ascii?Q?ew/DSQMiXEtW8m5NkRqyN//ftByRyL/mJXEu9drWHHPXIiK/8DOwqMY8YiuZ?=
 =?us-ascii?Q?82SSoAM5jO3dqUDyj3qPywgbdXpKCODysrlUyhFhXgLZjGlEihbTagj3Xgav?=
 =?us-ascii?Q?SLgmdLDJY7E+X4ovGGIzw7F63StCXYMdgEudZG0coo+QLq5p7tDPRydGD7ye?=
 =?us-ascii?Q?2aE8uuzFbsVQAShSe7XuWoN5z4TVdYed+1y8ToazQcqQ6KNIvONb68AlqMEF?=
 =?us-ascii?Q?rwtMfCkUR2bn9+tPaUiTa2nTlFwH3V8expYuDh7ikji3UOlvsLT8zQuFXAW1?=
 =?us-ascii?Q?Havzm9q7WC2BFweBj9LoFQTvxjTxWuprFzgoTBp7yKDpN31xxVwevKXhMkTR?=
 =?us-ascii?Q?UE+CkmGq8YYGtkAGQcxXRz8Faz155cLQl+ZtxnN3h66kICnx73t3KKRcegQm?=
 =?us-ascii?Q?CaoY+N4kv46hzOaJSlpr0vVXXlYoBSXz0LbmKX2/Dxtr7Im7Kna3DrZxUMep?=
 =?us-ascii?Q?cPpBGEV/QXZYPHgS7n0reA2bZjE4ByQOVzusKiImX1Tw/BsJg4aUcq9blCVd?=
 =?us-ascii?Q?EX2Brz9jXqPcgzLUGO403zpP0fmUoGB94DvjPWYz4XAoggRIZs0bGDLR6/R6?=
 =?us-ascii?Q?Zs5zR+PeZKVWelb4p2WgvjJtedi2c+lPmzignnxsMnSPK6XRCOEhqYRoZYVf?=
 =?us-ascii?Q?5NK68XGbA92/HrtOcgmRfs+kAa/Nd3dUvF+sYl4db6BvsrP2/VI68cAsV/oJ?=
 =?us-ascii?Q?mKf87ZTjJlDR1Sx8jJ6jE8YUWOyWbMOoQHjGeGS7TL5KYn7PYjAxZlIUbm8L?=
 =?us-ascii?Q?h9M/Eox6bM58PrdxbAalaOYfIRqpB7sQg2X+2i2HyXXzASm96im1yvNdnA+W?=
 =?us-ascii?Q?PSE8dUqhDCophHCSqKJiS8XLgBXQWSkW1EXlEIP6Y2WZn40W7uVqnLVQPbN1?=
 =?us-ascii?Q?lDqZdIXO6obH8Mob+DjaH+cHGGYBcM2vQ0q6hsMfWdU2/JSFSoxjutF6fVqM?=
 =?us-ascii?Q?wSesA0nULu8AI8QxDMBqBtKtXeAg1UOu9qITpPwpyLeqGFKvKoZyDyAOnaEo?=
 =?us-ascii?Q?NJgNJkehW98PJf8O6zem32Y3np6wakEEj5rfnBkMj1f+5acC6eelABGYCdzg?=
 =?us-ascii?Q?CFJnLiLgMg/uZNx9uYyWn8LhAMkarg4WtABQsBuz+bOb8DCA5+uxbR8lXlIK?=
 =?us-ascii?Q?/SSU+6sAZpiOcguXOzFnr6LBU//85m6HEoxQ03lGp4WVaZzQNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b73k3Rv19pHCSHqUufy0/ZqoPUlq3UsxV7pEl6lwMuIFA6sj9KUzzCe4BsaJ?=
 =?us-ascii?Q?xS/sH1gFbg4WxlD3Tmwh01TXQkgonn4yJP3LHtdNknkArLtSOsk1+x/tinOJ?=
 =?us-ascii?Q?y+aOv1VXDgMa1ecFNXZPS9412T2qyWqLUCmWyI9J3KkKBxgIIzQEzqR7Wn3K?=
 =?us-ascii?Q?PAqSGNg5mibNwSDj/O+QYwfHE7xyVaFbB0UoUFUhxI3ycAbrLUIcUX+L+60Z?=
 =?us-ascii?Q?9mTbeXQ+XnI6a33/qW6dlNeIOyPMHUI8xXOzocHuTkUH5uFSQS9r5cmMbAMA?=
 =?us-ascii?Q?P5fx04DhIwN3QOefi7TxvihGgG9pmQPvI7Vksg9Cedj+TQtKErZwM6ahXXTM?=
 =?us-ascii?Q?f1T3OWSJS2vyz/gI1dy+B/KggK4yKCFg9ZlWxVbazPLRCANQ/k439IPrkNoT?=
 =?us-ascii?Q?ABrFyyzWjpC6pjJvTF0CV4nS7vhnzTypxqsAVTgF4aV0MZACCtGXu53C43Vp?=
 =?us-ascii?Q?KHa52QfPouOl7xoma4WiGOrkVVdVchCdkI8xBlbyZIzt6mFMJ9nSrLRcyhyb?=
 =?us-ascii?Q?H4ex7Y3ZjmV/ahXJaq7k6baBxHxLynj+u7ODOC3njDNQ0QCql+BQpHm5ujGk?=
 =?us-ascii?Q?vQ8MgfXHF84EE2eIHsL9etWn873X35oLbnnykGjp47hkd1+Sgeide18w1pHV?=
 =?us-ascii?Q?GgE7NVF3UqYoY1Doan58n5prhkTVEZ/+6i/dgqerJEBOcoXW5C3GdcZgMEmi?=
 =?us-ascii?Q?QrTylPy4VATgPzqUQcP16BqzpgHWJGNSm2Y042R2sSpDBLR2G5Ots7euajkv?=
 =?us-ascii?Q?U3r+0YHNDhDbzGHlmed1fFytTHAbPeRZKH2f2Y7IWIRwu8nUxBxTxXQzuLQb?=
 =?us-ascii?Q?N9yF+o6GlqRc7EmyQx58RwtRk67jhRrm+GJiYasDqo3ysjjhTMqnyR2f6kus?=
 =?us-ascii?Q?OnrpxhUuGE0F0kG6i1ZJxrUYuCFLRWIQcwG6bTXc6bD/MTRQTcg93mKgruew?=
 =?us-ascii?Q?inpUhey8xZIoKMqVTg83E3hI2aLkiUY6agU4w9txeOVxDwKYnIMJ9mwaR/sG?=
 =?us-ascii?Q?bgH3NZGY+7QhDDUQyyKZR/kaiTfsC6GqyThL9H56UwxMYCnpImTxeCiSo+ga?=
 =?us-ascii?Q?tz1Z5hF5qolvSktqVaJLOAMDnsZKZSlX7fTeMBvjr5EgyxP4CFi7g/NWrQep?=
 =?us-ascii?Q?QkHGo+VXRwVmGKpiXSRBe3BfrGKWAjNB8eWqaCHPo4bfpKTP0T8VioMCPtXs?=
 =?us-ascii?Q?hjUycb5Tw9PFSfVmipZfKVKtYcorCILB2E1BmJDiUQVJ129RXtQYikR/ew7c?=
 =?us-ascii?Q?DsrDFu5atvf24pNxY6X4R5Kbw/3fJObwHyRGT5G6jX5AN0zZGySESmFeK2TW?=
 =?us-ascii?Q?wEmloSqaSfC2cQh3UblHX96DTRaJ5jUowQo1DF5uMI8U6hTjy+RkdhO+swCG?=
 =?us-ascii?Q?NjSWYgJESlxcVvhzjSRi4vJisYbTBv78ROfCDMWWiM6XugY5c3uXoFH8mm2Q?=
 =?us-ascii?Q?+cdkAQeLYzkl82a8oWvq/V8UFLrJvw8oFCKbTp4liTnHP3NoxALsgFBOsuS6?=
 =?us-ascii?Q?y9jDH6vL4/pPe1r3vF/sxYQYfQdidZ6colNEoRKT7i0uqWyGhDjLRGkF4gIZ?=
 =?us-ascii?Q?W0gDKQsuEwdXQclE38cG7k9swZa4q/saqoreJ+71?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a187c96e-8515-43b0-6753-08dcc28efb65
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:44:14.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQEAs5WmjTsGst8MJGEXsZJi72sIvZxrJdiUXCZNmce6aw77g+l0t+Fp4FiAIremGBvf7wRcdSsQrV6UW/SpCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7315

Make the code cleaner and avoid call clk_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/soc/ti/smartreflex.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index d6219060b616..103ea0ae7661 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -844,10 +844,9 @@ static int omap_sr_probe(struct platform_device *pdev)
 	if (ret > 0)
 		sr_info->irq = ret;
 
-	sr_info->fck = devm_clk_get(pdev->dev.parent, "fck");
+	sr_info->fck = devm_clk_get_prepared(pdev->dev.parent, "fck");
 	if (IS_ERR(sr_info->fck))
 		return PTR_ERR(sr_info->fck);
-	clk_prepare(sr_info->fck);
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -928,7 +927,6 @@ static int omap_sr_probe(struct platform_device *pdev)
 err_list_del:
 	pm_runtime_disable(&pdev->dev);
 	list_del(&sr_info->node);
-	clk_unprepare(sr_info->fck);
 
 	return ret;
 }
@@ -943,7 +941,6 @@ static void omap_sr_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(sr_info->dbg_dir);
 
 	pm_runtime_disable(dev);
-	clk_unprepare(sr_info->fck);
 	list_del(&sr_info->node);
 }
 
-- 
2.25.1


