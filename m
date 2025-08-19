Return-Path: <linux-pm+bounces-32590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CA1B2B6A2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 04:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA861B628C0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B02E221FBF;
	Tue, 19 Aug 2025 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ILjhwgAJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEF189F20;
	Tue, 19 Aug 2025 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568919; cv=fail; b=FiHZNeCa5nHs2Fd3ZFpYfHpW5aNZ8+8XFkeTH5Q2qx6yaP1TtTgrdM5hK4l5xMpe8+WHGZVSReRfrUWKYZV6U3KSd+usxU/pcm3Vx1ww5oaV14ogDyctXrVxfZ3X27fqnaPgBE5MHAmrPFQerVsBkpmTjEG8IjskIQhhIfP55Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568919; c=relaxed/simple;
	bh=5kdreTLOPNNAu+rtroPmDUkDvX8DUxQ967ZJzDKxxgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Th7IlCxY6VsDEer2wAhIgBI7zPQSmDKGolvUGjAhkqN5v1v6+wgFAWy5D/FTh2OakFTR12blm8bVAgRRTIc9ocOr+/GKJYzXLxximPR5GQSB1y0VYzH7pXQbqNfbimAMvaOSN1ovRJ+lJJiq8XALxYWXoIkGlJ/fNi4aqXzqSgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ILjhwgAJ; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NabVzh0Q0UrwXceCS5ipDedhgy0CCX7p6h0O5mnTMCy580hsm/tB0hR9t+ir5JJCzHH7D+2ifvCbzBeGJEDPaXQO918OVKSiuZiFGbFpVktr18CRKsGhPELGkWn7QIt6AYJgqO7EVaZs7G3pXz6DjPSgxcodTEdSk/UKI87tqJ+r0lDUXPw5br7yLYCQBDUVTHmRlBUPESCnUxenLk+Fw8dR6TT+YaKplo2lVXFV1FIiOG6V3D70jCRS8vV7wg3k++MeuHv+jZi8bdE+88QfFGcBHXOnwNcX9XbCkcFvpjFUX98ZcqQviLHUepCmChGbLsQXdMnCFWP4Pxz2ALgdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTF9R3Uwjpzb+7opizN5E2zpW5L57e1ezxM9fI4SiJw=;
 b=yp6G8+TnE/F/A/2+hmMJeoLTUD9VzkoJNIPmi9r6X/mWmKno0isRKdenI+ZCBsg4RyTPFQr0/Q0j7A37m9BmD/EwmXZpNKaS4xEQilyxXzdHbO4SMZocuiOhDMrqqM5SY3kZDEd22M0fvqlQLyIK8l0fKZlJGNooa6YLNWkNCcc9Dpr2da5vETToHyGvvNQMrU5Y3eqoGSs88Vw/MCWCNUcN3R5ffacndr/lWCh0fiTip3Nw/C3T4dzuODduH0sd1BuWA2sT5EDINvKopQT/IXy08yxSbdZwfYhSnDMCB/jGYNgDspVfbCro6Nsp+qy6UCHMcLg9cCqeQgjhxLxaxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTF9R3Uwjpzb+7opizN5E2zpW5L57e1ezxM9fI4SiJw=;
 b=ILjhwgAJZm2esFxTs3S20bW2RSFe5fHY8m3Y6LQrkMIL2MDDj456/wcyFE0zT2Gp8GdWizjlf5CMgEKDL3lbNPiaiUrJon4F6PZMmyhpQCYc+/YCoGPzqlLkWfYqUrNex6CZQdGfW9umzIpuXAw9hUiKWsqKsISjaNtexDWqQILqFpOpu5S9xA0Al14H5JXt7ACITloGW86SZ27iHzMd1U4aeFkr7MSTb1DKj6zwjVgVNW5FIC7oK4D5wbbsmbQoKsCkgltwtUBY7L6Kd+r8Q8a4mFvdWNO9CMA+P6DIM/8SHfiIFya+nFgz9EY4u3e0mlN0tQf6LJsVeJ1YDokGHA==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DBAPR04MB7397.eurprd04.prod.outlook.com (2603:10a6:10:1a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 02:01:52 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 02:01:52 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Thread-Topic: [PATCH v3 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Thread-Index: AQHcECMv67BJ4Jiud0KK0HoCLIERR7Roj5CAgACnVqA=
Date: Tue, 19 Aug 2025 02:01:52 +0000
Message-ID:
 <AS8PR04MB8642A5ABF8CB54BDA683D7368730A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250818-imx93_tmu-v3-0-35f79a86c072@nxp.com>
 <20250818-imx93_tmu-v3-3-35f79a86c072@nxp.com>
 <aKNL7/uLHW3Xsrnc@lizhi-Precision-Tower-5810>
In-Reply-To: <aKNL7/uLHW3Xsrnc@lizhi-Precision-Tower-5810>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DBAPR04MB7397:EE_
x-ms-office365-filtering-correlation-id: 591a0b4c-7f3b-4930-3050-08dddec45dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RM7waEt/aMOZQ3BTW55hXNaHLgxsnte3hor+D7bIHdtLuz9cRALninH5UJhV?=
 =?us-ascii?Q?VcnM4/XIuME8nlrPa5c+kcZRY1ilSskmgPrSF2Qo/b9WqnMewk4CXv1rWDpY?=
 =?us-ascii?Q?0sHrlofT8Xn1VMPlYafxO8v+YKRJ+kiDsIDWkpEfHgUZh83V2EwqKEdLJ5/i?=
 =?us-ascii?Q?JSpgAVRpCXpMvEvVCrluSKYsQQQfWh7ZqUbYOyUtFMsoe3CssDKJQBBRZ0iU?=
 =?us-ascii?Q?MKJiEXlXMwmzgxnk3RV5eySygyKhMkUYxIrieu9R3KTP6cbj2LZBBe6jyuoB?=
 =?us-ascii?Q?s+upMJFOxuf6OMOdT8zUrf0zlh6/78QS4rIkaqBaAQZoWmMTB8KStzxDAhm+?=
 =?us-ascii?Q?YEbHHjHvRc78eTtvonRzmfMtSMI69ue0iQB69O2POliIdO+k4p3X4z7glMbC?=
 =?us-ascii?Q?ig99a4PRzln+J7XKfXaYMHKQm/WfZMHam3g8me8d0O/XALhX4+j/ZI3C5p/M?=
 =?us-ascii?Q?+IJI530M4QAaV9E6Z/H2Knlxeal0s41IjXLTERoVKSK97zrrJnCN66UO0RSb?=
 =?us-ascii?Q?+hPzypXshidUiJGknliZi8VLiIXEZWmzh8U0e1vNzS4+2vN+ZFPoEtVcwC6v?=
 =?us-ascii?Q?oXTgWuyTjL3wCSO1yTZ7eFfqgTmS6oC4cuksC+SXFHHChFMVIRLO29x1hu6q?=
 =?us-ascii?Q?ykOXeaOb+d3qq+V30NTyauYt5OsgazslAgPL1YJ5zi3k4tNA2PDrv8XmqbL4?=
 =?us-ascii?Q?TblbMh9PRCBn5Aoekq+n6dOEQh3HbaTXjTbGnmSK41+U4ScpA/EjxF9bHK2+?=
 =?us-ascii?Q?AeMbwtQnw89fBjgYJXAj6qGgD74BqJ5ltLlWJ0nKo0NFQAilDyLCm7DNmqz5?=
 =?us-ascii?Q?zCpaIyastrzeqQ+efmlKRK/7Wa8uLIWogCAy8MXoFufstq+xpAwql6e9nUGD?=
 =?us-ascii?Q?owK4XnHJaElEelaTuerLT3noti6MHMzkfiWHXdNHYjOIDnqthJEMrMP4/p1n?=
 =?us-ascii?Q?hRwXkzlTCPl0pMpxXu7YMCUCub7/IgRu7iFcvcUtUEcmiunoRzyTauDBoJjR?=
 =?us-ascii?Q?YqguOKkPtqwSxbmhcpnVeVcJsRB8cetLfurv/HOsFx5QMJjWOmtXrkSLxh6z?=
 =?us-ascii?Q?Sa3ALenymTYISJsKeun2zwBtjjFrzyp8R3S2p1GNj7nxhh3OPzCaCIFTAonu?=
 =?us-ascii?Q?551Ac74X/lIgKaMPlS9zKjKu2J0S6t0Z86O+3rQrT+6pp/s+pquFdwNp071c?=
 =?us-ascii?Q?o1zaq+tC/ffF9+xEGIAhNeed65eQplkyEfqaWW4gd+Ltkr14TC+vWp2sy6vY?=
 =?us-ascii?Q?gbKwwmWbYfGnWLscZGrP/o7Lu3r5NtptoFde9kGK7gYOMKH4RvT70euoN3vG?=
 =?us-ascii?Q?hxU20rPc0Pd6/F1Nzu6m9UdPDKZ+j90ucVv39qsuAIY7wvk+022kf2dKeElI?=
 =?us-ascii?Q?bUW1s+lDdGFbw2gASpQiLvaJpjaB96X/CLPGZErPveR//i/MuAWqGFRqDN0L?=
 =?us-ascii?Q?Q9rh7O83erFM1wmzfGyBWTCHE2gHzxo4lqvOyJY7KtKxK0aDx57L8Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MWPK1+w5BBCZMQsER99rwYfIezqieeMxpZZzK52zo+LDU+zGGp1JoFmEo4SC?=
 =?us-ascii?Q?jELimwJuZf6d+9ib7004Ff9jRs8VejaCMxLplLwzHTL0S98CbjFhosxfT64j?=
 =?us-ascii?Q?RR5kUnVQHC+XLamhr6j+NVTqzyWx8ANDrY7JpAlP5judd5f9PlqaZQ6Kg0+r?=
 =?us-ascii?Q?F+rK1cSgwJ+HQbCfLGzu/5/wUibX7olFploqurnik7m16wkoFPcN2OD7T4bC?=
 =?us-ascii?Q?ZbVv8bu/fLmfZt+d315KmK9yuKSuG3h65zQgvpmJM33kMwekEK/jdxt9GCBQ?=
 =?us-ascii?Q?Z/k78kT/YBIiiwFjWKKWpQT/5sUAq5Vr8mSfCIMlyIL8hhNrwQ4fuNl6AdV0?=
 =?us-ascii?Q?cEa9doJarT9t+qIqZ9queSU5k+jsD1lzpdhLS0drrekunjF7r4rtwONiusdE?=
 =?us-ascii?Q?Sv+utxp7+9tbx3KEjGxrCSrm4YFGHICOgZKT9amz9eijCKIUVBTxIJnhowc5?=
 =?us-ascii?Q?ovl5bb0zssDAKTlvzMZ5MRRuaJneJPN8o83QOzdf6LwdJMR5Xy9ROeoNglZz?=
 =?us-ascii?Q?Pdn2pXCSUE2B31E/uwlReAAyjb0aHYmZjvOeKxy6UUxcL0iscRqfRvP++DWD?=
 =?us-ascii?Q?1eFzVw9dLUTyoiXyWtFGe7+Wge6MDKNtyr569BD09En79nGTRtrKzniUvKBP?=
 =?us-ascii?Q?MPtSnVitDWkQAjc/bphX5qCE3dItOCrUPHdvzD8IyXWvPglCu16jkuwtd11p?=
 =?us-ascii?Q?cGVUrQGoVxQJ0aqOkxoqy4F9TCIn+3ZRJLBdRf9jIcXQe0g8ZJ0saDWG7nuE?=
 =?us-ascii?Q?lJsCZybOZOm9PK+f8bherPzUNY/z5hTbbPkmofBQ7HNKR/F6BNYMw8RRVY76?=
 =?us-ascii?Q?Yu9QqVnkZWsxw1J46m/D37Tq/oIKU1oCpcOPZ0T0j4Ywn74izbUQ+QivDdGo?=
 =?us-ascii?Q?tz08cJUIOZwOdpM/X2xLRkqp/Qz/6CX5NK2bgn4gEepkAAyyIg3aiwZL+Qcd?=
 =?us-ascii?Q?Al1q2c1gs+F1KI3B0FRoK4W0OQd0XqkaT99YtXAS7NmAMQOB0LrDE7nFkxoE?=
 =?us-ascii?Q?CiNryV1R7nOoifJXOWLpzr2ji2L2lCzG4iX3kDU3Z67xJIHqBc26Q40S1axn?=
 =?us-ascii?Q?ng3bwQHUr9tyo2vic1FRah2htswg7DiuoXYFpF+xP/nJJBuk3cHm1VNXIJzr?=
 =?us-ascii?Q?M0AnHBV/k5uDandpMnhZqidbQ3Cspx/pxA7amKELq9SSftFFq3cX+eEdzHW3?=
 =?us-ascii?Q?5WfTo/racVp+aCzBfbz0V7du3MMf9h9EiAuYSBWnW8KVyZxLW9z+NBWFqYEW?=
 =?us-ascii?Q?sjJeHVSNXoNHTDuKV/sbZTrruKxoUWqOisyViCqoyeiQHYPf0FxgWprpSJrd?=
 =?us-ascii?Q?Jran2rXSGBV+iDiMEV4ieU0loRTW7eIZ5OcnwdEeZ7RwmfBwiHZINxc/gOIs?=
 =?us-ascii?Q?ud6nu9WdbPZdDZjAVy3r7Wa78U76eGP2fvafTs4BtHB/+Mv/yePyZl1KZGS9?=
 =?us-ascii?Q?Bmz6YwM7oLv+kbsi2j2m9ETV95AXhiKCLz/DsNvtxcnBv/7qacSkwQiG6KRk?=
 =?us-ascii?Q?vILx1xYxYVDa+QMj2hLN8iSNo/Ol5WKqI0NxVrc18PXQyUY2tNI0dGEuZVeV?=
 =?us-ascii?Q?F+9yYZw6SRJwYGbinu8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 591a0b4c-7f3b-4930-3050-08dddec45dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 02:01:52.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhiVQUl20Ur5L5GwGsFwjgKvKMq95u8ppPcRJaXSSK05HNatkC2OfbtxC8L9zKtVNTzcnJOIWpptMStIW8gR5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7397

> Subject: Re: [PATCH v3 3/4] thermal: qoriq: workaround unexpected
> temperature readings from tmu
>=20

...

> >
> > +	/*ERR052243: If a raising or falling edge happens, try later */
> > +	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
> > +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> > +		if (tidr & GENMASK(25, 24)) {
>=20
> you use GENMASK(25, 24) twice, define it as macro.

OK.

>=20
> > +			regmap_write(qdata->regmap, REGS_TIDR, GENMASK(25, 24));
> > +			return -EAGAIN;
> > +		}
> > +	}
> > +
> >  	if (qdata->ver =3D=3D TMU_VER1) {
> >  		*temp =3D (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
> >  	} else {
> > @@ -238,7 +268,6 @@ static void qoriq_tmu_init_device(struct
> qoriq_tmu_data *data)
> >  	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
> >
> >  	/* Set update_interval */
> > -
>=20
> uncessary change.

OK.

>=20
> >  	if (data->ver =3D=3D TMU_VER1) {
> >  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
> >  	} else {
> > @@ -246,6 +275,14 @@ static void qoriq_tmu_init_device(struct
> qoriq_tmu_data *data)
> >  		regmap_write(data->regmap, REGS_V2_TEUMR(0),
> GET_TEUMR0(data->drvdata));
> >  	}
> >
> > +	/* ERR052243: Set the raising & falling edge monitor */
> > +	if (CHECK_ERRATA_FLAG(data->drvdata, TMU_ERR052243)) {
> > +		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
> > +			     FIELD_PREP(TMRTRCTR_TEMP_MASK, 0x7));
> > +		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
> > +			     FIELD_PREP(TMFTRCTR_TEMP_MASK, 0x7));
>=20
> the same here for 0x7
>=20

OK, will define it as a macro.

BR
> Frank
> > +
> > +	}
> >  	/* Disable monitoring */
> >  	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);  } @@
> -389,6
> > +426,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
> >
> >  static const struct tmu_drvdata imx93_data =3D {
> >  	.teumr0 =3D TEUMR0_V21,
> > +	.tmu_errata =3D TMU_ERR052243,
> >  };
> >
> >  static const struct of_device_id qoriq_tmu_match[] =3D {
> >
> > --
> > 2.34.1
> >

