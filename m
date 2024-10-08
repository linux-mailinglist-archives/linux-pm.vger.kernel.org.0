Return-Path: <linux-pm+bounces-15312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195799444C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15151291087
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30E17C21E;
	Tue,  8 Oct 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="MeNzytbS"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010022.outbound.protection.outlook.com [52.101.229.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E054907;
	Tue,  8 Oct 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379804; cv=fail; b=j+yJFDRGrOOJVlaoKDgIlLZXRzOamZDBCzWEPtR8YGgdijBHniSOHYusQyubDLkeHrEZYVS00yjSQLahCwflSlXEmRXKTSCpWBidfamjU7ML4gkyQIfOexgx0aMYRkPDbFIVO6DhZ1T1pG8uzwrrfLZJCvLP5EKJcmv1F5v0oi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379804; c=relaxed/simple;
	bh=Xukg+50VXSbEH0LBwmPtWKcF2hEpre4FHDA41tR0bnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DC7uHPyC7doBx+4bt6aX+Be9kShCVgY68QXXfS8p6MEuRccaUoyvH3u/kqhbQoO4rUoVR1QAth5kShYSKE3v/E6JNRgUvbgoBGr+bq03C3ngO4BkTPXd012R/hPpbnhMRKnDDOSB6BKXsbbPA4kvdMDxh3Nn8psewAyYDFviubo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=MeNzytbS; arc=fail smtp.client-ip=52.101.229.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hANJnCMBHkuhVDcKG0WEhA7RqmAAsjC4mehK41s2Ht0SP9MHn+lgZ4OM6YIELi2GaoIMYMLziKFUkAlEayXs2ugmHcwR14bR3bUM8eVoc24HSNfEoIOe1M5oBXqWBDJEHpMsMW7Zigq3jyEwgi85ZIYUSQrxHFj0z/ksm3G4uGoJY2rdbbcGdjBqsyYrOzoTW7H1IVb8Q50TY3rF1l2OfhpKHwm/04/VtTzsrtIFnSKbuz/OgI2q1bg7on6KksJnW4tgWvIk47SCE/AvmiU38wScx/1OsFxvXfjalwo1WsGwgjhFVhkKVnOOT+UkMJv3/Tou8/UmgHcBuPY7qcUWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht+I+8XvH+ZCT654v7xrZNmKaH+vb585dvk312FvqWI=;
 b=Uk5XaRASbKcZsXbq11KXRfJ+mR5mVtPjAjbS19DOBJnJquCB8InDNdNc65S9AU52fP68ZiBXox9m0ifb2DNONe3h7lKhpQ4JESilJ9IFgQQwGDKyrOFLJ+BgLEaqr8OFxsFsnPkop5SPTZ5rLOdXnU/zQfuTVkEYnSKuv1jr2L2tFs/M6QSPpGkCqPBF50H8e6kwaLZIpm9C+UQA16WsmuvZuCdh5KuRIrF3D7I5GQ3QvbeYuSiBkAvlR8j2pZ6odO2g7RVW3NMhIjUDQEXEsafmOiLHjM0aAFovsthLOWohXRSP/xppq35a2cEisz6vwEx9SvSnE56YL4t3/qsu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht+I+8XvH+ZCT654v7xrZNmKaH+vb585dvk312FvqWI=;
 b=MeNzytbS/axKCOycjLnNkS0+mbdnrZjqhH9vV5fMXTqG0z+YPEnQKNOveRRJjldV8+XTB/mSBgS3dFt6sXj4fZtQcuVWDTdohVVnMClZMgNFuuKtVrMYHnw33K4x+36oIHoLN7SNiuiKEmcKmhbedXv3hBILAyzF2cqSHyuXpPw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB12368.jpnprd01.prod.outlook.com (2603:1096:405:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 09:29:57 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 09:29:49 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Lukasz Luba
	<lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>
CC: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Prabhakar Mahadev
 Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP
 tables
Thread-Topic: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP
 tables
Thread-Index: AQHbGWPIvY55zZyi0EuLuc8H7AfDz7J8lR8w
Date: Tue, 8 Oct 2024 09:29:49 +0000
Message-ID:
 <TY3PR01MB113460E688CC3689D94C85F6E867E2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <cover.1728377971.git.geert+renesas@glider.be>
In-Reply-To: <cover.1728377971.git.geert+renesas@glider.be>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB12368:EE_
x-ms-office365-filtering-correlation-id: e783297f-0497-442e-fb54-08dce77bc161
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wS8AHYIdAaVofOswuV/U7XOYEFZF7qbf580sqYjuNlEOKJNMfxlm6PQWx3uG?=
 =?us-ascii?Q?B4kaJgow0NigDoMWOnJ/vXEHt6nc8gIgGdLJWaO5sBNCLRumIz7ahOIuCmBa?=
 =?us-ascii?Q?wLygAJ+H9GIBxPYSLuUTFwgUu6/aMJ3xb+K3oCAUS2fjHs5cmWT+3cTtvu31?=
 =?us-ascii?Q?HCTjw6bvsldY/q34PCvomQILI6ejJH9W1J5pFYiOhlRneaybsw74n+XDwX2j?=
 =?us-ascii?Q?CN7uk/NjR5uRrTrWyULDv+nIisaCpV0OcM75nWxkkxQhEzjXg96Lr7Q/yMch?=
 =?us-ascii?Q?6ArMqwCozSbgTWJgqj08cnao5jDYVhmeY+kG2pGTLhjRBd8hdDcaEaZH+lwC?=
 =?us-ascii?Q?C8HVoM8sAomaNhlp9jXKlOhfTOjp1b3l5debMeucF08O49InY30jZufRZ63M?=
 =?us-ascii?Q?1zBSMKIzN3uQZD8UkrbTRtg6nmU85oCfOc1nLjEYK86fRmgqSE3YHiv9i69v?=
 =?us-ascii?Q?fbVMWPuq6OoBpA9u6soi43h7tZiMjtQCn52tuApIhJtt0Jih4lMsT2gOfF3J?=
 =?us-ascii?Q?BHnF27ccVrZTJi7caJGo4IYG3LQC4R+vog1JrrTsrQqufHzexhbzt3sgz93Q?=
 =?us-ascii?Q?X/gs87CTW0WS30hY05y6TR/r5f+EXuUG8fIl0ttSMdeVmW2/NedodRKmvN19?=
 =?us-ascii?Q?+c117q6PP0dFSkYVdMbIuW4HRJnmZoddsPeq++8wVO7e7hey6NyeV8bJU4H3?=
 =?us-ascii?Q?fnUVKVf+Vu7REYydo2uMC+0+VdP/yC1Pkax3U7fAIcA7mJrX5r6bU7DjxGvQ?=
 =?us-ascii?Q?9i8UhfMwa2OS4+0P55PLVox5Sb+AIZ+PkcaDFx6gvT5tTf9MPbVIoceskp7F?=
 =?us-ascii?Q?LdnnDRQbCUp8zdFWRot0uwVutq6gsEPd3tYZHTYHvqJpounj5eEzvZfIfHdC?=
 =?us-ascii?Q?CibR8Ti+VT08EFG8vvQtrEqb0pfTPrIBt82wt8F4e9ls7aYBCkp7AAHydJ4l?=
 =?us-ascii?Q?PzWP2/GweKdr0OFWDIfAYzqAmajYfoJ1wDB5gm/xMe7wLOfMtS060RuKZyTj?=
 =?us-ascii?Q?357R1OGNw1sFKAprfcIsLENk8BJmOGSnmRSEjEpq7OtxXTdvwhk/Rs9QivUw?=
 =?us-ascii?Q?2OlwAFpzoHJsK6jelBCcvKz8rXQVbzOmYumthNmByVa9udcZxj9lHdzHl3bD?=
 =?us-ascii?Q?tRFsF9v6OYH2oKEDXdHI2+wfmJ1dJo3oSRPps0t4xljL28LOHZyT2rMgY8dh?=
 =?us-ascii?Q?6AbBh2bolAuDOBWsh670uyAKFegAOi1TS6Luh0sVyXbb1IhIOUPaxjHu+k1/?=
 =?us-ascii?Q?cgfJ9br3iHYQ+OWhbOC4COQcJTZmUKKJPs1WXy9hnp7TFf4Ffr6NEYWEJFuz?=
 =?us-ascii?Q?Om5tOpxibxbJmGNUiAmyOH19vquF7F1ztBMNWDz5vMz2EQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rYlfu9iBS9IiUeUYJFtMelqXAmJwTV4ZQxIkomWCYxcNiE8KzrtBqMRjMEdw?=
 =?us-ascii?Q?23hD5hnSepyUUPHmL1T8/kpX1J7VJWi7IlSZ8ozlbTGyNX4f2pMXe/Gyz4Mp?=
 =?us-ascii?Q?a5I0HO6AKYuCOFiUswsGaHXKVNEhUJDdv9YHjm3c69p/vsroRb9HdEmFoc4D?=
 =?us-ascii?Q?Sk+z4Hss9YhfpGaU5sspgTaBW9EQ3KgSfqJUG0VylWb9lYUQEpJoGDzOUwJX?=
 =?us-ascii?Q?e31EjEVY6hHFv2t80UsbKwFYXWjRlXXz9TX8xV8vIJo+DSeBrp0iiZ81F+IA?=
 =?us-ascii?Q?I9T5Y3CSM61idAAR0x9m9GBZwSe92auFBrVlZVkW/n9ur71p0CuQicExZ3tN?=
 =?us-ascii?Q?oLbMWBowb68e2mIh44DDL9B384do/W0y/Z6rKLCshhw4LaWuQQYQuydxhXIo?=
 =?us-ascii?Q?0AINFlQmRCMjVeCA20xi/GFbHhcXf8fB+jn+U/5CimAUui+BF9A/Ew7KoV1G?=
 =?us-ascii?Q?ns8uQiC9X8OJ6QobqYVcFWY/5UNpAJbF2SrucY9keKUZyaT5cDYxfaRsIpBf?=
 =?us-ascii?Q?yI6q613c0J+i5bH7nglA39+dSPPuUJ2N8BwCElRD0DLNpjxy+7oXbE21rVL8?=
 =?us-ascii?Q?VYeoZ5sVSeRYrvgoqVfaBinTNaBrcP1KT5mm+lIYRiX0M2DqZ6mKgWv30iQj?=
 =?us-ascii?Q?0y+E8yhNZ8svV2eVFabWqMUXtJD6tzQTpPD1EZ7wMfo84b/uwcMcd51uJ6jE?=
 =?us-ascii?Q?q1JvHNna9pDkHd1kNmvMp3Tnd67TgcKKaBTnu+xQ7KJY0pDj/TzdFIB+DsXf?=
 =?us-ascii?Q?09a288Hmk5C8B/wkhGiFAmwNwYNgtxngx0lOZMkfRwRvZecRJ+ZtRs52lIpG?=
 =?us-ascii?Q?QN+BPNFXj1mW3eeF4u3YDbzOPq4QBHSnoAk+HDZUiCTlApQ6swpmI0fql5wQ?=
 =?us-ascii?Q?2kt0Cy0CIwhOvaKWxzPIaju5V9HZDlJd6S6hwGRGzebgiFUdjHmREh70USOV?=
 =?us-ascii?Q?toXQgFJzcZkH2cUFS7emz+ZtOwzpyDhxrQNj9S/uK3eY2kkzMq3rT5i7oeN8?=
 =?us-ascii?Q?6FJ162zk6xjyk0gjPL5VLDraoo7b7zZ/2bPYS3+lHj74dg/xjWqZRFcSqhwg?=
 =?us-ascii?Q?zywGngag6DaLh8hdJI8xDERveVOcqgjGaTt7unHm/7xbY9qFjpdBrYDmKD/S?=
 =?us-ascii?Q?R6byYe/Cfkal+N7VhHNcn+Yx+Yq7+KPqAhbDHBa/beVNhR7n7fppw7oaz630?=
 =?us-ascii?Q?PyUKpTwmllA5H8xoU1koksjTsBpjuV2detf30sfRnVgDqKCT1JSjxxv1YYPD?=
 =?us-ascii?Q?w8mMiR1lsBmgijxtIXYYve0Lq7c6ILYyzpOM4iXakQSSCtpUtJFTjNhZruOn?=
 =?us-ascii?Q?uNBsgSCRJ+orhll1ZrX4OXbvhbPn8eWil4TRUhJGKwHPbc+0VsCarmq1qHVK?=
 =?us-ascii?Q?DsVre+nc6rFQo80FPm2xeUqUzlJcf9toWKXEfDSk5GKaQrysyEyyaHUv07jR?=
 =?us-ascii?Q?hL8RFeXKsTEqguFVMHmPK0wHwQ3/R2Y1fShWgcPZRDOC1pcV0v8ShqpYHjts?=
 =?us-ascii?Q?r9tGvoTybjFFmaSb8FSiJJjhjzYicPpc9KSESrtLJEh7NadriHk6C3sKWoCO?=
 =?us-ascii?Q?V2INUOoY//NUBmo7ZO7XmUZDPpomOiNoGdj9QSKXsqHWOXmxpkjLANVl0lW6?=
 =?us-ascii?Q?eA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e783297f-0497-442e-fb54-08dce77bc161
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 09:29:49.0650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrqlYOJjFpdnwt6CF5GIOWOC66Ol5gMLtlJWIOOTA41tRmaiSPX7FWFIhnyO6FPX9w0bM+CQaDy/ezAJEiiwWfj92y6komtKasrWkwUW6aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12368

Hi Geert,

> -----Original Message-----
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH/RFC 0/2] arm64: dts: renesas: Re-add voltages to OPP tabl=
es
>=20
> 	Hi all,
>=20
> When CONFIG_ENERGY_MODEL=3Dy, an error is printed on RZ/G2E and R-Car E3:
>=20
>     cpu cpu0: EM: invalid perf. state: -22
>=20
> This happens because the Operating Points Parameters tables do not list v=
oltages, as they are all
> identical.  Previously, it was assumed they were optional, and unused, wh=
en none of the CPU nodes is
> tied to a regulator using the "cpu-supply" property.  This assumption tur=
ned out to be incorrect,
> causing the reported error message.
>=20
> This RFC patch series fixes this by adding the missing voltages.
>=20
> Note that the Energy Model calculates energy efficiency by dividing the
> (estimated) CPU power consumption by CPU core clock frequency.  When all =
voltages have the same value,
> the former is proportional to clock frequency, and energy efficiency beco=
mes a constant.  Hence all
> operating points are considered to have the same efficiency, and the Ener=
gy Model always picks the one
> with the highest clock rate (see also [1]).
>=20
> Alternatively, the Energy Model could be changed to silently ignore OPP t=
ables with missing
> frequencies.  IMHO this is not an unusual case.

I guess cooling uses OPP table for frequency down scaling at higher temp. S=
o, we need
OPP tables for thermal governors??

Cheers,
Biju

>=20
> Which approach should be taken?
> Thanks for your comments!
>=20
> [1] "PM: EM: Question Potential Issue with EM and OPP Table in cpufreq
>      ondemand Governor"
>     https://lore.kernel.org/all/a2ca883e-122e-43a1-b377-c43956b5b3be@arm.=
com
>=20
> Geert Uytterhoeven (2):
>   arm64: dts: renesas: r8a774c0: Re-add voltages to OPP table
>   arm64: dts: renesas: r8a77990: Re-add voltages to OPP table
>=20
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +++  arch/arm64/boot/dts/r=
enesas/r8a77990.dtsi | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> --
> 2.34.1
>=20
> Gr{oetje,eeting}s,
>=20
> 						Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But when I'm talking to
> journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds


