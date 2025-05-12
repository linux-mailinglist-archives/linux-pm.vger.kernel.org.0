Return-Path: <linux-pm+bounces-27034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CDAB2D77
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 04:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E211890D6F
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B61253344;
	Mon, 12 May 2025 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rou5sKhW"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571E1BC41;
	Mon, 12 May 2025 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747016659; cv=fail; b=Zb1HcH0YdBh69jlyUHXuPRtQUZxSAlO7pMSxnGDTykBoK13NXmmSH1TQ3x4FwLQFXLxlagTIyqvTaQQNxLEPsZjykiwb/dvIxSKQ7ddjSx6d+5QuyBbt9OApXsixmfJ5HCNHwUC2kaXoPYZIVApWdT3YoBIUCT76wcDYz7DEnbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747016659; c=relaxed/simple;
	bh=0g6ABewXd/+P/tABKvJ5N6vjaqGVTrW/aJEzR01Q2AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lP65Lm36ZkICF9fpXphoCVOvZ7MEiU09Ykw8NFrBZB0DbtGyBihp2Tn5AgOX+zmi+nVh+/Cccdv+Qba4D95JecENpthgripT/qSh9/S4+7alZI4qm8IHUi4FNJ9nDWJqKC2bLjsibRHyP9/bQHBhqIN3ZxKNQRPW5dsXkNN3stU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Rou5sKhW; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McdsHtsOpu8mGK3zrPrOE+LaElXfB4edEaRZeACqNDDaIqGkSdD33gl9CI9T5oDPe0pTSn5NSABqKCIElaw3mIh0Xx6O6MyOEP1oR5n+5aZt/oZ+2APQPwi595w9NP0yvgV9f0M6UF703Oqs50MZpeG82ukoPsO/REfp5L7Y6FQnsH1X5PAAKTrIKPoD4/eu1JWM1W5MSDb+RjlocHg8IosD11zUnoHCbCwBRoCHVTqYjPow9KkUPZMNT3oDs44E6zBTc1TgeNmQILzKDltv7ZQqQNudHzUWPaEOfFx0Zq+rvJj0VePFQnBwMIT4SmKzWWDKeKSJVCDUEGA8AD6/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQE+smlAQYrCLEFpMaGUqOqEj3mwPY0WYsv1XzO07tU=;
 b=ANG7FOPf+OyfotX/0GIFWqVRMpBYojj8EojfLBY8MzoOCpeIEQZ4hkNm7Ll2ytEE4ZhOYl52R/EDTQSQiE69+SaOSNpmSomvFOrzGaR4BydbbJwgEYzg+OEujP3vBGLfrcKMDQqTJp7gHOa3ooiFyMO6f5Xi3T2sVIySQEs7AIQ2nv72UZXwqw5OkwD+88v0C6HUxkWwP9KzOUAjvFgEGCPP0D54pjIyiNlch+OhVxPTRF+Y9GdGsMip2KuV4Pu3merdMr/N96HFdiobkEt9f9knXcCcMgEz97vahS9AKcTbX6mVZGkib2oog6s5aNbQTNL1+vlTWpRY6BNWWEQlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQE+smlAQYrCLEFpMaGUqOqEj3mwPY0WYsv1XzO07tU=;
 b=Rou5sKhWN3noxN430R+F07jdwC99TQjcMZJZdakO4I2BbVJZ1hy3Lvd7MbF2v07hrxeydKhK0IfVj/kfZAet/nCthQ6Zqp6NSmFjnqP1yplTB8+WoBXdNVywviW/E5o3zaJnBq+BI9DTyy2Xqp/E08Du5qNAtc7mgraG6lF+ceizj8qjpcPNnctga5xaU9S9b8vfY6QKt9vICwpVQldiZaPbtLhV/efoxCD5d+6qsvByD25nK9HrL4e2y9BVKfd+NRCuLTKNbPstWkssyA2zzdk51yU6qVsjeOFJm3q4ePkUtPx4HMbTArCmy28ZXv2rlJN/RTH0vMQBdaWq9klY9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9240.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 02:24:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 02:24:14 +0000
Date: Mon, 12 May 2025 11:33:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hiago De Franco <hiagofranco@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250512033330.GA31197@nxa18884-linux>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b02c926-2715-495b-4790-08dd90fc16bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wwqB7XyoUt4ClTcoejaaWN34/HJNBL6YX7X7fHh1JGh006Si9Q4FBgVIwZO9?=
 =?us-ascii?Q?epq8ktXrKLq63K7w3vYnBSulsA7p4HvEKmwcGMWHMlibAX2ckFQZrUHeeoHp?=
 =?us-ascii?Q?U21LUxsm0JBA3ndZSSmEghlY/+XP41DmLBWg5J1HOmisQnUACP92BzqfafO8?=
 =?us-ascii?Q?JGekwnuubvb4niBZ83yUqUDwwosbHC2JTo0xE3Hz+Jf4yNa4kwHYrkejetUn?=
 =?us-ascii?Q?SBJWfmFgAesEAVoy21Qvy0Vxbhiq6AHI0c7F+YKjqG7KmGY3lodzmqjYqnZN?=
 =?us-ascii?Q?9PcobARqyoe9lOgWh7TYKGklXS4SJv+LDFzI9xcr25+1p2i4prD2uuScK8EO?=
 =?us-ascii?Q?NO5fK0RA7xGtRwHjO4tNBGGODcajeEYQIw+EtTwh71ssyBDQwJ4uszSvrnm3?=
 =?us-ascii?Q?435LjhGUvueOK8bcVPlQkoyWyHU5WG/bybpwDerwF7nbFWn8a483x5r1LDiK?=
 =?us-ascii?Q?6GGsfmzSECsqw7uCOU07Gu7pLDBfqBuAAoBoABooYzmgJTDv8NXRu1Z9FQlY?=
 =?us-ascii?Q?joLibkDWTfD5kMs1jXT7iNF/aElXc+wEjdglhOpHz2C94SaXDMfOP1SF4uH6?=
 =?us-ascii?Q?j/o/QwMF6HxRX/oAFiCxaqsUI3pECwno1bTTppA5B20yD33EcfRLY5rVlfZQ?=
 =?us-ascii?Q?72T3iXQRkonVUWcpkR09wTF+zA2Ya6+3KIDyTaCo1z3JjqHDFe2FGElrfMGp?=
 =?us-ascii?Q?oTdFuATKqnf36Mv6wc3kEoQ77W4FPBBPLzdc0d7Nz1ObnPphyp4qpu188zlq?=
 =?us-ascii?Q?qkxGLPTcMMwH7BqtRBZASeO+P4+K9HBLveuyekAesbt5Z4bY92wvRZewWIf1?=
 =?us-ascii?Q?rx2iXo1ypcpDq8C9YNP+PcGE3fpNExLjbTEQXfpWZGcvwAZYVabSGkxc8/WG?=
 =?us-ascii?Q?AdKMgaF+NCmDo0a2HvR3yY374E23SUIyXePY8qFII4f86LTy4mTNKTB2Glmd?=
 =?us-ascii?Q?7StAY7w5QIm4D+D0mXyQQAfSkRRb9pR1BoThz72TtDd//0xUvm9FaJfUGoeq?=
 =?us-ascii?Q?1jl5fb3DvvNM8Thatn0F3V6U9poQxR/isz/aWruY3+rxaVUu6gjc9KyxyGYE?=
 =?us-ascii?Q?uysXWhqgE3pylV5K05yqq8MkBl0FzohcWW9KQe4I1XnCcQPLhkGHCAPtG9XI?=
 =?us-ascii?Q?a15O8DsdBAn4IKXmIcSwj5J7h7IIMveBZo76JxVzz6LWIaVepmMHmyqDiuS+?=
 =?us-ascii?Q?TyaLOcsyjYKJ9zzzKbyeGWGXByoj1aaKkVdsX/zE1fv+Ufm71dOyO0oN2nFs?=
 =?us-ascii?Q?FrrjrLXUiHC3QygHV6oIHOszA4R6LaB2Z3nNJJy74zGrJta/XKShRZWRWdMP?=
 =?us-ascii?Q?BxJhPAXk/Cbgn6HSiFWPPGuv08v5MRBmpbY/4rjB+HJWmhGVQ/BmU6PluSZw?=
 =?us-ascii?Q?hzwCuXV+4SxcZ6WabTl7iq8CXmtxVAPesm6Gsq71NqztIXlwOv+XcOhf19Ug?=
 =?us-ascii?Q?sljFb1BnAPwhTnowgane3Mofokt+ot9CDcOjamkA3GyFwnDd+osJcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLhi7xVk+UkG9iGaUTbBY5rIeGdwupGLAmzorItv+24l+34AmLhyAEW5m6Nb?=
 =?us-ascii?Q?gAU5ifmv2jO2BSxNpMap8ugcKM0uyAYAu4q4YYYNeE82F4A1u3sfAjBR8CYl?=
 =?us-ascii?Q?mB0+BH5iLq/X40NgHITvyNBDAbpqLHUFVL6EnkyiuKlMdTx9lKfeHTT/fJre?=
 =?us-ascii?Q?owbw2o2Pio9brVs1q2xepXlt5nxwzCgse/ZT4aY0MfwAUtlSTqLZqbYGaKEp?=
 =?us-ascii?Q?7hfjwvvNDRZilonCPOPR401ghJTMnhpyOORoUQ2p0w1IwnApgc6BX/pa87qY?=
 =?us-ascii?Q?i1AZombz8CDGPq33z4zaSuDqNaJkPPoLmYBcnCCsrJP/IM30mOhI+8Tr6Ccg?=
 =?us-ascii?Q?Zab4l4kaF+z2oBlTFZuBoyW42GJc3dCSmDRfVbkkvZawuFhlPBOvzTJ1DQOX?=
 =?us-ascii?Q?DQXjMLywHyzW7SofLZtrt7LgF8dqOf1YptuTSbfP3Y+3c1kP6VCH6KWTUKnm?=
 =?us-ascii?Q?1/mBv7i+De1Oex7hXyqbVrBSDmbZ8oToiFCcDgJawDavP/1jKmibRcOMvTiF?=
 =?us-ascii?Q?7P883x8LqLWX+Mcn/gldC8K7p75MFxKw6J9x3bjNgfzBagT8DdNYRMoqp+79?=
 =?us-ascii?Q?jqOJpYK684x+9mDMT7/tbdNq+1bFZvdCcGz/teXB47tUNyEQOB1wnXOUIYun?=
 =?us-ascii?Q?g1HlFSphebLZBJjjkX/+IcsAZQ6Q0wzVB63AyiadB30slhGY+U7ThOCkr1Yo?=
 =?us-ascii?Q?S6PiUQU4pr6N7dRKKRad4KT732e0IlWVj3YU802RbIFwMGf7mSzkSc7cAbQr?=
 =?us-ascii?Q?rwucEPLGGHyUC8kltpIkLMhb1fJW/sK85QltMAcrRgy6xhq2lIy1Vaf48RNw?=
 =?us-ascii?Q?yhOw38VsUmuwlF0TMdnw01V3kQNen5gTzbkfyiBK/D6qeFGCYl217IVe/IWG?=
 =?us-ascii?Q?mHfWTf4YP89sMJeF4iVWdF/eQx8IOOTD+od1bDGN/ckIZwVam0+rf0Udrv6i?=
 =?us-ascii?Q?59LGWbCXEUoNQ0yhW58HnEFK11zUPheOfyqOFn2s4nebyDjEHF0Yp6iJCHLR?=
 =?us-ascii?Q?YaP0CRevx2lt0xM5XHq8EANlZRzMZ7vdDJ38lx9hhrICSMlOGtUkse33DObT?=
 =?us-ascii?Q?TAbVwMmTOG+OdtoRbA7Y40RQpaDbmZDm45yOE12D1yoW17FMHyB07yWGtmQJ?=
 =?us-ascii?Q?giUnfbln/oPhgBe2L7JUTqTWOXAK82uS4wxeB7JfSt8Huaaa3dqqPFi9yx1I?=
 =?us-ascii?Q?sCdO/drteIJHP1uFQAdpgYEIOFKB0aGS8Xcob65i1E3ylZ3OE1/UnP7dy36M?=
 =?us-ascii?Q?Fh94Na05EmAoXR0WCc4K0ylA68rhwWpG1HVoJicG5B/vJY0p0EJ6sNi7LNGc?=
 =?us-ascii?Q?OSrND25rs2VJxkaF336kpaj8J/TCv5yqkiSMuEMaaGgc1EeemlJYKejzS3Lu?=
 =?us-ascii?Q?kj2YIJg+ModkyksZ4PARCyQav6WYk/DdNkSJH4dmIQdVbWr4H3UYli6LPMha?=
 =?us-ascii?Q?VUYQ9FHcKN5WYTgZpko4vM9UvyCKbID/Jkgxdso8qA8k7zd0V6nzOEIswDKP?=
 =?us-ascii?Q?TKI2zJxJRX/libloeC7LIkfiRMM6lLGqRSkKPsX4CPx1wfaIwxut1C+33Bup?=
 =?us-ascii?Q?x3JRzGQCUeLDWc6WbqOIqqtWtVpYvSJybaDN+iqU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b02c926-2715-495b-4790-08dd90fc16bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 02:24:14.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF7btyDCv7Lf8Owqdtj5wInoJruAPudMLJ6rKMkjTPEI0EGFLqoVWiB4FHz25TZHsxB9q8Aj4gnAhPpJUMiM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9240

Hi Ulf,

On Thu, May 08, 2025 at 12:03:33PM +0200, Ulf Hansson wrote:
>On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
>>
>> From: Hiago De Franco <hiago.franco@toradex.com>
>>
>> When the remote core is started before Linux boots (e.g., by the
>> bootloader), the driver currently is not able to attach because it only
>> checks for cores running in different partitions. If the core was kicked
>> by the bootloader, it is in the same partition as Linux and it is
>> already up and running.
>>
>> This adds power mode verification through the SCU interface, enabling
>> the driver to detect when the remote core is already running and
>> properly attach to it.
>>
>> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>> Suggested-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
>> suggested.
>> ---
>>  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
>> index 627e57a88db2..9b6e9e41b7fc 100644
>> --- a/drivers/remoteproc/imx_rproc.c
>> +++ b/drivers/remoteproc/imx_rproc.c
>> @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>>                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
>>                                 return -EINVAL;
>>
>> +                       /*
>> +                        * If remote core is already running (e.g. kicked by
>> +                        * the bootloader), attach to it.
>> +                        */
>> +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
>> +                                                               priv->rsrc_id);
>> +                       if (ret < 0)
>> +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>> +                                       priv->rsrc_id, ret);
>> +
>> +                       if (ret == IMX_SC_PM_PW_MODE_ON)
>> +                               priv->rproc->state = RPROC_DETACHED;
>> +
>>                         return imx_rproc_attach_pd(priv);
>
>Why is it important to potentially set "priv->rproc->state =
>RPROC_DETACHED" before calling imx_rproc_attach_pd()?
>
>Would it be possible to do it the other way around? First calling
>imx_rproc_attach_pd() then get the power-mode to know if
>RPROC_DETACHED should be set or not?

If M4 is not powered up by bootloader, attach_pd is to power
up the related power domains. And the rproc->state should be OFFLINE.

If M4 is powered up by bootloader, the rproc->state should be set as
DETACHED, then attach_pd here will not touch the real pd, because
scu-pd driver set is_off as false when doing pm_genpd_init.
In this case, we still need attach_pd to avoid power shutdown when
pd_ignore_unused and also need to support linux stop/start m4 even
it is started by bootloader.


So we could not reverse the logic.

Regards,
Peng

>
>The main reason why I ask, is because of how we handle the single PM
>domain case. In that case, the PM domain has already been attached
>(and powered-on) before we reach this point.
>
>>                 }
>>
>> --
>> 2.39.5
>>
>
>Kind regards
>Uffe

