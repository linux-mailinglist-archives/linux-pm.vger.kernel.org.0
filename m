Return-Path: <linux-pm+bounces-12758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20C95BC95
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 18:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F42121F232AE
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B41CE6F9;
	Thu, 22 Aug 2024 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="E3Qj/mY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011034.outbound.protection.outlook.com [52.101.125.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC62C190;
	Thu, 22 Aug 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345978; cv=fail; b=IHx05batN9NFhwbTy00byVEXVojS3C5pXmyEFoqDcxLof9w3I9VkprkjEQhN11xh+RkrhiCJq73qDzYmmVafLNlL207cGamZJLZXC36FtJIVWhfkgoXQNpu1JT732qzgHaApRhm/FWCIzJbvqTJJYE2A/32dCTJ4F6oz8vYAv1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345978; c=relaxed/simple;
	bh=tGhjVrkeqgbane+MB7PuIKc2ABk/58tUA+1mD5gCC4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GJJcVAhD6sx4LFYsTaVJj9g9OxWS425dtLXGBCeCBjKeg9P9Fhf5XkSON8IvQ0DyN10l/jyQTD8MMgFwyFFf1FLhpQE0SQr+IhOk7v8nQcMoHah8oj3AVSvarfBLFfT7h/oYieXRx/SdeGaBP7sLqBXgaoW80y9lTiW7i3OyQ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=E3Qj/mY8; arc=fail smtp.client-ip=52.101.125.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvHg+luRaYEn6oMQaw2x0UT11aZxr0DSqJ29LGHB06kDYN/4URj2v7UY+nKojJjbIAdSS4W28KO3j4wTU/4MnrAUQwCNDs75rEUYX5NuGEggPItFaVBNRgmEFB5RnsOxaHvzBlXa+IplpjBNjw6VtfHEkwQ5uEdNmQ0+8WanBwZCFuuf5TdWKcgxVpNhGokkgbo9asqOdnW/Re4pZJ39mbGQFnZ3npa460eBFDgGH9r/iJwP4yNLpvch3rFsZDzoR6S0gTScHxMfJ1wxNQqQJ9rDMGEoPQ65f/vRvJrK7uf3HGVy4LG75u9WveXIxH3EQbKK3lERCSIReVCJGCw7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOndNSNYQKD5XQxFe9nk33CQLms6sIf2EKCtqcAKmVw=;
 b=cSc04z9LRXaSB+J7hQhdeOHiTxOPKb8exBNNMnXawtnPvvIMKRWipprqaJVsQPa+wY9Fxf3zWxF+WoOhuBqncR3U5iM8ofUf1oAZdTF8g8oKgqcD0ZCvTXtf5WBbxbLZV/L1xW0b8YjsnCWtQhtOB5aOiFL09TVU5wr4EX2SEowheFO/ykV3/s/RKOxgmpznpvFmkc0gHOmQqVPpUwqB6oJHbTAF+qrjyC4x9YgdEyf5tSbmfR5lVPhcf5ieR4r2VI3jM0pHFNROcSDiLO0h0FJ+Lg+xqXq0Z7emgqcTdsOwBSp0CWZ7anYpUBANaENsnmdSIzkcu3VrxJooToSLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOndNSNYQKD5XQxFe9nk33CQLms6sIf2EKCtqcAKmVw=;
 b=E3Qj/mY8qg2WOEriPCWW2bFTAQtA5+rctE/Yp2HJwo1e5thsFS3icho/UAfuXuAbHThCK19CMutUohZVkpIEHxPGRZ8FZQHcO16Qhi3jm85U0rNAQTD9VVAPrC7KUVnMGxSwdYMVvvPyXdZVW5A8/SWnfxZRL35X3tjrqKPCoMA=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9989.jpnprd01.prod.outlook.com (2603:1096:400:1d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Thu, 22 Aug
 2024 16:59:28 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 16:59:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu.Beznea <claudiu.beznea@tuxon.dev>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
Thread-Topic: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
Thread-Index: AQHa9Kf1es/yPNhZeEG/EOaLUabxzrIzfjMQ
Date: Thu, 22 Aug 2024 16:59:27 +0000
Message-ID:
 <TY3PR01MB11346B5C5D9AA883B7736A5C3868F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-9-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9989:EE_
x-ms-office365-filtering-correlation-id: fa9cac7e-86f4-4d58-3ebc-08dcc2cbc866
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+qIyKQ4cyuc0b8zuVto7bkmfCzBKvsCs97MYNhrQYeRqTMa30UxuAZtftBe7?=
 =?us-ascii?Q?xu4lmlihRJvlXv7iiIccSUUqqSkZLRMvyhJJgBwDVs+StN0jcgdP9lv/QPO9?=
 =?us-ascii?Q?vVFGdQVjsDkJzlWgCu0Ta1UCjK9y/NOKh4wUzXLMkNyZD57OOiZLwweYtFDU?=
 =?us-ascii?Q?hVd38DLVpab6MJ7k62le1kB/EQ38ELdG6/G5vs9iEXyh6l/QCFteEtS3sFev?=
 =?us-ascii?Q?8iTPTeyhFMapg0jkrP7xpA0UNcZeBtwgRedWFO8UXYVyO9RHfpwBqwH3hcNG?=
 =?us-ascii?Q?v9hy/B+cI7rx8wtmIx016mgHWk258Eesmvq88jP1c+I3tQ33uNnTQ1vnbq3L?=
 =?us-ascii?Q?k99L0UlHeNf0v328/K4RWKX/3uj2jDuKbLTivrSNj0BjwuPi2PmvTuC5O2qV?=
 =?us-ascii?Q?y4Qp7yy7oXqaOTVZ7QdWaMW3buEGIRt23AL2E1PZKhNgefVkgkr4db6EYIKz?=
 =?us-ascii?Q?I2PaJVcSzkL9IZ/ZtpmJuLKIQrpzC0pNZECnYDm3qykNV/OkBjIC8O4yFx5Z?=
 =?us-ascii?Q?AxjqAzC/ymJjz9MO4RXsv8OGIROA6EtyW/+kCV89JrCVzwCG+BRHPWTbZ6Nm?=
 =?us-ascii?Q?jOyMhG6telAiEpc4Q5ndRekQJdrCjDVzSLhbc5AJoulIDA7OqNWvBax8wuZM?=
 =?us-ascii?Q?aHTk/Ha23hNoBoqv8KYl/ALVEnwYnOSC68cRQyKUhl7C2BidHPNtEdhTBZgm?=
 =?us-ascii?Q?Iv4iqZyKs3MdBPixjjhgnxhFBNh2nWXzUsJ/Lw9yjtRYkfWo755JHtbQveTg?=
 =?us-ascii?Q?BQN3c9i4F+rwxDKOTRSAaAiXP+D5O6eQOaW1sEB4WN/R7PtzlPA02/Z8SZNX?=
 =?us-ascii?Q?U3gAo5o+v7azq3Dumhx6iLH/FYVYsg6EshgQ3y/TjMd24xveLVq7nwnDa0lZ?=
 =?us-ascii?Q?dCQmcgOxgTsbebKX5M1n7SEFEgVJcdATVOKgsoPHI/QQvbT6O1bNwqjuwu8X?=
 =?us-ascii?Q?EIk0V4Eh21FrfFSHbO2oESOFIHA4t5bmpP50USTBFJQATTucZr6AhXByRqVr?=
 =?us-ascii?Q?hqiGuYqJ9pmEKY7nRv9nY0ECE6fF5J3bX9os289gO/9Am0ghhYLuAejfTwbu?=
 =?us-ascii?Q?olZkVHVBj0bloR6P5CeLj5SXFQTiHAmNFMB6Q7rr9QDXzUivSzSEC6sld+qs?=
 =?us-ascii?Q?V2JoUnW+J+lSooGlS1z1hYPBPfJuDPafZ/EyrcjBP/VORcCW/Hwhl7fGPB2m?=
 =?us-ascii?Q?77TQNR4ax7+lRaDxI3QjpIhF0ZY7jD3Ut4nnKin5EJSv6UY+ud79/u1i8+cb?=
 =?us-ascii?Q?Fj1ECnMu4U8oXJ+CMOxQqw3NkNlcu89NWJt6955q99ZnWx6mM/3AygJJFg5t?=
 =?us-ascii?Q?J3YxmHWn6WVObR7w7bp7P4gqtjGEHG2WhMY6PqkPiS+Nph4/ZRkz5/qsgxEv?=
 =?us-ascii?Q?fN5bvgYUvSAgyxnIhaDljCuWuvxTVZW77/u2TR6WnV3MsIKYOYKBm8RHXQYl?=
 =?us-ascii?Q?reUvnvqnrsE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aOGyfOvLQdRsPfEPNOUgIE4U8yajOmmCtPYnqdcmB8v5fR7JX1JZrhyIVa4L?=
 =?us-ascii?Q?p4gxIniw9ZZFdDpigHLRSA53AcvIeNpqHv6Di3tCTIbsu9rqtaRYrkZAFtnW?=
 =?us-ascii?Q?Xwk8DF8ecnFkxMvKzhT1FsizbLbw6Ff2kHomzJLOO+5y64AJNW9T9QQkoL3e?=
 =?us-ascii?Q?tifi/yDQj2jz/YeKu0AW5vCCGj/a7f5w6X9vmJ5n5qB+y4Ovtb+9JLUANFQh?=
 =?us-ascii?Q?8ME4Q7fzQ7sqb/WlgYatY7cvkJMDd3uAbydWIntF0ZSd+xkliWY3NLEDqCPI?=
 =?us-ascii?Q?bxVCD8GlGjsTZigLJDd4dhYFV0rYTkgdChjC1Um+pQSBiS/08ayesNX9f4wu?=
 =?us-ascii?Q?zHR9k6tCzRMMbEtfsUDrE8EabPTvWSelLAdO91AChnB9xM4qc3Oz7edJvMIN?=
 =?us-ascii?Q?9dJeHCJJCMeXHGiaBj7ErJbGhdW1Uz+7c1UvRLM5YmS/2z88oVomoZ2jwTHc?=
 =?us-ascii?Q?OgAZvVr0E6HXfQW9wDG8q3MyV25+SOQP5kOniMwGekERR2XVq8NSNi00mYLn?=
 =?us-ascii?Q?glf8/daba81IlkG3erbZWEIhqpCKQDV+NqAppR54248B72AlsDD+HLNA6I0v?=
 =?us-ascii?Q?e82slMlu6BQk/SB3o4X7FiX2Kyj7AxBz3jSCjqtKhsAuTfNnjIPLHSQ5L3Ek?=
 =?us-ascii?Q?1ogzXEDmycG3emFHOm2l0X3W7X58cGi1JmkN9s0bVVaBebuinCMtTrhqulkD?=
 =?us-ascii?Q?5F9LoXaCMIQujgCCSU1mEZp2IosNgaIT739NdCEr6+Wt4MZo/G4nEvGfQJUE?=
 =?us-ascii?Q?DGK8Cp6aLci9bL/BNRzrf3cHAlkRBQrRcMIy+iWinHUofoysGCo/fa5WfLVu?=
 =?us-ascii?Q?+6GgX9DT6ESVn9iWIltXiJej5OtS4do5Q3u9Zom1WnFu4+XSqgy+mEmh1OOn?=
 =?us-ascii?Q?2cQ1Ls3yEghY8TzXw3todgx1m8Fvu3uqXLXRfKsh71+Av7PIKmX6Osbg9LQa?=
 =?us-ascii?Q?ep66oB4Ds3f+kJlUs9dIK0in53Xz53HTJ4o5TK8EPksPSoqdgsVq7B9CCnDR?=
 =?us-ascii?Q?gAZ/HQ6KRfq4W8XHMjgAsjvfWSzE0ALfl4A6fKOSGW8Xra9ySUum9hw9DpR0?=
 =?us-ascii?Q?8JdeAuKPK5szjgu9qFO5jEBqyjZ57YeuAUSVgCvLrgMzZ3WlbXPX38Fj4lUB?=
 =?us-ascii?Q?IUROu3w5g4j8ZglsAIalJVao6tw25CQ0aD+LKLB2cU2Rv8qReIdMJ8oq7FzI?=
 =?us-ascii?Q?cEGWIDItKzEHDNigdewXVAbVuAb5aGvLqNRPs5O4m/7t3tW+KUtjEmVZu9Mn?=
 =?us-ascii?Q?kJ8Nv7x88n4xWMdlcrxuwebOri2kPD0EDBathABeG1UUbVEeT+cDW2TzjHAd?=
 =?us-ascii?Q?hgUCHc1M7BF2Ei2JfxiEnApBYicRSIbBjN6REFbZll40U/x1IZim5Wmqat67?=
 =?us-ascii?Q?DbWK11BngcpnNelHewQQ7fkFZQlS9IIOh7SqHcrmE4IniDKPRdtwAUavC+zj?=
 =?us-ascii?Q?4GEHtgGDflHKCQQXbaFxmT8WGmL7PtXrVy0/SjAJdE6CkEvrartO8IYNIVe7?=
 =?us-ascii?Q?Yg10SBlqQhZBRtLmuU8yMWT8T5zdGU/nnC6RjZt4MVjBFNPOg46bnuFf99a4?=
 =?us-ascii?Q?SwFrCjNSLDxDqAkLSi4DZmdmoq5BAO7rHAPcqBfSwzB6vR+yOkoHQP15td+O?=
 =?us-ascii?Q?OQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9cac7e-86f4-4d58-3ebc-08dcc2cbc866
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 16:59:27.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DguEB4HdzeKDGBnULzue61gINhBmtKgckrlX0pmGpXV9xfyyjeYIKRy6/WX+0Wf3f5OpgG9TBSL+ioK8f6qKAS6aZKuA8e8v3VLJAobiDWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9989

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Thursday, August 22, 2024 4:28 PM
> Subject: [PATCH 08/16] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Add support for RZ/G3S SoC. It needs its own compatible as it uses 2 rese=
t signals and it cannot work
> w/o both of them. To be able to fully validate this on DT schema, too, th=
e RZ/G3S uses it's own
> compatible w/o a fallback (as if the fallback will be used the RZ/G3S wil=
l not work anyway).

Other than reset/ power domain approach for handling USBPWRRDY signal

Can't USBPWRRDY signal handled in SYSC driver directly? Since SYSC driver i=
nit happens at very early boot stage
Check for USBPHY control device availability and handle USBPWRRDY signal th=
ere??

Cheers,
Biju

>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
> index 8b64c12f3bec..08b18d7de7ad 100644
> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -93,6 +93,7 @@ static int rzg2l_usbphy_ctrl_status(struct reset_contro=
ller_dev *rcdev,
>=20
>  static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] =3D {
>  	{ .compatible =3D "renesas,rzg2l-usbphy-ctrl" },
> +	{ .compatible =3D "renesas,r9a08g045-usbphy-ctrl" },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
> --
> 2.39.2


