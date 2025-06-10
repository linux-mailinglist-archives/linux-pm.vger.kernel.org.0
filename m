Return-Path: <linux-pm+bounces-28415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48DDAD43BB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 22:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA907AB9B9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC845265CA8;
	Tue, 10 Jun 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKMeyR/K"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7167A264F99;
	Tue, 10 Jun 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587314; cv=fail; b=D1+kgmeWtcszF59E70RCqxFUrJCGYmmYDvhMDq8b+pI+b4ZD+Wwg8/Nu5qwm52mL0z81c2yilB7elVy5s+yILXGIYAkYwvEne2tJc1HFAOazc3O2o/5l4+bk4SrKyLuU2HtfmqNi10zx/ZJ0gOYBnDSp3LOYuVNQXVhKPLK6+LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587314; c=relaxed/simple;
	bh=RG0QaP2l26j1pHoX/miYiTNa7qKrOjLtSlS5s2Fk8Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WKHOr9NDHI3fvW71ARmXlm0LRb3/ywLYcXAi5guvuOrhMfgWRIRF9mrVWGQT4SzGUcYbaj9Z8UkyI1hYTrglw4ar0FPLDF3E6qgJHkk00l9Vwn7/o3ubHyZDda5jb9BBprg3Nkofxudvom9ug1Xrs2MCXhLIjLedBtmqzPBGPwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TKMeyR/K; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvKDyTq90sS/wjwmSHiKdx1+YaAOsCxoKybTkZtGrFY1Wt5Qa0ym3tUTRkwRmoZwKL0gYshFpGraR3iue84wAnFHkUFO3z1qfV2gFfvXjdVx/IntnIk41WMjwBQq/QI4lpGJywMwMEzm4zMtKBSNcSozzOasFNFBSad+q21RBiaUITDIXIo5wWp9ng1EcbJPrR5/3fxuJ7MJHjB5MGm/n4Hy/5Vt/sObhUd5qBFSoxZecf/H9umCKuF+MgRDbz2Tyy6dBZmoOqbBaypkecolvYnSmfihg9AW28XJPJOfkP0RZTR40JWThzk5bxVuewTKzWsU/Oi6dia2XQ816DqzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdcKnFAfJgRj7zmQcjxwJRtnmQ7D94/FQizql7yE9q8=;
 b=DNWwBlLHlKy6jnnEvddoKTEPHM768Jb4S5bKkIX68d3yitPtJ3Ke916QsY7rVA7e3woqlQm9jJFefsjrNh4paa+yRByvgmLu5gqaat+AUFE5jX1VEe2REsNg+0YTPGSoN9rdbhK4IJWqGHhxA00DBafrtjAJ6F2lwtZLHQwKhbspyCwabInDR+d5kiD0IbspAAL8+BTnoYLPJSBhNzuNMo4QAkEnX1uh/c1Ls7U1LKQLG62OyeECzgzLgjRa/qFBxXuMYy0S38ZurIR/f+6BOqepkmX1Ah+qmLgatHDEsce/7p8AGfEuCSU/PQUy72t2ITz8h8OIs1sICc1MgONvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdcKnFAfJgRj7zmQcjxwJRtnmQ7D94/FQizql7yE9q8=;
 b=TKMeyR/Kq+nNvkoa0JW49eQSqQJsaVUZERGmuN6/c58a+7GkKkqtmX75u4DG3F1gJO3ijM2oENSTIIqTjyLHh8VKc+QfY8wpjsY9V4AMHY28mbZGm3c/tug3VG9YBHKPGCGbKZ8Mh9QxO7hT7glL7ApXbirXKo/8OU46uRdHqC21MjzB1vh7EfVfm5NY+F6TMeJD9b/ZGPeKNgY7VXXZbLDxu119CNV1irvENgpx3PDSOynXcxOgdFnroyaftDn+zH48JEGhtW7X4WFsigGQpv7MeyJPwuSGuGffpX0O6fnklti882D3i9nzaJkTD61sa4GpN/VQzfTRbb5d0Sk5Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10927.eurprd04.prod.outlook.com (2603:10a6:800:265::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 20:28:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 20:28:29 +0000
Date: Tue, 10 Jun 2025 16:28:20 -0400
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
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Message-ID: <aEiVZBloUxYcNOIP@lizhi-Precision-Tower-5810>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
 <20250610-pf1550-v5-6-ed0d9e3aaac7@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-pf1550-v5-6-ed0d9e3aaac7@savoirfairelinux.com>
X-ClientProxiedBy: PH7PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:510:324::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10927:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2202f7-8ada-4fb8-4086-08dda85d5c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJusIKAPXSbzZOef8ag4HMbNjPjPb0La4OUw526kmV+C+Br2aU6qarbi1tFC?=
 =?us-ascii?Q?sgFBrRvQ7MPuHq7D3fBnk/PGUWhjRZDLDqEcnA7DlZfKl0KLE0WaVu7K+358?=
 =?us-ascii?Q?hsJzeGmZY8AvIGDxc+Vxv0qmi/LCujlwX16eOjq20Ni0IiuaG2PueAaJTzKJ?=
 =?us-ascii?Q?RyaQ7QhWsTCN0C3wQXEZBmUBas38YMMpKsisnW4RIM9iwx1pFrhkEB6gLr+B?=
 =?us-ascii?Q?XylED1qISxrJOiWqs6aAIzJVWFXayu6kvvLk2y3OOYAS2PUtI9cAhSVC4GbS?=
 =?us-ascii?Q?iGiUi0aMQjAVNXR1hwo9bxEgAyV6FwMYBtGD9NMMkmUhRo+WiycJhPx/kyB0?=
 =?us-ascii?Q?SXvtS7UyniBeS/HhJpTEvuqClceJ4bnpbMIw0tN7JS4iNHSbx3+c++NzKEWs?=
 =?us-ascii?Q?JanqD03hlrP2L0Bv8jnZolfWxwVToIoesQfSbL3gqSJ7CFNlck+tvzCaWVtb?=
 =?us-ascii?Q?MQKMSYzU+YvC6YEULYKCjKZJ6vpsh4L/cUt8UlTZ9ecU/EvjH4Td0HgWcss7?=
 =?us-ascii?Q?q+s8xXGDwU1dGQdo1NoLWjjoIcODGov6iHugnQWeOahnF+VtBNgsb/AmMCNF?=
 =?us-ascii?Q?gXcRkPr28X+3/bFA30ytBLHsTVSIxtDfM8NiWCaeN+8gndOeXDCVQJnxUedz?=
 =?us-ascii?Q?GdKReSClRA685JBWOVExbZ+H2Z+Z0RGw7MOznvBjYe9I8rVDLE5bK7bZF6N6?=
 =?us-ascii?Q?Rr3UWVe9S5E+d5ZzTYJAQHV766NWcDwzL4v/L+glQEYsKH7sGvd+15qdfvQy?=
 =?us-ascii?Q?gL5dZDhJhX7hhnYq9bylUX7AuDwxDy94FoZDPSSlrO0uoZL46hBUvJkT9l8M?=
 =?us-ascii?Q?EgBwZ0yMkzeb5r004KlnQvOAuQgKzdNpzTnHR4Lzx/Xv+ejaFA5p6dG4INPu?=
 =?us-ascii?Q?rLP1v2qroE7/UQzed/fTQWv04niADrsZ1JSxV0/DyvC2j4fNSW6c2AInanBr?=
 =?us-ascii?Q?wIGDiE+R1M2qG1cQcNGJ7WFe7z48RMMdGvvlbjsfDJa7jDIHcSyRT6dzB236?=
 =?us-ascii?Q?143OKqgNy0TsPFQMma/dsPRVukaqqW7Bg7rAdkUpsnQ8DoewykPCpDg5EbD1?=
 =?us-ascii?Q?w2s34Kfm2VG3d/kimS/+AWFSj9hLvwK4PKN9phjjedLEPFL8zNKk6oStMmZY?=
 =?us-ascii?Q?ZqDJXXzplE3Z8fljiWXHrTzYVUDnZyNjKBaabxnIdhUzzmhH8ZrkwdDVFCIi?=
 =?us-ascii?Q?TZcRk2lg7yVdQnyJ96hrJrqr+qG7vxyZruuASDR91nvNSmVliJGgMiH6qg7V?=
 =?us-ascii?Q?zqTNSsbyWiiaGhnAbLi2/B2UkstBi2BFpA210bhvAwYheXTT/N/TdG5ZD9EJ?=
 =?us-ascii?Q?4/WVXyiBDa+5PXrLpL4+LBoFCDFDNxhJKEH4fizuItVdI1AQUMgTgvZbyh8C?=
 =?us-ascii?Q?3r3XqWJnxhL5SmpGg91ANG1muta0FZX5X+IODSoAV1myli/ueMZGFLLm7eIC?=
 =?us-ascii?Q?3NWVAd6DF3vK1BK/xQQBXxaMSYvonlZ7uEwl2zJc+tgsao7ESm0jKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y3tZVPdy7NqB8tMbRFAesXkJaKe0y8ZA9B+2Sg9r1nVH1NVNiTJssjiFokhh?=
 =?us-ascii?Q?VRgNcvk1ESHdirqE8qkFn+M4yQ6uwAZsK2E/PpvkLWVkB8snKVx+Bpv0YvAl?=
 =?us-ascii?Q?KwrgFTswsXUdvKBQ2C1cEGDy6P6Rrtbj11v9HvSaY+Etw2uDlOzbeuTPf9sC?=
 =?us-ascii?Q?/NpfYA9YcW2h/UXmRIEZbEcSK/tGTtyvR9KrikhFkPWs5UbKyJuxOZj10TEh?=
 =?us-ascii?Q?lpIu9BmYc77yqhYI34j5vKqLZBkvWnaL33J63n5kiM+ttiuTm41Sh3rO8TTu?=
 =?us-ascii?Q?kb4sONXhK1Con+cd7AVzj49llLAKwDNxKbofKZN9JrzXD37xSuHquHydnANV?=
 =?us-ascii?Q?1gJpzCA/cMHatx+xNZODHvLfRqhdouujdMKSOObthYn/iRWm9W8yOKhsOrl1?=
 =?us-ascii?Q?db4tmBsiMevyQV2/8FucoP0YmniZPlNtaX6CK3v/AZXAKneGT+5JV9xDBPA7?=
 =?us-ascii?Q?Vlrg06BAZepsLYOXjYK6ROPzOUvLTDGqbnKIq/hhcxOq1fondcNP70k1/mL8?=
 =?us-ascii?Q?1bdzB/ebrf3RPFMzgPlgxnCY2D87ITV8277VR+zhmjcyUdDt7IBiLIrZSCRW?=
 =?us-ascii?Q?3GtidfINApWtSPolZjKnhqEEGd2HllNFcdIh+JQ4uGjLaE3p4S2JqeVNSSiz?=
 =?us-ascii?Q?Uck52qZmFsl+kBsqYrXIwSERv9SZOM43HXdjLuvW6sGDzBUia2Sqh5m8RoWU?=
 =?us-ascii?Q?alhnNS07mQ6NlX3bVBkSWT7TXDU6564OxnOi1aXhtm4OaO5VHdqwyr7iisVD?=
 =?us-ascii?Q?urGh2UAkVMNJL0d56RPT0k3Q6U9gZ0GWqc5kyh4+Rvs/zKg3ZMq31uTTfEHi?=
 =?us-ascii?Q?iZTgS0LTKYeswrdwsiTFjLDG+A2FlKBpnpk4hi80iuY1h9KmJp3Z7eFmlT2H?=
 =?us-ascii?Q?I11WALFdH5mkS/2kt347QF7wmrGaRZVubxILo2DW2aksdv7GJK3AyiU3ap0w?=
 =?us-ascii?Q?FUThbQ7N3tyLO4cBg683XMwyqSq+3P+lwzmVHqDpVuaWrBWOHldcf4Xu43JX?=
 =?us-ascii?Q?jFbd/iFysA3TRWxj7BNINM5/vPJfqzJRvEfvzBi4dl5NpNoTUd3Fdce3wcep?=
 =?us-ascii?Q?J80ML4/ecWmv8HYAi23uuMGWP13mvj4GldELmtaEeT7BlR1m3eaEdTK9bUhJ?=
 =?us-ascii?Q?kOd8yyp/fQmFB7Gj89h7QDN144r+VrXxEa6Du6k9MurLgV/NFSYnWU3mSWXP?=
 =?us-ascii?Q?1X4MVGwYK8Fp39HuAL8JLybcQDRu9ZqowfaxIIIHO9xSp3FhlHk1wd7Gutlr?=
 =?us-ascii?Q?T37bxgDMfZx14RfKafFnIIDBSOSGVsa4J5GwFi47zBNFv0/I86VdLB1/28Xt?=
 =?us-ascii?Q?noLDJMPaFLEV/fv1PVKVkk/wc8zYkJYE0N54tC9tZAljg8isLtWSafmOkxt8?=
 =?us-ascii?Q?OIdyk0mgBieR+f6iWHXX09iOY/9krBv7ALXypjjZP3balXI095NWnt9baZw4?=
 =?us-ascii?Q?vkC4vfLhsQxdBqdq0EHs41AIx/rlP0OxpG0TGyps5phY7+944dwmdthxpEUO?=
 =?us-ascii?Q?UjL89NXuopFb0kPBhgOKSXlW5upikCC2VKR9oxapkGVQxc7fhY304StFZ7Jf?=
 =?us-ascii?Q?8TGlg3oSS82pAV8gPriAVszFrfebWyUKOREUncPY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2202f7-8ada-4fb8-4086-08dda85d5c19
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:28:28.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaElo752JQ9pPafiaWWRI8CLt86UA4OmekkNssvz3Fsjc45+VATrYs8cmJLIaYJEnqDhUDOYCzCiIyUULR5ztQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10927

On Tue, Jun 10, 2025 at 03:47:34PM -0400, Samuel Kayode wrote:
> Add MAINTAINERS entry for pf1550 PMIC.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98201e1f4ab5908ff49d32d19275e123cedb4b66..29287ab3c9d00240ecb0ac9793aa908ec75a9bd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17853,6 +17853,16 @@ F:	Documentation/devicetree/bindings/clock/imx*
>  F:	drivers/clk/imx/
>  F:	include/dt-bindings/clock/imx*
>
> +NXP PF1550 PMIC MFD DRIVER
> +M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +S:	Maintained

Can you add mail list imx@lists.linux.dev ?

Frank

> +F:	Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
> +F:	drivers/input/misc/pf1550-onkey.c
> +F:	drivers/mfd/pf1550.c
> +F:	drivers/power/supply/pf1550-charger.c
> +F:	drivers/regulator/pf1550-regulator.c
> +F:	include/linux/mfd/pfd1550.h
> +
>  NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
>
> --
> 2.49.0
>

