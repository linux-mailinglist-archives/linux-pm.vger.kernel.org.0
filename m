Return-Path: <linux-pm+bounces-33621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A73B3F972
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767B1204A73
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FDF2EA169;
	Tue,  2 Sep 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dRXXfi+E"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013020.outbound.protection.outlook.com [52.101.83.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7D20E6E1;
	Tue,  2 Sep 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803658; cv=fail; b=pYnkh/UD2CeBhUDvzUSGYSI/4nbbLz3nvFGWFZ27e9j4Tj6ePWn0pNfI/41oN47stB/s5Q6RTKAjSXk2PlDSOfcZr9PYUcWJMIa53Agv09Ql3ViXly/3e/Cs3VQtdB2qln9ZFenYTBjiM/ugKG8Ih9+GOGH3hdxBhwWs1m3XDS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803658; c=relaxed/simple;
	bh=5dSPDWNxfTQe1LNmNG+8MRz9Nb9LR6Fr686FwnpQYHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTBwRuYg8Is3QQstvcdwk0Qud+c50ejUeGJNhpTdP+XnEhS8RsXErkn0GbIbwly6fyH/rhG0mSaJ/FAlZ1MPWQhB6+BteASEujxfP26ncVEYwfoLTeqWiuxSNZOL+B5cb5rUs3fZzmscaR8sqzNfcgTge2+NbNiiVnE8HOU/Vvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dRXXfi+E; arc=fail smtp.client-ip=52.101.83.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdYSSftxhnX/eiMKx/a35IT+etWRHAtxYQicE/RqZ1DO31aRjfKUsdyhy4k4IblCOyx3rLugzaWoZ8TKhZVlZ6Mwr/IIGR4VzHQzucqjhTlokREx3ONr2FK6tBcWzbD/t4H6jnOlihZvKsfOsh8xRiV69BaaL8McEZmGI/hEEK8jB66WCPATkZk8h8Fell4D8j4YublM1mPmx7IsjMQHhSzIvSbkFIhpPU/EVrCVr51sj2o9HdUf7/h58g4DNjSIadzKJvprPcOIYHHH6GS0RRt0b7xDeQnO9FRwKKuhiOe90t80sEcOSTi8u7/9KHEFjjUlckyZqqfrr5ZpfNx5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=424mYQ1VTFxkWQ3X7r+7HzgD9r2j2iABJAmqzJxsGbQ=;
 b=qaWUB3Oxw0OuPDi4+P1x8Xf5XtGZC8hhuftChp4UZReIfmbpwsOsDhaOxLEXGJCLRf5+GlXsJuMjnoOh9eSsnPrg+FTXxrw0HMAj5+FTpedpuXfh6HCO1n0DBYQvdVSARiOHUn0b86bMxtEaNCyX0EU08i6XG5oMsXC6VEAn+xZSHprgSmWWwe9AY31LFHwkUP0g3JsBarPElohyQzr5cPUlOSJpF/LCns9fkSjY1jtI9T0A/26NIsw7rutuVvFBd8rBJ4XOnWkO4h/I7VQv8Z9ZoPCRmrzapjC5osg1d24izaOMSvYr0CemHPkzEmkDAizJS1qoWF6jor1teJYSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=424mYQ1VTFxkWQ3X7r+7HzgD9r2j2iABJAmqzJxsGbQ=;
 b=dRXXfi+ExkkV4O74CsgRhFsBWRSCC4z+Fidn6bQJsYB/+CYc3KtSUjBp6PACa5jnhWPhW1eWMksX//kCtmWnN1np8Nrq4TvI94uOXn0V/BN8JkDeumvsI1j8BXDmaDLHQIh/HyVKt6b8WPxI012qXiFm13dNP/b06UPxULS9aG4+zrIqhB8EfiKQwF2RZ6gHSNkQaS1a8Rxk0Pabg1mSxDev9GF93KpWP3poaKRKvLoUBH1LmhMGa2eMInEYLcTSgGkpQZoOFGm4UW5dUB7o48omXy+jkSDjIoOgoQuJPPk6szyNUCa6DUNL1K2ERcMhhqJU995Suo3UGWzsSJLiNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7638.eurprd04.prod.outlook.com (2603:10a6:20b:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 09:00:53 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 09:00:53 +0000
Date: Tue, 2 Sep 2025 16:55:13 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	imx@lists.linux.dev, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] usb: chipidea: ci_hdrc_imx: Set out of band
 wakeup for i.MX95
Message-ID: <xpso3qwem7d4rsksjazujvfqqvufdmq4vmfp2y7wcqlvk4f5nr@2akfm57mf6jd>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <20250902-pm-v3-3-ffadbb454cdc@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-pm-v3-3-ffadbb454cdc@nxp.com>
X-ClientProxiedBy: AM0PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::36) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 18972ffc-2f67-4139-9b40-08dde9ff38a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZrxXN17lig3MClt72hL+ZZUYw24x+1dM9t0q0EpiibMfwfWZje7YwfY1pvQm?=
 =?us-ascii?Q?wU1wHXQSy/HptmIpaA5Y1FYCFfS5aMKORP8vRWKG2QnznxDrJyu50Qu7y4er?=
 =?us-ascii?Q?D0DKWVb5GPg9f6774TuL08VT90/5HiJS1Z4qp11WovS89t4Z1qgDBuDmVYbO?=
 =?us-ascii?Q?onEsGP/XFXQrmcT136lWywOJV3QQDnOSWsM4gKR11BaghKB7t3cfekWBnx5Y?=
 =?us-ascii?Q?jOVgPsY7vxaIdfliqqXU/vhU49qlLixbSq/NPjz/vG0cR0GlGi/Di6mZzD1S?=
 =?us-ascii?Q?Fa4zh2D7BPYIaOiv0OnsWcmkYrXscs3LjcQf3/hHcE1HKlUPU/cgiBOvonfG?=
 =?us-ascii?Q?ZxxD1cGdKjojUmdHGoTT84HaIx2gRZELm0gRaJw0lBtrQzXNcUFJ7WaZpF3l?=
 =?us-ascii?Q?xvhQRC/Yck6P25JLIkgkUPrXMUoybSSkDQEKeztEKMHoXxu4Y3SonQkwKCgg?=
 =?us-ascii?Q?AEzayUh7ixw3fFBjYFGdD1XuubYQPcBxKVWeX70Nj44qFj31DODRkS1xqxC4?=
 =?us-ascii?Q?i5JmNkEmPjsoRdBPlgXupCqJu1/U4AFUnSmVvyeOvEQmzHdsCY6ZUGAxkQ3D?=
 =?us-ascii?Q?x253xSHw+s0PNXJtXNVxTfvqOzyjGBBMRtk3/dqMv/Xkr8AOO/7dl8WgmvbM?=
 =?us-ascii?Q?nccqhNgihdMR1nrDeFI94SDQwDCUy+vKqupnEyAbZwUGTjjXTVF4wolkOXo0?=
 =?us-ascii?Q?vJNzkIGwzLQ9WlMXgJx4sB/fkUop8Y9t1hMi/9cFI+KM3dKHr5Zf1QhEj0pO?=
 =?us-ascii?Q?tmIknV5TfDJ9tzKExCb0GnsaJcDdZiyUz6KGccCX5R/Tdy8XzPPHGJr2duLp?=
 =?us-ascii?Q?XwuYca/DtB82ZcPg4JLhdF8+FCYjLeFntx8GAwUERmWa/dHmxHZMrP1cgyk/?=
 =?us-ascii?Q?HvUf5Q18N/HHYn4HImJ9TH3E3ONhtNpf7K5xRwMVpR01VezTt1vBfr6XFdYL?=
 =?us-ascii?Q?273rkb7pDhJjyiWdjQSoUkbUl2mhGpFV0UfeqcTHrILPEVQzEi4cf4HP00Ec?=
 =?us-ascii?Q?uQPgcvXtDwhIaohzJ/oYxNYPKK+5IIkZcGoWuydBFhD/nJUNAWy5JOok1tb8?=
 =?us-ascii?Q?9fGHaPUa2UkIaolGoiPOKUOoJkvMB2Y7fpkw91lxnNSwBlvHUKZGCljXR+E6?=
 =?us-ascii?Q?lHN/CpIrRZJ3W/1k+fCOeHIVOIkdxO1J/dZG+/LM6hymzerq/rdo6/JMcSXm?=
 =?us-ascii?Q?fm77FDw9cAivXKn4pr/2LfdrEvBiehmTzkPL/4gn1P401gjOQ+nzXSE/JrtC?=
 =?us-ascii?Q?4gbvMqIoNLzYgddz1rdIScZ5X7Q3z4qmLmsTSXBiKc7J8YocGtHpdK9T1URC?=
 =?us-ascii?Q?2Wh0Wm2q8xv3mCz27M9AUbjQ9IP3GWxABloQAe8k98zk7+Sv37u/niBGyNf/?=
 =?us-ascii?Q?+Zdu/qeXty/xxn46mw51DsD1aB7Q4mj2eqLdMpGNqyAYDwlX52j7ntJbLB1m?=
 =?us-ascii?Q?HvskkdspHcu1rqXAXLSmBiRtM+GriSnwdiRb4GodDS8WBdf3yI4uag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCBWAyWVYkb9wHfYlFmxcTexKdXUx0RwHaFlFGOS0TxVlRbRZin8RuWtEw2U?=
 =?us-ascii?Q?zAlGzU6il1TDbtb8qHHwAnOFQ2aGaa+7JPYn34hkYEVgRjUgDRxKC9w9VE+E?=
 =?us-ascii?Q?OoifOoeLE2zvL5FmeOLkQA9YbUIcjMMJvajJqDFJbPZks8wjYWkm+QPdonbg?=
 =?us-ascii?Q?HLQ+oe6XlT1SIlZq9V1e68xoLUuTwe6Qt0vELaIkrRMOVED1mBNeGE3O5tw4?=
 =?us-ascii?Q?nWG5A7LtExgwgzWeieYVChIO7/hvjFrgPBV9okCFOA1GiEq/eqaeP9eB9bWL?=
 =?us-ascii?Q?ySO5iXt8cPSQaZMHudOsp5xl6gh9NkbTZ0qKaqLicFwhdPBDX3BGaAXdOnI3?=
 =?us-ascii?Q?J6zNwR1/JMKcu3YgHtNYkPWxbiPrJc/M3Q9S79UN1gz8JPgbu1krQsdFvdr1?=
 =?us-ascii?Q?S4r2FE7ELEtUByv1zj5NmKAp3Cadb2MzdAbNe1zIQl21WlOIawAIzLl3l0qK?=
 =?us-ascii?Q?sklVkJPzLqgiMK2SbLdNJIE8QOfxQEihl0FhP2goATmpyywakcJaVnebhAqD?=
 =?us-ascii?Q?xzWy8b/tRoyCWAvx+x2yDzJfRYeaAlb5SppICqW43Hl7wi8t0v8rw/Qgsh2+?=
 =?us-ascii?Q?VekHEud//qmFMEiVg2bbXmg7t4ZN4xoD+2nPJvrtb3zZyyofXs5H9leKQwYY?=
 =?us-ascii?Q?uYecxZzVf5LRbOgMWuNwmuKMlIdS2HgUhTJlx/EY1jkchidNSkHVux6YW10q?=
 =?us-ascii?Q?ZJ9FHuGcUpa0uZbsZTunI1e9OKtNDYAGRalqEwibqWe1QrhEB3rX6iR/HIXk?=
 =?us-ascii?Q?IZY7+/yQpEG5N55u37PzNDupNb7bo1UUki7iGmyHA8rnsoTWIT1cr/RsqpbB?=
 =?us-ascii?Q?DVPB3i3hs3n6XAqbbIfB5ygqh8cuGJPzUR3xpjYy4CRKwNNxNzwdNxLdlfSi?=
 =?us-ascii?Q?iesTkys50ydSLrW55Ozl34Qf8uo0FAvCtaUsiEkCAzKcGKD4PDS3sidh1Vbo?=
 =?us-ascii?Q?Nzkygq8x6M5WHE58bDcRUPWaD0hwd/W3Vv78Vgh1oDrIZsLTfvY0HmG7HvVR?=
 =?us-ascii?Q?bwWBnxiwRjV3E2sFDakDHDddgq7Nl0wSH3TRUKH8y7DOsWR0IV6pU0z2tayN?=
 =?us-ascii?Q?1oi+zLBvE2FfRASl3DE/nsgN61QmVrfk9JcssSBIuKk0eWt7jc15p6CtfncU?=
 =?us-ascii?Q?Qu8UAgz4wQt7ZxwRF4KqztVDNf9haV949nIgp12e49rn5YcuCDYF24yd+1xd?=
 =?us-ascii?Q?tpZr4iIFMqtRUfX9cPuwdHGIJaNUfLvwriUZslM5W8rUju6w3rVgYWFKzBLX?=
 =?us-ascii?Q?gmZJLaT4fL2yocWRXkcU2wlGAhm3pvbVP3sZNCxXm9SLFwSnUD4CWqKkGtG2?=
 =?us-ascii?Q?HqQDSbxK3J0nLc/jtoNieUivkrZ8eRYQcgypJMJHPv4qOuSHAkTu6BPtl9zh?=
 =?us-ascii?Q?N19hvFM8t8MBvFl+hNReNsHzmAgGZ0dDimLsbHs520j2OUb8cyF88OeHC/Ja?=
 =?us-ascii?Q?7D8iiwZ13ytT9LHG+S0/z3S9UaoWy2eGWGXsxT9Uepnz0A+xVNP1urfmLrUk?=
 =?us-ascii?Q?7eCNAYYaveizyjCJGlgjnYLurf9D6+aD89twE2AlbNDONmdLOAI+9O3P95pv?=
 =?us-ascii?Q?H+3ApjYw3UTLYHgCisAr+mK21WbVZ/r7pojUBGRG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18972ffc-2f67-4139-9b40-08dde9ff38a2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 09:00:53.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++/UlShz9E1Vnjm+aYMQ9R9uRWlRY5HlZ+JnzUtNxO5JvLoXRJUAZ7zkcFpI8dsim2VyQX2W3a9sr63lY4RVGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638

On Tue, Sep 02, 2025 at 11:33:02AM +0800, Peng Fan wrote:
> i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
> power domain(Digital logic) is off. There is still always on logic
> have the wakeup capability which is out band wakeup capbility.
> 
> So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
> wakeup system even if HSIOMIX power domain is in off state.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Tested-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>

> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
>  include/linux/usb/chipidea.h       | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index d7c2a1a3c2715967203b98c819fa864e06a00a32..a2b3f673dfc1183a02783bf6ef92f8570c6042cf 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
>  		CI_HDRC_HAS_PORTSC_PEC_MISSED,
>  };
>  
> +static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
> +	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
> +};
> +
>  static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
>  	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
>  };
> @@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
>  	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
>  	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
>  	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
> +	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
>  	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
>  	{ /* sentinel */ }
>  };
> @@ -570,6 +575,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  
>  	device_set_wakeup_capable(dev, true);
>  
> +	if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
> +		device_set_out_band_wakeup(dev, true);
> +
>  	return 0;
>  
>  disable_device:
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
>  #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
>  #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
> +#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
>  	enum usb_dr_mode	dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> 
> -- 
> 2.37.1
> 

