Return-Path: <linux-pm+bounces-26710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2705AAB9AD
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 09:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258917B3112
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48384206F23;
	Tue,  6 May 2025 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u2c+1lbg"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A2298254;
	Tue,  6 May 2025 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746502184; cv=fail; b=QzBMAzo16rhBCeHxa/TPUEhtbotuY5JeOxbRahU7QcFuk7djqFsT4MmCRmNulxJmeiBnREq6LQHTYgtPQF5ifLFRXKq5Iv2T8BojKGakDeenttUzSbXxR4Sej2dcDGtAhRRe+THAf9/61sul0iWRcb/I4IcYTxM6fTWmTi5KZgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746502184; c=relaxed/simple;
	bh=HeFFFiTNbSNnqnBPd4RJ9ib/AFKSzpkWtKU1lYuNmOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CpeMlcHvtiqzgUOaOY/WnrJHbCKwMcbZX74gJy0+X2iv5tS9S+1KFZ5v4UmkTXGDEJ8KXXZdgj08E1DjdtRI4bLUHMcOKiZCjR65i/+HEWXnp6+9yyW5ihzh99VP8LLK8NcyvUOPHkC5KXkOcqd2j7c0dTZ/DsSPgTdjgbXhD5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=u2c+1lbg; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmLQ3ZfSMgHWKNLjmbVtXDUhFZtFIyXE6Zh6cwcSo0VasLAUfER7VLXeMmEvxlF/HX4vz4e+orSy+qK1C+PZo01K7wPUtUPkskxBpBN7xgzD0zSnwmCzcjOoiUTrEw7FcxbHegMBkycsucCZRMoyzj6YsAUSIL/CWxxuvcjQd3rxOud6iR4I4bo6pS2RIDfWblFUn3SB2rLrjIdEHFQfmuiC6YV+LptIvw6nveiZ0R4PhA3cQRco6R64pMR0hs+BYvH23835rNzPBMJU0ymnKTkKKrbdjvmM3HA8mkQYysWBB2fBM1WAP3ekiLLH4F04E5cT9A3TOC5orZWHRE3jGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho7ItPFlA5lzXaeNVZSviOSWNKnifX9Cp67sSf2E5Q0=;
 b=L67eRBbeAefqLQ6emcFdEvdvppzMzUsqLno9Hp2LWUQcnFJT400BnizWAVyanrJbRJYsYOSk4KGxGLi23t6IfCjnCLb8mSy6cdbZJTrz2Oe47jWr+pXgm6FGBftr0NXi6oHOpJ64WETFONn5i22jfO98i6mjD/JGhbSuoEHqnOIB/8+P8+UNZEoIfhXQUIDFbsODt+cOsruZ/dd5pC8oTY8jnrER31VnB0poDOfabGAQuxdxD5Xv4CXPw5qyrZZ36LImMA8FCN5iPrBqK5Hkazm1t/c3psbZf8HGE+XkdbSq55Kmi0WnLwmMQV+2D7fQfJZkij1wgIaO4jj85oUERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho7ItPFlA5lzXaeNVZSviOSWNKnifX9Cp67sSf2E5Q0=;
 b=u2c+1lbgbR8fiIEcUohNh7P5xi/hlMIJTOSuEntVhQy4t3mFKqjVjf61J5ApLPm9W9Fhat1LkEZyPHfmljJclTs+XPQdJKYo+xWFrrgzEFph5qOKpsPzHR6a49L3sqYFnHjEVQIBLiu2hAq7uDudynT7/HKjKyLPsRebVJPqIWgZ1cOJId5ALQC8iRFLw8CNuP05xm2T0i5CPCcLhKoWr1KF+lyBtgy7/c9ePlNDhp1dRV9H1OXJHvle6KmydZGJd5ncnztJyoJIPVl61T8az2/iBMzbIPgED76T0OvplHpdgYF1UldeKdL7g3scV5YrzDRI8Vny0We6j7P5v/e6kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB9143.eurprd04.prod.outlook.com (2603:10a6:20b:44a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 03:29:38 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 03:29:37 +0000
Date: Tue, 6 May 2025 12:38:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] remoteproc: imx_rproc: skip clock enable when M-core
 is managed by the SCU
Message-ID: <20250506043835.GB24259@nxa18884-linux>
References: <20250505154849.64889-1-hiagofranco@gmail.com>
 <20250505154849.64889-2-hiagofranco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505154849.64889-2-hiagofranco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a48ff9-05b6-4c5b-37c2-08dd8c4e3a55
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4kSN+gO89Y9pr9Hs2dUzbFx15M8lPRWJz+tuZOImHi/0UYyQ7yGPLAiM9fFj?=
 =?us-ascii?Q?utqeLo2l6wpwVonc65h1zvZK3x1+NyeKo9BAqmcKWLtIWQ9ogQl9GI2t/mgY?=
 =?us-ascii?Q?BBInjCvfMf7S/1I1COxnkHa1hKxGzT6KzacQXNItromndDLwpDdADXa8SRyM?=
 =?us-ascii?Q?7Mn7vG4Ln6RKmI5/PuK6bOJC+R1swDZMCXXlU5P1+z7KhRqYUS4Bq09UDemf?=
 =?us-ascii?Q?baU2SfbxGTMlo1pEyKIwZbXGURA9VCqGtIoaviCqHjgsetRczzTX0z1ABmbD?=
 =?us-ascii?Q?vJ5YWgKFq3DBJcgN60F1JYZcP/X4h2F4XQE6EbTPA75QMDPXoWo3CQc1e9V8?=
 =?us-ascii?Q?5r3ljzHjtlRYakElix7UYsWdfwwO5lfpAqKJJTQikhIawH/TeE4rjzRRJgWS?=
 =?us-ascii?Q?gcl0DdYn5PuoMPiPBzJJbSD9bulLvYOemer/FBVCDFwPlMUgMSt6aWXbpwlk?=
 =?us-ascii?Q?FsgMhp25w3SXq1rSvneeeO2NWPigZLdbMWbibS82bojolz7pdiuckI3Qg3nE?=
 =?us-ascii?Q?QvLIbOUldeqDAowXSHuurqlWrZTgzfPcY6qCEgWryZFFP3jkUcKdueaOpzwv?=
 =?us-ascii?Q?GYiNi2LHPMLE2rvXR9j7N+ZTCzGLfpq3C4ooh0Sv8lddW4q5PPD2KXxEj99A?=
 =?us-ascii?Q?iSz2QIIxIcLcJ6ksAZqGJw7HRq/gg1p3Cls07ett6+3V9Q9atxB9batjIiaH?=
 =?us-ascii?Q?MPc8ugDXh26Iuxo2S4ZZPrW2Np9LbjNe+LBdFVEOntvEF7D9WWwYZJx0SsPb?=
 =?us-ascii?Q?9E7VEDVMWi1SKFRFKWagaSORi20E/EeQxQ3RB60yMEUYgjaby/Gyeesb2dEy?=
 =?us-ascii?Q?AQacSN6To9rGXQVki4Y0KwYXyUxkjBIgIwqzueJw3FMzb8qk8RcSb9SUca1T?=
 =?us-ascii?Q?O0euFyY0k77VKqTLMgJAxRwGzs8gP08fHh+CS3f38JT2YhFx48sRuvx3yyA1?=
 =?us-ascii?Q?Y9CjkfHoW9EMIDIyD9HEmDQl9h1czae0mTSVW/hryM6i+wDPtG2maKwm2QuT?=
 =?us-ascii?Q?KO814TV/CKdRv+wOzOJcufJ2lxSs3FgBenPoOU65zf4/Zt3jPsDm4du72BXV?=
 =?us-ascii?Q?Ta+Z2w+JWpO3G5s2ndohLc5wfPzIdp46tsnw2x/74IlvjAJSeHNdPehwESWY?=
 =?us-ascii?Q?e5LcUI+K//vUW8dennbso001qrsQPRMQDAJHZSDwF59bqTXwBxrt2azbWzxE?=
 =?us-ascii?Q?IiXEhu00nrV+mbTwK+6aa5SSDWxooN68nRH7nMCGWW38r0bwfBJ3KDE8nDfe?=
 =?us-ascii?Q?CCJQyEwliDE8Zdsj0bDwx0ixf2rtkZSlLS3l0pg3Tn3Rj7sJ2G2Iz7h/XjzQ?=
 =?us-ascii?Q?XEzmLatKyPcodqhNdThXsQwq/x+8tx/UWA6nHa796SqZhPyuArylvgHD01Yt?=
 =?us-ascii?Q?MT2hVB2QfGuRBFzAYIvwbZjC+WBPGcngfcwUz5ftOYBQrDpJRlLiZjRvItds?=
 =?us-ascii?Q?I0kBs0o5MSmpibNCmOh+bTC4rr+t/rY8VHosrbcYdkxc54Izd/bBxXlAugf2?=
 =?us-ascii?Q?D/xNCqP+MMtkmB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/mgHYJ4qk1UjzdSpjvYkzOPjjyXgPsPOMLalNzW/XghCBqc9qEWsIf2H17/a?=
 =?us-ascii?Q?ngmISWs7dIUqYeuEuiVL1cxbt//Gy2Lhq+lTqzeRttZEYz2wNt8o0ZHsiaez?=
 =?us-ascii?Q?bWmQVraGf8eatwUm5Q55tLm3mgQ070ROt0vGBD7NL5Qz4l3oJkxiFwml8GHB?=
 =?us-ascii?Q?zOw/kv4zpr0Us5KouZwibdU49J3gpsLDeY5+pn94SUvnj5bRn8/RWBXxiNaa?=
 =?us-ascii?Q?+7wxE6H6AvbCQqsX17d6jHedHLg7HECyoHS+paJkoLK59/psDcwX20bQHT5W?=
 =?us-ascii?Q?uDAVDDaipMm4O6/5J8N94B4YDa1Ke+bxL3L7boNIvQQlOITcSapxBq8JaVJd?=
 =?us-ascii?Q?zqV73vjKDBkewfeO6pw1kdkDwr1Z7NAftfdk5FiORqOoRz+skZN7aUkkGtUk?=
 =?us-ascii?Q?eo0X0mJPZXYolIv76vZQupXW+Vd2KVEhM6v1TVLQ68oyM033U92018C6+wZ+?=
 =?us-ascii?Q?TNSiFMCGVPhLEEFfbfDOJ0qFHBvHDfFZjF4FwTPq3oxSMLBspf6o0bS0db1X?=
 =?us-ascii?Q?shrbkawadyOGzsb+wFtN2h+94frc3+zwwPFnUjX3NY7hrkZt5lfvMutLKG4Y?=
 =?us-ascii?Q?gLerKZlZS2GBjGj5BF7pCtKiIm4Ci5cJvw7hPzedHFwv9+ghhd0G4YVakXDM?=
 =?us-ascii?Q?osGh+H3GAn7yO15C4KNfIQYzxoUjhFMZDX7FJRcZpEHTNC1F644Ey2ciAmkf?=
 =?us-ascii?Q?6SeqZzwQ+D8HVCM+/MMWGZtMxcvktbFAikcAanMNekXaXMtFyFRAC4pK0MCf?=
 =?us-ascii?Q?wh4i/aLyQZ+8qucZ8ANpHznMtOGYWlxJhlExqrw1QfPtJvL+q/840ohFykKJ?=
 =?us-ascii?Q?Qouf+e18Dj+WbcmfWoWIXfRd3EsSYwVJv88MbSOdJ6U9qJBqozVhB79Nb3s1?=
 =?us-ascii?Q?fGfTtPIhVXChgQVqefvJuHkzc2Xn/o3eUxgOWxKBCPdLIvLEK62xD5vSwtJP?=
 =?us-ascii?Q?7C35lR//u2Zs+FUalWd30Gk0gJ3lCY0SCdbHjCwfaEAs+nINs18MO7gW1t/o?=
 =?us-ascii?Q?9za7+C4qT12DVONxBZ0CTXryfMzqeYInzN0r4C65pPKmUR+p7b8qE+s9YPli?=
 =?us-ascii?Q?iR6Id6K/oVlG4gYfw8w5cyp13LRW3rBv12kMITMJIF20FGVwp5lCX6K3QUIN?=
 =?us-ascii?Q?EFKdO90LnCsZYvBn2E/qknXJXXSOc0tUtgT0Z8bCkGVv8xk9i31lLoZQgopu?=
 =?us-ascii?Q?FX+E76dAR+SBHSLBd/UoTFerrZe3mx/g0VXmRulgcgcA6zg3Hw9gXsp/iII9?=
 =?us-ascii?Q?sn+/T4b+Chk0vUh3gclUf7P0/MEXGuWt4FjJUQzjFGObn34CDU7Myy4EGwzI?=
 =?us-ascii?Q?p+u/3exk7RXanCEreekeBbVKNGhqnyBtvt8stJlCMcaYkboZAm6aNamZLa66?=
 =?us-ascii?Q?6FrNlNzq7c9kLUUTK+6NRSYAs8LZBIsYL9cXIt8ljeJWMpuyEheiQr5lKcF2?=
 =?us-ascii?Q?BnRq7D94b5NcDK5wlMz7mpDZrEK7v8T/TnR3Ol+ZDB9LSgFW/+iZYiAWnGKq?=
 =?us-ascii?Q?zpHQGqHLZp6ZATt6JEOhOZXF0QI2dZY4UjVInEt4ikCMm3u+zvqlkJouDOP+?=
 =?us-ascii?Q?UFCkW/aWIOiyQyNxQLmua6A0VvVc6BODZsngSzWd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a48ff9-05b6-4c5b-37c2-08dd8c4e3a55
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 03:29:37.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hGbwdMDmTIb+eZ1lgB5tY+5fqhyWucJmWw7kh2O4P//Tn9Fuygps5pKuQc3MkyyH6wVOlM6vznmXM8tlwVnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9143

On Mon, May 05, 2025 at 12:48:47PM -0300, Hiago De Franco wrote:
>From: Hiago De Franco <hiago.franco@toradex.com>
>
>For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
>before Linux starts (e.g., by the bootloader) and it is being managed by
>the SCU, the SCFW will not allow the kernel to enable the clock again.
>This currently causes an SCU fault reset when the M-core is up and
>running and the kernel boots, resetting the system.
>
>Therefore, add a check in the clock enable function to not execute it if
>the M-core is being managed by the SCU.
>
>This change affects only the i.MX8X and i.MX8 family SoCs, as this is
>under the IMX_RPROC_SCU_API method.

I would rewrite as below: "

For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
by the bootloader, M-core and Linux are in same SCFW(System Controller
Firmware) partition, so linux has permission to control M-core.

But when M-core is started, the SCFW will automatically enable the clock
and configure the rate, and any users that wanna to enable the clock
will get error 'LOCKED' from SCFW. So current imx_rproc.c probe function
gets failure because clk_prepare_enable returns failure. Then
the power domain of M-core is powered off when M-core is still running,
SCU(System Controller Unit) will get a fault reset, and system restarts.

To address the issue, ignore handling the clk for i.MX8X and i.MX8 M-core,
because SCFW automatically enables and configures the clock.
"

You may update if you wanna.

>
>Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>Suggested-by: Peng Fan <peng.fan@oss.nxp.com>

-> peng.fan@nxp.com

Thanks,
Peng

>---
> drivers/remoteproc/imx_rproc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
>index 74299af1d7f1..627e57a88db2 100644
>--- a/drivers/remoteproc/imx_rproc.c
>+++ b/drivers/remoteproc/imx_rproc.c
>@@ -1029,8 +1029,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
> 	struct device *dev = priv->dev;
> 	int ret;
> 
>-	/* Remote core is not under control of Linux */
>-	if (dcfg->method == IMX_RPROC_NONE)
>+	/* Remote core is not under control of Linux or it is managed by SCU API */
>+	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
> 		return 0;
> 
> 	priv->clk = devm_clk_get(dev, NULL);
>-- 
>2.39.5
>

