Return-Path: <linux-pm+bounces-25589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA0A911C0
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 04:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B18C1905197
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 02:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C719F133;
	Thu, 17 Apr 2025 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y9cUPRTK"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22640A927;
	Thu, 17 Apr 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744858011; cv=fail; b=GqvuryLA1mPmU80rZ+6ouOnlM6U7/ULwGQ3xXLrYS+MF8uy0ZfD5ppJcJqX+MrhkuXq7kRL3m/4SyVVnhKSLy6QdyyaARLj4jy65ztoelKMyWzZpWDzSkIFwZM29y8nrR0R18TDII4tv7+aR2yv9RlW93ZM38fxROP7J0X/kGx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744858011; c=relaxed/simple;
	bh=znBlxgakLZ/AmMxGefHVQQZyjYqSJp0vSiliqWtlwRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=peeHXSqskULFxbVL8KKqWWRpb8u2VDfws02RmjCg+pDdI49BTSbG3FJWPyBw6ZfGF2PYSu5eH2Uw9yi/vZrCBgvOaHn/CdAVog3XH6npB/YhL44bSFGfeHkf0vUOmtLT8+BSePtZYJrA2ow/tR+rGrNsG9SwF/ARD6dF7h/1YCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y9cUPRTK; arc=fail smtp.client-ip=40.107.104.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8x4c7tdxwKuJbfqxdEOBiOdj5M2QM4jOWG91j4wuE/aL4DW4IG1Z+FTxfWgV0Njaq7j2KV/iLeZfLlPxwbiCUBufkz+xyxITvQEmexep/vOR1ie6Hp4Yhdp7QQxtY/MKlgXjo+8B0E9OgEF389cj1bzG4kvZgmhu+IK+2+IJ+CdfEzIfth/IcNPPgo+jUfH7+ZdgcfuFWxeD493VTvLv1gYnvn1NJq3kNts4plI4EIU0+m4FwM/zm8veuS+GJ0Yv5Ir2Q+id2uIjwZHOMnZxWOYAg2rFNpJck1fqORUxGk29QhgBdy9Ew+15uoJRiI8p+BRAJwZDaN1iNmx7VW8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2I9+yRdECGXc4QhVx9vEQVtKWWDLfVrdSc5y8P6ivyE=;
 b=HEZ0AhwgTP3YSs9XYmOvGauheH6hJlBXNKutEnhrpqYa8dXxqdSwKoO681tkCVAQKzGkV5nY7nhIChwJr1C16vTH14FVGZvjkKiKZaFeezSpa+nlURs3Dnbs4JvUjMScGQXiCFYg9CdcVnRvbSwITWsCYgJnGc5+mvNkAuybMIkvHrUCX0R0VKzAkAEWapwRqdbFv56zdkuSCNbvAdXVFivgBpszdZYBD8QETu9xa63R9n9AiIoB3HkDUGiJdfqqq4ltMbQrokHnOAAVTlTGPx1VXczpg6brwSHgSw1tI/Q/rdhYTPG2+8/n3e7FuRtu3yacpBrg9CN11ZYifjn3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I9+yRdECGXc4QhVx9vEQVtKWWDLfVrdSc5y8P6ivyE=;
 b=Y9cUPRTKt0gJ4fFBf19brUTvPgTkkrKHDFKuxwCCLHPWXHyQ3QdN495223gkXgXoSH2KsZE8nZEugXxpv82lgiZjh18YBt5lCkxzJGZ5lgSNB+EbfUtB9DkGVp94rP2c84t17FfBtZ7aVyflRb1NDriuMM9S9XtX0BrGmLIb/rd6xWiqtSC6rJ2bdRlc5FbUdSvXnA5S2jqQ3ASIaciUNFEh6BeXGXHsGPXXN4ZA/TzIdXLrMR9/BIjVizwqedFn7mR4BpEKyyLMbO2Rh0E7gMieGtskxpYtWdKbNmopJ4+xFaEKmeBOIn2R2jw2a29LeiRiXZgmhWh0j5Pgrp5fDA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11011.eurprd04.prod.outlook.com (2603:10a6:102:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 02:46:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:46:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Hiago De Franco <hiago.franco@toradex.com>
Subject: RE: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when Cortex-M4
 is running and it was started by U-Boot bootaux
Thread-Topic: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when
 Cortex-M4 is running and it was started by U-Boot bootaux
Thread-Index:
 AQHbpWxIyVwHrK1A2UqE7zPASmzQ0LOedbwAgAAHyXCAADO/AIAECmYAgAEXKACAABeSoIABNmSAgADjngCAAOXrAIAAT4Cg
Date: Thu, 17 Apr 2025 02:46:46 +0000
Message-ID:
 <PAXPR04MB8459C8C64D90F1224C1C189088BC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
 <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250414224452.gk4ccniqtumfbjth@hiago-nb>
 <PAXPR04MB84591C4D560C0D3D64F927FC88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250415184009.2fvtn7tbe6uzwiyg@hiago-nb>
 <PAXPR04MB84596E1E47CDE57ADCE9B40F88BD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250416215744.6c57a3oqgt6zkeew@hiago-nb>
In-Reply-To: <20250416215744.6c57a3oqgt6zkeew@hiago-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB11011:EE_
x-ms-office365-filtering-correlation-id: 45c6a52d-a99a-43d3-87c8-08dd7d5a185a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XnTomF/13kID2U4aQ3uvkVSEf3zJ/pN65gnfWFs962oBdXZEkleT3YabMc4s?=
 =?us-ascii?Q?uumfL7IQnkxE44Ubf53JYZBDUZ2hPjOICEPeoUFmqpctVrg4hnX5G+I0bW9V?=
 =?us-ascii?Q?mMtxkl0lYIkw5sbDDZuPFUguiqqmbgyYVmLhnPC0jG+N26dNOVKedtl6u+et?=
 =?us-ascii?Q?RBerJavUPIJPrJryf+0Zs7b3iWkU8hp1BtbQKc82i/dTZZbZxEE3UehTK+rw?=
 =?us-ascii?Q?jbt5Mf1VJWq6wbuC1wijcKuUFGH0rGGSHDOD8OuC8yDh9ncZX54t3uYIAf68?=
 =?us-ascii?Q?drJTWE4aUlwUzIk2M1VzHCFzIh14xr+iz9fZony6KS4FmuG1qYp3kaGrnbOs?=
 =?us-ascii?Q?rAjkREa2bhZZLrNovgoN1Ok9LWMO5MdwxmbAg+J2Bjb3mXbgL6Y2zORDXIl9?=
 =?us-ascii?Q?u9NUy6pxo37/M4SFcgKZCBEjhk3vxll/1Q4G3DSubwjWWFzOfpU159C53x55?=
 =?us-ascii?Q?6QfxwHL7C8DClJRNVAKDci/Vk6mVQ/JEB+fwOZ6JVbVldRo3bwvnmxIRnfbF?=
 =?us-ascii?Q?LaXbs/bZ8gAnStU3Qyp9LMLIn+t17CaXLnYMCRUwQKBa/X0nWLtXBduzBIeK?=
 =?us-ascii?Q?wIgiyanql1QzmpP8azXyIuHdABWFwPm7zbD55lxV0mcwhHMM6jy57/rp4ntx?=
 =?us-ascii?Q?1V9ESF/yLZBQVobC2vlLe4Ogbe3i78Z2G3XqXGumP41ryWPbSM897SLLznCn?=
 =?us-ascii?Q?Nf2dfnP6SWt0hcy3umEuP8M7Xal3fsEbveXwUp6TRSEksUuwG9P2jv4fDeyD?=
 =?us-ascii?Q?afYT/Zhqn4Xezqr99wgUrwLrB0YLCjO4aVZThT4FHG53n9ysfd55Jg4TgohL?=
 =?us-ascii?Q?eUW3rlf48bhNWn7G1Hn3uaVYHp21ARZrCFB8bKc/kUjdspNWFdk/KPPabfxP?=
 =?us-ascii?Q?xIDeWl/WXhessW22aKecH15CC5akP6s4t08ZbElJOd5ttss0S3YFG2Feg39X?=
 =?us-ascii?Q?V8m4CRo7p/PeR4+WKdYr7gjhqjzKKrum/c0QXlqLjaLd67j8DKrDJ97gshZh?=
 =?us-ascii?Q?/QzCqYgT2o6yMEhyp9MJI3RA4fMXj7QYXFJ8+B+5judD8vuaJeuoX4k1OYPt?=
 =?us-ascii?Q?bJed+tCqwyKJWFimq8OY734HEMDC7HhTP3FApTa1KD3hRmeTYs2DpCFJPZ02?=
 =?us-ascii?Q?m3Z2Yr4MEg8ZhpWaKxp+/C08JOUuZngFn1CMurI9wbPLLbGgyAU7Rt6lGpq3?=
 =?us-ascii?Q?rXi5X4dFQDuYNJjWXdVxVH7pn64DFf96mj7SL6fTVuF72ZEeehNL4KOlPPMa?=
 =?us-ascii?Q?bfg8OjKdb0a6kOdFd8VgKbf1HE7+/lu+VfR/dPhfxK+25AQKY2ENAKhWyjmf?=
 =?us-ascii?Q?9nmAIWBPy0aezoPgKdqEM9ddt+9455VU8KbkM7IabY7/L5cKs01y/nB1OJUp?=
 =?us-ascii?Q?SNix9XV9bwqwF/RZYVTMzCVLbs1L0EMFeQ8rcEU6ZxrfG7EYRQ72OKPdIsUx?=
 =?us-ascii?Q?zxy+q/Kvqw+Z2uTraD5vJZ0LuCo8bZCeKP8VKct9s6PIUhVr/KpH5norBSoA?=
 =?us-ascii?Q?GnewHuXC2habqW4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ckoCKpB1LCDNABqQYlTz1zEQ9kJfC5gaRBCR5ZUjWWyMHHUplxoa2OhBV+S6?=
 =?us-ascii?Q?42FQYrczEMKAfXu8+pka4eafgBrd8kwjsDP7tKgYFno6naFZpbruMC6wowVo?=
 =?us-ascii?Q?v5g/I3w0v1kDPG6sEQSv9uigPn1GW12pGmcDtIAb1ucfM3hFL2SbyzacDz7y?=
 =?us-ascii?Q?KZjT0sZI8rVbfQGlgHbNKYFy9ridl1tWBAY2biCCbDPPjS423lYL/agbJmEL?=
 =?us-ascii?Q?czaUumy/cTU487bXc1jdlbqRstRgekTfVmH8H25kjRW1KuSRoWmcPLKcv1jw?=
 =?us-ascii?Q?vIJQOqRVf29bv25JVN25XMw7OpbMgGI5GEKLBRGwmYI3nWxJjmkZwaMIZrIG?=
 =?us-ascii?Q?kkBz0ZtU/TyRzHPrleMgR4y/KUT3zQ6FGv/k9tF5VZ8fcGFRQP79LCC51NDW?=
 =?us-ascii?Q?iZmQs0VzfCx/z5mCC1zsUvh8WYBnA8d+cV9C2pbHxqZcri+4qC9x2jNbwHKi?=
 =?us-ascii?Q?WXfzjFhc0aKX8py4aLFHnAA1oncs73yLDFTUgMhUn8aIyyvj7LyuUb6Gwwln?=
 =?us-ascii?Q?Q3I6Q/jnIJRyyrI9a47MrVgK+rjuiL6gy67EWS+wmhpHZRRsz8jeI+t3Dyeq?=
 =?us-ascii?Q?Aor9V3ySjDZ4IAAiG23LTcQ2qqKoJoBFMwLt+vUE6pppQr3RFP+hPm2mXvNa?=
 =?us-ascii?Q?Sd6Fh+gxSKAZ+GUsgI1DrjQNbh1omOH5bD6tGs7STHwFWU8L7VkRcxltez9z?=
 =?us-ascii?Q?kYaFdVbKLLXYMsydC1ldKxpzP4j/32Pq7I852lY9DYZ8I5s5vc7D9aEDEYDQ?=
 =?us-ascii?Q?qO82PFI5we2OS+e8kLMTZUZr61F3PzeactV7dj5vw6RYvf2YCbhYn9lIF5l1?=
 =?us-ascii?Q?3nGVOdh9tbRAoHFxsKOp3bmpEsDZA7wzNkq/tE70yv8SYTa6xAGZfucb4wiw?=
 =?us-ascii?Q?FCg4p7aIvu6j7RFoSDxoFehb5osBAnrBGznKcRe1rqH6aS3kw6gcrcOPFJey?=
 =?us-ascii?Q?Y6snIsbTMTtkyXrjFBdeIgFhuYuWrGkJsSx0zb1hT6wjJRbhic8qxyoSmNTo?=
 =?us-ascii?Q?YUQL5Q5rRXxjiBNVfhOHwdsJKqHqT0JUtkqpofE+MyKZiljA88MAPkPVp5lH?=
 =?us-ascii?Q?n8MdMWrDkbvgWw38rHJutwdVZ9uxgiY0e7qwWCsLOAMhMkIwoPCiip9I7UnG?=
 =?us-ascii?Q?k0N1T4JMYi5VTHuCt+K8ZP0YnReDNRLsNsLc8INPhz2ltpoMlRgWafiqx/6c?=
 =?us-ascii?Q?qDoJICuMJUI5cTWIn5Kt87K+xgRYnlYxEwgcsz9KJvlpK7kw9jaj1Vn4e0GO?=
 =?us-ascii?Q?UUljo6DxbxPsRvmuL1xBIanpApb1gRBWggfQ4xyXozHSDsWJvwGzi5eLnlOZ?=
 =?us-ascii?Q?u9qKNrtF9FO4XbubipybkJ7TQLFdhpiwGjcI13eyzCKWtIryW9IWXCUXPJih?=
 =?us-ascii?Q?gy0R5T4LZVYHpWgq4AG3nQLDIlCgcyMoVjIn2HIW0rWMcUO4CUUPEtcktdsl?=
 =?us-ascii?Q?jCsWsNYlFshbgMtAvRu6kTky6O0HnNX7cn1fTdbk+by+lthSEGlSr1IAVIHj?=
 =?us-ascii?Q?RQxxtOf3XrP2vVn7r32NXVMoWf436JjfmBVn6HUECEmgMhrS8/5xFa8iKlB9?=
 =?us-ascii?Q?yilX3MxMMWRK5uzCq7o=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c6a52d-a99a-43d3-87c8-08dd7d5a185a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 02:46:46.5517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5id0yo8dew8Q7geR+wARsOQFj/4Ty4ZsqfTtX456Ctt08IVFbIdL3veSVMzki3MvFJ5DgFGYDjOHLRT4cs8Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11011

> Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> when Cortex-M4 is running and it was started by U-Boot bootaux
>=20
> Hi Peng,
>=20
> On Wed, Apr 16, 2025 at 08:19:27AM +0000, Peng Fan wrote:
> > > Got it, I was able to make it work with the downstream pingpong
> > > driver and the MCUXpresso demo. I can launch the firmware using
> the
> > > remoteproc and exchange data between the two cores.
> > >
> > > There is something I noticed, when I start the pingpong demo with
> U-
> > > Boot, it does not work. I run the pingpong modprobe on Linux but
> the
> > > name service is never annouced. It only works if I start with the
> > > remoteproc on Linux, not U-Boot. Is this because of Linux not being
> > > able to control the M4?
> >
> > No. In you case, you could start using remoteproc, that means Linux
> > could control M4.
> >
> > >
> > > If I start the binary using U-Boot, the "state" always report as
> "offline"
> > > by the remoteproc driver.
> >
> > In drivers/remoteproc/imx_rproc.c,  imx_rproc_detect_mode case
> > IMX_RPROC_SCU_API is used for detect mode of M4 for i.MX8Q/X
> platform.
> > Please give a look where it returns.
> >
> > For U-Boot start m4, linux should remote state: "attached"
>=20
> Ok, in this case looks its does not work. I start the firmware with U-
> Boot and state is always "offline". Inside the IMX_RPROC_SCU_API case,
> the function returns at this point:
>=20
> 		...
> 		/*
> 		 * If Mcore resource is not owned by Acore partition, It
> is kicked by ROM,
> 		 * and Linux could only do IPC with Mcore and
> nothing else.
> 		 */
> 		if (imx_sc_rm_is_resource_owned(priv->ipc_handle,
> priv->rsrc_id)) {
> 			if (of_property_read_u32(dev->of_node,
> "fsl,entry-address", &priv->entry))
> 				return -EINVAL;
>=20
> 			return imx_rproc_attach_pd(priv); // <--
> Returns here
> 		...
>=20
> And this function, imx_rproc_attach_pd, returns 0 at the end:
>=20
> 	...
> 	return 0; // <-- Returns here at the end

        ret =3D dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);  =
                          =20
        return ret < 0 ? ret : 0;

It should return with ret as 0.
Because you mentioned you added two entries.
		power-domains =3D <&pd IMX_SC_R_M4_0_PID0>,
				<&pd IMX_SC_R_M4_0_MU_1A>;

https://lore.kernel.org/all/20250411162328.y2kchvdb4v4xi2lj@hiago-nb/


>=20
> detach_pd:
> 	while (--i >=3D 0) {
> 	...

It should not runs into detach_pd, where it fails?

>=20
> So looks like in this case the partition is *not* owned by the A core, it
> is still being owned by the Mcore and I can not attach.

No. It is owned, because imx_sc_rm_is_resource_owned returns
true from what you said above.

>=20
> For debugging purposes, I did the following patch, inverting the logic:
>=20
> diff --git a/drivers/remoteproc/imx_rproc.c
> b/drivers/remoteproc/imx_rproc.c index 592a34cfa75e..2fcc9086e916
> 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1072,7 +1072,7 @@ static int imx_rproc_detect_mode(struct
> imx_rproc *priv)
>                  * If Mcore resource is not owned by Acore partition, It =
is
> kicked by ROM,
>                  * and Linux could only do IPC with Mcore and nothing els=
e.
>                  */
> -               if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv-
> >rsrc_id)) {
> +               if (!imx_sc_rm_is_resource_owned(priv->ipc_handle,
> + priv->rsrc_id)) {
>                         if (of_property_read_u32(dev->of_node, "fsl,entry=
-
> address", &priv->entry))
>                                 return -EINVAL;

Please no.

>=20
> And now the remoteproc driver attaches to the MCore succesfully,
> which is exactly what I want. However less than one second later the
> kernel reboot with the "SCFW fault reset" again.

The resources used by M4 are unexpectedly shutdown by Linux,
as I understand.

Please check imx_rproc_attach_pd, it should return success
with dev_pm_domain_attach_list return 0.

Regards,
Peng

>=20
> Do you know what could be the issue in this case? Maybe the
> partitions are not yet correct?
>=20
> >
> > Regards,
> > Peng.
>=20
> Cheers,
> Hiago.

