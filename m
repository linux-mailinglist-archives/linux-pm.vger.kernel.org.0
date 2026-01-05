Return-Path: <linux-pm+bounces-40178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D556CF2A15
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 10:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5131630021F7
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 09:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D7E3358C6;
	Mon,  5 Jan 2026 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="mQ1wJ4EM"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010031.outbound.protection.outlook.com [52.101.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E732AAC7;
	Mon,  5 Jan 2026 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604176; cv=fail; b=JDDnD98gYONRDvQXEfoRgjvDD8dPRExdDBrpqqRSdWs3poEF3bhXWSnvx9Xn1i3cm7Cjd2Kp6nIaUilWwuqhQFwvgIEmChGnxlq+kQEI8+DNGWWg8Ko8rkIOrFXJWJbSiqf2NOGBnhlQYIsg+U2nTVCf8P6OKvr1tqNah9hny6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604176; c=relaxed/simple;
	bh=VVa2/jsdI+Dxhl6FfRvia99kcnjifvzGTIu7G8BLINI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tU9J773QwDO1GPKJvXU9fCM1C4lYUQ6LRePYUlGvjiNOFT7LHTJL/Eo7CI2DZJVhtOSvAxvrQpWzqRhTNdZfsSvxy+S1d1JWGl8Gc77ftBxZJibi0K5F7UzCYm6SbrB9pbwVo7BrwDDT3aWA8ON7UZussXNIqPm+aNOoT6Qc720=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=mQ1wJ4EM; arc=fail smtp.client-ip=52.101.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmSKof80A3KZK+oTHLULndPu5ym0DmS2kxweWpwtwVE3r1Gm1s9gPlUwJhYjOc+gQkwVWSmj0VP1JKQwSYeX9pO3MKkGnQCE3am/5qhP8pn+Wm+jUafq5nAmqrKCVuSDoCQLaIn/gME5VhUtOPAK51d3No5NAagZt9pIpFIVK2Ajj+q3eWDffP44sIEArklvNV3rBmbPQlSxDEQUzeZqFmF6RDWRvdwEIkcvK0WtJlO6BaBv0HxvgFmcgRv8ZomQhp0TulBsyyOA3eoo6HJreMDKstjFy4hF0WjVmvGJXhNG8hamGJNN2l4DO3vczqsk+9Kb/EXRgeICSHPPR0/KVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTgv+GqDc4vlq6lVswztq5itPz6cgdaIMsmnojWS9ew=;
 b=Lo4IKjn7R6G/uJRuEtRufCZXvI9kSJUU0loAoHAifij30hv1DJqQaukkOyHTt+uqnVGB7hs0pELS3BCV1s1I6bdmtTn/Q3VcDVqj2T3qlFQnbnPgV79pkoUOW+9kAL9aHD0WpjZnmGoiCNsE4zN2rktLLgS5c7jL9Cwz5gSYvMR52mcfPHjC67TpkEy0UOAvGIaajX0LHrsKQez/RTERuRrVFNrAmgPs/nIPV+EwXAED5rwqO2tXXIMgQTdKAWCAce/tFPDH2k7hLIQhcJSOws4ky3E+kVfAm85rhP9923iSPC+EbtxcQBK1UHDkwbF9UP6BrId3qkr7W2ommfe7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTgv+GqDc4vlq6lVswztq5itPz6cgdaIMsmnojWS9ew=;
 b=mQ1wJ4EMyA8q7p8aw1zU5LuWWpRCNg87Y0TAPQP0+macAeJP1eskbxLXZ9ZL9fkPAtlfADkV/8XShG0NxWnrn/8ZzE43njzQ/H1peR+FtLWxKqnUYXCVv5E9zk18qrKHvnakN6hDKdFRdd1ZZwB+2qykPEjm4MAsH7ezNU+anFg=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TY3PR01MB10254.jpnprd01.prod.outlook.com
 (2603:1096:400:1d8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Mon, 5 Jan
 2026 09:09:26 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::606d:1c5a:2899:5ea6%4]) with mapi id 15.20.9499.001; Mon, 5 Jan 2026
 09:09:26 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, John
 Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 0/9] Add TSU support for RZ/T2H and RZ/N2H
Thread-Topic: [PATCH v3 0/9] Add TSU support for RZ/T2H and RZ/N2H
Thread-Index: AQHcXtU9mfsKzagAAE6w/+IujL0DhrVDh5xw
Date: Mon, 5 Jan 2026 09:09:26 +0000
Message-ID:
 <TYRPR01MB15619FEEF47DF01E9FFD57BF68586A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TY3PR01MB10254:EE_
x-ms-office365-filtering-correlation-id: 8cf1ca55-b875-48d7-e391-08de4c3a203e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ud+A7eqEmB+jtUod+nQiby9qJ5fTB0qOK9YjT7UHhsaoNnEV0C5/BeZsZBxs?=
 =?us-ascii?Q?lsqxZ2YilNXlu2V2JkexBvGn9HXV5dBeyQ7JzR8bN9kHuVysp4xCTvlxPUaw?=
 =?us-ascii?Q?CRhIso2Xpt/3ghMpGB4XQe0lG/4hPtqjNUY4pLyQ+sg7dYC5RaO4R10dMEoD?=
 =?us-ascii?Q?+8h/ZzF9oYoWpR4wCuNOT/zOdcwjt3w/aYFleBk8KRd++Krr41bQQSFC9vg6?=
 =?us-ascii?Q?8P4GWJXz6FDYz+ka1cyVIQJJj/isQLaQdTdkRgCDrKwqjsjOfrVnflNM7+cV?=
 =?us-ascii?Q?h7h/GXdHaCOboYY/OzqwRjOiCSZgFss/xeaNdqi5tP5TxLI4sZpCgwmakmCo?=
 =?us-ascii?Q?QaQwodKktiuAYj3g0h1U8Nzc2MW3aLwiTQsNcgzNW7IWM2k5IhnjwJL+Tmmu?=
 =?us-ascii?Q?Da/33lIMXQmhosxOJbVznUtfj5+WYSguA+nSPkrIQbhKg7PsPZMP90xlWKop?=
 =?us-ascii?Q?Nca4CWpC+q3u4CtgWfHvODnIQHX0jjevAYyWRTZn4FN1SUeDjv7n2Ee55j8Z?=
 =?us-ascii?Q?6vZf/FyqDViRFhFcPyzyXO9RXxBpOhbkqCxSU9usPlkc3uzRCpagzaTsXnVS?=
 =?us-ascii?Q?/V90Nwhr/GO+26V4lZUGsUU65atzqHIV6zUQcffLSB2H10q5C0s+P+6dig1t?=
 =?us-ascii?Q?xwS8HLF0v3hk4zvrrRIo9T7aUu+RkJIm3yQ3dkxP96kwy2dZ151ZU59+yXCq?=
 =?us-ascii?Q?907z+RyogISzYs0UOc4wg5N2+Ww9cOwLz6WaKtX5NC7onW93OSOcsiNOvZpk?=
 =?us-ascii?Q?Cv/TNQjm7jfIYQh0yPvTLqiczf765xzy0k59YZkFLmOwByPnjAutxpA0hw0X?=
 =?us-ascii?Q?BLSRWHxeNjZCFn0wreVUgyWpKe8DDT7Yu1o9iuPi1mWzxyulFxulORn53SLW?=
 =?us-ascii?Q?ZhP9hTXxQoNwbwk9us0XGGWXvhcyzEHu2egBaMAyGYDPflO25of38L7JKB6D?=
 =?us-ascii?Q?SaINwqb2KTQ6FI4oykrElpUBP86UbzqJUJgCl8g0ZBDxgCSv66bKGVHUQ6pJ?=
 =?us-ascii?Q?N1RW9kOhPfyVwdkNM3m3RqsEjiOD0M8YfhZ+aGOuBtme7ojQG911P5O95cvT?=
 =?us-ascii?Q?bHOjbfHAw3HtPFbuqSaIn6qKEqKrHjFLsSIeIQuld1BavPJA6IPRtB2LpDAo?=
 =?us-ascii?Q?1iV4BnDyZ4xbswrmyVUJ6593I37L5e3hjJOlHIavywMf9guKKWRAT8Zxi31A?=
 =?us-ascii?Q?bT1wRbHr1qLV3FrczXDijefqLntGtn/g9Q8WssU6cz8YRlHyBP+OhJIcxxnV?=
 =?us-ascii?Q?kg8opuSIlHenyhRVJ0JjiNcX9h2IwWnFNFtwgQmKdfa1JBDqSrLjAJefGCOG?=
 =?us-ascii?Q?BWbiBC4StJwYELCXdBD9aQXFBnqqSCR46JdDGo74hhtKulr2A/xHEy84h2fG?=
 =?us-ascii?Q?2S7xDP+jvMzD4Asonf7e010z9G+hUY6IsSAcx7dbHNaXXPmIINseoFMYTAKj?=
 =?us-ascii?Q?xv2ZcYRN0bst2b+3izvQy6ZQ9ieQ8KpT2MkVgusx6kBeR9Nvl/SAw2SO57FW?=
 =?us-ascii?Q?ssXjsOOgqp4k2Niw5fRhAM6koOWwvwOsTJCz+VpovFxHo2yvUcp5wLhnuw?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RIZSrtTIFjAPIb282nwQLUh7X00PLyAZQ091zbZFjHGpYTGtjzXub5d/qX8E?=
 =?us-ascii?Q?5gXIsLUA7ZiTHaaI16Q6n0krw5idPOb0Lj/v0IrgHGdxl3BQsInLba4UHvI3?=
 =?us-ascii?Q?X8QRRuKpd7+K9WtEMX3lgyMr4oq71SoJRnUoIE5Yg7w/dnJ1GgqFnlWO0YlG?=
 =?us-ascii?Q?QUY90KaE2FvrVYoPa8nMNMUW8RR58QPCRXIUBx7bf9kTqd6LqeN+EXgDu5R7?=
 =?us-ascii?Q?tT0Qy9FPvetMqh+H4VTK+ulbpESk3FBRYf6weTPkolJveVv4d2XDt2c/AmX2?=
 =?us-ascii?Q?oRIaLfJXpRaDGL0DaCb2vWJecwshuUfhTyD9WZ4vKCKpEEuGIJ8vf1YfDWba?=
 =?us-ascii?Q?rl81kH5oOVqDdj7hL7WZrbPASVYWHMo6NOA8iqimD7bqadYEa9cCRrqGeWIb?=
 =?us-ascii?Q?EyELDoU15ufy7uG9swancuhCnYiRFptP3WJUVTgMagFssHSUW5p0+uSfJRUg?=
 =?us-ascii?Q?WjDOjB6L1nQAQuwMcH3KzMP60tdrDzNwrAGbe3QRctOfd59WQVBq/SV3bv3H?=
 =?us-ascii?Q?8gLuaDS8fiEwipJaERvaJMHebwUfH6/QmYeDBi08KaCzXdHSvUz3Z/QRTikP?=
 =?us-ascii?Q?rvgsjuoTm+DjfSGPtnXoqjhi8JAzaYtcz5KQz8S2aTz+psEDs59o4LDjKdKa?=
 =?us-ascii?Q?h7+0fk4oCtaa+GjdW4bMCSMf/sTnMGEzhzQzWfRqlLgo9o+0cLUnVAfb1hy1?=
 =?us-ascii?Q?2OFZbwTbroEQPqBkTUPbaa//QPn0XyuyHA/BuCYNNPmaKCdqeFAmoS14RK99?=
 =?us-ascii?Q?nZxT2p87aIxwPFr0JD1dZgmjQM0+0fDyAvKSZc2pcxgGfGqBSepXGj2j+MWz?=
 =?us-ascii?Q?gQnjku1uI9I0jKPniM+yxQx7jX94MEeoEBWaAKMUBKold1MmbWJgxY/hdfq0?=
 =?us-ascii?Q?uOechBbP8LP030b1WhdFtpd2IdOLjgSQKVFqdd5E7TXlnAdTAlPdnkMXFUaX?=
 =?us-ascii?Q?38y8lHU9CoZQv+DknRGsQhk7P11+1JO+Uk5eGA9a/qTtizuxV8pfjmrrN4E1?=
 =?us-ascii?Q?f86h19b3ywPXqVgRu7yvQc3K8y+O1FuOrOXAdA/pBUsYKIf3IidJXKLlFsGj?=
 =?us-ascii?Q?hl/xfQ1XxAMBF+fj+YpAlXhsHKwSZ8A2B1NKtrQQwyuyBtuUdWbSV+dWSHeI?=
 =?us-ascii?Q?Tddomi6YMultA6xCY3LRCBreZ2IxzQVutwzNswPKK2ogPW1cVZ8ql4Mc5VBe?=
 =?us-ascii?Q?NjqaTIOhUwaEKQq0+XxNSIZGaZDOjp584s4MLeMpTgzXDhx/mvbWJQlGKopF?=
 =?us-ascii?Q?43sxBXXCyFX0L6G2Zkd3pkd6bHA0AqDJB/HCwIwMn3HUouv9RMuiPm2kWEmV?=
 =?us-ascii?Q?9zTJ8zM+6eWAlVnILFo2YPbK8QpvwG7fUoB0dC4F4rmqBjZXEKkLXKlbAtgs?=
 =?us-ascii?Q?/uZLCBWvsc7LmgCowejdUlVczY8SkzkVuidOv1cqJnYHrdPp1Sru2lGUNQ9P?=
 =?us-ascii?Q?ucMxf58XCxyU2N36tupJ8/4YSgbgI/DMenBZBwMCsDYuADI4IYTkrdzzyPU2?=
 =?us-ascii?Q?aMyyBSn2LB/rstW3VDpoFOmsc7b7OdKd/MlBV2Xz9So4tZUb8UB0/RcV64Ej?=
 =?us-ascii?Q?KIaIV8viR9D7sLZzv60sSPKRJob9MDJphoE32pFQMHyMG2nEo+5ERihG+f8X?=
 =?us-ascii?Q?8Pf3hC60HEVU2ql1LXxjmnlWjiDf1DJhNCDYXKzoAgfhkeOqeXtGbcII3Ff2?=
 =?us-ascii?Q?1GYgMj2LLkHxqC+JbiIUHasXsmxx+/ebfcMpSJ09T5LS6oU8CskeZS6b8BtN?=
 =?us-ascii?Q?Uq3RtQDp0xKRe1DHWlgeN+ESK+Nh59so9vUiXko4lEHTWZdJK69i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf1ca55-b875-48d7-e391-08de4c3a203e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 09:09:26.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmpXG+CVDtZ8jTTaf0yW/djLbHqvq9SWy4Jd2TZ347KUiZ3Ed+c89kf6VdDfz7bN1UfM8lrjRa3M8+JvyLqFetLcgCXliuOvYJhorvaSggibpbpPoHf5JTPVlk2xfxjB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10254

Could I have some feedback from the thermal maintainers regarding
this series? Is there anything I must change for it to be queued up?

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Wednesday, November 26, 2025 3:04 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; Rafael J . Wysocki <rafa=
el@kernel.org>; Daniel
> Lezcano <daniel.lezcano@linaro.org>; Zhang Rui <rui.zhang@intel.com>; Luk=
asz Luba
> <lukasz.luba@arm.com>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski=
 <krzk+dt@kernel.org>; Conor
> Dooley <conor+dt@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be=
>; magnus.damm
> <magnus.damm@gmail.com>; Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vg=
er.kernel.org; linux-renesas-
> soc@vger.kernel.org; Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@=
renesas.com>
> Subject: [PATCH v3 0/9] Add TSU support for RZ/T2H and RZ/N2H
>
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> temperature calibration via SMC SIP and do not have a reset for the
> TSU peripheral, and use different minimum and maximum temperature values
> compared to RZ/G3E.
>
> Although the calibration data is stored in an OTP memory, the OTP itself
> is not memory-mapped, and instead, access to it is done through an OTP
> controller. The OTP controller is only accessible from the secure world,
> but the temperature calibration data stored in the OTP is exposed via
> SMC.
>
> V3:
>  * dt-bindings: rebase on top of [1]
>  * dt-bindings: conditionally add `resets: false` and
>    `renesas,tsu-trim: false` for renesas,r9a09g077-tsu compatibles
>
> V2:
>  * drop clk patch already present in linux-next
>  * dt-bindings: merge two items into a single enum
>
> [1]:
> https://patchwork.kernel.org/project/lin
> ux-pm%2Fcover%2F20251020143107.13974-1-ovidiu.panait.rb%40renesas.com%2F&=
data=3D05%7C02%7Ccosmin-
> gabriel.tanislav.xa%40renesas.com%7C7a5016e528af4bf804f108de2cec5e33%7C53=
d82571da1947e49cb4625a166a4a2
> a%7C0%7C0%7C638997590872132861%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn=
RydWUsIlYiOiIwLjAuMDAwMCIsIlA
> iOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dosq3QQ=
XwLGtLuHGkC05CppYS91YhGxwZN5kub
> hr8BZo%3D&reserved=3D0
>
> Cosmin Tanislav (9):
>   thermal: renesas: rzg3e: make reset optional
>   thermal: renesas: rzg3e: make min and max temperature per-chip
>   thermal: renesas: rzg3e: make calibration value retrieval per-chip
>   dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
>   thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
>   arm64: dts: renesas: r9a09g077: add OPP table
>   arm64: dts: renesas: r9a09g087: add OPP table
>   arm64: dts: renesas: r9a09g077: add TSU and thermal zones support
>   arm64: dts: renesas: r9a09g087: add TSU and thermal zones support
>
>  .../thermal/renesas,r9a09g047-tsu.yaml        |  30 ++++-
>  arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  65 +++++++++
>  arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  65 +++++++++
>  drivers/thermal/renesas/rzg3e_thermal.c       | 125 ++++++++++++------
>  4 files changed, 239 insertions(+), 46 deletions(-)
>
> --
> 2.52.0


