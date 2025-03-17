Return-Path: <linux-pm+bounces-24150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF9A64B27
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79B5188ABF2
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA98230BD0;
	Mon, 17 Mar 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bBfpCFzm"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011028.outbound.protection.outlook.com [52.101.125.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532038B;
	Mon, 17 Mar 2025 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209011; cv=fail; b=YIu9Qx82B9t6LPIG+82yst2YmPPSZQfG+u0jL972Fmop8TfCrKPVs4NPTCUqaObo9aYWSguWvaELXebXa+XIKeued1RSe3XGeG2Iglbr4w1Pj3cUwmv4I/F7qCuveFvNRuyefJorAmmvsz4RheCyy1ZjaDCu0WcIVNHXMqX2yrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209011; c=relaxed/simple;
	bh=zShEmghGM3pAPnhi2u1WuhuyNRfrBTYokYycaz20S24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r+y+IK0A4KPlfr/6sN4SI9IAieRmZHY//6ikCERTWRX8cRul9ySc2nkhwqu1J2Iq1eq9B+ls7b6JIDqKYc3x8WOrl3SCP/c3NR58pCDV8yEALXRM8ffoobGCzsj6z2INzBva4QZXsBInr0yhBudOVcSpHeQjDoIrT80+2EZuLNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bBfpCFzm; arc=fail smtp.client-ip=52.101.125.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbISxfgFUCZwW9HBsr2F6e5Dpp6hDsYmOMWOjQ3KHuA4i5QOBGxmSuTmZehrqYTBcIHuWBzTQccEOGUWi/qfB/J540Gh7WXa516V8jucmN7GKk8uLQVmo2xfxXu4DXoFG+Z1lT1yBVWvN1oGpm1Iqw5hCnZwG02ZRhazQdSKMSm6ekkpH6RbI5vvji1Hylv0glNfsgUSjhpKZ4YwWsArl5SB9R6ohPaBFAG7NNEDcS+x0mti4ZRRLBexAZ72/r+FN1a64LKWFez3HQobD2we5pfwtNx40DYEGOZcOB1cHCMqWbgUgIKApqZ2Q9t4qrpwI+x2l3wwbqif41cS5C80hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmixZEvpW/h9g+iHvgZIotsjV4RIh5/wa1wByxW7ado=;
 b=cMU3QsEbzOz35mBZTtC0GRbR5SqfNOs8OIcYKi4FRaVXdk5cZiJNg7kUQWoh+OlDXzBJnt7IQBNJZYIlWac/5RFhqTMIYZYpeidZmkV+uswvZUatDwWNHq/JHP2g8F2C8nQ2Tm65hr6h3t22rZEOGrNMK/8ncsoA59ghEYerMN7W8oRG/KXtorxga2CMRJ/2alA6i7k5fsKlMmpmmHedwfzgZXumkcpPhfCVeMIE5PO3s4U1n2ba2NB92EYUThksBkxwDAjebmc9oYytZ3X68I1EMi/gMcgBAnHGbcfQxfXXlXZK+wa1Bk5THzsakYN0A+r8GbQDOLXBRAqVeXIAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmixZEvpW/h9g+iHvgZIotsjV4RIh5/wa1wByxW7ado=;
 b=bBfpCFzm4xHSibnruvsbhACXRENrhBSbDd9OuOryhBFgRpj3vt2rrWOVTv3UR3ypUtFgSG3JcObxQRasjfAd938tTWcc5J+1CzWNOB01yvK1wkTTWooo4WxaHLg/MkXXj7HhjquObBJu+oCkJ0t5sezaT1u27DgNoDZ/6F9/PYI=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by OS3PR01MB7778.jpnprd01.prod.outlook.com (2603:1096:604:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:56:44 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:56:35 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "geert+renesas@glider.be" <geert+renesas@glider.be>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>
Subject: RE: [PATCH v3 2/6] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Topic: [PATCH v3 2/6] dt-bindings: thermal: r9a09g047-tsu: Document the
 TSU unit
Thread-Index: AQHblYIJrz4TClfN/kyydJCUqHZzHrN3EusAgAAVU+A=
Date: Mon, 17 Mar 2025 10:56:34 +0000
Message-ID:
 <OSBPR01MB2775B1B2FB8EE446E15B38CEFFDF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-3-john.madieu.xa@bp.renesas.com>
 <20250317-ubiquitous-acrid-gorilla-71d726@krzk-bin>
In-Reply-To: <20250317-ubiquitous-acrid-gorilla-71d726@krzk-bin>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|OS3PR01MB7778:EE_
x-ms-office365-filtering-correlation-id: bf0bd74a-7a93-4ed3-993e-08dd6542626d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tS6u4sEztquV++Hq+HwytihrZ0ij3BioeRHucle/1M6Wv08H6FBXDTzZCjKV?=
 =?us-ascii?Q?i8aJTurV9lUBxBY42aGaFImKKAOZxd+dlE0/ssr15PtPFlW6jt8FjkhzE5/0?=
 =?us-ascii?Q?ua9L+kIl+mFze56kllMT2MO0136mQW3IOEq0XNkpK8DcubalSN+gOka44D/a?=
 =?us-ascii?Q?dqhl1Fxlrf0swPqhXn4uqscQWLGzwuEC1wV09uJdEGBQ6lEDHL1jfVbdJWto?=
 =?us-ascii?Q?GPhErEZYzuw3FG+tRQFBinFjGW3iJCTNfNWet3IZbu9lF+8FdLmnucwt61QO?=
 =?us-ascii?Q?WROxcU9Lav1jdPlCHeguTRDtqueNmSST9EIAvkh/tRYXOx+a/B45sod+moPg?=
 =?us-ascii?Q?Ujq9a5xAwsPPJyQ+axZw1BBdt29lDSslsAp8cKtX4qPIHeTIRWUjDjA2Nvc3?=
 =?us-ascii?Q?u/jEonJ/5A44iqfB3ial9Pm+Lh7/ISpSNR+Qp1z216WLDu2yN3uc9+6A9JLJ?=
 =?us-ascii?Q?8eKMdxYxBNOb9c8AwWUqI0LaznJcxTEQ+0yVwXhKicC1+RH6iZ6q3g7C4p6R?=
 =?us-ascii?Q?hlrhsxZ37UDIlRXFAA3jHBFphdgMJiqH944QwhVwLYGanRAE8jMyd/YMiJzz?=
 =?us-ascii?Q?CRJo0TvKPqIlgD0sT9RrZqdHt6M5fevuw0PGy5e7c9dZ0giLelxM7lhk06xq?=
 =?us-ascii?Q?SR/H359XtJ9CbZvHH/w81MI619w5bNOzVvwlxzCbhhbUdkzY2zwUSdA678QR?=
 =?us-ascii?Q?ZOYliDeN1p06WIo25LuWe6Gr3QyKG4w0hhrsOtb2OJj+EO19ll2cEQ8VftjD?=
 =?us-ascii?Q?/GCMfuCTOLLbCYkRBrZfkfuTvpxBAxqTlHlA5QBVgd5oehMK2EN8aPxsNOLK?=
 =?us-ascii?Q?Eifl75L3Q3TNnOrj3ednhFmYHIeIIguYk0Hv9pHLMBZ9elf5FrB2ljQsEVpw?=
 =?us-ascii?Q?4Cg0J0jzicE6OL0/WeXmU11UYXauGkVSw5Mf6m54YbhNSJcbdY9CYMF4Ud9s?=
 =?us-ascii?Q?N62IenVuPkg2CbhQnZIqSx20E4F4PeAWbr6TZfNIlQXzOOyuBF/jnw1bnQ+2?=
 =?us-ascii?Q?9BEryxOtsJbslSrD5tBJWodUNJ208H/6pLVtK6EgAW/pZoMMXgvuYqJeoLcA?=
 =?us-ascii?Q?UfO2o++Jfy/Cjg5sdFoqPTC13DGdCArQNep7LXq6lZAisbAr3hZ4sWDeVnb+?=
 =?us-ascii?Q?xdRN0+t+2k+vcWnl5HoDA7fK4Lm0VrA7njR2sIuxenc8FVvQ4LQHuxyOF0Cy?=
 =?us-ascii?Q?m1vmSyizzeXjMucwPEFQuUyLJu2/6FfdoNVtedoWKaWa1NBaonLLpfAm2qtx?=
 =?us-ascii?Q?oU9C7bVn+mSsSACb+O/38zxMlCEAP996h5vIssM62F7Du3iB0DueDIhOQpa1?=
 =?us-ascii?Q?mSx5Ck8mtfCtQmxX8eH2ODd4DHS1KFglDsfSAN1cxLvGMgJGK5b4yiEmJNE1?=
 =?us-ascii?Q?jXKGH+5DTp5tHQdyCF3N9lkTWOd0Tci5mgTilHXsz89zMObaXzjaT9Lt6RgJ?=
 =?us-ascii?Q?r+B+OP4dgcJo/dHEVdNj37ueJKV/Ge+Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6sTcDuPBm6CuXfDqLF6SRJX/n41Vdfqt1VkXKOl+wFtLWO8Y0wvdhrfxXtgf?=
 =?us-ascii?Q?Ot1XToB5/uIxRZ/2sWCecMUZkeHRzpy43Q2Me84nQvATMzKmQK+chSSFvIVP?=
 =?us-ascii?Q?IaXq9XrxUytm1DMv46DkihRZ4xgd86H1iarQ6A0jnQTPPeuUQ2DzzOLRjVUd?=
 =?us-ascii?Q?7FtDIIlTHsmq48VTDVZbWVBK/djounBMooktZzDqWATBVWEVMcQFJ9up3vmE?=
 =?us-ascii?Q?6HcLUby401ORuusWW5yf7v/x1LX+CvplBfTw9N7k7GSW0nHDqD1YgWMPBsQM?=
 =?us-ascii?Q?18/GyD/iOm+xMG5P4rqOxhFa28vGhw6HCueIdgR7c/dBH+gF7zaspxZYpR2e?=
 =?us-ascii?Q?UC3TpFecCW4ExN84rngQXm8epcjSlN3MfO64gW8i0VQ3lVeMXGpHv3W+Msi5?=
 =?us-ascii?Q?9Uzp5EwfAtXPsrLfAbCbJW29IokN4t7d5EWtH5TrfLQCODQ7PD4inUTo9AVG?=
 =?us-ascii?Q?vY1YyTdHhZdupRWJzJNt6smZ2FWlkC9bkGQbVhgriEmr/EvkHVf36ZbUo39c?=
 =?us-ascii?Q?GDlOGsgIZ1/v9vWW3raUyL6Jk2CVEbYePXcA6pYcUbDTQWTjdN1PNxtXF0sc?=
 =?us-ascii?Q?owAu28kUjWRlHO3Ou2Rfw0o53ybIeN8aKuAhGe4Tpw7Q1mjx4uxVdo2Vdfj9?=
 =?us-ascii?Q?fOERc6GQDqgyeG5hrMrp3Oa/gSPGJGqR9fivLWHxV8vM4RrjUpN8YcWVwe4I?=
 =?us-ascii?Q?Cwdg580fErgooPKKtM3ltTBCD11jIrni2TrPHOlMcfGyq7I/tIybaFB5CMm9?=
 =?us-ascii?Q?XDfPUDwONOcHO2mnefqfiCFq5MfIL/tt2Wpf1J1T5VGUkW2xmuRr/T59jQr9?=
 =?us-ascii?Q?1PRWK9vY72RgbXP6J8wbaWi5SwREq9C0E0te1H7nfF27JCO+ftzAm5Vkaz37?=
 =?us-ascii?Q?zVwrrdPzf/OraM75tDiuYI1m8viPuBkfdMc7Kf09BFxL/4K2RTCDno2rCgtq?=
 =?us-ascii?Q?VQxJfY6o4hBWPdDT9/DJzXeYzLDh0oNw6y1YbPAWcWIXDaaetvW2/02LRQII?=
 =?us-ascii?Q?ILcgblgbJ4QXlHISJou+FKfkUzOEeNZF3DTXpBaMLXdTP5VbCQMkt848G2QJ?=
 =?us-ascii?Q?lTgn1V4f+zfegBp5m6GvlkZz5Qq3RaH9IgZSUqpTkIFaflDQM1hENIbNiD98?=
 =?us-ascii?Q?KkF/d13ocCKSX5lihx26sW0R4Cuzh6NVXyckrVZvqPKl+zxuoNRXuawpA6As?=
 =?us-ascii?Q?Tv3HzaTLETuxoD8mAMC1j91+zkDLMpqhEBJt3zUMQM1NnsP4kYeChTllyvnB?=
 =?us-ascii?Q?7inpOONe7joh+q4JxXa09evfiihZySVI/8mBuXrxR7EOlTbT+113gTLW8ISK?=
 =?us-ascii?Q?H9KNwwfRdUXOABB8M+/5Z5D9+r9fxKXi0e8r8sJwGqVliVMgs1QXpRiMYqq2?=
 =?us-ascii?Q?672Y8kC4x/V2XdkB/unOqX8n5TYqxR1pu5qn4VYkQSODy5D8lwFpXW+iL6EU?=
 =?us-ascii?Q?Ax/47xIYjtMGkLZNmEhdLLV35MG3dcuYpTDi7hjTo2UbmUDUVVox14tfv+QD?=
 =?us-ascii?Q?4iTbin9T+qb9qdhYnb4u2MsOw29uYNtjzv/0OzTU3IdrXCVyw7Uw7ixJL+6a?=
 =?us-ascii?Q?9va5V5poNw/W4wNOZWzv2Z2GcoZwJpkppewWGBwQKrgOYGv9XDYtF/zXdrty?=
 =?us-ascii?Q?jg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0bd74a-7a93-4ed3-993e-08dd6542626d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 10:56:34.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZ15TO/FDMD/TefdNHfktx1YQA3Z42JH91Jns3/rHYTf0v8hPOePhm3Y+ut0iJfESNTv9QGzv4lzkSWHLJ/IE75XrWthywUYNYxQvv4oqfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7778

Hi Krzysztof,

Thanks for the review!

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Monday, March 17, 2025 10:29 AM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH v3 2/6] dt-bindings: thermal: r9a09g047-tsu: Document
> the TSU unit
>=20
> On Sat, Mar 15, 2025 at 09:12:12AM +0100, John Madieu wrote:
> > The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block
> > designed to measure the junction temperature. The device provides
> > real-time temperature measurements for thermal management, utilizing a
> > single dedicated channel (channel 1) for temperature sensing.
>=20
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):

Will be fixed in v4.

>=20
> Please run scripts/checkpatch.pl and fix reported warnings. After that,
> run also 'scripts/checkpatch.pl --strict' and (probably) fix more
> warnings. Some warnings can be ignored, especially from --strict run, but
> the code here looks like it needs a fix. Feel free to get in touch if the
> warning is not clear.

Noted. Thanks!

>=20
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > ---
> > v1 -> v2:
> >  * Fix reg property specifier to get rid of yamlint warnings
> >  * Fix IRQ name to reflect TSU expectations
>=20
> ...
>=20
> > +  interrupts:
> > +    description: |
> > +      Interrupt specifiers for the TSU:
> > +      - S12TSUADI1: Conversion complete interrupt signal (pulse)
> > +      - S12TSUADCMPI1: Comparison result interrupt signal (level)
>=20
> Same problems as before - you need to list and describe items to have
> constraints. Otherwise why 5 interrupts are allowed but only two
> interrupt-names (test this)?
>=20
> There is no syntax like above in any other bindings. If you found such,
> please share the filename so we can fix it.

Will fix it in v4.

>=20
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: adi
> > +      - const: adcmpi
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 0
> > +
> > +  renesas,tsu-calibration-sys:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Phandle to the system controller (sys) that contains the TSU
> > +      calibration values used for temperature calculations.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - resets
> > +  - power-domains
> > +  - interrupts
> > +  - interrupt-names
> > +  - "#thermal-sensor-cells"
> > +  - renesas,tsu-calibration-sys
> > +
> > +    thermal-zones {
>=20
> Drop the node, no need to show how to use provider binding.

Noted. Thanks!

>=20
> Best regards,
> Krzysztof

Regards,
John

