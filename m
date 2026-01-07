Return-Path: <linux-pm+bounces-40390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B03ECFF129
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 18:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04AEC3045762
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986634A3D0;
	Wed,  7 Jan 2026 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Xsn3PzMM"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760ED3A0B02;
	Wed,  7 Jan 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805833; cv=fail; b=aSS6pceN3f+jVMA0I5IcvDOY69vEVrXMEtqvHVCq2bEqy1Lx8PyVR8G861yAHY9MEp4cKtj5zebf3xJdxgQQlLYnEykjTFeqCelSrju1ySF6x7+DbdgS6DLeoRA9xrf1PnqJICulpuzwDK2AfICAZcoixYsSgEPWCBuHBnFPLUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805833; c=relaxed/simple;
	bh=GIONI3v79GZ1q4WTMHVeu0EsQC22TnKbgqQIoovYt1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tm58ckNau/uScUwJJnqYXVFfzp+tlyI3nT5iLxT+2DzRju/y3TPJY6hsNavDCyYcdFmANTnI8AWBg8BEbZ0zjqGBVxSsPjcyXTp27gOUqtfb+8kjVqVEv5nzM6yd3J9WRo+tQ+yEhI2vzuI6M7pfezvpFxIqTexHfzPyX7mhLMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Xsn3PzMM; arc=fail smtp.client-ip=52.101.125.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf/3JvPdHNCVVvXKTaSwAIxlaRILGkwyh2W5aJjMlbG5W181LXX6PzKtytHzgqEQIFM1PPVLdmvFAHfBCt/ecBGNerNiFVtysnHRbPpjKUoTCwAgc6V/Z8lNWeXGRHqM74l1dHVQZfoYsgozY1zO2Lpp2b7xIPd5d98sWDGkjIx+h/vKKrggAuGTxvUYlfIXPOfYlrhjzEgAAXj3dAVCufYFQRVQPiMdOl2Afn2R2IHJ52qp2cCAPzYdh+1Bovp3mzOFs1t6lcV+xKXlu8snmaPN2GanLcoUDTytbhwyglyfVJ6lRbby7/jl/LFKevJP9BMql+VYbMnDOm6Fn1IGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY4eOz2/G+G9VTWR2cu/w3tz1TFDYKK1j2FbSMksr4A=;
 b=oZA9flVcZdf7CkwIH1m5n1glgpu/2hLZEq8EiPHvDwgP3P8bGKUFdM+BOilTaoG8IKVIs0pSnSKFVvCHtf2ldmnwN9rImryNxovkwye/g/SLuXdKgJ6rGZwnEqYiDhrxWs/pZsl4O5cgJsBv8wU/7yqvfxd1rpSiDaddWW8K4W2n86HhPJ26CCNLyrOSRqh82Ab05yrhTE83L1A3TbZ4AOL0sL0iydIbGFz55Hx948hD7/QgCpM9EXDlzOKESwUtjmkFbCVaGZ4XKuO2xkaIwzBOYVGwz6liRXHEo+eRjOZGtTw3vt9yYBEqlcxS4sgk3KwojLO3F+1yHdt3L9hryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY4eOz2/G+G9VTWR2cu/w3tz1TFDYKK1j2FbSMksr4A=;
 b=Xsn3PzMMvkoMN+p+qgIHvmKno3X/O6Pr75lL7ekO1Lj+hfz7TcrfcuHUjcEXt3GG205g4huML8f7L3aa3HLy1p4SEVua92+in4vb7JO4aiuiW1kBE9E2jRebjCWA7hkaTAIw2idAdFxBhywKWJFWRIq86G7dzRzROyIIYSFql1o=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYCPR01MB7386.jpnprd01.prod.outlook.com (2603:1096:400:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:10:15 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:10:15 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 3/9] thermal: renesas: rzg3e: make calibration value
 retrieval per-chip
Thread-Topic: [PATCH v3 3/9] thermal: renesas: rzg3e: make calibration value
 retrieval per-chip
Thread-Index: AQHcXtVHJDhk+RkGjEiFOXoXdGiG/bVHMttw
Date: Wed, 7 Jan 2026 17:10:15 +0000
Message-ID:
 <TY6PR01MB1737741ED188F41A980330789FF84A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251126130356.2768625-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-4-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYCPR01MB7386:EE_
x-ms-office365-filtering-correlation-id: e94f4079-2c13-4c1f-2615-08de4e0fa034
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KZ4pGKgb9XF3vHJMi4uZ8jwgjSrqgLH6TIjWf6qdiZStfrXl4l6v0VnT4eC6?=
 =?us-ascii?Q?hID1caVoXTos6k4j3x/fnlD1vbv3HTe6ONQNoYbVgcO8x8JkoD6fNHgusDFY?=
 =?us-ascii?Q?Nkb0/5aVewDJCmmRNcUguDhj2QJcdNcV1FXz7ntm/Ks0LhfcV0CcLPYbDZvD?=
 =?us-ascii?Q?zFoWN2xNlHLIjBBcCgmRBbqTx9PYsidFw4cExIUu2SGCWPZ2bqIR7siV79Bm?=
 =?us-ascii?Q?JMBz0Y1W9zJFcYaScd2VxPTPguTAJypJfZzDpHZblMi/Qn/DTnsd/48gfZFR?=
 =?us-ascii?Q?mBtdjczqXQqZYkpx4VU3rFkbS9KbuhMAOJjB6GMpPkIOPqu+yG36EdMfjjeU?=
 =?us-ascii?Q?DbHuC1zPVXPycxKp4NS80sAxOBQkWJlNOY3NTzty4xfhypXI6NexMpJSci+K?=
 =?us-ascii?Q?jPtW2o/nXc8sl8FsKG8KLgYBATz6fZ8zF6AeMpB6CVXUu91GW2aW8q+eRCpI?=
 =?us-ascii?Q?3ijTo9EM8meSMoNxvycwBwKdq2loGQ4R91VSarOQhpxX6AiidV8jovZXf7aA?=
 =?us-ascii?Q?lL5AOX7KqnpCacxtt/EBsHxRiaahbSG6Uum/VMHUVeirDArVKHdoC/7s1u3x?=
 =?us-ascii?Q?1zzYA0kCC+CaBep/Z34uF+wYlhulyD6sq20ZjLch/LukcjYEMxodcY8LjLb0?=
 =?us-ascii?Q?25jAhnv5m1luws96dqnd0W/FgNw/YIQ25hoZnKtZe0Jp3YEkhiDHFqXYlzNH?=
 =?us-ascii?Q?3pmYfx/bDnetm3qbwbCGYRlYOQ0tmtNHC/Aw/OG11t58aNGvjIaK6fibb8VT?=
 =?us-ascii?Q?gtXABToc9/aX28/n23jcd3k4Xd1DvjcQ/MvbBkP+JAqHdH4h32oiiExdLGou?=
 =?us-ascii?Q?ZWGeEYVsD4lycH2mZns9ayy5n8nO9PliWY64HdmgKavvDBbXZhnPQgNxHkTF?=
 =?us-ascii?Q?oVYrZsSuOFIfT7KNRGScVRLj2NZrip33aeuN905MJPBhJM8SIEKpQkXteSoh?=
 =?us-ascii?Q?TfC8gJP2+RKxEIShMDyhzdq72SQhTzzsZ6ttmXLtoL1Cmtt0a6Br39yK6w59?=
 =?us-ascii?Q?qO5uH5bzri+1J1VA3JjamxyKo4gsqm2s4NwhGWgsfTuOvp54OnLXoXglje0F?=
 =?us-ascii?Q?a+2t1IQUOsKjW2bOBYmtJtTpSE9Pj6+EuzEc9AVKezAaoRbx1urF/w7MHU9I?=
 =?us-ascii?Q?Tf/mRBpvV6gKwcZXby71uGh2Y8a9LHNgWgWXFjgSFFCk13wPfH9iCUT3sSSv?=
 =?us-ascii?Q?K5lR7sgglB4wVR6RCULWYW10SJTsLohH0Aehe+xxDWAYWDF5o00roFwCRfbL?=
 =?us-ascii?Q?yXotN1sNoZLHyDzYwtbAYftbvnKmwg9iMk6gzCBzzVIZ89W/1VYENr+9o6Sx?=
 =?us-ascii?Q?FogMqW54u7YPO7AorGdR1pkxDK/jPRhcDyi6a44KXUTrrRNcdkK/GeD4Z9UZ?=
 =?us-ascii?Q?yQermQv6Xo7Ln9Hm5LiQQX53xBXby4mpEwh+Oci7nDBedzNy5Xyxsy5cq3+v?=
 =?us-ascii?Q?Tye1tYMgLEVI0ZJpfLU7/FiXlUUg9JKnFZOf3FVwypnZZC/MGFFR1dOYrKaP?=
 =?us-ascii?Q?7r6OuranVvfngXjotZxk6wIL2mUTCnlO2pA6TxXhULDPl6wnGTE4B5Paaw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Db2jkmyTBieOdhWD7WNKlxo667G2I3N3UE+V2dGUJMypSfL9BYizFnobqDk6?=
 =?us-ascii?Q?Ie7wQO6Hu0gsQIcUuZmSEYx5hec2juEZwO1GFP9HFMNuCPmfPB7mKQcTCan8?=
 =?us-ascii?Q?l4xZfNPvkMdh3pHukEwKzN79B7faPKA83+uq1WsUF88/SpapwYHbRT0pOIAY?=
 =?us-ascii?Q?U9W4vP1NER49tZwDhuf9WzcecsOuVxQWgVakajIBdbuUlBJX2ssZ4XFpiSDG?=
 =?us-ascii?Q?o/MQmb8zcBYNml/XlLTCWyjY+zi+Fj5lYwi4jpQ56+0hzuC1ZMDC5w9Qlliu?=
 =?us-ascii?Q?TMIx5eyKRvI5sCH32hYkUgCkvnsXgq6OgVYenEeTqrFpDr/aBEl2gOW24kMs?=
 =?us-ascii?Q?HE2D9Md9lehW1LaDEzbgWahdndaM+mlLAPSaIWPd1ULQo7EyuDYBefBw4yws?=
 =?us-ascii?Q?fInzDS6Zu9OOwKm0p9dRCVA9fu5QUxADDFrx/VyhVoOO0trP/KgpDeocnPfR?=
 =?us-ascii?Q?HVCc2LHLLwwJis/HmyrDCH5E8p1pGJYzemvYKRYzeBOfp3jTReOUhqp8dB3y?=
 =?us-ascii?Q?NQLkpi/rxGVa/XHdp39l9vsTebE026plF/og092u3f/KV2exfZzOTCCIjJge?=
 =?us-ascii?Q?9qJ+OOZOzlIKwMCKa7XQtjkzJx67aEOSABHx8HOkYGm8CyTTKq9MveJ6xAfS?=
 =?us-ascii?Q?hNlTfJqVXHGoUZGAmm+x97n6GvqeM0PlS8is5KcvsOtfZ4m9QXaE7f2IfrGA?=
 =?us-ascii?Q?AumQfSpzNu/od28yomJj6PrSJ4ahdS6v35FcUFmL/66bNvrYdymqh5CFCzLC?=
 =?us-ascii?Q?gv1frBThfERzGGhzD5HCJ5+sp7/VcOPl3HvNqmnJOJTSs1PX3NKp1hFPvM5B?=
 =?us-ascii?Q?O/UbUNnxtw2MtffaYzQvC+2Iyk3kl9XNbhcVI7qZ7K0V9Ok8RQeGh89p6vw3?=
 =?us-ascii?Q?JSrk0E9KItiaqqAvZyQx1K9t7Zp1mX6ySSKo7PgyZyQHFYKm9W2KJNodGIO8?=
 =?us-ascii?Q?gM0i4VKJjE06XDSPPPwsSUVkU3RiM5T5Nu2lOnXLmE12Or051VpnROQdNRVD?=
 =?us-ascii?Q?Enva519nmaFRqdD7mSx6eZALRfI9Gj4ESR9f/xZG06lgbpBUYDUrM5XZEdCJ?=
 =?us-ascii?Q?IaOJp8Z5q1UBJGotCRg50I/Xtv93OPrnlA+/N8vO6UWqHUcG5IY1wPd61xGW?=
 =?us-ascii?Q?Cm7OntdSeXSBH8DGGV5Md1qdizFR3j2jBDPYAU1KjnDTckh28YNpNeTqvlY/?=
 =?us-ascii?Q?ytqgZf2LybrxAQGvOxoh327R8rjo7qnElhrhSfrHwyITA5SWcPdkXdMXD+rS?=
 =?us-ascii?Q?bskJCtOHsn/ttGA6Yb++VQrlk5/qRgt6iJMrICxlUo8NnZzBt0ZI9do4FbP5?=
 =?us-ascii?Q?VK8E5BwyZziOQ6+7eiQBGatTQwIEGeZ6Nn1vSDWQ7dStIKeO5E9bLLZEbSmX?=
 =?us-ascii?Q?eDx1USi/y7b/QILh37HUVNcIWgjlpJRHT0seX/RVv3tJjgV981jIQ3rB41tX?=
 =?us-ascii?Q?QU8UENhjbxy4SfHPO78Vjqeowl4SNhW+gkb97qt89Hu4wZEi7jENb8XMzQVi?=
 =?us-ascii?Q?TqazUNVjV3scakly3WOqYWvJT+D/2FSgqpwo3L/ievpjLqsX1SvLs4ty8TiX?=
 =?us-ascii?Q?F7ZlnV5EQih9TRUo5fpg284hDoQg3/RTepXk9LbuxBZkURX7X2V6OEtNhjfz?=
 =?us-ascii?Q?mRDutTnFJfXX81UpLXk5/dZ2pyO7vecVxMGfzHdvoTJm3sNGiHJ2SXZ0Fsl3?=
 =?us-ascii?Q?Y+CV3uMtXQ8s/O0BWWCLH3xdz5lcSW+TU5KsFDdqYE9tQWzYaN7+j8FrnBIe?=
 =?us-ascii?Q?tkHTLKKf8aI3flzgPXp23X9hRhCqBN4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94f4079-2c13-4c1f-2615-08de4e0fa034
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:10:15.1862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4af9ZzNiGJnxtLcI27Vk6uMHlUuaI0vrp6r/6HdpLVC/6UOokSK8oIKSJUftkKVl7cHLd+LYdMNL4IZQHrrOLOB9+OMFWtK3nZcZ8XAtBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7386

Hi Cosmin,

Thanks for your patch.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Wednesday, November 26, 2025 2:04 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; Rafael J . Wysocki
> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Zhang Ru=
i
> <rui.zhang@intel.com>; Lukasz Luba <lukasz.luba@arm.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>;
> magnus.damm <magnus.damm@gmail.com>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Cosmin-Gabriel
> Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Subject: [PATCH v3 3/9] thermal: renesas: rzg3e: make calibration value
> retrieval per-chip
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> temperature calibration data via SMC SIP calls.
>=20
> Prepare for them by moving the syscon usage into a single function, and
> placing it in the chip-specific struct.
>=20
> Rename the functions to match their functionality, and remove single-use
> variables from the private state.
>=20
> Also, move the calibration value mask into a macro.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> V3:
>  * no changes
>=20
> V2:
>  * no changes
>=20
>  drivers/thermal/renesas/rzg3e_thermal.c | 62 +++++++++++++------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c
> b/drivers/thermal/renesas/rzg3e_thermal.c
> index 3c9ff5e43d7e..d2525ad3ffcc 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -70,7 +70,12 @@
>  #define TSU_POLL_DELAY_US	10	/* Polling interval */
>  #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
>=20
> +#define TSU_TEMP_MASK		GENMASK(11, 0)
> +
> +struct rzg3e_thermal_priv;
> +
>  struct rzg3e_thermal_info {
> +	int (*get_trim)(struct rzg3e_thermal_priv *priv);
>  	int temp_d_mc;
>  	int temp_e_mc;
>  };
> @@ -91,13 +96,11 @@ struct rzg3e_thermal_info {  struct rzg3e_thermal_pri=
v
> {
>  	void __iomem *base;
>  	struct device *dev;
> -	struct regmap *syscon;
>  	struct thermal_zone_device *zone;
>  	struct reset_control *rstc;
>  	const struct rzg3e_thermal_info *info;
>  	u16 trmval0;
>  	u16 trmval1;
> -	u32 trim_offset;
>  	struct mutex lock;
>  };
>=20
> @@ -334,22 +337,8 @@ static const struct thermal_zone_device_ops
> rzg3e_tz_ops =3D {
>  	.set_trips =3D rzg3e_thermal_set_trips,
>  };
>=20
> -static int rzg3e_thermal_get_calibration(struct rzg3e_thermal_priv *priv=
)
> +static int rzg3e_validate_calibration(struct rzg3e_thermal_priv *priv)
>  {
> -	u32 val;
> -	int ret;
> -
> -	/* Read calibration values from syscon */
> -	ret =3D regmap_read(priv->syscon, priv->trim_offset, &val);
> -	if (ret)
> -		return ret;
> -	priv->trmval0 =3D val & GENMASK(11, 0);
> -
> -	ret =3D regmap_read(priv->syscon, priv->trim_offset + 4, &val);
> -	if (ret)
> -		return ret;
> -	priv->trmval1 =3D val & GENMASK(11, 0);
> -
>  	/* Validate calibration data */
>  	if (!priv->trmval0 || !priv->trmval1 ||
>  	    priv->trmval0 =3D=3D priv->trmval1 ||
> @@ -365,17 +354,30 @@ static int rzg3e_thermal_get_calibration(struct
> rzg3e_thermal_priv *priv)
>  	return 0;
>  }
>=20
> -static int rzg3e_thermal_parse_dt(struct rzg3e_thermal_priv *priv)
> +static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv
> +*priv)
>  {
>  	struct device_node *np =3D priv->dev->of_node;
> +	struct regmap *syscon;
>  	u32 offset;
> +	int ret;
> +	u32 val;
>=20
> -	priv->syscon =3D syscon_regmap_lookup_by_phandle_args(np,
> "renesas,tsu-trim", 1, &offset);
> -	if (IS_ERR(priv->syscon))
> -		return dev_err_probe(priv->dev, PTR_ERR(priv->syscon),
> +	syscon =3D syscon_regmap_lookup_by_phandle_args(np, "renesas,tsu-
> trim", 1, &offset);
> +	if (IS_ERR(syscon))
> +		return dev_err_probe(priv->dev, PTR_ERR(syscon),
>  				     "Failed to parse renesas,tsu-trim\n");
>=20
> -	priv->trim_offset =3D offset;
> +	/* Read calibration values from syscon */
> +	ret =3D regmap_read(syscon, offset, &val);
> +	if (ret)
> +		return ret;
> +	priv->trmval0 =3D val & TSU_TEMP_MASK;
> +
> +	ret =3D regmap_read(syscon, offset + 4, &val);
> +	if (ret)
> +		return ret;
> +	priv->trmval1 =3D val & TSU_TEMP_MASK;
> +
>  	return 0;
>  }
>=20
> @@ -402,11 +404,16 @@ static int rzg3e_thermal_probe(struct
> platform_device *pdev)
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>=20
> -	/* Parse device tree for trim register info */
> -	ret =3D rzg3e_thermal_parse_dt(priv);
> +	ret =3D priv->info->get_trim(priv);
>  	if (ret)
>  		return ret;
>=20
> +	/* Validate calibration data */
> +	ret =3D rzg3e_validate_calibration(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get valid calibration data\n");
> +
>  	/* Get clock to verify frequency - clock is managed by power domain
> */
>  	clk =3D devm_clk_get(dev, NULL);
>  	if (IS_ERR(clk))
> @@ -423,12 +430,6 @@ static int rzg3e_thermal_probe(struct platform_devic=
e
> *pdev)
>  		return dev_err_probe(dev, PTR_ERR(priv->rstc),
>  				     "Failed to get/deassert reset control\n");
>=20
> -	/* Get calibration data */
> -	ret =3D rzg3e_thermal_get_calibration(priv);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Failed to get valid calibration data\n");
> -
>  	/* Get comparison interrupt */
>  	irq =3D platform_get_irq_byname(pdev, "adcmpi");
>  	if (irq < 0)
> @@ -533,6 +534,7 @@ static const struct dev_pm_ops rzg3e_thermal_pm_ops =
=3D
> {  };
>=20
>  static const struct rzg3e_thermal_info rzg3e_thermal_info =3D {
> +	.get_trim =3D rzg3e_thermal_get_syscon_trim,
>  	.temp_d_mc =3D -41000,
>  	.temp_e_mc =3D 126000,
>  };
> --
> 2.52.0

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>


