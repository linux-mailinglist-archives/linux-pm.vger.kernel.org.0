Return-Path: <linux-pm+bounces-11199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263369336DF
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC5E1F23D62
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2C168BD;
	Wed, 17 Jul 2024 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nhOzEGAB"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2080.outbound.protection.outlook.com [40.92.43.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9E17997;
	Wed, 17 Jul 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197369; cv=fail; b=nKHvrTSL06ouNk5OPaTOaZGM6uw8YKjInr1AN4FRloRk8I8xHnI8xT4CM1AXqpFh6wM7boeH+IKfX+NuLthOtzpM5PIOEEgDB0yuIFMwfZ3wHBf4/oAy1f15vTNuJ3Bq1Tybxp0kinUowdEpmQ7LfewdyZY6ZncjLDY/6er8LrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197369; c=relaxed/simple;
	bh=llIz0Qg+lsbFRTH6DjWLKm6oFfDxGrTYcvlsGGYdTwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nEhwy+BE6ZDCQVg/pEMvUIcZr4E69mgnkRZeWWpyQSjmgHxixvIkSHJ+ChQ1bfTM+19r1McL7IGMBdYfeBxFqiyts0GGtx5olXMIrI0m00hQuRWFmJ/Gz4kfkfgV+B/IdkuX4svcwEtW7XtzUn8HSyHEo9U4t3bu9NRjNzab604=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nhOzEGAB; arc=fail smtp.client-ip=40.92.43.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFeItEJYN59x9k26F9MPyn+wrqvRNKKFdlrIjwePRBrjFWlZAApQOhYIu9WxL5If8jGlRdtsKKDiffS4Fxj4NBbW1Frr2oqS0ntM4hsd1kT0N/9XyGefHh7KbpP26Y24+57/DLS11F+Ad45LMcUJZKal+llDRhQTHEMTwleYC3EEvFtsx/lcGOR1F9kNq400A5KoweWhvOV9at2JJRIetKcqCn9me97tr77g7thmu14FLhWpcKCFqvTqdDky05Eq/ZBEvXy2rCs51XOEuF3e1ydIyVDkCaXQn4twitiVQHr3rm/Dht1e+FZsv6v+CCR0tEHrXfghcC762eyVLRQ69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT58tTSHLtBcrJ1Q1cckITVrp/s3aO0PJnIrfROWE5c=;
 b=PNYJNrpehazXr0CMOomd0dlwK2Vg1hVxZOumDtUdaSheXpOOcjUjfwkDKXIjsLsXj62LbJSo28fi4uayKXJzHhY9J2tjc0GD5VXwiE1ftYuXpHCaaydEldYeKq5ic97rGop5OekmK6kvMWTkdMj2eghnNLtOth8Eofx7QuEiWgNknsE9zOTPHa53WG2eBnmKD83sGAPKfSzx+RbCoOQVRSDpe2jx8h1NM6qepYAMl45GZrG53hHuTJ6UYCfXbFFRXzerSLcsTTN3ODye+riWq6CZIhLikjwPGrXh12F8XKV3Sn9ZPqyBi6S0ZV4m8J1ZvZP0mFKm4uduK8ufVZZrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT58tTSHLtBcrJ1Q1cckITVrp/s3aO0PJnIrfROWE5c=;
 b=nhOzEGABsdsNctJoVboQf0CGBA/5ByYF58xRqfLcFNAe/LcQdQUG1AlV/3FShsYnUtyUofqMr5GO5/hCzG5XQFdzrSHySnNeYnjEDpcYCq+zqfiK3BXcK50sjUN2R9EvHzgme+m6D410+6J/mdYOHLSxwgzzbvriV6rCw8nBWy631MNlLWNe+MIPQh/HgeE/0q03bmEBwW4r7b5eXfYCbw6OVIfhKbXc2oQc7sbriXrfR0JKHEc4jnsCmcoij8a6WY/uMQ/GVpUfwKT+9TqsdmMCgOZ8/6/F0IZPvyJr7yf8Rlxt1m9Qw2jO434ugBzDL5LgYmIJ71D5qSWJKguLIQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by SN7PR20MB5093.namprd20.prod.outlook.com (2603:10b6:806:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 06:22:45 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::b5de:b82:43d9:4e8c%5]) with mapi id 15.20.7784.013; Wed, 17 Jul 2024
 06:22:45 +0000
Date: Wed, 17 Jul 2024 14:22:32 +0800
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
Subject: Re: [PATCH v4 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <PH7PR20MB4962DD8526FF0845258ECE2FBBA32@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-TMN: [rXCyd0KqeWZ4DXEHgS+LvusMKluvz2GUPbPUQmh2jo4=]
X-ClientProxiedBy: PS1PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::36) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <y6brlmrhs2m4sm5kvfuluv6hmxjfz5zxmxtf6vww7hzpc3yn2p@m3gg6wh3mtvd>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|SN7PR20MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: c6892e0a-0d29-4b35-0984-08dca628de97
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	7PMbcgKkD2KESgZ9pSDotIVnPWVu9qeobVUnlY8NLBeXd/oYw5wIdrAM61V7276SF/tLAIyVj3IiqvylhGsrBDGZ+Pa4SnX6giQnKZTA9azpouPW0fKjwr3YB5ZilHi8nuqpj2DHvJKhJFRHVSINHW8HgFALDSuOVVzLN2TaKbnEs75ZfVKtf3iglZYOg0YCZN/5d0Y7uvcMyfOIrtfIKwGycWEF5CtYbNbFmKJ0q7dhw9JauKV0AbB7rqJfVlSXqbiJ6gEli4nHg0fCHZuQBW+K0yaYXbeO7eLgD4dTx6b918I+evx5H0waLg4kpuwdzkR2dryNl0V+7BlJ15E4H7TACiao/42DkbtG9kh5auHNVyOh3/uKSsAay5LE+joKIhBeasQn9cLpE9vtKvVPCyfBa2OiSfF5sOUxDqBxEZJLo40hNqrEZQoRHEKUWONjKUFq/qbQD+isLxTZ6Mhzby/noGxDsv6ClXkCDkFDfMZZNVV0dBntoEgBAUSPIut5aALv4wtHN425ZYIHzbx3STTxEsjwMGv+bPdnmrHMZixV7Z3c2qKZKOjoAJDSH9xe0IOmn6+SL52eGXKz7eCLdPLgxL/gGHrNjl41ZgWsMHIK0fery0/4SF773zq9MpmNAJnKTkCLmlCJrBQnsZHJkjfKPnxC/V+ZQiVlLo/JrR8eWK5YUEn0CZS9poyMI+TI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iMnTbZtZyd423EFcOGscNjX8f5Zp0KQEJ7BtuZH/d7r+meBw9aAHnMKeTJZT?=
 =?us-ascii?Q?+khfu5q4yDuUguWlqMZ8WxjYAl0uMmcdSpjx3lWiWl/h8PejfSlunzZwwk3T?=
 =?us-ascii?Q?kn8rT2i+af9NRRUpAZv5y+CUqLBrYKM/GJl3LG+Gi9Qo+KWHjz/K+nbKgSuL?=
 =?us-ascii?Q?cfj4ptH7g6W07+kRSEuh1UxaD1irgiI1Mcj+ZpavbKd11N20tS7V3b4TDBod?=
 =?us-ascii?Q?rmXXVlbaHanZl+cqwtSkeD0gBnk9ROM5bRIh6F+VYEP1E7aZeh7fL55N53fh?=
 =?us-ascii?Q?063T/b6ZlXI1vqC57j8XIcokNhsPFKkgyW7rUtrfm53IJrPRw+1ulCx6c97l?=
 =?us-ascii?Q?s+Kzal4tIliLEuJh43DpXOT78irNBnju/dHk7UBB7j9NfYP7l6i0w6Eo65bi?=
 =?us-ascii?Q?rbE/TAQ8yEoARXzH4TWlg2xdA5B51p2NA0j9JYj7sV7R/6/fx/8laAnZI7dZ?=
 =?us-ascii?Q?6OAhLRb4ulq96yKV2Qoeqg5xBPCC5ckWjgGIwPH8yuQO7mcEMpOHPVl0GX6s?=
 =?us-ascii?Q?V8obCcdidZ47haq6aw/1NtGcRkCyyMRY0goY9RhT5W+4sr9TyqYnmQYrwH4Y?=
 =?us-ascii?Q?WAPU7Hn48oq99EFLJRqbDu9g/V8OW3TNSmbCfTO32wzgAAh/8k4zkOGHcs+1?=
 =?us-ascii?Q?+vCUsIrcBGV+Nz4C13ge4tXAyUdsKHpOppgZNso2QYBqfA0t7wQtl2OGSLeh?=
 =?us-ascii?Q?8U38+rpM2uPVziF0AavbeKoOanlv3Mz6R7pe2ih45vByeVb4GDOsN/DdffPN?=
 =?us-ascii?Q?MA4gXoKLJAo6CLHyL/s2puANmsGk43Vm/8gO0/uNsQIiTzolQhMpGlQq/HQq?=
 =?us-ascii?Q?hL/TFZHrdKQuHPoFhjkjufCWGBrk878AvWIpvs2vCGWY0+snG8nOmcCAmZoL?=
 =?us-ascii?Q?Vl1PPGoBh5a95fh3J2kJB+oSAHPD1fjtGX2NlNkJ14bWFK8eucH1xfBPy+be?=
 =?us-ascii?Q?C0kTD+MkmFqoOSvU6OA/lTvz21kU5l9NiDhWxZS6rQJpv8f8XrqyrZkYF1Kh?=
 =?us-ascii?Q?oKx0dc1HkFDQCVJTG1N2HGcXJ6lLKIc5DDq306IUyxZ4RCpgRTSyUh48eS7U?=
 =?us-ascii?Q?q/KgUpQ8Jpl9jHOLuAMiTfpAf5nCwWM4W6dklG36v9CHPDECx3KniiUq1tEY?=
 =?us-ascii?Q?JdinigN54jTwlUVz7zqKOA/xAWrrUreraQ28rBoI10CPwa7AzDTAfhQTQHxC?=
 =?us-ascii?Q?5iZ9VfsA4/zoQTX8nhE7f0YEWGHr8ghjaxidSDOy4VXtfoJYGDt3gylLAJOO?=
 =?us-ascii?Q?TW9jzoDsnzs2sx5L0M+i?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6892e0a-0d29-4b35-0984-08dca628de97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:22:44.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5093

On Tue, Jul 16, 2024 at 09:42:35AM GMT, Haylen Chu wrote:
> Add support for cv180x SoCs integrated thermal sensors.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  drivers/thermal/Kconfig          |   6 +
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/cv180x_thermal.c | 241 +++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
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
> index 000000000000..8b726c0ad848
> --- /dev/null
> +++ b/drivers/thermal/cv180x_thermal.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Sophgo Inc.
> + * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define TEMPSEN_VERSION					0x0
> +#define TEMPSEN_CTRL					0x4
> +#define  TEMPSEN_CTRL_EN				BIT(0)
> +#define  TEMPSEN_CTRL_SEL_MASK				GENMASK(7, 4)
> +#define  TEMPSEN_CTRL_SEL_OFFSET			4
> +#define TEMPSEN_STATUS					0x8
> +#define TEMPSEN_SET					0xc
> +#define  TEMPSEN_SET_CHOPSEL_MASK			GENMASK(5, 4)
> +#define  TEMPSEN_SET_CHOPSEL_OFFSET			4
> +#define  TEMPSEN_SET_CHOPSEL_128T			0
> +#define  TEMPSEN_SET_CHOPSEL_256T			1
> +#define  TEMPSEN_SET_CHOPSEL_512T			2
> +#define  TEMPSEN_SET_CHOPSEL_1024T			3
> +#define  TEMPSEN_SET_ACCSEL_MASK			GENMASK(7, 6)
> +#define  TEMPSEN_SET_ACCSEL_OFFSET			6
> +#define  TEMPSEN_SET_ACCSEL_512T			0
> +#define  TEMPSEN_SET_ACCSEL_1024T			1
> +#define  TEMPSEN_SET_ACCSEL_2048T			2
> +#define  TEMPSEN_SET_ACCSEL_4096T			3
> +#define  TEMPSEN_SET_CYC_CLKDIV_MASK			GENMASK(15, 8)
> +#define  TEMPSEN_SET_CYC_CLKDIV_OFFSET			8
> +#define TEMPSEN_INTR_EN					0x10
> +#define TEMPSEN_INTR_CLR				0x14
> +#define TEMPSEN_INTR_STA				0x18
> +#define TEMPSEN_INTR_RAW				0x1c
> +#define TEMPSEN_RESULT(n)				(0x20 + (n) * 4)
> +#define  TEMPSEN_RESULT_RESULT_MASK			GENMASK(12, 0)
> +#define  TEMPSEN_RESULT_MAX_RESULT_MASK			GENMASK(28, 16)
> +#define  TEMPSEN_RESULT_CLR_MAX_RESULT			BIT(31)
> +#define TEMPSEN_AUTO_PERIOD				0x64
> +#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK		GENMASK(23, 0)
> +#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET		0
> +
> +struct cv180x_thermal_zone {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *clk_tempsen;
> +	u32 sample_cycle;
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
> +	regval |= TEMPSEN_SET_ACCSEL_2048T << TEMPSEN_SET_ACCSEL_OFFSET;
> +	regval |= 0x31 << TEMPSEN_SET_CYC_CLKDIV_OFFSET;
> +	writel(regval, base + TEMPSEN_SET);
> +
> +	regval = readl(base + TEMPSEN_AUTO_PERIOD);
> +	regval &= ~TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK;
> +	regval |= ctz->sample_cycle << TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET;
> +	writel(regval, base + TEMPSEN_AUTO_PERIOD);
> +
> +	regval = readl(base + TEMPSEN_CTRL);
> +	regval &= ~TEMPSEN_CTRL_SEL_MASK;
> +	regval |= 1 << TEMPSEN_CTRL_SEL_OFFSET;
> +	regval |= TEMPSEN_CTRL_EN;
> +	writel(regval, base + TEMPSEN_CTRL);
> +}
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
> +/*
> + *	Raw register value to temperature (mC) formula:
> + *
> + *		       read_val * 1000 * 716
> + *	Temperature = ----------------------- - 273000
> + *				divider
> + *
> + *	where divider should be ticks number of accumulation period,
> + *	e.g. 2048 for TEMPSEN_CTRL_ACCSEL_2048T
> + */
> +static int cv180x_calc_temp(struct cv180x_thermal_zone *ctz, u32 result)
> +{
> +	return (result * 1000) * 716 / 2048 - 273000;
> +}
> +
> +static int cv180x_get_temp(struct thermal_zone_device *tdev, int *temperature)
> +{
> +	struct cv180x_thermal_zone *ctz = thermal_zone_device_priv(tdev);
> +	void __iomem *base = ctz->base;
> +	u32 result;
> +
> +	result = readl(base + TEMPSEN_RESULT(0)) & TEMPSEN_RESULT_RESULT_MASK;
> +	*temperature = cv180x_calc_temp(ctz, result);
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops cv180x_thermal_ops = {
> +	.get_temp = cv180x_get_temp,
> +};
> +
> +static const struct of_device_id cv180x_thermal_of_match[] = {
> +	{ .compatible = "sophgo,cv1800-thermal" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
> +
> +static int
> +cv180x_parse_dt(struct cv180x_thermal_zone *ctz)
> +{
> +	struct device_node *np = ctz->dev->of_node;
> +	u32 tmp;
> +
> +	if (of_property_read_u32(np, "sample-rate-hz", &tmp)) {
> +		ctz->sample_cycle = 1000000;
> +	} else {
> +		/* sample cycle should be at least 524us */
> +		if (tmp > 1000000 / 524) {
> +			dev_err(ctz->dev, "invalid sample rate %d\n", tmp);
> +			return -EINVAL;
> +		}
> +
> +		ctz->sample_cycle = 1000000 / tmp;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cv180x_thermal_probe(struct platform_device *pdev)
> +{
> +	struct cv180x_thermal_zone *ctz;
> +	struct thermal_zone_device *tz;
> +	struct resource *res;
> +	int ret;
> +
> +	ctz = devm_kzalloc(&pdev->dev, sizeof(*ctz), GFP_KERNEL);
> +	if (!ctz)
> +		return -ENOMEM;
> +
> +	ctz->dev = &pdev->dev;
> +
> +	ret = cv180x_parse_dt(ctz);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to parse dt\n");
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctz->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ctz->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->base),
> +				     "failed to map tempsen registers\n");
> +
> +	ctz->clk_tempsen = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(ctz->clk_tempsen))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
> +				     "failed to get clk_tempsen\n");
> +
> +	cv180x_thermal_init(ctz);
> +
> +	tz = devm_thermal_of_zone_register(&pdev->dev, 0, ctz,
> +					   &cv180x_thermal_ops);
> +	if (IS_ERR(tz))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(tz),
> +				     "failed to register thermal zone\n");
> +
> +	platform_set_drvdata(pdev, ctz);
> +
> +	return 0;
> +}
> +
> +static int cv180x_thermal_remove(struct platform_device *pdev)
> +{
> +	struct cv180x_thermal_zone *ctz = platform_get_drvdata(pdev);
> +
> +	cv180x_thermal_deinit(ctz);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cv180x_thermal_suspend(struct device *dev)
> +{
> +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> +
> +	cv180x_thermal_deinit(ctz);
> +	clk_disable_unprepare(ctz->clk_tempsen);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cv180x_thermal_resume(struct device *dev)
> +{
> +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(ctz->clk_tempsen);
> +	cv180x_thermal_init(ctz);
> +
> +	return 0;
> +}
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
> +MODULE_DESCRIPTION("Sophgo CV180x thermal driver");
> +MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.45.2
> 

Where is interrupt handler? I see nothing about it.

Regards,
Inochi

