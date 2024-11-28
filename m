Return-Path: <linux-pm+bounces-18198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C78A09DB4B6
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 10:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB471642F8
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60F15535A;
	Thu, 28 Nov 2024 09:22:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020125.outbound.protection.outlook.com [52.101.227.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1717BA5;
	Thu, 28 Nov 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785764; cv=fail; b=Td4ugqtJiNSBgbjh7LWsp86605c48XskKVwFGKP52N4CQxfARJ/gM3G00h6Xp5GUlx4Wpts8D5Uh6YynTSkO/6ZKw4FfGwkzqxTGcAVc70YZC+B5fjUmp7iyzjbpEvrJJhSCyGGwfNuZHOk9ZntSZMPI7jZ0RQmNoVQlxeYPdMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785764; c=relaxed/simple;
	bh=LA9Bw57tEtQXuGDdvkKphxmHKLdtokx5AoKXS9OqA+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IqVpVM24IYPI1U4r9tGNc4DdWnFuyAr7lPjIbrKhTti1muBfukQ8PIHVmt51xyOrcNw3IsFo3DTMnzi4Ibf+2/odC2AwsV85DrbvtEwfs1u8A6WA8k+wMz4Y43Du6nP1DR722AhoA5l62cF2mtIy2gG/xrPDJytVpGIvqp894O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFjaanMiM9q3NMQVWWVphEQMKN+SRL5mscAy0MdYiQz5o8+HxCX5P7d0AuH6uo3FZluVshOUbfV8EZr8z0BVOuGl8RdkcKtk7vZMoOcHtRom7N2tdg0Bd2BArBcU0W9kJd1uRK8IQsQNDqi1wzgwqRQ+AvWS23o5aSXfMgJXLOhKvU2U4UAnfJXvvzrhiXEV+MIU1NS5c5lvOis4Ur5pfeAGgZVFiUarovz1prk61eu+pVWR+LPQR+M0iS045qGWmRYgRbCILE9/Ap/fi3NY4TraZyvM9J9oYZexyDQjpFKWfhe3/qujaviE3D8ZPAbp7JL6tD9LnLw+jVNFrS9Lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA9Bw57tEtQXuGDdvkKphxmHKLdtokx5AoKXS9OqA+s=;
 b=v/LjqYvlCpoRojxn/3fR/HWZIhFZEihfVoHCNgfDhsTmAqMSpjn0GpDCIPMFa33TLPiyL9SSQcJP0qgu11/icNTlrYD+Sa893Myv1qFr/ybG2PhErNUE3CVNJVbMMQzD5A9YSwbQHuGdDUiUxXa8kj0AGw1a8Exr+wU35l5DcIkaXVfGhd0P1zinFszmeYo2u1K7byXBCMX8XsBhfSxSKdaq2+4NySzUhD3YIBxW1Tzjus8+SzCaa0/d0xqHvyHEBKCsw0+XBcFuEdcW5yKP/7X3jqOH89DyrXgSo2FtYqzQOSDvGDfzk8yGlu5c7AE6qsxBTi4O+S2QwFlOIqMDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN0P287MB1122.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:139::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.15; Thu, 28 Nov 2024 09:22:39 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 09:22:38 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>, "sre@kernel.org" <sre@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Thread-Topic: [PATCH v4 1/2] dt-bindings: power: supply: Add STC3117 Fuel
 Gauge
Thread-Index: AQHbQOADe5gZwmKWdUmiMoICk/r1U7LLcMIAgADtzICAAAQ9gw==
Date: Thu, 28 Nov 2024 09:22:38 +0000
Message-ID:
 <MA0P287MB11788D277E79E03B6C7E4126F2292@MA0P287MB1178.INDP287.PROD.OUTLOOK.COM>
References: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
 <20241127151953.29550-2-bhavin.sharma@siliconsignals.io>
 <3eb06a70-cafb-4d89-aa68-524ec91e3850@kernel.org>
 <68e7f5cf-ff62-4184-8bf1-6338dc44fd2d@kernel.org>
In-Reply-To: <68e7f5cf-ff62-4184-8bf1-6338dc44fd2d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB1178:EE_|PN0P287MB1122:EE_
x-ms-office365-filtering-correlation-id: c749d907-6173-4eb9-8f58-08dd0f8e3403
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?A+CnxawLAUlIO+iKZRRM7LqHZwyHqKjimAyX9Rb/t3ElSaz8vOVrARfj?=
 =?Windows-1252?Q?2c/qoSHClWKetLABEhRXuPXVZiJ4GV02MXWgoiepDLwaIAmOoXisoyIv?=
 =?Windows-1252?Q?nZeN7oKfXo05JFr5CKStGLnwowfhvPXDbLMwJuLmGNvWAUmjH7viKOBW?=
 =?Windows-1252?Q?tK+HOsj+7m4AviSwoAksdknBUYyZf4s0BnSE5VIPcrt/PmJakiZ4EnRv?=
 =?Windows-1252?Q?nQYHESImD5LHlX1LQfzeY69H/y6JTLGitz0SU0+Wd5pwhq4sU7Vx/zQ1?=
 =?Windows-1252?Q?cQt7YPApmUX8aImwt5UL0bJhEQXf2UM1HX5melt9JAya9f8TiYpUax3a?=
 =?Windows-1252?Q?pGw7SPb1xct1xE26hgNVUSQ19Q29qrOdvDNmnh8GR2vI3KEZU0qKr6P2?=
 =?Windows-1252?Q?92T++w6yYbW34Lt2TNe3a985ki7gEDpJvQSgbqS9/E02UVAk6yZK3m9k?=
 =?Windows-1252?Q?I/S3U/fYa/LmN96VVVKSEQG/LrBfJlCmyqJwZu+M0wUbW7k/peRwgcGb?=
 =?Windows-1252?Q?I5EX+hBy2Npo0O2T17YrJAOkesDu86HBIBjmXe419VaaL8vd/koVX+4I?=
 =?Windows-1252?Q?mdIANXPU3I0WDZ8lLDKIXy4wcbkemNrq2io0UxnYnlSeK0Edq5ElA/UI?=
 =?Windows-1252?Q?iPLDZL8N9c74YCmGT//zn3jnNGkGZ7R3pVmdIXe3BqfGc9LdgSxiDT8R?=
 =?Windows-1252?Q?qqbn9MbaWPjlG8zRUQTlURtMSoRc5SssbFG6YncRS8vrC5vyuBfYzN3o?=
 =?Windows-1252?Q?+q6eg6GlMsGZrNsn1YujrVnSW7X0+U9Jcr6DXvjTFh90QIeLIbH6xaZ0?=
 =?Windows-1252?Q?HNrgbPfGisLLEBkaR/jWMNZiBbhBjTvPKrQZfxU/x+9mPXTDZMhaJK+y?=
 =?Windows-1252?Q?xfjjPC30pU2QEY4xC8oY+f18b2OcYHUZ6Zu22sIAEwOKKpBu/hlAOS52?=
 =?Windows-1252?Q?mdF87wckm1TRADbWny+yocOn8NfD9LXV8PthJ9T4qNqDRNFHSQBWCFZZ?=
 =?Windows-1252?Q?L0uOlWAy2nZ1TK6WNzzMU7iK1a/Lc42pqrSIfAZOIGhfgS7gjZEhToYq?=
 =?Windows-1252?Q?LIlYs59GubufkWw+v6JD/ZAexJQiVYThraFPi4f2XXURLtqhYxU8AI/y?=
 =?Windows-1252?Q?N1PYgNmWlMyVs+No35vcblrPS35z8gl/ydphTiZ/7Nct1KipreGHw57U?=
 =?Windows-1252?Q?cHAcRQPZAXH21lXmBf+5F04wy7JQFXbfcin+Q8SQ8emWaZCmsCqe+svo?=
 =?Windows-1252?Q?WeMkGMN3FYco/rMPp56pX6ve3YMWg03iMUIpjYTfbSqrBGpv4wWtfuMw?=
 =?Windows-1252?Q?gLfh7d5m6r8QquIk0Z6LVZrJ3lSi3LHEO+WGHizynLit/8drFb8f8p9M?=
 =?Windows-1252?Q?Pl0e6bFHkuKLpN+am1kgK/nGsAhz75j2NODQwkugon7HtTXgY3+K+ihW?=
 =?Windows-1252?Q?aYq5dX9Yi8aa5rEUsSY+L7IHvpv7u2M7kTRVr1m2i13+oevPcZXQcDnU?=
 =?Windows-1252?Q?dATvEIWue3cEF9sxWKAhqCJKvrKJUw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?6wkMmp7gEJtLgUEC20onbGK+uP94oElNkgrPnMniHpREivZnZOhQ+w+K?=
 =?Windows-1252?Q?vfgBYSwXSTRhV5c1DReNGRa0d3h9q6RTOf/UHEadeAh3n+KkIeA955mb?=
 =?Windows-1252?Q?pX2nWetq+qz25+YXtSU/4jfcdNXdkVJJkv7W6wYMPQePoCCdL23APBKd?=
 =?Windows-1252?Q?YEJoFsf3nfvtGvRZNTd5kRMWlm0JG4CAs3rSGJUBJlVFuXMSTeE4AChj?=
 =?Windows-1252?Q?h2ewdfXOQXUVbyS8mJQGfd/5zp9JD49J3zoDaHx3hj9NJALZW0e7GOtF?=
 =?Windows-1252?Q?wGV+Necd/0m7xMl5GsCNIbiCJy78+DnMU+UoSIbX4dhlrjcybPlB+hZy?=
 =?Windows-1252?Q?r/RuBf5ffMcfaSUo2oQmXN3LwC6GKWP2Q76Nv9lb1l/LiHGrfPdHVK4z?=
 =?Windows-1252?Q?o9P9yK/kfpPSfPJA8RIXPpsoNtWPHSkPM1kMiP0kzm3Xdc9opk0aCFZp?=
 =?Windows-1252?Q?kaenl0OBnRPKy65fN2+ohNHXwOfRZOVuoPqhy9y/al7MDPpPFvMSEkBq?=
 =?Windows-1252?Q?Nb9gq+gRX0MVJqYK3ScuexOH3yDAFERujWqo7CBOpfTR1ETP00Rzwgog?=
 =?Windows-1252?Q?4HcqQFK64s+CJDBIUCoxNQlFIqvbXrOYsr7Fi9j6rk0d+FeDccvCTW9f?=
 =?Windows-1252?Q?QeM0DVSuGGg6EA2BuToaUgyZUiCa31ifkFZsjlGRmeODDDtZJIL85uBx?=
 =?Windows-1252?Q?XCRmxpHbhPi/IsCZMDXO8F+csraFIrkKAQE7hkS0cTedM4xnlx7rL/Ip?=
 =?Windows-1252?Q?DBOlHNQ1CJHIRcqUj8X1JXc1UAzy6B9fdxb9sUFve1sANiqmDbtTNGWP?=
 =?Windows-1252?Q?j01jabN1Gw48k7i4l4ug+XO5fzqw9nKR5C3OIEDdpfW7oJTF2RZDcpa3?=
 =?Windows-1252?Q?JP0qzB3e9tfv6dENtRCcyX2A4WFbJ0p8iKQiMXtLjEcI8mQzSVVEDcoK?=
 =?Windows-1252?Q?jrN/JaTF8QZS5wcJoZnaPBCUA/e2AV/pBRUDJM059EKLEMAxrhzmRvMw?=
 =?Windows-1252?Q?bx/0mgmq6pNKmVsnMXiJxJGEMG2oHsM5wCrX831ctJ9jRthmu9KH7nja?=
 =?Windows-1252?Q?8oOmYtPoKXg8LmKtettI3DtSupICodpDumicMbEQ7NRnEd7pJJvDHvR3?=
 =?Windows-1252?Q?4HUy6xlUDWuE4yYqyn981Cgsy+mAAyu+5cPx1IKYC1qxg+OY96EuqBwS?=
 =?Windows-1252?Q?I7dd1JSdMqYkA5f4pd3ZH2OybvD4AtRlHjwWT6wAX4Unnqmy/QY41eTE?=
 =?Windows-1252?Q?3eN0doVo1Wk+D0BwQrRMjwbuL+lcpBjPmObl53rJ/OHqM7dGTsf6MiCE?=
 =?Windows-1252?Q?bnlhsLzb+bx2jtjNc05OuJ6U1VzmpljKevcYv5HwAZ3SgxiZXIoZIRdD?=
 =?Windows-1252?Q?wued/NZyyH4zGwT+DrbZV6PEiKL68w68FFwV3B0Q8NBvvqngCYUVCxY2?=
 =?Windows-1252?Q?+RHO6hUSNJp8wlU8VxZU3MuX8Z4YhsRZSb4TngF7SeQgbCiRQqEJ8BOG?=
 =?Windows-1252?Q?x6JHgtPzZzVHu85zvu+QwmUsUQfZEQI+vTPJL6HRRBHQFEGJF7kJVb+o?=
 =?Windows-1252?Q?OW1Pw+lsOmUti8FKXaQZG9MblAmD6IpPVatf75wHxWA6ELGD+Wqb4sEo?=
 =?Windows-1252?Q?4FVPXJIbAKzI1AkLyiDCnhisba5/+hHwDXnBiJ3WRIgPsoQaqE2Uy43s?=
 =?Windows-1252?Q?JZvg129Nc84WUESiKW0C8k4tdo4BkMQ1cRWn/r2pkHXM9KHakMnvhA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c749d907-6173-4eb9-8f58-08dd0f8e3403
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 09:22:38.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSRe+K0U+dJIQRpoUJ6M5tiq9Q6qUNyeLeM0Ch3byEi+KidIBFRjc5fHRV7oXtNb9S7FyCWKPeDpBlt9MOSdhJJPzeNHuPWKjVlTfanwLpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1122

Hi Krzysztof,=0A=
=0A=
>>> +=A0 reg:=0A=
>>> +=A0=A0=A0 maxItems: 1=0A=
>>=0A=
>> I asked you some questions on v2, then on v3 and no responses.=0A=
>>=0A=
>> You implemented some changes but still did not answer my question. I am=
=0A=
>> not going to ask again, obviously expecting different result on the same=
=0A=
>> makes little sense.=0A=
>>=0A=
>> No ack from me.=0A=
>>=0A=
>=0A=
> You responded privately - I am not going to do any talks under NDA. I=0A=
> also do not provide some sort of personal support service. Keep *ALL*=0A=
> discussions public.=0A=
=0A=
My apologies, that was unintentional.=0A=
=0A=
> Explaining what you asked:=0A=
>=0A=
> Some of these are from monitored-battery. Sense resistor should be=0A=
> separate property. But different question is about missing resources,=0A=
> like supplies (VCC) and interrupts. Just look at datasheet.=0A=
=0A=
since battery itself serves as the power supply for fuel gauge no additiona=
l supplies are required. =0A=
=0A=
Regarding interrupts yes, datasheet specifies an alarm pin that signals low=
 State of Charge or=0A=
Voltage conditions. However, I haven=92t incorporated interrupts in the dri=
ver to handle this. Should I=0A=
list the alarm pin as a resource in the device tree (or relevant configurat=
ion) even if it=92s not =0A=
implemented in the driver yet?=0A=
=0A=
Best Regards,=0A=
Bhavin=

