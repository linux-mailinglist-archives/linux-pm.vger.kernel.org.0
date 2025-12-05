Return-Path: <linux-pm+bounces-39243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D3CA83EA
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 16:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 771A8300879F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750E34B40F;
	Fri,  5 Dec 2025 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RBJK/j6R"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576C34A771;
	Fri,  5 Dec 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947269; cv=fail; b=S8o5QsaTiCwJk2a2snUMpKcd3PaoeyfCFA8bXFwmOS1X/6Ak3+K9k511PSltHRaexPzwY2ydpSHhKEeyiNbpHoOWPHGPUqY/EYmfWrjVklxrcWtn+BPEA9tDyJ+zjIqKL2qt7wOAL7YJFN7+J5Jg6zh7IVl71XAQZpGykrCh+so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947269; c=relaxed/simple;
	bh=igHeO10QKYcZdKMMjhz90C6sdjTPJcUdPNq7rfiE0A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YItaXf5SfrVGVlWYEI3BRDNhhvT8atiekYzs5yeAh0+ZVC/uP4+jyxusDQJMosqZeEHMnoCiYoPHYllAqbUFwDXQIZ8pL40z/tWJ+V37YMFE7aGnaa3pmGo2nXTPK2+UvyuOjeATb9ayz3D0WZdxzdDaE7YzbUm6J+GkI0S7N5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RBJK/j6R reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6oxgi63gB/IA3BGAczzQwUzhlkWmnmS9hzBns5wpCF6yso4A8p5elVRYWmn4ZlefYIFIO+xLG4Hul+V5gf+vUfy3EsbsQ4HEt7iPW3EMRTy8yJvtYzEM8ttR9AtKPm1X7h/viYwAmBsauRZSoAbQY5mFYo5o3Zn07tMRYd7WHYkcArSmFBeDEXLF6jH3aWWRFZjDHuHNEqO2gzPGN5kP495aq6AfD/mM9YuF4l6YPm70EnvM27tHuMcbEOB0tDtxQHVn5wCNP0ILOgqRCGIqS+NPz5Jkso9sK94wB/Yy6nqxWhlZBF+hPQkSChj08xDbaE8Mm1zWoqxY0wp7w4m4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yb6HSKnkby4sGZ2UNQq0wNSjmEmvE/LjFi+qA8XXZY=;
 b=JRD/MzR2gds6b7muh1UwCqnHjaN7VzT4Pjkzn9+vg+8SusrZDRj9mBCYvao/4U4si5X4hyps2Zhv5sTCyE8+zLc9+A9FcgXfF4SxveeWanPxdwqExuL/1cRtJqgxr37WFfjraE+JU773s1IuU1dh5yLv7PeKj+0MY/2bK9m1pSrbyOHlntv13PQ5XyvSgzUXEilz97pD1HW7j5IHy088umi1WlER7XU2GfkUXdlBTOFHkKSVXem9tyxkEznlOoBp9yGmdnPoROAYjOLGCbrpG5Ut6soFsVmk+wysrmhG9e87Y7VZUBzx7Lzxvx5T1sn7f7Vo1SwOV1LCq5XXruPmKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yb6HSKnkby4sGZ2UNQq0wNSjmEmvE/LjFi+qA8XXZY=;
 b=RBJK/j6Rtd3eItpBz5sHffpM263DhNOIeBFIkuvv8ONU0hcVYKfODwncQsaMMEZ3WfozmcgzeucWadMHl34NoxQwIiHUKXr/AuW/fJuH85ceqAvj8I8+goTNiGQcpoOsHyKd3MfFdGxgcTTZc/YN+5umcx6qD4Ia+Z5FUvCTg7TQsBLd/qPkSrPw5QIaJ4YWIyjEWt5oi22omNBwAiTqEb1B1wBlV3w6LuFbW1XovRngH+8fEFT+5nP/qPGFu1iKmBwwRvR1oA8OuyFWUlOzuwTRvcaglhlpx++cZPv2UQKH9ny3BTYTyad9CUBMSU83+klNnrV3gUQK9NG1Oqny/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 15:07:42 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 15:07:42 +0000
Date: Fri, 5 Dec 2025 10:07:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: ming.qian@oss.nxp.com, linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
	p.zabel@pengutronix.de, sebastian.fricke@collabora.com,
	shawnguo@kernel.org, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] media: verisilicon: Avoid G2 bus error while
 decoding H.264 and HEVC
Message-ID: <aTL1NrZyeq8g/4Ft@lizhi-Precision-Tower-5810>
References: <20251204090813.595-1-ming.qian@oss.nxp.com>
 <20251204090813.595-3-ming.qian@oss.nxp.com>
 <aTHGJzVKa7PbEifJ@lizhi-Precision-Tower-5810>
 <9f38bda2f1753645a1ae392ce5364ea0165fdc01.camel@ndufresne.ca>
 <aTIRwcocnye0Y6yV@lizhi-Precision-Tower-5810>
 <b45a73845e66355080cfad0f0040b6e7a9d78241.camel@ndufresne.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b45a73845e66355080cfad0f0040b6e7a9d78241.camel@ndufresne.ca>
X-ClientProxiedBy: PH7PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:510:339::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fbae2b-da0c-4d59-766c-08de341009e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ygX5e90x21fOM2wOBsPvKPf9/RgZe4ogcYPnLqGs/EEGOUe/WvhpgGM9l9?=
 =?iso-8859-1?Q?CAZufUzCSq9sLC9Gm2/rlE4Ugp0B8NSNIgQHxZorxabUHi4W25evw4ob4e?=
 =?iso-8859-1?Q?UCOiaHdzPMvUEregMsYNeCmOu/ebLKgvDvaMpun4CP8gIq/clrOo2p+mPu?=
 =?iso-8859-1?Q?HPlUKFQbhy6S48OKcQfAjiliSW0qMGUtW/dr96h9fBvjiMFHtG3B+DRFrP?=
 =?iso-8859-1?Q?fYUTlAKYmVm+E8BRUJMEkPuveWji0QDkSFoe1o0tYOEsp1PCAAJ3kakf8g?=
 =?iso-8859-1?Q?bZnzRjljIWIT+/gyxGjP5Uvpmpwh/AUHtgD3J3hBCnEfACL+XfuGJ9g6DY?=
 =?iso-8859-1?Q?/dL7PFHV0hCHJYQkE3swUPjN5Rci+hhkj72u6I8+hKpGWwRIGI5aSWTQib?=
 =?iso-8859-1?Q?3ZSzI2hzdx5Qo5OWD/jEcluZCuLgW/lNDh7ARHDeeMsVrdw8tmFYe8cbwO?=
 =?iso-8859-1?Q?OW6rg5If6Hb6jVTeuYw9+f8sx5Ei/NCwale9Jhr3NsTVJlrIr69o8VKw7L?=
 =?iso-8859-1?Q?qSQCZhNxtBHWh49Y3uuGavATMUTwEyILSfZUto5gJ4qTi072NLGmwdYUEJ?=
 =?iso-8859-1?Q?ht0LhDgTvrAiatJ/E8XBkqLrxBGGHNngCRlXQ/urPtOLuTg05MdgvGN59j?=
 =?iso-8859-1?Q?qvR8795H7MUKiEoP1w+OZBHJax+J4mWOkQDcUrR55uSTz6Fue2V3QSBo4C?=
 =?iso-8859-1?Q?FR7hqcnICTZtqIhtlKeu93gaVBzsSqlfnVtmoI6DCIqQsv/5tt+fyuD7gL?=
 =?iso-8859-1?Q?XRRl1M6jjJxLP+ISPGBKtprGd4zgWfnSNRPZ+q1G1v1czwRQ+p9NpZCHY2?=
 =?iso-8859-1?Q?6Dr+RI6e8RH2+y0zJlfMUQ/tTgEObjV/skhU9kF5YMLZhMlH8Fp9j2jcTy?=
 =?iso-8859-1?Q?6uHt09qhJjV2kdVHxyRguD8T02VRYpUHESODFKsS9uhM2tIHtSIQgEYIWL?=
 =?iso-8859-1?Q?8Bdrix98XaLeX2hSodPo/KQbbAKwtraSXaW252QJj6MeFiKWiN8E5PKxoP?=
 =?iso-8859-1?Q?4AeuWCiAufomGs7dKjwKZJIZ5LYAQ29LSzZ6sx4zElUUTj8NjOsERT3Ju6?=
 =?iso-8859-1?Q?u7FwTfJU/WIcjzfdu05PlSH2PW0PdBfQtCtjuPi3Q5Zjq57s2KgxBXfRR1?=
 =?iso-8859-1?Q?yelHutlKHUCN0Qv5B/ITn9BzPDIgL5iCPe+5JrVS1TzL51khBTMysc4aN+?=
 =?iso-8859-1?Q?EFzJfSRx4d3WLlv5UOqI+HZtOwuCInzLG3pdDNyTfvn0Mh9/KRot7cK9za?=
 =?iso-8859-1?Q?86t4FX5geg2mtb1UFaJmL7vQRfJMgMVVHLEuQ6Lw5Dx2ggfmP6rHajvLgI?=
 =?iso-8859-1?Q?jfBisW7K4b1jbe8izieq9SiuKgnbIZIBESnnlYdE7+gn9tgIZqXl8I0HT9?=
 =?iso-8859-1?Q?4Anws9sAcwoqoVmEKsSmtAKW1OEaa3HCFat7crEqlRnIMjUQc4RqD4SBhh?=
 =?iso-8859-1?Q?suhw+8A4KZ8GZpPQN1KKwHB4HWcwQOLJCvm7BFWJz5L5do8QmXjh5ddE8b?=
 =?iso-8859-1?Q?7niSVvHxkkatGXGeEhOYa2ynXHHrQySXDxcas8as3/vF4MIwsf4Ph5gltJ?=
 =?iso-8859-1?Q?HKDIUkE72+bg8lVlmXoueeABf/qS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Yv8TJtr126SC62l6oCBbjKBDir//ZKaALqy3ATxaqME7+zK2mNppc2bA82?=
 =?iso-8859-1?Q?OL0fXKy7fy8Z+k+jd4WIc6r0UNyXA+/6biwVlQ0ilfBEweMWh9Rdus66Ps?=
 =?iso-8859-1?Q?uhK2hyI8hFNivp8gR5YWRxmmL0a1L4AJ7jY4ifDS6zuyAZ3c9wHWzXiRpQ?=
 =?iso-8859-1?Q?ZTHZW78jL8zxsPFRsOLA1O1W7vj1sw3RElCwkkPYDz8oAcjfuhZdBqU1CU?=
 =?iso-8859-1?Q?fE0afL+UOnHJxWrUaZW8juuoGDxabNHFfKehKqXVWzcv9qPQ5oS6RG+OG4?=
 =?iso-8859-1?Q?ez9+fTIdA17VK+jwHAdkBkxhtuOel1GyO9vbf/iWZaZDz4NoOZLLpnW0hF?=
 =?iso-8859-1?Q?77UU3AiUov4z8oRvw538itrNWqwWD2gTvPpiZ2sFjB3/l1MsQDYY/jGi10?=
 =?iso-8859-1?Q?8KEj43g8wPyV6BsNMZyBVTypirtzOY80OXXlqga3xwr+jwGQ8lEVdElBJv?=
 =?iso-8859-1?Q?K48DD2e+CqWKoE3DV0cncH7HHqZv1M8Y8dNrhm119dvk2l8eCLhXtRCqhN?=
 =?iso-8859-1?Q?GT4bOJSqpt6nILIDL86t/jJDPI3x7BH37613mZU1b+SpBaggj25bt06Ud4?=
 =?iso-8859-1?Q?MR9RmgGNkxPcRSHszbAAdE3wDvLLZfDEgrtGohIBNpJSWKnPs0sSV1R6/x?=
 =?iso-8859-1?Q?WZU1NO49csWrF1E3o+mEEYmig+4aQJTJ1hSTbl3wYjpHMLbuEcW1tO2NzJ?=
 =?iso-8859-1?Q?TUVtctKEsc4r8kF8MVlazANvoXAnPHmdRv6sbECsp/dNdThFgdopd0mRKo?=
 =?iso-8859-1?Q?MtfgF2ekA1ebg0itBFoWA0Jt8mHCIIQQI1uiBti1RVJ4ADzgwOYwSa+j+y?=
 =?iso-8859-1?Q?/6NhIBlEfqdszxJP/GLURvrkwycc3RTL4fYyyp33HRonFAcJchyqwtCfIi?=
 =?iso-8859-1?Q?Ibkl7uzObkWL0LdnjOQRTr5eD1mBNAqyyDE9a4I3+Y7yclgzrrkKB133p2?=
 =?iso-8859-1?Q?9lHDKMWmUCZlFgFTMZfpXN9Zl6bNwYU5dNz4WbFmvEONjA6hsgD9aG2tkd?=
 =?iso-8859-1?Q?Det8g7mHXU+XMrzB0nsLhCk5w02iZHcNJtpUVSxZvc8HBG8qkc62wa2Y6C?=
 =?iso-8859-1?Q?ctcOJQkX3rexjPqnmt4ERKfOeJRe/Ro98OUf9A6zR+IkB+DPVMq/foE+T2?=
 =?iso-8859-1?Q?OY+KfexElISIVrbIL9tykRodYiwqz9DTmkx7jAmSy+etaS+B8VFgR3+oyp?=
 =?iso-8859-1?Q?dzdOerEiZXYk8gbEFw1ngCBrzTxOTiUC/HoNrDO/vTyQ7iGWRrS5jdyEgp?=
 =?iso-8859-1?Q?Qf1zX+F2I0zEjYLqxANi2kwPzL7zogT7BqsXXktPmxbbay1A5cBxIJclOZ?=
 =?iso-8859-1?Q?NlQeNEbhEuyfbD9LsFJdUVjLgFRloYMCdVnSKyOny999UNZzaE0ztY5qdv?=
 =?iso-8859-1?Q?rpuIvGWA6yoFO9nkbAkJWtrRp5heRjocogtNp/CWlRSYq9/iN/Nv+7u0j2?=
 =?iso-8859-1?Q?5kSiIc9HgY+uWfHiS33r7cLumfVlyaYKy1kACfNKNyO2BrgIzSaZF1BqEq?=
 =?iso-8859-1?Q?0Bqa0/PqSQH448lgbNSPtlPL2TQjjF5hifCT5jUbAvVM2FaFllh0TTph4t?=
 =?iso-8859-1?Q?U10NK7DJ3yEQPfznWdT1nVcVtmZxMBrAoNJDXNVCICXhy4fdqG/JjtOVAv?=
 =?iso-8859-1?Q?AP2IAnIL17B2aHIZMIYS1TzjG+4IjCsXIN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fbae2b-da0c-4d59-766c-08de341009e7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:07:42.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmnT3jBaPgwf4TdSa6OebaCaRrDaZcKvRoF6BLBf+PvYwR0w/xoa/CdQS7FZ7xEkw+n8iw1Q933ESKeuE/u/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

On Thu, Dec 04, 2025 at 07:05:01PM -0500, Nicolas Dufresne wrote:
> Le jeudi 04 décembre 2025 à 17:57 -0500, Frank Li a écrit :
> > On Thu, Dec 04, 2025 at 01:15:35PM -0500, Nicolas Dufresne wrote:
> > > Hi Frank,
> > >
> > > Le jeudi 04 décembre 2025 à 12:34 -0500, Frank Li a écrit :
> > > > > +static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
> > > > > +{
> > > > > +	struct device_node *node;
> > > > > +	struct hantro_dev *shared_vpu;
> > > > > +
> > > > > +	if (!vpu->variant || !vpu->variant->shared_devices)
> > > > > +		goto init_new_m2m_dev;
> > > >
> > > > I found only use shared_devices here, how to  ensure that g1 and g2 operate
> > > > alternately by using shared_devices?
> > >
> > > shared_devices is an array of of_device_id we match against. All the matching
> > > devices will share the same v4l2_m2m_dev (aka m2m scheduler). Typically, both
> > > cores will be schedule as one. This achieve what alternate operations without
> > > active polling or blocking locks/mutex.
> >
> > Okay, but this code require shared_devices==NULL's device probe firstly.
> > generally not order guaranteed, if there are not depentance at DT.
>
> shared_devices is a constant array that is set inside the variant. It is
> normally NULL, except for the imx8mq SoC, for which its always set.
>
> >
> > Does VPU always probe before g1/g2?
> >
> > and if there are two VPU instances, what's happen?
>
> Since there is two VPU, g1 and g2, we will enter this loop:
>
> > +	for_each_matching_node(node, vpu->variant->shared_devices) {
>
> On imx8mq, this will match twice.
>
> > +		struct platform_device *pdev;
> > +		struct v4l2_m2m_dev *m2m_dev;
> > +
> > +		pdev = of_find_device_by_node(node);
> > +		of_node_put(node);
> > +
> > +		if (!pdev)
> > +			continue;
>
> If the match does not have a device yet (not probe yet), we skip.
>
> > +
> > +		shared_vpu = platform_get_drvdata(pdev);
> > +		if (IS_ERR_OR_NULL(shared_vpu) || shared_vpu == vpu) {
> > +			platform_device_put(pdev);
> > +			continue;
> > +		}
>
> If its the current VPU, we also skip.
>
> > +
> > +		v4l2_m2m_get(shared_vpu->m2m_dev);
> > +		m2m_dev = shared_vpu->m2m_dev;
> > +		platform_device_put(pdev);
>
> Finally, if the other VPU was initialized, we ref the v4l2_m2m_dev. We will then
> create m2m_ctx from it which will cause the two VPU to be scheduled one after
> the other.
>
> > +
> > +		return m2m_dev;
> > +	}
>
> > +
> > +init_new_m2m_dev:
> > +	return v4l2_m2m_init(&vpu_m2m_ops);
>
> Otherwhise we create a fresh one.
>
> Does it make sense now ?

Yes, thanks for detial explain.

Frank

>
> Nicolas



