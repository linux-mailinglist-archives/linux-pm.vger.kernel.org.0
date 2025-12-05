Return-Path: <linux-pm+bounces-39245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C320DCA81A3
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE109305F142
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454234DB6F;
	Fri,  5 Dec 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XWWltsEO"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA134D91E;
	Fri,  5 Dec 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947377; cv=fail; b=EUQFiaEuFNTA4gZO0zvW5Dm77yU29mnTBzCIKRi06U/WuxKAC2n6ngT3HXq9Xx3RozTt2Y/hDq/dDQzRwDIRTb1RvRF8GZ53vJ2cidt/A2c+RCzGAZSAsxGPlHF/zjn83B0pvXfXc6jRX5v57MoFOr04N/sEXDu6IKp+KdDfnQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947377; c=relaxed/simple;
	bh=ON7Zib93ZE/ZONFNboLTCAeKkH7dkD7q363m1lcm5rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RD+c8bD16rOsQuUd+rAY2t7/fP3fw2sSwagYmquotSvd6xVnrNHlFtcMzykPoeX0sVrlaixaPFukj/RocLx+4gRPeb1b9pgl/7SJUDUtTGjnM3kS6kP1IFqSxv5BZ2RV6ZTELKr9zoHcBkRFEA1MRpRfiHjcUiMQekbdUATOfB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XWWltsEO; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXxqX+bCCew6GIMBZvc3eb/+Ln75R3vtvvE7y40KgXh9y5ILghghA8uUBOA1pVm/sZAAhgbr6rYR8/0Ve+KBsrm7omMOvV8a/9vqNSalHbGdpqLkMNjXXiT1tSuLgYBh7lde3e6SYxWGMUEj7FShSNgkPsO+c2s3uA5BrDj8Wlu5rwFtuZm4bJJZgxQb6kMWyzddl1HxMLsIJDhkLia0huFOCGK1/rYz8aZvM9pqeJIpUAztZvc/g39Z2tRVT/191qYNfgnEySUbuUWm8R4Y+oTOxhb6aRiIqEVBm9erKtTt0T5wtF3+fFYhTLr15n8ZwogMySvPBPkgk0IgwPX2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1o/ayJQFbh3JXddIGZuW0wTL7Quvgvjmr99QZxO3RQ=;
 b=vl+8pQsYpUFrzh3542hRejlwZT3mV4aCftWGk1J6L5Uq6KieqscvX1DEZ9cMSTsJe5mFpq17iL8d2AT4e53qAxflWtVN9wsN7qm6ARsV9EpFylxKjpCiIWS+Z7gidAHKZp68zXNbOADToLtn2Flc1jNss3k7WWX5nKwyrrNnsgInZmoXaMaat5CiZs6YkJne1hOeJ6dpE3Das8QcYbYyVLEZ0KGjwOS6kUJnBVi2p+10EW8iO8Ou8QfuDNXEUpnidOVvNcVfbMw0zgIQ4bTgJmQCx3CjygIe/LJ+D/R1aT21VK7JwYiLsy5LVZvEv2xkOz+AK/DOsML3yzk7UoFNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1o/ayJQFbh3JXddIGZuW0wTL7Quvgvjmr99QZxO3RQ=;
 b=XWWltsEOvcR+bC41IEtmqELgO0Ck+xvc7EPnxPcCmJyIXgg+pcgMQtdmTzwlyBmQPWIznMAhOreGPrmuyQLC91liUefip8LromN4uLBaa4PFL2AIrOS1Sp6Qjsq9Ceag59xCviL+MAT3iuH2jgkfZ8Lgr6uaAvSXRg4U302nlDRW1FXT7NEqrA86QMhHjlJ1hJ0HCFS/TdsvrfPhVGZXlghDeDvD7st/+thZDTOrKtMFpSAKLRyUgx+sZ2CaMXOeis7hyqLLwODJfnF0uNok85SBX03dRTfDZkJw3jPfyMzR30knl5+guyCZOo/ek9+t4yX8irdRP74VzNiiQhLrvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 15:09:29 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 15:09:29 +0000
Date: Fri, 5 Dec 2025 10:09:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
Message-ID: <aTL1nzFxWl8zKUGD@lizhi-Precision-Tower-5810>
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
 <20251205015428.643-4-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205015428.643-4-ming.qian@oss.nxp.com>
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: bc597292-6b06-4641-1e48-08de34104975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2xvPis8lWMYcRDGZR3eeTENytCu1JPpzLkvHnY8fSw417iZUSzUYS7CCKO9w?=
 =?us-ascii?Q?31f03GqpPjwKzWgkgVtCI8hObATBXtsZoBLJhcYD/7Lw9MA/Ed/inppXTYws?=
 =?us-ascii?Q?xgEQwBiEaIeDXw5K74V0A1U16EY/98PovfGuxbKXVJa2t57HRC/Pb1zgj2qF?=
 =?us-ascii?Q?Yfcz8klI/pd0dvAoaBRctJyshMhBIEG4xUnSPwBf/mFZyiGixeDWkIYD/f2x?=
 =?us-ascii?Q?t80EduYpeGdJzOYCpRJhiVqdilKJEHCX7deNYQzdBInTLxF9EhwCP75Snt/B?=
 =?us-ascii?Q?TcpJY5nitl+2xBu7obeSEw+79BDhdmVF0fGtoywU9sPoCHTUowETjaaEEFn5?=
 =?us-ascii?Q?oPM7ApUmtm6Xfp9deEShabNtDl1zywJVqRlDd52T+4l4c98hLHsWLtP1nTkl?=
 =?us-ascii?Q?kc6EU2B2P4vWPElbHN/rzpCxrR6gvXc5CGnfe+IawvI8Xww398+ziXYVS5ul?=
 =?us-ascii?Q?G+H03vihzXrZRc8nsNdv28G+k0r6oV1B02AszkYVjlLQOeECNPpL9KNQy913?=
 =?us-ascii?Q?hZJlGdq1kK4Xeyfpg6ZZTbT9ShhmZR18vL03xeCzA/+4CcNPmiBHRY8ybHSt?=
 =?us-ascii?Q?KTi3u9DJzisxC/y8KD9lP4bd33trQEQFoYBulsgRUliOH008XU0lWlMxiW8y?=
 =?us-ascii?Q?kb7t3GqUR+/0ojoOAfuNPXTzXJDpGL1oh3iFejgoAhrzYzL1jSq8/WZ4DSE8?=
 =?us-ascii?Q?P+2ixzEBjT0gAR1YCrj2F5pS/CvuLgG+zKRS4uUFxPGOkG97K1jcIynhfAjF?=
 =?us-ascii?Q?E/3s5ajtjYaQ9p/Uk2pqqOxptYJQoioTZs2OemPQEzz1i5woM/0HF/yGcyIF?=
 =?us-ascii?Q?XFT6qewHCpO4MGNQE6ZTEP5LKwgR653PTP3T8W58jhku2RvIKt3QjP/te+/Q?=
 =?us-ascii?Q?aTzbz3d5VZTsV76IL7l+NxBiqpOihBx+7quF1XRxNsQotsNa/O6tZsGG/yfr?=
 =?us-ascii?Q?x2cQwoPcx1VMAImUtDXLPojoLrCwnLbtbkMfwCgalFuMsVQ+jNPmeTiRMsk9?=
 =?us-ascii?Q?IwjP5siWnOS9NhD00jzxToA9NsgX4P3RqhQsj2hVJJ4/qlVutTGgvkDhyIXq?=
 =?us-ascii?Q?SAD0avtq4gEFHoqE5+vsDaYqUzFvhkZ8TeUgXmcESs+kYeqWGKbuTIfgOLYM?=
 =?us-ascii?Q?/ma9VbbF87wb/m7zM/TDV5V8EJDvJSUVmoLhtXkyaR5i2TVzFu0FX7SnbPne?=
 =?us-ascii?Q?boNcqNRn/+r2tzybEl24u45+o8PJqtcIsOe9gJEDPTy9PSW8/a4ACBxi5gWk?=
 =?us-ascii?Q?NX4nWK/v6isL61hiw4yPqv3U8NspVqHjCzssm66eeUIlOr7i+cNBKf60SezR?=
 =?us-ascii?Q?WBetc4tQ3JeM9M3eP6gUFi2pd6VcU37VpnaGU38XoyLgMkr4CNHuOxcZZtsQ?=
 =?us-ascii?Q?ODgpH1RgpwO2R4v7+hXS3m+SZ5XJgUkdMTiO0S7qwHw0b2PUC/YxFGNJ1e2r?=
 =?us-ascii?Q?frudqtjEJbTVOeluufh/poKz/YyQ5tHe/qAA3iYXXrl+aF6MwTWYVWEMwo44?=
 =?us-ascii?Q?ArNbKNmGpmSIcw0BlXTS/YOKLkmrAA0fCY7V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKdjHZzrKezrFJFOlKqJ8pBqMLY5cGDQaH9S2KWz29YhusFqqN47R/9Fvjhz?=
 =?us-ascii?Q?PAX2uaNDaQVAWKGhj35saI1f5Xjf4Heax59ehWej5CkLP38mc0uZmH8/xvm2?=
 =?us-ascii?Q?Zciuqn4akd9ZmbX+zcIpqhFZXskwFIjYMUymOvKDpDx4vTr04heEhI/17wsy?=
 =?us-ascii?Q?I8L/QJ8BEgatBY/3dxBQdFBigX/krloi288nQFj1l5Gbp8l0A+S06PbkMDzH?=
 =?us-ascii?Q?Pf5Rnwntyf4yDLs6zCf/xk6S4sWAG7ptToKFz49zs0A10J9Li6SIUKZSKaHI?=
 =?us-ascii?Q?9nJiaNzFHYemGvJu181NAIpRrcbcvI5zfekMhch/rTHgV6dgnZ7eyuL9qDTU?=
 =?us-ascii?Q?O19zyYF7GltRit1dgDQSMMIM48MVdYTpVPfr+Rxll1tZCXVbH6lXPFmDauvk?=
 =?us-ascii?Q?Gvf66Mj4VV9rUng11mYZHSdY/5OlQvaTgpgNN89eF71bVh5PJu91hGiXpU65?=
 =?us-ascii?Q?TQJxscdEDuja90luFNEWFIYUvluwSxx5uVP7Zf4/EKfRGoipWd/uWsbWWfnb?=
 =?us-ascii?Q?TpZ8lexO784jD8LHbzjHN3LPKA+vtZTRm5QFsR8LLipY6Snyv7rhqRKFqmQm?=
 =?us-ascii?Q?PDjymzN4MNlx9NR+vg6Try/a5uQ0bEMEwiZuOiSy/vIg3rUqU1Mg2oC4yLtE?=
 =?us-ascii?Q?hWu6Z6tRWrKjMEETWvCpVj03iyhw75+GXv0GLNNulDvEw4t/gQ2HCDiTAqdr?=
 =?us-ascii?Q?8npBjl85yUkc5nAuf2ZAV8WN4Mm5bKRpYlhVOjGxE6LJ0tTqA+vw3dwexTwl?=
 =?us-ascii?Q?3rFtDQnmlwWVK77F6WJcLEg7jo9ZivO80ozlLX5HU0Gn1gfk9Ei7pvw2io7/?=
 =?us-ascii?Q?UyeIjzRmHlZGj9QYJXxLhYwIqRHrAXS5SFLlpnZb0jO17OM7+lESnGd3xKVP?=
 =?us-ascii?Q?4f2vb8LPz8N6EYNK06kONOHBySrurAHQhgyBK2ylGKuN9M7k6HshSPlJilrn?=
 =?us-ascii?Q?9aBDpqK+zNPCYdjirrvGDXhyuWQIUQUIU4P8VnftEOI02h9pQKoonhoYaL0M?=
 =?us-ascii?Q?TWd4FUHEygdP0lc8FQsJ+XAw3c2sW1Pq7rDzj2c29d1LCCD2q/cN1zJzytEB?=
 =?us-ascii?Q?1w97WtpL6zcRgkec2iCN+BqCBztjXfE6UPPYGBsWxiWQIUtfvsunejxjwcRK?=
 =?us-ascii?Q?wSqlNsRHeazabmnQ+ezY4mJq43N9YOaPsppPnRxZjDjkN6Dyy3to6iyERYDT?=
 =?us-ascii?Q?AmmZFTrTvpJN960gyYGM/pIUdx82LFfCFyl6R9x8yUXvNTk89ieHoyM97Lue?=
 =?us-ascii?Q?y4yjKsRSRa1yyLZ8pMmZ4jp68RboOCY3jNqQm2Q8XJq+V7LkzwMH8iDTKzeV?=
 =?us-ascii?Q?BGa4DbrW3hxY6aeQcdD27Md7aeUV6Ln54b5ImnUiBt9eopOBsF/V8XWWphKn?=
 =?us-ascii?Q?CRRg/Gl51+glndjmkW0XcAB6zDVREAhSwjo4u9A2WjnAutGYVfu/wmn3NXiY?=
 =?us-ascii?Q?W7VC51kjuL4VnwewAlEoedHrMV6adEoR4a7XgcOH5agjdRlcM/V+JOTYFxHq?=
 =?us-ascii?Q?uHglkEG79Rj/79ocJZxkW28SCVvXvaaqEBeLjYPwsLk5Iz04Dkhvr/4sIW4q?=
 =?us-ascii?Q?snjDMcpJSUMg27+i3iP3a+NZlGFg1PCvub2aLRR/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc597292-6b06-4641-1e48-08de34104975
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:09:29.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+DKqgnmTp2Mg7Xnj2KCFikdpIzHK5rwwaNLJQw04PcxId4IN0bFKgugrGaUFJP+tbQy4LDJsNJdAiycscVcvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

On Fri, Dec 05, 2025 at 09:54:26AM +0800, ming.qian@oss.nxp.com wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
>
> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
> error and produce corrupted pictures, even potentially lead to system hang.
>
> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>
> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
> This allows for successful multi-instance decoding of H.264 and HEVC.
>
> To achieve this, g1 and g2 share the same v4l2_m2m_dev, and then the
> v4l2_m2m_dev can handle the scheduling.
>
> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
> Co-developed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v4
> - Avoid double put device node in for_each_matching_node
> v3
> - Add some comments
> v2
> - Update commit message
>
>  drivers/media/platform/verisilicon/hantro.h   |  2 +
>  .../media/platform/verisilicon/hantro_drv.c   | 42 +++++++++++++++++--
>  .../media/platform/verisilicon/imx8m_vpu_hw.c |  8 ++++
>  3 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index e0fdc4535b2d..0353de154a1e 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -77,6 +77,7 @@ struct hantro_irq {
>   * @double_buffer:		core needs double buffering
>   * @legacy_regs:		core uses legacy register set
>   * @late_postproc:		postproc must be set up at the end of the job
> + * @shared_devices:		an array of device ids that cannot run concurrently
>   */
>  struct hantro_variant {
>  	unsigned int enc_offset;
> @@ -101,6 +102,7 @@ struct hantro_variant {
>  	unsigned int double_buffer : 1;
>  	unsigned int legacy_regs : 1;
>  	unsigned int late_postproc : 1;
> +	const struct of_device_id *shared_devices;
>  };
>
>  /**
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 60b95b5d8565..94f58f4e4a4e 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -13,6 +13,7 @@
>  #include <linux/clk.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> @@ -1035,6 +1036,41 @@ static int hantro_disable_multicore(struct hantro_dev *vpu)
>  	return 0;
>  }
>
> +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
> +{
> +	struct device_node *node;
> +	struct hantro_dev *shared_vpu;
> +
> +	if (!vpu->variant || !vpu->variant->shared_devices)
> +		goto init_new_m2m_dev;
> +
> +	for_each_matching_node(node, vpu->variant->shared_devices) {
> +		struct platform_device *pdev;
> +		struct v4l2_m2m_dev *m2m_dev;
> +
> +		pdev = of_find_device_by_node(node);
> +		if (!pdev)
> +			continue;
> +
> +		shared_vpu = platform_get_drvdata(pdev);
> +		if (IS_ERR_OR_NULL(shared_vpu) || shared_vpu == vpu) {
> +			platform_device_put(pdev);
> +			continue;
> +		}
> +
> +		v4l2_m2m_get(shared_vpu->m2m_dev);
> +		m2m_dev = shared_vpu->m2m_dev;
> +		platform_device_put(pdev);
> +
> +		of_node_put(node);
> +
> +		return m2m_dev;
> +	}
> +
> +init_new_m2m_dev:
> +	return v4l2_m2m_init(&vpu_m2m_ops);
> +}
> +
>  static int hantro_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -1186,7 +1222,7 @@ static int hantro_probe(struct platform_device *pdev)
>  	}
>  	platform_set_drvdata(pdev, vpu);
>
> -	vpu->m2m_dev = v4l2_m2m_init(&vpu_m2m_ops);
> +	vpu->m2m_dev = hantro_get_v4l2_m2m_dev(vpu);
>  	if (IS_ERR(vpu->m2m_dev)) {
>  		v4l2_err(&vpu->v4l2_dev, "Failed to init mem2mem device\n");
>  		ret = PTR_ERR(vpu->m2m_dev);
> @@ -1225,7 +1261,7 @@ static int hantro_probe(struct platform_device *pdev)
>  	hantro_remove_enc_func(vpu);
>  err_m2m_rel:
>  	media_device_cleanup(&vpu->mdev);
> -	v4l2_m2m_release(vpu->m2m_dev);
> +	v4l2_m2m_put(vpu->m2m_dev);
>  err_v4l2_unreg:
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  err_clk_unprepare:
> @@ -1248,7 +1284,7 @@ static void hantro_remove(struct platform_device *pdev)
>  	hantro_remove_dec_func(vpu);
>  	hantro_remove_enc_func(vpu);
>  	media_device_cleanup(&vpu->mdev);
> -	v4l2_m2m_release(vpu->m2m_dev);
> +	v4l2_m2m_put(vpu->m2m_dev);
>  	v4l2_device_unregister(&vpu->v4l2_dev);
>  	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
>  	reset_control_assert(vpu->resets);
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> index 5be0e2e76882..6f8e43b7f157 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -343,6 +343,12 @@ const struct hantro_variant imx8mq_vpu_variant = {
>  	.num_regs = ARRAY_SIZE(imx8mq_reg_names)
>  };
>
> +static const struct of_device_id imx8mq_vpu_shared_resources[] __initconst = {
> +	{ .compatible = "nxp,imx8mq-vpu-g1", },
> +	{ .compatible = "nxp,imx8mq-vpu-g2", },
> +	{ /* sentinel */ }
> +};
> +
>  const struct hantro_variant imx8mq_vpu_g1_variant = {
>  	.dec_fmts = imx8m_vpu_dec_fmts,
>  	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
> @@ -356,6 +362,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
>  	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
>  	.clk_names = imx8mq_g1_clk_names,
>  	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
> +	.shared_devices = imx8mq_vpu_shared_resources,
>  };
>
>  const struct hantro_variant imx8mq_vpu_g2_variant = {
> @@ -371,6 +378,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
>  	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
>  	.clk_names = imx8mq_g2_clk_names,
>  	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
> +	.shared_devices = imx8mq_vpu_shared_resources,
>  };
>
>  const struct hantro_variant imx8mm_vpu_g1_variant = {
> --
> 2.52.0
>

