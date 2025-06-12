Return-Path: <linux-pm+bounces-28559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B70AD7781
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730491628E9
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E0299923;
	Thu, 12 Jun 2025 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UwTs3oRZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012032.outbound.protection.outlook.com [52.101.71.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD562F4317;
	Thu, 12 Jun 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744167; cv=fail; b=dFtYVyqTmYs+qXRegzH/bAVHcE1KM5jlTOfzbVMU0x0IEXgL3SfpZtbSaBAOI1pZNHaAZMlLDV8fSix/uTPFo7c/hsYLTe02xjbwfn5JBaVcqBmRgO8aSdlfyNprBl3AUcSQdqZXXn7CI09lMilya9fkOoliEdNXB5IQwBHHDKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744167; c=relaxed/simple;
	bh=U7HZbGW4jU1Lcs7FH5cVVvPipz6xIH5cdykO/dAJ6wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gSc0d1qXALo3EYjdvZ924hGOfwl6gRfkwK+dwhPHCghaP9tTXg9ZtfnIONpZNis+yQ7u80T5+J3G2wsQgl1/u/vCDZVkflYa+FzYAGFlXrGV/Hc1mT78RATDsfGAghTUeODAcxBOmUOeNCAyHZbx5Wo6Tui8pZEAjCHV5qUQ/OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UwTs3oRZ; arc=fail smtp.client-ip=52.101.71.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XacaMGvCyn/202FsF1wwvmzA4LUUwfWuskWqt7FAwOZJMFyhWWHXTqv4A3zxTm34ftItJ8PU7Ch09vMHXqFYC5HkDfnVSJ3bbwb0AyIf7463gdcDCv/dbI0Eg8x4r2naAEI55a9MdE0N7y2ZF2tv2wZmvVf9Oo2cWJRtT/FBA+WXW9yEPW2oxzTnYJdVO9vB82R5bRO/x4tRZAmIHxnr9fAX8I7E5Rm9UgedgOF+PH2XERzlO0bE9Pt3ZBaONohzOvKOj9dmNlXrostT9DSROR4UX97cjIH0w32/qJlCO7ihaBPOs1KN0YT9XQz1jILxmMp+xQ3MkV9/3+qEXhu+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6BLwtN7CszktD/SDsc1ixfpacR26/hH+SrJUPvxR88=;
 b=ncsuIq4TMjsYFtH3oDt9ir2IBbSshepHoOabi1WW8rc21fd/eE5FFmIHnkk3LhcbSdVVO2+EMZjmmV/WPAnbt87h8np/k9ZMQA633v+F6FpDF8vNSGzSEiyw73Fi3JPsofDvQm5DRE91HykiLFapZ/dNhgIRkgMSezCOQg630Z+hjLBxz7GZrmqfr6dNRxTx7sU16SRu5txyROtiQXWVAPu83/7sN0PORiPlOOW6r4rMio1h8wrFPJxiz+L5CJGjCkaemMkjV9oigsSyYI6lZhN8/Mdf9jCYeo6NrGxKWYHbyswLD6sCvNLDGvOFBbx+P09SDeOCsnt34zbm2Zz/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6BLwtN7CszktD/SDsc1ixfpacR26/hH+SrJUPvxR88=;
 b=UwTs3oRZkQgGhMLYemKUx2OcBUfyXVCT5sVypuDOFHuppRdvMiMAXNmFVhRI6+VY6C6PWTlZah/jKz3dkGyEVN1SOOWRfqog6QDJOzpts9zH4/Iuk4pLDDjuKNDRaa4SgyLBLv9VhIdvm13M9NASmTjtr53UP0qbOEt/t+gVK8eii1sr5coVBqq3isuvs+Ay+csc4fZigYaw2Unh98MthLoHTUaqQOSOpy3j7xwUWvG7CcW5x3rzNjlpcC26PQ5iQ4p/+16sMxXNfuStsNt+ppTctctxAh6pPTQDu9tCiMVFfgtghwccNNNVRmC0JfidMCV5A8wB4KFFOn1Grn/ssA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9347.eurprd04.prod.outlook.com (2603:10a6:10:357::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Thu, 12 Jun
 2025 16:02:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:02:42 +0000
Date: Thu, 12 Jun 2025 12:02:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v7 5/6] power: supply: pf1550: add battery charger support
Message-ID: <aEr6GZOrwOodBcKe@lizhi-Precision-Tower-5810>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-5-0e393b0f45d7@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-pf1550-v7-5-0e393b0f45d7@savoirfairelinux.com>
X-ClientProxiedBy: PH7PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:510:174::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 815deb27-71dd-4355-81df-08dda9ca8fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?czut/eLlGHBEM3bAtmUPP5A0oRjMqwVWjNkxJbq75hGfm/62nihl0PexDEOG?=
 =?us-ascii?Q?eA/fWy2yST3F9U82pZW9CVBhunjlI9chRdWKujQKd/0TuiAOhQBSlEidNGM3?=
 =?us-ascii?Q?lSj6SPTvb9GvNohSLgyJ7CcgDO/cWtG0KfuOv4GROvfVNlCBVktAE6fVznpo?=
 =?us-ascii?Q?LF1ytE9HCbU8TKibsNpqDQeJ1y56KFAUY6LnblXBoPvVjRY+MGyD4nsfhV6X?=
 =?us-ascii?Q?QH80k0Gd7Q+TJ1k/MorP9zWoQv1bYa5AJWU1GmoG1uJghDZMYQn+JHMZI6GZ?=
 =?us-ascii?Q?aVv0dygEoVn9V9zBi2kXYXRmgYgrgAi6EfBVONxS10RMcHt/wzVqrMyw/iq7?=
 =?us-ascii?Q?0X2pN1qS2aO4aPMCIDrxxyvkTVGWYC1It4QSNtM6LjTie6/9fLhOx067XPNA?=
 =?us-ascii?Q?rfeIU/rc/XBzI+FFNTG46DLMszlmmi0mh6b1bQuCNSjgAncpyIT/X9pdIf5F?=
 =?us-ascii?Q?WBizySBHAxdb/RG4jyJ8z618h0sdqq/EbWVOCXp9ik+dEqXDSFwYFiaCYKiH?=
 =?us-ascii?Q?YeRw4Zdl3kuWanW2YcsmKxhqtTdXCXZisBMiKF82IlMeUxwIEmMAghFKs8X/?=
 =?us-ascii?Q?SBsu6n3ErFzhIzxu0JzQ4KpxqXdJ1ZTP4AzG0IACxvs+XYQRJ4uF99T/loCn?=
 =?us-ascii?Q?dIwJlYSBSeLmHJ7kc5SJzPTJcssiLueJIbmM++800+OR8Vj828YwifNWin4x?=
 =?us-ascii?Q?jM0gxsQqhfiDcts9hCRaa/l5RQXI4dO2qrdpI0hNlWpgTp+KAYw7z6bZmlb3?=
 =?us-ascii?Q?+PKpooFZu63HcoNs8WYkbs+Vq4GC/B3HnTOgDO4CEkrUaWbL8RgD1glpckcM?=
 =?us-ascii?Q?yqet6nCWFyKbGAnQ/tC0HaP1DtHecXmAxeYcqYW5LFlaV9wcdKT1ar6y+Nwq?=
 =?us-ascii?Q?fUNvKmZvjsxDQLnOR5IYBMPBr43i5WD5p5D1vKHUe/hjP9dTKN1BX9gtKm3X?=
 =?us-ascii?Q?ExqiUF9qYOfr5zbQion9gd2jbG7ZGqO4PIiB6dTTC9mIv2kxhErXXjAlCryo?=
 =?us-ascii?Q?OWksTxd89jUfHwQ/IPnH+huqkt+e6F9AK5d6sy8Cj+VgG4UC+FrbGYBjeMcy?=
 =?us-ascii?Q?5HF7ZhSBLgZa8wtSTjL5Ox/T2v2XV9IGIWf9PBSZGEcWUtH+GjFXp8DeIpW0?=
 =?us-ascii?Q?eC3dRPK1RFCm18diIcKLnDE8S+i2onx9v3ZsWGKUKN1Rh0OLqxa5pvyfcSVj?=
 =?us-ascii?Q?AHKazucgTgNjDpygwJuM8g/Bp19FrNvkoCCCbSRocWfr1v47brbYewoq9w1K?=
 =?us-ascii?Q?yTAr3oqnQrszGglYLfM7ZLaWCnYil0XVSTiBEyXtIUpPBAyTbekQ1yhyllfH?=
 =?us-ascii?Q?cE0lZM8oqQTrqy0HXMSk/STbm0c9Rc7UMGQScZDfsqvDVwAQ7E8boi/f4Gdx?=
 =?us-ascii?Q?WS8pnlNon6F6IJmaxagSjSrXczLwbXZG77NIAKuswfvtCNsKJi92LdPUGNlz?=
 =?us-ascii?Q?5jWQ4kcJkFCnm3DxVEgeqrSih7x1P9TRDBDoZgoUMzx/uX9fX+la6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7hUHfYn9RTVJ2w0JZcW+iuKOg7cQSrg/K5ej2pmch0YlNqwRwRMneP5gMsK?=
 =?us-ascii?Q?exB1p+/RPwiGMJvTBtwL2RtS8GRnPaUhpFXDvAvWif2CEaNJQXY1iAo9Ofva?=
 =?us-ascii?Q?9ClmFv6QQD7sge1e2/MbtsJIHg2kvjT29KYLArubFEkHpEQOix2NlPtGUfAp?=
 =?us-ascii?Q?fJm3QC9dtsL3N/mGE+p5ttF6oJe0aCUufUOxZ42GpruLVNjjzTtaNC1NI7Le?=
 =?us-ascii?Q?ukrlJjBhnaAwdEv3OvRJgSNIScYxi6+I3w1r5MTxKqr4JpXfjYt74i3PHYDw?=
 =?us-ascii?Q?OKvTY7+xcb7pxEWC+cGCmaISJCNu4DzqaYybftMkES/CVndcGbgWPVCqXAZ8?=
 =?us-ascii?Q?HTFW+YUY/NwzXTm5n6Z/12bz8nBVGiCUAOObjq3iHrS9ec78nUM1u/rloQDh?=
 =?us-ascii?Q?8Q8L1IMPrO+LdKI/bcfUXR28iMsU0ZNPzLk7wylxCTAbB2rFGMnUNpnLFeXs?=
 =?us-ascii?Q?CWOCQSV4SmBmaHdarMvVVd192cklYSEBUrJO7UCJA8SUV3bQ63TeuEIRSTm2?=
 =?us-ascii?Q?essR0Ivmivq+k9bNkVYvqX9Ri4tfuEW1qjwWnLISZsC+BljtUtj4lD3tZVqM?=
 =?us-ascii?Q?UUlZ8i8q5Oo4/zGH+FoHk8zCdMf3qxeAi+rLeWzZhXTvpL/St3J9IG8zOqKH?=
 =?us-ascii?Q?LpxnLON3jj5ZkmzVzJIQjfLI9DLadKpdQcC6f9ZXpYjV8Uyaur/aonhVupen?=
 =?us-ascii?Q?Y4cNk4mVEF3vnnsaA1wka0AdJ7uWermhWr+lv2YhBSXeBYKf+ob9V0Z2qWcC?=
 =?us-ascii?Q?Ww5oGE7SzwM/i7LZd+2ErZfRIQzdIWL9S9GPz0vFrbnajqPg8Egn2UHlboQ4?=
 =?us-ascii?Q?oAXWX5maIERXHDqOB3yEUR7QcO2SL9v8d+GiJXLFozRikZs1IlUQzjyncwFN?=
 =?us-ascii?Q?DFwivEr2DN5HSvyS/NWkWwxdFRKkuzKoFYUdsMTr4HuldaztK9qeETVKdFIO?=
 =?us-ascii?Q?029TTUgdtXvX2it0jN8xP/DdTxSsGddBzcdpUa72Dp4hujoMjkjGfxeWrJId?=
 =?us-ascii?Q?JRydi5fH+zR9Aebn3anqxIJ22mz2fbepOdmVIaF9ChDxNdR/3MN77u9TeKHp?=
 =?us-ascii?Q?STQSZdCJFPmAgbJCcJM8/kCTaN7SFjfheBbB5HvUQMKAJEJn4oXUgSPVNlxc?=
 =?us-ascii?Q?u1n9WyyNtd37NRgNFVxQ5ponTWQJBR/4vSqkwk2qLGvE4JZcAiYD/CYjY4fI?=
 =?us-ascii?Q?uO4fC75cfwdEkv9lHODrcU/wh1F+V1tI3bulGSo9HXP6Pw0xEig5KExWXbEs?=
 =?us-ascii?Q?vdhbd6Tici6tgWpWkdrFM8Vz41FTHaE6iRFRQ0FP9I+szhTIcg4T0otpVt73?=
 =?us-ascii?Q?4l3K2ps1J7LvlqC6567amOxWNvZzYgRXASonaL3t+f9Wc+4LSZ8YUzq6rTLB?=
 =?us-ascii?Q?wkFT0gswgFRaXotTm4UOugt9pZd0n80/g8lsMAOOkBNxZqccKZnzin2YVLjX?=
 =?us-ascii?Q?M5peimCID40bHGFEOBEuwOrxWrGMF3ze/aGDehLXMEBxfF8VMAvu9iNFMH5A?=
 =?us-ascii?Q?98PfYDRXCmRDNp8MVrLxJNSPjHasfFXSVzZaKTs8Y5wtLDyeHuY17hDvvCKC?=
 =?us-ascii?Q?wbqdF5SDETYlmcSwRvfKn1VXC2uzISpAUHA0GvyU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815deb27-71dd-4355-81df-08dda9ca8fbc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:02:41.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hU0oSIf5tPEpZDhWbTBBvN5AUlcckafjNGgvnXNiS3nSZZmbL9yEHfZqmEyq7/JDBPdV0LHWUDt1Rl+xAeCgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9347

On Thu, Jun 12, 2025 at 10:55:47AM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>
> Add support for the battery charger for pf1550 PMIC.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v7:
> - Use reverse christmas tree order
> - Drop unecessary 0 in id table's driver data field
> - Store virqs to avoid reinvoking platform_get_irq in the interrupt
>   service routine
> - Drop manufacturer and model global variables
> v6:
> - Drop lock entirely
> - Reverse christmas tree order for variables defined in probe as
>   suggested by Frank
> - return pf1550_reg_init
> v5:
> - Drop lock for battery and charger delayed_work
> - More conservative locking in vbus delayed_work
> - Apply lock when setting power supply type during register initialization
> v4:
> - Finish handling of some interrupts in threaded irq handler
> - Use platform_get_irq
> v3:
> - Use struct power_supply_get_battery_info to get constant charge
>   voltage if specified
> - Use virqs mapped in MFD driver
> v2:
> - Address feedback from Enric Balletbo Serra
> ---
>  drivers/power/supply/Kconfig          |  11 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/pf1550-charger.c | 632 ++++++++++++++++++++++++++++++++++
>  3 files changed, 644 insertions(+)
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..6d0c872edac1f45da314632e671af1aeda4c87b8 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -471,6 +471,17 @@ config CHARGER_88PM860X
>  	help
>  	  Say Y here to enable charger for Marvell 88PM860x chip.
>
> +config CHARGER_PF1550
> +	tristate "NXP PF1550 battery charger driver"
> +	depends on MFD_PF1550
> +	help
> +	  Say Y to enable support for the NXP PF1550 battery charger.
> +	  The device is a single cell Li-Ion/Li-Polymer battery charger for
> +	  portable application.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called pf1550-charger.
> +
>  config BATTERY_RX51
>  	tristate "Nokia RX-51 (N900) battery driver"
>  	depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..7f68380099c59dab71b73120150612a23e16a745 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_CHARGER_RT9467)	+= rt9467-charger.o
>  obj-$(CONFIG_CHARGER_RT9471)	+= rt9471.o
>  obj-$(CONFIG_BATTERY_TWL4030_MADC)	+= twl4030_madc_battery.o
>  obj-$(CONFIG_CHARGER_88PM860X)	+= 88pm860x_charger.o
> +obj-$(CONFIG_CHARGER_PF1550)	+= pf1550-charger.o
>  obj-$(CONFIG_BATTERY_RX51)	+= rx51_battery.o
>  obj-$(CONFIG_AB8500_BM)		+= ab8500_bmdata.o ab8500_charger.o ab8500_fg.o ab8500_btemp.o ab8500_chargalg.o
>  obj-$(CONFIG_CHARGER_CPCAP)	+= cpcap-charger.o
> diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1693fb2afdd444e088827edc476fa271fb0937e0
> --- /dev/null
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// pf1550_charger.c - charger driver for the PF1550
> +//
> +// Copyright (C) 2016 Freescale Semiconductor, Inc.
> +// Robin Gong <yibin.gong@freescale.com>
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +
> +#define PF1550_CHARGER_NAME		"pf1550-charger"
> +#define PF1550_DEFAULT_CONSTANT_VOLT	4200000
> +#define PF1550_DEFAULT_MIN_SYSTEM_VOLT	3500000
> +#define PF1550_DEFAULT_THERMAL_TEMP	75
> +#define PF1550_CHARGER_IRQ_NR		5
> +
> +struct pf1550_charger {
> +	struct device *dev;
> +	const struct pf1550_dev *pf1550;
> +	struct power_supply *charger;
> +	struct power_supply_desc psy_desc;
> +	struct delayed_work vbus_sense_work;
> +	struct delayed_work chg_sense_work;
> +	struct delayed_work bat_sense_work;
> +	int virqs[PF1550_CHARGER_IRQ_NR];
> +
> +	u32 constant_volt;
> +	u32 min_system_volt;
> +	u32 thermal_regulation_temp;
> +};
> +
> +static int pf1550_get_charger_state(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_CHG_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_CHG_PRECHARGE:
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +		*val = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case PF1550_CHG_CONSTANT_VOL:
> +		*val = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case PF1550_CHG_EOC:
> +		*val = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case PF1550_CHG_DONE:
> +		*val = POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case PF1550_CHG_TIMER_FAULT:
> +	case PF1550_CHG_SUSPEND:
> +		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case PF1550_CHG_OFF_INV:
> +	case PF1550_CHG_OFF_TEMP:
> +	case PF1550_CHG_LINEAR_ONLY:
> +		*val = POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	default:
> +		*val = POWER_SUPPLY_STATUS_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_charge_type(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_CHG_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_CHG_SNS_MASK:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +	case PF1550_CHG_CONSTANT_VOL:
> +	case PF1550_CHG_EOC:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	case PF1550_CHG_DONE:
> +	case PF1550_CHG_TIMER_FAULT:
> +	case PF1550_CHG_SUSPEND:
> +	case PF1550_CHG_OFF_INV:
> +	case PF1550_CHG_BAT_OVER:
> +	case PF1550_CHG_OFF_TEMP:
> +	case PF1550_CHG_LINEAR_ONLY:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	default:
> +		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Supported health statuses:
> + *  - POWER_SUPPLY_HEALTH_DEAD
> + *  - POWER_SUPPLY_HEALTH_GOOD
> + *  - POWER_SUPPLY_HEALTH_OVERVOLTAGE
> + *  - POWER_SUPPLY_HEALTH_UNKNOWN
> + */
> +static int pf1550_get_battery_health(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_BAT_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_BAT_NO_DETECT:
> +		*val = POWER_SUPPLY_HEALTH_DEAD;
> +		break;
> +	case PF1550_BAT_NO_VBUS:
> +	case PF1550_BAT_LOW_THAN_PRECHARG:
> +	case PF1550_BAT_CHARG_FAIL:
> +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> +		*val = POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case PF1550_BAT_OVER_VOL:
> +		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +	default:
> +		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_present(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &= PF1550_BAT_SNS_MASK;
> +	*val = (data == PF1550_BAT_NO_DETECT) ? 0 : 1;
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_online(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret = regmap_read(regmap, PF1550_CHARG_REG_VBUS_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (data & PF1550_VBUS_VALID) ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +static void pf1550_chg_bat_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  bat_sense_work);
> +	unsigned int data;
> +
> +	if (!chg->charger)
> +		return;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_BATT_SNS, &data)) {
> +		dev_err(chg->dev, "Read BATT_SNS error.\n");
> +		return;
> +	}
> +
> +	switch (data & PF1550_BAT_SNS_MASK) {
> +	case PF1550_BAT_NO_VBUS:
> +		dev_dbg(chg->dev, "No valid VBUS input.\n");
> +		break;
> +	case PF1550_BAT_LOW_THAN_PRECHARG:
> +		dev_dbg(chg->dev, "VBAT < VPRECHG.LB.\n");
> +		break;
> +	case PF1550_BAT_CHARG_FAIL:
> +		dev_dbg(chg->dev, "Battery charging failed.\n");
> +		break;
> +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> +		dev_dbg(chg->dev, "VBAT > VPRECHG.LB.\n");
> +		break;
> +	case PF1550_BAT_OVER_VOL:
> +		dev_dbg(chg->dev, "VBAT > VBATOV.\n");
> +		break;
> +	case PF1550_BAT_NO_DETECT:
> +		dev_dbg(chg->dev, "Battery not detected.\n");
> +		break;
> +	default:
> +		dev_err(chg->dev, "Unknown value read:%x\n",
> +			data & PF1550_CHG_SNS_MASK);
> +	}
> +}
> +
> +static void pf1550_chg_chg_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  chg_sense_work);
> +	unsigned int data;
> +
> +	if (!chg->charger)
> +		return;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_SNS, &data)) {
> +		dev_err(chg->dev, "Read CHG_SNS error.\n");
> +		return;
> +	}
> +
> +	switch (data & PF1550_CHG_SNS_MASK) {
> +	case PF1550_CHG_PRECHARGE:
> +		dev_dbg(chg->dev, "In pre-charger mode.\n");
> +		break;
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +		dev_dbg(chg->dev, "In fast-charge constant current mode.\n");
> +		break;
> +	case PF1550_CHG_CONSTANT_VOL:
> +		dev_dbg(chg->dev, "In fast-charge constant voltage mode.\n");
> +		break;
> +	case PF1550_CHG_EOC:
> +		dev_dbg(chg->dev, "In EOC mode.\n");
> +		break;
> +	case PF1550_CHG_DONE:
> +		dev_dbg(chg->dev, "In DONE mode.\n");
> +		break;
> +	case PF1550_CHG_TIMER_FAULT:
> +		dev_info(chg->dev, "In timer fault mode.\n");
> +		break;
> +	case PF1550_CHG_SUSPEND:
> +		dev_info(chg->dev, "In thermistor suspend mode.\n");
> +		break;
> +	case PF1550_CHG_OFF_INV:
> +		dev_info(chg->dev, "Input invalid, charger off.\n");
> +		break;
> +	case PF1550_CHG_BAT_OVER:
> +		dev_info(chg->dev, "Battery over-voltage.\n");
> +		break;
> +	case PF1550_CHG_OFF_TEMP:
> +		dev_info(chg->dev, "Temp high, charger off.\n");
> +		break;
> +	case PF1550_CHG_LINEAR_ONLY:
> +		dev_dbg(chg->dev, "In Linear mode, not charging.\n");
> +		break;
> +	default:
> +		dev_err(chg->dev, "Unknown value read:%x\n",
> +			data & PF1550_CHG_SNS_MASK);
> +	}
> +}
> +
> +static void pf1550_chg_vbus_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg = container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  vbus_sense_work);
> +	bool psy_changed = false;
> +	unsigned int data;
> +
> +	if (!chg->charger)
> +		return;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data)) {
> +		dev_err(chg->dev, "Read VBUS_SNS error.\n");
> +		return;
> +	}
> +
> +	if (data & PF1550_VBUS_UVLO) {
> +		chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +		psy_changed = true;
> +		dev_dbg(chg->dev, "VBUS detached.\n");
> +	}
> +	if (data & PF1550_VBUS_IN2SYS)
> +		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
> +	if (data & PF1550_VBUS_OVLO)
> +		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
> +	if (data & PF1550_VBUS_VALID) {
> +		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> +		psy_changed = true;
> +		dev_dbg(chg->dev, "VBUS attached.\n");
> +	}
> +
> +	if (psy_changed)
> +		power_supply_changed(chg->charger);
> +}
> +
> +static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
> +{
> +	struct pf1550_charger *chg = data;
> +	struct device *dev = chg->dev;
> +	int i, irq_type = -1;
> +
> +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++)
> +		if (irq == chg->virqs[i])
> +			irq_type = i;
> +
> +	switch (irq_type) {
> +	case PF1550_CHARG_IRQ_BAT2SOCI:
> +		dev_info(dev, "BAT to SYS Overcurrent interrupt.\n");
> +		break;
> +	case PF1550_CHARG_IRQ_BATI:
> +		schedule_delayed_work(&chg->bat_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_CHGI:
> +		schedule_delayed_work(&chg->chg_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_VBUSI:
> +		schedule_delayed_work(&chg->vbus_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_THMI:
> +		dev_info(dev, "Thermal interrupt.\n");
> +		break;
> +	default:
> +		dev_err(dev, "unknown interrupt occurred.\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static enum power_supply_property pf1550_charger_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static int pf1550_charger_get_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct pf1550_charger *chg = power_supply_get_drvdata(psy);
> +	struct regmap *regmap = chg->pf1550->regmap;
> +	int ret = 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret = pf1550_get_charger_state(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret = pf1550_get_charge_type(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret = pf1550_get_battery_health(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret = pf1550_get_present(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret = pf1550_get_online(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval = "PF1550";
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval = "NXP";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pf1550_set_constant_volt(struct pf1550_charger *chg,
> +				    unsigned int uvolt)
> +{
> +	unsigned int data;
> +
> +	if (uvolt >= 3500000 && uvolt <= 4440000)
> +		data = 8 + (uvolt - 3500000) / 20000;
> +	else
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for constant voltage\n");
> +
> +	dev_dbg(chg->dev, "Charging constant voltage: %u (0x%x)\n", uvolt,
> +		data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_BATT_REG,
> +				  PF1550_CHARG_REG_BATT_REG_CHGCV_MASK, data);
> +}
> +
> +static int pf1550_set_min_system_volt(struct pf1550_charger *chg,
> +				      unsigned int uvolt)
> +{
> +	unsigned int data;
> +
> +	switch (uvolt) {
> +	case 3500000:
> +		data = 0x0;
> +		break;
> +	case 3700000:
> +		data = 0x1;
> +		break;
> +	case 4300000:
> +		data = 0x2;
> +		break;
> +	default:
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for minimum system voltage\n");
> +	}
> +
> +	data <<= PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT;
> +
> +	dev_dbg(chg->dev, "Minimum system regulation voltage: %u (0x%x)\n",
> +		uvolt, data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_BATT_REG,
> +				  PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK, data);
> +}
> +
> +static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg,
> +					      unsigned int cells)
> +{
> +	unsigned int data;
> +
> +	switch (cells) {
> +	case 60:
> +		data = 0x0;
> +		break;
> +	case 75:
> +		data = 0x1;
> +		break;
> +	case 90:
> +		data = 0x2;
> +		break;
> +	case 105:
> +		data = 0x3;
> +		break;
> +	default:
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for thermal temperature\n");
> +	}
> +
> +	data <<= PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
> +
> +	dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
> +		cells, data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_THM_REG_CNFG,
> +				  PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK,
> +				  data);
> +}
> +
> +/*
> + * Sets charger registers to proper and safe default values.
> + */
> +static int pf1550_reg_init(struct pf1550_charger *chg)
> +{
> +	struct device *dev = chg->dev;
> +	unsigned int data;
> +	int ret;
> +
> +	/* Unmask charger interrupt, mask DPMI and reserved bit */
> +	ret =  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MASK,
> +			    PF1550_CHG_INT_MASK);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Error unmask charger interrupt\n");
> +
> +	ret = regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS,
> +			  &data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Read charg vbus_sns error\n");
> +
> +	if (data & PF1550_VBUS_VALID)
> +		chg->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> +
> +	ret = pf1550_set_constant_volt(chg, chg->constant_volt);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_set_min_system_volt(chg, chg->min_system_volt);
> +	if (ret)
> +		return ret;
> +
> +	ret = pf1550_set_thermal_regulation_temp(chg,
> +						 chg->thermal_regulation_temp);
> +	if (ret)
> +		return ret;
> +
> +	/* Turn on charger */
> +	ret = regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_OPER,
> +			   PF1550_CHG_TURNON);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error turn on charger\n");
> +
> +	return 0;
> +}
> +
> +static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
> +{
> +	struct power_supply_battery_info *info;
> +	struct device *dev = chg->dev;
> +
> +	if (device_property_read_u32(dev->parent, "nxp,min-system-microvolt",
> +				     &chg->min_system_volt))
> +		chg->min_system_volt = PF1550_DEFAULT_MIN_SYSTEM_VOLT;
> +
> +	if (device_property_read_u32(dev->parent,
> +				     "nxp,thermal-regulation-celsius",
> +				     &chg->thermal_regulation_temp))
> +		chg->thermal_regulation_temp = PF1550_DEFAULT_THERMAL_TEMP;
> +
> +	if (power_supply_get_battery_info(chg->charger, &info))
> +		chg->constant_volt = PF1550_DEFAULT_CONSTANT_VOLT;
> +	else
> +		chg->constant_volt = info->constant_charge_voltage_max_uv;
> +}
> +
> +static int pf1550_charger_probe(struct platform_device *pdev)
> +{
> +	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg = {};
> +	struct pf1550_charger *chg;
> +	int i, irq, ret;
> +
> +	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	chg->dev = &pdev->dev;
> +	chg->pf1550 = pf1550;
> +
> +	if (!chg->pf1550->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get regmap\n");
> +
> +	platform_set_drvdata(pdev, chg);
> +
> +	INIT_DELAYED_WORK(&chg->vbus_sense_work, pf1550_chg_vbus_work);
> +	INIT_DELAYED_WORK(&chg->chg_sense_work, pf1550_chg_chg_work);
> +	INIT_DELAYED_WORK(&chg->bat_sense_work, pf1550_chg_bat_work);
> +
> +	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		chg->virqs[i] = irq;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						pf1550_charger_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						"pf1550-charger", chg);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed irq request\n");
> +	}
> +
> +	psy_cfg.drv_data = chg;
> +
> +	chg->psy_desc.name = PF1550_CHARGER_NAME;
> +	chg->psy_desc.type = POWER_SUPPLY_TYPE_BATTERY;
> +	chg->psy_desc.get_property = pf1550_charger_get_property;
> +	chg->psy_desc.properties = pf1550_charger_props;
> +	chg->psy_desc.num_properties = ARRAY_SIZE(pf1550_charger_props);
> +
> +	chg->charger = devm_power_supply_register(&pdev->dev, &chg->psy_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(chg->charger))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
> +				     "failed: power supply register\n");
> +
> +	pf1550_dt_parse_dev_info(chg);
> +
> +	return pf1550_reg_init(chg);
> +}
> +
> +static void pf1550_charger_remove(struct platform_device *pdev)
> +{
> +	struct pf1550_charger *chg = platform_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&chg->bat_sense_work);
> +	cancel_delayed_work_sync(&chg->chg_sense_work);
> +	cancel_delayed_work_sync(&chg->vbus_sense_work);
> +}
> +
> +static const struct platform_device_id pf1550_charger_id[] = {
> +	{ "pf1550-charger", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
> +
> +static struct platform_driver pf1550_charger_driver = {
> +	.driver = {
> +		.name	= "pf1550-charger",
> +	},
> +	.probe		= pf1550_charger_probe,
> +	.remove		= pf1550_charger_remove,
> +	.id_table	= pf1550_charger_id,
> +};
> +module_platform_driver(pf1550_charger_driver);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_DESCRIPTION("PF1550 charger driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>
>

