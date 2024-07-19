Return-Path: <linux-pm+bounces-11242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E449371FE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 03:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB61B1C20E02
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967571392;
	Fri, 19 Jul 2024 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FL91u/hP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2108.outbound.protection.outlook.com [40.92.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7D184D;
	Fri, 19 Jul 2024 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352439; cv=fail; b=syUS/lyMkgXvNUUX+rD7AZ2YYoLSgmXabRVtIb5VKlSVUXfvp1fXg7xYMTQot/+z69LUifkdJh/p/H6s7A67NQ92n0s7SYV1VlN594RCj/1IdxRAJJpQUAreK1+Oci6BonJC77GZX1qy6d3/9zCGsgYNV39UDo/B9FolggbPNj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352439; c=relaxed/simple;
	bh=eyXUAN2dgwhaAMuV89bSVDjk8Ee03TWxlUpvlAFNxAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nefLu5Cyqncy/CJDOfuTjrmLgS4EAV1VCpuh8NgYuLAPIC/2uxfwVYYdlhT9mqlI3J5X9+q8C6Blbu5XNk69R3S8Z25cxVgboXj3JtnGS/mVW+dASgUYJue5ReARNIZkkOleq7qC4bi7VwMxTuwJz79oouWj0gIrRQmGus2LRwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FL91u/hP; arc=fail smtp.client-ip=40.92.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djW4gRpRJvId3bkgS+lf3KCNB4PYnAQwWQDA/XTqy11uSD0NbGLrZsP3rJ2Ps+iUsYXtxEyRKL3FTniKccbUJd2it2iHaNQVwd8UaU9Xsrs8szRCzKu7Mbmahgb+LzKarr/Y4FFgFlG2094Z4/IRqYqaZBjiHP1WnwPmf8mW+x4bd97VjLAyHTMpARhzprwJRdZ6ytClcCP7UPEjLk2XXffMVrY29XZExQWVmnGJzwQLtfYLZSIXOEyDnJbqMLsTc8uP2xheQNS/TdMK+vFHvugUTJuv0CktErN50eEsErsJC60TxEnLuCFf+LxIwRdsZV+mekYXUWi/KTpBvkbjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G20LkvR30Q5T7iRgbwJFtst7KOVKYN1iuwpAHrJ+W94=;
 b=jslcGqNjlW2jF6dJZBPPOdqnk715L2Sq57oFU7MNSKacBZmOm1WV+dcCtN3nTbEA4TT5QSYvNHL5ODxR1Hp6HBakjr4p9hUuxf9pEbfQVMRkr+9J8WInvGbq1KwyXpNAd8qNPIiNm0nAoZLZDk0TkXV30/0DhvZZgeUS95uMAkYsYD/1VyFQi1hE33rWzqhvoaVY3Iiyh8lRoIWZNeoTQplDKeDA/9khB280IjBSPrqRqzdg9PxXgA1wAW8aS6fPFZAojPHpRYGKTYjht0zn6W4xo1RRGQLjYYuI9Ta80iuqj0Zzp1kOyAxvgxLSKya3b3eIXXc0BZfhK/bcX/Tw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G20LkvR30Q5T7iRgbwJFtst7KOVKYN1iuwpAHrJ+W94=;
 b=FL91u/hP5hKRFUZ/gTcgItPMMMDc/rwkI41fqTn44xxi5mgV/r1cm8/t/X2xxQIFO7emNrEEBHxYL8NZY0iE/9fGOpTDtYtp3xSTtJVdTyaQamLMmDr+9a35HDChzxmSyKttWSXsPOSGXThK77pEHvoc0eepJjOck+wxqDLtlJTd4tfZ4HzKij0KPI6ylrLjskL+V5j/RGBmxNgd20TQC6amytACIP6wXJu29xI7PGIOR8txp6gJZwffIfD3pONEICZhl3iSVVSf2OXOLOPBTwBGZauuHvvJZtjPMLRJj11l2WnEtWMST2RwMpEx6SjAu+ykeeGunByD44lwMfGeBw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB7071.namprd20.prod.outlook.com (2603:10b6:510:2fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 01:27:14 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 01:27:13 +0000
Date: Fri, 19 Jul 2024 09:26:57 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Haylen Chu <heylenay@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <IA1PR20MB4953D7CE439F97E4982830B5BBAD2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <PH7PR20MB4962DD8526FF0845258ECE2FBBA32@PH7PR20MB4962.namprd20.prod.outlook.com>
 <SEYPR01MB4221611E6BB87C70B30999E5D7AC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR01MB4221611E6BB87C70B30999E5D7AC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-TMN: [fyPZjtLdMCUGccx0mbswvgoMym9vo2JqrAFPPdog+6Y=]
X-ClientProxiedBy: PS1PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::36) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <fw2wqjl3hjb35tjm7uewooxocqrzda5puxns5p6ukhliyx7frl@rwkgx4l2nx6d>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9bf29b-81e5-465a-5acb-08dca791eb27
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	bVwIomt8z09JA35WlN17vpNNZsizW9uhV+zLzbeSJBXYGNI/qTvBNrNH3eAbVcF2oyxQF9FhF5tAIE85vTVxDaCKGLPGPCEMyBEMihHUGzKrLylNbA3hfwOEBGWZWRvgH28VOpv1EeUm/sK2u30BonMSs0WHS7LZA3U2g5X2lFX7nqqM0vn4UQp8p6D3WWlD+fox9XF3GYXszsszWfY04mbxiUlXQOw7WjQlGbCsRbR2rARq30m6IxEXeGwxUQWHLIvu9DD9zmY2/7LeJnPXocIuidR72HdyaK7Ir6sILnchHIvHNqDFmzPkZvaYvuIWsX9SQETVRJGal9RXhzz5jDDiObUk8TLyWeS5j6D1FjyqffcsGviQ9tN6uy5DxqghZkqp8Qhgi+C2WsKUUKrF4pPPAG+Tb+ebA2jueJq+fJPR9UYvR76roiTIjHC4P/zZhxmD7/MIvsbWUFBoV2vQoHFGbnk+EypAgfurjC20CE0fPM/U6rGt5X+nUI3TY+Td2pyG1EvKDvXqs86ovVjZk1Lyl9YC5bM9/SwrNkW6sa4rT6wc4KCTya3vhfmy/WQhS6YDZ4Wz3XFsa49GjjyxYa3sk2xCThQGw/SlwFg3PKa01Oww56SUOZ9WnxJb4d/Yxtw/L23ClJv58+EZQL0qaFiZ6LPWytY66nObfW0HfCdClGIpjfRkAFPrXzJl9DxI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sj0O8C+YzrqrIkZC8olPe5OWt8bUN5H2dlwqogs0hur3qTaNGBdcdhBJCi8r?=
 =?us-ascii?Q?dP2sYO2LrUEC/huHyAf8VA3FjMKEDakdlIgxsymoTu1RzQD2Pn1pfBeznXKd?=
 =?us-ascii?Q?WxSvEfNpwSUCbn4C66jlGxZt9iwNrgyMLfmaT+B2B6Y3n0RX1N4Ceu5Ju87j?=
 =?us-ascii?Q?Kc3Uix/WZdYfohqiccnC/zDgyPN4lLOFRLze41l7KvkvmT74Fn+qhcOlJYG1?=
 =?us-ascii?Q?5Pc9ckBzr6NaCCZ3WnE0PetC3UfClt8mifDbfPsOzvyhHq0OKz+ifTCPBVRA?=
 =?us-ascii?Q?RlgvQExoDgu6Gq0Qbd+CcQ1QYGcZiS50Rg5GyY0Dr2GJTEzx7AXJXp5M7hCA?=
 =?us-ascii?Q?NlocCjE5I0u2/GKBxgo8/4cQxrh1Fv0JPEYqW4qu8fwxKSRq7UPgzwHQkONm?=
 =?us-ascii?Q?jGc8FsSHGdAnyH+ERrz684d+FnPVNn+jeL/WyeNhk8oj+AHZV1un4d57FFVL?=
 =?us-ascii?Q?jHTBvHOeLTy+Dx1K18pkWwIIePBWq/vyAxYnlEehWBPxHDHyCdBrLw9Vj6Ei?=
 =?us-ascii?Q?3DTcEDXYudk64k5k83cWmfwbEQGxvJLNF8dVh93EcWTCMJxkbuZsRCOg85UO?=
 =?us-ascii?Q?FF6PNWg/6Xak1t5YwrTkDgaAV8WDgdBQ4GK7iDjhNW6Ez7LKxmlXNP3vvh+I?=
 =?us-ascii?Q?HmTF5FYS2TxwblbPXYlN8qe2Xw+ngB4NnvjAJJ4Pb0Udyt4kyZoqM2L846XE?=
 =?us-ascii?Q?rE1gZ8lWO8ryljPMDtPrBHX3A7+Diezu5IBbwovhejZNKGBx65krUWhef8gH?=
 =?us-ascii?Q?u8unIu2WmMQzj4onNcelfJ4UvSdEPI2nnEQ8nIXUmGYJCy9zbrJycGwn/vwd?=
 =?us-ascii?Q?5vhhl0cMh8xdSihXcbxELYFng4+yMwv2HhnAMMIbGp/fE+Mo3wH8pyszHtzv?=
 =?us-ascii?Q?tfu/Wi92Xcf2ppv0EL6KuoFOSHqYcI3CNmKAZQDomBjY2J/zHjOVG6FgWxMb?=
 =?us-ascii?Q?zSeJSDa+dqTwgjbDomuI2Y2hQ1InDUXzuaONUoHOaeVDFcQH2IiYKZVTluzr?=
 =?us-ascii?Q?0rtdXYUcEXy2z5nBcrjCQcX+rTQRKjwkdEMz+O9xwAlG1iYpeaeqf7g0Qghd?=
 =?us-ascii?Q?qknfn3dFOMfbqAkWQAR9/BJOnXDFDAhnE6oXRRyug2bOcV8hz+LJ9gJCcXJN?=
 =?us-ascii?Q?3/xWCb6rLmStOFC+fB/L8W56inoiOdNV9joCXSzT9FyODh8bhpyPSR/Dn//j?=
 =?us-ascii?Q?fZHCG3/v4d4fovBQz3+tBA+7qZzRNjX6GMLnoJqp5YGAYDJky474GlRKFhvY?=
 =?us-ascii?Q?xrtdJ5w9N8yRERR2TsKI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9bf29b-81e5-465a-5acb-08dca791eb27
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:27:13.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB7071

On Thu, Jul 18, 2024 at 06:49:05AM GMT, Haylen Chu wrote:
> On Wed, Jul 17, 2024 at 02:22:32PM +0800, Inochi Amaoto wrote:
> > On Tue, Jul 16, 2024 at 09:42:35AM GMT, Haylen Chu wrote:
> > > Add support for cv180x SoCs integrated thermal sensors.
> > > 
> > > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > > ---
> > >  drivers/thermal/Kconfig          |   6 +
> > >  drivers/thermal/Makefile         |   1 +
> > >  drivers/thermal/cv180x_thermal.c | 241 +++++++++++++++++++++++++++++++
> > >  3 files changed, 248 insertions(+)
> > >  create mode 100644 drivers/thermal/cv180x_thermal.c
> > > 
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 204ed89a3ec9..f53c973a361d 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -514,4 +514,10 @@ config LOONGSON2_THERMAL
> > >  	  is higher than the high temperature threshold or lower than the low
> > >  	  temperature threshold, the interrupt will occur.
> > >  
> > > +config CV180X_THERMAL
> > > +	tristate "Temperature sensor driver for Sophgo CV180X"
> > > +	help
> > > +	  If you say yes here you get support for thermal sensor integrated in
> > > +	  Sophgo CV180X SoCs.
> > > +
> > >  endif
> > > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > > index 5cdf7d68687f..5b59bde8a579 100644
> > > --- a/drivers/thermal/Makefile
> > > +++ b/drivers/thermal/Makefile
> > > @@ -65,3 +65,4 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> > >  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
> > >  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> > >  obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> > > +obj-$(CONFIG_CV180X_THERMAL)	+= cv180x_thermal.o
> > > diff --git a/drivers/thermal/cv180x_thermal.c b/drivers/thermal/cv180x_thermal.c
> > > new file mode 100644
> > > index 000000000000..8b726c0ad848
> > > --- /dev/null
> > > +++ b/drivers/thermal/cv180x_thermal.c
> > > @@ -0,0 +1,241 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2021 Sophgo Inc.
> > > + * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
> > > + */
> > > +
> > > +#include <linux/bits.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/thermal.h>
> > > +
> > > +#define TEMPSEN_VERSION					0x0
> > > +#define TEMPSEN_CTRL					0x4
> > > +#define  TEMPSEN_CTRL_EN				BIT(0)
> > > +#define  TEMPSEN_CTRL_SEL_MASK				GENMASK(7, 4)
> > > +#define  TEMPSEN_CTRL_SEL_OFFSET			4
> > > +#define TEMPSEN_STATUS					0x8
> > > +#define TEMPSEN_SET					0xc
> > > +#define  TEMPSEN_SET_CHOPSEL_MASK			GENMASK(5, 4)
> > > +#define  TEMPSEN_SET_CHOPSEL_OFFSET			4
> > > +#define  TEMPSEN_SET_CHOPSEL_128T			0
> > > +#define  TEMPSEN_SET_CHOPSEL_256T			1
> > > +#define  TEMPSEN_SET_CHOPSEL_512T			2
> > > +#define  TEMPSEN_SET_CHOPSEL_1024T			3
> > > +#define  TEMPSEN_SET_ACCSEL_MASK			GENMASK(7, 6)
> > > +#define  TEMPSEN_SET_ACCSEL_OFFSET			6
> > > +#define  TEMPSEN_SET_ACCSEL_512T			0
> > > +#define  TEMPSEN_SET_ACCSEL_1024T			1
> > > +#define  TEMPSEN_SET_ACCSEL_2048T			2
> > > +#define  TEMPSEN_SET_ACCSEL_4096T			3
> > > +#define  TEMPSEN_SET_CYC_CLKDIV_MASK			GENMASK(15, 8)
> > > +#define  TEMPSEN_SET_CYC_CLKDIV_OFFSET			8
> > > +#define TEMPSEN_INTR_EN					0x10
> > > +#define TEMPSEN_INTR_CLR				0x14
> > > +#define TEMPSEN_INTR_STA				0x18
> > > +#define TEMPSEN_INTR_RAW				0x1c
> > > +#define TEMPSEN_RESULT(n)				(0x20 + (n) * 4)
> > > +#define  TEMPSEN_RESULT_RESULT_MASK			GENMASK(12, 0)
> > > +#define  TEMPSEN_RESULT_MAX_RESULT_MASK			GENMASK(28, 16)
> > > +#define  TEMPSEN_RESULT_CLR_MAX_RESULT			BIT(31)
> > > +#define TEMPSEN_AUTO_PERIOD				0x64
> > > +#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK		GENMASK(23, 0)
> > > +#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET		0
> > > +
> > > +struct cv180x_thermal_zone {
> > > +	struct device *dev;
> > > +	void __iomem *base;
> > > +	struct clk *clk_tempsen;
> > > +	u32 sample_cycle;
> > > +};
> > > +
> > > +static void cv180x_thermal_init(struct cv180x_thermal_zone *ctz)
> > > +{
> > > +	void __iomem *base = ctz->base;
> > > +	u32 regval;
> > > +
> > > +	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
> > > +	writel(TEMPSEN_RESULT_CLR_MAX_RESULT, base + TEMPSEN_RESULT(0));
> > > +
> > > +	regval = readl(base + TEMPSEN_SET);
> > > +	regval &= ~TEMPSEN_SET_CHOPSEL_MASK;
> > > +	regval &= ~TEMPSEN_SET_ACCSEL_MASK;
> > > +	regval &= ~TEMPSEN_SET_CYC_CLKDIV_MASK;
> > > +	regval |= TEMPSEN_SET_CHOPSEL_1024T << TEMPSEN_SET_CHOPSEL_OFFSET;
> > > +	regval |= TEMPSEN_SET_ACCSEL_2048T << TEMPSEN_SET_ACCSEL_OFFSET;
> > > +	regval |= 0x31 << TEMPSEN_SET_CYC_CLKDIV_OFFSET;
> > > +	writel(regval, base + TEMPSEN_SET);
> > > +
> > > +	regval = readl(base + TEMPSEN_AUTO_PERIOD);
> > > +	regval &= ~TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK;
> > > +	regval |= ctz->sample_cycle << TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET;
> > > +	writel(regval, base + TEMPSEN_AUTO_PERIOD);
> > > +
> > > +	regval = readl(base + TEMPSEN_CTRL);
> > > +	regval &= ~TEMPSEN_CTRL_SEL_MASK;
> > > +	regval |= 1 << TEMPSEN_CTRL_SEL_OFFSET;
> > > +	regval |= TEMPSEN_CTRL_EN;
> > > +	writel(regval, base + TEMPSEN_CTRL);
> > > +}
> > > +
> > > +static void cv180x_thermal_deinit(struct cv180x_thermal_zone *ct)
> > > +{
> > > +	void __iomem *base = ct->base;
> > > +	u32 regval;
> > > +
> > > +	regval = readl(base + TEMPSEN_CTRL);
> > > +	regval &= ~(TEMPSEN_CTRL_SEL_MASK | TEMPSEN_CTRL_EN);
> > > +	writel(regval, base + TEMPSEN_CTRL);
> > > +
> > > +	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
> > > +}
> > > +
> > > +/*
> > > + *	Raw register value to temperature (mC) formula:
> > > + *
> > > + *		       read_val * 1000 * 716
> > > + *	Temperature = ----------------------- - 273000
> > > + *				divider
> > > + *
> > > + *	where divider should be ticks number of accumulation period,
> > > + *	e.g. 2048 for TEMPSEN_CTRL_ACCSEL_2048T
> > > + */
> > > +static int cv180x_calc_temp(struct cv180x_thermal_zone *ctz, u32 result)
> > > +{
> > > +	return (result * 1000) * 716 / 2048 - 273000;
> > > +}
> > > +
> > > +static int cv180x_get_temp(struct thermal_zone_device *tdev, int *temperature)
> > > +{
> > > +	struct cv180x_thermal_zone *ctz = thermal_zone_device_priv(tdev);
> > > +	void __iomem *base = ctz->base;
> > > +	u32 result;
> > > +
> > > +	result = readl(base + TEMPSEN_RESULT(0)) & TEMPSEN_RESULT_RESULT_MASK;
> > > +	*temperature = cv180x_calc_temp(ctz, result);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct thermal_zone_device_ops cv180x_thermal_ops = {
> > > +	.get_temp = cv180x_get_temp,
> > > +};
> > > +
> > > +static const struct of_device_id cv180x_thermal_of_match[] = {
> > > +	{ .compatible = "sophgo,cv1800-thermal" },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
> > > +
> > > +static int
> > > +cv180x_parse_dt(struct cv180x_thermal_zone *ctz)
> > > +{
> > > +	struct device_node *np = ctz->dev->of_node;
> > > +	u32 tmp;
> > > +
> > > +	if (of_property_read_u32(np, "sample-rate-hz", &tmp)) {
> > > +		ctz->sample_cycle = 1000000;
> > > +	} else {
> > > +		/* sample cycle should be at least 524us */
> > > +		if (tmp > 1000000 / 524) {
> > > +			dev_err(ctz->dev, "invalid sample rate %d\n", tmp);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		ctz->sample_cycle = 1000000 / tmp;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cv180x_thermal_probe(struct platform_device *pdev)
> > > +{
> > > +	struct cv180x_thermal_zone *ctz;
> > > +	struct thermal_zone_device *tz;
> > > +	struct resource *res;
> > > +	int ret;
> > > +
> > > +	ctz = devm_kzalloc(&pdev->dev, sizeof(*ctz), GFP_KERNEL);
> > > +	if (!ctz)
> > > +		return -ENOMEM;
> > > +
> > > +	ctz->dev = &pdev->dev;
> > > +
> > > +	ret = cv180x_parse_dt(ctz);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret, "failed to parse dt\n");
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	ctz->base = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(ctz->base))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->base),
> > > +				     "failed to map tempsen registers\n");
> > > +
> > > +	ctz->clk_tempsen = devm_clk_get_enabled(&pdev->dev, NULL);
> > > +	if (IS_ERR(ctz->clk_tempsen))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
> > > +				     "failed to get clk_tempsen\n");
> > > +
> > > +	cv180x_thermal_init(ctz);
> > > +
> > > +	tz = devm_thermal_of_zone_register(&pdev->dev, 0, ctz,
> > > +					   &cv180x_thermal_ops);
> > > +	if (IS_ERR(tz))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(tz),
> > > +				     "failed to register thermal zone\n");
> > > +
> > > +	platform_set_drvdata(pdev, ctz);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int cv180x_thermal_remove(struct platform_device *pdev)
> > > +{
> > > +	struct cv180x_thermal_zone *ctz = platform_get_drvdata(pdev);
> > > +
> > > +	cv180x_thermal_deinit(ctz);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused cv180x_thermal_suspend(struct device *dev)
> > > +{
> > > +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> > > +
> > > +	cv180x_thermal_deinit(ctz);
> > > +	clk_disable_unprepare(ctz->clk_tempsen);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __maybe_unused cv180x_thermal_resume(struct device *dev)
> > > +{
> > > +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> > > +
> > > +	clk_prepare_enable(ctz->clk_tempsen);
> > > +	cv180x_thermal_init(ctz);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(cv180x_thermal_pm_ops,
> > > +			 cv180x_thermal_suspend, cv180x_thermal_resume);
> > > +
> > > +static struct platform_driver cv180x_thermal_driver = {
> > > +	.probe = cv180x_thermal_probe,
> > > +	.remove = cv180x_thermal_remove,
> > > +	.driver = {
> > > +		.name = "cv180x-thermal",
> > > +		.pm = &cv180x_thermal_pm_ops,
> > > +		.of_match_table = cv180x_thermal_of_match,
> > > +	},
> > > +};
> > > +
> > > +module_platform_driver(cv180x_thermal_driver);
> > > +
> > > +MODULE_DESCRIPTION("Sophgo CV180x thermal driver");
> > > +MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.45.2
> > > 
> > 
> > Where is interrupt handler? I see nothing about it.
> > 
> > Regards,
> > Inochi
> 
> Interrupts are not used. This driver implements only polling the
> temperature.
> 
> Best regards,
> Haylen Chu

"xxx is not used" is not the reason for you to not implement it.
In addition, interrupt-driven is not just for reading sensors. I
have seen something important like critical alert. Drop interrupt
support may miss these alert.
If you do not want to implement this, move your driver to staging 
as it is not complete.

Regard,
Inochi


