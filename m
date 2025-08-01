Return-Path: <linux-pm+bounces-31761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15DB18364
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E22B17DD25
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4545C267F48;
	Fri,  1 Aug 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oPxTk6JM"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1608F49
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057475; cv=fail; b=E7K/1mlJHSKTcneZeu79R3iEZrTRlfHqqovXp72jXaf9HjnINPSpYnvB6405ir0ZsE0eCeI3wX+qe0y5oBk1TcDTuti7obi7Qpr7xC1eX/RWvprQgSwGJS6ZAa8kNaSTiDmWNnlGM0/uMhoLPG+DC49xxD8WPkRBi8zGtCzmrko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057475; c=relaxed/simple;
	bh=wfoaHRgDAtojfvDLIsQ97dDtFSNax47Iwo6Gg7tAUGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bvtme8eVlm39eRX/MRd090ljAeocFmA+Xw7T3vZ2pFkWQC7Iff80P44jupzJzWKVPYkLhqanATMwmgouul8ZcPcXFq5sydA9yTjZavl58vvXlT896PdCeFPfBC+CK3uXSwq7Zt/oiNl1yoxxsu9yKR7p84t4Xp1KvDwxUmekNJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oPxTk6JM; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2pk7pHG07LG8WdGolrCxnbRES79h6kPmeI+yANbdfkabKOsVZXU/CV+/s9Bz1oQ/3p0uMPFDo2KV6BdAQ5fjRjADC8snJ5mryVlGD9gcA3ggjn/w2mmDXQtgQ1jlGXyrruQDODyRADz8lMsFfS+ID/sA+dOVnAwuSc5RPYsfMzf+suy/XWmdyxJMt3XXjfvtR6XefyKCLwHFPU7dFakPmsZbkHW1+2j6Hvgv1vta+iTH8S1cRBM3vs7aSNWhStxwoqkuAtY72yipj/KJfTK+3bz33aY3b1IX1KwWX/tCxtbMGaNQOf3rXD5VX8Id2t1K0q74g6huMn7QxV3zExDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmacXnewKIf2y+FV+kEfDTCgHdZ5lJz+FdU0t8ZytJc=;
 b=KSVf007i3dAI0v2yy0jHLV2qrblo+0Mk9Dv+vhKG6yl9II8cMfYs0sAt+4NC855F7uPScM/E22X8L4oCBqWcNhJiI8EmI84iS+pjb1n7qTw46JPXssLo68078pzGhb4TuAqvHuxypWOpDiD1xWlw6QVmZEkAc8XY2YC8lWjcGgSo1DhwH1C04/06ULBDur2y9S0zhFn13O5HUhFhTLeJgX/cTH8ERMWov0hbPexZzAIIg5p1AZShfHYTUuIglTZWvFp4oyT773dtL44orq6NSqDQDoeuA0YceXK0GbwYaDMBBYafTh3ir9FeDbKfx5d+aFiRVFnVjpXeGqHT++dBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmacXnewKIf2y+FV+kEfDTCgHdZ5lJz+FdU0t8ZytJc=;
 b=oPxTk6JMehyIYFBkj7Kx0UNKsIijjRnVGkmcMuuo5o6aotkWIFmldz23xa2gCgM/1Uf+3hXIs2MAlXTNZwg1Sb/hjYIZR1/Na/b/Uxf9FbZ/bSfZfLPIRYtzPUuEq399NDMISUkck72CIKgT7dhqUMmikljRfL9ApLpKYOsetUWQEgeVCgFrAyGSArEKSjOfZTnUKfYrW6Vey7ql/iDGrbkeSiDka9AoPT+5YVyuuFhevqoHZVjEA4VCvOIzF9kQk3YBRB4Yt+oYiiosKFP0tQ+0JDRe1YK6VdKvwXfYnIW3kg3eO2BTVU5zoV06ObLz46cIbdKYwq0Sbtny1L1LVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:11:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Fri, 1 Aug 2025
 14:11:10 +0000
Date: Fri, 1 Aug 2025 10:11:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	rui.zhang@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [PATCH v2 3/4] thermal: qoriq: workaround the tmu temp jump on
 imx93
Message-ID: <aIzK93Gs/+sXHBZU@lizhi-Precision-Tower-5810>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
 <20250801081119.1999298-3-ping.bai@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801081119.1999298-3-ping.bai@nxp.com>
X-ClientProxiedBy: PH8P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e879e2e-c5c8-4a61-770c-08ddd1054410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?INnlniYlg9/FWSEOvBivOoVoP6F6JP9baKuAoue04L5PQZFviZ/pohvBoKS+?=
 =?us-ascii?Q?FolAvlLT3nKn+ha2CPqgDo9RHctELqmdJIrvT7KOaPzlWoqyrlLavO2l/nLH?=
 =?us-ascii?Q?/m/WEjmNKfoqHlVCZU60qaP6+l4y56Z693vdH+bm59oXdscJ3nL31hMfMVjh?=
 =?us-ascii?Q?SNAF4Xe/XEffZaVqHAEmLZb7IKrlUQAmpTHR3k5qsV2aIMWsJTx7fmrNIjGQ?=
 =?us-ascii?Q?dTqeMlT5R7TG5L0oeh8VDasQ6EcaC4KbpxEGwxvp89H8xe/0einUwLS/Xpvc?=
 =?us-ascii?Q?ohmekCHCkUuqZCLucPsJtSs4qqJpBTb2No7+OMGzm3V3mZv8T0uswN5E/lHC?=
 =?us-ascii?Q?M27lgdk2LQbEcM4ryLWw94QJTrPX5/7RsmIvB96MnRiAQWTu0aj3cKn0UZWK?=
 =?us-ascii?Q?oZMuCLtg9L6oEgxZUcmDwD+RroEJwaAuQDg/0STcb3MOlFms4rqLKmiLnuur?=
 =?us-ascii?Q?QU1zAjHfMdKwvyLTKk39+ZJx1eRo/W3dl9FSQaVIU3GJzECOheh91f/Nv5dt?=
 =?us-ascii?Q?Ev9KC8tnZSI4Q8HhPIjwSH1JP4kjPT+M9q9OLCV1w2rfK+8d277IxRzICr9/?=
 =?us-ascii?Q?foyYFtNZXROXoQf45/UyNgki2vkAvPbnn1TB9bN2wzF/xFFJ8E6oapebS860?=
 =?us-ascii?Q?w4CrmlIw6Yuh1MMjkj7HQl2VcVZUSaHHJceXynkQcD4SE6qxhpAUEvnMDKns?=
 =?us-ascii?Q?gH1qC6zKSW0X0Mfomu5iuGo3AxcTwTIzxTucB6jBrLEjrAEh233i8lrkFQX3?=
 =?us-ascii?Q?8wWlJerX1I2I+Roma0j6JDkl1FmYsn4sggFEGGl6EQhAV7qPrrpdYKDQMCAx?=
 =?us-ascii?Q?KK0Sv/ZQtEqdEpmEQdGVMijuInjMUhCTB7Wm+eUWAOSc4ecRQmYeDIxw8PPF?=
 =?us-ascii?Q?OZhREsDtmdFgLsAsnwUQbp6yyu+nImMAMm79q0bsV1bufZ/m3ClbDQLXWQhL?=
 =?us-ascii?Q?zZ5fpeLEK4wIQJD1i4yEB7R5p3TbUdMWxDVTu9ZFugFxPhyHHIp7Eq3W0++M?=
 =?us-ascii?Q?Gw0tivJ/bdtctoe14+Hymsqe+y4lh24FbCTT7VyUJ1pnath8PHynVW9CbVxl?=
 =?us-ascii?Q?gAGmq4k+voW1Oas/slumwxzFM9UGKMv14CgFhLV0x/4PL+hxG21aVIgk1CG5?=
 =?us-ascii?Q?neuBuZ8Z36vXi7cVuGGLEj4bkp0tGahqhxvEVRTmbOPoXpwbjUFFoopXOJz4?=
 =?us-ascii?Q?hOmykz2G4nQlm2KDMbVbtQj1B2Y2LX62tgFd9EVaCVEolbccb9MxJy2PK9GT?=
 =?us-ascii?Q?mIhfTMFbHq7Njb8Mb1itDIMY4cKFot7W4tcmDID1nopiiC7A3EXE9fM81YN6?=
 =?us-ascii?Q?aUzgNCxZE40Zq+Vy7WEPZ7Cwrtqlh06yuIdMl6ofKyBSs/8Ak+C92B2n4zo8?=
 =?us-ascii?Q?tAQ/spK2/4Po1aLyPEcLDUrKC9zbY4dnTJT2dQGbsSKa/HaWohrqYWPzNDj5?=
 =?us-ascii?Q?YalCFAjB/oyMbRumZOMgqFNWnZi1ydVrGwQT+HDcjrxJw7DkK/lbFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnXDzHetcT6bP9/XplWIpxQYdB0TUkOEIDJJIObsCSlCiZY/SJFIm6oxhLlK?=
 =?us-ascii?Q?orlkZHWWvo6RoBW8dXVa9U+th1vd9HyV48ALm/jvhpYxbLPbodCXvpRvw87L?=
 =?us-ascii?Q?zjXeE+gXPXlD6Vv0410y05XSHtb5QXt0Ww3MuG7D9fq1tV/zOj21E2y8cqGo?=
 =?us-ascii?Q?xbaNpLwOLQFnSW0CX65mNcP0HBU3oA7uMlKAVlZgOv8mqZUigHzf6BuHoq5n?=
 =?us-ascii?Q?bhUnh0XAWXaMxlCjDZ8vZUmMI7O1WjsUP003q0wAaXHjURAcdOwgQ8XgPxfM?=
 =?us-ascii?Q?P0FSsauzeUS6AXvZbf5m8g6l7oOQ/ibTLruQ5Ef3D7oblMcJ3GEQFKU/DpYd?=
 =?us-ascii?Q?0Nvj6RqJoSyzyavTuG0XXeKftxo9b+DNj4PVkATHCnWyl5kN5x+Dj0MtbYFR?=
 =?us-ascii?Q?rql8MHprmuugZEpQs1DTJUB7ubfB0a7NPeGkqMqi0cALkE0I6F9yQ4lP8xE6?=
 =?us-ascii?Q?/NSwCCnEORzQFZSpgqKNe+mOlKNtZ1KrKwWzHeYCrPN2LC09CnLK62Tlu4jf?=
 =?us-ascii?Q?SdNG/lkWmttTnRZ21feEoDRh7QWLxElXy2vK7ko0p969ODZQYuB6MAZXbL5A?=
 =?us-ascii?Q?uuRLzy5U3T1okyOS8C5q6CPFuJEDQdBx74s/TdZDdo3SyodXn6Fh/LUY2EF/?=
 =?us-ascii?Q?BMxazHuYRR8Y66mkW7c25pB5IT6aUxatptuOIfBPgHe18RsSn4jUHZ3e7A0B?=
 =?us-ascii?Q?T+38Dc8KTqAU9FgdaRJlqtZtiNj2IVy0s/Idkto8RlYEa7Esmhs0HfiN56XR?=
 =?us-ascii?Q?8Ylv1QSnaFuxMFzOE0aAQ41KfY/LCdw7L3SJCNvajI20yWKeCriVVlXxZ+YC?=
 =?us-ascii?Q?kirVqe7DbQhqubqfuqiHF1DREMOda1c7BuEmz6mGKRWarWJGVG2aJsI7V4HB?=
 =?us-ascii?Q?tGYNC8fWtxIOUAbQlVngiHh/WMr/pWhtbg8dkcsFe1MiPkPH9eIfiJO39sJR?=
 =?us-ascii?Q?QOacKf78WEjNMenV+lxNnoxsEuybUz2Qd6F1ZgXbqvS8dAxPxqFrNtiY4CNA?=
 =?us-ascii?Q?YOhqwZSjSto3cm58eJ/xPPXL1dlLsIQR6J6atWrnZvftJK4uvyLORQN/nPyD?=
 =?us-ascii?Q?HIV7T2VjjbxTg0Rn4dxgHM3KwkXKYvyOe95cST+PzMU+wan5yUpz8xJLfdwJ?=
 =?us-ascii?Q?heheZFieYVkXBjQB+BVcbRxAOEXX5NypAQZriMPCKkes7S/gRCh8PiHjlRA1?=
 =?us-ascii?Q?LGrkJPzW/DolaORcNnry53o3NWaYKbginnXz0/x66t60obY8/rt/+1iml/1d?=
 =?us-ascii?Q?0gbRacniIFiRTf+mHvn8a/MQfIQG1DvRx+69Y70rh0RtNW0bAsUjlB0iQY2b?=
 =?us-ascii?Q?5UPS3FPMMHM3rI5sIBABc9elkw/VtE4QCHT750dijq0ZBR/ST0XRi/PzRUs+?=
 =?us-ascii?Q?ymmyaxGFYXvi1XU8PMsVPxLU9HkjF1WpXPb+pXD6jJz/cMVW+cDLnzuSeYbg?=
 =?us-ascii?Q?Fd08XlLVeT24pPX1NXeqWGZcNB2edpmCG+LAENIZ6I/w77oYS16JM2NCN25n?=
 =?us-ascii?Q?aE5FTE3qWZF1hXIbP2UBVOyv4UDIXd/Sv6ANzi0PU21Lo3wWplqe3MTHijKM?=
 =?us-ascii?Q?HIP6+p/ozI7kSwsHss/hjt+vGbyayMop7OATyG8+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e879e2e-c5c8-4a61-770c-08ddd1054410
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:11:10.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CZtg/NwnZTLUctDnfC+RnqE/Lo36YozU8NaDqWIKBkn7MxTyhPEfGikyHgPZc0TLbmF+0NDV50a+NM4q2eI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686

On Fri, Aug 01, 2025 at 04:11:18PM +0800, Jacky Bai wrote:
> On i.MX93, the temp read from tmu may jump wrongly(ERR052243), and invalid
> temp will be read out. To workaround such issue, we need to use the
> raising/falling edge threshold to filter out the wrong temp. When reading
> the temp, need to check the TIDR register to make sure no jump happens.
>
> Please refer to NXP errata ERR052243 for more details.

Add download link here.

>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index fd4d162fc188..664cd5f7d8af 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -46,6 +46,13 @@
>  #define REGS_TIER	0x020	/* Interrupt Enable Register */
>  #define TIER_DISABLE	0x0
>
> +#define REGS_TIDR	0x24
> +#define TMRTRCTR	0x70
> +#define TMRTRCTR_EN	BIT(31)
> +#define TMRTRCTR_TEMP(x)	((x) & 0xFF)

use GET_FIELD()

> +#define TMFTRCTR	0x74
> +#define TMFTRCTR_EN	BIT(31)
> +#define TMFTRCTR_TEMP(x)	((x) & 0xFF)
>
>  #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
>  #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
> @@ -93,7 +100,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
>  	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
>  	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
> -	u32 val;
> +	u32 val, tidr;
>  	/*
>  	 * REGS_TRITSR(id) has the following layout:
>  	 *
> @@ -118,6 +125,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  	if (!(val & TMR_ME))
>  		return -EAGAIN;
>
> +	/* ERR052243: If there raising or falling edge happens, try later */
> +	if (qdata->ver == TMU_VER93) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & GENMASK(25, 24)) {
> +			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	if (regmap_read_poll_timeout(qdata->regmap,
>  				     REGS_TRITSR(qsensor->id),
>  				     val,
> @@ -126,6 +142,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
>  				     10 * USEC_PER_MSEC))
>  		return -ENODATA;
>
> +	/*ERR052243: If there raising or falling edge happens, try later */
> +	if (qdata->ver == TMU_VER93) {
> +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> +		if (tidr & GENMASK(25, 24)) {
> +			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	if (qdata->ver == TMU_VER1) {
>  		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
>  	} else {
> @@ -232,12 +257,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
>
>  	/* Set update_interval */
> -
>  	if (data->ver == TMU_VER1) {
>  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
>  	} else if (data->ver == TMU_VER93) {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
> +		/* ERR052243: Set the raising & falling edge monitor */
> +		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN | TMRTRCTR_TEMP(0x7));
> +		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN | TMFTRCTR_TEMP(0x7));
>  	} else {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
>  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> --
> 2.34.1
>

