Return-Path: <linux-pm+bounces-34622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDCB5708E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0FD3A1FD2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5028751D;
	Mon, 15 Sep 2025 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cPk9vtAc"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013064.outbound.protection.outlook.com [52.101.83.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164328750B;
	Mon, 15 Sep 2025 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918580; cv=fail; b=csZyJbFg4/qpGjSb5z4sh9JmFcNDIR6FK0iIyW2bv0FsN4cmVBE2iz8Igjzs9+8haNuqf1A9XeKYJ3cCDfHQ248tbY8LPnDiBdgteLHwtOxcf6H2v1xetD17GU9Rv5aHeOHFOVFeAfFj/pko10DtiC5XXqRKButgjQojqLNwjok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918580; c=relaxed/simple;
	bh=LNtuHeaDfd3b+NWLj5yOpbQNzmCEATTMt1jnKWMnGTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e6INke2n1ZY68sMbMEbZWYK7QEFO43xXJbPP4CsGLO3486bu3LpqVefPOG9wb5OyMKGkpEhmszpvr6/z9yjRRblUHQT5OwDM93LNc3bqAbluvVpC73Fiq44PZWX8wYNyAorBpanp0DoIzUWt20OU+Z8fLAQBX/8auUZKmlUdat4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cPk9vtAc; arc=fail smtp.client-ip=52.101.83.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFXN/ESgpSMWtdFQtcTU2d6jbYr1cQoZP6ed4s/hQhCMy3Lc28NJqJd+424BP4ngfz5IIU2+AQhQE3ikop3sXl/YSR1LZYTD2hAYOl82Pnvh+VoF4sBiDb65EAIufObdbCXbhlSKzot8U1v858o/nobgz+BnI6d5aZ9Ky8px35DeSkceIBDmKNHcmK7EC/pX90pX1YvWswwc0CMwqQhlW4fNlkmwsF+Bhu6mZIBHUEhgUJnPw3kZeKj3K0yy8xDxQjWUsB9eiC7FrhFlMqOyN4jbkSFla29MZeYE/9aWgU/oWZRspl6FC+v9vKBln33GFRhjtN1mZs9n7TBqcsdXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN69o7s5WarO8Bp/yA+cv1u9A7mvayiOInoJ5vZqIyo=;
 b=cVh4W2Olc87JPgVErW3ONGL5H07OAHCWdF1Aoww0E9g7UuLrkuRvzxfbv3V8kMssgmlYEMqgDfQCAeMaP6anuBohczYO4TZHAE0vSXOuIOwvZS5DSAC6G5RoiV3OG66ilzeefkxC/b1Z1mn4YFenO9LD3tHubo7iKa0Cq+43kKwBychpYCxvzMeC9nkRdPw+kFwqUapmMv3c/Zhes4BEv2Zi7YnrGisOY59+ylV2k3sosZo7DPy9x7IQQOOQchIM8ZeZAQUxG8vyvnGZIBQGRo/toDiCeeVmweF5lO3RJrcTamTpULlRfa/HNG/5sM5/Mgi3r0aSUkn0h18kFXZXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN69o7s5WarO8Bp/yA+cv1u9A7mvayiOInoJ5vZqIyo=;
 b=cPk9vtAcvqOTbZDyq25WOi9T6Fqae8BfUdjO1/fU+a33Z7X7WgICtKz8IVq2/zf2MqsQvrsnvXHamm7UL6PcRriMqpzQOSKRbae1oElSIvKyFFVKC/HKvVEKg6dg8EVKkEB62GmDIksNDrRULUflX2VKNEOdak1BPQDwunFMnoeFwcZFM61Ga01LeZbRGsccIqY5RUcP79QjRGmpGslPhwntXT+ODBsM9rMchkbvTWLSNyKFpoSxuRp8/wtyF8DBG+HDcX5isp7+E2Cwc7qR0mDlKDYPwUCR4J+WtwyHQufmoLulRRMoyLytSRRkjwpGwtozRWJIPsuBRbdwOJmC7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8336.eurprd04.prod.outlook.com (2603:10a6:102:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 06:42:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 06:42:53 +0000
Date: Mon, 15 Sep 2025 15:54:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com,
	jh.hsu@mediatek.com
Subject: Re: [PATCH v2 3/4] clk: mediatek: Add clock drivers for MT8189 SoC
Message-ID: <20250915075425.GE8224@nxa18884-linux.ap.freescale.net>
References: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
 <20250912120508.3180067-4-irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912120508.3180067-4-irving-ch.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 80bcb32c-ef6f-4649-0a79-08ddf42318b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sdHaelyZqgaAg+XiO124BDsM5j5/FoJKcd0KUtCg3tGTkqU+/XAfFnfI5w8e?=
 =?us-ascii?Q?Rm9YssxEZSMmG5Eb6880MTXlfAJtTKzghctkGhpHPZkP0uwkb+B967QNk1q5?=
 =?us-ascii?Q?+PTU6Eft1UuaD5vWGU7joYIkPQQ9EFxm9ivOEso1azkyGP0Yzh6QSNAA2pR+?=
 =?us-ascii?Q?ONxQsMTCDkqk/+TcY6bxgEWkxZg5AJsx+vI+TyW4mRAdq/rr7mOcDcvr4IYT?=
 =?us-ascii?Q?32qSGmqjcAAhh5hVFm4U1uQLlqnDOiGUWbFipSQ5W55liMTK1KZYaosdbliK?=
 =?us-ascii?Q?QAZZ/a84H58k3bj7fEXD4W/U3s/3YKhM7y0kYrfuoyu15/hGBTKjBy0uIUg9?=
 =?us-ascii?Q?4zunYjYoVKSxN5erc6Y3KYqf4l+slPMlVNdYkijvmKdlCeWLjjymKE89v40h?=
 =?us-ascii?Q?aODyuoeY9mPrh2dbU7uxrnBr96tqXOr/rZ5pzwXsZs/Yv7y8agXol2Kq0q1/?=
 =?us-ascii?Q?mMHIQ7K8qCfW5tTJ4V5neXUEDpzfR4JyLj4gIp7CjowzaHZ6HqiujKU6SUYu?=
 =?us-ascii?Q?+DcGx90sy3rfuUfxZGldnUcKjtgtQtu8Hl4XM8WNtnzNqStOojC1G561QlOF?=
 =?us-ascii?Q?m++87ZsNq89Mzf/hA6XVZQRhkJf5odr5Rljw7uDfX0RC3BzxMxdaimEKBVBb?=
 =?us-ascii?Q?Ggk8+ZmhlLRGo+mPC0QL8iS/deHUzrDDjmubgTukmONp5x6Oz0xGw//gs8qb?=
 =?us-ascii?Q?f/GE6h/z/Jpg8BCn/REruK5M7hoeW253+ZJN0pVTsm9ISZ/uaZCf+asepbAU?=
 =?us-ascii?Q?MMDisJ8F8kqr7wlqeOm/RMEKlgJDgdXiP8oK+nI29MTaTnTnG7dYn6zAXXx9?=
 =?us-ascii?Q?fUSGy8IqvfuJmHXpg68+HsRUa34QWExgnIxgW4W/9vNiixjjuLDN8BWh6I0Q?=
 =?us-ascii?Q?qyJG1bIwkcpB5cL6u1PU9nBPb3xu76vsciy1PNMRgHn3teMHqboW/xtJnOiK?=
 =?us-ascii?Q?EwXMj9sI4YZnjcjJomJWTiKKpfzY3N/RllFt3eYr9FWpglljorObQbc4zbiF?=
 =?us-ascii?Q?ui7RcWtQQAOVpS9BXggjIortCPa7JE3MQKsHye+8HlIymWSoyzbqBDTzaYM5?=
 =?us-ascii?Q?Atv15MhyA36+kvreDMVFfWV/aiGL4/b+fCUtHIZXq9uUxZIh7rwN59WJ6bo3?=
 =?us-ascii?Q?oDoN+dEHjEx2SW3tXaEJZbNqlxpRbuj2zGUNau0jjpOawo5p9P4u3Tv7OBKe?=
 =?us-ascii?Q?0ytCNztRuy2VdyjthSfR2w4V55J9POEViRAtRP00yuQiYSQeT+P/Vame7Zwm?=
 =?us-ascii?Q?/H9Bhj1NKmtkfqyCixiCVQbibyP3QbVH0dzUSma9WUfjUe7bevmGtE3JCx7F?=
 =?us-ascii?Q?Ahg6dC0w8FSqDzBstONFprHGf/63awlcWkO9j4iLiNDCygxIF+s1qWSUa6aN?=
 =?us-ascii?Q?zIjV+5QzRgoZ8AckvUrC68JNckzURwsqVQ9UtwD8lih+kWJi1xLpZFRwKThm?=
 =?us-ascii?Q?CVCzLVGneqwAmJd567fiTptqqoJtGyWr4BGlq+41bo0ThARN9bArMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gKU4mmk+wc16VCWGqab5unufGe3yL27hsfQFVpkejTUGBSgIzVYHZHn+xhb?=
 =?us-ascii?Q?d5Vn/AaalrBM3V84FXiqrhtxMYpPJ+q1IZP/Dat20JDxLfQ+z+2/4DD7nSXd?=
 =?us-ascii?Q?F+/jTD9WB/YnM2QGh43M7zdo8AEamBEAp0kIxZuVHVY2fa76BJI1pKXWF51h?=
 =?us-ascii?Q?JAWnQdt65Ep6F3qoAj0VWPg7y4MUVoTJkaY7qpxba/zjur3C7APtd5JXKH+I?=
 =?us-ascii?Q?tLB01tlL5KoyQAuWAIn56vwFH3Qf6BmvP/a/6sIePMm4Ni70wVS3DfprAn6+?=
 =?us-ascii?Q?NftfoJ1lpmHVJtbmR1rRdhsbmP+PGUV1YIBGA/Jih53oeCE7493p2zD3c3zh?=
 =?us-ascii?Q?ngRtYXIEki/cMRIW7x44vm8jfudhw6j3WyMF4tewIThphQ0n+YbQzXELD20t?=
 =?us-ascii?Q?T696RnreEquteB9XoNNioW+tbkAyV/kkRlrdKkCROxWOcttbii4BUjDEzPS8?=
 =?us-ascii?Q?X5a4jsXw0xGhlpnLupTNxVrqxhmjHtmepr2Bx0MflkpCXAwXf/kHuSi7VtLf?=
 =?us-ascii?Q?/0B6dRS6oz4Zyp7ywSLO/kj7xBcQMPoZ7ldoThg0AfjqLJT+Xpz0Ktsogp27?=
 =?us-ascii?Q?q3qjR9Ta1+yPX5sh+cBA5XU59YArZ8Wusg9RNPcm4HJVruahZV5mq37CaJsj?=
 =?us-ascii?Q?mJSg+WK1pMdg+yYEancwUbKXdp+o/gW6iJtK+6wNjkfRu0YEToBBwsSpQXtT?=
 =?us-ascii?Q?lgeErbCXPn6yMOyvgvsrM76BGdCR/TG0fNJl8pKvKE8zkyfdoHgKUqpCSA5c?=
 =?us-ascii?Q?iTSZE9d7Gc/HBy5cVvRyTE7vrbHhtZs8eh7yvzE75CPbPBExjL3Vy9NhRWcs?=
 =?us-ascii?Q?xy0SS6QZtFoLtv41srxrzsK7+5h360t5G5OaXuhE+Rjjuma8ldBxy4CBmdK4?=
 =?us-ascii?Q?vD1mxoPNqWHoFNStb2YmwGe271G6AAuaohYOU0NNVXqx9zGKduQcSX21Are6?=
 =?us-ascii?Q?DVvbVGGJ/PuCp011hjaUAgav/dep9T3OxxMDMcd+rmLCjUHo1Ry+kfPYxHch?=
 =?us-ascii?Q?Uogfo4d09mOiwmKuFylV58QO8Wvth8+1k8u6/X4j74vwUxHGkWClQaHm6tNX?=
 =?us-ascii?Q?c+mnYW0n+0Pr5oo4PoErhQkCLMRf2arc3FwWqKpIqv7QQWuP76GI88z3aWKO?=
 =?us-ascii?Q?EocH1izPNl8GfKJ47iSqZaxQGYhgfusHmp0+WcVSuSWLKiyyWObf/p1uDxF0?=
 =?us-ascii?Q?IwXniS6iaKLXx/zDJEp+Yn7QIKVzUImXRj93VTj0H5Qq2jAzwi1qGS0XDZtf?=
 =?us-ascii?Q?sHNPtOf0NUxABxwKNAyGfOcnZQ7OTr2MNKDTv2AuZJ3QnkBZJ4Jl5Nq2ShBj?=
 =?us-ascii?Q?thd0lfrQNQRhyjK3O0eN1EcHXoV5lhmRc6k5zbqtn8J/wIBVjfOSE9Z/PQ0h?=
 =?us-ascii?Q?6kcsNgPqjqjcYMbDkHVnhQE49cB3HNXWSRyDiRpxVrf/D4lv9GZfYnh+6T2U?=
 =?us-ascii?Q?8CEGoxxecLuo8PppsK74oN3Ge4FL7zPGG108B0cJ3kAbFfpoBekVkTG1ySus?=
 =?us-ascii?Q?huUpf5X9YD90zqPD+MBSHOg8JEkP79Bkp199rP9piTbaPxwfQgztRO9nmyAL?=
 =?us-ascii?Q?HFVX3/rnJ3aPatn0VxeRXBw/TBLnGta412ucI/V2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bcb32c-ef6f-4649-0a79-08ddf42318b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 06:42:53.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V38+21aEqqdR51TNHFJM75U6jVzvPrvwWHkbrG7lzGrk6WZCqMzxPdid5of33G3LpoKmMUZCEaRcxXT5Xjf6fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8336

Hi Irving-ch,

On Fri, Sep 12, 2025 at 08:04:52PM +0800, irving.ch.lin wrote:
>From: Irving-ch Lin <irving-ch.lin@mediatek.com>
>
>Introduce a new clock (clk) driver port for the MediaTek
>MT8189 SoC. The driver is newly implemented based on the hardware
>layout and register settings of the MT8189 chip, enabling correct clk
>management and operation for various modules.
>
>With clock topology, we need to register clock sequence below:
>apmixedsys(pll) -> topckgen(div/mux) -> others(cgs)
>
>Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
>---
> drivers/clk/mediatek/Kconfig                 |  146 +++
> drivers/clk/mediatek/Makefile                |   14 +
> drivers/clk/mediatek/clk-mt8189-apmixedsys.c |  135 +++
> drivers/clk/mediatek/clk-mt8189-bus.c        |  289 +++++
> drivers/clk/mediatek/clk-mt8189-cam.c        |  131 +++
> drivers/clk/mediatek/clk-mt8189-dbgao.c      |  115 ++
> drivers/clk/mediatek/clk-mt8189-dvfsrc.c     |   61 +
> drivers/clk/mediatek/clk-mt8189-iic.c        |  149 +++
> drivers/clk/mediatek/clk-mt8189-img.c        |  122 ++
> drivers/clk/mediatek/clk-mt8189-mdpsys.c     |  100 ++
> drivers/clk/mediatek/clk-mt8189-mfg.c        |   56 +
> drivers/clk/mediatek/clk-mt8189-mmsys.c      |  233 ++++
> drivers/clk/mediatek/clk-mt8189-scp.c        |   92 ++
> drivers/clk/mediatek/clk-mt8189-topckgen.c   | 1057 ++++++++++++++++++
> drivers/clk/mediatek/clk-mt8189-ufs.c        |  106 ++
> drivers/clk/mediatek/clk-mt8189-vcodec.c     |  119 ++
> drivers/clk/mediatek/clk-mt8189-vlpcfg.c     |  145 +++
> drivers/clk/mediatek/clk-mt8189-vlpckgen.c   |  280 +++++
> drivers/clk/mediatek/clk-mux.c               |    4 +
> 19 files changed, 3354 insertions(+)

This is too much changes in a single patch. Prefer to separate
into small patches in next version, otherwise it is hard to review.

Regards
Peng

