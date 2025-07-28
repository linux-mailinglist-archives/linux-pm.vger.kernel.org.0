Return-Path: <linux-pm+bounces-31484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63DEB13D22
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 16:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54F53A2B5F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFADB26F461;
	Mon, 28 Jul 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P7hv93IL"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36126E6ED;
	Mon, 28 Jul 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712876; cv=fail; b=gZHYcsOTC+AZuW+KKGsueu6LPyAQUhxm6l29CCLgRpJDDzexn271l/e527275iQ7FaOuHG8/52Mj17Nz3H7Pw1Vz1cc5Cy6YXftnNmuO9rLyGwLcmduHH+e/b3NIJtJLMTYl702pQHt59L8Ch5uuYwjP4nR8A24whv56lTIB5bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712876; c=relaxed/simple;
	bh=AsUWICfnIBdYRS0A/YmwWGAsI9QzIrqBttHqTwx4k78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FLchADMOQLwHdbR2E56C459TsV+Ysk5TUaPak0B1USCCnAA7ZjFQUOGQQNAk4IYPN87fffJTUJs0O95eL1vEKDPe+bxZI5S1macgHi2mk+PzI1gjzgfAnwTmtI9YtlgD7cJWl55TycDUM/tssy1akNiAA5zKk2YYoL1lrS6cj/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P7hv93IL; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+Adm2cI7BtXseXRRa20acDzqS7VyoWiwbAfDwsq5xTL3asCv5dxTgI3jUKxv06k/BTUkYmK5ie1LMe9OtQotzmae2SSuPdtLLxmKuy8Gjy1qBN5PrHkEXU6xPf/ketI9DdT229ea5zLza1H7fXm3yUyW/v70bm81KApiX/Ill4St8kvCIfOLG+rNCj/cO7fD+/abgBoPQ+wFjxe3h4/wt9bxEk5F/YI9l7Uq0lfhIIRV5YwZ+7RRbt3/30bduAbwM6WXoc1Zq5IejDXzZu3qs4iVwZc+A7Z9ccgP6JX7ozkjiHiOVfYEzp2O6PccHeyUQUsZBbctckj4K1I7dykFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzjR7DlGFy3FRCqn3aVShL5vwRwteut1P/W/gYEEE+E=;
 b=Egbsj/IN2ZzXLWryFzvkvAkKOdxx1nh307U//FwCGYTKYmJ5YfX7en3TFeZgAQZ6xphDwjh9gEFOapxh325OpzLYxw/LXx7Jah1+0rSzc/ZkpD00aXw5zDNtyPWnPgyHbTu4wWm1fbBu4C1R0NCYpe1xPhNp5KdFc2WBlnhlerZtPWVwdDg35oIdNkY7k3TV+05ciO6BUoNmXmsvZ3/KA8y8wsv1w3YjuMwNPLgjoxKJlCPjrxXUX8CD0nGt+aWZqB4bjSqvLO7gje5em0ylT5SOqDMFpv/gyMf/cVmjf+Uhvo0aTwf90wKlkMeMi1WQ/GLjKDWFz2XcOqUIK/BqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzjR7DlGFy3FRCqn3aVShL5vwRwteut1P/W/gYEEE+E=;
 b=P7hv93ILUfXMfIZbt2qtdxgZUvLJC+EOwsE5NyvnRF7spELoQ9HlNtu+O1GxVA0yjxBPPv9DYejr6EtXvIrR2Nv+sCj17SiDElxrFeDe10Pp6zbha7jSGHltuSLq8UIaxB+b55J+FHIso2TG3RJObyvxTePeV8jogrhy2Bo1fFZqoB6lgHF4E78GalY7XBYXE99sfyi6bn7kxrBw2D3+99n9SdhVORIwoj87MPDAOdcyjwIWlP6OCzpXlPMQxmBqlNOj/SbqF9uM5kucnRLkbwWciFrpN/j4gBl73ZSUukh3CVsAbXY3zxRKWVk20H5+UJ78ovGuJ2DDwg3n/EPnmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:27:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:27:51 +0000
Date: Mon, 28 Jul 2025 10:27:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, peng.fan@nxp.com, richardcochran@gmail.com,
	catalin.marinas@arm.com, will@kernel.org, ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, frieder.schrempf@kontron.de,
	primoz.fiser@norik.com, othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 03/11] arm64: dts: freescale: move aliases from
 imx93.dtsi to board dts
Message-ID: <aIeI3NQEVeeNzOvh@lizhi-Precision-Tower-5810>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
 <20250728071438.2332382-4-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728071438.2332382-4-joy.zou@nxp.com>
X-ClientProxiedBy: PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea5d419-9962-4e3e-5093-08ddcde2eee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZ9LgOPNsEMZD9UeNcnJmJlmD+DlZJamwiG/RpTWvXmr+MMIoB5i2WRDwBxs?=
 =?us-ascii?Q?xxAEO9B9dxdlv0f3AKK23zFvTN8AsERrc5Tp/g5wjj2LED9L8UopCf95b/yi?=
 =?us-ascii?Q?oyUnY3dkBtPgpiOK6lRHj76h05M79tkWyGUKHS4WoV0yFyJWnLhR74cxmGPv?=
 =?us-ascii?Q?Kv6wY1KpeKIME1kHZfTMbBUNj0eo94OHFjoPz4PiyET1SMIranvmzqib66NH?=
 =?us-ascii?Q?Vbce/q6uAT8HyUHSlhc0IZVOw9elbxGXa9vtQjuOKDr4udxX7e2ufhRVkQ/e?=
 =?us-ascii?Q?1CzBDEpwfwniTQw/mwm1/7vVRm/fgO8W9QngmAgoRqyViWflzQOMi+4Z3STF?=
 =?us-ascii?Q?5obaY/23yhBTjN86VfTo8DElbt7oZ4EFuydJistHOT1DSUDL2lKpthaAh97D?=
 =?us-ascii?Q?3nyaKIQkp5N+WREnYMB/RlsO7TptHpaPmaw6nTemI7neA2T3K8Hh+2Oa5KqN?=
 =?us-ascii?Q?3YIqOm6vcwUcQBP6UpuhqPLZg09x1Oc1PfZjDeoz98fuEB2VB0bH6VpLlqcf?=
 =?us-ascii?Q?gCT3q63tfU3p1/Mg4cixeH+ZCID7fya/PWTMf1VWsHvO2E0ggsvdy/ywTdu6?=
 =?us-ascii?Q?TEJbWuIBDX4txhaGj2Yc5S/9/SfXhZ+R08M6srBobP6C9ASAdMH3ks0z/oC/?=
 =?us-ascii?Q?nRFLtpxCkeh7Y/Tj/p2/kxKd/71JQfH87TMYvc7+y5jJrLhjdfGLBMDG0Enb?=
 =?us-ascii?Q?9wCWpn+mGP1i0VQWboxUUHfzQzG9PDkV9mMktnDmN+8ouM8q93/rddvrmwFr?=
 =?us-ascii?Q?GTdfKdOu3dy26q40hMeMmXQGZpjBg4Si0UYKkJqm2KaKvi82Ljmb/NqQuxRM?=
 =?us-ascii?Q?lRWxA7ZCHXCveyAemC7idU0j/kV8wg8mPXX1LCkHfPTjBHpR2W0/++KNFDU+?=
 =?us-ascii?Q?/bQ62GetsPuCiCKPVsfmyC6EtirX4gQBfx8FcEhN0WHVB8MDBvWxC6WbFsWF?=
 =?us-ascii?Q?mdYbWVry+KnkanBLeKz1fASE5lSbIJdBARlg+uj0zKM0M9bQntClG+//Kpkz?=
 =?us-ascii?Q?sZ8DeUMK73ppUgtLyV0eyhVX6Js3L3WdBimtNyk00eFVzs7f4l4oQqBrXzGt?=
 =?us-ascii?Q?4Q+j+LWY0WUYUb0CxLn28U0qFoyt8dpalBwuo8U6iYjruRRPIqVJXM+dwU+X?=
 =?us-ascii?Q?XlEZGU8cISAFPmvCwEsVanW7rq3nf3Ga+QXTsYaRTkGFqGGa4o9NV3cgwpZF?=
 =?us-ascii?Q?JtpKpbSoCGKjdvpcPKCMovcn6QlL9PRB0M5UpLdylFu07WV7cKU8HlgSUEiK?=
 =?us-ascii?Q?wDDwP0D6Y0RCR5eIHRSIYIW5EvuupntRgFwT26LQTK8KbLctGALe2Ii8gWT8?=
 =?us-ascii?Q?ffuvUFLY6H48Bu5FDUD/CiAJDsDd3dHp3h2A9it2/Bkhagb3nzByV3m1DQCJ?=
 =?us-ascii?Q?hDJBK0MaLPRe+u2ljZioygbO2yhjb2lYiDeFLxXZY1VZPRUcsp3xiwrR0Rdh?=
 =?us-ascii?Q?bxEWnM5TC/ZP4ZqdB8iQaFtl76uuwpwoIEPxvfKnPE8FKopy2DHgSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fs/d2DS/MUivuS7s+n0zBUQU+YiV5lXkTlvuHzkbJVuwd7DyoMqjq4SukPSE?=
 =?us-ascii?Q?wV5hit8zodtkesVgXskOXUy/PAoXqcNRHM6aev2AnV8pqlch2AxpFVUfMzBK?=
 =?us-ascii?Q?RVbOB6297ls9tKCdbxf/wNn3tIIhnDVueHl8lUFr/RLShXf+jWtwfPGkBah8?=
 =?us-ascii?Q?G4giqH3Dh5ZvJ+CIXp8SO7Z7ObKePZdRILqLjbJjfM7oDaS/yfyPxwWA3XYk?=
 =?us-ascii?Q?5Wt5s5NtghPZshJJdC9dy5lWuGp1OT649nkCBZNtXl1pQ3PBmjlKHq+lV5qP?=
 =?us-ascii?Q?VU7woztjXALiiqsmulEkVo/lMX+Hu84Cp57X4fbQINBMHDd6Mbj3gB8ApsZG?=
 =?us-ascii?Q?K/55JQX4k45K8ymKvs3co6r6o0hCwTX6urRf6364nF20CNdbhlNH5JxJ0ypP?=
 =?us-ascii?Q?VAePPgoIhs7c2rk2dLJ94QNReHFXtndPzirHsg/4+iWBMkQsOLOoyFFVUizO?=
 =?us-ascii?Q?fweArthxYHibl3EHs5tfrxZk8wn1x+UPG6kLI2LfCs5pm99SjKw02jQeIpK5?=
 =?us-ascii?Q?jmMXwvJNbm5cHLTkdTesw8uObih0irHjiCFICJiMgzbK0K/BjR/HhbJ6dj0o?=
 =?us-ascii?Q?dfem7N4MtwAL3BNQsDXme0kMRwK/LLjrH3wxj4wtMC6JeLlVpDIGmMab8Yae?=
 =?us-ascii?Q?RrWPDJMHeARp5TohfImY1OI9k1M2teK1QChuY0LOcBspqjr/PtkDxsSknBCu?=
 =?us-ascii?Q?3Lc68st7G9kSjxEBklhim58sdKsG/zhsA7GBysZTRctKHqtszwgI/c5qzJnp?=
 =?us-ascii?Q?pZdSIDn8ZfPOebw6Ri8I2n9CZuZQXhlxMx/qd/aYPjYADZOKsKhULdggnaiM?=
 =?us-ascii?Q?dLq6p+bGoqgD+0mVkuYw2bGFl6kepGxxuRFbxdcrmqFJf+amjanBwsrET33S?=
 =?us-ascii?Q?P5J5z75f2k2dzxFIbHnHZK2LHk9GHtW9O3lqkRIrpSSsjJgV1UcUhwy/aB41?=
 =?us-ascii?Q?6OfJ8dX+Eg/posteCoAyN5N4zyL/VZtZyZOsnu38GWKAsRmCn56wQUZcrASH?=
 =?us-ascii?Q?BGZTBsyCJbIzUK3FmqP36P3eJevIxOo2fFpiwsixCMFJ8nGpTwyVY7Hbf7YB?=
 =?us-ascii?Q?04RsiumcoUVb2FVQA3ZwDdPGq2sdyU7poxzsv4KZ6iUMfPw9qmCbVxQPE9Fy?=
 =?us-ascii?Q?vWJomf0oJyoj5TGGe6KgqTaAi+lfIdkSyNTRQXvysGJYYequKSi3d/hFtNgY?=
 =?us-ascii?Q?5610clCQLMGO+XC/K5DhX36dZ5Re4/F5uuygy7JMwuPcNgj75TvSI/IHGdRl?=
 =?us-ascii?Q?nq+MiJCFoxvHsNDUcXHmxjFOIypCabE3Y+KFTe3SJ6g93Td+y46FfaKoeZWg?=
 =?us-ascii?Q?9fqzI+7DNT5dgPJ63CEEdzp0/6kgRFPBk/3n6ArYGlJHkrhYAGKM/wsd+rWa?=
 =?us-ascii?Q?5AfJeNmHwU+3DlhrBNilc7osDIfkMxGrFb8oFCFW960DW7lNlA1TRKr6Q+Ci?=
 =?us-ascii?Q?RL5f0uZrgndu4opCqaa4Vkia23e/t47IIU1zSgu9gVYpp19GqpTk021bqTJi?=
 =?us-ascii?Q?04+jrFizUrTgMHM/zbO2pqvAZ9dPofi0jiqVgU3JjLX4c/chJWd5NUDiEMjk?=
 =?us-ascii?Q?97ReosQwEIaRvPeH+qY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea5d419-9962-4e3e-5093-08ddcde2eee1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:27:51.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8clsG5/a8H8gsRl6JP2jW3wo9UXXoj4JR3h7hofORXheG4NKwIK/OROKHpjR+g0EDVleywD897Z0ZAFpbjD0JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020

On Mon, Jul 28, 2025 at 03:14:30PM +0800, Joy Zou wrote:
> The aliases is board level property rather than soc property, so move
> these to each boards.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes for v7:
> 1. Add new patch that move aliases from imx93.dtsi to board dts.
> 2. The aliases is board level property rather than soc property.
>    These changes come from comments:
>    https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
> 3. Only add aliases using to imx93 board dts.
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++
>  .../boot/dts/freescale/imx93-14x14-evk.dts    | 15 ++++++++
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 18 ++++++++++
>  .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 21 ++++++++++++
>  .../dts/freescale/imx93-phyboard-nash.dts     | 21 ++++++++++++
>  .../dts/freescale/imx93-phyboard-segin.dts    |  9 +++++
>  .../freescale/imx93-tqma9352-mba91xxca.dts    | 11 ++++++
>  .../freescale/imx93-tqma9352-mba93xxca.dts    | 25 ++++++++++++++
>  .../freescale/imx93-tqma9352-mba93xxla.dts    | 25 ++++++++++++++
>  .../dts/freescale/imx93-var-som-symphony.dts  | 17 ++++++++++
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 34 -------------------
>  11 files changed, 181 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 8491eb53120e..674b2be900e6 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -12,6 +12,25 @@ / {
>  	model = "NXP i.MX93 11X11 EVK board";
>  	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
>
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		rtc0 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +	};
> +
>  	chosen {
>  		stdout-path = &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> index f556b6569a68..2f227110606b 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-14x14-evk.dts
> @@ -12,6 +12,21 @@ / {
>  	model = "NXP i.MX93 14X14 EVK board";
>  	compatible = "fsl,imx93-14x14-evk", "fsl,imx93";
>
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		rtc0 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +	};
> +
>  	chosen {
>  		stdout-path = &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index 75e67115d52f..4aa62e849772 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -17,6 +17,24 @@ bt_sco_codec: bt-sco-codec {
>  		compatible = "linux,bt-sco";
>  	};
>
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		rtc0 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +	};
> +
>  	chosen {
>  		stdout-path = &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> index 89e97c604bd3..11dd23044722 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> @@ -14,6 +14,27 @@ / {
>  	aliases {
>  		ethernet0 = &fec;
>  		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +		serial5 = &lpuart6;
> +		serial6 = &lpuart7;
> +		spi0 = &lpspi1;
> +		spi1 = &lpspi2;
> +		spi2 = &lpspi3;
> +		spi3 = &lpspi4;
> +		spi4 = &lpspi5;
> +		spi5 = &lpspi6;
> +		spi6 = &lpspi7;
> +		spi7 = &lpspi8;
>  	};
>
>  	leds {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> index 7e9d031a2f0e..adceeb2fbd20 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
> @@ -20,8 +20,29 @@ / {
>  	aliases {
>  		ethernet0 = &fec;
>  		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
>  		rtc0 = &i2c_rtc;
>  		rtc1 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +		serial5 = &lpuart6;
> +		serial6 = &lpuart7;
> +		spi0 = &lpspi1;
> +		spi1 = &lpspi2;
> +		spi2 = &lpspi3;
> +		spi3 = &lpspi4;
> +		spi4 = &lpspi5;
> +		spi5 = &lpspi6;
>  	};
>
>  	chosen {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> index 0c55b749c834..9e516336aa14 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
> @@ -18,8 +18,17 @@ /{
>  		     "fsl,imx93";
>
>  	aliases {
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
>  		rtc0 = &i2c_rtc;
>  		rtc1 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
>  	};
>
>  	chosen {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
> index 9dbf41cf394b..2673d9dccbf4 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba91xxca.dts
> @@ -27,8 +27,19 @@ aliases {
>  		eeprom0 = &eeprom0;
>  		ethernet0 = &eqos;
>  		ethernet1 = &fec;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
>  		rtc0 = &pcf85063;
>  		rtc1 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
>  	};
>
>  	backlight: backlight {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> index 137b8ed242a2..4760d07ea24b 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> @@ -28,8 +28,33 @@ aliases {
>  		eeprom0 = &eeprom0;
>  		ethernet0 = &eqos;
>  		ethernet1 = &fec;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		i2c3 = &lpi2c4;
> +		i2c4 = &lpi2c5;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
>  		rtc0 = &pcf85063;
>  		rtc1 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +		serial5 = &lpuart6;
> +		serial6 = &lpuart7;
> +		serial7 = &lpuart8;
> +		spi0 = &lpspi1;
> +		spi1 = &lpspi2;
> +		spi2 = &lpspi3;
> +		spi3 = &lpspi4;
> +		spi4 = &lpspi5;
> +		spi5 = &lpspi6;
>  	};
>
>  	backlight_lvds: backlight {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> index 219f49a4f87f..8a88c98ac05a 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> @@ -28,8 +28,33 @@ aliases {
>  		eeprom0 = &eeprom0;
>  		ethernet0 = &eqos;
>  		ethernet1 = &fec;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		i2c3 = &lpi2c4;
> +		i2c4 = &lpi2c5;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
>  		rtc0 = &pcf85063;
>  		rtc1 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +		serial5 = &lpuart6;
> +		serial6 = &lpuart7;
> +		serial7 = &lpuart8;
> +		spi0 = &lpspi1;
> +		spi1 = &lpspi2;
> +		spi2 = &lpspi3;
> +		spi3 = &lpspi4;
> +		spi4 = &lpspi5;
> +		spi5 = &lpspi6;
>  	};
>
>  	backlight_lvds: backlight {
> diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> index 576d6982a4a0..c789c1f24bdc 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-var-som-symphony.dts
> @@ -17,8 +17,25 @@ /{
>  	aliases {
>  		ethernet0 = &eqos;
>  		ethernet1 = &fec;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		i2c3 = &lpi2c4;
> +		i2c4 = &lpi2c5;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +		serial5 = &lpuart6;
>  	};
>
> +
>  	chosen {
>  		stdout-path = &lpuart1;
>  	};
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 64cd0776b43d..97ba4bf9bc7d 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -18,40 +18,6 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>
> -	aliases {
> -		gpio0 = &gpio1;
> -		gpio1 = &gpio2;
> -		gpio2 = &gpio3;
> -		gpio3 = &gpio4;
> -		i2c0 = &lpi2c1;
> -		i2c1 = &lpi2c2;
> -		i2c2 = &lpi2c3;
> -		i2c3 = &lpi2c4;
> -		i2c4 = &lpi2c5;
> -		i2c5 = &lpi2c6;
> -		i2c6 = &lpi2c7;
> -		i2c7 = &lpi2c8;
> -		mmc0 = &usdhc1;
> -		mmc1 = &usdhc2;
> -		mmc2 = &usdhc3;
> -		serial0 = &lpuart1;
> -		serial1 = &lpuart2;
> -		serial2 = &lpuart3;
> -		serial3 = &lpuart4;
> -		serial4 = &lpuart5;
> -		serial5 = &lpuart6;
> -		serial6 = &lpuart7;
> -		serial7 = &lpuart8;
> -		spi0 = &lpspi1;
> -		spi1 = &lpspi2;
> -		spi2 = &lpspi3;
> -		spi3 = &lpspi4;
> -		spi4 = &lpspi5;
> -		spi5 = &lpspi6;
> -		spi6 = &lpspi7;
> -		spi7 = &lpspi8;
> -	};
> -
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> --
> 2.37.1
>

