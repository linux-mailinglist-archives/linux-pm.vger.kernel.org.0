Return-Path: <linux-pm+bounces-20674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A275A167A9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EDF1661A0
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38093190485;
	Mon, 20 Jan 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WPpDCDNM"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7424C96;
	Mon, 20 Jan 2025 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737359474; cv=fail; b=cXItLRqGJa8HLgPD67vfcjnzvQeXWZlXdfP6AO6usA/OGipKjVVDlRYKR1mwbM/L7Jg6qngJgAq8p28GPZNzLzV7ci8lFgjKEufQuIPRBpQFPbAw93pAx+GEr7FQuioCm6Xdxf3DGCrFvX24TkTSNsPd/GHe8QoLM7fdpLMikZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737359474; c=relaxed/simple;
	bh=zNpZgGJGHThDvqH9099nZzmdMKwU8M4kd0hAg2JY+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S2TgrVoNEwShVztlxC5We9SsB8WW52KZVmoNcc984uTJDLe+PmMJzI0INm/mRIwQ+5lHsVldv654QIb3VicPEBE/0jOeIGDeX8ZsRw3HUIlpZj6KaD4s9DKg7zdrY1ph5Q/pr2QYo00cW4YVsDR67L4A16DArx+5NZ9R7vLicCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WPpDCDNM; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXCd0TC4t/k2hEeCaB2zmGuJ0cpiWduX9HPfkoFW222o4GUIVH4xrdo0jLa3L4i26XobkCLQ/WG410IIdtx8+87LGG8MKqpooKFiTYpF8EzYhqFZ2Do5XI0AFT9Am3AW7dO8Sur+YoAHvM/Qspb2MHdcqTDTCFFH32pYnERFmj2OjxxNnPd/wJ/WBHkpj/XnKb/2lW4uwYRlFFy9QKmL6DqH0JOx4jxtuF3z/ezGGKpBYRwoPFYY/0sUbTIg6cR9UCxmMmZEH5Gkl1Hly5Ody1Kh1X1w8/39Xa+S6SBvVW/jMY6/KJASki6KjO+c3ibLBxyfNPxE1rylrh/xJ+vF4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNpZgGJGHThDvqH9099nZzmdMKwU8M4kd0hAg2JY+HY=;
 b=NYcy4/ZhvstrEMLg274orsp93+4UTsX+v+AnhSU1qkgOAEbn3s24l7TugiMdsjzlOLgJS1StNDC0iz5f16hfnr/ZnmrtEfywBDmmGnluPHH8pUENLPQmBGk2y8JdHykoanEPdGaXAfm8RZAA1c3ReDDzlSDFkxPkqyexJE+14ktpwWtHTCCZIJZa4dAQbgzEXCl9IrFHZty2d5LwuCdA8KPF7aPSsYH4rFPfOSlEuLLmbTrVcsdNbXslhANAkyx6ZmmLkg7R275Mp7JJsCLIbiPiIoJb6uzUCUibwg6FymwE3qgGONzfeLpxrcEOKvEp6UuBLrkZDcdCk8IFEFvCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNpZgGJGHThDvqH9099nZzmdMKwU8M4kd0hAg2JY+HY=;
 b=WPpDCDNM9pgKFXXwoMT2W9ygCCDOa2ZyfAhLZZPwLT1riMba2YY8VlITvWjCHvWFJqHeOrfxaTwQdkWK4fzV/4oea6Zrfk2tAT/ZQQ9nr+oLUkp3fS1ycCqFPLzr0Q6/Xsr1bdo2FDGQmKs0/iIquL3ExfoOH4I22Wn8crumCwEiRQ0r17O5hqx1kLRc8ftR5W9FR13E3H6emq30ObM1fisTsrYbvtrr2iXy23lCsIAY+BTZdurTcS/ZbE9L5ihdPITrm942kKJpbAEpFLXSiTLDOnCRzKJ5VMreEBre0zivMZ0EWtSO6ljC9qh3AH5jtqTUfKLPnGDE5D8Vm+NAsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7487.eurprd04.prod.outlook.com (2603:10a6:800:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 07:51:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 07:51:07 +0000
Date: Mon, 20 Jan 2025 16:57:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 00/12] pm: Introduce devm_pm_set_wake_irq
Message-ID: <20250120085713.GA11473@localhost.localdomain>
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b984b7-5378-489a-de6e-08dd392732b7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bK2JZc6pipO6y/Kg+CzPKvVl+iTlbOCMNhnLdiKoJg3oaaqEqVhSo4vdvXLQ?=
 =?us-ascii?Q?uhuF28TowGDpMq8YhHliGXX3hdm0xhufJY5rst2LoalJm0jfsCseBeR31ca2?=
 =?us-ascii?Q?1DKTT7u8KBax7sOAm8GwcttsTcDWTS8tKCqzGuVyFf7L4rATkYUPb5qyy0Qn?=
 =?us-ascii?Q?yMiYkksEO8XETh2l3I8rhOUR5998txQOHoyUrKLTRHmr0MQotUlw3Ixsumcr?=
 =?us-ascii?Q?o9wGAYjXIF7rQNQxZ/+qu7pfeLyOjlOS/q+KrHYJIi1zTlhu5yz9EqP69E0i?=
 =?us-ascii?Q?VmAhEh35HLi1jNo82RbyCzTApM9UE7cvPIFraRraJ5MyMRrUNSzec4lUUXsT?=
 =?us-ascii?Q?a27iYywr+BAq+U/KbPSjlOVLTL3O8F3ZPotZVJQDcbGXnkEpX9NnExNo/8Rk?=
 =?us-ascii?Q?n9BH2oVPs8ZrMLJgXYi7wpHL0vnKPfJsoeFDIwJ8XyD212G2NaI/T2ABwHUh?=
 =?us-ascii?Q?x95BgLNiJ9JdEk+j3nn1Wd/hDxHCMOwHrDKb1A8g7+mOZ6SV2goOh56XFHUU?=
 =?us-ascii?Q?KFD0IOYhVBgnfwJiY0n3xMPj+ULJV4jG7aU4f5lWF8o0Vhu7eWITiJ76Pxtk?=
 =?us-ascii?Q?xg0j5Ju5B3uIZ1DTBArn0mWkzmfBOjhxbVhmE0uqoR9SjfCnmxq8DOrWv4lf?=
 =?us-ascii?Q?hAbncfbfsvu0ns47mEtMP6EgcKOAybnkghjBSe6nSHZkub+IGvwJt8HwP1ZU?=
 =?us-ascii?Q?Uv5K+KpL2iL0VlgudhO9ZcAXvlS6GR69kPGmxshrXsVOhzWpIeS5c5x+8C7a?=
 =?us-ascii?Q?qsFrjI8zCMwgWkGa/dGZS+s089G5FCzBKK73DNweJJi7QzszWhL7kPezg6h4?=
 =?us-ascii?Q?7dKx4Jt3DkrCsHTK452IDc7x3ZUltQHGmgcHy+SZ67w9fVqcvkNXOBiD8yPe?=
 =?us-ascii?Q?KE4LEzSIvfqKYdLa9XTpqsJs8EwxPXlVbJBvwfDvLUy4dp6gnkND4VdYj+8b?=
 =?us-ascii?Q?XrJ47Lw+wz9aBeiUGpefoIBGUbsvStI7YgWC3tpG2Z7H6zVPPeIXaD93fj4Q?=
 =?us-ascii?Q?jBhJVK19Ow0B2v2tSL7jmaE1lqiLSJZxcK1OYt5Zm8fjK0ObhaPhNywI95Al?=
 =?us-ascii?Q?btkUj/rJcQMOcmtCtEOw5jzuQWRSybwM4AyCvGGsUJQwh6lMLR5cf2/TiZYe?=
 =?us-ascii?Q?uD3K8xaTVkYNdGSTz58fCFuah0qG6m9tPSq0sGVwerHZtq5KyRul2A1HF/bY?=
 =?us-ascii?Q?vL7HqaT9MJDEa2O6z+iBpeG5uGRRQ8AhU7tbX5AKqVVJCQmAtYkp209hg8Jc?=
 =?us-ascii?Q?7KA9v+zeHfeF57p+0y93fT5fPdLTTN4efrJKwr2xxzHEllvJis6qjVEbeNGT?=
 =?us-ascii?Q?+Qrmg/nOJXn+vWCaGIF7pilDPPGrs+12MC5jug0dwg661OcrQZVPgcARcDhq?=
 =?us-ascii?Q?esA7/dM+8ZMu/U64yO15pZIF3P7WymJ7vF86OJqMFlofQbgcS/3YJVeMgNwX?=
 =?us-ascii?Q?LmHKxvPOXYhiCTFbJ2czEb3wcMVR07og?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MlYCCekcIK2h3IHYX+2IOuWCKuT8321c9KrGhMMJElWyFGC+P6JVUPhcPbsx?=
 =?us-ascii?Q?6mEPTgdP2imt8R0plt/TLbmqlp89cZ1z0EDYJIC9i9oMNmMYcQj2TYVpuI8N?=
 =?us-ascii?Q?3/NOa+pCO81T0064W3kppn4DR9ijDuCvkOo/RjhRsfBu11mcoYSEX7mqb4f4?=
 =?us-ascii?Q?9tB2+Zfb4S9JjIuBUV3xVF//s1LGZXYP8NRk3nSoJadhxUDUnZkFxqrL3Oyk?=
 =?us-ascii?Q?vDeRXsXrRgbsg2vwUr6vnLUz/UIW8KLne3VujzIgUHFhLSOe1Qg3yzttnj2S?=
 =?us-ascii?Q?4aY2lEa9MkbUHrZlhkGA/hRFHCISnxxzyZrSrTnSXGvOYlGA7t4NhA91sa6T?=
 =?us-ascii?Q?SneNJFZP1UIJRslOA1SgE84i06jIdU2f29dUmGflwfoDzN6CtzFZgFmDw+zZ?=
 =?us-ascii?Q?MOLS7DTbjAJ/0cGoLqODR9xQCz3Yfk6bwnoaYYPJwe4TYyyiugD+chFiVkJP?=
 =?us-ascii?Q?0Hud9CZU5kyo7ZArznDs7+rfskoV3VVumt+jPekbwvH5iSQDyx+3osYU4vu4?=
 =?us-ascii?Q?zhkoBZVKLvHWE4ncJWS82Xw0wclkiQUh3CvQ9geYYqvSDZmv/8oOA3AZgadM?=
 =?us-ascii?Q?zP0IdaPFUCw2So7bSKvIx09qHK5xq+637EYf8KxtRp4/H0j6L45vHukQjNFW?=
 =?us-ascii?Q?3YuTq22WmGzUMEjlLmlNFRCdBvm00sxAID4LBPXPyJ3dmtyj/3IBXhb9aQsn?=
 =?us-ascii?Q?2PbCkvLeuQXRvrsN+OB0yZGKZh/3oMvMe6jYNdizL/2ccZHHswBjEU2etG8H?=
 =?us-ascii?Q?GFY7kTmbultCJn2MYMgFO14I6admaaLGtBWL5OSc9nKPRstJXEGAVD0lcO7+?=
 =?us-ascii?Q?nsTbhugfU4LffTdQ3s1ihKxHvyVBrY73LXBAjgj7IKPUKCqg2Pax5tW8Bk4i?=
 =?us-ascii?Q?VBTEaYQ6lElWP8DqBiIPR5A8WXkvRUO97OjQVJ38MeQg7Xuj2o72rbpAc6qi?=
 =?us-ascii?Q?THbZclyur4f2pEie7DPCDP/2ovw9BHsl5qD1c95j7bUY50JSEkUmUkOS5TAM?=
 =?us-ascii?Q?xqEt/DtYNHxsgO33LQP+z11bJccqaS2dlKUL2jwdY17LzFYcTURp7TERhn5u?=
 =?us-ascii?Q?ySeEcVWwqxRU9MwDYdvndWyXIbHyRjZp3VzEYZkrt5sgrCZyC/jsYazmzt+E?=
 =?us-ascii?Q?msOTKHjnyu/G9+inOwdwwzwrO7BKrDyREGcTgIWBoYnismG1AUI4cmE/oh9R?=
 =?us-ascii?Q?V9vdxHzHzsiPUdUoUR2h3nXA55J2+K0dqMx5dhkBIqI5jaSZTi206a1/HXVn?=
 =?us-ascii?Q?heKi4GDkutfryUP/mubj1/Svf5xwmkV5js89JE0Lhn7S8xJmDaqQ9NWS7Wib?=
 =?us-ascii?Q?+qgSyG2lYxKGq+g/SxrPF+MQkssYLvYjoeDaPk+RSGqeC7QoafLlwoYmmiCj?=
 =?us-ascii?Q?QmSgpWwyrcXuYhS+Uuy0z1bREXBzakr0dibtorC9/HBQnH98nq4rEun/ta6k?=
 =?us-ascii?Q?2hjzf5W9847gQw/X2tmRIOt3vm1SwRa7RLyUme3St7ABDWULstifuPf4QDnI?=
 =?us-ascii?Q?Kmdn7B4ZTWOQcfwxrvb1B18lF7xb5O2fsE9Z+7jgCMaYY6ISo05l34yQ/5h7?=
 =?us-ascii?Q?2faQ1YV2JubzJdkB2NRfNZvqn1QOVaS1Ma5ILrAm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b984b7-5378-489a-de6e-08dd392732b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 07:51:07.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQs0XptAhdx1TsDG/p61/UhxakYiA2hubrEBK4VxdJImGYmHUpQ3eqTBLB8GwGADy/gXdWaDstnAvugia2UthA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487

Hi Alexandre, Dmitry

On Fri, Jan 03, 2025 at 04:41:12PM +0800, Peng Fan (OSS) wrote:
>This was a retry to address [1][2], to let common code handle
>dev_pm_clear_wake_irq. Then no need to call dev_pm_clear_wake_irq
>in each driver.remove() hook and error handling path.

Patch 1 has been accepted into pm tree.

For the rtc and input patches, are you ok with them?

Thanks,
Peng

