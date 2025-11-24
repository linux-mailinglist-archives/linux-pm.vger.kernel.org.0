Return-Path: <linux-pm+bounces-38477-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10EC816BF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8460F4E1B76
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A17314A64;
	Mon, 24 Nov 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QRavQBf6"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AACD4F5E0;
	Mon, 24 Nov 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763999371; cv=fail; b=sgn99QABGT6zx7EuY0Zr8DlT0NNySj2nF/hqpRXnCif5sXwoKxb4QTUomSxMyP1aJRs264ZkQ5pdCQjwNWhVjx6U6QR2xx2gzIDqAyo7AZeHHMdZw5z/XeHmzh6gRp/rqsgZ+55Ai2tTqn+w2a5MLOxIhaaFPA5crprACuW9I70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763999371; c=relaxed/simple;
	bh=7lE26UgBtYefATwPS9Q0Fy92FDx3AeDh04/PVMxHoqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WshqzyAq8vZzXxZmdLkb7kElnQl519uWaFc6uIs/d2Pq3flq98RKzAMvUceWdvRyIxi1c8p+IswLxREmYdpyY6t4QGVBQxy2rlwq41brx+qWi/q1m2wDemjehjWRn3f3ZFNzeQ8Cfc7ZBJOc513Zp2IrrPg27l2qlVck8xXRxBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QRavQBf6; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awxWLZIqoui5PFwhNqfkk8Dk98lzSwMWXrqZ64VIUsW0CuyYmMGESjrFQ5Dowjfe5zQYNLJ/DCBnBzHctI4pCNOFiVbdQc8nH38PHGM5Xlr/+xkaGxROJu6y2Z7xNt1XAszLnXOBn7HWLxfip6Jl3AQpT8gMsedXuJf6FaDwCzWfzBMl70vIvWc1+4ATovP667dHdyNvLtt8Gg19SGpBsT3hn8xKyzx8Nv+FjyORYSXrheAI4FmGaQNAN6ywyQYZgZHp/M+a+c7e/xdu4VwBQEgPj5uazminNzQ6b1GXQ/32i+HnaMVu9X6sf8iraL0bHR6Iwg0TLWV/R4AqPCGOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TghA5rkcZoe13lKhax0U8ktMUKJrlpbilfvIA6c1Vq4=;
 b=Z2VunPALWOeRcowEufBBS6cgFC4TBMZwk3RYJAWVrifPKnSPuzD5qYfbYn3HfusHSaJVLzNCDIrqesVFXM+6AtY8nJrKpFAjjYX31/r04HSP/GwCBebRaB4yYg8HtLcfYUSXbhbSP8Qt3C4f73/XXhsyJrsdqGh/vB8ZMVcjcXim5wJid/w4YBnU+5M9qVqwf5ijD6KRLVngC7Ir3AZG5H8IyldDQkIYBOHnZmLKKbkqKR0hPREQ618UoirrMcS6zwFWzhgCPZDsvGd1htB08ph7asSmyosizmcUEfTFKWa6ABcSnfq40sNOFGmhDPaRWB+O+kkNycmHtd3dnD8cOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TghA5rkcZoe13lKhax0U8ktMUKJrlpbilfvIA6c1Vq4=;
 b=QRavQBf6fBh4cKB3kvDPYvt2YEHMpDTldnSsNr2F6F4iJ2rC4+mKfDqz2a4Rq/0NZ0acv+0asnuo6Hvd2ygZfj3OsD/D2lhAqjicftfQVmM2iv2bhfDsP/E0RC9C9xFhBcNkEUz9bWNY1JxXXQAUOh5KLFjP/or17FnzBuKF2gVG0vo35Kk7KYPhaIwAWuSC5FIQ2/AcYwCrAyX4DHQb9HpX5TBwQFUv6uSi2rsXu9VGzCXTlR3Duq/icwtPZVZGzzzymHXzlRvWDmw+/CE8dILVdpSa9ogy06mjIOJG9wP271ormn8mwqVbOs95pSUPIvzlvfutUaybIjXXzhxVaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:49:25 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 15:49:25 +0000
Date: Mon, 24 Nov 2025 10:49:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
Message-ID: <aSR+eaVxBhnahOl7@lizhi-Precision-Tower-5810>
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
 <20251121081911.1682-2-ming.qian@oss.nxp.com>
 <aSCOZCJ2rSw7LAvE@lizhi-Precision-Tower-5810>
 <d282811a-866d-4ca8-b9f6-fc1da3a7565e@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d282811a-866d-4ca8-b9f6-fc1da3a7565e@oss.nxp.com>
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 377cb43d-e0d0-42b1-26aa-08de2b710b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WK/MpO3zhjsYNifB/DQI8wlBWCeZI1Meo/W296chJH9uhK7FCItdhZcsoD6U?=
 =?us-ascii?Q?j1sg1qAgXmsfuoiFS1NJ+nmzWOeqNRayda0gYT7RMDaKU9wGFNvYdP3b+I2t?=
 =?us-ascii?Q?S+6U+qXR7O3nep4XhVV+TCbOAJ1bT4wtg7lnxEJtVyTTJFzI5F9wQTBMHOgb?=
 =?us-ascii?Q?o22DugIDet6Ydpy5nijOcIU0DQtreagToeJ3wuEosoKJjkghnsL395sUW1+t?=
 =?us-ascii?Q?D0iuPUQ43YKHSVqIITHEQMfR+lObh2Uf1Q7KyZQBlS90NnbNhhNLImrdAwlq?=
 =?us-ascii?Q?Mu17OFqyFRMtZ6TtfHoXSdZ6uF2KlnLX5G6ZHi55Y7QnXfw/keNg1XzvRYty?=
 =?us-ascii?Q?n5hRqbaYFYipL1ue3H2J4uf9kyBp7BrFRaZXJAIGjsGqJaPKvHKuVBoSUrqK?=
 =?us-ascii?Q?F2uRo6Na7j/AQ98HN8vtkRErduby/mxxSvew75q7LNERqmWQ8rzPL0KQYzgJ?=
 =?us-ascii?Q?otjkVWPr219CYzHE5SQoX663x+tK7pI+5z4qEA5PN1TKu6I3PrUph/fnIFTE?=
 =?us-ascii?Q?szOVtTUgl/tyDz85BsJsl7a9XJDcmnZYZ7yyW5S+hzK5tsE+TqDXjayEjYG0?=
 =?us-ascii?Q?tHn+A/VFwzWoISK28HsCXWbwF5yc4aI6/CPtoUUmE8ph+aFnljGMV1MCkLxi?=
 =?us-ascii?Q?FZIU85klKV78ThSaMye9aaFdjYDzdQPf5M9Pd26nf+sDr9GDcg/IHAlLZmCp?=
 =?us-ascii?Q?rdLeZa26GOEe8NTJxza4eHi3vnMIPXbgUz+YIEPUaJzGYQVh8QJZ2qNj0LBJ?=
 =?us-ascii?Q?jctMRxG50xCZFszmr9eH/RKinsLOmjPuDl2uvFj41Kw4VxNQnri9RTNjuY/q?=
 =?us-ascii?Q?awkxcqt+I8TDG95YVPyogyhtGBTj4KDdV9sLj/bHzcMKWu83hWocRLksv6pO?=
 =?us-ascii?Q?z/Q7w0VYmI+Og1wyptQX29RRtN40shDCGy0tYEA3JgWqDA1LqwSFTwP8RMtq?=
 =?us-ascii?Q?KYawzmDFkCrBfm1lTL03Chsf8YK+M9UbtnIdEWOB5L1TCDMPFuDa8ubUcKao?=
 =?us-ascii?Q?PmWEKOZ15v8Nuc5sVNesz1aUaerlS/xcndDaaagJkRRfk8HRJsU+WFthYC84?=
 =?us-ascii?Q?dolCbUfYb5Y1XeySGSDUr2ShWJF07aZaFO9Vpx5tOIiHXfanXZHCeynZtzRh?=
 =?us-ascii?Q?w6u1P57H3Qqq/+O5RG1xhfrPT3hA6OLRNhYvvucm5lDybtZfS7ywyt/l683f?=
 =?us-ascii?Q?RrIWyGz3YO2KjmBg3Mjo2u7NvJvifmU7Jgx65iObEewgkKyZLqqn5xlSYbv+?=
 =?us-ascii?Q?zvV5CfpTPwWac0hjDaIYCRPf8lHl/uKpbUeTzE86HzrR+Cpq6VlbthzlPR5i?=
 =?us-ascii?Q?hQEE7leUYeRdBPWZg0zvMeTxzk25B1cDXUAXxS6F3tDpAoMSUQoDzaRHeqA/?=
 =?us-ascii?Q?kScM8fCrbzSlU6u6RXMU0jwAon6JVPgiGMgAQ/Xeztt1y6L5HssbuwgEIFEy?=
 =?us-ascii?Q?C1rw7+UVNfhMRj/kmGIb4XnqGZ9MU3adEmXMWU/dTqtwNO55TvJIJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kb1m8vUxrKKqg28P61um2PcB4NSYVJAO/dDi/2osRzYtViqL0AyM5pE4oUGt?=
 =?us-ascii?Q?EbSN5yxZKn0pKmyE+YLL3QFhNMbU55dXAv7xjjRhhcejAzlWI9mkPS6mJcam?=
 =?us-ascii?Q?1/3RyxfD6PkQvD371AaQGz3J6pt9vwPHBLdz1GquFtpj4XHyMP0jlUA/OgCi?=
 =?us-ascii?Q?Ad/nqL3bwtHQiR1Xnsx1+MdL4hO/98StS2TnmJnre05Fd+naszDuacRCQYrX?=
 =?us-ascii?Q?+z95zNJIM0wvv4viHUAawk0SNn0KF/V8h8ZU9+NaApED9aGB/0TGJAEFcF7I?=
 =?us-ascii?Q?AEJDmxS0uLdL2OOUVVKU4+zg0bgLUInAtuCu108Ew4SdelbgC7zvLYI3NZUi?=
 =?us-ascii?Q?u3YZqhiIO4KO3t8V29QABF9v5wf1eD4ZAqY8Kp2L6sJ2i4xB2aYNL7JfCnJm?=
 =?us-ascii?Q?G8hy6WPJ8/iuWJ/EWyNDnso3qjIeabxtm27fxjAryzo+meDSipInmgJOhK4v?=
 =?us-ascii?Q?Y8O9HtELxEZJybInHzYstRZ8/rQa5p3sRDsO+aj6isUecSclneE7Yh1RAOqC?=
 =?us-ascii?Q?kJzx7HKScs9hMAhNkzROATCCT6aWVRRBJa/UXquf8QTGHIZRf5xT3XBLm6gk?=
 =?us-ascii?Q?Bb8VuEN9ymGEuecfRCfCNhsnADw+V1lzeqpmsXRqClcNnftR+rcmjaUwMhMI?=
 =?us-ascii?Q?hoa8WKUAxXIHqwrVWUAwlr/pFvS7v6W5OkGwQnhlaNw5dMaowcm3CFskYSJ9?=
 =?us-ascii?Q?TZflUi1TtLGB0bF/m8tW7TWdSJRoM8LZu8JfPIGAROHeCYQ4MBdzbFZeps8W?=
 =?us-ascii?Q?b71oxFyKdVDynD55FTxlmEef5qoqdXt5L7CHOZQuOT0dzk2SFpxlJOTweiIA?=
 =?us-ascii?Q?/2h7xIJcUJUGcBxwaK9uQgRE9rDnQ5QfDDpGx6iWduzD9pNaaTi5nniwiZxW?=
 =?us-ascii?Q?P95C9rQCThUZJWAOtS+R7ABMq5Qigk3ZI/TwrarM49oVXSxz0/yhilm1vadX?=
 =?us-ascii?Q?nOlyhUoTRMALnVDmnxOkD1ZUW/Cywq/S7xpca57yAFw3tsm/Nass6wmW2rk+?=
 =?us-ascii?Q?vji7t+nJKgb6yYyWt40+RGPYSG5DVZC8LO+6+rjCECxgNf4EXNe9RlomHAny?=
 =?us-ascii?Q?0WTHZaVAIxen/rLm1J+tAcJiaDseu0UoOG87eW7lrsA3I+cd59sqEiFkjzRn?=
 =?us-ascii?Q?7BPwjEZR9CpBZUlQ0hnW7QGGj+z6U4BsnnRnC0hMN3uSBz/mmgOQ0MI9CtGB?=
 =?us-ascii?Q?6gjMfWzu/tcatQyZdM4JOH/8ZclesJAc5rstnwkTLKb/op82UnDMYQyL5X3l?=
 =?us-ascii?Q?aPPPjh78vcp1xBiMECLK8Mfj1ct7bGlLRgQWAsK+9kH2BBltLyn78BPQ5Imd?=
 =?us-ascii?Q?kpG6Cqg19rPG/AENxpKU6ltnVbO/SW1mjOzUDYidgUg6UguvQAhlVKc8n4tf?=
 =?us-ascii?Q?KAk37BdGbpxgjERsbrjM5mOStlGl0RpbcU4SwNUphgi3qq6yDMklw1C5BO0y?=
 =?us-ascii?Q?xKIHnW5J+sGdEMA2M92VBaab7EAyIqr/t2+r+d9F9GNgwU7pWuXdBTWC7kSH?=
 =?us-ascii?Q?Qa5VIadjHl9nIL6gWrf62bCt1owdaxEBBA6LaW8R5hUbkvBJ518heGCjDb01?=
 =?us-ascii?Q?NfusBF4W8qipOenFvEEsZz9MrnN6oytGp7o0FaLu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377cb43d-e0d0-42b1-26aa-08de2b710b47
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:49:25.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KISbn+GuyR8LsGCG07hQDfoL3LpKjahcFybS7Xi1wzip0HicuyBx1ScY03gIGAUctoEX+V3QbBeoloB2I1fPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827

On Mon, Nov 24, 2025 at 09:38:15AM +0800, Ming Qian(OSS) wrote:
> Hi Frank,
>
> On 11/22/2025 12:08 AM, Frank Li wrote:
> > On Fri, Nov 21, 2025 at 04:19:09PM +0800, ming.qian@oss.nxp.com wrote:
> > > From: Ming Qian <ming.qian@oss.nxp.com>
> > >
> > > For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
> > > g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
> > > error and produce corrupted pictures, even led to system hang.
> > >
> > > [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
> > > [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
> > >
> > > Therefore, it is necessary to ensure that g1 and g2 operate alternately.
> > > Then this allows for successful multi-instance decoding of H.264 and HEVC.
> > >
> > > Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
> > > Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> > > ---
> > >   drivers/media/platform/verisilicon/hantro.h   |  1 +
> > >   .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
> > >   .../media/platform/verisilicon/imx8m_vpu_hw.c |  4 +++
> > >   3 files changed, 31 insertions(+)
> > >
> > ...
> > >   #include <linux/workqueue.h>
> > > +#include <linux/iopoll.h>
> > >   #include <media/v4l2-event.h>
> > >   #include <media/v4l2-mem2mem.h>
> > >   #include <media/videobuf2-core.h>
> > > @@ -93,6 +94,9 @@ static void hantro_job_finish(struct hantro_dev *vpu,
> > >
> > >   	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
> > >
> > > +	if (vpu->variant->shared_resource)
> > > +		atomic_cmpxchg(vpu->variant->shared_resource, 0, 1);
> > > +
> > >   	hantro_job_finish_no_pm(vpu, ctx, result);
> > >   }
> > >
> > > @@ -166,12 +170,34 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
> > >   			      msecs_to_jiffies(2000));
> > >   }
> > >
> > > +static int hantro_wait_shared_resource(struct hantro_dev *vpu)
> > > +{
> > > +	u32 data;
> > > +	int ret;
> > > +
> > > +	if (!vpu->variant->shared_resource)
> > > +		return 0;
> > > +
> > > +	ret = read_poll_timeout(atomic_cmpxchg, data, data, 10, 300 * NSEC_PER_MSEC, false,
> > > +				vpu->variant->shared_resource, 1, 0);
> > > +	if (ret) {
> > > +		dev_err(vpu->dev, "Failed to wait shared resource\n");
> > > +		return -EINVAL;
> > > +	}
> >
> > why not use a mutex?
> >
> > mutex() lock here, unlock at hantro_job_finish(), if second instance
> > run to here, mutex() will block thread, until previous hantro_job_finish()
> > finish.
> >
> > Frank
>
> G1 and G2 are two different devices. If I were to use a mutex, I would
> need to define a global mutex. Therefore, to avoid using a global mutex,
> I only define a static atomic variable.

static atomic varible also is global.  Global mutex is allowed if it is
really needed.

>
> If a static mutex is acceptable, I think I can change it to a mutex.

ref to
https://elixir.bootlin.com/linux/v6.18-rc6/source/drivers/base/core.c#L43

Frank
>
> Regards,
> Ming
>
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static void device_run(void *priv)
> > >   {
> > >   	struct hantro_ctx *ctx = priv;
> > >   	struct vb2_v4l2_buffer *src, *dst;
> > >   	int ret;
> > >
> > > +	ret = hantro_wait_shared_resource(ctx->dev);
> > > +	if (ret < 0)
> > > +		goto err_cancel_job;
> > > +
> > >   	src = hantro_get_src_buf(ctx);
> > >   	dst = hantro_get_dst_buf(ctx);
> > ...
> >
> > >
> > > --
> > > 2.34.1
> > >

