Return-Path: <linux-pm+bounces-12814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3BB95C9DB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E091F23369
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE215CD78;
	Fri, 23 Aug 2024 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BkcyHBsD"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036313D538;
	Fri, 23 Aug 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407548; cv=fail; b=m7THkuHU3oTs/Hhex/wNA3/wI7zyiTsXxW37uCIlFJ2Ihuyio4YA9oU65cVrv3THdPZciib4BKl0MZJNEEjeN+vOTXfDza68rZsucUgR3B4CvyCGang7Qt26uhn8cnJq5+YTgepwmsCSuXjlQsK6VueNgNEdNkwRgTooEPGJsT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407548; c=relaxed/simple;
	bh=ps3SIbxBI4pKrTISDFyV0/mnOhN3sqFt+dl3g0o1xfk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XK0wBmJqqwFUmdjUT9teRRG1jIgROk0vzNVhbgrR6s6cRhAM/HqA91QhwrVpczbjOI0htB7rqI0WUjw7nWz7Kl57YwAppq1Um8Fx1G0qjZEx1I7lW6U6grMezxMYhp9Nfq1Pd5NZE6u14PRQJbM4CZu7mkC5zF4kD2oxiO3fvsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BkcyHBsD; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFPhbt517+edAsicn+8AHA8rRkJG1N0Vc8fnV4MR/UONhhht9DJsJIu1q/e25MGt8Ws7VwjiPdE66ghnwcTMHdG143tJBC53LgOVrG7XgE2OqkPaS0eFxAKnBM4OpqpYZKlaqae7dNPA3Psa1EzIUJnaeaQS8J3CrCsDZEifq48Bh/l8buMWlVtWdshqaBcd4L0yYhjW/nF6DdJTPje1y8fIgUXMoXp3gn5KTo2hF0vkgtSUQIiWA7Nhkgyv9q9ZZk3Atbnl/yWeh/dYM2NuN6Hulycr/s6gCZjBZR2O+ez/kHbgvP2xOif9iqwES9lNJ2tN8XD8vPJhNYIEGw6PEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE1ktnAocfDQGwjaPOMeJwkahtj+IU9lT9c2qQTNDy8=;
 b=mvsLkVL8cDwwGUWyZTYk9SI+IcksjzbApFKH1rChytJPjhWLme5ZHmImFwhtgNFfG2mp9RrBQ80KjXll408OrGXOJgpfc7sJ6UK/yfTmvUkLPaV3HBJmZwep0jJRmMPOvL/0OKab5fdPbyOqlLjgwkt4cY45nM+k4sOO6mUYBpt8zQh1t8kjuxDTeGgIlMy9Ku3NkMsrmxrMKsJ8hFljlc82IYZLulaNsxmsOKhLAH3vu+1Eq9jmpQZ31Etvz0rt2SkYlC6N4gBYw4z9f0w76dTY4yJR/+4j10SbcZkl1N8sv1GMMmbv3gTzWYeQEa6DVn69kqadlUtnpTANyPnAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE1ktnAocfDQGwjaPOMeJwkahtj+IU9lT9c2qQTNDy8=;
 b=BkcyHBsD1nCHtL4S5Dl8YRFAfx0E7VnGMzuLtoLJtBi4NHd0bBV9/q/M05QD1hs/7mTwyFk06Q0+xdnwTGnaf1rJgO7YN0ZAA7uiKBlJ0ChzcHFGZIuG5f6JoAl2XoyR2nsIaCXh703yKUBnCx19aq/r6S+jIBl6oEMYydYAGBfAXBIYUeZ63H4nEjJSr2M6KwXVJKt+/VWhLtT5ETJmfzLNHI2GbI+xwlWVilUtv/ltIeINF22d07fx3068A2J/Z+6Bvcupk2rpYgNl9l4r7lHsQEYxs6MxGkXeYUyOwWdv7cYWIQhW8rGDb6Z4fdsuJnQQP2YUxmhxmXUK//y68w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8864.eurprd04.prod.outlook.com (2603:10a6:102:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 10:05:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 10:05:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: ulf.hansson@linaro.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] pmdomain: imx: imx93-blk-ctrl: disable runtime in error path
Date: Fri, 23 Aug 2024 18:14:25 +0800
Message-Id: <20240823101425.3921920-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbddd5a-c2ec-4052-0c7d-08dcc35b2636
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?biiG4auu/L1x18V7VL+Ik/Jdcp4as8OTi6ZKP/Xc1Yi0MkuZ1tD1jRVnHSum?=
 =?us-ascii?Q?51+9s15eJjKRg5dZLHURSPvDKQ7GAqCnF2bA4D2WAoiplXsHCRyNleX+P+1H?=
 =?us-ascii?Q?vZ9/S3d7G5MVje1/hPARd/MUInngcdlswdzGYkmjaYJOzVy+6cvZQtypUndi?=
 =?us-ascii?Q?2J8quxctXAJaqDugKj2PHigwgq+IEYrKn8aVDq721fpEdGi1QkTG/NKDqM1q?=
 =?us-ascii?Q?hDXKzlN3/8327UaC66ddgjCab3y/54qk23ZmVY1EqCOUQ5FfqMQK8Kvdwg5e?=
 =?us-ascii?Q?z7mSavEu0IjGzH/F19BF7a8rOpT2b+LaG+RxdADnaLH/J0a1ENJGnEGZr41y?=
 =?us-ascii?Q?BqcWV2fJWn2QpB/drGleKzdErLl+F2k95+KZHOjr01EfF9CMfNhqV/g3kGGg?=
 =?us-ascii?Q?C1h9dQaWZ7Xunphc3KjOs3/rLStvMOyEcRTP7SNlZUUkielcKTEJ+FowDae3?=
 =?us-ascii?Q?Q4mR1NdFEkEUBYGiRLhUOkCBN2/IyncuCndBrNhxCEuyWH1EbGxWCwuefAMA?=
 =?us-ascii?Q?XIx5ajA0ZK9qqoG6zK3GP61Dpib4aYScP0MkXk1pv+VrSQHGx8VIFOYvM0RC?=
 =?us-ascii?Q?Rm8wEmtnARV96d3DqDwmO5SQheK7TYJt5OSAMSmXVaKVR1BzbPm4Z0KXd07d?=
 =?us-ascii?Q?YHlEnJkjp+J3zAn9EWEil89Mjj/oc0+r/9gbApm+L/0jZ/BSHP4Wl1ja9oDu?=
 =?us-ascii?Q?SPtmwF4LE8eZL23N/EtZXsf9lk1UVn3+7ZkIWRtcXo+phv/FQlQbuY+Q68VV?=
 =?us-ascii?Q?SC+7PbBrZRpvT4F/Tjsnt1jWG7IGhLf9ZagGAWqkjD/MfNV4Hh5Txbj4uyrk?=
 =?us-ascii?Q?TrRBAApUWPyEQzZzttx5OvyMnw8ceQUvYB1ndJcc4m+UtFUxYQexXW8+0XmC?=
 =?us-ascii?Q?G9CXATFz5zZJRW9jAWLjRIxmryFXQxFglKpqKcNlPEBwXk3mhfgSeGImje72?=
 =?us-ascii?Q?qXxjum+R9MGmYWWuU6/VVIVvvW6gjZPDt9xXiQEvJmBPobGWqdLvfVqRNklx?=
 =?us-ascii?Q?Rvu6d9ZlGwoZ4Xb7PwFJ4yZom7TKwCjdaPlntLX/V00GIOoNT949A6/9034G?=
 =?us-ascii?Q?nvgc9KkY2CZXCegj+wlo0sB7MyPHZsttnWbW1Y8hxF+VsU67H6erPOBVZ59u?=
 =?us-ascii?Q?wzHD/IpZg+KT5tGQJOdelRPwANaiq7PiGETCLLQxGSIOrQqfnJiHQO7eQ1Lz?=
 =?us-ascii?Q?DiLCgDU/lGKIsUAc6FFqF9ixFKQuusd1smlvLX+FO6IAzXz+ANgpB68EN3Rt?=
 =?us-ascii?Q?oEWIkj9tSzv3w9CmmqYZZgKVqFqf/lMTZ/6SvQEp+8ezGarCUYwAQicxMkRc?=
 =?us-ascii?Q?3iFnR6VlWnU/jgIWPNXRO68xQAxM60eMjDfW9cAq+BVgVAbmYU6xvl3PmmDk?=
 =?us-ascii?Q?6foOMPh9rCMibRgqr8ehiAMpteUSFZXkZzeNW4zPQ5dQTS4EGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwkphhRRsDAhLrZBcshKGW26EY6vmgcsFZLrSe4CK0dgHH1+BND0QMIXxUzo?=
 =?us-ascii?Q?SYmx9Byd3Nqjc85fLH1QE2ctqkvEBtxIpuM9xVcnYJRvpJohYwI90OHbXglr?=
 =?us-ascii?Q?RBaqLKbF2X7hKq5NQRNzEEGFNPzIWAmmeuvOJn48vUDTbKxkN9P10CeVbPhd?=
 =?us-ascii?Q?ySfeSiIbCdVzPsV2KsvtUFtItiz8ntkpv1kzHaJ2e5gZJ3NiX4WM4662Jkaw?=
 =?us-ascii?Q?dnsXD+m6crS2XwCYNCF/Bqa7VjQj+UpiOvdbjjQcZFdgc+TEbrHQQeMBRmdH?=
 =?us-ascii?Q?cNYNEHjkTAMH5CT4FGMTS4MruW6e5TpxR4oY1czmqpSz2yBA/P6sFXMzLfxi?=
 =?us-ascii?Q?V8tovO9mNh5j1gJk0zOP29B5PCTTdGKYYVWrF6Puds8kUanUE+5L9qN98gJk?=
 =?us-ascii?Q?a0om2dWNoaC4VLxKq6T2uV7wp9d5zwgcZX2D9yemcu6Nvvl4Dkj83Gc4Yuqn?=
 =?us-ascii?Q?Vz2Vk3+a5lyT/n7GtE7+8S1vFeJd5v+X4QqWFbl0eTqTk16n4qqNadZPOyFG?=
 =?us-ascii?Q?NPYNgUmtRwsc9URmZ2l53tQxFJmFcPyovwln3CGTja9MpJg/Ofpa8ZSL49sK?=
 =?us-ascii?Q?4y75+xspnPkOLuhc4eqeF0FSkOMavrOeRbOVMZODX19aiFyCcGGvxgD3FRKO?=
 =?us-ascii?Q?CEOFY4bq1MgM90wkTg2Cn4yBClC3b607Ecek8Yr4/wdNpO4POaZc00mpzc42?=
 =?us-ascii?Q?OYwIjNH9L3BE1UB4nM+oJn/x4rYtUnK09HZtkECs0CGxH7K4ADQJbPcGlnpe?=
 =?us-ascii?Q?oCR6HKvrLEEoEVTrXtAzroXGuxugB5szbK1bvxOfBj1y8i+Ld4VGLtqd4fgD?=
 =?us-ascii?Q?ssLK1tiaD/wGQe/mnknH0F4BJdNDq5BJctnLdGw0MvXvkpKOoOhpOYTMyzrL?=
 =?us-ascii?Q?pGDrJksQrSYwl+klaa+vsB9Gq/ENopN2cZVFZxeGiO1ZC83DBdDTBAbCLZA1?=
 =?us-ascii?Q?KL/xOnWY6iNoKoDUZoBXcjIVxksyxwBg1eJ6w5pU2R58zmkl0Rec1N6KTfyX?=
 =?us-ascii?Q?N45MMDkjPkEb9C1yin+stN/rReaMYg3eJSQcetWn045m5iwPqh2u5Abxi7do?=
 =?us-ascii?Q?cUHvnu4nvFbgLb4GNxIVdjIUNmgCdR8zwWipCMRBGyTkrpCB+XWKypePlnqs?=
 =?us-ascii?Q?X5B3i2gGqGgFeErMhjTdiPW3+eDNxKQkQ27LhPfd8MuXg7n+bHDUfmvdPRyR?=
 =?us-ascii?Q?Iz1kT2nbM2ss+YBL/RJbqIx+4KGf/T4t7954fKIjypjvNXGJeQnWTDcHrVW6?=
 =?us-ascii?Q?+/2v1xXpeSf4U405LwituiIEDMks1S3gFih3u/5um96vOcBecyv1PBabCqzS?=
 =?us-ascii?Q?3CIIsLpbt0Fksb79bPj2wZIX+N/7FhFEByJzcvBoRhtHyQO9vWsKtF4+XxaQ?=
 =?us-ascii?Q?CHqid0I1bnvCwEZuwSjW8+hgKr2rUe3KPQIzLyS1LirIgb+Ba0lAd5IUpvUE?=
 =?us-ascii?Q?/TZfWtneVigh4xWlDuHdHvW9XaOYCEi6RADHWTTboZat9iwoW810FGGusAb4?=
 =?us-ascii?Q?8qawew4IcBeG9rdmYRrnOcRBBGgeLr2vBoq/HPW5IB9c01SfmRUR7ovi+zqi?=
 =?us-ascii?Q?ItVnMx74oxJoPJgGEHUun6/aHppPUqsT3U0MZfyE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbddd5a-c2ec-4052-0c7d-08dcc35b2636
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:05:43.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTqX9PubiA0TuSeVtOdd+ROilryDGqHh9oT1ekCaV4LJvIs84c9J6fa6T2GUUJoX4yg2zk5ukq1GChE5Mm989w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8864

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_runtime_enable to disable runtime in case
of_genpd_add_provider_onecell fails.

Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx93-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
index 34ac7b722b90..9c2b1af1367e 100644
--- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
@@ -287,7 +287,7 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
-	pm_runtime_enable(dev);
+	devm_pm_runtime_enable(dev);
 
 	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
 	if (ret) {
-- 
2.37.1


