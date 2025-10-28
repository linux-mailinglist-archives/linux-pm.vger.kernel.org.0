Return-Path: <linux-pm+bounces-36986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B01C15E19
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196323BD11C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ADE28D8E8;
	Tue, 28 Oct 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hn7lfhIH"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9F2882BB;
	Tue, 28 Oct 2025 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669178; cv=fail; b=FeQG57GlyfCubskqRP7rL0spM91l8UUB9TGgZjsdFAica/60AVLQGf+rVcuGZCc3z/a3Uf0N63c07uOYkrZ8H5mdSpbwyBITj3QW2VJ9MJufkvkz/7aKX/Z0+Zs4BAc1gt9ZGJCcfSJqbOpbMtFnFnTaHcdJd1wxD35Fun4T+pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669178; c=relaxed/simple;
	bh=Qf66vdBjLXrPMLVMPox6V+RlJd02KMl4alDnzWMLRKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVx0TqkkBW/a8SDJLoA68PnhjEeqQwabJRBmiCvQE4X3uZRtreiiZuAAOg4eLwL5y/gR9QJegJWXNHYdNpmXso3grktve/o6kJqpGWK5vY8BiZkpap5qtAogq76v+n/jykeNGrk0Yghipj3zd32RkcO7VmF3BoDysz4Zf0RsZFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hn7lfhIH; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1r8GqiBRCXAKIgvJIm4Rbt26nFYudpawSD+IGNhq1tMo5zddLalE8z/KxuZfS+C+hhtByKFGsiUcXWgbfjoBuvoezk2YpI6plCFpCI6ARmSJVJMoYQCZXaRyYkiBp97MsO0NzbKFLZcLbBKCjJ+CVf7SYjYRs2bGL/T0mQYjlY0tqLrQsuyr45l9UlgwtL4/e5s+FrTXEN2akU1hRRoBKAZv/9YrfZ0x9xyW+O/5KO/m8tfcpOtRJcu6EScTJH5gCtDEFSPm6B4NYuERikiW94kuFD0Qyw5Y1wLVHaSVB3rWeZ/bzbNNj8xh3nmnk00JFqngD3E3jzcvL94dXT4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2bJJYUI0/YxSncNGECviaKnhkPJMlNSDclkVl2LJM0=;
 b=gKCRlRLwYPIPn1XHAjUZgRNGrkmfKAkkqcrbuAe1qJw4ErWMjn7Bl7qb88XmpLoF+TwS6EVQpyS2cvWb82lBAYAPo6B9NmxBN+W4m+jXWYdNMKjve/XDRPA2jAD1tPgJc4otLnVl7/LBUSerHJPkPaQvaVVfwco8+BD+zcEPd6ctwsaznYZR8r43EWDhTlFIBPpd+SWsljmVRu+ErTXgny3bF8yW0RazbqJwrHdQtpLUAsof9bXrXXv81xhaDFQgYxJdo9UDzzQgNhdUEFSO296h3TS9YLczBMCQJwbGdms5B8ncTMRkCkTyWwTewD78tLf+pYnwIAMa+CyR2WjoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2bJJYUI0/YxSncNGECviaKnhkPJMlNSDclkVl2LJM0=;
 b=Hn7lfhIHvWowY88ZH4fvniGCqGwUYJbretbzpSiIAahP1CfINn+iStuTtykvydpd0f8mLKLp+QG+h8B4z8lcMR8UCJ2xP39ETYmpzPR24s5OD66MzMctrQYeR4Wx0jz7OHtNaOf0dPP+cahuRryCtgmnOEMMo553kCSoPFiHyzUVHLtj8HuzFh21qcp7+jAAxEANDi6rZrvfnJkQcgmeZPCUq6RAgK6cw4ckANq9NMPoBat9dbn9wj8TDZ/Ie8fJJOVwFAniiAIheRetY3s71JUPnnW8hpD7BkDEMQ9nbhfjKb1h5Ses9UGqKIGaS37oioLQlEzVDMRPVIkAIQKqOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8928.eurprd04.prod.outlook.com (2603:10a6:102:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 16:32:53 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 16:32:53 +0000
Date: Tue, 28 Oct 2025 12:32:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ye.li@nxp.com, joy.zou@nxp.com
Subject: Re: [PATCH v7 3/3] arm64: dts: imx91: Add thermal-sensor and
 thermal-zone support
Message-ID: <aQDwK5BL3tXp8EjY@lizhi-Precision-Tower-5810>
References: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
 <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>
 <aPi4VqxIF/hltDC5@alb3rt0-ThinkPad-P15-Gen-1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPi4VqxIF/hltDC5@alb3rt0-ThinkPad-P15-Gen-1>
X-ClientProxiedBy: PH7PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:510:324::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b2fff8-20f8-44aa-c40c-08de163fa440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6uL/gch5r1eDAJtSA1FNIGpreeZZaPHNgBLiLYrpdDU6ePm2TKf1u9X89h3q?=
 =?us-ascii?Q?y1WklUqHD+ice4mPEMLfAYEtms3yuR07d1XTL0654jKS1pWo8YkaN1qbhth9?=
 =?us-ascii?Q?3otMPIZZjGB52dae5IC9x6gHwBOxw+e4rfboyQdA+2Kol6wUggdztjsdy54s?=
 =?us-ascii?Q?Z6IJ9o62x6/i7idDeNlVKl0CR4583eD2TYubDGdWAlZNU0Cy3j5eJbBwrLdQ?=
 =?us-ascii?Q?cFk82yK3bekYYdArFbj7OPFze1MGwC0+GjxQloFit52c1DSHGX2f1w0F2zSO?=
 =?us-ascii?Q?s08CMmSvHojdXHAe8r7IcwFxTb1QAWdcsrUDMoNfXDK3rR5tjIId0hcQSwsM?=
 =?us-ascii?Q?hi5a7jf4YN7tn+/vZTDFGM/NubhEagHtrO1oc9a/PkjIaBu6yllOo9Tl5crM?=
 =?us-ascii?Q?RUfndDFdAPEQn8X0iFKOKCi2hb0YcsY2ESFUdhL7EOykj4fuMppePkjXBUMq?=
 =?us-ascii?Q?LuTlMWxsiOXvOQQse2S0NDwK5Gl2wzIRfr0jgoE8LKJpQEw3S6Q2MMW2x2DT?=
 =?us-ascii?Q?Bwu12tX6AgKxmoKXuEqqIwl/qBwM/y2ZItLj2z2roZeAe7vek0o92xA0V48b?=
 =?us-ascii?Q?fJ11MI01YhPdeY8OqGbG0/TDJCP+oO1sds8JMvee4fh/pLBPEngpcI1o1yRB?=
 =?us-ascii?Q?3su9jFLokYoRhU7AvUILuZSKJtFeF8PGqtt2mqUG3GCVwYSCmsiqQnqodNoG?=
 =?us-ascii?Q?W6rNkyQm35uA7Qs7KYZSi6dhI2bOjZR+NTHAclg5yF3lN38u38N4ySlH5qnO?=
 =?us-ascii?Q?t1j5Sjl1UZYSWhG2kCimIU9+DMRpA1o2IunCO2qh8mlP3h7KoJxH2Rpuxn4z?=
 =?us-ascii?Q?FQCE1AxpAJS59BGdY7GEVGsWEwdTbCip4eLXKRnKMDeoBMrXhtTtmszFeVS9?=
 =?us-ascii?Q?EpCxNFjZtGJOH+uKvKXptlt9GsEe2l4mRW8ErCxGQv0H3GhkMyt7x+IU8vTr?=
 =?us-ascii?Q?OV0JK6s5BL5oaYtEz1r6qeMeRVVNwY+5YexUrqq6s9XUWlz/aOjxKrIy99cM?=
 =?us-ascii?Q?Vx3LRzNWMcNnk4aHKwHyjXbaapVQdWczzMSI0NVMpAUcutAf/HU97VT0M52f?=
 =?us-ascii?Q?PV3A1E1RYH4jIEa3OkaDEV3WdybmumJgXdzq3IDaIxt0qkGkUWx92ggmAFzR?=
 =?us-ascii?Q?Eln8cA0GfO1pfz6LbZR4UwW8y0fhdIkuB+0LbJ00tvnwJXt1JyqWYBk6Xap/?=
 =?us-ascii?Q?EBVgAyeeBxhCPGVhQNHjyhZUyToz07lbY81quVum7zcwOxoijoKg2oFo8kL0?=
 =?us-ascii?Q?FaJO5xcdG6RByVPksZOMSxcSuc/dScoKd3MTJLiSOrrT1GiWZExPxQZbQFj1?=
 =?us-ascii?Q?1QNhDU0SZVhqqK0n+Jct5xa4wc8ho4gWNuFYLtS0dlHoF3QG670bYvPOGcKe?=
 =?us-ascii?Q?ESu36GzdAp9zSdjI6C1xb94VxDeSed2PO70UWbq6wRkgVseYkO/gZlHWTOh7?=
 =?us-ascii?Q?DteEU5LrsRhWVK8M0/tQebz7ueErhcXlBmib5zyHTI70+esyyO6cgWo9sD2A?=
 =?us-ascii?Q?o3/rG4VvhNoD0YiG5QJ1VJk7VU//UFv1Lunc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dtLzZwboU2vwXZGA5hqxYlA0kwU/f8Y0fl3O4W0eKgt+pIfzVGhB1WfJk33k?=
 =?us-ascii?Q?+e6Z0jDYcmmHeQa5jwudsJ4l42NQj5s24M04HRMRmxl3xWSOD+qbUz+myrxZ?=
 =?us-ascii?Q?gE6eU6X+Ju1iGQjpZ/vkyajRR5kImm1Xuz/nbBkaVdqltH8QBh6Ie/VosrUV?=
 =?us-ascii?Q?6jkQIoyByD+ySQErqPNXx5JTW7FK5VaFuijVD6LKw8PjtDIFF4AypPFXZvfD?=
 =?us-ascii?Q?mtAfePjfBVOuf398Ez+UFyr6Dnnw+ULMmUtjuavXOhRZlSplkowM9eBMoAkb?=
 =?us-ascii?Q?1KxMJt0afKJEXJ/6bEUY/xlTg9o8UabyzkUKxh/E8pwyYW2RRPtrFSowl8Aa?=
 =?us-ascii?Q?ig5lB7MxxsRUumMuiQT12KBGB2Oq7XwPZ/MLaveYa3Jqd04hdzSj0Q1Dsep+?=
 =?us-ascii?Q?27M1K6xvOHclLtfCF1AWol3g9usya0birg+R9ZNFqahZ7pgTZTBDYjF7TGti?=
 =?us-ascii?Q?0hZgARCD0ItyMwuOdF0R6Uie5D3MhxdL/s+2hcOSWhxiRXGSfZ2x1m7ooeOP?=
 =?us-ascii?Q?mpJKOZQBSrXYVboBjvAFW3nSQTyZxDEGNpUj0PziEH1yXL1hOo//Sb6mkz0J?=
 =?us-ascii?Q?SLRzNylT3Wi/hfnJD6xDNGteGgzfT/d57IMRe+qdKTVP9DTyk8o0n9GeSJ1i?=
 =?us-ascii?Q?QOJN7dVgdwZQ+I9TcvnwJYuK4c5WWTM6p8eedzM90Bp4TOu2P7v4RcppNVQC?=
 =?us-ascii?Q?+O8D6seKHMRkb0jIxNegWZIaSrmIk3/wb9gSic3HLSxTS6fPsQ7IehYrcTB+?=
 =?us-ascii?Q?EYOYNjvBpcB3+vOglyHWWq5C+FJ7Bfrl7zW5Z7kz2wNiGtszfvH+yaeC/DOZ?=
 =?us-ascii?Q?Qgc7Bqf/yg38ICC27Ontvmirva66gcxJHq5D8pycjh6/pB0eS4Q+y7C9sYNc?=
 =?us-ascii?Q?V47dN0Q26RfDsZ97iNqg/UmXxw90/kv8qCi2scQa8Wzn1WfU2uVSABVLdwZA?=
 =?us-ascii?Q?J14JjZE9ozxrLcQe8lDQvGFnBeHBAa0Yf1lSH+ni2Pp82L7QpzdGH99llfS5?=
 =?us-ascii?Q?Uv/jg1USTx8/5v/MTEunFDJ0rySbuW4IBbg9AVMUvFADnYCAOFe2vtSZoZQJ?=
 =?us-ascii?Q?NKu+l5Hmt57E1AI9jdgkfvm+ZwqSORww9Ulcoy57gkE21sPSY877iIAJDEsX?=
 =?us-ascii?Q?K/NBPgjO2mXgVMdj8cFUbJu3mdipqgpvE/ytAI4rKwZuVO1Cf7Y4PwliJI81?=
 =?us-ascii?Q?bC/KmHz5YjTH9HAnaDOlPiIwHzqGMGfJ6IxRSLPvS88e//1se3uxe12RzFwb?=
 =?us-ascii?Q?S81lGe2jFVnR15b6ToW6sn+C3botSVkGqWvVPKKFXOR6jllxexik/YF6UOvn?=
 =?us-ascii?Q?+9iIVPHIh4J1ZP+ysI39AMks2YReY8v52yQh1y9EwX61ho13nNcWSjlCX1M1?=
 =?us-ascii?Q?4OYijyb+kea3irBLxzawht+11Hi2utSQ16Na3+pu0I1sbsUJ9fO2e3iwUs3L?=
 =?us-ascii?Q?ryjRCMw/peo/waMTsC48sCZVPX2iiabLkkC9dqjCuHrdgNInQIgRAWo1mmse?=
 =?us-ascii?Q?9xl3fKE0ffNL1fhCQ5TOq6Dd+92/qGVsEN9ekNd768Wm4LlD3HG/AC3l5C+w?=
 =?us-ascii?Q?i/8dABYCYN6MIBhsYRX8p9bvxfqO3sVQP5Ks6W7z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b2fff8-20f8-44aa-c40c-08de163fa440
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:32:52.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSz/aHpMHQC4lQa6RBAMLeKz4ytrz0JmhpiBMjx0R/Y0i3VEYArbHvkbfVKX5OBdt43FGmEzT2LaNHkTYj56OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8928

On Wed, Oct 22, 2025 at 12:56:22PM +0200, Alberto Merciai wrote:
> On Mon, Oct 20, 2025 at 03:00:42PM -0400, Frank Li wrote:
> > Add thermal-sensor and thermal-zone support.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > changes in v7
> > - new patch
> > ---
> >  arch/arm64/boot/dts/freescale/imx91.dtsi | 58 ++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > index 4d8300b2a7bca33bd0613db9e79d2fba6b40c052..f075592bfc01f1eb94d2a2bd8eea907cc2aed090 100644
> > --- a/arch/arm64/boot/dts/freescale/imx91.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > @@ -6,6 +6,54 @@
> >  #include "imx91-pinfunc.h"
> >  #include "imx91_93_common.dtsi"
> >
> > +/{
> > +	thermal-zones {
> > +		cpu-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <2000>;
> > +			thermal-sensors = <&tmu 0>;
> > +
> > +			trips {
> > +				cpu_alert: cpu-alert {
> > +					temperature = <80000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> > +				cpu_crit: cpu-crit {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +
> > +			cooling-maps {
> > +				map0 {
> > +					trip = <&cpu_alert>;
> > +					cooling-device =
> > +						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +};
>
> Here you define cooling-maps with passive and critical trip points.
>
> I was trying test that by enabling CONFIG_THERMAL_EMULATION and setting
> the emulated temp via
>
> echo 85000 > /sys/class/thermal/thermal_zone0/emul_temp
>
> By checking with mhz (from lmbench Yocto recipe) command I was expecting that the 91 start
> throttling but is not the case, Am I missing something?

CPUfreq driver have not been implemented in upstream kernel. This don't
affect tmu driver, tmu driver focus on read CPU tempature.

Frank

>
> Thanks,
> Alberto

