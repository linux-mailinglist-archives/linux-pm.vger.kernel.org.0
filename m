Return-Path: <linux-pm+bounces-41874-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHSaFpsOgGmk2AIAu9opvQ
	(envelope-from <linux-pm+bounces-41874-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 03:40:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E2C7E73
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 03:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DDE030053B3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173C21CC43;
	Mon,  2 Feb 2026 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dvKsd2pc"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8A1F3B87;
	Mon,  2 Feb 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770000021; cv=fail; b=iLqF79sspvY+idoiposgGtCTaqRf1SsefItQjCmjU1EWgfkmRE8b4ZEjN//+lXPpXTKLgR29Vab7e3Ize0U17XNLWFnt/f8o2GW4jXMTRLcxnGcaqTuHEIyF1/aphZoTq3H/K0H/69uDaT/UhTY4BzEAvmBr5qd+JjpKvj7z98k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770000021; c=relaxed/simple;
	bh=wb2DGqtQ0tuOcmaCru3tHg48zncu+HWRhkjGxh6/FYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TmD1iWUCoeRT7vLxEdGDPu+0mTOc0D6OxePQVigEOScy4Vrn3Y0gfEJk983LzzO7DGxlOuCXhxhYVan9q9+Gz2e6dehhAGhsbx1b0k9jkJmigOOsF37pnZq+TkoUeiXT7YpMfnQ7WMDdkJS1nxcKLaoTMRCf6JeXebIO7EL3rws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dvKsd2pc; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lbx6hBbrlsE2+qdhvBDJk5DlAwAFL8ePxv6qK+5AyQg3SDF2ZyBDeG7Ky/lXKrNrgZ67GLR4/3285x58P6b+PI033W9sL7RGKsKPSGhKEWv99QhaEdTF3VKlTlh4U4VTVH8mxPUK3cRO/eYdtH/ygMJt1RT1mcEGSQ06GWvJ44sLP23Vm44wM29yFCul2HnF1bpOahOBo+WBlVVnmJDbIUDFLuB8ihhgwiIPDdKc0YA7I94cjT7GReYWKZzuookFCvFxMew9Wxp1pdbPcUCTvoTf/YUYdfSZQxLcyWAxO3vVNRQyh8Mj7O3cgwoFq2KmXB5z1GtSnjT54HMEzlLUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeBSgTMwLAA7U//NVC2s8a1ZHtMmSuiuKGby6kyOD24=;
 b=NsbeRtvTzYxl9dqKhFn5QdTp5oVvZObA3Hvun62sAMVZAu/D9IfaqtiWZflLx/TB5c+KfRAzmhVmjl8AiN12Zm0n6uQ2yIyDQhzH4OY2zeMivET9S0lUYPd4RcKVJXy85Z96hDElpPFSmf2qBsfTvOUOqQSeAdJIoz6Oq6RVZ4IFdV4o6xmc4YPa+q5mq/sywY214Fhh7cie8g1VI5lOwLRp3ldp2kqf2ybA+FrTmiEBHVCneOcBLSQsw/3o+SYSeRKw/ORyaZjodoijyRmJ1EM5PHMZ3ID3GKE5dxBmKDsEYQzRB3/7f24Nj1EWZjwwqthUxCNLWryr9jJQ8/u5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeBSgTMwLAA7U//NVC2s8a1ZHtMmSuiuKGby6kyOD24=;
 b=dvKsd2pc5U0Sww7fT8Q22Qwl7JZr16bp9lYqMTfgHId0zWVyEH10aOpyBUBJkla1GawSuUx5jnTFN6ADloV8CTKwDjgSO5yn916LVCyGklwSKWJL8L6wO1y/hUuqdDFLnfoHmtwJm7FZgt6q1fpKCY4ciQKPwVuqpp8HwXN0nynUcOTLVKMjtRW4PBrxo7x6XxGuk5wkclaLnetWNeZt0zEhjGGt/2ldIUnmEP0Y/ptQn4wOfidZ0/b9UOixaI/WhV09FZIr42C6ziaSZ8pmFT8cYNOjGNhJj67Mx9V3ghyX+3HS0V/7Ij+PNV2OS5EN/GiJO+ueL8mzGIWfU+h1rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10370.eurprd04.prod.outlook.com (2603:10a6:800:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 02:40:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Mon, 2 Feb 2026
 02:40:15 +0000
Date: Mon, 2 Feb 2026 10:41:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com,
	eagle.zhou@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	ming.qian@oss.nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mq: Restore VPU G2 clock to 600MHz for
 4K60fps decoding
Message-ID: <aYAO7fOmCYVmCDa5@shlinux89>
References: <20260130084133.2159-1-ming.qian@oss.nxp.com>
 <5476502.mvXUDI8C0e@steina-w>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5476502.mvXUDI8C0e@steina-w>
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10370:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e16dc6-f066-47b7-1f8c-08de6204656a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yk5pLwUDggRxlQHyP5+6BouHzbQz5SiH6M6l8au1vjifQlDUjBYwstyKZaCl?=
 =?us-ascii?Q?L4TT8iGX3wlUFzrpkW84SRd/eEysEfp6VS4KDvt18fRlQLGU7B+nPnfmJCuw?=
 =?us-ascii?Q?9tKQw6qcctVESE5iYMo6nI189Da8TNsWF1Ss3N7DUxuvzGxR/uxKAev9i/MS?=
 =?us-ascii?Q?Pw1ID+OtLlfZH5+jNoYEBbEmkIc8MbgAH5oV7iCoOgxmIJt4u+NHxXYF+vzJ?=
 =?us-ascii?Q?oOqC/BQMTeJMKWGPAA5dCY6eMIQD/2bI5Zyv0yTHLTcU+69521JebkvYxzuR?=
 =?us-ascii?Q?7LxaVxdu9LvjyOKAyHXNcBAlhZK3BoAi2uLgcg7Mk4EE6vA10Ypr99LyJ9qw?=
 =?us-ascii?Q?X15QBMUF42z2ypva9Q0TBC9hXs15PiT3G3jdyJxGQoUHHJW+H1RANT7b7Jh6?=
 =?us-ascii?Q?LYC3/Pjq72h7Ng34aEQHSgfVikGMHLGN9dsGDf0aE0J9s9lxQSkmzcjLWUAw?=
 =?us-ascii?Q?cSMEF3SOknt6qqms7zxJsjrkaZzYgtxbVH+DWl3Axzj53Y68GJok8CemoKr0?=
 =?us-ascii?Q?5icu5QDDOZZwoTDZ2it3N+iDkDrbLwsdCPHYV893CW9AINugQ4jh7JyLt/3+?=
 =?us-ascii?Q?z3XqQalDpFB+m2nDfx9Yze1eho9kc9DhLbmlTc3/9SjP+XRPVtn+9TEe7gX/?=
 =?us-ascii?Q?zKYrIA3UGUOh3R6CuMRFWH6CozRiutqHcjE6/+G1cOwgnoqRQCEdUuZ+7sEl?=
 =?us-ascii?Q?IODq0HwVq7Qnl7098UrFywbOV5Ky1OGxuSnqsCbbeIWHBEjZ3u82gTGhXO8P?=
 =?us-ascii?Q?sQkoosKDQ+BY3/efhED+mPUTW03Qj2OPWYqFVNqik/rnEzlAYWFN/yz8Fr6O?=
 =?us-ascii?Q?sITnqvskST2c3qyHreVQ6JDkfB6Dt3eiNYoFXaynJl1c/dnIKtB4i0wujoF5?=
 =?us-ascii?Q?MUWFekZmxQ+bCypWD6FOwY3MBnUZSVvaIlfFAl2BdY8581G8C6v3Yc7QKSyn?=
 =?us-ascii?Q?mNI6BdHzD76lCUJx7eBPuBLKP1AKRDngIRApR8Uh4fNSfqlbMudvFuDbZb+j?=
 =?us-ascii?Q?w1rtD4ySzgPFohdqf3BWwrIcE7o8Ndz0+5orievFq/tGFbwnntUORZHBp2P3?=
 =?us-ascii?Q?IqD9U0OmiY6gf+3iQeDzwao+4Mbqobc8IKap68+Zk37BWbC7XWvtg42JeOeX?=
 =?us-ascii?Q?IRGNTS6UwsIEJieU69n8wVmGG1Au8udRGh5aV17KVcbCNL3u+yCTYVjoetFl?=
 =?us-ascii?Q?GnOUAaMBhrtwansXz7mKofcM/V+ZyYOwWzUzjmAl2lSDY4/mpvk27aEoMD8d?=
 =?us-ascii?Q?5FrP81WcgpLNd+11+DYzb1J8b1QtXDyJir6VQmT9m7HVj/WOsHVdvLvhZaJw?=
 =?us-ascii?Q?LyCgi/6lItMjQHnmBmo7zwJRXVTzl5Mq436NIIGyOfiIZ7U1DRhWNbGU3TKq?=
 =?us-ascii?Q?HXWFTy9cWXoSW9xK2AfVnBi4Kv3doLeZLsAV8oZTTSZp2KXfCuWgTw2Chn5S?=
 =?us-ascii?Q?q02wfIDVPBXS69gjIYcKo7o9GGLl87ySP6Wr3CfPP0vXkgNTh6ezBwgP8eLZ?=
 =?us-ascii?Q?EDVuxjjGe2TAsCcYX12i94TSTZsGzK+T1X41johFvwbR+RS2Oxs14zV6oYPn?=
 =?us-ascii?Q?BVN/DqVPvBjHiHfD+BS86H7jAv4ho4+UR0sNTZfi2lgXf2cpxdKE6b/PpEw+?=
 =?us-ascii?Q?KtMZYZ7u+mgy59ERtoATvDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iBtp8DtSGnBKPuaVmNnEQOzyn3sBfIPFYJWLAL4FaRvuJRjMO1waBZN5Zg0N?=
 =?us-ascii?Q?otEpL1hyoTe1eFRJv/iS3hF2Pv7IwJm5qkTxzScM4f3J53pTladg+pJGK5rD?=
 =?us-ascii?Q?o6kSv59kgPMNiIw0cmO99NxLCtLAVPk42B5tywVGs9hQyoyA0Idt2sbLfstL?=
 =?us-ascii?Q?qAN/U8f42Cw5laf9hMDCD2UGejt+5B0VOOZN4+W3POT21+25hZEhenQJ4rLu?=
 =?us-ascii?Q?9UI2JO50znYB7CRK2ZgikotSM8eCj8xyqXXsfWJ9iD9lG3FKUb2iagBPOA8t?=
 =?us-ascii?Q?IWxMbzKlWucFF4PrQnlQ8MzN/lWcyIvfi1xIToy5p8GZHcxeby8uo5N/L15C?=
 =?us-ascii?Q?LQeBoQhua2PL6vAHUqYIE1wvPC5jcwZWqJRxKpvoMwM0kd85alfNQzWxc4Iu?=
 =?us-ascii?Q?SV0CJ7d+u7haZzYVmsc4OEcccK77HxjyTFj9uWcQr0Z9lEUXfLb4Q09QScaZ?=
 =?us-ascii?Q?1u91MkRJluEJAB7UIt29c+zDYOBcZBmq3wJIoNBbaO+5yeORz14kxTxAx7Do?=
 =?us-ascii?Q?vE09ecAsfG6pQS0x0/EywKw2T34uk9TOW6jizUpM5WPwPzvYJ/KLxIeX7133?=
 =?us-ascii?Q?p/zcvFgRNtXeqo2dMyfHVzfkTguWV9rJ++EOV0Vug3h0NQCONu81Q/60hf3S?=
 =?us-ascii?Q?2JAytsUQzToQEzqwnxdJvy5mmJPeFyTMIrXuo6DxohRe08y0jsN9n2KIOQTO?=
 =?us-ascii?Q?MziLziHJcjH0Pojm7HsT2Y/E8zXSZ4JmGxSJn7U3gCRwOfLNBOCRq0svydFs?=
 =?us-ascii?Q?wCzcg17DpCNDHpnfoPQkp7+KbniLo3cLnTZMBQ7kU9yCh7ECYdxDD0xKXvIN?=
 =?us-ascii?Q?bV5PNAa6uM7Ag5qqxi9/CccBTjGrvsATHcjrYnGfEEXx5q8dKQt1KKH3zno0?=
 =?us-ascii?Q?psiyidhpCK9n98EBdm6fsLrnkOgaFGc7pZ5QJqbgvuJm1ZPZGLKJJntQ8TRY?=
 =?us-ascii?Q?vYe7CCyBqRvOtkQkWYx9LGXPyLVgxJeJpw9uylKn95FETfD15De04nXu6sJ1?=
 =?us-ascii?Q?Wr0LTXOZxJluti0seJTo8xNoPXTqoIdNV2aTINfJoN190G9UPtNHd8g3cycR?=
 =?us-ascii?Q?iwI/7kFRjGR2IB6Z0VZWKIa/vv6QOfkTBMZO6aSTxvpuJbqcTuVWni2JEvoT?=
 =?us-ascii?Q?abcxOapUb/YH3NfW7tGJGOoX8/RyeJu8h6jDDPA9JV1L0Bwc/AW8ksR3hg/f?=
 =?us-ascii?Q?YT/JUjeDAQ1Sh8Wba67E44hoy1lWZx4OVSOCgjLOjSDbL2ZnlOzqLRkkhxAj?=
 =?us-ascii?Q?ryUUo+SRjDK/+VndBKJZwEWdLFzvwx8ZahCMIgDxqI7S5y4zyZjq6S4sdjll?=
 =?us-ascii?Q?h5i86fAoDcQdHlVsoqP7aGtrTgEEgSfW0dSSo5Cq5NTOQoBdMtV6EQtA37j6?=
 =?us-ascii?Q?p82mMR5tdA5J6fDae8ZBohsILdnsVj63di3rVNFf53F2Mt0mnB5lSGThEl8W?=
 =?us-ascii?Q?Tz18hx4NBcQr2VM487wY6seGsB7rTzLCeBrNkUxJcorE+tqrKaL68vCyILov?=
 =?us-ascii?Q?+Mruvs4iYvwJlX+ekybpPTF3ph57dTx/mlAkNRW8Cv76HSCl8hdoygwHG/lt?=
 =?us-ascii?Q?HS2DsMstMf1mo4G4JRF2IwEoLcdLSG5ZqD3QnZEX3DWsrrXrZkCYnpyNXsHp?=
 =?us-ascii?Q?Xurmx6gfcF9W0Oi5t00zFUaGCZzAWD5U5+7wNANVGgTi8NV0XgdM/e8ujWMr?=
 =?us-ascii?Q?zjztUXhM8OxhEGJ2V2Fj8bCNCzR4Y77M0CyHy5lOjJRb3RfAR0ZVHFghvCeb?=
 =?us-ascii?Q?BLgDAGHF+A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e16dc6-f066-47b7-1f8c-08de6204656a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 02:40:15.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qV6uh9mDVK4pJmk94jHqzH9hb+NSWHZ7slWbCdtxudwddDz3GqqxZfaA3BUIVRr5sRbgHOIcfDqkPdrpk6zH4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10370
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41874-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	DBL_PROHIBIT(0.00)[0.0.0.6:email];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[60fps:email,nxp.com:email,NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C84E2C7E73
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 10:09:46AM +0100, Alexander Stein wrote:
>Am Freitag, 30. Januar 2026, 09:41:31 CET schrieb ming.qian@oss.nxp.com:
>> From: Ming Qian <ming.qian@oss.nxp.com>
>> 
>> The VPU G2 clock was reduced from 600MHz to 300MHz in commit
>> b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock") to address
>> pixel errors with high-resolution HEVC postprocessor output.
>> 
>> However, testing shows the 300MHz clock rate is insufficient for
>> 4K60fps decoding and the original pixel errors no longer occur at
>> 600MHz with current drivers.
>> 
>> Test results with 3840x2160@60fps HEVC stream decoded to NV12
>> (the same scenario that exhibited pixel errors previously):
>> 
>> 300MHz performance:
>> - Severe frame dropping throughout playback
>> - Only 336 frames rendered in 11:53 (0.471 fps)
>> - Continuous "A lot of buffers are being dropped" warnings
>> - Completely unusable for 4K video
>> 
>> 600MHz performance:
>> - Smooth playback with only 1 frame dropped at startup
>> - 37981 frames rendered in 10:34 (59.857 fps)
>> - Achieves target 60fps performance
>> - No pixel errors or artifacts observed
>> 
>> Restore the clock to 600MHz to enable proper 4K60fps decoding
>> capability while maintaining stability.
>> 
>> Test pipeline:
>>   gst-launch-1.0 filesrc location=<4K60_HEVC.mkv> ! \
>>     video/x-matroska ! aiurdemux ! h265parse ! \
>>     v4l2slh265dec ! video/x-raw,format=NV12 ! \
>>     queue ! waylandsink
>> 
>> Fixes: b27bfc5103c7 ("arm64: dts: freescale: Fix VPU G2 clock")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> index 607962f807be..731142176625 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
>> @@ -960,7 +960,7 @@ pgc_vpu: power-domain@6 {
>>  									 <&clk IMX8MQ_SYS1_PLL_800M>,
>>  									 <&clk IMX8MQ_VPU_PLL>;
>>  						assigned-clock-rates = <600000000>,
>> -								       <300000000>,
>> +								       <600000000>,
>
>If I read the Datasheet correctly 600 MHz is only supported by overdrive
>mode (also depending on the VDD_VPU).
>Is this frequency really correct?

G1 and BUS clk were already set as Overdrive frequency.

This change is to only upgrading G2 from 300M to 600M.

So if your question is should we downgrade all to Nominal mode, I think
no. The freq could be override in board dts, or adding a new dts
as arch/arm64/boot/dts/freescale/imx8mp-nominal.dtsi

Regards
Peng

>
>Best regards,
>Alexander
>
>>  								       <800000000>,
>>  								       <0>;
>>  					};
>> 
>> base-commit: c824345288d11e269ce41b36c105715bc2286050
>> prerequisite-patch-id: 0000000000000000000000000000000000000000
>> 
>
>
>
>

