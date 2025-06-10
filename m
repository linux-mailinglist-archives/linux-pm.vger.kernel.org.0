Return-Path: <linux-pm+bounces-28418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3913AD4456
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0043A5DCC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA63265614;
	Tue, 10 Jun 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BxSAzpS+"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B472459C0;
	Tue, 10 Jun 2025 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589362; cv=fail; b=CNCtymufhXu50qhMcemX71a1poZ+dCeTPsVNkv5wa6aOHYnUpLAFrAd1C7AWkx6p81DGOQN0s7yssAqUNnKtA8IziJKmblnVYRo2DxH4t1i/fbQ+qke38bTgUiSX0R/lZVLQ3Q5EdAgaeaHN8cjGnxVuVxJzEEmKLoyhWLqWz+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589362; c=relaxed/simple;
	bh=zWiqTC1Q2FlMCPrbak/JsMd09NIo7eleuyVOAEkuEHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nPZSmHm7B8MFlJ7oKUNhdWtgLJhPRmYOSW9Cvna+wF39V1aV+cQEXFyBXbRpwPwnUA02zYN0pBvXEpPvBmLpvliEixaCGF3hRjzB/6JVPhoACvQba0nYdNCzjBC/YNMWFMft6kyzLTUXx0QIxA9uNID2erXI3xtZQZB6teOg/lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BxSAzpS+; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsVCQCEn+iTkyxkkrSdGVJKAzcQDikL6ANL2NvtwCdhSt4TkyzUWXHU0LpasJEzCLoYAPY5tQ4JygP4jgvIAdPfONQtkuqCm37qpKt9FpkTxQfdIT12cl8V947WNXfC2ynLrQtfFLTbqJJBrNYJmyDz1aJU6VKsy4AUbb7M5vjDC48ZQDQ6rM5xWe4+P84BYG37wjq7RSfyDVSaRm9+V1oE/V4QcIpcE83og10RQNZu72jX+nmep7SqsKDVM4Moa4B+ELmNRiAyQUOj9+oq1GLEYw7VSqDo9avTYEs/hq4t3xuSH57Dm+Yrv+WhOK+ZCy/a1lUnSXZFHpJhW77vcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF324or/2CN9pq6dSSnu20S6WShg9W3C2IcmaD2S/kE=;
 b=QksSy8AXwoVpsIBrEtfki24mHqEgLyQQ8TIYPRAEgNAg9k0RAffNTmTgl+AyNlk2xOpH9m2hxB7uDspKfHMrRaAxb6Zsile3a1eZynYsDPdllWUZdBkYhl2OWqKMBpELN72NCwzbRnGmgnRj+IPmWIspy0QFD6q7g7rISgGhSxS0d2nQevPvX36WJ1hP6a+PROAqoYbUGwtNgaSfl0CenSTHKNuCLsNZlNYAOEfJXBuDAfRG3c6IMe+1deMARYSw9Y5nHt8YRpHkxvzuy6VOTWuGx3z2sOfrbI5Nqx9DyWsHeZh96Tq7UCdsDcd6drpQpHEZ+W3gS4zhXHyQbmMI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF324or/2CN9pq6dSSnu20S6WShg9W3C2IcmaD2S/kE=;
 b=BxSAzpS+FByF5XYPq8rHiGpoS6+/rvEiKUGyMwNkA9ebsoLHlSXurqx0WN0tXOFomlUYKOZOX/NZV9XjuOfZMO9OvLmoH586t+r2h0HAvofF0VUcnfrjdcFyhydrsh/cS+NJSmRmURLGHqk2KOpr7sM7LOHydGhz2UOKxT6MP6HcTIc/jzoi84kFkuhcUaRhjw7BYULvnpYyQVbKnXPLcHMgXWc5Ufo+168w9Qe1hnW6eJTKDdsSLiFK+CjrXMmGMmpvYyoO5cd2R10ASOm951uAzDinmETRU1FPrtGcH0iNRwRfeDZtcYr3jhNGcLhNVcr5pfddJjwBqM7dnBzfYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 21:02:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 21:02:37 +0000
Date: Tue, 10 Jun 2025 17:02:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5 4/6] input: pf1550: add onkey support
Message-ID: <aEidZI0hTPFaB7e8@lizhi-Precision-Tower-5810>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-4-ed0d9e3aaac7@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-pf1550-v5-4-ed0d9e3aaac7@savoirfairelinux.com>
X-ClientProxiedBy: PH7PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:510:174::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 633c273c-ffe1-4ae4-f374-08dda86220fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QV6yOdZJgPEd2XWg5SgRxS/DIzd+OAv+VbueV56gKx5tQwmOvW+42YejWX1u?=
 =?us-ascii?Q?kBvCubkb+0DgfTR9sLvJ9xTIowb+/CER4cjqelInGawsJdqHDRY9OmF2HKE2?=
 =?us-ascii?Q?/l0XBlfKMEJQx9FRxNKSnAPiky103KBtmDjbOjr6tldUa+pTietqzU7cWHOt?=
 =?us-ascii?Q?OVLnt9bzBLJfB4wx6fgXDW4cBiULkZu06OhEEwJeHFuNt5Z5H2jansGwOdhf?=
 =?us-ascii?Q?dzN1ykITGT+mzJU5m28bc/oziSAcRBTeyC4B+5GDSA9hKySeM6ruuP0ZBUKE?=
 =?us-ascii?Q?NrSmeyBqgxniR6ulcHtXouBNlON8VU8Bwr+ClYW4e+5dYezhCPwVya23FSIs?=
 =?us-ascii?Q?jh4QYdcuWoAD4kA5l3Mh9uXK9zx/VwVrKGye7rHTh63sFWHNNPWZfjMcSCXq?=
 =?us-ascii?Q?prD6z7GvKG7qpt3VAN8vwAM2S3MkOH7v6jNT++eFqZaJSQ7njqDDb/51qUJw?=
 =?us-ascii?Q?XzVVFTvw2UbmWWbGc/Vm/+8BdM34LgEgjGEL+45MyG3aF0vibRvS/jAmtdVc?=
 =?us-ascii?Q?wbtTuJ3SaszzAhAkVin1i7M/LtvJ5wfQIb3Z+PTzsis/al/XR82IoP2XO8vV?=
 =?us-ascii?Q?YVq7CBDLvsVSblzar7u/VoQbdkE9MWdQfHdpEDzbpBo6QOcDFrXsoElDmRCt?=
 =?us-ascii?Q?+bgEDp+LEftpo3C4GnyeDnNMuEAfrPJzgHX95rSz2cTWjA82kyLBWNmcac15?=
 =?us-ascii?Q?nFtdSvQ6sMBt/Z4/l+zN4srG4dNg+Wti2t65d5IBLHP/kYP3YqDG3oPFfoTA?=
 =?us-ascii?Q?kdjCsxOmjzlXATaGUfeY8YZCsLqdlH996K+sYzzEfvWGccE0lXJ7HwN8T4pD?=
 =?us-ascii?Q?1QAD+3q4WJ04vPY7h+OmaT5R0puL3lnJcA2Gk0sjRLYagG1xlQ6KpRaGSjsg?=
 =?us-ascii?Q?0R2l2+Hx9gsWQPjoXpuN4Sg06jb3ee2bFn0Js2IBqNH/OyZRLY5iJxu11yQD?=
 =?us-ascii?Q?ECef64o2lalwmmzMm843+rg6H8URzHLlsSzgHinXIBwEo8u61HJ+E+EX75la?=
 =?us-ascii?Q?P9xDyc8dERsKKxvERCu7mM1KgZ7TVWFlNihzLms5jI1g+lcU+H01eyzX4zF6?=
 =?us-ascii?Q?yEy+tCmwjXUBfqAzYG3pMihCuUcNG958I8FV0IaNdtuysnsKBVFWYlYTLEq/?=
 =?us-ascii?Q?R0Tzyh7SgBpFB6wkSln5wI3VPku7iZeuqj3es6FeIJOIXP9F/bjOW0IroSRz?=
 =?us-ascii?Q?GoEHV+LvsNUfhIqeUeQua/vmSvcLDBfa1s2MWD8T34PaKj0ij5ocG/DwhkbB?=
 =?us-ascii?Q?Cinb0P5aOkx6G8dhhiU0vis3JOPqr5pMvELL9D+SOVMYgHbu61BVNpg3QsCV?=
 =?us-ascii?Q?eAvM9o89ekfO8LBnw3kOA8rfGW99B3GAS99zNj9YV7gKC61Lvtfw2+NhkER/?=
 =?us-ascii?Q?M0MeS1QW3KcKSdpEhuuDq+mqVO/uDkLVziMK1hAW0zm9TWqIrCjYXRVrX8Ml?=
 =?us-ascii?Q?WVToiJqK7N9or9R0S3HkUg18EkevE6NwvBlhO13hGHaZJaJwyIa5bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hSXZZAtV6e5Gi9LAlyX8naKCFO4ujLVZHHETVD/4i5T5StGoHnnnyVLFtOVn?=
 =?us-ascii?Q?ZXgQm8zQlvZJ6pv01S5U/oRT4ThtNoXklATeuyXCGBrPFmt4B0Zt7xJrKSEO?=
 =?us-ascii?Q?Y6eyyBP+X3fpAIB8tFOzSPaxwAYkRwp4xuKsjE4fAGar/rUxWUf5hSh9nhed?=
 =?us-ascii?Q?gcuHoKzn/bRhQibo3FYavdMrHj4vdUcRaXmWuAI7cpt+6iDoNeChwbnUaxBj?=
 =?us-ascii?Q?PQKxfewb9SrzyZI+/YBLtGFPYNuWzIDEpIBpxNIIU3jCoUYyIhV9RTx9I+Hz?=
 =?us-ascii?Q?weg/ctirdJdraSueBilXTaaxVhg0BiHxt5s5rpIIvcPaXf8BIiKGQR2xAgk4?=
 =?us-ascii?Q?uTcmBfZ2t707wKrARUSn/FuHf0Z+rXQmDFiDFtHuxkJknDCtXPwBd810/kXW?=
 =?us-ascii?Q?AIi8WTVGBSdlDi8P0JOtyyAYUXKJwXboBpa5T/8Cq3sru1u9dt5sqYxf2wD3?=
 =?us-ascii?Q?f6sHNKh9ON9Rxi4jzgiitP8Q/Rxc7iuC6YF03VEla2m1NXRtJ06tDwMrsJl7?=
 =?us-ascii?Q?dCLbM3iILgBC4AUSKHeFZI/DtIwky9xUc5VDyHjoSGemPxaSH1q2TW/3uMvL?=
 =?us-ascii?Q?ItLefpJWdCaqhUpaA07zYaMV0K6qXKukBtwtTa552+rUmymWC0R/k8eFc0Y9?=
 =?us-ascii?Q?merRArTTNqrPIP5yesdBRZ4LsfqmViR1tyqBCqPv7csOTT1dJnND320W6j8Y?=
 =?us-ascii?Q?RSKSHddh6kurTeG5Iwujc4wtOuJRjLlpBAikuS1Wr58Ikj5ndIwYe+d7+Iyc?=
 =?us-ascii?Q?xgZGpdVp/qUhY0lRsYCZHUG3GI1vYztPk7nNiILyxJASSitwp4Kw7IfmxL0M?=
 =?us-ascii?Q?EYPswch36Q2sOZ91f4dWxH3610AOZNokxXUpH9ZmO/erRWtUcEkb+iEGTnQz?=
 =?us-ascii?Q?3Qd+XYuQyeUu9lVCK2o9WnsSaElP9QN2skAoAf9/5Ci6HyzngYj+XHO8Ocnn?=
 =?us-ascii?Q?Smkj7R8EneTnEr9bfBiANlqA5+Kz4wJndeRUMov0/FC5JHX8Lah6De281ppp?=
 =?us-ascii?Q?rboaAPiqJBixz7M0X0WTzLUpss3dHliLtlHfF850wEtjWxzQl2hAPfGazU5s?=
 =?us-ascii?Q?YlaSsk2bIM0ysbuCNjlqZFUrx+KRiM47mOmPoz6lU9geduOIMHzf9OaA2+FW?=
 =?us-ascii?Q?U9IlXhjFKB/79cd0x+DiTUnhVEFpF7P0N+ew/8W25WBt0Kbn/k6/DhSXfutE?=
 =?us-ascii?Q?PVaoR7XyvRH4Ka1tFJ6j8Jhw0YU2U340uhZqs0GUrn46lw3/9QPqkJwf77/B?=
 =?us-ascii?Q?fJvABqC+cpHv1/WEyID66SHN+bpFBAJzyrDPHzh9EvSzgYIY6TimI8wMzRHp?=
 =?us-ascii?Q?60qkkqGKtFwkI+GxWqzxn6LtkgCT0eoY+fcUxNq+4opvz80ZcHCaa9AKwb4E?=
 =?us-ascii?Q?50ny6adOwSpnwuw+URv19M3sIfs1SwwnKMtRyYDm4FBIGdtwwgzwkIzZc/pb?=
 =?us-ascii?Q?TRoD+Q5vh8kPh2lFlgLDDvCL1OBrVDSbrNI9imx55F26Ss4yNTk402U+3jjY?=
 =?us-ascii?Q?tPbBPFGV+8FCjexG/xbcDiKT0bKcDakg2i9dTfnouI2JGn6LpZlH/BggDGob?=
 =?us-ascii?Q?6icpNzK9EajY5vPPXBfOqzzNVG0ImA1CSOE/1gqo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633c273c-ffe1-4ae4-f374-08dda86220fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 21:02:37.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w9ZaBOfsW8OdX+7v8JhOFcaULj/iqBOi+4Gjnnl15GHdaXAaOxz/mbg83DwTJLoRwF554Wa2PDmUE2WwPFT+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

On Tue, Jun 10, 2025 at 03:47:32PM -0400, Samuel Kayode wrote:
> Add support for the onkey of the pf1550 PMIC.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v4:
> - Address Dmitry's feedback
>   - Drop irq variable in onkey_drv_data
>   - Drop keycode variable in onkey_drv_data
>   - Define wakeup as type bool
>   - Use platform_get_irq
>   - Use type const for struct pf1550_dev in onkey_drv_data
>   - Replace (error < 0) with (error) in if statement when applicable
>   - No need to define driver_data in table id
> - Define driver.pm with pm_sleep_ptr
> v3:
> - Address Dmitry's feedback
>   - Drop compatible string
>   - Remove dependency on OF
>   - Use generic device properties
>   - Drop unnecessary includes
>   - Drop unnecessary initializations in probe
>   - Always use the KEY_POWER property for onkey->keycode
>   - Do mapping of irqs in MFD driver
>   - Define onkey->input before interrupts are active
>   - Drop unnecessary input_free_device since devm
>   - Manage onkey irqs instead of the main interrupt line.
> - Fix integer overflow when unmasking onkey irqs in onkey_resume.
> v2:
> - Add driver for onkey
> ---
>  drivers/input/misc/Kconfig        |  11 +++
>  drivers/input/misc/Makefile       |   1 +
>  drivers/input/misc/pf1550-onkey.c | 183 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index f5496ca0c0d2bfcb7968503ccd1844ff43bbc1c0..47b3c43ff0550f14d61990997976366436411adc 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -179,6 +179,17 @@ config INPUT_PCSPKR
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pcspkr.
>
> +config INPUT_PF1550_ONKEY
> +	tristate "NXP PF1550 Onkey support"
> +	depends on MFD_PF1550
> +	help
> +	  Say Y here if you want support for PF1550 PMIC. Onkey can trigger
> +	  release and 1s(push hold), 2s, 3s, 4s, 8s interrupt for long press
> +	  detect.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called pf1550-onkey.
> +
>  config INPUT_PM8941_PWRKEY
>  	tristate "Qualcomm PM8941 power key support"
>  	depends on MFD_SPMI_PMIC
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 6d91804d0a6f761a094e6c380f878f74c3054d63..c652337de464c1eeaf1515d0bc84d10de0cb3a74 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
>  obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
>  obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
>  obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
> +obj-$(CONFIG_INPUT_PF1550_ONKEY)	+= pf1550-onkey.o
>  obj-$(CONFIG_INPUT_PM8941_PWRKEY)	+= pm8941-pwrkey.o
>  obj-$(CONFIG_INPUT_PM8XXX_VIBRATOR)	+= pm8xxx-vibrator.o
>  obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+= pmic8xxx-pwrkey.o
> diff --git a/drivers/input/misc/pf1550-onkey.c b/drivers/input/misc/pf1550-onkey.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..7e604c5544066eefbd84abe7bdff767b8b8978ab
> --- /dev/null
> +++ b/drivers/input/misc/pf1550-onkey.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Driver for the PF1550 ON_KEY
> +// Copyright (C) 2016 Freescale Semiconductor, Inc. All Rights Reserved.
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +
> +#include <linux/err.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/platform_device.h>
> +
> +#define PF1550_ONKEY_IRQ_NR	6
> +
> +struct onkey_drv_data {
> +	struct device *dev;
> +	const struct pf1550_dev *pf1550;
> +	bool wakeup;
> +	struct input_dev *input;
> +};
> +
> +static irqreturn_t pf1550_onkey_irq_handler(int irq, void *data)
> +{
> +	struct onkey_drv_data *onkey = data;
> +	struct platform_device *pdev = to_platform_device(onkey->dev);
> +	int i, state, irq_type = -1;
> +
> +	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++)
> +		if (irq == platform_get_irq(pdev, i))
> +			irq_type = i;
> +
> +	switch (irq_type) {
> +	case PF1550_ONKEY_IRQ_PUSHI:
> +		state = 0;
> +		break;
> +	case PF1550_ONKEY_IRQ_1SI:
> +	case PF1550_ONKEY_IRQ_2SI:
> +	case PF1550_ONKEY_IRQ_3SI:
> +	case PF1550_ONKEY_IRQ_4SI:
> +	case PF1550_ONKEY_IRQ_8SI:
> +		state = 1;
> +		break;
> +	default:
> +		dev_err(onkey->dev, "onkey interrupt: irq %d occurred\n",
> +			irq_type);
> +		return IRQ_HANDLED;
> +	}
> +
> +	input_event(onkey->input, EV_KEY, KEY_POWER, state);
> +	input_sync(onkey->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pf1550_onkey_probe(struct platform_device *pdev)
> +{
> +	struct onkey_drv_data *onkey;
> +	struct input_dev *input;
> +	int i, irq, error;
> +
> +	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	onkey->dev = &pdev->dev;
> +
> +	onkey->pf1550 = dev_get_drvdata(pdev->dev.parent);
> +	if (!onkey->pf1550->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get regmap\n");
> +
> +	onkey->wakeup = device_property_read_bool(pdev->dev.parent,
> +						  "wakeup-source");
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "failed to allocate the input device\n");
> +
> +	input->name = pdev->name;
> +	input->phys = "pf1550-onkey/input0";
> +	input->id.bustype = BUS_HOST;
> +
> +	input_set_capability(input, EV_KEY, KEY_POWER);
> +
> +	onkey->input = input;
> +	platform_set_drvdata(pdev, onkey);
> +
> +	for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						  pf1550_onkey_irq_handler,
> +						  IRQF_NO_SUSPEND,
> +						  "pf1550-onkey", onkey);
> +		if (error)
> +			return dev_err_probe(&pdev->dev, error,
> +					     "failed: irq request (IRQ: %d)\n",
> +					     i);
> +	}
> +
> +	error = input_register_device(input);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "failed to register input device\n");
> +
> +	device_init_wakeup(&pdev->dev, onkey->wakeup);
> +
> +	return 0;
> +}
> +
> +static int pf1550_onkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
> +	int i, irq;
> +
> +	if (!device_may_wakeup(&pdev->dev))
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI | ONKEY_IRQ_2SI |
> +			     ONKEY_IRQ_3SI | ONKEY_IRQ_4SI | ONKEY_IRQ_8SI);
> +	else
> +		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +			irq = platform_get_irq(pdev, i);
> +			if (irq > 0)
> +				enable_irq_wake(irq);
> +		}
> +
> +	return 0;
> +}
> +
> +static int pf1550_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct onkey_drv_data *onkey = platform_get_drvdata(pdev);
> +	int i, irq;
> +
> +	if (!device_may_wakeup(&pdev->dev))
> +		regmap_write(onkey->pf1550->regmap,
> +			     PF1550_PMIC_REG_ONKEY_INT_MASK0,
> +			     ~((u8)(ONKEY_IRQ_PUSHI | ONKEY_IRQ_1SI |
> +			     ONKEY_IRQ_2SI | ONKEY_IRQ_3SI | ONKEY_IRQ_4SI |
> +			     ONKEY_IRQ_8SI)));
> +	else
> +		for (i = 0; i < PF1550_ONKEY_IRQ_NR; i++) {
> +			irq = platform_get_irq(pdev, i);
> +			if (irq > 0)
> +				disable_irq_wake(irq);
> +		}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pf1550_onkey_pm_ops, pf1550_onkey_suspend,
> +			 pf1550_onkey_resume);
> +
> +static const struct platform_device_id pf1550_onkey_id[] = {
> +	{ "pf1550-onkey", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_onkey_id);
> +
> +static struct platform_driver pf1550_onkey_driver = {
> +	.driver = {
> +		.name = "pf1550-onkey",
> +		.pm   = pm_sleep_ptr(&pf1550_onkey_pm_ops),
> +	},
> +	.probe = pf1550_onkey_probe,
> +	.id_table = pf1550_onkey_id,
> +};
> +module_platform_driver(pf1550_onkey_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("PF1550 onkey Driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>

