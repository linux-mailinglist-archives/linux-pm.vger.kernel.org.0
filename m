Return-Path: <linux-pm+bounces-40518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FC7D075B7
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 07:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 778AA3008C63
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 06:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A102C3259;
	Fri,  9 Jan 2026 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="puTtccKc"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011071.outbound.protection.outlook.com [52.101.125.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120228980E;
	Fri,  9 Jan 2026 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767939156; cv=fail; b=g1vMQPt/uSdXFqe9i2eINbd9EFoK4c4ehXZKiWkYekCuqIPf8N/v2nNGe2r+dL3ELXbekxOKJEq0oPEnhii9uD7ElVEeFGf/I9LkyP0oLekLndA82JN90wOE++bIKPLdiW4MhUWH7fQYpGty43UHRJThYqoktlNJ1S+xNQ6Z+OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767939156; c=relaxed/simple;
	bh=9nr4zUUDHLGuEbN4vyEJlQabhRPiJ4DwXp7j05a+K8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HG7yJMxZ9jseemjRazL+IbZ+Ec1OKfsOXuymeo8qDuty/LTD/NPG1SBSaA0m6OMB4H+Hg46hzXGhR+L2ZAgiso5QZvymNAcOxzxE3jK+uafuWwXFYXjTKniy0j77Iyd9MkY7acES4YkSwqyYDTR6NrvsoXYIzxxkCHmrmaAlJ0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=puTtccKc; arc=fail smtp.client-ip=52.101.125.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y13id5tR7ZUzOtn+Phwy55lvYA1fxjHl2ywIFPA8wfi1G4wgkoA5YPLbg7gXdhzKa4tUvguNcmun8zMqR4VQIyrLNRLkz6c7MgI6IWU02K+jKltgN/vFWDHypWH6XHnXmBmiO13jchNruQOVbh00QLMdtM0rHs0hQ4Tm4y68ZKz4fyPwO9E+BmD892mdsrRxXaI079f3Q3dAwn3wDTP159P+Z8jeFQ9v7nXjVPdSCowzBSk7qVxAGU8yz4lHlfnfXFj0YstIJ/j4aYt6fTpUW9BBjEnyJ2dWM8beorOLrMK+qR2LJjQvNNQkM6Skz6q01P2HaHIJ74Fer5QZRGAqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L2eQR3IwJrVvM20zpCPLoh1KvON3yFeYIcfmj87MDY=;
 b=jRXKrUFvA5dhxZPkh8ZOtUh8uCFk6ISF9XIEq7WzBaWxbvcG7zan/uLOp22TTUdVdSZusIbcARq1ezCCiHmAyNlp+vwazuEOyI3xeGMDDgaI4qdvZF7/kQ7keUHkSQAPaWY52lHfat6TV2FCP3EZ99a4Io/mQ9LQNOQcEYPTKR5DC9d/1uA+r0TltUuiPvAY1Dd2uf+X2/XaLDDNdOKGVDB4N3LQwhd2e/E4doZ1Va/y5beFX7PqLtMcA/PK+Ho7N65+h6Sh+ceJQrxpBD5NHrJJIyk3Gfj00OIGs3tDLNHl+UvkDYNAkU6sXiONh8DKjkhjgjiXR6pSSDrX8OHhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L2eQR3IwJrVvM20zpCPLoh1KvON3yFeYIcfmj87MDY=;
 b=puTtccKcX+DsDly4wHBSqrqX4xBnlqp1hWr0vuQJ2yfARHjA/Xe5dU06cr36EDPNeRTvEN+l4CeTiiY0jJoZ8u8tfvDx8i8Y13+rl0BClNfkKW9h1uQD42XdYmqax3a0hfutOElkAj+d+MRPD6mjed+To0i3oBlhRQo/RXyKPoM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB14910.jpnprd01.prod.outlook.com (2603:1096:405:253::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 06:12:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 06:12:28 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, John
 Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, magnus.damm <magnus.damm@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcgNjpP7tWju4kVEOD2PeFnHW2A7VJWgkg
Date: Fri, 9 Jan 2026 06:12:28 +0000
Message-ID:
 <TY3PR01MB113464DB06BD82F3CC72B5B458682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260108195223.193531-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20260108195223.193531-6-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB14910:EE_
x-ms-office365-filtering-correlation-id: d1a4c5cc-42b5-4c47-0dc3-08de4f46110f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5QDpKdbHbiyVklSOLRJrfrQZ3lbF1PcEfhuYjY7skWWW2NyM7OaH0VfEdCLy?=
 =?us-ascii?Q?V1jdoLPHQtKDZdaHgAIWUxBP3l61fFXM61zEDWGP2I3NfwlB42v4NGX166ys?=
 =?us-ascii?Q?8S1aFcJvQVVf0zmq/ot9MmQWmez5WtHUkr7u+Vuk0mz8kDjo2vxvu/pJ02YN?=
 =?us-ascii?Q?pGG/+eoMAvvrUjXMNU3MPhz86Uk+1UPOer/xVwG17RcKH0xOrj5D5Qol3CkU?=
 =?us-ascii?Q?qfyisYuGrawjuI4II2FuGsgACzJSZ0/F+sI0fvNmBAfODv4A99zapwZ4mmEC?=
 =?us-ascii?Q?77bb9M73lwNKF7la2jvau2MxLS8cmUq66M3Haqr7q+Elp+twTHb36ddilRQp?=
 =?us-ascii?Q?b3/RqJq5oa1Lo0cEGHYon4gwYlB5eqJP3nFv/pNVgYRgGvJX2if5Rn5OjMMu?=
 =?us-ascii?Q?Wxm6Gu5JwdO99raD3fdYE/U5/4as2KdC9kbHk3hkZY0jQYtJRkJhjqk2Sx36?=
 =?us-ascii?Q?/eJV8EcNj+jnNqLRrGladqYlmcBsHNX6RxBNdzgCWhARbZwGtl74yveH06b7?=
 =?us-ascii?Q?Ax+FREnZyQa75mKo9WEuFDRsIkUIvolXgs1N7+SF08pQgbhx8VflDj+eA5T3?=
 =?us-ascii?Q?MHjXFLVtghcJQ04Zl/BpRoCsLtc5C1c/iaZUY+UX43l6R0hM0Qpb3ruRFGb7?=
 =?us-ascii?Q?wbUthdf5PLZ2O3Nrc/3kkpY1bZasSPtl3otMAyWg+VeVQM7mW6ubY4u6fJjS?=
 =?us-ascii?Q?u6+veSr51+3Z/Rj+J+wjCtiKNCrJyhfP4ibQQm0US2pthSSQeadM/0BWJt+S?=
 =?us-ascii?Q?fvXfqucecXMFnaIrOoHFYyHcfgiGIgrtpHGOXm1nIwIs2N/oSVn3Vt++Qcx5?=
 =?us-ascii?Q?Aq4ivCw2b+nFgLVQ5jTe0YMD85LDvCu7OZfx491/CMksTLMTpW8IjSHhB+k3?=
 =?us-ascii?Q?Bh2IIwVqHex+oOb+qadC0nF2WbGOVWLFgWM5skrevls0+j3ZyqiSYd73hoP7?=
 =?us-ascii?Q?wkK0XFH6D/037f9lpLi6sxUHCoCix9L4tACJ9Tk+NVdqKgBXh+kRZJt3HqHV?=
 =?us-ascii?Q?Q5zYAlA0UtwcB825Tg4vUCBrhSE1EmObWYlyQORBeZjnJ01OZ5MTYWV9GHyV?=
 =?us-ascii?Q?lqZtx6PKFhS1Aw/BZNhTifANG0EAV8UZcYyn8CP/5uclgQmA6phkGkrv3i3x?=
 =?us-ascii?Q?JYKrLf71IKTIE9ZVPI7mJN3rbBaemQcSOsYFkixdmW/UsVKFGAQR/3ZDgT/g?=
 =?us-ascii?Q?ViJ7n1qPFck2VHpesAei43uGO3sZRpkKvdvVNltJ26enMSKLOaHH9WrrHK+/?=
 =?us-ascii?Q?zSEL1lvarGm6KYXByQDSTum7zwaUBoRigztswNeJV1gwT3N3aYAqIAWz9FAz?=
 =?us-ascii?Q?ycwcIUDqpy+n1LY8W82O292UdUaBGtcgrqtzTdaTmdKBcundK+y00tdO5Or6?=
 =?us-ascii?Q?7D4tK8/JPPOVeT66r21/pCXINk5dUVhg0CgRXbsgy4M4LyTM73DrAA/S5zOf?=
 =?us-ascii?Q?accT0x1KPZLpXy54XBcq5GGcf5UllWZG7RSnno0jWVYxZbHt/ChaondTfF+D?=
 =?us-ascii?Q?mnxf96OOOBHk41D19ZqG6Rhk5r0kzNc5SzwX1NWobHxFuV0vYLvOIZ0Z1Q?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/RfDvzl7XFyfkrrYMJeQUyPvSrZUJb3tWIkd2IdbMpV/AQ4yInI7f7V03Y4x?=
 =?us-ascii?Q?hjiFyhIix8p+8D92/Zy7Cr/w0k55BegVn3LYhXNHbggUcwS4ubjg3cMlMfoS?=
 =?us-ascii?Q?bnNzz5hoVaps8WUXI4qMYldaIFpc75/0s779hzoZ874/Iau3I7mzFDn5AxRR?=
 =?us-ascii?Q?hLNwDoJwXvWxCQAjmtpU5iDQy8nUr/EeHIf3q6Rdal8gpa8lHOA0/GzMAuFn?=
 =?us-ascii?Q?LlqBDCZ3lCM8FCmZsYmQ+IMtB9Jy9A9oxeayQ+nf8w284ySPMqUWExH/jGBJ?=
 =?us-ascii?Q?lR7dJSBhVvaDCi4aRMkywzo/LDY2J/NfrTppBIuh3fpx1mHQm6MsWx1jBXg/?=
 =?us-ascii?Q?FSFsx79LnjpHvpTSVV0z4t8ICM58W7z+ueVpvpdvEfLurmck6WFFfWgqHw5f?=
 =?us-ascii?Q?gYe6rQ52VRlJ2Hv27yM2eNTR/zkdzsOLmxOJe4n9tqPzbcks5YB0oqfnhuTa?=
 =?us-ascii?Q?NPcCGvFd7gTkuH7SnIzAQXk7SlfvsFVFS5fykIRagSRQhVsM1zzsgRgledB7?=
 =?us-ascii?Q?1qUE1efiWWBdQV34NJXhg/USinh7SSDKPQ3xxShHHMnGdHTLGY1tOZfhI+Ei?=
 =?us-ascii?Q?gqgY/eLB9+f0NMQI8OfvoY+ky8GTAJu3dHH2NqNsYLL3ylqxWEiN9Vh+zlkd?=
 =?us-ascii?Q?jFi3NV3lbHlPLOWTLLuNzMjVZ1cWp4ZP9xFmaPs19bIt+loQBi3tA4/YUi21?=
 =?us-ascii?Q?wXgKB7i0uDLakzAuBCOoI8WY/kVt69ay1TbQSlmCRYUmm7NMN0GnlerezYP0?=
 =?us-ascii?Q?VDQkYbeQd+2ddM9PcgZ3sNX4ltnN0LJnFrBS1S6k/dW5oG2oDLI2gn4C8Bel?=
 =?us-ascii?Q?9Wtlp+UGWY1yLyV/09vk/4qjcM6OEHww3l7hePx9Jine4+QjueBdwxgLFflI?=
 =?us-ascii?Q?uMYehzX30L5X3rBMOAtKW9QlYGtDTUbA482cHE8bwvPWS76/RC8nycUON5vU?=
 =?us-ascii?Q?LXPZH3W05O8E8mfPHb7kPG+faBC19wC6MBmPcYUQ8H9pBbNp6SjHJSWK5c83?=
 =?us-ascii?Q?37KNfjkjL6uh8ylfDCNopzgG8BHztxrQl0GMYXGCr1ZaPIEMyOMhR6kx1kNk?=
 =?us-ascii?Q?kW10Ks4IMAdfT5e0hS0V8fHnRtV2YkjUMhNE7I7Vd/gMg5MY1WvzD9ownjhg?=
 =?us-ascii?Q?ft4/DzrdCk+HFlLwHFEj1L8RzE5Rku3RyXumb76KtfwNaTZYK6LYSP8zRxkT?=
 =?us-ascii?Q?jYJx/onC/t6RI/x3HheOYUNLmjfOJ0rC8bCIVM1jr9Y1ATi+Vzks1rpD6kbs?=
 =?us-ascii?Q?OwyNeZn9qDDYtyOcnSez2fvs4pdzF3sp+lL1qzGZlwYvGKp/db0JNThvrL0H?=
 =?us-ascii?Q?0P/x3UserSjuXd2Rc+OdCB9TlvDpVIqRuH92d0daMhc1JwvD5LvMR9yxtaew?=
 =?us-ascii?Q?nU6fT+KL491txm35VV0NJ/WVlOIqsLdiIPN9S5TecE72eMXQMJ3RZ3DizvhI?=
 =?us-ascii?Q?9UdPG0bSdudyh0rwlXjzcecGkTnSejpv/GaqjjxL4dlnEc82buVK9PiARtpo?=
 =?us-ascii?Q?IJpddy+CB0+plSn6jE58zj/0rW5N/du/bxNKX9PHHcRUsh76r7n/yRLPbQ7u?=
 =?us-ascii?Q?fQnUXUEO6n+Ut+lFy1nnY1MxtHeEVuCbg0G4IP+N2SC6SFtIYo2Uac05zSgl?=
 =?us-ascii?Q?abvbVc0LeXjZBm2/k9ly1Q9EGfXE2kG4+K9EK54Ye8W74N79Wc4vLn0DAPjs?=
 =?us-ascii?Q?0PzXYetm/C3Uq8j38xtml5nuBmd4BDp6gNiUVmo/2TQ8dxfaULQVaMIpXgNF?=
 =?us-ascii?Q?JngMeNU9dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a4c5cc-42b5-4c47-0dc3-08de4f46110f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 06:12:28.5363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QJeP/6N7KV1n89RspfoYEngxcFbdkQUql4K2VBUQvAmOT+WhcGYthgEnsE+uBEo/DgCnj4e1WqvAwojqB5XkjY5s67MZP+9Mluppz1R4yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14910

Hi Geert/Cosmin/John,

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: 08 January 2026 19:52
> Subject: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H a=
nd RZ/N2H
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the tem=
perature calibration via SMC
> SIP and do not have a reset for the TSU peripheral, and use different min=
imum and maximum temperature
> values compared to the already supported RZ/G3E.
>=20
> Although the calibration data is stored in an OTP memory, the OTP itself =
is not memory-mapped, access
> to it is done through an OTP controller.
>=20
> The OTP controller is only accessible from the secure world, but the temp=
erature calibration data
> stored in the OTP is exposed via SMC.
>=20
> Add support for retrieving the calibration data using arm_smcc_smc().
>=20
> Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
>=20
> Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>=20
> V5:
>  * add arm-smccc.h include
>=20
> V4:
>  * pick up John's Reviewed-by and Tested-by
>  * replace new macro TSU_TEMP_MASK usage with existing macro
>    TSU_CODE_MAX
>=20
> V3:
>  * no changes
>=20
> V2:
>  * no changes
>=20
>  drivers/thermal/renesas/rzg3e_thermal.c | 27 +++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/re=
nesas/rzg3e_thermal.c
> index 97c4053303e0..dde021e283b7 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2025 Renesas Electronics Corporation
>   */
> +#include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
> @@ -70,6 +71,10 @@
>  #define TSU_POLL_DELAY_US	10	/* Polling interval */
>  #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
>=20
> +#define RZ_SIP_SVC_GET_SYSTSU	0x82000022

Maybe add a comment mentioning firmware should
support this index and the otp value is stored in=20
arm_smccc_res.a0

> +#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
> +#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
> +
>  struct rzg3e_thermal_priv;
>=20
>  struct rzg3e_thermal_info {
> @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3=
e_thermal_priv *priv)
>  	return 0;
>  }
>=20
> +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
> +{
> +	struct arm_smccc_res local_res;
> +
> +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> +		      0, 0, 0, 0, 0, 0, &local_res);
> +	priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;

Do you think it is worth to ask firmware team to return error values in a0
and actual OTP value in a1.

So that driver can check the error code and propagate to the caller.

Cheers,
Biju


> +
> +	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
> +		      0, 0, 0, 0, 0, 0, &local_res);
> +	priv->trmval1 =3D local_res.a0 & TSU_CODE_MAX;
> +
> +	return 0;
> +}
> +
>  static int rzg3e_thermal_probe(struct platform_device *pdev)  {
>  	struct device *dev =3D &pdev->dev;
> @@ -524,8 +544,15 @@ static const struct rzg3e_thermal_info rzg3e_thermal=
_info =3D {
>  	.temp_e_mc =3D 126000,
>  };
>=20
> +static const struct rzg3e_thermal_info rzt2h_thermal_info =3D {
> +	.get_trim =3D rzg3e_thermal_get_smc_trim,
> +	.temp_d_mc =3D -40000,
> +	.temp_e_mc =3D 125000,
> +};
> +
>  static const struct of_device_id rzg3e_thermal_dt_ids[] =3D {
>  	{ .compatible =3D "renesas,r9a09g047-tsu", .data =3D &rzg3e_thermal_inf=
o },
> +	{ .compatible =3D "renesas,r9a09g077-tsu", .data =3D &rzt2h_thermal_inf=
o
> +},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
> --
> 2.52.0


