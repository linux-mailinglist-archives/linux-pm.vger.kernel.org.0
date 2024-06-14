Return-Path: <linux-pm+bounces-9188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE36908AFC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 13:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB2528B34F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA36195B01;
	Fri, 14 Jun 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QtPj4iSC"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2088.outbound.protection.outlook.com [40.107.114.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2A190477;
	Fri, 14 Jun 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365428; cv=fail; b=pCJ7VzlBeae+3iRakozvncwDopgIpJBr/A/OzVfoZ8gluLvnXdEg0SKn0Jt3cJgbD5+BY6w8u6pPBEPVlP/3dSahUAZhHL21uPC5nJkbZP3P4r2hk+tDx8p76N3ztEUOvBA1KWtS/8LO0vFpBAQvz7nKY8uu5INbtUgt6PTAWn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365428; c=relaxed/simple;
	bh=qi9/+WwxdqWWWy2YiKenEOB68hvY2mCp869MCFRBFhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUtFgdaw+htsaTaHXGb0Ps6imxzMoNv/sCSxzZf8w4t07wBk3R71kUXHRec0OcxjcZeoncYV5pliiffGC17LPBxLVEY75JiI1k70bmjGGEXZQa8fP3qAoNPXpXyRS9U7WsLTPrESrw8MpbY4AAcdfwcS3ioofLtd91DhG6/znSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QtPj4iSC; arc=fail smtp.client-ip=40.107.114.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctpkhfn5SBotIVKpd/+YOvmSAlNdTb+ySSYY5CvXeEyiDXS77ydGxDygcxnqz4qATqJG0eAEhQRhlD8gaEwjNi6ISwho9P4r1ggtE2xuyqm0Gqc4pQR0gy26g9voGEkxBQ+/D7n7en6LxiJ1vGWEeqAh+oComal5nc4PVV+ZP94354VW6y9mXeDVRZqzJFFA2unq1fGR/ahcyHgC1BG6iYJEeIOhoFj6ghyNzhCwEKaPlsc3z4V+kfbuWlAY5Z+PNyi9zjU6tk+BFhXvjPfjdhJuRJTTIYKt5WY9rhZHoLkLLS5j/dY+jvc5uCKk5Je9lFYJR0I51hkyoAYRAMfQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr43O+hM/q+69gYB5IqcoGuXAFj1WsYlsGZJyjQPcxA=;
 b=PvmUeJDrDUO9J1C3wJjnfIsR+jKM11n3FicusUzfm+wz5JUcnlcRHDoxCy+6js4dJbpKwFAJZYkOKK4tM4MXixkrD0YUksk8gwqyq6weDNnhudK4cDsxBBHhUyRUwreg34DLpzh0BkRE45NolcoYs/YdGZRxitxKO5kixenp3AwAjko7ov9QZZsEfoLjtyam7DpeqM3sL8v3OwcUCNS0FERUahxpdn8HxvHv8b2lCOz0/hu2rc+0gTL7AKzEuOulmSZloOXwn2iXNPjPPwIzEp0ZA/szL1UFgluXemYn4kmSg8OevlqaYJjelhyIa57U5owp8AuCyEEXpI5GjHJVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr43O+hM/q+69gYB5IqcoGuXAFj1WsYlsGZJyjQPcxA=;
 b=QtPj4iSCc89hlIDIoy+ggEvpXp11/k8s3up7iPHZleYEfIH4XKnFsXJ2lLC5HpOZoaKornDOWNqlKwQfxOCmvE59d0RSxX5q37hn6L7aVzJ1H/MhA3vfdONkzXz9b7wtc0YOGBQO4BWf7d7k6cltTS5BS5OS1nT5KunaXZleUl4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB7109.jpnprd01.prod.outlook.com (2603:1096:604:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 11:43:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 11:43:39 +0000
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
Thread-Index: AQHau+8g8jdUQb+BWEyWYz8fbD0DGrHCqBcAgAAUSDCAAYw8AIAC3s8w
Date: Fri, 14 Jun 2024 11:43:39 +0000
Message-ID:
 <TY3PR01MB113467AD31470F72C75DBF41986C22@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240611110402.58104-1-biju.das.jz@bp.renesas.com>
 <20240611110402.58104-4-biju.das.jz@bp.renesas.com>
 <ZmhmWrvyQiCzzeYi@finisterre.sirena.org.uk>
 <TY3PR01MB11346B807820F681E7EEF7A6786C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZmnDwKUlXCWFJ8W0@finisterre.sirena.org.uk>
In-Reply-To: <ZmnDwKUlXCWFJ8W0@finisterre.sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB7109:EE_
x-ms-office365-filtering-correlation-id: ca305626-2837-4df9-2758-08dc8c673bdf
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TALyEhwN1NoMpShhXal/10D1+Qpna8WSDmk7Da/i+p3AHb8nlwjTG3CdRdG2?=
 =?us-ascii?Q?XnysJWjMTXrgRT5Kh1Qh2A4lJmhFntjtQxB/yO6wj1XQnbj69fi1MFFMYDbM?=
 =?us-ascii?Q?yG6XHNt//kJTVNYPOs/VZ78SalIi992JQ3s+NOXbKMYDxSOMUJvo1AM2yCgH?=
 =?us-ascii?Q?cJk2EH/BVjdJ4hfpNzIQYgPdu8UIuyafQ++R77y3O0ujeSEKGDpjE7MzdQi+?=
 =?us-ascii?Q?HxOSWF/26gvWa525nAEUDPDXD1jUgV1ciJGPYL7ho7l5q70VcU/mhHJlt0d+?=
 =?us-ascii?Q?0MnT0NIhVklTzE38NZbatAffS8uMvpIDtRJfIPnOKpxrzlMHP1qTETowCj+B?=
 =?us-ascii?Q?C7di0F9FWe1LJEV/Y3RfWZO/2Q4KbVYw+CQm4mxGWx0qGvKycy4QW6g03Khb?=
 =?us-ascii?Q?cfJRJEXuejUW2Xm/ta/msz3p7RemwTqwtNdAC48RXPoe6NJ3FRXVcxy+C0Zy?=
 =?us-ascii?Q?nuHzrfkizT6jSoglU8+Rt9MFL0APQWenxUwdCw+LVJ0pR21PYLI5WzODMFu6?=
 =?us-ascii?Q?Hm67CFN80D0h5EHEXXZFBS5OyD5XOY3dyZvHWTczuNTlVeCqGk+lvNRTsbaJ?=
 =?us-ascii?Q?v/jUQxyNQkRlDE4AxRoE18lkjodv/fund+O9WH7B2mkD3HGmwbHkEZypV0+D?=
 =?us-ascii?Q?3TB3YqhU7bBS1GF9+Wo+v/2bv4ftp2QIMwJCeQVX+tmw2CpOC7AldUJpi8Zk?=
 =?us-ascii?Q?6TLWHGLsI9pQVZgpHgyXeUEN5l1N1aQjMB8t0uC5L394Yv0NnJ+prTUVJW/d?=
 =?us-ascii?Q?Pe1QRshSTc2Im74L595DASKznV2eB5k1OeX1q3X+CS4FYaDT6wknQ4Gl1RMo?=
 =?us-ascii?Q?+CVYyFZQX9yguM7JzJkIDRVzzNBvv+bu/KUSMqbNJdZNQwaLTh0Mz0KEPfkf?=
 =?us-ascii?Q?qGlCJY6nJ+740/lEGl8JBAT1itOcp7Orl6g+kDjUExHD0ejcq6p7Ieh4dQBP?=
 =?us-ascii?Q?WNDIggCt9C9Mf4cZK1Uhq43LnG+2dVQ8inX2gNzF3TRFOv2waC0430GSz4mk?=
 =?us-ascii?Q?nYYT6hU3Ps7bjTsMfQCZ5/9zoOGZE73S0KZIv3QYGI3oStiEzlZm5DmKZGCH?=
 =?us-ascii?Q?kVdhk9u7h4nC+F7RJJOYef4Jo6ZxdwjjQAB3RqQjYzTS3HAC+ti7azWwYkcA?=
 =?us-ascii?Q?Uo8LRq6rJWQ7wQBnP7P+aH1KevtdqQXELlXg+KNEXBdOycu/MSuSRhgzGsvC?=
 =?us-ascii?Q?Ve+kk/nHDmcMpimBN0lux0mg6NdMKAI11G+WTQC+qzJ4ggchcKzR9hBn6ZTN?=
 =?us-ascii?Q?36XVpDSnuQTXYO+fGBalgdgY967XEmaXPYlOQm+0K+uCYg8EKZzR0kgnsSq4?=
 =?us-ascii?Q?OM4hYhyobKGlqfDLh63wwa4rXa5v1cSv+Q4byY2FgfFhY3N8IPQq8i5uQC98?=
 =?us-ascii?Q?f3Brwac=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jAFVWLh/L2qi4SqjD3ScIX/cDf0PrgfoXArQKEw8UBETbK1htVqus0n3rSX+?=
 =?us-ascii?Q?69TFHNTeTfVDajl5y+xVK3DY4HvkDN/NEZI5SkqrXbmfNqKTKeJn0xA+2hBb?=
 =?us-ascii?Q?YAXGGn0yCtkmVlhTUQnkSJr4DlsLZZxLHymFJlTo1U0u6tibAYiaXh+V8m1E?=
 =?us-ascii?Q?IPXiMMl47zZBCLUyTHCS6PTuTX/96D9/D8yzUlMjWVBE6erBE+mHa0y7rgGY?=
 =?us-ascii?Q?8xDlR+/FMgm073f6QNINTTsXQ0kNz5gcpBhEbV1/xh28wCjHVm1+07nK+s4P?=
 =?us-ascii?Q?BgZ3J0AnDPpVdAKFljTk+uQFyXiCiczExXu1nxHWETZrOP5TSngFXyufmA3V?=
 =?us-ascii?Q?NvDOZKwGFbMIFHOEYD2+LBhkG7jS0AOlta/2DIfVhLps6exKbP/Lew3BLDK2?=
 =?us-ascii?Q?5hkVIYOWcOlJGExiKrf0jrCbClvcspK7TA4a2aM6qYiFAxVivWnQ8L0nEhln?=
 =?us-ascii?Q?zF9g+9ONDyecO8KGEG1wM6iByCJJUg1ccY+pZl1rW2BYLW5Eg79eAlVkhIfM?=
 =?us-ascii?Q?hgJPMYnbZcX/9Z6AMnKXNbvIx4c5uz7oWLYvJH4EL+D1IHA0K8nRppDmMZH6?=
 =?us-ascii?Q?W6PcEsFMFoioOLbeInwqtOWkkT1i1VD4QEbUOn20Mr5Vo6Ppuj2Vn2b4Ot7+?=
 =?us-ascii?Q?kDgtASNzSPLxTCRzbNcmA7RXTFJ0SjVjCsispf1p7fuSefK05bAsYRG3+Beh?=
 =?us-ascii?Q?XvQGhDfv814O6jsVrsknDi5CHchlMa4gSt6mwJwewRG4dHwGQgadznvO7zJf?=
 =?us-ascii?Q?xE8swGh1rR6xup4KHOLd8Rt3eHNCy1qI729AI9e7D4rF4tZCODa8wda13ks2?=
 =?us-ascii?Q?iNiGhvMBKo0J885Y3WtTb2NHzjU8YVehTUOEASyHpcfBsvhuxxjP6gm64tit?=
 =?us-ascii?Q?bz9tyuVM6H7aUc2WwLF5tEo636Eu3GRZtDFmW4XOTn9i2yTQ03mZYuJansBd?=
 =?us-ascii?Q?JIGaIV5wih1IH4JnGzOvpUbdStPMw9Tx3Nt2x200aXq5Ch/a7rsqgQy5w5TK?=
 =?us-ascii?Q?m9Ccy9De4pXYHDDyRQp6DlY/goZwcoLHhp1dF1eCzqPc3kvw43tvrun3M9dw?=
 =?us-ascii?Q?7s5Jh506iLXtBeRUMDisJoxeZD8E1gQeqdTWspKdqZ+AApB4ySsWECf3tJ1/?=
 =?us-ascii?Q?4tWPgiMid2jSgf9qnw5uOq419IuHc9hV/8eTUoxu6+gWG4I+BHa8zT4qndxS?=
 =?us-ascii?Q?dIIMfqeIxDo4mj0Fy5rwXv3jBXuogylprE3NsYXu9FaWPEEW5i51USEgO0KG?=
 =?us-ascii?Q?voxTZWYVkvdjlv5/V6BvujQgWYcGQ5tJWiVYtHRaAcNFeJJ55Rl38ViYoudt?=
 =?us-ascii?Q?oPuSNAoR6PVTZFR4BgGvrMGWozzonuUG4k0hQmBav7hNAyEWYzQ7YRLbdOqr?=
 =?us-ascii?Q?J5EQ19VYdowscyjI0zYZBK8zzprh4+/psjJpDB+Al/jO+EP/2YdQ9o1NtELl?=
 =?us-ascii?Q?C7vFtr7fYsR9rNm8c2vxFW3d7DUAVSOCtF6cvk4qg1Z8Otw01/lMIVol9ZH3?=
 =?us-ascii?Q?Vf9GCnsr+x7aT2Dtg9n1Y87Qz3XbVNTJAmsVJkAsuiJl7ks+I+s7FmnJKi1G?=
 =?us-ascii?Q?BKbOugmRk8OF/iLAzFxvthZkduz42nPHfATxqnNpC4jCkzczCO7mPmjvMLug?=
 =?us-ascii?Q?VQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca305626-2837-4df9-2758-08dc8c673bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 11:43:39.3616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ttv6D86s/TB//MXWfcBveeupElnylCFpRX3DrhLYPXIT4qcgaouVa1ZJ936Q5dPwwDwbPaxLCLjITLuuYyhwOMe2khtacGUOAP+wLzJMooI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7109

Hi Mark Brown,

Thanks for the feedback.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, June 12, 2024 4:50 PM
> Subject: Re: [PATCH v3 3/6] regulator: core: Add helper for allow access =
to enable register
>=20
> On Tue, Jun 11, 2024 at 04:28:37PM +0000, Biju Das wrote:
>=20
> > > So, it'll doubtless not be a surprise that I'm not thrilled with
> > > this - it's basically just punching a hole straight through all the
> > > locking and reference counting in a way that's just begging for abuse=
.  At the very least we
> should have a check for exclusive access in there.
>=20
> > Do you mean exclusive access by means of spinlock to avoid race between=
 enable/disable()?
> > If that is the case
>=20
> No, I mean regulator_get_exclusive(), this clearly can't work if there's =
more than one consumer.

OK, I will document like below

To access the hardware register for enabling/disabling the regulator,
consumers must use regulator_get_exclusive(), as it can't work if there's
more than one consumer. To enable/disable regulator use::
=20
       int regulator_hardware_enable(struct regulator *regulator, bool enab=
le);

>=20
> > > Also it's not sure about that name, if we were doing this it should
> > > be more describing the effect
>=20
> > What about the name regulator_hardware_enable() to make it generic??
>=20
> Possibly.
>=20
> > > on the regulator rather than this happening to be done via a
> > > register write (this should also work for GPIOs...).
>=20
> > Do you mean to make it generic, so that it works for both regmap based
> > enable/disable() as well as gpio based enable()/disable()??
>=20
> That too, I was mainly thinking about the name here though.

OK, will remove the restriction

-       if (enable) {
-               if (ops->enable =3D=3D regulator_enable_regmap)
-                       ret =3D ops->enable(rdev);
-       } else {
-               if (ops->disable =3D=3D regulator_disable_regmap)
-                       ret =3D rdev->desc->ops->disable(rdev);
-       }
+       if (enable)
+               ret =3D ops->enable(rdev);
+       else
+               ret =3D ops->disable(rdev);


Please let me know if anything wrong.

Cheers,
Biju


