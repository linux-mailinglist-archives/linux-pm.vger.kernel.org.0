Return-Path: <linux-pm+bounces-27440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712EDABEA23
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 05:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E734E0957
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8F6221568;
	Wed, 21 May 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dmZavJC0"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EA1C6FE4;
	Wed, 21 May 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747796626; cv=fail; b=GUetqGtjSqdquEx4w2s94Y7uraUppTAH9j69fW6Ooz3yTbYQeye96Be8eZ3XSUmusVLpppW84uGvsKtceV5WsGdn9mU+eCNbxZ8x0PCA+9KyzsbPEQo2fJXTF7nhY7l3SBbUshdhmR/R1nuBCXPgkyiOTguJVHsCfOig/Oh5PvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747796626; c=relaxed/simple;
	bh=+OhDJTeDyAbgJV5vXmzYVtVi/QyA7fMocftNe9NXCIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgvlKdPVddI2WjwPuuRtQ0jA1BjQLPH6brVz+YCulNmLMgoGAGSQYQu7VSNMXspAdeslZnagv6PeONfTrOG3R5BYY0M7w3GSMcH92hF2qYhZJrpiU5AH1bVVsz4ghc+LLuIpBuTzRul0vWXn1g6EFkHxY2MIQK68KpcGZgChpO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dmZavJC0; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ6junM8j8/2/3yg7Muf5zBOh7pb3sSGhXXuQ3qCbRR1DBs14r0xEbtdcFhGFAifwdMULkmLizTrbVRgfZyrmsJ9s+gd3CbUaTa+ZHgrJgx3ttJUERYVb1aF+7aZas2Pkjw8XTfUdU9gvKdC0ESXCYDu4FS6VVk+SSxrBYoe+maVanlC4lkBsFx1DTPOn3iKwCU8soM3ZZvKIEQU1cGzMeconbtFe0ax2MYulp2K6k6WLqURtOvLLz3ivRV0MbiCu2B1UYLEczkJREtVimiIfx55GbPJuSVrVNPzIH8QjGwUIDzwTK/9s80ilYNtlDTjKEGbOwCSMUndf6Mp5VtrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkgQGUKqQkdyZWKRDiEHvdIuYEGBEcWmrS11MJyM6bU=;
 b=Gqu9yM0Tudmj5GnAPc/5RdjWoTE3lydlGhCMVSVnk9lfNTnmnbbNvgAbjx5wIA+hvLaHKbcp4HV9SnN0Pvd++8eIr0ejhK3C1VWrJflUj7mny2DpkaXp+qHgnwjeIAWSapqNyYfi5pMnQniNWsnNzA3QaOkp4FKsfvtUqSOdCMY7D83RqdRCxf6RSrbDQzTUK/nkz1S0kmpuam72WX+LJu6wcDKSXW9VJ7Z/hqAHDDzmkPdajASF2g9BjvqmLeuk8DnvZs9masetngIr9fQ1A+Wa4eveK7cM71K5gDz/XbPN48QpOGNby4i/uWMLXxLoZglKZEIWzzTciTgI6ol8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkgQGUKqQkdyZWKRDiEHvdIuYEGBEcWmrS11MJyM6bU=;
 b=dmZavJC03o3Aoivkpgq+lFZRrZhksX/IFHlJdY0UMLeSAdIOiEh0Ce/brht1seMPKR9466K/6GE1g0Yc/1TLVfpHmthHlVyvN2Ncnom6nPwE1C4/fbQdSazePQgppnLxMfWhScTy4l4cSNp3WScghcXAfe35hlHh6gWnTdGbb4rWodLtBincMjt68TRsyp6h5/4oF1ExbU9EEFypAn4OigOm7Ua3h0toVVlVJNbc8u/UmsUsNKpHWeBY/m9ZOLWQzRNCJZAFqAxBgO2EwRdjZaHm7jsSa6CU/BQvuNozmlaIEzJdRjtCyU9m6oL3esqG3xZm6DfBBJjnfr2YXJI6ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 03:03:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 03:03:39 +0000
Date: Wed, 21 May 2025 12:13:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hiago De Franco <hiagofranco@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Message-ID: <20250521041306.GA28017@nxa18884-linux>
References: <20250507160056.11876-1-hiagofranco@gmail.com>
 <20250507160056.11876-4-hiagofranco@gmail.com>
 <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
 <20250508202826.33bke6atcvqdkfa4@hiago-nb>
 <CAPDyKFr3yF=yYZ=Xo5FicvSbDPOTx7+fMwc8dMCLYKPBMEtCKA@mail.gmail.com>
 <20250509191308.6i3ydftzork3sv5c@hiago-nb>
 <CAPDyKFpnLzk5YR3piksGhdB8ZoGNCzmweBTxm_rDX5=vjLFxqQ@mail.gmail.com>
 <20250519172357.vfnwehrbkk24vkge@hiago-nb>
 <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7da0f3-582f-4333-7157-08dd9814153a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhyG9q0uFrNQNyYs9o9dczwpWq7f+pApdR2kLsDv/J/CM89oe+igzp1chtgi?=
 =?us-ascii?Q?sCUXEYUxQjw8IKMOoi1Nk1P5Xv3K3radOsArZ4EsELWLigy//UbtC5XPFeVf?=
 =?us-ascii?Q?Rh9Yavj9sMnaaPTzoNk7zAhnyMjf9zLeIyJuaQ3ovXYxGhUki5BJaI4YrAo+?=
 =?us-ascii?Q?zvewUthQ2zaHB0BKZZ0mpdSWFj+nXSBTBzXl3sPLdAq53//guC2++kPSxGcR?=
 =?us-ascii?Q?jLuxeyRmP7RnUgox/ZQ+itUViql+PMGEKgienz7J+gMM5ZAKelslmTZwFsdc?=
 =?us-ascii?Q?ouB19CIvOtezy0eoawIBhw1qDCpOu0ug+Nob7URqSTftugomAICbWedx4HEi?=
 =?us-ascii?Q?uwxmEbckKX3pOHchOv3sHFXMofuYBIP+r3xxUXhaREL/lWZM2kpGfuu8/Bt1?=
 =?us-ascii?Q?QlZLB6Ejn53ygdMMSRnGUT+Xmghp7YhvYWmYhnFucoMMAdys0L4+Sw/n17Tx?=
 =?us-ascii?Q?CFJ7Ra/cOyke5RSH/H6OS2v0ABPxMyaP8Nk7/iXjGalmGOG2kATNuq4LOQVE?=
 =?us-ascii?Q?4bnTGEK1/+OUiyLYKXZMfIA47Mu5r8TSP15n5N38QHYU6650TTkLZf2HTg5C?=
 =?us-ascii?Q?vbbWGDN7MnJ49kH7T7/4jXfGFZMNp87zrT5N4SiJdyk7BLNW/4bi29Wh9z0S?=
 =?us-ascii?Q?nIGdj0z/KW6YkDpZ3G2R5X4gtpV+82d9CBeOxOF/v1NCpWED4M7lJ3/DU+Rq?=
 =?us-ascii?Q?m2XAF6F5Lnjy24mpsx45IXmnwXcYTkLYKW5Jf71L+wdGetS2gjjaa3qNMtKX?=
 =?us-ascii?Q?Y/hWNGWogQPlrcY0hvSaiKZ1o+rvzePo0xz9Gf6rA/9B0nujW07mrhSe6WAy?=
 =?us-ascii?Q?Cq5M8y7u1qg48Xlo2n8ddizwpcsnQXpkkp525QWo+BhTjhmTC/yRokI+Bfc1?=
 =?us-ascii?Q?PIgmC8oScoEBKvbRZ3NsT266zFd+HdwADlPoVQlO9KXS0tuTkGrzGODZR5Lp?=
 =?us-ascii?Q?P+bNxliqEb2/ezdFahzdHcHOA0OBDnugja5gGX0so+L+pUkRKhWaUwf3CACe?=
 =?us-ascii?Q?g+FCAnrTZSizHQe2GMYFfi8JI72kPf4MWQbFN4ed6/D71PANGnKHH6vbOUy3?=
 =?us-ascii?Q?npVgYRLQGrkn2Nb4Mc2bPznX8PcDIBGlDg283LOnL2n83fISrb2AIyr3wy+3?=
 =?us-ascii?Q?8TfEzrPhvV/UFOLiwH9UbrYx0DZYY4QC0YPy0hQihNdnfhbxkqa+fCWviXyJ?=
 =?us-ascii?Q?qopE4T+5RYGYahJdYywAKsG1TldHPyfBHsh7Rvc0SjE7lPbGgAncilNYgWy3?=
 =?us-ascii?Q?nc/a1/RAyfkKnR68NebEe7R5cQKzmmhD0gD98ZNwTXChQF5Ns8jZYAnl1cAk?=
 =?us-ascii?Q?vYg7HFjAjYcGkCw2p3dFxiZkTy9XQjftnSmPAtEBfLoBq9hwt+p6ESoEApXO?=
 =?us-ascii?Q?0oJeSZP3HdZH88p71jLtEsOEf9shrNSX9fv77DuUllXzQ8fsEykQfbbrfW9y?=
 =?us-ascii?Q?hToHlXZVFto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z5JK8qcPORkaqgJNGbSgntoScspopEPjo6xEqEvOe7NoRBdq5HTGXTMF977E?=
 =?us-ascii?Q?HWLuM784KpaymPw1f+mHKHKmjEHIVnPK1n0WdzHLi2aaxw6ITtoB5WwJ6Urd?=
 =?us-ascii?Q?WIIxlbi2oRABVveNOkItaap2IQcR38xgSODUkgn56gc/lS6eZtp0BCIL2G7v?=
 =?us-ascii?Q?1EO0HFpCuDhlXLwotSje4X3OcSoSHd/LQt8wvTnucnGSCf1qVaHHrkEqakKM?=
 =?us-ascii?Q?zSK99cL9NQEVc07zIHnQ4WxX+ePes4ulEhUtgiW81WBoDFuarBqlPP5je/OT?=
 =?us-ascii?Q?uZNVZXn9icTU02PbhX+cfQT3VHgA4VeCoFRXxoVb5RaXgLDbXcLboOI6TUiR?=
 =?us-ascii?Q?LjvPylU+qUE9fCjX1yv8HMstCC08LPO/zOVkwyu21kpYcTRt1XvrUlY4srb5?=
 =?us-ascii?Q?ARXh9DHYrGcQYOGpKdqWKTYtYrRacxRC3imydRfwIn/hZ2gl9gWY1RaLtjKD?=
 =?us-ascii?Q?geH1PZb0xF2YjDhDxbX8O3P2CX4BecS6QAr9Hf3/X8q0UwHW5NOUmG1baJDG?=
 =?us-ascii?Q?JBzJUEyhEU7xyIWNUs4r87Q4Rn2F8JKssr1+G3us6fb9c0KBKtwAJLVg1iyI?=
 =?us-ascii?Q?2bz1nDO0sechrHnfe3GZb2j1lF5yGIwNvA7pCoGC41YdU64I+kC34vBXzt19?=
 =?us-ascii?Q?TkF6aixVj3NaHwv+v8d0gde2JDBYMBDVjq11gn+OZ9wzRueIcMRieOFI7Xca?=
 =?us-ascii?Q?SVnrYvIWR9R4jN7G3o8dnC9zqj++SrZI6P7zhYro81H3YB/13wS73MxxiuJX?=
 =?us-ascii?Q?vVpPzu9xWtIVKzaxMIjwvQyZ+ioPirVr3GaBWDzbrpCiC8pzMDIBwEYGZZak?=
 =?us-ascii?Q?cd61bJ+EoeJ2YnDCegS/36+Hsh2CwutAAaV8eU9wYBqIlKAF6aAAC5LH+wdY?=
 =?us-ascii?Q?i3YX5oKbYri25CHgsBmYMaF8u9XG8Jr8RBN443um0G7e+pLeK86FFgeaCznA?=
 =?us-ascii?Q?JDN+NIOu+r3pGdU2FJU7f5C5ypsBKkR4pCBm8dmeevdUUM3ZMoIh9lUpdv/L?=
 =?us-ascii?Q?qObSc8f5OdiEHVjsu1hWgeDv/zJm1LF7zBse+of1dydpK3gG5HvSmhGx2iv/?=
 =?us-ascii?Q?jxs2c0pcG2g84JN7NiE2G4uAOKrzEDYYkaG1ADlqQVy5UnorlJvZCjWDJP5j?=
 =?us-ascii?Q?t22CFJKQCSkGhp+cRecqicmFbzoIhhSu+S1xPUp/Rv+yCjiYWiG8ykJ1BGxi?=
 =?us-ascii?Q?gd5hQy6aExnN2DkZA+ULu0t9rEFAwyrmAbQ7E8SPWx9ZXtBnLuDjb4py3DQQ?=
 =?us-ascii?Q?Jowa4etHu24aJlXyoI6uQnNBMgJ3iRUnuspa+YMbYl/MoigFmZ85L7HfKbUV?=
 =?us-ascii?Q?aPMFJimoLqOslazfjSc8rRzRQVXZ8C2qs4Kpu0CM1JCNrH9TkItWfxgqqNmg?=
 =?us-ascii?Q?fj3iv8I5TqmV92fhdm82eAnviwHIAdIHuG828vUtUIVV9HzZZT0DVOxIdpLh?=
 =?us-ascii?Q?qJmci1Z1xLsINxlkkkeLCoCmeuuBgKemRYb9Dxm1dGyNhPqemnD79PCA72Lm?=
 =?us-ascii?Q?aFiOmxW6Za5DDu9K1BjIELI0oGh4AVIvS6aXKB8lmKhhpD09AmaeEpRV/wdo?=
 =?us-ascii?Q?YvIMAQUiFGzkyBMxW7rC7gLsdjQkkGp8yIze19lg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7da0f3-582f-4333-7157-08dd9814153a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 03:03:39.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UajQfNcaaJS3e7Ew4dgLWlwevrXVfSJc3KqpqpviATtGh5kNmMxQ0uaGM4zrNfwrZ2W9pEPJ5T4LEhMWauvQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379

Hi Ulf,

On Tue, May 20, 2025 at 02:21:49PM +0200, Ulf Hansson wrote:
>On Mon, 19 May 2025 at 19:24, Hiago De Franco <hiagofranco@gmail.com> wrote:
>>
>> Hi Ulf,
>>
>> On Mon, May 19, 2025 at 04:33:30PM +0200, Ulf Hansson wrote:
>> > On Fri, 9 May 2025 at 21:13, Hiago De Franco <hiagofranco@gmail.com> wrote:
>> > >
>> > > On Fri, May 09, 2025 at 12:37:02PM +0200, Ulf Hansson wrote:
>> > > > On Thu, 8 May 2025 at 22:28, Hiago De Franco <hiagofranco@gmail.com> wrote:
>> > > > >
>> > > > > Hello,
>> > > > >
>> > > > > On Thu, May 08, 2025 at 12:03:33PM +0200, Ulf Hansson wrote:
>> > > > > > On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
>> > > > > > >
>> > > > > > > From: Hiago De Franco <hiago.franco@toradex.com>
>> > > > > > >
>> > > > > > > When the remote core is started before Linux boots (e.g., by the
>> > > > > > > bootloader), the driver currently is not able to attach because it only
>> > > > > > > checks for cores running in different partitions. If the core was kicked
>> > > > > > > by the bootloader, it is in the same partition as Linux and it is
>> > > > > > > already up and running.
>> > > > > > >
>> > > > > > > This adds power mode verification through the SCU interface, enabling
>> > > > > > > the driver to detect when the remote core is already running and
>> > > > > > > properly attach to it.
>> > > > > > >
>> > > > > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
>> > > > > > > Suggested-by: Peng Fan <peng.fan@nxp.com>
>> > > > > > > ---
>> > > > > > > v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
>> > > > > > > suggested.
>> > > > > > > ---
>> > > > > > >  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
>> > > > > > >  1 file changed, 13 insertions(+)
>> > > > > > >
>> > > > > > > diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
>> > > > > > > index 627e57a88db2..9b6e9e41b7fc 100644
>> > > > > > > --- a/drivers/remoteproc/imx_rproc.c
>> > > > > > > +++ b/drivers/remoteproc/imx_rproc.c
>> > > > > > > @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>> > > > > > >                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
>> > > > > > >                                 return -EINVAL;
>> > > > > > >
>> > > > > > > +                       /*
>> > > > > > > +                        * If remote core is already running (e.g. kicked by
>> > > > > > > +                        * the bootloader), attach to it.
>> > > > > > > +                        */
>> > > > > > > +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
>> > > > > > > +                                                               priv->rsrc_id);
>> > > > > > > +                       if (ret < 0)
>> > > > > > > +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
>> > > > > > > +                                       priv->rsrc_id, ret);
>> > > > > > > +
>> > > > > > > +                       if (ret == IMX_SC_PM_PW_MODE_ON)
>> > > > > > > +                               priv->rproc->state = RPROC_DETACHED;
>> > > > > > > +
>> > > > > > >                         return imx_rproc_attach_pd(priv);
>> > > > > >
>> > > > > > Why is it important to potentially set "priv->rproc->state =
>> > > > > > RPROC_DETACHED" before calling imx_rproc_attach_pd()?
>> > > > > >
>> > > > > > Would it be possible to do it the other way around? First calling
>> > > > > > imx_rproc_attach_pd() then get the power-mode to know if
>> > > > > > RPROC_DETACHED should be set or not?
>> > > > > >
>> > > > > > The main reason why I ask, is because of how we handle the single PM
>> > > > > > domain case. In that case, the PM domain has already been attached
>> > > > > > (and powered-on) before we reach this point.
>> > > > >
>> > > > > I am not sure if I understood correcly, let me know if I missed
>> > > > > something. From my understanding in this case it does not matter, since
>> > > > > the RPROC_DETACHED will only be a flag to trigger the attach callback
>> > > > > from rproc_validate(), when rproc_add() is called inside
>> > > > > remoteproc_core.c.
>> > > >
>> > > > Okay, I see.
>> > > >
>> > > > To me, it sounds like we should introduce a new genpd helper function
>> > > > instead. Something along the lines of this (drivers/pmdomain/core.c)
>> > > >
>> > > > bool dev_pm_genpd_is_on(struct device *dev)
>> > > > {
>> > > >         struct generic_pm_domain *genpd;
>> > > >         bool is_on;
>> > > >
>> > > >         genpd = dev_to_genpd_safe(dev);
>> > > >         if (!genpd)
>> > > >                 return false;
>> > > >
>> > > >         genpd_lock(genpd);
>> > > >         is_on = genpd_status_on(genpd);
>> > > >         genpd_unlock(genpd);
>> > > >
>> > > >         return is_on;
>> > > > }
>> > > >
>> > > > After imx_rproc_attach_pd() has run, we have the devices that
>> > > > correspond to the genpd(s). Those can then be passed as in-parameters
>> > > > to the above function to get the power-state of their PM domains
>> > > > (genpds). Based on that, we can decide if priv->rproc->state should be
>> > > > to RPROC_DETACHED or not. Right?
>> > >
>> > > Got your idea, I think it should work yes, I am not so sure how. From
>> > > what I can see these power domains are managed by
>> > > drivers/pmdomain/imx/scu-pd.c and by enabling the debug messages I can
>> > > see the power mode is correct when the remote core is powered on:
>> > >
>> > > [    0.317369] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_ON
>> > >
>> > > and powered off:
>> > >
>> > > [    0.314953] imx-scu-pd system-controller:power-controller: cm40-pid0 : IMX_SC_PM_PW_MODE_OFF
>> > >
>> > > But I cannot see how to integrate this into the dev_pm_genpd_is_on() you
>> > > proposed. For a quick check, I added this function and it always return
>> > > NULL at dev_to_genpd_safe(). Can you help me to understand this part?
>> >
>> > As your device has multiple PM domains and those gets attached with
>> > dev_pm_domain_attach_list(), the device(s) that you should use with
>> > dev_pm_genpd_is_on() are in imx_rproc->pd_list->pd_devs[n].
>>
>> Ok got it, thanks for sharing.
>>
>> I just send the v3 with the changes Peng proposed (here
>> https://lore.kernel.org/lkml/20250519171514.61974-1-hiagofranco@gmail.com/T/#t),
>> but I am a bit confused which path we should take, the initial approach
>> proposed or using these PD functions. Maybe we can discuss this in the
>> new v3 patch series?
>
>I think it would be better if we can avoid sharing low-level firmware
>functions for PM domains. I am worried that they may become abused for
>other future use-cases.
>
>So, if possible, I would rather make us try to use
>dev_pm_genpd_is_on() (or something along those lines), but let's see
>what Peng thinks about it before we make the decision.

There are two power domains for this m4:
power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;

So before attach the pd, dev_pm_genpd_is_on should also return false
per my understanding. If run dev_pm_genpd_is_on after attaching the pd,
the pd will be powered on. So we are not able to know whether M4 is started
by bootloader or not.

Hiago's case needs the real power status before attaching the
pd to set remoteproc as DETACHED(M4 kicked by bootloader) or OFFLINE(
M4 not kicked by bootloader) state.

Seems there is no other SCFW API to check whether M4 is started by
bootloader.

I not have good idea as of now except directly checking the real
power status to indicate M4 started by bootloader or not. Or using a
device tree property runtime added by bootloader,
saying "fsl,rproc-started"?


Thanks,
Peng

>
>[...]
>
>Kind regards
>Uffe

