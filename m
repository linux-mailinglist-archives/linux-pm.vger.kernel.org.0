Return-Path: <linux-pm+bounces-34519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED8BB5411A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 05:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CEB562C5A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 03:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104A19644B;
	Fri, 12 Sep 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LQE4gsmh"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244A800;
	Fri, 12 Sep 2025 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757648515; cv=fail; b=alQC0iM2sHXopI0AGxKNkQgZ4+dA7FJ/5FJsB1RBnR5UZOGap4pEjc4IeQ+5sAEbGaVH1ZD2FYv5NGhkuFds2Oh6jqwTfoX/pPfgptrqNadRkPVVOUs10Xvptf9B822ulYa9TwaJbKVRonPzFmPC9HOfv97OlqostnALW+e4em0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757648515; c=relaxed/simple;
	bh=4qUsy6RnXe6vvIaWj7vrKidO4//0ogHWm08/PPlfl8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/Cd6iQF3/W1OGdcgFZm60k4MzXGjbWk2N5DTF9qXom2J5/n0AKJA7KWakwLlWwNnV4QG6NYHYIMR0nv+W4zHGP2DmL8+hs33Grs2+1EBdStc0/Rz6gGjeBST78S4cPYn9X7J8uqA8FVicPrflQfcc3i92iESiUyJUEQvVsg9HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LQE4gsmh; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYBk/CoEAcfm+g1arhWboJEGAqobeptwMCiYL1LxIFiLH7PsZ8hmT6GelTzRXE7QaHe1734jYuGijMoBgjJZiAKQuAHswlyM28Xsxd2NwEgaYc5KWFDXXvfjdI3VVAE4ixwHDNKya4ivl+jsy8rVmIk4iyhJ3iw1znwxrdLuyInil/FOPGkRckekJxntpjy0jkh52iiXEvQQeuvYinV13LRBkqqhbbbnzRr04FunBfTixhCYdzr12Fv4pvz7kVeZH6Q2EhvXIkmP2eUeOpn4UczRgoQsofSOjAj+LysSNCh3Xjd4p9luK4Llrt5RDDLWV90shTMsBdbMyZ7KSMTynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qUsy6RnXe6vvIaWj7vrKidO4//0ogHWm08/PPlfl8M=;
 b=QV0PhRCIjE3IVaDQUI6ULuesF3uos6nWxmAtUB8Wo2irGN3ube9hZ7NumXEQdQkHN54VG0UYv++fIkIU+f/amoRnhBh+lag9g2peUWIZrU5iPQjrrEBgVFmVhgzROu7rq/ULRaJ6HMrggshTGHOg/yU236fK7xkTasTT6GNdJ+6xWHzP7JZl8vCNs4LNtOde6w2cSVYuOxvhoXcpjLMWKaBGOAFGNLLvyQrdrEU1xS3EzMlvRVHEDWfLgnVnNU+GbjZLGHyiOnm9WrIY8GM0eYJFycGjBKITCqJjYHB7ARCeoN1IQg9i7SY/ngVLwVjy9tP22qfC9BDgVukj4aE0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qUsy6RnXe6vvIaWj7vrKidO4//0ogHWm08/PPlfl8M=;
 b=LQE4gsmhubbFKdP/m5r0DSq2+wG6DzDEPUqkQEV3+phcWZKgye0qxPpWqjt2vjzJcgqefB/+Wp7mFwNWjnzc4u2n5nKSXof5yEZZ9o0JsS1ZcskNBLBv9f0RQ9PcMK+6ED1W8LHrevLl6QGfrF1r2hEwJG+kZ8RQKR6HfJFrpoDkrBLXUTy7+pxcn7znRn2hWIyNwauYQRHJzcXTTPCE23iDmArZ+8a1Y7tzMaiSTonfPJQs7B8jSaGVjBSt1r6NJnTBuR4AxR1MFvVJcoVL8Zpi72JFnJ6beUBsOcI+66hsjhMOrngRUwxRnTMagSB/SRqr6vT0YdrIY2+r0jXrwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 03:41:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 03:41:51 +0000
Date: Fri, 12 Sep 2025 12:53:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	imx@lists.linux.dev, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] pmdomain: core: Introduce
 device_set/get_out_band_wakeup and use it in usb
Message-ID: <20250912045316.GK5808@nxa18884-linux.ap.freescale.net>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
 <CAPDyKFqBJQ92HH1tSq1rfbXV1OwbyvgChyHfv7ykJqf2A6qYpw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqBJQ92HH1tSq1rfbXV1OwbyvgChyHfv7ykJqf2A6qYpw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b1f297-be13-4ddb-c013-08ddf1ae4f17
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|19092799006|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWxpaF/JAxoMJ+rvIxG5CIKm5SA8xK8uXzUxNFKQBVDyKirnSGlwPq1fNSj0?=
 =?us-ascii?Q?GtA3Bge27SBVb9L2xiNv6IUTCwXoiUURgjxHQt44LTewPxS6sXg+rv1vdcTP?=
 =?us-ascii?Q?AsXhcJmWYSHiBnv4GQIHxiPw3da5lufrjiVrGA2rWFkLmlG+uvpRpKmiUPqr?=
 =?us-ascii?Q?2z0a4YgT/XZSINC7knpIGRmmT2auqgrFMsqXiqmK5NCbmTDtdQJmxmcd5T+0?=
 =?us-ascii?Q?g6vnL+G6xW8TKarZzsBTHSO6aQ758FH+n08gOvnD4R2BQ2iOYDho8cQlrbC8?=
 =?us-ascii?Q?NJgo3dkWTkUI61tVetSU1Bf3yripftIS+ORc+C7p8Sy7hI7C7nn9Jyu4JlB6?=
 =?us-ascii?Q?O+ztIClxsF8wMqcE6Fh/hxoV4KiDWpdn7ZdoNoa9UjLxLgTQMHrVIYtR/6QR?=
 =?us-ascii?Q?iogGscct+PtWrDiHdP0djh4ihgv+BEHheTzqSUaXnrsXYLshSdDCnK9DENYo?=
 =?us-ascii?Q?AIIHoVAGPFRGHs1vETGgOwbG/a9O2P4HiKkNbjHAd/FUNpM7QY5JWvdhtpS9?=
 =?us-ascii?Q?rfDGZktph2FaF9GE37VWO22PvAXvTgbXHe0oczaaH1CmrNfc+mCiEx6pc3oU?=
 =?us-ascii?Q?Dy5zIY8k8mo9ur2KUarZgaBrQvVp03b6jELzkWOTU4r4iTQM3tr1XRiRl1Jc?=
 =?us-ascii?Q?c70l8mkUFZrDiJXYNXjHZQPZmcDm1+AnjuUKFbpGUpWarhFfmi1B5SjO8Inm?=
 =?us-ascii?Q?RDy8X5oJPzA4ezihtoPtC0V/8cmcOrMemgzUDaISYCsdHAAolziposXXv0+P?=
 =?us-ascii?Q?i+ZoDFRHIi8V2hpGdrk3RKzIp6QpH3dLxkBTfyU3LGWpj2G5kD2sFsiA53ww?=
 =?us-ascii?Q?1tOjkZtk0f5kv0E6xvZmpF/mwsr19k3MTesRtaZgkZmtYjEGCJSRwulK5CnJ?=
 =?us-ascii?Q?UbDOyOtKlRzti6fKhUBTriv71a1HbWfV1KzRgm3907C1tI1c2kB8rEGzVcYT?=
 =?us-ascii?Q?/oPkopn8hNQX5/H2IH+BZJlvV28qCIthETyIyOv0Nh73SHba67FYk9IRs1Z3?=
 =?us-ascii?Q?/H1eHn87cbtfL1P8AHxaMZYs0SD2z0errvNZAmex+Uaxxfy7tt7s9brU66OK?=
 =?us-ascii?Q?OThCeDl6EDhUGJHDMEfYsL67gQLe97NhSr7tw7fmp2vXJZii6duuE6Wv8Bmd?=
 =?us-ascii?Q?6CuOU+Bz1nHFx/GWYE7SGHr1lPbqATYr35YgptWYrfH4kAn/++s2o+obPPoo?=
 =?us-ascii?Q?o0HQOX7sq5BMobBHeLWShOdU3GM/SkuhQZvmmQ7wvjrO6b+YuzXRMAIMmIK6?=
 =?us-ascii?Q?nZmMWrVxHYkneNaLErkPTRBY5i5UxsMJ9MOoE0Rr0rd8mhLujhcJIjmWhNyF?=
 =?us-ascii?Q?VrPboisvVG/YymGdA7rhtxiQlc2R/2s7fXBKWd1ShD9pZmN68z0HgFNS3qIG?=
 =?us-ascii?Q?W8/s0uKukQ/LrDziOzchJdrHyzJu0lxDWNOURNiXj3/JFXno49f6p/2jweRC?=
 =?us-ascii?Q?04BUBMloi24CwnPuaK15EajYCE76xGd0wiz4LnXyiJCZ3Jwp/mZ4XA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBZ7JKN+bmWfaTJgWbJ4WTVw+yrwJ/3O6KlkurO3ficZVIE9gEnh7b7/EIvg?=
 =?us-ascii?Q?UuLoqS2tdZv34qpY/Y9m2K/dBbFfOnVNd7PdFHAxJQQ+oElJqOZ+89SomKa0?=
 =?us-ascii?Q?+Rbq8o69lvfA5TGeL4IilHaaieOh/ta7/+JVjHE1wzrOzgC1+3jhmizK73Pw?=
 =?us-ascii?Q?ArTEEsk7pnq7E2EqPyiUrW7s+fS0rq4GlJ0hTEXciZD6UnuAN4r1d/WpCzyU?=
 =?us-ascii?Q?kAJEVRVzCMHIQZREb6gs+xilxgTYLgvhcJihwr5rSDWNB1cEdiPPLHSLH9bQ?=
 =?us-ascii?Q?rOjI/QmkKuidOXEikuVafpSCSogWqkQqpx5l3Fm+vx9oj4PUGZ04H7+COYjF?=
 =?us-ascii?Q?bdLBP1v759NeiNpxXPJRUBULLrkH/TtV8ZsmhajgdIsQqbYf1PYP3dNGyNvV?=
 =?us-ascii?Q?pjztxMVU0tcoXNZTIST9JMGpQzlJWdiqH+2XB16651vXts3V06VPmUMTlwg6?=
 =?us-ascii?Q?xqsO6eEjAx/yJpRcZZ9dTv+S4HoEGBN+bSD+FyF1L9yKavQ70p8B8mXOOUuV?=
 =?us-ascii?Q?0KPShm5DF8l9is5stsx2L0CKZ/8q3+NZQ0bzve6+O+jVVWaT+hMGN883Xodg?=
 =?us-ascii?Q?x5E1g/yBT9EaSkTvKHIa9pWXbE2Ctw1OC0ygjiH9mrdXU7k6+mTK62R48SHz?=
 =?us-ascii?Q?kOdjDQ8w6vDYdpb2Z8XHodCzQyLog8k2/47TCQliHBaiSn10I8moFBC3yFp2?=
 =?us-ascii?Q?1yFXaJkxDM0VeRZvayJMfpbP8UMztJ/dd3Xk8F+VjBtkzxXVngLEXhCyHyr4?=
 =?us-ascii?Q?CE1u+8Gxs+k4gnl5G1LWnW6PBmH72m/dtVuW9A3nzaIJoty5TEW12fR4cZMq?=
 =?us-ascii?Q?ZEYRjD3ftqRQUjKr/m5EVwrfukOLda1LaUS9hJckPYhgGgRPrwJMn40F+yaj?=
 =?us-ascii?Q?eYVhQjTqcxjEPAUXAcnQmaFyQZ5HuSMiKSyH1qjdtOWhmKyE2SlA4mw1qRwg?=
 =?us-ascii?Q?elilF5Djwh7+t0H1+67w8TN0mTN4YZn1ECRIf3oee6wqUQaPlQkXsw5ZfFPy?=
 =?us-ascii?Q?jXhId5GMB1wdPcQ2n6DVSOAXTGr/wLORwrtXREAFOSU/ppbiJ187IPeNA9vM?=
 =?us-ascii?Q?yUFwy3FYGvzrTTt3GSx4LrrpeLPwD9aBQ2wy32e5DDiARCfaHMfvVgDqfdMd?=
 =?us-ascii?Q?VkeaD/rCFSuNYRM4nleRUO3otcMbFfhserBms3FxkHJA90n0DmbLvPJjQ5fd?=
 =?us-ascii?Q?IeK0Le8D71+ZaxC6ItJSNekIAigFUSkGTF7OMDENPc8HyUbsQfLFphofeisL?=
 =?us-ascii?Q?AOSLbNRcCWCI5Gkj8ruNsvBUHN/cHgRtUviXWYTY4hS08mx8dI5wrlLLMI7y?=
 =?us-ascii?Q?ER+i8lkX+x51lTYqNx9byc9CJknequkM+gl6WJ7F6QAXUwUHaapZg7wiR7aP?=
 =?us-ascii?Q?lzNFeBxwBz+9YStqpffWWoBe2rUz2lsifci81Gpo4AdpTha5zZwIbvTtSP1i?=
 =?us-ascii?Q?REliIaGJsm7qsVOV6QLrzkBDUpNqB95n0V+yU2tuePL6yd+QhbrOmPAk6deV?=
 =?us-ascii?Q?ZZh8812ibnTHZPbTuiCcROikEvhGA/QwrrmfMJl755/nsuZIeBBcVVPNWxvE?=
 =?us-ascii?Q?8WPfYXmOge0L44i/47VKDKI1ax0B5D/CcM3H8yiP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b1f297-be13-4ddb-c013-08ddf1ae4f17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:41:51.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFzzJIY3O4bkX+rGmB5MYhsutwCZHM4QrWihVxe0Xq8MHLDVBxGXbvOBecmdqoJkF5p75DG7UuQSRlp7Mt0VWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526

Hi Ulf
On Thu, Sep 11, 2025 at 04:45:31PM +0200, Ulf Hansson wrote:
[...]
>
>Overall I think the series looks nice, but I will make some more
>thinking of this in the next few days and come back with some proper
>comments, at latest in the middle of next week.

Thanks a lot for the review! I'll stay tuned for your comments next week.

Thanks,
Peng

