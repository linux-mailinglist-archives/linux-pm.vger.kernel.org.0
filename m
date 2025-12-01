Return-Path: <linux-pm+bounces-39020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6DDC99678
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D50DB4E0525
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC827FD5A;
	Mon,  1 Dec 2025 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cpvPHDex"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786F26463A;
	Mon,  1 Dec 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628916; cv=fail; b=lHiH1TrOuJhxuUZs3M72jvLcPCfi7M2UDaG3Llmtdoat3cgzgr9wjgkaFBovEqI88pZqg/iESiCQHomqmXT4nZXljPX+0EDh28+YJ6r/JufiBnKFS+FJKk5xpbh2b+HWJ3J/usCX3x24i/TcsSqgBJBUiV1EMN3Sn1DlVM2giM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628916; c=relaxed/simple;
	bh=Nhwjlqz0QokBOB5Uwfc1p9jiZ4R57uLBd7xFMXF1zwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSZnFFRTEGWKRrCltQ40cITouo5GlwTS6ExIFWUSzytUaSAxvQs7gNHzzd0Mizft3srPgQbh8V2yj6YWUjgEEHoFJibT+7pbaxxyjHKDG9jCBnD/IfJzLrvIjqbQokYZGlVve1BQBn7+UAOSKpr64LbXZKPx/THeTQ5QAxnWKl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cpvPHDex; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWUKibWZ1gLyVBkxtE8dRX71UcXBXhU5jK/xRtYnsVxS8haT2o7lowUWFSKWi/y3gnyciE11LKKtHF+jlfKtYiNdpMrf2CJu6QOzTBHLd3cZn2Q1Bdc/gC7ugS5bNcMz3lpHipwfbPZ2UcDqetBotKtobTz01n35nNUa9yjRb9ZIPpDuDzVcxpPeapD+CIwC8gWkpszm/SGeMyxVCZ5snuTYVD9mlzM/Zef0Mgwzrry19KSXYMqheFPBA6cvEt78949MEdJJgzPPtvnlCdh03J9OezWtT5INFSyMsYB8KrTOyIQs1TYcbaSq2nT2+HpLuYn26PichFaN2zh2+SYGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGhwUranff3L/F5OzMDKVjmK5Fk2fpwh1ss89aXCaiI=;
 b=DoPadfsVE805eZix233mpHm2pwBuxwlIY0RTg16ubOXSCXSJN+LgGS60XRtzKjZyuyHQlRoqGpPo8sprD+B0BS05XEGHTyxbBZMiS5aTnirgQprvgT8TXRLvbRq/MIKvuliWAQN5OatUH6/RSf6d8S5fiRHjE6wZKpcB3HKv/7cK5g+e7HfeQqLG6nvNONkw3gXy1q1dhDIvj6WvHS1QGXjGfQQL+umC/oo5HVUNSUtYr+ZmcyptH7YjSKsDlu4oMj0rqmvOmHWPwrPfIfiWuivz6hGg404zAGZ+zO2YRpLYRsM7BvYejWn4F6fIP35uLsLwh/Fe9XdPeaMY6+ZjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGhwUranff3L/F5OzMDKVjmK5Fk2fpwh1ss89aXCaiI=;
 b=cpvPHDexVt6A15niyiF/6fwq8TcF8WQdEXHcGyOBiQOAqZxyE1iOwyPsSkoKwoqbgqnP3vDJl3JUoVSFbA+wzr+ITe7eMopQDRpIKMNYBfBcg7jOljN54VyQZHnioV+KU4c+G+WGcMIZL6TfF9ZVmFgYv/H3hwCmRAGqITBnbXiKAKiI9AYWgDTLAiJNXzLfRUBdgubjzj2CKn+1dPxfiTgUS5E43Qt66caKEAFcVRxnmUUBxAmJLocudjjLd6uGIKL1zqVhVLsP0B0nsFWuc2EXyv/lY2/5OhceHUZoQ88fO0QeeDnN2baCINox4YnvR/YhGcjK2CxoqqVm87GBpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB10693.eurprd04.prod.outlook.com (2603:10a6:10:588::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:41:50 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:41:50 +0000
Date: Mon, 1 Dec 2025 17:41:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: imx93-blk-ctrl: convert to devm_* only
Message-ID: <aS4ZpyhrJ1IpUCKv@lizhi-Precision-Tower-5810>
References: <20251201-v6-18-topic-imx93-blkctrl-v1-0-b57a72e60105@pengutronix.de>
 <20251201-v6-18-topic-imx93-blkctrl-v1-2-b57a72e60105@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-v6-18-topic-imx93-blkctrl-v1-2-b57a72e60105@pengutronix.de>
X-ClientProxiedBy: PH7PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:510:324::8) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB10693:EE_
X-MS-Office365-Filtering-Correlation-Id: d31d5f82-8839-4f14-37dc-08de312ad136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wjvYhnjoCnugv7sCwfswEXJvKqXHPcYSBLQoPzEMF/zAsBmo3Zby9FmEotiR?=
 =?us-ascii?Q?zXVlEHbTwjv4Tpb7jAEtqr40DG5ErdwxLxOrUtsju/knyHLUDV4NhSxwM1Dx?=
 =?us-ascii?Q?VH08MCoEC5UW8xyA+EMn2fsycpRFi4peKlnZQiggoUFUf9APV/5RiP2O7q+2?=
 =?us-ascii?Q?y9k92MpiwYS4FgsU6TC5LfYQScbE2ko9XSrEWQ+HMZ9mEjwyJG32JjUxd5rr?=
 =?us-ascii?Q?XbwKwZSgFBMnPiEJ+L6hSIqBkPoHXyXXX7xbrvFmViamBy1FGJYBkjFb3lyC?=
 =?us-ascii?Q?06+FMPBeg++iLX073AXN+sjoCOAAKjkLnZbddmaD2okNLctoapSYXPaJWKLs?=
 =?us-ascii?Q?QkkKx2vAY5QcS7NrOsmnoVf/opMRdLBQbq497NQ5fg6AMsTHN46W5c1WyHOV?=
 =?us-ascii?Q?wHXAoOHXEP8MUE8uAjep/zqpfpHs3R+m+OUnWUmufIQEk9I0O02VBvIom4Ku?=
 =?us-ascii?Q?cgkAGfQkP6GG8lcBo7/6ln1scLTeBBxpakmMWOctoA1wZPleTonXIUVccPp3?=
 =?us-ascii?Q?EDqW17SBlfZ4daDGLlYH1BiRf1kklceSEg4Jmns1RWtRNrsVlMbdkpTSgPuz?=
 =?us-ascii?Q?MijfF+hbi5LMDAWc5u6YJJlF+BIVAxJLk0mzaZnEWMebi6T9kHpg91QPYRfN?=
 =?us-ascii?Q?k5gQZhsL8GU1jl4c6Zucqs8fAFKpizxlpJLhdHTdNhO24S13h+ZI0vGjX2nQ?=
 =?us-ascii?Q?S3rXBE5OxgzMxWq8rK3SgFOmSNttdQEPu7UsI7McXTUCTNRdgosYNfQWTJ2G?=
 =?us-ascii?Q?xk9xv0GXq7AE1jrXwMTNHnyVuQdwE1V5rK1K0DuYaJNsUZjcgmh+V8E/7Q7J?=
 =?us-ascii?Q?7LlOn2Elh9T2CxLQGvgzj5ZwJELo+Cp7ogkHAz6rfUTG7nzvKHjJpJHB2x6D?=
 =?us-ascii?Q?kVbICtj7ldPm19SxzalrYjGrHVdsJGddX6LVaLeVipiJrp4pqhX8hNQpVhKL?=
 =?us-ascii?Q?5NTA83VHHRSZpgm7YvhBpHeay9iNGuSGwX1SG4qAzrKKllCUcwcEYKmmCV9j?=
 =?us-ascii?Q?b2IdR9LoaDyQv1sC/phPCCLy7jt9fAXLLQhtbHiw7X73wdxjOiW+R/TJe8Xb?=
 =?us-ascii?Q?0T0uEUUgEf/aQCpUIw+3/Il+sQhlcgyTlHE5uWnBDUgLRudNqctn//vXxFKo?=
 =?us-ascii?Q?/FCPCdElJFZ/JA9BjzjLyrNGrhS3YbtkBloOSdIdmUfITZ7Hy14f2nQYsONT?=
 =?us-ascii?Q?53RzW5A2rCPbRK688MEsmpUjvAW9K5dnS8kmDIKufezGfPCh+nDdSgiQBFTb?=
 =?us-ascii?Q?oObfNEM4NMpNFDyu11JMpPnPIaPcEGjyFoYkei9zifa0nrziVeBYqew+AvGR?=
 =?us-ascii?Q?r3aUvihxQ93GIJVFabVVpGwhXifvIUYNJTZkkoeHQyCMzWMwCqyYzusrDpaD?=
 =?us-ascii?Q?Ci8dyoTzRHWT8jQrkHtjuwFboc/6e/reE+qy9yJFLEw5fFHWS0MpiOud1Lpn?=
 =?us-ascii?Q?DEitT68gkBoC5xh2xlh/w9Y+J3pYe1ImsnqX6VBBD9fvyisV4yAOxU8AKBz5?=
 =?us-ascii?Q?3ubs6rnGQtlmSjZvom1QSfOZ70FBmwGu9Yvb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2mrFxlAc1VK/TCWxdXK9H4O+w1iAGnNuHFGQzUjdH2FVSAOG21GlwyWLQH/9?=
 =?us-ascii?Q?aIeXeoiCEsCl/KuBKCFJbAeMgjRL3amdAE9Gz40zyErKT/w8+vJln8JKbXzw?=
 =?us-ascii?Q?i5c5FeCDqnhOcdpghYUwXaNmD/BydVgZv89AFFPPaPTlcy+NIpRz1KF49ial?=
 =?us-ascii?Q?gPG7BMXX/V1dg2BH+DHKTIOXM5Eg3S5jGd31diMe89D1OevkZkVY1A/NtIfc?=
 =?us-ascii?Q?irneJqAM5TFC2CQoLHKn2uMHRzdP5uf6fWoJK2DgINi+hmjIVhQnkc7zSMAM?=
 =?us-ascii?Q?stLciane35jeuDAXnsJUqCGmZr2d25NuWOHtAjCPeqjUk2Vm6aakmRGt493Y?=
 =?us-ascii?Q?WLUBON1I43+FsLQJSYseeZrBqOxSsKN3x+5T4O/o3xqiUwxoE69lcM+tzSN0?=
 =?us-ascii?Q?3qQPjTKA2NjItPZlqukMSSA/oUoXVot85EqU/PObWPOQBgIwySyDj+QtkGoq?=
 =?us-ascii?Q?JSadwrqk6ILNYee2jQy1SS2+mSLhc7tPwR+yrAaOEZT/tFN+lgtjcJSlfers?=
 =?us-ascii?Q?QHz6H44rIHmYKk4gsyZ80WR8alhEtvb6AsSnJyVb1U4k8bDUzUIn++jq0oov?=
 =?us-ascii?Q?WDfGaQqGnJFo5iX/E2UtMbUTzBiMdPfr9g/8247nUgmoaaRv6gubbYohhOtv?=
 =?us-ascii?Q?3+/ViczDngNzlRJGAlR+++iN4GMnX5XGspYP541aBnmPJ7KYE4bZgRgadDxP?=
 =?us-ascii?Q?NNK/D4Owo07lssSNuwDKRLJ7zxVp5vlyD6uOc4gbd7ykCQIBtt5aWXuJWRmo?=
 =?us-ascii?Q?dws9BNQvckso1E+2K6nQfyXND66OtTdXu2KKfdsJJzwi9Gt+zqpRSot1T81z?=
 =?us-ascii?Q?okHExZeuWBs4YViByieLwccFJJXGfFj3tT16x2RGKn1tOSerihHzHa7Ns3Vj?=
 =?us-ascii?Q?yzMhNbeCkn7yKrC6X5BbBgE5jMm1CYuUNfoDyX0/eFe9+6Z4u0YX5Xkb9HDW?=
 =?us-ascii?Q?5Obq+gIhVgy7fOAy7TMiVpS4vH/GQjd6CT+A1xG4NrUFuSvEiKXFYP3z7ZiI?=
 =?us-ascii?Q?VSVnvEppiy5e9CiFXUdq7nLHJfTIgo/8cukXo20SDNqzh+16Fgb09LGQQ3Ze?=
 =?us-ascii?Q?VUrNrR02ywRKJZ159/WWlEqxi0UgKWuU94ASQCzATpq08Md4JjlaxOm/npxe?=
 =?us-ascii?Q?TNYQzNxQyXRle5VTPvmptQQXLMX+dSXRSmBohtj2wAqCBoQZGvNHDXV5bZQ5?=
 =?us-ascii?Q?ArRqxgG4xS6eH0XoDcUbvkhkfJipuGGxdxK+lLrUH/6yNd9X0O6dhIYcvygx?=
 =?us-ascii?Q?ACe4cphRSxY1Q4ouTN6bLMfUoME3OTRzGWiV+WPARDJkgEMzkDzxneaBEIcE?=
 =?us-ascii?Q?sfaYvWOQ4rc9W8fvO95Rwv11OSl1MFiXxD35yk2xLf/mLwmrYIaUjEsZ9An+?=
 =?us-ascii?Q?HHPnFShUDC2hM3SosuwaUhNI0qpqwffmvkxmgyWmNTTd71FfoiyFWXvimm07?=
 =?us-ascii?Q?O5ykSqqpqiQYdw0Qqr5XTfTq5QNdJeFkzl4qlRVUr/LHsH6xsPQUkhHJ/Blt?=
 =?us-ascii?Q?PKxfb+sdsBnti19NmbtepFQlix48NZVq16ueGXgGfs2ldyfn/VjRPYbMWfhB?=
 =?us-ascii?Q?LfJad6C0huZf4owp5pk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31d5f82-8839-4f14-37dc-08de312ad136
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 22:41:50.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5vSa4HdLlh2PpGcM6NXL+MDfZtE2yXkcITcVOA/lLteP6shjX7mDg/dQxtuOvSN8QxtU9y+rGQyQTUp7sm7HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10693

On Mon, Dec 01, 2025 at 06:12:06PM +0100, Marco Felsch wrote:
> Some APIs used by this driver don't have devm_ helpers yet. Instead of
> using the devm_add_action_or_reset() the current driver is based on hand
> crafted error goto paths and a .remove() callback.
>
> Convert the driver to devm_ APIs only by making use of
> devm_add_action_or_reset() and devm_pm_runtime_enable() to simplify the
> release and error path.

Nit: I think keep this paragaph should be enough.

>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 64 +++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 2aa163aef8de4ee901b9cde76ce2aad246c8c08a..13b0de6dd689cf944e034f7666a4e97b0118e3bd 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -188,6 +188,20 @@ static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>  	return 0;
>  }
>
...
>  static struct lock_class_key blk_ctrl_genpd_lock_class;
>
>  static int imx93_blk_ctrl_probe(struct platform_device *pdev)
> @@ -256,10 +270,8 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  			domain->clks[j].id = data->clk_names[j];
>
>  		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
> -		if (ret) {
> -			dev_err_probe(dev, ret, "failed to get clock\n");
> -			goto cleanup_pds;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to get clock\n");
>
>  		domain->genpd.name = data->name;
>  		domain->genpd.power_on = imx93_blk_ctrl_power_on;
> @@ -267,11 +279,12 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  		domain->bc = bc;
>
>  		ret = pm_genpd_init(&domain->genpd, NULL, true);
> -		if (ret) {
> -			dev_err_probe(dev, ret, "failed to init power domain\n");
> -			goto cleanup_pds;
> -		}
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to init power domain\n");
>
> +		ret = devm_add_action_or_reset(dev, imx93_release_pm_genpd, &domain->genpd);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to add pm_genpd release callback\n");
>  		/*
>  		 * We use runtime PM to trigger power on/off of the upstream GPC
>  		 * domain, as a strict hierarchical parent/child power domain
> @@ -288,39 +301,17 @@ static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>  		bc->onecell_data.domains[i] = &domain->genpd;
>  	}
>
> -	pm_runtime_enable(dev);
> +	devm_pm_runtime_enable(dev);

Need check return value

>
>  	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "failed to add power domain provider\n");
> -		goto cleanup_pds;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add power domain provider\n");
>
> -	dev_set_drvdata(dev, bc);

why remove dev_set_drvdata(dev, bc)

Frank
> +	ret = devm_add_action_or_reset(dev, imx93_release_genpd_provider, dev->of_node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add genpd_provider release callback\n");
>
>  	return 0;
> -
> -cleanup_pds:
> -	for (i--; i >= 0; i--)
> -		pm_genpd_remove(&bc->domains[i].genpd);
> -
> -	return ret;
> -}
> -
> -static void imx93_blk_ctrl_remove(struct platform_device *pdev)
> -{
> -	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
> -	int i;
> -
> -	of_genpd_del_provider(pdev->dev.of_node);
> -
> -	pm_runtime_disable(&pdev->dev);
> -
> -	for (i = 0; i < bc->onecell_data.num_domains; i++) {
> -		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
> -
> -		pm_genpd_remove(&domain->genpd);
> -	}
>  }
>
>  static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
> @@ -455,7 +446,6 @@ MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
>
>  static struct platform_driver imx93_blk_ctrl_driver = {
>  	.probe = imx93_blk_ctrl_probe,
> -	.remove = imx93_blk_ctrl_remove,
>  	.driver = {
>  		.name = "imx93-blk-ctrl",
>  		.of_match_table = imx93_blk_ctrl_of_match,
>
> --
> 2.47.3
>

