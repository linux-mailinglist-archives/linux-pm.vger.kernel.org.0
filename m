Return-Path: <linux-pm+bounces-23426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1363A4E740
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF468E1A10
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940227CB2A;
	Tue,  4 Mar 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z7xNwILY"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B527CB0C;
	Tue,  4 Mar 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104616; cv=fail; b=NSbJYaJ+S4pkBKRK8JU/wZa0WJShFyWriaAmcUQ82JagiKpJu/vuVJjlmnO6GatfgtMvV/J2aXMJAahntsvruGhTSq1sp3yBLmIK33fF9k2u3NDtw0r5XAT9Z+Umm5KjjOiEGnCKZpsq9HTE4hkQtJMzG87d3k2dUxZERDjWGNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104616; c=relaxed/simple;
	bh=591ax5HgNUjMBPnjwqYbnvwHiwAkFKlf1efFl3ALsqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lnqrhSBs8J9N9TPC9SLBKqAvcRXlkSnMCptoqW8f9Yf9g8YrvHE6UKFsFKeFsNaoGlsi6mCHRrAVzZRXu6mikLCovU3UzZRSrjyevDgo8ufi0GSwXR6j3uI1IpPX9t+FB0SA4Ny/2FnqeR8bKAhaWvRN7E3Jmax5/8Gsksc7AOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z7xNwILY; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYhopeAPOGRDii60jrrPn6Q741p6oDinqGv9pc7QTngQfYTFoITDLEaudr+PYJo31GQcKOwrtxsp/GC6CMzRl1JJmZMPByApzLwX4eeSj8HfAVPa45jnAEpylkkhVpG4RATLv4s2t4k1ipeoDDS+es7S22M9q7/TVTbiZ5cNTT2SY9QmzX3gU10QcdpcawBU2vadujHvJQ/G1ZjI0jAQKXOY2G7V+zrgSwKt2alxlyHyy41qZa7/pop755gjW/dPG/Qode+xHiDG+dy3yzB+ITJSkrfIS9VBt0LoQ0+2jMjmraGS93Yx3nA8AxFEGQoMMN+HWWEVJzOHuTNCyAyEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOTE2cHaeVEdvkl4fnHP4GWrQZqQ0FAgH5/D5Hck9Xs=;
 b=CfKOeRiUcOYRZIvgbZjlb4723anMK+k4DUYT4qYhbR0YL3v6KcUGupLRHZSUrLNTlX2XN2ye/LwVmYFWzspe/rfKHKT7Kq6ltRFqYTUMMLUGTF5wLHOgIz6wl9gMbXsvqx6Dms+vnmwrfTaq3GaKxPB7aM6CqmAKFkL5HCqC0koQat93T1SVVVziD6J7uXqnd1DNKa3utfrqCfdWvPQTQWQGTytzm7fRBT6m5r+3KjwgedU79zrokO2XZqx9lJ637iC6jJ1i0ejCkGBN0pFegdjsB07mmy6B8QZiIAlap2p4BF0PCo/1pRF1e4Wg/duZndA26YSDGEtf5XpstAqElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOTE2cHaeVEdvkl4fnHP4GWrQZqQ0FAgH5/D5Hck9Xs=;
 b=Z7xNwILYhY2ZYtlCcxAyMkZaLaPreKnnVknEaJSdBfIXmfTR9fGe+RohPmg51teZpOO4TfGxJ3MtomH3KLx5fPxtzZJOXLsynxxci8Y/bNHbIfRzgNRKThlugBa3GV0oAMdU5NNCn9CmfzB8oweKJsQeoMMIk6mxBonV2c3pGMZ9woXCa3igtlB64236z2TVGGtksTcuG8tASl0WgDfyCE59YEnZtdTEKXxgPNcN9NuqLXV4wnzYWjUo2EL8hWlKKEL0ypOnrc8fyXtytnaI3HOjX9ufu+MwgkmhTr+/XfMZObkOQHe2CT3JuWwxvMheaZDtETHDVpOeTzUg51itzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9369.eurprd04.prod.outlook.com (2603:10a6:10:358::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:10:11 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:10:11 +0000
Date: Tue, 4 Mar 2025 11:10:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] arm64: dts: imx93: Add LCDIF & LDB nodes
Message-ID: <Z8cl2bwpYFiS2lnr@lizhi-Precision-Tower-5810>
References: <20250304154929.1785200-1-alexander.stein@ew.tq-group.com>
 <20250304154929.1785200-5-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154929.1785200-5-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9369:EE_
X-MS-Office365-Filtering-Correlation-Id: 2913b20d-d543-4898-ff06-08dd5b370a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZbfvADZY+875wP5SqFFNqtx8wwxNfllrH3dKpzBI0m9rC6M8bFsm8mv4aZk3?=
 =?us-ascii?Q?vgFsFebO0HZPgHXddbOlbD99XIykkVaqMA+0qy6yAUY3C8P5LqqzkZrUZu8m?=
 =?us-ascii?Q?m8NGnulX6JU8f0GzoRMZ+1cUzeaEoaRe8mV8d5yY/jAhb3FCicAjSwNAUgWi?=
 =?us-ascii?Q?3aatapM7CJBD63GDVF7iXNOVzvhIpQ3lgXQU5HewwmxsKIAPb+coHVBKw352?=
 =?us-ascii?Q?ZSpMIKVBqR+PqqTSJn5HYMkJvj4/Nqgro39UsfyzzyPd2gcNkJH6GNjfeI4/?=
 =?us-ascii?Q?1V1NMyqjJnZfesTIRpcS/qfCL55ygHNrni730HIFESJAQ5yxGcDAkCQqdFSn?=
 =?us-ascii?Q?RcRFCLiKdEDYzfUXH/HmP4QDkZuf7wQYFD3P/ceB26ThX0rhAXewVUMUj+X8?=
 =?us-ascii?Q?gzQ3ZZ7AwvxB+hcCbH/8yQwYQTGv35tjWTv1OPhrdFua/r3c6ZjXYW7vEiQL?=
 =?us-ascii?Q?rk759NswEMGDTpUchDYSiIxS6O1TfxDepOasJ0ZlD9sFvB0sumZRrSNkl8K4?=
 =?us-ascii?Q?8TxMN+QsIb7GhhOzWTr+eqItPXjcRSlMRx0XSp5agTcICeAhKPuYlavaea/K?=
 =?us-ascii?Q?4ZTGgE6/q5P7H66fsZIpBsPlu8iQAYTSH9NrGKEueIMSZIPHzsGricjNz2m1?=
 =?us-ascii?Q?BrKiSYP8efC3W1nwg3GgSW2NHqV+e0I39FuSkSxeJLzazezx1/2KwiUqbhPx?=
 =?us-ascii?Q?92LWwF7zh0eHqoEr3jaEkQPq3YXNMMEjddwVhfPN0yNgbnSEAdbRIlb0bmLE?=
 =?us-ascii?Q?1ZzBBqhfEeXn9M0dUGt0CwIets+1ggYhQEKyHarr3qn32Ewa3TnkFYuTAfX6?=
 =?us-ascii?Q?10Uj+6DWvwkAPYtLzdTDLyFXn+INQttslOb1ercKN5iirukJFD19+oF/j3GH?=
 =?us-ascii?Q?hV4ZIv8MDDE4b1LdusZ2cLTcNFbW5i0330GDSu2033Z9jstkfOkUTFhAOl8y?=
 =?us-ascii?Q?6Bhj03lYuN77Jp78LrXYBcgyy49UScK7Hix+5N16cje8o6eRkN3WLRy+01nB?=
 =?us-ascii?Q?p1zPtn74tM+85QmaSF0U3coR28nByAgowi+Y09hlLaNxCsRpi5TSEt9ChH8I?=
 =?us-ascii?Q?/un1GLgX8i9qqc0uHjOtseaTnmhbHSmikw1gHszWUmi0t9FhRRZC484d9EP2?=
 =?us-ascii?Q?h+geC5OyKmh6A1Ak7qPkXH1nmSzki4aJMl1M4iFThtH9mK2k2kN1JM/+HvHL?=
 =?us-ascii?Q?BFbwtvIrbDYN9IK8WyasSHtZGfk8fmlZhbCnzMZDBGXb0CdyuE1YWjDswCP7?=
 =?us-ascii?Q?Cid9dDJddt4X5qUu3WF9alu07n9Ab8YU+wsurO1x+in4yf7GsP16Udxuucp9?=
 =?us-ascii?Q?ocZHqBa0fRKdRBLPo0e+MRMQOz+mSOgrPUqmXjKTEGiaSfPSUMVKlrLOpXHy?=
 =?us-ascii?Q?LDIotxhTRkoCHLHZTOhkhwAIVenp7epSvwePKkudccQW8sVLOJKiPclZwTpU?=
 =?us-ascii?Q?8ObA9AkCohIzTv0hRKU1tVT/Rn1HgiYu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCTGGoyQ+PlfmboB6jScsjT/XehKSzUyvcD8VfOn7vMTEHda+g2Q6iGZO/0F?=
 =?us-ascii?Q?UelNv+5RjvINGZtRwbHqdtViPgecHs92fTNk6+t7G3Bismh36Jxkmu6iszOT?=
 =?us-ascii?Q?673HHk/Yi4OwatmftukEMpkurIKZwp6VfjXcXQNmVlJGFefYXPN1T1AONtIF?=
 =?us-ascii?Q?FGjgEgy5lPuP4+KVmAFLIUY4CP/uAz2ZGBPqIn5vU44/qYaCFEwRrzIrjCBL?=
 =?us-ascii?Q?w12e9JPEZ97LVVQiTdLjshkmWh6jWdpnkZ5W5PjSiBP3BVoVWmoz4ZJ9THuF?=
 =?us-ascii?Q?YFANa1TQJ7jISVP8HV45OmrTcWE3b7Jmw+6lDYwG4O0ycM3QYA0zVN4s3/Fm?=
 =?us-ascii?Q?t/9a7EUgzR32+aEV1TxnQBQ1BCgi5aUwCGX/p3dW7K0dvSZVU9qHmHYMYXmA?=
 =?us-ascii?Q?W6CycMQa0uR6GNCnFhr/qXMgyImO6x1MoNcjDNnwox8ozsLDxy2gY4CO+GI+?=
 =?us-ascii?Q?BsfctUbNKt73irTZLF7RVButKx83uhh9SZOyLaxTR6jTygrEtmQIk/bc4/j3?=
 =?us-ascii?Q?+VlFmk2WIfzDAIA/GWX6YiwjZdeA/Ypn4nOZSB6FpdJNxU7wkgyfAEwQGVbQ?=
 =?us-ascii?Q?w6xeixzALDpo1kJWIrG1FA3BrNxHB1YZfDtSy3H0Tks0+N+42CMgOArFSqKW?=
 =?us-ascii?Q?pj7D4HZIQK69RuL/9j9H1t5N7Tyk+9lVpczoZt1eo3djrT13Jx3lTUl4Snu3?=
 =?us-ascii?Q?N5ESY/8sQTonil2U5xJUAKRyqsB6U+hw+fimuK3T6tK/jc30f80hjEqi9oRg?=
 =?us-ascii?Q?rAuZNJN4IERM3eUAiO23iYIe4oe7Jh2AAp/4iJudjBAZoKVh89V0l0M0t19f?=
 =?us-ascii?Q?C86FRiLYpVx/nYs1iXakHyLBVVYMBDWBRFFW8q7PPJfv5bjW3FlfeSSZ433h?=
 =?us-ascii?Q?ZSXJsHT8I+7vI498Ka10obUUKjTTXfA/8spI7Cek+U/Rnc740sGLsmnyF8GC?=
 =?us-ascii?Q?opxGbPSlgvhKJ61UUpHLY6hTzFXyM/XlaDpqhF7RE8h8tQFRO6DD1WBJTH1e?=
 =?us-ascii?Q?9ttFq9g7XgmXCqMzHA9G/lKgxmF2TxofOYsRgmwKXKQBdVwDPe6pGqmJCVHf?=
 =?us-ascii?Q?m9dTEBqW6FOpQUvboxWFSItjRE9HKy/kj7P/p+EP+Tryg6j4exCrHNevOqBi?=
 =?us-ascii?Q?fnKLgOQF9VXDu97mO1ravMg64bsQMj9ytuim5YAeKPl/NanLWh9i1PDQJNJD?=
 =?us-ascii?Q?MLdKjDxWcXCXyvvGqtQsd2irXVtXO3YBmEYKHkkMaCo4705IWfTRG6YGnMtQ?=
 =?us-ascii?Q?WQ2EabkfQbBPN1sk026G8HecAr38FpEQpaVEkSZ26Xpx10q+YInlg8b4E9Tj?=
 =?us-ascii?Q?HW0rc3HadlQ8IqKGH9yuHHwbMZsdqpijrg+8LJhhCrb89uyHH/J2vyU0kmXU?=
 =?us-ascii?Q?4a4rsZMwy2jTZ9YZX+K2sf8VBDubp0wnQmXg0gGnT0Wmz/VAgpZESXlh4EhM?=
 =?us-ascii?Q?X2qlW8M/UcFtIohYyPemwqVuWIklEWDc5iEoEz46i74JCaonegGL1zlnqBFg?=
 =?us-ascii?Q?loWg+65D59uqJULXKgZu9wuSSPqGwFU8N0jSU4rIMbAUoYON2mLe8qwlfd4X?=
 =?us-ascii?Q?0iLK/4bxqRuCYdiqXMgfuaLUEozZUALq5cOYK3Zr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2913b20d-d543-4898-ff06-08dd5b370a04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:10:11.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBxgVtjXCR8ozgz6l4sOrVAh6AWlL0kVuUpYXz1CivcyWkSbldzbYCEy35qKdxa1BOKvaJN5qv4SuTU++zzH5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9369

On Tue, Mar 04, 2025 at 04:49:23PM +0100, Alexander Stein wrote:
> LCDIF port 1 is directly attached to the LVDS Display Bridge (LDB).
> Both need the same clock source (VIDEO_PLL1).
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 77 ++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index 56766fdb0b1e5..69a639a8c833f 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -1273,6 +1273,9 @@ s4muap: mailbox@47520000 {
>  		media_blk_ctrl: system-controller@4ac10000 {
>  			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
>  			reg = <0x4ac10000 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x4ac10000 0x10000>;

I remember ranges should be after reg.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  			power-domains = <&mediamix>;
>  			clocks = <&clk IMX93_CLK_MEDIA_APB>,
>  				 <&clk IMX93_CLK_MEDIA_AXI>,
> @@ -1286,8 +1289,82 @@ media_blk_ctrl: system-controller@4ac10000 {
>  				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
>  			clock-names = "apb", "axi", "nic", "disp", "cam",
>  				      "pxp", "lcdif", "isi", "csi", "dsi";
> +			assigned-clocks = <&clk IMX93_CLK_MEDIA_AXI>,
> +					  <&clk IMX93_CLK_MEDIA_APB>,
> +					  <&clk IMX93_CLK_VIDEO_PLL>,
> +					  <&clk IMX93_CLK_MEDIA_DISP_PIX>;
> +			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD0>,
> +						 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +						 <&clk IMX93_CLK_24M>,
> +						 <&clk IMX93_CLK_VIDEO_PLL>;
> +			assigned-clock-rates = <333333333>, <133333333>, <0>, <200000000>;
>  			#power-domain-cells = <1>;
>  			status = "disabled";
> +
> +			lvds_bridge: bridge@20 {
> +				compatible = "fsl,imx93-ldb";
> +				reg = <0x20 0x4>, <0x24 0x4>;
> +				reg-names = "ldb", "lvds";
> +				clocks = <&clk IMX93_CLK_LVDS_GATE>;
> +				clock-names = "ldb";
> +				assigned-clocks = <&clk IMX93_CLK_MEDIA_LDB>;
> +				assigned-clock-parents = <&clk IMX93_CLK_VIDEO_PLL>;
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						ldb_from_lcdif: endpoint {
> +							remote-endpoint = <&lcdif_to_ldb>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						ldb_lvds: endpoint {
> +						};
> +					};
> +				};
> +			};
> +		};
> +
> +		lcdif: display-controller@4ae30000 {
> +			compatible = "fsl,imx93-lcdif";
> +			reg = <0x4ae30000 0x23c>;
> +			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk IMX93_CLK_MEDIA_DISP_PIX>,
> +				 <&clk IMX93_CLK_LCDIF_GATE>,
> +				 <&clk IMX93_CLK_MEDIA_AXI>;
> +			clock-names = "pix", "axi", "disp_axi";
> +			assigned-clocks = <&clk IMX93_CLK_VIDEO_PLL>,
> +					  <&clk IMX93_CLK_MEDIA_DISP_PIX>;
> +			assigned-clock-parents = <&clk IMX93_CLK_24M>,
> +						 <&clk IMX93_CLK_VIDEO_PLL>;
> +			power-domains = <&media_blk_ctrl IMX93_MEDIABLK_PD_LCDIF>;
> +			status = "disabled";
> +
> +			port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				lcdif_to_dsi: endpoint@0 {
> +					reg = <0>;
> +				};
> +
> +				lcdif_to_ldb: endpoint@1 {
> +					reg = <1>;
> +					remote-endpoint = <&ldb_from_lcdif>;
> +				};
> +
> +				lcdif_to_dpi: endpoint@2 {
> +					reg = <2>;
> +				};
> +			};
>  		};
>
>  		usbotg1: usb@4c100000 {
> --
> 2.43.0
>

