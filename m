Return-Path: <linux-pm+bounces-29357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35414AE4851
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E279F1630A7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C7125EF82;
	Mon, 23 Jun 2025 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gabtvXYL"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66D24FC09;
	Mon, 23 Jun 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692021; cv=fail; b=SjunX7MF/oene7TtxWoNRSCBUUcIpsvrXqaAx4surRpV/kfA55msSOmQRGhDKc0lrHV3h/4c/1p75PHXraZcH9Tg7a7XsVYJbgAsRGzHdwWzvWGgw/HDo1Qt5vREX7Vj1/fnQxE+EOerQXotn5yn1NF8Ob8+UlNcZfKbDKOBSWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692021; c=relaxed/simple;
	bh=SJfMkVhfv9LW99h7eF3psn/i6fj8qxlP3FxqnXFmoT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CRNMCUpSghW4gixLwguvbyqIa4eswiQ8k3s6H1Sb3xvaHoHo53ksQVbFkHBtEZO6579E/w+m2muhalRPHFdtVYAgP0WVRUhboWCeF664Ocx1MfItB38qCZyY2Wxna5/fyHYTYB/JccuALaTp63hHeXVmYI3MKxoqRu1WB8iETrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gabtvXYL reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl2rB+vugogKkuLVebUGFRj4SFFsx6zTgCkRr5ht/3lJfjcIQfbKuOTrKdX0yB3j3R5C6NZiwpoSVyGwPsLYenoT6iDjzCqcfeTBzWxHAjccm4hGaIHC8XwEQZjnfbd4Ocfd6/0KD+9EkSPMXeFgZwpCU7TUaZ0RSfGzRAD5l4b7mCQ+qgfVYVHLG4zhTmVlpnBYzm+Eqz6HVjGnTgWnSLXrC7u8Vdzagbf17o0Gly1rH7t4I5MuV/GQtp21uFRUpETyOgCU+cdV2CEQXLGikWQnCwmknJiikEnQ7FM0vWmcF1fZ1EfYej4pPBeQA9Z/51o4xtOcu4DAp01LGtp7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT3DJhCOpt/pld+msgTRxpi7smDoJ3QEPUK1xUq/AsQ=;
 b=TJBMh82KUS+t+OCkOT/wYuoPleKNUCJL/EudST+JfEviKgsdN6kUOWSys6IEkjprlmYbd+ZfB432q+kFQToH0tLQzVtjEiB3rGBGDGA0jXjxr0is3fjcWNW854tDkl4r1ZnBXW9oYD0x3dwjDTtLamqx+wA7/2u/3fZeKKY4DrhkA6VjDsEdcE12dBXhgxCk3nLBmZx46XN1Wf7DDI91wEw9jvZuHlWpkCDUzOocQRaqGq0H5jGuncvMFqZvDimagkf+J1Vw7Oa22t9/WTZYtTQ6HXqcFak6hgWFQbwzKQJpGbkOW2vdRgJIVZEqEJk7nctrO7asGUAtnEnLRmGotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT3DJhCOpt/pld+msgTRxpi7smDoJ3QEPUK1xUq/AsQ=;
 b=gabtvXYLSLWc6Yf97JL4s5MBIui5aRegCr2FBE42QXP5AIOifL2qSMI3znXHMqB6bKsrWv0gaHwHjuuCk3lNLfkvwM6qFZG/J24j/6/RK4qy8DrEG41QX4JsiPQcTo6I0kmoGI5Eo8BxmzXwDUoAA3hu2d0JVd44muezPnyuZeeueq8mIkRkLynAYkEQiPjKoqCyqNu+5pScS/cZPD3wzlvwFWpgqZPt89R+mFY0TESelANKJECNnIFybiRbab4yryRBFaMm3IQgk7el4O5C05UU9hf9iQ8MD+a/KF+lzVp8UGc+SAVH0UH7+ZbIROn4+zUKHDeSHzy4H46WaU4/6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7656.eurprd04.prod.outlook.com (2603:10a6:20b:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 15:20:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 15:20:15 +0000
Date: Mon, 23 Jun 2025 11:20:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 22/24] thermal/drivers/imx: convert to use
 devm_request*_irq_probe()
Message-ID: <aFlwqaNvHtPk7wbR@lizhi-Precision-Tower-5810>
References: <20250623124257.475083-1-panchuang@vivo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623124257.475083-1-panchuang@vivo.com>
X-ClientProxiedBy: AM0PR10CA0091.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::44) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: a62d2d82-2f9c-4a64-561d-08ddb269743c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?xHwmzbV6tOYb6P2g0bHVhF7kqFvBHYgwyLKj/4hx69e2OKqPqUib0slCgK?=
 =?iso-8859-1?Q?Wh4R5mYO95kdI22wrsaExBj4y9iITAklfuTSpm8PbfsAOtzR64wTmRUdi0?=
 =?iso-8859-1?Q?G/kXsFzHY0PEu9gX1vFoPneIXQoORxc4fOvBy9dGNKvQfgoKvC2N3NwDcd?=
 =?iso-8859-1?Q?MXDqCKqRGRX3ZednlIgrk82Pxmke51TSdpGIfOII7FeX9omFeOzi5T5TiG?=
 =?iso-8859-1?Q?l4zEzYYqZIwFdvjF8ql+Be15e1sWivf14spyINtQy60mYN0Ji4YxoiCV3W?=
 =?iso-8859-1?Q?CzDRbUDFjbjnfOgJxLsVwKHSU+vT0zHfDLs5FmEuRzMxc/ZlG2cFA52BW0?=
 =?iso-8859-1?Q?x/kkbN0av/sgmEvqifqZnmKHspyhmj+CifFHk3u4l6JbE3LHGztJBjaXad?=
 =?iso-8859-1?Q?zbUmTDQDo/mlg328jI8l0cC7ri+b71FPeJZGF/5QJG8SRPpb05NxfPK05h?=
 =?iso-8859-1?Q?fgAoajmdOTVf/1FpSZFL2BAssOtpus90EvxeSZeRm4h+aGmjUSMgZDGwBn?=
 =?iso-8859-1?Q?TptG4EjSlGdtDRoZyYnoN8t6mx6pFrAkPfspF0BQXHGg156/usJcQKobKO?=
 =?iso-8859-1?Q?tYur8kI3XNiexOClNciM3GwSAsGyAbbrHaeBwpOHrQP/qRTPicU3d6J5zn?=
 =?iso-8859-1?Q?8JYd7LSX65Hv+Bf0u3UHDiUBQHSFzcDXGWbGQsOeFiKhFbEq2Y9cbUnup7?=
 =?iso-8859-1?Q?edOaMpHV9jFgCwi+ly5/kghLVu7bYzQpoJ6DOFBu3XwE+G6q2Uc9Bd1aAs?=
 =?iso-8859-1?Q?kRhih7DtCoes//rAWpcki4yI6poMnLUQSNcKMyVgBPMxfm057yrUlTVWnv?=
 =?iso-8859-1?Q?DM+3lEWsj+OP2GoY04hBuMZG4ZD8bWegoMD8WKpT7ns0QDqOT/D0xUtngl?=
 =?iso-8859-1?Q?Wt3P7J7JCzUOsus78P+L6OuApwAOLq+X1mdheEKtKuTkqvkOzecjTQfm6c?=
 =?iso-8859-1?Q?FjtdgQdExnP30zvDGr93HBhfuVxBu3dcL+LoyqGOI0QKbJFI3Eq3vVuCEQ?=
 =?iso-8859-1?Q?0QQnzEdSU3Hb07lXYue2hD9RMg5vT4fQ6h9ontIhiiEpvf3KLhoU+2j2+9?=
 =?iso-8859-1?Q?1id7RgLBiq3wjdTOCh+1Tsjm2zXzxv65tBQ/3dUclq746Gt2Zzo/lT6Zvp?=
 =?iso-8859-1?Q?zUzJFN0MJpyw2W6iCKlg6i3J4e8eRCSKAC+M77x5eOYrUpQj7y83BHC5nM?=
 =?iso-8859-1?Q?T/ahcZW+fEilAK1P2nBxV5oQ27N8v7Srg6HmaFHH9SZZBrkPA9sZxUqtOC?=
 =?iso-8859-1?Q?oUZMAV1J+5fXE2ioUKmSUQp7Wu8BWxoXWpQAq6vIR0HcS/5J0ZL58AHWO4?=
 =?iso-8859-1?Q?pKlPt3wL+fG9zBB2D0/AjeYUJYoEJWk9oqLIUFJzux76NAYj0aKpgyqfKU?=
 =?iso-8859-1?Q?iuEae5x/3FjhP087fzI6I9nl0f3jVC0FCtBAhg9753X6ZQKmufX6NY8rUD?=
 =?iso-8859-1?Q?A/8lPJMsBZpFPzZq7Xqqpb17ac9aEJYEquF/19ozLixwSnpeYZun2I0cd6?=
 =?iso-8859-1?Q?Fjw4brjxDC/0AbFE1yVIYvDVuPwOvmP+dbEVLompTUyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?zIfOh6l5nKCD2HJr/VCluAT1xTc36eBmGmodS2krAZ6ss8vhKQh/24QA4q?=
 =?iso-8859-1?Q?zlPAAERSuZzRkCby9pRDQnre1ARUAsylpevHGM4xcg+A7hwzLR900b2mlL?=
 =?iso-8859-1?Q?LIsIFDPsms6EENji1/FuXiyOaPFOiQ2xNR/FKSL0zzpgvWEjeX0CKPd1m8?=
 =?iso-8859-1?Q?wLfYf8IDdru4e6SKWpp/DNKvSYkolQo/zMWMUVOHP7XT45qHVcsY14i/FZ?=
 =?iso-8859-1?Q?vpqF9Ayv7gFF5UjicmEPWAmZ3M7uuTK3Ebs4L+BJMh2YukQ4gu7b7Kk7HZ?=
 =?iso-8859-1?Q?uAQXPphsfx8xG2YY6DCXrzVhRh0bHBEhF4ttHtZ3v6fYndE7/saRQBJA22?=
 =?iso-8859-1?Q?53JApbr/fB4MIpkydCxo1RO2RnX7hZQrV/5uggZtDL9YHhQTxWhjSLxZ2g?=
 =?iso-8859-1?Q?58AATMwAjRiiGS31pNT5GB8fdf+w8GxtPhSiSllLzZIZuZivo2LxL7FSMr?=
 =?iso-8859-1?Q?J/rvysHroVRBNnGLOctpN0hfz6rDaH9hLA18/9cS8DliFuko10JjxVMwM7?=
 =?iso-8859-1?Q?AzXJa1iBszjyOqwWMHts9Q9zQSo9xH036Orsf10rH5SheEHvJwAflgViXg?=
 =?iso-8859-1?Q?q2e94Y9kzzBkwwXytADj4YvAjiE+r1lLOMDS6c96I+baKG85LJnR9PZQC1?=
 =?iso-8859-1?Q?Qm0WmqjFsAom+mW0g+ynaMS/41WZFPAZgrJlDfIVnHo2YlepnCZ0L7bO2W?=
 =?iso-8859-1?Q?WNPwl/OVoRKCjDs2sYMA9uDtn9mtv00s8YZ9L/6CjN/Kdce4qxYJSpnD5g?=
 =?iso-8859-1?Q?iDsi1ip0twuEckI8OpjGAtMaCUWKLmNfsfGVooCe+arEerHI2ZBsYxhwLN?=
 =?iso-8859-1?Q?7NbFwM6jvxLfKGlhoIwII/6Te0EC5wV0Qa3Kl9L4JMstA8Q3ojovaUq7am?=
 =?iso-8859-1?Q?ZEdKivXF0q3Cu9ArfHKX88yLF9wHM32zignp4QKJesPl5TU8LdptNd0O+0?=
 =?iso-8859-1?Q?e357Tt4Rn+t9Vf7+253jrQzG8obNukGNSO2M7iyFMxqv5GEk8WAyWWq+t8?=
 =?iso-8859-1?Q?M79Otg0YYMb2WLGv0sQSElmustOPOQyvP/Yirr8XIIyImmbSm2JA3Ognja?=
 =?iso-8859-1?Q?ipV6VS86EOHzBqPH4vztFbjw8JRQ4nz2ImdIiUZWQS1+aEITm/VnXoI8FE?=
 =?iso-8859-1?Q?HmKY2eR5OghZdi2HHlwrZ1Pkhm87p1GfDltvvK6fFdFyI+UAnuERBI2hWb?=
 =?iso-8859-1?Q?tvy8MEK4vxObdwbO1a96ptYsy5vm88GvGXRJ7stHi8nATwuyUSDJnYaBK0?=
 =?iso-8859-1?Q?h6y6WTYzHSFW2XS096o6n+IwL4wPGMfA7+mf1h/5oq4yjCkp7ZcDKcv84Y?=
 =?iso-8859-1?Q?rlnUms+DYDpdtg2OLrrlmEd/Nyj/zfZVrRCRe+PFgr6kj9M6fuMIbEmZrK?=
 =?iso-8859-1?Q?B8v972EKndRXdlPf7C9r52NHahPJSqPeDQCpW7xOW9XpwpJCqOoSfKQ5oo?=
 =?iso-8859-1?Q?+81ZR/Yj0mUnLeB+NccDwQIBUZCQPdtWTX/AC57kmgPPf6mF1AHIUaL7ZZ?=
 =?iso-8859-1?Q?NYtq6x+7AhbgUeg9WBvBUo4dXeszo7EvuwSno0m604qGEl+I/A4G6FYvyB?=
 =?iso-8859-1?Q?kOX83oN04z2d5FqeLtxft1Y+annhj1w2MeY1AP/m+hk5e1bbD1OrudA8Ft?=
 =?iso-8859-1?Q?sB6JO+zpQAZXc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62d2d82-2f9c-4a64-561d-08ddb269743c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:20:15.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ii8YlBi6cNowkaNjmA293rfNh4ovKLllKJj5rA11c3hxGatjl4t2f5dQa68Y7XQ96C9pBPI6lHjwOhbYWLcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7656

On Mon, Jun 23, 2025 at 08:42:57PM +0800, Pan Chuang wrote:
> From: Yangtao Li <frank.li@vivo.com>
>
> The new devm_request_*irq_probe API prints an error message by default
> when the request fails, and consumers can provide custom error messages.
>
> Converting drivers to use this API has the following benefits:
>
>   1.More than 2,000 lines of code can be saved by removing redundant error
>   messages in drivers.

This one should be total save, not for this patch. Each patch's commit
message should be independent.

You just need said, use new API to simple code because commit xxx add new
helper function devm_request_threaded_irq_probe().

Frank
>
>   2.Upper-layer functions can directly return error codes without missing
>   debugging information.
>
>   3.Having proper and consistent information about why the device cannot
>   be used is useful.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/thermal/imx_thermal.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index bab52e6b3b15..151976d0820e 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -729,13 +729,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto thermal_zone_unregister;
>
> -	ret = devm_request_threaded_irq(dev, data->irq,
> -			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
> -			0, "imx_thermal", data);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to request alarm irq: %d\n", ret);
> +	ret = devm_request_threaded_irq_probe(dev, data->irq,
> +					      imx_thermal_alarm_irq,
> +					      imx_thermal_alarm_irq_thread,
> +					      0, "imx_thermal", data, "alarm");
> +	if (ret < 0)
>  		goto thermal_zone_unregister;
> -	}
>
>  	pm_runtime_put(data->dev);
>
> --
> 2.39.0
>

