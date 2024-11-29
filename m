Return-Path: <linux-pm+bounces-18239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE49DC35A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 13:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D947160582
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6733619CD16;
	Fri, 29 Nov 2024 12:17:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020086.outbound.protection.outlook.com [52.101.227.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1C14D6ED;
	Fri, 29 Nov 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882651; cv=fail; b=rTwhDhVM/FkjUKr2MziuCLDmIWGPk9HX5JITew+1P5NVrIYQskCRkFiA9VXkWuKMEMxC4VFanN5YvgJtfPELgDsHKpDfVhrcal6sfrQgvVcBdAHoiHsgPfaM7xjfxga4sKOXi3LCJLZXOPX/OKE9EOoOhXSKo1cNsm8kdrW67MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882651; c=relaxed/simple;
	bh=vyaEs5CsR68foohHL26yaLXBJaVY0qZIFk8E/U4jzqs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mhWWtOSerjdwTXYIcakIafSUD8+whfqLuquQNLopZrxi7B3yF0RUEbUO3SKIUaJatNHnE2V5URX+6ioSNCWkzSEMDN4O8m7VzjHa7e/rUrgfqYRD4PLKHU01IIkOFFlvAFoZX0Ih2jLA8beykJrcTU4sd6U685b00PUIyuyunpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SehGxXNpr7twyCNihbwUtrlj6fU7M0PxU+mHRslMuaaLB2lr7RyLOf9+57PPAcRz7lq44d/G6xcwYzcVWmEpP6+ubIosa4kpHm0d/db1OXAq5P4fWME5zGbqfLnOMA+tyHH6BeBIptzzg7vg8iONm54sULKBuE1vj+yUNzL6de8pa30g5nAljKp5x69phreMdKfTXu2rK6p9jowH3QwRRvr6m59fXdgVn0KX9IK6hL+bkT67EQcSaad/rmC2tkFql7hd353gkIp78kOoTxONF96+td0gHLPmVb7c12ZrKigZBr8e/IBZUyn/XyYdbrX+ZTgUqjNV9ZRFuNv2wQk0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyaEs5CsR68foohHL26yaLXBJaVY0qZIFk8E/U4jzqs=;
 b=i35ol8nbf7IqxejZiRGM9F+akm/5cBPvUIKPrA5vKm/wVkeLlE803mzAT+7pXCG4q+kdee/efzeSHwPcEzo/IChTkzKcCeZesWxAd2NZ/sVL5+qD9Jp+3tveUZeI4VkWKPnFNKg77oy7Bv2M5/rn+/VCyg/EDhjRqfDpbAA7uqKl7Em0+yyJpSLwHd4lnSiwyIUImNZqVm3nf0UdBtRbZGWGk6FHNCuxvhJNVmoCu24Yfwfca9KNSa+AgeEXm5Fb8EgtSuViMcNYfOZ4wgnMnZtnjkK5wplsSJ1QpFr/ittzKNNqI/c419mJBNm2a7M7lcCLlNbZX78orLyD2nL96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN0P287MB0312.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:da::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.20; Fri, 29 Nov 2024 12:17:25 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 12:17:25 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>, "sre@kernel.org" <sre@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Thread-Topic: [PATCH v5 1/2] dt-bindings: power: supply: Add STC3117 Fuel
 Gauge
Thread-Index: AQHbQlPYB+5g4qwzoUOYDL/HkY/HgbLOJJUAgAADVLI=
Date: Fri, 29 Nov 2024 12:17:25 +0000
Message-ID:
 <MA0P287MB11782E233EB153B2FBC5602CF22A2@MA0P287MB1178.INDP287.PROD.OUTLOOK.COM>
References: <20241129114200.13351-1-bhavin.sharma@siliconsignals.io>
 <20241129114200.13351-2-bhavin.sharma@siliconsignals.io>
 <4e8f9526-f7cf-46b1-bdb3-831dc04543f3@kernel.org>
In-Reply-To: <4e8f9526-f7cf-46b1-bdb3-831dc04543f3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB1178:EE_|PN0P287MB0312:EE_
x-ms-office365-filtering-correlation-id: 6a9fadd2-3632-4f91-f3fb-08dd106fc90c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NJeoRN8WYwNF1XCeh7L2fOi6wu/IZeTORYTEgVcQ2ECmhiA6ghJQDyRl+S?=
 =?iso-8859-1?Q?WEMfZeXbISXuHycOA8md+vGZz5LKTbepc0HIsl5aHJxRsbw6vB9ZLVIvNU?=
 =?iso-8859-1?Q?qGePhUTJg4R+4PubLiyLcdSuyeyadH5PuviD+zs+ARl+hXglbXRsnS3N2x?=
 =?iso-8859-1?Q?/QxleYi9+gCsg1hmhutpa6cka+yV6zH5jHDS+opqgbEm9UubJYSMCh2wL1?=
 =?iso-8859-1?Q?azNtkH8i9oQlPtjmJIKCU+vLoTrjemwqAopOXMlcvQYZvvLB1u8LcuMezX?=
 =?iso-8859-1?Q?9h96DmbYro9EbXvleqqVCb+3PBoIR4I6H4dJYS5OqL50uBWTzvXPrIEQcf?=
 =?iso-8859-1?Q?Z6vAmMy5UPiwlSRzBwaJP2I6MPcKoB0KLVyANrEJXKTJBCfslMgLc3f9cU?=
 =?iso-8859-1?Q?eO97KYoOkKz3zDKcG/E1xWt4iWID7nkJy+i1Oomn7E+fVZfZbz7DDGACoG?=
 =?iso-8859-1?Q?ElxuKX70gQoZKqkF8sV2AMESkqhWgBdIM9Zyv+DBlIa9aq8wUxD8/eHPwh?=
 =?iso-8859-1?Q?Xt9CZmDL6W9Fd0qmxaAshK3we32s/buX7u/NzsMwVhi/TrYL65nzLkWkbv?=
 =?iso-8859-1?Q?gJoTimrY+kEozPK2kR454J2vzK/MN9nlXELH9RmA9R4fM2RWsiEkwni0ky?=
 =?iso-8859-1?Q?DsiKESRQyRL8YaZvRNNLLSPSbj1FMyrkWw/xLK/zrRQLM1QuetgSzvi+1H?=
 =?iso-8859-1?Q?h3NzjqpKavpotJuo9ap3xX1FeIgScjMzEzodJxX0Jipu0pY34YJqxvWUc0?=
 =?iso-8859-1?Q?dXrqOpyKTBwGQXCVOo2XN3FY0i0Tf5E9aTDft4tWnZq94dQyHlxWIGxUdS?=
 =?iso-8859-1?Q?1tnsLNkoNo68U8Yb+j6SZs55V0wdUpyCCChsgTImlNCRQEpAZVrv4KaxGz?=
 =?iso-8859-1?Q?RjnjjB/pvoYeJoQkIUYV3AojAokQ8ShZJ6z0PhqLlyRGrDwAsu+xNxR4nA?=
 =?iso-8859-1?Q?vEQpPOUYEuvpkQrfA10Yk5kUETdmVv2Bekgxh5/pvbZkpnELHw4h1vOOcK?=
 =?iso-8859-1?Q?bsWhl5C+EhlDqAA5RFVmh3pbTcSWenjmjiW85klaV8O2A4+8jpitGVyDU5?=
 =?iso-8859-1?Q?tFEPF9hlWPZ+UrWylgrwzXrd7bKL5nFYtAW3fAw1ONNIkThj0XkaP/Mhbd?=
 =?iso-8859-1?Q?0HOWcbCNj17ub+roBFHPGR1e0KNhLr0QqKInKFFlJDJxKsqFhYjAzDYvlS?=
 =?iso-8859-1?Q?324lorpGviU5hzFm9gSMGQ1r/qpPcl95Vo9GwHa46wobOsi24+SUc6oKWa?=
 =?iso-8859-1?Q?/pAZ6/NBtkDVxPxGG8kvLrir8EG+6DbWfMKeimdNdyYxzQlUtyvfCO2CKC?=
 =?iso-8859-1?Q?9HXUOX+VDUm7aamZuyZjvrf0C+zNRkfI7fxxrrlOV23fo9Kjz1Mo1Ztuob?=
 =?iso-8859-1?Q?0tzvkgUQv/EtfXLOOMiuW1cjanbqcQTcPUCsf64xEBmY02SqE+o3bmXpxJ?=
 =?iso-8859-1?Q?DVRIBiN8EdtTFMOxJbmo1Lha3cgIxl+JdSbSMg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?q12S6ZIcy/Z++j9YSyJkKxEaVXeQ3oq+6aQgtai8yvR1IrUIQdP7vPBdKf?=
 =?iso-8859-1?Q?eZqbM1QHZvp+bB1ZlfYQAtfHahBwl/T/FptWChjCIBs3Y+y8XJLUUYTN3Y?=
 =?iso-8859-1?Q?LvfRVKzCuDucOLibLGDqERZmRu1QX9EkEX06UyKtkl6a/szVWiDNBP53z7?=
 =?iso-8859-1?Q?Q5V/6+M6Zh1sx13E2rRll0uXk7SFP1Vc5xdF7QF0dWzpcEEbg/Z+HRHWhk?=
 =?iso-8859-1?Q?qyQaMFKWvB7YFSpMZ7JSMqpR+tG6jsCTJc8GT21JfVcJA9RV1OyH8Gqt+I?=
 =?iso-8859-1?Q?dghsk7W/EXbDkKQI/LooUD2BcYFFU7egIiGjfeZ4PCg+JPC01JCSGGv2wh?=
 =?iso-8859-1?Q?/pC0gcsQB5yeDr1DrPZNOhfE0KFs/dWbyb2hwA93KDytKMuPanmJ2U23Lr?=
 =?iso-8859-1?Q?FYcCD6bptBqCIBM4BdBjxdxEuvDU9dXzyZREftSC4FceFV8UafWpAMoCFp?=
 =?iso-8859-1?Q?TJfyYrq9l+4+woaec3V3qTmbxiVc2HTZ7abTyvxHvJv/8AgQrQW3fX20YS?=
 =?iso-8859-1?Q?7J5lFu4XxRm/D2PduQlM9aNX81zdJDOfjPZJnKos348fO8joNYBDUVxbxh?=
 =?iso-8859-1?Q?vH9r/dCDDsFijrq/9ATN0RiEh12nHaDznm+czxpD80oUdATK4L+ovNiFkD?=
 =?iso-8859-1?Q?p2bax56xyHYGvvdS5S/kHmx+Ea3j8OL1pgz2PANmZVNtqzubnUfWLCe8K1?=
 =?iso-8859-1?Q?any3n/6NtyXXl/bNoeCHDpvNOC+Ey4/KVh18Fn4aI5xhi+44bMscVYXtnn?=
 =?iso-8859-1?Q?/qqSz+8YXZYdS2qe+3Zq0IYcfcuPaBHR0IgkJfdnL7y9Wq0TaIqcF0ynJs?=
 =?iso-8859-1?Q?qvFBxRLIYkMvVav2essVidV0xs8TgKgNtRnGqBnPSOFXoXadtiStK9eYVu?=
 =?iso-8859-1?Q?NukR43x2jfKP4OLgxeWFd53RC83wODsjyx2dXrBvkhX12oB0cNv80AfbME?=
 =?iso-8859-1?Q?/FXdM0Un9u8j+IPYEWqtlzqCnj1R51awX+rLtDzlwlWg9mbfb8PCyWbQir?=
 =?iso-8859-1?Q?HOz0bEYBC5Ei+zgZH62bVtyeUgFP7YGyVDRN7UxBb81XOoxQkpOzeHEMeG?=
 =?iso-8859-1?Q?fvif3RFG5HnaYuyBnScFBMVefetpyY5hDr20NnFhNG8ZG7jmKhff6gx57K?=
 =?iso-8859-1?Q?x2WWw0JHB0JZXOYYN37z16YOtlHk19v+2hZsiQak2JO9ClICPE5+lmFc1M?=
 =?iso-8859-1?Q?OsJJqhZ0lXsvmJztDGW8Ve4XsKLxvIhEPwk425jOrIIsYs4UfcsQ1zLd98?=
 =?iso-8859-1?Q?AQWlZDg5H/rmgBmbZinT4pmzvRZWT0ldTJUozULJgo1GIJPtNEJMfinufQ?=
 =?iso-8859-1?Q?vyVEjmyWwFGR/GBMzgXkiMYVF+XeI/wsPVKmir+m0Gd6SxYx7PpBUmnSv/?=
 =?iso-8859-1?Q?BK3P9xmlYuEs9n8kcMIKqB78FAVXWslqEjm395S5Yo5hsvk/0T2uUyOgfp?=
 =?iso-8859-1?Q?jgQeQZtoNfhwvp5Ojif4r4FFKE2Ynbvnwnf/3AjnYBpJ40qFIjR7mGjLIg?=
 =?iso-8859-1?Q?QiJ1MqkC+3pjNlileJ41u4aXEnOxqrw9jcDF2GeWoG3I9ZCMACK4ksS1+q?=
 =?iso-8859-1?Q?hd3EC3ZjL/9NUl0X5K6k41uPmbOUdn/hnDBs0HYQRX+jc1V8vI/jY1nSSR?=
 =?iso-8859-1?Q?f9Pwc3tfaryaUl7+UcBYBC4SP2RC1xwsEGXsfK77717uHjoqgWC3OZEA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9fadd2-3632-4f91-f3fb-08dd106fc90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 12:17:25.6903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JofuS/05ltRNdRSX8xkMC9xe08xg//5JLnqEwSjYnEQhON4AUP5dXku+d3P2Z07/QzT4kytIA4VYZYMjoUKdpohItg9+G2mGDgbK1IsqzGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0312

Hi=A0Krzysztof,=0A=
=0A=
Thanks for the review=0A=
=0A=
> > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
io>=0A=
> > Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
>=0A=
> Your SoBs are odd... second patch has totally reversed path comparing to=
=0A=
> this one. What do you want to express here?=0A=
=0A=
i will correct the order=0A=
=0A=
> > +=A0 sense-resistor:=0A=
> > +=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/phandle=0A=
> > +=A0=A0=A0 description: Current sense resistor in milliohms=0A=
>=0A=
> phandle cannot be in milliohms... Anyway, use existing widely used=0A=
> property: shunt-resistor-micro-ohms=0A=
=0A=
okay=0A=
=0A=
> > +=A0=A0=A0=A0=A0 bat: battery {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 compatible =3D "simple-battery";=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 charge-full-design-microamp-hours =3D <2600000>;=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 voltage-min-design-microvolt =3D <3300000>;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 voltage-max-design-microvolt =3D <4250000>;=0A=
> > +=A0=A0=A0=A0=A0 };=0A=
>=0A=
> Drop battery node, not needed for example.=0A=
=0A=
okay =0A=
=0A=
> > +=A0=A0=A0=A0=A0 battery@70 {=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 compatible =3D "st,stc3117";=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x70>;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D <&gpio0>;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <31 IRQ_TYPE_LEVEL_LOW>;=0A=
> =0A=
> It does not look like you tested the bindings, at least after quick=0A=
> look. Please run `make dt_binding_check` (see=0A=
> Documentation/devicetree/bindings/writing-schema.rst for instructions).=
=0A=
> Maybe you need to update your dtschema and yamllint.=0A=
=0A=
ohh yes , need to add bindings for interrupt =0A=
=0A=
Best Regards,=0A=
Bhavin=

