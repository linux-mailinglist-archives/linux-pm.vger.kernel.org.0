Return-Path: <linux-pm+bounces-27070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE74AB4C04
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F66D17C786
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC71E5B8B;
	Tue, 13 May 2025 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fn8YmTWN"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D389DF49;
	Tue, 13 May 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118065; cv=fail; b=Hhn7DRuH67pyIkqTzgIKh2H8cGubwH5rDc0/JUwC8VDkZsYtkalbRqwY941wYyh6Bf7jjvcXzhwDRi4fobgPn00JJriS199dfG8agED8yhWQTMrYqd/8wHUcnFBnh6VfnxGiLG8o8T6w98JCyJ+CFb4gddFOaa+G7iIOYLVZLo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118065; c=relaxed/simple;
	bh=JDWfZQFSbueVzMxvKSgwBjZOS1o10Lb0ywJOcTicjXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ivho2lUAWrYT2cOLQ9TxPC9yUfEsxrMVxLsN5P9r3uFINNckfqETlfeUiBVkBOTM2gHe7iL+ZzXiODR0hQq+nuE6cIqr6dzQpRrn3cK57E/8bwYKkCRpQGGc4UrJMd+QJCL/A9HLdo+3Ksj3XWRq4UkaO9jlF7OMSzEDhyQrybw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Fn8YmTWN; arc=fail smtp.client-ip=40.107.247.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9IWNQL/Yr3+OMYZtDCPBmLQCA2Lkzquozk/ifNNwyfTt7yDFaZNP0aXd7dEHgIFCCaPXORFUPJj4VLE16Cu5E7eImT38g4DCL44FqBpIsKJ/2wzpGxDRVLmEIx/IVlX7FZz5TDnnF9proR9Nvm4i4/XfPE+9qqrMdOOtUdzfBLEBPniI6g0rh+SEvHG50Tz3X+82hiK5oRN200YJxE0ueUaSPEbfwBqN6O1lQ2iqbwUPeZa9HcUAhzoVsbJuSrgxSS1uo+UY3lJ8XjDeRVRhulwVpDX5nJEyFLEUjI4ccoKYMaL4KmcWm58mvJsrP8ZMPldK/2McU0N6qT1bWUexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKX+pxfzKL99dE22MOiQGp7IW094pkR8ChIKTSO0mCw=;
 b=CmX1A9sW9PrV/YJZ/Kw+H3sEOQXrd0zpSN2iKIRwMwbYovfI9wRol1Lu8iWA0lBfw5R0eisqseg//9gM6iWj6qpvFLO+OguEqch3+ibxmsCyCMWyGE9bFYHkcuZwQ73LdmkpVBKLVF7vXLUBZHWUbMbpk4zhGuUakQzdORhjdANPzaFbiOGMmX7zbtbb6VxkjSmyr0qhlUKIIg0u1OwMNONcYTHLeYbIOZ3NLXM0kyhe2DoRQKM2JUvwmV50a+RAhYgbq4ASoJi0WNtHPmzBX3xaJavsmilPNdMH0wtob+g0c5HTAYaO8BGuRYQwgCPT4acUoj36/m9eVEXayxiu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKX+pxfzKL99dE22MOiQGp7IW094pkR8ChIKTSO0mCw=;
 b=Fn8YmTWNLHErUmc6XPMYB6FLqD56iSf22CL5V82+VY73fe7hVYZfLCAOUG3NvHwBno5RJ1iHI6O01pTbDw5tN9j3/HdsKmavs6+MsQ30lb5tA03ANoJIGZ3bcnLEjZXQZDKcU7k0BTqxu0QC/Yz0QjsT+xxfrzdYLc4BAlTkKKP5TewpudC37q3shec97c5fRB54UKbpWAUNZZU8lSS7qVAeQzYTa5K9P7bDNa1hZ3bP9nbO2mkEqk/Ac8zTEyQlcCrY1wTOGN2cAOE45zXUh6ocqLZ3aDpuMxOcTt0TJR95PeyCBRduUfmxd//QKgH9p55YJSHeKc2C05cDFFK9sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10887.eurprd04.prod.outlook.com (2603:10a6:10:592::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 06:34:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:34:19 +0000
Date: Tue, 13 May 2025 15:43:37 +0800
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
Subject: Re: [PATCH v2 1/3] firmware: imx: move get power mode function from
 scu-pd.c to misc.c
Message-ID: <20250513073822.GA14572@nxa18884-linux>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-2-hiagofranco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507160056.11876-2-hiagofranco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10887:EE_
X-MS-Office365-Filtering-Correlation-Id: 974c2206-8016-470c-62b9-08dd91e82fc1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fz4Mm+38HwIvHWN36cNktIJu3D/YjligWKYD9WQdxb4vODFPAhgAipOlxs10?=
 =?us-ascii?Q?BReFEYsXMAHZlafYWejTLO62m7/yKw8AMzYJWC+LnvdT0c2AjSf809wpr6fY?=
 =?us-ascii?Q?4nKeQQkSHKQ1coLtiC2wa7tAcIBMad5KvqoMwtYLWPFS21/ZPgPaGy7o5ZyT?=
 =?us-ascii?Q?3wpwfsYUfgsmiPjexbV6JfCKDKe+W/Fz8ALS0bEEq4U30FK3/+bUeIWUyaAh?=
 =?us-ascii?Q?f8jiIYOnmXySZQZGcA0MbbQhdcZlZwJSEYM7PY/qPXlY9y3YKxIRKvz0Z4Jz?=
 =?us-ascii?Q?tHnx91lzDDA61wick5cEWSKOrX+7q7qhAOK2XbFs/tNt+/TyDX81LgqMy6tC?=
 =?us-ascii?Q?aqRT739z+8CckrFZbqE5podBkVpYvDFu9vHItYDhPyWefSRDAOAhnDgf5LdI?=
 =?us-ascii?Q?TGLKHL4upoNWbQux7KuHtmkeWOEOmDL7TxlD+T6Q2pjQW17YvzdD5BkALCqk?=
 =?us-ascii?Q?2cxGvIO7/MRKN2Cb+E59g6P1d1sTG2AKyFsL2biSs+Y6lK1J6OoSUON5tkxr?=
 =?us-ascii?Q?XpPwzOZ5ZvYwg0FK1nXm5z6KDW3z/9OZo56ZkeP1H77RLyBof1OfeHGUQNnB?=
 =?us-ascii?Q?DlSwH1XSGgQ93TrFABDlebBD7PX8vR+W/atP/JegLfQVVrIsB+TcWeTf4a/w?=
 =?us-ascii?Q?8nZGjGvXzKDyGZnzWC0zKid0WooF/eltQk8Po3FdHOpw09K5ZJrsAZfFNE4H?=
 =?us-ascii?Q?2OLGmX0MuBIhWS3Yp5pu6KdM2rjIy4/RixUHFY2V6jSnGmGnzMo3ojgSBc6j?=
 =?us-ascii?Q?P9wErgqlMDd2FTm6SgiO3qbfL3+kR48UnNym8CHOGjDemKu0qyjxNBhRMbt8?=
 =?us-ascii?Q?ahoxcmeDKLoW1Y8hoIIV3LSvyDjT5hYf9TlQrw4+fyiGjsRhAC6g2/HoIEZF?=
 =?us-ascii?Q?at/UclxA6X0n6HclMN71UhJTqk5eW3CSE6Psn5XBWVGvoyjv8eD7eHLgq86z?=
 =?us-ascii?Q?yeyJEVAF4ccGM80/OIEQ1ax+shAVKZAQ+NVMCzHN8cnYuDSkub28+lcyj0k8?=
 =?us-ascii?Q?k62ifAf08lC4QMSm3jBc3AIJjR3VKIdfhFrbPbDF6zP8S3whgL5RcPtFNnC8?=
 =?us-ascii?Q?TvkDtEKvqt127Mpb2wJrsi/10nO0UyvvujvjEGauf62I4ZDoUrfkUdWqcUv5?=
 =?us-ascii?Q?fN2g67PED5VK7Wb0gN3cor3f6zeuq1ypo/2hPcBVjp0O6eXE/zUZ5L7FSB03?=
 =?us-ascii?Q?Mhhqq8P86ecmilwpan9Xy0oFDjfxgDNCq4ZJS6iTA6l5lQ+NXlCSoU0hFdCU?=
 =?us-ascii?Q?iB0b1oSLJaJJIiK/sFPaDfN8/sFN4pzXd2Sj68fHR4DZwKm/Ed7S3+enbffY?=
 =?us-ascii?Q?AP0JPEs0XBCFt5kCfG0ynNIivR+B2/0O550T+I4QlfdI2HOPDQaKXI8u4e7W?=
 =?us-ascii?Q?Reg9EAZjLuGxy6O7AHL1SAqsOXPcPgnb9Cx3Wxe7crf7DtvNj1earqPB5axH?=
 =?us-ascii?Q?YTKCpcqb3ZlrizVe5OJuTsLgBzyyLQXuT3HKPK1VUbXpqw3uQkUeLgVsqey4?=
 =?us-ascii?Q?W/uTehziq08vNP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5f/48eTIzfsdvGGgZK2dBshRXNSQ9QmfqmYq9g9i+F3PT4iAZ/NtoaevfBl+?=
 =?us-ascii?Q?vcwcNa7QWm7YjNyaHr4HX02ixCu6wCs9j02WfuA5ws2bs9k6tA+N7fyGh4Z8?=
 =?us-ascii?Q?AMaiU0xp7n94LDR4Ve+yc9FvD73B5nuj/NAZ2JjJTR5hsqI7gTqFJuaTFqOq?=
 =?us-ascii?Q?TL6luJ0My1UKBhjhacR2OqrrGx/IwS00L9UPZMFiFWqFTz6bUTTim30d7AG+?=
 =?us-ascii?Q?LkFg66BvajXmYRn3jrQA+6REr9sL02fXBfOiWx13KiSqhXh1b+vwUQ+2IkiX?=
 =?us-ascii?Q?pTXeGwgcz1r/lyffWOJEAlgG1ZJNCyV/hVXIWsCe/UoOSeRBMzrByho3bwEU?=
 =?us-ascii?Q?Bf0p/o5qc2nYsUPdBx9wJBoEAsxdvlWnYi5WNxAOFHnui/dFLsD5hJ1IGuEH?=
 =?us-ascii?Q?G4WZUSrsTYwFwSWE9le+Zp9JurNGaIWC6RG/3giJNUd9EPjcrnaBhaHPHO5/?=
 =?us-ascii?Q?KpCT11Bm3Tri6UkODo0XLdZ7GpHdi7PbUgjCozn328LYkVgtpVEnTOikpshU?=
 =?us-ascii?Q?cF1ThtNBh9kK2+DIJJ3Kv6op2a8o5I8HiEIKlxkpkiituiL1v1UMOBOQVw7E?=
 =?us-ascii?Q?TUep83dRbsSOfv1uoogyHefu6OnCjR9ZlLpSVLKyKhi34x5hrdfhYcnSrOcb?=
 =?us-ascii?Q?PWtFkPi0NfgNttFzW7rSYx6s/dx9v5yz28Gsema1ks829uDx/c1JXBPPluYX?=
 =?us-ascii?Q?Ly4WaaFAEElNgH7KfAH7hJkfa5YrzYNoiyyGQ7lRYtErCCE8Upp1ozMEtnbK?=
 =?us-ascii?Q?wcZeGHocctliqZ5TYyCIQJLmYuYQXrJAZ7JjiZBJoMbbTLO9fBfoXMdQLBME?=
 =?us-ascii?Q?5vZ0fBc5iUZM+Fnl565CejsFZd0O7gE4KxCLEFzYeSRFH2M7vZMorfeiYBZV?=
 =?us-ascii?Q?VW+IEXcYEDfASF7t6L7HAwJjtIHscy/XuY3WMCF6L0J6SbSMYBZEBAhlUfbT?=
 =?us-ascii?Q?dHQuRw475cQMIObfM7c76zBBS7pJSFXATmaQMGV3uyWQbCmnECSm3dVtRKO6?=
 =?us-ascii?Q?9w95smRtZneRC0HL2U+L0cebQZtvJgmjb0fXx9YaXnBEXQAKcuPmX+GNcVY9?=
 =?us-ascii?Q?h4mFhLRb0ZKpo0K46hg1KY/mGAET8o3ScIUerQSdDybliLjCXWSXR2iD53kM?=
 =?us-ascii?Q?PDL3g3TJdeuIic2bFdK992SMh61mt/6yxpRZR86up42i4kK6S03DtQPFym0Q?=
 =?us-ascii?Q?/kIsBcqwm9Su8sL0XPMPPyVjefPxTjE9BrqdPyZJwSBYx8F+y2Dns53hPhM2?=
 =?us-ascii?Q?yFg1SprAc4Lnlj4PkHLZpWgJXjXlSvc4qdziy2XNynGMdAI8344iywZJwALL?=
 =?us-ascii?Q?TvIlpUmh1OI4Ogf6ktsFh5+ZCdX7EexlNNXtUpxvk+vIp/LqAJmQibms0hyR?=
 =?us-ascii?Q?/MSNWd+Gxvu4O/hGSdB/OsG+u0MvPIU2FnKbDt7ND2+2agmmJutuO0RWksuu?=
 =?us-ascii?Q?FDwO7A3Ucp5WlMawd/H7mxdOLHmwRnbnoduq6WoWngh02/HNOXEMkQMSp9wv?=
 =?us-ascii?Q?uPhye97BVACf3y/XmFvQb1pcBtUB+LiERiSErT7kaSGBFNA1w5CtVw7g3yn0?=
 =?us-ascii?Q?69iJj/jVi49qhQCkGUf9C1acjQoNRJHbG8eLd43Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974c2206-8016-470c-62b9-08dd91e82fc1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:34:19.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmkJG/Y1qB3lLcg/my/PsnBPEXcN4Pz4Kw9vQg87tCRjXB7z4/FvxOI47bZhA6H5M+hp9VMM2lqetditJ/4UoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10887

Hi Hiago,

On Wed, May 07, 2025 at 01:00:54PM -0300, Hiago De Franco wrote:
>From: Hiago De Franco <hiago.franco@toradex.com>
>
>Move imx_sc_get_pd_power() from pmdomain/imx/scu-pd.c to
>firmware/imx/misc.c and rename it to imx_sc_pm_get_resource_power_mode()
>to maintain the same naming logic with other functions in misc.c.
>
>This makes the API available for other use cases. For example,
>remoteproc/imx_rproc.c can now use this function to check the power mode
>of the remote core.
>
>Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>---
>v2: moved this patch to be the first one
>---
> drivers/firmware/imx/misc.c           | 47 +++++++++++++++++++++++++++
> drivers/pmdomain/imx/scu-pd.c         | 29 ++++-------------
> include/linux/firmware/imx/svc/misc.h |  8 +++++
> 3 files changed, 62 insertions(+), 22 deletions(-)
>
>diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
>index d073cb3ce699..61fcb0066ec9 100644
>--- a/drivers/firmware/imx/misc.c
>+++ b/drivers/firmware/imx/misc.c
>@@ -37,6 +37,18 @@ struct imx_sc_msg_resp_misc_get_ctrl {
> 	u32 val;
> } __packed __aligned(4);
> 
>+struct imx_sc_msg_req_get_resource_power_mode {
>+	struct imx_sc_rpc_msg hdr;
>+	union {
>+		struct {
>+			u16 resource;
>+		} req;
>+		struct {
>+			u8 mode;
>+		} resp;
>+	} data;
>+} __packed __aligned(4);
>+
> /*
>  * This function sets a miscellaneous control value.
>  *
>@@ -135,3 +147,38 @@ int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> 	return imx_scu_call_rpc(ipc, &msg, true);
> }
> EXPORT_SYMBOL(imx_sc_pm_cpu_start);
>+
>+/*
>+ * This function gets the power mode from a given @resource
>+ *
>+ * @param[in]     ipc         IPC handle
>+ * @param[in]     resource    resource to check the power mode
>+ *
>+ * @return Returns < 0 for errors or the following for success:
>+ * IMX_SC_PM_PW_MODE_OFF  0	Power off
>+ * IMX_SC_PM_PW_MODE_STBY 1	Power in standby
>+ * IMX_SC_PM_PW_MODE_LP   2	Power in low-power
>+ * IMX_SC_PM_PW_MODE_ON   3	Power on
>+ *
>+ * These are defined under firmware/imx/svc/pm.h
>+ */
>+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource)
>+{
>+	struct imx_sc_msg_req_get_resource_power_mode msg;
>+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
>+	int ret;
>+
>+	hdr->ver = IMX_SC_RPC_VERSION;
>+	hdr->svc = IMX_SC_RPC_SVC_PM;
>+	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
>+	hdr->size = 2;
>+
>+	msg.data.req.resource = resource;
>+
>+	ret = imx_scu_call_rpc(ipc, &msg, true);
>+	if (ret)
>+		return ret;
>+
>+	return msg.data.resp.mode;
>+}
>+EXPORT_SYMBOL(imx_sc_pm_get_resource_power_mode);
>diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
>index 01d465d88f60..945f972e636f 100644
>--- a/drivers/pmdomain/imx/scu-pd.c
>+++ b/drivers/pmdomain/imx/scu-pd.c
>@@ -54,6 +54,7 @@
> #include <dt-bindings/firmware/imx/rsrc.h>
> #include <linux/console.h>
> #include <linux/firmware/imx/sci.h>
>+#include <linux/firmware/imx/svc/misc.h>
> #include <linux/firmware/imx/svc/rm.h>
> #include <linux/io.h>
> #include <linux/module.h>
>@@ -328,27 +329,6 @@ static void imx_sc_pd_get_console_rsrc(void)
> 	imx_con_rsrc = specs.args[0];
> }
> 
>-static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
>-{
>-	struct imx_sc_msg_req_get_resource_power_mode msg;
>-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
>-	int ret;
>-
>-	hdr->ver = IMX_SC_RPC_VERSION;
>-	hdr->svc = IMX_SC_RPC_SVC_PM;
>-	hdr->func = IMX_SC_PM_FUNC_GET_RESOURCE_POWER_MODE;
>-	hdr->size = 2;
>-
>-	msg.data.req.resource = rsrc;
>-
>-	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
>-	if (ret)
>-		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>-			rsrc, ret);
>-
>-	return msg.data.resp.mode;
>-}
>-
> static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
> {
> 	struct imx_sc_msg_req_set_resource_power_mode msg;
>@@ -438,7 +418,12 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
> 	if (imx_con_rsrc == sc_pd->rsrc)
> 		sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
> 
>-	mode = imx_sc_get_pd_power(dev, pd_ranges->rsrc + idx);
>+	mode = imx_sc_pm_get_resource_power_mode(pm_ipc_handle,

I mean, not change scu-pd.c in this patchset. After
imx_sc_pm_get_resource_power_mode landed, you could update scu-pd.c.

Otherwise you are touch three trees which are a bit hard to manage for
maintainers:
scu-pd.c under linux-pm tree
misc.c under linux-imx tree, I think using power.c should be better.
imx_rproc.c under linux-remoteproc tree

My suggestion was that
patch 1: firmware: imx: Introduce imx_sc_pm_get_resource_power_mode
patch 2: remoteproc: imx_rproc: Detecting power mode of M4 for i.MX8QX
Patch 3: pmdomain: scu-pd: migrate to use imx common pm API

Patch 3 could be separate out in future patchset to avoid handling three trees.

Regards,
Peng
>+						 pd_ranges->rsrc + idx);
>+	if (mode < 0)
>+		dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>+			pd_ranges->rsrc + idx, mode);
>+
> 	if (mode == IMX_SC_PM_PW_MODE_ON)
> 		is_off = false;
> 	else
>diff --git a/include/linux/firmware/imx/svc/misc.h b/include/linux/firmware/imx/svc/misc.h
>index 760db08a67fc..376c800a88d0 100644
>--- a/include/linux/firmware/imx/svc/misc.h
>+++ b/include/linux/firmware/imx/svc/misc.h
>@@ -55,6 +55,8 @@ int imx_sc_misc_get_control(struct imx_sc_ipc *ipc, u32 resource,
> 
> int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> 			bool enable, u64 phys_addr);
>+
>+int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc, u32 resource);
> #else
> static inline int imx_sc_misc_set_control(struct imx_sc_ipc *ipc,
> 					  u32 resource, u8 ctrl, u32 val)
>@@ -73,5 +75,11 @@ static inline int imx_sc_pm_cpu_start(struct imx_sc_ipc *ipc, u32 resource,
> {
> 	return -ENOTSUPP;
> }
>+
>+static inline int imx_sc_pm_get_resource_power_mode(struct imx_sc_ipc *ipc,
>+						    u32 resource)
>+{
>+	return -ENOTSUPP;
>+}
> #endif
> #endif /* _SC_MISC_API_H */
>-- 
>2.39.5
>

