Return-Path: <linux-pm+bounces-18917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1319EB2CB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555F21885B24
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC21AAA0D;
	Tue, 10 Dec 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWOW/729"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15C1A7253;
	Tue, 10 Dec 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839782; cv=fail; b=PbN2RKJMRZunjueMVGQNYqs1sQ/Lj6D/UFPk5N7l2UpBZzlCqDbEa+HC+eQSYYAFNilLqcGCd1yaWv6hfw5+2u26kyaLvMbWHUNY1Irgve6DHWoe5mT/n2KNvBlaSnojxEyqd5hr8PRjB+zfczyyQFGtWve3xFYQsIvNj20W1Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839782; c=relaxed/simple;
	bh=S/Bf1s+QYFcyRxHEW82grDeNnaLJM/+BWYrRRdGGMnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o3+eJrDipxgES1KfM89e2E677QPl1O1NNcm7Cg8aXaRoS2uYxJAPMMYMslf/wv+jmOu9czTeKqHCgAf/8Iu6s9YU3Lc23SdvKqZDw/6Kduz75bdiWuBR+Xl+QN6NSLxmcqMO5owMIr7oJI+gvdKv01WHr1+Xfd+7ewuw9EhOt/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UWOW/729; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrigVAs6y4pebTgmGCPtWfr2XUvbo8Q+2vU261m9ZRfRezmAzTLIq47A8/JiZ50HlXSXPQtqwoxmGtEdofTSwCcqlSd5ke965vdNLoqs/XoNKOHwylScJrVNh2Rp8PskjSh/NafSK8QiPaAUnVLcZNe2ER/ZEzegkjEXGhmee6D3hNzxT37aIdHAoiYwypYensFjaYlBy0LQ6bvw3+cmJRHil19Xw+6uPlJAZsYeLkWdi7kXz2MX0RhjrAXXJLibS8d1kOZkT1iqWG66AFJsRcDuASDs12CYTDHgNncKvBAnDFGudLmFxnhnRCM0FStV/MWPvU1fHZkmXOY3Xhr9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSLMiPyl3Zv9rLcmQjHoxdgkIuJYXzX0LJUYjUVkbZg=;
 b=pFzkOkw0DFVnRw6UIryGfrkNpWYFFQsg61vT5IYwfMNyvUfDqMVRtJZPBY867Ox3V17GHpHISef3eJ7Erhq+SfRi7JHZcIc/mqJvCYJuiL1F7iYhDChQjEiYoNhOP6M2EGyPt71M1EUJo1kZDai2r3l+UKJZIWr4J5Xwmrcr7pOUf4Ab2o4mtCU/iU95l44amcSH/EizexAIQzA2uFeryzf8Z5afzMewu6J5iwo2gr8vc8nnK/tgwc1QufPgF6+trkA7E+Yskd3xRy1FCSfbM8Aywb0c7p7CXljAl2PCxzivbjp+26wsZH0n1xlDXWMilp3hsVmV6fdqV9i+mWmCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSLMiPyl3Zv9rLcmQjHoxdgkIuJYXzX0LJUYjUVkbZg=;
 b=UWOW/729GO2p72j7tzSYQ9w9afamnQ9BbyMiR+UOpw/trMmb/PG722ePcF5iRNJZce/xWPb+MBMw79hCYxFEBVdQWD0xqXKyxMzw7PL/Fyv6cfKR6ML3o0b4pwQ5Ul351ZkQWf2uav3LLWv2/Vp501j5Purs8r5dRUkX4YF+bDAFJ13DbPmvfqi37yFr1TyMCshygkGlcNjbBvaQ8UjsZ5AVMlqRyO673IBMYNSut4bY2kkUjFJB4N2RIIs9mZeUflAD7TUO9EVgC3fEa0vSkt1+lWU0z3JFVcVRIWnI1o2J2a6Qq16KwCYwW8wVN3fbCTLC0idm+u50vTc0WlOzGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10819.eurprd04.prod.outlook.com (2603:10a6:102:48b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 14:09:36 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 14:09:36 +0000
Date: Tue, 10 Dec 2024 09:09:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, imx@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Message-ID: <Z1hLlm75iGMogltc@lizhi-Precision-Tower-5810>
References: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
 <20241209-imx91tmu-v1-2-7859c5387f31@nxp.com>
 <20241210103646.7gblp7mzxbna5gas@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210103646.7gblp7mzxbna5gas@pengutronix.de>
X-ClientProxiedBy: BYAPR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::36) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10819:EE_
X-MS-Office365-Filtering-Correlation-Id: 29189da3-dc7c-4b79-2cfd-08dd1924475f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDUIfTM1bL4jUpWDKzKA8JgFyAyGIVmv3g7G/NlGtOfLUoF6nZUTW4k4ige1?=
 =?us-ascii?Q?F6waZuGEeEcnQ7MOUp6/+HV7EAigliTdNyXVFMRwxY5A+PSp6iSIalpFlXAf?=
 =?us-ascii?Q?RebH/cJJ6Ev7AhrwSU1cYiRlZzn8xCUUWsqNoeAXTx2VwTS8IHts68nqu+c4?=
 =?us-ascii?Q?abEYsMopmvF2BCwqAK090/OpTRw9p/i3Em3yiTt4SCxK635Z+t53eWxnHNUs?=
 =?us-ascii?Q?mXqJBXWFuNmHCu84Es8pWOwG8/f1lv8jGPUVTqwHcy4bfO5WacAJutabrB9o?=
 =?us-ascii?Q?pWcTY7kBf87rBRSmI0WEcRZ2kEFD0ATu0U37DOnNhCHGG9TZ5plrtC5pvcGu?=
 =?us-ascii?Q?drWhx4wOd588RerUbufD57D5QEakmO+9R2Nq9VVZBfgfdbroaLe4mT27kehK?=
 =?us-ascii?Q?2qPt8mfC28I1De39g9JaLQ6J0dyz5OdcsyQF3lCsz6OLsZne3JMpykF8zgZW?=
 =?us-ascii?Q?ozkV7Kr/JC2I3uKWPAWO7mAh4cnWrJOLwk8cbYXuIHgq3HucZl4+8bG78WqQ?=
 =?us-ascii?Q?9RYMuKB0JrrtvnsVrzZAFHlvZC8DvirlSqBadgszAqNihR7Ww7Mnhbd/DiE0?=
 =?us-ascii?Q?dIiFDGu6akukUSMtXWAdwZy5e9JJOAmTPe5OB8sR8C/BXbve8UAhKwQDrLLS?=
 =?us-ascii?Q?ou1rct7q4DvmabuFPiPof8mSfZSTK+j49FEnZ+76wRtLRO+346kHIOUvajd3?=
 =?us-ascii?Q?WBIitI1qzKGwD/hYLtBHbbQt0MmLU9wmus9tVByjdfm1cUBdVJTNoTqXwmtp?=
 =?us-ascii?Q?0oibVoOQXgX+gCwbjtnilX+X4wE7p7KKgzbf7ioBHMS620lvBNnCmsGk1HJF?=
 =?us-ascii?Q?lr6N2mzBliTukcuqfJFi3EmcgLnjes2eBLuajedO1i+eQhRryLf9dqIxgtUk?=
 =?us-ascii?Q?qVMZAYN5nOzmG7F08sH9+i5D4A8Oj3AxEvTXHAI045ty9U9Xhva3/fGOjOIa?=
 =?us-ascii?Q?jYgZcExyk03mq3eqoyHGt6Qx+7yAlxBJp4SIhkzsjhpOtZcfMVHjruUAVdL2?=
 =?us-ascii?Q?jfChfnPO0jMri9RBEtOM0vcqSoTWR5f064IkKyM8kIzm39caPOIh1QwaendQ?=
 =?us-ascii?Q?1PI7sHzWJY4X94RvZvGr6kOLcOmqDNEATEkIICA/bZruUEUdMP3hyFuB1nXW?=
 =?us-ascii?Q?5vbXN53BrR9GSTq96kfui0CPt4UuSulLbYAs2eTvXj1a/aSP95kYRqQ435sW?=
 =?us-ascii?Q?l+7KFAAfukqcwnFIO/cIHMIrVHadjBUTWvphArQsUIiPGAdCvd3AvL+6Iosw?=
 =?us-ascii?Q?EXYVTMnfoPth82Z9lpshX4+iNiEiDICoqTbkFUDuKiW5XVKeTdybmSz7h2al?=
 =?us-ascii?Q?UTMS5kC2EEOpifoMZawKf1xB5KFV+NTUEZi2fFACq5CBqP519TZ9jmY0QaH0?=
 =?us-ascii?Q?X3OOF8ouurY/CTkpwxe7YoZlQ4H9WjfhWTLH6aXlkIiP1kA9Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yxsAs9HBhCOB66Te/+IZvpB21ZAS12D4d/RlB3copI57w5TtckWfXxdNldwA?=
 =?us-ascii?Q?nQu35Z5HjT5YsjVhOMKUXLiLJPDggKOPxrY47VlCRDBxUeHWO1sI286Qb53u?=
 =?us-ascii?Q?ZCXg1zULee6SRCcDUDqFQRUQsPKERx8w1hIUq3ZnPdSXDqOdqaLp6/QJb/RK?=
 =?us-ascii?Q?OXS3Q4kFl8wW6VCSt8RDXkL+sSU6hcM4hhcijNxLkexXJKpLSZbEm8TNB9YR?=
 =?us-ascii?Q?BqXSX1JvIawX3m83EpYijTyc7PN3KAuvrMlQh/St7TiaP/74epZsxkvzp8Xi?=
 =?us-ascii?Q?VC/4UFGy7vkiIBRyy71ll/PBcPkB7KDfLwD4GJfhnDm8mttEqBDspXYykh0c?=
 =?us-ascii?Q?tqWxhphnVBJuf3eaIfVFDEhpqCMnq1Ul/YK0ho7Izfpnzbpey7Qt+879gIms?=
 =?us-ascii?Q?MEx/x+SdflNhvNPCKt4w0QtPT4mNcNPSbQ9nVjWTsPOIev2cQYGGEROH6oSR?=
 =?us-ascii?Q?gHOOFXvUBX8KRVADwjH/1rFppAI8UnJ4nPBk3DxGqYRQu+F2oq+3cpfkWffD?=
 =?us-ascii?Q?ON54ZNYpSe4KDxe7TMdDJEYypJCvSrmyxBFV7q2HhTXUnzhYPYtyP6CYd/AG?=
 =?us-ascii?Q?v9w8ukN47n2hFnbLWnMVRMmirnPaJtvMygVRs/8oZgO5j0NUQmTbwaiNBhIh?=
 =?us-ascii?Q?TLfB3du5EoincwIap/WX5RsFEBZqZHWYB2wWOYf9awv7exaHJeo5zhBkokYs?=
 =?us-ascii?Q?lKPrY79DaNw2y/3s4GTtfJJVs2j3EgDwlA9OCZmXyU4aWEm8wqic2olE3a0C?=
 =?us-ascii?Q?f7tFD1JKYvADz6J177GLCPI2AnHglfYHUACPyMGEtpGOGSdh7JUaEES6/5Ih?=
 =?us-ascii?Q?k5uQqIqQhIAmKY2WxFapOlVoLKIPZLr+6lYcsj/jx65KXVRMxhb/JrZm00P9?=
 =?us-ascii?Q?auWFnHnaU9GXSkpLh9mxYjNfmYJMxIewG18bewBJ3CaYbJ6ExGSlqDa02sjo?=
 =?us-ascii?Q?2EF6nDCcCDbjHkSLQMY8Z7nKdLFj7lfKpWa/VuhUzn3aZyMK+GiV1KXvT0m0?=
 =?us-ascii?Q?glXoaMXzMaLUWgSoVC4JbQdsdhWLQfQ/BgeouNrbWxqNyrDyjgyWGnFX3poe?=
 =?us-ascii?Q?0y1fwmlYiebxC6xSaKxjLH9ETR9TCTXFaHfTDxkY9X1FPp4xrZyDpDYPu443?=
 =?us-ascii?Q?wQq+HvwfSjQMjvKZia9tRL6aJhT3UZ+SG6/jEkadepYpY1fb18PxWDTbYbPA?=
 =?us-ascii?Q?YqJVNvjVEARTwrit/MjETm3xZlozpUIIe/go17Y1j5edMUF63aQ8oNI4op5m?=
 =?us-ascii?Q?wnLWCGxwlfP4wXS9QnHc/hGPG67I8hY8co4RCN/p5TCYVU26HKoY/v8DtJJH?=
 =?us-ascii?Q?mIFwid0JF+Qohab8LnROAm2GeweI54T1fQSjEjuy+INdnVmnXE8Ne0IqwNEH?=
 =?us-ascii?Q?7T+vFLrsQwCXXJ7EmV6KQspmVXqYskXHn/HH0VM5F8D40pz1uMHHfyufAfFv?=
 =?us-ascii?Q?yT5NFqRW3Tsz2a8E4OVOEMzo41/W00vSkOYez62NbzwJviVZujJWAPcDQ5TH?=
 =?us-ascii?Q?WNBbpwkadAhA7jQeneHZBhuWYz9y6JvsrKGtD+2mOcUmDeAUlzmm/NcEJk+2?=
 =?us-ascii?Q?x0xL6wu0dWDO/ZxYhVs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29189da3-dc7c-4b79-2cfd-08dd1924475f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:09:36.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smK/xRzRbpD+aO4h/QUhsKlnu8UxDsGQkUofjZOgdvmr/qGnlM/YyuULnrbCHTqqnF0MfXazBY81pHvn0Zdomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10819

On Tue, Dec 10, 2024 at 11:36:46AM +0100, Marco Felsch wrote:
> Hi,
>
> On 24-12-09, Frank Li wrote:
> > From: Pengfei Li <pengfei.li_1@nxp.com>
> >
> > Introduce support for the i.MX91 thermal monitoring unit, which features a
> > single sensor for the CPU. The register layout differs from other chips,
> > necessitating the creation of a dedicated file for this.
> >
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/thermal/Kconfig         |  10 ++
> >  drivers/thermal/Makefile        |   1 +
> >  drivers/thermal/imx91_thermal.c | 281 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 292 insertions(+)
> >
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index d3f9686e26e71..da403ed86aeb1 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -296,6 +296,16 @@ config IMX8MM_THERMAL
> >  	  cpufreq is used as the cooling device to throttle CPUs when the passive
> >  	  trip is crossed.
> >
> > +config IMX91_THERMAL
> > +	tristate "Temperature sensor driver for NXP i.MX91 SoC"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	depends on OF
> > +	help
> > +	  Support for Temperature sensor found on NXP i.MX91 SoC.
> > +	  It supports one critical trip point and one passive trip point. The
> > +	  cpufreq is used as the cooling device to throttle CPUs when the passive
> > +	  trip is crossed.
> > +
> >  config K3_THERMAL
> >  	tristate "Texas Instruments K3 thermal support"
> >  	depends on ARCH_K3 || COMPILE_TEST
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 9abf43a74f2bb..08da241e6a598 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
> >  obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
> >  obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
> >  obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
> > +obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
> >  obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
> >  obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
> >  obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
> > diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
> > new file mode 100644
> > index 0000000000000..19c4dafe9c7a9
> > --- /dev/null
> > +++ b/drivers/thermal/imx91_thermal.c
> > @@ -0,0 +1,281 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2024 NXP.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/thermal.h>
> > +
> > +#define CTRL0			0x0
> > +
> > +#define STAT0			0x10
> > +#define STAT0_DRDY0_IF_MASK	BIT(16)
> > +
> > +#define DATA0			0x20
> > +#define DATA_INT_MASK		GENMASK(14, 7)
> > +#define DATA_FRAC_MASK		GENMASK(6, 0)
> > +
> > +#define THR_CTRL01		0x30
> > +#define THR_CTRL23		0x40
> > +
> > +#define CTRL1			0x200
> > +#define CTRL1_SET		0x204
> > +#define CTRL1_CLR		0x208
> > +#define CTRL1_EN		BIT(31)
> > +#define CTRL1_START		BIT(30)
> > +#define CTRL1_STOP		BIT(29)
> > +#define CTRL1_RES_MASK		GENMASK(19, 18)
> > +#define CTRL1_MEAS_MODE_MASK	GENMASK(25, 24)
> > +
> > +#define PERIOD_CTRL		0x270
> > +#define MEAS_FREQ_MASK		GENMASK(23, 0)
> > +
> > +#define REF_DIV			0x280
> > +#define DIV_EN			BIT(31)
> > +#define DIV_MASK		GENMASK(23, 16)
> > +
> > +#define PUD_ST_CTRL		0x2B0
> > +#define PUDL_MASK		GENMASK(23, 16)
> > +
> > +#define TRIM1			0x2E0
> > +#define TRIM2			0x2F0
> > +
> > +#define TMU_TEMP_LOW_LIMIT	-40000
> > +#define TMU_TEMP_HIGH_LIMIT	125000
> > +
> > +#define DEFAULT_TRIM1_CONFIG 0xB561BC2DU
> > +#define DEFAULT_TRIM2_CONFIG 0x65D4U
>
> please align the defines and use lower-case for the hex values.
>
> > +struct tmu_sensor {
> > +	struct imx91_tmu *priv;
> > +	struct thermal_zone_device *tzd;
> > +};
>
> This can be part of imx91_tmu right?
>
> > +struct imx91_tmu {
> > +	void __iomem *base;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	struct tmu_sensor sensors;
> > +};
> > +
> > +static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
> > +{
> > +	if (start)
> > +		writel_relaxed(CTRL1_START, tmu->base + CTRL1_SET);
> > +	else
> > +		writel_relaxed(CTRL1_STOP, tmu->base + CTRL1_SET);
>
> Nit:
> 	unsigned int val = start ? CTRL1_START : CTRL1_STOP;
>
> 	writel_relaxed(val, tmu->base + CTRL1_SET);
>
> Aside the nit, why do you use *_relaxed() accessors in you whole code?
> Is the order not strictly required?
>
> > +}
> > +
> > +static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
> > +{
> > +	if (enable)
> > +		writel_relaxed(CTRL1_EN, tmu->base + CTRL1_SET);
> > +	else
> > +		writel_relaxed(CTRL1_EN, tmu->base + CTRL1_CLR);
>
> Same here:
>
> 	unsigned int reg = enable ? CTRL1_SET : CTRL1_CLR;
>
> 	writel_relaxed(CTRL1_EN, tmu->base + reg);
> > +}
> > +
> > +static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
> > +{
> > +	struct tmu_sensor *sensor = thermal_zone_device_priv(tz);
> > +	struct imx91_tmu *tmu = sensor->priv;
>
> With tmu_sensor merged into imx91_tmu you don't need this reverse
> pointer logic.
>
> > +	int val;
> > +	int ret;
> > +
> > +	ret = readl_relaxed_poll_timeout(tmu->base + STAT0, val,
> > +					 val & STAT0_DRDY0_IF_MASK, 1000,
> > +					 40000);
> > +	if (ret)
> > +		return -EAGAIN;
> > +
> > +	val = readl_relaxed(tmu->base + DATA0) & 0xffffU;
> 						   ^
> 				Please use a MASK define for it, also no
> 				need to use the U suffix.
>
> Also according the TRM 58.3.4 this doesn't seem right. According the TRM
> this is a s16 (two's-complement) value. You won't get negative values if
> store it within a int.
>
> > +	*temp = val * 1000L / 64L;
> 			  ^     ^
> You don't need to specify the type here explicit since all params would
> be converted to int and no overflow happens.
>
> > +	if (*temp < TMU_TEMP_LOW_LIMIT || *temp > TMU_TEMP_HIGH_LIMIT)
> > +		return -EAGAIN;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct thermal_zone_device_ops tmu_tz_ops = {
> > +	.get_temp = imx91_tmu_get_temp,
> > +};
> > +
> > +static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
> > +{
> > +	struct device *dev = tmu->dev;
> > +	int ret;
> > +	u32 trim1, trim2;
>
> Please use the reverse christmas tree style.
>
> > +	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (trim1 == 0 || trim2 == 0)
> > +		return -EINVAL;
> > +
> > +	writel_relaxed(trim1, tmu->base + TRIM1);
> > +	writel_relaxed(trim2, tmu->base + TRIM2);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx91_tmu_probe(struct platform_device *pdev)
> > +{
> > +	struct imx91_tmu *tmu;
> > +	unsigned long rate;
> > +	u32 div;
> > +	int ret;
> > +	int i = 0;
>
> Same here.
>
> > +	tmu = devm_kzalloc(&pdev->dev, sizeof(struct imx91_tmu), GFP_KERNEL);
> > +	if (!tmu)
> > +		return -ENOMEM;
> > +
> > +	tmu->dev = &pdev->dev;
> > +
> > +	tmu->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(tmu->base))
> > +		return PTR_ERR(tmu->base);
> > +
> > +	tmu->clk = devm_clk_get_prepared(&pdev->dev, NULL);
> > +	if (IS_ERR(tmu->clk))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
> > +
> > +	tmu->sensors.priv = tmu;
>
> As said, no need for the sensors container.
>
> > +	tmu->sensors.tzd = devm_thermal_of_zone_register(&pdev->dev, i, &tmu->sensors, &tmu_tz_ops);
> > +	if (IS_ERR(tmu->sensors.tzd))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(tmu->sensors.tzd),
> > +				     "failed to register thermal zone sensor\n");
> > +
> > +	platform_set_drvdata(pdev, tmu);
> > +
> > +	/* disable the monitor during initialization */
> > +	imx91_tmu_enable(tmu, false);
> > +	imx91_tmu_start(tmu, false);
>
> Make use of pm_runtime?

thermal is always on after probe. continue measure tempature. So pm_runtime
is not suitable for this case.

>
> > +	ret = imx91_init_from_nvmem_cells(tmu);
> > +	if (ret) {
> > +		writel_relaxed(DEFAULT_TRIM1_CONFIG, tmu->base + TRIM1);
> > +		writel_relaxed(DEFAULT_TRIM2_CONFIG, tmu->base + TRIM2);
> > +	}
> > +
> > +	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
> > +	rate = clk_get_rate(tmu->clk);
> > +	div = (rate / 4000000) - 1;
>
> Would be nice to validate the div value before passing to the HW and if
> the target rate of 4MHz can't be reached by the div you you should
> return -EINVAL.
>
> > +
> > +	/* Set divider value and enable divider */
> > +	writel_relaxed(DIV_EN | FIELD_PREP(DIV_MASK, div), tmu->base + REF_DIV);
> > +
> > +	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
> > +	writel_relaxed(FIELD_PREP(PUDL_MASK, 100U), tmu->base + PUD_ST_CTRL);
> > +
> > +	/*
> > +	 * Set resolution mode
> > +	 * 00b - Conversion time = 0.59325 ms
> > +	 * 01b - Conversion time = 1.10525 ms
> > +	 * 10b - Conversion time = 2.12925 ms
> > +	 * 11b - Conversion time = 4.17725 ms
> > +	 */
> > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x3), tmu->base + CTRL1_CLR);
> > +	writel_relaxed(FIELD_PREP(CTRL1_RES_MASK, 0x1), tmu->base + CTRL1_SET);
> > +
> > +	/*
> > +	 * Set measure mode
> > +	 * 00b - Single oneshot measurement
> > +	 * 01b - Continuous measurement
> > +	 * 10b - Periodic oneshot measurement
> > +	 */
>
> For the resolution it's fine to have the values directly coded without a
> define, but here we can definitly use a define and drop the comment.
>
> > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x3), tmu->base + CTRL1_CLR);
> > +	writel_relaxed(FIELD_PREP(CTRL1_MEAS_MODE_MASK, 0x1), tmu->base + CTRL1_SET);
>
> Why do we set it to periodic mode instead of the single-shot? At the
> moment the device doesn't have IRQ support, and so there is no need to
> run the measurements in background.

It is "continous measurement".  first clean MODE_MASK, then then 01.

_CLR means clean bits according to mask
_SET means set bits according to mask.

Frank

>
> > +
> > +	/*
> > +	 * Set Periodic Measurement Frequency to 25Hz:
> > +	 * tMEAS_FREQ = tCONV_CLK * PERIOD_CTRL[MEAS_FREQ]. ->
> > +	 * PERIOD_CTRL(MEAS_FREQ) = (1000 / 25) / (1000 / 4000000);
> > +	 * Where tMEAS_FREQ = Measurement period and tCONV_CLK = 1/fCONV_CLK.
> > +	 * This field should have value greater than count corresponds
> > +	 * to time greater than summation of conversion time, power up
> > +	 * delay, and six times of conversion clock time.
> > +	 * tMEAS_FREQ > (tCONV + tPUD + 6 * tCONV_CLK).
> > +	 * tCONV is conversion time determined by CTRL1[RESOLUTION].
> > +	 */
> > +	writel_relaxed(FIELD_PREP(MEAS_FREQ_MASK, 0x27100), tmu->base + PERIOD_CTRL);
>
> With the single-shot measurements we could remove this part and..
>
> > +
> > +	/* enable the monitor */
> > +	imx91_tmu_enable(tmu, true);
> > +	imx91_tmu_start(tmu, true);
>
> this part as well.
>
> Regards,
>   Marco
>
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx91_tmu_remove(struct platform_device *pdev)
> > +{
> > +	struct imx91_tmu *tmu = platform_get_drvdata(pdev);
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_start(tmu, false);
> > +	imx91_tmu_enable(tmu, false);
> > +}
> > +
> > +static int __maybe_unused imx91_tmu_suspend(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +
> > +	/* disable tmu */
> > +	imx91_tmu_start(tmu, false);
> > +	imx91_tmu_enable(tmu, false);
> > +
> > +	clk_disable_unprepare(tmu->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused imx91_tmu_resume(struct device *dev)
> > +{
> > +	struct imx91_tmu *tmu = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(tmu->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	imx91_tmu_enable(tmu, true);
> > +	imx91_tmu_start(tmu, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(imx91_tmu_pm_ops,
> > +			 imx91_tmu_suspend, imx91_tmu_resume);
> > +
> > +static const struct of_device_id imx91_tmu_table[] = {
> > +	{ .compatible = "fsl,imx91-tmu", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, imx91_tmu_table);
> > +
> > +static struct platform_driver imx91_tmu = {
> > +	.driver = {
> > +		.name	= "i.MX91_thermal",
> > +		.pm	= pm_ptr(&imx91_tmu_pm_ops),
> > +		.of_match_table = imx91_tmu_table,
> > +	},
> > +	.probe = imx91_tmu_probe,
> > +	.remove = imx91_tmu_remove,
> > +};
> > +module_platform_driver(imx91_tmu);
> > +
> > +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> > +MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
> > +MODULE_LICENSE("GPL");
> >
> > --
> > 2.34.1
> >
> >
> >

