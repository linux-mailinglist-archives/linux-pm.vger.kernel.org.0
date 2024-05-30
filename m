Return-Path: <linux-pm+bounces-8435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7E8D5671
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 01:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771562847F4
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A216F0D0;
	Thu, 30 May 2024 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TtuioQlD"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2044.outbound.protection.outlook.com [40.92.23.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD721350;
	Thu, 30 May 2024 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112773; cv=fail; b=hf9Yn1CNF65qUjmuaAjl62rlmrHhJ0YFwQkWAvjqTp+Au7ofOdzKx4aSJOCskBBeGo4n5qZJXioonjLOe3qtXtqcd4gkxquIoz3Hu0IXWAO6NInQyC7KDc3yTCQxUDUuiR+l0sP7t4YOyy3vs/xgi2s1rDVNYQHi1mhw4Hk4AUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112773; c=relaxed/simple;
	bh=Gy+EtIdQ4KN5T0pNpvLeYTygBNTOhxL75l8sd54a2cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fq3d3NW2eX7tfY+5xZsQzlFweK/dBS4dDsB+1Fssrrsh4/hXRtATgE+R404gzXbvfQgUxXZ6+CjTby0+8hEYoZiymySGjRJdapCWcEu+8qaBIvZSFKZgHxHE1TPkeFBKy56xYva8RZzrq93mRn92eiz0IzcziIzp4ezEVfPztX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TtuioQlD; arc=fail smtp.client-ip=40.92.23.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4OGsZ3ZN4CQ2To5fNurUCZGDVOB027Rl4y63hZxREHWYHD8kUE2Z4TFqsKamhicloiLPAD420b93CxTkW/i9+HeiFzow7gpb1BxBYaHoC5byhDsqk64/dNibTvhEZ4H69qCxrj6ZJ0MBghtHDLL5M09A8iYxqQUyFtNMeyiVwpTRkkg32lnQCOhk14T+ICVnPnURO4OeC4h76XrsJFspT89JrtNS5luSP3AGPxoXzofVfBRJds07CbpZjDAnlHOhKTTkhztGfJwv4oLdFLuD8jJTDoO/vXwuMuy0v0u1WW6pwuorMS7VFMXB4+AQhv3noy1Lgh8I18oytYG86Eonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLJtRiTZ+ZC9VHiFfvAb1AC5HieMc9+M/3XHzD3UX68=;
 b=nKmMmexAvMAtTqiVHicVeT7u+ec1WnCbaXOJSc3n31C6ZdhdcUgUOAKtsjtSa2L62jpm+tkUpi148gjZhoePe6OCMh1NvF9uOIfxT+tpPHuxxhxNguUhB15cg6XBUN7qGRFElhaynYzRXJuIZL7FbHbWmMbcXsErnXo1xmPxFLvLYvKZHivplwmzC0dbvbMT+tH9DUvN6Gg0/kcd9JdsyrKH07bkLTSsdAOYMrrEzKgKyulBguzdXAvfZzLYsnU3UUBECcaWLom4JMlcY/ASxb8z8iz3w6rtUuHuxSsY95Y12JZ+UCqSUI+PSgdRNcpiW2/ZcOe/QthtIXYDlsY3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLJtRiTZ+ZC9VHiFfvAb1AC5HieMc9+M/3XHzD3UX68=;
 b=TtuioQlD5pEdJ9/bW8Nxg762Rqu4BLhqNnpLBQpPbrzOfwvr/68iUEjIyYcI9/dS1akaZtcGXxh5SSH1+waM5kxmWIaHEuC8naf2stqIwdXknLHK1dMn9ttP93xwETk3Tt0bp+y48vo0iz88+PsRPmX2mdvS6Xi8WE3cH/2TqucQgW4oVb5Rgt5aTss8K+ElCSSC/oKIfqJTSed6zs/rNWsrOmouuRiAURu7UkT4+AFQpvZmXPtT2BP/9ruspqmWRh421523rMB/A4nFvJuinvD6jIl4GqU7XmtNodIuez+XmtjsOP3mtO2Ql7lKhl6l/svYWcHlT4f220eymXnlLQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by CY5PR20MB4928.namprd20.prod.outlook.com (2603:10b6:930:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 23:46:09 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c%6]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 23:46:09 +0000
Date: Fri, 31 May 2024 07:45:37 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Haylen Chu <heylenay@outlook.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <IA1PR20MB49533177BEFC431FC16D1AB8BBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SEYPR01MB422119B40F4CF05B823F93DCD7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB4221BEBBF659F8495BF0E831D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR01MB4221BEBBF659F8495BF0E831D7F32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-TMN: [jLRA/bHeQyuJB4O2an7L6WJ5zaNGrnnBx+lX7J2hvPE=]
X-ClientProxiedBy: TYAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:404:15::27) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <yk7uex55z3tvuujyg5fs3deadv6pg4atxxagqz2trga2gj7nww@wacs3qg7joxs>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|CY5PR20MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 60beeff7-cc67-4449-b84d-08dc8102a55a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	P7qcfp+sGRL2jqezugDwY9R6zD1/kv38nKBnmU0alKKmEQ+JqzTMVg8s85njMDZqADZcd+aUG9No1gNJ/tOZ04u3TtN0o/BeLKSafLovyyffaLKcsxZVT3/7MCr/ykpHUGqOC1NLrjKWPZg768ms9G2Te+jo7Ml9EWhdIXi6GW/3S9UZgDAc/2jHJm19Q6GtOGvAX3ue7B1ZyBAqmyEZNfJ94d5JPSff+bQViVSWXW6iTSXZp88zXgiE/BQ4dS1Ucn3ICpNrfKp25nGjbAJa36KtszL2Q6VmwmhPTBQhJMv/eYihUcWmm3+FpRMKpAf5oh8qXrvM/dlN7hq8P0tbimDqL0UX5DE3SwrJJu1LY3RhyAcWFFbG2EoJ9DU+WS4sXct3kKy7bBtXz/x8yOt9K32fW0xuCF/yDJ2oMIc6BU6hit480ZEcrWxs+ka+Niqx37QESX7Qw49A0OSh6sUWOx7d7zOcFo4pa1OGGoMz0I4qvL0fi40fE3PohwTabmdJ99Ye+v2uo0WYLHz1A6FxTEH4nEU3MwoVQBHcL3czVJEisf01RNSQgNlJTdybDGqjq1Dg8q9EQ8uo5b6K32mDh+sVwIsiUv28gl8g+Ecq9l7PTyQnrGyyVuoj/tT9XdGV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBiRf2rWC+TD7RQ18ECwSl7x0CNsyVHUeXsUqubpnOfl+eQB1D18b1MT/UST?=
 =?us-ascii?Q?qydU8ehLWwkUqZsL6Oqgbqd8lSxzM0e/JoMX7yB91IXjKqAhymK7/hg722Zg?=
 =?us-ascii?Q?PU1pKgbOBYGk1pv1rP5g7LCCN5B1ctb3vz8a/4LYGu42ONXYp/cME7Q/kx7+?=
 =?us-ascii?Q?o6uRjk7Uo8ZeIkXnxMb8mUFRddr7UF7Moagkdmu8EbFTE27YKYQ8HiIE97Df?=
 =?us-ascii?Q?8aUqtfiJwl75NjnKQVuxMdmlSy3PQcJugGXQfn8OD9xOh51uFoFE4iKsu7i5?=
 =?us-ascii?Q?Bdgs1uffOOyc7sFReu99UWHwHXBG1Q6OPGfDwDS5hpofcq8fg1M3cOkPPC3d?=
 =?us-ascii?Q?M6Xb/5W5FLQRXpjGCM6rAfjjxarvvGTrCI2fd+437PFRuKUGxmdB3PnVc4mm?=
 =?us-ascii?Q?ilJrHGKlS/W0zMg95uZf1rwh/ZVh++DHLHh+DDQ57QvO4DZk7jrXZ6B6zkff?=
 =?us-ascii?Q?JGuNlAm3D8ukECT7kxQ9U0vP/atv9vXmR3G3gode6Qe4nTrfF7vj+28ENq4A?=
 =?us-ascii?Q?8nJbLWuHAdq5/k5f2dTak+UMCFbX4pZosLDIiAhBnJc9UsnQnhPUZ4ZeHgIz?=
 =?us-ascii?Q?eYCSVGgJKdxUQKwqnkSGtbYJ+xEpgOfP0inpiAjAqsexIvtPdT09xrByJVNx?=
 =?us-ascii?Q?rkqbHd5K4yh4+wRXuVm+d403waeeya1LE6ZP7fl3W5W8ilv3BrFXTVWchomS?=
 =?us-ascii?Q?JF0VsFlzq7eDvJsBV3H/8njQdMr7Gxe6A9OsNPQZZXD1gf4RDMWLxa1WSTMr?=
 =?us-ascii?Q?CoFA22sWHEc/yyZnTa8JeTDGmz4I7NvSlBP1peBBOIkKpYaNg0xUpL1wfJzh?=
 =?us-ascii?Q?/SHrMeluba4J8jHA/5hsaFxJnw93mPebzzi5WwkseWQ6ASEwyY8oBvridiTr?=
 =?us-ascii?Q?7pVGSx6/ZcI2Erh9BkwIjH+B1uL2fFNv7UdsneSV7322Junsd6B1rP2FNjJ5?=
 =?us-ascii?Q?LhGWexBv3H5sQPARRPehNkfYlANmX7hGZ0kFDSs2qoqyqAkWrMmz2tHvPG/R?=
 =?us-ascii?Q?LWtPbB0RPunKgbQP6KGkORAhfcDvSbeYVAzZeliRBaymWSGLpGvHvSG4wtKs?=
 =?us-ascii?Q?+ngVsXQ7o/o0CsvkJYWEDBQrLguEx2kJrtNO62g4EcgSZSipSt5D79ItHYd+?=
 =?us-ascii?Q?3Tl4Ip9F4tD//hczek0Lt15pOcCrsaJKMubkrZYCrjfVmah/EAKDqOWPLKxO?=
 =?us-ascii?Q?NXmFpJMQ3UEsUl9Ue7zaIOX0GOADTHyAxcrNQPvds1+opv/KU7WTSDnABjE2?=
 =?us-ascii?Q?94Ym/jb3GjPeneV0jLHp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60beeff7-cc67-4449-b84d-08dc8102a55a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:46:09.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4928

On Thu, May 30, 2024 at 01:48:27PM GMT, Haylen Chu wrote:
> Add support for cv180x SoCs integrated thermal sensors.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  drivers/thermal/Kconfig          |   6 +
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/cv180x_thermal.c | 210 +++++++++++++++++++++++++++++++
>  3 files changed, 217 insertions(+)
>  create mode 100644 drivers/thermal/cv180x_thermal.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 204ed89a3ec9..f53c973a361d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -514,4 +514,10 @@ config LOONGSON2_THERMAL
>  	  is higher than the high temperature threshold or lower than the low
>  	  temperature threshold, the interrupt will occur.
>  
> +config CV180X_THERMAL
> +	tristate "Temperature sensor driver for Sophgo CV180X"
> +	help
> +	  If you say yes here you get support for thermal sensor integrated in
> +	  Sophgo CV180X SoCs.
> +
>  endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 5cdf7d68687f..5b59bde8a579 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -65,3 +65,4 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
>  obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> +obj-$(CONFIG_CV180X_THERMAL)	+= cv180x_thermal.o
> diff --git a/drivers/thermal/cv180x_thermal.c b/drivers/thermal/cv180x_thermal.c
> new file mode 100644
> index 000000000000..618e031b4515
> --- /dev/null
> +++ b/drivers/thermal/cv180x_thermal.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 CVITEK Inc.

There is no CVITEK anyway, use SOPHGO instead. 

> + * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/thermal.h>
> +

> +#define TEMPSEN_VERSION					0x0
> +#define TEMPSEN_CTRL					0x4
> +#define TEMPSEN_CTRL_EN					BIT(0)
> +#define TEMPSEN_CTRL_SEL_MASK				GENMASK(7, 4)
> +#define TEMPSEN_CTRL_SEL_OFFSET				4
> +#define TEMPSEN_STATUS					0x8
> +#define TEMPSEN_SET					0xc
> +#define TEMPSEN_SET_CHOPSEL_MASK			GENMASK(5, 4)
> +#define TEMPSEN_SET_CHOPSEL_OFFSET			4
> +#define TEMPSEN_SET_CHOPSEL_128T			0
> +#define TEMPSEN_SET_CHOPSEL_256T			1
> +#define TEMPSEN_SET_CHOPSEL_512T			2
> +#define TEMPSEN_SET_CHOPSEL_1024T			3
> +#define TEMPSEN_SET_ACCSEL_MASK				GENMASK(7, 6)
> +#define TEMPSEN_SET_ACCSEL_OFFSET			6
> +#define TEMPSEN_SET_ACCSEL_512T				0
> +#define TEMPSEN_SET_ACCSEL_1024T			1
> +#define TEMPSEN_SET_ACCSEL_2048T			2
> +#define TEMPSEN_SET_ACCSEL_4096T			3
> +#define TEMPSEN_SET_CYC_CLKDIV_MASK			GENMASK(15, 8)
> +#define TEMPSEN_SET_CYC_CLKDIV_OFFSET			8
> +#define TEMPSEN_INTR_EN					0x10
> +#define TEMPSEN_INTR_CLR				0x14
> +#define TEMPSEN_INTR_STA				0x18
> +#define TEMPSEN_INTR_RAW				0x1c
> +#define TEMPSEN_RESULT(n)				(0x20 + (n) * 4)
> +#define TEMPSEN_RESULT_RESULT_MASK			GENMASK(12, 0)
> +#define TEMPSEN_RESULT_MAX_RESULT_MASK			GENMASK(28, 16)
> +#define TEMPSEN_RESULT_CLR_MAX_RESULT			BIT(31)
> +#define TEMPSEN_AUTO_PERIOD				0x64
> +#define TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK		GENMASK(23, 0)
> +#define TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET		0

I suggest adding extra indent to the register value macro. It is too hard to
identify which one is register offset, which one it register value.

> +
> +struct cv180x_thermal_zone {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *clk_tempsen;
> +};
> +

> +static void cv180x_thermal_init(struct cv180x_thermal_zone *ctz)
> +{
> +	void __iomem *base = ctz->base;
> +	u32 regval;
> +
> +	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
> +	writel(TEMPSEN_RESULT_CLR_MAX_RESULT, base + TEMPSEN_RESULT(0));
> +
> +	regval = readl(base + TEMPSEN_SET);
> +	regval &= ~TEMPSEN_SET_CHOPSEL_MASK;
> +	regval &= ~TEMPSEN_SET_ACCSEL_MASK;
> +	regval &= ~TEMPSEN_SET_CYC_CLKDIV_MASK;
> +	regval |= TEMPSEN_SET_CHOPSEL_1024T << TEMPSEN_SET_CHOPSEL_OFFSET;
> +	regval |= TEMPSEN_SET_ACCSEL_2048T  << TEMPSEN_SET_ACCSEL_OFFSET;
> +	regval |= 0x31 << TEMPSEN_SET_CYC_CLKDIV_OFFSET;
> +	writel(regval, base + TEMPSEN_SET);
> +
> +	regval = readl(base + TEMPSEN_AUTO_PERIOD);
> +	regval &= ~TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK;
> +	regval |= 0x100000 << TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET;
> +	writel(regval, base + TEMPSEN_AUTO_PERIOD);
> +
> +	regval = readl(base + TEMPSEN_CTRL);
> +	regval &= ~TEMPSEN_CTRL_SEL_MASK;
> +	regval |= 1 << TEMPSEN_CTRL_SEL_OFFSET;
> +	regval |= TEMPSEN_CTRL_EN;
> +	writel(regval, base + TEMPSEN_CTRL);
> +}

The sensors of CV1800 support various periods, I think you should add
support for all of them and let user select them. The configuration
you use now can be left as the default.

> +
> +static void cv180x_thermal_deinit(struct cv180x_thermal_zone *ct)
> +{
> +	void __iomem *base = ct->base;
> +	u32 regval;
> +
> +	regval = readl(base + TEMPSEN_CTRL);
> +	regval &= ~(TEMPSEN_CTRL_SEL_MASK | TEMPSEN_CTRL_EN);
> +	writel(regval, base + TEMPSEN_CTRL);
> +
> +	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
> +}
> +

> +static int calc_temp(uint32_t result)

Add "cv180x" prefix.

> +{
> +	return ((result * 1000) * 716 / 2048 - 273000);
> +}

Why these magic number, I have not see any info in the document. 

> +
> +static int cv180x_get_temp(struct thermal_zone_device *tdev, int *temperature)
> +{
> +	struct cv180x_thermal_zone *ctz = thermal_zone_device_priv(tdev);
> +	void __iomem *base = ctz->base;
> +	u32 result;
> +
> +	result = readl(base + TEMPSEN_RESULT(0)) & TEMPSEN_RESULT_RESULT_MASK;
> +	*temperature = calc_temp(result);
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops cv180x_thermal_ops = {
> +	.get_temp = cv180x_get_temp,
> +};
> +
> +static const struct of_device_id cv180x_thermal_of_match[] = {
> +	{
> +		.compatible = "sophgo,cv180x-thermal",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
> +
> +static int cv180x_thermal_probe(struct platform_device *pdev)
> +{
> +	struct cv180x_thermal_zone *ctz;
> +	struct thermal_zone_device *tz;
> +	struct resource *res;
> +
> +	ctz = devm_kzalloc(&pdev->dev, sizeof(*ctz), GFP_KERNEL);
> +	if (!ctz)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctz->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ctz->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->base),
> +				     "failed to map tempsen registers\n");
> +
> +	ctz->clk_tempsen = devm_clk_get(&pdev->dev, "clk_tempsen");
> +	if (IS_ERR(ctz->clk_tempsen))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
> +				     "failed to get clk_tempsen\n");
> +
> +	clk_prepare_enable(ctz->clk_tempsen);
> +
> +	ctz->dev = &pdev->dev;
> +
> +	cv180x_thermal_init(ctz);
> +
> +	platform_set_drvdata(pdev, ctz);

Set this after register thermal zone.

> +
> +	tz = devm_thermal_of_zone_register(&pdev->dev, 0, ctz,
> +					   &cv180x_thermal_ops);
> +	if (IS_ERR(tz))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tz),
> +				     "failed to register thermal zone\n");
> +
> +	return 0;
> +}
> +
> +static int cv180x_thermal_remove(struct platform_device *pdev)
> +{
> +	struct cv180x_thermal_zone *ctz = platform_get_drvdata(pdev);
> +
> +	cv180x_thermal_deinit(ctz);
> +	clk_disable_unprepare(ctz->clk_tempsen);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cv180x_thermal_suspend(struct device *dev)
> +{
> +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> +
> +	cv180x_thermal_deinit(ctz);
> +	clk_disable_unprepare(ctz->clk_tempsen);
> +
> +	return 0;
> +}
> +
> +static int cv180x_thermal_resume(struct device *dev)
> +{
> +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(ctz->clk_tempsen);
> +	cv180x_thermal_init(ctz);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */

Use __maybe_unused may be more clear with SIMPLE_DEV_PM_OPS.

> +
> +static SIMPLE_DEV_PM_OPS(cv180x_thermal_pm_ops,
> +			 cv180x_thermal_suspend, cv180x_thermal_resume);
> +
> +static struct platform_driver cv180x_thermal_driver = {
> +	.probe = cv180x_thermal_probe,
> +	.remove = cv180x_thermal_remove,
> +	.driver = {
> +		.name = "cv180x-thermal",
> +		.pm = &cv180x_thermal_pm_ops,
> +		.of_match_table = cv180x_thermal_of_match,
> +	},
> +};
> +
> +module_platform_driver(cv180x_thermal_driver);
> +
> +MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.45.1
> 

