Return-Path: <linux-pm+bounces-23481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59689A4FBEC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 11:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E721888103
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D492063EC;
	Wed,  5 Mar 2025 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FqsgI8T9"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6971D6DAA;
	Wed,  5 Mar 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170575; cv=fail; b=ARJhUO+wu/RB0kDCUc0O1BVhBe2Ap3GotY2j4rahuzLPCP/43g3QhGsbPx0P4GiSpApV5FZNGYyP3/BF+4d9cegEA8TndF68yRdHZXhj3X30HFXwYggUdgC5If05QiFWSL5j9zlZlRbkJEeA1FTb72NEbd6tUyjXXBR8wNoTKnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170575; c=relaxed/simple;
	bh=jJ5WHUIQi1BwWvXxbKANu/eyLhUD135JVNCESaU5t7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=br8155GgJUcuT255oWKTIMAJ9NqNwDc8qE+WYWh0TsqCnI0kj8+FqCNE+WEokTn8pND3GRtB60zDwFvOdfhO+v6xvC229stuztHohb2RvK9JZOCm8r2M5/yNezszsGf+geBn9eirke2rqdCmjIC3YdgKGi5Hpv/zrFBrewij0JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FqsgI8T9; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayypQP90ShSQQ4vG+z7s8jN5nkIlY/qrspNTSf0Enh4Bf7SxZ09URYkpNkkZPy9bxd+sJ2447hTaBXHTO5p3QSZp4YOdUWtHZJhSvSOEMLpkju/2TwPrWuYTGqjO1TLoSNg2vgvj2FKW+wLFb1uWqE0LGs8+VUBnqmii/d7Wjlgy6fr4EOFRYNGxGzkbJA3qw1Td2fq+o1vAkudVV9A2ADvQzWB0Czk8eEMMoobylvbhuA49bL6b8eWdg5DU2QB0CPt27TXiyp/C619txnYSk6iSuJQkX+sCxYbel4JeKgofxEKge7JnNTUyLEs/pjtTbr60uhHg7MN+ZhhnSjq9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oQBv9DGX5MBjYgZKt1qCzyNby2mcL2ak2VbrbY1MiI=;
 b=k3XRFuXzkCQ8xoZUS9ma8G8l+deAjq7KpoIR+EveZbKeP2yztJno3/QJ7ZtJCgGXakaSyPFlxzhb0jOSBtI5iKuTrJktVpUm7tyqFpTUM3F1pl2XhJF3JYy/JeYrxrRnwFdPdRBg4K4DF005SsHhFIM5FS6A+AaKCw+Sx+Igj+gjlXUP+kPPFoLBwGWocSarlb/MyUAT59pPvcMcdWuqPnw4s0yCXq2DTbkO24UCc/xH8ODOecvAHRsi1WTRLl+VvgaTMQwwRdyuVICnINiGIpBwqNOG60jek0t1uGbYwPyb7qNzPI91BLDXJ+qu+lZWVOl9AJRtNg08n/ymPN05sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oQBv9DGX5MBjYgZKt1qCzyNby2mcL2ak2VbrbY1MiI=;
 b=FqsgI8T9o+x7HrGvIsQhbACbyInG+/j1gb7UhGX36j31/khDLTK3iDoaU5jxUzaYLSNeKEocrkWXYorwAqly0jywf+OY2pbbDFimEzN/FjXWyLADmeA9PBSGq1QifPvTaX5YtgB6/J0VwAOZP7/W9KKvKWqhg0yd/1ZdOhxSs3lPWdfObe0TOqmh/18hdMI6X2OrN0UPZjlDg+zCAHB9T9UKDRqfIdnU9crkikcY+ZkEScr6nUXoavXXhkQrteFGFedPApCc2g3QNMsfVOD1XHqUYV8fq14q8GTpTT4NWKYPqPb4UJRXetHgtBE60P1kajqkGfO3GzlIR+u8m/jxcw==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AS5PR04MB9729.eurprd04.prod.outlook.com (2603:10a6:20b:650::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 10:29:31 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 10:29:31 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Yuanjie Yang
	<quic_yuanjiey@quicinc.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "d-gole@ti.com" <d-gole@ti.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"khilman@baylibre.com" <khilman@baylibre.com>, "quic_tingweiz@quicinc.com"
	<quic_tingweiz@quicinc.com>
Subject: RE: [PATCH v2] cpuidle: psci: Init cpuidle only for present CPUs
Thread-Topic: [PATCH v2] cpuidle: psci: Init cpuidle only for present CPUs
Thread-Index: AQHbOzhFh9gfrwvKcE+pYcIsioxEIrNkuiWAgABBTwCAAACKMA==
Date: Wed, 5 Mar 2025 10:29:30 +0000
Message-ID:
 <AS8PR04MB8642344F9CA6D423D068E46C87CB2@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20241120103749.1450017-1-ping.bai@nxp.com>
 <Z8fv3X0Pivh8zbMg@cse-cd02-lnx.ap.qualcomm.com>
 <20250305102542.36q7lmctx5jm4mg7@bogus>
In-Reply-To: <20250305102542.36q7lmctx5jm4mg7@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|AS5PR04MB9729:EE_
x-ms-office365-filtering-correlation-id: f77963b0-28fd-403b-6fb6-08dd5bd09d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aMFjdCHzy9JSyY1KtHSkPbN7nyAUgbUYLiUddZu7eeAGfdsnkcckl2Gjx+x7?=
 =?us-ascii?Q?58ocoJS0xe5+HPH5J28vXhZBRyouYpDGLOIFV3PP1+7c7WcuR93UlGcLK3OS?=
 =?us-ascii?Q?ctr4sTsUXqQ1OJ6+bLrQD328i8qS26W2LCsB/BIBRIe/uj8ZevB+U9xCfa2v?=
 =?us-ascii?Q?Cb11lfbdEoKfQvBm1zlATeMnBRjXnyqQMHYvKMNt/DuFNbSTuxHpJv+5hvto?=
 =?us-ascii?Q?OF838H4I9pHN/F7tIerQNN6IMoapsqQQ2++uuombfbMVU2syonOX/dKh2yj0?=
 =?us-ascii?Q?u6HJIfvNlr7cZw8OzF0Y09+xTH62UmKWOehYS78gfAih1KP4q3d/jcEi1Mc1?=
 =?us-ascii?Q?AooGN+UVcv7hlnd03jh0se3CEFNMZN01vPTZ4upVsgjH+4Natc9OBODoq76o?=
 =?us-ascii?Q?ApLfc2kkUTC10ToqSpwUhI2Sb2xSeVKxK2ZYqq2YyxhX9nRPS0Y1OjaCvf/a?=
 =?us-ascii?Q?jje2ZTCPKwBqWmU8H5i16OiOhKUZ8DsK36pigOLi7yL9qT7paCXWpQOzqkPD?=
 =?us-ascii?Q?SRoAOCsKZIu+xmnpskE5CWNk6KaP6l2aMJCLBWy5+WwTv/QkM6yMudojwoC0?=
 =?us-ascii?Q?vhVGtEpHCD4TU4/9xo36Wz3DWBGy7uDuw+DJie5TGz1fiA5klFr5O04d5awS?=
 =?us-ascii?Q?9N4u56neNzESb9Q9NhyfJWYMCgXQoBWze/0K+PfoCx/qYVG6l2cuu+U6UkXA?=
 =?us-ascii?Q?r3NQSxPdLa/xMIP5w/rkQUkVGSdMEU7LBSOhDgdSMivg/3aCapDsrvnIkreg?=
 =?us-ascii?Q?ExPfO4tkuzj2g5pQ0R+TsYftQgi/GZgm9RfZgRTa29bVm6Xk6AhaNYLZ2fcq?=
 =?us-ascii?Q?gcC7AQbLuXS4fjKza0UEvs9u4jFAq1eY84X5qw+OdCGb0Ohpf3n/PhpQy0A3?=
 =?us-ascii?Q?bO8pWj4xo9RFUWrxtEvCSfTN4DZ/lj/bEWYSWmiVk71E97vWIkuGTRjTgFwx?=
 =?us-ascii?Q?2lUw35mdY3IADmfY6nAVuifBqnPxdsn9nRk0tPv4oBTRy0wlJG3jDw0ShH/u?=
 =?us-ascii?Q?N6QDh9XhHNcmslcgcFvyox4g3nX8lQkII8POEkQg+0nfqgEj1fVYTnN8W3yP?=
 =?us-ascii?Q?P8pQk5sbXSTFf7BegiI1J0ky5ri1L7KK864L6IpDdOhubGeU2JxKKw2dWOR8?=
 =?us-ascii?Q?1GGXi8/78FrtatmIcacfPofcb5mFNvMU/wn2WIzufHBp2ZCVa5F1kv4I6EBs?=
 =?us-ascii?Q?J8WaSiw0vuQ1ZjnXgIL0q5eiHAFrDZQJ5Idrp/OEiOdEbx3DcJzOSFTWm4Gt?=
 =?us-ascii?Q?dM3MfGz6MlZjSEk3wVNdM97GZs9RN1Wr7cMd+J7FA6q1oEXqTHnDjFk+x+H5?=
 =?us-ascii?Q?e9SA5+oqT3oyuDZv5Z5LShOkLC5H9b1h7DyHuNQkUUUMbfSxRQGMbwrrJP7A?=
 =?us-ascii?Q?WnFXQzPSm3Lm/CBk1m1dgG3b0GD4it2wPVGQg6w9Q1FhXT5o1sUMoE2MlP3a?=
 =?us-ascii?Q?rLt9MsICizZvoZhfFzfbzp491w/XVWc6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xc2SMo88gfcZ81+EnENaucEmo7Djwt40l+B43ICbNksVF7Cz5sbYYPOH7FGK?=
 =?us-ascii?Q?ReAPxZ9mJX7/3hohq0jnZwE6ecqVbKbyuLF2eAs9Ct3L51I6a2a7INIiLyaz?=
 =?us-ascii?Q?UsufVaBWGSXvd+aw4VS+4NIJFhvpF5sh0CWHF8kB+HIZe/GkoRdfL/YxWMrp?=
 =?us-ascii?Q?3qA0vFRw/ExwSCikCEwlf0yDZwS7pzNfwbBMaBvp9UrcB4zQ459aE3pNC/Xj?=
 =?us-ascii?Q?1OSmcoR5hNXzSmJklIfOIMJRAIzr/coo5Fv38aHR3Is6NRburiDHlSRvHI7B?=
 =?us-ascii?Q?LMSEDD0NgMEWAlNSCLdnN/KjHdLYYtjH/bRF1NlEGICt/cTIGslfPo8c7U3m?=
 =?us-ascii?Q?tUniI5mXV6J8aCJxQ/PxRV6C/AF8P2TfmRCYnJp0ZvhyL3ARY++k/vzUIV6I?=
 =?us-ascii?Q?FETX7MQ96035vASKw47jkti+5N9k8P9HJzUhlEWjXj9fo+E+3U/4rqxWq9M+?=
 =?us-ascii?Q?WwNMOe41LJm9uusxIMcbLLXSfnbjpus+wkbSmU0FF8XTdgv9xbCqGDiFBuEx?=
 =?us-ascii?Q?uB5nFcrwFGEnY0CwFDeC4+Qon9cBf7BJV4H1u8IfHzk9tsztLc/xlt6uHT1b?=
 =?us-ascii?Q?Ebyl0C19qdyp7xmXBDPY2fFB+lvJ4ueqOOQiX+dPxWasKNLSCJIKQbfXaP+l?=
 =?us-ascii?Q?bxPE/ZQsaKKMRBaeQVJL45ZIl2pokDk7RA2B85Mb87ksK8wou9V3SdIR3Tqf?=
 =?us-ascii?Q?+aie1QM4khPDI9Atof+lV1MwxYUWroREnf2AyWV9dXRI9NCrv/vJB/yNWcJ5?=
 =?us-ascii?Q?vGrkWusIFXVyod9Hgo//wB71qegcclioEtYZ5Im6phc4VM/yGXCJVMQ/I4P9?=
 =?us-ascii?Q?8EwwkAtA/ldhpNOe69aAbHajhtrOoknj3YytJSrFpHDZak+YRkHnWLTYn8qj?=
 =?us-ascii?Q?ojWlLPnm1YmcaRaEGsXn74DZ42lI8e17F1HfaPXnY1k8H10bF51zsNhsycYV?=
 =?us-ascii?Q?BXdHwhDmYrp8Ml/nyIqcFcen2UE9ZKMhGPg5qTcuNeV0AWBBdceoxuI5hNj/?=
 =?us-ascii?Q?So87Nxm4Oi5GfqkNu1A7UnJVLLowFmUC+9ldJ0tQV/aFAFyI+nA12v8DTitP?=
 =?us-ascii?Q?6Ipa8/Rk/EeOs63eoxec+UUUCYA9BZT7GaWqmL6+ilfGLkK/gNv1vN9S4nAd?=
 =?us-ascii?Q?53w3Qf1G3rjxNzxyZI3UGJuXw5cfOHOwN8n4QSCSNsd3jp/6B+h7pTdkKQSR?=
 =?us-ascii?Q?ej2znhOss7DxzOxBDarv+BTXrra66YLmQPRCyEk32hO8gr99fASPdu5+DEQs?=
 =?us-ascii?Q?4ueIXbZs/KjHrW/ps8egFUAbL1ezrq3hvUfcq1kQ+2NbRbyh4u6EqIjMHU0W?=
 =?us-ascii?Q?KrLQAjXix6Awdk3OTUJ3NRuewA8Ic/mwsbsnpJQd6rvcYBqXFYk3IgH/X33A?=
 =?us-ascii?Q?xP0t88pHzEXATsgq2CT1IIRx+Fe6STrgt2GfL4khUyU9gm+8k+hcWDzlgytP?=
 =?us-ascii?Q?ho3HrPeatr6698JTTIJlKloAzRzS5f2okQMtsQpCq1ku+VU23kejonK7y0Tt?=
 =?us-ascii?Q?6FD9C3WXiPdpFz2+xNiuM2ECiBGuCMGClH3jP1js6zRboQ5JXDy4Lg50Egs2?=
 =?us-ascii?Q?nN72dac9anWVaUyp3N0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77963b0-28fd-403b-6fb6-08dd5bd09d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 10:29:30.9779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grN4N7hc6vl/iIM7HGYjgS2feEZTgEygQ3VDi9sDEvcDnct66cBxGqf2VyACt/fx8w22dNq9dVWbkB6c4ru4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9729

> Subject: Re: [PATCH v2] cpuidle: psci: Init cpuidle only for present CPUs
>=20
> Hi Jacky,
>=20
> I wasn't Cc-ed on the original patch.
>=20
> I was searching to provide feedback but couldn't find one.
>=20
> On Wed, Mar 05, 2025 at 02:31:57PM +0800, Yuanjie Yang wrote:
> > On Wed, Nov 20, 2024 at 06:37:49PM +0800, Jacky Bai wrote:
> > > With 'nosmp' or 'maxcpus=3D0' boot command line parameters, the
> > > 'cpu_present_mask' may not be the same as 'cpu_possible_mask'.
> > >
> > > In current psci cpuidle driver init, for_each_possible_cpu() is used
> > > to init the cpuidle for each possible CPU. but in drivers/base/cpu.c
> > > ->cpu_dev_register_generic(),
> > > for_each_present_cpu() is used to register cpu device for present
> > > CPUs.
> > >
> > > When boot system with 'nosmp' or 'maxcpus=3D0', the cpuidle driver
> > > init failed due to no valid CPU device sysfs node for non-boot CPUs.
> > >
> > > [ 0.182993] Failed to register cpuidle device for cpu1
> > >
> > > Use for_each_present_cpu() to register cpuidle only for present
> > > CPUs.
> > >
>=20
> Can you reword it something like
> "
>=20
> for_each_possible_cpu() is currently used to initialize cpuidle in the PS=
CI
> cpuidle driver.
>=20
> However, in cpu_dev_register_generic(), for_each_present_cpu() is used to
> register CPU devices which means the CPU devices are only registered for
> present CPUs and not all possible CPUs.
>=20
> With nosmp or maxcpus=3D0, only the boot CPU is present, leading to the
> failure:
>=20
>   |  Failed to register cpuidle device for cpu1
>=20
> Change for_each_possible_cpu() to for_each_present_cpu() in the PSCI
> cpuidle driver to ensure it only registers cpuidle devices for CPUs that =
are
> actually present.
>=20
> "
>=20
> With that, you can add:
>=20
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>=20
> Please cc Ulf Hansson <ulf.hansson@linaro.org> as well. Either him or Raf=
ael
> can then pick up the patch.
>=20

Sorry, I should Cc you in the list. Thank you for your suggestion, I will r=
esolve it in v3.

BR

> --
> Regards,
> Sudeep

