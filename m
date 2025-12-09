Return-Path: <linux-pm+bounces-39364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58522CB084D
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEDA3300C0F9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B03002BC;
	Tue,  9 Dec 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="knEDgeQu"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0F2EC55C;
	Tue,  9 Dec 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765296874; cv=fail; b=t/YcJSajytLa6uwCXK8jFpqVhvkfocDKN+Lsb6YI3nTaFr9q6x/X883ay9VSWaSvcavcrQjvqoa3MfyNJP7GFu98vx60YeMV684Z2ih71hVC3MRjjEQfPfkUsd0vGI4YWP0MbDBZRD2Ca9DEuMxgj9wVs6UDBgs+fSg3P8Ywa4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765296874; c=relaxed/simple;
	bh=drYALEu9xqulKYkV2JDSk5ciHVwxVPNfV+IUPaB8+IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GEOwoZmgC7Xp0QbkpJn/DSbJFajZWhVlnVqKVI37pHES65aXxL6QFhfKaxtzQviHl/lpH8YCffWbkwHqs6e2uu1FrzXJok5EaxGMcsF0TBfXlQBBrNXsrMWKbH/Bi1pos4UeuAFr035JgSLPxbnUjYHQnYj+uyMdYfcYRBatrmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=knEDgeQu; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljqvSw29deZbTCH3wrm4rZ/BVOpjCcGYD5H8xATR0XUG6e54Q7v8IIZx/zp4rFN+iuDDvx7cmMqSL4aW2+AKyRRJnCjYZQ+Px3tz57CH53tvu844ABCCIIAVnQXnXQxt7qF4wCmY6/Y6a7E//PM58UNwjAevvY6dSq4Q2pNM5aS/qLrFA5U2+IlZiQaVSD44cuDUxYOwIQMf4yy/kSCv2PUnNfxcC/Iq64cvj8+BQ0f/w7bXi5slSqKQiMe2zb9T2rSpipF4RrIRRXj0kxZEjQ19OeBQ9ElZLsI1wHcsLTdhjZdIYeYdbL6D0FxLXOUedmJljd+r9ETFIYoBkLBrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AypGCGsmD2lV7ELFX0/5nOMQZHSv6FDU+K9J7m0D95s=;
 b=A7JTeUqZ2IIAg/hSIOcFhIsOF1kVH9rsRh2XwEosOXMEHvw7jjYotWQvhNwotgSgh/7DCTeEGKzlLX+oBuC0biK3YIzW5mSxXptl4ammnfVNMegdNbQBIEpYTgYAysQt6lKw2r3mjcvN1dm+/2/o09IaCJrWeEUxbhCCZkTOIy4Ej7AOW74IKF9i3UKyCCVGLtbLJQ7hC0cs4Ipn9+YeTb5bt5eqWqtl2dj7wqMSHjW+ZmO/SvdfKNv1dsHqhbK+4TPUmgG1yn2blC/0ARP4atSN0hGgJTD0pnA5/QmZ31pRVZ2lpRA0GRzuFYCT4heQKzfEg6Q7cjuXrKNHmqEkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AypGCGsmD2lV7ELFX0/5nOMQZHSv6FDU+K9J7m0D95s=;
 b=knEDgeQuvdC0V6VubAbKwcMdyg9RFp5cnW10+mLnx0UxZI8Cp0+NYAIbknRXSHlGr9lzLu25930RiwhvLk0nEKt6fqpQUJR4ZXpY4DBj3aXSvjAm/ck4qL5OGlh3WqLilyCYDRs+RmHBI3ULGxT9XhmJZGTt7JPtroY0L4pH6UmSd45LGqN/V6rWPobidYC3OzEyNqPmNgZeLwu6XRtkYJRx4cZSk0j5YpJO+Cdkiqn/tepe9lvtGVHdbsbpQoHuGRyhqr5WfFQnKGJzItkbUplIeAkT2Cc2npArTZqq2OcWaNuy6cwgvjakDediF/VKqkMapGxgfrwmR/BcIJeqYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 16:14:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 16:14:29 +0000
Date: Tue, 9 Dec 2025 11:14:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] pmdomain: imx: Fix reference count leak in
 imx_gpc_probe()
Message-ID: <aThK3DwGFY1xhvyN@lizhi-Precision-Tower-5810>
References: <20251209081909.24982-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209081909.24982-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e20252-6323-4fa7-0245-08de373e07a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtuCywk7LbpbCBWrP9jY6Fw3qSiUFc6uNs2EeEw7K/qlqwp1Th7sESXEhK+d?=
 =?us-ascii?Q?ZRtrGwRFFPJSISLd+EIHjwrEKuLdEEgLxgUM9ghIZl7hhEENF+EkPYESk2q4?=
 =?us-ascii?Q?3SARPjyFjpJf7ui8W0jkjcqCp3RIXdcMfC9Zh88g6ay1ZSzORYFt9BbVesKs?=
 =?us-ascii?Q?PI9kbOSaHW/aSV2Nw7U0BuIn3AblViWT0dFm81scFn/VvgeG2nN869w34C/b?=
 =?us-ascii?Q?sI+hl7JupxI9V7m9zSiLbqf+0GuYX9ZCF5gtUk7laUyrEXJoqezfD/81jdME?=
 =?us-ascii?Q?cn/cXd7MktKJo8I8Rq3ed3qggV1mEiF+r0mDbtbopl7qYiHG9+anpx4oZrOL?=
 =?us-ascii?Q?iPReyYnfqdnTcaP1IO5jAOskOcwWEqrjTF8PGULte4Ex2qWSebfv6s02Wh1h?=
 =?us-ascii?Q?vwfXbSl7Aig7c8BVDewqBg8maWEw87AU4XwqFi+PQsixW4PbvaqaGY/G468n?=
 =?us-ascii?Q?Y5tkYmUnd5RuhK7NHv7nLgOSszO9KhFn4bnqGDAKhCe9cNXSdJ38u70D2vkB?=
 =?us-ascii?Q?AuWFGWQBgN1qIPxUb4d6sJCvydtQMaUxJLDg137c5WkeKw1kQ/1Ctvc6ptFf?=
 =?us-ascii?Q?+nRZYpqUMaMH89DfxlEHaau1/WCbyatnnVPecwoqM5V3TymL52DNx2z4n+Qr?=
 =?us-ascii?Q?/zkYegAKdcrHUdvJ5ZSHymUbGF2w8ksyOrIN9m2qClKR50okeg47uOw9ONTV?=
 =?us-ascii?Q?IZzfUEmBCQ+9eat5iLgx0EaP8HGq3Oqtc1TTBbnCNU+5OrFPMr154KeFurH/?=
 =?us-ascii?Q?GROixPLsOoGcTVko6BKxpI6x5jbqDxRXU+xutp7TX8zbhYBHq0m51vPRuHrl?=
 =?us-ascii?Q?Tbe5FRq7IrktcbJw4RzLlB6xc6ifs1WUnoIyWeewaE2ayc6EDj3SDYduC8Dm?=
 =?us-ascii?Q?l4SPKnjybkPlPnlsquK3vVVpKBFMyviyHFYK9eL7i9LWL7wWHd1k4ERidWOv?=
 =?us-ascii?Q?Xqp1wL9Jq7/rQccQacbba3rk0k8qfjy2bCqG4bsZ5WxeaakO9RKb4AnlgwbS?=
 =?us-ascii?Q?YnKmRYbrOB/13tNZ52/TafDIjpRXylm4YXtPoLbYPiFqbAFB7599qmId1HXV?=
 =?us-ascii?Q?GqrN1Eb60Fe0aJuCiR98Cbw1Uk4GLrYbrdUF6T8MI5ygQ9ynGiupy53zPe0W?=
 =?us-ascii?Q?vSNbBW9DbQtbO/VqGfLN2AbYOnC7bnV90TqbrrCux53cVdXC5UBvkDnc5BU8?=
 =?us-ascii?Q?n3r4js5C0HlBly6uuvSo03eV8ywOVijMUTaCoCm/GjFRnpKi85CMN1/vYaDL?=
 =?us-ascii?Q?y6WARz4yTsx2mJxueKxXiuOwjNwOpzORft8QG9yK0CXShop8fa7DiRJXcJoo?=
 =?us-ascii?Q?GTs1Up3rULTEo+/ZjtC3xvY7sE42Y9SWrGcwouPLqTE9m3Baf2qK/EWTjUZK?=
 =?us-ascii?Q?qjoX91tdN/mjvJ/gQjswkxoS1YV0m+33HyyYga3IiyjhBDNmfcVmToWphACX?=
 =?us-ascii?Q?Y969iPyqdST/ZMZR7x1FJW5MZxsI1VkpYVKf1Vyt8+w8MJcQrTV96ZNUgSu+?=
 =?us-ascii?Q?tlGhz7KqPlIMBSHeNdsZ3KbidIeS/BbCDFh/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y9BsU2tY8kjFven1yhltsRrODbU3dYN3Yo+xx5itpy/tpYXYSMHPjHGFRM0t?=
 =?us-ascii?Q?mPZYmnNInJ77n6dug+aQeIr9ix6DM7si+hOWr8oORFLakbgM5o69cgoEbQW7?=
 =?us-ascii?Q?6/+uy6Oq4emhxMWjO/A1IlkGZdXf0xgMH2yZxZwYVVNk3BSNiABXwrYZT7Nm?=
 =?us-ascii?Q?/aaisM//lDVmntFSw3HgTj3ags0lPMi5YKZB28qj2Pr+zG3m0QUvEn9qIoz4?=
 =?us-ascii?Q?QUlwjuBSdYu3ww4pm0/olcPBtXWZtihrmnPkxkv1jvCYlyB13wly0qr/Pyu/?=
 =?us-ascii?Q?4qSPqX8d0+lkmpWLY9XYpWld34Olw3t68A/U09fyoGoebGqW3ybqEcTn17x/?=
 =?us-ascii?Q?TcMP/mrr6J5W4LHod33PdqTr6oJzSo4Ncs9SXEVPltvbUGBGELlWhiB9HzAR?=
 =?us-ascii?Q?YdgEygXAHuFgeCDAQsL4oVYaTudWA0fkdmSwRNBBJh1qLvyJ9b4t47qbhJVV?=
 =?us-ascii?Q?K5u9VTJ8fIEETQRuulkojSI/74cGWvaBzr79LcvmEIlSTyn1KoTLZlYgjPEv?=
 =?us-ascii?Q?IxjKmciOunBBxfV/bGZcUQJmPtDz51IjzY2korS0kBKxzA9x4ko/hItCa3ai?=
 =?us-ascii?Q?UhAiCM1rgoNUKu1ZqdbL5mBH0LCyhTijQzNo6OF58MeAwAD00326eh3lciFA?=
 =?us-ascii?Q?NjzvTcKDGPi5UYMplA1H8L5CH5w+jpUumF3wXtGUhWYUN47mwCtZ8N+ytqEZ?=
 =?us-ascii?Q?YhG0SRZm1M3UMCuTIrWAqwrKryGu03Tkvo8XhUXE20kRFd8DWNLYKTYSXSv4?=
 =?us-ascii?Q?RXfbe3hETBlMaPIEgLRlFCCYpjKdjLo0aXOTCEds/DpjOZhYD59MPe0aStXQ?=
 =?us-ascii?Q?QiGWIaGcyBzguO+2tq+4FW3URjJYdZvuKco7KXzY5dEh95hIATfVhwFIcPup?=
 =?us-ascii?Q?SODm3b+xHKdzI/iFLnVixSfDMOqZZKmYgT/kF1kRE+IPxMlsJ4IpmCEiooCD?=
 =?us-ascii?Q?Z0LzyGAAJnZgeHaGbSkyvKtAWbrsta+72+JVq0HRmjKBSZSlsY+H4dR8ybP/?=
 =?us-ascii?Q?bUamM6Dt/wAt3HjBF8lgdcETagJU5DcM69aG+03QU34zMtJJTpl8dS231zmV?=
 =?us-ascii?Q?5OKcQzOBgCFk8lhvL8Wn0zQYLu7jDyNG5NUh4Gvzonw9mHioPy0mIiV/n4fp?=
 =?us-ascii?Q?eqjRzzQUaCdNTvpin+QJp6MmoOrCFCFRLlBkjgMW3Y+OLkSKaGkTaEKilwoh?=
 =?us-ascii?Q?yZYqT3ByyKrnTgIq77Yr3b5TSob/DeIt5lrSMhxQ/c7BAm3ToS3EWt/jvjmD?=
 =?us-ascii?Q?n4EBdCkF2Ge4F+KhYzUt9OMUu13LBILKlOw0GPPXykQTHVyln8y1HgHGqUbb?=
 =?us-ascii?Q?/3vWoeEyhdzXZTdxdOsUf0S500Rtof/9DAtbqLKhxuMgz46+/ErM+saHr7Qh?=
 =?us-ascii?Q?P9dgNj7hOCmDDc+elIHexeHEbFa+r0xudtUhtath6uJUWJv9G5EihB4Q+KgY?=
 =?us-ascii?Q?wVwwFAVfeIJfKIblNal0BfYW/lqweHpmS9HxyCvEyvcBT9l79khKB6+dOgzl?=
 =?us-ascii?Q?Id6ttLegas2JGuqzQOrjlt0UxQHnX4GW5XmGEvsbG8wO6GSClx/I3aMjbIEK?=
 =?us-ascii?Q?9SA3cuRupnD1sFZCcHgJZeMu7lEYqvHLIcBuyjRn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e20252-6323-4fa7-0245-08de373e07a5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 16:14:29.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkEYyAx/FvdVKJLkulzBEJ+x5NTlVGSVPoSA7PiW6E8hRswX2moIfHuJ8I+5hK0DRqM0tq2wFJDco0F/yNCkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827

On Tue, Dec 09, 2025 at 08:19:09AM +0000, Wentao Liang wrote:
> of_get_child_by_name() returns a node pointer with refcount incremented,
> we should use the __free() attribute to manage the pgc_node reference.
> This ensures automatic of_node_put() cleanup when pgc_node goes out of
> scope, eliminating the need for explicit error handling paths and
> avoiding reference count leaks.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>
> ---
> Change in V2:
> - Use __free() attribute instead of explicit of_node_put() calls
> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index f18c7e6e75dd..89d5d68c055d 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -403,7 +403,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
>  static int imx_gpc_probe(struct platform_device *pdev)
>  {
>  	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
> -	struct device_node *pgc_node;
> +	struct device_node *pgc_node __free(pgc_node);

struct device_node *pgc_node __free(pgc_node)
	= of_get_child_by_name(pdev->dev.of_node, "pgc");

Make sure pgc_node value assigned when use cleanup. Please see cleanup.h

Frank
>  	struct regmap *regmap;
>  	void __iomem *base;
>  	int ret;
> --
> 2.34.1
>

