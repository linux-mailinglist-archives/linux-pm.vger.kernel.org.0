Return-Path: <linux-pm+bounces-39417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C69CB3513
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED73F3115551
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166292FFFB2;
	Wed, 10 Dec 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="chyatg21"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6826738D;
	Wed, 10 Dec 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380271; cv=fail; b=VBFrw37kEZrk0QFdrLCNR6wGqEsZ2djkkhRBqpXjnTl3lz3RZWkG+h5i96H4i7LP7XPmo+8H57vPx0n44sp5mP8iTkXt/6U6nNZFiHrTjqS5lJ9Xw9WrEisFblBmkIbvmfSkSXAmZe/k7izEFU3AQeJ+tNcpfmgx3t+TkGzjVNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380271; c=relaxed/simple;
	bh=zo4cMQP/d19fK6JkYw3reQzjNpZ0MK81EOisRF8DnkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ps6TH18OUtX2daxvGEhf6MzRLvvEFG9YgNl61i3WuygRyLfg/5c8FaCZoltE78XhI6EfAB0ISwbvU55eTvoK5SZHM7cUN4WNwp4ClIe34puUzXJVfpZsm99d974I4PzFhkD+mOeazPvreaAUXISt4CR9Qvvpk65apyP1V4fl7iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=chyatg21; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGmUP27h8KgBh5BmC9lrE+yGJuU6n/4Hc9TmjIP1QbqKaOvDvW7XyY+j4cf2xMcpd8XZ9lOjcmvR/4Nscs/5P9j0CoXe0kYMk6q6YsBC7IXldzAA5JQX0q/ArYThH1mNjASYnzQ8dtQddQmLxCp7qP8/jdpiXGNreRxf/hjRzxNtTBRWPMZKK/G4dSGY19QdYX2jO7alYLKqC4Y0EdNrVEKez81pAzdgIdPXq8Hq/FkwD/9MkrH9a2DpkT9W204h/Hisyv+ZPsBSLIYknNojWp67+Bn0lM8rvWxxlzJmXwo3fbAS57mO24S8TQItPT7ri22e9ME8pCEqgDiBCHZ3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UQvzWk765SAQZvXHAtTHMHgTYskLRLxG2/Nb8QoU9g=;
 b=cNVVF3CpU3CuUXcpNs76NBAXeCjHqyHu0GioD9RVAs+ZVMHMgllOIn1PPP7we+lG6K3qN8EOSjI0bxTObptkarS/DDtrC1YghVs9Rh4uM7gkddqsjywxtK4qfyLxUPEZ6ClYBJBxwHZ9JSw3RgiJpIuifeB/ydXuoAs2+krjhW+HDk19qpITUGSixLK2ey/VPO4K6clAufAT0amzY5yJ7qG82ttTQ2JTUB7Ks1tYFBa01m91EcubfZt2GHKUAHaVOYODunp7SZuOaQXhibka1LcqIdUlu890cz9lYIAY6LTEtAN7KL48awBX1yfwIktHY30pUvjV1wssZbEUt2l4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UQvzWk765SAQZvXHAtTHMHgTYskLRLxG2/Nb8QoU9g=;
 b=chyatg21IakaCe9fyOrB1EhEwEOosbW2mQYI0QC2mvvw0/ytvwVexgwWnCOqyE93gK1F/56UMGmwc/zyV7MgfYgN36O9IN4h1O0n2g7V5TjoLBj2taZTHjU/DhNDzt8SPTjKhPGjwEUe8bDNB3ZyAsRYhYqgdvWvuPGI0ahiEHbqrkKrgVOuwIMR2HYEpCKx1hEjc8rIJUW+9rION2o4tZWVAYzmDIZCX1KbtzhpQTEtvxFKF2zns6SVrESMevWcl6QwmpMZfnpmOVgA4tn6JVA3NXcF0EjllyRxFYh0nRRt4OOtxeBLNEZDCioJ+Lll3yCLp46J8JmXysMWugcVxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM0PR04MB11931.eurprd04.prod.outlook.com (2603:10a6:20b:6fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 15:24:26 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 15:24:26 +0000
Date: Wed, 10 Dec 2025 10:24:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] pmdomain: imx: Fix reference count leak in
 imx_gpc_probe()
Message-ID: <aTmQo6L96/PcpVq0@lizhi-Precision-Tower-5810>
References: <20251210033524.34600-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210033524.34600-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: PH8PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:510:23c::14) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM0PR04MB11931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5413c80e-e5f0-4fdb-f055-08de3800341f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LxYdAwoGlXYr1vPPDaOc7q3CNHLY9GtlUgneYJ0h1FQqerRFtcKzIPzD8qBV?=
 =?us-ascii?Q?VXnXheh9VMCIETBaFzB5ugB/i/+0LHGXTuvxVbwaKtL+8s9unqH4ZTBKu24s?=
 =?us-ascii?Q?fF9E/fKhmMUNhSHvqSph/KvlhtJfxBf24iQ/xcJwS6jxTKW0njjxEedvyiyY?=
 =?us-ascii?Q?syq9CkcvA1yGWqYZabjGpoLKCqoOQtbWBGRQs9xSb2yTKUICoyTnsQ9pZcL0?=
 =?us-ascii?Q?5gPoA05l4lCTtEQuVbnUWylUkwVmkfogMBFa8yedhwQrG5NERSMpBVAtjqGf?=
 =?us-ascii?Q?AmZ3bbDnsNVkFRG7WsPCwHrsGhR3ZBEFEQRY4NIt2G39L7WsDcB2612Fwaum?=
 =?us-ascii?Q?Ae7M6+QKlzTIX2JVnKMb3lsGKdwQoED/ERD2Omo5A0SrAgU4dlBRGrFZgl2M?=
 =?us-ascii?Q?RC8BWngxsvXV1wZHqq5Y77DNne6a8RpzSLXKaUt8Rr9obyKmqSM5lJ0z/2CP?=
 =?us-ascii?Q?hEXgwRqr3gVrQ3BwhyGgKS9/3jAiiqJgZS5hWZJwghVIntv5g0JMYYoC8lq3?=
 =?us-ascii?Q?5r7yIC04arets76rTiE1T9gy1eNtdiJawmSQ68utktrSq/01y3DHQlls9TTT?=
 =?us-ascii?Q?YiGvWpDB37Owwtm6F4HPqPs1mAo3lfxZD4cHL+HIaiyLhkxQzEM6IAcaslBK?=
 =?us-ascii?Q?GvF3QnW5yb53fR9QlNg/F2MoanG/5V7UD3UvIdsO3drgZ+/rsZ16L2JG9I06?=
 =?us-ascii?Q?tpPX2C0V6HOZtMRY/9dvKvXS+Z+qNIrLCWWjSxjVrptyBzwskxGV65ngiQ6z?=
 =?us-ascii?Q?PgVWK8IkEK2v9SQpzq7clevgOXlJvjqH+L8uG7ReBlPN4cdiC3ioM9Vm5oO9?=
 =?us-ascii?Q?v+xyKam3Lr0PmztCBNIcRPFQpgLuUVTxbwASydQaA2azIJRcnGwlXCkfXEKp?=
 =?us-ascii?Q?JV9pxF7eS0dLJGUltoCPaiSyhVFiVgaHjwxAuvfNZoaVerYFgXwEBEW8Fg5X?=
 =?us-ascii?Q?eo5drxebrHDeCijVDxJi4Z4okZHu/QOvpOp6S4K4MI3nekEPc3ONE5nlJN3Q?=
 =?us-ascii?Q?qHyFNqyg5VvpGtl9ILEGyrxoAjMoAbr99G0jy6WgCQxOtI6SOLx18j7vkqk7?=
 =?us-ascii?Q?oHrIRdlEnipGVI5MbP55r5I9eljf8NqD/LdhuWAxex+ljuU+K5E1Y90TDLMa?=
 =?us-ascii?Q?KFZIkSn97PcYXQ6QWSfmjP1h5aznZkwWgMFwVuvsiNb2GQtrs3T+vIsFEr+G?=
 =?us-ascii?Q?PqBTIxEiS/LGP7TO8ohOtO6hzeXgnbrzcLo5IfuzUMiwOMu4vxYefQhquVVB?=
 =?us-ascii?Q?Vj/Xpi7XVhLmV+SeCCFfIHTOwk5uFL4+yIcItUXM0/xbTtKorvbXCz4HNWjF?=
 =?us-ascii?Q?zfw+DC5swZ9nsS4dV8IUFYZBcrF3gLbqc5ALbn3ExOa/xTZH6+Gndyq8JWgy?=
 =?us-ascii?Q?4tH3IN2HvIdTlUzUEY6Dvt8g9eD1AWOcH8ur4n7KfT7SMlOkE5xFO2a9z3jt?=
 =?us-ascii?Q?mVOF3WpyUmT7YnM80SeE71z4t4RfDo+3CTvWWTB/yf0/leuOblQGnvYHvTo6?=
 =?us-ascii?Q?W51WrvtkfOR6yptacEeqCHtRIvHdlOFflaki?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fK1yasb0Ys8Seom0nJIO9Ar5UrfOpDvfpo9W7w/TrBTuHib7GJUKsRklUzg?=
 =?us-ascii?Q?jMFnWJJUT7ltXLOzAxr/zXtKHxqlrPElerOH3rZXF901NSQBdXSMEM6q2tJc?=
 =?us-ascii?Q?447MNubseWyLmuxaEADjxvlpyvoTa9ZUWFsQR90q1tIn5q4p4uTlxebxfhTn?=
 =?us-ascii?Q?BIP7CO8SMDcOa5B5MOnZBPjFWyydWsOENnVNWANrEYEu6LRIf86A034Atq+z?=
 =?us-ascii?Q?wCAvU37q9jjLXHSmpe/1C4xHJ4yzXhJuLvom45l8gSwQSXxdWB2SAazRg5ku?=
 =?us-ascii?Q?2VpPa2E3G4KpXo2+s8E93JQqggXNBCjPnfKBw/ZQmAZ/w6JClObGSzc7jgsF?=
 =?us-ascii?Q?B3wfh2kMYPEdgYpfYE7PzeWd0HUtL81c5lMZ7x8si8c84q/2is3pM5IlCA59?=
 =?us-ascii?Q?StgqjyjfamnZ9K/KIFJMi8t4DSeRg6ZXXmnkwberLnBoKbF0rrmKwvjvITXD?=
 =?us-ascii?Q?QNK8SyQY1yXWIo14UxBQL5yxOTJcw25Pg8TmvYu6AKpmXWREjMW63KALsNFg?=
 =?us-ascii?Q?pgLNTy8Dxcr9vyyO71l11Ikw47OVqHF2pg31c+Xvi/YmkMzggg2YizjxONk1?=
 =?us-ascii?Q?EDXGMBjGcc0rvVWHvNPMsFbJkclWbzfbgUTu9vQ+cEQquNxiUlUDzekWIrmx?=
 =?us-ascii?Q?O7mgJpk/Ib7dVugv11KGSDiJ+PpUsjwmDcH7/rDot/iyFOXsutWFlJLuX6bj?=
 =?us-ascii?Q?A7yIO//5fKrMeZAtvrdyqDQ/QLHkGnI8X9aDWMiHYYSoOhR6+wMu/BHCXmK4?=
 =?us-ascii?Q?Rl8T0ZJB7YW8BCVQq/9U6XlMSjskSDk6L7jkiJFWVXcXrpBL/gos0r8/nowU?=
 =?us-ascii?Q?zGSqKYw5bKmNhyU2mkbBQ7wdGOjquRZ4unJBCWSnEDQcUl49fG4Qphl/T3oq?=
 =?us-ascii?Q?+JZyWDiMNh3przVKVRDilAa30SeQakl5hPMbzGQE5o3SGrkO9UJ0U+gSqaEA?=
 =?us-ascii?Q?pDGkKlk9VsdINJGX4N5VfiRdjIIvWjS4C7hXEiaaMzRKjTSm9y0t64Ega1aG?=
 =?us-ascii?Q?r25x4fsqxh+hzgIbi7fzozIufZHdoJQnBzuWgwcMKk0DAnVUhpWj1llBYtx6?=
 =?us-ascii?Q?Sgkvjn4yPEDHWsjFBraVIBNrcQT+OygCEYbLCPuXlC0AM3lQU7KghEMgkiMn?=
 =?us-ascii?Q?Db273CdMG51FccpcuM3Q5KWCUOYnjaeeR8i7UrGaIbxXiper6jEpZysU++eT?=
 =?us-ascii?Q?EEJMkDTNf1q2X2S85s/meWcEknsOQu9DJ1ojrlS8XDQCqCRpcafLHE7rbtjI?=
 =?us-ascii?Q?sgEkaupngIPdC8/8dVnwDil3rCbHgTg0X13VhWLOrtUEIMphO6Mt246q5LHQ?=
 =?us-ascii?Q?LQVR+X++GAYHGj6YhxOL7rgT0SO/Nc1tqEZn+J0Jd41OfWyRRfPo7ccIUXpL?=
 =?us-ascii?Q?M9j+OhtBs99gwhdVDTmoUY+at/Z3cq3jhfYLQTOJWxc0n7/fSsNCGOJrgsIC?=
 =?us-ascii?Q?JSExrg4F0POYCJMC7Z2/W0Tq0+SPWdeHt+N9kCAWs6k6dPkAfNl7bSrLwLq8?=
 =?us-ascii?Q?NHt+zdye5WW4UvpB436YXuMBhCS+YfTQ0uafYdIaDg5xFppLJz6TKzcIsyZJ?=
 =?us-ascii?Q?wcPLr87Azb0F64wXrQl5l5tbQLtQkwMbhYxFKSTj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5413c80e-e5f0-4fdb-f055-08de3800341f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:24:26.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/fA8wVz+Jjw1R2y8bYlqb8Z2FmiA7OC74Kg/GUR/Tip0ePVyCDYVdwiqLGcfdnZ7PeI1e2H0H1OfBlHvGtUaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11931

On Wed, Dec 10, 2025 at 03:35:24AM +0000, Wentao Liang wrote:
> of_get_child_by_name() returns a node pointer with refcount incremented.
> Use the __free() attribute to manage the pgc_node reference, ensuring
> automatic of_node_put() cleanup when pgc_node goes out of scope.
>
> This eliminates the need for explicit error handling paths and avoids
> reference count leaks.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>
> ---
> Change in V3:
> - Ensure variable is assigned when using cleanup attribute
>
> Change in V2:
> - Use __free() attribute instead of explicit of_node_put() calls
> ---
>  drivers/pmdomain/imx/gpc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index f18c7e6e75dd..0fb3250dbf5f 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -403,13 +403,12 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
>  static int imx_gpc_probe(struct platform_device *pdev)
>  {
>  	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
> -	struct device_node *pgc_node;
> +	struct device_node *pgc_node __free(pgc_node)
> +		= of_get_child_by_name(pdev->dev.of_node, "pgc");

Does it pass build? Sorry I have typo at previous comments.

struct device_node *pgc_node __free(device_node) = of_get_child_by_name(pdev->dev.of_node, "pgc");
                                    ^^^^^^^^^^^

Frank


>  	struct regmap *regmap;
>  	void __iomem *base;
>  	int ret;
>
> -	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> -
>  	/* bail out if DT too old and doesn't provide the necessary info */
>  	if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
>  	    !pgc_node)
> --
> 2.34.1
>

