Return-Path: <linux-pm+bounces-40533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB67D0894F
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 11:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5442830245CB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE61337BB4;
	Fri,  9 Jan 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ahz08EJm"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011059.outbound.protection.outlook.com [52.101.125.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77AA3370EF;
	Fri,  9 Jan 2026 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954826; cv=fail; b=NvEyEuL5gm9x5WNfRLHPIgE8CmzALlqRRKyxe653MrsJJCZL+GyWne7Qo2X9yy3RY45d1KkLucTc+J1j91yvnM8Imt88W6vEHAHItPgm7lILSZq4PR4Pal3ozEFQQVzAu3VXYWfRA+v8+h/Xh3q3xygRlsVBqjxyql5rwShEGpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954826; c=relaxed/simple;
	bh=3E/CTX/h0jkJTkD2MqqFmsEkfTHQDH6ZeubOPzSXNBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YhrPYmkn+ww+gcFi0dg3WYNosPDHLfhqS89V3S2O0IcgpPsSzfnfJcDqev+FIjz/F61Fm50vaJkVkEeZ3h9smSQRSj2GkuQaUVTL4ND4r12FM7sdVPDJ/IphQa56TxuQYbBatYgZzXxjss7a5t1DT71Ykyu2AydvZJDs74anLR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ahz08EJm; arc=fail smtp.client-ip=52.101.125.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjhv56uLckbHOMC2GwuZHPA9dbTmZuFgH1B9dQCo33rRJsuljSHHJ7vM+l99SAonsasmGWRvrTjn/ShRfGZjL6JJ4IVaMwZmrel4G4yAHRzkuML+YClvCa57T+wil6vNgQtQIs9/42yCcvoCmTv/Q6YgnKbhI5NDdN5lgtmfSrrgU+MTjH7XxdLvx/Z9hIwKmhBuVKozjm8N+ZzAYqGbFt+ewnflcTXq+ya8WQQrWPYasmy7Zkj4vMMpZTqCjGI7mEzRnSl7SVYV4l2NYmgj/2hdSdA8ejUTlentK30PlCNx42/gRiFLYta7GtlDUmr22r2cVyOiYwzmcq0hJytdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHOmUBJ1IfjFMS/2OOTrhhE/x3kVySZsANqPazpYNp4=;
 b=eLoWTVGkU4uJYJxObPzHQ9oJM32SCQNgQdNsEqZYbzyO83rzzuBmoqT3bXw5oUUIu7uL5304MKhemITd5GXOWopXA2elQj1DAeMxl0/eRNkVthrJ1/0LDa7eQsw2NUFNlK4mn3Tu/vHdAeOK7KNlxHdBlrRScCOqR5FTutRJo67T2NXqkmZ9MpPbwlsmgDaSy3LiWRXEnwQROdm2ATFM7d52FgXo43K6IfU7LeakWaY9URhrLnHzNK/x4P4eMciPFJQuxC1pdncusiqMW9x+Jx3Qb+G58vR/Sr0dP5InLt34GieUtg2sbEmYraDFz3LXQ9z1s/ZoMEMBOVN3natAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHOmUBJ1IfjFMS/2OOTrhhE/x3kVySZsANqPazpYNp4=;
 b=ahz08EJm6b1liyn9kPaynBGqFQlI4Po+Uvt1LRdTpqw8/EIEqsH0YZ5hNrXv4vBgVQwDozjxl1k7J6pcqPvKL3zkV6vJ3YfUHyyazSxwgUvial8mOL7steEOVGnW/EQDWXxB6g3t7SYtvVB8qe7ZxqdPRZrvpDAhN3QrinstL0w=
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com (2603:1096:400:3c0::7)
 by TYCPR01MB8344.jpnprd01.prod.outlook.com (2603:1096:400:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Fri, 9 Jan
 2026 10:33:40 +0000
Received: from TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97]) by TYCPR01MB11332.jpnprd01.prod.outlook.com
 ([fe80::2511:10cd:e497:4d97%2]) with mapi id 15.20.9520.001; Fri, 9 Jan 2026
 10:33:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Cosmin-Gabriel Tanislav
	<cosmin-gabriel.tanislav.xa@renesas.com>, John Madieu
	<john.madieu.xa@bp.renesas.com>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, magnus.damm
	<magnus.damm@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: RE: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Topic: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcgNjpP7tWju4kVEOD2PeFnHW2A7VJWgkggAAujYCAAABl0IAAEqaAgAAEpWA=
Date: Fri, 9 Jan 2026 10:33:39 +0000
Message-ID:
 <TYCPR01MB11332563E563AE1F941C27A338682A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
References:
 <TY3PR01MB1134624FF7929D32670CA90F68682A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260109095937.3317991-1-geert+renesas@glider.be>
In-Reply-To: <20260109095937.3317991-1-geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11332:EE_|TYCPR01MB8344:EE_
x-ms-office365-filtering-correlation-id: 41d6c020-db55-4a9e-25e6-08de4f6a8de7
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J/JGRIhplmL6AA1I6LE4r3y6w/G7hrXmHAQl2FenxZBgByPvKS1ceBst1ixa?=
 =?us-ascii?Q?uJyb7MW+vFgHF+KFTu76iE31/uQhBh7i4i9akNY8tP78wSEVWsfVxISc7eb5?=
 =?us-ascii?Q?6d+LC61Gmx1YoOAMpKUqG7lxtwaIQI6a/M0yKf1RpLPfU/COR47FallF8/tw?=
 =?us-ascii?Q?XKLaPakNstJuRIPLmWsJN+hr63zkNk080ActsNC2yGbBQsaWgmqsugykRxLS?=
 =?us-ascii?Q?8x53dwIRwcvkvAuB8vN2WpVXuNwAHgw1YMcblIOX5KPHcSlbkxlCFF3iKusO?=
 =?us-ascii?Q?ksbH4gYyBj4rNjF7Q3gRyId1DZvKYP40/VshfbtPAM9gvEQwXS9bMKAFLPtZ?=
 =?us-ascii?Q?UJp0dzSG63S8Zu0NYUK1G3mFiCEFSrQW8snul33gKIQMgXuZBnU8mp3TfWjG?=
 =?us-ascii?Q?0JVnPA+XL9Ouv2IBq7bR3bMbRaFsKUrjDk+JLYr8TY5wX0zcOiO4TQi8Uvc8?=
 =?us-ascii?Q?iLbzFWlyxGZhqSizvc84+GH62cPn5TzgNBnKv2j5dLv9Uta1g1t3bv4SzeND?=
 =?us-ascii?Q?9p8fJrPyS1llrBc4kFhIjD0KMiIsPMBk6zi24hBUVwZljWyzyrdD/3GF1I38?=
 =?us-ascii?Q?l5xumBPTwv0Xq5ixxM43PnNtcom26QpZnCcnaAd1HtQi2pD+44raPbkEJ3q+?=
 =?us-ascii?Q?tGPNukY390KFEAlauwfhUTvDNRNN/unUli0UwTlKtsq0lG9ovKoLPLoG4AR6?=
 =?us-ascii?Q?TV3nGLl/uDdOrdp4aaS/81HFHmyXcionCIwoa9oRFL7pOR5FgGxh4GtBmEwp?=
 =?us-ascii?Q?Ph28WUK282eQ9Ubg0PVBajht9YwEVDFBimff+wQGWpdQxef+yyoyaU/24UJo?=
 =?us-ascii?Q?RrO7EVrGHLxusMXZUw8/X1nJHHz5cH5+Tb81cGnQWu4o8s6bo/6DQ2PYhG+D?=
 =?us-ascii?Q?EfHU4tllOkKlbv+8vL+fPuRWvAvk1KPX3H5aI2u6gGMP7/jLROE+PS3AXD2M?=
 =?us-ascii?Q?vbeCzOdSSVI1rg6R52xgG02ax1n1k82qZieDhByLXO68sRWl2Qvr1fQ/L+Yk?=
 =?us-ascii?Q?6DqxsQ5D6kJFUElEppZXguDVHTNe5/gj5COdneh7FjtAp4eL1ySVPHhs32pY?=
 =?us-ascii?Q?qBZF+S2gmgcV9tPa4nmbVbNCmdcbcHXEhiWggy/WoC9udoibgqprirgN9UUE?=
 =?us-ascii?Q?3QKnSKRtaN+u3HVzbiyiDUinZfiZ9yDNEQ/ILB5YlsodDJKut7+1anTFBHUB?=
 =?us-ascii?Q?6fIO71IcD1xv6iep4bebQ6nRt/4wag8wxQSZFXK6mIBCIYGNl4+6UqVF7HX+?=
 =?us-ascii?Q?DpmIpnCehSMesboAuMwnzkohDHORFUw/yH8f0abEO4qYsQsbdbtmwzI7IvB/?=
 =?us-ascii?Q?anqn2/FmUkELmnNd3f82dKr/MK+Dq7nyg8WqSwvBFaDVfqVzHSCJ/qe3G5en?=
 =?us-ascii?Q?wYstbOEg55QDIuWGPhGyIR8ITQ0iWojTXGikIAXMpT/Dwk1S4jU1ipnGKI+q?=
 =?us-ascii?Q?GS+sBIlacQOo2DJcreQyG9RwpXXj64YQdwNiMwL4Rn9d8RAZoFoKXI8VNWtC?=
 =?us-ascii?Q?zQRNGkEHTQ3QoathP2Y1zyEHRYhwvUCeWC4o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11332.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m7LmAM1EDb/CddplnEKc8SprEUkWgkSmV7PI8oXzwvwf8CPx9g7walh47Y9X?=
 =?us-ascii?Q?mUGLnSQ3kH8dteDEWdcN+d34PfSbE+GtKEWb3wiNGVt68MqbH8yRHjh/Q5D/?=
 =?us-ascii?Q?CAfua+/K4pFW9xvrhJQ+1ft4/1PWKENvDZk7DxDoNRpXIcEin1e9NeO5p7Lr?=
 =?us-ascii?Q?EiOhgCEGNeRk5GEq50jSYqN2hadkUCw2gWLWohLON15Zq1t3aXwbqGwFJ+A5?=
 =?us-ascii?Q?ir9aLQ00zZSGowXpjSnGRAcRZtDGqLDhv0ARyWewXSPULDaqsifbHyV24T6L?=
 =?us-ascii?Q?CR60xSeaFtpXcWFyj9IFAL0+El9LFVDQ7CM4P2S7LUEkqczJTQ4QnyE8VPmn?=
 =?us-ascii?Q?j5UrctKo9p/UW3xsKgArSs6xgpRveSK7y9WVvfbcFQHzO1tky7jdCp0R1EEh?=
 =?us-ascii?Q?eZIJ8BfQ/KEim2ZtC4HfWC/VitA2v5v0aaOWVzOH+MrhrHhpMIm2+056z7cC?=
 =?us-ascii?Q?qIGhtRyN3TmkZhZdOKDDrBbAaosfoobyNSoWIriEPk6DygbCrReAMd+k5MNK?=
 =?us-ascii?Q?5z02grMBfkBKWT2K4o4MMNKSzsLeG6j6S6jVXWagaGHrLmdKigkCpnuVaQj9?=
 =?us-ascii?Q?Igmp203ev8Xw0O6QZRrX3gJBbdEchv1qi4qwclvKKDnVs9uvRyUR1tMTKNIa?=
 =?us-ascii?Q?pOX8vz3QQ38fzvIv2G8Z4u5ckJgmTckO6QME3kEoOgP9o+7GkKMe0uxuEKRV?=
 =?us-ascii?Q?FsR5B7bM1m2r+032Ipi0GkgO+aMgdrjVDV/ErRIwv+mHSSyRk4XKdRXFC3F8?=
 =?us-ascii?Q?FZxBtuZVPdYDD5rObJBGSSDhwweYphRmvoJF1eMJDdMWxzzndnR70ZXhUrrk?=
 =?us-ascii?Q?wcwNjo0OTU2c55N13ai2T+SoSV0SdgeJE65XRxUyP9ktxjS2KF/AB3Vdupvm?=
 =?us-ascii?Q?PmtJUlvGnl3Obf8N0YZWCeluzgHtJj2FblsO3rwJ0zXyvr49dujx9GliE1/c?=
 =?us-ascii?Q?s97IJ7tcnGrRuDRjyLQP6ih2cOSMIQwiV/ZgQvFyCpyheCsYzT+aVnNmd8p6?=
 =?us-ascii?Q?9lVBY1jrnAKyXhmUKpcr3do/a5a4kcaCneaOa9Xp2euCeuflzFlk3bAqjEph?=
 =?us-ascii?Q?rw0od1i04gZZWYB7JpXR2NgTwL3Bu/ihZ6jFxcwcFSLU6OOTKF1S2KAH9Izf?=
 =?us-ascii?Q?M4XtFkUOgpEExis86cqm1fSy3ePFHxa62LJ0zHoklOLOsi9HTt0zgE62uZ4x?=
 =?us-ascii?Q?ow5zvqqrXr9vHluI4X0njJFM6ZVOpX6gVHDDpvwB5OUfHWS5kwJ/DRbJNh3v?=
 =?us-ascii?Q?8kaJCgP3KC3J7WjUSmyefFH08mm96lCGhHEHNy6KFMf3yXjZc+rMSgpGmJ+c?=
 =?us-ascii?Q?ThXdqcSBPz2JP1sajYwlrxP4AYOJdXMbdn57Yu7j9ZVOdwPAZUxtZJH6rpSi?=
 =?us-ascii?Q?vrhbtY8b7CS34fFevGB/X0AB82ePUyYy31GaL+Ko2VrPgm0HF7czGs8DaoTL?=
 =?us-ascii?Q?V5I95XBcg+2+TE5SI7FTcTUQWlZ0UZyEG/MpZMAuUtBbsspz8lTbOEMW+OF8?=
 =?us-ascii?Q?oGUoTawpgxurU9xe0X6hmySQKLbac1+YdDbYBIHdu+92LTN7e34TieoUT60t?=
 =?us-ascii?Q?2k1qaBdZ8ha2Du3c+SkvsHLpbmugPP4MySgV5nz24TPUa46eV7Z1Y7F629eD?=
 =?us-ascii?Q?3/aO3Nzz5rIoxrASnyXtkocUcIvTQB/+m8aSZfYtGsn/zUW/caZcw2do86rS?=
 =?us-ascii?Q?1IHkrjpBxrrnHtr/Y6tEb9001BRkZ2yz4YtvMVkvrkgy82D1P4ZrvHy6jgJI?=
 =?us-ascii?Q?PR0e/hMMbQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11332.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d6c020-db55-4a9e-25e6-08de4f6a8de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 10:33:39.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvAi6+pmZp9KppFTWF1rNYkCeVDs0zrtMiBTobMViGn5Nx74QW0/TsASbAVfn6noTjgwHLVARg6IdtvpvrpA6MR7k8TwIPCeWqsZdqp5HgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8344

Hi Geert,

Thanks for the feedback.

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Sent: 09 January 2026 10:00
> Subject: Re: [PATCH v5 5/5] thermal: renesas: rzg3e: add support for RZ/T=
2H and RZ/N2H
>=20
> Hi Biju, Cosmin, John,
>=20
> On Fri, 9 Jan 2026 at 10:06, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > From: Cosmin-Gabriel Tanislav
> > > <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > > > The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs
> > > > > expose the temperature calibration via SMC SIP and do not have a
> > > > > reset for the TSU peripheral, and use different minimum and
> > > > > maximum temperature values compared to the already supported
> > > > > RZ/G3E.
> > > > >
> > > > > Although the calibration data is stored in an OTP memory, the
> > > > > OTP itself is not memory-mapped, access to it is done through an
> > > > > OTP controller.
> > > > >
> > > > > The OTP controller is only accessible from the secure world, but
> > > > > the temperature calibration data stored in the OTP is exposed via=
 SMC.
> > > > >
> > > > > Add support for retrieving the calibration data using arm_smcc_sm=
c().
> > > > >
> > > > > Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.
> > > > >
> > > > > Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > Signed-off-by: Cosmin Tanislav
> > > > > <cosmin-gabriel.tanislav.xa@renesas.com>
>=20
> > > > > --- a/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> > > > > @@ -4,6 +4,7 @@
> > > > >   *
> > > > >   * Copyright (C) 2025 Renesas Electronics Corporation
> > > > >   */
> > > > > +#include <linux/arm-smccc.h>
> > > > >  #include <linux/clk.h>
> > > > >  #include <linux/cleanup.h>
> > > > >  #include <linux/delay.h>
> > > > > @@ -70,6 +71,10 @@
> > > > >  #define TSU_POLL_DELAY_US        10      /* Polling interval */
> > > > >  #define TSU_MIN_CLOCK_RATE       24000000  /* TSU_PCLK minimum 2=
4MHz */
> > > > >
> > > > > +#define RZ_SIP_SVC_GET_SYSTSU    0x82000022
> > > >
> > > > Maybe add a comment mentioning firmware should support this index
> > > > and the otp value is stored in
> > > > arm_smccc_res.a0
> > >
> > > The fact that the calibration value is stored in .a0 is clear from
> > > the retrieval code, let's not add comments where the code is straight=
forward.
>=20
> Agreed.
>=20
> > If you have just a0, then driver expect a0 from firmware is either
> > error and OTP value.
> >
> > If you have a0 and a1
> >
> > Success case a0=3D0
> > Error case a0=3DSMC_UNK
> >
> > a1 will have the value from OTP.
> >
> > > Regarding the firmware support, it's obvious that the firmware needs
> > > to support this and that the values don't just magically appear, no?
> >
> > How do you share this info to customers that they have their own firmwa=
re?
> >
> > Eg: Customer firmware is using different service ID and driver uses dif=
ferent one.
>=20
> Specify the service ID in DT?
>=20
> > > > > +#define OTP_TSU_REG_ADR_TEMPHI   0x01DC
> > > > > +#define OTP_TSU_REG_ADR_TEMPLO   0x01DD
> > > > > +
> > > > >  struct rzg3e_thermal_priv;
> > > > >
> > > > >  struct rzg3e_thermal_info {
> > > > > @@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(str=
uct rzg3e_thermal_priv *priv)
> > > > >   return 0;
> > > > >  }
> > > > >
> > > > > +static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv
> > > > > +*priv) {
> > > > > + struct arm_smccc_res local_res;
> > > > > +
> > > > > + arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
> > > > > +               0, 0, 0, 0, 0, 0, &local_res);
> > > > > + priv->trmval0 =3D local_res.a0 & TSU_CODE_MAX;
> > > >
> > > > Do you think it is worth to ask firmware team to return error
> > > > values in a0 and actual OTP value in a1.
> > > >
> > > > So that driver can check the error code and propagate to the caller=
.
> > >
> > > If we do that, we will have one more variant to handle here, as we
> > > cannot make sure that the TF-A running on the board is always the lat=
est.
> >
> > Mainline will use new variant, that can have both a0 and a1, if we take=
 that route.
> >
> > > Right now things are simple as it's either supported or not supported=
.
>=20
> Agreed.
>=20
> > > If a0 is some error value, how would you distinguish between an
> > > error in the new variant and a proper value in the old variant? Both =
cases would only populate a0.
> > >
> > > Also, I'm not sure how much use we can get out of a TF-A error value.
> > >
> > > The error that TF-A already returns in SMC_UNK =3D -1, or 0xFFFFFFFF
> > > in u32, it is pretty standard for SMC calls and the probe() function =
already checks against it.
> >
> > The OTP value can be 0xFFFFFFFF, if it is not programmed, if that is
> > case How do you distinguish error with respect actual otp value.
>=20
> What is the expected behavior when the firmware interface is not availabl=
e, or the OTP is not
> programmed?
> Currently the thermal driver fails to probe, which is IMHO suboptimal.
> An alternative would be to fallback to default calibration values, as don=
e on R-Car Gen3.  To handle
> that, rzg3e_thermal_get_smc_trim() should store the unmasked values in tr=
mval[01], so the probe code
> can detect this case.
>=20
> BTW, what are the default values of the trim registers on RZ/G3E, when th=
e device is not trimmed? Or
> is this always done, unlike programming the OTP on RZ/T2H?

RZ/G3E Hardware manual mentions the below notes[1]. RZ/G3E also the has val=
ues stored in OTP
But the values are mirrored in SYS register, and it has access in normal wo=
rld.

[1]
Note 1. These bits indicate a value for 19Bh to E43h.=20

Chers,
Biju=20

