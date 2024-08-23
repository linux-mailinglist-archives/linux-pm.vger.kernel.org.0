Return-Path: <linux-pm+bounces-12797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C895C67E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3711C215DD
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3649F13B59B;
	Fri, 23 Aug 2024 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="E5ETnKCK"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010030.outbound.protection.outlook.com [52.101.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12978131BDF;
	Fri, 23 Aug 2024 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397973; cv=fail; b=B2qqbHc/uSAgPYPtT+9Hx8Uh464opNZ7wxXuSbx7QWeL9P5tFEsPWKTcYS7FaaFYdh6zA22W3T1/wboVyogTtmffse6Z1hwrcrGv+zTgwoITJS5UnhZqTtsbhU/XdCiR5iV7TqZ8wCUj5hIpAXfybZPO7q9f3+9BN5srkG72vDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397973; c=relaxed/simple;
	bh=hJhW/yMAK8b8Dr0GVHuFWmi9RXeQRyBiLVwiJs+aSHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCcFTmo17DRn6eLSZSguuUxDqXCRFNvF9Ivi3jTdK5F3XqLrFiJKnt3BH6LoxrgBmK0p7ivlacRRMJSni0mSX0r9hGezvXd0HwXbgR/2h6FUbFbLpAtmoqbuOmOhtf3Wmv/9EHlaOM4AfJob/RmZlOt4NF1YQ1nv7DxxWHpMDRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=E5ETnKCK; arc=fail smtp.client-ip=52.101.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxAIYV6zIClfVVL3RNPSbwXSgcvgNI74eV63Ev9nK1ywwm0q5EU3TMSrxMHFJCWtcH8Xg/ljWiBOFI/QS2qdqEqgMYJBwjd8kP3dDvUXVhxIY0t+ovYYow57hkAIllS38qYOOroKHsZ7z7d7Fu4bZxm+xYCGuG94r0VmflKynLUiVB5im5OPksPVwXDPJUu7NsS0wBAQmk5yni9D19Sq6QpalgMZEfnSb/pQIbMELh4aSr+yTeNv6ErdH6l6YQJIVhuHMWwHeTOcFF3qE7TQ+qsvwk1l9XJOIefk3/XtmFaiUHvJOvjh/iSOM5t0zznLndsS8Jm2BOkPNR3uE/X8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1bPuOdmf9jDgiaW1SSzsb7d1IqfHSup6uWCF4yiMGU=;
 b=R69XlTBD+0zXXoyMF4InO6IgLHqcd9lcKE3WES2zVQqr/R+fuBenCm5fOO8GopDjxs0DDVdZ4YZMxezfOtgnZSySKtlRee+EhE8stnEzAQ6Svjo7guo7nY2PkGc1M3RrQgt5BP55faiqmOKxGVzjYSL6De+ihZIS1xiQWwL9MHQtkyAlBAglb3dWPrHAn5li7uY1ynPlq01J/bmJxPjrCuFSUF+4Lt9UaNSbs3eatuT5CAJ9bg02y1xbCfyko8aWTylDawOZE4iR75NKuZ03VMcCqXcD3W/gIghvMqvp/TSwd6ev583TuVkwucrXQq+cfq013QUdZs0YnsmCBAghMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1bPuOdmf9jDgiaW1SSzsb7d1IqfHSup6uWCF4yiMGU=;
 b=E5ETnKCKGszqXR7hh5BDhxc28t1DiugcCVtbB3y6WlRWptol19eIVCdf88ZGsecaifOqLVlOg3HVfVahWr8eQRPyoju+TItrABt5HO0kekIDN+A2LjYV25Vi4ZmYQXUpz5/fUofLTEafNVFc42DUkVl8uupqa7wuNPV3/z4eBdg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB11932.jpnprd01.prod.outlook.com (2603:1096:400:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 07:26:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 07:25:59 +0000
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
Subject: RE: [PATCH 07/16] reset: rzg2l-usbphy-ctrl: Get reset control array
Thread-Topic: [PATCH 07/16] reset: rzg2l-usbphy-ctrl: Get reset control array
Thread-Index: AQHa9KfzjUIr6NsDo02njnbQaEM3ZLI0cJ3Q
Date: Fri, 23 Aug 2024 07:25:59 +0000
Message-ID:
 <TY3PR01MB11346900BCCEB55580C2F912086882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-8-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB11932:EE_
x-ms-office365-filtering-correlation-id: 3227bd2a-0d1f-42e6-8037-08dcc344d60e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U1OmEXujYRrCCp407tCpe6aRnV3EXMezddhR1OeyXCj4vhf9dPyTAKLZZ4eg?=
 =?us-ascii?Q?boN/CA4QS93gLTjnAPC6rjXfr61Zh3KJsT0KlUqVcePvDjfxah6U021iE/9U?=
 =?us-ascii?Q?CMjzbkXcmuZqQGbKsy+XMeZkgiM6Ru7tLtBuQbd445SD83YAoh9J1Iaqr7BE?=
 =?us-ascii?Q?YD4jv8JWEBwBGkKEoj5T7DyygHf94WNF/fULrJU+f9TJgJbLfvfr2ozxU903?=
 =?us-ascii?Q?3wE/vP3WNZ0ltDMIruUBCpHETFDToTvZOdVHNyzWOV+bddpzdUbhrc/Ss3GH?=
 =?us-ascii?Q?uBV/Cozj4IcFf+Q9M8VwRobprr+Ve2La1a9uloiNoy6nwPf6LOWLcVpLD+oF?=
 =?us-ascii?Q?5FythC5s6x2bGk2nY1RtozMsBeJPhUy4RL6rJ0aVkKu12UeKGDBinwYHIUVM?=
 =?us-ascii?Q?0Du+N8ZI8Z9dpl4nwc2LE52jdVK2GQV3C7sYR22O8Ix++t/zrh4eO6Yvs4lH?=
 =?us-ascii?Q?nSTbu0SzqA0bmpq/e/NOUb1hRzPWYeitqniHhl8M5Pe1uZ6JJE+kgVXIIrNK?=
 =?us-ascii?Q?dOFQescAQmvYcQG+DnetUEPME01z3DE3ccO9QIixjDCHxpbl6JBLy7Azlge1?=
 =?us-ascii?Q?V9y2pal3PGjCXm9IlExctN0Y8ImyIjDwjBauXXb/XZbemZQInBPx2NovpkkP?=
 =?us-ascii?Q?WUACK4r32cyg6dlkRMilEh0qnhAW0mu+JJWpw5OIFK9qTcMb6jCZXfDLT087?=
 =?us-ascii?Q?Im3euJ/4ETUAtIm+zihr7ujvaZ1zCpJ20YRSril2cjeYVs1dJL09p9XGMYb9?=
 =?us-ascii?Q?tXkIgCVLmSirK24cSFVrzlW8bo3WrGlkT3gvu9c8CQmJJ8L6QS5CKfiX3Nap?=
 =?us-ascii?Q?Brg6YHWFHzNUvYxElCzLyyCV0S4I76W+a9dm72O7Xq+eMhGJzGJSLzFAHDyD?=
 =?us-ascii?Q?70fZ8WzeFmvZo1dUcARA7mYNiXN+HChyY/V9UxoYPdD+zeAvf3FHSrw0Wozj?=
 =?us-ascii?Q?EG4EXA+mPbusQ0ifhZonV5lWIv40CD71OtBd7HjQuyZJDQbg0Y49cjl7Oc3P?=
 =?us-ascii?Q?Wp3fBJSZnFieq8vx87O4EX35TUulzhOLvIfcM+yETX+1L/058fhzdTjyM3nf?=
 =?us-ascii?Q?C5XBQX9u8bLnhd24ZWIV5wgzV047XAUFE4WyLUTgh9bXNVpsACylLZnyvhgL?=
 =?us-ascii?Q?pfl4Q5udX1AFMDp+OCJsoZDlms2jDZ+sDUGHW+X32MOS2gFHjHdo5GlVKdoD?=
 =?us-ascii?Q?+EWk7fYTwzrs+ngxTiCyXAuV/5BfNhvPhOKnT75HMVtAW9AW2nZ8B6eAXyp/?=
 =?us-ascii?Q?k6r/ZloWq75By4PKXj/Mv0XhlaeRmKoV14q98gl0ware0zYGFiDKLvYfIxZv?=
 =?us-ascii?Q?rbR+331zguXUpFknku+fv4U8HC8j2wvp3o2t7VJ9gsAv2NxCqOXHmXrFUEey?=
 =?us-ascii?Q?CDnKmRu/BhWxT6/HSng0491OO0//JSSulud9yIvdTAQwJKh7QHqbh+xS5+H5?=
 =?us-ascii?Q?8PTrDtJg1xQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qeWa8iisbc/qOw0e4XvCRWgJggh4l4xuyz47gMDWRgKQPVLqS5LFwAM6X6GG?=
 =?us-ascii?Q?0vpIw/4Aku5LsD1AuxA1JmJzZpT2JcsMbb+NfOFSZTXmny03xUcsl1IiBK71?=
 =?us-ascii?Q?w9BDjF3tcUhPeceuZ4ZQi5TPsyTrIawT9EBrI1Cqn4ZUh1xeHSlAKwjBoSpI?=
 =?us-ascii?Q?eLFdHGTaFgKByNgk3rZSBsXBZ24dKKPq0cMVENEnm6g/zEqucN7B8h3IaNex?=
 =?us-ascii?Q?Jra/8i+bqCowttpuOUdXT4JQ3bXI1ReRKwxVXlXwvsXmeO+ONZvXzYmNtPCG?=
 =?us-ascii?Q?/j4mpL9T2OqiLfulAtb5x1HzlgEf7lby2LUvfXxPe3zO8cnLwMs6eTXOgwKq?=
 =?us-ascii?Q?cRbW9x8x4UAsnirRBI3k0Phc8ZwIaE2W2dKro69xSd9esLneVjrjc5B+I9N1?=
 =?us-ascii?Q?WE20bmP1lqPFEPpkFHcF1sBgtgYARCLkKBW2dgMaiufoNE1ZWeASrMufzKHv?=
 =?us-ascii?Q?NRgfA3DtL7hwuTOpeTcsoO3tHafUfHw4gjKpbhduHRTWSpieCfQwgFvsjbPp?=
 =?us-ascii?Q?PXyC7j0E44xrTKbMPCzGHZTCsY/lNqYQDlo6T5xMJvxzH8dfsKYtzAKFNona?=
 =?us-ascii?Q?DpoZOVSyEQd2GmORwi0BVJVbMp9ArOVg19AYMaDkVe8ocZWOKTzyCwRBS4L2?=
 =?us-ascii?Q?BuFd10G2URBeaZGWx88MstTDnCEMmlD0zLnH3KwrAMcAhx40D9cDiAE8D9Ay?=
 =?us-ascii?Q?aCjQa5rdgmbdWTa9aB4j3p6vQh3MqHbSdrRptwDmeCMULmDHByJOsdELw108?=
 =?us-ascii?Q?Z4cqHENjC6QLHhPBT80OaD52S7xKKlU9wUehNdrIv7lN51iorq1SBu8Ybenl?=
 =?us-ascii?Q?7jfzd+zySCzkthO+2Gi2fuyeAavtlR0UxhaWGFrU79VnuhingdsLpFpSejCf?=
 =?us-ascii?Q?qDLMc1oHnDrQGcLxxP+Y7Q//N6irLHll8TQQf58KWWcUGdBKfKKsvFEIXCdo?=
 =?us-ascii?Q?TDS1rxVaQZESK+fdGEgBt0xubJX5RN+jG3drniiqP6LOWX5Gtfsivns4eZ94?=
 =?us-ascii?Q?rtJEJh6GIt/gu/D27lpLHO4NSMcpjJZ18dj5QTr0zsaMSq72CUN67rjQ5bAD?=
 =?us-ascii?Q?VVuVR8Ef9jWAgWJxWFIQM7FLrRaWunlJ141W0SOALrIGlPi8LZy0EX+S4Wam?=
 =?us-ascii?Q?rikPn+DY4TYYdw9WoN4oQ1L3dz9x0IZIUEoQiFji7VWE7Ydz96atq6Ax/oyp?=
 =?us-ascii?Q?ctkMGD5rF14snQU87219sLYWaKh2iuIaepxQZbr3ABu4mnUO+tJzpSWZsilO?=
 =?us-ascii?Q?9/VzOTiqYEzQh6bMj2IZqHOSD9GhNXi5BSoU/pNLvRSWTKJB6AQceMHGC2UG?=
 =?us-ascii?Q?o+nvU/oZf0xUuFPb4iOV/6U5ZpEtPPscdP8Qqh3BjeH5OFI8PZ8eLLLo3Q7l?=
 =?us-ascii?Q?qQAhRFnxSE2XMNlfzkzDtTmHpPmj44x39bu+i2mZ/ahQXZy3fnx0HvS0hnA1?=
 =?us-ascii?Q?bI+g35Ws4w0CERHGiFq3DrQKCwVyDGKo5Xkg+NlSpFdrtERKy+oZb5wwS6er?=
 =?us-ascii?Q?LpDfuTnPgYmwCfuVbNzJFN0O1ZSpsZxjT/SsnRdq9WUd0/pZmf3EwE8Q9+IW?=
 =?us-ascii?Q?8M+OY5m9vdKvdZgKCE8sh/Hz9+ZzHGSHWJ9nwt6mwpMif52YwOQZwW7BL9Cr?=
 =?us-ascii?Q?Mg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3227bd2a-0d1f-42e6-8037-08dcc344d60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 07:25:59.5677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKUsscRZISutP/IazBzQyZuMmTF3ufTmJL2PADCcO2QV3EnvM2BqTTcsqFbloI8WUotbstHP3Rfv8+AkIjVGm4n2zCWZwgL64OdXQboXZyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11932

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Thursday, August 22, 2024 4:28 PM
> Subject: [PATCH 07/16] reset: rzg2l-usbphy-ctrl: Get reset control array
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Before accessing the USB area of the RZ/G3S SoC the PWRRDY bit of the SYS=
_USB_PWRRDY register need to
> be cleared. When USB area is not used the PWRRDY bit of the SYS_USB_PWRRD=
Y register need to be set.
> This register is in the SYSC controller address space and the assert/de-a=
ssert of the signal handled
> by SYSC_USB_PWRRDY was implemented as a reset signal.
>=20
> The USB modules available on the RZ/G3S SoC that need this bit set are:
> - USB ch0 (supporting host and peripheral mode)
> - USB ch2 (supporting host mode)
> - USBPHY control
>=20
> As the USBPHY control is the root device for all the other USB channels (=
USB ch0, USB ch1) add support
> to set the PWRRDY for the USB area when initializing the USBPHY control. =
As this is done though reset
> signals get the reset array in the USBPHY control driver.
>=20

Comment applicable, if the USB PWRRDY signal is modelled as reset signal.

There is no user for this patch. The first user is RZ/G3S and is there is n=
o support yet.
I think you should merge this patch with next one so that there is a user(R=
Z/G3S)
for this patch.

Cheers,
Biju

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
> index 1cd157f4f03b..8b64c12f3bec 100644
> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -132,7 +132,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_de=
vice *pdev)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>=20
> -	priv->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	priv->rstc =3D devm_reset_control_array_get_exclusive(&pdev->dev);
>  	if (IS_ERR(priv->rstc))
>  		return dev_err_probe(dev, PTR_ERR(priv->rstc),
>  				     "failed to get reset\n");
> --
> 2.39.2


