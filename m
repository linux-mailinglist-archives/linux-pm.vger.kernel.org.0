Return-Path: <linux-pm+bounces-23837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEA1A5BF15
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCE2172EBD
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A924394B;
	Tue, 11 Mar 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="aVFBORS3"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010000.outbound.protection.outlook.com [52.101.229.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24922617F;
	Tue, 11 Mar 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692815; cv=fail; b=VqOpZxZaqGBKagE4aFKciPtz9kmC4zzb/Okjb5FX3B+du88N4MOgxX8H/shbxZYkaA9M9yJUPOKTfFw7mI6m5qsvakeX2wtxBhLnfnqcRbs8tDxN/7/yjMIFrI1BG3EdwYzx0pvZvVzx43tWCw1pUsQs9YY9hpWqzLiVDqQs0EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692815; c=relaxed/simple;
	bh=2nnxd2NXGNcNCE5hlwHCo0lrNSY5hLaWCW3UhJknP6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jWo0wBuRqPQUB4bsrczo4EgIj3Mf5RffgAVpdQTTVLluL6Cj3URK5kGYcB0zfA5aPFb9n+bKdyCcHFxQA1nqjpzM63Fj/r0ewGltpOjy720pOW6/MEoy7b5JxWUtBj69ECmx+kNT0mRigr8CGYQoYpmbAuccFc7g8sJLRw/f4ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=aVFBORS3; arc=fail smtp.client-ip=52.101.229.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QESkkqMO2hkTvVooIhIa/xi3WCG4XIDLhepmg9kMv3oX2zwD8lgcQKHNZnttg+u6mmBCzM8UBxQelsTb+mSK+bxVAme+pjfoNORPoeypeN4YLullj4ZQC7K5DyP8jJZ+tXP9D2StrSL4UMYMfDp7Qzz1OliDu7Lzs+879/NyQh4wS799mZBGTh3UoXPY9UYRWhEUXuFTbg5e10ZLbS5yfHLnmM9jJjpzSpb6Rq7zZP/n5SHwMP6VFevDu2Wa2BL3H4Q7oMWoJw9rn+PURRRxV3dDW6NaYnYDS2gCMVRsfDwOIeX9i5m5aHyjq7T+UyBMiJarPYGgzWlbhtKaY5ggkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocYP3dp8YYBArqlKe2Vw+IvdltMZLgTVJWaVrSp0Zdo=;
 b=krIT1mGtwrVEbnc0urYEiAZdd0vz3xmYlQ424+3IYNgjAJCrIDoIs1cWwOLzzTRLleRZPKzqVFqqvHtLGUhY+fbh3QXI1YOA5jCTziOCdWXwCtdOd8En0MkGUgIzLsajsPc9NUz4qDqwJGOWw/fdtzPl54HGNl/efcdHGFwhByhjfzzJ71cjW1A1//5NAIikcKsa2KjYNgzDLYDXGkYs2tfEGluBjgowDGkbYiuCFlwtEsSrv9zXS/ud44WsbBnQYy79BOUolPKU44v0MAKZQubh9fdKGi7y6NMVbLjNCDBUEZ7rL/CQBZlt/8Uefisk8M99Ejhzvvsv++1lYKsMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocYP3dp8YYBArqlKe2Vw+IvdltMZLgTVJWaVrSp0Zdo=;
 b=aVFBORS3ygX1GeoxmOwEagQ7xrGleQ/bV9ZsoU4q47lLGvSL0KeQxsU45OpG4zDV2YTKMGef6Dcqbvp9pkvyP9N3MZPnXfywkfuCnuqngEU58tCip6n+9KvaX/zeS7FC2y6ZnuDZMGFXrjvqzhiPITO4W4HgttFQFXuT5fBZ4aw=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TY4PR01MB14780.jpnprd01.prod.outlook.com (2603:1096:405:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 11 Mar
 2025 11:33:29 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%4]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 11:33:27 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "magnus.damm@gmail.com" <magnus.damm@gmail.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
Thread-Topic: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
Thread-Index: AQHbkOyvb8DHVyIlg0GJYW48v45DAbNsKXcAgAGlKkA=
Date: Tue, 11 Mar 2025 11:33:27 +0000
Message-ID:
 <OSBPR01MB27751FB038A030EBCE0A93B2FFD12@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
 <TY3PR01MB1134648D962B26E94C4BA0D1C86D62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB1134648D962B26E94C4BA0D1C86D62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TY4PR01MB14780:EE_
x-ms-office365-filtering-correlation-id: e2e5eae4-4d7d-45e6-d8a7-08dd60908aa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0wGSDClTIoOJsARr2mqdDaxLFZ1M+nejczw5cE6a79Cdm5Yf39d101UQyjYy?=
 =?us-ascii?Q?ta6qtMFmUjUKa/9VmEO6YDP9boX7uepg5Yawmo+3M+QFBvQ8mmQ6CMAr+Mci?=
 =?us-ascii?Q?NYb8u73UV9g3g2t5PUVbRk98CVTNF6ZhZbKO9GmEfQFCjJ80aXZXgdvTB3O+?=
 =?us-ascii?Q?y9JsAXdXMhRD/dGyilvNJgHJ5V1FOva7PsTHb2VT4N0dz/h+d127eU2R4VPv?=
 =?us-ascii?Q?ftdIQ0bCZkWpx+X4zzBLfzZPlUotULCQ57R9tk+8WpbhWpBJyOfemznZFTtj?=
 =?us-ascii?Q?IDYH66KTrfhISH/ezsV6pi7hAFQMxO5odIY+Mvi74CE55jtAEmWjHhyJbQ4W?=
 =?us-ascii?Q?woC6QveMljvz9ATkz/mvlhjM7IiLzSGM5/X8NqVE88OJMRtDTZgmVysgh12O?=
 =?us-ascii?Q?/Blj9yVFTyVLh9O18RE/WJK7OXjWXSiPNedBI2q3c2/0kzeHB1+Yh1Mp5Lio?=
 =?us-ascii?Q?0y3V0kbdochffRVSptsuRwZ5sgZEdabEO+Ft0KDD0bmxZ+A/vFLxk4lApIPz?=
 =?us-ascii?Q?w4GezyCoyl/Z4imy2yPE7lC1tAR4YjfLUQIIz5NX6gatxDZ+99yVxe2cKtbe?=
 =?us-ascii?Q?Es6oYpoGhepkAuXSVLgSZCNnZkxZNWddNFKpD3rGYIGtfJYoEP5+j2tck04w?=
 =?us-ascii?Q?BgywH4FbTxtBbFEZKPImvofYCHg++k/tGuglm0yg+Ix7wbzolIRbxW8K2ELM?=
 =?us-ascii?Q?LNHbUgQEK6oo9FsIYTlKtgYrDlAzJeUM0D/9QswX014RmKQcmEkbcV830oap?=
 =?us-ascii?Q?HavRbtibMoMuO2QCpsCiXpW73cSb8WXKNsSv+96YAxAYgf3UED72FYRx9KCY?=
 =?us-ascii?Q?KdROx1J217mddJQzyufoOTm01JjrW4xVuqFXy4AZYGdD8ru652sLZJ1ozKRA?=
 =?us-ascii?Q?lxEdvF6O1+ugoJEyjzXo5fQDGbHOMIpqppgntkl/Izr0JPkcUEyeAmY1i7nB?=
 =?us-ascii?Q?0eKZHY6FAGFtS2J3M/01pJ3zPXUSMiEnHv7e7xbSDYVWm1d7XIk4NqWeAt8a?=
 =?us-ascii?Q?skfUyqwEXKKQNMsTLlCt/ImXFEZYsxbKIgm53Rnnxn0KnGFJDfInP46Dy+KQ?=
 =?us-ascii?Q?aQynazFxpe93d26na7fNhWU0LMUcCS1sO8mOvc22kxd2X0l9EoPxH4V/YmfW?=
 =?us-ascii?Q?XGCVcYdL7CDVCpLjI65TfystdGv38gtSQsZ/QdcgeBNV5srd+w1hOcD80K2U?=
 =?us-ascii?Q?uZyWiRcYHCkXOG0kvHMpsdAUVi7fnmgQ30VwF+vK/kmB1HAHJKCF3sPIsNyW?=
 =?us-ascii?Q?5xEKaej8sJo5dy+tq6Ksc/JZ0Vo9NzQ8QmOdG2B2QbfWfwj9DP/VEPwjYA1+?=
 =?us-ascii?Q?t3JSZCOkwyOLznD+ELxiBPg4nPBq+5W+xoPSswfRP/NmBem4z7fLOFZMRQ9y?=
 =?us-ascii?Q?cim5svBvbmsKZ1oBVrQlGdYJD+AWCY4uaDwXxCYuXX/fixbi3N1XQYlN9Lgn?=
 =?us-ascii?Q?zq+9Qv8jQuPcrMe2xpELZvrwnFB54ul7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mcVQOHr8W/0xptYhQUfQfP8nOy+aJvCEusG8wNhy5kNusU8uo5zMy4fLBhes?=
 =?us-ascii?Q?gDT8O1/gwzZ/y/wkevbYihkV5g3slcdvghNx3PTKw3aekQYdwDp6UsQYdSDw?=
 =?us-ascii?Q?0kLgkBeAELFfLhYz32hNSGJoklLKsu7AO2xEmsf8kMzAVnWO4dT5DXNJnLif?=
 =?us-ascii?Q?9xB9UL+pB+PTgRmTHRxm3mO4jCKEKA8R4N+uv/Lg4a5a0EnAbzB2d8kIta/x?=
 =?us-ascii?Q?Cf0NOj9AvWQYeKkeEh7Yxp89dZcc2ep/uAEpMQE3OuX4a5/txMNcxK/7VzjI?=
 =?us-ascii?Q?67BhnCKQOQWm0RebqE1cWEzQHVXka7GKimsFw8DSjExBkg34cwlDzMSAl565?=
 =?us-ascii?Q?/Mkyze8WglCOx8G30ShNKAv1AYu9JA2GGCQud4Av7DIOP1FVuLX5cZfOjsSg?=
 =?us-ascii?Q?KF2v7Co69OH9zMdnunpsUv8kniuCu0jlimbIBduN1ifJvym5m+KmFQDct55l?=
 =?us-ascii?Q?0zc99xGwk5SuHzokqoA2K0VqwiBco/pT6SGu64tE7wDt6Ogq99kPZ7rQC+po?=
 =?us-ascii?Q?H5tPZNswc/2DZjG1i9cHVbBdchk4wpFhkZbrhDVdWtt7FAP2WHsyz+S6mn7R?=
 =?us-ascii?Q?EBWQxYDRtAVP+H0Zd+GGxetpmaA5lmryI5KzoPgoOz5rWR8tJHBdS24bPgsB?=
 =?us-ascii?Q?b9GflXKD8YoUgKW3TpoCkZir90XvbWIpneMrmiz7EGzUoA694KNmgENAS2A9?=
 =?us-ascii?Q?4I0Ylyqch6vYs/8r72ZFTW6Xm/f59b68ZGKHfLx0kWZWZWdH0uuibAm+YJmZ?=
 =?us-ascii?Q?HeeyfNWjuFGIq2Jrvs4unb2DVKgEyuhHP6I7a0U73tsr5GjP5SNxP6QFc8jV?=
 =?us-ascii?Q?IT1k7jnIFHRtLtAtIiu4xeYEqB9wTZTLgezjIio3CKyzzUZu8TqVZyHvQebg?=
 =?us-ascii?Q?P3Iy+acYXe6cqSkTYuKSFa37dxcja+piR62+VnJBwJyJZalVM8UU9olHwYRi?=
 =?us-ascii?Q?g2NUh4wQuFWIEY9YXVgSYUsbokjIvYx92kkTReHHrvfzJzPdNQlnSHNlpGB7?=
 =?us-ascii?Q?YrHZf6RWWyNL7LaWaW0sER5uJKIW/O0020OR3RoQ5OQplcpPbyVVnxPL1+7j?=
 =?us-ascii?Q?bBdp2JeIFkmWBtRZ7Q6i1Y2P9fdMZxIH6Pqle1N1qjhGzhUf9SgalWu7I/Uz?=
 =?us-ascii?Q?/sLPg+3MJfcS/IRGP6koZf3AMknTHD8iHtvVIIifyb1JyreU52TJ2sV1OL8b?=
 =?us-ascii?Q?+oEyqNGCz55s/ibzvPjjRmFxKbW1ZJXCXwdOJ+7QFOd2xcC2KUmuXjqQbaVu?=
 =?us-ascii?Q?SMMQOGStBsrj6UoF0wXYcbqZ/VzE7BTEpndzzuuvL4ba36UNAPfIlwJyvBBf?=
 =?us-ascii?Q?DU1TGvduyHJzOwQCFTddaNtJb3zmt+5I+UJNCuPtXbhvzvbGvdr7dzHEWbqn?=
 =?us-ascii?Q?1gInYN1Wln+tYPOkuvERwRd2NZ2KjfyXo/w6TlqxQXFX65VYCZ/0bkcqViK4?=
 =?us-ascii?Q?ufNAIIitukf1dzEOBrzyNnEIp3NERAJmOhgFyoL4J042I2wPsnsA53tRLug/?=
 =?us-ascii?Q?EcxjendhXaIeWM4xo1VVHMGb4vAHTPwz0WjtQ/4wNUk1O6A4IPlc2olMrakO?=
 =?us-ascii?Q?GfqywFZ7Fd8hB2yuk4FFlZX84ePcGDOwn1lHhngS+BlUzO8ug4emskA73o/D?=
 =?us-ascii?Q?3w=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e5eae4-4d7d-45e6-d8a7-08dd60908aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:33:27.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtIsGINI6CbyCfxDO1IbAnyrBorApqcyUcrOPPLfNf+YW0FJMDpz0FLTHAjWHA7erfGn0SqwLEOD02DUJ67pym0e+YlvdZtTC25tvHFzzvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14780

Hi Biju,

Thanks for your review.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, March 10, 2025 11:18 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; geert+renesas@glider.be;
> niklas.soderlund+renesas@ragnatech.se; conor+dt@kernel.org;
> krzk+dt@kernel.org; robh@kernel.org; rafael@kernel.org;
> daniel.lezcano@linaro.org
> Subject: RE: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
>=20
> Hi John,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > Sent: 09 March 2025 12:13
> > Subject: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
> >
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > This patch series introduces a new thermal cooling driver that
> > implements CPU hotplug-based thermal management. The driver
> > dynamically takes CPUs offline during thermal excursions to reduce
> > power consumption and prevent overheating, while maintaining system
> stability by keeping at least one CPU online.
> >
> > 1- Problem Statement
> >
> > Modern SoCs require robust thermal management to prevent overheating
> > under heavy workloads. Existing cooling mechanisms like frequency
> > scaling may not always provide sufficient thermal relief, especially in
> multi-core systems where per-core thermal contributions can be
> significant.
> >
> > 2- Solution Overview
> >
> > The driver:
> >
> >  - Integrates with the Linux thermal framework as a cooling device
> >  - Registers per-CPU cooling devices that respond to thermal trip
> > points
> >  - Uses CPU hotplug operations to reduce thermal load
> >  - Maintains system stability by preserving the boot CPU from being
> > put offline,  regardless the CPUs that are specified in cooling device
> list.
> >  - Implements proper state tracking and cleanup
> >
> > Key Features:
> >
> >  - Dynamic CPU online/offline management based on thermal thresholds
> >  - Device tree-based configuration via thermal zones and trip points
> >  - Hysteresis support through thermal governor interactions
> >  - Safe handling of CPU state transitions during module load/unload
> >  - Compatibility with existing thermal management frameworks
> >
> > Testing
> >
> >  - Verified on Renesas RZ/G3E platforms with multi-core CPU
> > configurations
> >  - Validated thermal response using artificial load generation
> > (emul_temp)
> >  - Confirmed proper interaction with other cooling devices
> >  - Verified support for 'plug' type trace events
> >  - Tested with step_wise governor
> >
> > As the 'hot' type is already used for user space notification, I've
> choosen 'plug' for this new type.
> > suggestions on this are welcome. Here is an example of 'thermal-zone'
> that integrate 'plug' type:
> >
> > ```
> > thermal-zones {
> > 	cpu-thermal {
> > 		polling-delay =3D <1000>;
> > 		polling-delay-passive =3D <250>;
> > 		thermal-sensors =3D <&tsu>;
> >
> > 		cooling-maps {
> > 			map0 {
> > 				trip =3D <&target>;
> > 				cooling-device =3D <&cpu0 0 3>, <&cpu3 0 3>;
> > 				contribution =3D <1024>;
> > 			};
>=20
> Is it not possible here to make cpu1 and cpu2 as well for DVFS passive
> cooling?

From my tests, adding same CPUs as cooling devices in both maps
generated some warnings saying that the trip could not be bound
to my ("plug") cooling device.

This is a point I still must investigate, and comments from maintainers
would be welcome. However, despite these warnings, I had no unexpected
behavior, and even thermal trace events were Ok.

>=20
> >
> > 			map1 {
> > 				trip =3D <&trip_emergency>;
> > 				cooling-device =3D <&cpu1 0 1>, <&cpu2 0 1>;
> > 				contribution =3D <1024>;
> > 			};
> >
> > 		};
>=20
> Is it not possible here to make cpu3 as well as hot pluggable device for
> cooling?
>=20
> Cheers,
> Biju

Regards,
John


