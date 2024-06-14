Return-Path: <linux-pm+bounces-9202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0A908F5E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9CF1F21735
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 15:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86995146A7D;
	Fri, 14 Jun 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="caE/0yzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2068.outbound.protection.outlook.com [40.107.114.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D9219D8A8;
	Fri, 14 Jun 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380382; cv=fail; b=Vh04QKEUgXrfOpgAMU/F7B1UUIc6gUsxsrM0vG7ylT+hpG9bErhaZDuZO+0i5Cn51TNBSL7F3SiWcmooYIHg4VtTknVL0JE06H0apDSY0mp4XYiSk6u0HBZEv7H9LEScHBZgFN7KRO8I00onxaA+eHtDLBlHlk+2JWIcU/EQVDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380382; c=relaxed/simple;
	bh=Z4xFJkb48oAR0YJLYSc7ko2GiYC8HLPEiKkQQQCs4JY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H9Kml/0bjS0199WZ+aSGkb/2XidPsExD+87V0RnxGFCC3uk/YdSa0peMuYT36bxKGVAflM1cIeyb34UOYSNB4vNJuSsuYGf2SgnF1g1THhCVveDOEFx18QXymMeg23EuPambu4KauswgWvn93DJkoWVmByAk5exwZt6Pf5ldr10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=caE/0yzf; arc=fail smtp.client-ip=40.107.114.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWqPUXUCbT+9AN2z8fSxpOXWNsI3ylVb6+tfVJAk9RJ1Y66ByQdfmhcJEr5L91XkOuNNtAa3dS4fE4UwT/e8FkhGUX88q4BEQtmkWOADE402L1Cnqll07AM7KwOGQ1iqAvovm7RTSytw8ApJPRx2ftUSfO9mb+pRhCl0xqX+DI7lynKUHJ9ffJOVSqaGoysP6OVfc9cBugq2BRBQJzBoU9vL9tPpsn12+ZBLJ1A9DCXZCwwS2M+5z6i9b4zZumyKN4EcmvZ+THxsd6SYystI5kcuESsn0XclXxNA9zfKCp+8nYHhXd1D66AFQ+jGMxjT5apDMWvWamn3h9/nbZ7kaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyc/dQ7TXgZciLUuZsgksomWXgXd7IYTrBdVV0V6wIE=;
 b=N2oBAxBOOEf6GnJNfhwE7jy81/ae9nu+ofHkcVubOe1GKw/hzwvPo74Vsrgnnj1lZLOhBCysAzNX5aEWuFBTG/P/2w9dp9aUJAua/xNYKPS8cCyUSVs22lVZo1By/DgaSa3KPX+JvASS9mo4iWH73dexoUXqzvHI97c9sFH2wHF+0Zfod74H/IvfFh03ycIpxE0eI5n6zNUeXuDSOp5jfz2PaVIg5nycffWETwAPa2Pv/us061KoZ99xnaZGyj8fp/rM9DyMHU02owuKHN7htaBnnfmdKlGPqNoWUhONDtCn6FgkFigta2/l3BDUn7ly8iRzUDHQG+DAT46qew+byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyc/dQ7TXgZciLUuZsgksomWXgXd7IYTrBdVV0V6wIE=;
 b=caE/0yzfgC2tyucSEfSToXpqeGxv0ncYFlX4zCzTckh90/W2jKX6dgVB/pt3qF4GmIrg8L0Yu4IXMZFAMYnH3YgbvYKdQnN8+0Cn6Z0HVk2irfeYMcfXkWlJc5u8pl8nPU5yN2mod3O2fMMRU8x/L+185RSa2yrf/iO1/zpcpHU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYAPR01MB5708.jpnprd01.prod.outlook.com (2603:1096:404:8058::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 15:52:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7677.026; Fri, 14 Jun 2024
 15:52:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham
 I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] regulator: core: Add helper for allow access to
 enable register
Thread-Topic: [PATCH v3 3/6] regulator: core: Add helper for allow access to
 enable register
Thread-Index:
 AQHau+8g8jdUQb+BWEyWYz8fbD0DGrHCqBcAgAAUSDCAAYw8AIAC3s8wgAAv4YCAABZhUA==
Date: Fri, 14 Jun 2024 15:52:56 +0000
Message-ID:
 <TY3PR01MB113461D9FCEAC66C85D940A3886C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
 <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
 <ZmhmWrvyQiCzzeYi@finisterre.sirena.org.uk>
 <TY3PR01MB11346B807820F681E7EEF7A6786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZmnDwKUlXCWFJ8W0@finisterre.sirena.org.uk>
 <TY3PR01MB113467AD31470F72C75DBF41986C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZmxUUbpGZiZMlHVE@finisterre.sirena.org.uk>
In-Reply-To: <ZmxUUbpGZiZMlHVE@finisterre.sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYAPR01MB5708:EE_
x-ms-office365-filtering-correlation-id: e25b5c4e-db53-42bf-042d-08dc8c8a0f36
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|7416011|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vb4ZzXv8UleGFfB3J4rP82Cx1KtXlYKdXuGIjYfqDGkalVNSugeWbXucV/jY?=
 =?us-ascii?Q?udJqHeqiRZjmgzD/dCXjwh5DnA2iJm4V+Q4zeqG2o5o0GyjhejBUiLYfFkxx?=
 =?us-ascii?Q?V9Hu1sTbocL7LphUtGbhS4tB3ARDyIriXTZKHDdmOMvAp5+6iUvFcxSBCkod?=
 =?us-ascii?Q?iY5YWRC6jkEOBED6G8PIpX+hnICD1d37RXsukqHJWioQ+AUuZs1qrJX/waLm?=
 =?us-ascii?Q?Emg+0t+/Bs4vCzPHUQqhytr3eF0w2WA010xogDRhYd1ZL3moUhG93pePPH3r?=
 =?us-ascii?Q?VX4hEmtTdo71l2/uAAH9iH5/lBwk1bIaCQbdaeVrwBKF9Qf4dOQZGoIxVoCL?=
 =?us-ascii?Q?QkkXy4246Ry9PrlX/7kRUrwg7k4P3Mcns7ffbciOBWdn4LTWXp/JgcfcV8+d?=
 =?us-ascii?Q?w2ASTQSEGE1VsObM4apw7yiCmyZ5v7N+WCF7wUOLUdIMkL3dDMCd7jPKerk1?=
 =?us-ascii?Q?iDyPqPSgR5jh2ygeR5NKtpV9KTarPD/d1bneedVgMFPj55Aeq/zXNd93DRlE?=
 =?us-ascii?Q?QdqZle0KlvExMJCnHVi7xipB9jEo0mELRzTTucgPN8goAO5248K29jFEv0VN?=
 =?us-ascii?Q?7lskwoIk5rdtwGkAuuGQtgfStchQP0+qXEQxOVMXPNZi652+taTF6eqyw6Wa?=
 =?us-ascii?Q?wuLuhFO0q6duA4yuNZos8JEX+FEc1h+Jyx8KP6XrZZYAkW4YWZH4pw9NeSDE?=
 =?us-ascii?Q?rlkjQZUnMP79Qphzys2h3+jZq5bnT5aoJ/pF8MWgLS5UkzF+V5KrYssoQ2u1?=
 =?us-ascii?Q?RqF2dZyE88ZWRiTi/nyUh8SfBEJqAN5XbNT2THRnRMhT8xuvs2dtOIa7Qn6P?=
 =?us-ascii?Q?pIVj8fXs+nba0hyVN2Zik8qE4GLq5+LHBu6pcEVoe43qz9u12z+l7EqBQd0j?=
 =?us-ascii?Q?5KE7gdZPTQqzggCwkP8uqYSws5qDOm5Y3hWRaND9Rlx1/jyvnTY52f/4DSAA?=
 =?us-ascii?Q?/merId1dr87ADZO/imQ90lMy/S20HOhepH5gApXsR4CY5L2rWXc/RKkSqCVz?=
 =?us-ascii?Q?tXBEYgSqB+hD9ePFy8MUFQLZMpNs0YgQzvnfFMV83TLiZmcZlrLYVJPFZU7q?=
 =?us-ascii?Q?Hrq9B3WlRB98c3PgGMtrXjKI8XWQbSZZceLCu8HWkZmtrN+/GJbjYvNfsQwW?=
 =?us-ascii?Q?LpbdbJlMzO9ARgWBK1NXDnz5lUk1b499c7vYRVBUObNQoRcHyvBhCL3OnE2C?=
 =?us-ascii?Q?u3//AUtEmk24fTEgyEYamoxOlwvlfA4MzVFuZDCovr0oOpZVYXEQbUG3/nxX?=
 =?us-ascii?Q?kx3vCfQE4KrsHkNC5uKXWVC+sbyhCYJlKutMA7rkg9xDk27CN261SthVb9Da?=
 =?us-ascii?Q?sYBsf4rRIiQZRSXdkdx36VYJVJ1YDIZtth9aqaplkqwd/fPF9wtPFWUqrd6e?=
 =?us-ascii?Q?k495i6c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eKC7Tx/vNWyPJbv2SHDFLKofU0BhZenyph+YkpMQDikxtRLxzrtR82tkN3XX?=
 =?us-ascii?Q?KKAGWyMkYAqX1uHtuQTacAZA4hII763YtnVzETuZKCk5sNKMremOiDmxt4Wi?=
 =?us-ascii?Q?xWrSL0Ql8SqCSebdy4DuHh0kXYiwKNpQaYuA0AcuB7LkszPmKmxZ87Ox/+bu?=
 =?us-ascii?Q?BL5bNjorhnShOQTjflQaYc3tIotM0BZFnf3YvRjIBIbM2/jdGCqhxPkSWMln?=
 =?us-ascii?Q?3WRJ8oVFAfELFyxqAtUcS0ZiiIH7XjqeNTQmtAG8GogZjUdi1dbge43JhbHw?=
 =?us-ascii?Q?J3Cf2pUpeO5pyPR7XV8dp8XJyPZh2BgsPmnEhklBxRCL/zfjilfPjHb5PH8z?=
 =?us-ascii?Q?kA9H08CRoSpR/ZHiaj4B1lFebWhjeLXR/bv4A+SpK3QXxX5SBuze9t7Cgzmd?=
 =?us-ascii?Q?KSipXqVdSOeMJGguWWPZr2K57TIoSHYVshZbmpfYfclnM4T7f1pR6zBMfMtX?=
 =?us-ascii?Q?atIRsfqKWwldztInQ060HRpaSKd7b/zCx37svKAwelouf7v7ZVzc5YmBTWQG?=
 =?us-ascii?Q?HeS7mUp75WzC60+dNPt7V2Jj3R+wQL5TqGniosMs660q53SW41rxwujJkJo9?=
 =?us-ascii?Q?FMFW0T2p8QSFy5id/qzaZZ1U0pCQi4scbIf9ptvbuW6BxTz4AGhS8XeyBPw6?=
 =?us-ascii?Q?kEAnKVVpbZVK6y3hYdMX0PX6qOY7IC+9JhMpcSFetmgTPJ22MZCTmc1v3jye?=
 =?us-ascii?Q?RAtvhmX0qYQViNbTp4Blf7ZJQ2iVfEDHgt1YJiiKdwvwsrBUQlYzcRSVhBhR?=
 =?us-ascii?Q?V0cCAF1LWFgCCq5jbI8Xswv/R4qw8G2UqklCK68QJTpiB0mUUsz4JnVmOUQb?=
 =?us-ascii?Q?n7XhWkZhZOPHnwUZzSh5pWhKKvhib3eENqFwW/2RiWZJsIwvhCqG3eD+9prK?=
 =?us-ascii?Q?tj8o6/SaPE37an6m7ZIiBWH/xDZ/eaePv+htcNMXdz1YjNikv7x745mcj6z+?=
 =?us-ascii?Q?PN6xwB71SHZ009OFx99EIO5gp8ADmO6zHXaUyNAGLvHIJapLKkGzy8z6RENq?=
 =?us-ascii?Q?2lTpp+ODt1zJEVmMiPSQq8VaqanVG0LELJcXxbe/CavKxVL1f2UHs+nB6FHd?=
 =?us-ascii?Q?VRhFiBe7Mkq36UYoV0aEWsmpVZ8nrYo/oIdxKa00LcRg5P1zYL/jm47eONo+?=
 =?us-ascii?Q?D0Ud5QtbPcMWtK0RqPN+1RVgFrFiGtqNgnLEX5bzdB4VN82zRvxxeq7htO4e?=
 =?us-ascii?Q?EO+auOWMbtYZj2yphAjY/iiEkqBCz7RH5xs5xi5+kwkM/ZdtL7FDHHQEKfRt?=
 =?us-ascii?Q?eyyxQr9LxO3R4HR2NgmL2GHlgjPBItcmeUr+MQVvu5Eh371NObPrMlLm77Zu?=
 =?us-ascii?Q?UBefXf1DNQKn0AebP4Z2pdj+/F3kiFGnMMYuzCOO52SZoCklr2hNkGwTVdUD?=
 =?us-ascii?Q?t7VQKJVTJRlszKc0rvnHu62U4CGAJymy4QWCuh2er5A55b1Ymm2XXYe+htWA?=
 =?us-ascii?Q?plisQg0D30nIMacWi64drNYxKIFzTF4e6akb96st4xRE6xcb/3Ph15c/9FDN?=
 =?us-ascii?Q?J5eIZPwXDDcV0LnaK3aL1uFjOk6hwdlLgi2d6n0XFmHIBSX4vBpa2SR1rySt?=
 =?us-ascii?Q?W65DLHZxlvOc9sDk1VJ4yzbSo2s8p8dkOVdz6KUOXwdbxKH31L69XMWbOKcg?=
 =?us-ascii?Q?cA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e25b5c4e-db53-42bf-042d-08dc8c8a0f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 15:52:56.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOQB2CkBog954Ii5ZO/15JA5kf1d25bEuRsBIBqK2K7ZQh42Qc7wMNX9jsskH0muuLzcQCqfSpypNEMNGl92b2cOqjGe7cN67qzPlAb9u2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5708

Hi Mark Brown,

Thanks for the feedback.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, June 14, 2024 3:32 PM
> Subject: Re: [PATCH v3 3/6] regulator: core: Add helper for allow access =
to enable register
>=20
> On Fri, Jun 14, 2024 at 11:43:39AM +0000, Biju Das wrote:
>=20
> > To access the hardware register for enabling/disabling the regulator,
> > consumers must use regulator_get_exclusive(), as it can't work if
> > there's more than one consumer. To enable/disable regulator use::
>=20
> >        int regulator_hardware_enable(struct regulator *regulator, bool
> > enable);
>=20
> We should also enforce this.

OK, will enforce and return error

	int ret =3D -EOPNOTSUPP;

	if (!ops || !ops->enable || !ops->disable || !regulator->exclusive)
		return ret;

Cheers,
Biju


