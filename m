Return-Path: <linux-pm+bounces-31766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA87B18444
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE3A1C82276
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC826CE3A;
	Fri,  1 Aug 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DK+s1Rdg"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BC122D9ED
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060063; cv=fail; b=hmSgBYshLAXxBqNLIwVUDHxMMty/cX2jqSkVU0QJSIK/G3xpM2tkaJB8ksLBzLdj6kKLbK8zuM1XSFyz1qbk8gFe6CWPJEb1X3FLFmEF2LLRoHY1JTh69fesKKiZaWvTA2cNJpTpu2+OGE40Y7nOoH8wXgm7jXqOcy3Q+ZNBClo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060063; c=relaxed/simple;
	bh=GnbGwv+MbkP1uIx7IhRsa1wK7KkFvY9+ILdq3g4prME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WgjK/FlPNSYYIvOWiawJtiKN7IE3cN0AB3/FhjcDGuH20yiMn2oWCv7/ZsG8G96bhKAstvn43zLu1Xz/qUcNSnb1cjiDkzhDevAhbpGy3An0XCwTynfvS5DUzPxtviYJqQu9jSz67bR/WKUnIovuiBnvmhIsVv7VugIlivEObnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DK+s1Rdg; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIwEQtY8uxe2RP4eG4PAAo5o6Vj0mBx2M9UV8HfOoE4V4SPy8rGhFf7dhNQkF9V59rq1QwwxLPnsuUN2NESiCByRr8bYUlD6qtC5kGRvCZeeJqoyDxzRFEDQf7VRHGulVG4fmV28s+V1s/Ea90Dk+LCWaZUzsV6na8oplEZQY02dxVDilnH/8midedrDQa1Eckfycj5O8XKBx2UEF2m4gqrdjVi4Pvy2yJj37p5lgQ/uayVefvMTyRp76TpW7VxAuD/hb6dRJbkxO3ilzzS4TXgqkjR6PXhhIJ/eRQqlk9k5ILFEDF7WpXjMo4RaxiHGzNfVvYetItYgX3w0LHWeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaLaunDXpHF6tgpocpr9gXG8RHg/lAlBs3jfrpgXhTo=;
 b=wc9rvhFjvXy6/KLY2xoEaCLGpiIQ5XM3edpj0dh50GIl0rtqP/2QiTey2O/zh8NtDPh3DaP59obhCkHKFdtpC0NAnBv98PuhHKpchrJtfueSmpq6cgF4CwqrN8e/oaWbNtER3Fb0uXEizATSmqpLBgAW/BpJ+nEhvgfkkfPk+C24IcGeER6l7PMfo4FT2w10pE+oKBB5naJffqDlL1nBGgU3ay2AeGzcw3l6kkBPhPPxlglBLuZe0HOmDsD7rc3T/ifPsXnLUiBk6a5H1mghDqgkiZc5YDgr6so5p6VYALHPzVNqW9YoEFWEB7HriQJ7XWXaBUYebWBt9rf4MpO7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaLaunDXpHF6tgpocpr9gXG8RHg/lAlBs3jfrpgXhTo=;
 b=DK+s1RdgaIkmuQnYXfudjqpW7/FwHjaAht/DB2+uER4Z8MCbSDzBvi8tygtdyNZwjKo5KRO/zIfnkVCFHOZOGQVYl8SRxc/Qvc0vR5REe2d0xVHBW/pSF5fe+Ko+5U6JnJ/xAscIeNlTb+Di3eSOr4oBLxHc00N1yepq+o6PwruMQkXsUU0lz0Xb+Nu4zWT2s/Gpd1LH9FQyqkSq4vmgkCXZPC4q6zkK7F2mxDr3DNWaMemcJWr5j1WsSDPtVNKH3UWZz1zdgQlHtdUTfdGftCmKSe9v+tfdWBrehG0EZADolr8l2daU8JykoKt1FbCCnvuQz28X4ZpmeC4H+sgbjw==
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DBBPR04MB7978.eurprd04.prod.outlook.com (2603:10a6:10:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:54:18 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:54:18 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "krzk@kernel.org" <krzk@kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH v2 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Topic: [PATCH v2 2/4] thermal: qoriq: add i.MX93 TMU support
Thread-Index: AQHcAruGxq2iEhcWo02hHK5ogHM2ObRN1jcAgAALk8A=
Date: Fri, 1 Aug 2025 14:54:18 +0000
Message-ID:
 <AS8PR04MB864298D157317757B19FCA5E8726A@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20250801081119.1999298-1-ping.bai@nxp.com>
 <20250801081119.1999298-2-ping.bai@nxp.com>
 <aIzKgvERyoaCpnyt@lizhi-Precision-Tower-5810>
In-Reply-To: <aIzKgvERyoaCpnyt@lizhi-Precision-Tower-5810>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DBBPR04MB7978:EE_
x-ms-office365-filtering-correlation-id: 6b1eb134-04fe-46df-0f52-08ddd10b4a91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9pRAATPjM1DQR8MdOxkpjWEd6KZMFF8OZJTWUb1FcWbXK08ge7EjYOrbFjVo?=
 =?us-ascii?Q?eM5K6cZVTS855DZQyeaOglA9d4sOqQu0DsaIojipFy3opUBzSiMAze6xBba2?=
 =?us-ascii?Q?G/cjb94SIKl4Fb5o0DvU50h18w0GZFSHQQFbpOjrJB+Y2Ov7UybVOcNO0Qsu?=
 =?us-ascii?Q?1xsqhLnk/eLPUQUa0iY4CdozGUDkUph1prmCEXjAwnQXlGnDoDixGnyAYZYI?=
 =?us-ascii?Q?0EW9oPDJ2uUTb1BUMuV0skxxKX61kVE0xxKcJAlyHIyfaCegJoK0ORjyxhNj?=
 =?us-ascii?Q?qno+uVl9envg/+q7gvnvY1I0PIEQbnQjbfVx1hhYlvburcjFwdrtIbAnhpC8?=
 =?us-ascii?Q?7CvzvnjPL8VzEX/S8HXfXJEkCLL4MpIvcBsnLN2VF9NcTmB0sPqtKhWnDshy?=
 =?us-ascii?Q?Tqf78yZuMyL7v6ftHtIZfzeaC97at4jdR0wCi33JxgkOgFi23HYFx8CUN4IF?=
 =?us-ascii?Q?FKmKB/6WDBWZP4XtyNVqQkRDBiJ8b+k3PmACMEvVMGq2YxU72DLDxvOwfmTU?=
 =?us-ascii?Q?MnaWqOb8tcE2FIp9ziRWsDw6D4yEBMUtduQsezCDRzu0hrRgWdPMzPyxUXic?=
 =?us-ascii?Q?YbIq6cV8lNpeDZrceRECXQ7a+VmSHaLF691ah2MBP/oYXjh/FeooCK+m+tJ5?=
 =?us-ascii?Q?a0lld+/thos1GGNBesuLJyHd1pw5DTltBsNmpSSuShbMU3aBN2ogw8GNks/F?=
 =?us-ascii?Q?Wra/u2P7mMlEFssuv31RQ/Xg9Cxmoze6QAU31Da8/l5CYsiMg6l67zc2mAZH?=
 =?us-ascii?Q?Drj2tnFcAyGIBUoqXLCL4V5Ay5VAJ/g8W6Z07QxGA4TgXVJ201B2f7xLEOXw?=
 =?us-ascii?Q?3VAmWpB7yt+Ee8qLYeVUJLrR19tiE/0BwIB+e1j4p7/1+z8dngdFWqvsgU1I?=
 =?us-ascii?Q?pX6gKPTFj2VwXuF+SSx8TaFvFCH/knri4IfEMGEn95ZE5qVLcCx2nHmK4adz?=
 =?us-ascii?Q?uDZLMDc5r3yPLoCOnbdSyPBzHhlywgnVpNBUfM7GX0WbP9kdfNZixlCpg5GP?=
 =?us-ascii?Q?HBUTyPBpKx/835kFREckbXcWvgtmDCuQmBpkSfONd2bp4iNM/mbHK/DhCNf6?=
 =?us-ascii?Q?38twAb8/T+7wUjYpqw629i6CZ/uOJePmQQNQy0F9GAFhC4u8nwg9e9Fo+4Nc?=
 =?us-ascii?Q?4OHssTvQl5ipWYPwKxOsHdBYg416o/xWFBfHQOJNxC1aHB0dmtSmro0iQCAy?=
 =?us-ascii?Q?wGtfmDDrajSa1LWu6jc2DoAFHpJSbRa6P8cJoUMVUmyV3JDT5tg8M8A4xrAZ?=
 =?us-ascii?Q?NLaqPD0VZkC4OgcVfNtx0vUAhGAI9J/oRzvD/7g0HGew+cBpd2MZX6OC6v4w?=
 =?us-ascii?Q?dYS+phXBiAqdxy86aKMibtUsyNzL8Bx5rvxyPN0/3rtxyBpULR4laXStfT/P?=
 =?us-ascii?Q?XWK/BpHObo2bbyTujPZMprcD52IETce8hgBW0eAQjLiRFEGAOGFCZGtqQ/cA?=
 =?us-ascii?Q?7+mM+IrQu0JCX5Xt0CCFJBwnO4T8pZNA1V0N1RMqAy2KZ9HZl+bQPQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kRzzV9NOkitO7+P6Q96klOm4MyT7HUPQkWBtzSED44ywaJEi097I5yGubnpn?=
 =?us-ascii?Q?FeD5TDGlsiO9uwoZkjZ5EGVtwWvduDUfudbZPKnm4iTLSXaq+UdrnfSyJjPK?=
 =?us-ascii?Q?CDQrt/qBd1Ax2q/8exzZR048fKOqIwJBfRzCNx3QE4K+s/a8RROVP2HjdLBK?=
 =?us-ascii?Q?qxJGpkRfNqP4OsS8gfFp9GdtEu6imFQ9HP7P2gV7yi5AAIIXogKMVkAE2XNl?=
 =?us-ascii?Q?1qbxEGQ7qzy/xFCOTxBnpCpAvvVrfvUq0Aaf9pVokXghGHO5aD6l7WKDzk8Z?=
 =?us-ascii?Q?Njb2HSNYDUXGGxRMoJT1k0LVPtqAygucY+JWM3a+zCJ1cb4+HJ5JbPWWZx5T?=
 =?us-ascii?Q?hpe4LbyLAULdGBEqR//ITDawd9LEmCknKAJoiVhH5GranX8dmQucOm40PvgA?=
 =?us-ascii?Q?Si91iqCUNo4B5zvHIcmttys/Arc39XGX4cLWujawYAQkXkOKrZRsp4iEPxLv?=
 =?us-ascii?Q?YzUposppQNlhv3BKdb1oWufbY1MmoIWqaRjik6pdlXLJv6tVAWHToNp8oreI?=
 =?us-ascii?Q?lgZOmDn77nWnPV1ixZXBH5skCkDWEQ+TZHrQQv6rlrX7VEKCV8GCC+Esvo8T?=
 =?us-ascii?Q?5im8IngSNnjmBf679WwQVUYJcESE0fQydjdob5Z/Rjmup+A2eLJBYIwZWHVv?=
 =?us-ascii?Q?TgdVVd7VAJboqQCmmX26zCSUDc7JJqbUNJt6xizWIHU7P7HYLEC5pgIG7fNK?=
 =?us-ascii?Q?Tp4T5fFwFNF/ydpwF13JDc9eFdWZbRkEoLTwmXbXUJCgyuFK4rF+FWySXr9+?=
 =?us-ascii?Q?av7GEugtqjgiE/rw3MpLu7WKI78hCHyGPPxRmwAc8exbA2EtYagOjT+YdueJ?=
 =?us-ascii?Q?3yVf6/5Lt0IeaE4VKQNTGGiXeVWb9MMewnj6p+uzt2K4sGtpVRW2r/jTsXXu?=
 =?us-ascii?Q?COqK6p5EaQ892egopnRLEM/h50LKJBssWVhP3CxJN2ubczQshUZQK04ovtaw?=
 =?us-ascii?Q?sc9UO7jcfmOVCqcD1+wV1DhY2u31ycwJ1xPiG4FuA/61TO2Awx2UjBWvGfgt?=
 =?us-ascii?Q?oum1Yot/YQ5eK6Xvv3TuhYUvcB52J+SLNXMQOvrtMKQ6DOu6vCHVhexoHHhy?=
 =?us-ascii?Q?7iVEUr3Wxf9o3iAmxKbWhOUATcn0zOpFYaSU6qlx3P7n0F0xa3+zgvDr0btn?=
 =?us-ascii?Q?GAsIX1LsczMG1zuohu+vx+/BBWaeHiQqj6eW5PoISzfmuKCIu7nE49Jnzow9?=
 =?us-ascii?Q?mblPH+ykDt+nZbGrV6RQAtJOlPwZLSRNT/bsTrhC/v9Uaqpo940PyBGsyO+/?=
 =?us-ascii?Q?j0utfcecEMZPEniz3eSbAV1zP4ide9SUFGmYWXEngPqASdR455NR6P5VbdvC?=
 =?us-ascii?Q?r/0OAPji1dWvnBIrTZwRGllsBYmZOuU5vSNI/tmjEGxdXrVAb0p30wjL3Y7N?=
 =?us-ascii?Q?UUKLVPLv3RwJp5KLS32hTz8Cgc9qxqVBEPgAPCW4LWzHejEpXuHxQD3itaEo?=
 =?us-ascii?Q?56DohofdyF9K2Q8q8M7ujiSWMBpzuof9dMKyN5g4DIrS6MyE/vS0t8bMuokO?=
 =?us-ascii?Q?iYzWHz4shRiye02lnpOEAWmREfx1bzsqa/GLFCNL6nl31IRrqVW69a/D848e?=
 =?us-ascii?Q?oHS+alagHM6C/7xcuoo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1eb134-04fe-46df-0f52-08ddd10b4a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 14:54:18.2105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdBttOqC0d5pud1dAsxlJl/Usm/Q0QITRJm4VbJiOeqtwHiHe023TkUqTXdOqZVZgFGs4KsKEZefKRyZxiwdFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7978

> Subject: Re: [PATCH v2 2/4] thermal: qoriq: add i.MX93 TMU support
>=20
> On Fri, Aug 01, 2025 at 04:11:17PM +0800, Jacky Bai wrote:
> > The TMU used on i.MX93 need some speccial handling and workaround to
> > be done even the revision info read from the ID register is the same
> > as Qoriq platform. Add i.MX93 compatible string and corresponding code =
for
> it.
> >
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > ---
> >  - v2 changes:
> >   - use the compatible match data to identify the i.MX93 TMU variant
> > ---
> >  drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c
> > b/drivers/thermal/qoriq_thermal.c index 01b58be0dcc6..fd4d162fc188
> > 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  //
> >  // Copyright 2016 Freescale Semiconductor, Inc.
> > +// Copyright 2022-2025 NXP
>=20
> should only claim 2025.
>=20

Ok.

> >
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > @@ -24,9 +25,11 @@
> >  #define TMTMIR_DEFAULT	0x0000000f
> >  #define TIER_DISABLE	0x0
> >  #define TEUMR0_V2		0x51009c00
> > +#define TEUMR0_V21		0x55010c00
> >  #define TMSARA_V2		0xe
> >  #define TMU_VER1		0x1
> >  #define TMU_VER2		0x2
> > +#define TMU_VER93		0x3
> >
> >  #define REGS_TMR	0x000	/* Mode Register */
> >  #define TMR_DISABLE	0x0
> > @@ -232,6 +235,9 @@ static void qoriq_tmu_init_device(struct
> > qoriq_tmu_data *data)
> >
> >  	if (data->ver =3D=3D TMU_VER1) {
> >  		regmap_write(data->regmap, REGS_TMTMIR, TMTMIR_DEFAULT);
> > +	} else if (data->ver =3D=3D TMU_VER93) {
> > +		regmap_write(data->regmap, REGS_V2_TMTMIR,
> TMTMIR_DEFAULT);
> > +		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V21);
> >  	} else {
> >  		regmap_write(data->regmap, REGS_V2_TMTMIR,
> TMTMIR_DEFAULT);
> >  		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
> @@ -312,12
> > +318,22 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > -	/* version register offset at: 0xbf8 on both v1 and v2 */
> > -	ret =3D regmap_read(data->regmap, REGS_IPBRR(0), &ver);
> > -	if (ret)
> > -		return dev_err_probe(dev, ret,  "Failed to read IP block
> version\n");
> > +	/*
> > +	 * for i.MX93, the TMU HW version read from the ID register does
> > +	 * reflect the real HW implementation version, assigned the TMU
> > +	 * version statically.
> > +	 */
> > +	ver =3D (uintptr_t)of_device_get_match_data(&pdev->dev);
> > +	if (ver =3D=3D TMU_VER93) {
> > +		data->ver =3D ver;
> > +	} else {
> > +		/* version register offset at: 0xbf8 on both v1 and v2 */
> > +		ret =3D regmap_read(data->regmap, REGS_IPBRR(0), &ver);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,  "Failed to read IP block
> > +version\n");
> >
> > -	data->ver =3D (ver >> 8) & 0xff;
> > +		data->ver =3D (ver >> 8) & 0xff;
> > +	}
> >
> >  	qoriq_tmu_init_device(data);	/* TMU initialization */
> >
> > @@ -379,6 +395,7 @@ static
> DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
> >  static const struct of_device_id qoriq_tmu_match[] =3D {
> >  	{ .compatible =3D "fsl,qoriq-tmu", },
> >  	{ .compatible =3D "fsl,imx8mq-tmu", },
> > +	{ .compatible =3D "fsl,imx93-tmu", .data =3D (void *) TMU_VER93 },
>=20
> Now, don't prefer direct pass a ID here.
>=20
> struct tmu_drv_data
> {
> 	u32  temu0;  /* or other touch actual bits define, or workaround
> 			name, ticket number ... */
> }
>=20
> const struct tmu_drv_data imx93_data =3D {
> 	.temu0 =3D TEUMR0_V21;
> }
>=20

Sure, will introduce a new struct to hold the match data info.

BR

> Frank
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, qoriq_tmu_match);
> > --
> > 2.34.1
> >

