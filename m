Return-Path: <linux-pm+bounces-12798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E352995C699
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651821F25927
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77313C80A;
	Fri, 23 Aug 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="nPX3/8/f"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010032.outbound.protection.outlook.com [52.101.229.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D08136E2E;
	Fri, 23 Aug 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398558; cv=fail; b=UzojTItf8GdzXwVUVWucPi3TWPhEFvLB1vl3UAve3O0eR8VEJXINck7olYmgTZYsTcble2PeXGiOyv5F7zk/fbXwdSt5bnidQjWbBKt1zNc9WTSXUQbdLqh3bD+14DXHBrGcwGbp4czcs0U5gGp9b9LmWY/yCrrTKnW7w/QnB0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398558; c=relaxed/simple;
	bh=GXfT3L4x+8qaCjdyxObYmMAhISnUtNY/v0Xgf6zDAaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cmV0ZhOK+wfZ3a019cRp/3bzM7R5tM+5DOjOLS+kEG/jzDRtLBn3DpM3B+CiDUniYPSj26vU4fcK5WIWSGrj28UTpIDR/EovIO+mE3Ubaxu9FXkQdWJ6zhgCs5tiSKn/KAOn5/0aAqQqvKhoUF+uPr7hiBm0nBZ/LmYbRiJ1xDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=nPX3/8/f; arc=fail smtp.client-ip=52.101.229.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu886PCji+UNNYUWAlbaUalapLeQFhb+SJSQKRVqF5gLBdSkkSRCXR5Ba2xx0gYg9X/qRMAbU7yaUhkCOGKKy6UGFcwhU7URaWHfkfimmieCb0Fq3VeF/q+Xm9ZDRdlawLnxraLb0IRauVI2l131m/ZZhleF6Wx2/wi0d3CDoXzKDeDeXGyANJWsrwjLY9lNvtcfvHXVJ85ffTqEI30LogUFH9HKJbtNwvyY9rN6+wbSyEhmwwmyNOI+WGxL5x2mPu2ME28ypja/SwWQDIaqhOItT4AJDcUmyv5Od35DPtH5h5pl0PMAr1ONPZl0J96o9nCCS6bvZ0O1mYB4sRFUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha39zt00Ud54rrj+OBwpod3DaKbEwcqFVDbGmwJHTm8=;
 b=OIo7q8YC47HS/CpUmWidJJDWzDTX62JNgyepHpfrjqqApRKmVARNmxgsXs3ongkJE6vnCtVf4qthCY5dy/JGW8AwWuVosc7/mJ0UFwPr1kwUpwzin1gXSX6m1obZcQoH0BktVZ37JADRx/Q9BAS+10iPiNUlowX/22IsQFIBB/JSOVMjjMqoiDYYesg9qCgTd4Sat6tTAI6mySTAZ2jl7QJOa0JJyuSCi0hj6HikPFnBJsphOjdympW2CnldLESsa2NxkNaH9UvOaXtTtEyNBCKVR6qs6A3uLqs0+3bGzPlGKwi7LrSlTDN3g1rHe7meWGYFRZv7jT/nr0bftXpFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha39zt00Ud54rrj+OBwpod3DaKbEwcqFVDbGmwJHTm8=;
 b=nPX3/8/fZfbMfmTOGPmVGFsd7zy+yVrvHDVyEg5oh9UVpE+TIggKp/7ajzYezXT0w68MMFF/+le2EVOtiAO6MBjEKUXX+JCiT98EPmbPJdb4XWS3fwUGIO3b90wZB8ZpyJmlwC+pqSL9bO2sr/YmCR/b7RNlbfOvounJV1OOX8g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB12916.jpnprd01.prod.outlook.com (2603:1096:405:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 07:35:50 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 07:35:50 +0000
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
Subject: RE: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Thread-Topic: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Thread-Index: AQHa9Kf4PPM3ttIrIU+GFs1JG0RdeLI0cirA
Date: Fri, 23 Aug 2024 07:35:50 +0000
Message-ID:
 <TY3PR01MB113468A6CA4ADBCA577670AD486882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB12916:EE_
x-ms-office365-filtering-correlation-id: bfd16a1b-3e14-42e0-be79-08dcc3463654
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hYdel4nlKjlERDy2Jz4txmmA7Xvs/W/TctX0jyTtGEjlC/612XWT+AbiLaN1?=
 =?us-ascii?Q?rInXMx6t/GEp/YTGQZOpAgi+WuDfyn6US/6TJSOvtbtcqSGVuhI535L4RMVQ?=
 =?us-ascii?Q?Kxe3zZpSKix77niGa/0Oow7i1ImRCHEP+9wJtpcD8Fxe/fd3Q6R0jRtFxLhl?=
 =?us-ascii?Q?Vwr4c9U4erX7zHx2DzwZZp36UvtqViuk0uzGAU8pvrKap0J7xxw03FM+r1KL?=
 =?us-ascii?Q?SbbC2optXayRldw3AkKXqBcK7d9hrk/rRCQD1DoEYJRv/JKvPvghviR0VMb1?=
 =?us-ascii?Q?RxvQTJqk7z1okTdQR/AFBBiIcBlGOT1UOE850Pmq+C0G9uEk6OA+XGa5+KCh?=
 =?us-ascii?Q?KzIssDVu+W2N/JRJFUN3tN6ThyS7uFqBTjwEYitcvmylmm7awiKuyUC4gvZP?=
 =?us-ascii?Q?uMQRG/umLPXd+qgksmm8tgWaQukBWEVECBfAurXAal7/81i3fMXaLgasR7WC?=
 =?us-ascii?Q?p17x07OWDTJA3LeEh4bRlnur39OlBckPdVgZsjzAeXb05t2DLti9bV5zukII?=
 =?us-ascii?Q?WYVGlOj7zxN35U5A7FLUBPF99vc44TUFu7/QKmBC6sx8xdq0qIxxgUoI/mPi?=
 =?us-ascii?Q?KsZanjwEXU2KifRyn0SlRQgknIZPvHJqoTsOq0PQUlKdGsyZ1wtTse+zRYT5?=
 =?us-ascii?Q?K58iPN9PMsWJ43nMtPGQXskJ3FiubbsSglalizaDSiFVDn/iQUwabvA/CKwX?=
 =?us-ascii?Q?eNHIbrlOmpM/rTSKYdxaKbA/geVGN2Y/gKNjaoCf0O1q/gT9nX6umZFRb9bC?=
 =?us-ascii?Q?byPa4Ej3Z6A7zn6TdfT5qU53cp73ty4dnnrKcBL4BXh9HymHnObfNq9otHn2?=
 =?us-ascii?Q?uoZppJ+nGETd29/Txj94p1zaMrwbe0UFP0RIpXxN8+zTRhip+RCpybfSswiJ?=
 =?us-ascii?Q?cBu0BgQl25Zm38GACi1U/f8hF1bVa9WzyIfaslc3odfQlWzGWfeiVTLlXkwS?=
 =?us-ascii?Q?POKEh8nnijcRS9FlfBCW4+4b/YiG8Jcp9ZTARr6ICH5uG/jWktzoY0ZSG3UU?=
 =?us-ascii?Q?J8hV+qlxIz+jf2g4FPrhyv46XSVRvcE64vxHWel9SKQE8ZCm83V+adfXyeS9?=
 =?us-ascii?Q?d2PyoTujUEM1MkLe2OKvsHKZBBZOk2lHBoCw3f4UAiP32KXGqjm+CHutv4D4?=
 =?us-ascii?Q?XUDSm+u+iUJEBBHa4B9MLvP37ohitE7INGKAk1xSX2PXuLRqYecSvP7xXfDo?=
 =?us-ascii?Q?kPRAUc+RqY5LBfg/sf2XXZTt/Nrt8+vxO+hQNCxcPZkQi2SE4sjphH8Phshn?=
 =?us-ascii?Q?+1Njg79StRcM5GCNMBCEk6rrc98AMhvRe5Zkdd+WwJ10LAruulC0Erw7zGN7?=
 =?us-ascii?Q?BlLnLXPAvlJdh1TNtxeEJjpD8gvTNKzQhWm/QCiWHrRSqp0a362Vh7NqY3XQ?=
 =?us-ascii?Q?0j/dntuc2fPkt6AnHv+91Na7CkpwLkb9VpfkJcE7ha94UtH8OA9eF8yONc1A?=
 =?us-ascii?Q?Jkt7usDwBjo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ha6o5CKN4oaJqBdV+OVp4eE+GKMU8DzGwtXIned8JmUCpK2XO6EKd2mGPbHf?=
 =?us-ascii?Q?FrI8V4zXd2gB8v7SmXtgc16ni7q+z8mtlK+DWq/fuJn9Uw4DlZr82NOaE5CB?=
 =?us-ascii?Q?V/eHBxhMnG46q5fNemjGIuRZdQJ3LeUFmQhdY2lK72xjG+aweoEaGd55Ml+C?=
 =?us-ascii?Q?b/CCo/szzP7GBLiIwF/I8WGCsagK2tMttYwUOgbK+yIb9RNgb2hx0L1wCwd/?=
 =?us-ascii?Q?Dto5gc9Io4ZfLuDBPVJSF5IiyqLN14ppgSPyI2yD6r80zhCuq+Nj9acgza8s?=
 =?us-ascii?Q?8G/qstgIOm6wARFUJ2CXR28loBVri7ZB5TTYRUvzSuJGu6DchNq8lqOYLht2?=
 =?us-ascii?Q?jDsq4S2bRWHIFF2yoAmsNNPZZsB0GMqwC49NuXq9emSUfXqaSYdAvp9laT7E?=
 =?us-ascii?Q?CRcfaN0VffhIF2CaMMwkNsRN7NQ3Tw81qqZK5LDc3Jm4m6vBVICVDlHMaYpX?=
 =?us-ascii?Q?mk1v3dWbdKoqtOasIp1I835vGEqTiI8HAZJZ0k5CvGbM9hvXssw+iuAyM4BP?=
 =?us-ascii?Q?pvEdR+fRWNAa2p3bIaaIiCrcY6qvb32WoO20D6TioNcn2j2tz1zWAKJlXWsO?=
 =?us-ascii?Q?LfIK9XqKnHHcRAy3nJY+/12Ci8gJcyNOZ8+24mqkKxTVpUd1otlG0ZEX56uM?=
 =?us-ascii?Q?/8vcP0OOG7e4BkCIsx7e5wwsucNkDe0x8in3NKXsg4wDusRxnD7CiZphK2ZH?=
 =?us-ascii?Q?EQQ69nGdF/EwmBMnDwtYf6fwdrMNm2kt6sJDOHiro50Mcu0rbCbpfvbPpAXE?=
 =?us-ascii?Q?lYtQl43E7OI57AjKbux/OPLuuSpWRtC8GF5PiJtXPikfsKtAjP0uYBOot58U?=
 =?us-ascii?Q?yaILKa1E/OmgHGrPEZ4bvT7KwzmjcBz9JOSmA1l7R+REo1HMoq/Gp6zQAXkU?=
 =?us-ascii?Q?6LrlmtBLjdMiUHW5yG2jypjEb7jNXMsqlNCodGjFJMmp+bxW03Nt+gL63hWY?=
 =?us-ascii?Q?C92N+PIplvN8uuPkFjA9sjyI93+ej2tAHLnafVeQq6nIjeCMzBZHWZUKSHrd?=
 =?us-ascii?Q?gIvCnDIDsqPXk8icLVre9uZID1wp/7S7Ij5hTOefs3Veu6l8XWCN7d9FYwLi?=
 =?us-ascii?Q?iRWcW3prI7VJNKxiCN5GB4r9G4WViODQU+bIbOlddPPgFDix2+NCZlBXMc2s?=
 =?us-ascii?Q?7kAM6KcBjawKNd7qLmJT6FSQGzg9K6F+Ed6Lupk0Wcb2FiBT7WLFjxtf15V2?=
 =?us-ascii?Q?2kjec45GwmrTw8d8LgsZeBM1RGDE5/iS0AV4fnRQKpqYgAHTVEEqGAaOPVcl?=
 =?us-ascii?Q?HjpVL2I8hW7mGfcSYwVofUn5aE1BzzSJz9sU/ojx3ZTkzveLiJycuG7gxTI8?=
 =?us-ascii?Q?oEE+V3B+3z6+hcVYdPMkvZOcjRcHuW/mM+zR5kqZgh1qvWXcHsKzs+cUbU3I?=
 =?us-ascii?Q?We3EkrwOfBnGIUo0+18lbEOVlX0Q01pUcSZvgpRKbCQIT3BwWiiKNR4iKtrL?=
 =?us-ascii?Q?JgM2BxKmak3wl7eQRmG9OGxyOZWkjddM/g/rV+UyvwzShFhoNwhl8VV3cOYb?=
 =?us-ascii?Q?TGD53XvYVBFomLj4FWQJVqvQUtb71YovtV3IDiPIMuFCe9PmYJDNfzbCXmQ1?=
 =?us-ascii?Q?Xff6Q9lWpk9G1JkUawLO6eTO53YSPVgTGY8lm7plQ6HvlZu6u+9rbtSYlLzM?=
 =?us-ascii?Q?qQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd16a1b-3e14-42e0-be79-08dcc3463654
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 07:35:50.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehgFgLiyPzj9D2MlADZdW/+sQLf4mEe4c0QsxYinB5KslhbgPNhflkyypsPsqCYkv4lCdNdJ8TkZgxCUJxrlEuayMUrk5ttR9llOV8dkBP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12916

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Thursday, August 22, 2024 4:28 PM
> Subject: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to initi=
alize the bus
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The Renesas RZ/G3S need to initialize the USB BUS before transferring dat=
a due to hardware limitation.
> As the register that need to be touched for this is in the address space =
of the USB PHY, and the UBS
> PHY need to be initialized before any other USB drivers handling data tra=
nsfer, add support to
> initialize the USB BUS.
>=20
> As the USB PHY is probed before any other USB drivers that enables clocks=
 and de-assert the reset
> signals and the BUS initialization is done in the probe phase, we need to=
 add code to de-assert reset
> signal and runtime resume the device (which enables its clocks) before ac=
cessing the registers.
>=20
> As the reset signals are not required by the USB PHY driver for the other=
 USB PHY hardware variants,
> the reset signals and runtime PM was handled only in the function that in=
itialize the USB BUS.
>=20
> The PHY initialization was done right after runtime PM enable to have all=
 in place when the PHYs are
> registered.

There is no user for this patch. The first user is RZ/G3S and you should me=
rge this patch with
next one.

Cheers,
Biju

>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 50 ++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renes=
as/phy-rcar-gen3-usb2.c
> index 7594f64eb737..cf4299cea579 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -19,12 +19,14 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/string.h>
>  #include <linux/usb/of.h>
>  #include <linux/workqueue.h>
>=20
>  /******* USB2.0 Host registers (original offset is +0x200) *******/
>  #define USB2_INT_ENABLE		0x000
> +#define USB2_AHB_BUS_CTR	0x008
>  #define USB2_USBCTR		0x00c
>  #define USB2_SPD_RSM_TIMSET	0x10c
>  #define USB2_OC_TIMSET		0x110
> @@ -40,6 +42,10 @@
>  #define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)	/* For EHCI */
>  #define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)	/* For OHCI */
>=20
> +/* AHB_BUS_CTR */
> +#define USB2_AHB_BUS_CTR_MBL_MASK	GENMASK(1, 0)
> +#define USB2_AHB_BUS_CTR_MBL_INCR4	2
> +
>  /* USBCTR */
>  #define USB2_USBCTR_DIRPD	BIT(2)
>  #define USB2_USBCTR_PLL_RST	BIT(1)
> @@ -111,6 +117,7 @@ struct rcar_gen3_chan {
>  	struct extcon_dev *extcon;
>  	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
>  	struct regulator *vbus;
> +	struct reset_control *rstc;
>  	struct work_struct work;
>  	struct mutex lock;	/* protects rphys[...].powered */
>  	enum usb_dr_mode dr_mode;
> @@ -125,6 +132,7 @@ struct rcar_gen3_chan {  struct rcar_gen3_phy_drv_dat=
a {
>  	const struct phy_ops *phy_usb2_ops;
>  	bool no_adp_ctrl;
> +	bool init_bus;
>  };
>=20
>  /*
> @@ -650,6 +658,35 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct=
 device_node *np)
>  	return candidate;
>  }
>=20
> +static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
> +{
> +	struct device *dev =3D channel->dev;
> +	int ret;
> +	u32 val;
> +
> +	channel->rstc =3D devm_reset_control_array_get_shared(dev);
> +	if (IS_ERR(channel->rstc))
> +		return PTR_ERR(channel->rstc);
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D reset_control_deassert(channel->rstc);
> +	if (ret)
> +		goto rpm_put;
> +
> +	val =3D readl(channel->base + USB2_AHB_BUS_CTR);
> +	val &=3D ~USB2_AHB_BUS_CTR_MBL_MASK;
> +	val |=3D USB2_AHB_BUS_CTR_MBL_INCR4;
> +	writel(val, channel->base + USB2_AHB_BUS_CTR);
> +
> +rpm_put:
> +	pm_runtime_put(dev);
> +
> +	return ret;
> +}
> +
>  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)  {
>  	const struct rcar_gen3_phy_drv_data *phy_data; @@ -703,6 +740,15 @@ sta=
tic int
> rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>  		goto error;
>  	}
>=20
> +	platform_set_drvdata(pdev, channel);
> +	channel->dev =3D dev;
> +
> +	if (phy_data->init_bus) {
> +		ret =3D rcar_gen3_phy_usb2_init_bus(channel);
> +		if (ret)
> +			goto error;
> +	}
> +
>  	channel->soc_no_adp_ctrl =3D phy_data->no_adp_ctrl;
>  	if (phy_data->no_adp_ctrl)
>  		channel->obint_enable_bits =3D USB2_OBINT_IDCHG_EN; @@ -733,9 +779,6 @=
@ static int
> rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>  		channel->vbus =3D NULL;
>  	}
>=20
> -	platform_set_drvdata(pdev, channel);
> -	channel->dev =3D dev;
> -
>  	provider =3D devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlat=
e);
>  	if (IS_ERR(provider)) {
>  		dev_err(dev, "Failed to register PHY provider\n"); @@ -762,6 +805,7 @@=
 static void
> rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
>  	if (channel->is_otg_channel)
>  		device_remove_file(&pdev->dev, &dev_attr_role);
>=20
> +	reset_control_assert(channel->rstc);
>  	pm_runtime_disable(&pdev->dev);
>  };
>=20
> --
> 2.39.2


