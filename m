Return-Path: <linux-pm+bounces-653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37128023D4
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 13:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D631C1F2110C
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99096D510;
	Sun,  3 Dec 2023 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mv1Orx4q"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77516C2;
	Sun,  3 Dec 2023 04:43:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLp+lEHMxNOvxV6XsXty1uWAILXzpDG3SQLGNTYnzYP6jlRm2jGwD3OaYIR2NZ2D+XlM8Hj6TQ1rwpQeAEy1wBd7PfJeiNvZW7udSvHAbrZTCt1v9mA2E6ziia3CjGmNqh/OI1dF4+F63HI67Dn1k/UcIs5jGBTdDhGtvprgoDQObrJDJuxaV9opGnEmSmMOKkhZEMJkoZjZTCRnLE7N+39UAvaHbWthQdGXYlTDyvd3ka+jT9Dw3SKI+b227UHE7H2AMIlJUQWAQs11rRkzYCgB1+Fo8ms/24Ax3cZSMMStu5Bu/FOQQTecIcdP2RRkl9PerdDE3Eb2LwAkpuIBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OewW07s704/QN7kO32Q1fI4NKw2OutVSDVmxlVHvj6o=;
 b=UlME4RibCJR9u69z3RZdiB1cRS3pGT8HRQlvpwy2uWetKyi9jkiIz/tj+ZOqQLf9txAKHa2rcyB7JAQkYQxj2kpbe6ZCOTCe2pO21VaFdBk7lMr7/XLnbYowud7PGdZj42FfNk8ntIDyM+ABIG6yh5UfVNIO8AvVTRYiILjnAeqXLYAHMlZJJ1O4jWTD+jxh3zC+X0eVwe7A/lqpI/XQEbtTW3KTUeeDC0sqfOH7B3gCQmQOOwpdRdY9oHlPtOpX5w1GGpTuHsXC0RtMJfLN36/uRVWSIDAwOVslTN2N7W1PkSsIxWrvDCtt73bT5zaRZBTa7mDBTL6smCuMViBOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OewW07s704/QN7kO32Q1fI4NKw2OutVSDVmxlVHvj6o=;
 b=mv1Orx4q7Ba9IhXtxZjvl+kXJdqmdY2VdGjhuZ9/RY4LyFvOLfxjC2yJzMjk1/hs4rl0Qds1v1nicHo9ID6XKHeSBEu2DY6FqTLM9vgXMm5CMU8b+U8j+9NRn2WLF5Kng95XPo7IdJ3fvXuSPKjFuevXJsQRuAb2xuRlr6dkmxY=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB8310.jpnprd01.prod.outlook.com
 (2603:1096:400:15a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 12:43:22 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7046.032; Sun, 3 Dec 2023
 12:43:22 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Conor Dooley <conor@kernel.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>, Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Steve Twiss <stwiss.opensource@diasemi.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 00/11] Convert DA906{1,2} bindings to json-schema
Thread-Topic: [PATCH v3 00/11] Convert DA906{1,2} bindings to json-schema
Thread-Index: AQHaJdxbj+OyhL1dmkKdDES8WnOFSrCXcAiAgAAQK7A=
Date: Sun, 3 Dec 2023 12:43:22 +0000
Message-ID:
 <TYCPR01MB11269AD9696A6FF35FD5254688687A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231203113159.92316-1-biju.das.jz@bp.renesas.com>
 <20231203-unthread-suffering-411df4cb0f4c@spud>
In-Reply-To: <20231203-unthread-suffering-411df4cb0f4c@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB8310:EE_
x-ms-office365-filtering-correlation-id: 75d9dfb5-3f34-4007-0e53-08dbf3fd6f2b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 abSc7QNSRI8oQ2VcKvuCUuqxGn3zMBNm//olYT2VZZKrXqy973pfLhiBrqSWC+QCXnPfUjnmzF7XavNoJcarP3XVFxxF8jhcRxuMewtwcDugH1Y7GWghUswUQyi066EGx9drFTtbZQsg5P+GW0XBQEcWHLPdRIskvFwhig+TM8xgwWKrgbERJ1mbQuRWSMgj+S6MTyQBBmazwrW044yAAiRazmaC0jOA70g9g+B09WbPyHacxl4WoxD4Jz8WrGQNVH//U7hIS0zYISlx4og4f/WCMYxh1zr+5yFGfCWJJytw4V3PcMc8nbQuDLoP27kCHqZgp9ZxQt5l3QnfPAomqmNQT7B5eALIcYHOibljq7H1wM8lFyL/vV7f0YKAhsOqkzmGRpBSly70KMx2hgQmKLeCOK/Jpq8T8yo87FSxmk2zZJxRKNpdcVp4Ix0ijgE7MLHMECHuUhuTQN6d18fbymvnH3ejWcXNN1RsMKMNWvq+SNYoGv6zLkNQVxzege2yBXB/dlXQ2rvEkfRjndY3K9d+KU/8HOF24ylxH+gjgJsozXmkaBEN9LLXMRMAQtcQSdWZZ3EdJ5FMPage0kPUplY8D+s27AFKVKCCZEomaOE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(54906003)(6916009)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(4326008)(8676002)(8936002)(316002)(478600001)(966005)(71200400001)(7416002)(5660300002)(38070700009)(41300700001)(33656002)(2906002)(86362001)(52536014)(83380400001)(26005)(122000001)(38100700002)(55016003)(6506007)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5zPLx/v8HUTeTlujcrkVHLXUn6um9cF+TuDrE+Cotojmi2vH2rMYALNgOB1s?=
 =?us-ascii?Q?+Ej19Z6zrH18bw+sk3wR3pcmevnyhAJL9PMktBpvrN5ZTi1a0ApfeKfhboFA?=
 =?us-ascii?Q?RGUmtGhfOk2tZ+0j2N3LYmGjxJAcb/E9hWigi+1DH0EnTxHxZgh655SdLWQu?=
 =?us-ascii?Q?dDSVOpXSyzF6F4Iw40MAwyFUIufK4xf5+PmixkQu17ster/y2wBhdN/uNwOp?=
 =?us-ascii?Q?JJgA9F8Oz69LHzIisl74ndNqIf/ml8tZlqGv4kFY0hTg74a5f4Wev1XODEdo?=
 =?us-ascii?Q?RRqx3n71OxPMXjQDE7Bnts5g6YLCYEI8aQnu8or4zQ+Zin1UXCj/uI0HnhHN?=
 =?us-ascii?Q?6DJyWzaboJ89HfqsUrgQTxLtunX/GsyG7Oqecc58egpaRd/vzxJ0tyvJT7RU?=
 =?us-ascii?Q?0k1e+McLdgA9X6G1/gVvyaBdoo454lDYuokvGcmecqOpuKB++kOj8SEp+AI0?=
 =?us-ascii?Q?xDVRuWy/2i40sO6L9NXVGYb3hqaLVxhub4xp2DQAEwILAUly/08fBtVXgFtE?=
 =?us-ascii?Q?zLI1+G8XEWKvjE/kGqcOuRzYzTAx//GoY7OoqowAO1nOX3JkNHHy/T7TFJ9R?=
 =?us-ascii?Q?0JRK2R5VcD6Lv5Wz0RYGGcgPqJ5rb8arIJJu2dvgKhEOS3++/lF+xFLoP31K?=
 =?us-ascii?Q?TG5XU8LgHq/Zy6/cHKoKuypglKTzYTq0Oexy9lSiOjO9bA96nwjcdDM0o85N?=
 =?us-ascii?Q?BuIpMeXMD7DEN/q7XB2hORSTpxY5eA8DUuGXdM1Z4I9sfHK9D+BMYmfmYiui?=
 =?us-ascii?Q?CuCiEAnkwA8kbg+JpmmaRO9TgehPleCV3KGWdXtHz9LmaSjm6C9si9k1iITI?=
 =?us-ascii?Q?/9r17hY6MFDhSmQ9+oGWcGPQ6strFPAWnKgKqNB3KnlfMa2D6+dIGBIQwNc/?=
 =?us-ascii?Q?cTCM6WmjWLRRKaJnEeV4PoRDG6R/zcn6kITku5LJF26LCtL5+jTS1G+I2KYJ?=
 =?us-ascii?Q?OmZBVjr9TjApCdoAaQthec4qiZ/1aLMcnHBbcbXasN0/7fdFD2LW8QoAPA7k?=
 =?us-ascii?Q?6qPlNjqBpMZXTo8WIkpyfHrGEmR3eerxc/iQqGD72cO8JWK8EJKhybwoy/sW?=
 =?us-ascii?Q?DbXJqdtTJ7JihGyOX4xEiFmF0Z4+WpGKHBx0iZDfujim5Cn1JQ7cfJzx4dk/?=
 =?us-ascii?Q?QS4TMfo6So2Y47Ftf5XJNqUJTrx0swgxabDsglvtGfeHyd/A5HpkaSa89KzB?=
 =?us-ascii?Q?NuaFZleO6ou+XTnA4UQ8T76qitZxZBf9LJtFCBTvFk8wol05k5QKPxMgi7J7?=
 =?us-ascii?Q?KRjCvYKHWneM58XCkthS+QS+XGUbQTMMz8FhJVPirKzO3J4reM7hjHKdQc+K?=
 =?us-ascii?Q?D5JmMUn8P6FLDJECqxQ1u31/9FOXhXVFRIILEQv6JXkZIOuAY3WSJ7+3FImb?=
 =?us-ascii?Q?GG2VH9cBAdYt0DGWDjV2iR4g4OySLt/5DAee0wodDNWnZTlMSl661H8UHd43?=
 =?us-ascii?Q?MmtWJyKYYPRlcxlP3+W/XRbHEcm0ouqZV24GV/SiT86p43dF2PlIACEw3c8/?=
 =?us-ascii?Q?objrkO0dbvum4zZ/BAHGhiG4ZOnnP5Z5V4CLX0JEvkDwjAUa0U6S/MWd8zsc?=
 =?us-ascii?Q?mUi7bnqMm8tVFEnrMR2LvDdr0mi2nH0J41dLxwZUZVIUUUoubUgK8ZcgZBN4?=
 =?us-ascii?Q?SQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d9dfb5-3f34-4007-0e53-08dbf3fd6f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2023 12:43:22.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNflrnqpk5gVwR7EwqCCZ0zPaiK4XWGlpbVmqu7fF82/B/G9j9a2gxHHDQpVe6F3KjOk4b6rifzWAhJS4elgvFMLlJL+MbePOcb704g80fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8310

Hi Conor,

Thanks for the feedback.

> Subject: Re: [PATCH v3 00/11] Convert DA906{1,2} bindings to json-schema
>=20
> On Sun, Dec 03, 2023 at 11:31:48AM +0000, Biju Das wrote:
> > Convert the below bindings to json-schema
> > 1) DA906{1,2} mfd bindings
> > 2) DA906{1,2,3} onkey bindings
> > 3) DA906{1,2,3} thermal bindings
> >
> > Also add fallback for DA9061 watchdog device and document
> > DA9063 watchdog device.
>=20
> Horrible timing, you sent this after I started looking at the previous
> revision of the patchset :( I left some comments and tags on the previous
> version which I would imagine that some of them also apply here.


I missed some checks which is pointed out by bot. So I thought of sending v=
3
Before anyone started reviewing it.

Sure, I will take care you review comments in v2 when sending new version.

Cheers,
Biju



>=20
> >
> > v2->v3:
> >  * Updated Maintainer entries for watchdog,onkey and thermal bindings
> >  * Fixed bot errors related to MAINTAINERS entry, invalid doc
> >    references and thermal examples by merging patch#4.
> >
> > v1->v2:
> >  Ref:
> > https://lore.kernel.org/all/20231201110840.37408-5-biju.das.jz@bp.rene
> > sas.com/
> >  * DA9062 and DA9061 merged with DA9063
> >  * Sorted the child devices
> >  * mfd,onkey and thermal are pointing to child bindings
> >
> >
> >
> > Biju Das (11):
> >   MAINTAINERS: Update da9062-watchdog bindings
> >   dt-bindings: watchdog: dlg,da9062-watchdog: Add fallback for DA9061
> >     watchdog
> >   dt-bindings: watchdog: dlg,da9062-watchdog: Document DA9063 watchdog
> >   dt-bindings: input: Convert da906{1,2,3} onkey to json-schema
> >   dt-bindings: mfd: dlg,da9063: Update watchdog property
> >   dt-bindings: mfd: dlg,da9063: Update onkey property
> >   dt-bindings: mfd: dlg,da9063: Sort child devices
> >   dt-bindings: mfd: da9062: Update watchdog description
> >   dt-bindings: mfd: da9062: Update onkey description
> >   dt-bindings: mfd: da9062: Update thermal description
> >   dt-bindings: mfd: dlg,da9063: Convert da9062 to json-schema
> >
> >  .../bindings/input/da9062-onkey.txt           |  47 ----
> >  .../bindings/input/dlg,da9062-onkey.yaml      |  60 +++++
> >  .../devicetree/bindings/mfd/da9062.txt        | 124 ----------
> >  .../devicetree/bindings/mfd/dlg,da9063.yaml   | 221 +++++++++++++++---
> >  .../bindings/thermal/da9062-thermal.txt       |  36 ---
> >  .../bindings/thermal/dlg,da9062-thermal.yaml  |  78 +++++++
> >  .../watchdog/dlg,da9062-watchdog.yaml         |  12 +-
> >  MAINTAINERS                                   |   6 +-
> >  8 files changed, 336 insertions(+), 248 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/input/da9062-onkey.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/da9062.txt
> >  delete mode 100644
> > Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> >
> > --
> > 2.39.2
> >

