Return-Path: <linux-pm+bounces-8744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC38FF7B2
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 00:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885F11F25475
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A413C820;
	Thu,  6 Jun 2024 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eOSvIdhQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2022.outbound.protection.outlook.com [40.92.18.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E14224D6;
	Thu,  6 Jun 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713443; cv=fail; b=b+l35DlkikYq0O/uRb4fJDhg/OkWOTDT8AuLx+2ffieUqevslbKWzouewM5f1nKcb1+SZvoOQb86CyMh5P46HJnWcNXocWckWRsWl8Zf0+HYYPUfSyoaRgrreUuXwvFnztnQ2tkk7vEcplkAkiB58CxhyVsaE4cLhLbP7H5+YWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713443; c=relaxed/simple;
	bh=eU0/BTxkZJq9dhtfgfqoV2E6+BfZ5YpTCvHCyxGMquM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gKhUi7p9LRh+O12qdZF1qsyg9VryDRHRCptlw70dgQujpc83KQ8CHzaDCvid9IS49CECCziblTl1Z5+7l4Ee1UGR0uNWWLN5xbU407gvhi5kRvE6fX1W2TvUDKrQQ4bLXy9QtAwPrazPOV7iVBuVAO0IeNzuy+KZWrEwvknrlQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eOSvIdhQ; arc=fail smtp.client-ip=40.92.18.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6QNsmJju/m65fIxIOLuviYyxJmzpt7G2qK/6hVLMgXS+f33WFKnzovUtx8VNKXz19ihainI6iizTgHP7/TaNRe8+GKOJScjSnmew9oyn36xxMwaPVBaghRql/Ml1+v30CtMrRagCK3sdooOiLyAQZV4SovMHpvVoxPltFofjvDjZhmsHIshVnuMRH3JEQiJRQ6d7pBK3NSWMWFPq0vPdJ/6W8kFPTFYqWYt2F9qyBdjuA8OWpTqIuuD5SkuLrU8f3oUnKgsTpbRsBKv1TVTcKrLBp1aK3H28rj/lPdjxFZ5+lxk/zxO0ZsKXtr2WPXPOKieXVDTheKc2tUSgoaUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/a94fw/UDkCnJhjkgpW/L0CEo+uD+Jq0ukeECfqhJg=;
 b=HxOckWTg3hGfet1S/Bz46TjXgjpOo7h8GodxK7n+EfRWBN20KTpKhKz4K97QI6Zonp5MHPoGa0Krx8cocblrMeRifB7PX2zMR+usBjYNRMTAsozvb6ChCuw5VE1tQfyGeeQR/1wnz9dC3mADrdOmZeNRP6JSz3Mss3KAZ/SSpTLkHpNPQ6Z9MU9cqkdt9ml5Z9RWRdYL3vVBVG6IwYZ2uV/aM64LAn5AqPiYR7wwQnfrwKlwfjB6vSx43efTrSOBsfHLQRIpW512Z7GS5l2jNggyHAkeldapIRarNG2W1XHr9DKXJYGHtMbegPiMkgzU75FicaMtxr8VzPEUjAA+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/a94fw/UDkCnJhjkgpW/L0CEo+uD+Jq0ukeECfqhJg=;
 b=eOSvIdhQ1Hk85mdkBwnldNmPUPhvo84/BMxuPb9uW4z7bRgYTnJHih8WmTi4wp+Y9FoZDRmEHR6115q4bPlELVWa31hWKPh0EfTAP9JMB+jkrl/sMbBq0t/I88eAibw88IP1i9d32O326eY+J78stymAVHz6/ru9hiIZLv9r3X+NzlZ8/WKrWRyt6d6aPAt62h5/bud6iwW9V9HLLbRUlPjof6aUs7OFIouKaSpQdLCuSbVvvhWQ3CdeCSy10jfae7Zv3F9bs6fW237a2ZsFH7EbPFJjZ1O+u/EUI5huP/WAsfkrH6KwfudGAOrQnFdO2mP39wWaqE3c8+CAvWet/A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA0PR20MB3360.namprd20.prod.outlook.com (2603:10b6:806:98::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 22:37:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 22:37:16 +0000
Date: Fri, 7 Jun 2024 06:36:53 +0800
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
Subject: Re: [PATCH v2 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <IA1PR20MB4953FE4721CA7DFB617282BBBBFA2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <SG2PR01MB4218013241B3EED779D3BAE8D7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
 <SG2PR01MB42187EC277384F84A3126F0DD7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR01MB42187EC277384F84A3126F0DD7F82@SG2PR01MB4218.apcprd01.prod.exchangelabs.com>
X-TMN: [lkC4jG9DAE8r8FxJ4CsLbeTRI6S2XQSDo13KYdFChLQ=]
X-ClientProxiedBy: TYBP286CA0034.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <vtjfu4fwyqvuyz5pd3vsz6zn2fkko7ekpsub2tcyrqcvi7hgea@nwislzs6dnvr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA0PR20MB3360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a13712f-4a01-451f-7435-08dc867937c7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	X5odPEZo9Ak9BphtSrAKb/bnz1zFEPdU/IS3SUdkivO1kUPmGQJi4a2t1LQ7hdbq68MRygW8oojcKojGi+vWf2ths0PZMUJastpj0wwELENbIcF44s0SBROemDVsDcmHhSgFZGxtY/JcQTA3mX1tXgI3JTrYxn8CyWmchbVGObmdxs7N4xHDlKgKOAswsFZC1V7wZTSbIY4TCz5CGj5sHkE/kxXil47rExIBayL/zOs/zfLGHj5R0ZVl+nUBtO0O+kr99kN/Sl9Os4OKJK6MiDMbBd719P1e+OWWp6ya0WyheMyHVZFyzDNq1XgC8Wa3tkOEkwtpJ0SbK+mRsKkPC5fiODBTQ7dr9lS80cCWjwpMNTJdyWbSr4WDBtpHtALJBTblGoXinS6Bo4mKDKrBzUUWuhQ707B3t6R+xBHheK5yknSkTd9qFGRWlcTnjqlw1FZRAfh/pwxY+G00BOwPz91r1hFDN5v/sldfh5wZsYc62y5eKNBb9Yxjqc0Xh5+nkDObVtVgJY6Oi36Tm0zOB3rfworJ0aOrPk4LfcRBZvKnctS15g7ZzcDGavL3PGaXTKHgCsNeBlDYSPx13oTIOOHzR5+viCdJOeuNLXbgFyVg9MsjKtfiCQZhJIq4Kq9N
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GPdCmcPPOcdkUorVMVDwqXUDv4EUPcBzSCXIpobsPZJ9BPRrv0kTQ7uGDCxU?=
 =?us-ascii?Q?MFIqSeFpkNBCkDmYxgrH0Ex1Ll2CEJhQq8zt09iBIECodYGZl8w5NxjiqqBq?=
 =?us-ascii?Q?Dn6yVXSobBlTOI2Cdvu3m5+yb8c5Fm0gEIDl6gjAsELlToxFbOEbz9HgB/xU?=
 =?us-ascii?Q?C3999dVH4+rOkdLjx5iuXxbNE9kxZ3TEzJ7rkGkaHAh3av1xG+Jd+O0xWOoG?=
 =?us-ascii?Q?2prLd21CDduCIC3ASBmUnZO1oDl/9DAWPd0+kDvrwplu52n9KG1T/4F1qgxR?=
 =?us-ascii?Q?zNGT6Bp1MbdQMG1ZANqjNmfS8WF1a7GfmmPOU4KCIdPmo2KhYAouHPZQhaTT?=
 =?us-ascii?Q?XjdWoUIMTw1YFDl2ipbOBUvuhpewaffQZ8RANNqWUVlL/KMDQHXNsQT2EqvS?=
 =?us-ascii?Q?7TGk1lvpnwGW9XPI5XKU2raPUJWoWmad+soMyf+wu8cUaZFIdhkJ5vmg4BKV?=
 =?us-ascii?Q?elk+zPGQgFGdFIMBauDVnM4x7cCEb+jcMgma66pyNR9BKYPG3BTpHLruZZ+A?=
 =?us-ascii?Q?RFh5DLIcx9Eo3X8ZZSCMSP7zrMWkDWWXZld4s1CUKCHxvlZPEXFR8CDJ4mDm?=
 =?us-ascii?Q?RmJ8Zw+uwcq2rrMFlvXz4M+LLshSvg24tuxthYlpZKQ01q6lNER3vyRNgv+o?=
 =?us-ascii?Q?8bTbp+KljYO0bFq3QGHAXq7reabl5mp9BrGkZipRk+zqwhlFsI1L0USyFD6b?=
 =?us-ascii?Q?V4heAjeU1tF5W8CNuaL7Vq6m+UHmjG3NO2LxLEjfXbZtWuGGRqh7cc0QkmO2?=
 =?us-ascii?Q?v7HbUhXDwfOnL5u+lvUYvIwvlCjhtB3QY1yUq1FlOwCruq2mEqTW2I94A2gI?=
 =?us-ascii?Q?kxloo3Baqzx/d4RS5oAsj7yf7pg0UAlyzsmEfCaugtbUjXlwq0yABYEopVYD?=
 =?us-ascii?Q?koeCmW8ZRTv6nXFnmMOEtFfys+hEC8DnHIThILR7NI0VJ8E3bsRCo8F7TMd5?=
 =?us-ascii?Q?4GWgrUvMaP6g3tGy16dY3IdwA0ZWNHQ02tnZPvxICjeNO3dRq7Cer5XZYsYV?=
 =?us-ascii?Q?9tH70sH7axKBiUAqd4sJKTE+wcB9SXK/dRrLyvaydtEsW+Uxc/eV4vg6okyy?=
 =?us-ascii?Q?NobdsvZiD3oBjoDq94ULUndS71f749lMP2WmFYvArxxDBF/WKqPeVNdnjQXz?=
 =?us-ascii?Q?P2bgXAtv6jBJIUGP1XfdGTPi0RhvAxQBvf13hYQO+72mBZceps+R57MBhVT/?=
 =?us-ascii?Q?YjeHV/0kYU/07HDZa8ZybCpGSLiTJYINvpdFwIkXUR1RiEHs8MQ/b6G7Fvpz?=
 =?us-ascii?Q?z6kjDW0JmScJtTF6nXCR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a13712f-4a01-451f-7435-08dc867937c7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 22:37:16.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3360

On Tue, Jun 04, 2024 at 12:54:21PM GMT, Haylen Chu wrote:
> Add support for cv180x SoCs integrated thermal sensors.
> 
> Signed-off-by: Haylen Chu <heylenay@outlook.com>
> ---
>  drivers/thermal/Kconfig          |   6 +
>  drivers/thermal/Makefile         |   1 +
>  drivers/thermal/cv180x_thermal.c | 262 +++++++++++++++++++++++++++++++
>  3 files changed, 269 insertions(+)
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
> index 000000000000..89425e2b75a2
> --- /dev/null
> +++ b/drivers/thermal/cv180x_thermal.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Sophgo Inc.
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
> +	u32 chop_period;
> +	u32 accum_period;
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
> +	regval |= ctz->chop_period << TEMPSEN_SET_CHOPSEL_OFFSET;
> +	regval |= ctz->accum_period << TEMPSEN_SET_ACCSEL_OFFSET;
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
> +	u32 divider = (u32)(512 * int_pow(2, ctz->accum_period));
> +
> +	return (result * 1000) * 716 / divider - 273000;
> +}
> +

According to the staff from Sophgo, the original formula is just done 
by curve fitting. And the formula is not affected by any parameters.
Those parameters only affect timing.

Although this is still uncertainty about how to calculate the temp,
I suspect you did not test your patch well, and the formula you wrote
is obviously broken. Please test your patch in all conditions.

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
> +	{ .compatible = "sophgo,cv180x-thermal" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
> +
> +static int
> +cv180x_parse_dt(struct cv180x_thermal_zone *ctz)
> +{
> +	struct device_node *np = ctz->dev->of_node;
> +
> +	if (of_property_read_u32(np, "accumulation-period",
> +				 &ctz->accum_period)) {
> +		ctz->accum_period = TEMPSEN_SET_ACCSEL_2048T;
> +	} else {
> +		if (ctz->accum_period < TEMPSEN_SET_ACCSEL_512T ||
> +		    ctz->accum_period > TEMPSEN_SET_ACCSEL_4096T) {
> +			dev_err(ctz->dev, "invalid accumulation period %d\n",
> +				ctz->accum_period);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (of_property_read_u32(np, "chop-period", &ctz->chop_period)) {
> +		ctz->chop_period = TEMPSEN_SET_CHOPSEL_1024T;
> +	} else {
> +		if (ctz->chop_period < TEMPSEN_SET_CHOPSEL_128T ||
> +		    ctz->chop_period > TEMPSEN_SET_CHOPSEL_1024T) {
> +			dev_err(ctz->dev, "invalid chop period %d\n",
> +				ctz->chop_period);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (of_property_read_u32(np, "sample-cycle-us", &ctz->sample_cycle))
> +		ctz->sample_cycle = 1000000;
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
> +	ctz->clk_tempsen = devm_clk_get(&pdev->dev, "clk_tempsen");
> +	if (IS_ERR(ctz->clk_tempsen))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
> +				     "failed to get clk_tempsen\n");
> +
> +	clk_prepare_enable(ctz->clk_tempsen);
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
> +	clk_disable_unprepare(ctz->clk_tempsen);
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

