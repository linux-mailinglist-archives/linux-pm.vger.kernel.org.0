Return-Path: <linux-pm+bounces-11155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57D9326DC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D77B2398D
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0C19AA7A;
	Tue, 16 Jul 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="O0F6W77P"
X-Original-To: linux-pm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2100.outbound.protection.outlook.com [40.92.103.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344AC1E498;
	Tue, 16 Jul 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134109; cv=fail; b=VBmt6t58rhAp29scbNcHlHYSIz+GVANZ8wotFETe1pcV8RDdZ/k9u8W+FINNxqplqWauhycyjhCpL5h+l2zN/IdnGrcQb9tGu8XOMeK84J+dpYDvXkC1Pssl99RoerKab/3x6TjSbkhU7b7iY0edYumNaV+CL2sCyuPOokFSnLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134109; c=relaxed/simple;
	bh=Awu4kaK76vTKYm21DNNfrYLxBYCQnYshQhjNHN8wGzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hlgxEfB409kd9eujCEKi6oTsjD6ew124W6ixYzM7k3dZkyWXoE9gJoguCJLFI9A97GPiCwElQ415MeXMmfBpdqBi1lj92cCQUFHq+38lROkZCUCWp/u/3pPeM+TS+mqFJihwXOnJcJ6hzseiViwtN5J4cjZzyoeY5Ya1xzbe7qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=O0F6W77P; arc=fail smtp.client-ip=40.92.103.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CivSMfU2aIowfQL/vdKOFGKIT1733nGutY8150iHduFn8+gNxw9Hc54VvJLcF9QcAcPE92sNWuAuuGvE/Av1ra4D6uDSSs9sDnEeAxL1bsoLTj1ubg7Fv9pgkhBOok3cbC/Uk23JJz4OncCj6rh5p5/wKCGd4V/XCyzVWnupU8mXdJjH6OjPZOpdksxclIj6/hmUJQwNCQVfBljWMiihQCrBXZefBUOW83+6/3xtFszN9D+6JyvvFGqd/MRPCYSBRKGNglMDKRAtjZ7cP2j1srPQBAcdCUzut6RRXTV1mh0iYmNS33hjmuFsDqNctmgomTdvNwDU27F/azIE5BM95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZoNf2Dm58XNL3ZgciqC7tt65l6xNWsAupgtxNiCSfg=;
 b=NbuIK6xUmK+gwOF7pjkWJrGliSENE5bVK/eYMMgBmH1P4+sFOuxkbFEIWTavgLZxBcUKlm4FdZ3azuwfZ99W33cWy4sEAdBPBClTfQYl/w/iJpbGZX7JdqhvRj1Q75Fb47cdjAXvvjfAwEZsjWjjqrckxoQ5EGEC82x8eh58wDzCGp0HZfogF9FKl9pe6W953bL8QI6715WG+sYx9PqJDI0FHrH996asgWBfavpvj90gpOSyteHGMKbbmtyZVjIBAnSUIT2ti+XQ60rz2nWKHUSl4DrnKwyco7AkL/B1cmW77lfgbj5KiVn9YlSm9YlAxkIrCuwGwN7NG3peQT1m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZoNf2Dm58XNL3ZgciqC7tt65l6xNWsAupgtxNiCSfg=;
 b=O0F6W77PFwdxgdxOnWj7b0Qr6LTRWj0DUNP4AE085y26ed3LWWW+TVEr3MI6oYSX1EvpWHrhk2NDQDg2PWVjMHFMDGQxzyosPvocI8WQeMnGSepurx6fdYQZI+0skc1XQ0b2bMOL+qNPxehYQWe9/wHyfT8gAjP3PvMyP9+eU0HfQGue3gEPEZH7gcOeMP44EPNbpX1Shcj+F+X1Qa008FB7WEox1BpH1s5ApYr/7MMJmMZJ/rhQ+Rm9TgsTSEcQ0t0z4vbJC+4hExsk+oI8W38Jsx/8bU5PQWxSG6h8E25AI/i/w/thNfT7fkc+VkLnIwCDR/fZGdQmW9ZFogqmoQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1114.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 12:48:18 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 12:48:18 +0000
Message-ID:
 <MA0P287MB2822B966D31B16B6C4853C8CFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 16 Jul 2024 20:48:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] thermal: cv180x: Add cv180x thermal driver support
To: Haylen Chu <heylenay@outlook.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [eTgWZDQQntYlp4UeolNJnY9kdT53gjwN]
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <27b299ec-934d-418f-94cb-ac0793ba66f9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1114:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f1cfb7-3b18-4646-82e0-08dca5959143
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	9kQzJo6TLBCFk93q1fbSyR3llavWq4LzgMqwFO+GB1V0JnAWERn/GcToULfzKvbsRWi76LIc1tlnKoVuwAC5GzGVGoYgT96lTDPPK3LZCgw0TlBtHCgDsf3rLeskb26zQDl2Eqb/xhkbtDIOlmAy3gTjRTBWUtLZ0XMDFutZEar6cPf1MKAn4+TRKd8xaxb3TsIxSiT2HiQjKrmwt4J+FPCGiRqR325QHLqjBgLI7EzXTVe+Y4Kei9LkQ6t1XQkbZoPHk+lopa7XtbsgzG71h+v6fji94+lE06MrpYJN+2j4NDuYSaLrxNJuV07XK7/y815smvBxmZ+LjO0mFqnla4me4WsmFKx/ezOoJP8+PJP2t4SXUPcNWHf7lRcCsIAtdUk/szUGGUtKHp8M5OEtnTcEXxHZMlr3FlhW0mHxukW+4Uyv/D+SIRmkKEq8w+fTmVsiYF9PvfCmNf8gsJ8UuQA4RNkj/9ovbntn+EO0zu+UsSo0nxmIN1TVKeAd8SGAMOexGIfp4PMN70WgPMNT7jBQteZk8TIeRDcx1mcA73ZbwAuC3jBl4FZJJFyKGk/CGmKpp5L6J5R7WpWXRQOVrKKFy0m4wluZkbjXXfkyworOeWS6wattvUHwGYxD9AOec2I5D7E1twmP7OGro0Astg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TStuR1p0aGkwWHlDc25jZUcybFFXaUxZRHdseTU2YXEvOXlTSHNJNGc2UEV3?=
 =?utf-8?B?eDRGRzlidUFMTDhXSkEyZVNIU244K0F1Z1hMUWdzTFFxN2h1KzhxLzV3SkVz?=
 =?utf-8?B?VHNmQmpZQ0Q2OU8zVTVZZlNwamxLUUtPY0xXQStXSnpza2lMTUM0T1o1NXl3?=
 =?utf-8?B?UE84VnVvRm9GVW53T2NPT25IVW9hamFZS3hqNlN1TzJtN0lKZ2c5dk4ybTBi?=
 =?utf-8?B?cmNOaVA2Y2toSFRqbW85cWlkNlJEcFMvcUprVFhmR1Fkc3lraTIxbjYrOUVl?=
 =?utf-8?B?OWs2NUVXaWI0Ti9pT2VJakxra3RkSHNSKzVCYzZNR2dSdGU3YVNvRmtOYUE0?=
 =?utf-8?B?WklrZmlsUFdyT0lnZ0hrSnYvSnBqcW42TEh2eVFERXdOS2ZDTjRVekQ2MW15?=
 =?utf-8?B?RCtXR1NMbjVNZXBaSURLZmlZNXZEdG9hT2o5am96QnI1Y2RNYXlhRmtHazF1?=
 =?utf-8?B?UjFMSFpQZ3ovMUhHUFRpTEJRcTh3MSs3NStWYlNjTDZrcTE5cmRCd00rRnFV?=
 =?utf-8?B?RmZRSUpzUlZnam5mSW04ajc4b0Rkd2J1Zk5yeWZDNElmNmxqUlFDYm9EbkIr?=
 =?utf-8?B?ZVlyS016YVVBaXVENE5MdGplbURpbW0xZkV3bHlORHFNa3RBSWVmVWtGRHh2?=
 =?utf-8?B?dldpdHIraDBCTHAvOXdzWUk1RVRURkYwWFpETytGZ3M3RGs3QzdrRFBSa0Nw?=
 =?utf-8?B?TjlKdm5YY25TMHZ1NnBpOGdCQkMrMnFheFAzdmJ4bENxQjFMVTJscU94akE0?=
 =?utf-8?B?YmxpRG5neDB1VDR4Q0JsNkt1dDdmSlNsT25ReXBPaTV5ZWptUkFyUmRBcEo3?=
 =?utf-8?B?cmdIYTVENVczelhXejFrc1BnTm9mc2lPUWIzWG9IN3dUTTl1K2c1Lysyci9u?=
 =?utf-8?B?aVJCNC9nWk9BdytpVXlXeVM3Tm1HaE0yY0tiZlVNWnFHc1NjUktFUWdUeVps?=
 =?utf-8?B?Q3RyelpLMjZ2MFNLQ0N1K1FXanp2RzNzRkljb2RFOEVRYzNBbnNRZWZ2elg5?=
 =?utf-8?B?Tk1WcVJ2QStucmF0K01SSnJiazQ4aGQvSkMvKzJtejdCYnBOYStyQVQvWlZV?=
 =?utf-8?B?LzdwVk14bVdMUU1vY2xlOU9xTmFaWWNCM2dUeHhRcjIyUFBNUGpuWTBidk1K?=
 =?utf-8?B?WUJXS2t0dG02c05VdXBoTHF1M0EzZmNkMmdrTXlNWlMvcXAzdXdZMFUvZFlt?=
 =?utf-8?B?dFJRTXR6MStGdXBXV1JHdGRhaHBEc3ZPd0Q2eVViaDFTSUQzbEkyM2VCNDVq?=
 =?utf-8?B?VHlkR3d1VWRnVzJTbHpZb1JQa3hmQm8vaW9ac2YxOVZCRDVOV2RBWS9ZT3Q5?=
 =?utf-8?B?VWoyRGo0dnZFQnVvKzV2cGQzcm81cTRDdXRydmdndU5TbzdmTmVENnQ1SmNk?=
 =?utf-8?B?NmlWQTdGclQ4bnhnT2hlM0tRSW4zeFhsaXZNSkpiMG1vU1BRbm5kcExUMW5X?=
 =?utf-8?B?clh2aFIzcStSRVNyOTdPUWZUZWZBTUJGM2JvU2lGZDJQQkExeTA3U1hxeGE4?=
 =?utf-8?B?cE52Vm1PQzgwTWFoRDBCNDZjSlVTeVV5NXUvRnlZVEVVdnAwOWpQL3VjQXEv?=
 =?utf-8?B?cTR5WUZiQmI2UWQ2MjV1SnNubnFkb1M1VTdCV1B0ckhoUi83Q3BxSHVXR0Rw?=
 =?utf-8?B?ZmlTOTZqeEN6QVk1TldRd1FETXFhNmRjSHFZeVlReDlJckRidGkzOWxJbXJS?=
 =?utf-8?Q?KVxWftVfzKDA0LBJPu0E?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f1cfb7-3b18-4646-82e0-08dca5959143
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 12:48:18.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1114


On 2024/7/16 17:42, Haylen Chu wrote:
> Add support for cv180x SoCs integrated thermal sensors.
>
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>   drivers/thermal/Kconfig          |   6 +
>   drivers/thermal/Makefile         |   1 +
>   drivers/thermal/cv180x_thermal.c | 241 +++++++++++++++++++++++++++++++
>   3 files changed, 248 insertions(+)
>   create mode 100644 drivers/thermal/cv180x_thermal.c
cv18xx_thermal.c ? See my comments in patch 1. When you deicide it, 
update this for all patches.
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 204ed89a3ec9..f53c973a361d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -514,4 +514,10 @@ config LOONGSON2_THERMAL
>   	  is higher than the high temperature threshold or lower than the low
>   	  temperature threshold, the interrupt will occur.
>   
> +config CV180X_THERMAL
Same question above, CV18XX_THERMAL?
> +	tristate "Temperature sensor driver for Sophgo CV180X"
> +	help
> +	  If you say yes here you get support for thermal sensor integrated in
> +	  Sophgo CV180X SoCs.
> +
>   endif
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 5cdf7d68687f..5b59bde8a579 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -65,3 +65,4 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
>   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
>   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
>   obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
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

