Return-Path: <linux-pm+bounces-29945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E4AF06FE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 01:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB17D447ADB
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 23:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275826FD95;
	Tue,  1 Jul 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Sy+qhpH7"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010017.outbound.protection.outlook.com [52.101.228.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F902226D14;
	Tue,  1 Jul 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751413210; cv=fail; b=lueVUNXnBSSblxgP4tTWcU4NdVeBaC/XO9BriVHepepCKSEAQLJq+4QQ8OYG2gC5bOaanmnUGM/5tvTCWIpUU+tZD/5pemoLzNjmil+BHYTd281ECFrtEmk+8GMoX3ML+8xz7ufvjhrriGo/O2Pgy285BHnfpj5MC/YgrXeo0Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751413210; c=relaxed/simple;
	bh=OrCGahakmnZaESS+zlx8PcV3IhnB8Aty9pbVLhp2cEA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lStNIwwXzrICm5vf3Zo62OwkGGDvUcfZc/7dJv32iEr0TWM86QQGYCEtXK8biYUqyT+1RYrfl3OLnytzvXckdqhS44oyu9Vz3Peg4swwFdM5ZEwEVu4ZdMIqCcMVGElZHifQeCXiQ3NZdD6+WKTihn7inokObWSRnhuiEXGRXhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Sy+qhpH7; arc=fail smtp.client-ip=52.101.228.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwQFA3xUR7U6yPCuSQ/HZ8E7qCVsOH7+xhTEuBiCInXioRq40n1q6HtYONOVXH3VueE4Vaw0PCnYuGbcL/42n8ga4iLPZOq9X92H+j/h8UxQlUNANghDhRhS6WRWpvQxaCnLjtzaTkTgMp4DGIF30kZWCSiWsz6xo1bYlE2fdMsjQhEHzOczo291gstFuTKmY5FZ87EIrBMxHMTHuZdEQH0Sgdo6ijwnLv4Kc6GZY4utc1t6EzX0RxmMjsFITEw1QGdFth2YCk6SxcJ+DiSJuHQqRvbn7PPgrJ5OS5g4jHZnDI8SIm0SUtjeMDVD/X8kB1UlsHiIP0NGilZoKA8qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmTomgCuJg8VJyRR4DXCQUk+/Xc/3jYaDpYPN4KebzQ=;
 b=NvCZ95/+PAx2N9X+8OoAVmyzi8U5aT0vkCHPwv6hSx5ByXtx//bk5vwLMECq4EsOIqN9CrtpBRCD1EP0BsQ6VqekvEe/auxzeHvHbsH2j+P3FUfBRCmCP3xWFkLD9Y4dMskAP0SqPDDnWjhZiFxnQIjdUY//XdfAYp8IJ2S7gSQ9griH1AA6DQ5o/lwaDQHS+6FTF0guNF4SifuaY4xH2A61jsQ9A8waQxyDZouY2mW6S8V5a0HC2WnjddnLLBvDrb7LYvGMw7qvRmH3xYzgQ9D5KkAdTzXrTTFz76Uy2JhqBiQstFGy/AF0dZH+3ATFCLnygYiQVNyjS6CE9IkelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmTomgCuJg8VJyRR4DXCQUk+/Xc/3jYaDpYPN4KebzQ=;
 b=Sy+qhpH7igWPzYcrdmPiaFjEibFOf7Ntq6vtg/hfPNzg80pJCfiUOn+Hetq4zFQIXJKUo1NFxU5+WZ3DT67W+L0FsPFkC3a79MqByUCOsN19B0aWsXT+rp1xs2xajrStYsMTiBuHsIuqUt9U0IDdLyHOhZ5RoEvEBUx7bfsEKgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYRPR01MB16153.jpnprd01.prod.outlook.com
 (2603:1096:405:2e3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 23:40:05 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 23:40:05 +0000
Message-ID: <87cyajzdij.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdomain: renesas: sort Renesas Kconfig configs
In-Reply-To: <CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com>
References: <878qlagmrq.wl-kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVqqCX1=2j740xnU6C=C8x=K-ayQ-uSbmafPVaa-nGtMA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 1 Jul 2025 23:40:04 +0000
X-ClientProxiedBy: TYCP301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::18) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYRPR01MB16153:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e8b908-6de3-4bdb-bfe5-08ddb8f89af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tjRF/T+YHm1cSUoYDf84gGEpNmf3X5RLTRfIAUu2vNGpbe5z5jHCrxwjB7jq?=
 =?us-ascii?Q?l0xLHD2R5E3OTVzLmRuEpEFTViyzw6CEeB9pHcP4HrMh5kprlKQnA3M+4RS2?=
 =?us-ascii?Q?KFqv+LhsMBGSJhNdTkjII4cGPB3fSXC3ymx3+NDCf9Hl83KEKL0lK/gQCYW6?=
 =?us-ascii?Q?zSj02WRguRLcGg4JwJc8C3pV5EQWFEzFuvCJkss8psUSoDZKR0b4rP5vapRN?=
 =?us-ascii?Q?Q0nfuEadKOce2egFKUuV9ob2FoRr08vx33ZUStSYF9m5rp5Q/xZ5udnHhM94?=
 =?us-ascii?Q?u0E6e9qPJn/XBlR2edK0LLYWRVmQ4kiibOd59Gb+ONmzZtNyeJhx1nsAoiuN?=
 =?us-ascii?Q?XFADmYTkRyTKnBXgz7kpHU6NYDY4iz3nKfx/yTy3uUTJThErQCU46i6t+fe6?=
 =?us-ascii?Q?bMtr69wR8mb1lM2zwqBazITl+D83LiZA6HDPoWwz4xkccSAo7sjy+zbG0Uf9?=
 =?us-ascii?Q?5URsdzqp6oZujwWASnQA2QNYHRnkwdEnMS6OMKM38vyK8pxxnB9R6JeLxVm8?=
 =?us-ascii?Q?yWdzWZ1/y75Kr5h7wUMGvkQltD0Jj8vedn1f5O+ovka3cRZzW2EyAXWsTjnd?=
 =?us-ascii?Q?CGG4+dYoY5u3A8sfEq1RcyjBbKkuC8zgHUphor7fPWu2fLrH4ELht6r9IAVs?=
 =?us-ascii?Q?bbxLF8lYk2axYSa8AsNUtqnAhK22A+x7nACEszuaQ4mdkmdOUi9quYb1QQc1?=
 =?us-ascii?Q?WpU8v0tpNrY8sSpc8T/s6+Nr/2Y3Na5zoShnMJ795sSnTQt7qXueQk8x6Hwg?=
 =?us-ascii?Q?60U9ZPOWI6IilmK91SbkpaD7sKFC64fxsrij8kgwQnvGxgD8p7c804lkq0CQ?=
 =?us-ascii?Q?Hv7Hz/O/EG5Bl7JY+Xb11D6EQMkKSClmMj2syigVwB3+hZL9/gAU9bXeCbwm?=
 =?us-ascii?Q?sWYgKXJfimrNY7O5ftiFCgK8J6sUPHV8Le9EZZ+LL8LeWnMBd9brNVvHVDTO?=
 =?us-ascii?Q?lYkhrBOpCL61hOVEsT7WBY/VqUt2TSpHsWsALHWy1nxfpGastEH8Hrm9kvqn?=
 =?us-ascii?Q?7SgawwLVuZFVcDs2svoNf9uTmBh++kDxeHv/cFFj0N52ShSKQY4uHyVcD2GM?=
 =?us-ascii?Q?8bS02VKhww+GMqUQ7LhZZeOCZZfQm03vg/JO4EzF5p9nqWT8dU93VdpWKz6n?=
 =?us-ascii?Q?soXKePM9nRZeWp52BM/w5WDvrQKfMzsjaXWg3OXqIpYJP7Vjz/z3oyBludqU?=
 =?us-ascii?Q?KlkV4D3aHtvj8Med+LgzoSxu0qoviw4KlNHEvoKuVqwDLi01bQXRiSquq+Ha?=
 =?us-ascii?Q?Di3qWNkh+7u7jpEbZBUL7SpcJ0VWjI1T3F65nHw1UZZIvOdsGEcKDijJNJ2E?=
 =?us-ascii?Q?wXr5MB1B7nHTJxu9c/wMRyet3kC3yw9J6yQ482HTaQwm38/Xa5vdjQVTFPdt?=
 =?us-ascii?Q?0OdAf1QLRY8H/m0AttFJdOwmebFjwDvH8h0KaLGE7itfzkAdDk9IzWW+yixY?=
 =?us-ascii?Q?OKyDUU8SDYXHSymdiAm+RcjcEFHqU7/DEOcdOlgQZKRQB2Y1ADofxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Gzj2c9NUakA7DXvoBqsk8CBpRGDZy2lT+G9Z7fkCiHi0yHYP7FX1dgFhAAb?=
 =?us-ascii?Q?XzPEJGFiVlwDzA5w8UY8t5Q6bRIc5Cn4awO6e1T7gYE/V/N6JKn2/JknMljI?=
 =?us-ascii?Q?sxd3MjuVDUoEckUIAkgwNpb3eOEM4IcdcE7nfVqTKBoXigojEnUcaS+MoVmh?=
 =?us-ascii?Q?Q2cWvUZtSADPMvBy6nxbMX8naB3TewedN3ff3gfwS0vMYPYFdg1BEUa9J3mp?=
 =?us-ascii?Q?YWw3Df5kBYii7X9y3fdkR5k/4Nb0dGo6pbLvTJIFSxiFSPPvApP2hM1Yexf7?=
 =?us-ascii?Q?Mrd/wfbhqpGfHx7oyF/va+3j99Ydy/rlTpFObHtGwUQ0aAaXuxV/FrKS2Mvz?=
 =?us-ascii?Q?ifNZ32HAfqR9JaYdZufJm534jP2+SysmyGOFYB9rh0f1/rE2+ra06BHp07mi?=
 =?us-ascii?Q?QI9oiI2JsUS1Yb3QCT4WlEyKaJ1IIQX9o6ZajPIojGMWn61nEMvSf1OIe/4B?=
 =?us-ascii?Q?UF27cXQG/x6sHuaWtLjr1IS3k1K2GNsFV8zdy37ulWe06z1d5KZkRtKcMCUh?=
 =?us-ascii?Q?nOoQihVrpSj5tvz6LqnVIqPl2N6SMttifPAeHx1sgq8tRBMYSutvl4VUoOrq?=
 =?us-ascii?Q?HzTJZZjtaUCYZr16w3gFVf9qQcfdSU0ebDi/dHk4MpovpLgWi+P2EGgMx/uS?=
 =?us-ascii?Q?rlhU9z4eGEbIasJujOU8KYJtUl88MSTHZENqudtz11UBt3/NoSfvimljOgju?=
 =?us-ascii?Q?IwyIDKgBsnM5gkTF1BJoZVo5+4daleUfRMKvvBC6XHowwbSstEUu5aGgUejN?=
 =?us-ascii?Q?8l0wcy/kCoctxarP6glv3bf4mEfenu+4PX6iow2mhdKuIFOZZXnwa3zUiw51?=
 =?us-ascii?Q?Nim0e8AGTNWB77lYjH3qWSEJVXh+m8vx3OlMe/Ojl6T7K2X9Dd1Ae8H2jHTQ?=
 =?us-ascii?Q?PT7AO4DOufneGfSFfsxT7qqWp2Df5z1JWnohj0VvKPWDbzVmf8ei1H5cGhRJ?=
 =?us-ascii?Q?Il0nKoLCc6QTf9iO0s5AGb5fBewVSzme6jdl9Mm2vsHwrwVjwfS4gkDxYvm/?=
 =?us-ascii?Q?eOKcDYG2cNnRUyRJVA/JH5ji80mXdxejgRxdsuGu8Ccblo/YBKa2ZYfhDD3o?=
 =?us-ascii?Q?GbvnyyzaV9DgaS0BMFn4JZd5IpDel60fgsC9oOF83StXXMnC7YKvh12CGIV0?=
 =?us-ascii?Q?DTQlPNaLOI2GAAq1M7EZK+SVCIjWua8WLhwHvNLHBLGgdmOD2OnQqzxT6kwJ?=
 =?us-ascii?Q?yfKLshPsPPJxdsnpvH8mmPmR6RbIIqfXhIeTmUW7aHltxtaOE2rU4kp5/SwH?=
 =?us-ascii?Q?hC4rP66fpX1VdPcEAxUFUqtenbopbkiG7IzpBXKCuJvGPEqz4t1v1yXGdMym?=
 =?us-ascii?Q?1LQ88Yh7BNiZijR048OkCbdbBXxZZx+Lsub0r6mcpRykoIgTnwv0LG8s1QXb?=
 =?us-ascii?Q?7bcLpPfLkpdLeaaH5zZx/EGbvkttnFlJmX8TSDQDjUtlJofgCyDeYjB38Ftu?=
 =?us-ascii?Q?mxZLZ8zyoThb7hvGjicaKNK+SnH4OsRyQsKOVCK99pM0+t3r9lu4aBEIIwLI?=
 =?us-ascii?Q?AgtVx/5oXdnQ8lI0/XgxlC5pgLwb87nJgYrUifEZcqr8gONybq0i0OEM9fWm?=
 =?us-ascii?Q?EbkzxSQQkMrnplPlHqc1Qi8bG2C96YHFINpcedmX9BEHsIDsafZZyTAR4rpq?=
 =?us-ascii?Q?g3rLCUqDnO/zMU3yjBa+Ick=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e8b908-6de3-4bdb-bfe5-08ddb8f89af6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 23:40:04.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VFFponucOXWWFpJ9r/dkoC0yA1/LBsjamyfwkKPQ67GWww5kA9cf8T2s9A5qiR4QNMQRp1Cxwzr8znwIqy3ko39lQEaup5javoj8Pn/uagnKknNlCim2m8g4xrdaRDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16153


Hi Geert

Thank you for your review

> > +# SoC Type
> 
> "# Family"?
(snip)
> > -config SYSC_R8A779F0
> > -       bool "System Controller support for R-Car S4-8" if COMPILE_TEST
> > -       select SYSC_RCAR_GEN4
> > +config SYSC_R8A7791
> > +       bool "System Controller support for R8A7791 (R-Car M2-W/N)" if COMPILE_TEST
> 
> "R8A7791/R8A7793"?
(snip)
> The rest LGTM, so

Should I post v2 patch ? Or can you adjust/fixup when you applying ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto

