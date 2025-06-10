Return-Path: <linux-pm+bounces-28417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AC5AD4445
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 22:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F8B17A89D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25DD2676FF;
	Tue, 10 Jun 2025 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EE/xyLw2"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019F4685;
	Tue, 10 Jun 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589097; cv=fail; b=G0WuV6wBwj9JIY0mPwQ97Nz7INkTtPsn5jvkWztl/6ykRCDhNnV3fGtE5mPLg+3LKYBfLGrmqoRMbENjl+EAP0L1BHY4NYvqQUDo3sj3fJ8fXT32k3D20l7ZL60y9TheBlZLNuu4iKB2IYYAznlBt6AkjRRLJgb8gsPQXxWeJ4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589097; c=relaxed/simple;
	bh=QmHjYcIIFZkRYhP2mB7617KkRyTb17Kb6QTnxgMpEC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JK+WPqoxWaOog3qbkUdtnaZXgX83jwN4QeiqI4TRhT1OS484JFehFg6PosN7wfS0e0vnNEepbR6QNN4CojwBpqDvscEAspJYxYiRZCXIXjJ0/490iRSuPJ2qRmUM1wwpQbR+Lvkf9t7evfa7bF7MXBZleRquJPaq0vfiiHTwbI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EE/xyLw2; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlFiWfq/hEnaE4ryChcUqCZ/URbQbgdQVwXvspDrW4GuQalpyMTWvkxMD5wC2h3lUTNgaiH/FOZBlPrqRsfFz/tTbaJ0FY2GsE87oU8fSao46u2Aquja5hevsgKjRAY35A2muIPaSEoSv8FgONZIJubFNteWOPxqPTVGIt1TY/tmZOVDQRupUT8/sqiM8KZdFT1rWMxbExI9s/OVREde9M+SqeFn4MIN6Ipx6lxz9EGMVX9r2GKpDL/FvhVfnhX2cQ1dJ5r35gthiiz0rNtjBDZHezTz7qciotCeHwwfq26WhPKqn4H1V2t4cX0ipC6DbNxlWiRt9ExnJW11/lvOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2pN1ZS/BreatNf6TmKWxky8IcUkVZ7fVGA0xwTspQ4=;
 b=pFi21sPPnhX26ICditznuthDMyMx+K5/VnDmGKhf1nT1iJObjWKw2ZEL05wtez0lpA5WDURxpWXd3qMA2kHHsc4EarNamy8G4W8TXAKljIA8TcD3bJ9sRXNDun1RnLHEaxSZjWfMxAi/9LfC7P9QAxPoUlKPrCDdjZjPebggCAI37Q1NNbRNNaJZiGfNOqwItNzeqzRiVSgYZ1W+rthMKHF5KRDgmW1DkcK14sVfcaqdKdDcETc+N058ltUBN+npVwzrDHZt8kxZ7MDeuYRAwYdsRJoG6bpgoyZSRipsD1Q4ERGmxsnIwYC4gsvGQHwBtX/HjQnYxRXF9IzMFlXxFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2pN1ZS/BreatNf6TmKWxky8IcUkVZ7fVGA0xwTspQ4=;
 b=EE/xyLw2fdPjG4eapRl0EhOXbwfSpdQjQiBkyjzZM/KAC0qNptFBY/ikGmPGbA6H1glF+3y8RVlOhl3hEHs/ZUK36sHc9oGOVNfctN1mABq9AKTJ+Z+0BtkLRW3SIvEgbc4zP5Eqw0tw/5me209elwINrvjAwzj7LmHZFUE3OJMMX16VzmrkvDyeid9osWoEox04KCwzeT+bZo2FSUJLZnEYXY5BYleuG7HikCF4U2spytsy3/gB7OewzcK9sinCKIbnwcyXRkW/NJoTZun9AT5btIa2DRe3TzYanbyrvdfo3QzusgUBHl5JmPvDBfg3FMOdbBxTAEO+MKJYbPVPIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 20:58:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 20:58:10 +0000
Date: Tue, 10 Jun 2025 16:58:01 -0400
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
Subject: Re: [PATCH v5 3/6] regulator: pf1550: add support for regulator
Message-ID: <aEicWcrWr1TMq9r9@lizhi-Precision-Tower-5810>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-3-ed0d9e3aaac7@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-pf1550-v5-3-ed0d9e3aaac7@savoirfairelinux.com>
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b65034a-533e-429c-6d0a-08dda861820d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvLKw6qPFHtZyBKei3Sl7t1si5R+zforp5wUraQTYZs9o0RaIhZzUb+GO+Uj?=
 =?us-ascii?Q?bWPcDryc+zw7mToINh5LdoeUKIjwPmoitgL3rF3q+8XsnJM5z6Ij5Zel4guw?=
 =?us-ascii?Q?Zrpzl/hPmtgDclsYyuSVGllNSBSDAa4GGnz9vooug9Le98gh279n1uVBHkNi?=
 =?us-ascii?Q?hGrOtgHIf9BFfkXiGA+op7gCEJWW+Yn6ZtgWsL1/dULg2YNncLK7WtDrQihx?=
 =?us-ascii?Q?P84jByT4rpxLHnUOXELEeLsINtqqYRxVixh9zUbGy3R1wTklLu4GSx3H8kyS?=
 =?us-ascii?Q?c+UaTbaYG/0YLQYXof3wLh7QSsZvRjfYPio+rLitdqjh2CmQuG9+JuEt9tct?=
 =?us-ascii?Q?3NWo8ifX1tVnoAvS5EXZifNcw5yEY1vKqw3c2R5DOIwEnKPGiBofcVBullxn?=
 =?us-ascii?Q?EkHZ/PCes6IDT8bbr8S06F8zsW0SGH5YUJXuaN7dtQBlY2cpPCEwA0A0t6R7?=
 =?us-ascii?Q?0zyY27MWwRTtLfnzJOjCpowAeNLFvd2k72NboARfDS6YS0SytfozbgqTDQv9?=
 =?us-ascii?Q?lzXbbaTegLQINKyYlIx77jXDVenvT+QNAue4SZlq2rRmW5h/Moiqe7Lkg8Ab?=
 =?us-ascii?Q?DrpcBNWwKYnW4IxL8LFWv8z+Nq1bfTYmbACwR+28uNt9v3Y7QFz2UX2zarOs?=
 =?us-ascii?Q?U+fgtOdq694x3/nCPHDP1i/+AzhCa9PleQBTFnGNIfhT4uTEdFnq52XZpzyy?=
 =?us-ascii?Q?+j7IXvwjcIDD/Gogvckr5gsM3QffCJyXzG73h7JjGhJfRipRG9o5JNjDV6eq?=
 =?us-ascii?Q?dJtPS0Xef6qqWxpz0eKbvzhbQr750GaF0YoYPN3cnLIOR9cyMAG7sXFIP0xR?=
 =?us-ascii?Q?KpgkRybJvWkvQtN8g+MUgUebpNIg5c2U+DBVp7w2QdbOYggKk35E+FZ91TOp?=
 =?us-ascii?Q?mqzNhbiHUTjihxCzNUqtY7l8LJKegPBmusvBkaB+Rvh6/GRtgGASw55SmwAa?=
 =?us-ascii?Q?i2lx9LkNFD5jJuMTtu45IxJKDb2+iHz3q0eVS1OUihbK+o6O8LY0Ov6+tUUy?=
 =?us-ascii?Q?BAd91O1uHTVJb1kNzUBpyLvB4zbW005PIYxVKMFvf/MhfnqcCZZFKHxQhdaL?=
 =?us-ascii?Q?XtuyulJd1yFQXXmbCcMSpIqMKeKjaBbVFJfsC0mBts6YBMfJ2w5qhqVdqjrK?=
 =?us-ascii?Q?iOQHXKEsvzINW6DzBPGvAM8jetXXoOLdwRM79fYmUJ9hB9jIH7QpjnP3X9y1?=
 =?us-ascii?Q?1uXphQOXRZ96wuVFC4FdgUzQK0m9UTCYCtG5YrX+g2vKdhCcnFeitftWK9CN?=
 =?us-ascii?Q?oRInurz97Uj5a6HWO/dGjZ8UYpRHziwI3o0Br6IMhHWfxHxVI6upetwNn+MG?=
 =?us-ascii?Q?4df87TlKFn96USrlX1qaQSY8Mk24ONIgfvmMQW+FhAB8I9zX5M47ufadVDYG?=
 =?us-ascii?Q?Gp8fGP0BJQFFupa3LHAPZSNoj/MwWgyKtlc4NFFbLgTtXZi2FWGknRdwnuS+?=
 =?us-ascii?Q?VQb6X2+9kxtMTWWXly8kxgnWa9xz30NEuX1VzG7+wcb6brCcHBag7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kAM/bZs+icGRLUCX2ZoKzir9l2ZRFsaXo1eca99G2Ejq7Ob+aHtCUQtFvME8?=
 =?us-ascii?Q?W5FibC97iZSMv5S0jfZiLpETjjYxM728BDU/ENnpMXGBOelJKMOMmDhkaBji?=
 =?us-ascii?Q?EIA0xo4N1ORu7UGQeystKu2Z2TyZ6eeOlPiKVViXzulKXKTKAK6SBUROPPgY?=
 =?us-ascii?Q?0P69NU5IuJsFzkPP6G6g3WuNoM/UXdD5ii3mA0hJfi2LRgCWsIe3WsbiZg6+?=
 =?us-ascii?Q?6Mcx1K/yfoPccbvyaBgGAuhMWCw+UufN6PfTlumnba8+pkpnNWJMqszXPZ6a?=
 =?us-ascii?Q?JIEtPTKfp7RPJAYj+0eMmHgHDSzdqvOndonClMz15cFu49KE8gXemRq+xzga?=
 =?us-ascii?Q?+hBK/1GqvZa6Qltjp/UBk3w/JqQqILD9EJkpvuXm7vv6s4KE4+7nEfPP8xAq?=
 =?us-ascii?Q?TXsvYXeRmyA1rueuccZ5A8uYVQ2rf8ykm/bc2C+ygRIlq894qEXg428AzJ4n?=
 =?us-ascii?Q?IwMiOP5FVkKwhX/7N6VSAcCKx7xE/fb4nf42uivqKnspZqhLq6trQmAqfGah?=
 =?us-ascii?Q?vJ4pdUA0DlzjbiPgrBP7f+igFYfqvcNe/jkHCZRtGpbxHJy4iJB1aBsMKGhY?=
 =?us-ascii?Q?Eo8Qs0e18X61gS1GactkMIcoDjfY8sYW3ELZn0XIovjkISohuu/cyc2bcq8H?=
 =?us-ascii?Q?pdlI6tBSNJRBkeYc4j6/tFiEhJ4Kd1nsdXn07BHFssNdgf5GE4+RoV8dl3Vx?=
 =?us-ascii?Q?KVhAMlDaxyQl/xjFb18tyP+VkeybBYkHRo5qWsSqprton3z8tlpKTz4dYYkR?=
 =?us-ascii?Q?rH1ySdCkSqEEEm8TBj8H6YvCzn8U9r0Bbj49qocP6Jhl0cjXI/RoCSYEV6V+?=
 =?us-ascii?Q?BwC8wYOt+0or7TvyUw9LVg/Kg/D4QDPAjT7EveZLHoLBLXCpsDkCv3ot9O9/?=
 =?us-ascii?Q?ae9a0lL9jHjzK4s+1m+ugak3L5ji/MZhvFpomIuiPGDFtmzL73R+Kcmfprda?=
 =?us-ascii?Q?3gOr32qaFDqhbXDDtYG6q6AOTLTpHIcoxTGlV/zcs9+wToBtvQb5Hme2zWB6?=
 =?us-ascii?Q?ruDSiQ69v2f7R/N8pBUB2Z2ehBaUV8W3T4clkb/V0Q9snwVaVHxSulHtrQ1q?=
 =?us-ascii?Q?wkxtw2DUW6WgEyynM3iuT+nwtnXAgh4LNyWH+TN9seb0TH5NfYneA3FlLR8z?=
 =?us-ascii?Q?R2M/zyIpMz8y61rW4gAySrEylKus3057yQUzj5X9lrn1jIK5WD2/mACujs6g?=
 =?us-ascii?Q?BrnC9DixPD8LkW37tJTiLcgca8fcgAI9V7X3HJ8J+Yu7p9k+RMUmJXq61Du7?=
 =?us-ascii?Q?sfGOMGFsD3nrqQ/yZ0Vv63ERf3j1WFmtqg0PX7riEVCiWjoot05i2ZDDNctB?=
 =?us-ascii?Q?YtYoJE6QiG3G4kTYD4nKJU1mcRGCkpYuQ4HSgl8e/V3N3JyTLGdI9+HNaWJE?=
 =?us-ascii?Q?QEp1yfSEjRphmd4ycQOoSVYcABBufQ0Uwm8M/8SLxIqWl0hXgM3Ohrz9d5nZ?=
 =?us-ascii?Q?+cTg4aK9lZPdJpGztmQVGym3T+P8GImzOCET7TR0CzYpkyjMaFGX2WCo/UN2?=
 =?us-ascii?Q?wwjlb15fNpd2FwB9Dx+1vwj4tWdvHn7pSaSwGuXT5L14yJ9EEj33sLINszqG?=
 =?us-ascii?Q?NdhGDtJ3Q2bkcJgsk+jhOi6CHfmIZPBx/m6+JCse?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b65034a-533e-429c-6d0a-08dda861820d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:58:10.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw+aQ16BEvkgLJuCO+meA0kPCMFVJTqOPrisouTN267k0zNxJN2pPUCJBgFwSCcG2f9r+sZvdSe7D0Xn9/0+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

On Tue, Jun 10, 2025 at 03:47:31PM -0400, Samuel Kayode wrote:
> Add regulator support for the pf1550 PMIC.
>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v5:
> - Address Mark's feedback:
>   - Add comments to clarify difference in interrupts
>   - Issue warn event for _LS(low side) interrupt
>   - Validate maximum ramp_delay
> v4:
> - Address Mark's feedback:
>   - Use C++ comments for SPDX license
>   - Add portions copyright to reflect my update
>   - Validate ramp_delay
>   - Report overcurrent and temperature events
> - Use platform_get_irq
> v3:
> - Drop duplicate include
> - Drop unnecessary includes
> - Accept lower case regulator names from devicetree
> - Use virqs mapped in core MFD driver
> v2:
> - Add driver for regulator
> ---
>  drivers/regulator/Kconfig            |   9 +
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/pf1550-regulator.c | 366 +++++++++++++++++++++++++++++++++++
>  3 files changed, 376 insertions(+)
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 6d8988387da4599633ca9bde2698b9711e34a245..de455887f9aeeada5546e44b8dc9d7ed041618a6 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1049,6 +1049,15 @@ config REGULATOR_PV88090
>  	  Say y here to support the voltage regulators and convertors
>  	  on PV88090
>
> +config REGULATOR_PF1550
> +	tristate "NXP PF1550 regulator"
> +	depends on MFD_PF1550
> +	help
> +	  Say y here to select this option to enable the regulators on
> +	  the PF1550 PMICs.
> +	  This driver controls the PF1550 regulators via I2C bus.
> +	  The regulators include three bucks and three ldos.
> +
>  config REGULATOR_PWM
>  	tristate "PWM voltage regulator"
>  	depends on PWM
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index c0bc7a0f4e67098c50ac3cf887ae95f46b2eac44..891174b511fc0653bac662c71659498122e8441f 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -125,6 +125,7 @@ obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
>  obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
>  obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
>  obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
> +obj-$(CONFIG_REGULATOR_PF1550) += pf1550-regulator.o
>  obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
>  obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
>  obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
> diff --git a/drivers/regulator/pf1550-regulator.c b/drivers/regulator/pf1550-regulator.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..54fdf28643d8376d87faa5d2c5a562593ba0c063
> --- /dev/null
> +++ b/drivers/regulator/pf1550-regulator.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// pf1550.c - regulator driver for the PF1550
> +//
> +// Copyright (C) 2016 Freescale Semiconductor, Inc.
> +// Robin Gong <yibin.gong@freescale.com>
> +//
> +// Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> +// Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +//
> +// This driver is based on pfuze100-regulator.c
> +//
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +
> +#define PF1550_REGULATOR_IRQ_NR		11
> +#define PF1550_MAX_REGULATOR		7
> +
> +struct pf1550_desc {
> +	struct regulator_desc desc;
> +	unsigned char stby_reg;
> +	unsigned char stby_mask;
> +};
> +
> +struct pf1550_regulator_info {
> +	struct device *dev;
> +	const struct pf1550_dev *pf1550;
> +	struct pf1550_desc regulator_descs[PF1550_MAX_REGULATOR];
> +	struct regulator_dev *rdevs[PF1550_MAX_REGULATOR];
> +};
> +
> +static const int pf1550_sw12_volts[] = {
> +	1100000, 1200000, 1350000, 1500000, 1800000, 2500000, 3000000, 3300000,
> +};
> +
> +static const int pf1550_ldo13_volts[] = {
> +	750000, 800000, 850000, 900000, 950000, 1000000, 1050000, 1100000,
> +	1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000,
> +	1800000, 1900000, 2000000, 2100000, 2200000, 2300000, 2400000, 2500000,
> +	2600000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
> +};
> +
> +static int pf1550_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> +{
> +	int id = rdev_get_id(rdev);
> +	unsigned int ramp_bits = 0;
> +	int ret;
> +
> +	if (id > PF1550_VREFDDR)
> +		return -EACCES;
> +
> +	if (ramp_delay < 0 || ramp_delay > 6250)
> +		return -EINVAL;
> +
> +	ramp_delay = 6250 / ramp_delay;
> +	ramp_bits = ramp_delay >> 1;
> +
> +	ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg + 4, 0x10,
> +				 ramp_bits << 4);
> +	if (ret < 0)
> +		dev_err(&rdev->dev, "ramp failed, err %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const struct regulator_ops pf1550_sw1_ops = {
> +	.list_voltage = regulator_list_voltage_table,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
> +	.set_ramp_delay = pf1550_set_ramp_delay,
> +};
> +
> +static const struct regulator_ops pf1550_sw2_ops = {
> +	.list_voltage = regulator_list_voltage_linear,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +	.set_voltage_time_sel = regulator_set_voltage_time_sel,
> +	.set_ramp_delay = pf1550_set_ramp_delay,
> +};
> +
> +static const struct regulator_ops pf1550_ldo1_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_table,
> +	.map_voltage = regulator_map_voltage_ascend,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_ops pf1550_ldo2_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_linear,
> +	.set_voltage_sel = regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel = regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_ops pf1550_fixed_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = regulator_is_enabled_regmap,
> +	.list_voltage = regulator_list_voltage_linear,
> +};
> +
> +#define PF_VREF(_chip, match, _name, voltage)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = 1,	\
> +		.ops = &pf1550_fixed_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.min_uV = (voltage),	\
> +		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +		.enable_mask = 0x1,	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +	.stby_mask = 0x2,	\
> +}
> +
> +#define PF_SW1(_chip, match, _name, mask, voltages)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ARRAY_SIZE(voltages),	\
> +		.ops = &pf1550_sw1_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.volt_table = voltages,	\
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
> +	.stby_mask = (mask),	\
> +}
> +
> +#define PF_SW3(_chip, match, _name, min, max, mask, step)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ((max) - (min)) / (step) + 1,	\
> +		.ops = &pf1550_sw2_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.min_uV = (min),	\
> +		.uV_step = (step),	\
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _STBY_VOLT,	\
> +	.stby_mask = (mask),	\
> +}
> +
> +#define PF_LDO1(_chip, match, _name, mask, voltages)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ARRAY_SIZE(voltages),	\
> +		.ops = &pf1550_ldo1_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.volt_table = voltages, \
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +		.enable_mask = 0x1,	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +	.stby_mask = 0x2,	\
> +}
> +
> +#define PF_LDO2(_chip, match, _name, mask, min, max, step)	{	\
> +	.desc = {	\
> +		.name = #_name,	\
> +		.of_match = of_match_ptr(match),	\
> +		.regulators_node = of_match_ptr("regulators"),	\
> +		.n_voltages = ((max) - (min)) / (step) + 1,	\
> +		.ops = &pf1550_ldo2_ops,	\
> +		.type = REGULATOR_VOLTAGE,	\
> +		.id = _chip ## _ ## _name,	\
> +		.owner = THIS_MODULE,	\
> +		.min_uV = (min),	\
> +		.uV_step = (step),	\
> +		.vsel_reg = _chip ## _PMIC_REG_ ## _name ## _VOLT, \
> +		.vsel_mask = (mask),	\
> +		.enable_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +		.enable_mask = 0x1,	\
> +	},	\
> +	.stby_reg = _chip ## _PMIC_REG_ ## _name ## _CTRL, \
> +	.stby_mask = 0x2,	\
> +}
> +
> +static struct pf1550_desc pf1550_regulators[] = {
> +	PF_SW3(PF1550, "sw1", SW1, 600000, 1387500, 0x3f, 12500),
> +	PF_SW3(PF1550, "sw2", SW2, 600000, 1387500, 0x3f, 12500),
> +	PF_SW3(PF1550, "sw3", SW3, 1800000, 3300000, 0xf, 100000),
> +	PF_VREF(PF1550, "vrefddr", VREFDDR, 1200000),
> +	PF_LDO1(PF1550, "ldo1", LDO1, 0x1f, pf1550_ldo13_volts),
> +	PF_LDO2(PF1550, "ldo2", LDO2, 0xf, 1800000, 3300000, 100000),
> +	PF_LDO1(PF1550, "ldo3", LDO3, 0x1f, pf1550_ldo13_volts),
> +};
> +
> +static irqreturn_t pf1550_regulator_irq_handler(int irq, void *data)
> +{
> +	struct pf1550_regulator_info *info = data;
> +	struct device *dev = info->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int i, irq_type = -1;
> +	unsigned int event;
> +
> +	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++)
> +		if (irq == platform_get_irq(pdev, i))
> +			irq_type = i;
> +
> +	switch (irq_type) {
> +	/* The _LS interrupts indicate over-current event. The _HS interrupts
> +	 * which are more accurate and can detect catastrophic faults, issue
> +	 * an error event. The current limit FAULT interrupt is similar to the
> +	 * _HS'
> +	 */
> +	case PF1550_PMIC_IRQ_SW1_LS:
> +	case PF1550_PMIC_IRQ_SW2_LS:
> +	case PF1550_PMIC_IRQ_SW3_LS:
> +		event = REGULATOR_EVENT_OVER_CURRENT_WARN;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			if (!strcmp(rdev_get_name(info->rdevs[i]), "SW3"))
> +				regulator_notifier_call_chain(info->rdevs[i],
> +							      event, NULL);
> +		break;
> +	case PF1550_PMIC_IRQ_SW1_HS:
> +	case PF1550_PMIC_IRQ_SW2_HS:
> +	case PF1550_PMIC_IRQ_SW3_HS:
> +		event = REGULATOR_EVENT_OVER_CURRENT;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			if (!strcmp(rdev_get_name(info->rdevs[i]), "SW3"))
> +				regulator_notifier_call_chain(info->rdevs[i],
> +							      event, NULL);
> +		break;
> +	case PF1550_PMIC_IRQ_LDO1_FAULT:
> +	case PF1550_PMIC_IRQ_LDO2_FAULT:
> +	case PF1550_PMIC_IRQ_LDO3_FAULT:
> +		event = REGULATOR_EVENT_OVER_CURRENT;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			if (!strcmp(rdev_get_name(info->rdevs[i]), "LDO3"))
> +				regulator_notifier_call_chain(info->rdevs[i],
> +							      event, NULL);
> +		break;
> +	case PF1550_PMIC_IRQ_TEMP_110:
> +	case PF1550_PMIC_IRQ_TEMP_125:
> +		event = REGULATOR_EVENT_OVER_TEMP;
> +		for (i = 0; i < PF1550_MAX_REGULATOR; i++)
> +			regulator_notifier_call_chain(info->rdevs[i],
> +						      event, NULL);
> +		break;
> +	default:
> +		dev_err(dev, "regulator interrupt: irq %d occurred\n",
> +			irq_type);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pf1550_regulator_probe(struct platform_device *pdev)
> +{
> +	const struct pf1550_dev *pf1550 = dev_get_drvdata(pdev->dev.parent);
> +	struct pf1550_regulator_info *info;
> +	int i, irq = -1, ret = 0;
> +	struct regulator_config config = { };
> +
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	config.regmap = dev_get_regmap(pf1550->dev, NULL);
> +	if (!config.regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get parent regmap\n");
> +
> +	config.dev = pf1550->dev;
> +	config.regmap = pf1550->regmap;
> +	info->dev = &pdev->dev;
> +	info->pf1550 = pf1550;
> +
> +	memcpy(info->regulator_descs, pf1550_regulators,
> +	       sizeof(info->regulator_descs));
> +
> +	for (i = 0; i < ARRAY_SIZE(pf1550_regulators); i++) {
> +		struct regulator_desc *desc;
> +		unsigned int val;
> +
> +		desc = &info->regulator_descs[i].desc;
> +
> +		if (desc->id == PF1550_SW2) {
> +			pf1550_read_otp(info->pf1550, 0x1f, &val);

I suggest don't export pf1550_read_otp() function, you can add a field at
top pf1550_dev like 'dvs_enb', here just check if (pf1550->dvs_enb).

Frank

> +			/* OTP_SW2_DVS_ENB == 1? */
> +			if ((val & 0x8)) {
> +				desc->volt_table = pf1550_sw12_volts;
> +				desc->n_voltages = ARRAY_SIZE(pf1550_sw12_volts);
> +				desc->ops = &pf1550_sw1_ops;
> +			}
> +		}
> +
> +		info->rdevs[i] = devm_regulator_register(&pdev->dev, desc,
> +							 &config);
> +		if (IS_ERR(info->rdevs[i]))
> +			return dev_err_probe(&pdev->dev,
> +					     PTR_ERR(info->rdevs[i]),
> +					     "failed to initialize regulator-%d\n",
> +					     i);
> +	}
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	for (i = 0; i < PF1550_REGULATOR_IRQ_NR; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						pf1550_regulator_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						"pf1550-regulator", info);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed: irq request (IRQ: %d)\n",
> +					     i);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id pf1550_regulator_id[] = {
> +	{ "pf1550-regulator", 0 },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_regulator_id);
> +
> +static struct platform_driver pf1550_regulator_driver = {
> +	.driver = {
> +		   .name = "pf1550-regulator",
> +		   },
> +	.probe = pf1550_regulator_probe,
> +	.id_table = pf1550_regulator_id,
> +};
> +module_platform_driver(pf1550_regulator_driver);
> +
> +MODULE_DESCRIPTION("NXP PF1550 regulator driver");
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.49.0
>

