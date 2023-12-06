Return-Path: <linux-pm+bounces-732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306D806ADB
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 10:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B1E1F211B9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 09:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D541A71C;
	Wed,  6 Dec 2023 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PvFnQ/gT"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB5A4;
	Wed,  6 Dec 2023 01:37:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTcdDsWr7LivYd8mPDz3XSzjLnwuSmPtq86T4TW+YLpRioXGCpSn+f6xIFb/Y06NCiVQPoWcfAZREY4bctbgYI7NzFWZRm5eyQun2+VxmO6k2fEbT+wAi72W7qhw6GWdJ0Mnr+/IAaLNJfwgQTdyibUzj1A34IqlnQFUrex/hHXLSJ36xFxPmPdvhpGD/6Aeyo1Dke//vNHG9/v+t1Z3oq/ou8jR73HU9YNwoSmuLfNQjQgNAgspL0aThp7n00dyfjG02xSg/ZBjx8d551rWrFkD6mC2gdrY2kAc98L4Q5bACgJk6bl+ROsYahTDbgsiCwjw1IcNpo3K9pxQkoSlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm5dHkBTbJ6mR6oLrfPFZ9rJEYBiBTvr3jPNiqgqUXY=;
 b=Z6i/MXt9usPBE7VPQpnI1XrubZPpUH+viciBQZo+/lrM5mFZC/whDwOPe2bAT0btIVAy4IDyK9oUFeD5asYJfOkfKho5Qk/TLslA5CkQsVCI6t2teJ04NW5gAiG9WU1Y0r7vNmbYlrg03UgCZftaEixVHS6e4Nh0x8PMEDDodFJHXJFndrHW/ig+zFlaf3DYyCDSYAUTXYfEUPUXCCIekeQ7NCpO1sHvQfUelhu/wTSTHPvu+XKYSfz+10vGkjBgDRRa4z0YUYaZWIipekAwJZpMMom4qXgSNdVqhc7kWf0F/NyIiXQKPwb9CwvxJz3hgZ6Mr6rQRJAeI7rIPWjzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm5dHkBTbJ6mR6oLrfPFZ9rJEYBiBTvr3jPNiqgqUXY=;
 b=PvFnQ/gToLJ2coDfsZhxGHoFG+pWBT89Euhbq8lTgDInpknCz9rqjFmPGalZK46I4smtaPMiooGJN3bG/kngvbDLG5p0HqIPT/ed/+pYBTkdOunqrNim5VtybTz3DgyX0mtqezDJwtSrs166GqCvjYW4Glxlkur97n4WLGKOWpQ=
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 (2603:1096:400:366::13) by TYCPR01MB9959.jpnprd01.prod.outlook.com
 (2603:1096:400:1d7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:37:36 +0000
Received: from TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::db2e:9e88:68f8:486b]) by TYVPR01MB11279.jpnprd01.prod.outlook.com
 ([fe80::db2e:9e88:68f8:486b%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 09:37:35 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: kernel test robot <lkp@intel.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Support
 Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2} thermal
 to json-schema
Thread-Topic: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
Thread-Index: AQHaJVVpNr8VVPZoO0mAS8LwJgirUrCbsDaAgABT9HA=
Date: Wed, 6 Dec 2023 09:37:35 +0000
Message-ID:
 <TYVPR01MB11279035E0EB1AF11C78453178684A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
References: <20231202192536.266885-5-biju.das.jz@bp.renesas.com>
 <202312061242.lKDoAY9g-lkp@intel.com>
In-Reply-To: <202312061242.lKDoAY9g-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11279:EE_|TYCPR01MB9959:EE_
x-ms-office365-filtering-correlation-id: 34fe1763-6844-472f-31a8-08dbf63efad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 euYQcf2KIKO7EocaWdsgZ2Qn7vjHZWAb4C1YcO0yU7ieDUJBFP2y/LupW7a+dWjm4lf3mmd0xuZ8AAuhJy0LBHT1YxUSze3/7sJc+ptriYTU3Gp7GnyZ3awIMJIYuio/j+7Cddz+OIsQcVdhQqx1bL/7c6ooFFVj1SpvpltIkzVGAF6KBi3Jz0Ts+BaNO4mVPEEKFvYMkpbq6g+VwKvTnN95D1UNbWNyY2bE2FV4uOim6rxmCIkjtSCaxY28kAc+LQBtNbSDfJur/1w+4PANiOXnGbNRLJSBecHWDrlq78RXNi9OLR2b9UzCPRx2Ik31hctrPp8ZmoXO+oKGbGOrFSQjhMP2sL2+SRVsxGluK8xo0nRnl58nBJn6d1gKDEpxl5sGtZJjGAXla30nlWWKgK1w1ecQBjkB6HWMfkiTyKIs+TCi/cG+MzKwzYhScqdt20yO8/FYYtNbeVhQ2r7eKcJNDUN+jCX2aoNsQWK4A7apvTuG1XZDNjLvQ+Fi0D0HTmVO8XnT99R6e5estE4qmYU90X3PDvMxKsexd+Vs+5FhyKMilkswA/Gf8lGlyb6bS+u3e6nrVY2ogliATzPpcwmlOZ2VI6/b4BIOGUY2enVwtaz9bcukGdGLP5MKTXgSjU8IaevTa4wir+sd7wZfdQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11279.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(55016003)(478600001)(71200400001)(7696005)(966005)(122000001)(38100700002)(83380400001)(6506007)(53546011)(9686003)(33656002)(8676002)(8936002)(4326008)(64756008)(2906002)(7416002)(5660300002)(4744005)(86362001)(41300700001)(52536014)(54906003)(66446008)(38070700009)(66556008)(66476007)(76116006)(66946007)(110136005)(316002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EQySvE2cpHxzDGpdhGLuLarKYwvk9Fl09F/DJMMUi87n+osODfx51pr1kTGu?=
 =?us-ascii?Q?JXNrhamJi3gENe5nNsIBmvxtdDRrvRavksS7vLWMbqiQVvdJcoMVlypkPL+m?=
 =?us-ascii?Q?J4TDxxrxsi12kbyihYYzI8l8iNW48+0HtDF5DkUHF/YRX3olvvSnIU+1W7Io?=
 =?us-ascii?Q?2ReUHUd4UOK7iVL9Ne2P4l1PZ9D/JwoILpRzyEQdDTop6/Og1FfOGR81T64Z?=
 =?us-ascii?Q?7yYovFO3l8ylgCpaFPpYf7LU/QpAxBDfO13JPeb3t7LtCEYYZ41Oa2LdRd2C?=
 =?us-ascii?Q?j1vvjgOUuvMDwOqG+AG5b2ebGRBZU5z/HNEKer3ra2GOMi0PmmP2ZkobgnZF?=
 =?us-ascii?Q?pIL2JjveFwFQERRRkheyQYWB9Ra0qn2eoacPjflBxgVcwJnrHtGVfxX/HKDm?=
 =?us-ascii?Q?wSysFc7jewmPXVaubYvJY89hXg2lXZho1voIdCdtJRpWfhx+1eRcSWXFK19i?=
 =?us-ascii?Q?kWDgTeZETQQ4PQ4MIN3Am3Ov3rr9pPhRaBgJII3erpk4GoDyUfDwDQ1Z6Mid?=
 =?us-ascii?Q?utDO4xAJ6dmEBKRnT/eic9cmHaTwNVwhtPjKj4BtW6RacQNzmYMJWBsaRYQK?=
 =?us-ascii?Q?wwFembM0uFgiQghUyXGcRzt4w5lrZ4Iy1JmS1yMTc/kYfk6QerxsXRq71n/+?=
 =?us-ascii?Q?d+lK0zQ17us3IQ4V7/LD8Vrqv/vDochcKX6WUHpXTLPnGQEIFb2OhMP3OLqR?=
 =?us-ascii?Q?pS4+RabIZ4TCWVi9i/f8qbr7vgIdKmKJU1yT+evA+MyOikOO0C5cjb9uJYeA?=
 =?us-ascii?Q?ba2ur5Ci0VRDx0yyg/+yWLOHS/281dWLq1N/GFFLekUB+xbIFT9W2WSU1Hc7?=
 =?us-ascii?Q?RcujB9mMCUFswu3GjJ6u1VPbk3pcuNc59EKdczPd5qfOJtMTphxeojxOxL/A?=
 =?us-ascii?Q?WVDtPNyPOe84EIiWsgSo44xsueFAP2mslt7rFTjAV6GTy2/IrYT3kceImjBx?=
 =?us-ascii?Q?ofJ6ENvL1H0PjgxiETrLIn38Q66rziA8odQmI73h6BpvsGwgp9zMBtPlG/CG?=
 =?us-ascii?Q?7FxgKAFJ0w+fjABqU6ybaewiM0zYhn7ote2nPfJufmDZHXHd+0CAmDfGyziC?=
 =?us-ascii?Q?84Ag1OuWj0X+1OrmeK7Mc910gwaw/FaInBZe0Lr2HQbM9PZcAeldTYEq6D2J?=
 =?us-ascii?Q?M/RLdUOPEL8UdPhMlYn2Nj6ocmeOW8Q3HofciavLEX1oLYoM1MJ9iMTeTh34?=
 =?us-ascii?Q?iPxZ8wxq3TO7O24lJ7+nENcSb/toDlv489BYPnx3yjEuRZmtrfqK9auleC/E?=
 =?us-ascii?Q?jNip9dKCYTg17sUuWlqUsSXYPqYv+2qRusst4pCMzYV7H3b3NTNS5JZ5zAsV?=
 =?us-ascii?Q?4J6vfdgoDjmStYlg0XzWnOY+Uwq4d+OdpAR0rZoArXtKML7ejFPMZfgTq/BA?=
 =?us-ascii?Q?Fm8H3v2cT0gEYgEaUpEqUCrmAO8cCWDDuQY48N661f7nvUUQYw2agwh/y2TG?=
 =?us-ascii?Q?GW/6bNpb6mG73cCHuZ2a3YUhOG9aGTloSQhOuOBkjd/6ErvGhgCwNOUGXwEc?=
 =?us-ascii?Q?ombl5grzmKpfxbY2yhg7pjv+fIqQr/Adin3MN8/G/XmZisjBg0lsdrMRwNfu?=
 =?us-ascii?Q?b/RrkQO30Xk+YAtVK21lg+EOEePr1DjYPR/UhzCPLC202k0E4XR66/TRME/h?=
 =?us-ascii?Q?/Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11279.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fe1763-6844-472f-31a8-08dbf63efad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 09:37:35.9503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+PvTgXvPifyQHVbbM1TOJr+F0xLk6mF7ECh0d814C21N7H/ofwbz69XwUU7IzrccW0zj9DzwGb1iWPVXvk7MYv6h+mnvVGIs117p09ydFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9959

Hi kernel test robot,


> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, December 6, 2023 4:34 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>; Rob Herring
> Subject: Re: [PATCH v2 04/11] dt-bindings: thermal: Convert da906{1,2}
> thermal to json-schema
>=20
> Hi Biju,
>=20
> kernel test robot noticed the following build warnings:
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> Warning: MAINTAINERS references a file that doesn't exist:
> >> Documentation/devicetree/bindings/thermal/da90??-thermal.txt
>=20

There is an updated patch series available[1] and Please retest and provide=
 feedback if any?

[1] https://lore.kernel.org/all/20231204172510.35041-1-biju.das.jz@bp.renes=
as.com/

Cheers,
Biju

