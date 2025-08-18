Return-Path: <linux-pm+bounces-32560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B8B2AD5D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09E73BE66D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301032144D;
	Mon, 18 Aug 2025 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n0pLMS0o"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3631E0E3;
	Mon, 18 Aug 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532106; cv=fail; b=J4PnfnFmDca2InH45aIgWbYTTYlE1Xiub0EHeIQWOp6aYgJ5LxtcGSER3aITzAE9/NvZuBsPTtz+AWQ97FudzUdtS2d7YRS7o6RCCiJzkVY6BsS/UEFXSwMLzCgOGGyWXknhkxNOR7KUHhaLNK1GX1yYIBczwl77RFpsy/frqCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532106; c=relaxed/simple;
	bh=myWEXdP1yV1SJnbrwReg1563b6UIDFmgdceEzMP/3Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mq7Thn8lweJdwYXhyB2YdtJDVtDT21ghJAlNAiOkvjJPFNPLysv1HNuLxt1Wec0yawvy1pvT9SVVXZLGcidBU7NKm/5cf6kfX7wYk7zqmqCSsfXSfAsxVwVMmBqQnNAGs6d3rADlJppUCsYO1g7t++u3CoNSTcr4t0c5xw+3GFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n0pLMS0o; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNn3eGFlRNPZoLFgKGVtCRXYLNe05+1qfZubQRJcyqqNZet4ZL7Efa2Kd/W0pOEOa5ntnNAtSJ4psRcrlm1p4bXlaPi6vtUCC/Zj0sO4ic/B9yJ9aVz/I/1zrTjz8PLrwcuu/O/RAdn6ts1tZbaRMBQ5s3T9lYdbE+9FgnpO1R6sr2HXPCrbHGaROLG9W7NwPDgAqf6qSKreVeOJcb916iMlJDZw/Wbfsr2KlsHmTW/lF+/9pc8+zWL2rkwmDUFV8lYAP1YuLiZAPNm08yVccKHfNySez/uuo+GIrR8U7pM4jqt6lg9BtFiColZ3+s8ii1a36c+St02gK6xPBbw+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70a81dbRjtO34zwpz1InCl5IHRpAZyDHVw8qWV9dC8Y=;
 b=CcyLAiDBN8MwF3gwR+JrvsVJKlJSXBWXJtiviBDHIERl0lM+oVGv8hu3fCUnlAfQlLlPb8IK+s8iOlYggmyTLyvAZWyFAiQzlAe8h5Eskp4BHLZWGRVftBhOIah3UPtJsA6EuptPT0A9NnWAErq4/6QazNbQs+XgEIB6ssmtmkcwDPWLMlvtUUI86/p1RVc82ISyI2pBEUGxMyivfsV1bS3EEMF+zG2P2l/H3sMgT8qFDHoxNW54tWU+EVITmCsqYhmInmhQilceHvXVYijAJ6HyqD+xFpNNBez8V/bIRAcSctjZBj4Ksu/teabpThy4lhgBL7J1e4hF3XJQwo0MJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70a81dbRjtO34zwpz1InCl5IHRpAZyDHVw8qWV9dC8Y=;
 b=n0pLMS0oj430bZdej0FiVN7iEQRHChf7FFY9NnnO8nW5DpDPznEbywf649shDp16wwJX3nKMosVrTf/0NaeP7v8lhtvDkVmIqdfECvZwhxYNILBIl1oqZ4/zMowU62UTCOqjKZU4GLkkKct3G5MYTZifu6OkyXQhkkVddKKB5c9hzUz3p6cZNECZoBj84twIdWaQpf4y3wdn1EsQhOaHOFa48zhg1JGnJflPGKCSIHDCzEh5p8vJzGyK5C9FfpicWSnUllLIhe1HK5dpPc8wDULUTdAfk+I+aEZcZyMbSPZ8Mokaik/giXsXBOqb/0BCmI0470GyAtqBDsEycAsc9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:48:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:48:20 +0000
Date: Mon, 18 Aug 2025 11:48:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 2/4] thermal: qoriq: add i.MX93 tmu support
Message-ID: <aKNLPNJFmQplYXc3@lizhi-Precision-Tower-5810>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
 <20250818-imx93_tmu-v3-2-35f79a86c072@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-imx93_tmu-v3-2-35f79a86c072@nxp.com>
X-ClientProxiedBy: PH0PR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:510:4::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: e256ed7b-efec-4426-8edd-08ddde6ea80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?acmZhLQOyhg/z32T5LG7Iz0z7f09gZvpOm7w4P88pExQSoch4aynX+HLpHYp?=
 =?us-ascii?Q?CB+Q9HR6flbkRvLJi8nqS/9ewj4PoY41fNKYlZd2TTtzSA+lT1gr4CY1xqqP?=
 =?us-ascii?Q?VDIYLuzxKgWIhDzt91Rx12qigPJfSh9hl1NvLCM9wguG8xKo8LCr4hQIoO+f?=
 =?us-ascii?Q?n4qhmQaE3YqCU+TyKaoiiCRrWdv0COxS2faO/cf7sG/XUNNIf1p2qMFg+LBr?=
 =?us-ascii?Q?A1AEbZTW3wyd14THEIsbNz7cgfURencyD9JFfiTbcy4e7Ix0x05WbqXhnkoq?=
 =?us-ascii?Q?Xu6iBS3C55ULVOIbaqWOcayc+0lERz3k8jYl6zWTKDuVjMYcHcFbRuq2CNGa?=
 =?us-ascii?Q?0/Y1r0/rjqanwkWfnYP83cP2C39hAXJoss/5T6E0fUnnyj9yKMsiYIOYNFrL?=
 =?us-ascii?Q?OGmLPnY3moo1e9zzTN/HVbGWD5nCUUiNHb9AwzKwkSlLxattOzX7noxLCtQI?=
 =?us-ascii?Q?Se7dxdWjI/wamQO5SfndrD9nIOlG9CDuB8NFHHR9T/F8uECmVuGLOCYJgv78?=
 =?us-ascii?Q?bHgrMw2fndPKHSEWCBSpheZ095wZqEeO1jnpNla0YVThGu/lNHb7hlUwE5b/?=
 =?us-ascii?Q?s0BIT1Vws6rfqlHPV+sT4K2ye+kIRJ6VWOlhI2CqNlR23h2gXpii0nCWFMrR?=
 =?us-ascii?Q?lWR8N8q56QkvwjzW9mVDPMavOsH6qC5O7ZQgA7+TXpSMS9ZGVXGnugbSrM/Q?=
 =?us-ascii?Q?znFxsF+dXJrOSBUuX+9w20KH2xc+Zi3qCxfzOmZYpYg7Rr/dwMKjhEcIDJa6?=
 =?us-ascii?Q?8T56JA1xGnJymclffZYZtb41bt5yFPS5sWV+xFbnCc9bVAQyaGGdXWJOgMqd?=
 =?us-ascii?Q?ud20DTsE2f5LVK0v2UfrE9UJGV4L55taMrTOq/Ly0wG3Q/Ifj308ya9eDYgC?=
 =?us-ascii?Q?2aYhT8ikf3qJmCX6TjUFYn5WFVvGaBJQo//mYS4LtwzWGItM784TIpHYwf22?=
 =?us-ascii?Q?m0S89S43Doco5Xl3pcPCeQ4wzZBUF3PWxQnjI/VdiLhV9jNI56nkPwca4V+S?=
 =?us-ascii?Q?4O5tFYZuc6HhFKumbMIG73Zlj4vBkeT9CWrfsM3dhwYYvqJKg3JrxVs0Vcnv?=
 =?us-ascii?Q?a8rni0+12Wmn1hqddlDO68Oa7mIAbGuI6D46SlvSGDJ1BBQN7zfPXE9JMqS/?=
 =?us-ascii?Q?sr3XjBdZ1riako+MKWAlqQ59/cAMhsGtQhbwsOGIedmjLdi1pS2eWVW5bYp4?=
 =?us-ascii?Q?vRqu8WFAHrj9NEROydHnNEi+S/zIh0r8HX0JAXh+rH50hmCitVxKQBjAmCS5?=
 =?us-ascii?Q?PPicOJo+hE5Hcc1tfhGmrTtizOfHA2HCSUG8uR1+DohlLioWndoyjuX/kYWk?=
 =?us-ascii?Q?e8W8m8K65sXPpAOLpCuAzDzcvtiY7OMsF+59VCY/PlOSkedxTjc1cZyd0rUp?=
 =?us-ascii?Q?nnXQB5Xv03Fnkr7robTCDP3a6w4iGf20OW3salzzflKqYH9BFOg5Q97f87VO?=
 =?us-ascii?Q?1lA36iacoY/kVHP+5JmZqLtTmkUjeLvjh1fdCOt2m4QQJDa+53AnTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44xtYLQR/CmBxM8BhZcVU1wC2rMKA34GnSfyJd5kkdhnxPgpYQoLGbRkCONb?=
 =?us-ascii?Q?ooXkZBvidaDfKOKBFqAyL7MJjEIBHIy9jXwpQCaEgFgKxS1U5jU6fXb0Mhi/?=
 =?us-ascii?Q?fR+n/TULs9xHb7MoBZb7P4LgLA/UUF1l64V6mzU1yD36fYNTKoqavTKU1gvp?=
 =?us-ascii?Q?D4SDiBJPDRpJ9jaFAxJojlxO7B1AADHEicKviua4vOBrp0TvorB0xxVm+e4X?=
 =?us-ascii?Q?GcOjKmXgd5KLQPQAB6KFa623N22GwRbxjPfbt2JG1jz3vpKoTWF7uIKkXRE1?=
 =?us-ascii?Q?rheSwfwOAh1UmksLukEMrAiayuOQ41ms5atm4pFL/80sPB7cMILEWQS2+TTQ?=
 =?us-ascii?Q?cxhzFIklUvjGsJd8xcs6Z/L01CJdlg/Qezc6q2z6jtQ6MIoGzeBHbQQ0G2TG?=
 =?us-ascii?Q?m5sbiCSsSJVnn7acVMthh3QunxRqXgI1Bo875BV/UfXDjZ9SWmdLQ/dkeSOl?=
 =?us-ascii?Q?cjQVCm3VSmXhbUG5OizrIUPv7ql+jPN6TKweAZ/7TgFKa4iwvD/RBgg4qje7?=
 =?us-ascii?Q?beAV2kXM4PTAZhjOucBjVqCVWihJGTtzvNzTTfruuELvNKDnKLdKAkCaK03z?=
 =?us-ascii?Q?fB3NVn+gotdyjt1fecycBwabVlelOLKcufhVmkGnD0Is2rVlgWb4TOM91oA/?=
 =?us-ascii?Q?xDL8lp1mpDst0PTxc+YhG5IhQqZYfudt/bEl/XNjdp+G8dh0L912a3qxmX6Q?=
 =?us-ascii?Q?rhQ0clWTHmywwDmRmof/ggMvbVoVLr7ScDUNFVi96wgIPDWgMlV9QXXI4H4Q?=
 =?us-ascii?Q?zvm399MDOxR5pOD7VdqecZCYDZ7LM9uLRfeu1Pj0z3MmKLsXlG65gLIcPvze?=
 =?us-ascii?Q?o/a90x5uK1HWiWj7UB5eeAKcgTsaQyJPzv8lR0A9C/vVZSJb+XvfXwg2/bsH?=
 =?us-ascii?Q?ofsqVkkh+SRaszzQqsYgrhqnSE+bQfwKwtKuCxMe5vXldgX2famFE7YdMMhI?=
 =?us-ascii?Q?lyxf/sfmbfiGb0oUoaijLYF8sk3Kfg+w0OmOlnmfUIm0HNJNXxQspbZ+cZgq?=
 =?us-ascii?Q?j6C7hCaUSqjenW9yG5eznQayGRAylH29dMRBxtcU8I6Gt3+wAgGEuzBw90aN?=
 =?us-ascii?Q?BXgrnoPnQSIy/hxHQTEdfZuSGPnOoDuJ4t07JtRTCUwhcEnlzdlocr9D3/SN?=
 =?us-ascii?Q?oaA/v6e/afpWJbhXHalVxD+56ycmbZZNlf4f4GO7KqwUALla5CIJkPoF8aDH?=
 =?us-ascii?Q?LRFd7eVn8c+h4GbcD8yTQ3f2bMzoi8eFyS2XoUGg9WjMUIIS03cIcTaU+xDq?=
 =?us-ascii?Q?bKuyzW3i5ipknC1o4PkHGtldl5rRNas8qPGUT4siA1aTiOnqpWyMGnt0Rx+7?=
 =?us-ascii?Q?yOlWLhOc4t4MHOilQYiadsYSzNmWuhveiD9qfkrQyravuh+jkDG1gZQj3aju?=
 =?us-ascii?Q?iYjB3zzZl0vQLZqc4NjBT2C7Vt8ye1vn9F5uYMNrjySrnRtHqjc1/13jMZG6?=
 =?us-ascii?Q?gReUda0UcVSWUqrG0y1YQG5eXlJP5O+ZllpxktlwdKZxnHMjFdzKgddIByli?=
 =?us-ascii?Q?8OUiJOXSWLmoVKydedZzRwr2leNiWGyuZgDJFUtyVV20jFY65LiADsTXwhNW?=
 =?us-ascii?Q?MfhHc5BTc6w2tp3w8C2u+iAesY4pBP6RaShwp3nB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e256ed7b-efec-4426-8edd-08ddde6ea80d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:48:20.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/ZaKJqGtFJZfr2+3waaQnXmpTDjDghUlhJ2P+T0TV56Qvk/a35hU4LKx098TL1IDIzpx4hNhoTkaaSuguw8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

On Mon, Aug 18, 2025 at 05:33:12PM +0800, Jacky Bai wrote:
> For Thermal monitor unit(TMU) used on i.MX93, the HW revision info read
> from the ID register is the same the one used on some of the QorIQ
> platform, but the config has some slight differance. Add i.MX93 compatible
> string and corresponding code for it.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  - v3 changes:
>   - use the drv data struct for match data and refine the code
>   - update the copyright
>
>  - v2 changes:
>   - use the compatible match data to identify the i.MX93 TMU variant
> ---
>  drivers/thermal/qoriq_thermal.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 01b58be0dcc64d14ca5e4bba654eed8f15e827fc..b2e634547271dcf512c714907baa162921d2d527 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  //
>  // Copyright 2016 Freescale Semiconductor, Inc.
> +// Copyright 2025 NXP
>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -24,6 +25,7 @@
>  #define TMTMIR_DEFAULT	0x0000000f
>  #define TIER_DISABLE	0x0
>  #define TEUMR0_V2		0x51009c00
> +#define TEUMR0_V21		0x55000c00
>  #define TMSARA_V2		0xe
>  #define TMU_VER1		0x1
>  #define TMU_VER2		0x2
> @@ -66,6 +68,8 @@
>  						   */
>  #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
>
> +#define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
> +
>  /*
>   * Thermal zone data
>   */
> @@ -73,12 +77,17 @@ struct qoriq_sensor {
>  	int				id;
>  };
>
> +struct tmu_drvdata {
> +	u32 teumr0;
> +};
> +
>  struct qoriq_tmu_data {
>  	int ver;
>  	u32 ttrcr[NUM_TTRCR_MAX];
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	struct qoriq_sensor	sensor[SITES_MAX];
> +	const struct tmu_drvdata *drvdata;
>  };
>
>  static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
> @@ -234,7 +243,7 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
>  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
>  	} else {
>  		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
> -		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> +		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
>  	}
>
>  	/* Disable monitoring */
> @@ -319,6 +328,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>
>  	data->ver = (ver >> 8) & 0xff;
>
> +	data->drvdata = of_device_get_match_data(&pdev->dev);
> +
>  	qoriq_tmu_init_device(data);	/* TMU initialization */
>
>  	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
> @@ -376,9 +387,14 @@ static int qoriq_tmu_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
>  				qoriq_tmu_suspend, qoriq_tmu_resume);
>
> +static const struct tmu_drvdata imx93_data = {
> +	.teumr0 = TEUMR0_V21,
> +};
> +
>  static const struct of_device_id qoriq_tmu_match[] = {
>  	{ .compatible = "fsl,qoriq-tmu", },
>  	{ .compatible = "fsl,imx8mq-tmu", },
> +	{ .compatible = "fsl,imx93-tmu", .data = &imx93_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
>
> --
> 2.34.1
>

