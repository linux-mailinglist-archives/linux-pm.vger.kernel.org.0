Return-Path: <linux-pm+bounces-11198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD0E93366B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 07:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF4E1C20F82
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 05:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8188D51A;
	Wed, 17 Jul 2024 05:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pGRVq0tF"
X-Original-To: linux-pm@vger.kernel.org
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazolkn19012059.outbound.protection.outlook.com [52.103.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431907494;
	Wed, 17 Jul 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721194377; cv=fail; b=YuoiVu3nGJn4H+onNfHzdzqp557pEHUwlUvNpn92NsxqaSSxPS6CBRtpI5suUfALu1nx51Io+8cSbz9Pfb/p3WP+19xkBX39wwKlg/nsCvpMjYqI8sxNuPc1s0D3FH0rDuchvAzgpfkfv3c6w3X83/J093+ej1nJ6ahOqfv1Pec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721194377; c=relaxed/simple;
	bh=iMgynuDK6lZIAbzwKFrkLPA/4dQD0Z0dId8Z8P+XcoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n3J25UfwnlpSQtP1m1/9NoLUoJYbRhPh/bCB1eDQayi9meDqHdJpSEWqi83pxUAPY6z1rFZ6zZdZGouRwsvbOOC0XzrLc1AFXgfZQ0KI7AVFKbAEQiZkKJxzWZhaggcJBuGsMrjwSAfZXVv/lXpI7CRSLF8YimiQNYLFi5Vf/ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pGRVq0tF; arc=fail smtp.client-ip=52.103.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpkQgZhaJVLkL9twGN56kMNpwfHAuDwKKJV3yVNL08sS/L5DqODnV0e3YhgynrJsvO0ZTgTWJYyzdCCWeosCwqvh3a8BKyZjOFAbFzsUV9Lc+CWfo7KalLkrOpD8DL8LwHu0yggzO++jx0+2M/cz80aohpiAYouOcQajL2yKV/Xhx9akB19ysO8t0+EjWmH5/wIIP/tlEgQu2/x8Hethj4nb3Nba347ZxpMEBIUiXc3YbJMeDw+CH0LA4mRtLH+KOcq8phdOnWuOwhcxVa2y5xvRCowoSn0Y0cHKnHSMk3DhpY9aUYRz+OcFFC/42mQs4s/bYEhBKTQP0DFt+G8JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RxWkJZTcKURDbO+N8vL7ANyVn44DujFEi5Bee/8m8A=;
 b=G+lpaUdIN4hLkvCQCwzSpBHQLTpZZE5siWY2EHfcyUw6CwA6Tu3d2wvRBNmOIDpu+3yyGQxpVuxvfpAHBJ2eJcu+dFJvtRBJDNU0KHwPZLRBjGdZm08MZcsYoPV6SppXgywPKFXPH3irlUtRvb7A1nW9QCkRe4Xem6iF8jhbBW68DoDJWn9SvQbQ5Fk8KOCJqNID90cw2Fvv2rRGuoSZ/ISscFue/R4n4rYQs7hhfUB+w7zOkLJRZ2amFdxVxqFP430UMtKet+EiaBcBrgD5Dbqdgk//NAWiEpfpm+CTXHzBP0tEQ7ioQfem8SJ5v5JErW+prvV6qdkyPCayfhwKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RxWkJZTcKURDbO+N8vL7ANyVn44DujFEi5Bee/8m8A=;
 b=pGRVq0tFapwob0T1o+M5d3PbzFJ2K93pxP7C3wcVvLW3aF+RDc0yKRpf8tqWTsfzINVzaOzZpqYHpye8ydSKWAVw8TKgb17Eci/7qsM9dYBygaFRghqhr5FqYIKf3DlWAirjaF+Cw/18RaxFB3SzMrpnYfXoEfcuZB/xVTL7i0FaeMR8kKNUocZQUy/SNqoUIjnV+kiICoobENbcCvlP5/FwVRnute4Ypo+ZfztvlgaC5UNth5BRAet0PtDb/Uio0Q8WSxqInn4G+oQjSCeh4yQT6VK0fpMcA8LR+Qrrv8vfx88HRcyj9nrrQKAmLkbRs8uETL3cHAbvmBGANWQXGw==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4847.apcprd01.prod.exchangelabs.com
 (2603:1096:400:285::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 05:32:48 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%5]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 05:32:48 +0000
Date: Wed, 17 Jul 2024 05:32:41 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] thermal: cv180x: Add cv180x thermal driver support
Message-ID:
 <SEYPR01MB4221CB9833191B3177523A07D7A32@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB422158B2766DA03728AD90CBD7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <SEYPR01MB42215C6F248AF99499F6A050D7A22@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
 <MA0P287MB2822B966D31B16B6C4853C8CFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822B966D31B16B6C4853C8CFEA22@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [dC1L4SaGo5rJjqocmeG01RS0IUASHVyq]
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To SEYPR01MB4221.apcprd01.prod.exchangelabs.com (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <ZpdXechiDP0I0DUw@ketchup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0cfeb3-10ea-473c-8f4f-08dca621e474
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	fbQr/OxUZhimmEBZgjuUN2uEu817uC4Th4UR8yUySv5x8A2DO9y3/O/IygxFkWxr4H8+JuWqcZ+PXTmM5KtgEZr3h8fEbL60jCEuZQaSgPl7w/KKY4rIECK2vPJp3QvZteuTsvFAlP5v70TIl/DdMX8jiGXKr1O59hNCDdfjkPbK2Ao5etPf0ND/YGgc9iJovUWE9bBQMNEP/AVOtxuNnR46bewwRZFNKXo8acc+0q66u3dKbnCRJuQErEzGyhG5pPBvNgxAv+eA8VayREtW2pr83Hkm5V/PPoAFmfUCay5/LViRNPKQd18gaKCsJLZsvJGqZYG6wyyy6VLkfEVrWHfDyXPkMVPGx4XOCwBUR5P/8xNrPCMpO4vU5FBNsMKWmdkT4LF1Y7Dpcxg012s41O38GiS3Y42XAORnf10RAWxR++dmGu4OO9blSCrBQetlCeMPMEEYYlaZqhVzCcB/ZjOLyd+rEN0Pc4HLFzlW+b7a9ssC497ULq+mu6cktbq5IuAbhG//2lzREKrgvGjo32KL8q2DJmQDsHX4VV74IfJvd+Z/ehlOdK9sxfnTPf+mWSzlMXkhrkx/RBBRPU0Qcxuc7N/Q0AEF9sXaL7pAsevtIHTykjoVzgQsz63XC+BTQViCgcDtSVnYBcwRN+1Tig==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCESIDOil2kdnc4yroopfnSWYaU5mZFeFQXszZI/fAh6hQ2NEyZIQHH8MRro?=
 =?us-ascii?Q?5eieYkKSyxF86P0nUfM/GMBqRpubi7GEDPpn4wR4HSTrz91a74fgWVsBN67l?=
 =?us-ascii?Q?EifsqDbuynOBxj7uO5MMuY6FG8eOC/RZa2tbzFvLIV8ChTdBrVsV8expfTjo?=
 =?us-ascii?Q?qrosIFmn7rebxvsNthp9VZQv9TL11Bd0yTfNH5qQ8DQNP9VYAV66RHD4LegY?=
 =?us-ascii?Q?BA0Bw2aJrY73D/KlWglQ13qvcc84zw+sQMm3qMWsdqY3ZjC3AGVU2ar/3qch?=
 =?us-ascii?Q?DWgtqUUQ/cwZqxp+xmQq2WnO+0vG0nxaFTYTS47/eJJIf4Y8O4cEuF1C1Zmr?=
 =?us-ascii?Q?W4VltaXbmFFP9j1FkmANfy+N7XZNLiQ8E/MjvQR9ELNEA7mM6RxcheCotRTK?=
 =?us-ascii?Q?XtiRGUYHQeI/ZiyUtyp1AB4d0K0V30T8yv91zhfQYRoKlTtwdP5bvNm1DD/H?=
 =?us-ascii?Q?C1rM6K4LOjnmZI3ayasSv+2XQtv5IOJuYutAQnupt8U6CHoG2k9uhXKzyIMC?=
 =?us-ascii?Q?hGrO9Hpt7NWpgAKNHUtf2ngRTvAy+gLnCJoRHtTlfn7ElinQjJTYABzVBw9P?=
 =?us-ascii?Q?jeY/AABdX6mpDnATOiWe37t76kJsF4meQnFV2BjPfUgGM+ZwYD87xNrupDW3?=
 =?us-ascii?Q?F4D1T/oFgfNi86XLJW0LZ3lHHyEFB7HnctVwUI+FXEh3DMvNx40rgTmDKQbw?=
 =?us-ascii?Q?+Vd0ILsj7I0Y5s4v3DqOF3O3e8TgXnxDU9lQTXzW/GntR7K8SY/LXouQJC8h?=
 =?us-ascii?Q?reYTxrabtlmKS7WLL+ir3b24bzk5KROVWtp1utpVEKDelkbrz/TLh00t8Jcl?=
 =?us-ascii?Q?AXViNUm+NxAbp7vvwzn36o5SiSbuQ0FWEpQaa30vZl6vqhHrm2TzR1o0sd1S?=
 =?us-ascii?Q?N9tfZlqmqQ2rCj02LATt5Vjbm5Z71FzSVGRDZZ1H+Kr0xpPZwu2HR82Pn/dh?=
 =?us-ascii?Q?2TvcZP5yOYQhPOE5U3WUfusEW+gkYA/HwqAf+LPJ2fJVoO1AZX0PWRKNgEdP?=
 =?us-ascii?Q?C+C5MVAxneRLj2/oeaNynxOqlMWdUlBObxmtrvRbZZlaq6+qW2mNMXu4EemY?=
 =?us-ascii?Q?554KazKWDOxSzEdvkXUJV8iQc0HOlHh33kQ+YSd/xUDTDp6hhUpplXFu6weR?=
 =?us-ascii?Q?BYRVG64GtAl5Yoa22FdgdjtKfgQPXZWgQAmNi7rQZ5qbQ6Os79hCRFGDqhv7?=
 =?us-ascii?Q?p843EBMidSzEujQVRC4CCaPOzFJcTPDi1xEEhvn3PxO6HSnjzl8BsKwInHM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0cfeb3-10ea-473c-8f4f-08dca621e474
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 05:32:48.0329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4847

On Tue, Jul 16, 2024 at 08:48:13PM +0800, Chen Wang wrote:
> 
> On 2024/7/16 17:42, Haylen Chu wrote:
> > Add support for cv180x SoCs integrated thermal sensors.
> > 
> > Signed-off-by: Haylen Chu <heylenay@outlook.com>
> > ---
> >   drivers/thermal/Kconfig          |   6 +
> >   drivers/thermal/Makefile         |   1 +
> >   drivers/thermal/cv180x_thermal.c | 241 +++++++++++++++++++++++++++++++
> >   3 files changed, 248 insertions(+)
> >   create mode 100644 drivers/thermal/cv180x_thermal.c
> cv18xx_thermal.c ? See my comments in patch 1. When you deicide it, update
> this for all patches.

I would use unified "cv1800" in next revision.

Best regards,
Haylen


> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 204ed89a3ec9..f53c973a361d 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -514,4 +514,10 @@ config LOONGSON2_THERMAL
> >   	  is higher than the high temperature threshold or lower than the low
> >   	  temperature threshold, the interrupt will occur.
> > +config CV180X_THERMAL
> Same question above, CV18XX_THERMAL?
> > +	tristate "Temperature sensor driver for Sophgo CV180X"
> > +	help
> > +	  If you say yes here you get support for thermal sensor integrated in
> > +	  Sophgo CV180X SoCs.
> > +
> >   endif
> > diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> > index 5cdf7d68687f..5b59bde8a579 100644
> > --- a/drivers/thermal/Makefile
> > +++ b/drivers/thermal/Makefile
> > @@ -65,3 +65,4 @@ obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> >   obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
> >   obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
> >   obj-$(CONFIG_LOONGSON2_THERMAL)	+= loongson2_thermal.o
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

