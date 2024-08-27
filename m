Return-Path: <linux-pm+bounces-12962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C597A9609C5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05673B20CEC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB61A0730;
	Tue, 27 Aug 2024 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oDM55hsi"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011061.outbound.protection.outlook.com [52.101.125.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8BD1991C8;
	Tue, 27 Aug 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760940; cv=fail; b=h047qQR9AmwY0HAB/4exKZy5omCjD9Sk8wx+kWbpwWOZsvto7njxEhRBUosNqdKBphE5Z+nomL/9JvgvuqK8Sftc7E/nzFpUF2G4VawQJqh7RIVWHeIQzJOA90G+l+sYcqo8Z3aHQAd3+few5G4lNGspYAf5ie2nHjh/r7dZaM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760940; c=relaxed/simple;
	bh=dD0SEEvx4uP1k063pQgFQBtuHT49n1dfzRNgZ+k1aeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MNkqG7kJM/f5CmF3anlz9dTZ69ekIweJY9SdtXC6id+RFYmu757FdWAbf6MfiWghRi1QgBFrDjORVQAuVKP3Ue0A55SijftR/7XmxEBPTUsryttK3hNHGjSjXXyo+LXhTuPcHkCTMkQazcW3cQdo068wLnpDb/s/Ort+UFuKQFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=oDM55hsi; arc=fail smtp.client-ip=52.101.125.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFx4AJP82hvQQYou57lfd1J56pPwCKA8KlKFaaTNA+y4hkCNef/UlN7EiAHbaBX5wqCWC8b9TcXqp3rHYXVRQ4ESxGC6Ue46xmR2IM+a0lgSRvWO2u3Cgqb1qI5DtT977zVqoCUn1j5kG2p+c1HqKKfv4uIVvZgl1Hr7XKfGktBvB+dAt1ijlYAzhA+4Xq75qbEzmyPiqNufZl5j8uNNf5z+FO5uSzeK+gAW7V7H+DHWIDf8NoD+4C0EvKJkJAKWbMI/6Eu5tuj7ktU8yUM/u+C10L6G9PNSDlnG2zJmhJJ5RjcLUSMY7ZcK7nYvACZRBnRycUQKyr8f9WwZ10u9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0E7UiMW/BDAIwzN32eC0C3BVEK+wUk0G3FSqLbursk=;
 b=M+KNIZp7aItxN0ind34CzHbxSLj+iCQ+x6pRmJi1C5xOsrXmrK6M5zO6kWOmb9JxmVOujqAdgltCIEOG8ctxN95lBDyjhuIG5aIQwaDzfe/Fp3qaJlv8c9lEIHQE+ExovEkGnK0GsnKj7uKXNFM6+s1Ta4MjU64yyw72PL6ozO0qMe8sGngPd1gwPTvGBZapEwqB8qD6cC3+zxpw1s1krBtDXcgsB/93ASCBz8+b9tlBwZgUbhmzdJvB3Pq29J2W6omc7SJvp2IGPueF5Wvi3tClSnOYrW3ceu18lqXTcSz544H3YtRBGjNyHmuGrWQR5+Qz93voFxp6lFDpeVydTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0E7UiMW/BDAIwzN32eC0C3BVEK+wUk0G3FSqLbursk=;
 b=oDM55hsisIZ4Ir/AdokLaWgrsCd6wWUoGnYc41dtDLBg01mvlBrH3rIUmrPAE31kK0MpKYPR4inpxROPYkdIahrIkUUiuvswegNF4MI0KIFK+MrhZuvOT5l1XmC+E2bj657BRR0DMp8UO4ZmeDSJQ6TGJWyZ23QNcas7J0dn+uU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSCPR01MB12657.jpnprd01.prod.outlook.com (2603:1096:604:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 12:15:29 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 12:15:29 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
Thread-Topic: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in
 the restart handler
Thread-Index: AQHa98xfGZ/E41sgA0mqBISLrIoXOLI7BK6g
Date: Tue, 27 Aug 2024 12:15:29 +0000
Message-ID:
 <TY3PR01MB11346A223DA7462799B9D103786942@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240826152529.2080248-1-claudiu.beznea.uj@bp.renesas.com>
 <20240826152529.2080248-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240826152529.2080248-4-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSCPR01MB12657:EE_
x-ms-office365-filtering-correlation-id: 44cd3e7f-51a4-4a96-dbfa-08dcc691f0ee
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WnDO33HW3d0JY4qD0McngGEATzGfD7/DeVycZGuFYi3AuUbWfTTk5Vbiw4Gd?=
 =?us-ascii?Q?r5FB1pL14b/ho8wXP0ug/b00wsRXEYbanjirM2zqU31RR8U2BrYgfGFTCvw6?=
 =?us-ascii?Q?qqA+gVRR3dnvuoOaDUVgAOri3j03XpHbesgaQFkQkvsqcQG7DSRivrh1HStu?=
 =?us-ascii?Q?S4bzAogBE7pl5kcLCZfW9GftXrhQSr0R+FwjqAkt2VH7AFs+H4x0MXYFuzPm?=
 =?us-ascii?Q?SwpIbU2r+RzZK2LlazhCVbST1+QgRx5RoKAfxQTIQtbt9u64w/Og7olB79xy?=
 =?us-ascii?Q?M8ul4taGRTCKGwLOzUQVXQ579Vtrd9xvjKGjmn8+/nYT+XbRnzFYFxlbmy3L?=
 =?us-ascii?Q?sIWnZB3EWsZ+badGVMIfVpCtF0sYyZ0/x2GYQc4gBtEbjIXnOSMUY344btPW?=
 =?us-ascii?Q?sRaLCfv17fFZfOVMDywE2qWLiX1HJdJvtVfIu/KQ8+V309W1oDcOCSQGEPcC?=
 =?us-ascii?Q?GNKwM0mPgo37z2wac7D/InU2nChjeSNnBRoji3u5yOkfItkQTEnjdbsQtgNp?=
 =?us-ascii?Q?e0Rp8ONDOOQWH1NPYBzoucZ67lSLcLfddNeTfgW4KukC/4YK32JDbz41/Shl?=
 =?us-ascii?Q?cpJ38QOZ2/RPXUxf88AkBJEJACKbRO6tBtkfLlc9Icj89ldO0mGhQpyx9nJ7?=
 =?us-ascii?Q?RB48euLYPn0zQ38mLugizil/pmQohREw3DnlhIq+RkULE+etE0dwNU6H2qXz?=
 =?us-ascii?Q?IYPYOXsKvqX2wIbtEfgz8pW3xHYnY1ewjc+LV5fLcjFxs0nyhTDvuCPXq1CF?=
 =?us-ascii?Q?hexuIb2mYt+jf0oXjNDooziHeVv/3SEJ1xd2GO1eUr8NLbYNwlNdePIepFOy?=
 =?us-ascii?Q?uHldqFlotVHF3uC8rJpPNB+7CIG0rDk4XMECFLo9vHgB+zmUUjRvFrQFevq8?=
 =?us-ascii?Q?2D0ADcrUi/hJaV/2mDASYZX9yMjwS9J20VDRvwRCPgbdaH4A2OfA+LRv+d90?=
 =?us-ascii?Q?IWIAKjZHwWv0mpkg2kVu5AYqaY1oC2Vxt0gbJKF6EmxltyZUASpLPvjIyTn7?=
 =?us-ascii?Q?e8deYGMWOUSsbUUerfo5MDez1WwpvFeZloys5S/cmzjVY2+HMfpGml0lJYF2?=
 =?us-ascii?Q?Rpjp3nmhAurT4BLNHkFKnL2eleKPqgriNB/guKQ2jnu15A4rs4yhBljPlV/y?=
 =?us-ascii?Q?qEB0NKMnOdNyJoBvkYq2buhE59/ecP4eY3YlLEE38PajuDHN8AYnYeMetvp8?=
 =?us-ascii?Q?3zWV5io7IxKOUfWZSPaHG/pfemepkL5TbpuL4BAZU/LxBa9VrKlKef3iZ7uy?=
 =?us-ascii?Q?0ezP9v2QyUqp0/kQmoNa8ce4+GOgez0ztBP9EC5S4HXHFvq0nC4aejChSyqB?=
 =?us-ascii?Q?fFCTZN9iiz6TRRUDKJ/MofHGHPKrhEIeCMHYPcoFTq0jkAIasb55GT9Xv8TA?=
 =?us-ascii?Q?xUJe51Sg5GRlWNsrmJSAxULhTbX0ciggqdM7pHCkQhuV/4id/Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EUAbPaKW6gmMFQAh6ag9aRh1SaFj/5yMsv+YUVEOC5cbvKdOwtlBCbkI1jPD?=
 =?us-ascii?Q?fVQhTkorj23gDuywK0DUXiUgV0JXJPwd96zyLeLafjIKmAAaKtbmbjM1tcs6?=
 =?us-ascii?Q?DuKXuIOwf2Qk6k67tRzTL0m1w2hRu3xwsKYyd6gxhox2wo7ZAq6wfpi2iaig?=
 =?us-ascii?Q?r1b0nPlgaulhyz6zk9K1+qkJEA/sGpil8aHDFpfiQPtFmMd/QFp84qWZuCyO?=
 =?us-ascii?Q?eKNFy5jt8vzR6nR+6uYqOr9Ec4VYZL0fidWi87afV+tdn9tptjR0vnGqsYDI?=
 =?us-ascii?Q?mQQ56fWOcIkVnXrOwTtQ9wtG96Uq+Imkg9tEv/RqvdbPN7tf/xbO9BTwR1y5?=
 =?us-ascii?Q?USOoTTGGpVXEILZ4HRqJlSHkORtM6z6PvmsRKvacsUaoO7/MaxwPHnM+cN6N?=
 =?us-ascii?Q?0oAhNKpcALP3dBo9LM1jrTPfV8iM9uqbhAn2Re29zrQjyChgSg7ydWPjfDiu?=
 =?us-ascii?Q?Cs8CQx8dju3zPoCuUf6zhse1EpTsKlklC23qLpVU+y23i1BqWJSRG4Qefcx7?=
 =?us-ascii?Q?ViR0zznJ0VZZavEA2AQjWVKdY8OkoiTzPwLoVxg+siTGIOUYa4Nu7HXO4KZy?=
 =?us-ascii?Q?Tjqh2TI4RJonifGhJyc0dQ7yg6vIbhcHySkqWoxRDkps6yS+oCbjMwa+PYOo?=
 =?us-ascii?Q?pS4B8gdmi3VrHkaI0NwOJcOSUH9BWeA2dQ6ZqBdv2GtSVy6/5AVJjxzxNyy9?=
 =?us-ascii?Q?QDBhF2hSmYv/0ykEuE9W7gAT30c8PrAdwAyduCGd5TU5pQt+T65uhFT10iR5?=
 =?us-ascii?Q?vAeTCMpefc3WHJHegpymVn9fAm6mYlX5Jjcek697wyD3cSZcZVoF0tAxMVoY?=
 =?us-ascii?Q?/5PYyy8UFCzPH9DLaslywroIVria3vuG9Esg2q8h7E6gh8dH2F8OuenXxQyl?=
 =?us-ascii?Q?lqliu1s3TOHTy0Pp6GRVfAaOcAZAzz9KQhaJOf/hFEPUeyENV7TYlLcH2Oad?=
 =?us-ascii?Q?ur7bYWH92YG1Xpt/Zot1LAZwcWsIVIcXxn1xvI+7zbZKdYYaT4Uvod8sw0et?=
 =?us-ascii?Q?x5mLzmbq1uL6g5nqsd0pDD72/AGDXad2TbqQ5ntmzyjPuAZjHfgx54zxz7+G?=
 =?us-ascii?Q?QlndmGtA6a79HnnmcHg+QfKLXhE9HmjxQydRtTQoufvnp0CfPfG42dUbhC2q?=
 =?us-ascii?Q?/yKGncj6hd8sbW80OGkQaqE7m0/ITB0nMkYoGYUkJxkYA/KKBhYj3P9SmlBa?=
 =?us-ascii?Q?Ezh3BccSgDHd1c+Pq6B+GNLg8yNTpSSp6avqUdKi+r2TyGbMb61waFWlidhB?=
 =?us-ascii?Q?NtywOjRZGQ627z6lkhy7ZUFCXfJETTkHQlMlYtVd5rX2rKOH1kw41A6wLl0O?=
 =?us-ascii?Q?6SRRVCcqW0lX3AImFIWcZ/eIjLboQ13SW9wJihPCUJz3ajkC394VDb37lXD2?=
 =?us-ascii?Q?OyZG7mc0DsJRGZ6ay0YnLiO+T6qLbh4Eb/Vh+jv8XsdoVtclnbkpYIJrOKHE?=
 =?us-ascii?Q?jvHpWlaMoABLkZTgm3B0ZRNk7BvXcL6KvHWyqz2Kyqrycuw//d+OPrjdlNcR?=
 =?us-ascii?Q?OnHsgWyvmb9LUcIEM0eB2bGWFfa7TtyFonDpZwHBeDP9Jou6x5EE03opJxeD?=
 =?us-ascii?Q?DYC3lBZY8MyUrViu1yhwVzyVKr1ty/WS5kTSxfjAsFJ2eTwEI8SQKx+7Je0H?=
 =?us-ascii?Q?XQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd3e7f-51a4-4a96-dbfa-08dcc691f0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 12:15:29.4441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2HoRo7Y98Sw6Tx06dG6EbceJedRip95iXkW5esFgfOC8XKduSXsrvUolzokTxWNXkm5yLU1MUtH5t71rs+HWzs0IyAQpQZ1j+TbbSfjQR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12657

Hi Claudiu,

Thanks for the feedback.

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Monday, August 26, 2024 4:25 PM
> Subject: [PATCH 3/3] watchdog: rzg2l_wdt: Power on the watchdog domain in=
 the restart handler
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> On RZ/G3S the watchdog can be part of a software-controlled PM domain. In=
 this case, the watchdog
> device need to be powered on in struct watchdog_ops::restart API. This ca=
n be done though
> pm_runtime_resume_and_get() API if the watchdog PM domain and watchdog de=
vice are marked as IRQ safe.
> We mark the watchdog PM domain as IRQ safe with GENPD_FLAG_IRQ_SAFE when =
the watchdog PM domain is
> registered and the watchdog device though pm_runtime_irq_safe().
>=20
> Before commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") pm_runtime_get_sync() was used in watchdog restart handler (wh=
ich is similar to
> pm_runtime_resume_and_get() except the later one handles the runtime resu=
me errors).
>=20
> Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait
> context'") dropped the pm_runtime_get_sync() and replaced it with
> clk_prepare_enable() to avoid invalid wait context due to genpd_lock() in=
 genpd_runtime_resume() being
> called from atomic context. But
> clk_prepare_enable() doesn't fit for this either (as reported by Ulf Hans=
son) as clk_prepare() can
> also sleep (it just not throw invalid wait context warning as it is not w=
ritten for this).
>=20
> Because the watchdog device is marked now as IRQ safe (though this patch)=
 the
> irq_safe_dev_in_sleep_domain() call from genpd_runtime_resume() returns
> 1 for devices not registering an IRQ safe PM domain for watchdog (as the =
watchdog device is IRQ safe,
> PM domain is not and watchdog PM domain is always-on), this being the cas=
e of RZ/G2 devices that uses

RZ/G2L alike devices or be specific RZ/{G2L,G2LC,G2UL,V2L} as it is not app=
licable for
RZ/G2{H,M,N,E}devices.


> this driver, we can now drop also the clk_prepare_enable() calls in resta=
rt handler and rely on
> pm_runtime_resume_and_get().
>=20
> Thus, drop clk_prepare_enable() and use pm_runtime_resume_and_get() in wa=
tchdog restart handler.

Can this patch be fix for Commit e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'B=
UG: Invalid wait
> context'") on RZ/{G2L,G2LC,G2UL,V2L} SoC??

Cheers,
Biju

>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/watchdog/rzg2l_wdt.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c =
index
> 2a35f890a288..e9e0408c96f7 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
> @@ -166,8 +167,23 @@ static int rzg2l_wdt_restart(struct watchdog_device =
*wdev,
>  	struct rzg2l_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
>  	int ret;
>=20
> -	clk_prepare_enable(priv->pclk);
> -	clk_prepare_enable(priv->osc_clk);
> +	/*
> +	 * In case of RZ/G3S the watchdog device may be part of an IRQ safe pow=
er
> +	 * domain that is currently powered off. In this case we need to power
> +	 * it on before accessing registers. Along with this the clocks will be
> +	 * enabled. We don't undo the pm_runtime_resume_and_get() as the device
> +	 * need to be on for the reboot to happen.
> +	 *
> +	 * For the rest of RZ/G2 devices (and for RZ/G3S with old device trees
> +	 * where PM domains are registered like on RZ/G2 devices) it is safe
> +	 * to call pm_runtime_resume_and_get() as the
> +	 * irq_safe_dev_in_sleep_domain() call in genpd_runtime_resume()
> +	 * returns non zero value and the genpd_lock() is avoided, thus, there
> +	 * will be no invalid wait context reported by lockdep.
> +	 */
> +	ret =3D pm_runtime_resume_and_get(wdev->parent);
> +	if (ret)
> +		return ret;
>=20
>  	if (priv->devtype =3D=3D WDT_RZG2L) {
>  		ret =3D reset_control_deassert(priv->rstc);
> @@ -275,6 +291,7 @@ static int rzg2l_wdt_probe(struct platform_device *pd=
ev)
>=20
>  	priv->devtype =3D (uintptr_t)of_device_get_match_data(dev);
>=20
> +	pm_runtime_irq_safe(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>=20
>  	priv->wdev.info =3D &rzg2l_wdt_ident;
> --
> 2.39.2
>=20


