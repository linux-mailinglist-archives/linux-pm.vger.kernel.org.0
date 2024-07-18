Return-Path: <linux-pm+bounces-11222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8EA93484A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 08:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0001C20F89
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE314D8BA;
	Thu, 18 Jul 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ExTwYY3n"
X-Original-To: linux-pm@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19010001.outbound.protection.outlook.com [52.103.64.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98F1B86F4;
	Thu, 18 Jul 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285365; cv=fail; b=t9qjUnXvjNhyC5cNwUbljE5RdWdxuBjBvj/7Dez3khoa6H3N2WPrdqjL2aXGkRwVSv5RFZt6d46b4ZqsnwPlpKlqqsGOu3rmfg3EDH3k7D9r54dJDMCiwvAfvQAlG7gapxxnxpqa1TKE9jx/VNFLtbki4nR9T3ZrE9dxEIZ+/54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285365; c=relaxed/simple;
	bh=gKZiYNFYfUmIZEgix1/dihAuwJw6+yilHC7kXF/g44I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dkAfmz+6mM9IBR96Pngj+L/He5ZbC7cEpo8OAv81nGKThry2OHbvLRZYizx+Q4JDtASaBjJu1evIKCWo0gRd5z4IzPRDQZtufBI0RmzDWMfHy2wdYCJeaX0J11YvcPD+Igzv0oH3HolceJMe5qy+TF4AM3AQt8u0bgDLxPE9jD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ExTwYY3n; arc=fail smtp.client-ip=52.103.64.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2bt83dpi66V9jinXXEaV0QEfanTDi1MWXM3r9oKbnq283P6V+VeAfIotj+xQfaHGK1HkG1sg9TBT+1n5QQq9aG991WIi84iHyWSP0I5/eOWSMCAGNvLfTEUCYtZO9wlkWZcIqwA09ItYl777rtxijX1sQhSlMwUyXthN6Na6WTQUTBVUQIyqAQPx6kwU9yF3jXrwSBQUlRqAYk6+0u/gGsEQtENBGki3/1nTIeAqoZ+g0IfL7xg7ygk1e0q52WnjfWNIICq4SbfzfJ1CBm1m5OXOSnV/+8yPa4x+yo990VYWYk1c6l2i+bPDGom8+mF+mRGyzpJ7LT5rlw+7jDYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dj1dCUGHPuDcs8f5L48a8MYf7ZqslST0r1An7BNp0E=;
 b=bwOT8xUGIVoU2TxGrERlIp6OSO588W7ohkqPl6HPP5I8VWEgKW/kv7IjkrRv0GKQsl5kb9UBJ6DH/qj0o6shCeeCDI6sxFpAl8OLblnl/GUeqgaC8jV3Qgnp44cELhIpukA3JfzcEV8H2DKM43vJhDOvHxG/LPGK2ewY3UPBziysgNCASL92F3dTxVGj8f8boLapmcnA+GkDDnd2koGd/k96Hxv1dPLnzy4OuK8Z0kyOUWWCUuBXhfgMMhMGEvAbYiycz6zydymX30tVKSvyqTy73ESSHMkKxD6JXdvzlNbv/MA20vjSSb0bK9Mcaht3j1YcQl0JYXOMYpTSn4dBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dj1dCUGHPuDcs8f5L48a8MYf7ZqslST0r1An7BNp0E=;
 b=ExTwYY3nMnJexZQp3GbQELkabPaPJwr0UxP57NSFdZScOSxTShKqvEyEFOYPZObC6lmc3GwRX0PxR3z7ufLUtaPsdbdZPh87r2BSP5DhMc6AmMXt1u6rPihoHHw9bR2BiHiK+PoK2Xk58YOFC/apglCHSaH4WFqPmgfSmF2lObe8C0blHu50fHaLeDrf8VXuqynXj1yGbwnHYIrBiIxWt0M3Fq3wFL2PraCs3enJe9P3x38C8hqEb1k/+RFPomRqZBlFhyjHv0AumCVnVMmThaBj0mGOHEOPIw31NSCGCvThf1aUmVKfqPqdwzhEfldMUKoDIylJHtN1brA5STK1Mg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYUPR01MB5399.apcprd01.prod.exchangelabs.com
 (2603:1096:400:356::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 06:49:14 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 06:49:13 +0000
Date: Thu, 18 Jul 2024 06:49:05 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Inochi Amaoto <inochiama@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <SEYPR01MB4221611E6BB87C70B30999E5D7AC2@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <PH7PR20MB4962DD8526FF0845258ECE2FBBA32@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR20MB4962DD8526FF0845258ECE2FBBA32@PH7PR20MB4962.namprd20.prod.outlook.com>
X-TMN: [I7SB39OJtPOmW025sWfm+fva033bMFH1]
X-ClientProxiedBy: TYAPR01CA0235.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::31) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <Zpi64YtcgEdgnzyi@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYUPR01MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8cf5f3-eb67-4605-82e7-08dca6f5bb97
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	JetZF8Z600j+EkNX4lWaIShNKjL4xbb1tj9x/G1xyFoBWE4vCheC/KKddu/BCry/uWYbauOExiJGoefBmFWkhUqmyRu1QJUrD7alTiwXQnpEpwj5u2SZ/xf9qzG7XImPjVA0+XdkmyfwZF13A0IT3u0rR7E0BYwzi1JsOvWmFtSF+DGTYiWh5SnnI5bC/YstwrFPsvUcKl+r01SQfrVrorsE91BIC77O1glyHGM+qOn8lNlTHWP6nPUC/XJ1U/1++VCElGTWYJW+O/M9Kf0Ij4w1SHT7sss88WlLWl3GEmxYI4iP3J/84TQfK62cUGKcbUqR2H5RE3YOGOw3ALtUKGi7bdJ/RJ1AezLS8JmMrKrttdcHt/XGgO4yTt12lxJbF8noptMPNedq40xucsOqtV1qHogNGcIzUPScrwmGScEi7QpCra7/ivnw2zh8mqeUqzHNgwhJ2ou50i7De3eoJwlTSSaMCM/B2S5fm97Z0d05SJa2j3a4FhwTc7xK5X/5vZSqEBUZtJwgf4ayBXgihVq5FntDihkcIzvcy77XCxVe2abfqzMOLPMOsyNJvsir5QOigOkTPpTUCJ9Wqz4fdQxd2B2D4bTjRqq1SkqGQKo0YoLzZjbVrNdMREykgd2KwZFp+6tF14alBn8jjPl4Fg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/dM9NBgsy2x7UeubXbOFyLYwXE8P16gEEZ3zY/2uatqySvWm9hy/2dkNQoPK?=
 =?us-ascii?Q?UWtcJHbDyTjMhC8gkSxHl/j4k9sJa+KbhjsU8mKxZNLKTrd7HkpKwM5C6laC?=
 =?us-ascii?Q?uWZd0FPZtP47H+L8z1Su6w62UIgJV30EGnhveqiqcPp5qJ0T1uiAm6vrxHIV?=
 =?us-ascii?Q?GOYcYBO+4nRftmosK5/WCkjWdW1+ZfRCquY9C0lOO+i+RKRJRX47PlN8tZaA?=
 =?us-ascii?Q?q8GoF0Qp6OfuouumlrrlA3VkR0tPoKtbCBwm06yruch0f4BUNIi0lQP6OkWU?=
 =?us-ascii?Q?wIkyywEO9QKN7NblYH/9I5rJmu4muxsmo4xSXHJHv3SIf+o91wdWO574HVZQ?=
 =?us-ascii?Q?H/mC8mGieadwt7Xp2dYFGczpgL9GcZtm9abJm2Eg85T7teuf2ipRqxNVJmgt?=
 =?us-ascii?Q?ewbQ4VUzKA5Zy0mDdAdw1/POCKXIWn4aOMQ+vYyFZzdlrV07Xg5AQxKzx403?=
 =?us-ascii?Q?krwryQMO116PGtuttbpjTeYoy7E5sdIJRjSIDMNSZYzPmL4TJl92U9v5Ofl5?=
 =?us-ascii?Q?ubYkjHFCLljWwKMvQRj9qzJF8bB8ZmZZhk4/Emg9l0djCi817/POjx+R7tc7?=
 =?us-ascii?Q?UcunxQxhRmX1zTTDD1s1y+pY1WSjSyIeKvPYoS7SYp4mKjqE2LBrQ2fzif0d?=
 =?us-ascii?Q?+Th3o57zPxFh7YlvVgiSwWiI5XshsvvjS/kFyVIUN2q/L6SSAmySidN4hCx+?=
 =?us-ascii?Q?9BZUl0gROXRmeYAKaLWuEqpV9IoxdIOFnpn1hO7klEmtecDelnfDIwiiJV+r?=
 =?us-ascii?Q?kh4/KggOwvmRPb1L6ATTu0cbOLwErc9PNyLGBegRLEglLPdAM1/h/CbO0tu3?=
 =?us-ascii?Q?yz0Y1xgEcj8QCxvoRuWKbk4+Xu/6eBaWmj65koWmqVD0HtEJvEeYlFTt/8XZ?=
 =?us-ascii?Q?aDlZ0eyFeXh1ziWBifco8GKpq9+miJ1D4EQa5T5JhvvNSH9kOSxlY+WXuwXP?=
 =?us-ascii?Q?Gt1p3pIbpJrzsFIIbAdxDhVXFzyhm6r9bAQjJynx05o1TcbWq6jSfFWBHMHg?=
 =?us-ascii?Q?37xr1qz4FGjqh/dL0cjPjti4CB4nbDOj8mrymoVuM/d6JJCaYsuLVfSawRCt?=
 =?us-ascii?Q?ESOuHZXbNFnyAC5dXZ3xa1fCHcuI8Ws8JPaANJBfJvXLXPV3eIrfbqXNY5Ej?=
 =?us-ascii?Q?f36AmVMEGfbuYez0TZtWc1s+gzPAPwIR3ZmvnjIy/ThUm3CwkcxCH0isPAOQ?=
 =?us-ascii?Q?JBoNKtrfn0uKWNxFopCwpovzpffqaBorv9QWpj0ZKvrsMnrkO3kr6ot1Q8U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8cf5f3-eb67-4605-82e7-08dca6f5bb97
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 06:49:12.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR01MB5399

On Wed, Jul 17, 2024 at 02:22:32PM +0800, Inochi Amaoto wrote:
> On Tue, Jul 16, 2024 at 09:42:35AM GMT, Haylen Chu wrote:
> > Add support for cv180x SoCs integrated thermal sensors.
> > 
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> >  drivers/thermal/Kconfig          |   6 +
> >  drivers/thermal/Makefile         |   1 +
> >  drivers/thermal/cv180x_thermal.c | 241 +++++++++++++++++++++++++++++++
> >  3 files changed, 248 insertions(+)
> >  create mode 100644 drivers/thermal/cv180x_thermal.c
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 204ed89a3ec9..f53c973a361d 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -514,4 +514,10 @@ config LOONGSON2_THERMAL
> >  	  is higher than the high temperature threshold or lower than the low
> >  	  temperature threshold, the interrupt will occur.
> >  
> > +config CV180X_THERMAL
> > +	tristate "Temperature sensor driver for Sophgo CV180X"
> > +	help
> > +	  If you say yes here you get support for thermal sensor integrated in
> > +	  Sophgo CV180X SoCs.
> > +
> >  endif
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 5cdf7d68687f..5b59bde8a579 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -65,3 +65,4 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> >  obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
> >  obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> >  obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
> > +obj-$(CONFIG_CV180X_THERMAL)	+= cv180x_thermal.o
> > diff --git a/drivers/thermal/cv180x_thermal.c b/drivers/thermal/cv180x_thermal.c
> > new file mode 100644
> > index 000000000000..8b726c0ad848
> > --- /dev/null
> > +++ b/drivers/thermal/cv180x_thermal.c
> > @@ -0,0 +1,241 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2021 Sophgo Inc.
> > + * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
> > + */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/thermal.h>
> > +
> > +#define TEMPSEN_VERSION					0x0
> > +#define TEMPSEN_CTRL					0x4
> > +#define  TEMPSEN_CTRL_EN				BIT(0)
> > +#define  TEMPSEN_CTRL_SEL_MASK				GENMASK(7, 4)
> > +#define  TEMPSEN_CTRL_SEL_OFFSET			4
> > +#define TEMPSEN_STATUS					0x8
> > +#define TEMPSEN_SET					0xc
> > +#define  TEMPSEN_SET_CHOPSEL_MASK			GENMASK(5, 4)
> > +#define  TEMPSEN_SET_CHOPSEL_OFFSET			4
> > +#define  TEMPSEN_SET_CHOPSEL_128T			0
> > +#define  TEMPSEN_SET_CHOPSEL_256T			1
> > +#define  TEMPSEN_SET_CHOPSEL_512T			2
> > +#define  TEMPSEN_SET_CHOPSEL_1024T			3
> > +#define  TEMPSEN_SET_ACCSEL_MASK			GENMASK(7, 6)
> > +#define  TEMPSEN_SET_ACCSEL_OFFSET			6
> > +#define  TEMPSEN_SET_ACCSEL_512T			0
> > +#define  TEMPSEN_SET_ACCSEL_1024T			1
> > +#define  TEMPSEN_SET_ACCSEL_2048T			2
> > +#define  TEMPSEN_SET_ACCSEL_4096T			3
> > +#define  TEMPSEN_SET_CYC_CLKDIV_MASK			GENMASK(15, 8)
> > +#define  TEMPSEN_SET_CYC_CLKDIV_OFFSET			8
> > +#define TEMPSEN_INTR_EN					0x10
> > +#define TEMPSEN_INTR_CLR				0x14
> > +#define TEMPSEN_INTR_STA				0x18
> > +#define TEMPSEN_INTR_RAW				0x1c
> > +#define TEMPSEN_RESULT(n)				(0x20 + (n) * 4)
> > +#define  TEMPSEN_RESULT_RESULT_MASK			GENMASK(12, 0)
> > +#define  TEMPSEN_RESULT_MAX_RESULT_MASK			GENMASK(28, 16)
> > +#define  TEMPSEN_RESULT_CLR_MAX_RESULT			BIT(31)
> > +#define TEMPSEN_AUTO_PERIOD				0x64
> > +#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK		GENMASK(23, 0)
> > +#define  TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET		0
> > +
> > +struct cv180x_thermal_zone {
> > +	struct device *dev;
> > +	void __iomem *base;
> > +	struct clk *clk_tempsen;
> > +	u32 sample_cycle;
> > +};
> > +
> > +static void cv180x_thermal_init(struct cv180x_thermal_zone *ctz)
> > +{
> > +	void __iomem *base = ctz->base;
> > +	u32 regval;
> > +
> > +	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
> > +	writel(TEMPSEN_RESULT_CLR_MAX_RESULT, base + TEMPSEN_RESULT(0));
> > +
> > +	regval = readl(base + TEMPSEN_SET);
> > +	regval &= ~TEMPSEN_SET_CHOPSEL_MASK;
> > +	regval &= ~TEMPSEN_SET_ACCSEL_MASK;
> > +	regval &= ~TEMPSEN_SET_CYC_CLKDIV_MASK;
> > +	regval |= TEMPSEN_SET_CHOPSEL_1024T << TEMPSEN_SET_CHOPSEL_OFFSET;
> > +	regval |= TEMPSEN_SET_ACCSEL_2048T << TEMPSEN_SET_ACCSEL_OFFSET;
> > +	regval |= 0x31 << TEMPSEN_SET_CYC_CLKDIV_OFFSET;
> > +	writel(regval, base + TEMPSEN_SET);
> > +
> > +	regval = readl(base + TEMPSEN_AUTO_PERIOD);
> > +	regval &= ~TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_MASK;
> > +	regval |= ctz->sample_cycle << TEMPSEN_AUTO_PERIOD_AUTO_CYCLE_OFFSET;
> > +	writel(regval, base + TEMPSEN_AUTO_PERIOD);
> > +
> > +	regval = readl(base + TEMPSEN_CTRL);
> > +	regval &= ~TEMPSEN_CTRL_SEL_MASK;
> > +	regval |= 1 << TEMPSEN_CTRL_SEL_OFFSET;
> > +	regval |= TEMPSEN_CTRL_EN;
> > +	writel(regval, base + TEMPSEN_CTRL);
> > +}
> > +
> > +static void cv180x_thermal_deinit(struct cv180x_thermal_zone *ct)
> > +{
> > +	void __iomem *base = ct->base;
> > +	u32 regval;
> > +
> > +	regval = readl(base + TEMPSEN_CTRL);
> > +	regval &= ~(TEMPSEN_CTRL_SEL_MASK | TEMPSEN_CTRL_EN);
> > +	writel(regval, base + TEMPSEN_CTRL);
> > +
> > +	writel(readl(base + TEMPSEN_INTR_RAW), base + TEMPSEN_INTR_CLR);
> > +}
> > +
> > +/*
> > + *	Raw register value to temperature (mC) formula:
> > + *
> > + *		       read_val * 1000 * 716
> > + *	Temperature = ----------------------- - 273000
> > + *				divider
> > + *
> > + *	where divider should be ticks number of accumulation period,
> > + *	e.g. 2048 for TEMPSEN_CTRL_ACCSEL_2048T
> > + */
> > +static int cv180x_calc_temp(struct cv180x_thermal_zone *ctz, u32 result)
> > +{
> > +	return (result * 1000) * 716 / 2048 - 273000;
> > +}
> > +
> > +static int cv180x_get_temp(struct thermal_zone_device *tdev, int *temperature)
> > +{
> > +	struct cv180x_thermal_zone *ctz = thermal_zone_device_priv(tdev);
> > +	void __iomem *base = ctz->base;
> > +	u32 result;
> > +
> > +	result = readl(base + TEMPSEN_RESULT(0)) & TEMPSEN_RESULT_RESULT_MASK;
> > +	*temperature = cv180x_calc_temp(ctz, result);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct thermal_zone_device_ops cv180x_thermal_ops = {
> > +	.get_temp = cv180x_get_temp,
> > +};
> > +
> > +static const struct of_device_id cv180x_thermal_of_match[] = {
> > +	{ .compatible = "sophgo,cv1800-thermal" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, cv180x_thermal_of_match);
> > +
> > +static int
> > +cv180x_parse_dt(struct cv180x_thermal_zone *ctz)
> > +{
> > +	struct device_node *np = ctz->dev->of_node;
> > +	u32 tmp;
> > +
> > +	if (of_property_read_u32(np, "sample-rate-hz", &tmp)) {
> > +		ctz->sample_cycle = 1000000;
> > +	} else {
> > +		/* sample cycle should be at least 524us */
> > +		if (tmp > 1000000 / 524) {
> > +			dev_err(ctz->dev, "invalid sample rate %d\n", tmp);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ctz->sample_cycle = 1000000 / tmp;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cv180x_thermal_probe(struct platform_device *pdev)
> > +{
> > +	struct cv180x_thermal_zone *ctz;
> > +	struct thermal_zone_device *tz;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	ctz = devm_kzalloc(&pdev->dev, sizeof(*ctz), GFP_KERNEL);
> > +	if (!ctz)
> > +		return -ENOMEM;
> > +
> > +	ctz->dev = &pdev->dev;
> > +
> > +	ret = cv180x_parse_dt(ctz);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "failed to parse dt\n");
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	ctz->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(ctz->base))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->base),
> > +				     "failed to map tempsen registers\n");
> > +
> > +	ctz->clk_tempsen = devm_clk_get_enabled(&pdev->dev, NULL);
> > +	if (IS_ERR(ctz->clk_tempsen))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(ctz->clk_tempsen),
> > +				     "failed to get clk_tempsen\n");
> > +
> > +	cv180x_thermal_init(ctz);
> > +
> > +	tz = devm_thermal_of_zone_register(&pdev->dev, 0, ctz,
> > +					   &cv180x_thermal_ops);
> > +	if (IS_ERR(tz))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(tz),
> > +				     "failed to register thermal zone\n");
> > +
> > +	platform_set_drvdata(pdev, ctz);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cv180x_thermal_remove(struct platform_device *pdev)
> > +{
> > +	struct cv180x_thermal_zone *ctz = platform_get_drvdata(pdev);
> > +
> > +	cv180x_thermal_deinit(ctz);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused cv180x_thermal_suspend(struct device *dev)
> > +{
> > +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> > +
> > +	cv180x_thermal_deinit(ctz);
> > +	clk_disable_unprepare(ctz->clk_tempsen);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused cv180x_thermal_resume(struct device *dev)
> > +{
> > +	struct cv180x_thermal_zone *ctz = dev_get_drvdata(dev);
> > +
> > +	clk_prepare_enable(ctz->clk_tempsen);
> > +	cv180x_thermal_init(ctz);
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(cv180x_thermal_pm_ops,
> > +			 cv180x_thermal_suspend, cv180x_thermal_resume);
> > +
> > +static struct platform_driver cv180x_thermal_driver = {
> > +	.probe = cv180x_thermal_probe,
> > +	.remove = cv180x_thermal_remove,
> > +	.driver = {
> > +		.name = "cv180x-thermal",
> > +		.pm = &cv180x_thermal_pm_ops,
> > +		.of_match_table = cv180x_thermal_of_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(cv180x_thermal_driver);
> > +
> > +MODULE_DESCRIPTION("Sophgo CV180x thermal driver");
> > +MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.45.2
> > 
> 
> Where is interrupt handler? I see nothing about it.
> 
> Regards,
> Inochi

Interrupts are not used. This driver implements only polling the
temperature.

Best regards,
Haylen Chu

