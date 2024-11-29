Return-Path: <linux-pm+bounces-18215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBD9DBE41
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 01:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C5CB20E34
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 00:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC98BF8;
	Fri, 29 Nov 2024 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g7gk+Rjm"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5013211C;
	Fri, 29 Nov 2024 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732840731; cv=fail; b=aVwY4LakZAJD3lFapano0SscOMngORzk+0sJw1sI5hkhCj5tH0nJYr81AtWZpeqd7WPdWIbZWKAxDKJeFKKQINUrW9lbGmdA++HOE/RvcdmFjWrPWRv3yt3TUjmB/r9EfthQYoSJPAICBAYkU5OSGtLucoNMbjgy8958GqiRrsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732840731; c=relaxed/simple;
	bh=uQgpmd9XygN16vJui3j5hwSCLazYjRlCwiH45Qh70/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=raWUmKoG+uszAEZhGqvLfOvW9PquOwCUeMRzVzXemjgb7n8zupBv4ijpfr4zk+QstI6UdrO4lDMJyLFcXlNPAmpaqdSRRF+7cou5T8DoTbA9a31hqmEhXJ6b2PMNCqN6kadXZWJcDUUZYMW5fZANeASA+SAGx4hYDOLcUBrDSUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g7gk+Rjm; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtWOPtcnIdaZcZfS4D8Jl70X0BDU/N+Ho9cNYED4KmZTId2WK1VjFt8eGoo5uCo57XP7E0b94OJruQJIFQEDDaJ6FhQ5LBPER9sSi6QksjOxrAYTSuJotx2tsfPvrdup1YKZHroqdbugHTKu18tRTqraRgwrYxw91yIPQwKcCLY5oZVbDODV1LdKVUnUHe02WeeFG1RzDd2QtoRbtgpesndwa+A021KtqiosvCdroxmRndUKOVasmtq8QuXLpm3CMR+9OYXBshoPQyyPb40nscWgzmHYlG3qr91Xj5Gzf1KLfkoHjSNpQvPjxZR53JQmo1bTYMQ2AVRi9b3xKiAosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjuvRVRULDKUNYFnY+p/NeeWHfO2GbIbXGUTSC/Wltg=;
 b=BjvEsfrtibCteKhC+aoE550jPV6Xxw8iEwH9fyL1OY7ERYQ5gB3keNbowgvmVMQ8+sXa6LFch/PJ9ZVnonAQCy5kRjXvmy6digi05o2eNQlIfj+XpVwME8xVCwliR6w1oc7eAkXFKBLurLC+jwR3Yz6vpOHTbN0BcOJ+o3YlcdAosB0wp0B65kvBSZLMJ6Rwtc4JPyd/YPb6+2Zw+l1iTfXsUXe2p3/OA8l7MKZ2SQitEwACWCOf/VlM/39AsMqmKkvwX993NHVx089UOlcMbzgjpOBzEVFOMKOkJ5fJGoHoGmLxSCVxINGUge43RNmtDFz8NEKmEQlJHeX0wkMDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjuvRVRULDKUNYFnY+p/NeeWHfO2GbIbXGUTSC/Wltg=;
 b=g7gk+RjmQOvtH1EFP4ZMDgEXPngKOOemJgTBE/dPXL+qVZKf75uQPZBsqolw9fzDQG+YI/wnmyZrpwVWt4PSZNnSaTazleywROYihWsGQ4rwZlCisLQuZ7FJtohlQXODisqHfNIrAHhq6YBbSM0GrN1VhVdrTaXEMIt6FhXkzIRiGxKgX1vdkXcEVS5zZ+5+6TdlDD3euLAmwjZZ08nJcjMTQ9GIB2JhqSZF+UeVepegs1nDuYKS+1l1nGDCcue0aMihLW6bOUyHLPnAx88GJpc4OdKE3k97W3NvN/G9j94AP7jUHJwhw5J0hYilU0BYK+8bBIH1tLe/pcr7uQ7MsQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 00:38:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 00:38:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>, Shuah Khan
	<shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur
	<jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
Thread-Topic: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
 cross-compiling env params
Thread-Index:
 AQHbCotjTSksRUq1mEyXqNdymTcGi7LBikwAgACE5UCAAEobgIAAeDyQgAEi9QCACeReYA==
Date: Fri, 29 Nov 2024 00:38:45 +0000
Message-ID:
 <PAXPR04MB845918523309488B79BB617A882A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <20240919-pm-v2-2-0f25686556b5@nxp.com>
 <48c0adb5-4ae8-48bc-8e83-3d1c413f6861@broadcom.com>
 <DB9PR04MB846134093D2302B6D67E7E6288222@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <16411b6f-3e1d-4d52-a047-8c322774ec8c@broadcom.com>
 <PAXPR04MB84595BA5BEAE2D21F015036688232@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <2bbabd2c-24ef-493c-a199-594e5dada3da@broadcom.com>
In-Reply-To: <2bbabd2c-24ef-493c-a199-594e5dada3da@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10321:EE_
x-ms-office365-filtering-correlation-id: fab58dcf-ef2a-4c72-b93f-08dd100e2ef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3hvAmo/LRpd7yxplX6syEl/HlhxE/PVaoFew5TXTHEzwbSok+9TlsyzwwHx4?=
 =?us-ascii?Q?E1wNHgy2lhT+5UNiO4+7/HYu7nXAWnyaD0v1STcWHJRzvIntC7tZeWdab5ju?=
 =?us-ascii?Q?VLK381UmnWFXLxnF7Y4NUkFTk8cmznAO7JSP6Td/mYt3tCLuKaW0IKrT68VD?=
 =?us-ascii?Q?yfHhccEvRV+mah8kYpbmYu/tDTygG4keIrakonQmLtf/kadS2j5ZMW4X/5ni?=
 =?us-ascii?Q?objEBxAKItKPDxkMaCmanoVqUKZGrZKwViN4LTYrav632W3uYllPqfpe+v6U?=
 =?us-ascii?Q?0RpXjbnVe3iNNpHoDfwbOHU2G4hyC3SH+FbweqHf2k7ODzZfS7qIj8zTTKIA?=
 =?us-ascii?Q?ReOwQGYnv7YGKEYDUNYJQp3hABjjTkDwOsCCqk2Jy24mvsXBzdNsQIBl+o5i?=
 =?us-ascii?Q?3B2jf4/5ThqFCh2s2wpsG2BNbs3777whvNtuVL+THwcXW3cNfJ20SRKFmJYW?=
 =?us-ascii?Q?+1uI1mYdsf7TBeP1ZZF9if3ni+QBrW3Gj+m5Wo7CRTnNuPlQ9bluKxoXjo5C?=
 =?us-ascii?Q?6KBWo9jGy6Fmi1p5DYqlMgxlyrbhNueVqN5unajyRjYScAhSPcWMga17Uqa+?=
 =?us-ascii?Q?x7J5bkcRV6z0WkpWMIH/2hKpgij1MhkKbRuHLvVATTkIPVheElKQn57HUfes?=
 =?us-ascii?Q?PCgowaZMVOmfis7Q2oFRCVtKY6mEWZCo85SeR762tmsW1iP4mEbhjm+xliY5?=
 =?us-ascii?Q?T4pDb0vZXpJLS6BhWo1yGK+mIONur5tNTjZb2/nS1z0WXzRS7/Mh+KkRHOkk?=
 =?us-ascii?Q?kOTc7ShSkTMmBI4CJo+VY2jIjqh/1M5CMNSCATH3DYVDXYfVr3YwMh77etJn?=
 =?us-ascii?Q?u6DYRW0//sYcbj+W+n2yAcbnsnkf6GJZvEMZz2SO2oo70pDOYL1ez4L0voJH?=
 =?us-ascii?Q?kKf5bdUlN++HnIRi7rvk2r4OAv4OSG4y3k4rj/vhxJcu3CMFNo39tpXwqLVH?=
 =?us-ascii?Q?BF5zKGFswxI4kBm4bLl5gLBSEfzJujGbNjOfuzrbxkizgGrKMinmYr8B9PXt?=
 =?us-ascii?Q?uoFy6Io5jLkxCM87LAmltx66kANj6hM1FGl27yVALGdEYNvbd5rkU2EkvxxK?=
 =?us-ascii?Q?Dw9olkYznLAu0x/lXnUdcSs7F+KK3STS7Z76vRxSoRKN1wBorKKQHgwOaPIP?=
 =?us-ascii?Q?4E/hY53zV4p7JFRayVQq1qzdjhXvj0/ghW1dRl4Wts029YXjs8e3oSGQePBa?=
 =?us-ascii?Q?cHPaASyv7AYSRiXqmBV6Dvl/fMb7ZDxKzt2UgnLqU4dnnPxeFxSAz5F6NECf?=
 =?us-ascii?Q?YItUzclrIQV/WPugEFbEdBt0/foZHEFEDr7uZKbmua5KHFmZl5N5cDA8/pdj?=
 =?us-ascii?Q?9NVX4374LEr4NxyhPyKiFlfxr/AlTwuV2rZD428lkjkMVcn5FPO7GNnfJCwr?=
 =?us-ascii?Q?2MpWaf4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UxV/IwEL7HkBuQQSn8k8g0PdP9cdWTqHHCjFQKmqgn3fLPPnwNTy6PkrWUQQ?=
 =?us-ascii?Q?ccQh6cS3DxLlSgmfaT0hXP5VO1lIzz42bTUBwYXq+ZyvCb5LDC1gVIl56Nea?=
 =?us-ascii?Q?78iuqqlCh+lAFVx9hUw0y9Ca9UywI7wT4tPg/xLyktruxMyhr+RpVKR46KGG?=
 =?us-ascii?Q?u83CDi8/0BYBE0NDcpQGGAaPeSgOZpOVqj7MjZhSTW/2VYBWcFLwCv3rXf6o?=
 =?us-ascii?Q?Y6MvYfNRBFtxRnRtJjiQNru0WTuMu/04H9rI035FijBh7fMB586KbbceI9bO?=
 =?us-ascii?Q?531+fhkTUrF/3XzRZHkEpiSxKlFS4gO0tIy56JQAWQ5sMLVOGonjSQgvDYqn?=
 =?us-ascii?Q?Wb/pSra5FoYLvE3wQgG59JvvItNHj9tmdwao9CiGW086srUbYwrsBTvp9oyC?=
 =?us-ascii?Q?2fcBHlhnTJogZsIGOr8XGezho29dJ3bZbEzihQdL6688G6IFhTroNBvrN5r3?=
 =?us-ascii?Q?dV/OelShRuiIiyxPdjg14Iamf7PTc3B5x5WAjNtCbJRMLkDqptNB9KjVrFNw?=
 =?us-ascii?Q?P62VBjjy1FGCclmSM8/H1rwx8/1DCWFe3RPsg044wrTqLDiOJt7DU0TpMqK1?=
 =?us-ascii?Q?lF8PO/7uT/YdKgPQLcJL/apoiqNM60x+1vILF+Q1xDmOWk/II/W9xid2H2o9?=
 =?us-ascii?Q?ueL5A496jhBK5iBn3dHwjPCx/bHG68jhnWXMSN6GdaEyh/VRcA4kLhCxOfZn?=
 =?us-ascii?Q?9gu0GgR1yyUN4E9RoYZlapkBsv7LDJyYFUPWnmvfi9RKdZ7PvK6RZkXF7ENK?=
 =?us-ascii?Q?3Nfq+shLNQD85PooXaR12c1pKE3C6LV7LVWp/UfdCuwC7knYnW3i2C3uJY7A?=
 =?us-ascii?Q?Xww4lWGDg70Ih1UsF/RgMhr4j5WoyoAAqdBtiVHbypQFGJQy+CRnU22D6Ew1?=
 =?us-ascii?Q?5Jz6SMwtrnwAbJSn6+TMNVJzSJjOWtyl8XQFm62O4W2Sh0+fe8/smUwfJ/0P?=
 =?us-ascii?Q?e9elcKgPxjIPYaqaSezkzU7tufhZbDoXOrlfMmYtwKH74YPrzpkchZAHM2zA?=
 =?us-ascii?Q?Mv9y/VBzkM0ZOOailcVs017QcNvMOwZONLNC1yYCoWVepriVyY6n93H4BZ8z?=
 =?us-ascii?Q?JB/0vAfXg6fcm4E77CSUL7LTWLN3P//7Y1a8VGyiFlKnMAK9XpRjSd8ZjBMV?=
 =?us-ascii?Q?YESOza+JaWcqAcgfJ17z+YynJW23/Q2pNSuEVeZXYxpkBONRFL3CL9T3cnWw?=
 =?us-ascii?Q?g/nptkR6DAv9czwusxYuRbwOjD+iF9jvkmqsw5GkZrIfq02hcFs6wcsyFCax?=
 =?us-ascii?Q?VsNcVWsKGpOCaCav26706MyTQl6MT9sBgzmZiU5G91CgKAURr5C9ARaMEKki?=
 =?us-ascii?Q?lP/667iwUvgYRhXDtjpweexlVGaAHPg2cxarJ4vdvS0VxoJu9Shen+aFei30?=
 =?us-ascii?Q?8tDSVA3YMzO0YrjlzIXjyqKTGHCgSF+4VZ6iErrveURP5Z7Q8WAjcPO/t1Nn?=
 =?us-ascii?Q?i1KVMbCwTzX9ms6MWKa4s1e8D1lsUcTZOBVmef/qxhhzzfKLRo5g2sdLFHKw?=
 =?us-ascii?Q?zB3AyLCnbBOOcMyo56g8UTXQ0YGCw4jyOBxLFH6BB9Acoxn6QGvX/8ShBK48?=
 =?us-ascii?Q?fc+uX9Bu84CgLq7niiM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab58dcf-ef2a-4c72-b93f-08dd100e2ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 00:38:45.9386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQJm4yDHrmaT3ARy5dv1jlLcvEocYvmAeI+gndp3Z2aNYs3SSCr8RU8QRsFZYoFbd7LtqUSTeZ3t24b5xBoMKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow overriding
> cross-compiling env params
>=20
> On 11/21/24 16:13, Peng Fan wrote:
> >> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow
> overriding
> >> cross-compiling env params
> >>
> >> On 11/21/24 04:40, Peng Fan wrote:
> >>>> Subject: Re: [PATCH v2 2/2] pm: cpupower: Makefile: Allow
> >> overriding
> >>>> cross-compiling env params
> >>>>
> >>>> Hi Peng,
> >>>>
> >>>> On 9/19/2024 5:08 AM, Peng Fan (OSS) wrote:
> >>>>> From: Peng Fan <peng.fan@nxp.com>
> >>>>>
> >>>>> Allow overriding the cross-comple env parameters to make it
> >> easier
> >>>> for
> >>>>> Yocto users. Then cross-compiler toolchains to build cpupower
> >> with
> >>>>> only two steps:
> >>>>> - source (toolchain path)/environment-setup-armv8a-poky-linux
> >>>>> - make
> >>>>
> >>>> This patch breaks the way that buildroot builds cpupower:
> >>>>
> >>>>
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> >>>> git.buildroot.net%2Fbuildroot%2Ftree%2Fpackage%2Flinux-
> >>>> tools%2Flinux-tool-
> >>>>
> >>
> cpupower.mk.in&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C246da9
> >>>>
> >>
> 2d8b6243d138c808dd09e6d644%7C686ea1d3bc2b4c6fa92cd99c5c3
> >>>>
> >>
> 01635%7C0%7C0%7C638677609234547728%7CUnknown%7CTWFpb
> >>>>
> >>
> GZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
> >>>>
> >>
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> >>>>
> >>
> a=3DnL1YUl%2F07Vd8F0GpW7uRqdpZT74avOku1ox9N3%2FFkUg%3D&r
> >>>> eserved=3D0
> >>>>
> >>>> and after enabling verbose it becomes clear as to why, see below:
> >>>>
> >>>>    >>> linux-tools  Configuring
> >>>>    >>> linux-tools  Building
> >>>> GIT_DIR=3D.
> >>>> PATH=3D"/local/users/fainelli/buildroot-
> >>>> upstream/output/arm/host/bin:/local/users/fainelli/buildroot-
> >>>>
> >>
> upstream/output/arm/host/sbin:/projects/firepath/tools/bin:/home/ff
> >>>>
> >>
> 944844/bin:/home/ff944844/.local/bin:/opt/stblinux/bin:/usr/local/sb
> >>>> in:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/loc
> >>>> al /ga mes:/snap/bin:/opt/toolchains/metaware-vctools-
> 0.4.1/bin/"
> >>>> /usr/bin/make -j97
> >>>> CROSS=3D/local/users/fainelli/buildroot-
> >>>> upstream/output/arm/host/bin/arm-linux-
> >>>> CPUFREQ_BENCH=3Dfalse NLS=3Dfalse LDFLAGS=3D"-L.
> >>>> -L/local/users/fainelli/buildroot-
> >> upstream/output/arm/target/usr/lib"
> >>>> DEBUG=3Dfalse V=3D1 -C
> >>>> /local/users/fainelli/buildroot-upstream/output/arm/build/linux-
> >>>> custom/tools
> >>>> cpupower
> >>>> mkdir -p power/cpupower && /usr/bin/make
> >> subdir=3Dpower/cpupower
> >>>> --no-print-directory -C power/cpupower cc -DVERSION=3D\"6.12.0\"
> -
> >>>> DPACKAGE=3D\"cpupower\"
> >>>> -DPACKAGE_BUGREPORT=3D\"linux-pm@vger.kernel.org\" -
> >> D_GNU_SOURCE -pipe
> >>>> -Wall -Wchar-subscripts -Wpointer-arith -Wsign- compare
> >>>> -Wno-pointer-sign -Wdeclaration-after-statement -Wshadow - Os
> >>>> -fomit-frame-pointer -fPIC -o lib/cpufreq.o -c lib/cpufreq.c
> >>>
> >>> You are building on an ARM host? Or you are cross compiling with
> cc
> >> is
> >>> actually arm gcc?
> >>
> >> This is cross compiling targeting ARM, which is why CROSS is set to
> >> ../arm-linux-
> >>
> >>>
> >>>>
> >>>> Here we use cc, aka host compiler, rather than $(CROSS)gcc as we
> >>>> should, so we are no longer cross compiling at all.
> >>>
> >>> I not understand. CROSS was set, but using cc to compile for host?
> >>
> >> See below.
> >>
> >>>
> >>>>
> >>>> The issue is the use of the lazy set if absent for *all* of CC, LD,
> >>>> AR, STRIP, RANLIB, rather than just for CROSS. The following fixes
> >>>> it
> >> for me:
> >>>>
> >>>> diff --git a/tools/power/cpupower/Makefile
> >>>> b/tools/power/cpupower/Makefile index
> >>>> 175004ce44b2..96bb1e5f3970 100644
> >>>> --- a/tools/power/cpupower/Makefile
> >>>> +++ b/tools/power/cpupower/Makefile
> >>>> @@ -87,11 +87,11 @@ INSTALL_SCRIPT =3D ${INSTALL} -m 644
> >>>>     # to something more interesting, like "arm-linux-".  If you want
> >>>>     # to compile vs uClibc, that can be done here as well.
> >>>>     CROSS ?=3D #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> >>>> -CC ?=3D $(CROSS)gcc
> >>>> -LD ?=3D $(CROSS)gcc
> >>>> -AR ?=3D $(CROSS)ar
> >>>> -STRIP ?=3D $(CROSS)strip
> >>>> -RANLIB ?=3D $(CROSS)ranlib
> >>>> +CC =3D $(CROSS)gcc
> >>>> +LD =3D $(CROSS)gcc
> >>>> +AR =3D $(CROSS)ar
> >>>> +STRIP =3D $(CROSS)strip
> >>>> +RANLIB =3D $(CROSS)ranlib
> >>>
> >>> The ? is just allow to override CC/LD/AR.., so in your env, CC is
> >>> set, but should not be used for cpupower compling?
> >>
> >> Adding debug to show the origin of the CC variable shows the
> following:
> >>
> >> CROSS=3D/local/users/fainelli/buildroot-
> >> upstream/output/arm/host/bin/arm-linux-
> >> CC origin is (default) and value is (cc) LD origin is (default) and
> >> value is
> >> (ld) CC=3Dcc LD=3Dld AR=3Dar STRIP=3D RANLIB=3D
> >
> >
> > How about
> > CROSS ?=3D #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> > ifneq ($(CROSS), )
> > CC =3D $(CROSS)gcc
> > LD =3D $(CROSS)gcc
> > AR =3D $(CROSS)ar
> > STRIP =3D $(CROSS)strip
> > RANLIB =3D $(CROSS)ranlib
> > else
> > CC ?=3D $(CROSS)gcc
> > LD ?=3D $(CROSS)gcc
> > AR ?=3D $(CROSS)ar
> > STRIP ?=3D $(CROSS)strip
> > RANLIB ?=3D $(CROSS)ranlib
> > Endif
>=20
> Yes, this works just as well, do you want to submit this if that works in
> your environment as well?

I will prepare a patch.

Thanks,
Peng.

> --
> Florian

