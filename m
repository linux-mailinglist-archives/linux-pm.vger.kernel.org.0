Return-Path: <linux-pm+bounces-39021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E3BC9968A
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 23:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C1F3A400B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D4B2874FF;
	Mon,  1 Dec 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q9H+ZO43"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8E5286897;
	Mon,  1 Dec 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628976; cv=fail; b=ol9JQTUDF4l0BtTYiIGgkC3mAtiWdo7qIZUzj8u+PZb/+nQLHLehVGcNNj79JDM95nOcUpxn0fUqiPe/xusYEgpU5RP93Zj5FxQL8+p1GPyeC3yFXkHJjWlxFfaLo0yBdW8VTjEGsoTOHpDBknbfNw9dn75KzSOIABTj1Bkl+/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628976; c=relaxed/simple;
	bh=YN5dG27ahcNct6mA26/pET9Xq5d5KbQgIEuCQJK8cTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwhvJXNdcZM57lrLNAXqMBElSrPcZt6pwrLaA9/LdJt7XsHMKCatQSfNW0dyrviSq0ukyTYTOJmLoZH71kSXfNb9Xdo3iu1c8I2A2HJq6mpOQ96Vlu5DFkzSjmTJvHJpiPrvrdj+T8TVc+F7eRMNgYn0z0ZOaixwsyVO8wgJHvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q9H+ZO43; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZKVnJTxVEsxWGeRDX8nB1lOLP4F2+Wgj/0KLZIxNZvKkVfhbDC1MlmhTUcxsesQp7t4xge4iBMtvqBAt8YrMoQLqNyORaNJwdvk4VimEAnXPDVqAJWF/673uRWA02RXbimKAJmuYwzjMnVrVeugoouMnFbwJzdhZkkAIj8jGPYIvz96+CVITa4zXrSzHaEVTC1rTCinljO1JgHza/SLhxrEa7QTvIeuBdmm3JipCysm6rUje/jAHhQ9SqnJA4Tp1NOzmYj/zuGgmzrKkB96ZU6VygaRuskTurBzJ05mpKAvTKfNcr2TYOAo+q8MN22l3a4GMer6VqHHDyB+8gFXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb4+dHtitH96NjX7oimOEAFcsGMWToVA5wHhe362fVA=;
 b=zO07Dsxp18Bi3N0xiDZ9I2i3WlnoQAdtQxRnIEhySUwt5Y887qQ9ZDoKDTrYN/cTNObiNGX7rZCi5U9zL1lKpBh/9NltJnoipeLCqufffN1sepmbUHOD6fa9XfT4Yd64ok97j0FL4xGxjj4z2+BF2hEbFVkQo+TfkKSDuKANBOrnB1C7UYLMOFYyy0Drahmdb/W8VOq20yJD7h+B1taHRItRGjr48BGxMQvsor2r9ElbJkTViStAgkWugzkD/nA0VHHJe4TQsEb41HZ1jgzOzVvSl63Iv+CUqs2PiIagNn35gdLNkq6ROxmDay3SxSw+xdajWVBPmK81RAUvXnG1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb4+dHtitH96NjX7oimOEAFcsGMWToVA5wHhe362fVA=;
 b=Q9H+ZO43b4V0+zu53SCAXRrRw+sq8eQfkcGEa7naYtSMqAkFz+PrEsM+WRROjTqni70ig/yDW2dEYABWvyNa4HhduWKGJqZtuVlxn/PWkYVGpmlLrer2OT5iWh1S+ITKByACjD/Y8bUqv1zWPZGkvRJrHHly9W9ShUk3AcV9XSBldI3Y5I5aLBNGVUvojKeI5m0U9IzBAvBgoIV+ThGTAzewfRX+lGYwRAvIwrgl5KUNeOyTfQCjrWDvwxfnTe0uT1DxonyG4slsvY7LJRd92PLg10TPNbR/K3upmnk+iyK74jm0eznOS6UV0iBT/wcAy5IwAlApdBjZOAQs0Kj+jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB10693.eurprd04.prod.outlook.com (2603:10a6:10:588::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:42:51 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:42:51 +0000
Date: Mon, 1 Dec 2025 17:42:45 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pmdomain: imx93-blk-ctrl: add support for optional
 subnodes
Message-ID: <aS4Z5QS9VBU6ObVF@lizhi-Precision-Tower-5810>
References: <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
 <20251201-v6-18-topic-imx93-blkctrl-v1-3-b57a72e60105@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-v6-18-topic-imx93-blkctrl-v1-3-b57a72e60105@pengutronix.de>
X-ClientProxiedBy: SA0PR11CA0074.namprd11.prod.outlook.com
 (2603:10b6:806:d2::19) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB10693:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e30c17-48e8-4763-74ed-08de312af5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nKq4SBEQ52C23n+K08ulj772vWCfa/bB+2+x98uwJYZHnXiVJMJgyYRFKQbo?=
 =?us-ascii?Q?S7CLiJmreeoJoNR0pQb6vEUqrzP/1rMeUV4D6GoeOxS9T2Bu3Jq/LY55hLwH?=
 =?us-ascii?Q?XmFK7TizlH0vUVNuAmCweeEwKzwigTV8B7Fox/J36uZXPPktnHMuAGwVc8OJ?=
 =?us-ascii?Q?JimMv3m3D2ataqsHjwCXRJWOC2T/JvAIfg+iZh/hwrx11ylNakLJtExMyI2r?=
 =?us-ascii?Q?PrVbt68QFFkPO+LfA4RZxO/CdLFS0E1fj7Ggxvl0m2NqGgn7iy6CuBXzINee?=
 =?us-ascii?Q?8CaO2WY7jz3sm0dp2dxwk7Qgi1BT+OBqLkmfq4bwXsKJQYrkO2tRM9XuGwqO?=
 =?us-ascii?Q?V7atWRo10LtTw/+uTpzfFIid79ZLdkZNg/rovD1MWYoDJXiSyEOjtRjYo7Z3?=
 =?us-ascii?Q?FtHcHj9+EkNzYXYCWFZDvDArTZsO4lVwLAvl9AZPuNzC1kBnaNWSZiuqiVQf?=
 =?us-ascii?Q?oa782WKB4y/lSI7wFP7CRuWom1GV15yGdQValdxnHDaOtGqGtx6CNaT2zw2e?=
 =?us-ascii?Q?fwqJrQuizCqRiRRkxJwMZ3FkIT2oTn8sKH3xX1o/HiFAxwwVwf5fOmUB620D?=
 =?us-ascii?Q?n0Iw7FzNXaunmzM6yPCU+h7Om+f7G9g7VayKlBwg/fNBT5O5s5cvlNpoaRqw?=
 =?us-ascii?Q?9rqpjhasu2FLfZ2M3nRpc8HxtoJysNx7LJoT7j0m+ag7KKgNc0AJbrELW50U?=
 =?us-ascii?Q?KcrbxOiFBUBdw3QC04Ni5f/9O32yuOJy1BUPgTDAFsu9xUSuRXDDNfTsuT2M?=
 =?us-ascii?Q?9hX0Fdz69VuCgWHnF12XMZ/3tYTd2bj0MLwpwpgcH5jWHH70cRJkrfvU7hQF?=
 =?us-ascii?Q?FbKemqIofDEpkK6D630/r70CsQSlhh4Mdvpv1kLxIVRplZUvqYd7Eam0+rI1?=
 =?us-ascii?Q?RtEL+nDiBK94PnHt1Ksyrq+nJsOW3xIxbEGfxuEUOeXeO+/QnPtqbeMDXvlz?=
 =?us-ascii?Q?5EG7OS4yFACdbkH3p/uUqw8TpVyCREfrV0FpXcUYo16KBCYfJBbd4KNA3vBf?=
 =?us-ascii?Q?OSm+E0iGLOGQyXfI5kLc8IwoND2bQD92tZJOqkEjAnmZx9mrjszP0xvc5vvd?=
 =?us-ascii?Q?BVEHoke80V/El8g0KVzOr8JGnATd+9Aq8eEXuTfdeoQUd6Lmv1PqOnxfHb16?=
 =?us-ascii?Q?UsBcnPRPoPP5ukyEC0NbUENZGdwWmGOkmsSrRm33cTwpHx88qHxxik6Qi7pa?=
 =?us-ascii?Q?6qgQN+E3qZqKgAWHKPOtOod+MNFuBNxZ5zVRjgI48pXujh7moIAYQodWUcoO?=
 =?us-ascii?Q?qONVHFlZcEzfOaiZjof/0vQXamda44NTl+x1GOipcg5Ktwgstq7CJ1OdGHyZ?=
 =?us-ascii?Q?sVnpqNRTkQ0qafRcXZK8gtW9N4NpkLxv3w8NyIGFlWhnr1winxFFTy7RFDR3?=
 =?us-ascii?Q?y/1iFMAK4dc8ilNE7DiJvuHfzKEi6rl4OcUeFR21DiZi7OyAOONcLpgFgVaK?=
 =?us-ascii?Q?hoNflU6MXb4PQp1JfbV/8lghxPoQso7oDNyNtFxT8ONynk2YzbQ7xP3RoW1f?=
 =?us-ascii?Q?m2ynDml7200OVRI+j5U5Tq6JhJP59Uqo/tkH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8NQcSfAyHriuG7JtXssenRfyjhoa4+sKgOpmHz66uBu3hKpQYnxYsu5bwR0J?=
 =?us-ascii?Q?A3YPpLmkVFDnEhf1FrgRYYjxOjhqVvG6itV9sccjMnQS8kZTjKdB43jDcRmD?=
 =?us-ascii?Q?Zbbax/fkAnwV2cQyuN1nmET9Y+dHjG6KjrgOxkdi90vUf+CR0bNPA5+iUsDA?=
 =?us-ascii?Q?zyyk3yYjAqQje8PJBQ5kGLb0q11zNR71xGI0hrON76+ApNRZOE5pC76h9Kv4?=
 =?us-ascii?Q?8vZornYQarZ3oO8o9+KSFYDEzKctk1STRQnsTm2UERw2Dk2e1DIfZum/bdPh?=
 =?us-ascii?Q?xdYTPW0g+AEZeiJWK0L9KDUlYwacoLOB+WhvC1ezqbZgqbEzGmb7T+ft0J5f?=
 =?us-ascii?Q?yfbO2ExcjG7LZOCfhnnPPtBJ/5FbU06p8wIPxQ8okJo9IdCG3Zi08AzBfUly?=
 =?us-ascii?Q?xZcsK6032Yb8lF4eP4e/HDCJ7vnu7WBEG0oeJBMgkB+O6XIX0ACx3H+iFAUl?=
 =?us-ascii?Q?xff70NRRiUXIidGB5pSw65k1JIk+Ax2yGFSW0tMZz/maY3JMIxTkSKsA7JC5?=
 =?us-ascii?Q?xdxckG7JiU3XZRGTQI2SEr7rJZOcHZcAYEK1GdnhnmLH190rR+lqw4rstGv1?=
 =?us-ascii?Q?3XAlq6IXwSIzJW7rvmay8qtil34RzxiQzup08gf8Xfijc4IpPLDjBARj6+8N?=
 =?us-ascii?Q?TIoQZA7AiZcIcm5q7uVUyD5Y1nD96s8vBhL+Od5nCfGGp/kfnJxpgVlNXTTO?=
 =?us-ascii?Q?NchjzIkXrq7UOdCvE+0eTOBc0hbVLm4M+Cfc1dvA9zgFZAgTZXkbtCk8fjZ0?=
 =?us-ascii?Q?PLoyOw9DGbp0PuWdGg84XiXqhjIxTb8koYA7/ndEh94zO239hAuIJpIa7gFB?=
 =?us-ascii?Q?kbhqJC+G44OY5PXSD/b3gqByTQ7vIgQl6njrfwGqmnbNjg+6cqKOsXaJwjHh?=
 =?us-ascii?Q?CXD9OLXtEnkBS9Lbhr8O5K5oKFE7wva9qvm53RLGAtGFh57n2HWyA4t6NMUA?=
 =?us-ascii?Q?WLpG6W9aAIeNpoOIS0jZtW2qr5i4/CCDDYG1DzVZO562qTUPk+2f0I0Twipc?=
 =?us-ascii?Q?Nz4SwGBTQTKxkhX1liz/SxcTSa4suYMUeUKmm4KEQibX0IJsJwgiBbtQU5u2?=
 =?us-ascii?Q?W5Ws27OEllYyafob+tQM4BTNHoY7rr8IO+ZdOLolXw9qMQgpf45TBugBCgvu?=
 =?us-ascii?Q?j49NNEKqiYPDE89tG/UJTVtlm5Q4m3CdJ7M/ivQd27Pd0JR8d75786xEOT/i?=
 =?us-ascii?Q?nOlboBwoeuR3V76OBVy4kORT2ncqbH6iAw0N3GNmDHiZBcPlntR4NfVu+YYd?=
 =?us-ascii?Q?0LCF/5VTha/KC7wUsTksHCjG853ctY4LT/WaGnsa7QLvE1ggPRf7F7U2Zztl?=
 =?us-ascii?Q?4JFRERDs0Z2lOUAhYjQvZPwt5r94JNzGaUqqJ+QU4GHJa4pVHwBn/fc4Ofqb?=
 =?us-ascii?Q?xyttQqq08V1h+AWjz+3E3gnlenusWJayc0p/eCn6L7Ov8owClSoPrWGmY7mk?=
 =?us-ascii?Q?xrdEXc16su06IqX+4initptVf42QsF27mJAGpeRPVQe7HedmRKLKigjcwG2Q?=
 =?us-ascii?Q?KjVtzIal3q7uxty8bKRN4TXby4b1bn6veLTimRdI1RaFyhM9AJsl4RRc6C58?=
 =?us-ascii?Q?jSO4zKqjGso3LsFwhlk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e30c17-48e8-4763-74ed-08de312af5b9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:42:51.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PlXCK8gN+kASxGrt2Prjhfi7IqvGvgq0o785zbiLxTdizWwFg5S7IOWtn89YWq162G7FsFZfMrQfGRGmW7m8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10693

On Mon, Dec 01, 2025 at 06:12:07PM +0100, Marco Felsch wrote:
> This particular block can have DT subnodes describing the LVDS LDB, MIPI
> DSI and parallel DPI bridge.
>
> Scan for possible sub-devices within the driver, instead of misusing the
> simple-bus to perform the scan.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 13b0de6dd689cf944e034f7666a4e97b0118e3bd..8f79cabe07face872cb396bfb7329c230c4a97fe 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -7,6 +7,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -311,6 +312,10 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to add genpd_provider release callback\n");
>
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to populate blk-ctrl sub-devices\n");
> +
>  	return 0;
>  }
>
>
> --
> 2.47.3
>

